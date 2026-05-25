# Guide de dimensionnement des VMs

> 🇬🇧 This page is also available in English: [VM Sizing Guide](vm-sizing-guide.md)

Ce guide vous aide à choisir la bonne taille de VM Azure pour votre déploiement Nextcloud,
en fonction du nombre d'utilisateurs simultanés et de la charge de travail prévue.

---

## SKUs de VM recommandées

| SKU VM | vCPU | RAM | Coût mensuel (estim.) | Recommandé pour |
|--------|------|-----|------------------------|-----------------|
| `Standard_B2s` | 2 | 4 Go | ~35 $ USD | 1–10 utilisateurs, dev/test, pilotes |
| `Standard_B4ms` | 4 | 16 Go | ~130 $ USD | 10–50 utilisateurs, petites équipes |
| `Standard_D2s_v3` | 2 | 8 Go | ~70 $ USD | 10–30 utilisateurs, charge constante |
| `Standard_D4s_v3` | 4 | 16 Go | ~140 $ USD | 30–100 utilisateurs, départements |
| `Standard_D8s_v3` | 8 | 32 Go | ~280 $ USD | 100–300 utilisateurs, groupes de recherche |

> **Remarque :** Les coûts sont des estimations basées sur la tarification à l'utilisation
> en East US. Utilisez la
> [Calculatrice de prix Azure](https://azure.microsoft.com/fr-fr/pricing/calculator/)
> pour une tarification précise dans votre région.

---

## Dimensionnement du stockage

### Disque OS

Le disque OS (30 Go par défaut pour cette image marketplace) contient :
- Ubuntu 22.04 LTS
- Nginx, PHP-FPM, MariaDB, Redis
- Les fichiers de l'application Nextcloud (`/var/www/nextcloud/`)

**Taille recommandée pour le disque OS :** 64 Go minimum.

### Disque de données — Disque séparé pour les données utilisateurs

Pour les déploiements en production, attachez un **disque de données** séparé pour les
fichiers utilisateurs Nextcloud. Cela maintient les données utilisateurs indépendantes du
disque OS, ce qui simplifie les sauvegardes et le redimensionnement.

| Nombre d'utilisateurs | Volume de données estimé | Disque de données recommandé |
|-----------------------|--------------------------|------------------------------|
| 1–10 | < 500 Go | SSD Premium 512 Go (P20) |
| 10–50 | 500 Go – 2 To | SSD Premium 1 To (P30) |
| 50–200 | 2 To – 8 To | SSD Premium 4 To (P50) |
| 200+ | > 8 To | Azure Files ou Blob Storage |

### Attacher et monter un disque de données

```bash
# Trouver le nouveau disque de données (p. ex. /dev/sdc)
lsblk

# Créer un système de fichiers
sudo mkfs.ext4 /dev/sdc

# Créer le point de montage
sudo mkdir -p /mnt/nextcloud-data

# Monter le disque
sudo mount /dev/sdc /mnt/nextcloud-data

# Persister le montage dans /etc/fstab (utiliser l'UUID pour plus de fiabilité)
DISK_UUID=$(sudo blkid -s UUID -o value /dev/sdc)
echo "UUID=${DISK_UUID}  /mnt/nextcloud-data  ext4  defaults  0  2" | sudo tee -a /etc/fstab

# Déplacer le répertoire de données Nextcloud vers le nouveau disque
sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --on
sudo rsync -av /var/www/nextcloud/data/ /mnt/nextcloud-data/
sudo chown -R www-data:www-data /mnt/nextcloud-data

# Mettre à jour config.php
sudo sed -i "s|'datadirectory'.*|'datadirectory' => '/mnt/nextcloud-data',|" \
  /var/www/nextcloud/config/config.php

sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --off
```

---

## Recommandations mémoire

| Composant | Minimum | Recommandé |
|-----------|---------|------------|
| PHP-FPM (`memory_limit`) | 256 Mo | 512 Mo |
| MariaDB (`innodb_buffer_pool_size`) | 128 Mo | 512 Mo – 1 Go |
| Redis (`maxmemory`) | 64 Mo | 256 Mo |

Ajuster la limite mémoire PHP :

```bash
sudo sed -i 's/^memory_limit.*/memory_limit = 512M/' /etc/php/8.1/fpm/php.ini
sudo systemctl restart php8.1-fpm
```

---

## Mise à l'échelle au-delà d'une VM unique

Pour les déploiements dépassant 300 utilisateurs simultanés, envisagez :

- **Azure Files Premium** — stockage NFS partagé pour la mise à l'échelle horizontale
- **Azure Database for MariaDB** — base de données gérée avec sauvegardes automatiques
- **Azure Cache for Redis** — Redis géré pour les sessions et le verrouillage de fichiers
- **Azure Front Door** ou **Application Gateway** — terminaison SSL et équilibrage de charge

Ces architectures nécessitent une configuration personnalisée au-delà de la portée
de cette image marketplace.

---

## Guides connexes

- [Sauvegarde et restauration](backup-restore-fr.md)
- [Sécurité réseau](network-security-fr.md)
- [Surveillance](monitoring-fr.md)
