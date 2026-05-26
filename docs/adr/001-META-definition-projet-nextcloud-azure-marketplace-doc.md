---
# 🤖 Machine-Readable Metadata (Frontmatter YAML)
adr: 1
title: "Définition et Cadrage du Projet nextcloud-azure-marketplace-doc"
status: "accepted"
date: 2026-05-25
superseded_by: null
replaces: null
related_adrs: [801]
related_issues: []

# 🗂️ Taxonomie ADR
classification:
  lifecycle: "accepted"
  domain: "meta"
  impact: "high"
  quality:
    - "maintainability"
    - "compliance"
    - "usability"
  reversibility: "moderate"
  scope: "strategic"
  tech_areas:
    - "documentation"
    - "azure"
    - "marketplace"
    - "nextcloud"

tags: ["project-definition", "scope", "strategy", "documentation", "marketplace", "nextcloud"]
stakeholders: ["@cotechnoe"]
effort: "medium"
---

# ADR 001: Définition et Cadrage du Projet nextcloud-azure-marketplace-doc

## 📋 Vue d'Ensemble

| Attribut | Valeur |
|----------|--------|
| **Statut** | ✅ Accepté |
| **Date décision** | 2026-05-25 |
| **Impact** | 🔴 Élevé (décision fondatrice — cadre tous les autres ADRs) |
| **Domaine** | META |
| **Réversibilité** | 🟡 Modérée |
| **Portée** | Projet complet |

## 🎯 Définition du Projet

> **Le projet `nextcloud-azure-marketplace-doc` maintient la documentation publique de l'offre Azure Marketplace "Cotechnoe Cloud Hub — Secure File Collaboration on Azure". Cette documentation est destinée aux administrateurs systèmes qui déploient Nextcloud Hub directement depuis Azure Marketplace et ont besoin de guides opérationnels pour configurer, sécuriser, utiliser et dépanner leur instance.**

## 🎯 Contexte et Problème

### Situation de départ

L'offre **Cotechnoe Cloud Hub — Secure File Collaboration on Azure** est publiée sur Microsoft Azure Marketplace. Les clients (universités, centres de recherche, organismes publics, entreprises) déploient une VM Nextcloud Hub directement dans leur abonnement Azure.

Ces clients ont besoin d'une documentation :
- **Opérationnelle** : comment se connecter, vérifier les services, configurer Nextcloud, gérer le TLS
- **En anglais** (langue canonique), avec traduction française disponible
- **Accessible publiquement** via les URLs référencées dans Partner Center (Support URL, Learn More URL)
- **Conforme aux directives Microsoft** pour la certification et le maintien de l'offre

**Problème** : Sans dépôt de documentation dédié, structuré et publiquement accessible, l'offre ne peut pas passer la certification Microsoft (champ Support URL obligatoire) et les clients n'ont pas les ressources nécessaires pour utiliser l'offre avec succès.

### Relation avec le dépôt de build

Ce projet de documentation est **distinct mais complémentaire** du dépôt de build `Cotechnoe/nextcloud-marketplace` :

| Dépôt | Rôle | Audience | Visibilité |
|-------|------|----------|------------|
| `Cotechnoe/nextcloud-marketplace` | Build de l'image VM (Packer, scripts, CI/CD) | Équipe de développement | Privé |
| `Cotechnoe/nextcloud-azure-marketplace-doc` | Documentation utilisateur finale | Administrateurs clients Marketplace | Public |

Les modifications techniques dans le dépôt de build qui affectent l'expérience utilisateur (nouvelle fonctionnalité, changement de comportement au premier démarrage, mise à jour TLS) **déclenchent une mise à jour obligatoire** de ce dépôt de documentation.

## 💡 Décision

**Nous maintenons un dépôt GitHub public dédié à la documentation utilisateur finale** (`Cotechnoe/nextcloud-azure-marketplace-doc`), séparé du dépôt de build, avec une structure claire et des règles de contenu strictes (voir ADR-801).

### Périmètre de ce Dépôt

**Contenu dans scope** :
- `README.md` : présentation de l'offre, accès rapide aux pages wiki, badge Marketplace
- `docs/` : guides longs en format Markdown (guides de configuration institutionnelle, etc.)
- `docs/adr/` : décisions architecturales de ce projet de documentation

