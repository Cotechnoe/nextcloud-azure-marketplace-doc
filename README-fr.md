# Cotechnoe Cloud Hub — Collaboration de fichiers sécurisée sur Azure

[![Azure Marketplace](https://img.shields.io/badge/Azure%20Marketplace-Cotechnoe%20Cloud%20Hub-blue?logo=microsoftazure)](https://azuremarketplace.microsoft.com/fr-FR/marketplace/apps/cotechnoe.nextcloud-hub?ocid=nc_github_readme&utm_source=github&utm_medium=referral&utm_campaign=docs)
[![Licence : CC BY 4.0](https://img.shields.io/badge/Licence-CC%20BY%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

> 🇬🇧 This page is also available in English: [README.md](README.md)

Ce dépôt contient la documentation utilisateur de la machine virtuelle **Cotechnoe Cloud Hub** sur Azure Marketplace — une plateforme de collaboration de fichiers auto-hébergée et sécurisée basée sur [Nextcloud](https://nextcloud.com), destinée aux universités et centres de recherche.

## Démarrage rapide

1. **Déployer** la VM depuis [Azure Marketplace](https://azuremarketplace.microsoft.com/fr-FR/marketplace/apps/cotechnoe.nextcloud-hub?ocid=nc_github_readme&utm_source=github&utm_medium=referral&utm_campaign=docs) — environ 5 minutes.
2. **Connecter** un nom de domaine à l'adresse IP publique de la VM et se connecter en SSH.
3. **Ouvrir** `https://votre-domaine.exemple.com` — votre instance Nextcloud est prête à configurer.

Les instructions complètes, étape par étape, sont disponibles dans le [wiki](../../wiki).

---

## Documentation

| Sujet | EN | FR |
|-------|----|----|
| **Accueil — Présentation et navigation** | [Home](../../wiki/Home) | [Home-fr](../../wiki/Home-fr) |
| **Déploiement depuis Marketplace** | [Deploying-from-Marketplace](../../wiki/Deploying-from-Marketplace) | [Deploying-from-Marketplace-fr](../../wiki/Deploying-from-Marketplace-fr) |
| **Connexion SSH** | [SSH-Connection](../../wiki/SSH-Connection) | [SSH-Connection-fr](../../wiki/SSH-Connection-fr) |
| **Vérification post-déploiement** | [Post-Deployment-Verification](../../wiki/Post-Deployment-Verification) | [Post-Deployment-Verification-fr](../../wiki/Post-Deployment-Verification-fr) |
| **Certificat HTTPS / TLS** | [HTTPS-TLS-Certificate](../../wiki/HTTPS-TLS-Certificate) | [HTTPS-TLS-Certificate-fr](../../wiki/HTTPS-TLS-Certificate-fr) |
| **Configuration de Nextcloud** | [Configuring-Nextcloud](../../wiki/Configuring-Nextcloud) | [Configuring-Nextcloud-fr](../../wiki/Configuring-Nextcloud-fr) |
| **Mise à jour de Nextcloud** | [Updating-Nextcloud](../../wiki/Updating-Nextcloud) | [Updating-Nextcloud-fr](../../wiki/Updating-Nextcloud-fr) |
| **Explorer Nextcloud** | [Exploring-Nextcloud](../../wiki/Exploring-Nextcloud) | [Exploring-Nextcloud-fr](../../wiki/Exploring-Nextcloud-fr) |
| **Charger des données d'exemple** | [Loading-Sample-Data](../../wiki/Loading-Sample-Data) | [Loading-Sample-Data-fr](../../wiki/Loading-Sample-Data-fr) |
| **Résolution de problèmes** | [Troubleshooting](../../wiki/Troubleshooting) | [Troubleshooting-fr](../../wiki/Troubleshooting-fr) |
| **Support** | [Support](../../wiki/Support) | [Support-fr](../../wiki/Support-fr) |
| **Gestion des utilisateurs** | [Managing-Users](../../wiki/Managing-Users) | [Managing-Users-fr](../../wiki/Managing-Users-fr) |
| **Gestion des applications** | [Managing-Apps](../../wiki/Managing-Apps) | [Managing-Apps-fr](../../wiki/Managing-Apps-fr) |
| **Guide de dimensionnement VM** | [vm-sizing-guide](docs/vm-sizing-guide.md) | [vm-sizing-guide-fr](docs/vm-sizing-guide-fr.md) |
| **Guide des applications Nextcloud** | [nextcloud-apps-guide](docs/nextcloud-apps-guide.md) | [nextcloud-apps-guide-fr](docs/nextcloud-apps-guide-fr.md) |
| **Sauvegarde et restauration** | [backup-restore](docs/backup-restore.md) | [backup-restore-fr](docs/backup-restore-fr.md) |
| **SSO Entra ID** | [entra-id-sso](docs/entra-id-sso.md) | [entra-id-sso-fr](docs/entra-id-sso-fr.md) |
| **Supervision** | [monitoring](docs/monitoring.md) | [monitoring-fr](docs/monitoring-fr.md) |
| **Sécurité réseau** | [network-security](docs/network-security.md) | [network-security-fr](docs/network-security-fr.md) |

---

## À propos de cette VM

La VM **Cotechnoe Cloud Hub** déploie une plateforme de collaboration entièrement configurée et auto-hébergée sur une seule machine virtuelle Azure :

| Service | Rôle |
|---------|------|
| **Nginx** | Proxy inverse + terminaison TLS |
| **PHP-FPM 8.1+** | Environnement d'exécution de l'application |
| **MariaDB** | Base de données intégrée |
| **Redis** | Cache de sessions et verrouillage des fichiers |
| **Certbot** | Gestion automatique des certificats Let's Encrypt |

La pile logicielle est basée sur [Nextcloud Hub](https://nextcloud.com), distribué sous licence [AGPL-3.0](https://www.gnu.org/licenses/agpl-3.0.html). Voir [NOTICE.md](NOTICE.md) pour les informations d'attribution.

---

## Support

- **GitHub Issues :** [Ouvrir un ticket](https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/issues)
- **Forum communautaire Nextcloud :** [help.nextcloud.com](https://help.nextcloud.com)
- **Support Azure :** [portal.azure.com](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade)

---

## Licence

La documentation dans ce dépôt est distribuée sous licence [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).  
Le logiciel Nextcloud est distribué sous licence [AGPL-3.0](https://www.gnu.org/licenses/agpl-3.0.html).  
Voir [NOTICE.md](NOTICE.md) et [LICENSE.md](LICENSE.md) pour les détails.
