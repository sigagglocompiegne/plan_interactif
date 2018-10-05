![picto](/doc/img/Logo_web-GeoCompiegnois.png)

# Documentation d'administration de la base #

## Principes
 * **généralité** :
 Il n'y a pas à proprement dit de base de données propres pour générer l'application grand public Plan Interactif. Il s'agit plutôt d'un transfert de données existantes afin d'être consultable dans une application dédiée à partir d'une recherche d'adresse.
 
 * **résumé fonctionnel** :
Les données exploitées sont soient transférées en l'état ou soient retravaillées (calcul, forme, ...) sous forme de vues applicatives. Les données sont stockées sur un serveur Postgres déporté du prestataire de service GEO. Le transfert des données de la base de production (maitre) de l'Agglomération de la Région de Compiègne et la base déportée (esclave) a lieu tous les jours pendant la nuit. Ainsi les données mises à jour dans la journée sont disponibles le lendemain sur l'application.

## Schéma fonctionnel

![schema_fonctionnel](img/schema_fonctionnel_docurba.png)
