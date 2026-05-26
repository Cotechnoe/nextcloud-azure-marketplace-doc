# Certificat HTTPS / TLS

> 🇬🇧 This page is also available in English: [[HTTPS-TLS-Certificate]]

Cette page explique comment obtenir et configurer un certificat TLS gratuit avec Certbot (Let's Encrypt)
afin que votre instance Nextcloud soit accessible via HTTPS avec un certificat valide.

---

## Prérequis

- Les quatre services (Nginx, PHP-FPM, MariaDB, Redis) sont en cours d'exécution — voir [[fr-Post-Deployment-Verification]].
- Vous avez un **nom de domaine pleinement qualifié (FQDN)** (p. ex. `cloud.exemple.com`).
- Votre VM possède une **adresse IP publique statique** (configurée lors du déploiement).
- L'**enregistrement DNS A** de votre domaine pointe vers l'adresse IP statique de la VM.
- Les ports **80** et **443** sont ouverts dans le groupe de sécurité réseau de la VM.

> **Pourquoi une IP statique ?** Si la VM redémarre et que l'IP change, votre domaine ne se résoudra
> plus correctement. Utilisez toujours une IP statique pour les déploiements en production.

---

## Étape 1 — Attribuer une adresse IP publique statique (si ce n'est pas déjà fait)

1. Dans le [portail Azure](https://portal.azure.com), accédez à **Machines virtuelles > [votre VM] > Réseau**.
2. Cliquez sur le lien de l'adresse IP publique.
3. Sous **Configuration**, définissez **Affectation** sur **Statique**.
4. Cliquez sur **Enregistrer**.

---

## Étape 2 — Créer un enregistrement DNS A

Dans le panneau de contrôle de votre fournisseur DNS, créez un **enregistrement A** :

| Champ | Valeur |
|-------|--------|
| **Nom** | `cloud` (ou `@` pour le domaine apex) |
| **Type** | `A` |
| **Valeur** | Adresse IP publique statique de la VM |
| **TTL** | 3600 (ou la valeur par défaut de votre fournisseur) |

Attendez la propagation DNS (généralement 5 à 30 minutes). Vérifiez avec :

```bash
dig cloud.exemple.com +short
# Doit retourner l'adresse IP publique de la VM
```

---

## Étape 3 — Obtenir un certificat TLS avec Certbot

Connectez-vous en SSH à la VM et exécutez Certbot :

```bash
sudo certbot --nginx -d cloud.exemple.com
```

Remplacez `cloud.exemple.com` par votre FQDN réel.

Certbot va :
1. Vérifier la propriété du domaine via le challenge HTTP (le port 80 doit être ouvert).
2. Obtenir un certificat auprès de Let's Encrypt.
3. Configurer automatiquement Nginx pour utiliser HTTPS.
4. Configurer le renouvellement automatique via un timer systemd.

Lorsqu'il vous est demandé, saisissez votre adresse e-mail pour les notifications d'expiration
et acceptez les Conditions d'utilisation.

---

## Étape 4 — Mettre à jour les domaines de confiance Nextcloud

Nextcloud n'accepte que les requêtes provenant de noms de domaine de confiance. Ajoutez votre FQDN :

```bash
sudo -u www-data php /var/www/nextcloud/occ config:system:set trusted_domains 1 --value=cloud.exemple.com
```

Vérifiez la liste des domaines de confiance :

```bash
sudo -u www-data php /var/www/nextcloud/occ config:system:get trusted_domains
```

Résultat attendu :

```
localhost
cloud.exemple.com
```

---

## Étape 5 — Forcer la redirection HTTPS

Assurez-vous que tout le trafic HTTP est redirigé vers HTTPS. Vérifiez votre configuration Nginx :

```bash
sudo nginx -t && sudo systemctl reload nginx
```

Vérifiez que la navigation vers `http://cloud.exemple.com` redirige vers `https://cloud.exemple.com`.

---

## Vérification

1. Ouvrez `https://cloud.exemple.com` dans votre navigateur.
2. Confirmez que le navigateur affiche une **icône de cadenas** (certificat valide).
3. Vérifiez les détails du certificat — l'émetteur doit être **Let's Encrypt**.

---

## Renouvellement du certificat

Certbot renouvelle automatiquement les certificats avant leur expiration. Testez le processus de renouvellement :

```bash
sudo certbot renew --dry-run
```

Les certificats sont renouvelés automatiquement via l'unité systemd `certbot.timer`. Aucune action manuelle n'est nécessaire.

---

## Résolution de problèmes

**Erreur Certbot : « Could not bind to IPv4 or IPv6... port 80 in use »**  
Nginx utilise le port 80. Utilisez le plugin `--nginx` (comme indiqué ci-dessus) qui gère cela automatiquement,
ou arrêtez temporairement Nginx : `sudo systemctl stop nginx`, exécutez Certbot en mode autonome, puis redémarrez.

**Erreur Certbot : « DNS problem: NXDOMAIN looking up A for... »**  
La propagation DNS n'est pas encore terminée. Patientez et réessayez, ou vérifiez l'enregistrement A avec `dig`.

**Le navigateur affiche « Votre connexion n'est pas privée »**  
Nextcloud n'a peut-être pas le FQDN correct dans les domaines de confiance. Répétez l'étape 4.
Vérifiez également que le certificat correspond au domaine : `sudo certbot certificates`.

**Après le renouvellement du certificat, Nginx affiche l'ancien certificat**  
Exécutez : `sudo systemctl reload nginx`

---

## Étapes suivantes

| Étape suivante | Page |
|----------------|------|
| Finaliser la configuration initiale de Nextcloud | [[fr-Configuring-Nextcloud]] |
