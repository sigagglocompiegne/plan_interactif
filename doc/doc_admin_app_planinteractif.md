![picto](img/Logo_web-GeoCompiegnois.png)

# Documentation d'administration de l'application #

# Généralité

|Représentation| Nom de l'application |Résumé|
|:---|:---|:---|
|![picto](/doc/img/picto_plan_interactif_vert.png)|Plan Interactif|Cette application grans public est dédiée à la recherche d'informations sur les services publics (élus, écoles, bureau de vote, ...) à partir de la recherche d'une adresse.|


# Accès

|Public|Métier|Accès restreint|
|:-:|:-:|:---|
|X||Accès tout public pas de contraintes liées à la donnée|

# Droit par profil de connexion

* **Prestataires**

Sans Objet

* **Personnes du service métier**

Sans Objet

* **Autres profils**

Sans objet

# Les données

Sont décrites ici les Géotables et/ou Tables intégrées dans GEO pour les besoins de l'application. Les autres données servant d'habillage (pour la cartographie ou les recherches) sont listées dans les autres parties ci-après. Le tableau ci-dessous présente uniquement les changements (type de champ, formatage du résultat, ...) ou les ajouts (champs calculés, filtre, ...) non présents dans la donnée source. 

## GeoTable : `xappspublic_geo_v_adresse`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|adresse_apostrophe|x|||Remplace l'apostrophe par rien, permet la recherche d'adresse sans tenir compte de cette apostrophe |Recherche d'une adresse (BAL)||
|adresse_complete |x|||Génère l'adresse complète|Fiches d'informations||
|adresse_html |x|x||Contient le champ calculé `adresse_complete` et affichage / suggestion en résultat de recherche et déclaré en HTML|Recherche d'une adresse (BAL)||
|affiche_etiquette  |x|||résultat du calcul `angle`x-1 pour afficher l'étiquette du point d'adresse|Cartothèque||
|affiche_mes_docurba |x|||Formatage du message pour cliquer sur parcelle et déclaré en HTML|Recherche d'une adresse (localiser une parcelle)||
|affiche_rech_adr |x|||Formatage du message au résultat d'une adresse et déclaré en HTML|Recherche d'une adresse (BAL)||
|affiche_rech_adr_ru |x|||Formatage du message au résultat d'une adresse (test pour RU) et déclaré en HTML|Recherche d'une adresse (BAL)||
|affiche_rech_adr_vide  |x|||Formatage d'une ligne vide (-) pour gérer l'affichage dans les bulles de résultats déclaré en HTML|Recherche d'une adresse (BAL)||


   * filtres :
   
|Nom|Attribut| Au chargement | Type | Condition |Valeur|Description|
|:---|:---|:-:|:---:|:---:|:---|:---|
|ARC|insee|x|Alphanumérique|est égale à une valeur par défaut|code insee des communes de l'ARC||
|Pas de n° (00000)|numero|x|Alphanumérique|est différente de une valeur par défaut|00000||
|Fenêtre carte|geom||spatial|est contenue dans la sélection courante||| 

   * relations :

|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|
| xappspublic_geo_vmr_planinteractif_refelu | geom | 0 à 1 (intersection) |
| xappspublic_geo_v_carte_scolaire_ele | id_adresse | 0 à n (égal) |
| xappspublic_geo_v_carte_scolaire_mat | id_adresse | 0 à n (égal) |
| geo_decoupage_electoral | geom | 0 à 1 (intersection) |
| + geo_decoupage_electoral | id_poi | 1 à n (égal) |
| xapps_geo_v_dec_secteur_enc_secteur | geom | 1 (intersection) |
| xapps_geo_v_fo_sfr_pm | geom | 1 (intersection) |
| geo_dec_secteur_om | geom | 1 (intersection) |
| xappspublic_an_dec_pavverre_adr_proxi | id_adresse | 0 à n (égal) |
| + geo_dec_pav_verre | id_contver | 0 à n (égal) |
| xappspublic_an_dec_pavtlc_adr_proxi | id_adresse | 0 à n (égal) |
| + geo_dec_pav_tlc | id_cont_tl | 0 à n (égal) |
|  xappspublic_geo_mob_rurbain_la_tampon | geom | 0 à n (intersection) |
| + xappspublic_geo_mob_rurbain_la | id_la | 0 à n (égal) |
| xappspublic_an_vmr_fichegeo_ruplu0_gdpublic | insee | 1 (égal) |

   * particularité(s) : aucune

## GeoTable : `xappspublic_geo_vmr_planinteractif_refelu`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|affiche_coordonnee_er |x|||Formate en HTML l'affichage des coordonnées du premier élu de quartier|champ calculé affiche_coordonnee_er_synt||
|affiche_coordonnee_er2  |x|||Formate en HTML l'affichage des coordonnées du second élu de quartier|champ calculé affiche_coordonnee_er_synt||
|affiche_coordonnee_er3  |x|||Formate en HTML l'affichage des coordonnées du troisième élu de quartier|champ calculé affiche_coordonnee_er_synt||
|affiche_coordonnee_er_synt |x|||Formate en HTML l'affichage des coordonnées des élus de quartier|Fiches d'informations||
|affiche_coordonnee_maire |x|||Formate en HTML l'affichage des coordonnées du maire|Fiches d'informations||
|lien_logo |x|x||Formate en HTML l'affichage du logo de la commune|Fiches d'informations||
|lien_photo_er |x|||Formate en HTML la photo du 1er élu de quartier |champ calculé affiche_coordonnee_er||
|lien_photo_er2 |x|||Formate en HTML la photo du 2nd élu de quartier |champ calculé affiche_coordonnee_er2||
|lien_photo_er3 |x|||Formate en HTML la photo du 3ème élu de quartier |champ calculé affiche_coordonnee_er3||
|lien_photo_maire |x|||Formate en HTML la photo du maire |champ calculé affiche_coordonnee_maire||

   * filtres : aucun

   * relations : aucune

   * particularité(s) : aucune

