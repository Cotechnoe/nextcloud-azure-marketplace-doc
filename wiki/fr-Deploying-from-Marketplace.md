# Déploiement depuis Azure Marketplace

> 🇬🇧 This page is also available in English: [[Deploying-from-Marketplace]]

Cette page vous guide dans le déploiement de la VM **Cotechnoe Cloud Hub** depuis Azure Marketplace,
de la recherche de l'offre jusqu'à une machine virtuelle opérationnelle dans votre abonnement Azure.

---

## Prérequis

- Un abonnement Azure actif avec les droits pour créer des machines virtuelles.
- Un groupe de ressources (existant ou nouveau) dans la région Azure de votre choix.
- Un nom de domaine que vous pourrez pointer vers l'adresse IP publique de la VM (nécessaire pour HTTPS).

---

## Étape 1 — Trouver l'offre sur Azure Marketplace

1. Ouvrez [Azure Marketplace](https://azuremarketplace.microsoft.com/fr-FR/marketplace/apps/cotechnoe.nextcloud-hub).
2. Recherchez **« Cotechnoe Cloud Hub »**.
3. Sélectionnez l'offre et cliquez sur **Obtenir maintenant** (Get It Now).
4. Vous êtes redirigé vers le portail Azure pour créer la VM.

---

## Étape 2 — Configurer la machine virtuelle

Dans l'assistant **Créer une machine virtuelle** du portail Azure, remplissez les onglets suivants :

### Bases (Basics)

| Champ | Valeur recommandée |
|-------|-------------------|
| **Abonnement** | Votre abonnement |
| **Groupe de ressources** | Créer ou utiliser un existant |
| **Nom de la machine virtuelle** | p. ex. `nextcloud-prod` |
| **Région** | La plus proche de vos utilisateurs |
| **Image** | Cotechnoe Cloud Hub (prérempli) |
| **Taille** | Voir le [Guide de dimensionnement VM](https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc/blob/main/docs/vm-sizing-guide-fr.md) |
| **Type d'authentification** | Clé publique SSH (recommandé) |
| **Nom d'utilisateur** | `azureuser` (par défaut) |
| **Clé publique SSH** | Collez votre clé publique |

### Disques (Disks)

- **Type de disque OS :** SSD Premium (recommandé pour la production)
- **Disque de données :** Ajoutez un disque géré d'au moins 64 Go pour le stockage des données Nextcloud (recommandé)

### Réseau (Networking)

| Champ | Valeur recommandée |
|-------|-------------------|
| **Réseau virtuel** | Créer ou utiliser un existant |
| **Adresse IP publique** | Créer une adresse IP publique **statique** |
| **Groupe de sécurité réseau** | De base |
| **Ports entrants publics** | Autoriser les ports sélectionnés : **SSH (22), HTTP (80), HTTPS (443)** |

> **Important :** Utilisez une adresse IP publique **statique** pour que votre nom de domaine
> continue de pointer vers la même adresse après les redémarrages de la VM.

### Gestion (Management)

- Activez **Arrêt automatique** si ce déploiement n'est pas en production, pour contrôler les coûts.

---

## Étape 3 — Vérifier et créer

1. Cliquez sur **Vérifier + créer**.
2. Examinez le récapitulatif de validation — vérifiez qu'aucune erreur n'est affichée.
3. Cliquez sur **Créer**.
4. Azure provisionne la VM — cela prend généralement 3 à 5 minutes.

---

## Vérification

Une fois le déploiement terminé :

1. Accédez à **Machines virtuelles** dans le portail Azure.
2. Trouvez votre VM et confirmez **État : En cours d'exécution**.
3. Copiez l'**adresse IP publique** — vous en aurez besoin dans les prochaines étapes.

---

## Étapes suivantes

| Étape suivante | Page |
|----------------|------|
| Se connecter en SSH | [[fr-SSH-Connection]] |
| Pointer votre domaine vers la VM | [[fr-HTTPS-TLS-Certificate]] |

---

## Résolution de problèmes

**Le déploiement a échoué avec « Quota dépassé »**  
Demandez une augmentation du quota pour le SKU VM souhaité dans la région de votre abonnement.
Voir [Limites de quota Azure](https://learn.microsoft.com/fr-fr/azure/quotas/view-quotas).

**La VM reste bloquée dans l'état « Création » depuis plus de 15 minutes**  
Annulez le déploiement, consultez le journal d'activité pour les détails de l'erreur, puis réessayez.

**Le port SSH (22) est bloqué**  
Vérifiez que le groupe de sécurité réseau autorise le port TCP entrant 22.
Voir [[fr-SSH-Connection]] pour les détails.
