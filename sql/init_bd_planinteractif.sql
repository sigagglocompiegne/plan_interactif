-- ############################################################################################ SUIVI CODE SQL ###################################################################################################

-- 2018/10/05 : GB / Initialisation des requêtes d'exploitation pour le fonctionnel de l'application grand public Plan Interactif

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                       VUES APPLICATIVED GRAND PUBLIC                                                                      ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- ************************************************************************************************************************
-- *** ADRESSE
-- ************************************************************************************************************************

-- View: x_apps_public.xappspublic_geo_v_adresse

-- DROP VIEW x_apps_public.xappspublic_geo_v_adresse;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_geo_v_adresse AS
 SELECT p.id_adresse,
    p.id_voie,
    p.id_tronc,
    a.numero,
    a.repet,
    a.complement,
    a.etiquette,
    a.angle,
    v.libvoie_c,
    v.insee,
    k.codepostal,
    c.commune,
    v.rivoli,
    v.rivoli_cle,
    v.mot_dir,
    lta.valeur AS "position",
    ltb.valeur AS dest_adr,
    ltc.valeur AS etat_adr,
    i.refcad,
    i.nb_log,
    i.pc,
    ltd.valeur AS groupee,
    lte.valeur AS secondaire,
    ltf.valeur AS src_adr,
    ltg.valeur AS src_geom,
    p.src_date,
    p.date_sai,
    p.date_maj,
    a.observ,
    lth.valeur AS diag_adr,
    lti.valeur AS qual_adr,
    i.id_ext1,
    i.id_ext2,
    p.x_l93,
    p.y_l93,
    a.verif_base,
    p.geom
   FROM r_objet.geo_objet_pt_adresse p
     LEFT JOIN r_adresse.an_adresse a ON a.id_adresse = p.id_adresse
     LEFT JOIN r_adresse.an_adresse_info i ON i.id_adresse = p.id_adresse
     LEFT JOIN r_voie.an_voie v ON v.id_voie = p.id_voie
     LEFT JOIN r_administratif.lk_insee_codepostal k ON v.insee = k.insee::bpchar
     LEFT JOIN r_osm.geo_osm_commune c ON v.insee = c.insee::bpchar
     LEFT JOIN r_objet.lt_position lta ON lta.code::text = p."position"::text
     LEFT JOIN r_adresse.lt_dest_adr ltb ON ltb.code::text = i.dest_adr::text
     LEFT JOIN r_adresse.lt_etat_adr ltc ON ltc.code::text = i.etat_adr::text
     LEFT JOIN r_adresse.lt_groupee ltd ON ltd.code::text = i.groupee::text
     LEFT JOIN r_adresse.lt_secondaire lte ON lte.code::text = i.secondaire::text
     LEFT JOIN r_adresse.lt_src_adr ltf ON ltf.code::text = a.src_adr::text
     LEFT JOIN r_objet.lt_src_geom ltg ON ltg.code::text = p.src_geom::text
     LEFT JOIN r_adresse.lt_diag_adr lth ON lth.code::text = a.diag_adr::text
     LEFT JOIN r_adresse.lt_qual_adr lti ON lti.code::text = a.qual_adr::text
  WHERE a.diag_adr::text <> '12'::text;

ALTER TABLE x_apps_public.xappspublic_geo_v_adresse
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_geo_v_adresse
    IS 'Vue complète et décodée des adresses destinée à l''exploitation applicative (générateur d''apps)';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_geo_v_adresse TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_adresse TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_adresse TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_geo_v_adresse TO read_sig;


-- ************************************************************************************************************************
-- *** REFERENCE DES ELUS
-- ************************************************************************************************************************


-- View: x_apps_public.xappspublic_geo_vmr_planinteractif_refelu

-- DROP MATERIALIZED VIEW x_apps_public.xappspublic_geo_vmr_planinteractif_refelu;

