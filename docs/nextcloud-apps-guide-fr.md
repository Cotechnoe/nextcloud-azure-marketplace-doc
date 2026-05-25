# Guide des applications Nextcloud

> 🇬🇧 This page is also available in English: [Nextcloud Apps Guide](nextcloud-apps-guide.md)

Ce guide couvre l'installation et la configuration des applications les plus utiles
pour les environnements académiques, de recherche et d'entreprise.

---

## Politique d'installation des applications

Installez uniquement des applications depuis la **boutique officielle Nextcloud** (`apps.nextcloud.com`).
Les dépôts d'applications tiers ne sont pas pris en charge et peuvent compromettre la sécurité.

Consultez la page wiki [[Managing-Apps-fr]] pour les procédures générales de gestion des applications.

---

## Collabora Online (Édition de documents)

Collabora Online fournit une suite bureautique dans le navigateur (Writer, Calc, Impress)
intégrée directement dans Nextcloud.

### Prérequis

- Minimum **4 vCPU / 8 Go RAM** (Standard_D2s_v3 ou supérieur)
- Un **serveur Collabora Online** séparé ou l'application **Collabora Online Built-in** (petits déploiements)

### Installer Collabora Online Built-in

Pour les petits déploiements (jusqu'à 20 éditeurs simultanés) :

```bash
sudo -u www-data php /var/www/nextcloud/occ app:install richdocumentscode
sudo -u www-data php /var/www/nextcloud/occ app:install richdocuments
```

Puis configurer dans Nextcloud :

1. Accédez à **Paramètres > Administration > Nextcloud Office**.
2. Sélectionnez **Utiliser le serveur CODE intégré**.
3. Cliquez sur **Enregistrer**.

### Vérification

Ouvrez un fichier `.docx`, `.xlsx` ou `.pptx` dans l'application Fichiers — il devrait
s'ouvrir dans l'éditeur du navigateur.

---

## Talk (Appels vidéo et messagerie)

Nextcloud Talk fournit des appels vidéo chiffrés de bout en bout, le partage d'écran
et la messagerie d'équipe sans quitter Nextcloud.

### Installer

```bash
sudo -u www-data php /var/www/nextcloud/occ app:install spreed
```

### Configurer un serveur TURN (pour les appels à travers NAT/pare-feux)

Pour des appels vidéo fiables, configurez un serveur TURN :

1. Accédez à **Paramètres > Administration > Talk**.
2. Ajoutez l'URL de votre serveur TURN : `turns:turn.exemple.com:5349`
3. Saisissez le secret du serveur TURN.

> Pour un déploiement de test rapide sans serveur TURN, les appels peuvent fonctionner
> sur le même réseau mais échoueront pour les utilisateurs distants derrière un NAT.

---

## Calendrier et Contacts

Fournissent des points de terminaison CalDAV et CardDAV qui s'intègrent avec les
clients de bureau et mobiles.

### Installer

```bash
sudo -u www-data php /var/www/nextcloud/occ app:install calendar
sudo -u www-data php /var/www/nextcloud/occ app:install contacts
```

### URLs CalDAV/CardDAV

Les utilisateurs peuvent connecter leurs clients de calendrier et carnet d'adresses en utilisant :

- **CalDAV :** `https://cloud.exemple.com/remote.php/dav/calendars/<nomutilisateur>/`
- **CardDAV :** `https://cloud.exemple.com/remote.php/dav/addressbooks/users/<nomutilisateur>/`

---

## Authentification à deux facteurs (TOTP)

Activez l'authentification à deux facteurs basée sur TOTP pour une sécurité accrue des comptes.

### Installer

```bash
sudo -u www-data php /var/www/nextcloud/occ app:install twofactor_totp
```

### Imposer l'A2F pour tous les utilisateurs (Admin)

```bash
sudo -u www-data php /var/www/nextcloud/occ twofactor:enforce --on
```

Les utilisateurs seront invités à configurer leur application d'authentification
(Google Authenticator, Authy, etc.) à la prochaine connexion.

### Imposer l'A2F pour des groupes spécifiques uniquement

```bash
sudo -u www-data php /var/www/nextcloud/occ twofactor:enforce --on --group=admins
```

---

## Dossiers de groupe

Les dossiers de groupe permettent aux administrateurs de créer des dossiers partagés
accessibles à des groupes entiers, avec des permissions ACL granulaires.

### Installer

```bash
sudo -u www-data php /var/www/nextcloud/occ app:install groupfolders
```

### Créer un dossier de groupe

1. Accédez à **Paramètres > Administration > Dossiers de groupe**.
2. Cliquez sur **Ajouter un nouveau dossier**, saisissez un nom.
3. Assignez des groupes et définissez les permissions (Lecture, Écriture, Partage, Suppression).

---

## Récapitulatif

| Application | ID de l'application | Cas d'usage |
|-------------|---------------------|-------------|
| Collabora Online (Built-in) | `richdocumentscode` + `richdocuments` | Édition de documents dans le navigateur |
| Talk | `spreed` | Appels vidéo, messagerie |
| Calendrier | `calendar` | Calendriers CalDAV |
| Contacts | `contacts` | Carnets d'adresses CardDAV |
| Two-Factor TOTP | `twofactor_totp` | Sécurité renforcée à la connexion |
| Dossiers de groupe | `groupfolders` | Dossiers partagés départementaux |

---

## Guides connexes

- [Guide de dimensionnement des VMs](vm-sizing-guide-fr.md) — Vérifier les ressources suffisantes avant d'installer des applications lourdes
- [Gestion des utilisateurs](../wiki/Managing-Users-fr.md)
- [Sécurité réseau](network-security-fr.md)
