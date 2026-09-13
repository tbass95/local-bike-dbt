# Local Bike - Synthese Business Data-Driven

**Date** : Septembre 2026
**Auteur** : Analytics Engineering Team
**Destinataire** : Alexander Anthony - Direction Operations

---

## 1. Contexte et objectifs

Local Bike a accumule depuis 2016 des donnees transactionnelles
riches : 4 200 lignes de ventes, 939 lignes de stocks, 1 445 clients,
9 magasins, 10 employes, 321 produits.

Cette masse de donnees represente un actif strategique inexploite.
L'objectif de ce projet est de transformer cette donnee brute en
insights actionnables pour :

- Optimiser les ventes
- Maximiser les revenus
- Reduire les ruptures de stock
- Fideliser les clients a forte valeur

---

## 2. Architecture technique

Un entrepot de donnees structure en modele en etoile a ete construit
sur BigQuery avec DBT :

- 9 modeles de nettoyage (staging)
- 3 modeles de jointures metier (intermediate)
- 7 modeles de structuration (marts core) : 5 dimensions + 2 faits
- 8 modeles d'analyses business (marts analytics)
- 42 tests automatises (unicite, integrite, valeurs metier)

Total : 27 modeles DBT, 42 tests, tous verts.

---

## 3. Analyses business disponibles

### 3.1 Performance commerciale

**sales_by_store**
Question : Quel magasin performe le mieux ?
Metrique : CA total, nombre de commandes, panier moyen
Action : Reaffecter les equipes vers les magasins sous-performants

**sales_by_month**
Question : Quelle est la saisonnalite des ventes ?
Metrique : CA mensuel, evolution annuelle
Action : Anticiper les stocks et les effectifs par saison

**sales_by_staff**
Question : Quel vendeur performe le mieux ?
Metrique : CA genere, commandes traitees
Action : Identifier les best practices, former les autres

### 3.2 Performance produit

**sales_by_product**
Question : Quels produits rapportent le plus ?
Metrique : CA, unites vendues, taux de remise moyen
Action : Concentrer les stocks sur les top produits

**pareto_products**
Question : Quel est le 80/20 du catalogue ?
Metrique : Repartition cumulative du CA
Action : Identifier les 20 pourcent de produits qui font 80 pourcent du CA

**discount_impact**
Question : Les remises sont-elles rentables ?
Metrique : CA brut vs net, taux de remise par tranche
Action : Limiter les remises sur les produits a faible marge

### 3.3 Performance operationnelle

**stock_alerts**
Question : Ou sont les ruptures de stock ?
Metrique : Produits en RUPTURE, CRITIQUE, FAIBLE
Action : Reapprovisionner en urgence les produits en rupture

### 3.4 Performance client

**customer_rfm**
Question : Qui sont mes clients VIP et a risque ?
Metrique : Segmentation RFM (Recence, Frequence, Montant)
Segments : CHAMPION, FIDELE, NOUVEAU_PROMETTEUR,
           A_RISQUE, PERDU, A_REACTIVER
Action : Programme VIP, campagne de reactivation

---

## 4. Recommandations operationnelles

### 4.1 Court terme (0-3 mois)

1. Reapprovisionner les produits en RUPTURE sur les top ventes
2. Lancer un programme VIP pour les segments CHAMPION
3. Auditer les magasins sous-performants
4. Former les vendeurs sur les best practices des tops performers

### 4.2 Moyen terme (3-6 mois)

1. Mettre en place un dashboard Metabase pour le suivi quotidien
2. Optimiser les remises selon l'analyse discount_impact
3. Anticiper les pics saisonniers par un plan de stock
4. Campagne de reactivation des clients A_RISQUE

### 4.3 Long terme (6-12 mois)

1. Prevision des ventes via ML
2. Recommandation produit personnalisee
3. Automatisation du reapprovisionnement
4. Extension du projet a d'autres sources (marketing, web)

---

## 5. Insights attendus (a completer par les resultats)

Apres execution des analyses, les insights cles a documenter :

- Top 3 magasins par CA
- Top 10 produits par CA
- Repartition du CA par categorie
- Segmentation client (nb clients par segment)
- Nombre de produits en rupture
- Taux de remise moyen et son impact

---

## 6. Gouvernance et qualite

- 42 tests automatises valident les donnees a chaque execution
- Documentation interactive disponible via dbt docs serve
- Code versionne sur GitHub
- Pipeline reproductible et scalable

---

## 7. Conclusion

Ce projet transforme Local Bike en entreprise data-driven.
Les 8 analyses business alimentent directement les decisions
operationnelles et permettent un pilotage par la donnee.

Prochaines etapes :
1. Dashboard Metabase pour le suivi quotidien
2. Automatisation des reapprovisionnements
3. Prevision des ventes

---

*Document genere par l'equipe Analytics Engineering*
*Projet DBT : local-bike-dbt*