CREATE MATERIALIZED VIEW x_apps_public.xappspublic_geo_vmr_planinteractif_refelu
TABLESPACE pg_default
AS
 WITH req_t AS (
        ( WITH req_quartier AS (
                 SELECT q_1.gid,
                    q_1.id,
                    q_1.insee,
                    q_1.nom,
                    q_1.commune,
                    q_1.l_logo,
                    q_1.geom
                   FROM r_administratif.geo_adm_quartier q_1
                  WHERE q_1.id = '159QUAR001'::bpchar
                ), req_maire AS (
                 SELECT m_1.gid,
                    m_1.insee,
                    m_1.l_m,
                    m_1.l_m_titre,
                    m_1.l_m_email,
                    m_1.l_m_tel,
                    m_1.l_m_url,
                    m_1.l_m_photo
                   FROM r_administratif.an_ref_maire m_1
                  WHERE m_1.insee = '60159'::bpchar
                ), req_eluq001 AS (
                 WITH req_eluq1 AS (
                         SELECT q11.gid,
                            q11.id,
                            q11.l_er AS l_er1,
                            q11.l_er_titre AS l_er_titre1,
                            q11.l_er_email AS l_er_email1,
                            q11.l_er_tel AS l_er_tel1,
                            q11.l_er_url AS l_er_url1,
                            q11.l_er_photo AS l_er_photo1
                           FROM r_administratif.an_ref_eluquartier q11
                          WHERE q11.id = '159QUAR001'::bpchar
                         OFFSET 0
                         LIMIT 1
                        ), req_eluq2 AS (
                         SELECT q12.gid,
                            q12.id,
                            q12.l_er AS l_er2,
                            q12.l_er_titre AS l_er_titre2,
                            q12.l_er_email AS l_er_email2,
                            q12.l_er_tel AS l_er_tel2,
                            q12.l_er_url AS l_er_url2,
                            q12.l_er_photo AS l_er_photo2
                           FROM r_administratif.an_ref_eluquartier q12
                          WHERE q12.id = '159QUAR001'::bpchar
                         OFFSET 1
                         LIMIT 1
                        )
                 SELECT q1_1.id,
                    q1_1.l_er1,
                    q1_1.l_er_titre1,
                    q1_1.l_er_email1,
                    q1_1.l_er_tel1,
                    q1_1.l_er_url1,
                    q1_1.l_er_photo1,
                    q2.l_er2,
                    q2.l_er_titre2,
                    q2.l_er_email2,
                    q2.l_er_tel2,
                    q2.l_er_url2,
                    q2.l_er_photo2
                   FROM req_eluq1 q1_1,
                    req_eluq2 q2
                  WHERE q1_1.id = q2.id
                )
         SELECT q.id,
            q.insee,
            q.nom,
            q.commune,
            q.l_logo,
            m.l_m,
            m.l_m_titre,
            m.l_m_email,
            m.l_m_tel,
            m.l_m_url,
            m.l_m_photo,
            q1.l_er1,
            q1.l_er_titre1,
            q1.l_er_email1,
            q1.l_er_tel1,
            q1.l_er_url1,
            q1.l_er_photo1,
            q1.l_er2,
            q1.l_er_titre2,
            q1.l_er_email2,
            q1.l_er_tel2,
            q1.l_er_url2,
            q1.l_er_photo2,
            NULL::character varying AS l_er3,
            NULL::character varying AS l_er_titre3,
            NULL::character varying AS l_er_email3,
            NULL::character varying AS l_er_tel3,
            NULL::character varying AS l_er_url3,
            NULL::character varying AS l_er_photo3,
            q.geom
           FROM req_quartier q,
            req_maire m,
            req_eluq001 q1
          WHERE q.insee = m.insee AND q1.id = q.id)
        UNION ALL
        ( WITH req_quartier AS (
                 SELECT q_1.gid,
                    q_1.id,
                    q_1.insee,
                    q_1.nom,
                    q_1.commune,
                    q_1.l_logo,
                    q_1.geom
                   FROM r_administratif.geo_adm_quartier q_1
                  WHERE q_1.id = '159QUAR002'::bpchar
                ), req_maire AS (
                 SELECT m_1.gid,
                    m_1.insee,
                    m_1.l_m,
                    m_1.l_m_titre,
                    m_1.l_m_email,
                    m_1.l_m_tel,
                    m_1.l_m_url,
                    m_1.l_m_photo
                   FROM r_administratif.an_ref_maire m_1
                  WHERE m_1.insee = '60159'::bpchar
                ), req_eluq002 AS (
                 WITH req_eluq2 AS (
                         SELECT q21.gid,
                            q21.id,
                            q21.l_er AS l_er1,
                            q21.l_er_titre AS l_er_titre1,
                            q21.l_er_email AS l_er_email1,
                            q21.l_er_tel AS l_er_tel1,
                            q21.l_er_url AS l_er_url1,
                            q21.l_er_photo AS l_er_photo1
                           FROM r_administratif.an_ref_eluquartier q21
                          WHERE q21.id = '159QUAR002'::bpchar
                         OFFSET 0
                         LIMIT 1
                        )
                 SELECT q2.id,
                    q2.l_er1,
                    q2.l_er_titre1,
                    q2.l_er_email1,
                    q2.l_er_tel1,
                    q2.l_er_url1,
                    q2.l_er_photo1
                   FROM req_eluq2 q2
                )
         SELECT q.id,
            q.insee,
            q.nom,
            q.commune,
            q.l_logo,
            m.l_m,
            m.l_m_titre,
            m.l_m_email,
            m.l_m_tel,
            m.l_m_url,
            m.l_m_photo,
            q1.l_er1,
            q1.l_er_titre1,
            q1.l_er_email1,
            q1.l_er_tel1,
            q1.l_er_url1,
            q1.l_er_photo1,
            NULL::character varying AS l_er2,
            NULL::character varying AS l_er_titre2,
            NULL::character varying AS l_er_email2,
            NULL::character varying AS l_er_tel2,
            NULL::character varying AS l_er_url2,
            NULL::character varying AS l_er_photo2,
            NULL::character varying AS l_er3,
            NULL::character varying AS l_er_titre3,
            NULL::character varying AS l_er_email3,
            NULL::character varying AS l_er_tel3,
            NULL::character varying AS l_er_url3,
            NULL::character varying AS l_er_photo3,
            q.geom
           FROM req_quartier q,
            req_maire m,
            req_eluq002 q1
          WHERE q.insee = m.insee AND q1.id = q.id)
        UNION ALL
        ( WITH req_quartier AS (
                 SELECT q_1.gid,
                    q_1.id,
                    q_1.insee,
                    q_1.nom,
                    q_1.commune,
                    q_1.l_logo,
                    q_1.geom
                   FROM r_administratif.geo_adm_quartier q_1
                  WHERE q_1.id = '159QUAR003'::bpchar
                ), req_maire AS (
                 SELECT m_1.gid,
                    m_1.insee,
                    m_1.l_m,
                    m_1.l_m_titre,
                    m_1.l_m_email,
                    m_1.l_m_tel,
                    m_1.l_m_url,
                    m_1.l_m_photo
                   FROM r_administratif.an_ref_maire m_1
                  WHERE m_1.insee = '60159'::bpchar
                ), req_eluq003 AS (
                 WITH req_eluq1 AS (
                         SELECT q31.gid,
                            q31.id,
                            q31.l_er AS l_er1,
                            q31.l_er_titre AS l_er_titre1,
                            q31.l_er_email AS l_er_email1,
                            q31.l_er_tel AS l_er_tel1,
                            q31.l_er_url AS l_er_url1,
                            q31.l_er_photo AS l_er_photo1
                           FROM r_administratif.an_ref_eluquartier q31
                          WHERE q31.id = '159QUAR003'::bpchar
                         OFFSET 0
                         LIMIT 1
                        ), req_eluq2 AS (
                         SELECT q32.gid,
                            q32.id,
                            q32.l_er AS l_er2,
                            q32.l_er_titre AS l_er_titre2,
                            q32.l_er_email AS l_er_email2,
                            q32.l_er_tel AS l_er_tel2,
                            q32.l_er_url AS l_er_url2,
                            q32.l_er_photo AS l_er_photo2
                           FROM r_administratif.an_ref_eluquartier q32
                          WHERE q32.id = '159QUAR003'::bpchar
                         OFFSET 1
                         LIMIT 1
                        )
                 SELECT q1.id,
                    q1.l_er1,
                    q1.l_er_titre1,
                    q1.l_er_email1,
                    q1.l_er_tel1,
                    q1.l_er_url1,
                    q1.l_er_photo1,
                    q2.l_er2,
                    q2.l_er_titre2,
                    q2.l_er_email2,
                    q2.l_er_tel2,
                    q2.l_er_url2,
                    q2.l_er_photo2
                   FROM req_eluq1 q1,
                    req_eluq2 q2
                  WHERE q1.id = q2.id
                )
         SELECT q.id,
            q.insee,
            q.nom,
            q.commune,
            q.l_logo,
            m.l_m,
            m.l_m_titre,
            m.l_m_email,
            m.l_m_tel,
            m.l_m_url,
            m.l_m_photo,
            q3.l_er1,
            q3.l_er_titre1,
            q3.l_er_email1,
            q3.l_er_tel1,
            q3.l_er_url1,
            q3.l_er_photo1,
            q3.l_er2,
            q3.l_er_titre2,
            q3.l_er_email2,
            q3.l_er_tel2,
            q3.l_er_url2,
            q3.l_er_photo2,
            NULL::character varying AS l_er3,
            NULL::character varying AS l_er_titre3,
            NULL::character varying AS l_er_email3,
            NULL::character varying AS l_er_tel3,
            NULL::character varying AS l_er_url3,
            NULL::character varying AS l_er_photo3,
            q.geom
           FROM req_quartier q,
            req_maire m,
            req_eluq003 q3
          WHERE q.insee = m.insee AND q3.id = q.id)
        UNION ALL
        ( WITH req_quartier AS (
                 SELECT q_1.gid,
                    q_1.id,
                    q_1.insee,
                    q_1.nom,
                    q_1.commune,
                    q_1.l_logo,
                    q_1.geom
                   FROM r_administratif.geo_adm_quartier q_1
                  WHERE q_1.id = '159QUAR004'::bpchar
                ), req_maire AS (
                 SELECT m_1.gid,
                    m_1.insee,
                    m_1.l_m,
                    m_1.l_m_titre,
                    m_1.l_m_email,
                    m_1.l_m_tel,
                    m_1.l_m_url,
                    m_1.l_m_photo
                   FROM r_administratif.an_ref_maire m_1
                  WHERE m_1.insee = '60159'::bpchar
                ), req_eluq004 AS (
                 WITH req_eluq1 AS (
                         SELECT q41.gid,
                            q41.id,
                            q41.l_er AS l_er1,
                            q41.l_er_titre AS l_er_titre1,
                            q41.l_er_email AS l_er_email1,
                            q41.l_er_tel AS l_er_tel1,
                            q41.l_er_url AS l_er_url1,
                            q41.l_er_photo AS l_er_photo1
                           FROM r_administratif.an_ref_eluquartier q41
                          WHERE q41.id = '159QUAR004'::bpchar
                         OFFSET 0
                         LIMIT 1
                        ), req_eluq2 AS (
                         SELECT q42.gid,
                            q42.id,
                            q42.l_er AS l_er2,
                            q42.l_er_titre AS l_er_titre2,
                            q42.l_er_email AS l_er_email2,
                            q42.l_er_tel AS l_er_tel2,
                            q42.l_er_url AS l_er_url2,
                            q42.l_er_photo AS l_er_photo2
                           FROM r_administratif.an_ref_eluquartier q42
                          WHERE q42.id = '159QUAR004'::bpchar
                         OFFSET 1
                         LIMIT 1
                        )
                 SELECT q1.id,
                    q1.l_er1,
                    q1.l_er_titre1,
                    q1.l_er_email1,
                    q1.l_er_tel1,
                    q1.l_er_url1,
                    q1.l_er_photo1,
                    q2.l_er2,
                    q2.l_er_titre2,
                    q2.l_er_email2,
                    q2.l_er_tel2,
                    q2.l_er_url2,
                    q2.l_er_photo2
                   FROM req_eluq1 q1,
                    req_eluq2 q2
                  WHERE q1.id = q2.id
                )
         SELECT q.id,
            q.insee,
            q.nom,
            q.commune,
            q.l_logo,
            m.l_m,
            m.l_m_titre,
            m.l_m_email,
            m.l_m_tel,
            m.l_m_url,
            m.l_m_photo,
            q4.l_er1,
            q4.l_er_titre1,
            q4.l_er_email1,
            q4.l_er_tel1,
            q4.l_er_url1,
            q4.l_er_photo1,
            q4.l_er2,
            q4.l_er_titre2,
            q4.l_er_email2,
            q4.l_er_tel2,
            q4.l_er_url2,
            q4.l_er_photo2,
            NULL::character varying AS l_er3,
            NULL::character varying AS l_er_titre3,
            NULL::character varying AS l_er_email3,
            NULL::character varying AS l_er_tel3,
            NULL::character varying AS l_er_url3,
            NULL::character varying AS l_er_photo3,
            q.geom
           FROM req_quartier q,
            req_maire m,
            req_eluq004 q4
          WHERE q.insee = m.insee AND q4.id = q.id)
        UNION ALL
        ( WITH req_quartier AS (
                 SELECT q_1.gid,
                    q_1.id,
                    q_1.insee,
                    q_1.nom,
                    q_1.commune,
                    q_1.l_logo,
                    q_1.geom
                   FROM r_administratif.geo_adm_quartier q_1
                  WHERE q_1.id = '159QUAR005'::bpchar
                ), req_maire AS (
                 SELECT m_1.gid,
                    m_1.insee,
                    m_1.l_m,
                    m_1.l_m_titre,
                    m_1.l_m_email,
                    m_1.l_m_tel,
                    m_1.l_m_url,
                    m_1.l_m_photo
                   FROM r_administratif.an_ref_maire m_1
                  WHERE m_1.insee = '60159'::bpchar
                ), req_eluq005 AS (
                 WITH req_eluq1 AS (
                         SELECT q51.gid,
                            q51.id,
                            q51.l_er AS l_er1,
                            q51.l_er_titre AS l_er_titre1,
                            q51.l_er_email AS l_er_email1,
                            q51.l_er_tel AS l_er_tel1,
                            q51.l_er_url AS l_er_url1,
                            q51.l_er_photo AS l_er_photo1
                           FROM r_administratif.an_ref_eluquartier q51
                          WHERE q51.id = '159QUAR005'::bpchar
                         OFFSET 0
                         LIMIT 1
                        ), req_eluq2 AS (
                         SELECT q52.gid,
                            q52.id,
                            q52.l_er AS l_er2,
                            q52.l_er_titre AS l_er_titre2,
                            q52.l_er_email AS l_er_email2,
                            q52.l_er_tel AS l_er_tel2,
                            q52.l_er_url AS l_er_url2,
                            q52.l_er_photo AS l_er_photo2
                           FROM r_administratif.an_ref_eluquartier q52
                          WHERE q52.id = '159QUAR005'::bpchar
                         OFFSET 1
                         LIMIT 1
                        ), req_eluq3 AS (
                         SELECT q53.gid,
                            q53.id,
                            q53.l_er AS l_er3,
                            q53.l_er_titre AS l_er_titre3,
                            q53.l_er_email AS l_er_email3,
                            q53.l_er_tel AS l_er_tel3,
                            q53.l_er_url AS l_er_url3,
                            q53.l_er_photo AS l_er_photo3
                           FROM r_administratif.an_ref_eluquartier q53
                          WHERE q53.id = '159QUAR005'::bpchar
                         OFFSET 2
                         LIMIT 1
                        )
                 SELECT q1.id,
                    q1.l_er1,
                    q1.l_er_titre1,
                    q1.l_er_email1,
                    q1.l_er_tel1,
                    q1.l_er_url1,
                    q1.l_er_photo1,
                    q2.l_er2,
                    q2.l_er_titre2,
                    q2.l_er_email2,
                    q2.l_er_tel2,
                    q2.l_er_url2,
                    q2.l_er_photo2,
                    q3.l_er3,
                    q3.l_er_titre3,
                    q3.l_er_email3,
                    q3.l_er_tel3,
                    q3.l_er_url3,
                    q3.l_er_photo3
                   FROM req_eluq1 q1,
                    req_eluq2 q2,
                    req_eluq3 q3
                  WHERE q1.id = q2.id AND q1.id = q3.id
                )
         SELECT q.id,
            q.insee,
            q.nom,
            q.commune,
            q.l_logo,
            m.l_m,
            m.l_m_titre,
            m.l_m_email,
            m.l_m_tel,
            m.l_m_url,
            m.l_m_photo,
            q5.l_er1,
            q5.l_er_titre1,
            q5.l_er_email1,
            q5.l_er_tel1,
            q5.l_er_url1,
            q5.l_er_photo1,
            q5.l_er2,
            q5.l_er_titre2,
            q5.l_er_email2,
            q5.l_er_tel2,
            q5.l_er_url2,
            q5.l_er_photo2,
            q5.l_er3,
            q5.l_er_titre3,
            q5.l_er_email3,
            q5.l_er_tel3,
            q5.l_er_url3,
            q5.l_er_photo3,
            q.geom
           FROM req_quartier q,
            req_maire m,
            req_eluq005 q5
          WHERE q.insee = m.insee AND q5.id = q.id)
        UNION ALL
        ( WITH req_quartier AS (
                 SELECT q_1.gid,
                    q_1.id,
                    q_1.insee,
                    q_1.nom,
                    q_1.commune,
                    q_1.l_logo,
                    q_1.geom
                   FROM r_administratif.geo_adm_quartier q_1
                  WHERE q_1.id = '159QUAR006'::bpchar
                ), req_maire AS (
                 SELECT m_1.gid,
                    m_1.insee,
                    m_1.l_m,
                    m_1.l_m_titre,
                    m_1.l_m_email,
                    m_1.l_m_tel,
                    m_1.l_m_url,
                    m_1.l_m_photo
                   FROM r_administratif.an_ref_maire m_1
                  WHERE m_1.insee = '60159'::bpchar
                ), req_eluq006 AS (
                 WITH req_eluq6 AS (
                         SELECT q61.gid,
                            q61.id,
                            q61.l_er AS l_er1,
                            q61.l_er_titre AS l_er_titre1,
                            q61.l_er_email AS l_er_email1,
                            q61.l_er_tel AS l_er_tel1,
                            q61.l_er_url AS l_er_url1,
                            q61.l_er_photo AS l_er_photo1
                           FROM r_administratif.an_ref_eluquartier q61
                          WHERE q61.id = '159QUAR006'::bpchar
                         OFFSET 0
                         LIMIT 1
                        )
                 SELECT q6_1.id,
                    q6_1.l_er1,
                    q6_1.l_er_titre1,
                    q6_1.l_er_email1,
                    q6_1.l_er_tel1,
                    q6_1.l_er_url1,
                    q6_1.l_er_photo1
                   FROM req_eluq6 q6_1
                )
         SELECT q.id,
            q.insee,
            q.nom,
            q.commune,
            q.l_logo,
            m.l_m,
            m.l_m_titre,
            m.l_m_email,
            m.l_m_tel,
            m.l_m_url,
            m.l_m_photo,
            q6.l_er1,
            q6.l_er_titre1,
            q6.l_er_email1,
            q6.l_er_tel1,
            q6.l_er_url1,
            q6.l_er_photo1,
            NULL::character varying AS l_er2,
            NULL::character varying AS l_er_titre2,
            NULL::character varying AS l_er_email2,
            NULL::character varying AS l_er_tel2,
            NULL::character varying AS l_er_url2,
            NULL::character varying AS l_er_photo2,
            NULL::character varying AS l_er3,
            NULL::character varying AS l_er_titre3,
            NULL::character varying AS l_er_email3,
            NULL::character varying AS l_er_tel3,
            NULL::character varying AS l_er_url3,
            NULL::character varying AS l_er_photo3,
            q.geom
           FROM req_quartier q,
            req_maire m,
            req_eluq006 q6
          WHERE q.insee = m.insee AND q6.id = q.id)
        UNION ALL
        ( WITH req_quartier AS (
                 SELECT q_1.gid,
                    q_1.id,
                    q_1.insee,
                    q_1.nom,
                    q_1.commune,
                    q_1.l_logo,
                    q_1.geom
                   FROM r_administratif.geo_adm_quartier q_1
                  WHERE q_1.id = '159QUAR007'::bpchar
                ), req_maire AS (
                 SELECT m_1.gid,
                    m_1.insee,
                    m_1.l_m,
                    m_1.l_m_titre,
                    m_1.l_m_email,
                    m_1.l_m_tel,
                    m_1.l_m_url,
                    m_1.l_m_photo
                   FROM r_administratif.an_ref_maire m_1
                  WHERE m_1.insee = '60159'::bpchar
                ), req_eluq007 AS (
                 WITH req_eluq7 AS (
                         SELECT q71.gid,
                            q71.id,
                            q71.l_er AS l_er1,
                            q71.l_er_titre AS l_er_titre1,
                            q71.l_er_email AS l_er_email1,
                            q71.l_er_tel AS l_er_tel1,
                            q71.l_er_url AS l_er_url1,
                            q71.l_er_photo AS l_er_photo1
                           FROM r_administratif.an_ref_eluquartier q71
                          WHERE q71.id = '159QUAR007'::bpchar
                         OFFSET 0
                         LIMIT 1
                        )
                 SELECT q7_1.id,
                    q7_1.l_er1,
                    q7_1.l_er_titre1,
                    q7_1.l_er_email1,
                    q7_1.l_er_tel1,
                    q7_1.l_er_url1,
                    q7_1.l_er_photo1
                   FROM req_eluq7 q7_1
                )
         SELECT q.id,
            q.insee,
            q.nom,
            q.commune,
            q.l_logo,
            m.l_m,
            m.l_m_titre,
            m.l_m_email,
            m.l_m_tel,
            m.l_m_url,
            m.l_m_photo,
            q7.l_er1,
            q7.l_er_titre1,
            q7.l_er_email1,
            q7.l_er_tel1,
            q7.l_er_url1,
            q7.l_er_photo1,
            NULL::character varying AS l_er2,
            NULL::character varying AS l_er_titre2,
            NULL::character varying AS l_er_email2,
            NULL::character varying AS l_er_tel2,
            NULL::character varying AS l_er_url2,
            NULL::character varying AS l_er_photo2,
            NULL::character varying AS l_er3,
            NULL::character varying AS l_er_titre3,
            NULL::character varying AS l_er_email3,
            NULL::character varying AS l_er_tel3,
            NULL::character varying AS l_er_url3,
            NULL::character varying AS l_er_photo3,
            q.geom
           FROM req_quartier q,
            req_maire m,
            req_eluq007 q7
          WHERE q.insee = m.insee AND q7.id = q.id)
        UNION ALL
        ( WITH req_quartier AS (
                 SELECT q_1.gid,
                    q_1.id,
                    q_1.insee,
                    q_1.nom,
                    q_1.commune,
                    q_1.l_logo,
                    q_1.geom
                   FROM r_administratif.geo_adm_quartier q_1
                  WHERE q_1.id = '159QUAR008'::bpchar
                ), req_maire AS (
                 SELECT m_1.gid,
                    m_1.insee,
                    m_1.l_m,
                    m_1.l_m_titre,
                    m_1.l_m_email,
                    m_1.l_m_tel,
                    m_1.l_m_url,
                    m_1.l_m_photo
                   FROM r_administratif.an_ref_maire m_1
                  WHERE m_1.insee = '60159'::bpchar
                ), req_eluq008 AS (
                 WITH req_eluq1 AS (
                         SELECT q81.gid,
                            q81.id,
                            q81.l_er AS l_er1,
                            q81.l_er_titre AS l_er_titre1,
                            q81.l_er_email AS l_er_email1,
                            q81.l_er_tel AS l_er_tel1,
                            q81.l_er_url AS l_er_url1,
                            q81.l_er_photo AS l_er_photo1
                           FROM r_administratif.an_ref_eluquartier q81
                          WHERE q81.id = '159QUAR008'::bpchar
                         OFFSET 0
                         LIMIT 1
                        ), req_eluq2 AS (
                         SELECT q82.gid,
                            q82.id,
                            q82.l_er AS l_er2,
                            q82.l_er_titre AS l_er_titre2,
                            q82.l_er_email AS l_er_email2,
                            q82.l_er_tel AS l_er_tel2,
                            q82.l_er_url AS l_er_url2,
                            q82.l_er_photo AS l_er_photo2
                           FROM r_administratif.an_ref_eluquartier q82
                          WHERE q82.id = '159QUAR008'::bpchar
                         OFFSET 1
                         LIMIT 1
                        )
                 SELECT q1.id,
                    q1.l_er1,
                    q1.l_er_titre1,
                    q1.l_er_email1,
                    q1.l_er_tel1,
                    q1.l_er_url1,
                    q1.l_er_photo1,
                    q2.l_er2,
                    q2.l_er_titre2,
                    q2.l_er_email2,
                    q2.l_er_tel2,
                    q2.l_er_url2,
                    q2.l_er_photo2
                   FROM req_eluq1 q1,
                    req_eluq2 q2
                  WHERE q1.id = q2.id
                )
         SELECT q.id,
            q.insee,
            q.nom,
            q.commune,
            q.l_logo,
            m.l_m,
            m.l_m_titre,
            m.l_m_email,
            m.l_m_tel,
            m.l_m_url,
            m.l_m_photo,
            q8.l_er1,
            q8.l_er_titre1,
            q8.l_er_email1,
            q8.l_er_tel1,
            q8.l_er_url1,
            q8.l_er_photo1,
            q8.l_er2,
            q8.l_er_titre2,
            q8.l_er_email2,
            q8.l_er_tel2,
            q8.l_er_url2,
            q8.l_er_photo2,
            NULL::character varying AS l_er3,
            NULL::character varying AS l_er_titre3,
            NULL::character varying AS l_er_email3,
            NULL::character varying AS l_er_tel3,
            NULL::character varying AS l_er_url3,
            NULL::character varying AS l_er_photo3,
            q.geom
           FROM req_quartier q,
            req_maire m,
            req_eluq008 q8
          WHERE q.insee = m.insee AND q8.id = q.id)
        UNION ALL
        ( WITH req_quartier AS (
                 SELECT q_1.gid,
                    q_1.id,
                    q_1.insee,
                    q_1.nom,
                    q_1.commune,
                    q_1.l_logo,
                    q_1.geom
                   FROM r_administratif.geo_adm_quartier q_1
                  WHERE q_1.id = '159QUAR009'::bpchar
                ), req_maire AS (
                 SELECT m_1.gid,
                    m_1.insee,
                    m_1.l_m,
                    m_1.l_m_titre,
                    m_1.l_m_email,
                    m_1.l_m_tel,
                    m_1.l_m_url,
                    m_1.l_m_photo
                   FROM r_administratif.an_ref_maire m_1
                  WHERE m_1.insee = '60159'::bpchar
                ), req_eluq009 AS (
                 WITH req_eluq1 AS (
                         SELECT q91.gid,
                            q91.id,
                            q91.l_er AS l_er1,
                            q91.l_er_titre AS l_er_titre1,
                            q91.l_er_email AS l_er_email1,
                            q91.l_er_tel AS l_er_tel1,
                            q91.l_er_url AS l_er_url1,
                            q91.l_er_photo AS l_er_photo1
                           FROM r_administratif.an_ref_eluquartier q91
                          WHERE q91.id = '159QUAR009'::bpchar
                         OFFSET 0
                         LIMIT 1
                        ), req_eluq2 AS (
                         SELECT q92.gid,
                            q92.id,
                            q92.l_er AS l_er2,
                            q92.l_er_titre AS l_er_titre2,
                            q92.l_er_email AS l_er_email2,
                            q92.l_er_tel AS l_er_tel2,
                            q92.l_er_url AS l_er_url2,
                            q92.l_er_photo AS l_er_photo2
                           FROM r_administratif.an_ref_eluquartier q92
                          WHERE q92.id = '159QUAR009'::bpchar
                         OFFSET 1
                         LIMIT 1
                        )
                 SELECT q1.id,
                    q1.l_er1,
                    q1.l_er_titre1,
                    q1.l_er_email1,
                    q1.l_er_tel1,
                    q1.l_er_url1,
                    q1.l_er_photo1,
                    q2.l_er2,
                    q2.l_er_titre2,
                    q2.l_er_email2,
                    q2.l_er_tel2,
                    q2.l_er_url2,
                    q2.l_er_photo2
                   FROM req_eluq1 q1,
                    req_eluq2 q2
                  WHERE q1.id = q2.id
                )
         SELECT q.id,
            q.insee,
            q.nom,
            q.commune,
            q.l_logo,
            m.l_m,
            m.l_m_titre,
            m.l_m_email,
            m.l_m_tel,
            m.l_m_url,
            m.l_m_photo,
            q9.l_er1,
            q9.l_er_titre1,
            q9.l_er_email1,
            q9.l_er_tel1,
            q9.l_er_url1,
            q9.l_er_photo1,
            q9.l_er2,
            q9.l_er_titre2,
            q9.l_er_email2,
            q9.l_er_tel2,
            q9.l_er_url2,
            q9.l_er_photo2,
            NULL::character varying AS l_er3,
            NULL::character varying AS l_er_titre3,
            NULL::character varying AS l_er_email3,
            NULL::character varying AS l_er_tel3,
            NULL::character varying AS l_er_url3,
            NULL::character varying AS l_er_photo3,
            q.geom
           FROM req_quartier q,
            req_maire m,
            req_eluq009 q9
          WHERE q.insee = m.insee AND q9.id = q.id)
        UNION ALL
        ( WITH req_quartier AS (
                 SELECT q_1.gid,
                    q_1.id,
                    q_1.insee,
                    q_1.nom,
                    q_1.commune,
                    q_1.l_logo,
                    q_1.geom
                   FROM r_administratif.geo_adm_quartier q_1
                  WHERE q_1.id = '159QUAR010'::bpchar
                ), req_maire AS (
                 SELECT m_1.gid,
                    m_1.insee,
                    m_1.l_m,
                    m_1.l_m_titre,
                    m_1.l_m_email,
                    m_1.l_m_tel,
                    m_1.l_m_url,
                    m_1.l_m_photo
                   FROM r_administratif.an_ref_maire m_1
                  WHERE m_1.insee = '60159'::bpchar
                ), req_eluq010 AS (
                 WITH req_eluq1 AS (
                         SELECT q101.gid,
                            q101.id,
                            q101.l_er AS l_er1,
                            q101.l_er_titre AS l_er_titre1,
                            q101.l_er_email AS l_er_email1,
                            q101.l_er_tel AS l_er_tel1,
                            q101.l_er_url AS l_er_url1,
                            q101.l_er_photo AS l_er_photo1
                           FROM r_administratif.an_ref_eluquartier q101
                          WHERE q101.id = '159QUAR010'::bpchar
                         OFFSET 0
                         LIMIT 1
                        ), req_eluq2 AS (
                         SELECT q102.gid,
                            q102.id,
                            q102.l_er AS l_er2,
                            q102.l_er_titre AS l_er_titre2,
                            q102.l_er_email AS l_er_email2,
                            q102.l_er_tel AS l_er_tel2,
                            q102.l_er_url AS l_er_url2,
                            q102.l_er_photo AS l_er_photo2
                           FROM r_administratif.an_ref_eluquartier q102
                          WHERE q102.id = '159QUAR010'::bpchar
                         OFFSET 1
                         LIMIT 1
                        )
                 SELECT q1.id,
                    q1.l_er1,
                    q1.l_er_titre1,
                    q1.l_er_email1,
                    q1.l_er_tel1,
                    q1.l_er_url1,
                    q1.l_er_photo1,
                    q2.l_er2,
                    q2.l_er_titre2,
                    q2.l_er_email2,
                    q2.l_er_tel2,
                    q2.l_er_url2,
                    q2.l_er_photo2
                   FROM req_eluq1 q1,
                    req_eluq2 q2
                  WHERE q1.id = q2.id
                )
         SELECT q.id,
            q.insee,
            q.nom,
            q.commune,
            q.l_logo,
            m.l_m,
            m.l_m_titre,
            m.l_m_email,
            m.l_m_tel,
            m.l_m_url,
            m.l_m_photo,
            q10.l_er1,
            q10.l_er_titre1,
            q10.l_er_email1,
            q10.l_er_tel1,
            q10.l_er_url1,
            q10.l_er_photo1,
            q10.l_er2,
            q10.l_er_titre2,
            q10.l_er_email2,
            q10.l_er_tel2,
            q10.l_er_url2,
            q10.l_er_photo2,
            NULL::character varying AS l_er3,
            NULL::character varying AS l_er_titre3,
            NULL::character varying AS l_er_email3,
            NULL::character varying AS l_er_tel3,
            NULL::character varying AS l_er_url3,
            NULL::character varying AS l_er_photo3,
            q.geom
           FROM req_quartier q,
            req_maire m,
            req_eluq010 q10
          WHERE q.insee = m.insee AND q10.id = q.id)
        UNION ALL
        ( WITH req_quartier AS (
                 SELECT q_1.gid,
                    q_1.id,
                    q_1.insee,
                    q_1.nom,
                    q_1.commune,
                    q_1.l_logo,
                    q_1.geom
                   FROM r_administratif.geo_adm_quartier q_1
                  WHERE q_1.id = '159QUAR011'::bpchar
                ), req_maire AS (
                 SELECT m_1.gid,
                    m_1.insee,
                    m_1.l_m,
                    m_1.l_m_titre,
                    m_1.l_m_email,
                    m_1.l_m_tel,
                    m_1.l_m_url,
                    m_1.l_m_photo
                   FROM r_administratif.an_ref_maire m_1
                  WHERE m_1.insee = '60159'::bpchar
                ), req_eluq011 AS (
                 WITH req_eluq11 AS (
                         SELECT q111.gid,
                            q111.id,
                            q111.l_er AS l_er1,
                            q111.l_er_titre AS l_er_titre1,
                            q111.l_er_email AS l_er_email1,
                            q111.l_er_tel AS l_er_tel1,
                            q111.l_er_url AS l_er_url1,
                            q111.l_er_photo AS l_er_photo1
                           FROM r_administratif.an_ref_eluquartier q111
                          WHERE q111.id = '159QUAR011'::bpchar
                         OFFSET 0
                         LIMIT 1
                        )
                 SELECT q11_1.id,
                    q11_1.l_er1,
                    q11_1.l_er_titre1,
                    q11_1.l_er_email1,
                    q11_1.l_er_tel1,
                    q11_1.l_er_url1,
                    q11_1.l_er_photo1
                   FROM req_eluq11 q11_1
                )
         SELECT q.id,
            q.insee,
            q.nom,
            q.commune,
            q.l_logo,
            m.l_m,
            m.l_m_titre,
            m.l_m_email,
            m.l_m_tel,
            m.l_m_url,
            m.l_m_photo,
            q11.l_er1,
            q11.l_er_titre1,
            q11.l_er_email1,
            q11.l_er_tel1,
            q11.l_er_url1,
            q11.l_er_photo1,
            NULL::character varying AS l_er2,
            NULL::character varying AS l_er_titre2,
            NULL::character varying AS l_er_email2,
            NULL::character varying AS l_er_tel2,
            NULL::character varying AS l_er_url2,
            NULL::character varying AS l_er_photo2,
            NULL::character varying AS l_er3,
            NULL::character varying AS l_er_titre3,
            NULL::character varying AS l_er_email3,
            NULL::character varying AS l_er_tel3,
            NULL::character varying AS l_er_url3,
            NULL::character varying AS l_er_photo3,
            q.geom
           FROM req_quartier q,
            req_maire m,
            req_eluq011 q11
          WHERE q.insee = m.insee AND q11.id = q.id)
        UNION ALL
        ( WITH req_quartier AS (
                 SELECT q_1.gid,
                    q_1.id,
                    q_1.insee,
                    q_1.nom,
                    q_1.commune,
                    q_1.l_logo,
                    q_1.geom
                   FROM r_administratif.geo_adm_quartier q_1
                  WHERE q_1.id = '159QUAR012'::bpchar
                ), req_maire AS (
                 SELECT m_1.gid,
                    m_1.insee,
                    m_1.l_m,
                    m_1.l_m_titre,
                    m_1.l_m_email,
                    m_1.l_m_tel,
                    m_1.l_m_url,
                    m_1.l_m_photo
                   FROM r_administratif.an_ref_maire m_1
                  WHERE m_1.insee = '60159'::bpchar
                ), req_eluq012 AS (
                 WITH req_eluq12 AS (
                         SELECT q121.gid,
                            q121.id,
                            q121.l_er AS l_er1,
                            q121.l_er_titre AS l_er_titre1,
                            q121.l_er_email AS l_er_email1,
                            q121.l_er_tel AS l_er_tel1,
                            q121.l_er_url AS l_er_url1,
                            q121.l_er_photo AS l_er_photo1
                           FROM r_administratif.an_ref_eluquartier q121
                          WHERE q121.id = '159QUAR012'::bpchar
                         OFFSET 0
                         LIMIT 1
                        )
                 SELECT q12_1.id,
                    q12_1.l_er1,
                    q12_1.l_er_titre1,
                    q12_1.l_er_email1,
                    q12_1.l_er_tel1,
                    q12_1.l_er_url1,
                    q12_1.l_er_photo1
                   FROM req_eluq12 q12_1
                )
         SELECT q.id,
            q.insee,
            q.nom,
            q.commune,
            q.l_logo,
            m.l_m,
            m.l_m_titre,
            m.l_m_email,
            m.l_m_tel,
            m.l_m_url,
            m.l_m_photo,
            q12.l_er1,
            q12.l_er_titre1,
            q12.l_er_email1,
            q12.l_er_tel1,
            q12.l_er_url1,
            q12.l_er_photo1,
            NULL::character varying AS l_er2,
            NULL::character varying AS l_er_titre2,
            NULL::character varying AS l_er_email2,
            NULL::character varying AS l_er_tel2,
            NULL::character varying AS l_er_url2,
            NULL::character varying AS l_er_photo2,
            NULL::character varying AS l_er3,
            NULL::character varying AS l_er_titre3,
            NULL::character varying AS l_er_email3,
            NULL::character varying AS l_er_tel3,
            NULL::character varying AS l_er_url3,
            NULL::character varying AS l_er_photo3,
            q.geom
           FROM req_quartier q,
            req_maire m,
            req_eluq012 q12
          WHERE q.insee = m.insee AND q12.id = q.id)
        UNION ALL
        ( WITH req_quartier AS (
                 SELECT q_1.gid,
                    q_1.id,
                    q_1.insee,
                    q_1.nom,
                    q_1.commune,
                    q_1.l_logo,
                    q_1.geom
                   FROM r_administratif.geo_adm_quartier q_1
                  WHERE q_1.id = '159QUAR013'::bpchar
                ), req_maire AS (
                 SELECT m_1.gid,
                    m_1.insee,
                    m_1.l_m,
                    m_1.l_m_titre,
                    m_1.l_m_email,
                    m_1.l_m_tel,
                    m_1.l_m_url,
                    m_1.l_m_photo
                   FROM r_administratif.an_ref_maire m_1
                  WHERE m_1.insee = '60159'::bpchar
                ), req_eluq013 AS (
                 WITH req_eluq1 AS (
                         SELECT q131.gid,
                            q131.id,
                            q131.l_er AS l_er1,
                            q131.l_er_titre AS l_er_titre1,
                            q131.l_er_email AS l_er_email1,
                            q131.l_er_tel AS l_er_tel1,
                            q131.l_er_url AS l_er_url1,
                            q131.l_er_photo AS l_er_photo1
                           FROM r_administratif.an_ref_eluquartier q131
                          WHERE q131.id = '159QUAR013'::bpchar
                         OFFSET 0
                         LIMIT 1
                        ), req_eluq2 AS (
                         SELECT q132.gid,
                            q132.id,
                            q132.l_er AS l_er2,
                            q132.l_er_titre AS l_er_titre2,
                            q132.l_er_email AS l_er_email2,
                            q132.l_er_tel AS l_er_tel2,
                            q132.l_er_url AS l_er_url2,
                            q132.l_er_photo AS l_er_photo2
                           FROM r_administratif.an_ref_eluquartier q132
                          WHERE q132.id = '159QUAR013'::bpchar
                         OFFSET 1
                         LIMIT 1
                        )
                 SELECT q1.id,
                    q1.l_er1,
                    q1.l_er_titre1,
                    q1.l_er_email1,
                    q1.l_er_tel1,
                    q1.l_er_url1,
                    q1.l_er_photo1,
                    q2.l_er2,
                    q2.l_er_titre2,
                    q2.l_er_email2,
                    q2.l_er_tel2,
                    q2.l_er_url2,
                    q2.l_er_photo2
                   FROM req_eluq1 q1,
                    req_eluq2 q2
                  WHERE q1.id = q2.id
                )
         SELECT q.id,
            q.insee,
            q.nom,
            q.commune,
            q.l_logo,
            m.l_m,
            m.l_m_titre,
            m.l_m_email,
            m.l_m_tel,
            m.l_m_url,
            m.l_m_photo,
            q13.l_er1,
            q13.l_er_titre1,
            q13.l_er_email1,
            q13.l_er_tel1,
            q13.l_er_url1,
            q13.l_er_photo1,
            q13.l_er2,
            q13.l_er_titre2,
            q13.l_er_email2,
            q13.l_er_tel2,
            q13.l_er_url2,
            q13.l_er_photo2,
            NULL::character varying AS l_er3,
            NULL::character varying AS l_er_titre3,
            NULL::character varying AS l_er_email3,
            NULL::character varying AS l_er_tel3,
            NULL::character varying AS l_er_url3,
            NULL::character varying AS l_er_photo3,
            q.geom
           FROM req_quartier q,
            req_maire m,
            req_eluq013 q13
          WHERE q.insee = m.insee AND q13.id = q.id)
        UNION ALL
        ( WITH req_quartier AS (
                 SELECT q_1.gid,
                    q_1.id,
                    q_1.insee,
                    q_1.nom,
                    q_1.commune,
                    q_1.l_logo,
                    q_1.geom
                   FROM r_administratif.geo_adm_quartier q_1
                  WHERE q_1.id = '159QUAR014'::bpchar
                ), req_maire AS (
                 SELECT m_1.gid,
                    m_1.insee,
                    m_1.l_m,
                    m_1.l_m_titre,
                    m_1.l_m_email,
                    m_1.l_m_tel,
                    m_1.l_m_url,
                    m_1.l_m_photo
                   FROM r_administratif.an_ref_maire m_1
                  WHERE m_1.insee = '60159'::bpchar
                ), req_eluq014 AS (
                 WITH req_eluq1 AS (
                         SELECT q141.gid,
                            q141.id,
                            q141.l_er AS l_er1,
                            q141.l_er_titre AS l_er_titre1,
                            q141.l_er_email AS l_er_email1,
                            q141.l_er_tel AS l_er_tel1,
                            q141.l_er_url AS l_er_url1,
                            q141.l_er_photo AS l_er_photo1
                           FROM r_administratif.an_ref_eluquartier q141
                          WHERE q141.id = '159QUAR014'::bpchar
                         OFFSET 0
                         LIMIT 1
                        ), req_eluq2 AS (
                         SELECT q142.gid,
                            q142.id,
                            q142.l_er AS l_er2,
                            q142.l_er_titre AS l_er_titre2,
                            q142.l_er_email AS l_er_email2,
                            q142.l_er_tel AS l_er_tel2,
                            q142.l_er_url AS l_er_url2,
                            q142.l_er_photo AS l_er_photo2
                           FROM r_administratif.an_ref_eluquartier q142
                          WHERE q142.id = '159QUAR014'::bpchar
                         OFFSET 1
                         LIMIT 1
                        )
                 SELECT q1.id,
                    q1.l_er1,
                    q1.l_er_titre1,
                    q1.l_er_email1,
                    q1.l_er_tel1,
                    q1.l_er_url1,
                    q1.l_er_photo1,
                    q2.l_er2,
                    q2.l_er_titre2,
                    q2.l_er_email2,
                    q2.l_er_tel2,
                    q2.l_er_url2,
                    q2.l_er_photo2
                   FROM req_eluq1 q1,
                    req_eluq2 q2
                  WHERE q1.id = q2.id
                )
         SELECT q.id,
            q.insee,
            q.nom,
            q.commune,
            q.l_logo,
            m.l_m,
            m.l_m_titre,
            m.l_m_email,
            m.l_m_tel,
            m.l_m_url,
            m.l_m_photo,
            q14.l_er1,
            q14.l_er_titre1,
            q14.l_er_email1,
            q14.l_er_tel1,
            q14.l_er_url1,
            q14.l_er_photo1,
            q14.l_er2,
            q14.l_er_titre2,
            q14.l_er_email2,
            q14.l_er_tel2,
            q14.l_er_url2,
            q14.l_er_photo2,
            NULL::character varying AS l_er3,
            NULL::character varying AS l_er_titre3,
            NULL::character varying AS l_er_email3,
            NULL::character varying AS l_er_tel3,
            NULL::character varying AS l_er_url3,
            NULL::character varying AS l_er_photo3,
            q.geom
           FROM req_quartier q,
            req_maire m,
            req_eluq014 q14
          WHERE q.insee = m.insee AND q14.id = q.id)
        UNION ALL
        ( WITH req_quartier AS (
                 SELECT q_1.gid,
                    q_1.id,
                    q_1.insee,
                    q_1.nom,
                    q_1.commune,
                    q_1.l_logo,
                    q_1.geom
                   FROM r_administratif.geo_adm_quartier q_1
                  WHERE q_1.id = '159QUAR015'::bpchar
                ), req_maire AS (
                 SELECT m_1.gid,
                    m_1.insee,
                    m_1.l_m,
                    m_1.l_m_titre,
                    m_1.l_m_email,
                    m_1.l_m_tel,
                    m_1.l_m_url,
                    m_1.l_m_photo
                   FROM r_administratif.an_ref_maire m_1
                  WHERE m_1.insee = '60159'::bpchar
                )
         SELECT q.id,
            q.insee,
            q.nom,
            q.commune,
            q.l_logo,
            m.l_m,
            m.l_m_titre,
            m.l_m_email,
            m.l_m_tel,
            m.l_m_url,
            m.l_m_photo,
            NULL::character varying AS l_er1,
            NULL::character varying AS l_er_titre1,
            NULL::character varying AS l_er_email1,
            NULL::character varying AS l_er_tel1,
            NULL::character varying AS l_er_url1,
            NULL::character varying AS l_er_photo1,
            NULL::character varying AS l_er2,
            NULL::character varying AS l_er_titre2,
            NULL::character varying AS l_er_email2,
            NULL::character varying AS l_er_tel2,
            NULL::character varying AS l_er_url2,
            NULL::character varying AS l_er_photo2,
            NULL::character varying AS l_er3,
            NULL::character varying AS l_er_titre3,
            NULL::character varying AS l_er_email3,
            NULL::character varying AS l_er_tel3,
            NULL::character varying AS l_er_url3,
            NULL::character varying AS l_er_photo3,
            q.geom
           FROM req_quartier q,
            req_maire m
          WHERE q.insee = m.insee)
        UNION ALL
        ( WITH req_quartier AS (
                 SELECT q_1.gid,
                    q_1.id,
                    q_1.insee,
                    q_1.nom,
                    q_1.commune,
                    q_1.l_logo,
                    q_1.geom
                   FROM r_administratif.geo_adm_quartier q_1
                  WHERE q_1.insee <> '60159'::bpchar
                ), req_maire AS (
                 SELECT m_1.gid,
                    m_1.insee,
                    m_1.l_m,
                    m_1.l_m_titre,
                    m_1.l_m_email,
                    m_1.l_m_tel,
                    m_1.l_m_url,
                    m_1.l_m_photo
                   FROM r_administratif.an_ref_maire m_1
                  WHERE m_1.insee <> '60159'::bpchar
                )
         SELECT q.id,
            q.insee,
            q.nom,
            q.commune,
            q.l_logo,
            m.l_m,
            m.l_m_titre,
            m.l_m_email,
            m.l_m_tel,
            m.l_m_url,
            m.l_m_photo,
            NULL::character varying AS l_er1,
            NULL::character varying AS l_er_titre1,
            NULL::character varying AS l_er_email1,
            NULL::character varying AS l_er_tel1,
            NULL::character varying AS l_er_url1,
            NULL::character varying AS l_er_photo1,
            NULL::character varying AS l_er2,
            NULL::character varying AS l_er_titre2,
            NULL::character varying AS l_er_email2,
            NULL::character varying AS l_er_tel2,
            NULL::character varying AS l_er_url2,
            NULL::character varying AS l_er_photo2,
            NULL::character varying AS l_er3,
            NULL::character varying AS l_er_titre3,
            NULL::character varying AS l_er_email3,
            NULL::character varying AS l_er_tel3,
            NULL::character varying AS l_er_url3,
            NULL::character varying AS l_er_photo3,
            q.geom
           FROM req_quartier q,
            req_maire m
          WHERE q.insee = m.insee)
        )
 SELECT row_number() OVER () AS gid,
    req_t.id,
    req_t.insee,
    req_t.nom,
    req_t.commune,
    req_t.l_logo,
    req_t.l_m::character varying(255) AS l_m,
    req_t.l_m_titre,
    req_t.l_m_email::character varying(255) AS l_m_email,
    req_t.l_m_tel,
    req_t.l_m_url,
    req_t.l_m_photo,
    req_t.l_er1::character varying(255) AS l_er1,
    req_t.l_er_titre1::character varying(255) AS l_er_titre1,
    req_t.l_er_email1::character varying(255) AS l_er_email1,
    req_t.l_er_tel1,
    req_t.l_er_url1::character varying(255) AS l_er_url1,
    req_t.l_er_photo1,
    req_t.l_er2::character varying(255) AS l_er2,
    req_t.l_er_titre2::character varying(255) AS l_er_titre2,
    req_t.l_er_email2::character varying(255) AS l_er_email2,
    req_t.l_er_tel2,
    req_t.l_er_url2::character varying(255) AS l_er_url2,
    req_t.l_er_photo2,
    req_t.l_er3::character varying(255) AS l_er3,
    req_t.l_er_titre3::character varying(255) AS l_er_titre3,
    req_t.l_er_email3::character varying(255) AS l_er_email3,
    req_t.l_er_tel3,
    req_t.l_er_url3::character varying(255) AS l_er_url3,
    req_t.l_er_photo3,
    req_t.geom
   FROM req_t
