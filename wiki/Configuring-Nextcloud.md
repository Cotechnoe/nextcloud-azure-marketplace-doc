# Configuring Nextcloud

> 🇫🇷 Cette page est également disponible en français : [[Configuring-Nextcloud-fr]]

This page walks you through the initial Nextcloud configuration after deployment,
including the setup wizard and key post-installation settings.

---

## Prerequisites

- HTTPS is configured and your domain resolves correctly — see [[HTTPS-TLS-Certificate]].
- All four services are running — see [[Post-Deployment-Verification]].

---

## Step 1 — Open the Setup Wizard

1. Open your browser and navigate to `https://cloud.example.com`.
2. The Nextcloud **Setup Wizard** appears on first access.

> **Note:** If the Setup Wizard does not appear and you see a login page, Nextcloud was
> pre-configured during deployment. Skip to Step 3.

---

## Step 2 — Complete the Setup Wizard

Fill in the following fields:

### Administrator Account

| Field | Value |
|-------|-------|
| **Admin username** | Choose a secure username (not `admin`) |
| **Admin password** | Choose a strong password (≥12 characters) |

### Data Folder

The default data folder is `/var/www/nextcloud/data`.  
If you attached a separate data disk during deployment, change this to the mount point of that disk
(e.g. `/mnt/data/nextcloud`).

### Database Configuration

| Field | Value |
|-------|-------|
| **Database type** | MySQL/MariaDB |
| **Database user** | `nextcloud` (pre-configured) |
| **Database password** | See `/root/nextcloud-db-password.txt` or the deployment output |
| **Database name** | `nextcloud` |
| **Database host** | `localhost` |

Click **Finish setup**.

---

## Alternative: Command-Line Installation

If you prefer to configure Nextcloud without the web wizard, use the `occ` CLI:

```bash
sudo -u www-data php /var/www/nextcloud/occ maintenance:install \
  --database "mysql" \
  --database-host "localhost" \
  --database-name "nextcloud" \
  --database-user "nextcloud" \
  --database-pass "YOUR_DB_PASSWORD" \
  --admin-user "YOUR_ADMIN_USER" \
  --admin-pass "YOUR_ADMIN_PASSWORD" \
  --data-dir "/var/www/nextcloud/data"
```

> Replace `YOUR_DB_PASSWORD`, `YOUR_ADMIN_USER`, and `YOUR_ADMIN_PASSWORD` with your actual values.

---

## Step 3 — Post-Installation Settings

### Set the Correct Domain

```bash
sudo -u www-data php /var/www/nextcloud/occ config:system:set overwrite.cli.url \
  --value="https://cloud.example.com"
```

### Configure Email Notifications (Optional)

1. In the Nextcloud admin interface, go to **Settings > Personal info > Email**.
2. Under **Basic settings**, configure your SMTP server.

### Enable Redis for File Locking

Redis is pre-configured on this VM. Verify it is active in `config.php`:

```bash
sudo grep -A 10 'memcache' /var/www/nextcloud/config/config.php
```

Expected entries:

```php
'memcache.local' => '\\OC\\Memcache\\Redis',
'memcache.locking' => '\\OC\\Memcache\\Redis',
```

---

## Step 4 — Configure Background Jobs

Set Nextcloud to use the system cron for background tasks (recommended over the default Ajax):

```bash
sudo -u www-data php /var/www/nextcloud/occ background:cron
```

Verify the cron job exists:

```bash
sudo crontab -u www-data -l
```

Expected:

```
*/5 * * * * php /var/www/nextcloud/occ background:job
```

If the cron entry is missing, add it:

```bash
echo "*/5 * * * * php /var/www/nextcloud/occ background:job" | sudo crontab -u www-data -
```

---

## Verify

1. Log in to Nextcloud at `https://cloud.example.com` with your admin credentials.
2. Go to **Settings > Overview** — confirm no warnings are shown (or resolve listed warnings).
3. Upload a test file to verify file storage is working.

---

## Troubleshooting

**"Your data directory is invalid" warning**  
The data directory path in `config.php` does not exist or has incorrect ownership.
Set correct ownership: `sudo chown -R www-data:www-data /var/www/nextcloud/data`

**"Maintenance mode is active"**  
Turn off maintenance mode: `sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --off`

**Setup Wizard shows database connection error**  
Verify MariaDB is running and the database credentials are correct.
Check MariaDB with: `sudo mysql -u nextcloud -p -e "USE nextcloud;"`

---

## Next Steps

| Next | Page |
|------|------|
| Explore Nextcloud features | [[Exploring-Nextcloud]] |
| Keep Nextcloud up to date | [[Updating-Nextcloud]] |
| Manage user accounts | [[Managing-Users]] |
