# Screenshots Guide — Azure Marketplace

> Azure Marketplace requires screenshots at **1280×720 px** (16:9), PNG or JPEG format.
> A minimum of 1 screenshot is required; up to 5 are recommended.

---

## Required Screenshots

### Screenshot 1 — Web Interface (Login Page + Dashboard)

**File name:** `screenshot-01-dashboard.png`
**Resolution:** 1280×720 px
**Content:**
- Show the Nextcloud login page OR the main Files view after login.
- The browser address bar should display `https://` (HTTPS confirmed).
- The UI language should be English.

**Suggested setup:**
1. Open `https://your-domain` in a browser at 1280×720 viewport.
2. Log in as admin.
3. Navigate to the Files view.
4. Take a full-page screenshot.

---

### Screenshot 2 — Admin Dashboard

**File name:** `screenshot-02-admin-dashboard.png`
**Resolution:** 1280×720 px
**Content:**
- Show the Nextcloud Administration overview page (`/settings/admin/overview`).
- Confirm all green checkmarks (no security warnings).
- The browser address bar should display `https://`.

**Suggested setup:**
1. Log in as admin.
2. Go to **Settings > Administration > Overview**.
3. Scroll to show the Security & Setup Warnings section with all items resolved.
4. Take a screenshot.

---

### Screenshot 3 — HTTPS Certificate

**File name:** `screenshot-03-https-certificate.png`
**Resolution:** 1280×720 px
**Content:**
- Show the browser padlock / certificate details for the Nextcloud HTTPS endpoint.
- Show the certificate is issued by **Let's Encrypt** or another trusted CA.

**Suggested setup:**
1. Click the padlock icon in the browser address bar.
2. Click "Certificate is valid" or "More information".
3. Take a screenshot showing the issuer (Let's Encrypt) and validity dates.

---

### Screenshot 4 — Collaborative Editing (Optional)

**File name:** `screenshot-04-collabora-editing.png`
**Resolution:** 1280×720 px
**Content:**
- Show a document open in Collabora Online Built-in CODE.
- Demonstrates the office suite integration.

---

### Screenshot 5 — Mobile / User Experience (Optional)

**File name:** `screenshot-05-mobile-files.png`
**Resolution:** 1280×720 px
**Content:**
- Show the responsive web interface on a simulated mobile viewport.
- OR show the Nextcloud Files app on a mobile device.

---

## Azure Marketplace Image Specifications

| Requirement | Value |
|-------------|-------|
| Minimum resolution | 1280×720 px |
| Maximum file size | 4 MB per image |
| Accepted formats | PNG, JPEG |
| Minimum screenshots | 1 |
| Maximum screenshots | 5 |
| Safe zone | Keep key content 40px from edges |

---

## Tools for Screenshots

- **Browser:** Chrome or Edge with DevTools (set viewport to 1280×720)
- **Capture:** OS screenshot tool, Flameshot (Linux), or Snagit
- **Resize/crop:** GIMP, ImageMagick: `convert input.png -resize 1280x720! output.png`

---

## Checklist Before Upload

- [ ] Resolution is exactly 1280×720 px
- [ ] HTTPS visible in address bar (screenshots 1–3)
- [ ] No personal or test data visible
- [ ] No debug banners or error messages visible
- [ ] Screenshots represent the production-ready state
- [ ] File size under 4 MB each
