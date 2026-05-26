# Troubleshooting

> 🇫🇷 Cette page est également disponible en français : [[fr_Troubleshooting]]

This page covers the most common issues encountered with a Nextcloud Azure Marketplace
deployment, along with diagnostic commands and solutions.

---

## Prerequisites

- You are connected to the VM via SSH — see [[SSH-Connection]].
- All four services are expected to be running: Nginx, PHP-FPM 8.3, PostgreSQL 16, Redis.

---

## Issue 1 — Port 443 Is Blocked (Cannot Access Nextcloud via HTTPS)

**Symptoms:** Browser shows "connection refused" or times out on `https://cloud.example.com`.

**Diagnosis:**

```bash
# Check if Nginx is listening on 443
sudo ss -tlnp | grep ':443'

# Check NSG / firewall rules (verify from Azure Portal)
# Settings > Networking > Inbound port rules — port 443 must be allowed
```

**Solutions:**

1. Verify that the NSG (Network Security Group) for the VM has an inbound rule allowing TCP port 443.
   Go to the Azure Portal > VM > Networking > Inbound port rules.
2. Verify Nginx is running: `sudo systemctl status nginx`
3. Restart Nginx if needed: `sudo systemctl restart nginx`

---

## Issue 2 — TLS Certificate Expired

**Symptoms:** Browser shows security warning "Your connection is not private" (ERR_CERT_DATE_INVALID).

**Diagnosis:**

```bash
# Check certificate expiry date
sudo certbot certificates
```

**Solution:**

Renew the certificate manually:

```bash
sudo certbot renew
sudo systemctl reload nginx
```

For automatic renewal, verify that the certbot timer is active:

```bash
sudo systemctl status certbot.timer
```

If the timer is inactive, enable it:

```bash
sudo systemctl enable --now certbot.timer
```

---

## Issue 3 — Database Connection Lost

**Symptoms:** Nextcloud shows "Error while trying to create admin user: Failed to connect to the database" or "could not connect to server: Connection refused".

**Diagnosis:**

```bash
sudo systemctl status postgresql
sudo journalctl -u postgresql --since "1 hour ago" | tail -30
```

**Solutions:**

1. Start or restart PostgreSQL: `sudo systemctl restart postgresql`
2. Check disk space — PostgreSQL can fail if the disk is full:
   ```bash
   df -h /
   ```
3. Check PostgreSQL log: `sudo journalctl -u postgresql --since "1 hour ago" | tail -50`

---

## Issue 4 — PHP-FPM Crash (502 Bad Gateway)

**Symptoms:** Nginx returns a 502 Bad Gateway error. Pages do not load.

**Diagnosis:**

```bash
sudo systemctl status php8.3-fpm
sudo journalctl -u php8.3-fpm --since "30 minutes ago" | tail -20
```

**Solutions:**

1. Restart PHP-FPM: `sudo systemctl restart php8.3-fpm`
2. Check PHP error log: `sudo tail -50 /var/log/php8.3-fpm.log`
3. Increase memory limit if processes are killed by OOM (Out of Memory):
   Edit `/etc/php/8.3/fpm/php.ini` → `memory_limit = 512M`, then restart PHP-FPM.

---

## Issue 5 — Redis Unavailable (Locking Issues)

**Symptoms:** Nextcloud shows "Could not obtain lock" errors, or file operations fail with locking warnings.

**Diagnosis:**

```bash
sudo systemctl status redis-server
redis-cli ping
```

Expected response from `redis-cli ping`: `PONG`

**Solutions:**

1. Start or restart Redis: `sudo systemctl restart redis-server`
2. Check Redis log: `sudo tail -30 /var/log/redis/redis-server.log`
3. Verify Redis configuration in Nextcloud `config.php`:
   ```bash
   sudo grep -A 5 'redis' /var/www/nextcloud/config/config.php
   ```

---

## General Diagnostic Commands

```bash
# Check all four services at once
sudo systemctl is-active nginx php8.3-fpm postgresql redis-server

# View Nextcloud application log (last 50 lines)
sudo tail -50 /var/log/nextcloud/nextcloud.log | python3 -m json.tool 2>/dev/null || \
  sudo tail -50 /var/log/nextcloud/nextcloud.log

# Check disk space
df -h

# Check memory usage
free -h

# Check running PHP-FPM workers
ps aux | grep php-fpm | grep -v grep | wc -l
```

---

## Nextcloud Integrity Check

Run the built-in integrity check to detect modified or missing core files:

```bash
sudo -u www-data php /var/www/nextcloud/occ integrity:check-core
```

No output means all core files are intact.

---

## Next Steps

| Next | Page |
|------|------|
| Get support | [[Support]] |
| Update Nextcloud | [[Updating-Nextcloud]] |
| Verify services | [[Post-Deployment-Verification]] |
