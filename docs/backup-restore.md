# Backup and Restore

> 🇫🇷 Cette page est également disponible en français : [Sauvegarde et restauration](backup-restore-fr.md)

This guide covers backup and restore procedures for a Nextcloud deployment on Azure,
including the application files, database, and user data.

---

## Before You Begin

> **Always enable maintenance mode before taking a backup.**
> This prevents data corruption from in-progress uploads or database writes.

```bash
sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --on
```

Disable maintenance mode after the backup completes:

```bash
sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --off
```

---

## What to Back Up

| Component | Path / Method | Description |
|-----------|---------------|-------------|
| User data | `/var/www/nextcloud/data/` (or custom data dir) | All user files |
| Application | `/var/www/nextcloud/` | Nextcloud PHP files, apps, themes |
| Configuration | `/var/www/nextcloud/config/config.php` | Database credentials, domain config |
| Database | `mysqldump` | All Nextcloud tables |

---

## Manual Backup

### Step 1 — Enable Maintenance Mode

```bash
sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --on
```

### Step 2 — Backup User Data

```bash
BACKUP_DIR="/mnt/backup/nextcloud-$(date +%Y%m%d)"
sudo mkdir -p "$BACKUP_DIR"

sudo rsync -av /var/www/nextcloud/data/ "$BACKUP_DIR/data/"
```

### Step 3 — Backup Application and Config

```bash
sudo rsync -av \
  --exclude='data/' \
  --exclude='cache/' \
  /var/www/nextcloud/ "$BACKUP_DIR/app/"
```

### Step 4 — Backup MariaDB Database

```bash
# Get database credentials from config.php
DB_NAME=$(sudo grep "dbname" /var/www/nextcloud/config/config.php | \
  sed "s/.*=> '\(.*\)',/\1/")
DB_USER=$(sudo grep "dbuser" /var/www/nextcloud/config/config.php | \
  sed "s/.*=> '\(.*\)',/\1/")
DB_PASS=$(sudo grep "dbpassword" /var/www/nextcloud/config/config.php | \
  sed "s/.*=> '\(.*\)',/\1/")

sudo mysqldump --single-transaction \
  -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" \
  > "$BACKUP_DIR/nextcloud-db.sql"
```

### Step 5 — Disable Maintenance Mode

```bash
sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --off
```

---

## Restore Procedure

### Step 1 — Enable Maintenance Mode

```bash
sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --on
```

### Step 2 — Restore User Data

```bash
BACKUP_DIR="/mnt/backup/nextcloud-20240101"  # replace with your backup date

sudo rsync -av --delete \
  "$BACKUP_DIR/data/" /var/www/nextcloud/data/
sudo chown -R www-data:www-data /var/www/nextcloud/data/
```

### Step 3 — Restore Application Files

```bash
sudo rsync -av --delete \
  "$BACKUP_DIR/app/" /var/www/nextcloud/
sudo chown -R www-data:www-data /var/www/nextcloud/
```

### Step 4 — Restore MariaDB Database

```bash
DB_NAME=$(sudo grep "dbname" /var/www/nextcloud/config/config.php | \
  sed "s/.*=> '\(.*\)',/\1/")
DB_USER=$(sudo grep "dbuser" /var/www/nextcloud/config/config.php | \
  sed "s/.*=> '\(.*\)',/\1/")
DB_PASS=$(sudo grep "dbpassword" /var/www/nextcloud/config/config.php | \
  sed "s/.*=> '\(.*\)',/\1/")

sudo mysql -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" \
  < "$BACKUP_DIR/nextcloud-db.sql"
```

### Step 5 — Repair File Cache

```bash
sudo -u www-data php /var/www/nextcloud/occ files:scan --all
sudo -u www-data php /var/www/nextcloud/occ maintenance:repair
sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --off
```

---

## Azure Backup

For automated backups with retention policies, use **Azure Backup**:

1. Open the **Azure Portal** and navigate to your VM.
2. Select **Backup** under **Operations**.
3. Choose **Recovery Services Vault** (create one if needed).
4. Select **Azure Virtual Machine** backup policy.
5. Configure a daily backup schedule with appropriate retention (e.g., 30 days daily, 12 weeks weekly).

> **Limitation:** Azure VM backups create crash-consistent snapshots.
> For application-consistent backups of the database, use the `mysqldump` method above
> combined with Azure Blob Storage upload.

### Upload Backup to Azure Blob Storage

```bash
# Install Azure CLI if not present
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Login (use managed identity if VM has one assigned)
az login --identity

# Upload backup archive
BACKUP_ARCHIVE="/mnt/backup/nextcloud-$(date +%Y%m%d).tar.gz"
sudo tar czf "$BACKUP_ARCHIVE" /mnt/backup/nextcloud-$(date +%Y%m%d)/

az storage blob upload \
  --account-name "<your-storage-account>" \
  --container-name "nextcloud-backups" \
  --name "$(basename $BACKUP_ARCHIVE)" \
  --file "$BACKUP_ARCHIVE" \
  --auth-mode login
```

---

## Related Guides

- [VM Sizing Guide](vm-sizing-guide.md) — Size the data disk appropriately for backup storage
- [Monitoring](monitoring.md) — Set alerts for backup job failures