WITH DATA;

ALTER TABLE x_apps_public.xappspublic_geo_vmr_planinteractif_refelu
    OWNER TO sig_create;

COMMENT ON MATERIALIZED VIEW x_apps_public.xappspublic_geo_vmr_planinteractif_refelu
    IS 'Vue matérialisée affichant pour chaque commune et/ou quartier l''ensembles des élus référents (maire + élu(s) de quartier)?
Cette vue est envoyée à MyGeo (base Postgres sur le SaaS de BG) pour l''application Grand Public Plan interactif via un workflow FME automatisé (à venir).
Le workflow de travail est ici : Y:Ressources-Partage-ProceduresFMEprodAPPS_GB_PUBLICPLAN_INTERACTIF.fmw.
Attention : à rafraîchir si une mise à jour a été faite sur la référence des élus et à modifier si le nombre d''élus par quartier a été modifié';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_geo_vmr_planinteractif_refelu TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_vmr_planinteractif_refelu TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_vmr_planinteractif_refelu TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_geo_vmr_planinteractif_refelu TO read_sig;


-- ************************************************************************************************************************
-- *** MOBILITE (LA)
-- ************************************************************************************************************************

-- View: x_apps_public.xappspublic_an_v_tic_la_gdpu

-- DROP VIEW x_apps_public.xappspublic_an_v_tic_la_gdpu;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_an_v_tic_la_gdpu AS
 SELECT la.id_la,
    la.nom,
    lu1.num_ligne AS n_lu1,
    lu2.num_ligne AS n_lu2,
    djf.num_ligne AS n_djf,
    tad.num_ligne AS n_tad,
    pu.num_ligne AS n_pu,
    sco.num_ligne AS n_sco,
    ((((
        CASE
            WHEN lu1.num_ligne IS NOT NULL THEN lu1.num_ligne
            ELSE ''::text
        END ||
        CASE
            WHEN lu2.num_ligne IS NOT NULL THEN '-'::text || lu2.num_ligne
            ELSE ''::text
        END) ||
        CASE
            WHEN djf.num_ligne IS NOT NULL THEN '-'::text || djf.num_ligne
            ELSE ''::text
        END) ||
        CASE
            WHEN tad.num_ligne IS NOT NULL THEN '-'::text || tad.num_ligne
            ELSE ''::text
        END) ||
        CASE
            WHEN pu.num_ligne IS NOT NULL THEN '-'::text || pu.num_ligne
            ELSE ''::text
        END) ||
        CASE
            WHEN sco.num_ligne IS NOT NULL THEN '-'::text || sco.num_ligne
            ELSE ''::text
        END AS n_tic,
        CASE
            WHEN lu1.num_ligne ~~ '1%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_1.png"/>'::text
            ELSE NULL::text
        END AS img_l1,
        CASE
            WHEN lu1.num_ligne = '2'::text OR lu1.num_ligne ~~ '%-2'::text OR lu1.num_ligne ~~ '2-%'::text OR lu1.num_ligne ~~ '%-2-%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_2.png"/>'::text
            ELSE NULL::text
        END AS img_l2,
        CASE
            WHEN lu1.num_ligne ~~ '%3%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_3.png"/>'::text
            ELSE NULL::text
        END AS img_l3,
        CASE
            WHEN lu1.num_ligne ~~ '%4%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_4.png"/>'::text
            ELSE NULL::text
        END AS img_l4,
        CASE
            WHEN lu1.num_ligne ~~ '%5%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_5.png"/>'::text
            ELSE NULL::text
        END AS img_l5,
        CASE
            WHEN lu1.num_ligne ~~ '%6%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_6.png"/>'::text
            ELSE NULL::text
        END AS img_l6,
        CASE
            WHEN lu2.num_ligne ~~ 'ARC Express'::text OR lu2.num_ligne ~~ '%-ZA1'::text OR lu2.num_ligne ~~ '%-ZA1-%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_ARCExpress.png"/>'::text
            ELSE NULL::text
        END AS img_larcexpress,
        CASE
            WHEN lu2.num_ligne ~~ 'Navette HM'::text OR lu2.num_ligne ~~ '%-Navette HM'::text OR lu2.num_ligne ~~ '%-Navette HM-%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_NavetteHM.png"/>'::text
            ELSE NULL::text
        END AS img_hm,
        CASE
            WHEN djf.num_ligne ~~ 'D1'::text OR djf.num_ligne ~~ 'D1%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_D1.png"/>'::text
            ELSE NULL::text
        END AS img_ld1,
        CASE
            WHEN djf.num_ligne ~~ 'D2'::text OR djf.num_ligne ~~ '%-D2'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_D2.png"/>'::text
            ELSE NULL::text
        END AS img_ld2,
        CASE
            WHEN tad.num_ligne ~~ '%13%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_13.png"/>'::text
            ELSE NULL::text
        END AS img_l13,
        CASE
            WHEN tad.num_ligne ~~ '%14%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_14.png"/>'::text
            ELSE NULL::text
        END AS img_l14,
        CASE
            WHEN tad.num_ligne ~~ '%15%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_15.png"/>'::text
            ELSE NULL::text
        END AS img_l15,
        CASE
            WHEN tad.num_ligne ~~ '%16%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_16.png"/>'::text
            ELSE NULL::text
        END AS img_l16,
        CASE
            WHEN tad.num_ligne ~~ '%17%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_17.png"/>'::text
            ELSE NULL::text
        END AS img_l17,
        CASE
            WHEN tad.num_ligne ~~ '%18%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_18.png"/>'::text
            ELSE NULL::text
        END AS img_l18,
        CASE
            WHEN tad.num_ligne ~~ '%19%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_19.png"/>'::text
            ELSE NULL::text
        END AS img_l19,
        CASE
            WHEN tad.num_ligne ~~ '%20%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_20.png"/>'::text
            ELSE NULL::text
        END AS img_l20,
        CASE
            WHEN pu.num_ligne ~~ '%101%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_101.png"/>'::text
            ELSE NULL::text
        END AS img_l101,
        CASE
            WHEN pu.num_ligne ~~ '%103%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_103.png"/>'::text
            ELSE NULL::text
        END AS img_l103,
        CASE
            WHEN pu.num_ligne ~~ '%106%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_106.png"/>'::text
            ELSE NULL::text
        END AS img_l106,
        CASE
            WHEN pu.num_ligne ~~ '%107%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_107.png"/>'::text
            ELSE NULL::text
        END AS img_l107,
        CASE
            WHEN pu.num_ligne ~~ '%109%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_109.png"/>'::text
            ELSE NULL::text
        END AS img_l109,
        CASE
            WHEN sco.num_ligne ~~ '%102%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_102.png"/>'::text
            ELSE NULL::text
        END AS img_l102,
        CASE
            WHEN sco.num_ligne ~~ '%104%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_104.png"/>'::text
            ELSE NULL::text
        END AS img_l104,
        CASE
            WHEN sco.num_ligne ~~ '%108%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_108.png"/>'::text
            ELSE NULL::text
        END AS img_l108,
        CASE
            WHEN sco.num_ligne ~~ '%110%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_110.png"/>'::text
            ELSE NULL::text
        END AS img_l110
   FROM m_mobilite.geo_mob_rurbain_la la
     LEFT JOIN x_apps_public.xappspublic_an_v_tic_la_gdpu_lu_1 lu1 ON la.id_la::text = lu1.id_la::text
     LEFT JOIN x_apps_public.xappspublic_an_v_tic_la_gdpu_lu_2 lu2 ON la.id_la::text = lu2.id_la::text
     LEFT JOIN x_apps_public.xappspublic_an_v_tic_la_gdpu_djf djf ON la.id_la::text = djf.id_la::text
     LEFT JOIN x_apps_public.xappspublic_an_v_tic_la_gdpu_pu pu ON la.id_la::text = pu.id_la::text
     LEFT JOIN x_apps_public.xappspublic_an_v_tic_la_gdpu_sco sco ON la.id_la::text = sco.id_la::text
     LEFT JOIN x_apps_public.xappspublic_an_v_tic_la_gdpu_tad tad ON la.id_la::text = tad.id_la::text
  WHERE la.statut::text = '10'::text
  ORDER BY la.id_la;