## GeoTable : `geo_plan_refpoi`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|affiche_ele|x||Nom de l'école (élé)| Gestion de l'affichage de l'école élémentaire d'appartenance (avancé sql)|Fiche d'information : Equipement||
|affiche_mat  |x||Nom de l'école (mat)|Gestion de l'affichage de l'école maternelle d'appartenance (avancé sql)|Fiche d'information : Equipement|
|affiche_result  |x|||Message de résultat si aucun équipement trouvé|Recherche d'un équipement||
|affiche_vote  |x||Lieu de vote|Affichage du POI lieu de vote|Fiche d'information : Equipement||
|poi_recherche |x|||Formate nom du POI et la commune|Recherche d'un équipement||
|poi_lib |||Fiche d'informations : Equipement||||

   * filtres :
   
|Nom|Attribut| Au chargement | Type | Condition |Valeur|Description|
|:---|:---|:-:|:---:|:---:|:---|:---|
|ARC|insee|x|Alphanumérique|est égale à une valeur par défaut|code insee des communes de l'ARC||


   * relations :

|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|
| an_plan_refcontactpoi | id_poi | 0 à 1 (égal) |
| xappspublic_geo_mob_rurbain_la_tampon | geom | 0 à n (Centroïd est contenu) |
| + xappspublic_geo_mob_rurbain_la | id_la | 0 à n (égal) |

   * particularité(s) : aucune
   
## GeoTable : `xappspublic_geo_mob_rurbain_la`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|affiche_annonce|x|x|| Message d'annonce (en HTM) si besoin|Fiche d'information : Arrêt TIC||
|et_img_ligne  |x|x|Ligne(s)| Formate l'affichage des lignes par leur image (en HTML)|Fiche d'information : Equipement, Arrêt TIC et Recherche d'un arrêt du réseau TIC|
|eti_img_text   |x||Arrêt|Formate l'affichage du nom de l'arrêt TIC|Fiche d'information : Arrêt TIC et  Recherche d'un arrêt du réseau TIC||

   * filtres :
   
Sans objet

   * relations :

|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|
|  xappspublic_geo_mob_rurbain_ze | id_la | 0 à n (égal) |
| + xappspublic_an_mob_rurbain_passage | id_ze | 0 à n (égal) |
| + an_mob_rurbain_docligne | id_ligne | 1 à n (égal) |
|  xappspublic_geo_mob_rurbain_ze | id_la | 0 à n (égal) |
| + xappspublic_an_mob_rurbain_passage | id_ze | 0 à n (égal) |
| + an_mob_rurbain_docligne | id_ligne | 1 à n (égal) |

   * particularité(s) : aucune
   
## GeoTable : `geo_mob_borne_electrique`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|affiche_result|x|x|| Formate l'affichage du n° de la borne|Recherche : Borne électrique||
|affiche_result_1  |x|x|| Formate l'affichage du message cliquez ici pour + d'info (en HTML)|Fiche d'information : Les bornes électriques|
|id_borne  |||N° de la borne| |Fiche d'information : Les bornes électriques|
|url  |||Site| |Fiche d'information : Les bornes électriques|

   * filtres :
   
Sans objet

   * relations :

Sans objet

   * particularité(s) : aucune
   
## GeoTable : `geo_mob_3v_statio`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|adresse_comp|x|x|| Formate de l'adresse pour affichage dans lafiche|Fiche d'informations : Stationnement vélo||
|nb_place  |x|x|| Formate l'affichage du champ `capacité` (si 0 = inconnu sinon valeur) (avancé SQL)|Fiche d'information :  Stationnement vélo, Recherche : Stationnement vélo |
|type_equipement  |x|x|| Formate l'affichage du champ `mobilier` (si null = inconnu sinon valeur) (avancé SQL)|Fiche d'information :  Stationnement vélo, Recherche : Stationnement vélo |

   * filtres :
   
|Nom|Attribut| Au chargement | Type | Condition |Valeur|Description|
|:---|:---|:-:|:---:|:---:|:---|:---|
|ARC|insee|x|Alphanumérique|est égale à une valeur par défaut|code insee des communes de l'ARC||
|Actif|statut||Alphanumérique|est égale à une valeur par défaut|10|affiche uniquement les valeurs actives|

   * relations :

Sans objet

   * particularité(s) : aucune
   
## GeoTable : `geo_dec_pav_verre`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|affiche_info_bulle|x|x|| Formate une info bulle affichant le type de conteneur et son adresse |Recherche : Conteneur verre ||
|affiche_plus_info  |x|x|| Formate un message "Cliquez ici pour + d'infos"|Recherche : Conteneur verre ||
|nb_conteneur  |x|x|| Formate l'affichage du nombre de conteneur|Fiche d'information :  Conteneur verre ||
|verif_maj  |x|x|| Formate un nombre de jour entre la date du jout et la date de mise à jour pour initialiser le déclencheur|Déclencheur : Mise à jour Plan Interactif TRI ||

   * filtres : aucun
   

   * relations :

