# Configuration de Nextcloud

> 🇬🇧 This page is also available in English: [[Configuring-Nextcloud]]

Cette page vous guide à travers la configuration initiale de Nextcloud après le déploiement,
y compris l'assistant de configuration et les paramètres clés post-installation.

---

## Prérequis

- HTTPS est configuré et votre domaine se résout correctement — voir [[fr_HTTPS-TLS-Certificate]].
- Les quatre services sont en cours d'exécution — voir [[fr_Post-Deployment-Verification]].

---

## Étape 1 — Ouvrir l'assistant de configuration

1. Ouvrez votre navigateur et accédez à `https://cloud.exemple.com`.
2. L'**assistant de configuration** de Nextcloud apparaît lors du premier accès.

> **Remarque :** Si l'assistant de configuration n'apparaît pas et que vous voyez une page de connexion,
> Nextcloud a été préconfiguré lors du déploiement. Passez à l'étape 3.

---

## Étape 2 — Compléter l'assistant de configuration

Remplissez les champs suivants :

### Compte administrateur

| Champ | Valeur |
|-------|--------|
| **Nom d'utilisateur admin** | Choisissez un nom d'utilisateur sécurisé (pas `admin`) |
| **Mot de passe admin** | Choisissez un mot de passe fort (≥ 12 caractères) |

### Dossier de données

Le dossier de données par défaut est `/var/nextcloud-data`.  
Si vous avez attaché un disque de données séparé lors du déploiement, modifiez ce chemin
vers le point de montage de ce disque (p. ex. `/mnt/data/nextcloud`).

### Configuration de la base de données

| Champ | Valeur |
|-------|--------|
| **Type de base de données** | PostgreSQL |
| **Utilisateur de la base de données** | `nextcloud` (préconfiguré) |
| **Mot de passe de la base de données** | Voir `/root/nextcloud-db-password.txt` ou la sortie du déploiement |
| **Nom de la base de données** | `nextcloud` |
| **Hôte de la base de données** | `127.0.0.1:5432` |

Cliquez sur **Terminer la configuration**.

---

## Alternative : Installation en ligne de commande

Si vous préférez configurer Nextcloud sans l'assistant web, utilisez l'interface CLI `occ` :

```bash
sudo -u www-data php /var/www/nextcloud/occ maintenance:install \
  --database "pgsql" \
  --database-host "127.0.0.1:5432" \
  --database-name "nextcloud" \
  --database-user "nextcloud" \
  --database-pass "VOTRE_MOT_DE_PASSE_DB" \
  --admin-user "VOTRE_UTILISATEUR_ADMIN" \
  --admin-pass "VOTRE_MOT_DE_PASSE_ADMIN" \
  --data-dir "/var/nextcloud-data"
```

> Remplacez `VOTRE_MOT_DE_PASSE_DB`, `VOTRE_UTILISATEUR_ADMIN` et `VOTRE_MOT_DE_PASSE_ADMIN`
> par vos valeurs réelles.

---

## Étape 3 — Paramètres post-installation

### Définir le domaine correct

```bash
sudo -u www-data php /var/www/nextcloud/occ config:system:set overwrite.cli.url \
  --value="https://cloud.exemple.com"
```

### Configurer les notifications par e-mail (facultatif)

1. Dans l'interface d'administration Nextcloud, accédez à **Paramètres > Informations personnelles > E-mail**.
2. Sous **Paramètres de base**, configurez votre serveur SMTP.

### Activer Redis pour le verrouillage des fichiers

Redis est préconfiguré sur cette VM. Vérifiez qu'il est actif dans `config.php` :

```bash
sudo grep -A 10 'memcache' /var/www/nextcloud/config/config.php
```

Entrées attendues :

```php
'memcache.local' => '\\OC\\Memcache\\Redis',
'memcache.locking' => '\\OC\\Memcache\\Redis',
```

---

## Étape 4 — Configurer les tâches de fond

Définissez Nextcloud pour utiliser le cron système pour les tâches en arrière-plan (recommandé plutôt que le mode Ajax par défaut) :

```bash
sudo -u www-data php /var/www/nextcloud/occ background:cron
```

Vérifiez que la tâche cron existe :

```bash
sudo crontab -u www-data -l
```

Attendu :

```
*/5 * * * * php /var/www/nextcloud/occ background:job
```

Si l'entrée cron est manquante, ajoutez-la :

```bash
echo "*/5 * * * * php /var/www/nextcloud/occ background:job" | sudo crontab -u www-data -
```

---

## Vérification

1. Connectez-vous à Nextcloud sur `https://cloud.exemple.com` avec vos identifiants d'administrateur.
2. Accédez à **Paramètres > Vue d'ensemble** — confirmez qu'aucun avertissement n'est affiché
   (ou résolvez les avertissements listés).
3. Téléversez un fichier de test pour vérifier que le stockage fonctionne.

---

## Résolution de problèmes

**Avertissement « Votre répertoire de données n'est pas valide »**  
Le chemin du répertoire de données dans `config.php` n'existe pas ou a des permissions incorrectes.
Définissez les permissions correctes : `sudo chown -R www-data:www-data /var/nextcloud-data`

**« Le mode maintenance est actif »**  
Désactivez le mode maintenance : `sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --off`

**L'assistant de configuration affiche une erreur de connexion à la base de données**  
Vérifiez que PostgreSQL est en cours d'exécution et que les identifiants de la base de données sont corrects.
Testez PostgreSQL avec : `sudo -u postgres psql -U nextcloud -d nextcloud -c "\\conninfo"`

---

## Étapes suivantes

| Étape suivante | Page |
|----------------|------|
| Découvrir les fonctionnalités de Nextcloud | [[fr_Exploring-Nextcloud]] |
| Maintenir Nextcloud à jour | [[fr_Updating-Nextcloud]] |
| Gérer les comptes utilisateurs | [[fr_Managing-Users]] |
