# Deploying from Azure Marketplace

> 🇫🇷 Cette page est également disponible en français : [[fr-Deploying-from-Marketplace]]

This page walks you through deploying the **Cotechnoe Cloud Hub** VM from Azure Marketplace,
from finding the offer to a running virtual machine in your Azure subscription.

---

## Prerequisites

- An active Azure subscription with permission to create virtual machines.
- A resource group (existing or new) in the Azure region of your choice.
- A domain name you can point to the VM's public IP address (needed later for HTTPS).

---

## Step 1 — Find the Offer on Azure Marketplace

1. Open [Azure Marketplace](https://azuremarketplace.microsoft.com/en-US/marketplace/apps/cotechnoe.nextcloud-hub).
2. Search for **"Cotechnoe Cloud Hub"**.
3. Select the offer and click **Get It Now**.
4. You are redirected to the Azure portal to create the VM.

---

## Step 2 — Configure the Virtual Machine

In the Azure portal **Create a virtual machine** wizard, fill in the following tabs:

### Basics

| Field | Recommended value |
|-------|-------------------|
| **Subscription** | Your subscription |
| **Resource group** | Create new or use existing |
| **Virtual machine name** | e.g. `nextcloud-prod` |
| **Region** | Nearest to your users |
| **Image** | Cotechnoe Cloud Hub (pre-selected) |
| **Size** | See [VM Sizing Guide](https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/blob/main/docs/vm-sizing-guide.md) |
| **Authentication type** | SSH public key (recommended) |
| **Username** | `azureuser` (default) |
| **SSH public key** | Paste your public key |

### Disks

- **OS disk type:** Premium SSD (recommended for production)
- **Data disk:** Add a managed data disk of at least 64 GB for Nextcloud data storage (recommended)

### Networking

| Field | Recommended value |
|-------|-------------------|
| **Virtual network** | Create new or use existing |
| **Public IP** | Create a **Static** public IP address |
| **NIC network security group** | Basic |
| **Public inbound ports** | Allow selected: **SSH (22), HTTP (80), HTTPS (443)** |

> **Important:** Use a **Static** public IP so your domain name keeps pointing to the same
> address after VM restarts.

### Management

- Enable **Auto-shutdown** if this is a non-production deployment to control costs.

### Advanced

> **⚠️ This step is required.** The VM runs a one-time first-boot setup that reads credentials written by cloud-init. If the **Custom data** field is left empty, the `nextcloud-first-boot` service will fail and Nextcloud will not be installed.

In the **Custom data** field, paste the following cloud-init configuration and replace all placeholder values with your own:

```yaml
#cloud-config
write_files:
  - path: /etc/nextcloud/config.env
    owner: root:root
    permissions: "0600"
    content: |
      NC_ADMIN_USER=ncadmin
      NC_ADMIN_PASSWORD=YourStrongPassword123!
      NC_DB_PASSWORD=AnotherStrongPassword456!
      REDIS_PASSWORD=RedisPassword789!
```

| Variable | Description | Requirements |
|----------|-------------|--------------|
| `NC_ADMIN_USER` | Nextcloud web administrator username | Alphanumeric, no spaces |
| `NC_ADMIN_PASSWORD` | Nextcloud web administrator password | Min. 12 characters |
| `NC_DB_PASSWORD` | PostgreSQL password for the `nextcloud` database user | Min. 12 characters |
| `REDIS_PASSWORD` | Redis authentication password | Min. 12 characters |

> **Notes:**
> - The `#cloud-config` header on the **first line** is mandatory — do not omit it.
> - `NC_ADMIN_USER` / `NC_ADMIN_PASSWORD` are your **Nextcloud** web admin credentials, not the Azure VM SSH user.
> - `config.env` is automatically shredded by `nc-first-boot.sh` once first-boot completes — it does not persist on the VM.
> - The first-boot service starts automatically after cloud-init writes this file — no manual action is required.

### Tags

Add any resource tags required by your organization (optional).

---

## Step 3 — Review and Create

1. Click **Review + create**.
2. Review the validation summary — ensure no errors are shown.
3. Click **Create**.
4. Azure provisions the VM — this typically takes 3–5 minutes.

---

## Verify

When deployment completes:

1. Go to **Virtual machines** in the Azure portal.
2. Find your VM and confirm **Status: Running**.
3. Copy the **Public IP address** — you will need it in the next steps.

---

## Next Steps

| Next | Page |
|------|------|
| Connect via SSH | [[SSH-Connection]] |
| Point your domain to the VM | [[HTTPS-TLS-Certificate]] |

---

## Troubleshooting

**Deployment failed with "Quota exceeded"**  
Request a quota increase for the desired VM SKU in your subscription region.
See [Azure quota limits](https://learn.microsoft.com/en-us/azure/quotas/view-quotas).

**The VM is stuck in "Creating" for more than 15 minutes**  
Cancel the deployment, check the activity log for error details, and retry.

**SSH (port 22) is blocked**  
Verify that the Network Security Group allows inbound TCP port 22.
See [[SSH-Connection]] for details.
