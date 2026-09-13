# Local Bike Analytics Engineering Project

Projet DBT complet pour transformer Local Bike en entreprise data-driven.

## Objectif

Fournir a l'equipe operations des insights strategiques pour optimiser les ventes, maximiser les revenus, ameliorer la gestion des stocks et fideliser les clients.

## Stack technique

DBT pour la transformation, BigQuery comme entrepot de donnees cloud, SQL pour 100 pourcent des transformations, Metabase pour la visualisation.

## Architecture

Modele en etoile organise en 3 couches.

### Couches

staging : Nettoyage des donnees brutes (9 modeles)
intermediate : Jointures metier (3 modeles)
marts core : Dimensions et Faits (7 modeles)
marts analytics : Analyses business (8 modeles)

### Schema en etoile

Tables de faits : fact_sales, fact_stocks
Dimensions : dim_customers, dim_products, dim_stores, dim_staffs, dim_date

## Analyses business disponibles

sales_by_store : Quel magasin performe le mieux
sales_by_product : Quels produits rapportent le plus
sales_by_month : Quelle est la saisonnalite
sales_by_staff : Quel vendeur performe le mieux
customer_rfm : Qui sont mes clients VIP et a risque
stock_alerts : Ou sont les ruptures de stock
discount_impact : Les remises sont-elles rentables
pareto_products : Quel est mon 80/20

## Installation

Prerequis : Python 3.9 plus, un compte Google Cloud avec BigQuery active, un service account avec les roles BigQuery Admin.

Setup en 7 etapes :

1. Cloner le repo
2. Creer un venv : python3 -m venv .venv
3. Activer : source .venv/bin/activate
4. Installer : pip install dbt-bigquery
5. Configurer le fichier profiles.yml dans .dbt
6. Installer les packages : dbt deps
7. Lancer les modeles : dbt run

## Tests

Le projet contient 42 tests DBT. Lancer avec : dbt test

## Documentation

Generer la documentation interactive avec dbt docs generate puis dbt docs serve. Ouvrir ensuite http://localhost:8080

## Auteur

Projet realise dans le cadre de la transformation data-driven de Local Bike.

## Licence

Projet prive Local Bike 2026