|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|
|  an_dec_pav_doc_media | id | 0 à n (égal) |

   * particularité(s) : un déclencheur a été initialisé sur supression, ajout ou modification de la donnée (ne fonctionne pas sur version SaaS 1.14.2). En attente nouvelle version pour test.
   
## GeoTable : `geo_dec_pav_tlc`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|affiche_info_bulle|x|x|| Formate une info bulle affichant le type de conteneur et son adresse |Recherche : Conteneur textile ||
|nb_conteneur  |x|x|| Formate l'affichage du nombre de conteneur|Fiche d'information :  Conteneur textile ||

   * filtres : aucun
   

   * relations :

|Géotables ou Tables| Champs de jointure | Type |
|:---|:---|:---|
|  an_dec_pav_doc_media | id | 0 à n (égal) |

   * particularité(s) : aucune
   
## GeoTable : `geo_decoupage_electoral`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|affiche_bureau |x||Votre bureau|Formate en HTML le message lié au bureau de vote selon la commune|Fiche d'informations : Fiche d'informations ||


   * filtres : aucun

   * relations : aucune

   * particularité(s) : aucune
   
## GeoTable : `xappspublic_geo_v_dec_secteur_enc_secteur`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|affiche_message |x||Les encombrants|Formate le message selon la commune et les champs l_message_1 ..|Fiche d'informations : Fiche d'informations ||


   * filtres : aucun

   * relations : aucune

   * particularité(s) : aucune
   
## GeoTable : `geo_dec_secteur_om`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|affiche_calendrier |x||Les ordures ménagères, la collecte sélective et les déchets verts|Si le chaamp calculé `l_fichier` n'est pas null affiche en html l'adresse de l'image avec `l_fichier` + `affiche_message` si non que `affiche_message`|Fiche d'informations : Fiche d'informations ||
|affiche_message |x||Information(s) complémentaire(s)|Affiche les messages l_message(n) selon qu'il soit rempli ou vide|Champ calculé `affiche_message` ||

   * filtres : aucun

   * relations : aucune

   * particularité(s) : aucune
   
## GeoTable : `xappspublic_geo_v_carte_scolaire_mat`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
| affiche_mat ||x|Nom de l'école||Fiche d'informations : Fiche d'informations||
| url ||x|+ d'infos||Fiche d'informations : Fiche d'informations||

   * filtres : aucun

   * relations : aucune

   * particularité(s) : aucune
   
## GeoTable : `xappspublic_geo_v_carte_scolaire_ele`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
| affiche_ele ||x|Nom de l'école||Fiche d'informations : Fiche d'informations||
| url ||x|+ d'infos||Fiche d'informations : Fiche d'informations||

   * filtres : aucun

   * relations : aucune

   * particularité(s) : aucune
   
## GeoTable : `xappspublic_an_dec_pavverre_adr_proxi`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
| affiche_ordre |x|x||Formate l'affichage de l'ordre de proximité des PAV selon le champ ordre|Fiche d'informations : Fiche d'informations||


   * filtres : aucun

   * relations : aucune

   * particularité(s) : aucune
   
## GeoTable : `xappspublic_an_dec_pavtlc_adr_proxi`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
| affiche_ordre |x|x||Formate l'affichage de l'ordre de proximité des PAV selon le champ ordre|Fiche d'informations : Fiche d'informations||


   * filtres : aucun

   * relations : aucune

   * particularité(s) : aucune
   
## Table : `an_plan_refcontactpoi`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
| adresse_complete |x|x||Formate l'adresse à partir des champs adresse,cp et commune|Fiche d'informations : Equipement||
| affiche_url1 |x|x||Formate en html l'affichage de l'adresse du site internet si il existe|Fiche d'informations : Equipement||
| affiche_url2 |x|x||Formate en html l'affichage de l'adresse d'un autre site internet si il existe|Fiche d'informations : Equipement||

   * filtres : aucun

   * relations : aucune

   * particularité(s) : aucune

## Table : `an_mob_rurbain_ligne`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
| affiche_type_reseau |x|x|Réseau|Formate l'affichage du type de réseau|Fiche d'informations : Arrêt TIC||
| img_ligne |x|x|MLigne(s)|Formate en html l'affichage de ou des lignes|Fiche d'informations : Arrêt TIC||


   * filtres : aucun

   * relations : aucune

   * particularité(s) : aucune
   
## Table : `an_mob_rurbain_docligne`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|  affiche_horaire_ligne |x|x|Horaires|Formate (lien) l'affichage de la fiche horaire (si `l_fichier` = fiche horaire alors adresse du fichier en http:// + `n_fichier`|Fiche d'informations : Arrêt TIC||

   * filtres : aucun

   * relations : aucune

   * particularité(s) : aucune

## Table : `xappspublic_an_mob_rurbain_passage`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|  affiche_direction |x|x||Formate l'affichage de la direction vers + `nom direction`|aucune||
|   nom_direction |||Direction||Fiche d'informations : Arrêt TIC||

   * filtres : aucun

   * relations : aucune

   * particularité(s) : aucune

# Les fonctionnalités

Sont présentées ici uniquement les fonctionnalités spécifiques à l'application.

## Recherche globale : `Recherche d'une adresse (BAL)`

Cette recherche permet à l'utilisateur de faire une recherche libre sur une adresse.

* Configuration :

Source : `xappspublic_geo_v_adresse (ARC)`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|adresse_apostrophe ||x||||
|adresse_html |x||x|||
|affiche_rech_adr_vide |x|||||
|affiche_rech_adr |x|||||
|geom||||x||

