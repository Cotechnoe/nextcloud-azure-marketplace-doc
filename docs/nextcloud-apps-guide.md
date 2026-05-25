# Nextcloud Apps Guide

> 🇫🇷 Cette page est également disponible en français : [Guide des applications Nextcloud](nextcloud-apps-guide-fr.md)

This guide covers the installation and configuration of the most useful apps
for academic, research, and enterprise environments.

---

## App Installation Policy

Install apps only from the official **Nextcloud App Store** (`apps.nextcloud.com`).
Third-party app repositories are not supported and may compromise security.

See the wiki page [[Managing-Apps]] for general app management procedures.

---

## Collabora Online (Document Editing)

Collabora Online provides a browser-based office suite (Writer, Calc, Impress)
integrated directly in Nextcloud.

### Requirements

- Minimum **4 vCPU / 8 GB RAM** (Standard_D2s_v3 or higher)
- A separate **Collabora Online server** or **Collabora Online Built-in** app (smaller deployments)

### Install Collabora Online Built-in

For small deployments (up to 20 concurrent editors):

```bash
sudo -u www-data php /var/www/nextcloud/occ app:install richdocumentscode
sudo -u www-data php /var/www/nextcloud/occ app:install richdocuments
```

Then configure in Nextcloud:

1. Go to **Settings > Administration > Nextcloud Office**.
2. Select **Use the built-in CODE server**.
3. Click **Save**.

### Verify

Open a `.docx`, `.xlsx`, or `.pptx` file in the Files app — it should open in the browser editor.

---

## Talk (Video Calls and Messaging)

Nextcloud Talk provides end-to-end encrypted video calls, screen sharing,
and team messaging without leaving Nextcloud.

### Install

```bash
sudo -u www-data php /var/www/nextcloud/occ app:install spreed
```

### Configure TURN Server (for calls across NAT/firewalls)

For reliable video calls, configure a TURN server:

1. Go to **Settings > Administration > Talk**.
2. Add your TURN server URL: `turns:turn.example.com:5349`
3. Enter the TURN server secret.

> For a quick test deployment without a TURN server, calls may work on the same network
> but will fail for remote users behind NAT.

---

## Calendar and Contacts

Provide CalDAV and CardDAV endpoints that integrate with desktop and mobile clients.

### Install

```bash
sudo -u www-data php /var/www/nextcloud/occ app:install calendar
sudo -u www-data php /var/www/nextcloud/occ app:install contacts
```

### CalDAV/CardDAV URLs

Users can connect their calendar and address book clients using:

- **CalDAV:** `https://cloud.example.com/remote.php/dav/calendars/<username>/`
- **CardDAV:** `https://cloud.example.com/remote.php/dav/addressbooks/users/<username>/`

---

## Two-Factor Authentication (TOTP)

Enable TOTP-based two-factor authentication for additional account security.

### Install

```bash
sudo -u www-data php /var/www/nextcloud/occ app:install twofactor_totp
```

### Enforce 2FA for All Users (Admin)

```bash
sudo -u www-data php /var/www/nextcloud/occ twofactor:enforce --on
```

Users will be prompted to configure their authenticator app (Google Authenticator,
Authy, etc.) on next login.

### Enforce 2FA for Specific Groups Only

```bash
sudo -u www-data php /var/www/nextcloud/occ twofactor:enforce --on --group=admins
```

---

## Group Folders

Group Folders allow administrators to create shared folders accessible to entire
groups, with fine-grained ACL permissions.

### Install

```bash
sudo -u www-data php /var/www/nextcloud/occ app:install groupfolders
```

### Create a Group Folder

1. Go to **Settings > Administration > Group folders**.
2. Click **Add new folder**, enter a name.
3. Assign groups and set permissions (Read, Write, Share, Delete).

---

## Summary

| App | App ID | Use Case |
|-----|--------|----------|
| Collabora Online (Built-in) | `richdocumentscode` + `richdocuments` | Browser document editing |
| Talk | `spreed` | Video calls, messaging |
| Calendar | `calendar` | CalDAV calendars |
| Contacts | `contacts` | CardDAV address books |
| Two-Factor TOTP | `twofactor_totp` | Enhanced login security |
| Group Folders | `groupfolders` | Shared departmental folders |

---

## Related Guides

- [VM Sizing Guide](vm-sizing-guide.md) — Ensure sufficient resources before installing heavy apps
- [Managing Users](../wiki/Managing-Users.md)
- [Network Security](network-security.md)
