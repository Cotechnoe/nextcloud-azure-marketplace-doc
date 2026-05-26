# HTTPS / TLS Certificate

> 🇫🇷 Cette page est également disponible en français : [[fr_HTTPS-TLS-Certificate]]

This page explains how to obtain and configure a free TLS certificate using Certbot (Let's Encrypt)
so that your Nextcloud instance is accessible over HTTPS with a valid certificate.

---

## Prerequisites

- All four services (Nginx, PHP-FPM, MariaDB, Redis) are running — see [[Post-Deployment-Verification]].
- You have a **Fully Qualified Domain Name (FQDN)** (e.g. `cloud.example.com`).
- Your VM has a **Static public IP address** (set during deployment).
- Your domain's **DNS A record** points to the VM's static public IP address.
- Ports **80** and **443** are open in the VM's Network Security Group.

> **Why a static IP?** If the VM restarts and the IP changes, your domain will no longer resolve
> correctly. Always use a static IP for production deployments.

---

## Step 1 — Assign a Static Public IP (if not already done)

1. In the [Azure portal](https://portal.azure.com), go to **Virtual machines > [your VM] > Networking**.
2. Click the public IP address link.
3. Under **Configuration**, set **Assignment** to **Static**.
4. Click **Save**.

---

## Step 2 — Create a DNS A Record

In your DNS provider's control panel, create an **A record**:

| Field | Value |
|-------|-------|
| **Name** | `cloud` (or `@` for apex domain) |
| **Type** | `A` |
| **Value** | VM static public IP address |
| **TTL** | 3600 (or your provider's default) |

Wait for DNS propagation (typically 5–30 minutes). Verify with:

```bash
dig cloud.example.com +short
# Should return the VM's public IP address
```

---

## Step 3 — Obtain a TLS Certificate with Certbot

SSH into the VM and run Certbot:

```bash
sudo certbot --nginx -d cloud.example.com
```

Replace `cloud.example.com` with your actual FQDN.

Certbot will:
1. Verify domain ownership via HTTP challenge (port 80 must be open).
2. Obtain a certificate from Let's Encrypt.
3. Automatically configure Nginx to use HTTPS.
4. Set up automatic renewal via a systemd timer.

When prompted, enter your email address for expiry notifications and agree to the Terms of Service.

---

## Step 4 — Update Nextcloud Trusted Domains

Nextcloud only accepts requests from trusted domain names. Add your FQDN:

```bash
sudo -u www-data php /var/www/nextcloud/occ config:system:set trusted_domains 1 --value=cloud.example.com
```

Verify the trusted domains list:

```bash
sudo -u www-data php /var/www/nextcloud/occ config:system:get trusted_domains
```

Expected output:

```
localhost
cloud.example.com
```

---

## Step 5 — Force HTTPS Redirection

Ensure all HTTP traffic is redirected to HTTPS. Check your Nginx configuration:

```bash
sudo nginx -t && sudo systemctl reload nginx
```

Verify that browsing to `http://cloud.example.com` redirects to `https://cloud.example.com`.

---

## Verify

1. Open `https://cloud.example.com` in your browser.
2. Confirm the browser shows a **padlock icon** (valid certificate).
3. Check certificate details — issuer should be **Let's Encrypt**.

---

## Certificate Renewal

Certbot automatically renews certificates before they expire. Test the renewal process:

```bash
sudo certbot renew --dry-run
```

Certificates are renewed automatically via the `certbot.timer` systemd unit. No manual action is needed.

---

## Troubleshooting

**Certbot error: "Could not bind to IPv4 or IPv6... port 80 in use"**  
Nginx is using port 80. Use the `--nginx` plugin (as shown above) which handles this automatically,
or temporarily stop Nginx: `sudo systemctl stop nginx`, run Certbot standalone, then restart.

**Certbot error: "DNS problem: NXDOMAIN looking up A for..."**  
DNS has not propagated yet. Wait and retry, or verify the A record with `dig`.

**Browser shows "Your connection is not private"**  
Nextcloud may not have the correct FQDN in trusted_domains. Re-run Step 4.
Also verify the certificate matches the domain: `sudo certbot certificates`.

**After certificate renewal, Nginx shows old certificate**  
Run: `sudo systemctl reload nginx`

---

## Next Steps

| Next | Page |
|------|------|
| Complete Nextcloud initial setup | [[Configuring-Nextcloud]] |
