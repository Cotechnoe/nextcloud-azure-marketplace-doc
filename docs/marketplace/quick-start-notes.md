# Quick Start Notes — Azure Marketplace

> This file contains the Quick Start notes (≤500 characters) displayed during ARM deployment
> in the Azure portal "Get started" panel.

---

## English (canonical)

```
After deployment:
1. Wait 10-15 min for automatic setup (cloud-init)
2. Configure DNS: point your domain to VM public IP
3. Setup TLS certificate (SSH to VM, see wiki docs)
4. Access Nextcloud at https://your-domain
Full guide: https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/wiki
```

**Character count:** 257 / 500 ✅

---

## Français

```
Après déploiement :
1. Attendre 10-15 min pour la configuration automatique (cloud-init)
2. DNS : pointez votre domaine vers l'IP publique de la VM
3. Configurer le certificat TLS (SSH vers la VM, voir wiki)
4. Accéder à Nextcloud : https://votre-domaine
Guide complet : https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/wiki
```

**Nombre de caractères :** 298 / 500 ✅

---

## Usage Notes

- The Quick Start notes appear in the Azure portal during or after ARM deployment.
- Keep these short and action-oriented — customers see this immediately after provisioning.
- Replace `setup.sh` with the actual post-deployment script name if it differs.
