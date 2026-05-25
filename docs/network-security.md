# Network Security

> 🇫🇷 Cette page est également disponible en français : [Sécurité réseau](network-security-fr.md)

This guide covers network security hardening for your Nextcloud VM on Azure,
including NSG rules, SSH hardening, and application-level security headers.

---

## Azure Network Security Group (NSG)

The VM deployed from Azure Marketplace includes a pre-configured NSG. Verify and enforce
the following inbound rules:

### Required Inbound Rules

| Priority | Name | Port | Protocol | Source | Action |
|----------|------|------|----------|--------|--------|
| 100 | Allow-HTTPS | 443 | TCP | Any | Allow |
| 110 | Allow-HTTP-Redirect | 80 | TCP | Any | Allow |
| 120 | Allow-SSH | 22 | TCP | Your IP | Allow |
| 4096 | Deny-All-Inbound | * | Any | Any | Deny |

> **Security Note:** Restrict SSH (port 22) to your specific IP address or CIDR range
> rather than `Any (*)` to reduce exposure to brute-force attacks.

### Update NSG Rules via Azure CLI

```bash
# Restrict SSH to a specific IP
az network nsg rule update \
  --resource-group "<your-rg>" \
  --nsg-name "<your-nsg>" \
  --name "Allow-SSH" \
  --source-address-prefix "203.0.113.0/24"
```

### Deny All Other Inbound Traffic

```bash
az network nsg rule create \
  --resource-group "<your-rg>" \
  --nsg-name "<your-nsg>" \
  --name "Deny-All-Inbound" \
  --priority 4096 \
  --direction Inbound \
  --access Deny \
  --protocol "*" \
  --source-address-prefix "*" \
  --destination-port-range "*"
```

---

## SSH Hardening

### Disable Password Authentication

Edit `/etc/ssh/sshd_config`:

```bash
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
```

### Disable Root Login

```bash
sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
```

### Reload SSH Service

```bash
sudo systemctl reload sshd
```

---

## fail2ban — Brute-Force Protection

Install and configure fail2ban to block repeated failed login attempts:

```bash
sudo apt-get install -y fail2ban
```

Create a jail configuration for SSH:

```bash
sudo tee /etc/fail2ban/jail.d/nextcloud-ssh.conf > /dev/null << 'EOF'
[sshd]
enabled  = true
port     = 22
filter   = sshd
logpath  = /var/log/auth.log
maxretry = 5
bantime  = 3600
findtime = 600
EOF
```

Enable fail2ban for Nextcloud login attempts (requires Nginx log parsing):

```bash
sudo tee /etc/fail2ban/filter.d/nextcloud.conf > /dev/null << 'EOF'
[Definition]
failregex = ^<HOST>.*"(GET|POST).*" (401|403) .*$
            .*Login failed: .*Remote IP: '<HOST>'.*
ignoreregex =
EOF

sudo tee /etc/fail2ban/jail.d/nextcloud-http.conf > /dev/null << 'EOF'
[nextcloud]
enabled  = true
port     = http,https
filter   = nextcloud
logpath  = /var/log/nginx/access.log
           /var/www/nextcloud/data/nextcloud.log
maxretry = 10
bantime  = 3600
findtime = 600
EOF
```

```bash
sudo systemctl enable --now fail2ban
```

---

## HTTP Security Headers (Nginx)

Nextcloud's Nginx configuration already includes recommended security headers.
Verify they are present in your virtual host configuration:

```bash
sudo grep -A 20 "server {" /etc/nginx/sites-enabled/nextcloud
```

Ensure the following headers are configured:

```nginx
add_header Strict-Transport-Security "max-age=15768000; includeSubDomains; preload" always;
add_header X-Content-Type-Options "nosniff" always;
add_header X-Frame-Options "SAMEORIGIN" always;
add_header X-XSS-Protection "1; mode=block" always;
add_header Referrer-Policy "no-referrer" always;
add_header Permissions-Policy "geolocation=(),midi=(),sync-xhr=(),microphone=(),camera=(),magnetometer=(),gyroscope=(),fullscreen=(self),payment=()" always;
```

After any Nginx configuration change:

```bash
sudo nginx -t && sudo systemctl reload nginx
```

---

## Nextcloud Security Scan

Run the official Nextcloud security scanner against your instance:

```
https://scan.nextcloud.com
```

Address all **Critical** and **High** severity findings before going to production.

---

## Trusted Certificates

Ensure only trusted CA certificates are accepted for outbound HTTPS calls from Nextcloud:

```bash
sudo -u www-data php /var/www/nextcloud/occ security:certificates
```

Import a specific CA if needed:

```bash
sudo -u www-data php /var/www/nextcloud/occ security:certificates:import /path/to/ca.crt
```

---

## OWASP Hardening Checklist

| OWASP Category | Mitigation Applied |
|---------------|-------------------|
| A01 — Broken Access Control | NSG Deny-All rule; fail2ban |
| A02 — Cryptographic Failures | HTTPS enforced; HSTS header |
| A05 — Security Misconfiguration | SSH hardening; security headers |
| A07 — Auth Failures | fail2ban; password auth disabled |
| A09 — Security Logging | Nginx + Nextcloud logs; Azure Monitor alerts |

---

## Related Guides

- [HTTPS / TLS Certificate](../wiki/HTTPS-TLS-Certificate.md) — Configure Let's Encrypt
- [Monitoring](monitoring.md) — Set alerts for suspicious activity
- [Entra ID SSO](entra-id-sso.md) — Replace password auth with Entra ID SSO
