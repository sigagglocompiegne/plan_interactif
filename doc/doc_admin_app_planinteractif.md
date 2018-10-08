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
|affiche_rech_adr_vide  |x|||Formatage du message pour aucun résultat (test pour RU) et déclaré en HTML|Recherche d'une adresse (BAL)||


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

## GeoTable : `geo_v_osm_commune_arcba`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|

Sans objet


   * filtres :
   
Sans objet

   * relations :

Sans objet

   * particularité(s) : aucune
   
## GeoTable : `geo_v_osm_masque_arcba`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|

Sans objet


   * filtres :
   
Sans objet

   * relations :

Sans objet

   * particularité(s) : aucune
   

## GeoTable : `geo_plan_refpoi`

|Attributs| Champ calculé | Formatage |Renommage|Particularité/Usage|Utilisation|Exemple|
|:---|:-:|:-:|:---|:---|:---|:---|
|affiche_ele|x||x| Gestion de l'affichage de l'école élémentaire d'appartenance (avancé sql)|Fiche d'information : Equipement||
|affiche_mat  |x||x|Gestion de l'affichage de l'école maternelle d'appartenance (avancé sql)|Fiche d'information : Equipement|
|affiche_result  |x|||Message de résultat si aucun équipement trouvé|Recherche d'un équipement||
|affiche_vote  |x||x|Affichage du POI lieu de vote|Fiche d'information : Equipement||
|poi_recherche |x|||Formate nom du POI et la commune|Recherche d'un équipement||


   * filtres :
   
|Nom|Attribut| Au chargement | Type | Condition |Valeur|Description|
|:---|:---|:-:|:---:|:---:|:---|:---|
|ARC|insee|x|Alphanumérique|est égale à une valeur par défaut|code insee des communes de l'ARC||
|Parcs, jardins, aires de jeux|poi_n3||Alphanumérique|est égale à une valeur par défaut|15112,15113,15114,15118,15119|utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|CIO |poi_n3||Alphanumérique| est égale à une valeur par défaut|18216|utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Office du tourisme nom |poi_lib||Alphanumérique| commence par une valeur par défaut|Office|utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Poste |poi_n3||Alphanumérique| est égale à une valeur par défaut|22312,22313,22314|utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Hôpital |poi_n3||Alphanumérique| est égale à une valeur par défaut|16111,16112|utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Cinéma |poi_n3||Alphanumérique| est égale à une valeur par défaut|13314|utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Tennis |poi_n3||Alphanumérique| est égale à une valeur par défaut|12213|utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Gare SNCF |poi_n3||Alphanumérique| est égale à une valeur par défaut|20113|utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Maternités |poi_n3||Alphanumérique| est égale à une valeur par défaut|16311|utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Mairie |poi_n2||Alphanumérique| est égale à une valeur par défaut|171,175|utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Danse |poi_lib||SQL|{poi_lib} like '%danse%' or {poi_lib} like '%Danse%' ||utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Mur d'escalade |poi_n3||Alphanumérique| est égale à une valeur par défaut|12315|utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Espace numérique |poi_n3||Alphanumérique| est égale à une valeur par défaut|13117|utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Filtre sur espace de carte |geom||Alphanumérique| est contenue dans la sélection courante|||
|Nom déchetterie |poi_lib||sql| {poi_lib} like '%Déchetterie%'||utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Nom recyclerie |poi_lib||sql| {poi_lib} like '%Recyclerie%'||utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Jeu d'arc |poi_lib||sql| {poi_lib} like '%Jeu d''Arc%' or {poi_lib} like '%Tir à l''Arc%'||utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Base-Ball |poi_lib||sql| {poi_lib} like '%Base-Ball%'||utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Skate Park |poi_lib||sql| {poi_lib} like '%Skate Park%'||utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Karting |poi_lib||sql| {poi_lib} like '%Karting%'||utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Maisons associatives |poi_n3||Alphanumérique| est égale à une valeur par défaut|17317|utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Salles polyvalentes |poi_n3||Alphanumérique| est égale à une valeur par défaut|13414|utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Stade et plaine de jeux |poi_n3||Alphanumérique| est égale à une valeur par défaut|12211|utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Bureau de vote |usa_bvote||Alphanumérique| est égale à |true|utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|BMX |poi_lib||sql| {poi_lib} like '%BMX%'||utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Dispensaires |poi_n3||Alphanumérique| est égale à une valeur par défaut|16211,16212,16213,16214,16215,16312,16416,16512,16513,16516,16912,16915,16917|utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Hébergement spécialisés |poi_n3||Alphanumérique| est égale à une valeur par défaut|14913,14914,14917|utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Autres administrations |poi_n3||Alphanumérique| est égale à une valeur par défaut|22111,22113,18112,18115,19212,19213,17400|utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|
|Bibliothèques |poi_n3||Alphanumérique| est égale à une valeur par défaut||utilisé pour les recherches fonctionnelles permettant d'afficher uniquement la catégorie filtrée|

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
   

# Les fonctionnalités

Sont présentées ici uniquement les fonctionnalités spécifiques à l'application.

## Recherche globale : `Recherche dans la Base Adresse Locale`

Cette recherche permet à l'utilisateur de faire une recherche libre sur une adresse.

Cette recherche a été créée pour l'application RVA. Le détail de celle-ci est donc à visualiser dans le répertoire GitHub rva au niveau de la documentation applicative.

