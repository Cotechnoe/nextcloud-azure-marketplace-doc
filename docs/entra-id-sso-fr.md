# Intégration SSO Entra ID

> 🇬🇧 This page is also available in English: [Entra ID SSO Integration](entra-id-sso.md)

Ce guide explique comment configurer l'authentification unique (SSO) entre Microsoft Entra ID
(anciennement Azure Active Directory) et votre instance Nextcloud, en utilisant le protocole SAML 2.0.

---

## Vue d'ensemble

| Élément | Valeur |
|---------|--------|
| Protocole | SAML 2.0 |
| Application Nextcloud | `user_saml` |
| Fournisseur d'identité | Microsoft Entra ID |
| Version Nextcloud minimale | 25+ |

---

## Prérequis

- Nextcloud est accessible via HTTPS (voir [[HTTPS-TLS-Certificate-fr]])
- Vous avez le rôle **Administrateur général** ou **Administrateur d'application** dans Entra ID
- L'application `user_saml` est disponible depuis la boutique d'applications Nextcloud

---

## Étape 1 — Installer l'application SSO et authentification SAML

```bash
sudo -u www-data php /var/www/nextcloud/occ app:install user_saml
```

---

## Étape 2 — Enregistrer Nextcloud dans Entra ID

1. Ouvrez le [Portail Azure](https://portal.azure.com) et accédez à
   **Microsoft Entra ID > Applications d'entreprise**.
2. Cliquez sur **+ Nouvelle application > Créer votre propre application**.
3. Nommez-la (p. ex. `Nextcloud`) et sélectionnez **Intégrer toute autre application que vous ne trouvez pas dans la galerie (Hors galerie)**.
4. Cliquez sur **Créer**.

### Configurer SAML

5. Dans la nouvelle application, accédez à **Authentification unique > SAML**.
6. Sous **Configuration SAML de base**, définissez :
   - **Identificateur (ID d'entité) :** `https://cloud.exemple.com/apps/user_saml/saml/metadata`
   - **URL de réponse (URL ACS) :** `https://cloud.exemple.com/apps/user_saml/saml/acs`
   - **URL de connexion :** `https://cloud.exemple.com/login`

7. Sous **Attributs et revendications**, vérifiez que l'attribut suivant est mappé :
   - `user.userprincipalname` → `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier`

8. Téléchargez le fichier **XML des métadonnées de fédération**.

---

## Étape 3 — Configurer le SSO dans Nextcloud

1. Dans Nextcloud, accédez à **Paramètres > Administration > Authentification SSO et SAML**.
2. Sélectionnez **Utiliser l'authentification SAML intégrée**.
3. Sous **Données du fournisseur d'identité**, cliquez sur **Importer les métadonnées du fournisseur d'identité**
   et téléversez le fichier XML des métadonnées de fédération téléchargé depuis Entra ID.

4. Définissez **Attribut pour mapper l'UID :** `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier`

5. (Optionnel) Mappez le nom d'affichage et l'e-mail :
   - **Nom d'affichage :** `http://schemas.microsoft.com/identity/claims/displayname`
   - **E-mail :** `http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress`

6. Cliquez sur **Enregistrer**.

---

## Étape 4 — Assigner les utilisateurs dans Entra ID

1. Dans l'application d'entreprise Entra ID, accédez à **Utilisateurs et groupes**.
2. Cliquez sur **+ Ajouter un utilisateur/groupe**.
3. Assignez les utilisateurs ou groupes qui devraient avoir accès à Nextcloud.

---

## Étape 5 — Tester l'intégration

1. Ouvrez une fenêtre de navigation privée/incognito.
2. Accédez à `https://cloud.exemple.com/login`.
3. Cliquez sur **Se connecter avec SSO**.
4. Vous devriez être redirigé vers la page de connexion Microsoft.
5. Après l'authentification, vous devriez être redirigé et connecté à Nextcloud.

---

## Provisionnement des utilisateurs (Optionnel — SCIM)

Pour le provisionnement automatique des utilisateurs, Nextcloud prend en charge SCIM
via l'application `user_scim`. Cela maintient les utilisateurs Nextcloud synchronisés
avec les groupes Entra ID automatiquement.

```bash
sudo -u www-data php /var/www/nextcloud/occ app:install user_scim
```

Configurez le point de terminaison SCIM dans Entra ID sous
**Application d'entreprise > Provisionnement > SCIM**.

---

## Résolution des problèmes

| Problème | Cause probable | Solution |
|----------|---------------|----------|
| Erreur "Not allowed to login" | Utilisateur non assigné dans Entra ID | Assigner l'utilisateur dans Application d'entreprise > Utilisateurs et groupes |
| Boucle de redirection à la connexion | URL ACS incorrecte dans Entra ID | Vérifier que l'URL de réponse correspond exactement |
| "Signature verification failed" | Décalage d'horloge entre VM et Entra ID | Synchroniser l'horloge VM : `sudo timedatectl set-ntp true` |
| Les utilisateurs ne trouvent pas leurs fichiers après SSO | Mauvais mappage UID | Vérifier que l'attribut UID mappe vers la même valeur que les noms d'utilisateurs locaux existants |

---

## Guides connexes

- [Gestion des utilisateurs](../wiki/Managing-Users-fr.md) — Gérer les utilisateurs locaux avec les utilisateurs SSO
- [Gestion des applications](../wiki/Managing-Apps-fr.md) — Procédures d'installation d'applications
- [Sécurité réseau](network-security-fr.md) — Assurer que le pare-feu autorise HTTPS pour les flux SAML
