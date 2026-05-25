# Release Notes — v1.0.0

> Azure Marketplace release notes for **Cotechnoe Cloud Hub — Secure File Collaboration on Azure**
> Initial release (v1.0.0)

---

## v1.0.0 — Initial Release

**Release date:** 2024

### What's New

This is the initial release of Cotechnoe Cloud Hub on Azure Marketplace.

**Platform**
- Nextcloud Hub (latest stable) deployed on Ubuntu LTS
- Nginx + PHP-FPM 8.1+ + MariaDB + Redis — production-tuned stack
- Automated Let's Encrypt TLS certificate provisioning (Certbot)
- Nextcloud built-in updater enabled for seamless security patch delivery

**Security**
- NSG pre-configured: inbound HTTPS (443), HTTP redirect (80), SSH (22) only
- SSH key-pair authentication required — password login disabled by default
- HSTS and security headers configured in Nginx
- fail2ban available for brute-force protection

**Collaboration Features**
- File sync and share (web, desktop, mobile clients)
- Collabora Online Built-in CODE — browser-based document editing
- Nextcloud Talk — video conferencing and messaging
- Calendar (CalDAV) and Contacts (CardDAV)
- Two-Factor Authentication (TOTP)
- Group Folders for team collaboration

**Identity & Access**
- Local user management
- LDAP/AD integration supported
- SAML 2.0 / OIDC SSO with Microsoft Entra ID supported via `user_saml` app

**Documentation**
- Full wiki included in GitHub repository
- Guides: deployment, SSH, HTTPS, post-deployment, updates, backup/restore
- Technical guides: VM sizing, apps, Entra ID SSO, monitoring, network security

### Known Limitations

- Single-VM deployment: high availability requires additional Azure services
  (Azure Files Premium, Azure Database for MariaDB, Azure Cache for Redis)
- Collabora Online is provided as the built-in CODE server; for production
  scale (>20 concurrent editors), a dedicated Collabora Online server is recommended

### Upgrade Path

Future releases will be published as new VM image versions on Azure Marketplace.
Between Marketplace releases, Nextcloud application updates can be applied using
the built-in updater (`occ upgrade`) as documented in the
[Updating Nextcloud](https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/wiki/Updating-Nextcloud) wiki page.

---

## Legal

Nextcloud is a registered trademark of Nextcloud GmbH, Stuttgart, Germany.
This offer is published independently by Cotechnoe and is not affiliated with or
endorsed by Nextcloud GmbH.

Documentation is licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
