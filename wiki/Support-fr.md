# Soutien technique

> 🇬🇧 This page is also available in English: [[Support]]

Cette page décrit les canaux de soutien disponibles pour le déploiement Nextcloud
sur Azure Marketplace offert par Cotechnoe.

---

## Canaux de soutien

### 1. GitHub Issues — Problèmes de déploiement et de documentation

Pour les problèmes spécifiques au déploiement Azure Marketplace, à la configuration
de la VM ou aux erreurs de documentation, ouvrez un ticket dans le dépôt GitHub :

**[github.com/Cotechnoe/nextcloud-azure-marketplace-doc/issues](https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/issues)**

Utilisez ce canal pour :
- La VM ne démarre pas après le déploiement
- Les services (Nginx, PHP-FPM, MariaDB, Redis) ne démarrent pas
- Erreurs de documentation ou étapes manquantes
- Suggestions de nouveaux guides ou améliorations

### 2. Forum communautaire Nextcloud — Questions liées à l'application

Pour les questions sur les fonctionnalités Nextcloud, les applications, la configuration
et l'utilisation générale :

**[help.nextcloud.com](https://help.nextcloud.com)**

Utilisez ce canal pour :
- Installation et configuration d'applications
- Questions sur la gestion des utilisateurs
- Problèmes de partage de fichiers et de collaboration
- Intégration avec des services externes (LDAP, Entra ID, etc.)

### 3. Support Azure — Problèmes d'infrastructure cloud

Pour les problèmes liés à l'infrastructure Azure elle-même (disponibilité de la VM,
mise en réseau, facturation) :

**[azure.microsoft.com/fr-fr/support/create-ticket](https://azure.microsoft.com/fr-fr/support/create-ticket)**

Utilisez ce canal pour :
- VM inaccessible depuis le Portail Azure
- Règles NSG qui ne s'appliquent pas correctement
- Questions sur l'abonnement ou la facturation
- Alertes Azure Monitor

---

## Signaler un problème efficacement

Lorsque vous ouvrez un ticket GitHub, incluez les informations suivantes pour accélérer
la résolution de votre problème :

```
## Environnement
- Version Nextcloud : (exécutez `sudo -u www-data php /var/www/nextcloud/occ status`)
- SKU de la VM : (p. ex. Standard_B2s)
- Système d'exploitation : Ubuntu 22.04 LTS
- Date de déploiement : AAAA-MM-JJ

## Description du problème
Une description claire de ce qui s'est mal passé.

## Étapes pour reproduire
1. Étape un
2. Étape deux
3. Étape trois

## Comportement attendu
Ce que vous vous attendiez à voir se produire.

## Comportement réel
Ce qui s'est produit réellement.

## Journaux pertinents
(collez la sortie des commandes pertinentes — voir [[Troubleshooting-fr]] pour les commandes de diagnostic)
```

---

## Autodiagnostic

Avant d'ouvrir une demande de soutien, exécutez ces vérifications rapides :

```bash
# Vérifier les quatre services
sudo systemctl is-active nginx php8.1-fpm mariadb redis-server

# Vérifier le statut de Nextcloud
sudo -u www-data php /var/www/nextcloud/occ status

# Vérifier l'espace disque
df -h
```

Voir [[Troubleshooting-fr]] pour les procédures de diagnostic détaillées.

---

## Étapes suivantes

| Étape suivante | Page |
|----------------|------|
| Résoudre les problèmes courants | [[Troubleshooting-fr]] |
| Explorer Nextcloud | [[Exploring-Nextcloud-fr]] |
| Retourner à l'accueil du wiki | [[Home-fr]] |
