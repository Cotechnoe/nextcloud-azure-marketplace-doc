---
# 🤖 Machine-Readable Metadata (Frontmatter YAML)
adr: 803
title: "Titre Offre Azure Marketplace — Conformité Marques Tierces (Microsoft & Wikimedia)"
status: "accepted"
date: 2026-05-25
superseded_by: null
replaces: null
related_adrs: [801, 802]
related_issues: []

# 🗂️ Taxonomie ADR
classification:
  lifecycle: "accepted"
  domain: "biz"
  impact: "high"
  quality:
    - "compliance"
    - "usability"
  reversibility: "easy"
  scope: "tactical"
  tech_areas:
    - "azure"
    - "marketplace"
    - "partner-center"

tags: ["azure-marketplace", "certification", "partner-center", "trademark", "listing-title", "100.1.1.1", "100.7.1"]
stakeholders: ["@cotechnoe"]
effort: "low"
---

# ADR 803 : Titre Offre Azure Marketplace — Conformité Marques Tierces (Microsoft & Wikimedia)

## 📊 Vue d'Ensemble

| Attribut | Valeur |
|----------|--------|
| **Statut** | ✅ Accepté |
| **Date Décision** | 2026-05-25 |
| **Stakeholders** | @cotechnoe |
| **Impact** | 🔴 Élevé (bloquant certification) |
| **Effort Implémentation** | 🟢 Faible (changement Partner Center) |
| **Risque Technique** | 🟢 Faible |

---

## 🎯 Contexte & Problème

### Problème

Lors de la soumission du 05/20/2026, le rapport de certification Azure Marketplace a retourné le
statut **"Attention needed"** avec l'erreur suivante :

> **100.1.1.1 — Inaccurate title**  
> "The offer listing contains Microsoft trademarked or copyrighted material in [Listing Title]."

Le titre soumis était : **`Nextcloud Hub Cloud Edition — Azure Virtual Machines`**

L'expression **"Azure Virtual Machines"** est une marque déposée de Microsoft. Son utilisation
directe dans le titre d'une offre tierce est interdite par la politique de contenu Microsoft
Marketplace.

Ce blocage s'est produit à **cinq reprises** :

| # | Date | Titre soumis | Erreur |
|---|------|-------------|--------|
| 1 | 05/19/2026 | `Nextcloud Hub — Azure VM` | 100.7.1 (révision initiale) |
| 2 | 05/20/2026 | `Nextcloud Hub Cloud Edition — Azure Virtual Machines` | 100.1.1.1 |
| 3 | 05/20/2026 | `Nextcloud Hub Cloud Edition — Collaboration Platform for Azure` | 100.7.1 |
| 4 | 05/21/2026 | `Cotechnoe Nextcloud Hub — Self-Hosted Cloud Platform` | 100.7.1 |
| 5 | 05/21/2026 | `Cotechnoe Cloud Hub — Secure File Collaboration on Azure` | ✅ Accepté |

### Diagnostic

Les rejets #1 à #4 ont permis d'identifier deux sources de non-conformité distinctes :

1. **Marque Microsoft** : les termes "Azure", "Azure VM", "Azure Virtual Machines" dans le titre
   déclenchent la politique **100.1.1.1**.

2. **Marque Nextcloud GmbH** : le terme **"Nextcloud"** est une marque déposée de
   **Nextcloud GmbH**, enregistrée dans plusieurs juridictions. Son utilisation dans le titre
   d'un produit commercial sur Azure Marketplace sans accord explicite peut violer la politique
   **100.7.1** (clause IP tierce).

> **Note** : Le message d'erreur indique "Microsoft trademarked" mais c'est un template
> générique — la politique 100.7.1 couvre **toute propriété intellectuelle tierce**, pas
> uniquement les marques Microsoft.

### Contraintes

- **Microsoft Marketplace Policy 100.7.1** : Interdit l'utilisation de toute propriété
  intellectuelle tierce sans autorisation — marques Microsoft (ex. "Azure") ET marques
  d'autres organisations.
