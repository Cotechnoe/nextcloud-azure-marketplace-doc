# Sécurité réseau

> 🇬🇧 This page is also available in English: [Network Security](network-security.md)

Ce guide couvre le renforcement de la sécurité réseau pour votre VM Nextcloud sur Azure,
incluant les règles NSG, le durcissement SSH et les en-têtes de sécurité au niveau application.

---

## Groupe de sécurité réseau Azure (NSG)

La VM déployée depuis Azure Marketplace inclut un NSG préconfiguré. Vérifiez et appliquez
les règles entrantes suivantes :

### Règles entrantes requises

| Priorité | Nom | Port | Protocole | Source | Action |
|----------|-----|------|-----------|--------|--------|
| 100 | Allow-HTTPS | 443 | TCP | Tout | Autoriser |
| 110 | Allow-HTTP-Redirect | 80 | TCP | Tout | Autoriser |
| 120 | Allow-SSH | 22 | TCP | Votre IP | Autoriser |
| 4096 | Deny-All-Inbound | * | Tout | Tout | Refuser |

> **Note de sécurité :** Restreignez SSH (port 22) à votre adresse IP spécifique ou plage CIDR
> plutôt qu'à `Tout (*)` pour réduire l'exposition aux attaques par force brute.

### Mettre à jour les règles NSG via Azure CLI

```bash
# Restreindre SSH à une IP spécifique
az network nsg rule update \
  --resource-group "<votre-rg>" \
  --nsg-name "<votre-nsg>" \
  --name "Allow-SSH" \
  --source-address-prefix "203.0.113.0/24"
```

### Refuser tout autre trafic entrant

```bash
az network nsg rule create \
  --resource-group "<votre-rg>" \
  --nsg-name "<votre-nsg>" \
  --name "Deny-All-Inbound" \
  --priority 4096 \
  --direction Inbound \
  --access Deny \
  --protocol "*" \
  --source-address-prefix "*" \
  --destination-port-range "*"
```

---

## Durcissement SSH

### Désactiver l'authentification par mot de passe

Modifiez `/etc/ssh/sshd_config` :

```bash
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
```

### Désactiver la connexion root

```bash
sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
```

### Recharger le service SSH

```bash
sudo systemctl reload sshd
```

---

## fail2ban — Protection contre la force brute

Installez et configurez fail2ban pour bloquer les tentatives de connexion échouées répétées :

```bash
sudo apt-get install -y fail2ban
```

Créer une configuration de prison pour SSH :

```bash
sudo tee /etc/fail2ban/jail.d/nextcloud-ssh.conf > /dev/null << 'EOF'
[sshd]
enabled  = true
port     = 22
filter   = sshd
logpath  = /var/log/auth.log
maxretry = 5
bantime  = 3600
findtime = 600
EOF
```

Activer fail2ban pour les tentatives de connexion Nextcloud (nécessite l'analyse des journaux Nginx) :

```bash
sudo tee /etc/fail2ban/filter.d/nextcloud.conf > /dev/null << 'EOF'
[Definition]
failregex = ^<HOST>.*"(GET|POST).*" (401|403) .*$
            .*Login failed: .*Remote IP: '<HOST>'.*
ignoreregex =
EOF

sudo tee /etc/fail2ban/jail.d/nextcloud-http.conf > /dev/null << 'EOF'
[nextcloud]
enabled  = true
port     = http,https
filter   = nextcloud
logpath  = /var/log/nginx/access.log
           /var/www/nextcloud/data/nextcloud.log
maxretry = 10
bantime  = 3600
findtime = 600
EOF
```

```bash
sudo systemctl enable --now fail2ban
```

---

## En-têtes de sécurité HTTP (Nginx)

La configuration Nginx de Nextcloud inclut déjà les en-têtes de sécurité recommandés.
Vérifiez qu'ils sont présents dans la configuration de votre hôte virtuel :

```bash
sudo grep -A 20 "server {" /etc/nginx/sites-enabled/nextcloud
```

Assurez-vous que les en-têtes suivants sont configurés :

```nginx
add_header Strict-Transport-Security "max-age=15768000; includeSubDomains; preload" always;
add_header X-Content-Type-Options "nosniff" always;
add_header X-Frame-Options "SAMEORIGIN" always;
add_header X-XSS-Protection "1; mode=block" always;
add_header Referrer-Policy "no-referrer" always;
add_header Permissions-Policy "geolocation=(),midi=(),sync-xhr=(),microphone=(),camera=(),magnetometer=(),gyroscope=(),fullscreen=(self),payment=()" always;
```

Après toute modification de la configuration Nginx :

```bash
sudo nginx -t && sudo systemctl reload nginx
```

---

## Scan de sécurité Nextcloud

Exécutez le scanner de sécurité officiel Nextcloud contre votre instance :

```
https://scan.nextcloud.com
```

Traitez tous les problèmes de gravité **Critique** et **Élevée** avant la mise en production.

---

## Certificats de confiance

Assurez-vous que seuls les certificats d'autorité de certification de confiance sont acceptés
pour les appels HTTPS sortants de Nextcloud :

```bash
sudo -u www-data php /var/www/nextcloud/occ security:certificates
```

Importer un CA spécifique si nécessaire :

```bash
sudo -u www-data php /var/www/nextcloud/occ security:certificates:import /chemin/vers/ca.crt
```

---

## Liste de contrôle de durcissement OWASP

| Catégorie OWASP | Atténuation appliquée |
|-----------------|----------------------|
| A01 — Contrôle d'accès défaillant | Règle NSG Deny-All ; fail2ban |
| A02 — Défaillances cryptographiques | HTTPS imposé ; en-tête HSTS |
| A05 — Mauvaise configuration de sécurité | Durcissement SSH ; en-têtes de sécurité |
| A07 — Échecs d'authentification | fail2ban ; auth par mot de passe désactivée |
| A09 — Journalisation insuffisante | Journaux Nginx + Nextcloud ; alertes Azure Monitor |

---

## Guides connexes

- [HTTPS / Certificat TLS](../wiki/HTTPS-TLS-Certificate-fr.md) — Configurer Let's Encrypt
- [Surveillance](monitoring-fr.md) — Configurer des alertes pour activités suspectes
- [SSO Entra ID](entra-id-sso-fr.md) — Remplacer l'auth par mot de passe avec SSO Entra ID
