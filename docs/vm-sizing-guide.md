# VM Sizing Guide

> 🇫🇷 Cette page est également disponible en français : [VM Sizing Guide (fr)](vm-sizing-guide-fr.md)

This guide helps you choose the right Azure VM size for your Nextcloud deployment,
based on the number of concurrent users and expected workload.

---

## Recommended VM SKUs

| VM SKU | vCPU | RAM | Monthly Cost (est.) | Recommended for |
|--------|------|-----|----------------------|-----------------|
| `Standard_B2s` | 2 | 4 GB | ~$35 USD | 1–10 users, dev/test, pilots |
| `Standard_B4ms` | 4 | 16 GB | ~$130 USD | 10–50 users, small teams |
| `Standard_D2s_v3` | 2 | 8 GB | ~$70 USD | 10–30 users, consistent load |
| `Standard_D4s_v3` | 4 | 16 GB | ~$140 USD | 30–100 users, departments |
| `Standard_D8s_v3` | 8 | 32 GB | ~$280 USD | 100–300 users, research groups |

> **Note:** Costs are estimates based on pay-as-you-go pricing in East US.
> Use [Azure Pricing Calculator](https://azure.microsoft.com/en-us/pricing/calculator/)
> for accurate pricing in your region.

---

## Storage Sizing

### OS Disk

The OS disk (default 30 GB for this marketplace image) contains:
- Ubuntu 24.04 LTS
- Nginx, PHP-FPM, MariaDB, Redis
- Nextcloud application files (`/var/www/nextcloud/`)

**Recommended OS disk size:** 64 GB minimum.

### Data Disk — Separate Disk for User Data

For production deployments, attach a separate **data disk** for Nextcloud user files.
This keeps user data independent of the OS disk, simplifying backups and disk resizing.

| User Count | Estimated Data Volume | Recommended Data Disk |
|------------|-----------------------|-----------------------|
| 1–10 | < 500 GB | Premium SSD 512 GB (P20) |
| 10–50 | 500 GB – 2 TB | Premium SSD 1 TB (P30) |
| 50–200 | 2 TB – 8 TB | Premium SSD 4 TB (P50) |
| 200+ | > 8 TB | Azure Files or Blob Storage |

### Attach and Mount a Data Disk

```bash
# Find the new data disk (e.g., /dev/sdc)
lsblk

# Create a filesystem
sudo mkfs.ext4 /dev/sdc

# Create mount point
sudo mkdir -p /mnt/nextcloud-data

# Mount the disk
sudo mount /dev/sdc /mnt/nextcloud-data

# Persist the mount in /etc/fstab (use UUID for reliability)
DISK_UUID=$(sudo blkid -s UUID -o value /dev/sdc)
echo "UUID=${DISK_UUID}  /mnt/nextcloud-data  ext4  defaults  0  2" | sudo tee -a /etc/fstab

# Move Nextcloud data directory to the new disk
sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --on
sudo rsync -av /var/nextcloud-data/ /mnt/nextcloud-data/
sudo chown -R www-data:www-data /mnt/nextcloud-data

# Update config.php
sudo sed -i "s|'datadirectory'.*|'datadirectory' => '/mnt/nextcloud-data',|" \
  /var/www/nextcloud/config/config.php

sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --off
```

---

## Memory Recommendations

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| PHP-FPM (`memory_limit`) | 256 MB | 512 MB |
| MariaDB (`innodb_buffer_pool_size`) | 128 MB | 512 MB – 1 GB |
| Redis (`maxmemory`) | 64 MB | 256 MB |

Adjust PHP memory limit:

```bash
sudo sed -i 's/^memory_limit.*/memory_limit = 512M/' /etc/php/8.1/fpm/php.ini
sudo systemctl restart php8.1-fpm
```

---

## Scaling Beyond a Single VM

For deployments exceeding 300 concurrent users, consider:

- **Azure Files Premium** — shared NFS storage for horizontal scaling
- **Azure Database for MariaDB** — managed database with automatic backups
- **Azure Cache for Redis** — managed Redis for session and file locking
- **Azure Front Door** or **Application Gateway** — SSL termination and load balancing

These architectures require custom configuration beyond the scope of this
marketplace image.

---

## Related Guides

- [Backup and Restore](backup-restore.md)
- [Network Security](network-security.md)
- [Monitoring](monitoring.md)
