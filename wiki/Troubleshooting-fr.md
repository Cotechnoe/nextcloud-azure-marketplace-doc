# Résolution de problèmes

> 🇬🇧 This page is also available in English: [[Troubleshooting]]

Cette page couvre les problèmes les plus courants rencontrés avec un déploiement Nextcloud
depuis Azure Marketplace, ainsi que les commandes de diagnostic et les solutions.

---

## Prérequis

- Vous êtes connecté à la VM via SSH — voir [[SSH-Connection-fr]].
- Les quatre services devraient être en cours d'exécution : Nginx, PHP-FPM 8.3, PostgreSQL 16, Redis.

---

## Problème 1 — Port 443 bloqué (impossible d'accéder à Nextcloud via HTTPS)

**Symptômes :** Le navigateur affiche « connexion refusée » ou expire sur `https://cloud.exemple.com`.

**Diagnostic :**

```bash
# Vérifier si Nginx écoute sur le port 443
sudo ss -tlnp | grep ':443'

# Vérifier les règles NSG / pare-feu (depuis le Portail Azure)
# Paramètres > Mise en réseau > Règles de port entrant — le port 443 doit être autorisé
```

**Solutions :**

1. Vérifiez que le NSG (Groupe de sécurité réseau) de la VM a une règle entrante autorisant TCP port 443.
   Accédez au Portail Azure > VM > Mise en réseau > Règles de port entrant.
2. Vérifiez que Nginx est en cours d'exécution : `sudo systemctl status nginx`
3. Redémarrez Nginx si nécessaire : `sudo systemctl restart nginx`

---

## Problème 2 — Certificat TLS expiré

**Symptômes :** Le navigateur affiche un avertissement de sécurité « Votre connexion n'est pas privée » (ERR_CERT_DATE_INVALID).

**Diagnostic :**

```bash
# Vérifier la date d'expiration du certificat
sudo certbot certificates
```

**Solution :**

Renouvelez le certificat manuellement :

```bash
sudo certbot renew
sudo systemctl reload nginx
```

Pour le renouvellement automatique, vérifiez que le minuteur certbot est actif :

```bash
sudo systemctl status certbot.timer
```

Si le minuteur est inactif, activez-le :

```bash
sudo systemctl enable --now certbot.timer
```

---

## Problème 3 — Perte de connexion à la base de données

**Symptômes :** Nextcloud affiche « Erreur lors de la création de l'utilisateur admin : impossible de se connecter à la base de données » ou « could not connect to server: Connection refused ».

**Diagnostic :**

```bash
sudo systemctl status postgresql
sudo journalctl -u postgresql --since "1 hour ago" | tail -30
```

**Solutions :**

1. Démarrez ou redémarrez PostgreSQL : `sudo systemctl restart postgresql`
2. Vérifiez l'espace disque — PostgreSQL peut échouer si le disque est plein :
   ```bash
   df -h /
   ```
3. Consultez le journal PostgreSQL : `sudo journalctl -u postgresql --since "1 hour ago" | tail -50`

---

## Problème 4 — Crash PHP-FPM (502 Bad Gateway)

**Symptômes :** Nginx retourne une erreur 502 Bad Gateway. Les pages ne se chargent pas.

**Diagnostic :**

```bash
sudo systemctl status php8.3-fpm
sudo journalctl -u php8.3-fpm --since "30 minutes ago" | tail -20
```

**Solutions :**

1. Redémarrez PHP-FPM : `sudo systemctl restart php8.3-fpm`
2. Consultez le journal PHP : `sudo tail -50 /var/log/php8.3-fpm.log`
3. Augmentez la limite mémoire si les processus sont tués par OOM (Out of Memory) :
   Modifiez `/etc/php/8.3/fpm/php.ini` → `memory_limit = 512M`, puis redémarrez PHP-FPM.

---

## Problème 5 — Redis indisponible (problèmes de verrouillage)

**Symptômes :** Nextcloud affiche des erreurs « Could not obtain lock » ou les opérations sur les fichiers échouent avec des avertissements de verrouillage.

**Diagnostic :**

```bash
sudo systemctl status redis-server
redis-cli ping
```

Réponse attendue de `redis-cli ping` : `PONG`

**Solutions :**

1. Démarrez ou redémarrez Redis : `sudo systemctl restart redis-server`
2. Consultez le journal Redis : `sudo tail -30 /var/log/redis/redis-server.log`
3. Vérifiez la configuration Redis dans le fichier `config.php` de Nextcloud :
   ```bash
   sudo grep -A 5 'redis' /var/www/nextcloud/config/config.php
   ```

---

## Commandes de diagnostic générales

```bash
# Vérifier les quatre services en une seule commande
sudo systemctl is-active nginx php8.3-fpm postgresql redis-server

# Afficher le journal applicatif Nextcloud (50 dernières lignes)
sudo tail -50 /var/log/nextcloud/nextcloud.log | python3 -m json.tool 2>/dev/null || \
  sudo tail -50 /var/log/nextcloud/nextcloud.log

# Vérifier l'espace disque
df -h

# Vérifier l'utilisation de la mémoire
free -h

# Vérifier les workers PHP-FPM actifs
ps aux | grep php-fpm | grep -v grep | wc -l
```

---

## Vérification de l'intégrité Nextcloud

Exécutez la vérification d'intégrité intégrée pour détecter les fichiers principaux modifiés ou manquants :

```bash
sudo -u www-data php /var/www/nextcloud/occ integrity:check-core
```

L'absence de sortie indique que tous les fichiers principaux sont intacts.

---

## Étapes suivantes

| Étape suivante | Page |
|----------------|------|
| Obtenir de l'aide | [[Support-fr]] |
| Mettre à jour Nextcloud | [[Updating-Nextcloud-fr]] |
| Vérifier les services | [[Post-Deployment-Verification-fr]] |
