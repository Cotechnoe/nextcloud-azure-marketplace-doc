# Cotechnoe Cloud Hub — Azure Marketplace Documentation

> 🇫🇷 Cette page est également disponible en français : [[fr_Home]]

Welcome to the official documentation for **Cotechnoe Cloud Hub — Secure File Collaboration on Azure**, deployed via the Microsoft Azure Marketplace.

Cotechnoe Cloud Hub is a production-ready [Nextcloud Hub](https://nextcloud.com) instance running on Ubuntu 24.04 LTS with Nginx, PHP-FPM 8.3, PostgreSQL 16, and Redis — all pre-configured and ready to use after deployment.

## Quick Start

Cotechnoe Cloud Hub is available directly from the [Microsoft Azure Marketplace](https://azuremarketplace.microsoft.com/). Once deployed, follow these steps:

| # | Task | Wiki Page |
|---|------|-----------|
| 1 | Deploy the VM and fill in configuration parameters | [[Deploying-from-Marketplace]] |
| 2 | Connect to the VM via SSH | [[SSH-Connection]] |
| 3 | Verify that all services are running | [[Post-Deployment-Verification]] |
| 4 | Confirm the HTTPS certificate is active | [[HTTPS-TLS-Certificate]] |
| 5 | Configure Nextcloud settings | [[Configuring-Nextcloud]] |
| 6 | Load sample data to explore features | [[Loading-Sample-Data]] |
| 7 | Explore the Nextcloud interface | [[Exploring-Nextcloud]] |
| 8 | Troubleshoot common issues | [[Troubleshooting]] |

## Architecture Overview

```
Internet (HTTPS 443 / HTTP 80)
        │
     Nginx  ──  reverse proxy + Let's Encrypt TLS certificate (auto-provisioned)
        │
     PHP-FPM 8.3
        │
     Nextcloud Hub 33  (/var/www/nextcloud)
        │
        ├── PostgreSQL 16  ──  database (127.0.0.1:5432)
        │
        ├── Redis  ──  session cache + file locking (127.0.0.1:6379)
        │
        └── /var/nextcloud-data  ──  Azure managed data disk (user files, logs)
```

> **Security:** PostgreSQL (port 5432) and Redis (port 6379) are bound to `127.0.0.1` only. Publicly accessible ports: 80 (HTTP → HTTPS redirect), 443 (HTTPS), and 22 (SSH, restricted by NSG rule to `sshSourceIP`).

## Deployment Parameters

| Parameter | Description | Default / Example |
|-----------|-------------|-------------------|
| `adminUsername` | VM SSH administrator username | `azureuser` |
| `adminPublicKey` | SSH public key (OpenSSH format, ed25519 or RSA 4096) | `ssh-ed25519 AAAA...` |
| `vmSize` | Azure VM size | `Standard_D4s_v3` |
| `dataDiskSizeGB` | Size of the managed data disk for `/var/nextcloud-data` (GB) | `128` |
| `sshSourceIP` | Allowed CIDR for SSH access | `203.0.113.0/32` or `*` |
| `nextcloudAdminUser` | Nextcloud administrator username | `ncadmin` |
| `nextcloudAdminPassword` | Nextcloud administrator password (min. 12 chars) | — |
| `nextcloudDomain` | Domain name used for the VM FQDN and TLS certificate | `cloudapp.azure.com` |

## Wiki Pages

- [[Deploying-from-Marketplace]] — Deploy from Azure Marketplace and fill in configuration parameters
- [[SSH-Connection]] — Connect to the VM using a PEM key
- [[Post-Deployment-Verification]] — Validate that all services are running correctly
- [[HTTPS-TLS-Certificate]] — TLS certificate provisioning, Let's Encrypt, renewal, and custom certs
- [[Configuring-Nextcloud]] — Configure mail, trusted domains, and other Nextcloud settings
- [[Updating-Nextcloud]] — Safely upgrade Nextcloud to a newer version
- [[Managing-Users]] — Create and manage user accounts and groups
- [[Managing-Apps]] — Install and manage Nextcloud apps
- [[Loading-Sample-Data]] — Load sample files to explore the interface
- [[Exploring-Nextcloud]] — Navigate the Nextcloud web interface
- [[Troubleshooting]] — Common errors and their solutions
- [[Support]] — Publisher and community support channels, contact information

## Available Languages

The following pages are also available in French / Les pages suivantes sont également disponibles en français :

| English | Français |
|---------|----------|
| [[Home]] | [[fr_Home]] |
| [[Deploying-from-Marketplace]] | [[fr_Deploying-from-Marketplace]] |
| [[SSH-Connection]] | [[fr_SSH-Connection]] |
| [[Post-Deployment-Verification]] | [[fr_Post-Deployment-Verification]] |
| [[HTTPS-TLS-Certificate]] | [[fr_HTTPS-TLS-Certificate]] |
| [[Configuring-Nextcloud]] | [[fr_Configuring-Nextcloud]] |
| [[Updating-Nextcloud]] | [[fr_Updating-Nextcloud]] |
| [[Managing-Users]] | [[fr_Managing-Users]] |
| [[Managing-Apps]] | [[fr_Managing-Apps]] |
| [[Loading-Sample-Data]] | [[fr_Loading-Sample-Data]] |
| [[Exploring-Nextcloud]] | [[fr_Exploring-Nextcloud]] |
| [[Troubleshooting]] | [[fr_Troubleshooting]] |
| [[Support]] | [[fr_Support]] |

## Resources

- [Nextcloud Official Documentation](https://docs.nextcloud.com/)
- [Azure Marketplace](https://azuremarketplace.microsoft.com/)
- [[Support]] — Contact publisher or Nextcloud community
