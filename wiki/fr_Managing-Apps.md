# Gestion des applications

> 🇬🇧 This page is also available in English: [[Managing-Apps]]

Cette page explique comment installer, mettre à jour, activer, désactiver et supprimer
des applications dans votre déploiement Nextcloud.

---

## Prérequis

- Vous êtes connecté en tant qu'administrateur.

---

## La boutique d'applications

Nextcloud dispose d'une boutique d'applications intégrée qui donne accès aux applications officielles
maintenues par Nextcloud GmbH et des développeurs communautaires vérifiés.

Pour y accéder :

1. Accédez à **Paramètres > Applications** dans le panneau d'administration Nextcloud.
2. Parcourez les applications par catégorie ou recherchez par nom.

> **Avertissement de sécurité :** Installez uniquement des applications depuis la boutique officielle
> Nextcloud (`apps.nextcloud.com`). Les dépôts tiers ne sont pas pris en charge et peuvent
> introduire des vulnérabilités de sécurité ou des instabilités.

---

## Installer une application

### Via l'interface web

1. Accédez à **Paramètres > Applications**.
2. Trouvez l'application que vous souhaitez installer.
3. Cliquez sur **Télécharger et activer**.

### Via la CLI

```bash
sudo -u www-data php /var/www/nextcloud/occ app:install <id-app>
```

Exemple — installer l'application Contacts :

```bash
sudo -u www-data php /var/www/nextcloud/occ app:install contacts
```

---

## Activer et désactiver des applications

### Activer une application

```bash
sudo -u www-data php /var/www/nextcloud/occ app:enable <id-app>
```

### Désactiver une application

```bash
sudo -u www-data php /var/www/nextcloud/occ app:disable <id-app>
```

> **Important :** Certaines applications essentielles **ne doivent pas être désactivées** car elles
> sont nécessaires au fonctionnement sécurisé et correct de Nextcloud. L'application **Updater**
> en est un exemple — la désactiver empêcherait l'application des mises à jour de sécurité.

---

## Mettre à jour des applications

Les applications reçoivent des mises à jour indépendamment du cœur Nextcloud.
Pour mettre à jour toutes les applications :

### Via l'interface web

1. Accédez à **Paramètres > Applications > Mises à jour** (si disponible).
2. Cliquez sur **Tout mettre à jour** ou mettez à jour les applications individuellement.

### Via la CLI

```bash
sudo -u www-data php /var/www/nextcloud/occ app:update --all
```

Pour mettre à jour une seule application :

```bash
sudo -u www-data php /var/www/nextcloud/occ app:update <id-app>
```

---

## Lister les applications installées

```bash
sudo -u www-data php /var/www/nextcloud/occ app:list
```

Cette commande affiche les applications activées et désactivées avec leurs numéros de version.

---

## Supprimer une application

### Via l'interface web

1. Accédez à **Paramètres > Applications**.
2. Trouvez l'application sous **Vos applications** ou **Applications désactivées**.
3. Cliquez sur **Supprimer**.

### Via la CLI

```bash
sudo -u www-data php /var/www/nextcloud/occ app:remove <id-app>
```

> **Remarque :** La suppression d'une application efface son code mais peut laisser des données
> de configuration dans la base de données.

---

## Applications recommandées

Les applications suivantes sont couramment utilisées dans les environnements académiques,
de recherche et d'entreprise :

| Application | Description | ID de l'application |
|-------------|-------------|---------------------|
| **Collabora Online** | Éditeur de documents dans le navigateur (Writer, Calc, Impress) | `richdocuments` |
| **Talk** | Appels vidéo, partage d'écran et messagerie d'équipe | `spreed` |
| **Calendrier** | Calendriers personnels et partagés avec CalDAV | `calendar` |
| **Contacts** | Carnet d'adresses avec support CardDAV | `contacts` |
| **Two-Factor TOTP** | Application d'authentification (Google Authenticator, Authy) | `twofactor_totp` |
| **Dossiers de groupe** | Dossiers partagés avec permissions par groupe | `groupfolders` |
| **Mots de passe** | Gestionnaire de mots de passe intégré à Nextcloud | `passwords` |

---

## Étapes suivantes

| Étape suivante | Page |
|----------------|------|
| Résoudre les problèmes | [[fr_Troubleshooting]] |
| Obtenir de l'aide | [[fr_Support]] |
| Mettre à jour le cœur Nextcloud | [[fr_Updating-Nextcloud]] |
