# Gestion des utilisateurs

> 🇬🇧 This page is also available in English: [[Managing-Users]]

Cette page couvre la création, l'organisation et la gestion des comptes utilisateurs dans Nextcloud,
y compris la gestion des groupes, les quotas et l'importation CSV pour le provisionnement en masse.

---

## Prérequis

- Vous êtes connecté en tant qu'administrateur.
- Nextcloud est configuré — voir [[fr-Configuring-Nextcloud]].

---

## Créer un utilisateur

1. Accédez à **Paramètres > Utilisateurs** dans le panneau d'administration Nextcloud.
2. Cliquez sur **Nouvel utilisateur**.
3. Remplissez les champs :

| Champ | Description |
|-------|-------------|
| **Nom d'utilisateur** | Identifiant de connexion unique (ne peut pas être modifié ultérieurement) |
| **Nom d'affichage** | Nom complet affiché dans l'interface |
| **Mot de passe** | Mot de passe initial (l'utilisateur peut le modifier après connexion) |
| **E-mail** | Facultatif — utilisé pour les notifications et la réinitialisation du mot de passe |
| **Groupes** | Assigner l'utilisateur à un ou plusieurs groupes |
| **Quota** | Quota de stockage (p. ex. `5 Go`) ou **Quota par défaut** |

4. Cliquez sur **Ajouter un nouvel utilisateur**.

### Créer un utilisateur via la CLI

```bash
sudo -u www-data php /var/www/nextcloud/occ user:add \
  --display-name="Jeanne Dupont" \
  --group="chercheurs" \
  jdupont
# Un mot de passe vous sera demandé
```

---

## Gestion des groupes

Les groupes vous permettent de gérer les autorisations, le partage et les quotas pour des ensembles d'utilisateurs.

### Créer un groupe

1. Accédez à **Paramètres > Utilisateurs**.
2. Cliquez sur **Ajouter un groupe** dans la barre latérale gauche.
3. Saisissez un nom de groupe et appuyez sur Entrée.

### Ajouter un utilisateur à un groupe

- Depuis la liste des utilisateurs : cliquez sur la cellule **Groupes** d'un utilisateur et ajoutez le nom du groupe.
- Via la CLI :

```bash
sudo -u www-data php /var/www/nextcloud/occ group:adduser chercheurs jdupont
```

### Lister les membres d'un groupe

```bash
sudo -u www-data php /var/www/nextcloud/occ group:listmembers chercheurs
```

---

## Définir des quotas de stockage

### Définir un quota par défaut pour tous les utilisateurs

1. Accédez à **Paramètres > Administration > Authentification des utilisateurs**.
2. Définissez le champ **Quota par défaut** (p. ex. `10 Go`).

### Définir un quota par utilisateur

1. Accédez à **Paramètres > Utilisateurs**.
2. Trouvez l'utilisateur et cliquez sur la colonne **Quota**.
3. Saisissez la valeur du quota (p. ex. `5 Go`) et appuyez sur Entrée.

### Définir un quota via la CLI

```bash
sudo -u www-data php /var/www/nextcloud/occ user:setting jdupont files quota "5 GB"
```

---

## Importation d'utilisateurs en masse via CSV

Pour les environnements universitaires ou d'entreprise, vous pouvez importer des utilisateurs
depuis un fichier CSV en utilisant l'application **User CSV Import**
(installez-la d'abord depuis **Paramètres > Applications**).

Format CSV :

```csv
userid,display_name,email,groups,quota,password
jdupont,Jeanne Dupont,jdupont@exemple.com,chercheurs|étudiants,5 GB,ChangeMe123!
adubois,Alice Dubois,adubois@exemple.com,personnel,10 GB,ChangeMe123!
```

Commande d'importation (si l'application prend en charge la CLI) :

```bash
sudo -u www-data php /var/www/nextcloud/occ user:import /chemin/vers/utilisateurs.csv
```

> **Remarque :** Les mots de passe dans les fichiers CSV sont temporaires. Exigez des utilisateurs
> qu'ils modifient leur mot de passe à la première connexion via
> **Paramètres > Administration > Sécurité**.

---

## Réinitialiser le mot de passe d'un utilisateur

### Via l'interface web

1. Accédez à **Paramètres > Utilisateurs**.
2. Cliquez sur le **menu trois points** à côté de l'utilisateur.
3. Sélectionnez **Modifier l'utilisateur** et mettez à jour le mot de passe.

### Via la CLI

```bash
sudo -u www-data php /var/www/nextcloud/occ user:resetpassword jdupont
```

---

## Désactiver et supprimer des utilisateurs

### Désactiver un utilisateur (conserve les données)

```bash
sudo -u www-data php /var/www/nextcloud/occ user:disable jdupont
```

### Réactiver un utilisateur désactivé

```bash
sudo -u www-data php /var/www/nextcloud/occ user:enable jdupont
```

### Supprimer un utilisateur

```bash
sudo -u www-data php /var/www/nextcloud/occ user:delete jdupont
```

> **Avertissement :** La suppression d'un utilisateur efface définitivement ses données.
> Envisagez de désactiver l'utilisateur à la place.

---

## Étapes suivantes

| Étape suivante | Page |
|----------------|------|
| Gérer les applications installées | [[fr-Managing-Apps]] |
| Résoudre les problèmes | [[fr-Troubleshooting]] |
| Obtenir de l'aide | [[fr-Support]] |
