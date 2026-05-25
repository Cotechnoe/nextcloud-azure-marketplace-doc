# Monitoring

> 🇫🇷 Cette page est également disponible en français : [Surveillance](monitoring-fr.md)

This guide covers monitoring strategies for your Nextcloud deployment on Azure,
including Azure Monitor alerts, log inspection, and lightweight Prometheus metrics.

---

## Built-in Health Check

Check the overall status of Nextcloud at any time:

```bash
sudo -u www-data php /var/www/nextcloud/occ status
sudo -u www-data php /var/www/nextcloud/occ integrity:check-core
```

Check all four services:

```bash
sudo systemctl is-active nginx php8.1-fpm mariadb redis-server
```

---

## Azure Monitor — VM Metrics

Azure Monitor collects host-level metrics automatically for all Azure VMs.

### Enable Recommended Alerts

1. Open the **Azure Portal** and navigate to your VM.
2. Select **Monitoring > Alerts > + Create > Alert rule**.
3. Add the following recommended alert conditions:

| Metric | Threshold | Severity |
|--------|-----------|----------|
| CPU Percentage | > 85% for 5 min | Sev 2 (Warning) |
| Available Memory Bytes | < 512 MB | Sev 2 (Warning) |
| OS Disk IOPS Consumed % | > 90% for 5 min | Sev 1 (Critical) |
| Data Disk IOPS Consumed % | > 90% for 5 min | Sev 1 (Critical) |
| Network In Total | Custom baseline | Sev 3 (Informational) |

4. Set **Action Group** to send email or webhook notifications.

### Enable Guest Metrics (Detailed)

For memory and per-process metrics, enable the **Azure Monitor Agent**:

```bash
# Install Azure Monitor Agent extension via Azure CLI
az vm extension set \
  --resource-group "<your-rg>" \
  --vm-name "<your-vm>" \
  --name AzureMonitorLinuxAgent \
  --publisher Microsoft.Azure.Monitor \
  --version 1.0
```

---

## Log Inspection

### Nginx Logs

```bash
# Access log (recent requests)
sudo tail -f /var/log/nginx/access.log

# Error log
sudo tail -f /var/log/nginx/error.log

# Count 5xx errors in the last 100 lines
sudo tail -100 /var/log/nginx/access.log | grep -c ' 5[0-9][0-9] '
```

### PHP-FPM Logs

```bash
sudo journalctl -u php8.1-fpm -n 50 --no-pager
```

### MariaDB Logs

```bash
sudo journalctl -u mariadb -n 50 --no-pager

# Check for slow queries (if slow query log is enabled)
sudo tail -f /var/log/mysql/mariadb-slow.log
```

### Nextcloud Application Log

```bash
sudo tail -f /var/www/nextcloud/data/nextcloud.log | python3 -m json.tool
```

Set log level (0=DEBUG, 1=INFO, 2=WARN, 3=ERROR, 4=FATAL):

```bash
sudo -u www-data php /var/www/nextcloud/occ config:system:set loglevel --value=2 --type=integer
```

---

## Disk Space Monitoring

Nextcloud will stop accepting uploads when the data disk is full.
Monitor disk usage with:

```bash
df -h
```

Set up a simple cron-based alert:

```bash
# /etc/cron.daily/disk-check
#!/bin/bash
THRESHOLD=85
USAGE=$(df /var/www/nextcloud/data | awk 'NR==2 {print $5}' | tr -d '%')
if [ "$USAGE" -gt "$THRESHOLD" ]; then
  echo "Warning: Nextcloud data disk is ${USAGE}% full on $(hostname)" \
    | mail -s "Disk Alert: Nextcloud" admin@example.com
fi
```

---

## Prometheus + Nextcloud Metrics (Optional)

For advanced monitoring, the **nextcloud-exporter** exposes Nextcloud metrics
in Prometheus format.

### Enable Nextcloud Server Info

```bash
sudo -u www-data php /var/www/nextcloud/occ config:system:set \
  token_auth_enforced --value=false --type=boolean
```

Create a monitoring user and generate an app password:

```bash
sudo -u www-data php /var/www/nextcloud/occ user:add monitoring --display-name="Monitoring"
# Then generate an app password in Settings > Security > App passwords
```

### Deploy nextcloud-exporter

```bash
docker run -d \
  --name nextcloud-exporter \
  -p 9205:9205 \
  -e NEXTCLOUD_SERVER="https://cloud.example.com" \
  -e NEXTCLOUD_USERNAME="monitoring" \
  -e NEXTCLOUD_PASSWORD="<app-password>" \
  xperimental/nextcloud-exporter
```

Key metrics exposed:

| Metric | Description |
|--------|-------------|
| `nextcloud_users_total` | Total registered users |
| `nextcloud_active_users_total` | Active users (last 5 min) |
| `nextcloud_files_total` | Total files stored |
| `nextcloud_free_space_bytes` | Free space in data directory |
| `nextcloud_php_memory_limit_bytes` | PHP memory limit |

---

## Related Guides

- [Troubleshooting](../wiki/Troubleshooting.md) — Resolve issues found during monitoring
- [Backup and Restore](backup-restore.md) — Alert on backup failures
- [VM Sizing Guide](vm-sizing-guide.md) — Right-size based on monitoring data
