# Plan de rédaction — Documentation `Cotechnoe/nextcloud-azure-marketplace-doc`

**Créé :** 2026-05-25  
**Projet :** Nextcloud Hub — Azure Marketplace VM  
**Dépôt cible :** `https://github.com/Cotechnoe/nextcloud-azure-marketplace-doc`  
**ADR de référence :** [`801-BIZ-strategie-documentation-marketplace.md`](https://github.com/Cotechnoe/nextcloud-marketplace/blob/main/docs/adr/801-BIZ-strategie-documentation-marketplace.md) (dépôt `nextcloud-marketplace`)  
**Dépôts inspirants :** `Cotechnoe/fuseki-azure-marketplace-docs`, `Cotechnoe/vivo-azure-marketplace-docs`

---

## 1. Objectif

Ce plan décrit l'ensemble des documents à rédiger pour le dépôt public
`Cotechnoe/nextcloud-azure-marketplace-doc`, qui constitue la documentation de l'offre
**Nextcloud Hub** sur Azure Marketplace, destinée aux administrateurs et équipes IT
des universités et centres de recherche.

Il ne couvre **pas** les ADRs ni la documentation interne du dépôt de build
`nextcloud-marketplace` — ceux-ci font l'objet du plan
`plan-adaptation-adrs-smw-vers-nextcloud.md` dans ce dépôt.

### Public visé par la documentation

| Profil | Besoin |
|--------|--------|
| Administrateur système (université/centre de recherche) | Déployer la VM, vérifier les services, configurer Nextcloud |
| Responsable de plateforme de recherche | Gestion des utilisateurs, quotas, apps, intégration SSO |
| Informaticien institutionnel | TLS, sauvegardes, supervision, mise à jour |

### Politique de langue (ADR 801)

- **English First** : toute page est d'abord rédigée en anglais (version canonique).
- **Français** : traduction dérivée produite à partir de la version anglaise finalisée.
- Les deux versions sont maintenues en tandem (même numéro de commit de synchronisation).

---

## 2. Structure cible du dépôt

Inspirée des dépôts `fuseki-azure-marketplace-docs` et `vivo-azure-marketplace-docs` :

```
nextcloud-azure-marketplace-doc/
├── README.md                        # Index EN + Quick Start + tableau doc
├── README-fr.md                     # Traduction française du README
├── NOTICE.md                        # Crédits, attributions (Nextcloud AGPL-3.0)
├── LICENSE.md                       # Licence de la documentation (CC BY 4.0)
├── PRIVACY.md                       # Avis de confidentialité (RGPD)
├── Makefile                         # Automatisation (lint, preview, sync)
├── .gitignore
├── docs/
│   ├── adr/                         # Architecture Decision Records du projet doc
│   │   ├── TAXONOMY.md              # Taxonomie des ADRs
│   │   ├── README.md                # Index des ADRs
│   │   └── 8xx-BIZ-*.md            # ADRs métier (stratégie, sources, marque)
│   ├── plans/
│   │   └── plan-redaction-doc-nextcloud-azure-marketplace.md   # ce fichier
│   ├── vm-sizing-guide.md           # Tableau SKU Azure vs charge Nextcloud
│   ├── vm-sizing-guide-fr.md
│   ├── nextcloud-apps-guide.md      # Applications Nextcloud recommandées
│   ├── nextcloud-apps-guide-fr.md
│   ├── backup-restore.md            # Sauvegarde et restauration
│   ├── backup-restore-fr.md
│   ├── entra-id-sso.md              # SSO Microsoft Entra ID (SAML/OIDC)
│   ├── entra-id-sso-fr.md
│   ├── monitoring.md                # Supervision et alertes Azure
│   └── monitoring-fr.md
└── wiki/                            # Copies sources des pages wiki (optionnel)
```

---

## 3. Phases de rédaction

### Phase 1 — Fondations du dépôt
**Objectif :** Rendre le dépôt opérationnel avec les fichiers de base et le
README principal. Ces documents sont requis avant que le dépôt soit référencé
dans Partner Center.

| # | Document | Langue | Priorité | Effort | Notes |
|---|----------|--------|----------|--------|-------|
| 1.1 | `README.md` | EN | 🔴 Critique | Modéré | Présentation offre, tableau doc, badge Marketplace, Quick Start 3 étapes |
| 1.2 | `README-fr.md` | FR | 🔴 Critique | Mineur | Traduction de 1.1 |
| 1.3 | `NOTICE.md` | EN | 🟡 Important | Mineur | Crédits Nextcloud GmbH (marque), mention licence AGPL-3.0 de l'app |
| 1.4 | `LICENSE.md` | EN | 🟡 Important | Mineur | CC BY 4.0 pour la documentation elle-même |
| 1.5 | `PRIVACY.md` | EN | 🟡 Important | Modéré | Données collectées par la VM, politique de rétention, contact DPO |
| 1.6 | `Makefile` | — | 🟢 Utile | Modéré | Cibles : `lint`, `preview`, `check-links`, `sync-fr` |

**Dépendances :** Aucune — peut démarrer immédiatement.  
**Critère de complétion :** Le dépôt est listable sur GitHub avec un README clair ; Partner Center peut y être référencé.

---

### Phase 2 — Pages wiki essentielles (flux de déploiement)
**Objectif :** Couvrir le parcours utilisateur principal : déploiement → connexion →
vérification → configuration de base. Ces pages sont vérifiées par Microsoft lors
de la certification.

Ordre de rédaction = ordre du parcours utilisateur.

| # | Page wiki (EN) | Page wiki (FR) | Priorité | Effort | Description |
|---|----------------|----------------|----------|--------|-------------|
| 2.1 | `Home` | `Home-fr` | 🔴 Critique | Modéré | Index navigation, architecture simplifiée (1 VM, multi-services), Quick Start, liens pages |
| 2.2 | `Deploying-from-Marketplace` | `Deploying-from-Marketplace-fr` | 🔴 Critique | Modéré | Paramètres ARM : taille VM, région, user SSH, port 443 ; bouton Deploy |
| 2.3 | `SSH-Connection` | `SSH-Connection-fr` | 🔴 Critique | Mineur | Connexion SSH depuis Windows (PuTTY/Terminal), Linux, macOS |
| 2.4 | `Post-Deployment-Verification` | `Post-Deployment-Verification-fr` | 🔴 Critique | Modéré | Vérifier nginx, PHP-FPM, MariaDB, Redis ; accès HTTPS ; status `occ` |
| 2.5 | `HTTPS-TLS-Certificate` | `HTTPS-TLS-Certificate-fr` | 🔴 Critique | Modéré | Certificat Let's Encrypt auto, renouvellement certbot, cert personnalisé |
| 2.6 | `Configuring-Nextcloud` | `Configuring-Nextcloud-fr` | 🔴 Critique | Majeur | Wizard first-boot vs `occ maintenance:install`, admin, domaine de confiance, stockage |
| 2.7 | `Updating-Nextcloud` | `Updating-Nextcloud-fr` | 🔴 Critique | Modéré | Canal `stable`/`maintenance`, commande `occ upgrade`, Nextcloud Updater web — **l'Updater ne peut pas être désactivé** (condition de conformité marque, §5.4) |

**Dépendances :** Phase 1 (README doit être publié en premier).  
**Critère de complétion :** Un utilisateur peut déployer Nextcloud depuis zéro, accéder à l'interface HTTPS et appliquer une mise à jour.

---

### Phase 3 — Pages wiki d'exploration et de gestion courante
**Objectif :** Permettre à l'utilisateur d'exploiter et d'administrer Nextcloud
au quotidien.

| # | Page wiki (EN) | Page wiki (FR) | Priorité | Effort | Description |
|---|----------------|----------------|----------|--------|-------------|
| 3.1 | `Exploring-Nextcloud` | `Exploring-Nextcloud-fr` | 🟡 Important | Modéré | Navigation interface, Files, Talk, Calendar, Office Online, gestion utilisateurs |
| 3.2 | `Loading-Sample-Data` | `Loading-Sample-Data-fr` | 🟡 Important | Mineur | Upload fichiers d'exemple, partage, lien public — valide le déploiement |
| 3.3 | `Troubleshooting` | `Troubleshooting-fr` | 🟡 Important | Majeur | Top 10 problèmes post-déploiement : port 443, cert expiré, DB connexion, PHP-FPM |
| 3.4 | `Support` | `Support-fr` | 🟡 Important | Mineur | Issues GitHub, forum Nextcloud, support Azure, contact Cotechnoe |
| 3.5 | `Managing-Users` | `Managing-Users-fr` | 🟡 Important | Modéré | Création/suppression de comptes, groupes, quotas, import CSV, réinitialisation mot de passe — cas d'usage université et centre de recherche |
| 3.6 | `Managing-Apps` | `Managing-Apps-fr` | 🟢 Utile | Mineur | Activer/désactiver des apps depuis l'app store officiel Nextcloud — rappel : apps hors app store interdites (§5.4) |

**Dépendances :** Phase 2 complétée.  
**Critère de complétion :** L'utilisateur peut administrer les comptes et les applications, et trouver de l'aide.

---

### Phase 4 — Guides techniques approfondis (dossier `docs/`)
**Objectif :** Répondre aux besoins des administrateurs expérimentés et des
intégrations avancées. Moins urgents pour la certification initiale.

| # | Document | Langue | Priorité | Effort | Description |
|---|----------|--------|----------|--------|-------------|
| 4.1 | `docs/vm-sizing-guide.md` | EN+FR | 🟡 Important | Modéré | Tableau SKU (B2s, D2s_v3, D4s_v3, etc.) vs nb d'utilisateurs, stockage Nextcloud |
| 4.2 | `docs/nextcloud-apps-guide.md` | EN+FR | 🟡 Important | Modéré | Apps recommandées : Collabora Online, Talk, Calendar, Contacts, Two-Factor Auth |
| 4.3 | `docs/backup-restore.md` | EN+FR | 🟡 Important | Majeur | Sauvegarde des données (`/var/www/nextcloud/data`), dump MariaDB, Azure Backup |
| 4.4 | `docs/entra-id-sso.md` | EN+FR | 🟢 Utile | Majeur | Intégration SSO Entra ID (SAML 2.0 / OIDC) — app `user_saml` + configuration Nextcloud |
| 4.5 | `docs/monitoring.md` | EN+FR | 🟢 Utile | Modéré | Azure Monitor, alertes CPU/disk, logs nginx/PHP-FPM, intégration Prometheus |
| 4.6 | `docs/network-security.md` | EN+FR | 🟡 Important | Modéré | Règles NSG Azure (ports 22/80/443 uniquement), fail2ban, désactivation des ports inutilisés, renforcement SSH — recommandations OWASP A05 |

**Dépendances :** Phase 2 et 3 doivent être publiées.  
**Critère de complétion :** Couverture complète des scénarios d'administration avancés, incluant la sécurité réseau.

---

### Phase 5 — Assets marketing et listing Partner Center
**Objectif :** Compléter le dossier de certification Marketplace et préparer le
lancement (Go Live).

| # | Livrable | Priorité | Effort | Description |
|---|----------|----------|--------|-------------|
| 5.1 | Description courte Marketplace (256 car. max) | 🔴 Critique | Mineur | EN + FR — accroche descriptive sans « Nextcloud » dans la formule principale, ex. *« Deploy a fully configured, self-hosted collaboration platform on Azure »* — « Nextcloud » peut figurer dans le corps mais pas comme nom de l'offre (ADR 803, §5.4) |
| 5.2 | Description longue Marketplace (≤ 3000 car.) | 🔴 Critique | Modéré | EN + FR — features, use cases université/recherche, getting started |
| 5.3 | Notes de démarrage rapide Marketplace | 🔴 Critique | Mineur | Texte affiché pendant le déploiement ARM (≤ 500 car.) |
| 5.4 | Screenshots Marketplace (min. 2, max. 5) | 🟡 Important | Modéré | 1280×720 : interface web Nextcloud, tableau bord admin, HTTPS cert |
| 5.5 | Badge Azure Marketplace dans README.md | 🟡 Important | Mineur | Badge officiel GTM Toolkit avec paramètres UTM (ADR 801, Règle 7) |
| 5.6 | Release Notes (première version) | 🟢 Utile | Mineur | Modèle `vivo-azure-marketplace-docs` : new features, improvements, fixes |

**Dépendances :** Phase 1 complétée ; Phase 2 en cours ou terminée.  
**Critère de complétion :** Dossier Partner Center complet, apte à la soumission pour certification Microsoft.

---

## 4. Tableau de bord — Synthèse des livrables

| Phase | Livrables EN | Livrables FR | Priorité max | Effort total estimé |
|-------|:-----------:|:-----------:|:------------:|:--------------------|
| 1 — Fondations | 4 | 1 | 🔴 Critique | ~4 h |
| 2 — Wiki essentielles | 7 pages | 7 pages | 🔴 Critique | ~15 h |
| 3 — Wiki courante | 6 pages | 6 pages | 🟡 Important | ~12 h |
| 4 — Guides techniques | 6 docs | 6 docs | 🟡 Important | ~17 h |
| 5 — Assets Marketplace | 6 | — | 🔴 Critique | ~5 h |
| **Total** | **29** | **20** | — | **~53 h** |

---

## 5. Spécificités Nextcloud à traiter

Ces points distinguent la documentation Nextcloud de celle des autres offres
Cotechnoe (Fuseki, VIVO, SMW) et doivent être traités explicitement.

### 5.1 Architecture multi-services dans une seule VM
La VM déploie simultanément :
- **Nginx** (reverse proxy + TLS)
- **PHP-FPM 8.1+** (avec extensions : gd, curl, mbstring, xml, zip, intl, sodium, pdo_mysql, etc.)
- **MariaDB** (base de données Nextcloud intégrée)
- **Redis** (cache sessions et fichiers verrous — fortement recommandé)

Les guides de vérification (`Post-Deployment-Verification`) doivent couvrir les 4 services.

### 5.2 Wizard de première installation vs `occ`
Deux stratégies possibles — à documenter clairement :
- **Wizard web** : L'utilisateur complète l'installation via `https://<ip>/` au premier démarrage.
- **`occ maintenance:install`** : Pré-configuration automatisée par cloud-init, Nextcloud prêt à l'emploi.

La page `Configuring-Nextcloud` doit expliquer laquelle s'applique à l'image livrée.

### 5.3 Outil CLI `occ`
Central pour l'automatisation et l'administration. À documenter dans chaque guide où il est pertinent :
```bash
sudo -u www-data php /var/www/nextcloud/occ <commande>
```
Exemples : `status`, `maintenance:mode`, `user:list`, `app:install`, `db:convert-filecache-bigint`.

### 5.4 Marque Nextcloud (ADR 803)

Source : [Nextcloud Trademark Guidelines](https://nextcloud.com/trademarks/) (mise à jour juin 2024).

#### Règles d'écriture
- Utiliser « Nextcloud » (avec majuscule), jamais « nextcloud », « Next Cloud » ni « NC ».
- Toujours mentionner « Nextcloud GmbH » comme détenteur de la marque dans `NOTICE.md`.
- Ne pas laisser entendre que Cotechnoe est affilié, sponsorisé ou approuvé par Nextcloud GmbH.

#### Ce qui est interdit sans permission écrite de Nextcloud GmbH
| ❌ Interdit | Règle |  
|------------|-------|
| Utiliser « Nextcloud » dans le **titre de l'offre** Marketplace | Politique 100.7.1 + Trademark Guidelines §Apps and service names |
| Utiliser la marque pour **promouvoir ou annoncer** un service d'hébergement commercial | Trademark Guidelines §Advertising and marketing materials |
| Distribuer une image VM **modifiée** (apps désactivées, apps hors app store, theming personnalisé) et conserver la marque | Trademark Guidelines §Distributing Nextcloud server |
| Désactiver Files, Talk, Updater, l'app Support ou tout composant Nextcloud Hub par défaut | Idem — constitue une version modifiée |

#### Ce qui est permis sans permission
| ✅ Autorisé | Base |
|------------|------|
| Distribuer la VM avec Nextcloud **non modifié** (pré-configuration et apps de l'app store autorisées) | Trademark Guidelines §Distributing Nextcloud server |
| Mentionner « Nextcloud » de façon **descriptive** dans le corps des descriptions et guides (ex. *« This VM includes Nextcloud Hub »*) | Fair use descriptif |
| Référencer la marque dans `NOTICE.md`, `README.md` et la documentation technique pour identifier le logiciel | Fair use |

#### Titre de l'offre (ADR 803)
Le titre retenu **`Cotechnoe Cloud Hub — Secure File Collaboration on Azure`** est conforme.
Ne jamais introduire « Nextcloud » dans le titre sans accord écrit préalable de Nextcloud GmbH.

#### Action recommandée
Contacter Nextcloud GmbH via [nextcloud.com/contact](https://nextcloud.com/contact) pour obtenir une permission formelle d'utiliser la marque dans les matériaux marketing. Cela permettrait d'utiliser « Nextcloud » dans le titre et les publicités, et d'accéder au programme partenaire officiel.

### 5.5 Licence AGPL-3.0 de Nextcloud
Mentionner explicitement dans `NOTICE.md` et le README que :
- Le logiciel Nextcloud est distribué sous licence [AGPL-3.0](https://www.gnu.org/licenses/agpl-3.0.html).
- La documentation Cotechnoe (ce dépôt) est sous licence [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
- L'image VM Cotechnoe est un packaging distinct — ne pas confondre les licences.

### 5.6 Versions Nextcloud
Nextcloud maintient deux branches (ex. NC 29 LTS + NC 30 stable). Documenter :
- Quelle version est embarquée dans l'image publiée.
- La politique de mise à jour (canal `stable`, `maintenance:update` via `occ`).
- Les notes de version dans le README (modèle VIVO : sections *New features*, *Improvements*, *Bug fixes*).

### 5.7 Stockage et quotas
Contrairement à Fuseki ou VIVO, Nextcloud est centré sur le stockage de fichiers.
Documenter dans `vm-sizing-guide.md` :
- Disque de données séparé recommandé (Azure Data Disk) vs disque OS.
- Chemin par défaut : `/var/www/nextcloud/data/`.
- Commande pour déplacer le dossier de données (`occ config:system:set datadirectory`).

### 5.8 TLS et nom de domaine
Let's Encrypt (Certbot) requiert un **FQDN (nom de domaine pleinement qualifié)** pointant vers l'IP publique de la VM. Un déploiement avec IP seule ne peut pas obtenir de certificat automatique.
Documenter dans `HTTPS-TLS-Certificate` :
- **Prérequis DNS** : enregistrement A `nextcloud.mondomaine.ca → IP publique VM` avant de lancer Certbot.
- **Option sans domaine** : certificat auto-signé — avertissement navigateur attendu, à déconseiller en production.
- **IP statique Azure** : recommander une IP publique statique (Azure Public IP — Static SKU) plutôt qu'une IP dynamique susceptible de changer au redémarrage.
- **Domaines de confiance Nextcloud** (`occ config:system:set trusted_domains`) : à synchroniser avec le FQDN utilisé.

---

## 6. Conventions de rédaction

Référence : ADR 801, Règles 3 et 4.

### 6.1 Structure de chaque page wiki

```markdown
# [Titre — verbe d'action ou sujet concret]

> 🇫🇷 Cette page est également disponible en français : [[Page-fr]]

Brève introduction (1-2 phrases) — ce que l'utilisateur va accomplir.

---

## Prerequisites
## Step 1 — [Action]
## Step 2 — [Action]
## Verify
## Troubleshooting   ← optionnel, pour les cas courants liés à cette tâche
```

### 6.2 Paramètres UTM dans les liens vers le listing (ADR 801, Règle 7)

```
https://azuremarketplace.microsoft.com/en-US/marketplace/apps/cotechnoe.nextcloud-hub
  ?ocid=nc_github_readme&utm_source=github&utm_medium=referral&utm_campaign=docs
```

| Contexte | `ocid` | `utm_source` | `utm_medium` |
|----------|--------|-------------|-------------|
| README.md | `nc_github_readme` | `github` | `referral` |
| Home.md wiki | `nc_wiki_home` | `wiki` | `referral` |
| Email support | `nc_support_email` | `email` | `email` |

### 6.3 Nommage des fichiers traduits

| Fichier EN (canonique) | Fichier FR (dérivé) |
|------------------------|---------------------|
| `Deploying-from-Marketplace.md` | `Deploying-from-Marketplace-fr.md` |
| `Configuring-Nextcloud.md` | `Configuring-Nextcloud-fr.md` |
| `docs/vm-sizing-guide.md` | `docs/vm-sizing-guide-fr.md` |

---

## 7. Critères de complétion globale

Le dépôt `Cotechnoe/nextcloud-azure-marketplace-doc` est considéré **prêt pour la
certification Partner Center** quand :

- [ ] `README.md` publié avec badge Marketplace et tableau wiki complet
- [ ] Phases 1 et 2 complétées (fondations + wiki essentielles)
- [ ] Toutes les pages wiki de Phase 2 ont leur traduction française
- [ ] Les URLs wiki sont référencées dans Partner Center (Learn More URL + Support URL)
- [ ] `NOTICE.md` mentionne la marque Nextcloud GmbH et la licence AGPL-3.0
- [ ] Le titre de l'offre Partner Center ne contient pas « Nextcloud » sans accord écrit de Nextcloud GmbH (ADR 803)
- [ ] Les descriptions Marketplace (courte + longue) utilisent « Nextcloud » uniquement de façon descriptive — jamais comme nom de l'offre (§5.4)
- [ ] L'image VM ne modifie pas Nextcloud Server au sens AGPLv3 (aucune app par défaut désactivée, aucune app hors app store installée) — condition nécessaire au droit d'utiliser la marque
- [ ] Aucune référence au dépôt développeur `nextcloud-marketplace` dans les pages publiques
- [ ] Le lien Support URL répond en HTTP 200 (vérifié par la pipeline Partner Center)

La documentation est considérée **complète** quand les Phases 3, 4 et 5 sont
également publiées.

---

## 8. Références

| Document | Lien |
|----------|------|
| ADR 801 — Stratégie documentation Marketplace | [dépôt `nextcloud-marketplace`](https://github.com/Cotechnoe/nextcloud-marketplace/blob/main/docs/adr/801-BIZ-strategie-documentation-marketplace.md) |
| ADR 802 — Sources officielles Azure Marketplace | [dépôt `nextcloud-marketplace`](https://github.com/Cotechnoe/nextcloud-marketplace/blob/main/docs/adr/802-BIZ-sources-officielles-azure-marketplace.md) |
| ADR 803 — Titre offre et conformité marque | [dépôt `nextcloud-marketplace`](https://github.com/Cotechnoe/nextcloud-marketplace/blob/main/docs/adr/803-BIZ-titre-offre-marketplace-conformite-marque.md) |
| Dépôt de référence — Fuseki docs | [`Cotechnoe/fuseki-azure-marketplace-docs`](https://github.com/Cotechnoe/fuseki-azure-marketplace-docs) |
| Dépôt de référence — VIVO docs | [`Cotechnoe/vivo-azure-marketplace-docs`](https://github.com/Cotechnoe/vivo-azure-marketplace-docs) |
| Nextcloud Trademark Guidelines | [`nextcloud.com/trademarks`](https://nextcloud.com/trademarks/) |
| Microsoft Writing Style Guide | [`learn.microsoft.com/style-guide`](https://learn.microsoft.com/en-us/style-guide/welcome/) |
| Partner Center Listing Guidelines | [`learn.microsoft.com/.../marketplace-criteria-content-validation`](https://learn.microsoft.com/en-us/partner-center/marketplace-offers/marketplace-criteria-content-validation) |
