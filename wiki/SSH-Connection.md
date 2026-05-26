# SSH Connection

> 🇫🇷 Cette page est également disponible en français : [[fr-SSH-Connection]]

This page explains how to connect to your Cotechnoe Cloud Hub VM using SSH so you can
manage the server and run administrative commands.

---

## Prerequisites

- The VM is **Running** in the Azure portal.
- You have the **public IP address** of the VM.
- You have the **SSH private key** that matches the public key used during deployment.

---

## Step 1 — Find the VM Public IP Address

1. In the [Azure portal](https://portal.azure.com), navigate to **Virtual machines**.
2. Click on your VM.
3. On the **Overview** tab, copy the **Public IP address**.

---

## Step 2 — Connect via SSH

### Linux / macOS / Windows (PowerShell or WSL)

Open a terminal and run:

```bash
ssh azureuser@<PUBLIC_IP_ADDRESS>
```

Replace `<PUBLIC_IP_ADDRESS>` with the IP copied in the previous step.

**Example:**

```bash
ssh azureuser@20.42.100.200
```

If your private key is not in the default location (`~/.ssh/id_rsa`), specify it with `-i`:

```bash
ssh -i /path/to/your/private-key.pem azureuser@<PUBLIC_IP_ADDRESS>
```

### Windows (PuTTY)

1. Download and install [PuTTY](https://www.putty.org/).
2. In PuTTY, set **Host Name** to the VM public IP address.
3. Under **Connection > SSH > Auth > Credentials**, browse to your `.ppk` private key file.
4. Click **Open**.

---

## Step 3 — Accept the Host Key

On first connection, SSH prompts you to verify the host fingerprint:

```
The authenticity of host '20.42.100.200 (20.42.100.200)' can't be established.
ED25519 key fingerprint is SHA256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

Type `yes` and press Enter. The fingerprint is saved to `~/.ssh/known_hosts`.

---

## Verify

After connecting, you should see a welcome message and a shell prompt:

```
Welcome to Ubuntu 24.04.x LTS (GNU/Linux ...)
...
azureuser@nextcloud-prod:~$
```

You are now connected to the VM and can run administrative commands.

---

## Troubleshooting

**`Permission denied (publickey)`**  
- Verify that the correct private key is specified with `-i`.
- Ensure the private key file permissions are restricted: `chmod 600 /path/to/key.pem`.

**`Connection refused` or `Connection timed out`**  
- Check that port **22** is allowed in the VM's Network Security Group (NSG).  
  In the Azure portal: **VM > Networking > Inbound port rules** — confirm an allow rule for port 22.

**`ssh: connect to host ... port 22: No route to host`**  
- Confirm the VM is in **Running** state in the Azure portal.
- Verify the public IP address is correct.

---

## Next Steps

| Next | Page |
|------|------|
| Verify all services are running | [[Post-Deployment-Verification]] |
| Set up HTTPS certificate | [[HTTPS-TLS-Certificate]] |