**Contenu hors scope** :
- Scripts de build Packer ou Makefile
- Détails d'implémentation de l'image VM (ARM/Bicep internes, variables d'environnement)
- ADRs d'infrastructure, de sécurité VM, ou de DevOps (ils restent dans `nextcloud-marketplace`)
- Processus de publication Partner Center (aspect build)

### Audience cible

Les utilisateurs de cette documentation sont :

| Profil | Description | Besoin documentaire |
|--------|-------------|---------------------|
| **Administrateur système** | Déploie et maintient la VM Nextcloud | SSH, services, TLS, mises à jour |
| **Responsable de plateforme de recherche** | Configure Nextcloud pour une équipe | Administration, apps, stockage |
| **Informaticien institutionnel** | Intègre Nextcloud dans l'infrastructure | SSO, LDAP, networking |
| **Responsable de déploiement** | Déploie depuis Marketplace | ARM template parameters, first steps |

Ces utilisateurs :
- **ne sont pas** les développeurs du dépôt `nextcloud-marketplace`
- n'ont **pas accès** au dépôt de build
- attendent une documentation **opérationnelle**, axée sur l'utilisation, **en anglais**

### Structure des URLs Publiques

| Ressource | URL | Référencé dans Partner Center |
|-----------|-----|-------------------------------|
| Page principale | `github.com/Cotechnoe/nextcloud-azure-marketplace-doc` | Learn More URL |
| Wiki opérationnel | `github.com/Cotechnoe/nextcloud-azure-marketplace-doc/wiki` | Support URL |

### Offre documentée

| Attribut | Valeur |
|----------|--------|
| **Titre de l'offre** | Cotechnoe Cloud Hub — Secure File Collaboration on Azure |
| **Éditeur Marketplace** | Cotechnoe |
| **Type d'offre** | Azure Virtual Machine |
| **Logiciel embarqué** | Nextcloud Hub (dernière version stable) |
| **OS** | Ubuntu 24.04 LTS |
| **Stack** | Nginx + PHP-FPM + MariaDB 10.6+ + Redis (optionnel) |
| **Modèle de licence** | BYOS (Bring Your Own Subscription) — image gratuite |
| **Segments cibles** | Universités, centres de recherche, organismes publics, PME |

## 🔒 Contraintes de Contenu

| Contrainte | Description | Source |
|------------|-------------|--------|
| **Support URL valide** | La wiki URL doit être accessible 24/7 depuis un navigateur public | Microsoft Partner Center |
| **English First** | Documentation canonique en anglais | ADR-801 |
| **Microsoft Writing Style Guide** | Ton, structure, vocabulaire conformes | ADR-801 |
| **Pas de liens vers le dépôt build** | Aucune référence à `nextcloud-marketplace`, scripts Packer | ADR-801 Règle 5 |
| **Pas de contenu développeur** | Aucun ADR interne, aucune variable d'implémentation | ADR-801 Règle 1 |

## ⚖️ Conséquences

**Positives** :
- Certification Microsoft satisfaite (Support URL valide et maintenu)
- Expérience utilisateur cohérente pour les clients Marketplace
- Séparation claire entre documentation interne et documentation client
- Maintenabilité à long terme grâce aux ADRs de gouvernance

**Contraintes acceptées** :
- La documentation doit être mise à jour à chaque changement dans le build qui affecte l'UX
- Maintenance de deux langues (EN canonique + FR traduction)
- Aucune génération automatique depuis le code source (risque de fuite de contenu développeur)

## 🔗 Références

| Ressource | URL |
|-----------|-----|
| ADR-000 — Processus ADR | [./000-META-processus-creation-adr.md](./000-META-processus-creation-adr.md) |
| ADR-801 — Stratégie documentation | [./801-BIZ-strategie-documentation-marketplace.md](./801-BIZ-strategie-documentation-marketplace.md) |
| ADR-803 — Titre offre et conformité marque | [./803-BIZ-titre-offre-marketplace-conformite-marque.md](./803-BIZ-titre-offre-marketplace-conformite-marque.md) |
| Dépôt de build (référence) | `Cotechnoe/nextcloud-marketplace` (privé) |
| Partner Center — Marketplace offers | <https://learn.microsoft.com/en-us/partner-center/marketplace-offers/> |
