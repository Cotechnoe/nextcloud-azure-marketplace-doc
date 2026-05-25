---
# 🤖 Machine-Readable Metadata (Frontmatter YAML)
adr: 0
title: "Processus de Création et Gestion des ADR"
status: "accepted"
date: 2026-05-25
superseded_by: null
replaces: null
related_adrs: []
related_issues: []

# 🗂️ Taxonomie ADR
classification:
  lifecycle: "accepted"
  domain: "meta"
  impact: "critical"
  quality:
    - "maintainability"
    - "compliance"
  reversibility: "hard"
  scope: "strategic"
  tech_areas:
    - "documentation"
    - "git"

tags: ["process", "documentation", "meta-adr", "governance"]
stakeholders: ["@cotechnoe", "@nextcloud-azure-marketplace-doc"]
effort: "low"
---

# ADR 000: Processus de Création et Gestion des ADR

## ⚠️ Documents Complémentaires Obligatoires

**Ce processus est documenté dans un système cohérent de 4 fichiers à consulter ensemble** :

1. **[ADR-000](./000-META-processus-creation-adr.md)** — Ce fichier (processus et règles)
2. **[TAXONOMY.md](./TAXONOMY.md)** — Classification détaillée
3. **[adr-template.md](./adr-template.md)** — Template pratique
4. **[README.md](./README.md)** — Index et guide rapide

**⚡ Cohérence** : Toute modification des plages de numérotation, domaines ou classification doit être reflétée dans les 4 fichiers.

---

## 📊 Vue d'Ensemble

| Attribut | Valeur |
|----------|--------|
| **Statut** | ✅ Accepté |
| **Date Décision** | 2026-05-25 |
| **Dernière Révision** | 2026-05-25 |
| **Stakeholders** | @cotechnoe |
| **Impact** | 🔴 Critique (fondamental) |
| **Effort Implémentation** | 🟢 Faible |
| **Risque Technique** | 🟢 Faible |

## Statut

✅ Accepté

## Date

2026-05-25

## Contexte

Le projet **nextcloud-azure-marketplace-doc** maintient la documentation publique de l'offre **Cotechnoe Cloud Hub — Secure File Collaboration on Azure**, publiée sur Microsoft Azure Marketplace. Cette documentation est destinée aux administrateurs systèmes qui déploient Nextcloud Hub depuis Azure Marketplace.

Ce projet nécessite une documentation structurée des décisions éditoriales et stratégiques importantes. Les Architecture Decision Records (ADR) sont un moyen éprouvé de capturer le **pourquoi** derrière les décisions de contenu et de gouvernance, facilitant :

- La compréhension des choix éditoriaux par les nouveaux contributeurs
- La traçabilité des décisions dans le temps
- L'évaluation des alternatives considérées
- La documentation des conséquences (positives et négatives)
- La justification des changements futurs
- La conformité aux directives de contenu Microsoft Azure Marketplace

Sans processus formalisé, les décisions restent implicites, rendant difficile :

- La cohérence de la documentation
- La recherche de décisions passées
- La compréhension du contexte historique
- L'évaluation de la pertinence actuelle des décisions

## Décision

Adopter un processus formalisé de création et gestion des ADR basé sur le modèle Michael Nygard, adapté pour **nextcloud-azure-marketplace-doc**.

### Structure des ADR

Chaque ADR suit le template : [`docs/adr/adr-template.md`](./adr-template.md)

Ce template inclut :

#### **Frontmatter YAML obligatoire** (machine-readable)

```yaml
---
adr: XXX
title: "Titre Descriptif"
status: "proposed"  # lifecycle state
date: YYYY-MM-DD
classification:
  lifecycle: "proposed"
  domain: "meta"
  impact: "high"
  quality: ["maintainability", "compliance"]
  reversibility: "moderate"
  scope: "strategic"
  tech_areas: ["documentation", "marketplace"]
tags: ["documentation", "azure-marketplace"]
stakeholders: ["@cotechnoe"]
effort: "medium"
---
```

#### **Sections obligatoires** (human-readable)

```markdown
# ADR XXX: Titre Court et Descriptif

## 📊 Vue d'Ensemble (tableau récapitulatif)

## 🎯 Contexte & Problème
[Description du problème avec questions guidées]

## ✅ Décision
[Solution choisie + principes appliqués]

## ⚖️ Conséquences
### ✅ Positives
### ⚠️ Négatives & Mitigations

## 🔄 Alternatives Considérées
[Options rejetées avec justification]

## 🔗 Références
```

