![picto](/doc/img/Logo_web-GeoCompiegnois.png)

# Documentation d'administration de la base #

## Principes
 * **généralité** :
 Il n'y a pas à proprement dit de base de données propres pour générer l'application grand public Plan Interactif. Il s'agit plutôt d'un transfert de données existantes afin d'être consultable dans une application dédiée à partir d'une recherche d'adresse.
 
 * **résumé fonctionnel** :
Les données exploitées sont soient transférées en l'état ou soient retravaillées (calcul, forme, ...) sous forme de vues applicatives. Les données sont stockées sur un serveur Postgres déporté du prestataire de service GEO. Le transfert des données de la base de production (maitre) de l'Agglomération de la Région de Compiègne et la base déportée (esclave) a lieu tous les jours pendant la nuit. Ainsi les données mises à jour dans la journée sont disponibles le lendemain sur l'application.

## Schéma fonctionnel

![schema_fonctionnel](img/ProcédureGEO_PlanInteractif.png)

## Dépendances (non critiques)

Les dépendances sont liées à chaque donnée transférée.


## Classes d'objets

L'ensemble des classes d'objets de gestion sont stockés pour la plupart dans le schéma x_apps_public. Certaines peuvent être conservées dans les schémas métiers de chaque donnée dans le cas d'un transfert de la donnée brute.

 ### classes d'objets des données brutes :
 
`geo_a_habillage_pct` : (archive) Donnée géographique contenant l'habillage ponctuel des documents d'urbanisme locaux (PLUi, PLU, CC) sur le modèle du standard CNIG 2017

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|  
|idhab|Identifiant unique de l'habillage ponctuel|character varying(10)| |


Particularité(s) à noter : aucune

---


`an_v_docurba_arcba` : Vue ARC simplifiée de la table an_doc_urba à usage interne. Ajout nom de la commune et du libellé de l'état du document


---

 ### classes d'objets applicatives sont classés dans le schéma x_apps_public :

 
`xapps_an_vmr_p_information` : Vue matérialisée alphanumérique formatant une liste des parcelles avec les informations ponctuelles, surfaciques (hors DPU et ZAD), linénaires issues des documents d'urbanisme et d'autres informations jugées utiles issues d'autres données métiers (Natura 2000,ZICO, ZNIEFF, ...) impactant chaque parcelle. Cette vue est liée dans GEO pour récupération de ces informations dans la fiche de renseignements d'urbanisme (cf dossier GitHub correspondant à l'application).



## Liste de valeurs

Sans objet

---

## Traitement automatisé mis en place (Workflow de l'ETL FME)

Un worflow FME a été réalisé permettant de gérer l'envoi automatique des données vers la base esclave. Il est stockée ici Y:\Ressources\4-Partage\3-Procedures\FME\prod\APPS_GB_PUBLIC\PLAN_INTERACTIF.fmw.
Ce Workflowest exécuté toutes les nuits via une tache planifiée sur le serveur sig-applis.

Aucune fiche de procédures ont été réalisées.

---

## Projet QGIS pour la gestion

Sans objet
       
## Export Open Data

Sans objet

---

## Modèle conceptuel simplifié
Sans objet
