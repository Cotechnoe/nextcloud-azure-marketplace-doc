# Privacy Policy — Cotechnoe Cloud Hub VM

**Last updated:** 2026-05-25

---

## Overview

The **Cotechnoe Cloud Hub** virtual machine (VM) is a self-hosted deployment that runs
entirely within your Azure subscription. Cotechnoe does not collect, store, or process
any personal data from VM instances after deployment.

---

## Data Collected by the VM

When you deploy and operate the Cotechnoe Cloud Hub VM, the following data is collected and
stored **exclusively within your Azure infrastructure**:

| Data Type | Location | Purpose |
|-----------|----------|---------|
| Nextcloud user accounts (usernames, email, password hashes) | MariaDB on the VM `/var/lib/mysql` | Authentication & collaboration |
| Uploaded files and shared data | VM data disk `/var/www/nextcloud/data` | User file storage |
| Application logs (Nginx, PHP-FPM, Nextcloud) | `/var/log/nginx/`, `/var/log/php-fpm/`, `/var/www/nextcloud/data/nextcloud.log` | Diagnostics & troubleshooting |
| Session data | Redis (in-memory, port 6379) | Performance & file locking |
| TLS certificates | `/etc/letsencrypt/` | HTTPS communication |
| SSH authentication logs | `/var/log/auth.log` | Security & access control |

All data listed above remains within your Azure subscription and is subject to your
organization's own data governance policies.

---

## Data Retention

- **User data** — retained for as long as Nextcloud accounts exist on the VM.
- **Log files** — rotated automatically by `logrotate`; default retention is 14 days.
- **TLS certificates** — renewed automatically by Certbot every 60 days; expired certificates
  are archived in `/etc/letsencrypt/archive/`.

You are responsible for defining and enforcing data retention policies appropriate to your
organization.

---

## Data Processed by Azure

Deploying and operating a VM on Microsoft Azure involves data processing by Microsoft under
their [Privacy Statement](https://privacy.microsoft.com/en-us/privacystatement) and
[Data Protection Addendum](https://www.microsoft.com/en-us/licensing/docs/view/Microsoft-Products-and-Services-Data-Protection-Addendum-DPA).

Azure services that may process data in connection with this VM include:

- Azure Compute (VM resources)
- Azure Virtual Network (networking)
- Azure Storage (OS disk, optional data disk)
- Azure Monitor / Log Analytics (if enabled by the operator)
- Azure Backup (if enabled by the operator)

---

## Let's Encrypt / Certbot

When you use the built-in automatic TLS certificate feature, the VM contacts the
[Let's Encrypt ACME API](https://letsencrypt.org/privacy/) to obtain and renew certificates.
Let's Encrypt logs the domain name and IP address associated with each certificate request.
This is subject to the [Let's Encrypt Privacy Policy](https://letsencrypt.org/privacy/).

---

## No Telemetry from Cotechnoe

Cotechnoe does not install telemetry agents, tracking pixels, analytics SDKs, or any other
software that transmits data from the VM to Cotechnoe. There is no outbound data collection
by the publisher after deployment.

---

## Operator Responsibilities

As the operator of this VM, you are the **data controller** for all personal data stored or
processed by Nextcloud. You are responsible for:

- Configuring user accounts and access policies.
- Implementing backup and disaster recovery procedures.
- Applying security patches and updates.
- Complying with applicable data protection regulations (e.g., GDPR, PIPEDA, FERPA).
- Publishing your own privacy notice to end users of your Nextcloud instance.

---

## Contact

For questions about this privacy policy or the Cotechnoe Cloud Hub offer:

- **GitHub Issues:** [github.com/Cotechnoe/nextcloud-azure-marketplace-doc/issues](https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/issues)
- **Website:** [cotechnoe.com](https://cotechnoe.com)
