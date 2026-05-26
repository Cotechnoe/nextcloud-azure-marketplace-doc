# Chargement de données de démonstration

> 🇬🇧 This page is also available in English: [[Loading-Sample-Data]]

Cette page explique comment charger des fichiers et des données de démonstration dans Nextcloud
pour explorer ses fonctionnalités, effectuer des démonstrations ou valider votre déploiement.

---

## Prérequis

- Nextcloud est configuré et vous pouvez vous connecter en tant qu'administrateur — voir [[Configuring-Nextcloud-fr]].
- Vous êtes connecté à la VM via SSH — voir [[SSH-Connection-fr]].

---

## Option 1 — Téléverser des fichiers via l'interface web

La façon la plus simple d'ajouter du contenu de démonstration est de téléverser des fichiers
directement via le navigateur :

1. Connectez-vous à Nextcloud sur `https://cloud.exemple.com`.
2. Cliquez sur le bouton **+** dans la barre d'outils des fichiers.
3. Sélectionnez **Téléverser un fichier** et choisissez des fichiers depuis votre machine locale.

Vous pouvez téléverser des documents, des images ou des feuilles de calcul pour explorer les fonctionnalités de partage et de collaboration.

---

## Option 2 — Copier des fichiers depuis le serveur

Si vous souhaitez ajouter rapidement un ensemble plus important de fichiers de démonstration,
connectez-vous à la VM via SSH et copiez des fichiers dans le répertoire de données d'un utilisateur :

```bash
# Remplacez "admin" par le nom d'utilisateur Nextcloud réel
NEXTCLOUD_USER="admin"
DATA_DIR="/var/nextcloud-data/${NEXTCLOUD_USER}/files"

# Créer un répertoire de démonstration
sudo mkdir -p "${DATA_DIR}/Documents de démonstration"

# Copier des fichiers exemples (ajustez le chemin source si nécessaire)
sudo cp /usr/share/doc/*/copyright "${DATA_DIR}/Documents de démonstration/" 2>/dev/null || true
sudo chown -R www-data:www-data "${DATA_DIR}"
```

Après la copie des fichiers, scannez-les pour que Nextcloud les prenne en compte :

```bash
sudo -u www-data php /var/www/nextcloud/occ files:scan --user="${NEXTCLOUD_USER}"
```

---

## Option 3 — Générer des utilisateurs et fichiers de démonstration avec occ

Pour un environnement de démonstration, vous pouvez créer plusieurs utilisateurs de test avec des données de démonstration :

### Créer des utilisateurs de test

```bash
# Créer un utilisateur de test
sudo -u www-data php /var/www/nextcloud/occ user:add \
  --display-name="Utilisateur Test 1" \
  --group="groupetest" \
  utilisateurtest1
```

### Partager des fichiers entre utilisateurs

1. Connectez-vous en tant qu'administrateur.
2. Téléversez des fichiers dans votre espace Fichiers administrateur.
3. Partagez-les avec `utilisateurtest1` en utilisant la boîte de dialogue de partage.

---

## Option 4 — Importer un jeu de données de démonstration via WebDAV

Utilisez `curl` pour téléverser des fichiers via WebDAV depuis une source distante ou le système de fichiers local :

```bash
# Téléverser un fichier unique via WebDAV
curl -u admin:MOT_DE_PASSE_ADMIN \
  -T /chemin/vers/fichier/local.pdf \
  https://cloud.exemple.com/remote.php/dav/files/admin/fichier.pdf
```

---

## Vérification

Après le chargement des données de démonstration :

1. Connectez-vous à Nextcloud sur `https://cloud.exemple.com`.
2. Ouvrez l'application **Fichiers** et confirmez que les fichiers téléversés sont visibles.
3. Essayez de partager un fichier avec un autre utilisateur pour tester le flux de partage.
4. Installez l'application **Photos** (si ce n'est pas déjà fait) et téléversez des images pour tester la vue galerie.

---

## Nettoyage

Pour supprimer toutes les données de démonstration lorsque vous n'en avez plus besoin :

1. Dans l'interface web de Nextcloud, sélectionnez les fichiers/dossiers et cliquez sur **Supprimer**.
2. Accédez à **Fichiers > Fichiers supprimés** et supprimez-les définitivement de la corbeille.

Ou via la ligne de commande :

```bash
sudo -u www-data php /var/www/nextcloud/occ trashbin:cleanup --all-users
```

---

## Étapes suivantes

| Étape suivante | Page |
|----------------|------|
| Gérer les comptes utilisateurs | [[Managing-Users-fr]] |
| Gérer les applications installées | [[Managing-Apps-fr]] |
| Résoudre les problèmes | [[Troubleshooting-fr]] |