ALTER TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_an_v_tic_la_gdpu
    IS 'Vue alphanumétique des lieux d''arrêt avec le numéro des lignes en desserte du réseau TIC (intégré au FME export pour l''application GEO Gd Public pour l''affichage des lignes dans les résultats de recherche et info-bulle)';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu TO read_sig;

-- ******************************************************************
-- la vue précédente est possible car les vues ci-dessous existent

-- View: x_apps_public.xappspublic_an_v_tic_la_gdpu_djf

-- DROP VIEW x_apps_public.xappspublic_an_v_tic_la_gdpu_djf;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_an_v_tic_la_gdpu_djf AS
 WITH req_num_lu AS (
         SELECT DISTINCT ze.id_la,
            l.nom_court
           FROM m_mobilite.geo_mob_rurbain_ze ze,
            m_mobilite.an_mob_rurbain_passage p,
            m_mobilite.an_mob_rurbain_ligne l
          WHERE p.id_ligne::text = l.id_ligne::text AND ze.id_ze::text = p.id_ze::text AND (l.nom_court::text = 'D1'::text OR l.nom_court::text = 'D2'::text)
          ORDER BY ze.id_la
        ), req_la AS (
         SELECT geo_mob_rurbain_la.id_la,
            geo_mob_rurbain_la.nom
           FROM m_mobilite.geo_mob_rurbain_la
        )
 SELECT req_num_lu.id_la,
    replace(replace(replace(array_agg(req_num_lu.nom_court ORDER BY req_num_lu.nom_court::text)::text, '{'::text, ''::text), '}'::text, ''::text), ','::text, '-'::text) AS num_ligne
   FROM req_num_lu,
    req_la
  WHERE req_num_lu.id_la::text = req_la.id_la::text
  GROUP BY req_num_lu.id_la;

