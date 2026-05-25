# Managing Users

> 🇫🇷 Cette page est également disponible en français : [[Managing-Users-fr]]

This page covers creating, organizing, and managing user accounts in Nextcloud,
including group management, quotas, and CSV import for bulk provisioning.

---

## Prerequisites

- You are logged in as an administrator.
- Nextcloud is configured — see [[Configuring-Nextcloud]].

---

## Creating a User

1. Go to **Settings > Users** in the Nextcloud administration panel.
2. Click **New user**.
3. Fill in the fields:

| Field | Description |
|-------|-------------|
| **Username** | Unique login name (cannot be changed later) |
| **Display name** | Full name shown in the interface |
| **Password** | Initial password (user can change it after login) |
| **Email** | Optional — used for notifications and password reset |
| **Groups** | Assign the user to one or more groups |
| **Quota** | Storage quota (e.g. `5 GB`) or **Default quota** |

4. Click **Add new user**.

### Create a User via CLI

```bash
sudo -u www-data php /var/www/nextcloud/occ user:add \
  --display-name="Jane Doe" \
  --group="researchers" \
  jdoe
# You will be prompted for the password
```

---

## Managing Groups

Groups let you manage permissions, sharing, and quotas for sets of users.

### Create a Group

1. Go to **Settings > Users**.
2. Click **Add group** in the left sidebar.
3. Enter a group name and press Enter.

### Assign a User to a Group

- From the user list: click the **Groups** cell for a user and add the group name.
- Via CLI:

```bash
sudo -u www-data php /var/www/nextcloud/occ group:adduser researchers jdoe
```

### List Group Members

```bash
sudo -u www-data php /var/www/nextcloud/occ group:listmembers researchers
```

---

## Setting Storage Quotas

### Set a Default Quota for All Users

1. Go to **Settings > Administration > User authentication**.
2. Set the **Default quota** field (e.g. `10 GB`).

### Set a Per-User Quota

1. Go to **Settings > Users**.
2. Find the user and click the **Quota** column.
3. Enter the quota value (e.g. `5 GB`) and press Enter.

### Set Quota via CLI

```bash
sudo -u www-data php /var/www/nextcloud/occ user:setting jdoe files quota "5 GB"
```

---

## Bulk User Import via CSV

For university or enterprise environments, you can import users from a CSV file
using the **User CSV Import** app (install it first from **Settings > Apps**).

CSV format:

```csv
userid,display_name,email,groups,quota,password
jdoe,Jane Doe,jdoe@example.com,researchers|students,5 GB,ChangeMe123!
asmith,Alice Smith,asmith@example.com,staff,10 GB,ChangeMe123!
```

Import command (if the app provides CLI support):

```bash
sudo -u www-data php /var/www/nextcloud/occ user:import /path/to/users.csv
```

> **Note:** Passwords in CSV files are temporary. Require users to change their password
> on first login via **Settings > Administration > Security**.

---

## Resetting a User Password

### Via Web Interface

1. Go to **Settings > Users**.
2. Click the **three-dot menu** next to the user.
3. Select **Edit user** and update the password.

### Via CLI

```bash
sudo -u www-data php /var/www/nextcloud/occ user:resetpassword jdoe
```

---

## Disabling and Deleting Users

### Disable a User (preserves data)

```bash
sudo -u www-data php /var/www/nextcloud/occ user:disable jdoe
```

### Enable a Disabled User

```bash
sudo -u www-data php /var/www/nextcloud/occ user:enable jdoe
```

### Delete a User

```bash
sudo -u www-data php /var/www/nextcloud/occ user:delete jdoe
```

> **Warning:** Deleting a user permanently removes their data. Consider disabling the user instead.

---

## Next Steps

| Next | Page |
|------|------|
| Manage installed apps | [[Managing-Apps]] |
| Troubleshoot issues | [[Troubleshooting]] |
| Get support | [[Support]] |
