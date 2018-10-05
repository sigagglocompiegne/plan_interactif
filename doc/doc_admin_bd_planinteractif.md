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

 ### classes d'objets des données brutes et des vues applicatives :
 
 La structure des tables ou des vues ne sera pas détaillée ici puisque qu'il s'agit d'une exploitation brute de données existantes gérées pour d'autres usages. Seules les vues applicatives pourront faire l'objet d'un détail de leur structure.
 
 
- limites adminsitratives :

`r_osm.geo_v_osm_commune_arcba` : Donnée géographique des limites communales de l'Agglomération de la Région de Compiègne

Particularité(s) à noter : aucune

---

`r_osm.geo_osm_masque_arcba` : Donnée géographique générant un polygone à trou sur l'Agglomération de la Région de Compiègne pour créer un effet masque sur les territroires périphériques.

Particularité(s) à noter : aucune

---

`r_plan.geo_plan_refpoi` : Donnée géographique des POI sur l'Agglomération de la Région de Compiègne.
`r_plan.an_plan_refcontactpoi` : Donnée alphanumérique des contacts des POI sur l'Agglomération de la Région de Compiègne.

Particularité(s) à noter : aucune

---

`m_mobilite.geo_mob_rurbain_la` : Donnée géographique des arrêts logiques du réseau de transoport sur l'Agglomération de la Région de Compiègne(TIC).
`m_mobilite.geo_mob_rurbain_ze` : Donnée géographique des arrêts physiques du réseau de transoport sur l'Agglomération de la Région de Compiègne(TIC).
`m_mobilite.an_mob_rurbain_passage` : Donnée alphanumérique gérant les passages aux arrêts physiques du réseau de transoport sur l'Agglomération de la Région de Compiègne(TIC).
`m_mobilite.lt_mob_rurbain_terminus` : Liste de valeur contenant les lieux de terminus ou de passage intermédiaire du réseau de transoport sur l'Agglomération de la Région de Compiègne(TIC).
`m_mobilite.an_mob_rurbain_ligne` : Donnée alphanumérique contenant la liste des lignes du réseau de transoport sur l'Agglomération de la Région de Compiègne(TIC).
`m_mobilite.an_mob_rurbain_docligne` : Donnée alphanumérique contenant les documents relatifs aux lignes du réseau de transoport sur l'Agglomération de la Région de Compiègne(TIC).

Particularité(s) à noter : les données mobilités font l'objet de traitement particulier avant envoi à la base esclave (cf partie sur ETL en bas pour plus de détails).

---

`m_mobilite.geo_mob_3v_station` : Donnée géographique contenant la localisation des stationnements pour vélo sur l'Agglomération de la Région de Compiègne(TIC).
`m_tourisme.geo_tou_depart_rando` : Donnée géographique contenant la localisation des départs de randonnées sur l'Agglomération de la Région de Compiègne(TIC).

Particularité(s) à noter : aucune

---

`m_dechet.geo_dec_pav_verre` : Donnée géographique contenant la localisation des conteneurs verres sur l'Agglomération de la Région de Compiègne(TIC).
`m_dechet.geo_dec_pav_tlc` : Donnée géographique contenant la localisation des conteneurs textiles, lignes, chaussures sur l'Agglomération de la Région de Compiègne(TIC).
`m_dechet.an_dec_pav_doc_media` : Donnée alphnaumérique contenant les documents joints aux conteneurs (photos) sur l'Agglomération de la Région de Compiègne(TIC).
`m_dechet.geo_dec_secteur_om` : Donnée géoégraphique contenant les secteurs de ramassage des ordures ménagères sur l'Agglomération de la Région de Compiègne(TIC).

Particularité(s) à noter : aucune

---

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
