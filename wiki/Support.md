# Support

> 🇫🇷 Cette page est également disponible en français : [[fr_Support]]

This page describes the available support channels for the Nextcloud Azure Marketplace
deployment offered by Cotechnoe.

---

## Support Channels

### 1. GitHub Issues — Deployment and Documentation Problems

For problems specific to the Azure Marketplace deployment, VM configuration,
or documentation errors, open an issue in the GitHub repository:

**[github.com/Cotechnoe/nextcloud-azure-marketplace-doc/issues](https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/issues)**

Use this channel for:
- VM does not start after deployment
- Services (Nginx, PHP-FPM, MariaDB, Redis) fail to start
- Documentation errors or missing steps
- Suggestions for new guides or improvements

### 2. Nextcloud Community Forum — Application-Level Questions

For questions about Nextcloud features, apps, configuration, and general usage:

**[help.nextcloud.com](https://help.nextcloud.com)**

Use this channel for:
- App installation and configuration
- User management questions
- File sharing and collaboration issues
- Integration with external services (LDAP, Entra ID, etc.)

### 3. Azure Support — Cloud Infrastructure Issues

For problems with the Azure infrastructure itself (VM availability, networking, billing):

**[azure.microsoft.com/en-us/support/create-ticket](https://azure.microsoft.com/en-us/support/create-ticket)**

Use this channel for:
- VM not reachable from the Azure Portal
- NSG rules not applying correctly
- Subscription or billing questions
- Azure Monitor alerts

---

## Filing a Good Bug Report

When opening a GitHub issue, include the following information to help resolve
your problem faster:

```
## Environment
- Nextcloud version: (run `sudo -u www-data php /var/www/nextcloud/occ status`)
- VM SKU: (e.g. Standard_B2s)
- OS: Ubuntu 24.04 LTS
- Deployment date: YYYY-MM-DD

## Problem Description
A clear description of what went wrong.

## Steps to Reproduce
1. Step one
2. Step two
3. Step three

## Expected Behavior
What you expected to happen.

## Actual Behavior
What actually happened.

## Relevant Logs
(paste output of relevant commands — see [[Troubleshooting]] for diagnostic commands)
```

---

## Self-Service Diagnostic

Before opening a support request, run these quick checks:

```bash
# Check all four services
sudo systemctl is-active nginx php8.1-fpm mariadb redis-server

# Check Nextcloud status
sudo -u www-data php /var/www/nextcloud/occ status

# Check disk space
df -h
```

See [[Troubleshooting]] for detailed diagnostic procedures.

---

## Next Steps

| Next | Page |
|------|------|
| Troubleshoot common issues | [[Troubleshooting]] |
| Explore Nextcloud | [[Exploring-Nextcloud]] |
| Return to wiki home | [[Home]] |
