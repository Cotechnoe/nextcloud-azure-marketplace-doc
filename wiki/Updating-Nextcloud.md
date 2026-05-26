# Updating Nextcloud

> 🇫🇷 Cette page est également disponible en français : [[fr-Updating-Nextcloud]]

This page explains how to keep your Nextcloud installation up to date using
the built-in updater and the `occ upgrade` command.

---

## Prerequisites

- You are connected to the VM via SSH — see [[SSH-Connection]].
- You have taken a backup before starting — see the backup guide for details.

> **Important:** Always back up your data and database before performing an upgrade.
> Upgrades cannot be rolled back without a backup.

---

## Update Channels

Nextcloud offers two update channels:

| Channel | Description |
|---------|-------------|
| **stable** | Well-tested releases, recommended for production |
| **maintenance** | Security and critical bug fixes only for the current major version |

Check the current channel:

```bash
sudo -u www-data php /var/www/nextcloud/occ config:system:get updater.release.channel
```

Set the channel to `stable` (recommended):

```bash
sudo -u www-data php /var/www/nextcloud/occ config:system:set updater.release.channel --value=stable
```

---

## Step 1 — Enable Maintenance Mode

Before upgrading, put Nextcloud into maintenance mode to prevent user access:

```bash
sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --on
```

---

## Step 2 — Run the Updater

Nextcloud ships with a built-in web updater. To use it:

1. Navigate to `https://cloud.example.com/updater/` in your browser while logged in as admin.
2. Click **Start update** and follow the on-screen prompts.
3. The updater will download the new version and extract the files.

Alternatively, use the command-line updater:

```bash
sudo -u www-data php /var/www/nextcloud/updater/updater.phar
```

> **Note:** The Nextcloud Updater app is a core component and **must not be disabled**.
> Disabling it would prevent security updates from being applied.

---

## Step 3 — Run Database Migrations

After the files are updated, run the database upgrade:

```bash
sudo -u www-data php /var/www/nextcloud/occ upgrade
```

This applies any database schema changes required by the new version.

---

## Step 4 — Disable Maintenance Mode

Once the upgrade is complete, disable maintenance mode:

```bash
sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --off
```

---

## Step 5 — Verify the Upgrade

Check that Nextcloud is running the new version:

```bash
sudo -u www-data php /var/www/nextcloud/occ status
```

Expected output includes the new version number:

```
Nextcloud or one of the apps require upgrade - only a single user (who is an admin) is allowed to be logged in
...
  - installed: true
  - version: 28.x.x.x
  - versionstring: 28.x.x
```

Also log in via the web interface and check **Settings > Overview** for any remaining warnings.

---

## Verify

| Check | Command / Action |
|-------|-----------------|
| Version | `sudo -u www-data php /var/www/nextcloud/occ status` |
| No warnings | Settings > Overview in browser |
| All services active | `sudo systemctl is-active nginx php8.3-fpm postgresql redis-server` |

---

## Troubleshooting

**`occ upgrade` fails with "already latest version"**  
The database is already at the current version. Run `occ status` to confirm. You can safely disable maintenance mode.

**Web updater gets stuck**  
Use the command-line updater instead: `sudo -u www-data php /var/www/nextcloud/updater/updater.phar`

**"Could not get exclusive lock on config file"**  
Another `occ` process is running. Wait for it to finish, or check with `ps aux | grep occ`.

**Apps are disabled after upgrade**  
Some apps may not yet support the new Nextcloud version. Go to **Settings > Apps**
and check for available app updates, or wait for the app developer to release a compatible version.

---

## Next Steps

| Next | Page |
|------|------|
| Manage installed apps | [[Managing-Apps]] |
| Manage user accounts | [[Managing-Users]] |
| Troubleshoot issues | [[Troubleshooting]] |
