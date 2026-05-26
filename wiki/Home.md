# Cotechnoe Cloud Hub — Documentation Home

> 🇫🇷 Cette page est également disponible en français : [[Home-fr]]

Welcome to the **Cotechnoe Cloud Hub** documentation wiki. This is the central reference for
administrators who have deployed the Nextcloud-based collaboration VM from Azure Marketplace.

[![Azure Marketplace](https://img.shields.io/badge/Azure%20Marketplace-Deploy%20Now-blue?logo=microsoftazure)](https://azuremarketplace.microsoft.com/en-US/marketplace/apps/cotechnoe.nextcloud-hub?ocid=nc_wiki_home&utm_source=wiki&utm_medium=referral&utm_campaign=docs)

---

## Getting Started

Follow these pages **in order** for a fresh deployment:

| Step | Page | Estimated time |
|------|------|----------------|
| 1 | [[Deploying-from-Marketplace]] | 5 min |
| 2 | [[SSH-Connection]] | 5 min |
| 3 | [[Post-Deployment-Verification]] | 10 min |
| 4 | [[HTTPS-TLS-Certificate]] | 15 min |
| 5 | [[Configuring-Nextcloud]] | 20 min |

---

## Day-to-Day Administration

| Task | Page |
|------|------|
| Keep Nextcloud up to date | [[Updating-Nextcloud]] |
| Explore the web interface | [[Exploring-Nextcloud]] |
| Load sample data for testing | [[Loading-Sample-Data]] |
| Manage user accounts and groups | [[Managing-Users]] |
| Install and manage apps | [[Managing-Apps]] |

---

## Technical Guides

| Guide | Description |
|-------|-------------|
| [VM Sizing Guide](https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/blob/main/docs/vm-sizing-guide.md) | Choose the right VM SKU for your user count |
| [Backup & Restore](https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/blob/main/docs/backup-restore.md) | Backup strategy, recovery procedures |
| [Entra ID SSO](https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/blob/main/docs/entra-id-sso.md) | Single Sign-On via Microsoft Entra ID (SAML 2.0 / OIDC) |
| [Monitoring](https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/blob/main/docs/monitoring.md) | Azure Monitor, alerts, log analysis |
| [Network Security](https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/blob/main/docs/network-security.md) | NSG rules, fail2ban, SSH hardening |
| [Nextcloud Apps Guide](https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/blob/main/docs/nextcloud-apps-guide.md) | Collabora Online, Talk, Calendar, Contacts |

---

## Help & Support

- [[Troubleshooting]] — Common post-deployment issues and fixes
- [[Support]] — Where to get help

---

## Available Languages

All pages are available in English (canonical) and French (translation).  
Select the **-fr** version of any page for the French translation.

| English | Français |
|---------|---------|
| [[Home]] | [[Home-fr]] |
| [[Deploying-from-Marketplace]] | [[Deploying-from-Marketplace-fr]] |
| [[SSH-Connection]] | [[SSH-Connection-fr]] |
| [[Post-Deployment-Verification]] | [[Post-Deployment-Verification-fr]] |
| [[HTTPS-TLS-Certificate]] | [[HTTPS-TLS-Certificate-fr]] |
| [[Configuring-Nextcloud]] | [[Configuring-Nextcloud-fr]] |
| [[Updating-Nextcloud]] | [[Updating-Nextcloud-fr]] |
| [[Exploring-Nextcloud]] | [[Exploring-Nextcloud-fr]] |
| [[Loading-Sample-Data]] | [[Loading-Sample-Data-fr]] |
| [[Troubleshooting]] | [[Troubleshooting-fr]] |
| [[Support]] | [[Support-fr]] |
| [[Managing-Users]] | [[Managing-Users-fr]] |
| [[Managing-Apps]] | [[Managing-Apps-fr]] |

---

## About This VM

The Cotechnoe Cloud Hub VM runs the following services on a single Azure virtual machine:

- **Nginx** — reverse proxy with TLS termination
- **PHP-FPM 8.3** — application runtime
- **PostgreSQL 16** — database
- **Redis** — session cache and file locking
- **Certbot** — automatic Let's Encrypt certificate management

The VM is based on [Nextcloud Hub](https://nextcloud.com), a trademark of Nextcloud GmbH.  
See the [NOTICE](https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/blob/main/NOTICE.md) file for attribution.