ALTER TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_djf
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_an_v_tic_la_gdpu_djf
    IS 'Vue alphanumétique des lieux d''arrêt avec le numéro des lignes dimanche et jours fériés en desserte du réseau TIC (intégré à la vue xapps_an_v_tic_la_gdpu pour export dans l''application GEO Gd Public pour l''affichage des lignes dans les résultats de recherche et info-bulle';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_djf TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_djf TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_djf TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_djf TO read_sig;

-- View: x_apps_public.xappspublic_an_v_tic_la_gdpu_lu_1

-- DROP VIEW x_apps_public.xappspublic_an_v_tic_la_gdpu_lu_1;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_an_v_tic_la_gdpu_lu_1 AS
 WITH req_num_lu AS (
         SELECT DISTINCT ze.id_la,
            l.nom_court
           FROM m_mobilite.geo_mob_rurbain_ze ze,
            m_mobilite.an_mob_rurbain_passage p,
            m_mobilite.an_mob_rurbain_ligne l
          WHERE p.id_ligne::text = l.id_ligne::text AND ze.id_ze::text = p.id_ze::text AND (l.nom_court::text = '1'::text OR l.nom_court::text = '2'::text OR l.nom_court::text = '3'::text OR l.nom_court::text = '4'::text OR l.nom_court::text = '5'::text OR l.nom_court::text = '6'::text)
        ), req_la AS (
         SELECT geo_mob_rurbain_la.id_la,
            geo_mob_rurbain_la.nom
           FROM m_mobilite.geo_mob_rurbain_la
        )
 SELECT req_num_lu.id_la,
    replace(replace(replace(array_agg(req_num_lu.nom_court ORDER BY req_num_lu.nom_court::text)::text, '{'::text, ''::text), '}'::text, ''::text), ','::text, '-'::text) AS num_ligne
   FROM req_num_lu,
    req_la
  WHERE req_num_lu.id_la::text = req_la.id_la::text
  GROUP BY req_num_lu.id_la;

ALTER TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_lu_1
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_an_v_tic_la_gdpu_lu_1
    IS 'Vue alphanumétique des lieux d''arrêt avec le numéro des lignes urbaines (1 à 6) en desserte du réseau TIC (intégré à la vue an_v_tic_la_gdpu pour export dans l''application GEO Gd Public pour l''affichage des lignes dans les résultats de recherche et info-bulle';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_lu_1 TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_lu_1 TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_lu_1 TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_lu_1 TO read_sig;

-- View: x_apps_public.xappspublic_an_v_tic_la_gdpu_lu_2

-- DROP VIEW x_apps_public.xappspublic_an_v_tic_la_gdpu_lu_2;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_an_v_tic_la_gdpu_lu_2 AS
 WITH req_num_lu AS (
         SELECT DISTINCT ze.id_la,
            l.nom_court
           FROM m_mobilite.geo_mob_rurbain_ze ze,
            m_mobilite.an_mob_rurbain_passage p,
            m_mobilite.an_mob_rurbain_ligne l
          WHERE p.id_ligne::text = l.id_ligne::text AND ze.id_ze::text = p.id_ze::text AND (l.nom_court::text = 'ARC Express'::text OR l.nom_court::text = 'Navette HM'::text)
        ), req_la AS (
         SELECT geo_mob_rurbain_la.id_la,
            geo_mob_rurbain_la.nom
           FROM m_mobilite.geo_mob_rurbain_la
        )
 SELECT req_num_lu.id_la,
    replace(replace(replace(replace(array_agg(req_num_lu.nom_court ORDER BY req_num_lu.nom_court::text)::text, '{'::text, ''::text), '}'::text, ''::text), ','::text, '-'::text), '"'::text, ''::text) AS num_ligne
   FROM req_num_lu,
    req_la
  WHERE req_num_lu.id_la::text = req_la.id_la::text
  GROUP BY req_num_lu.id_la;

ALTER TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_lu_2
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_an_v_tic_la_gdpu_lu_2
    IS 'Vue alphanumétique des lieux d''arrêt avec le numéro des lignes urbaines (ARC Express et HM) en desserte du réseau TIC (intégré à la vue an_v_tic_la_gdpu pour export dans l''application GEO Gd Public pour l''affichage des lignes dans les résultats de recherche et info-bulle';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_lu_2 TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_lu_2 TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_lu_2 TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_lu_2 TO read_sig;


-- View: x_apps_public.xappspublic_an_v_tic_la_gdpu_pu

-- DROP VIEW x_apps_public.xappspublic_an_v_tic_la_gdpu_pu;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_an_v_tic_la_gdpu_pu AS
 WITH req_num_lu AS (
         SELECT DISTINCT ze.id_la,
            l.nom_court
           FROM m_mobilite.geo_mob_rurbain_ze ze,
            m_mobilite.an_mob_rurbain_passage p,
            m_mobilite.an_mob_rurbain_ligne l
          WHERE p.id_ligne::text = l.id_ligne::text AND ze.id_ze::text = p.id_ze::text AND (l.nom_court::text = '101'::text OR l.nom_court::text = '103'::text OR l.nom_court::text = '106'::text OR l.nom_court::text = '107'::text OR l.nom_court::text = '109'::text)
        ), req_la AS (
         SELECT geo_mob_rurbain_la.id_la,
            geo_mob_rurbain_la.nom
           FROM m_mobilite.geo_mob_rurbain_la
        )
 SELECT req_num_lu.id_la,
    replace(replace(replace(array_agg(req_num_lu.nom_court ORDER BY req_num_lu.nom_court::text)::text, '{'::text, ''::text), '}'::text, ''::text), ','::text, '-'::text) AS num_ligne
   FROM req_num_lu,
    req_la
  WHERE req_num_lu.id_la::text = req_la.id_la::text
  GROUP BY req_num_lu.id_la;

ALTER TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_pu
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_an_v_tic_la_gdpu_pu
    IS 'Vue alphanumétique des lieux d''arrêt avec le numéro des lignes péri_urbain (hors ARC Express) en desserte du réseau TIC (intégré à la vue an_v_tic_la_gdpu pour export dans l''application GEO Gd Public pour l''affichage des lignes dans les résultats de recherche et info-bulle';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_pu TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_pu TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_pu TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_pu TO read_sig;

-- View: x_apps_public.xappspublic_an_v_tic_la_gdpu_sco

-- DROP VIEW x_apps_public.xappspublic_an_v_tic_la_gdpu_sco;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_an_v_tic_la_gdpu_sco AS
 WITH req_num_lu AS (
         SELECT DISTINCT ze.id_la,
            l.nom_court
           FROM m_mobilite.geo_mob_rurbain_ze ze,
            m_mobilite.an_mob_rurbain_passage p,
            m_mobilite.an_mob_rurbain_ligne l
          WHERE p.id_ligne::text = l.id_ligne::text AND ze.id_ze::text = p.id_ze::text AND (l.nom_court::text = '102'::text OR l.nom_court::text = '104'::text OR l.nom_court::text = '108'::text OR l.nom_court::text = '110'::text)
        ), req_la AS (
         SELECT geo_mob_rurbain_la.id_la,
            geo_mob_rurbain_la.nom
           FROM m_mobilite.geo_mob_rurbain_la
        )
 SELECT req_num_lu.id_la,
    replace(replace(replace(array_agg(req_num_lu.nom_court ORDER BY req_num_lu.nom_court::text)::text, '{'::text, ''::text), '}'::text, ''::text), ','::text, '-'::text) AS num_ligne
   FROM req_num_lu,
    req_la
  WHERE req_num_lu.id_la::text = req_la.id_la::text
  GROUP BY req_num_lu.id_la;

ALTER TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_sco
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_an_v_tic_la_gdpu_sco
    IS 'Vue alphanumétique des lieux d''arrêt avec le numéro des lignes scolaires en desserte du réseau TIC (intégré à la vue an_v_tic_la_gdpu pour export dans l''application GEO Gd Public pour l''affichage des lignes dans les résultats de recherche et info-bulle';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_sco TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_sco TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_sco TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_sco TO read_sig;


-- View: x_apps_public.xappspublic_an_v_tic_la_gdpu_tad

-- DROP VIEW x_apps_public.xappspublic_an_v_tic_la_gdpu_tad;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_an_v_tic_la_gdpu_tad AS
 WITH req_num_lu AS (
         SELECT DISTINCT ze.id_la,
            l.nom_court
           FROM m_mobilite.geo_mob_rurbain_ze ze,
            m_mobilite.an_mob_rurbain_passage p,
            m_mobilite.an_mob_rurbain_ligne l
          WHERE p.id_ligne::text = l.id_ligne::text AND ze.id_ze::text = p.id_ze::text AND (l.nom_court::text = '13'::text OR l.nom_court::text = '14'::text OR l.nom_court::text = '15'::text OR l.nom_court::text = '16'::text OR l.nom_court::text = '17'::text OR l.nom_court::text = '18'::text OR l.nom_court::text = '19'::text OR l.nom_court::text = '20'::text)
        ), req_la AS (
         SELECT geo_mob_rurbain_la.id_la,
            geo_mob_rurbain_la.nom
           FROM m_mobilite.geo_mob_rurbain_la
        )
 SELECT req_num_lu.id_la,
    replace(replace(replace(array_agg(req_num_lu.nom_court ORDER BY req_num_lu.nom_court::text)::text, '{'::text, ''::text), '}'::text, ''::text), ','::text, '-'::text) AS num_ligne
   FROM req_num_lu,
    req_la
  WHERE req_num_lu.id_la::text = req_la.id_la::text
  GROUP BY req_num_lu.id_la;

ALTER TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_tad
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_an_v_tic_la_gdpu_tad
    IS 'Vue alphanumétique des lieux d''arrêt avec le numéro des lignes scolaires en desserte du réseau TIC (intégré à la vue an_v_tic_la_gdpu pour export dans l''application GEO Gd Public pour l''affichage des lignes dans les résultats de recherche et info-bulle';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_tad TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_tad TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_tad TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_an_v_tic_la_gdpu_tad TO read_sig;


-- ************************************************************************************************************************
-- *** MOBILITE (ZE)
-- ************************************************************************************************************************

-- View: x_apps_public.xappspublic_an_v_tic_ze_gdpu

