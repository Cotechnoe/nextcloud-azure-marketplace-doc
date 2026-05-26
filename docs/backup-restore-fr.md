# Sauvegarde et restauration

> 🇬🇧 This page is also available in English: [Backup and Restore](backup-restore.md)

Ce guide couvre les procédures de sauvegarde et de restauration pour un déploiement
Nextcloud sur Azure, incluant les fichiers d'application, la base de données et les
données utilisateurs.

---

## Avant de commencer

> **Activez toujours le mode maintenance avant de faire une sauvegarde.**
> Cela évite la corruption de données causée par des téléversements ou des écritures
> en base de données en cours.

```bash
sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --on
```

Désactivez le mode maintenance après la sauvegarde :

```bash
sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --off
```

---

## Quoi sauvegarder

| Composant | Chemin / Méthode | Description |
|-----------|------------------|-------------|
| Données utilisateurs | `/var/nextcloud-data/` (ou répertoire personnalisé) | Tous les fichiers utilisateurs |
| Application | `/var/www/nextcloud/` | Fichiers PHP Nextcloud, apps, thèmes |
| Configuration | `/var/www/nextcloud/config/config.php` | Identifiants BD, config domaine |
| Base de données | `pg_dump` | Toutes les tables Nextcloud |

---

## Sauvegarde manuelle

### Étape 1 — Activer le mode maintenance

```bash
sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --on
```

### Étape 2 — Sauvegarder les données utilisateurs

```bash
BACKUP_DIR="/mnt/backup/nextcloud-$(date +%Y%m%d)"
sudo mkdir -p "$BACKUP_DIR"

sudo rsync -av /var/nextcloud-data/ "$BACKUP_DIR/data/"
```

### Étape 3 — Sauvegarder l'application et la configuration

```bash
sudo rsync -av \
  --exclude='data/' \
  --exclude='cache/' \
  /var/www/nextcloud/ "$BACKUP_DIR/app/"
```

### Étape 4 — Sauvegarder la base de données PostgreSQL

```bash
# Récupérer le nom de la BD depuis config.php
DB_NAME=$(sudo grep "dbname" /var/www/nextcloud/config/config.php | \
  sed "s/.*=> '\(.*\)',/\1/")

sudo -u postgres pg_dump "$DB_NAME" \
  > "$BACKUP_DIR/nextcloud-db.sql"
```

### Étape 5 — Désactiver le mode maintenance

```bash
sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --off
```

---

## Procédure de restauration

### Étape 1 — Activer le mode maintenance

```bash
sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --on
```

### Étape 2 — Restaurer les données utilisateurs

```bash
BACKUP_DIR="/mnt/backup/nextcloud-20240101"  # remplacer par votre date de sauvegarde

sudo rsync -av --delete \
  "$BACKUP_DIR/data/" /var/nextcloud-data/
sudo chown -R www-data:www-data /var/nextcloud-data/
```

### Étape 3 — Restaurer les fichiers d'application

```bash
sudo rsync -av --delete \
  "$BACKUP_DIR/app/" /var/www/nextcloud/
sudo chown -R www-data:www-data /var/www/nextcloud/
```

### Étape 4 — Restaurer la base de données PostgreSQL

```bash
DB_NAME=$(sudo grep "dbname" /var/www/nextcloud/config/config.php | \
  sed "s/.*=> '\(.*\)',/\1/")

sudo -u postgres psql "$DB_NAME" \
  < "$BACKUP_DIR/nextcloud-db.sql"
```

### Étape 5 — Réparer le cache de fichiers

```bash
sudo -u www-data php /var/www/nextcloud/occ files:scan --all
sudo -u www-data php /var/www/nextcloud/occ maintenance:repair
sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --off
```

---

## Sauvegarde Azure

Pour des sauvegardes automatisées avec des politiques de rétention, utilisez **Sauvegarde Azure** :

1. Ouvrez le **Portail Azure** et accédez à votre VM.
2. Sélectionnez **Sauvegarde** sous **Opérations**.
3. Choisissez un **coffre Recovery Services** (créez-en un si nécessaire).
4. Sélectionnez la politique de sauvegarde **Machine virtuelle Azure**.
5. Configurez une planification de sauvegarde quotidienne avec une rétention appropriée
   (p. ex. 30 jours quotidiens, 12 semaines hebdomadaires).

> **Limitation :** Les sauvegardes VM Azure créent des instantanés cohérents avec les
> pannes. Pour des sauvegardes cohérentes avec l'application pour la base de données,
> utilisez la méthode `pg_dump` ci-dessus combinée avec le téléversement vers
> Stockage Blob Azure.

### Téléverser la sauvegarde vers Stockage Blob Azure

```bash
# Installer Azure CLI si absent
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Se connecter (utiliser l'identité gérée si la VM en a une assignée)
az login --identity

# Téléverser l'archive de sauvegarde
BACKUP_ARCHIVE="/mnt/backup/nextcloud-$(date +%Y%m%d).tar.gz"
sudo tar czf "$BACKUP_ARCHIVE" /mnt/backup/nextcloud-$(date +%Y%m%d)/

az storage blob upload \
  --account-name "<votre-compte-stockage>" \
  --container-name "nextcloud-backups" \
  --name "$(basename $BACKUP_ARCHIVE)" \
  --file "$BACKUP_ARCHIVE" \
  --auth-mode login
```

---

## Guides connexes

- [Guide de dimensionnement des VMs](vm-sizing-guide-fr.md) — Dimensionner le disque de données pour le stockage des sauvegardes
- [Surveillance](monitoring-fr.md) — Configurer des alertes pour les échecs de travaux de sauvegarde
