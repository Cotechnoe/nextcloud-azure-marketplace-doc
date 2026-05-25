# 📚 Architecture Decision Records (ADR) — nextcloud-azure-marketplace-doc

**Index central** de toutes les décisions architecturales du projet **nextcloud-azure-marketplace-doc**.

> Ce projet maintient la documentation publique de l'offre **Cotechnoe Cloud Hub — Secure File Collaboration on Azure**, publiée sur Microsoft Azure Marketplace. La documentation est destinée aux administrateurs qui déploient Nextcloud Hub depuis Azure Marketplace et doivent configurer, utiliser et dépanner leur instance.

---

## 🗂️ Documents du Système ADR

| Document | Description |
|----------|-------------|
| **[ADR-000](./000-META-processus-creation-adr.md)** | Processus et règles de création des ADRs |
| **[TAXONOMY.md](./TAXONOMY.md)** | Classification détaillée des ADRs |
| **[adr-template.md](./adr-template.md)** | Template à copier pour un nouvel ADR |
| **[README.md](./README.md)** | Ce fichier (index et guide rapide) |

---

## ⚡ Créer un Nouvel ADR Rapidement

```bash
# 1. Identifier la catégorie (META 000-099 ou BIZ 800-899)
# 2. Trouver le prochain numéro disponible dans la plage
ls -1 docs/adr/0*.md | tail -1   # Exemple: bloc META (000-099)

# 3. Créer le fichier depuis le template
cp docs/adr/adr-template.md docs/adr/003-META-nouvelle-decision.md

# 4. Rédiger, committer et mettre à jour ce README
git add docs/adr/003-META-nouvelle-decision.md docs/adr/README.md
git commit -m "docs(adr): ADR-003 [META] Nouvelle décision"
```

---

## 📋 Index des ADRs par Catégorie

### 🔧 META — Méta-processus (000-099)

| ADR | Titre | Statut | Date | Domaine |
|-----|-------|--------|------|---------|
| [000](./000-META-processus-creation-adr.md) | Processus de Création et Gestion des ADR | ✅ Accepté | 2026-05-25 | Gouvernance |
| [001](./001-META-definition-projet-nextcloud-azure-marketplace-doc.md) | Définition et Cadrage du Projet nextcloud-azure-marketplace-doc | ✅ Accepté | 2026-05-25 | Gouvernance |
| [002](./002-META-agent-ia-non-hallucination.md) | Agent IA — Contrainte de Non-Hallucination et Usage Vérifié | ✅ Accepté | 2026-05-25 | Gouvernance |

---

### 💼 BIZ — Business & Documentation (800-899)

| ADR | Titre | Statut | Date | Domaine |
|-----|-------|--------|------|---------|
| [801](./801-BIZ-strategie-documentation-marketplace.md) | Stratégie de Documentation — Offre Azure Marketplace (utilisateur final) | ✅ Accepté | 2026-05-25 | Documentation |
| [802](./802-BIZ-sources-officielles-azure-marketplace.md) | Sources Officielles Azure Marketplace — Référentiel Anti-Hallucination IA | ✅ Accepté | 2026-05-25 | Documentation |
| [803](./803-BIZ-titre-offre-marketplace-conformite-marque.md) | Titre Offre Azure Marketplace — Conformité Marques Tierces | ✅ Accepté | 2026-05-25 | Conformité |

---

## 🔗 Relations avec le Projet Build

Ces ADRs de documentation sont complémentaires (mais indépendants) des ADRs du dépôt de build :

| ADR (doc repo) | ADR correspondant (build repo) | Nature de la relation |
|----------------|--------------------------------|-----------------------|
| ADR-001 (définition doc) | ADR-001 build repo | Projet distinct, but complémentaire |
| ADR-801 (stratégie doc) | ADR-801 build repo | Importé et adapté — repo doc est la portée cible |
| ADR-802 (sources) | ADR-802 build repo | Importé et adapté — sources communes |
| ADR-803 (titre/marque) | ADR-803 build repo | Importé et adapté — conformité commune |

> **Note** : Les ADRs d'infrastructure (INFRA), de sécurité VM (SEC), de DevOps (DEVOPS) et de tests (TEST) du dépôt build ne sont **pas** importés ici — ils concernent la fabrication de l'image VM, hors scope de ce dépôt de documentation.