-- DROP VIEW x_apps_public.xappspublic_an_v_tic_ze_gdpu;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_an_v_tic_ze_gdpu AS
 SELECT ze.id_ze,
    lu1.num_ligne AS n_lu1,
    lu2.num_ligne AS n_lu2,
    djf.num_ligne AS n_djf,
    tad.num_ligne AS n_tad,
    pu.num_ligne AS n_pu,
    sco.num_ligne AS n_sco,
    ((((
        CASE
            WHEN lu1.num_ligne IS NOT NULL THEN lu1.num_ligne
            ELSE ''::text
        END ||
        CASE
            WHEN lu2.num_ligne IS NOT NULL THEN '-'::text || lu2.num_ligne
            ELSE ''::text
        END) ||
        CASE
            WHEN djf.num_ligne IS NOT NULL THEN '-'::text || djf.num_ligne
            ELSE ''::text
        END) ||
        CASE
            WHEN tad.num_ligne IS NOT NULL THEN '-'::text || tad.num_ligne
            ELSE ''::text
        END) ||
        CASE
            WHEN pu.num_ligne IS NOT NULL THEN '-'::text || pu.num_ligne
            ELSE ''::text
        END) ||
        CASE
            WHEN sco.num_ligne IS NOT NULL THEN '-'::text || sco.num_ligne
            ELSE ''::text
        END AS n_tic,
        CASE
            WHEN lu1.num_ligne ~~ '1%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_1.png"/>'::text
            ELSE NULL::text
        END AS img_l1,
        CASE
            WHEN lu1.num_ligne = '2'::text OR lu1.num_ligne ~~ '%-2'::text OR lu1.num_ligne ~~ '2-%'::text OR lu1.num_ligne ~~ '%-2-%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_2.png"/>'::text
            ELSE NULL::text
        END AS img_l2,
        CASE
            WHEN lu1.num_ligne ~~ '%3%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_3.png"/>'::text
            ELSE NULL::text
        END AS img_l3,
        CASE
            WHEN lu1.num_ligne ~~ '%4%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_4.png"/>'::text
            ELSE NULL::text
        END AS img_l4,
        CASE
            WHEN lu1.num_ligne ~~ '%5%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_5.png"/>'::text
            ELSE NULL::text
        END AS img_l5,
        CASE
            WHEN lu1.num_ligne ~~ '%6%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_6.png"/>'::text
            ELSE NULL::text
        END AS img_l6,
        CASE
            WHEN lu2.num_ligne ~~ 'ARC Express'::text OR lu2.num_ligne ~~ '%-ARC Express'::text OR lu2.num_ligne ~~ '%-ARC Express-%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_ARCExpress.png"/>'::text
            ELSE NULL::text
        END AS img_lae,
        CASE
            WHEN lu2.num_ligne ~~ 'Navette HM'::text OR lu2.num_ligne ~~ '%-Navette HM'::text OR lu2.num_ligne ~~ '%-Navette HM-%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_NavetteHM.png"/>'::text
            ELSE NULL::text
        END AS img_hm,
        CASE
            WHEN djf.num_ligne ~~ 'D1'::text OR djf.num_ligne ~~ 'D1%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_D1.png"/>'::text
            ELSE NULL::text
        END AS img_ld1,
        CASE
            WHEN djf.num_ligne ~~ 'D2'::text OR djf.num_ligne ~~ '%-D2'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_D2.png"/>'::text
            ELSE NULL::text
        END AS img_ld2,
        CASE
            WHEN tad.num_ligne ~~ '%13%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_13.png"/>'::text
            ELSE NULL::text
        END AS img_l13,
        CASE
            WHEN tad.num_ligne ~~ '%14%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_14.png"/>'::text
            ELSE NULL::text
        END AS img_l14,
        CASE
            WHEN tad.num_ligne ~~ '%15%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_15.png"/>'::text
            ELSE NULL::text
        END AS img_l15,
        CASE
            WHEN tad.num_ligne ~~ '%16%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_16.png"/>'::text
            ELSE NULL::text
        END AS img_l16,
        CASE
            WHEN tad.num_ligne ~~ '%17%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_17.png"/>'::text
            ELSE NULL::text
        END AS img_l17,
        CASE
            WHEN tad.num_ligne ~~ '%18%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_18.png"/>'::text
            ELSE NULL::text
        END AS img_l18,
        CASE
            WHEN tad.num_ligne ~~ '%19%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_19.png"/>'::text
            ELSE NULL::text
        END AS img_l19,
        CASE
            WHEN tad.num_ligne ~~ '%20%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_20.png"/>'::text
            ELSE NULL::text
        END AS img_l20,
        CASE
            WHEN pu.num_ligne ~~ '%101%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_101.png"/>'::text
            ELSE NULL::text
        END AS img_l101,
        CASE
            WHEN pu.num_ligne ~~ '%103%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_103.png"/>'::text
            ELSE NULL::text
        END AS img_l103,
        CASE
            WHEN pu.num_ligne ~~ '%106%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_106.png"/>'::text
            ELSE NULL::text
        END AS img_l106,
        CASE
            WHEN pu.num_ligne ~~ '%107%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_107.png"/>'::text
            ELSE NULL::text
        END AS img_l107,
        CASE
            WHEN pu.num_ligne ~~ '%109%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_109.png"/>'::text
            ELSE NULL::text
        END AS img_l109,
        CASE
            WHEN sco.num_ligne ~~ '%102%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_102.png"/>'::text
            ELSE NULL::text
        END AS img_l102,
        CASE
            WHEN sco.num_ligne ~~ '%104%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_104.png"/>'::text
            ELSE NULL::text
        END AS img_l104,
        CASE
            WHEN sco.num_ligne ~~ '%108%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_108.png"/>'::text
            ELSE NULL::text
        END AS img_l108,
        CASE
            WHEN sco.num_ligne ~~ '%110%'::text THEN '<img src="http://geo.compiegnois.fr/documents/metiers/mob/tic/logo/ligne_110.png"/>'::text
            ELSE NULL::text
        END AS img_l110
   FROM m_mobilite.geo_mob_rurbain_ze ze
     LEFT JOIN x_apps_public.xappspublic_an_v_tic_ze_gdpu_lu_1 lu1 ON ze.id_ze::text = lu1.id_ze::text
     LEFT JOIN x_apps_public.xappspublic_an_v_tic_ze_gdpu_lu_2 lu2 ON ze.id_ze::text = lu2.id_ze::text
     LEFT JOIN x_apps_public.xappspublic_an_v_tic_ze_gdpu_djf djf ON ze.id_ze::text = djf.id_ze::text
     LEFT JOIN x_apps_public.xappspublic_an_v_tic_ze_gdpu_pu pu ON ze.id_ze::text = pu.id_ze::text
     LEFT JOIN x_apps_public.xappspublic_an_v_tic_ze_gdpu_sco sco ON ze.id_ze::text = sco.id_ze::text
     LEFT JOIN x_apps_public.xappspublic_an_v_tic_ze_gdpu_tad tad ON ze.id_ze::text = tad.id_ze::text
  WHERE ze.statut::text = '10'::text
  ORDER BY ze.id_ze;

ALTER TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_an_v_tic_ze_gdpu
    IS 'Vue alphanumétique des zones d''embarquement avec le numéro des lignes en desserte du réseau TIC  (intégré au FME d''export pour l''application GEO Gd Public pour l''affichage des lignes dans les résultats de recherche et info-bulle)';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu TO read_sig;


-- ******************************************************************
-- la vue précédente est possible car les vues ci-dessous existent

-- View: x_apps_public.xappspublic_an_v_tic_ze_gdpu_djf

-- DROP VIEW x_apps_public.xappspublic_an_v_tic_ze_gdpu_djf;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_an_v_tic_ze_gdpu_djf AS
 WITH req_num_lu AS (
         SELECT DISTINCT p.id_ze,
            l.nom_court
           FROM m_mobilite.an_mob_rurbain_passage p,
            m_mobilite.an_mob_rurbain_ligne l
          WHERE p.id_ligne::text = l.id_ligne::text AND (l.nom_court::text = 'D1'::text OR l.nom_court::text = 'D2'::text)
        )
 SELECT req_num_lu.id_ze,
    replace(replace(replace(array_agg(req_num_lu.nom_court ORDER BY req_num_lu.nom_court::text)::text, '{'::text, ''::text), '}'::text, ''::text), ','::text, '-'::text) AS num_ligne
   FROM req_num_lu
  GROUP BY req_num_lu.id_ze;

ALTER TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_djf
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_an_v_tic_ze_gdpu_djf
    IS 'Vue alphanumétique des zones d''embarquement avec le numéro des lignes dimanche et jours fériés en desserte du réseau TIC (intégré à la vue an_v_tic_ze_gdpu pour export dans l''application GEO Gd Public pour l''affichage des lignes dans les résultats de recherche et info-bulle';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_djf TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_djf TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_djf TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_djf TO read_sig;


-- View: x_apps_public.xappspublic_an_v_tic_ze_gdpu_lu_1

-- DROP VIEW x_apps_public.xappspublic_an_v_tic_ze_gdpu_lu_1;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_an_v_tic_ze_gdpu_lu_1 AS
 WITH req_num_lu AS (
         SELECT DISTINCT p.id_ze,
            l.nom_court
           FROM m_mobilite.an_mob_rurbain_passage p,
            m_mobilite.an_mob_rurbain_ligne l
          WHERE p.id_ligne::text = l.id_ligne::text AND (l.nom_court::text = '1'::text OR l.nom_court::text = '2'::text OR l.nom_court::text = '3'::text OR l.nom_court::text = '4'::text OR l.nom_court::text = '5'::text OR l.nom_court::text = '6'::text)
        )
 SELECT req_num_lu.id_ze,
    replace(replace(replace(array_agg(req_num_lu.nom_court ORDER BY req_num_lu.nom_court::text)::text, '{'::text, ''::text), '}'::text, ''::text), ','::text, '-'::text) AS num_ligne
   FROM req_num_lu
  GROUP BY req_num_lu.id_ze;

ALTER TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_lu_1
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_an_v_tic_ze_gdpu_lu_1
    IS 'Vue alphanumétique des zones d''embarquement avec le numéro des lignes urbaines (1 à 6) en desserte du réseau TIC (intégré à la vue an_v_tic_ze_gdpu pour export dans l''application GEO Gd Public pour l''affichage des lignes dans les résultats de recherche et info-bulle';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_lu_1 TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_lu_1 TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_lu_1 TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_lu_1 TO read_sig;


-- View: x_apps_public.xappspublic_an_v_tic_ze_gdpu_lu_2

-- DROP VIEW x_apps_public.xappspublic_an_v_tic_ze_gdpu_lu_2;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_an_v_tic_ze_gdpu_lu_2 AS
 WITH req_num_lu AS (
         SELECT DISTINCT p.id_ze,
            l.nom_court
           FROM m_mobilite.an_mob_rurbain_passage p,
            m_mobilite.an_mob_rurbain_ligne l
          WHERE p.id_ligne::text = l.id_ligne::text AND (l.nom_court::text = 'ARC Express'::text OR l.nom_court::text = 'Navette HM'::text)
        )
 SELECT req_num_lu.id_ze,
    replace(replace(replace(replace(array_agg(req_num_lu.nom_court ORDER BY req_num_lu.nom_court::text)::text, '{'::text, ''::text), '}'::text, ''::text), ','::text, '-'::text), '"'::text, ''::text) AS num_ligne
   FROM req_num_lu
  GROUP BY req_num_lu.id_ze;

ALTER TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_lu_2
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_an_v_tic_ze_gdpu_lu_2
    IS 'Vue alphanumétique des zones d''embarquement avec le numéro des lignes urbaines (ARC Express et HM) en desserte du réseau TIC (intégré à la vue an_v_tic_ze_gdpu pour export dans l''application GEO Gd Public pour l''affichage des lignes dans les résultats de recherche et info-bulle';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_lu_2 TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_lu_2 TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_lu_2 TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_lu_2 TO read_sig;

-- View: x_apps_public.xappspublic_an_v_tic_ze_gdpu_pu

-- DROP VIEW x_apps_public.xappspublic_an_v_tic_ze_gdpu_pu;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_an_v_tic_ze_gdpu_pu AS
 WITH req_num_lu AS (
         SELECT DISTINCT p.id_ze,
            l.nom_court
           FROM m_mobilite.an_mob_rurbain_passage p,
            m_mobilite.an_mob_rurbain_ligne l
          WHERE p.id_ligne::text = l.id_ligne::text AND (l.nom_court::text = '101'::text OR l.nom_court::text = '103'::text OR l.nom_court::text = '106'::text OR l.nom_court::text = '107'::text OR l.nom_court::text = '109'::text)
        )
 SELECT req_num_lu.id_ze,
    replace(replace(replace(array_agg(req_num_lu.nom_court ORDER BY req_num_lu.nom_court::text)::text, '{'::text, ''::text), '}'::text, ''::text), ','::text, '-'::text) AS num_ligne
   FROM req_num_lu
  GROUP BY req_num_lu.id_ze;

ALTER TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_pu
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_an_v_tic_ze_gdpu_pu
    IS 'Vue alphanumétique des zones d''embarquement avec le numéro des lignes péri_urbain (hors ARC Express) en desserte du réseau TIC (intégré à la vue an_v_tic_ze_gdpu pour export dans l''application GEO Gd Public pour l''affichage des lignes dans les résultats de recherche et info-bulle';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_pu TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_pu TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_pu TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_pu TO read_sig;

-- View: x_apps_public.xappspublic_an_v_tic_ze_gdpu_sco

-- DROP VIEW x_apps_public.xappspublic_an_v_tic_ze_gdpu_sco;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_an_v_tic_ze_gdpu_sco AS
 WITH req_num_lu AS (
         SELECT DISTINCT p.id_ze,
            l.nom_court
           FROM m_mobilite.an_mob_rurbain_passage p,
            m_mobilite.an_mob_rurbain_ligne l
          WHERE p.id_ligne::text = l.id_ligne::text AND (l.nom_court::text = '102'::text OR l.nom_court::text = '104'::text OR l.nom_court::text = '108'::text OR l.nom_court::text = '110'::text)
        )
 SELECT req_num_lu.id_ze,
    replace(replace(replace(array_agg(req_num_lu.nom_court ORDER BY req_num_lu.nom_court::text)::text, '{'::text, ''::text), '}'::text, ''::text), ','::text, '-'::text) AS num_ligne
   FROM req_num_lu
  GROUP BY req_num_lu.id_ze;

ALTER TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_sco
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_an_v_tic_ze_gdpu_sco
    IS 'Vue alphanumétique des zones d''embarquement avec le numéro des lignes scolaires en desserte du réseau TIC (intégré à la vue an_v_tic_ze_gdpu pour export dans l''application GEO Gd Public pour l''affichage des lignes dans les résultats de recherche et info-bulle';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_sco TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_sco TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_sco TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_sco TO read_sig;

-- View: x_apps_public.xappspublic_an_v_tic_ze_gdpu_tad

