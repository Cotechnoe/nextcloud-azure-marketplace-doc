# Mise à jour de Nextcloud

> 🇬🇧 This page is also available in English: [[Updating-Nextcloud]]

Cette page explique comment maintenir votre installation Nextcloud à jour en utilisant
le programme de mise à jour intégré et la commande `occ upgrade`.

---

## Prérequis

- Vous êtes connecté à la VM via SSH — voir [[fr_SSH-Connection]].
- Vous avez effectué une sauvegarde avant de commencer — consultez le guide de sauvegarde pour les détails.

> **Important :** Sauvegardez toujours vos données et votre base de données avant d'effectuer
> une mise à jour. Les mises à jour ne peuvent pas être annulées sans une sauvegarde.

---

## Canaux de mise à jour

Nextcloud propose deux canaux de mise à jour :

| Canal | Description |
|-------|-------------|
| **stable** | Versions bien testées, recommandées pour la production |
| **maintenance** | Correctifs de sécurité et de bogues critiques uniquement pour la version majeure actuelle |

Vérifiez le canal actuel :

```bash
sudo -u www-data php /var/www/nextcloud/occ config:system:get updater.release.channel
```

Définissez le canal sur `stable` (recommandé) :

```bash
sudo -u www-data php /var/www/nextcloud/occ config:system:set updater.release.channel --value=stable
```

---

## Étape 1 — Activer le mode maintenance

Avant la mise à jour, mettez Nextcloud en mode maintenance pour empêcher l'accès des utilisateurs :

```bash
sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --on
```

---

## Étape 2 — Exécuter le programme de mise à jour

Nextcloud est livré avec un programme de mise à jour web intégré. Pour l'utiliser :

1. Accédez à `https://cloud.exemple.com/updater/` dans votre navigateur en étant connecté en tant qu'administrateur.
2. Cliquez sur **Démarrer la mise à jour** et suivez les instructions à l'écran.
3. Le programme de mise à jour téléchargera la nouvelle version et extraira les fichiers.

Vous pouvez également utiliser le programme de mise à jour en ligne de commande :

```bash
sudo -u www-data php /var/www/nextcloud/updater/updater.phar
```

> **Remarque :** L'application Updater de Nextcloud est un composant essentiel et **ne doit pas être désactivée**.
> La désactiver empêcherait l'application des mises à jour de sécurité.

---

## Étape 3 — Exécuter les migrations de base de données

Après la mise à jour des fichiers, exécutez la mise à jour de la base de données :

```bash
sudo -u www-data php /var/www/nextcloud/occ upgrade
```

Cette commande applique les modifications de schéma de base de données requises par la nouvelle version.

---

## Étape 4 — Désactiver le mode maintenance

Une fois la mise à jour terminée, désactivez le mode maintenance :

```bash
sudo -u www-data php /var/www/nextcloud/occ maintenance:mode --off
```

---

## Étape 5 — Vérifier la mise à jour

Vérifiez que Nextcloud exécute la nouvelle version :

```bash
sudo -u www-data php /var/www/nextcloud/occ status
```

La sortie attendue comprend le nouveau numéro de version :

```
Nextcloud or one of the apps require upgrade - only a single user (who is an admin) is allowed to be logged in
...
  - installed: true
  - version: 28.x.x.x
  - versionstring: 28.x.x
```

Connectez-vous également via l'interface web et vérifiez **Paramètres > Vue d'ensemble**
pour les avertissements restants.

---

## Vérification

| Vérification | Commande / Action |
|-------------|------------------|
| Version | `sudo -u www-data php /var/www/nextcloud/occ status` |
| Aucun avertissement | Paramètres > Vue d'ensemble dans le navigateur |
| Tous les services actifs | `sudo systemctl is-active nginx php8.3-fpm postgresql redis-server` |

---

## Résolution de problèmes

**`occ upgrade` échoue avec « already latest version »**  
La base de données est déjà à la version actuelle. Exécutez `occ status` pour confirmer.
Vous pouvez désactiver le mode maintenance en toute sécurité.

**Le programme de mise à jour web se bloque**  
Utilisez plutôt le programme de mise à jour en ligne de commande :
`sudo -u www-data php /var/www/nextcloud/updater/updater.phar`

**« Could not get exclusive lock on config file »**  
Un autre processus `occ` est en cours d'exécution. Attendez qu'il se termine,
ou vérifiez avec `ps aux | grep occ`.

**Des applications sont désactivées après la mise à jour**  
Certaines applications peuvent ne pas encore prendre en charge la nouvelle version de Nextcloud.
Accédez à **Paramètres > Applications** et vérifiez les mises à jour disponibles,
ou attendez que le développeur de l'application publie une version compatible.

---

## Étapes suivantes

| Étape suivante | Page |
|----------------|------|
| Gérer les applications installées | [[fr_Managing-Apps]] |
| Gérer les comptes utilisateurs | [[fr_Managing-Users]] |
| Résoudre les problèmes | [[fr_Troubleshooting]] |
