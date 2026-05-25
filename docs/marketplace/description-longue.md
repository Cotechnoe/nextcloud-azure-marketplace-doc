# Long Description — Azure Marketplace

> This file contains the long description (≤3000 characters) for the Azure Marketplace listing.
> Per ADR 803, "Nextcloud" must NOT appear in the offer title but may appear in the description.

---

## English (canonical)

```
Cotechnoe Cloud Hub — Secure File Collaboration on Azure

Deploy a fully self-hosted file sharing and collaboration platform on your own Azure infrastructure, powered by Nextcloud — the leading open-source file sync and share solution trusted by universities, research institutions, healthcare organizations, and enterprises worldwide.

**Key Features**

• Self-hosted on Azure: Your data stays in your Azure subscription. No third-party cloud storage.
• HTTPS included: Automated Let's Encrypt TLS certificate provisioning via Certbot.
• Single Sign-On ready: Native SAML 2.0 / OIDC integration with Microsoft Entra ID (Azure Active Directory).
• Collaboration apps: Built-in document editing with Collabora Online, video conferencing with Talk, calendars (CalDAV), and contacts (CardDAV).
• Automated updates: The Nextcloud built-in updater keeps your instance current with security patches.
• Performance-tuned stack: Nginx + PHP-FPM 8.1+ + MariaDB + Redis — optimized for Azure VM SKUs.
• Secure by default: NSG pre-configured for HTTPS/SSH only. SSH key-pair authentication required.

**Who Is This For?**

• Educational institutions and research labs needing GDPR-compliant data sovereignty
• Healthcare organizations requiring data residency within Azure regions
• Enterprises replacing public cloud storage (OneDrive, Google Drive, Dropbox) with a private alternative
• SMBs and startups wanting a full collaboration platform without per-user SaaS fees

**Quick Start**

1. Deploy the VM from Azure Marketplace.
2. Connect via SSH and run the post-deployment wizard.
3. Point your domain DNS to the VM public IP.
4. HTTPS is configured automatically with Let's Encrypt.
5. Access your Nextcloud instance at https://your-domain.

**Support**

Full documentation, troubleshooting guides, and support resources are available in the GitHub Wiki. Community and commercial support options are described in the Support page.

Nextcloud is a registered trademark of Nextcloud GmbH, Stuttgart, Germany. This offer is published by Cotechnoe and is not affiliated with or endorsed by Nextcloud GmbH.
```

**Character count:** ~1850 / 3000 ✅

---

## Français

```
Cotechnoe Cloud Hub — Collaboration de fichiers sécurisée sur Azure

Déployez une plateforme de partage de fichiers et de collaboration entièrement auto-hébergée sur votre propre infrastructure Azure, propulsée par Nextcloud — la solution open source de synchronisation et partage de fichiers de référence, utilisée par des universités, institutions de recherche, organisations de santé et entreprises du monde entier.

**Fonctionnalités clés**

• Auto-hébergé sur Azure : Vos données restent dans votre abonnement Azure. Pas de stockage cloud tiers.
• HTTPS inclus : Provisionnement automatique du certificat TLS Let's Encrypt via Certbot.
• SSO prêt à l'emploi : Intégration SAML 2.0 / OIDC native avec Microsoft Entra ID (Azure Active Directory).
• Applications de collaboration : Édition de documents intégrée avec Collabora Online, vidéoconférence avec Talk, calendriers (CalDAV) et contacts (CardDAV).
• Mises à jour automatisées : Le programme de mise à jour intégré de Nextcloud maintient votre instance à jour avec les correctifs de sécurité.
• Pile optimisée : Nginx + PHP-FPM 8.1+ + MariaDB + Redis — optimisé pour les SKUs VM Azure.
• Sécurisé par défaut : NSG préconfiguré pour HTTPS/SSH uniquement. Authentification par paire de clés SSH requise.

**Pour qui ?**

• Établissements d'enseignement et laboratoires de recherche nécessitant la souveraineté des données conforme au RGPD
• Organisations de santé nécessitant la résidence des données dans les régions Azure
• Entreprises remplaçant le stockage cloud public (OneDrive, Google Drive, Dropbox) par une alternative privée
• PME et startups souhaitant une plateforme de collaboration complète sans frais SaaS par utilisateur

Nextcloud est une marque déposée de Nextcloud GmbH, Stuttgart, Allemagne. Cette offre est publiée par Cotechnoe et n'est pas affiliée à Nextcloud GmbH.
```

**Nombre de caractères :** ~1700 / 3000 ✅
