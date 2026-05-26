# Exploring Nextcloud

> 🇫🇷 Cette page est également disponible en français : [[fr-Exploring-Nextcloud]]

This page gives you an overview of the core features available in your Nextcloud
deployment so you can get the most out of the platform.

---

## Prerequisites

- Nextcloud is configured and you can log in — see [[Configuring-Nextcloud]].

---

## The Main Interface

After logging in, you land on the **Files** app — the central hub for managing files and folders.

The top navigation bar provides access to all installed apps:

| Icon / App | Description |
|-----------|-------------|
| **Files** | Upload, download, share, and manage files and folders |
| **Photos** | Browse and organize photos and videos |
| **Talk** | Audio/video calls and team messaging |
| **Calendar** | Personal and shared calendars with CalDAV support |
| **Contacts** | Address book with CardDAV support |
| **Activity** | Feed of recent events (uploads, shares, comments) |
| **Settings** | User preferences, security settings, connected devices |

---

## File Management

### Upload Files

- Drag and drop files directly into the browser window, or
- Click the **+** button in the toolbar and select **Upload file**.

### Create Files and Folders

Click the **+** button and choose **New folder**, **New text document**, or **New spreadsheet**
(if Collabora Online is installed).

### Share Files and Folders

1. Hover over a file or folder and click the **Share** icon.
2. Choose to share with:
   - **Internal users or groups** — type a username or group name.
   - **Public link** — generates a shareable URL with optional password protection and expiry date.

### Sync with Desktop and Mobile Clients

Install the Nextcloud desktop or mobile client to keep your files synchronized:

- [Nextcloud Desktop Client](https://nextcloud.com/install/#install-clients) (Windows, macOS, Linux)
- [Nextcloud iOS App](https://apps.apple.com/app/nextcloud/id1125420102)
- [Nextcloud Android App](https://play.google.com/store/apps/details?id=com.nextcloud.client)

Configure the client with:
- **Server URL**: `https://cloud.example.com`
- **Username / Password**: your Nextcloud credentials

---

## WebDAV Access

Nextcloud supports WebDAV for file access from any compatible client or script:

```
https://cloud.example.com/remote.php/dav/files/USERNAME/
```

Replace `USERNAME` with your Nextcloud username.

---

## Key Settings

Access **Settings** (top-right user menu) to:

- Change your password and profile picture.
- Enable **Two-Factor Authentication (2FA)** for enhanced security.
- View and revoke active sessions.
- Generate **App passwords** for use with desktop/mobile clients or API integrations.

---

## Administrator Overview

Administrators can access additional settings under **Settings > Administration**:

| Setting | Purpose |
|---------|---------|
| **Overview** | System health, warnings, and version info |
| **Users** | Create and manage users and groups |
| **Apps** | Install, update, and disable apps |
| **Basic settings** | Email, background jobs, log level |
| **Sharing** | Global share permissions and defaults |
| **Security** | Password policy, brute-force protection, 2FA enforcement |
| **Logging** | View and download application logs |

---

## Next Steps

| Next | Page |
|------|------|
| Load sample data for testing | [[Loading-Sample-Data]] |
| Manage user accounts | [[Managing-Users]] |
| Install and manage apps | [[Managing-Apps]] |
