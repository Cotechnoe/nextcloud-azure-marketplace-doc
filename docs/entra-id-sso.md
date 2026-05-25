# Entra ID SSO Integration

> 🇫🇷 Cette page est également disponible en français : [Intégration SSO Entra ID](entra-id-sso-fr.md)

This guide explains how to configure Single Sign-On (SSO) between Microsoft Entra ID
(formerly Azure Active Directory) and your Nextcloud instance, using the SAML 2.0 protocol.

---

## Overview

| Item | Value |
|------|-------|
| Protocol | SAML 2.0 |
| Nextcloud app | `user_saml` |
| Identity Provider | Microsoft Entra ID |
| Minimum Nextcloud version | 25+ |

---

## Prerequisites

- Nextcloud is accessible over HTTPS (see [[HTTPS-TLS-Certificate]])
- You have **Global Administrator** or **Application Administrator** role in Entra ID
- The `user_saml` app is available from the Nextcloud App Store

---

## Step 1 — Install the SSO & SAML Authentication App

```bash
sudo -u www-data php /var/www/nextcloud/occ app:install user_saml
```

---

## Step 2 — Register Nextcloud in Entra ID

1. Open the [Azure Portal](https://portal.azure.com) and go to
   **Microsoft Entra ID > Enterprise Applications**.
2. Click **+ New application > Create your own application**.
3. Name it (e.g., `Nextcloud`) and select **Integrate any other application you don't find in the gallery (Non-gallery)**.
4. Click **Create**.

### Configure SAML

5. In the new application, go to **Single sign-on > SAML**.
6. Under **Basic SAML Configuration**, set:
   - **Identifier (Entity ID):** `https://cloud.example.com/apps/user_saml/saml/metadata`
   - **Reply URL (Assertion Consumer Service URL):** `https://cloud.example.com/apps/user_saml/saml/acs`
   - **Sign on URL:** `https://cloud.example.com/login`

7. Under **Attributes & Claims**, ensure the following attribute is mapped:
   - `user.userprincipalname` → `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier`

8. Download the **Federation Metadata XML** file.

---

## Step 3 — Configure Nextcloud SSO

1. In Nextcloud, go to **Settings > Administration > SSO & SAML authentication**.
2. Select **Use built-in SAML authentication**.
3. Under **Identity Provider Data**, click **Import Identity Provider Metadata** and upload
   the Federation Metadata XML downloaded from Entra ID.

4. Set the **Attribute to map the UID to:** `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier`

5. (Optional) Map display name and email:
   - **Display name:** `http://schemas.microsoft.com/identity/claims/displayname`
   - **Email:** `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress`

6. Click **Save**.

---

## Step 4 — Assign Users in Entra ID

1. In the Entra ID Enterprise Application, go to **Users and groups**.
2. Click **+ Add user/group**.
3. Assign the users or groups that should have access to Nextcloud.

---

## Step 5 — Test the Integration

1. Open a private/incognito browser window.
2. Navigate to `https://cloud.example.com/login`.
3. Click **Log in with SSO**.
4. You should be redirected to the Microsoft login page.
5. After authentication, you should be redirected back and logged in to Nextcloud.

---

## Provisioning Users (Optional — SCIM)

For automatic user provisioning, Nextcloud supports SCIM via the `user_scim` app.
This keeps Nextcloud users synchronized with Entra ID groups automatically.

```bash
sudo -u www-data php /var/www/nextcloud/occ app:install user_scim
```

Configure the SCIM endpoint in Entra ID under
**Enterprise Application > Provisioning > SCIM**.

---

## Troubleshooting

| Problem | Likely Cause | Solution |
|---------|-------------|----------|
| "Not allowed to login" error | User not assigned in Entra ID | Assign user in Enterprise Application > Users and groups |
| Redirect loop on login | Wrong ACS URL in Entra ID | Verify Reply URL matches exactly |
| "Signature verification failed" | Clock skew between VM and Entra ID | Sync VM clock: `sudo timedatectl set-ntp true` |
| Users can't find files after SSO | UID mapping mismatch | Verify UID attribute maps to the same value as existing local usernames |

---

## Related Guides

- [Managing Users](../wiki/Managing-Users.md) — Manage local users alongside SSO users
- [Managing Apps](../wiki/Managing-Apps.md) — App installation procedures
- [Network Security](network-security.md) — Ensure firewall allows HTTPS for SAML flows