(Calcul des suggestions par "Contient les mots entiers")
(la détection des doublons n'est pas activée ici)

 * Filtres : aucun

 * Fiches d'information active : Fiche d'informations


## Recherche (clic sur la carte) : `Recherche d'une adresse (BAL)`

Cette recherche permet à l'utilisateur de cliquer sur la carte et de remonter les informations à l'adresse et d'accéder à la fiche d'Informations.

Même configuration que la recherche globale plus haut. 


## Recherche (fonctionnalités) : `Petite enfance`

Cette recherche permet à l'utilisateur d'afficher les POI petites enfance sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Petite enfance|x|poi_n2|est égale à une valeur par défaut|111,112||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
## Recherche (fonctionnalités) : `Primaire`

Cette recherche permet à l'utilisateur d'afficher les POI des écoles primaires sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Primaire|x|poi_n2|est égale à une valeur par défaut|101||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
 ## Recherche (fonctionnalités) : `Secondaire`

Cette recherche permet à l'utilisateur d'afficher les POI des écoles secondaires sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Secondaire|x|poi_n3|est égale à une valeur par défaut|10211,10212,10213,10214,10215||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
## Recherche (fonctionnalités) : `Formation supérieure`

Cette recherche permet à l'utilisateur d'afficher les POI petites enfance sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Formation supérieure|x|poi_n2|est égale à une valeur par défaut|103,104||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
## Recherche (fonctionnalités) : `Gare SNCF`

Cette recherche permet à l'utilisateur d'afficher les POI des gares sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Gare SNCF|x|poi_n3|est égale à une valeur par défaut|20113||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 

## Recherche (fonctionnalités) : `Gare routière`

Cette recherche permet à l'utilisateur d'afficher les POI des gares routières sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Gare routière|x|poi_n3|est égale à une valeur par défaut|20911||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Recherche (fonctionnalités) : `Arrêt du réseau TIC`

Cette recherche permet à l'utilisateur d'afficher les POI des arrêts de bus du réseau TIC sur la carte.

  * Configuration :

Source : `xappspublic_geo_mob_rurbain_ze`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Arrêt||x|x|||
|eti_arret_simple||||||
|Arrêt|x|||||
|Ligne(s)|x|||||
|eti_arret|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

Sans objet

 * Fiches d'information active : Arrêt TIC

## Recherche (fonctionnalités) : `Aire de covoiturage`

Cette recherche permet à l'utilisateur d'afficher les POI des aires de covoiturage sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Aire de covoiturage|x|poi_n3|est égale à une valeur par défaut|20916||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
## Recherche (fonctionnalités) : `Borne électrique`

Cette recherche permet à l'utilisateur d'afficher les POI des gares routières sur la carte.

  * Configuration :

Source : `geo_mob_borne_electrique`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|affiche_result|x|||||
|Commune|x|||||
|affiche_result_1|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

Sans objet

 * Fiches d'information active : Les bornes électriques
 
## Recherche (fonctionnalités) : `Stationnement vélo`

Cette recherche permet à l'utilisateur d'afficher les POI des stationnements vélos sur la carte.

  * Configuration :

Source : `geo_mob_3v_statio`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|nb_place|x|||||
|type_equipement|x|||||
|adresse_comp|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Actif|x|statut|est égale à une valeur par défaut|10||||||

(1) si liste de domaine

 * Fiches d'information active : Stationnement vélo

## Recherche (fonctionnalités) : `Départ de randonnées`

Cette recherche permet à l'utilisateur d'afficher les POI des gares sur la carte.

  * Configuration :

Source : `geo_tou_depart_rando`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Rando nom|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

Sans objet

 * Fiches d'information active : Randonnée

## Recherche (fonctionnalités) : `Bibliothèques,médiathèques, archives`

Cette recherche permet à l'utilisateur d'afficher les POI des bibliothèques, ... sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Bibliothèques, médiathèques, archives|x|poi_n3|est égale à une valeur par défaut|13111,13113,13115||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Recherche (fonctionnalités) : `Espace numérique`

Cette recherche permet à l'utilisateur d'afficher les POI des espaces numériques sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Espace numérique|x|poi_n3|est égale à une valeur par défaut|13117||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
## Recherche (fonctionnalités) : `Musées`

Cette recherche permet à l'utilisateur d'afficher les POI des musées sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Musée|x|poi_n3|est égale à une valeur par défaut|13311||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Recherche (fonctionnalités) : `Théâtres, salles de spectacles`

Cette recherche permet à l'utilisateur d'afficher les POI des théâtres et salles de spectacle sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Théâtres, salle de spectavles|x|poi_n3|est égale à une valeur par défaut|13312,13313||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement


## Recherche (fonctionnalités) : `Cinéma`

Cette recherche permet à l'utilisateur d'afficher les POI des cinémas sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Cinéma|x|poi_n3|est égale à une valeur par défaut|13314||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
## Recherche (fonctionnalités) : `Karting-Bowling`

Cette recherche permet à l'utilisateur d'afficher les POI des karting-bowling sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Karting|x|poi_lib|{poi_lib} like '%Karting%'|||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Recherche (fonctionnalités) : `Lieu de culte`

Cette recherche permet à l'utilisateur d'afficher les POI des lieux de cultes sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Culte|x|poi_n2|est égale à une valeur par défaut|21||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Recherche (fonctionnalités) : `Centre de loisirs, écoles artistiques`

Cette recherche permet à l'utilisateur d'afficher les POI des centres de loisirs sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Centre de loisirs,écoles artistiques|x|poi_n3|est égale à une valeur par défaut|13212,13213||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Recherche (fonctionnalités) : `Parcs, jardins, aires de jeux`

Cette recherche permet à l'utilisateur d'afficher les POI des parcs, jardins, ... sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Parcs, jardins,aires de jeux|x|poi_n3|est égale à une valeur par défaut|15112,15113,15114,15118,15119||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement


## Recherche (fonctionnalités) : `Office du tourisme`

Cette recherche permet à l'utilisateur d'afficher les POI des offices de tourisme sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`||

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`||

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Office du tourisme|x|poi_n3|est égale à une valeur par défaut|17319||||||
|Office du tourisme|x|poi_lib|commence par|Office||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 

## Recherche (fonctionnalités) : `Piscine`

Cette recherche permet à l'utilisateur d'afficher les POI des piscines sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Piscine|x|poi_n3|est égale à une valeur par défaut|12313||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Recherche (fonctionnalités) : `Patinoire`

Cette recherche permet à l'utilisateur d'afficher les POI des patinoires sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Patinoire|x|poi_n3|est égale à une valeur par défaut|12316||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
## Recherche (fonctionnalités) : `Terrain de tennis`

Cette recherche permet à l'utilisateur d'afficher les POI des terrains de tennis sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Tennis|x|poi_n3|est égale à une valeur par défaut|12213||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
## Recherche (fonctionnalités) : `Boulodromes`

Cette recherche permet à l'utilisateur d'afficher les POI des boulodromes sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Boulodromes|x|poi_n3|est égale à une valeur par défaut|12214||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Recherche (fonctionnalités) : `Golf`

Cette recherche permet à l'utilisateur d'afficher les POI des golfs sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Golf|x|poi_n3|est égale à une valeur par défaut|12218||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
 ## Recherche (fonctionnalités) : `Equitation`

Cette recherche permet à l'utilisateur d'afficher les POI liés à l'équitation sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Equitation|x|poi_n3|est égale à une valeur par défaut|12215,12212||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
## Recherche (fonctionnalités) : Citys Stade``

Cette recherche permet à l'utilisateur d'afficher les POI des citys stades sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Citys Stades|x|poi_n3|est égale à une valeur par défaut|12217||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Recherche (fonctionnalités) : `Stades et plaines de jeux`

Cette recherche permet à l'utilisateur d'afficher les POI des stades et palines de jeux sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Stades et plaines de jeux|x|poi_n3|est égale à une valeur par défaut|12211||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Recherche (fonctionnalités) : `Base-Ball`

Cette recherche permet à l'utilisateur d'afficher les POI des terrains de Base-Ball sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Base-Ball|x|poi_lib|{poi_lib} like '%Base-Ball%'|||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
## Recherche (fonctionnalités) : `Gymnase`

Cette recherche permet à l'utilisateur d'afficher les POI des gymnases sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Gymnase|x|poi_n3|est égale à une valeur par défaut|12311||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Recherche (fonctionnalités) : `Dojo`

Cette recherche permet à l'utilisateur d'afficher les POI des dojos sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Dojo|x|poi_lib|{poi_lib} like '%Dojo%'|||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Recherche (fonctionnalités) : `Danse`

Cette recherche permet à l'utilisateur d'afficher les POI des lieux de danses sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Danse|x|poi_lib|{poi_lib} like '%Danse%'|||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
## Recherche (fonctionnalités) : `Skate Park`

Cette recherche permet à l'utilisateur d'afficher les POI des Skate Park sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Skate Park|x|poi_lib|{poi_lib} like '%Skate Park%'|||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
## Recherche (fonctionnalités) : `BMX`

Cette recherche permet à l'utilisateur d'afficher les POI des lieux de pratique du BMX sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|BMX|x|poi_lib|{poi_lib} like '%BMX%'|||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
## Recherche (fonctionnalités) : `Jeu d'arc`

Cette recherche permet à l'utilisateur d'afficher les POI des jeux d'arc sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Jeu d'arc|x|poi_lib|{poi_lib} like '%Jeu d''arc%' or {poi_lib} like '%Tir à l''Arc%'|||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Recherche (fonctionnalités) : `Nautique`

Cette recherche permet à l'utilisateur d'afficher les POI des activités nautiques sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Nautique|x|poi_lib|{poi_lib} like '%Nautique%' or {poi_lib} like '%nautique%'|||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
## Recherche (fonctionnalités) : `Parcours sportif`

Cette recherche permet à l'utilisateur d'afficher les POI des parcours sportifs sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Parcours sportifs|x|poi_lib|{poi_lib} like '%Parcours sportif%' or {poi_lib} like '%Parcours de santé%'|||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
## Recherche (fonctionnalités) : `Mur d'escalade`

Cette recherche permet à l'utilisateur d'afficher les POI des murs d'escalade sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Mur d'escalade|x|poi_n3|est égale à une valeur par défaut|12315||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
## Recherche (fonctionnalités) : `Mairies - Intercommunalités`

Cette recherche permet à l'utilisateur d'afficher les POI des mairies et siège des EPCI sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Mairie|x|poi_n2|est égale à une valeur par défaut|171,175||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Recherche (fonctionnalités) : `Bureau de vote`

Cette recherche permet à l'utilisateur d'afficher les POI des bureaux de vote sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Bureau de vote|x|usa_bvote|est égale à une valeur par défaut|true||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Recherche (fonctionnalités) : `Emploi`

Cette recherche permet à l'utilisateur d'afficher les POI des structures liées à l'emploi sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Emploi|x|poi_n2|est égale à une valeur par défaut|182,183,184,185||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
## Recherche (fonctionnalités) : `Maisons des associations, locaux associatifs,maison de quartier`

Cette recherche permet à l'utilisateur d'afficher les POI des structures associatives sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Emploi|x|poi_n3|est égale à une valeur par défaut|17317||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
 ## Recherche (fonctionnalités) : `Palais de Justice, tribunaux, prison`

Cette recherche permet à l'utilisateur d'afficher les POI liés à la Justice sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Justice|x|poi_n3|est égale à une valeur par défaut|19311,19313,19314,19317||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
## Recherche (fonctionnalités) : `Autres administrations`

Cette recherche permet à l'utilisateur d'afficher les POI des autres administrations sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Autres administrations|x|poi_n3|est égale à une valeur par défaut|22111,22113,18112,18115,19212,19213,17400||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
## Recherche (fonctionnalités) : `Déchetterie`

Cette recherche permet à l'utilisateur d'afficher les POI des déchetteries sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Déchetterie|x|poi_n3|est égale à une valeur par défaut|22512||||||
|Nom Déchetterie|x|poi_lib|{poi_lib} like '%Déchetterie%'|||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Recherche (fonctionnalités) : `Recyclerie`

Cette recherche permet à l'utilisateur d'afficher les POI des recycleries sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Recyclerie|x|poi_n3|est égale à une valeur par défaut|22512||||||
|Nom Recyclerie|x|poi_lib|{poi_lib} like '%Recyclerie%'|||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Recherche (fonctionnalités) : `Conteneur Verre`

Cette recherche permet à l'utilisateur d'afficher les POI des conteneurs verres sur la carte.

  * Configuration :

Source : `geo_dec_pav_verre`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|affiche_info_bulle|x|||||
|Commune|x|||||
|affiche_plus_info|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Actif|x|statut|est égale à une valeur par défaut|10||||||
|Non professionnel|x|env_implan|est différentde de la valeur par défaut|40||||||

(1) si liste de domaine

 * Fiches d'information active : Conteneur Verre
 

## Recherche (fonctionnalités) : `Conteneur Textile`

Cette recherche permet à l'utilisateur d'afficher les POI des conteneurs TLC sur la carte.

  * Configuration :

Source : `geo_dec_pav_tlc`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|affiche_info_bulle|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

Sans objet

(1) si liste de domaine

 * Fiches d'information active : Conteneur Textile
 
## Recherche (fonctionnalités) : `Marché`

Cette recherche permet à l'utilisateur d'afficher les POI des marchés sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Non marché|x|poi_lib|{poi_lib} like '%Marché%'|||||||
|Marché|x|poi_n3|est égale à une valeur par défaut|17319||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
 ## Recherche (fonctionnalités) : `Cimetière, crématorium`

Cette recherche permet à l'utilisateur d'afficher les POI des cimetières et crématoriums sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Groupe de filtres par défaut|`ET`||

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

|Groupe de filtres par défaut|`OU`||

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Crématorium|x|poi_lib|{poi_lib} like '%Crématorium%'|||||||
|Cimetière|x|poi_n3|est égale à une valeur par défaut|23000||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 

## Recherche (fonctionnalités) : `Bureau de poste, centre de tri`

Cette recherche permet à l'utilisateur d'afficher les POI des bureaux de postes et/ou centre de tri sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Poste|x|poi_n3|est égale à une valeur par défaut|22312,22313,22314||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
 ## Recherche (fonctionnalités) : `Hôpital, clinique, polyclinique`

Cette recherche permet à l'utilisateur d'afficher les POI des hôpitaux sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Hôpital|x|poi_n3|est égale à une valeur par défaut|16111,16112||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
## Recherche (fonctionnalités) : `Dispensaires, centres médicaux`

Cette recherche permet à l'utilisateur d'afficher les POI des centres de soins sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Dispensaires|x|poi_n3|est égale à une valeur par défaut|16211,16212,16213,16214,16215,16312,16416,16512,16513,16516,16912,16915,16917||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Recherche (fonctionnalités) : `Maternités`

Cette recherche permet à l'utilisateur d'afficher les POI des maternités sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Maternités|x|poi_n3|est égale à une valeur par défaut|16311||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Recherche (fonctionnalités) : `Polices, gendarmeries`

Cette recherche permet à l'utilisateur d'afficher les POI de la police et gendarmerie sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Polices|x|poi_n3|est égale à une valeur par défaut|19413,19414,19512||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
## Recherche (fonctionnalités) : `Centres de secours`

Cette recherche permet à l'utilisateur d'afficher les POI des centres de secours (pompier) sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Services de secours|x|poi_n3|est égale à une valeur par défaut|19513||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Recherche (fonctionnalités) : `Espace jeune`

Cette recherche permet à l'utilisateur d'afficher les POI des espaces pour jeunes sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Espace jeune|x|poi_n3|est égale à une valeur par défaut|13415||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
## Recherche (fonctionnalités) : `Maisons de retraite, foyers clubs`

Cette recherche permet à l'utilisateur d'afficher les POI des maisons de retraites/foyers clubs sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Maisons de retraite|x|poi_n3|est égale à une valeur par défaut|14111,14112,14113,14114||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
 ## Recherche (fonctionnalités) : `Foyers logements, résidences universitaires`

Cette recherche permet à l'utilisateur d'afficher les POI des Foyers logements, résidences universitaires sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Foyers logements|x|poi_n3|est égale à une valeur par défaut|14211,14212,14213 ou 14215||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Recherche (fonctionnalités) : `Centres sociaux,actions sociales`

Cette recherche permet à l'utilisateur d'afficher les POI des centres sociaux et actions sociales sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Centres sociaux|x|poi_n3|est égale à une valeur par défaut|14311,14911 ou 14912||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Recherche (fonctionnalités) : `Hébergements scpécialisés`

Cette recherche permet à l'utilisateur d'afficher les POI des hébergements spécialisés sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Foyers logements|x|poi_n3|est égale à une valeur par défaut|14913, 14914 ou 14917||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Recherche (fonctionnalités) : `CIO`

Cette recherche permet à l'utilisateur d'afficher les POI des centres d'information et d'orientation sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|CIO|x|poi_n3|est égale à une valeur par défaut|18216||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement
 
## Recherche (fonctionnalités) : `Salles polyvalentes, salles des fêtes, foyers`

Cette recherche permet à l'utilisateur d'afficher les POI des salles polyvalentes, salles des fêtes et foyers sur la carte.

  * Configuration :

Source : `geo_plan_refpoi`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Equipement|x|||||
|Commune|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Salles polyvalentes|x|poi_n3|est égale à une valeur par défaut|13414||||||
|Filtre sur espace de carte|x|geom|est contenu dans la sélection courante|||||||

(1) si liste de domaine

 * Fiches d'information active : Equipement

## Fiche d'information : `Fiche d'informations`

Source : `xappspublic_geo_v_adresse (ARC)`

 * Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|530x650|Accordéon|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Votre adresse|adresse_commplete|Par défaut|Vertical||||
|Votre mairie et votre élu(e) de quartier|||Vertical||||
|Votre maire|lien_photo_mairie,affiche_coordonnee_mairie|Par défaut|Vertical||||
|Votre ou vos élu(e)(s) de quartier|affiche_coordonnee_er_synt|Par défaut|Vertical||||
|Où scolariser votre enfant ?|||Vertical||||
|Maternelle|affiche_mat,commune_3,url|Masqué|Vertical||||
|Elémentaire|affiche_ele,commune_3,url_1|Masqué|Vertical||||
|Où voter ?|affiche_bureau|Par défaut|Vertical||||
|Où prendre un bus, un car, un Allotic ?|nom,et_img_ligne|Par défaut|Vertical||+ d'infos (Arrêt TIC)||
|Où déposer votre verre ou vos textiles ?|||Vertical||||
|Verre à proximité|affiche_ordre,adresse,commune_1|Par défaut|Vertical||+ d'infos (Conteneur verre)||
|Textile à proximité|affiche_ordre_1,adresse_1,commune_2|Par défaut|Vertical||+ d'infos (Conteneur textile)||
|Vos jours de collecte des déchets ?|||Vertical||||
|Les ordures ménagères, la collecte sélective et les déchets vertes|affiche_calendrier|Par défaut|Vertical||||
|Les encombrants|affiche_message|Par défaut|Vertical||||
|Votre accès internet par la fibre optique|affiche_info|par défaut|Vertical||||

 * Saisie : aucune

 * Modèle d'impression : aucun


## Fiche d'information : `Fiche équipement`


Source : `geo_plan_refpoi`

 * Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|530x650|Vertical|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Libellé|poi_lib|Par défaut|Vertical||||
|Localisation|adresse_complete,commune|Par défaut|Vertical||||
|Information(s) complémentaire(s)|affiche_url1,affiche_url2|Par défaut|Vertical||||
|Venir en transport en commun|nom,et_img_ligne|Par défaut|Vertical||Arrêt TIC (+ d'infos)||

 * Saisie : aucune

 * Modèle d'impression : aucun
 
## Fiche d'information : `Arrêt TIC`

Source : `xappspublic_geo_mob_rurbain_la`

 * Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|530x650|Vertical|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Nom de l'arrêt|eti_img_txt|Par défaut|Vertical||||
|Desserte(s)|img_ligne,affiche_type_reseau,affiche_horaire_ligne,nom_direction|Par défaut|Vertical||||


 * Saisie : aucune

 * Modèle d'impression : aucun
 * Particularité : cette fiche est ouvrable depuis la fiche équipement également

## Fiche d'information : `Les bornes électriques`

Source : `geo_mob_borne_electrique`

 * Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|530x650|Vertical|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|(vides)|id_borne,commune,url,photo|A gauche|Vertical||||

 * Saisie : aucune

 * Modèle d'impression : aucun
 * Particularité : aucune
 

## Fiche d'information : `Conteneur Verre`

Source : `geo_dec_pav_verre`

 * Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|530x650|Vertical|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Informations sur le conteneur|commune,quartier,adresse,nb_conteneur|par défaut|Vertical||||
|Photographie(s)|lien_photo|par défaut|Vertical||||

 * Saisie : aucune

 * Modèle d'impression : aucun
 * Particularité : aucune
 
## Fiche d'information : `Conteneur Textile`

Source : `geo_dec_pav_tlc`

 * Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|530x650|Vertical|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Informations sur le conteneur|commune,quartier,adresse,nb_conteneur|par défaut|Vertical||||
|Photographie(s)|lien_photo|par défaut|Vertical||||

 * Saisie : aucune

 * Modèle d'impression : aucun
 * Particularité : aucune


## Analyse :

Sans objet

## Statistique :

Sans objet

## Modification géométrique : 

Sans objet
 
 # La cartothèque

|Groupe|Sous-groupe|Visible dans la légende|Visible au démarrage|Détails visibles|Déplié par défaut|Geotable|Renommée|Issue d'une autre carte|Visible dans la légende|Visible au démarrage|Déplié par défaut|Couche sélectionnable|Couche accrochable|Catégorisation|Seuil de visibilité|Symbologie|Autres|
|:---|:---|:-:|:-:|:-:|:-:|:---|:---|:-:|:-:|:-:|:-:|:-:|:---|:---|:---|:---|:---|
||||x|||xappspublic_geo_v_adresse (ARC)|Adresse (1/1502è au 1/2100è)|||x|||||1502 à 2100|pas de symbole affiche uniquement l'étiquette (etiquette) du n° de l'adresse (noir,gras,taille 8,halo=1 blanc,pas de fond, pas de contour, angle de rotation par le champ `affiche_etiquette`, pas de conflit) |Interactivité avec le champ infobulle `{adresse_complete}` |
||||x|||xappspublic_geo_v_adresse (ARC)|Adresse (0 à 1/1501è)|||x|||||0 à 1501|pas de symbole affiche uniquement l'étiquette (etiquette) du n° de l'adresse (noir,gras,taille 10,halo=1 blanc,pas de fond, pas de contour, angle de rotation par le champ `affiche_etiquette`, pas de conflit) |Interactivité avec le champ infobulle `{adresse_complete}` |
|||x|x||| geo_v_osm_commune_arcba|Etiquette des communes||x|x||||||pas de symbole affiche uniquement l'étiquette (commune M) du nom de la commune (#CC740C,gras,taille 8,halo=1 blanc,pas de fond, pas de contour, angle de rotation par le champ `affiche_etiquette`, pas de conflit) |Interactivité avec le champ infobulle `{adresse_complete}` |
|||x|x||| geo_v_osm_commune_arcba|Limite des communes||x|x||||||uniquement le contour (#CC740C,taille 2,ligne continue) ||
||||x||| geo_osm_masque_arcba|masque sur l'ARC|||x||||||uniquement le fond plein (couleur #FFFFFF,40% d'opacité) ||

 * Particularité : projection en EPSG:3857 piur gérer OpenStreetMap en fond de plan, emprise sur les limites communales, niveau d'échelles pré-fixées (150000,110000,75000,56000,28000,14000,7000,5000,3000,2000,1500,1000,500)

# L'application

* Généralités :

|Gabarit|Thème|Modules spé|Impression|Résultats|
|:---|:---|:---|:---|:---|
|Grand Public (1)|Plan Interactif|StreetView,Google Analytics, coordonnées au survol,Météo,Partage de lien|Modèle standard GEO pas de possibilité d'ajouter des modèles||

* Particularité de certains modules :
  * Module introduction : aucun.
  * Module javacript : aucun
  * Module Google Analytics : le n° ID est disponible sur le site de Google Analytics

* Recherche globale :

|Noms|Tri|Nb de sugggestion|Texte d'invite|
|:---|:---|:---|:---|
|Recherche d'une adresse (BAL),Recherche d'un équipement, Recherche d'un arrêt du réseau TIC|distance|20|Tapez une adresse, un équipement, un arrêt de bus|

* Carte : `Plan d'agglo Interactif V2`

Comportement au clic : (dés)active uniquement l'item cliqué
Liste des recherches : Recherche d'une adresse (BAL)

* Fonds de plan :

|Nom|Au démarrage|opacité|
|:---|:---|:---|
|OpenStreetMap|x|non paramétrable|
|Vue aérienne|x (au choix de l'utilisateur)|non paramétrable|

* Fonctionnalités

|Groupe|Nom|Au démarrage|
|:---|:---|:---|
|Enseignement|||
||Petite enfance||
||Primaire|x|
||Secondaire||
||Formation Supérieure||
||Formation Professionnelle||
|Mobilité|||
||Gare SNCF|x|
||Gare routière|x|
||Arrêt du réseau TIC|x|
||Aire de covoiturage||
||Borne électrique||
||Stationnement vélo||
||Départ de randonnées||
|Culture et loisirs|||
||Bibliothèques, médiathèques,archives||
||Espace numérique||
||Musées||
||Théâtres, salles de spectacles||
||Cinéma||
||Karting-Bowling||
||Lieu de culte||
||Centres de loisirs, écoles artistiques||
||Parcs,jardins,aires de jeux||
||Office du tourisme||
|Sports||
||Piscine||
||Patinoire||
||Terrain de tennis||
||Boulodromes||
||Golf||
||Equitation||
||Citys Stades||
||Stades et plaines de jeux||
||Base-Ball||
||Gymnase||
||Dojo||
||Danse||
||Skate Park||
||BMX||
||Jeu d'arc||
||Stand de tir||
||Nautique||
||Parcours sportif||
||Mur d'escalade||
|Adminsitrations||
||Mairies - intercommunalité|x|
||Bureau de vote|x|
||Emploi||
||Maisons des associations, locaux associatifs, maisons de quartier||
||Palais de justice,tribunaux, prison||
||Autres administrations||
|Vie pratique||
||Déchetterie||
||Recyclerie||
||Conteneur Verre|x|
||Conteneur Textile|x|
||Marché||
||Cimetière, crématorium||
||Bureau de vote, centre de tri||
|Santé/Sécurité||
||Hôpital, clinique, polyclinique|x|
||Dispensaires, centres médicaux||
||Maternités||
||Polices, gendarmeries||
||Centres de secours||
|Social et animation||
||Espace jeune||
||Maisons de retraite, foyers clubs||
||Foyers logements, résidences universitaires||
||Centres sociaux, actions sociales||
||Hébergements spécialisés||
||CIO||
||Salles polyvalentes, salles des fêtes, foyers||
