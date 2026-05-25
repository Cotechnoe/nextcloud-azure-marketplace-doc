# 🗂️ Taxonomie ADR — Guide de Classification

**Version**: 2.0  
**Date**: 2026-05-25  
**Projet**: nextcloud-azure-marketplace-doc  
**Basée sur**: Bonnes pratiques industrie (AWS, Azure, GitHub ADR Organization)

---

## ⚠️ Documents Complémentaires

**Ce document fait partie d'un système cohérent de 4 fichiers** :

1. **[ADR-000](./000-META-processus-creation-adr.md)** — Processus et numérotation
2. **[TAXONOMY.md](./TAXONOMY.md)** — Ce fichier (classification détaillée)
3. **[adr-template-ai-optimized.md](./adr-template-ai-optimized.md)** — Template pratique
4. **[README.md](./README.md)** — Index et vue d'ensemble

**⚡ IMPORTANT** : Toute modification de classification ici doit être reflétée dans le template et ADR-000.

---

## 📋 Vue d'Ensemble

Cette taxonomie permet de **classifier chaque ADR selon 7 dimensions** pour :
- ✅ Faciliter la recherche et le filtrage
- ✅ Permettre le parsing automatique par agents IA
- ✅ Construire des graphes de dépendances
- ✅ Générer des dashboards automatiques

**Format** : Frontmatter YAML dans chaque ADR (voir `adr-template-ai-optimized.md`)

