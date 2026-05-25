# Découvrir Nextcloud

> 🇬🇧 This page is also available in English: [[Exploring-Nextcloud]]

Cette page vous présente les fonctionnalités principales disponibles dans votre déploiement Nextcloud
afin de vous aider à exploiter pleinement la plateforme.

---

## Prérequis

- Nextcloud est configuré et vous pouvez vous connecter — voir [[Configuring-Nextcloud-fr]].

---

## L'interface principale

Après la connexion, vous arrivez sur l'application **Fichiers** — le centre de gestion des fichiers et dossiers.

La barre de navigation supérieure donne accès à toutes les applications installées :

| Icône / Application | Description |
|--------------------|-------------|
| **Fichiers** | Téléverser, télécharger, partager et gérer les fichiers et dossiers |
| **Photos** | Parcourir et organiser les photos et vidéos |
| **Talk** | Appels audio/vidéo et messagerie d'équipe |
| **Calendrier** | Calendriers personnels et partagés avec support CalDAV |
| **Contacts** | Carnet d'adresses avec support CardDAV |
| **Activité** | Flux des événements récents (téléversements, partages, commentaires) |
| **Paramètres** | Préférences utilisateur, paramètres de sécurité, appareils connectés |

---

## Gestion des fichiers

### Téléverser des fichiers

- Glissez-déposez des fichiers directement dans la fenêtre du navigateur, ou
- Cliquez sur le bouton **+** dans la barre d'outils et sélectionnez **Téléverser un fichier**.

### Créer des fichiers et dossiers

Cliquez sur le bouton **+** et choisissez **Nouveau dossier**, **Nouveau document texte**
ou **Nouveau tableur** (si Collabora Online est installé).

### Partager des fichiers et dossiers

1. Survolez un fichier ou un dossier et cliquez sur l'icône **Partager**.
2. Choisissez de partager avec :
   - **Utilisateurs ou groupes internes** — saisissez un nom d'utilisateur ou de groupe.
   - **Lien public** — génère une URL partageable avec protection par mot de passe et date d'expiration optionnelles.

### Synchroniser avec les clients bureau et mobile

Installez le client bureau ou mobile Nextcloud pour maintenir vos fichiers synchronisés :

- [Client bureau Nextcloud](https://nextcloud.com/install/#install-clients) (Windows, macOS, Linux)
- [Application Nextcloud iOS](https://apps.apple.com/app/nextcloud/id1125420102)
- [Application Nextcloud Android](https://play.google.com/store/apps/details?id=com.nextcloud.client)

Configurez le client avec :
- **URL du serveur** : `https://cloud.exemple.com`
- **Nom d'utilisateur / Mot de passe** : vos identifiants Nextcloud

---

## Accès WebDAV

Nextcloud prend en charge WebDAV pour accéder aux fichiers depuis n'importe quel client ou script compatible :

```
https://cloud.exemple.com/remote.php/dav/files/NOM_UTILISATEUR/
```

Remplacez `NOM_UTILISATEUR` par votre nom d'utilisateur Nextcloud.

---

## Paramètres clés

Accédez aux **Paramètres** (menu utilisateur en haut à droite) pour :

- Modifier votre mot de passe et votre photo de profil.
- Activer l'**authentification à deux facteurs (2FA)** pour une sécurité renforcée.
- Afficher et révoquer les sessions actives.
- Générer des **mots de passe d'application** pour les clients bureau/mobile ou les intégrations API.

---

## Vue d'ensemble de l'administrateur

Les administrateurs peuvent accéder à des paramètres supplémentaires sous **Paramètres > Administration** :

| Paramètre | Objectif |
|-----------|---------|
| **Vue d'ensemble** | Santé du système, avertissements et informations sur la version |
| **Utilisateurs** | Créer et gérer les utilisateurs et les groupes |
| **Applications** | Installer, mettre à jour et désactiver des applications |
| **Paramètres de base** | E-mail, tâches en arrière-plan, niveau de journalisation |
| **Partage** | Autorisations et paramètres de partage globaux |
| **Sécurité** | Politique de mots de passe, protection contre les attaques par force brute, application de la 2FA |
| **Journalisation** | Afficher et télécharger les journaux d'application |

---

## Étapes suivantes

| Étape suivante | Page |
|----------------|------|
| Charger des données de démonstration | [[Loading-Sample-Data-fr]] |
| Gérer les comptes utilisateurs | [[Managing-Users-fr]] |
| Installer et gérer des applications | [[Managing-Apps-fr]] |