-- DROP VIEW x_apps_public.xappspublic_an_v_tic_ze_gdpu_tad;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_an_v_tic_ze_gdpu_tad AS
 WITH req_num_lu AS (
         SELECT DISTINCT p.id_ze,
            l.nom_court
           FROM m_mobilite.an_mob_rurbain_passage p,
            m_mobilite.an_mob_rurbain_ligne l
          WHERE p.id_ligne::text = l.id_ligne::text AND (l.nom_court::text = '13'::text OR l.nom_court::text = '14'::text OR l.nom_court::text = '15'::text OR l.nom_court::text = '16'::text OR l.nom_court::text = '17'::text OR l.nom_court::text = '18'::text OR l.nom_court::text = '19'::text OR l.nom_court::text = '20'::text)
        )
 SELECT req_num_lu.id_ze,
    replace(replace(replace(array_agg(req_num_lu.nom_court ORDER BY req_num_lu.nom_court::text)::text, '{'::text, ''::text), '}'::text, ''::text), ','::text, '-'::text) AS num_ligne
   FROM req_num_lu
  GROUP BY req_num_lu.id_ze;

ALTER TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_tad
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_an_v_tic_ze_gdpu_tad
    IS 'Vue alphanumétique des zones d''embarquement avec le numéro des lignes scolaires en desserte du réseau TIC (intégré à la vue an_v_tic_ze_gdpu pour export dans l''application GEO Gd Public pour l''affichage des lignes dans les résultats de recherche et info-bulle';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_tad TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_tad TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_tad TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_an_v_tic_ze_gdpu_tad TO read_sig;

-- ************************************************************************************************************************
-- *** MOBILITE (ZE bis)
-- ************************************************************************************************************************

-- View: x_apps_public.xappspublic_geo_v_tic_ze_gdpu

-- DROP VIEW x_apps_public.xappspublic_geo_v_tic_ze_gdpu;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_geo_v_tic_ze_gdpu AS
 SELECT ze.id_ze,
    ze.nom,
    lu.ligne_urbaine,
    djf.ligne_djf,
    pu.ligne_pu,
    tad.ligne_tad,
    sco.ligne_sco,
    ze.geom
   FROM m_mobilite.geo_mob_rurbain_ze ze
     LEFT JOIN x_apps_public.xappspublic_geo_v_tic_ze_gdpu_lu lu ON ze.id_ze::text = lu.id_ze::text
     LEFT JOIN x_apps_public.xappspublic_geo_v_tic_ze_gdpu_djf djf ON ze.id_ze::text = djf.id_ze::text
     LEFT JOIN x_apps_public.xappspublic_geo_v_tic_ze_gdpu_pu pu ON ze.id_ze::text = pu.id_ze::text
     LEFT JOIN x_apps_public.xappspublic_geo_v_tic_ze_gdpu_tad tad ON ze.id_ze::text = tad.id_ze::text
     LEFT JOIN x_apps_public.xappspublic_geo_v_tic_ze_gdpu_sco sco ON ze.id_ze::text = sco.id_ze::text
  WHERE ze.statut::text = '10'::text;

ALTER TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_geo_v_tic_ze_gdpu
    IS 'Vue géométrique des zones d''embarquement avec les lignes en desserte du réseau TIC (intégré  au FME d''export pour exploitation dans l''application grand public Plan d''Agglomération Interactif (fiche information))';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu TO read_sig;

-- ******************************************************************
-- la vue précédente est possible car les vues ci-dessous existent

-- View: x_apps_public.xappspublic_geo_v_tic_ze_gdpu_djf

-- DROP VIEW x_apps_public.xappspublic_geo_v_tic_ze_gdpu_djf;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_geo_v_tic_ze_gdpu_djf AS
 WITH req_ze AS (
         SELECT geo_mob_rurbain_ze.id_ze,
            geo_mob_rurbain_ze.nom,
            geo_mob_rurbain_ze.geom
           FROM m_mobilite.geo_mob_rurbain_ze
          WHERE geo_mob_rurbain_ze.statut::text = '10'::text
        ), req_desserte_djf AS (
         SELECT DISTINCT p.id_ze,
            (l.nom_court::text || ' vers '::text) || t.valeur::text AS nom_court
           FROM m_mobilite.an_mob_rurbain_passage p
             LEFT JOIN m_mobilite.an_mob_rurbain_ligne l ON p.id_ligne::text = l.id_ligne::text
             LEFT JOIN m_mobilite.lt_mob_rurbain_terminus t ON p.direction::text = t.code::text
          WHERE l.genre::text = '10'::text AND (l.nom_court::text = 'D1'::text OR l.nom_court::text = 'D2'::text) AND (p.t_passage::text = '22'::text OR p.t_passage::text = '10'::text OR p.t_passage::text = '32'::text OR p.t_passage::text = '40'::text)
          ORDER BY p.id_ze
        )
 SELECT DISTINCT req_ze.id_ze,
    req_ze.nom,
    replace(replace(replace(replace(array_agg(req_desserte_djf.nom_court ORDER BY req_desserte_djf.nom_court)::text, '"'::text, ''::text), '}'::text, ''::text), '{'::text, ''::text), ','::text, chr(10))::character varying(500) AS ligne_djf,
    req_ze.geom
   FROM req_ze,
    req_desserte_djf
  WHERE req_ze.id_ze::text = req_desserte_djf.id_ze::text
  GROUP BY req_ze.id_ze, req_ze.nom, req_ze.geom;

ALTER TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_djf
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_geo_v_tic_ze_gdpu_djf
    IS 'Vue géométrique formattant pour chaque ZE le n° de ligne et sa direction pour les lignes Dimanche et jours fériés. Cette vue permet de générer la vue geo_v_tic_ze_gdpu (export shape via FME) pour la gestion de l ''affichage de la fiche info dans l''application grand public Plan d''Agglo interactif';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_djf TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_djf TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_djf TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_djf TO read_sig;

-- View: x_apps_public.xappspublic_geo_v_tic_ze_gdpu_lu

-- DROP VIEW x_apps_public.xappspublic_geo_v_tic_ze_gdpu_lu;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_geo_v_tic_ze_gdpu_lu AS
 WITH req_ze AS (
         SELECT geo_mob_rurbain_ze.id_ze,
            geo_mob_rurbain_ze.nom,
            geo_mob_rurbain_ze.geom
           FROM m_mobilite.geo_mob_rurbain_ze
          WHERE geo_mob_rurbain_ze.statut::text = '10'::text
        ), req_desserte_lu AS (
         SELECT DISTINCT p.id_ze,
            (l.nom_court::text || ' vers '::text) || t.valeur::text AS nom_court
           FROM m_mobilite.an_mob_rurbain_passage p
             LEFT JOIN m_mobilite.an_mob_rurbain_ligne l ON p.id_ligne::text = l.id_ligne::text
             LEFT JOIN m_mobilite.lt_mob_rurbain_terminus t ON p.direction::text = t.code::text
          WHERE l.genre::text = '10'::text AND l.nom_court::text <> 'D1'::text AND l.nom_court::text <> 'D2'::text AND (p.t_passage::text = '22'::text OR p.t_passage::text = '10'::text OR p.t_passage::text = '31'::text OR p.t_passage::text = '40'::text)
          ORDER BY p.id_ze
        )
 SELECT DISTINCT req_ze.id_ze,
    req_ze.nom,
    replace(replace(replace(replace(array_agg(req_desserte_lu.nom_court ORDER BY req_desserte_lu.nom_court)::text, '"'::text, ''::text), '}'::text, ''::text), '{'::text, ''::text), ','::text, chr(10))::character varying(500) AS ligne_urbaine,
    req_ze.geom
   FROM req_ze,
    req_desserte_lu
  WHERE req_ze.id_ze::text = req_desserte_lu.id_ze::text
  GROUP BY req_ze.id_ze, req_ze.nom, req_ze.geom;

ALTER TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_lu
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_geo_v_tic_ze_gdpu_lu
    IS 'Vue géométrique formattant pour chaque ZE le n° de ligne et sa direction pour les lignes urbaines. Cette vue permet de générer la vue geo_v_tic_ze_gdpu (export shape via FME) pour la gestion de l ''affichage de la fiche info dans l''application grand public Plan d''Agglo interactif';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_lu TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_lu TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_lu TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_lu TO read_sig;

-- View: x_apps_public.xappspublic_geo_v_tic_ze_gdpu_pu

-- DROP VIEW x_apps_public.xappspublic_geo_v_tic_ze_gdpu_pu;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_geo_v_tic_ze_gdpu_pu AS
 WITH req_ze AS (
         SELECT geo_mob_rurbain_ze.id_ze,
            geo_mob_rurbain_ze.nom,
            geo_mob_rurbain_ze.geom
           FROM m_mobilite.geo_mob_rurbain_ze
          WHERE geo_mob_rurbain_ze.statut::text = '10'::text
        ), req_desserte_pu AS (
         SELECT DISTINCT p.id_ze,
            (l.nom_court::text || ' '::text) || t.valeur::text AS nom_court
           FROM m_mobilite.an_mob_rurbain_passage p
             LEFT JOIN m_mobilite.an_mob_rurbain_ligne l ON p.id_ligne::text = l.id_ligne::text
             LEFT JOIN m_mobilite.lt_mob_rurbain_terminus t ON p.direction::text = t.code::text
          WHERE l.genre::text = '20'::text AND (p.t_passage::text = '22'::text OR p.t_passage::text = '10'::text OR p.t_passage::text = '31'::text OR p.t_passage::text = '40'::text)
          ORDER BY p.id_ze
        )
 SELECT DISTINCT req_ze.id_ze,
    req_ze.nom,
    replace(replace(replace(replace(array_agg(req_desserte_pu.nom_court ORDER BY req_desserte_pu.nom_court)::text, '"'::text, ''::text), '}'::text, ''::text), '{'::text, ''::text), ','::text, chr(10))::character varying(500) AS ligne_pu,
    req_ze.geom
   FROM req_ze,
    req_desserte_pu
  WHERE req_ze.id_ze::text = req_desserte_pu.id_ze::text
  GROUP BY req_ze.id_ze, req_ze.nom, req_ze.geom;

ALTER TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_pu
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_geo_v_tic_ze_gdpu_pu
    IS 'Vue géométrique formattant pour chaque ZE le n° de ligne et sa direction pour les lignes péri-urbaines. Cette vue permet de générer la vue geo_v_tic_ze_gdpu (export shape via FME) pour la gestion de l''affichage de la fiche info dans l''application grand public Plan d''Agglo interactif';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_pu TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_pu TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_pu TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_pu TO read_sig;

-- View: x_apps_public.xappspublic_geo_v_tic_ze_gdpu_sco

-- DROP VIEW x_apps_public.xappspublic_geo_v_tic_ze_gdpu_sco;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_geo_v_tic_ze_gdpu_sco AS
 WITH req_ze AS (
         SELECT geo_mob_rurbain_ze.id_ze,
            geo_mob_rurbain_ze.nom,
            geo_mob_rurbain_ze.geom
           FROM m_mobilite.geo_mob_rurbain_ze
          WHERE geo_mob_rurbain_ze.statut::text = '10'::text
        ), req_desserte_pu AS (
         SELECT DISTINCT p.id_ze,
            (l.nom_court::text || ' Vers '::text) || t.valeur::text AS nom_court
           FROM m_mobilite.an_mob_rurbain_passage p
             LEFT JOIN m_mobilite.an_mob_rurbain_ligne l ON p.id_ligne::text = l.id_ligne::text
             LEFT JOIN m_mobilite.lt_mob_rurbain_terminus t ON p.direction::text = t.code::text
          WHERE l.genre::text = '40'::text AND (p.t_passage::text = '22'::text OR p.t_passage::text = '10'::text OR p.t_passage::text = '31'::text OR p.t_passage::text = '40'::text)
          ORDER BY p.id_ze
        )
 SELECT DISTINCT req_ze.id_ze,
    req_ze.nom,
    replace(replace(replace(replace(array_agg(req_desserte_pu.nom_court ORDER BY req_desserte_pu.nom_court)::text, '"'::text, ''::text), '}'::text, ''::text), '{'::text, ''::text), ','::text, chr(10))::character varying(500) AS ligne_sco,
    req_ze.geom
   FROM req_ze,
    req_desserte_pu
  WHERE req_ze.id_ze::text = req_desserte_pu.id_ze::text
  GROUP BY req_ze.id_ze, req_ze.nom, req_ze.geom;

