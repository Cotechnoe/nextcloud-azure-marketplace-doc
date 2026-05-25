# Surveillance

> 🇬🇧 This page is also available in English: [Monitoring](monitoring.md)

Ce guide couvre les stratégies de surveillance pour votre déploiement Nextcloud sur Azure,
incluant les alertes Azure Monitor, l'inspection des journaux et les métriques Prometheus légères.

---

## Vérification de santé intégrée

Vérifiez l'état général de Nextcloud à tout moment :

```bash
sudo -u www-data php /var/www/nextcloud/occ status
sudo -u www-data php /var/www/nextcloud/occ integrity:check-core
```

Vérifier les quatre services :

```bash
sudo systemctl is-active nginx php8.1-fpm mariadb redis-server
```

---

## Azure Monitor — Métriques VM

Azure Monitor collecte automatiquement les métriques au niveau hôte pour toutes les VMs Azure.

### Activer les alertes recommandées

1. Ouvrez le **Portail Azure** et accédez à votre VM.
2. Sélectionnez **Surveillance > Alertes > + Créer > Règle d'alerte**.
3. Ajoutez les conditions d'alerte recommandées suivantes :

| Métrique | Seuil | Gravité |
|----------|-------|---------|
| Pourcentage CPU | > 85% pendant 5 min | Grav. 2 (Avertissement) |
| Octets mémoire disponibles | < 512 Mo | Grav. 2 (Avertissement) |
| % IOPS consommées du disque OS | > 90% pendant 5 min | Grav. 1 (Critique) |
| % IOPS consommées du disque de données | > 90% pendant 5 min | Grav. 1 (Critique) |
| Total réseau entrant | Référence personnalisée | Grav. 3 (Information) |

4. Définissez un **Groupe d'actions** pour envoyer des notifications par e-mail ou webhook.

### Activer les métriques invité (Détaillées)

Pour les métriques mémoire et par processus, activez l'**Agent Azure Monitor** :

```bash
# Installer l'extension Azure Monitor Agent via Azure CLI
az vm extension set \
  --resource-group "<votre-rg>" \
  --vm-name "<votre-vm>" \
  --name AzureMonitorLinuxAgent \
  --publisher Microsoft.Azure.Monitor \
  --version 1.0
```

---

## Inspection des journaux

### Journaux Nginx

```bash
# Journal d'accès (requêtes récentes)
sudo tail -f /var/log/nginx/access.log

# Journal d'erreurs
sudo tail -f /var/log/nginx/error.log

# Compter les erreurs 5xx dans les 100 dernières lignes
sudo tail -100 /var/log/nginx/access.log | grep -c ' 5[0-9][0-9] '
```

### Journaux PHP-FPM

```bash
sudo journalctl -u php8.1-fpm -n 50 --no-pager
```

### Journaux MariaDB

```bash
sudo journalctl -u mariadb -n 50 --no-pager

# Vérifier les requêtes lentes (si le journal des requêtes lentes est activé)
sudo tail -f /var/log/mysql/mariadb-slow.log
```

### Journal d'application Nextcloud

```bash
sudo tail -f /var/www/nextcloud/data/nextcloud.log | python3 -m json.tool
```

Définir le niveau de journalisation (0=DEBUG, 1=INFO, 2=WARN, 3=ERROR, 4=FATAL) :

```bash
sudo -u www-data php /var/www/nextcloud/occ config:system:set loglevel --value=2 --type=integer
```

---

## Surveillance de l'espace disque

Nextcloud arrêtera d'accepter les téléversements quand le disque de données est plein.
Surveillez l'utilisation du disque avec :

```bash
df -h
```

Configurer une alerte simple basée sur cron :

```bash
# /etc/cron.daily/disk-check
#!/bin/bash
THRESHOLD=85
USAGE=$(df /var/www/nextcloud/data | awk 'NR==2 {print $5}' | tr -d '%')
if [ "$USAGE" -gt "$THRESHOLD" ]; then
  echo "Avertissement : le disque de données Nextcloud est à ${USAGE}% sur $(hostname)" \
    | mail -s "Alerte disque : Nextcloud" admin@exemple.com
fi
```

---

## Prometheus + Métriques Nextcloud (Optionnel)

Pour une surveillance avancée, le **nextcloud-exporter** expose les métriques Nextcloud
au format Prometheus.

### Activer les informations serveur Nextcloud

```bash
sudo -u www-data php /var/www/nextcloud/occ config:system:set \
  token_auth_enforced --value=false --type=boolean
```

Créer un utilisateur de surveillance et générer un mot de passe d'application :

```bash
sudo -u www-data php /var/www/nextcloud/occ user:add monitoring --display-name="Surveillance"
# Ensuite générer un mot de passe d'application dans Paramètres > Sécurité > Mots de passe d'application
```

### Déployer nextcloud-exporter

```bash
docker run -d \
  --name nextcloud-exporter \
  -p 9205:9205 \
  -e NEXTCLOUD_SERVER="https://cloud.exemple.com" \
  -e NEXTCLOUD_USERNAME="monitoring" \
  -e NEXTCLOUD_PASSWORD="<mot-de-passe-app>" \
  xperimental/nextcloud-exporter
```

Métriques clés exposées :

| Métrique | Description |
|----------|-------------|
| `nextcloud_users_total` | Total d'utilisateurs enregistrés |
| `nextcloud_active_users_total` | Utilisateurs actifs (5 dernières min) |
| `nextcloud_files_total` | Total de fichiers stockés |
| `nextcloud_free_space_bytes` | Espace libre dans le répertoire de données |
| `nextcloud_php_memory_limit_bytes` | Limite mémoire PHP |

---

## Guides connexes

- [Résolution des problèmes](../wiki/Troubleshooting-fr.md) — Résoudre les problèmes détectés lors de la surveillance
- [Sauvegarde et restauration](backup-restore-fr.md) — Alertes sur les échecs de sauvegarde
- [Guide de dimensionnement des VMs](vm-sizing-guide-fr.md) — Adapter la taille basé sur les données de surveillance
