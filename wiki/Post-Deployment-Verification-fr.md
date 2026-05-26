# Vérification post-déploiement

> 🇬🇧 This page is also available in English: [[Post-Deployment-Verification]]

Après le déploiement et la connexion SSH, vérifiez que les quatre services principaux fonctionnent
correctement avant de configurer Nextcloud.

---

## Prérequis

- Vous êtes connecté à la VM via SSH (voir [[SSH-Connection-fr]]).

---

## Étape 1 — Vérifier Nginx

Nginx fait office de serveur web et de proxy inverse.

```bash
sudo systemctl status nginx
```

La sortie attendue contient `Active: active (running)`.

Si Nginx ne fonctionne pas, démarrez-le :

```bash
sudo systemctl start nginx
sudo systemctl enable nginx
```

**Tester la réponse HTTP :**

```bash
curl -I http://localhost
```

Attendu : `HTTP/1.1 200 OK` ou une redirection vers HTTPS.

---

## Étape 2 — Vérifier PHP-FPM

PHP-FPM traite les requêtes PHP pour Nextcloud.

```bash
sudo systemctl status php8.3-fpm
```

La sortie attendue contient `Active: active (running)`.

Si PHP-FPM ne fonctionne pas, démarrez-le :

```bash
sudo systemctl start php8.3-fpm
sudo systemctl enable php8.3-fpm
```

**Vérifier la version de PHP :**

```bash
php --version
```

Attendu : PHP 8.3.

---

## Étape 3 — Vérifier PostgreSQL

PostgreSQL stocke la base de données Nextcloud.

```bash
sudo systemctl status postgresql
```

La sortie attendue contient `Active: active (running)`.

Si PostgreSQL ne fonctionne pas, démarrez-le :

```bash
sudo systemctl start postgresql
sudo systemctl enable postgresql
```

**Tester la connectivité à la base de données :**

```bash
sudo -u postgres psql -c "\\l"
```

Attendu : Un tableau listant les bases de données, dont `nextcloud` (si déjà configurée).

---

## Étape 4 — Vérifier Redis

Redis fournit le cache de sessions et le verrouillage des fichiers pour Nextcloud.

```bash
sudo systemctl status redis-server
```

La sortie attendue contient `Active: active (running)`.

Si Redis ne fonctionne pas, démarrez-le :

```bash
sudo systemctl start redis-server
sudo systemctl enable redis-server
```

**Tester la connectivité Redis :**

```bash
redis-cli ping
```

Attendu : `PONG`

---

## Vérification globale

Exécutez toutes les vérifications en une seule commande :

```bash
for svc in nginx php8.3-fpm postgresql redis-server; do
  echo "=== $svc ===" && sudo systemctl is-active "$svc"
done
```

Les quatre services doivent tous indiquer `active`.

---

## Tableau récapitulatif

| Service | Commande de vérification | Résultat attendu |
|---------|------------------------|-----------------|
| Nginx | `sudo systemctl is-active nginx` | `active` |
| PHP-FPM | `sudo systemctl is-active php8.3-fpm` | `active` |
| PostgreSQL | `sudo systemctl is-active postgresql` | `active` |
| Redis | `sudo systemctl is-active redis-server` | `active` |

---

## Résolution de problèmes

**Nginx ne démarre pas : « Address already in use »**  
Un autre processus utilise le port 80 ou 443. Trouvez-le avec `sudo ss -tlnp | grep ':80\|:443'` et arrêtez-le.

**PHP-FPM ne démarre pas : « No such file or directory »**  
Le chemin du socket configuré dans Nginx peut ne pas correspondre à celui créé par PHP-FPM.
Vérifiez la cohérence dans `/etc/nginx/sites-available/` et `/etc/php/8.3/fpm/pool.d/www.conf`.

**PostgreSQL ne démarre pas : « could not open file \"pg_filenode.map\" »**  
Problème de répertoire de données. Consultez les journaux PostgreSQL :
`sudo journalctl -u postgresql --since "5 minutes ago"`.

**Redis : `redis-cli ping` retourne `Connection refused`**  
Vérifiez que Redis écoute sur `127.0.0.1:6379` :
`sudo ss -tlnp | grep 6379`

---

## Étapes suivantes

| Étape suivante | Page |
|----------------|------|
| Configurer HTTPS | [[HTTPS-TLS-Certificate-fr]] |
| Finaliser la configuration de Nextcloud | [[Configuring-Nextcloud-fr]] |