### Numérotation et Convention de Nommage

#### Format Hybride (Numéro + Catégorie + Titre)

**Format standard** : `XXX-CATÉGORIE-titre-kebab-case.md`

**Structure** :
- `XXX` : Numéro séquentiel sur 3 chiffres, **par plage de catégorie**
- `CATÉGORIE` : Préfixe domaine en UPPER-CASE (3-6 lettres)
- `titre-kebab-case` : Titre descriptif en minuscules avec tirets

**Exemples propres au projet** :
```
000-META-processus-creation-adr.md                    # Méta-ADR sur le processus
001-META-definition-projet-nextcloud-azure-marketplace-doc.md  # Définition projet
800-BIZ-strategie-contenu-documentation.md            # Stratégie contenu
801-BIZ-strategie-documentation-marketplace.md        # Documentation Marketplace
```

#### Préfixes Catégories pour ce Projet

**Plages de numérotation réservées** :

| Préfixe | Plage | Domaine | Usage |
|---------|-------|---------|-------|
| `META` | 000-099 | Méta-processus | ADRs sur le processus ADR lui-même, gouvernance projet |
| `BIZ` | 800-899 | Business / Documentation | Stratégie doc, conformité Marketplace, contenu éditorial |

> **Note** : Ce dépôt de documentation n'utilise que deux catégories (META et BIZ). Les catégories INFRA, SEC, DEVOPS, TEST sont réservées au dépôt de build `nextcloud-marketplace` et ne sont pas utilisées ici.

#### Séquence Numérotation

- **ADR 000** : Ce document (méta-ADR sur le processus)
- **Séquence META** : 000-001-002... (décisions de gouvernance)
- **Séquence BIZ** : 800-801-802... (décisions de contenu et stratégie)
- **Ordre de création** : Chronologique au sein de chaque catégorie

### États Possibles (Lifecycle)

| Emoji | État | Description | YAML Value |
|-------|------|-------------|------------|
| 🔄 | Brouillon | En cours de rédaction | `draft` |
| 🔄 | Proposé | Prêt pour revue/validation | `proposed` |
| ✅ | Accepté | Décision approuvée et appliquée | `accepted` |
| ❌ | Rejeté | Proposition refusée (archivée) | `rejected` |
| ⚠️ | Déprécié | Remplacé par un ADR plus récent | `deprecated` |
| ➡️ | Supersédé | Remplacé (référencer l'ADR qui remplace) | `superseded` |

### Workflow de Création

```
1. Identifier le besoin de décision
       ↓
2. Copier adr-template.md avec le prochain numéro disponible
       ↓
3. Rédiger le contexte, la décision, les alternatives
       ↓
4. Commit sur branche feature/adr-XXX
       ↓
5. Pull Request avec revue
       ↓
6. Merge → statut passe à "accepted"
       ↓
7. Mettre à jour README.md (index)
```

### Convention de Commit

```
docs(adr): ADR-XXX [CATÉGORIE] Titre court de la décision
```

Exemples :
```
docs(adr): ADR-003 [META] Politique de gestion des versions wiki
docs(adr): ADR-804 [BIZ] Stratégie de localisation multilingue
```

## Conséquences

**Positives** :
- Traçabilité des décisions éditoriales et stratégiques
- Onboarding facilité pour les nouveaux contributeurs
- Conformité aux directives Microsoft documentée et vérifiable
- Base de connaissance réutilisable pour les futures offres Marketplace

**Contraintes acceptées** :
- Chaque décision importante nécessite la rédaction d'un ADR (effort modéré)
- Le README.md de ce répertoire doit être mis à jour à chaque nouvel ADR

## Références

| Ressource | URL |
|-----------|-----|
| ADR-001 — Définition du projet doc | [./001-META-definition-projet-nextcloud-azure-marketplace-doc.md](./001-META-definition-projet-nextcloud-azure-marketplace-doc.md) |
| Template ADR | [./adr-template.md](./adr-template.md) |
| "Documenting Architecture Decisions" — Michael Nygard | <https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions> |
| Dépôt build (référence) | `Cotechnoe/nextcloud-marketplace` (dépôt privé) |
