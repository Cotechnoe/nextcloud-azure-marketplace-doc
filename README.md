# Cotechnoe Cloud Hub — Secure File Collaboration on Azure

[![Azure Marketplace](https://img.shields.io/badge/Azure%20Marketplace-Cotechnoe%20Cloud%20Hub-blue?logo=microsoftazure)](https://azuremarketplace.microsoft.com/en-US/marketplace/apps/cotechnoe.nextcloud-hub?ocid=nc_github_readme&utm_source=github&utm_medium=referral&utm_campaign=docs)
[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

This repository contains the user documentation for the **Cotechnoe Cloud Hub** virtual machine offer on Azure Marketplace — a self-hosted, secure file collaboration platform built on [Nextcloud](https://nextcloud.com) for universities and research centres.

## Quick Start

1. **Deploy** the VM from [Azure Marketplace](https://azuremarketplace.microsoft.com/en-US/marketplace/apps/cotechnoe.nextcloud-hub?ocid=nc_github_readme&utm_source=github&utm_medium=referral&utm_campaign=docs) — takes about 5 minutes.
2. **Connect** via SSH and point a domain name to the VM public IP.
3. **Open** `https://your-domain.example.com` — your Nextcloud instance is ready to configure.

Full step-by-step instructions are available in the [wiki](../../wiki).

---

## Documentation

| Topic | EN | FR |
|-------|----|----|
| **Home — Overview & Navigation** | [Home](../../wiki/Home) | [Home-fr](../../wiki/Home-fr) |
| **Deploying from Marketplace** | [Deploying-from-Marketplace](../../wiki/Deploying-from-Marketplace) | [Deploying-from-Marketplace-fr](../../wiki/Deploying-from-Marketplace-fr) |
| **SSH Connection** | [SSH-Connection](../../wiki/SSH-Connection) | [SSH-Connection-fr](../../wiki/SSH-Connection-fr) |
| **Post-Deployment Verification** | [Post-Deployment-Verification](../../wiki/Post-Deployment-Verification) | [Post-Deployment-Verification-fr](../../wiki/Post-Deployment-Verification-fr) |
| **HTTPS / TLS Certificate** | [HTTPS-TLS-Certificate](../../wiki/HTTPS-TLS-Certificate) | [HTTPS-TLS-Certificate-fr](../../wiki/HTTPS-TLS-Certificate-fr) |
| **Configuring Nextcloud** | [Configuring-Nextcloud](../../wiki/Configuring-Nextcloud) | [Configuring-Nextcloud-fr](../../wiki/Configuring-Nextcloud-fr) |
| **Updating Nextcloud** | [Updating-Nextcloud](../../wiki/Updating-Nextcloud) | [Updating-Nextcloud-fr](../../wiki/Updating-Nextcloud-fr) |
| **Exploring Nextcloud** | [Exploring-Nextcloud](../../wiki/Exploring-Nextcloud) | [Exploring-Nextcloud-fr](../../wiki/Exploring-Nextcloud-fr) |
| **Loading Sample Data** | [Loading-Sample-Data](../../wiki/Loading-Sample-Data) | [Loading-Sample-Data-fr](../../wiki/Loading-Sample-Data-fr) |
| **Troubleshooting** | [Troubleshooting](../../wiki/Troubleshooting) | [Troubleshooting-fr](../../wiki/Troubleshooting-fr) |
| **Support** | [Support](../../wiki/Support) | [Support-fr](../../wiki/Support-fr) |
| **Managing Users** | [Managing-Users](../../wiki/Managing-Users) | [Managing-Users-fr](../../wiki/Managing-Users-fr) |
| **Managing Apps** | [Managing-Apps](../../wiki/Managing-Apps) | [Managing-Apps-fr](../../wiki/Managing-Apps-fr) |
| **VM Sizing Guide** | [vm-sizing-guide](docs/vm-sizing-guide.md) | [vm-sizing-guide-fr](docs/vm-sizing-guide-fr.md) |
| **Nextcloud Apps Guide** | [nextcloud-apps-guide](docs/nextcloud-apps-guide.md) | [nextcloud-apps-guide-fr](docs/nextcloud-apps-guide-fr.md) |
| **Backup & Restore** | [backup-restore](docs/backup-restore.md) | [backup-restore-fr](docs/backup-restore-fr.md) |
| **Entra ID SSO** | [entra-id-sso](docs/entra-id-sso.md) | [entra-id-sso-fr](docs/entra-id-sso-fr.md) |
| **Monitoring** | [monitoring](docs/monitoring.md) | [monitoring-fr](docs/monitoring-fr.md) |
| **Network Security** | [network-security](docs/network-security.md) | [network-security-fr](docs/network-security-fr.md) |

---

## About This VM

The **Cotechnoe Cloud Hub** VM deploys a fully configured, self-hosted collaboration platform on a single Azure virtual machine:

| Service | Role |
|---------|------|
| **Nginx** | Reverse proxy + TLS termination |
| **PHP-FPM 8.3** | Application runtime |
| **PostgreSQL 16** | Integrated database |
| **Redis** | Session cache & file locking |
| **Certbot** | Automatic Let's Encrypt certificate management |

The software stack is based on [Nextcloud Hub](https://nextcloud.com), distributed under [AGPL-3.0](https://www.gnu.org/licenses/agpl-3.0.html). See [NOTICE.md](NOTICE.md) for attribution details.

---

## Repository Structure

```
nextcloud-azure-marketplace-doc/
├── README.md               ← This file
├── README-fr.md            ← French version
├── NOTICE.md               ← Third-party software notices
├── LICENSE.md              ← Documentation license (CC BY 4.0)
├── PRIVACY.md              ← Privacy policy for the VM
├── Makefile                ← Local tooling (lint, link-check, sync-fr)
└── docs/
    ├── adr/                ← Architecture Decision Records
    ├── vm-sizing-guide.md
    ├── backup-restore.md
    ├── entra-id-sso.md
    ├── monitoring.md
    ├── network-security.md
    └── nextcloud-apps-guide.md
```

Wiki pages are maintained at [`Cotechnoe/nextcloud-azure-marketplace-doc/wiki`](../../wiki).

---

## Support

- **GitHub Issues:** [Open an issue](https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/issues)
- **Nextcloud Community Forum:** [help.nextcloud.com](https://help.nextcloud.com)
- **Azure Support:** [portal.azure.com](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade)

---

## License

Documentation in this repository is licensed under [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).  
The Nextcloud software itself is distributed under [AGPL-3.0](https://www.gnu.org/licenses/agpl-3.0.html).  
See [NOTICE.md](NOTICE.md) and [LICENSE.md](LICENSE.md) for details.
