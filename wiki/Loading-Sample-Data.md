# Loading Sample Data

> 🇫🇷 Cette page est également disponible en français : [[Loading-Sample-Data-fr]]

This page explains how to load sample files and data into Nextcloud to explore its
features, run demonstrations, or validate your deployment.

---

## Prerequisites

- Nextcloud is configured and you can log in as admin — see [[Configuring-Nextcloud]].
- You are connected to the VM via SSH — see [[SSH-Connection]].

---

## Option 1 — Upload Files via the Web Interface

The simplest way to add sample content is to upload files directly through the browser:

1. Log in to Nextcloud at `https://cloud.example.com`.
2. Click the **+** button in the Files toolbar.
3. Select **Upload file** and choose files from your local machine.

You can upload any documents, images, or spreadsheets to explore sharing and collaboration features.

---

## Option 2 — Copy Files from the Server

If you want to add a larger set of sample files quickly, SSH into the VM and copy files
to a user's data directory:

```bash
# Replace "admin" with the actual Nextcloud username
NEXTCLOUD_USER="admin"
DATA_DIR="/var/nextcloud-data/${NEXTCLOUD_USER}/files"

# Create a sample directory
sudo mkdir -p "${DATA_DIR}/Sample Documents"

# Copy example files (adjust source path as needed)
sudo cp /usr/share/doc/*/copyright "${DATA_DIR}/Sample Documents/" 2>/dev/null || true
sudo chown -R www-data:www-data "${DATA_DIR}"
```

After copying files, scan them to make Nextcloud aware of them:

```bash
sudo -u www-data php /var/www/nextcloud/occ files:scan --user="${NEXTCLOUD_USER}"
```

---

## Option 3 — Generate Sample Users and Files with occ

For a demonstration environment, you can create multiple test users with sample data:

### Create Test Users

```bash
# Create a test user
sudo -u www-data php /var/www/nextcloud/occ user:add --password-from-env testuser1
# When prompted, or use:
sudo -u www-data php /var/www/nextcloud/occ user:add \
  --display-name="Test User 1" \
  --group="testgroup" \
  testuser1
```

### Share Files Between Users

1. Log in as admin.
2. Upload files to your admin Files area.
3. Share them with `testuser1` using the share dialog.

---

## Option 4 — Import a Demo Dataset via WebDAV

Use `curl` to upload files via WebDAV from a remote source or local file system:

```bash
# Upload a single file via WebDAV
curl -u admin:ADMIN_PASSWORD \
  -T /path/to/local/file.pdf \
  https://cloud.example.com/remote.php/dav/files/admin/file.pdf
```

---

## Verify

After loading sample data:

1. Log in to Nextcloud at `https://cloud.example.com`.
2. Open the **Files** app and confirm the uploaded files are visible.
3. Try sharing a file with another user to test the sharing workflow.
4. Install the **Photos** app (if not already installed) and upload some images to test the gallery view.

---

## Cleanup

To remove all sample data when you no longer need it:

1. In the Nextcloud web interface, select the files/folders and click **Delete**.
2. Go to **Files > Deleted files** and permanently delete them from the trash.

Or via command line:

```bash
sudo -u www-data php /var/www/nextcloud/occ trashbin:cleanup --all-users
```

---

## Next Steps

| Next | Page |
|------|------|
| Manage user accounts | [[Managing-Users]] |
| Manage installed apps | [[Managing-Apps]] |
| Troubleshoot issues | [[Troubleshooting]] |
