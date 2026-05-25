---
# 🤖 Machine-Readable Metadata (Frontmatter YAML)
adr: 2
title: "Agent IA — Contrainte de Non-Hallucination et Usage Vérifié"
status: "accepted"
date: 2026-05-25
superseded_by: null
replaces: null
related_adrs: [0, 1]
related_issues: []

classification:
  lifecycle: "accepted"
  domain: "meta"
  impact: "high"
  quality:
    - "reliability"
    - "maintainability"
    - "compliance"
    - "traceability"
  reversibility: "easy"
  scope: "strategic"
  tech_areas:
    - "ai"
    - "documentation"

tags: ["ia", "agent", "hallucination", "gouvernance", "fiabilité", "vérification", "documentation"]
stakeholders: ["@cotechnoe"]
effort: "low"
---

# ADR-002 : Agent IA — Contrainte de Non-Hallucination et Usage Vérifié

## 📊 Vue d'Ensemble

| Attribut | Valeur |
|----------|--------|
| **Statut** | ✅ Accepté |
| **Date Décision** | 2026-05-25 |
| **Stakeholders** | @cotechnoe |
| **Impact** | 🔴 Élevé |
| **Effort Implémentation** | 🟢 Faible |
| **Risque Technique** | 🟡 Moyen |

---

## 🎯 Contexte & Problème

Les agents IA (GitHub Copilot, Claude, GPT, etc.) sont utilisés activement dans ce projet pour générer de la documentation, des ADRs, et des pages wiki.

Ces outils peuvent **halluciner** — produire des informations factuellement fausses avec une apparente confiance : numéros de versions inventés, URLs inexistantes, paramètres de configuration incorrects, commandes CLI erronées.

Dans le contexte d'une documentation publiée pour **Azure Marketplace**, une hallucination non détectée peut avoir des conséquences directes :
- Documentation utilisateur erronée conduisant à des déploiements défaillants
- Références à des fonctionnalités Nextcloud inexistantes ou obsolètes
- URLs de support invalides → échec de certification Microsoft
- Informations de conformité incorrectes (politique 100.7.1, trademark guidelines)
- Perte de confiance des utilisateurs clients Marketplace

**Besoin central** : établir une règle de projet claire encadrant l'usage des agents IA, afin que toute contribution générée par IA soit vérifiable, sourcée, et validée avant publication.

---

## 💡 Décision

**Tout contenu généré par un agent IA et intégré dans ce dépôt doit reposer sur des faits vérifiés à partir de sources primaires officielles.** L'agent IA ne peut pas affirmer ou documenter une information technique sans être en mesure de la sourcer.

### Règles opérationnelles

#### 1. Sourçage obligatoire pour les informations techniques

Toute information technique produite par l'IA doit être fondée sur au moins une source primaire officielle consultée pendant la session :

| Type d'information | Source primaire acceptable |
|--------------------|---------------------------|
| Versions logicielles (Nextcloud, PHP, MariaDB, Nginx…) | Site officiel du projet, releases GitHub |
| Documentation Nextcloud (occ, config.php, apps) | `nextcloud.com`, `docs.nextcloud.com`, `github.com/nextcloud/server` |
| Commandes CLI (`occ`, `certbot`, `systemctl`…) | Documentation officielle de l'outil |
| Exigences Azure Marketplace | `learn.microsoft.com/azure/marketplace` |
| Politiques de certification Microsoft | `learn.microsoft.com/legal/marketplace/certification-policies` |
| Style et ton de la documentation | [Microsoft Writing Style Guide](https://learn.microsoft.com/style-guide/welcome/) |
| Paramètres ARM template exposés au client | Documentation Partner Center ou dépôt build (via demande) |

#### 2. Interdiction d'inventer des références

L'agent IA **ne doit pas** :
- Citer une URL sans l'avoir consultée (ou sans pouvoir la vérifier)
- Affirmer un numéro de version sans le sourcer
- Proposer un paramètre de commande en supposant son existence
- Générer un lien vers un ADR, une issue, ou une page wiki qui n'existe pas encore
- Documenter un comportement de l'image VM sans confirmation depuis le dépôt build

#### 3. Signal explicite en cas d'incertitude

Quand l'agent IA ne peut pas vérifier une information, il doit le signaler explicitement :

```
⚠️ Non vérifié : cette information n'a pas été confirmée depuis une source primaire.
Vérifier avant publication : <URL ou commande de vérification>
```

#### 4. Validation humaine obligatoire avant publication

Toute page wiki ou document généré par IA passe par une relecture humaine avant publication. La relecture porte notamment sur :
- La cohérence des numéros de versions avec l'état réel de l'offre
- La validité des URLs et des commandes documentées
- La conformité du ton avec le Microsoft Writing Style Guide
- L'absence de références au dépôt développeur (voir ADR-801 Règle 5)

#### 5. Périmètre de cette règle

Cette règle s'applique à **tous les artefacts** : pages wiki Markdown, ADRs, README, guides techniques, tout contenu publié dans ce dépôt ou dans la wiki associée.

---

## ⚖️ Alternatives Évaluées

### 1. Confiance implicite dans l'agent IA

Utiliser le contenu généré tel quel, sans vérification systématique.

**Rejeté** : les modèles LLM produisent régulièrement des hallucinations confiantes sur des sujets techniques spécifiques (versions, APIs, configuration). Le risque est inacceptable pour une documentation référencée dans Partner Center.

### 2. Bannir les agents IA du projet

N'utiliser aucun outil IA dans la chaîne de rédaction.

**Rejeté** : les agents IA apportent une productivité réelle pour la génération d'ADRs, la traduction EN→FR, la détection d'incohérences. Les bannir est disproportionné ; les encadrer est suffisant.

---

## ✅ Conséquences

### Positives

- **Fiabilité** : les artefacts intégrés sont fondés sur des faits vérifiables
- **Traçabilité** : chaque information technique est associée à une source consultable
- **Confiance dans la documentation** : les pages wiki peuvent être citées avec assurance dans les échanges avec Microsoft Partner Center
- **Détection d'erreurs** : le processus de vérification révèle les versions conflictuelles et docs obsolètes

### Contraintes à gérer

- **Ralentissement ponctuel** : vérifier chaque information depuis une source primaire allonge le temps de génération (acceptable)
- **L'IA peut ne pas avoir accès à internet** : l'agent doit signaler explicitement qu'il travaille depuis sa connaissance interne d'entraînement
- **Connaissance d'entraînement ≠ hallucination** : si l'agent cite sa connaissance d'entraînement en le signalant clairement, c'est conforme à cette règle

---

## 🔗 Références

| Ressource | URL |
|-----------|-----|
| ADR-000 — Processus de création des ADRs | [./000-META-processus-creation-adr.md](./000-META-processus-creation-adr.md) |
| ADR-001 — Définition du projet nextcloud-azure-marketplace-doc | [./001-META-definition-projet-nextcloud-azure-marketplace-doc.md](./001-META-definition-projet-nextcloud-azure-marketplace-doc.md) |
| ADR-802 — Sources officielles Azure Marketplace | [./802-BIZ-sources-officielles-azure-marketplace.md](./802-BIZ-sources-officielles-azure-marketplace.md) |
| Microsoft Writing Style Guide | <https://learn.microsoft.com/en-us/style-guide/welcome/> |
| Nextcloud documentation officielle | <https://docs.nextcloud.com> |