> **Périmètre doc repo** : Ce dépôt ne gouverne que les décisions de documentation.
> Les ADRs de type ARCH, INFRA, SEC, DATA, API, DEVOPS, TEST restent dans le dépôt build
> [`Cotechnoe/nextcloud-marketplace`](https://github.com/Cotechnoe/nextcloud-marketplace).

---

## 🔍 Les 7 Dimensions de Classification

### 1️⃣ Lifecycle (Cycle de Vie)

**État actuel de l'ADR dans son cycle de vie**

| Valeur | Description | Emoji | Usage |
|--------|-------------|-------|-------|
| `draft` | Rédaction en cours, peut contenir TODOs | 🔄 | ADR incomplet |
| `proposed` | Prêt pour review équipe | 🔄 | En attente validation |
| `accepted` | Décision approuvée et en vigueur | ✅ | Implémenté |
| `rejected` | Proposition refusée (archivée) | ❌ | Non retenu |
| `deprecated` | Obsolète mais pas remplacé | ⚠️ | À retirer |
| `superseded` | Remplacé par nouvel ADR | ➡️ | Référencer nouveau |

**Exemple** :
```yaml
classification:
  lifecycle: "accepted"
```

---

### 2️⃣ Domain (Domaine)

**Domaine principal concerné**

**Plages de numérotation réservées par domaine** :

| Préfixe | Plage | Domaine | Exemples ADR nextcloud-azure-marketplace-doc |
|---------|-------|---------|----------------------------------------------|
| `META` | 000-099 | Méta-processus, gouvernance, IA | ADR-000 : Processus ADR ; ADR-002 : Non-hallucination IA |
| `BIZ` | 800-899 | Stratégie documentation, conformité Marketplace, marques | ADR-801 : Stratégie doc ; ADR-803 : Titre offre |

> Les plages 100-799 et 900-999 **ne sont pas utilisées dans ce dépôt**.
> Si un besoin documentaire ne rentre pas dans META ou BIZ, ouvrir une discussion avec @cotechnoe.

**Descriptions par domaine** :

| Valeur | Description | Exemples contexte nextcloud-azure-marketplace-doc |
|--------|-------------|---------------------------------------------------|
| `meta` | Gouvernance du processus ADR, contraintes IA | Processus création ADR, anti-hallucination |
| `biz` | Stratégie documentation, conformité Marketplace, marques | Titre offre, sources canoniques, politique bilingue |

**Exemple** :
```yaml
classification:
  domain: "biz"
```

**Règle** : Choisir **UN seul domaine principal** (le plus impacté).

---

### 3️⃣ Impact (Niveau d'Impact)

**Ampleur de l'impact sur le projet documentation**

| Valeur | Description | Critères | Réversibilité Typique |
|--------|-------------|----------|----------------------|
| `low` | Impact local, facilement réversible | Changement d'une seule page ou section | Easy |
| `medium` | Plusieurs pages/sections, effort modéré | Mise à jour multi-pages, synchronisation EN/FR | Moderate |
| `high` | Politique globale, breaking change | Changement de structure, politique de langue | Hard |
| `critical` | Fondamental, irréversible | Changement d'identité de l'offre | Irreversible |

**Aide décision (contexte nextcloud-azure-marketplace-doc)** :
- **Low** : Correction d'un screenshot, ajout d'une note informative
- **Medium** : Ajout d'une section entière au wiki, changement de style de rédaction
- **High** : Changement de politique bilingue, refonte de la structure wiki
- **Critical** : Changement du titre de l'offre Marketplace (impacte la certification)

---

### 4️⃣ Quality Attributes (Attributs Qualité - ASR)

**Qualités affectées (basé sur ISO 25010)**

| Valeur | Description | Métriques Typiques | Pertinence nextcloud-azure-marketplace-doc |
|--------|-------------|-------------------|--------------------------------------------|
| `usability` | Clarté, accessibilité, lisibilité | Temps de résolution d'un problème utilisateur | Pages wiki claires pour IT admins |
| `compliance` | Légal, marques, politiques Microsoft | Résultat certification Partner Center | Respect trademark, policies 100.x |
| `maintainability` | Cohérence, facilité de mise à jour | Temps de sync EN↔FR par release | Processus de mise à jour maîtrisé |
| `reliability` | Exactitude du contenu, liens valides | % liens brisés, erreurs factuelles détectées | Sources canoniques vérifiées |
| `traceability` | Liens ADR→issue→commit | Couverture des décisions documentées | ADRs liés aux issues GitHub |
| `portability` | Indépendance vis-à-vis du dépôt build | Aucune référence interne build repo | Contenu publiable sans build repo |

**Exemple** :
```yaml
classification:
  quality:
    - "compliance"
    - "usability"
    - "maintainability"
```

---

### 5️⃣ Reversibility (Facilité de Changement)

**Effort requis pour changer cette décision**

| Valeur | Effort | Durée Typique | Dépendances |
|--------|--------|---------------|-------------|
| `easy` | Très faible | < 1 jour | Aucune ou locale |
| `moderate` | Moyen | 1-5 jours | Quelques pages/sections |
| `hard` | Élevé | > 1 semaine | Impact sur plusieurs ADRs |
| `irreversible` | Impossible/Prohibitif | Migration complète | Changement d'offre Marketplace |

**Aide décision (contexte nextcloud-azure-marketplace-doc)** :
- **Easy** : Mise à jour d'un screenshot, correction d'un lien
- **Moderate** : Changement de politique de rédaction (affecte pages existantes)
- **Hard** : Changement de structure du wiki (affecte tous les liens entrants)
- **Irreversible** : Changement d'Offer ID dans Partner Center (immuable)

---

### 6️⃣ Scope (Portée)

**Niveau stratégique de la décision**

| Valeur | Description | Horizon Temporel | Niveau |
|--------|-------------|------------------|--------|
| `strategic` | Vision long terme, organisation-wide | 3-5 ans | Direction Cotechnoe |
| `tactical` | Implémentation spécifique, projet-wide | 6-18 mois | Responsable doc |
| `operational` | Choix locaux, composant-level | 1-6 mois | Rédacteur |

**Aide décision (contexte nextcloud-azure-marketplace-doc)** :
- **Strategic** : Choix du canal de distribution (Marketplace vs site direct)
- **Tactical** : Politique bilingue EN/FR, structure wiki, titre de l'offre
- **Operational** : Choix d'un outil de traduction, ordre des pages dans la barre latérale

---

### 7️⃣ Tech Areas (Domaines Technologiques)

**Technologies/plateformes/outils concernés** (liste libre)

#### Cloud & Marketplace
- `azure`, `marketplace`, `partner-center`

#### Nextcloud Stack (référence uniquement)
- `nextcloud`, `mariadb`, `nginx`, `php-fpm`, `redis`

#### Documentation & Publication
- `wiki`, `documentation`, `markdown`

#### Marketing & Analytics
- `gtm`, `utm`, `ocid`, `analytics`

**Exemple** :
```yaml
classification:
  tech_areas:
    - "azure"
    - "marketplace"
    - "partner-center"
```

---

## 📊 Exemple Complet

### ADR-801 : Stratégie Documentation Marketplace

```yaml
---
adr: 801
title: "Stratégie Documentation — Politique de Contenu User-Facing pour l'Offre Marketplace"
status: "accepted"
date: 2026-05-25

classification:
  lifecycle: "accepted"
  domain: "biz"
  impact: "high"
  quality:
    - "usability"
    - "maintainability"
    - "compliance"
  reversibility: "moderate"
  scope: "strategic"
  tech_areas:
    - "azure"
    - "marketplace"
    - "nextcloud"
    - "wiki"

tags: ["azure-marketplace", "documentation", "english-first", "microsoft-style-guide"]
stakeholders: ["@cotechnoe"]
effort: "medium"
---
```

---

## 🔎 Cas d'Usage

### Recherche par Domain
```bash
# Tous les ADRs BIZ
grep -l 'domain: "biz"' docs/adr/*.md
```

### Filtrage par Impact
```bash
# ADRs à impact élevé seulement
grep -l 'impact: "high"' docs/adr/*.md
```

### ADRs concernant la conformité Marketplace
```bash
grep -l '"compliance"' docs/adr/*.md
```

### Recherche par tech_area marketplace
```bash
grep -l '"marketplace"' docs/adr/*.md
```

---

## ✅ Checklist Validation Classification

Avant d'accepter un ADR, vérifier :

- [ ] **Lifecycle** : État cohérent avec contenu ADR
- [ ] **Domain** : `meta` ou `biz` uniquement (pas d'autres domaines dans ce dépôt)
- [ ] **Impact** : Niveau justifié dans section Conséquences
- [ ] **Quality** : ≥ 1 attribut qualité listé
- [ ] **Reversibility** : Cohérent avec impact et scope
- [ ] **Scope** : Aligné avec stakeholders et horizon
- [ ] **Tech Areas** : ≥ 1 technologie listée (pas de `packer`, `bicep`, `azure-devops`)
- [ ] **Aucune référence build repo** : Règle 5 ADR-801 — pas de chemins internes, pas de `Cotechnoe/nextcloud-marketplace` dans le contenu destiné aux utilisateurs

---

## 🏷️ Convention Nommage Fichiers (Format Hybride)

### Format Standard

**Pattern** : `XXX-CATÉGORIE-titre-kebab-case.md`

### Exemples nextcloud-azure-marketplace-doc

```
000-META-processus-creation-adr.md                           # META : 000-099
001-META-definition-projet-nextcloud-azure-marketplace-doc.md # META : 000-099
002-META-agent-ia-non-hallucination.md                       # META : 000-099
801-BIZ-strategie-documentation-marketplace.md               # BIZ  : 800-899
802-BIZ-sources-officielles-azure-marketplace.md             # BIZ  : 800-899
803-BIZ-titre-offre-marketplace-conformite-marque.md         # BIZ  : 800-899
```

### Commandes Recherche par Catégorie

```bash
# ADRs META
ls -1 docs/adr/*-META-*.md

# ADRs BIZ
ls -1 docs/adr/*-BIZ-*.md

# Comptage par catégorie
ls -1 docs/adr/*.md | grep -oE "[A-Z]+" | sort | uniq -c
```

---

## 📚 Références

### Standards Industrie
- **ISO 25010** : System and software quality models
- **Microsoft Writing Style Guide** : [learn.microsoft.com/en-us/style-guide](https://learn.microsoft.com/en-us/style-guide/welcome/)
- **Microsoft Azure Marketplace** : [VM Offer Requirements](https://learn.microsoft.com/en-us/partner-center/marketplace-offers/marketplace-virtual-machines)

### Bonnes Pratiques ADR
- [Joel Parker Henderson — ADR GitHub](https://github.com/joelparkerhenderson/architecture-decision-record)
- [ADR.github.io](https://adr.github.io/)
- [AWS Prescriptive Guidance](https://docs.aws.amazon.com/prescriptive-guidance/latest/architectural-decision-records/)

---

## 📝 Notes

**Évolution** : Cette taxonomie peut évoluer avec le projet. Si changement majeur de classification, créer un nouvel ADR META et superseder ADR-000.

**Contexte spécifique nextcloud-azure-marketplace-doc** : La classification `compliance` est particulièrement importante dans ce projet en raison des exigences strictes de certification Microsoft Azure Marketplace (politiques 100.1.1.1 et 100.7.1) et des contraintes de marques tierces (Nextcloud GmbH, Microsoft).

---

**Version** : 2.0  
**Maintenu par** : @cotechnoe  
**Dernière mise à jour** : 2026-05-25  
**Projet** : nextcloud-azure-marketplace-doc
