# Post-Deployment Verification

> 🇫🇷 Cette page est également disponible en français : [[Post-Deployment-Verification-fr]]

After deploying and connecting via SSH, verify that all four core services are running
correctly before configuring Nextcloud.

---

## Prerequisites

- You are connected to the VM via SSH (see [[SSH-Connection]]).

---

## Step 1 — Verify Nginx

Nginx serves as the web server and reverse proxy.

```bash
sudo systemctl status nginx
```

Expected output includes `Active: active (running)`.

If Nginx is not running, start it:

```bash
sudo systemctl start nginx
sudo systemctl enable nginx
```

**Test HTTP response:**

```bash
curl -I http://localhost
```

Expected: `HTTP/1.1 200 OK` or a redirect to HTTPS.

---

## Step 2 — Verify PHP-FPM

PHP-FPM processes PHP requests for Nextcloud.

```bash
sudo systemctl status php8.1-fpm
```

Expected output includes `Active: active (running)`.

If PHP-FPM is not running, start it:

```bash
sudo systemctl start php8.1-fpm
sudo systemctl enable php8.1-fpm
```

**Verify PHP version:**

```bash
php --version
```

Expected: PHP 8.1 or higher.

---

## Step 3 — Verify MariaDB

MariaDB stores the Nextcloud database.

```bash
sudo systemctl status mariadb
```

Expected output includes `Active: active (running)`.

If MariaDB is not running, start it:

```bash
sudo systemctl start mariadb
sudo systemctl enable mariadb
```

**Test database connectivity:**

```bash
sudo mysql -u root -e "SHOW DATABASES;"
```

Expected: A table listing databases including `nextcloud` (if already configured).

---

## Step 4 — Verify Redis

Redis provides session caching and file locking for Nextcloud.

```bash
sudo systemctl status redis-server
```

Expected output includes `Active: active (running)`.

If Redis is not running, start it:

```bash
sudo systemctl start redis-server
sudo systemctl enable redis-server
```

**Test Redis connectivity:**

```bash
redis-cli ping
```

Expected: `PONG`

---

## Summary Check

Run all checks in one command:

```bash
for svc in nginx php8.1-fpm mariadb redis-server; do
  echo "=== $svc ===" && sudo systemctl is-active "$svc"
done
```

All four services should report `active`.

---

## Verify

| Service | Check command | Expected |
|---------|--------------|---------|
| Nginx | `sudo systemctl is-active nginx` | `active` |
| PHP-FPM | `sudo systemctl is-active php8.1-fpm` | `active` |
| MariaDB | `sudo systemctl is-active mariadb` | `active` |
| Redis | `sudo systemctl is-active redis-server` | `active` |

---

## Troubleshooting

**Nginx fails to start: "Address already in use"**  
Another process is using port 80 or 443. Find it with `sudo ss -tlnp | grep ':80\|:443'` and stop it.

**PHP-FPM fails to start: "No such file or directory"**  
The socket path configured in Nginx may not match what PHP-FPM creates.
Check `/etc/nginx/sites-available/` and `/etc/php/8.1/fpm/pool.d/www.conf` for socket path consistency.

**MariaDB fails to start: "Can't open and lock privilege tables"**  
Data directory corruption. Run `sudo mysql_upgrade` or consult MariaDB logs:
`sudo journalctl -u mariadb --since "5 minutes ago"`.

**Redis: `redis-cli ping` returns `Connection refused`**  
Verify that Redis is listening on `127.0.0.1:6379`:
`sudo ss -tlnp | grep 6379`

---

## Next Steps

| Next | Page |
|------|------|
| Configure HTTPS | [[HTTPS-TLS-Certificate]] |
| Complete Nextcloud setup | [[Configuring-Nextcloud]] |