ALTER TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_sco
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_geo_v_tic_ze_gdpu_sco
    IS 'Vue géométrique formattant pour chaque ZE le n° de ligne et sa direction pour les lignes scolaires. Cette vue permet de générer la vue geo_v_tic_ze_gdpu (export shape via FME) pour la gestion de l''affichage de la fiche info dans l''application grand public Plan d''''Agglo interactif';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_sco TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_sco TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_sco TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_sco TO read_sig;

-- View: x_apps_public.xappspublic_geo_v_tic_ze_gdpu_tad

-- DROP VIEW x_apps_public.xappspublic_geo_v_tic_ze_gdpu_tad;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_geo_v_tic_ze_gdpu_tad AS
 WITH req_ze AS (
         SELECT geo_mob_rurbain_ze.id_ze,
            geo_mob_rurbain_ze.nom,
            geo_mob_rurbain_ze.geom
           FROM m_mobilite.geo_mob_rurbain_ze
          WHERE geo_mob_rurbain_ze.statut::text = '10'::text
        ), req_desserte_pu AS (
         SELECT DISTINCT p.id_ze,
            (l.nom_court::text || ' Vers '::text) || t.valeur::text AS nom_court
           FROM m_mobilite.an_mob_rurbain_passage p
             LEFT JOIN m_mobilite.an_mob_rurbain_ligne l ON p.id_ligne::text = l.id_ligne::text
             LEFT JOIN m_mobilite.lt_mob_rurbain_terminus t ON p.direction::text = t.code::text
          WHERE l.genre::text = '30'::text AND (p.t_passage::text = '22'::text OR p.t_passage::text = '10'::text OR p.t_passage::text = '31'::text OR p.t_passage::text = '40'::text)
          ORDER BY p.id_ze
        )
 SELECT DISTINCT req_ze.id_ze,
    req_ze.nom,
    replace(replace(replace(replace(array_agg(req_desserte_pu.nom_court ORDER BY req_desserte_pu.nom_court)::text, '"'::text, ''::text), '}'::text, ''::text), '{'::text, ''::text), ','::text, chr(10))::character varying(500) AS ligne_tad,
    req_ze.geom
   FROM req_ze,
    req_desserte_pu
  WHERE req_ze.id_ze::text = req_desserte_pu.id_ze::text
  GROUP BY req_ze.id_ze, req_ze.nom, req_ze.geom;

ALTER TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_tad
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_geo_v_tic_ze_gdpu_tad
    IS 'Vue géométrique formattant pour chaque ZE le n° de ligne et sa direction pour les lignes AlloTic. Cette vue permet de générer la vue geo_v_tic_ze_gdpu (export shape via FME) pour la gestion de l''affichage de la fiche info dans l''application grand public Plan d''Agglo interactif';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_tad TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_tad TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_tad TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_geo_v_tic_ze_gdpu_tad TO read_sig;



-- ************************************************************************************************************************
-- *** MOBILITE (Tampon LA)
-- ************************************************************************************************************************

-- View: x_apps_public.xappspublic_geo_v_tic_la_tampon

-- DROP VIEW x_apps_public.xappspublic_geo_v_tic_la_tampon;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_geo_v_tic_la_tampon AS
 SELECT geo_mob_rurbain_la.id_la,
    geo_mob_rurbain_la.date_sai,
    geo_mob_rurbain_la.date_maj,
    geo_mob_rurbain_la.op_sai,
    geo_mob_rurbain_la.modification,
    geo_mob_rurbain_la.statut,
    geo_mob_rurbain_la.nom,
    geo_mob_rurbain_la.nom_court,
    geo_mob_rurbain_la.description,
    geo_mob_rurbain_la.x_l93,
    geo_mob_rurbain_la.y_l93,
    geo_mob_rurbain_la.date_deb,
    geo_mob_rurbain_la.date_fin,
    geo_mob_rurbain_la.hierarchie,
    geo_mob_rurbain_la.insee,
    geo_mob_rurbain_la.commune,
    geo_mob_rurbain_la.id_parent,
    geo_mob_rurbain_la.sens,
    geo_mob_rurbain_la.angle,
    geo_mob_rurbain_la.observ,
    geo_mob_rurbain_la.v_tampon,
    geo_mob_rurbain_la.geom2
   FROM m_mobilite.geo_mob_rurbain_la
  WHERE geo_mob_rurbain_la.statut::text = '10'::text
  ORDER BY geo_mob_rurbain_la.nom;

ALTER TABLE x_apps_public.xappspublic_geo_v_tic_la_tampon
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_geo_v_tic_la_tampon
    IS 'Vue géométrique contenant les tampons d''emprise des lieux d''arrêt pour EXPORT FME et recherche des adresse dans ses tampons pour remonter l''arrêt et les lignes en desserte';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_geo_v_tic_la_tampon TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_tic_la_tampon TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_tic_la_tampon TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_geo_v_tic_la_tampon TO read_sig;

-- ************************************************************************************************************************
-- *** TRI, DECHET
-- ************************************************************************************************************************

-- View: x_apps_public.xappspublic_geo_v_dec_pav_tampon

-- DROP VIEW x_apps_public.xappspublic_geo_v_dec_pav_tampon;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_geo_v_dec_pav_tampon AS
 SELECT geo_dec_pav_verre.id_contver,
    geo_dec_pav_verre.v_tampon,
    geo_dec_pav_verre.date_effet,
    geo_dec_pav_verre.geom2
   FROM m_dechet.geo_dec_pav_verre
  WHERE geo_dec_pav_verre.statut::text = '10'::text AND geo_dec_pav_verre.env_implan::text <> '40'::text;

ALTER TABLE x_apps_public.xappspublic_geo_v_dec_pav_tampon
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_geo_v_dec_pav_tampon
    IS 'Vue géométrique contenant les tampons d''emprise des conteneurs TLC pour EXPORT FME et recherche des adresse dans ses tampons pour remonter le PAV VERRE';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_geo_v_dec_pav_tampon TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_dec_pav_tampon TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_dec_pav_tampon TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_geo_v_dec_pav_tampon TO read_sig;

-- View: x_apps_public.xappspublic_geo_v_dec_pav_tlc_tampon

-- DROP VIEW x_apps_public.xappspublic_geo_v_dec_pav_tlc_tampon;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_geo_v_dec_pav_tlc_tampon AS
 SELECT geo_dec_pav_tlc.id_cont_tl,
    geo_dec_pav_tlc.v_tampon,
    geo_dec_pav_tlc.date_effet,
    geo_dec_pav_tlc.geom2
   FROM m_dechet.geo_dec_pav_tlc;

ALTER TABLE x_apps_public.xappspublic_geo_v_dec_pav_tlc_tampon
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_geo_v_dec_pav_tlc_tampon
    IS 'Vue géométrique contenant les tampons d''emprise des conteneurs TLC pour EXPORT FME et recherche des adresse dans ses tampons pour remonter le PAV VERRE';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_geo_v_dec_pav_tlc_tampon TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_dec_pav_tlc_tampon TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_dec_pav_tlc_tampon TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_geo_v_dec_pav_tlc_tampon TO read_sig;

-- View: x_apps_public.xappspublic_geo_v_dec_secteur_enc_secteur

-- DROP VIEW x_apps_public.xappspublic_geo_v_dec_secteur_enc_secteur;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_geo_v_dec_secteur_enc_secteur AS
 SELECT geo_dec_secteur_enc.gid,
    geo_dec_secteur_enc.insee,
    geo_dec_secteur_enc.commune,
    geo_dec_secteur_enc.adresse,
    geo_dec_secteur_enc.l_secteur,
    geo_dec_secteur_enc.l_message1,
    geo_dec_secteur_enc.l_message2,
    geo_dec_secteur_enc.geom1 AS geom
   FROM m_dechet.geo_dec_secteur_enc;

ALTER TABLE x_apps_public.xappspublic_geo_v_dec_secteur_enc_secteur
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_geo_v_dec_secteur_enc_secteur
    IS 'Vue géométrique contenant les secteurs de rammassage des encombrants pour export dans GEO APPLI GD PUBLIC';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_geo_v_dec_secteur_enc_secteur TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_dec_secteur_enc_secteur TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_dec_secteur_enc_secteur TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_geo_v_dec_secteur_enc_secteur TO read_sig;


-- ************************************************************************************************************************
-- *** Carte scolaire
-- ************************************************************************************************************************

-- View: x_apps_public.xappspublic_geo_v_carte_scolaire_mat

-- DROP VIEW x_apps_public.xappspublic_geo_v_carte_scolaire_mat;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_geo_v_carte_scolaire_mat AS
 WITH req_1 AS (
         WITH req_a AS (
                 SELECT s.id,
                    a.id_adresse,
                    s.url
                   FROM x_apps.xapps_geo_vmr_adresse a,
                    r_administratif.geo_carte_scolaire s
                  WHERE st_intersects(a.geom, s.geom) = true
                )
         SELECT req_a.id_adresse,
            lk_cscomat_poi.id,
            lk_cscomat_poi.id_poi_mat,
            req_a.url
           FROM req_a,
            r_administratif.lk_cscomat_poi
          WHERE req_a.id = lk_cscomat_poi.id
        )
 SELECT row_number() OVER () AS gid,
    req_1.id_adresse,
    req_1.id,
    req_1.id_poi_mat,
        CASE
            WHEN geo_plan_refpoi.id_poi = 'poi801'::bpchar THEN 'Rattachement aux écoles maternelles de Compiègne (se renseigner en mairie)'::character varying(255)
            WHEN geo_plan_refpoi.id_poi = 'poi743'::bpchar OR geo_plan_refpoi.id_poi = 'poi820'::bpchar OR geo_plan_refpoi.id_poi = 'poi678'::bpchar THEN 'Se renseigner en mairie'::character varying(255)
            ELSE
            CASE
                WHEN geo_plan_refpoi.id_poi = 'poi927'::bpchar THEN 'Se rapprocher de la mairie pour connaître le périmètre scolaire dont dépend votre ou vos enfant(s)'::character varying(255)
                ELSE geo_plan_refpoi.poi_lib::character varying(255)
            END
        END AS affiche_mat,
    req_1.url,
    geo_plan_refpoi.geom
   FROM req_1
     JOIN r_plan.geo_plan_refpoi ON req_1.id_poi_mat::bpchar = geo_plan_refpoi.id_poi;

ALTER TABLE x_apps_public.xappspublic_geo_v_carte_scolaire_mat
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_geo_v_carte_scolaire_mat
    IS 'Vue géographique remontant pour chaque adresse les écoles maternelles de rattachement et la géométrie du POI (export shape via FME) pour la gestion de l''affichage de la fiche info dans l''application grand public Plan d''Agglo interactif';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_geo_v_carte_scolaire_mat TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_carte_scolaire_mat TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_carte_scolaire_mat TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_geo_v_carte_scolaire_mat TO read_sig;


-- View: x_apps_public.xappspublic_geo_v_carte_scolaire_ele

-- DROP VIEW x_apps_public.xappspublic_geo_v_carte_scolaire_ele;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_geo_v_carte_scolaire_ele AS
 WITH req_1 AS (
         WITH req_a AS (
                 SELECT s.id,
                    a.id_adresse,
                    s.url
                   FROM x_apps.xapps_geo_vmr_adresse a,
                    r_administratif.geo_carte_scolaire s
                  WHERE st_intersects(a.geom, s.geom) = true
                )
         SELECT req_a.id_adresse,
            lk_cscoele_poi.id,
            lk_cscoele_poi.id_poi_ele,
            req_a.url
           FROM req_a,
            r_administratif.lk_cscoele_poi
          WHERE req_a.id = lk_cscoele_poi.id
        )
 SELECT row_number() OVER () AS gid,
    req_1.id_adresse,
    req_1.id,
    req_1.id_poi_ele,
        CASE
            WHEN geo_plan_refpoi.id_poi = 'poi743'::bpchar OR geo_plan_refpoi.id_poi = 'poi820'::bpchar OR geo_plan_refpoi.id_poi = 'poi678'::bpchar THEN 'Se renseigner en mairie'::character varying(255)
            ELSE
            CASE
                WHEN geo_plan_refpoi.id_poi = 'poi999'::bpchar THEN 'Ecole élémentaire les Remparts et/ou du Centre (contactez Mme GRAF, directrice des Remparts, au 0344409235)'::character varying(255)
                WHEN geo_plan_refpoi.id_poi = 'poi927'::bpchar THEN 'Se rapprocher de la mairie pour connaître le périmètre scolaire dont dépend votre ou vos enfant(s)'::character varying(255)
                ELSE geo_plan_refpoi.poi_lib::character varying(255)
            END
        END AS affiche_ele,
    req_1.url,
    geo_plan_refpoi.geom
   FROM req_1
     JOIN r_plan.geo_plan_refpoi ON req_1.id_poi_ele::bpchar = geo_plan_refpoi.id_poi;

ALTER TABLE x_apps_public.xappspublic_geo_v_carte_scolaire_ele
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_geo_v_carte_scolaire_ele
    IS 'Vue géographique remontant pour chaque adresse les écoles élémentaires de rattachement avec la géométrie du POI (export shape via FME) pour la gestion de l''affichage de la fiche info dans l''application grand public Plan d''Agglo interactif';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_geo_v_carte_scolaire_ele TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_carte_scolaire_ele TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_carte_scolaire_ele TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_geo_v_carte_scolaire_ele TO read_sig;

-- ************************************************************************************************************************
-- *** Fibre optique
-- ************************************************************************************************************************

-- View: x_apps_public.xappspublic_geo_v_fo_sfr_pm

-- DROP VIEW x_apps_public.xappspublic_geo_v_fo_sfr_pm;

CREATE OR REPLACE VIEW x_apps_public.xappspublic_geo_v_fo_sfr_pm AS
 WITH req_pm AS (
         SELECT geo_fo_sfr_pm.gid,
            geo_fo_sfr_pm.id_sro,
            geo_fo_sfr_pm.date_int,
            geo_fo_sfr_pm.date_maj,
            geo_fo_sfr_pm.insee,
            geo_fo_sfr_pm.commune,
            geo_fo_sfr_pm.id_pm,
            geo_fo_sfr_pm.l_annee,
            geo_fo_sfr_pm.l_zone,
            geo_fo_sfr_pm.l_adresse,
            geo_fo_sfr_pm.l_statut,
            geo_fo_sfr_pm.l_nbpri_previ,
            geo_fo_sfr_pm.l_nbprisout_previ,
            geo_fo_sfr_pm.l_nbpriaer_previ,
            geo_fo_sfr_pm.l_nbprifac_previ,
            geo_fo_sfr_pm.l_nbpri_reel,
            geo_fo_sfr_pm.l_nbprisout_reel,
            geo_fo_sfr_pm.l_nbpriaer_reel,
            geo_fo_sfr_pm.l_nbprifac_reel,
            geo_fo_sfr_pm.l_date_rac_nro AS l_date_rac,
            geo_fo_sfr_pm.l_date_maj,
            geo_fo_sfr_pm.geom1 AS geom,
            geo_fo_sfr_pm.l_role,
            geo_fo_sfr_pm.l_g2r_nro,
            geo_fo_sfr_pm.observ,
            geo_fo_sfr_pm.l_secteur,
            geo_fo_sfr_pm.l_eligibilite,
            geo_fo_sfr_pm.l_eligibilite_url,
            geo_fo_sfr_pm.l_message,
            geo_fo_sfr_pm.l_date_pose,
            geo_fo_sfr_pm.l_date_rac_zapm,
            geo_fo_sfr_pm.l_date_j3m,
            geo_fo_sfr_pm.l_nbpripav_reel,
            geo_fo_sfr_pm.l_nbpricoll_reel,
            geo_fo_sfr_pm.l_date_dj3m
           FROM m_reseau_sec.geo_fo_sfr_pm
        ), req_dmaj AS (
         SELECT max(geo_fo_sfr_pm.date_maj) AS mdate_maj
           FROM m_reseau_sec.geo_fo_sfr_pm
        )
 SELECT req_pm.gid,
    req_pm.id_sro,
    req_pm.date_int,
    req_pm.date_maj,
    req_pm.insee,
    req_pm.commune,
    req_pm.id_pm,
    req_pm.l_annee,
    req_pm.l_zone,
    req_pm.l_adresse,
    req_pm.l_statut,
    req_pm.l_nbpri_previ,
    req_pm.l_nbprisout_previ,
    req_pm.l_nbpriaer_previ,
    req_pm.l_nbprifac_previ,
    req_pm.l_nbpri_reel,
    req_pm.l_nbprisout_reel,
    req_pm.l_nbpriaer_reel,
    req_pm.l_nbprifac_reel,
    req_pm.l_date_rac,
    req_pm.l_date_maj,
    req_pm.geom,
    req_pm.l_role,
    req_pm.l_g2r_nro,
    req_pm.observ,
    req_pm.l_secteur,
    req_pm.l_eligibilite,
    req_pm.l_eligibilite_url,
    req_pm.l_message,
    req_pm.l_date_pose,
    req_pm.l_date_rac_zapm,
    req_pm.l_date_j3m,
    req_pm.l_nbpripav_reel,
    req_pm.l_nbpricoll_reel,
    req_pm.l_date_dj3m,
    req_dmaj.mdate_maj
   FROM req_pm,
    req_dmaj;

ALTER TABLE x_apps_public.xappspublic_geo_v_fo_sfr_pm
    OWNER TO sig_create;
COMMENT ON VIEW x_apps_public.xappspublic_geo_v_fo_sfr_pm
    IS 'Vue de consultation uniquement sur les secteurs de PM pour export dans l''application Grand Public Plan interactif';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps_public.xappspublic_geo_v_fo_sfr_pm TO edit_sig;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_fo_sfr_pm TO sig_create;
GRANT ALL ON TABLE x_apps_public.xappspublic_geo_v_fo_sfr_pm TO create_sig;
GRANT SELECT ON TABLE x_apps_public.xappspublic_geo_v_fo_sfr_pm TO read_sig;


