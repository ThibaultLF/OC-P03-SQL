# OC-P03-Base_de_données_immobilière

[![Language](https://img.shields.io/badge/SQL-darkblue.svg?style=flat&logo=SQL&logoColor=white)](https://sql.sh/cours/optimize)
[![MySQL](https://img.shields.io/badge/MySQL-darkorange.svg?style=flat&logo=mysql&logoColor=white)](https://www.mysql.com/fr/)

Création et utilisation d'une base de données immobilière. Retrouver dans le dossier *Code_sql* les fichiers:
- *Creation_projetoc.sql* permet de créer la base de données dans MySQL;
- *import_donnee.sql*  permet d'importer les données dans la base créée précédemment;
- *Requete_projet_oc_export_resultat.sql* les différentes requêtes demandées dans le projet.

## Scénario du projet

Vous êtes data analyst chez Laplace Immo, un réseau national d’agences immobilières. Le directeur général est sensible depuis quelque temps à l’importance des données, et il pense que l’agence doit se démarquer de la concurrence en créant un modèle pour mieux prévoir le prix de vente des biens immobiliers. 
Ce projet stratégique est appelé en interne le projet « DATAImmo ». La CTO de l’entreprise, Clara Daucourt, a la responsabilité de conduire le projet. Dans ce cadre, elle vous a confié la création de la base de données permettant de collecter les transactions immobilières et foncières en France. Vous utiliserez ensuite cette base pour analyser le marché et aider les différentes agences à mieux accompagner leurs clients.

### Besoins en analyse de données:
À la demande de François Lapeyre, il faut extraire les données suivantes via des requêtes SQL sur les données :
1. Nombre total d’appartements vendus au 1er semestre 2020;
2. Proportion des ventes d’appartements par le nombre de pièces;
3. Liste des 10 départements où le prix du mètre carré est le plus élevé;
4. Prix moyen du mètre carré d’une maison en Île-de-France;
5. Liste des 10 appartements les plus chers avec le département et le nombre de mètres carrés;
6. Taux d’évolution du nombre de ventes entre le premier et le second trimestre de 2020;
7. Liste des communes où le nombre de ventes a augmenté d'au moins 20% entre le premier et le second trimestre de 2020;
8. Différence en pourcentage du prix au mètre carré entre un appartement de 2 pièces et un appartement de 3 pièces;
9. Les moyennes de valeurs foncières pour le top 3 des communes des départements 6, 13, 33, 59 et 69;

### **Livrable:**
1. Dictionnaire des données (*DicoVar.xlsx*);  
2. Modèle conceptuel des données (*UML.drawio*);
3. Schéma relationnel normalisé (*MPD_IMMO.architect*);
4. Code SQL pour répondre aux requêtes.


## Réalisation du projet

### Préparation des données
Le jeu de données est extrait des demandes de valeurs foncières fourni par le gouvernement (*DAN-P3-data.xlsx*). Après analyse des différentes requêtes demandées, nous conserverons les données listées dans le dictionnaire des données. Le traitement du fichier excel est effectué avec Power Query:
- Création des 4 tables; 
- Modifications du type de données; 
- Colonnes inutiles supprimées; 
- Création des clés primaires;
- Fusion des requêtes pour les clés étrangères;
- Suppression des doublons là où c’est nécessaire;
- Le tout est alors exporté au format CSV.

### Création, Implémentation, Requête.
A l'aide des fichiers contenus dans le dossier *Code_sql*, vous pourrez créer la base de données, implémenter les données et enfin réaliser les différentes requêtes demandées.