## Recherche globale : `Recherche dans la Base de Voie Locale`

Cette recherche permet à l'utilisateur de faire une recherche libre sur le libellé d'une voie.

Cette recherche a été créée pour l'application RVA. Le détail de celle-ci est donc à visualiser dans le répertoire GitHub rva au niveau de la documentation applicative.

## Recherche globale : `Localiser une commune de l'APC`

Cette recherche permet à l'utilisateur de faire une recherche sur une commune du Pays Compiégnois.

  * Configuration :

Source : `geo_v_osm_commune_apc (pour recherche)`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Commune M|x|x|x|||
|geom||||x||

(Calcul des suggestions par "Contient la chaîne")
(la détection des doublons n'est pas activée ici)

 * Filtres : aucun

 * Fiches d'information active : aucune
 
## Recherche globale : `Localiser un équipement`

Cette recherche permet à l'utilisateur de faire une recherche un équipement localisé dans une commune du Pays Compiégnois.

  * Configuration :

Source : `geo_plan_refpoi (usage APC)`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|recherche_poi|x|x|x|||
|geom||||x||

(Calcul des suggestions par "Contient les mots entiers (Postgres Full-TextSearch)")
(la détection des doublons n'est pas activée ici)

 * Filtres : aucun

 * Fiches d'information active : Fiche équipement

## Recherche (clic sur la carte) : `Parcelle(s) sélectionnée(s)`

Cette recherche permet à l'utilisateur de cliquer sur la carte et de remonter les informations de la parcelle et d'accéder soit à la fiche de renseignement d'urbanisme ou de la fiche parcelle détaillée (si les droits).

  * Configuration :

Source : `r_bg_edigeo.PARCELLE (Parcelle (Alpha) V3`

Les champs affichés par défaut par le module intégrateur de l'éditeur ont été conservés ici.

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Bg Emplacement|x|||||
|Bg Full Address|x|||||

L'attribut de géométrie (geom) utilisé est celui de la couche `Parcelle V3 (r_bg_edigeo.PARCELLE)`.
(la détection des doublons n'est pas activée ici)

 * Filtres :

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|SECU|x|ccocom|est égale à une valeur du contexte `ccocom`|||||Ce champ est lié au profil utilisateur et contient le ou les code(s) insee lui permettant d'accéder aux données du cadastre de la ou des commune(s) en question|

(1) si liste de domaine

 * Fiches d'information active : Renseignements d'urbanisme, Renseignements d'urbanisme (non DGFIP)
 
## Recherche (clic sur la carte) : `PPRi zonage (projet) - remarque`

Cette recherche permet à l'utilisateur de cliquer sur la carte et de remonter les informations de la parcelle et d'accéder soit à la fiche de renseignement d'urbanisme ou de la fiche parcelle détaillée (si les droits).

  * Configuration :

Source : `m_urbanisme_reg.geo_sup_pm1_ppri_projet_rq (PPRi zonage (projet) - remarque)`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|affiche_result|x|||||
|message|x|||||

(la détection des doublons n'est pas activée ici)

 * Filtres :

Sans objet

(1) si liste de domaine

 * Fiches d'information active : PPRi zonage (projet) - remarque

## Recherche : `Toutes les recherches cadastrales`

L'ensemble des recherches cadastrales ont été formatées et intégrées par l'éditeur via son module GeoCadastre.
Seul le nom des certaines recherches a été modifié par l'ARC pour plus de compréhension des utilisateurs.

  * Configuration :

Source : `r_bg_edigeo.PARCELLE (Parcelle (Alpha) V3`

|Libellé d'origine|Nouveau libellé|
|:---|:---|
|Parcelles par adresse|Parcelles par adresse fiscale|
|Parcelles par propriétaire|Parcelles par nom du propriétaire|
|Parcelles par propriétairesde locaux|Parcelles par nom du propriétaire d'un local|

## Recherche : `Par libellé de zone PLU`

Cette recherche permet à l'utilisateur de faire une recherche sur les zonages d'une commune.

  * Configuration :

Source : `x_apps_geo_vmr_p_zone_urba`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Zonage|x|||||
|libellé de voie|x|||||
|libelon|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Commune|x|insee|est égale à une valeur de liste de choix|Liste de domaine (Commune APC (sans filtre))|commune_m|insee|insee|||
|zonage|x||Prédéfinis filtre à liste de choix|||||||

(1) si liste de domaine

 * Fiches d'information active : Fiche détaillée POS-PLU-CC
 
## Recherche : `Par type de zone PLU`

Cette recherche permet à l'utilisateur de faire une recherche sur les types de zones d'une commune.

  * Configuration :

Source : `x_apps_geo_vmr_p_zone_urba`

|Attribut|Afficher|Rechercher|Suggestion|Attribut de géométrie|Tri des résultats|
|:---|:-:|:-:|:-:|:-:|:-:|
|Zonage|x|||||
|libellé de voie|x|||||
|libelon|x|||||
|geom||||x||

(la détection des doublons n'est pas activée ici)

 * Filtres :

|Groupe|Jointure|Filtres liés|
|:---|:-:|:-:|
|Groupe de filtres par défaut|`ET`|x|

|Nom|Obligatoire|Attribut|Condition|Valeur|Champ d'affichage (1)|Champ de valeurs (1)|Champ de tri (1)|Ajout autorisé (1)|Particularités|
|:---|:-:|:---|:---|:---|:---|:---|:---|:-:|:---|
|Commune|x|insee|est égale à une valeur de liste de choix|Liste de domaine (Commune APC (sans filtre))|commune_m|insee|insee|||
|Type de zonage|x|typezone|est égale à une valeur de liste de choix|Liste de domaine (Type de zone PLU)|typezone_lib|typezone|typezone|||

(1) si liste de domaine

 * Fiches d'information active : Fiche détaillée POS-PLU-CC
 
## Recherche : `Recherche avancée d'une adresse`

Cette recherche permet à l'utilisateur de faire une recherche guidée d'une adresse contrairement à la recherche globale par saisie libre.

Cette recherche a été créée pour l'application RVA. Le détail de celle-ci est donc à visualiser dans le répertoire GitHub rva au niveau de la documentation applicative.
 
 ## Recherche : `Recherche avancée d'une voie`

Cette recherche permet à l'utilisateur de faire une recherche guidée d'une voie contrairement à la recherche globale par saisie libre.

Cette recherche a été créée pour l'application RVA. Le détail de celle-ci est donc à voisualiser dans le répertoire GitHub rva au niveau de la documentation applicative.


## Fiche d'information : `Fiche adresse`

Source : `xapps_geo_vmr_adresse`

Cette fiche est issus de l'application RVA. Consultez le répertoire rva sur GitHub pour plus de précisions.

## Fiche d'information : `Fiche équipement`

Source : `r_plan.geo_plan_refpoi (usage APC)`

 * Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|530x650|Vertical|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Etablissement|poi_lib|Par défaut|Vertical||INFORMATIONS / CONTACT||

 * Saisie : aucune

 * Modèle d'impression : aucun
 
## Fiche d'information : `Fiche détaillée POI`

Source : `r_plan.an_plan_refcontactpoi`

 * Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|530x650|Vertical|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Etablissement|poi_lib,poi_alias|Par défaut|Vertical||||
|Adresse|adr_compl|Par défaut|Vertical||||
|Contact|tel, fax, mail|Par défaut|Vertical||||
|Lien(s) internet|site,url1,url2|Par défaut|Vertical||||
|Remarques|observ|Par défaut|Vertical||||

 * Saisie : aucune

 * Modèle d'impression : aucun
 * Particularité : cette fiche est liée à la fiche équipement, et n'est accessaible qu'à partir de celle-ci 
 
## Fiche d'information : `Fiche parcelle` et `Fiche local`

Source : `r_bg_majic.NBAT_10 (Parcelle (Alpha) V3)`

Ces fiches sont liées au module GeoCadastre de l'éditeur et ne sont pas modifiable par l'ARC. 

## Fiche d'information : `Fiche détaillée POS-PLU-CC`

Source : `x_apps_geo_vmr_p_zone_urba`

 * Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|530x650|Vertical|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Caractéristiques de la zone|LIBELLE (commune-BG),libelle,gestion_libelle_long,typezone,destdomi_lib,fermreco,l_surf_cal,l_observ|Par défaut|Vertical||||
|Validité du document|datappro_date|Par défaut|Vertical||||
|Accès au réglement|urlfic|Par défaut|Vertical||||

 * Saisie : aucune

 * Modèle d'impression : Fiche standard
 
 ## Fiche d'information : `Fiche adresse` et `Fiche d'information sur la voie`

Ces deux fiches sont issues de l'application RVA. Se référer au répertoire GitHub du même nom pour plus de précisions.

## Fiche d'information : `PPRi zonage (projet) - remarque`

Source : `m_urbanisme_reg.geo_sup_pm1_ppri_projet_rq (PPRi zonage (projet) - remarque)`

 * Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|530x650|Vertical|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|Caractéristiques de l'annotation|id_rq,nom,tyep_rq,observ,date_sai,date_maj|Par défaut|Vertical||||

 * Saisie : aucune

 * Modèle d'impression : Fiche standard+carte
 
## Fiche d'information : `Renseignements d'urbanisme`

Source : `r_bg_majic.NBAT_10 (Parcelle (Alpha) V3)`

 * Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|600x650|Vertical|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|(vide)|affiche_commune|Masqué|Vertical||||
|(vide)|titre_html|Masqué|Vertical||||
|(vide)|section_parcelle|Masqué|Vertical||||
|(vide)|tableau_proprio|Masqué|Vertical||||
|(vide)|titre_doc_urba_valide_html|Masqué|Vertical||||
|(vide)|tableau_doc_vigueur|Masqué|Vertical||||
|(vide)|libelle(xapps_an_vmr_parcelle_plu),libelong,urlfic (xapps_an_vmr_parcelle_plu)|Masqué|Vertical||Fiche POS-PLU-CC||
|(vide)|titre_prescription_html|Masqué|Vertical||||
|(vide)|libelle(xapps_an_vmr_p_prescription),lien(xapps_an_vmr_p_prescription)|Masqué|Vertical||||
|(vide)|titre_dpu_html|Masqué|Vertical||||
|(vide)|application,beneficiaire,date_ins,urlfic(xapps_an_vmr_p_information_dpu)|Masqué|Vertical||||
|(vide)|titre_info_utile_html|Masqué|Vertical||||
|(vide)|libelle(xapps_an_vmr_p_information),lien(xapps_an_vmr_p_information)|Masqué|Vertical||||
|(vide)|titre_sup_html,titre_sup_impact|Masqué|Vertical||||
|(vide)|ligne_aff(an_sup_geo),l_url(an_sup_geo)|Masqué|Vertical||||
|(vide)|titre_ac4|Masqué|Vertical||||
|(vide)|message,protec,typeprotec(an_sup_ac4_geo_protect)|Masqué|Vertical||||
|(vide)|titre_liste_sup_com|Masqué|Vertical||||
|(vide)|titre_taxe_amgt|Masqué|Vertical||||
|(vide)|affiche_taux,affiche_url(an_fisc_geo_taxe_amgt)|Masqué|Vertical||||

 * Saisie : aucune

 * Modèle d'impression : Fiche standard
 * Particularité : le champ calculé tableau_proprio a été intégré en plus de l'éditeur. Ce champ doit-être recréer à chaque mise à jour du module GeoCadastre et de la création de la structure dans GEO si besoin (champ HTML <b>{BG_FULL_NAME} /st de ligne/
{BG_FULL_ADDRESS}</b>) et renommé Le ou les propriétaire(s).

## Fiche d'information : `Renseignements d'urbanisme (non DGFIP)`

Source : `r_bg_majic.NBAT_10 (Parcelle (Alpha) V3)`

 * Statistique : aucune
 
 * Représentation :
 
|Mode d'ouverture|Taille|Agencement des sections|
|:---|:---|:---|
|dans le gabarit|600x650|Vertical|

|Nom de la section|Attributs|Position label|Agencement attribut|Visibilité conditionnelle|Fichie liée|Ajout de données autorisé|
|:---|:---|:---|:---|:---|:---|:---|
|(vide)|affiche_commune|Masqué|Vertical||||
|(vide)|titre_html|Masqué|Vertical||||
|(vide)|section_parcelle|Masqué|Vertical||||
|(vide)|titre_doc_urba_valide_html|Masqué|Vertical||||
|(vide)|tableau_doc_vigueur|Masqué|Vertical||||
|(vide)|libelle(xapps_an_vmr_parcelle_plu),libelong,urlfic (xapps_an_vmr_parcelle_plu)|Masqué|Vertical||Fiche POS-PLU-CC||
|(vide)|titre_prescription_html|Masqué|Vertical||||
|(vide)|libelle(xapps_an_vmr_p_prescription),lien(xapps_an_vmr_p_prescription)|Masqué|Vertical||||
|(vide)|titre_dpu_html|Masqué|Vertical||||
|(vide)|application,beneficiaire,date_ins,urlfic(xapps_an_vmr_p_information_dpu)|Masqué|Vertical||||
|(vide)|titre_info_utile_html|Masqué|Vertical||||
|(vide)|libelle(xapps_an_vmr_p_information),lien(xapps_an_vmr_p_information)|Masqué|Vertical||||
|(vide)|titre_sup_html,titre_sup_impact|Masqué|Vertical||||
|(vide)|ligne_aff(an_sup_geo),l_url(an_sup_geo)|Masqué|Vertical||||
|(vide)|titre_ac4|Masqué|Vertical||||
|(vide)|message,protec,typeprotec(an_sup_ac4_geo_protect)|Masqué|Vertical||||
|(vide)|titre_liste_sup_com|Masqué|Vertical||||
|(vide)|titre_taxe_amgt|Masqué|Vertical||||
|(vide)|affiche_taux,affiche_url(an_fisc_geo_taxe_amgt)|Masqué|Vertical||||

 * Saisie : aucune

 * Modèle d'impression : Fiche standard
 * Particularité : cette fiche est identique à la fiche "Renseignement d'urbanisme" sauf qu'elle n'affiche pas le nom des propriétaires et n'est accessible uniquement pour les profils non DGI à partir des applicatifs GEO.

## Analyse :

Sans objet

## Statistique :

Sans objet

## Modification géométrique : 

Sans objet
 
 # La cartothèque

|Groupe|Sous-groupe|Visible dans la légende|Visible au démarrage|Détails visibles|Déplié par défaut|Geotable|Renommée|Issue d'une autre carte|Visible dans la légende|Visible au démarrage|Déplié par défaut|Couche sélectionnable|Couche accrochable|Catégorisation|Seuil de visibilité|Symbologie|Autres|
|:---|:---|:-:|:-:|:-:|:-:|:---|:---|:-:|:-:|:-:|:-:|:-:|:---|:---|:---|:---|:---|
||||x|||xapps_geo_vmr_adresse|Adresse|x||x|||||0 à 2000|Symbole réduit à 8 et 1% opacité et contour 0% (pour ne pas le voir sur la carte)|Interactivité avec le champ infobulle `{adresse} || '<br>' || CASE WHEN {diag_adr} <> 'Adresse conforme' THEN {diag_adr} ELSE '' END`|
|Servitudes d'utilités publique||x||x||||||||||||||
|Servitudes d'utilités publique|A4-Cours d'eau non domaniaux|x||x||geo_sup_a4_generateur_sup_l|Générateur||x|x||||||Ligne bleue||
|Servitudes d'utilités publique|A4-Cours d'eau non domaniaux|x||x||geo_sup_a4_assiette_sup_s|Assiette||x|x||||||Contour vert pointillé||
|Servitudes d'utilités publique|AC1-Monuments historiques|x||x||geo_sup_ac1_generateur_sup_s_060|Générateur (MH)||x|x||||||Contour noir épais et fond orangé plein|Interactivité sur le champ info_bulle `CASE WHEN {nomgen} IS NOT NULL THEN 'Nom du générateur (monuments historiques)' || chr(10) || replace(replace({nomgen}, 'AC1_', ''), '_gen', '') END`|
|Servitudes d'utilités publique|AC1-Monuments historiques|x||x||geo_sup_ac1_assiette_sup_s_060|Assiette (MH)||x|x||||||Contour orangé et hachure en ligne oblique orange fine en fond|Interactivité sur le champ info_bulle `CASE WHEN {nomass} IS NOT NULL THEN 'Nom de l''assiette (monuments historiques)' || chr(10) || replace(replace({nomass}, 'AC1_', ''), '_ass', '') || chr(10) ||
'Type : ' || {typeass} END`|
|Servitudes d'utilités publique|AC1-Monuments historiques|x||x||geo_vmr_sup_ac1_parcelle|Parcelles impactées par un MH||x|||||||Pas de contour et fond orangé à 50% d'opacité||
|Servitudes d'utilités publique|AC2-Sites inscrits et classés|x||x||geo_sup_ac2_assiette_sup_s|Assiette (Sites inscrits et classés)||x|x||||||Cadrillage rouge|Interactivité sur le champ info_bulle `CASE WHEN {nomass} IS NOT NULL THEN
'Nom de l''assiette (sites inscrits et classés)' || chr(10) || replace(replace({nomass}, 'AC2_', ''), '_ass', '') || chr(10) ||
'Type : ' || {typeass} END`|
|Servitudes d'utilités publique|AC4-ZPPAUP|x||||geo_sup_ac4_zppaup_protect|Info Bulle||x|x|||||0 à 13 000è|Fond blanc opacaité 1%|Interactivité sur le champ info_bulle `ZPPAUP (protection des bâtiments) Mesure : {protec} Objet : {typeprotec}`|
|Servitudes d'utilités publique|AC4-ZPPAUP|x||||ZPPAUP (flux geoserver)|ZPPAUP||x|x||||||||
|Servitudes d'utilités publique|AS1-Périmètres captages|x||x||geo_sup_as1_generateur_sup_p_060|Point de captage||x|x||||||Point bleu|Interactivité sur le champ info_bulle `Nom du générateur (AS1-Point de captage) : {ins_nom}` |
|Servitudes d'utilités publique|AS1-Périmètres captages|x||x||geo_sup_as1_assiette_pepi_sup_s_060|Périmètre immédiat (captage)||x|x||||||Pas de fond, contour bleu|Interactivité sur le champ info_bulle `CASE WHEN {nomass} IS NOT NULL THEN
'Nom de l'assiette (AS1-Périmètre de protection immédiat du captage)' || chr(10) ||
replace(replace({nomass}, 'AS1_', ''), '_ass', '') END`|
|Servitudes d'utilités publique|AS1-Périmètres captages|x||x||geo_sup_as1_assiette_pepr_sup_s_060|Périmètre rapproché (captage)||x|x||||||Hachure bleue fine en fond, contour bleu|Interactivité sur le champ info_bulle `Nom de l'assiette (AS1-Périmètre de protection rapproché du captage) {nom_pp_aep}`|
|Servitudes d'utilités publique|AS1-Périmètres captages|x||x||geo_sup_as1_assiette_pepr_sup_s_060|Périmètre éloigné (captage)||x|x||||||Hachure bleue épaisse en fond, contour bleu|Interactivité sur le champ info_bulle `Nom de l'assiette (AS1-Périmètre de protection éloigné du captage) {nom_pp_aep}`|
|Servitudes d'utilités publique|EL3-Alignement|x||x||geo_sup_el3_assiette_sup_s|Assiette||x|x||||typeass||Ligne noire épais pour le halage et pointillé noir pour le marche pied||
|Servitudes d'utilités publique|EL7-Alignement|x||x||geo_sup_el7_assiette_sup_l_060|Assiette||x|x||||||Ligne pointillée noire épais||
|Servitudes d'utilités publique|I3 - Canalisations de gaz|x||x||geo_sup_i3_generateur_sup_l|Générateur (gaz)||x|x||||||Ligne pointillée violette épaisse||
|Servitudes d'utilités publique|I3 - Canalisations de gaz|x||x||geo_sup_i3_assiette_sup_s|Assiette (gaz)||x|x||||||Fond hachuré fin violet et contour fin violet||
|Servitudes d'utilités publique|I4 - Lignes électriques (RTE uniquement pour le moment)|x||x||geo_sup_i4_generateur_sup_l_060|Générateur (ligne)||x|x||||||Ligne pointillée violette épaisse|Interactivité sur le champ info_bulle `'Opérateur : ' || {srcgeogen} || chr(10) || 'Type de ligne : ' || {l_type} || chr(10) || CASE WHEN {l_tension} = 0 THEN 'Tension = hors tension' ELSE 'Tension : ' || {l_tension} || ' kV' END`|
|Servitudes d'utilités publique|I4 - Lignes électriques (RTE uniquement pour le moment))|x||x||geo_sup_i4_assiette_sup_s_060|Assiette (RTE - Distance Limite d’Investigation)||x|x||||||Fond hachuré fin violet et contour épais violet||
|Servitudes d'utilités publique|INT1 - Cimetières|x||x||geo_sup_int1_generateur_sup_s|Générateur (cimetières)||x|x||||||Quadrillage fin noir||
|Servitudes d'utilités publique|INT1 - Cimetières|x||x||geo_sup_int1_assiette_sup_s|Assiette (cimetières)||x|x||||||Fond  hachuré fin noir avec contour noir épais||
|Servitudes d'utilités publique|PM1-PPR naturels ou miniers|x||x||geo_sup_ppri_cote_compiegne|Cote PPRi Compiègne-Pt Ste Maxence||x|x||||||Trait noir épais|Champ calculé etiquette_code `round({ngf}::decimal,2) || 'm(NGF)'`|
|Servitudes d'utilités publique|PM1-PPR naturels ou miniers|x||x||geo_sup_pm1_generateur_sup_s_060|Zone PPRi||x|x||||l_zone||Couleur par type de zone|Interactivité sur info_bulle `PPR inondation (type de zone) : {l_zone}`|
|Servitudes d'utilités publique|PM3-PPR technologiques|x||x||geo_sup_pm3_assiette_sup_s_060|Assiette (PPRT)||x|x||||||Contour épais orangé et quadrillage orangé croisé oblique|Interactivité sur info_bulle `CASE WHEN {nomass} IS NOT NULL THEN
'Nom de l''assiette (PPR technologique)' || chr(10) || replace(replace({nomass}, 'PM3_', ''), '_ass', '') || chr(10) || 'Type : ' || {typeass} END`|
|Servitudes d'utilités publique|PT1-Perturbations électromagnétiques pour un centre radioélectrique|x||x||geo_sup_pt1_assiette_sup_s|Nature de la protection||x|x||||typeass (zone de garde (coutour épais bleu-violet et fond hachuré fin bleu violet oblique / ) et zone de protection (coutour épais bleu-violet et fond hachuré fin bleu violet oblique \ )|||Interactivité sur info_bulle `CASE WHEN {nomass} IS NOT NULL THEN 'Nom de l''assiette' || chr(10) || '(Servitude de protection des centres de réception radioélectrique' || chr(10) || 'contre les perturbations électromagnétiques)' || chr(10) || replace(replace({nomass}, 'PT1_', ''), '_ass', '') || chr(10) || 'Type : ' || {typeass} END`|
|Servitudes d'utilités publique|PT2-Obstacles pour un centre radioélectrique||x||x||geo_sup_pt2_assiette_sup_s|Zone primaire de dégagement|x|x||||||Coutour épais bleu-violet et fond hachuré fin bleu violet oblique /|Interactivité sur info_bulle `CASE WHEN {nomass} IS NOT NULL THEN 'Nom de l''assiette' || chr(10) || '(Servitudes de protection des centres radioélectriques' || chr(10) || 'd''émission et de récéption contre les obstacles)' || chr(10) || replace(replace({nomass}, 'PT2_', ''), '_ass', '') || chr(10) || 'Type : ' || {typeass} END`|
|Servitudes d'utilités publique|PT2LH-Obstacles pour une liaison hertzienne||x||x||geo_sup_pt2lh_assiette_sup_s|Zone spéciale de dégagement|x|x||||||Coutour épais bleu-violet et fond hachuré fin bleu violet oblique /|Interactivité sur info_bulle `CASE WHEN {nomass} IS NOT NULL THEN 'Nom de l''assiette' || chr(10) || '(Servitudes de protection contre ' || chr(10) || 'les obstacles pour une liaison hertzienne) ' || chr(10) || replace(replace({nomass}, 'PT2LH_', ''), '_ass', '') || chr(10) || 'Type : ' || {typeass} END`|
|Servitudes d'utilités publique|T1-Chemin de fer|x||x||geo_sup_t1_assiette_sup_s|Emprise de voie ferrée (SNCF-RFF)||x|x||||||Coutour épais noir et fond haburé fin noir oblique /|Interactivité sur info_bulle `CASE WHEN {nomass} IS NOT NULL THEN 'Nom de l''assiette' || chr(10) || '(Servitude de visibilité sur les voies publiques.' || chr(10) || 'Zones de servitudes relatives aux chemins de fer)' || chr(10) || replace(replace({nomass}, 'T1_', ''), '_ass', '') || chr(10) || 'Type : ' || {typeass} END`|
|Servitudes d'utilités publique|T4-T5-Servitudes aéronautiques|x||x||geo_sup_t5_assiette_sup_s|Zone de dégagement ou de balisage||x|x||||||Coutour épais noir|Interactivité sur info_bulle `CASE WHEN {nomass} IS NOT NULL THEN 'Nom de l''assiette' || chr(10) || 'Servitudes aéronautique de balisage et de dégagement.' || chr(10) ||  replace(replace({nomass}, 'T5_', ''), '_ass', '') || chr(10) || 'Type : ' || {typeass} END`|
|Autres informations jugées utiles||x||x||||||||||||||
|Autres informations jugées utiles|Atlas des zones inondables|x||x||geo_risq_azi_ngf_l|Cote||x|x||||||Trait épais noir|Etiquette sur etiquette_cote `round({ngf}::decimal,2) || 'm(NGF)'`|
|Autres informations jugées utiles|Atlas des zones inondables|x||x||geo_risq_azi_crue9330|Zonage||x|x||||||Fond bleu transparent 50% et contour même couleur pas transparent|
|Autres informations jugées utiles|Natura 2000|x||x||geo_env_n2000_zps_m2010|périmètre ZPS (Natura 2000)||x|x||||||Contour fin violet et hachuré oblique violet /|
|Autres informations jugées utiles|Natura 2000|x||x||geo_env_n2000_sic_m2010|périmètre SIC  (Natura 2000)||x|x||||||Contour fin orangé et hachuré oblique orangé /|
|Autres informations jugées utiles|Zone humide (SMOA)|x||x||geo_smoa_inv_zh|Zone humide par classement||x|x||||classement_carte `CASE WHEN {classement} = 'H' THEN {classement} WHEN {classement} = 'PP' THEN {classement} WHEN ({classement} = 'NZH' or {classement} = 'P') THEN 'P' END`|| H = Zone humide avérée (fond vert 60% sans contour), P = Potentiellement humide - nécessite analyse sol (sans contour hachure / bleu), PP = Potentiellement humide - nécessite analyse végétation et sol (sans contour fond bleu clair 60%)||
|Autres informations jugées utiles|Zone humide (SAGEBA)|x||x||geo_env_sageba_zhv4|Zone humide identifiée||x|x||||||Fond vert sans contour 60%||
|Autres informations jugées utiles|ZICO (Zones Importantes pour la Conservation des Oiseaux)|x||x||geo_env_zico|Zone humide identifiée||x|x||||||Contour violet épais et quadrillage oblique violet||
|Autres informations jugées utiles|ZNIEFF (Zones Naturelles d'Intêret Ecologique, Faunistique et Floristique)|x||x||geo_env_znieff1|ZNIEFF Type 1||x|x||||||Coutour épais marron et hachure oblique / fine marron||
|Autres informations jugées utiles|ZNIEFF (Zones Naturelles d'Intêret Ecologique, Faunistique et Floristique)|x||x||geo_env_znieff2|ZNIEFF Type 2||x|x||||||Coutour épais vert foncé et hachure oblique / fine vert foncé||
|Autres informations jugées utiles|ZDH (Zone à Dominante Humide)|x||x||geo_env_zdh|Périmètre ZDH||x|x||||||Coutour bleu clair foncé et hachuré -- forme de vague bleu clair||
|Autres informations jugées utiles|APB (Arrêté de Protection de Biotope)|x||x||geo_env_apb|Périmètre APB||x|x||||||Coutour rouge épais et fond jaune ||
|Autres informations jugées utiles|Zone sensible Grande Faune|x||x||geo_env_inventairezonesensible|Périmètre Zone Sensible Grande Faune||x|x||||||Pas de contour font kaki 50% ||
|Autres informations jugées utiles|ENS (Espace Naturel Sensible)|x||x||geo_env_ens|Périmètre ENS||x|x||||||Contour vert moyen et hachuré -- forme de vague vert moyen||
|Autres informations jugées utiles|Aléa de retrait-gonflement des argiles|x||x||geo_risq_alea_retraitgonflement_argiles|Zone d'aléa||x|x||||alea||Faible (violet foncé 40%), Moyen (violet foncé 60%),Fort (violet foncé 80%)||
|Autres informations jugées utiles|Inventaire du patrimoine vernaculaire|x||x||geo_inv_patrimoine_lin|Inventaire du patrimoine vernaculaire||x|x|||||0 à 5001è|Trait marron épais 3||
|Autres informations jugées utiles|Zonage d'assainissement|x||x||geo_eu_zonage|Zonage d'assainissement||x|x||||zone||Collectif (trait épais violet et fond violet 50%), Collectif futur (trait violet sans fond), Non collectif (trait vert clair et fond vert clair 50%)||
|Altimétrie|MNT allégé issu du LIDAR|x||x||Flux (MNT allégé issu du LIDAR)|Zonage d'assainissement||x|x||||||||
|Crues||x||x||||||||||||||
|Crues|Aléa de la crue trentennale|x||x||Flux (Crue trentennale - cote de référence)|Crue trentennale - cote de référence||x|x||||||||
|Crues|Aléa de la crue trentennale|x||x||Flux (Crue trentennale - hauteur d'eau)|Crue trentennale - hauteur d'eau||x|x|||||||Onglet avancé activé pour définir un icône dans la thématique et afficher la légende du flux au clic sur cette incône|
|Crues|Aléa de la crue centennale|x|x|x||Flux (Crue centennale - cote de référence)|Crue centennale - cote de référence||x|x||||||||
|Crues|Aléa de la crue centennale|x|x|x||Flux (Crue centennale - hauteur d'eau)|Crue centennale - hauteur d'eau||x|x|||||||Onglet avancé activé pour définir un icône dans la thématique et afficher la légende du flux au clic sur cette incône|
|Crues|Aléa de la crue millénale|x||x||Flux (Crue millénale - cote de référence)|Crue millénale - cote de référence||x|x||||||||
|Crues|Aléa de la crue millénale|x||x||Flux (Crue millénale - hauteur d'eau)|Crue millénale - hauteur d'eau||x|x|||||||Onglet avancé activé pour définir un icône dans la thématique et afficher la légende du flux au clic sur cette incône|
|Urbanisme||x|x|x||||||||||||||
|Urbanisme|Prescriptions PLU (info bulle)|x|x|||geo_p_prescription_pct|Prescription ponctuelle||x|x|||||0 à 4000è|Aucune|Interactivité sur le champ info_bulle `CASE WHEN {libelle} is not null THEN 'Prescription : ' || {libelle} WHEN {l_nature} is not null THEN 'Nature : ' || {l_nature} END ` |
|Urbanisme|Prescriptions PLU (info bulle)|x|x|||geo_p_prescription_lin|Prescription linéaire||x|x|||||0 à 4000è|Aucune|Interactivité sur le champ info_bulle `CASE WHEN {libelle} is not null THEN 'Prescription : ' || {libelle}
WHEN {l_nature} is not null THEN 'Nature : ' || {l_nature} WHEN {l_valrecul} is not null THEN 'Valeur du recul : ' || {l_valrecul}END` |
|Urbanisme|Prescriptions PLU (info bulle)|x|x|||geo_p_prescription_surf|Prescription surfacique||x|x|||||0 à 4000è|Aucune|Interactivité sur le champ info_bulle `CASE WHEN {libelle} is not null THEN 'Prescription : ' || {libelle}
WHEN {l_nature} is not null THEN 'Nature : ' || {l_nature} WHEN {l_valrecul} is not null THEN 'Valeur du recul : ' || {l_valrecul}END` |
|Urbanisme|Informations jugées utiles PLU (info bulle)|x|x|||geo_p_info_pct|Information ponctuelle||x|x|||||0 à 4000è|Aucune|Interactivité sur le champ info_bulle `CASE WHEN {libelle} is not null THEN 'Information jugée utile : ' || {libelle} END` |
|Urbanisme|Informations jugées utiles PLU (info bulle)|x|x|||geo_p_info_pct|Information ponctuelle||x|x|||||0 à 4000è|Aucune|Interactivité sur le champ info_bulle `CASE WHEN {libelle} is not null THEN 'Information jugée utile : ' || {libelle} END` |
|Urbanisme|Informations jugées utiles PLU (info bulle)|x|x|||geo_p_info_lin|Information linéaire||x|x|||||0 à 4000è|Aucune|Interactivité sur le champ info_bulle `CASE WHEN {libelle} is not null THEN 'Information jugée utile : ' || {libelle} WHEN {l_valrecul} is not null THEN 'Valeur de recul : ' || {l_valrecul} END` |
|Urbanisme|Informations jugées utiles PLU (info bulle)|x|x|||geo_p_info_surf|Information surfacique||x|x|||||0 à 4000è|Aucune|Interactivité sur le champ info_bulle `CASE WHEN {libelle} is not null THEN 'Information jugée utile : ' || {libelle} WHEN {l_valrecul} is not null THEN 'Valeur du recul : ' || {l_valrecul} END` |
|Urbanisme||||||geo_p_zone_pau|PAU (informatif)||x|x||||||Trait vert pomme épais et hachuré / fin vert pomme|Cette couche est visible uniquement pour certaines personnes du droit des sols (groupe PAU_CONSULT)|
|Urbanisme||||||Flux (Document d'urbanisme)|Document d'urbanisme||x|x||||||||
|PPRi (projet)||x||x||||||||||||||
|PPRi (projet)||||||geo_sup_pm1_ppri_projet_rq (PPRi zonage (projet) - remarque)|Annotation||x|x|x|x||type_rq|0 à 500000è|Symbole Goutte rouge pour remarque générale et verte pour remarque ponctuelle|Interactivité sur le champ info_bulle `'<i>Remarque</i>' || chr(10) || {type_rq} || chr(10) || '<i>annotée par</i>' || chr(10) || {nom} || chr(10) || 'le ' || to_char({date_sai},'DD-MM-YYYY') || chr(10) || CASE WHEN {date_maj} IS NOT NULL THEN 'modifiée le ' || to_char({date_maj},'DD-MM-YYYY') ELSE '' END || chr(10) || '<br><i>Activez l''outil<img src="http://geo.compiegnois.fr/documents/cms/i_geo.png" width="20" height="25"> puis cliquez sur l''icône<br> pour accéder aux informations détaillées</i>''<br><br><i>Accédez à la fiche d''aide sur la gestion <br> des annotations en faisant un clic gauche.</i>'` |3
|PPRi (projet)||||||Flux (Crue centennale - cote de référence)|Crue centennale - cote de référence||x|x||||||||
|PPRi (projet)||||||Flux (PPRi (projet) - zone de danger)|PPRi (projet) - zone de danger||x|x|||||||Onglet avancé activé pour définir un icône dans la thématique et afficher la légende du flux au clic sur cette incône|
|PPRi (projet)||||||Flux (PPRi (projet) - CSNE-MAGEO)|PPRi (projet) - CSNE-MAGEO||x|x|||||||Onglet avancé activé pour définir un icône dans la thématique et afficher la légende du flux au clic sur cette incône|
|PPRi (projet)||||||Flux (SUP PM1 - PPRi (projet) - zonage)|SUP PM1 - PPRi (projet) - zonage||x|x|||||||Onglet avancé activé pour définir un icône dans la thématique et afficher la légende du flux au clic sur cette incône|
|Foncier||x||x||||||||||||||
|Foncier||||||geo_v_fon_proprio_pu_pays|Propriété institutionnelle||x|x|x|||foncier_public_type||Une couleur par type||
|Cadastre||||x||||||||||||||
|Cadastre||||||r_bg_edigeo.PARCELLE (Parcelle V3)|Parcelle V3|||x|||x||0 à 8000è|Fond blanc 1% sans contour||

# L'application

* Généralités :

|Gabarit|Thème|Modules spé|Impression|Résultats|
|:---|:---|:---|:---|:---|
|Grand Public (1)|Thème Plan Interactif|StreetView,Google Analytics, coordonnées au survol,Météo,Partage de lien|Modèle standard GEO pas de possibilité d'ajouter des modèles||

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