- **Nextcloud GmbH Trademark** : "Nextcloud" est une marque déposée de Nextcloud GmbH.
  Son utilisation dans le nom d'un produit commercial nécessite une vérification des
  [Trademark Guidelines](https://nextcloud.com/trademarks/). Les termes descriptifs
  comme "cloud", "hub", "collaboration" sont génériques.
- **Règle 100.1.1.1** : Pour un logiciel repackagé, le nom de l'éditeur ("Cotechnoe") doit
  apparaître dans le titre.
- **"Cloud" — terme générique** : Selon la [Wikimedia Foundation Trademark Policy](https://foundation.wikimedia.org/wiki/Policy:Wikimedia_Foundation_Trademark_Policy),
  "cloud" est un terme commun descriptif sans protection distinctive, conforme à l'article 3.1
  du contrat éditeur Microsoft (General Listing Policies).

---

## ✅ Décision

### Titre retenu

> **`Cotechnoe Cloud Hub — Secure File Collaboration on Azure`**

### Justification

| Critère | Explication |
|---------|-------------|
| **Conformité marque** | Évite le terme "Nextcloud" dans le titre ; utilise des termes génériques : "Cloud Hub", "Collaboration", "Secure" |
| **Éditeur visible** | "Cotechnoe" satisfait la règle 100.1.1.1 (logiciel repackagé) |
| **Différenciation** | "Secure File Collaboration" décrit l'usage final ; "on Azure" positionne la plateforme sans utiliser la marque "Azure Virtual Machines" |
| **Concision** | 47 caractères — lisible dans les listes de résultats Marketplace (max 200 chars) |

### Règle générale à retenir

| ❌ Interdit | ✅ Autorisé |
|------------|------------|
| `... Azure Virtual Machines ...` | Termes descriptifs génériques (Cloud, Platform, Hub) |
| `Nextcloud Hub ...` dans le titre | Nom de l'éditeur (Cotechnoe) |
| `... for Azure` avec marque Microsoft | `... on Azure` — formulation descriptive |
| `File Sharing` (trop générique) | `Secure File Collaboration` (différenciant) |

---

## 📋 Implémentation

**Chemin Partner Center** :  
`Marketplace offers → Cotechnoe Cloud Hub → Offer listing → Listing title`

**Valeur à saisir** : `Cotechnoe Cloud Hub — Secure File Collaboration on Azure`

**Action** : Modifier le champ, sauvegarder, republier l'offre.

---

## 📚 Références

- [Microsoft Marketplace General Listing and Offer Policies — §100](https://learn.microsoft.com/en-us/legal/marketplace/certification-policies#100-general)
- [Azure VM Certification Policies — §100.1.1.1](https://learn.microsoft.com/en-us/legal/marketplace/certification-policies#1001-vm-images)
- [Wikimedia Foundation Trademark Policy](https://foundation.wikimedia.org/wiki/Policy:Wikimedia_Foundation_Trademark_Policy) — "cloud" est un terme commun non protégé
- [Nextcloud Trademark Guidelines](https://nextcloud.com/trademarks/) — vérifier usage commercial autorisé

---

## 📐 Relation avec les Autres ADRs

| ADR | Titre | Relation |
|-----|-------|----------|
| [ADR-801](./801-BIZ-strategie-documentation-marketplace.md) | Stratégie Documentation Marketplace | ADR-803 **applique** la politique de conformité marque définie dans ADR-801 (règle 1 : English First, titres marketplace) |
| [ADR-802](./802-BIZ-sources-officielles-azure-marketplace.md) | Sources Officielles Marketplace | ADR-803 **s'appuie** sur les sources canoniques ADR-802 pour interpréter les politiques 100.1.1.1 et 100.7.1 |

---

## ✅ Conséquences

### Positif

- Certification Azure Marketplace débloquée — offre visible publiquement
- Titre conforme à la politique 100.1.1.1 (éditeur présent) et 100.7.1 (IP tierce évitée)
- Titre descriptif centré sur la proposition de valeur utilisateur

### Négatif / Mitigation

- Le titre n'inclut pas "Nextcloud" → potentielle moindre reconnaissance immédiate
- **Mitigation** : "Nextcloud" reste présent dans la description, le summary, et les mots-clés de
  l'offre — seul le titre du listing est contraint. La description doit mentionner Nextcloud Hub
  en toutes lettres dès la première phrase.
