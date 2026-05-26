# Cotechnoe Cloud Hub — Documentation Azure Marketplace

> 🇬🇧 This page is also available in English: [[Home]]

Bienvenue dans la documentation officielle de **Cotechnoe Cloud Hub — Collaboration de fichiers sécurisée sur Azure**, déployé via le Microsoft Azure Marketplace.

Cotechnoe Cloud Hub est une instance [Nextcloud Hub](https://nextcloud.com) prête pour la production, fonctionnant sur Ubuntu 24.04 LTS avec Nginx, PHP-FPM 8.3, PostgreSQL 16 et Redis — entièrement préconfigurée et opérationnelle après le déploiement.

## Démarrage rapide

Cotechnoe Cloud Hub est disponible directement depuis le [Microsoft Azure Marketplace](https://azuremarketplace.microsoft.com/). Une fois déployé, suivez ces étapes :

| # | Tâche | Page du wiki |
|---|-------|--------------|
| 1 | Déployer la VM et remplir les paramètres de configuration | [[fr_Deploying-from-Marketplace\|Déployer depuis le Marketplace]] |
| 2 | Se connecter à la VM via SSH | [[fr_SSH-Connection\|Connexion SSH]] |
| 3 | Vérifier que tous les services sont en cours d'exécution | [[fr_Post-Deployment-Verification\|Vérification post-déploiement]] |
| 4 | Confirmer que le certificat HTTPS est actif | [[fr_HTTPS-TLS-Certificate\|Certificat HTTPS / TLS]] |
| 5 | Configurer les paramètres Nextcloud | [[fr_Configuring-Nextcloud\|Configurer Nextcloud]] |
| 6 | Charger des données d'exemple pour explorer les fonctionnalités | [[fr_Loading-Sample-Data\|Chargement des données d'exemple]] |
| 7 | Explorer l'interface Nextcloud | [[fr_Exploring-Nextcloud\|Explorer Nextcloud]] |
| 8 | Résoudre les problèmes courants | [[fr_Troubleshooting\|Dépannage]] |

## Vue d'ensemble de l'architecture

```
Internet (HTTPS 443 / HTTP 80)
        │
     Nginx  ──  proxy inverse + certificat TLS Let's Encrypt (provisionné automatiquement)
        │
     PHP-FPM 8.3
        │
     Nextcloud Hub 33  (/var/www/nextcloud)
        │
        ├── PostgreSQL 16  ──  base de données (127.0.0.1:5432)
        │
        ├── Redis  ──  cache de session + verrouillage de fichiers (127.0.0.1:6379)
        │
        └── /var/nextcloud-data  ──  disque de données géré Azure (fichiers utilisateurs, journaux)
```

> **Sécurité :** PostgreSQL (port 5432) et Redis (port 6379) sont liés à `127.0.0.1` uniquement. Ports accessibles publiquement : 80 (HTTP → redirection HTTPS), 443 (HTTPS) et 22 (SSH, restreint par règle NSG à `sshSourceIP`).

## Paramètres de déploiement

| Paramètre | Description | Valeur par défaut / Exemple |
|-----------|-------------|--------------------------|
| `adminUsername` | Nom d'utilisateur administrateur SSH de la VM | `azureuser` |
| `adminPublicKey` | Clé publique SSH (format OpenSSH, ed25519 ou RSA 4096) | `ssh-ed25519 AAAA...` |
| `vmSize` | Taille de la VM Azure | `Standard_D4s_v3` |
| `dataDiskSizeGB` | Taille du disque de données pour `/var/nextcloud-data` (Go) | `128` |
| `sshSourceIP` | CIDR autorisé pour l'accès SSH | `203.0.113.0/32` ou `*` |
| `nextcloudAdminUser` | Nom d'utilisateur administrateur Nextcloud | `ncadmin` |
| `nextcloudAdminPassword` | Mot de passe administrateur Nextcloud (min. 12 caractères) | — |
| `nextcloudDomain` | Nom de domaine pour le FQDN de la VM et le certificat TLS | `cloudapp.azure.com` |

## Pages du wiki

- [[fr_Deploying-from-Marketplace\|Déployer depuis le Marketplace]] — Déployer depuis Azure Marketplace et remplir les paramètres de configuration
- [[fr_SSH-Connection\|Connexion SSH]] — Se connecter à la VM avec une clé PEM
- [[fr_Post-Deployment-Verification\|Vérification post-déploiement]] — Valider que tous les services fonctionnent correctement
- [[fr_HTTPS-TLS-Certificate\|Certificat HTTPS / TLS]] — Provisionnement du certificat TLS, Let's Encrypt, renouvellement et certificats personnalisés
- [[fr_Configuring-Nextcloud\|Configurer Nextcloud]] — Configurer le courriel, les domaines de confiance et autres paramètres Nextcloud
- [[fr_Updating-Nextcloud\|Mettre à jour Nextcloud]] — Mettre à jour Nextcloud vers une version plus récente en toute sécurité
- [[fr_Managing-Users\|Gérer les utilisateurs]] — Créer et gérer les comptes utilisateurs et les groupes
- [[fr_Managing-Apps\|Gérer les applications]] — Installer et gérer les applications Nextcloud
- [[fr_Loading-Sample-Data\|Chargement des données d'exemple]] — Charger des fichiers d'exemple pour explorer l'interface
- [[fr_Exploring-Nextcloud\|Explorer Nextcloud]] — Naviguer dans l'interface web Nextcloud
- [[fr_Troubleshooting\|Dépannage]] — Erreurs courantes et leurs solutions
- [[fr_Support\|Support]] — Canaux de support de l'éditeur et de la communauté, coordonnées

## Langues disponibles

Les pages suivantes sont également disponibles en anglais / The following pages are also available in English:

| Français | English |
|----------|---------|
| [[fr_Home\|Accueil]] | [[Home]] |
| [[fr_Deploying-from-Marketplace\|Déployer depuis le Marketplace]] | [[Deploying-from-Marketplace]] |
| [[fr_SSH-Connection\|Connexion SSH]] | [[SSH-Connection]] |
| [[fr_Post-Deployment-Verification\|Vérification post-déploiement]] | [[Post-Deployment-Verification]] |
| [[fr_HTTPS-TLS-Certificate\|Certificat HTTPS / TLS]] | [[HTTPS-TLS-Certificate]] |
| [[fr_Configuring-Nextcloud\|Configurer Nextcloud]] | [[Configuring-Nextcloud]] |
| [[fr_Updating-Nextcloud\|Mettre à jour Nextcloud]] | [[Updating-Nextcloud]] |
| [[fr_Managing-Users\|Gérer les utilisateurs]] | [[Managing-Users]] |
| [[fr_Managing-Apps\|Gérer les applications]] | [[Managing-Apps]] |
| [[fr_Loading-Sample-Data\|Chargement des données d'exemple]] | [[Loading-Sample-Data]] |
| [[fr_Exploring-Nextcloud\|Explorer Nextcloud]] | [[Exploring-Nextcloud]] |
| [[fr_Troubleshooting\|Dépannage]] | [[Troubleshooting]] |
| [[fr_Support\|Support]] | [[Support]] |

## Ressources

- [Documentation officielle Nextcloud](https://docs.nextcloud.com/)
- [Azure Marketplace](https://azuremarketplace.microsoft.com/)
- [[fr_Support\|Support]] — Contacter l'éditeur ou la communauté Nextcloud
