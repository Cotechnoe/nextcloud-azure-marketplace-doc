# Cotechnoe Cloud Hub — Accueil Documentation

> 🇬🇧 This page is also available in English: [[Home]]

Bienvenue dans le wiki de documentation de **Cotechnoe Cloud Hub**. Cette page est la référence centrale pour les administrateurs ayant déployé la VM de collaboration basée sur Nextcloud depuis Azure Marketplace.

[![Azure Marketplace](https://img.shields.io/badge/Azure%20Marketplace-D%C3%A9ployer-blue?logo=microsoftazure)](https://azuremarketplace.microsoft.com/fr-FR/marketplace/apps/cotechnoe.nextcloud-hub?ocid=nc_wiki_home&utm_source=wiki&utm_medium=referral&utm_campaign=docs)

---

## Démarrage

Suivez ces pages **dans l'ordre** pour un nouveau déploiement :

| Étape | Page | Durée estimée |
|-------|------|--------------|
| 1 | [[Deploying-from-Marketplace-fr]] | 5 min |
| 2 | [[SSH-Connection-fr]] | 5 min |
| 3 | [[Post-Deployment-Verification-fr]] | 10 min |
| 4 | [[HTTPS-TLS-Certificate-fr]] | 15 min |
| 5 | [[Configuring-Nextcloud-fr]] | 20 min |

---

## Administration courante

| Tâche | Page |
|-------|------|
| Mettre à jour Nextcloud | [[Updating-Nextcloud-fr]] |
| Explorer l'interface web | [[Exploring-Nextcloud-fr]] |
| Charger des données de test | [[Loading-Sample-Data-fr]] |
| Gérer les comptes utilisateurs | [[Managing-Users-fr]] |
| Installer et gérer les applications | [[Managing-Apps-fr]] |

---

## Guides techniques

| Guide | Description |
|-------|-------------|
| [Guide de dimensionnement VM](https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/blob/main/docs/vm-sizing-guide-fr.md) | Choisir le bon SKU selon le nombre d'utilisateurs |
| [Sauvegarde & Restauration](https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/blob/main/docs/backup-restore-fr.md) | Stratégie de sauvegarde et procédures de récupération |
| [SSO Entra ID](https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/blob/main/docs/entra-id-sso-fr.md) | Authentification unique via Microsoft Entra ID |
| [Supervision](https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/blob/main/docs/monitoring-fr.md) | Azure Monitor, alertes, analyse des journaux |
| [Sécurité réseau](https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/blob/main/docs/network-security-fr.md) | Règles NSG, fail2ban, durcissement SSH |
| [Guide des applications Nextcloud](https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/blob/main/docs/nextcloud-apps-guide-fr.md) | Collabora Online, Talk, Calendrier, Contacts |

---

## Aide et support

- [[Troubleshooting-fr]] — Problèmes courants post-déploiement et solutions
- [[Support-fr]] — Où obtenir de l'aide

---

## Langues disponibles

Toutes les pages sont disponibles en anglais (version canonique) et en français (traduction).

| English | Français |
|---------|---------|
| [[Home]] | [[Home-fr]] |
| [[Deploying-from-Marketplace]] | [[Deploying-from-Marketplace-fr]] |
| [[SSH-Connection]] | [[SSH-Connection-fr]] |
| [[Post-Deployment-Verification]] | [[Post-Deployment-Verification-fr]] |
| [[HTTPS-TLS-Certificate]] | [[HTTPS-TLS-Certificate-fr]] |
| [[Configuring-Nextcloud]] | [[Configuring-Nextcloud-fr]] |
| [[Updating-Nextcloud]] | [[Updating-Nextcloud-fr]] |
| [[Exploring-Nextcloud]] | [[Exploring-Nextcloud-fr]] |
| [[Loading-Sample-Data]] | [[Loading-Sample-Data-fr]] |
| [[Troubleshooting]] | [[Troubleshooting-fr]] |
| [[Support]] | [[Support-fr]] |
| [[Managing-Users]] | [[Managing-Users-fr]] |
| [[Managing-Apps]] | [[Managing-Apps-fr]] |

---

## À propos de cette VM

La VM Cotechnoe Cloud Hub exécute les services suivants sur une seule machine virtuelle Azure :

- **Nginx** — proxy inverse avec terminaison TLS
- **PHP-FPM 8.1+** — environnement d'exécution de l'application
- **MariaDB** — base de données
- **Redis** — cache de sessions et verrouillage des fichiers
- **Certbot** — gestion automatique des certificats Let's Encrypt

La VM est basée sur [Nextcloud Hub](https://nextcloud.com), marque déposée de Nextcloud GmbH.  
Voir le fichier [NOTICE](https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/blob/main/NOTICE.md) pour les informations d'attribution.
