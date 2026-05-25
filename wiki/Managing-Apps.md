# Managing Apps

> 🇫🇷 Cette page est également disponible en français : [[Managing-Apps-fr]]

This page explains how to install, update, enable, disable, and remove apps in your
Nextcloud deployment.

---

## Prerequisites

- You are logged in as an administrator.

---

## The App Store

Nextcloud has a built-in App Store that provides access to official apps maintained
by Nextcloud GmbH and verified community developers.

To access it:

1. Go to **Settings > Apps** in the Nextcloud administration panel.
2. Browse apps by category or search by name.

> **Security Notice:** Only install apps from the official Nextcloud App Store
> (`apps.nextcloud.com`). Third-party repositories are not supported and
> may introduce security vulnerabilities or instability.

---

## Installing an App

### Via the Web Interface

1. Go to **Settings > Apps**.
2. Find the app you want to install.
3. Click **Download and enable**.

### Via CLI

```bash
sudo -u www-data php /var/www/nextcloud/occ app:install <app-id>
```

Example — install the Contacts app:

```bash
sudo -u www-data php /var/www/nextcloud/occ app:install contacts
```

---

## Enabling and Disabling Apps

### Enable an App

```bash
sudo -u www-data php /var/www/nextcloud/occ app:enable <app-id>
```

### Disable an App

```bash
sudo -u www-data php /var/www/nextcloud/occ app:disable <app-id>
```

> **Important:** Some core apps **must not be disabled** as they are required for
> secure and correct operation of Nextcloud. The **Updater** app is one such
> component — disabling it would prevent security updates from being applied.

---

## Updating Apps

Apps receive updates independently of the Nextcloud core. To update all apps:

### Via the Web Interface

1. Go to **Settings > Apps > Updates** (if available).
2. Click **Update all** or update apps individually.

### Via CLI

```bash
sudo -u www-data php /var/www/nextcloud/occ app:update --all
```

To update a single app:

```bash
sudo -u www-data php /var/www/nextcloud/occ app:update <app-id>
```

---

## Listing Installed Apps

```bash
sudo -u www-data php /var/www/nextcloud/occ app:list
```

This shows enabled and disabled apps along with their version numbers.

---

## Removing an App

### Via the Web Interface

1. Go to **Settings > Apps**.
2. Find the app under **Your apps** or **Disabled apps**.
3. Click **Remove**.

### Via CLI

```bash
sudo -u www-data php /var/www/nextcloud/occ app:remove <app-id>
```

> **Note:** Removing an app deletes its code but may leave configuration data in the database.

---

## Recommended Apps

The following apps are commonly used in academic, research, and enterprise environments:

| App | Description | App ID |
|-----|-------------|--------|
| **Collabora Online** | Browser-based document editor (Writer, Calc, Impress) | `richdocuments` |
| **Talk** | Video calls, screen sharing, and team messaging | `spreed` |
| **Calendar** | Personal and shared calendars with CalDAV | `calendar` |
| **Contacts** | Address book with CardDAV support | `contacts` |
| **Two-Factor TOTP** | Authenticator app (Google Authenticator, Authy) | `twofactor_totp` |
| **Group Folders** | Shared folders with per-group permissions | `groupfolders` |
| **Passwords** | Password manager integrated with Nextcloud | `passwords` |

---

## Next Steps

| Next | Page |
|------|------|
| Troubleshoot issues | [[Troubleshooting]] |
| Get support | [[Support]] |
| Update Nextcloud core | [[Updating-Nextcloud]] |
