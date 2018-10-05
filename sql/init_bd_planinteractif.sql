-- ############################################################################################ SUIVI CODE SQL ###################################################################################################

-- 2018/10/05 : GB / Initialisation des requêtes d'exploitation pour le fonctionnel de l'application grand public Plan Interactif

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                       VUES APPLICATIVED GRANS PUBLIC                                                                      ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


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

