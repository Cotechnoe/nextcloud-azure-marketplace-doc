# Connexion SSH

> 🇬🇧 This page is also available in English: [[SSH-Connection]]

Cette page explique comment vous connecter à votre VM Cotechnoe Cloud Hub via SSH afin de
gérer le serveur et exécuter des commandes d'administration.

---

## Prérequis

- La VM est à l'état **En cours d'exécution** dans le portail Azure.
- Vous avez l'**adresse IP publique** de la VM.
- Vous avez la **clé privée SSH** correspondant à la clé publique utilisée lors du déploiement.

---

## Étape 1 — Trouver l'adresse IP publique de la VM

1. Dans le [portail Azure](https://portal.azure.com), accédez à **Machines virtuelles**.
2. Cliquez sur votre VM.
3. Dans l'onglet **Vue d'ensemble**, copiez l'**adresse IP publique**.

---

## Étape 2 — Se connecter en SSH

### Linux / macOS / Windows (PowerShell ou WSL)

Ouvrez un terminal et exécutez :

```bash
ssh azureuser@<ADRESSE_IP_PUBLIQUE>
```

Remplacez `<ADRESSE_IP_PUBLIQUE>` par l'adresse copiée à l'étape précédente.

**Exemple :**

```bash
ssh azureuser@20.42.100.200
```

Si votre clé privée ne se trouve pas à l'emplacement par défaut (`~/.ssh/id_rsa`), indiquez-la avec `-i` :

```bash
ssh -i /chemin/vers/votre/cle-privee.pem azureuser@<ADRESSE_IP_PUBLIQUE>
```

### Windows (PuTTY)

1. Téléchargez et installez [PuTTY](https://www.putty.org/).
2. Dans PuTTY, saisissez l'adresse IP publique de la VM dans le champ **Host Name**.
3. Sous **Connection > SSH > Auth > Credentials**, naviguez jusqu'à votre fichier de clé privée `.ppk`.
4. Cliquez sur **Open**.

---

## Étape 3 — Accepter la clé d'hôte

À la première connexion, SSH vous demande de vérifier l'empreinte de l'hôte :

```
The authenticity of host '20.42.100.200 (20.42.100.200)' can't be established.
ED25519 key fingerprint is SHA256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

Tapez `yes` et appuyez sur Entrée. L'empreinte est enregistrée dans `~/.ssh/known_hosts`.

---

## Vérification

Après la connexion, vous devriez voir un message de bienvenue et une invite de commande :

```
Welcome to Ubuntu 24.04.x LTS (GNU/Linux ...)
...
azureuser@nextcloud-prod:~$
```

Vous êtes maintenant connecté à la VM et pouvez exécuter des commandes d'administration.

---

## Résolution de problèmes

**`Permission denied (publickey)`**  
- Vérifiez que la bonne clé privée est spécifiée avec `-i`.
- Assurez-vous que les permissions du fichier de clé privée sont restreintes : `chmod 600 /chemin/vers/cle.pem`.

**`Connection refused` ou `Connection timed out`**  
- Vérifiez que le port **22** est autorisé dans le groupe de sécurité réseau (NSG) de la VM.  
  Dans le portail Azure : **VM > Réseau > Règles de port entrant** — confirmez une règle d'autorisation pour le port 22.

**`ssh: connect to host ... port 22: No route to host`**  
- Confirmez que la VM est à l'état **En cours d'exécution** dans le portail Azure.
- Vérifiez que l'adresse IP publique est correcte.

---

## Étapes suivantes

| Étape suivante | Page |
|----------------|------|
| Vérifier que tous les services sont opérationnels | [[Post-Deployment-Verification-fr]] |
| Configurer le certificat HTTPS | [[HTTPS-TLS-Certificate-fr]] |
