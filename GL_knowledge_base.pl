%  BUILDINGS / BLOCS


building(bloc_amphi, 'Bloc Amphithéâtres',   800).
building(bloc_td,    'Bloc Salles TD',        300).
building(bloc_li,    'Bloc Laboratoires LI',  600).


% Amphhi  
room(a1,   200, projector,        bloc_amphi, 15).
room(a2,   200, projector,        bloc_amphi, 15).
room(a3,   200, projector,        bloc_amphi, 15).
room(a4,   200, projector,        bloc_amphi, 15).
room(a5,   200, projector,        bloc_amphi, 15).
room(a6,   200, projector,        bloc_amphi, 15).
room(a7,   200, projector,        bloc_amphi, 15).
room(a8,   200, projector,        bloc_amphi, 15).

% Sallet  TD
room(r103, 30, whiteboard, bloc_td, 5).
room(r115, 30, whiteboard, bloc_td, 5).
room(r135, 30, whiteboard, bloc_td, 5).
room(r145, 30, whiteboard, bloc_td, 5).
room(r153, 30, whiteboard, bloc_td, 5).
room(r155, 30, whiteboard, bloc_td, 5).
room(r169, 30, whiteboard, bloc_td, 5).
room(r171, 30, whiteboard, bloc_td, 5).
room(r203, 30, whiteboard, bloc_td, 5).
room(r207, 30, whiteboard, bloc_td, 5).
room(r209, 30, whiteboard, bloc_td, 5).
room(r213, 30, whiteboard, bloc_td, 5).
room(r215, 30, whiteboard, bloc_td, 5).
room(r219, 30, whiteboard, bloc_td, 5).
room(r225, 30, whiteboard, bloc_td, 5).
room(r227, 30, whiteboard, bloc_td, 5).
room(r229, 30, whiteboard, bloc_td, 5).
room(r231, 30, whiteboard, bloc_td, 5).
room(r235, 30, whiteboard, bloc_td, 5).
room(r239, 30, whiteboard, bloc_td, 5).
room(r245, 30, whiteboard, bloc_td, 5).
room(r247, 30, whiteboard, bloc_td, 5).

%  Labo LI 

room(li116,     25, pc_lab,          bloc_li, 10).
room(li173,     30, pc_lab,          bloc_li, 10).
room(li175,     25, pc_lab,          bloc_li, 10).
room(li177,     25, pc_lab,          bloc_li, 10).
room(li208,     25, electronics_lab, bloc_li, 12).
room(li210,     25, pc_lab,          bloc_li, 10).
room(li212,     25, pc_lab,          bloc_li, 10).
room(li255,     25, electronics_lab, bloc_li, 12).
room(li2121,    40, pc_lab,          bloc_li, 10).
room(li2121bis, 25, pc_lab,          bloc_li, 10).

%  TIME SLOTS


slot(mon_s1, monday,    '08h00', '09h30', 1.5).
slot(mon_s2, monday,    '09h45', '11h15', 1.5).
slot(mon_s3, monday,    '11h30', '13h00', 1.5).
slot(mon_s4, monday,    '14h00', '15h30', 1.5).
slot(mon_s5, monday,    '15h45', '17h15', 1.5).

slot(tue_s1, tuesday,   '08h00', '09h30', 1.5).
slot(tue_s2, tuesday,   '09h45', '11h15', 1.5).
slot(tue_s3, tuesday,   '11h30', '13h00', 1.5).
slot(tue_s4, tuesday,   '14h00', '15h30', 1.5).
slot(tue_s5, tuesday,   '15h45', '17h15', 1.5).

slot(wed_s1, wednesday, '08h00', '09h30', 1.5).
slot(wed_s2, wednesday, '09h45', '11h15', 1.5).
slot(wed_s3, wednesday, '11h30', '13h00', 1.5).
slot(wed_s4, wednesday, '14h00', '15h30', 1.5).
slot(wed_s5, wednesday, '15h45', '17h15', 1.5).

slot(thu_s1, thursday,  '08h00', '09h30', 1.5).
slot(thu_s2, thursday,  '09h45', '11h15', 1.5).
slot(thu_s3, thursday,  '11h30', '13h00', 1.5).
slot(thu_s4, thursday,  '14h00', '15h30', 1.5).
slot(thu_s5, thursday,  '15h45', '17h15', 1.5).

slot(fri_s1, friday,    '08h00', '09h30', 1.5).
slot(fri_s2, friday,    '09h45', '11h15', 1.5).
slot(fri_s3, friday,    '11h30', '13h00', 1.5).
slot(fri_s4, friday,    '14h00', '15h30', 1.5).
slot(fri_s5, friday,    '15h45', '17h15', 1.5).

slot(sat_s1, saturday,  '08h00', '09h30', 1.5).
slot(sat_s2, saturday,  '09h45', '11h15', 1.5).

% lgroupet


group(gl2_1, gl2, 30).
group(gl2_2, gl2, 30).
group(gl2_3, gl2, 30).
group(gl3_1, gl3, 30).
group(gl3_2, gl3, 30).
group(gl4_1, gl4, 28).
group(gl4_2, gl4, 28).


subgroup(gl2_1a, gl2_1, a, 15).
subgroup(gl2_1b, gl2_1, b, 15).
subgroup(gl2_2a, gl2_2, a, 15).
subgroup(gl2_2b, gl2_2, b, 15).
subgroup(gl2_3a, gl2_3, a, 15).
subgroup(gl2_3b, gl2_3, b, 15).
subgroup(gl3_1a, gl3_1, a, 15).
subgroup(gl3_1b, gl3_1, b, 15).
subgroup(gl3_2a, gl3_2, a, 15).
subgroup(gl3_2b, gl3_2, b, 15).
subgroup(gl4_1a, gl4_1, a, 14).
subgroup(gl4_1b, gl4_1, b, 14).
subgroup(gl4_2a, gl4_2, a, 14).
subgroup(gl4_2b, gl4_2, b, 14).

% profet


instructor(gasmi_g,       'Gasmi Ghada',             gl).
instructor(arbi_a,        'Arbi Adnen',               gl).
instructor(sfaxi_m,       'Sfaxi Mourad',             gl).
instructor(khalgui_m,     'Khalgui Mohamed',          gl).
instructor(baklouti_f,    'Baklouti Fatma',           gl).
instructor(ouni_s,        'Ouni Sofiane',             gl).
instructor(mliki_h,       'Mliki Hazar',              gl).
instructor(damergi_e,     'Damergi Emir',             gl).
instructor(gasmi_ma,      'Gasmi Maroua',             gl).
instructor(sellaouti_a,   'Sellaouti Aymen',          gl).
instructor(taktak_h,      'Taktak Hajer',             gl).
instructor(ben_gamra_i,   'Ben Gamra Imene',          management).
instructor(bichiou_i,     'Bichiou Imene',            languages).
instructor(zanina_w,      'Zanina Wiem',              languages).
instructor(yaich_s,       'Yaich Sameh',              languages).
instructor(bouzidi_s,     'Bouzidi Sonia',            gl).
instructor(hamdi_s,       'Hamdi Sana',               gl).
instructor(sfaxi_l,       'Sfaxi Lilia',              gl).
instructor(ben_yahia_s,   'Ben Yahia Saloua',         gl).
instructor(mzabi_h,       'Mzabi Hela',               management).
instructor(abdelmoula_n,  'Abdelmoula Naouel',        management).
instructor(negra_a,       'Negra Amamou Bouthei',     languages).
instructor(trigui_f,      'Trigui Elloumi Fatma',     math).
instructor(hmida_n,       'Hmida Jendoubi Nadia',     math).
instructor(loukil_a,      'Loukil Adlène',            gl).
instructor(ben_rejeb_i,   'Ben Rejeb Ihsen',          languages).
instructor(ben_hassouna_a,'Ben Hassouna Asma',        gl).
instructor(hanchi_t,      'Hanchi Thouraya',          gl).
instructor(jemai_a,       'Jemaï Abderrazak',         gl).
instructor(mami_i,        'Mami Imen',                gl).
instructor(bali_i,        'Bali Ines',                law).
instructor(bouaziz_s,     'Bouaziz Samira',           management).


% disponibilites 




available(gasmi_g, mon_s1).
available(gasmi_g, mon_s2).
available(gasmi_g, fri_s2).
available(gasmi_g, fri_s3).
available(gasmi_g, fri_s4).
available(gasmi_g, sat_s2).


available(arbi_a, mon_s2).
available(arbi_a, mon_s4).
available(arbi_a, mon_s5).
available(arbi_a, tue_s4).


available(sfaxi_m, mon_s3).
available(sfaxi_m, fri_s4).


available(khalgui_m, mon_s2).
available(khalgui_m, tue_s1).
available(khalgui_m, tue_s3).
available(khalgui_m, tue_s4).
available(khalgui_m, wed_s1).
available(khalgui_m, wed_s2).


available(baklouti_f, mon_s2).
available(baklouti_f, tue_s3).
available(baklouti_f, tue_s4).
available(baklouti_f, wed_s1).
available(baklouti_f, wed_s2).
available(baklouti_f, wed_s3).
available(baklouti_f, thu_s2).


available(ouni_s, wed_s2).
available(ouni_s, wed_s3).
available(ouni_s, thu_s2).


available(mliki_h, thu_s4).
available(mliki_h, thu_s5).
available(mliki_h, fri_s5).


available(damergi_e, thu_s3).
available(damergi_e, thu_s4).
available(damergi_e, thu_s5).
available(damergi_e, sat_s1).

available(gasmi_ma, fri_s4).
available(gasmi_ma, fri_s5).

available(sellaouti_a, mon_s5).
available(sellaouti_a, thu_s5).
available(sellaouti_a, fri_s1).
available(sellaouti_a, fri_s4).
available(sellaouti_a, sat_s1).
available(sellaouti_a, sat_s2).

available(taktak_h, tue_s2).
available(taktak_h, fri_s4).
available(taktak_h, fri_s5).

available(ben_gamra_i, wed_s1).

available(bichiou_i, thu_s1).
available(bichiou_i, thu_s2).

available(zanina_w, thu_s1).

available(yaich_s, mon_s1).

available(bouzidi_s, mon_s2).
available(bouzidi_s, mon_s3).
available(bouzidi_s, tue_s1).
available(bouzidi_s, tue_s2).
available(bouzidi_s, wed_s1).
available(bouzidi_s, fri_s2).
available(bouzidi_s, fri_s3).

available(hamdi_s, tue_s1).
available(hamdi_s, tue_s2).

available(sfaxi_l, tue_s4).
available(sfaxi_l, thu_s2).
available(sfaxi_l, thu_s4).
available(sfaxi_l, fri_s1).
available(sfaxi_l, fri_s2).

available(ben_yahia_s, mon_s1).
available(ben_yahia_s, fri_s2).
available(ben_yahia_s, fri_s3).

available(mzabi_h, mon_s4).

available(abdelmoula_n, wed_s3).

available(negra_a, thu_s3).

available(trigui_f, mon_s1).
available(trigui_f, mon_s4).
available(trigui_f, tue_s1).
available(trigui_f, wed_s1).
available(trigui_f, thu_s1).

available(hmida_n, mon_s2).
available(hmida_n, mon_s3).
available(hmida_n, mon_s4).
available(hmida_n, tue_s3).
available(hmida_n, thu_s2).

available(loukil_a, mon_s1).
available(loukil_a, wed_s3).
available(loukil_a, fri_s2).
available(loukil_a, fri_s3).

available(ben_rejeb_i, mon_s4).
available(ben_rejeb_i, tue_s1).

available(ben_hassouna_a, mon_s5).
available(ben_hassouna_a, tue_s4).
available(ben_hassouna_a, thu_s3).
available(ben_hassouna_a, thu_s4).

available(hanchi_t, mon_s5).
available(hanchi_t, tue_s4).

available(jemai_a, tue_s4).
available(jemai_a, wed_s1).

available(mami_i, mon_s4).
available(mami_i, tue_s4).
available(mami_i, tue_s5).

available(bali_i, thu_s1).
available(bali_i, fri_s1).

available(bouaziz_s, wed_s1).
available(bouaziz_s, thu_s1).

% COURSES

% gl2
course(gl2_archi_c,     'Architecture des réseaux',        gl2, lecture,  1, 1, projector,  loukil_a).
course(gl2_analyse2_c,  'Analyse 2',                       gl2, lecture,  1, 1, projector,  trigui_f).
course(gl2_csi_c,       'Conception des systèmes d''info', gl2, lecture,  1, 1, projector,  bouzidi_s).
course(gl2_sgbd_c,      'Systèmes de gestion de BDD',      gl2, lecture,  1, 1, projector,  baklouti_f).
course(gl2_algebre2_c,  'Algèbre 2',                       gl2, lecture,  1, 1, projector,  hmida_n).
course(gl2_apprep_c,    'Applications reparties',          gl2, lecture,  1, 1, projector,  ben_hassouna_a).
course(gl2_compta_c,    'Comptabilité',                    gl2, lecture,  1, 1, projector,  bouaziz_s).
course(gl2_droit_c,     'Droit',                           gl2, lecture,  1, 1, projector,  bali_i).

course(gl2_techweb_ctp, 'Technologie de web',              gl2, combined, 1, 1, pc_lab,     sellaouti_a).
course(gl2_unix_ctp,    'Unix',                            gl2, combined, 1, 1, pc_lab,     mami_i).
course(gl2_java_ctp,    'Atelier Java',                    gl2, combined, 1, 1, pc_lab,     jemai_a).

course(gl2_analyse2_td, 'Analyse 2 – TD',                  gl2, td,       1, 1, whiteboard, trigui_f).
course(gl2_algebre2_td, 'Algèbre 2 – TD',                  gl2, td,       1, 1, whiteboard, hmida_n).
course(gl2_anglais_td,  'Anglais – TD',                    gl2, td,       1, 1, whiteboard, ben_rejeb_i).
course(gl2_csi_td,      'Conception SI – TD',              gl2, td,       1, 1, whiteboard, bouzidi_s).

course(gl2_archi_tdtp,  'Architecture des réseaux – TD/TP',gl2, tp,       1, 1, pc_lab,     loukil_a).
course(gl2_csi_tp,      'Conception SI – TP',              gl2, tp,       1, 1, pc_lab,     hanchi_t).
course(gl2_apprep_tp,   'Applications reparties – TP',     gl2, tp,       1, 1, pc_lab,     ben_hassouna_a).
course(gl2_sgbd_tp,     'SGBD – TP (Gest. Admin BDD)',     gl2, tp,       1, 1, pc_lab,     baklouti_f).

% GL3 

course(gl3_algo_ci,       'Algorithmique',                  gl3, ci,      1, 1, whiteboard, gasmi_g).
course(gl3_analyse_num_ci,'Analyse Numérique',              gl3, ci,      1, 1, whiteboard, arbi_a).
course(gl3_optim_ci,      'Optimisation',                   gl3, ci,      1, 1, whiteboard, sfaxi_m).
course(gl3_complexite_ci, 'Complexité des algorithmes',     gl3, ci,      1, 1, whiteboard, mliki_h).
course(gl3_francais_ci,   'Français',                       gl3, ci,      1, 1, whiteboard, zanina_w).  % GL3/1
course(gl3_francais2_ci,  'Français',                       gl3, ci,      1, 1, whiteboard, yaich_s).   % GL3/2

course(gl3_marketing_c,   'Marketing',                      gl3, lecture, 1, 1, projector,  ben_gamra_i).
course(gl3_prog_log_c,    'Programmation Logique',          gl3, lecture, 1, 1, projector,  khalgui_m).
course(gl3_bdd_rel_c,     'Bases de données Relationnelles',gl3, lecture, 1, 1, projector,  baklouti_f).
course(gl3_fsr_c,         'Fondements systèmes repartis',   gl3, lecture, 1, 1, projector,  ouni_s).
course(gl3_analyse_don_c, 'Analyse des données',            gl3, lecture, 1, 1, projector,  arbi_a).
course(gl3_codesign_c,    'CO-design',                      gl3, lecture, 1, 1, projector,  damergi_e).
course(gl3_proto_web_c,   'Protocoles comm. Web',           gl3, lecture, 1, 1, projector,  sellaouti_a).
course(gl3_method_c,      'Méthodologies de conception',    gl3, lecture, 1, 1, projector,  gasmi_g).

course(gl3_anglais_td,    'Anglais – TD',                   gl3, td,      1, 1, whiteboard, bichiou_i).
course(gl3_bdd_rel_td,    'BDD Relationnelles – TD',        gl3, td,      1, 1, whiteboard, baklouti_f).
course(gl3_bddnr_td,      'BDD NON Relationnelles – TD',    gl3, td,      1, 1, whiteboard, baklouti_f).

course(gl3_prog_log_tdtp, 'Programmation Logique – TD/TP',  gl3, tp,      1, 1, pc_lab,          khalgui_m).
course(gl3_fsr_tp,        'Fondements SR – TP',             gl3, tp,      1, 1, pc_lab,          ouni_s).
course(gl3_analyse_don_tp,'Analyse des données – TP',       gl3, tp,      1, 1, pc_lab,          arbi_a).
course(gl3_codesign_tp,   'CO-design – TP',                 gl3, tp,      1, 1, electronics_lab, damergi_e).
course(gl3_proto_web_tp,  'Protocoles Web – TP',            gl3, tp,      1, 1, pc_lab,          sellaouti_a).
course(gl3_method_tp,     'Méthodologies – TP',             gl3, tp,      1, 1, pc_lab,          gasmi_g).
course(gl3_ppp_tp,        'Projet Personnel Professionnel', gl3, tp,      1, 1, pc_lab,          taktak_h).

% GL4 

course(gl4_devops_c,      'DevOps',                         gl4, lecture, 1, 1, projector,       ben_yahia_s).
course(gl4_deep_c,        'Deep Learning',                  gl4, lecture, 1, 1, projector,       hamdi_s).
course(gl4_grh_c,         'Gestion des Ressources Humaines',gl4, lecture, 1, 1, projector,       mzabi_h).
course(gl4_bigdata_c,     'Big Data',                       gl4, lecture, 1, 1, projector,       sfaxi_l).
course(gl4_arch_log_c,    'Architectures logicielles',      gl4, lecture, 1, 1, projector,       sfaxi_l).
course(gl4_proto_secu_c,  'Protocoles de sécurité',         gl4, lecture, 1, 1, projector,       gasmi_ma).
course(gl4_test_c,        'Test Logiciel',                  gl4, lecture, 1, 1, projector,       gasmi_ma).
course(gl4_mgt_proj_ctp,  'Management de projet',           gl4, combined,1, 1, pc_lab,          abdelmoula_n).

course(gl4_compil_ci,     'Compilation',                    gl4, ci,      1, 1, whiteboard,      khalgui_m).
course(gl4_img_ci,        'Traitement d''images',           gl4, ci,      1, 1, electronics_lab, bouzidi_s).

course(gl4_anglais_td,    'Anglais – TD',                   gl4, td,      1, 1, whiteboard,      negra_a).

course(gl4_ihm_tp,        'IHM – TP',                       gl4, tp,      1, 1, pc_lab,          taktak_h).
course(gl4_deep_tp,       'Deep Learning – TP',             gl4, tp,      1, 1, pc_lab,          hamdi_s).
course(gl4_compil_tp,     'Compilation – TP',               gl4, tp,      1, 1, pc_lab,          khalgui_m).
course(gl4_bigdata_tp,    'Big Data – TP',                  gl4, tp,      1, 1, pc_lab,          sfaxi_l).
course(gl4_arch_log_tp,   'Architectures logicielles – TP', gl4, tp,      1, 1, pc_lab,          sfaxi_l).
course(gl4_devops_tp,     'DevOps – TP',                    gl4, tp,      1, 1, pc_lab,          ben_yahia_s).
course(gl4_img_tp,        'Traitement d''images – TP',      gl4, tp,      1, 1, electronics_lab, bouzidi_s).
course(gl4_proto_secu_tp, 'Protocoles de sécurité – TP',    gl4, tp,      1, 1, pc_lab,          gasmi_ma).

%  EQUIPMENT 


compatible(projector,        projector).
compatible(whiteboard,       whiteboard).
compatible(whiteboard,       projector).        
compatible(pc_lab,           pc_lab).
compatible(pc_lab,           electronics_lab).  
compatible(electronics_lab,  electronics_lab).

% verification 

session(gl2_archi_c,     gl2_1, a5,        mon_s1).
session(gl2_analyse2_td, gl2_1, r227,      mon_s2).
session(gl2_algebre2_td, gl2_1, r135,      mon_s3).
session(gl2_anglais_td,  gl2_1, r145,      mon_s4).
session(gl2_csi_tp,      gl2_1, li177,     mon_s5).
session(gl2_analyse2_c,  gl2_1, a5,        tue_s1).
session(gl2_csi_c,       gl2_1, a5,        tue_s2).
session(gl2_sgbd_c,      gl2_1, a5,        tue_s3).
session(gl2_java_ctp,    gl2_1, li2121,    tue_s4).
session(gl2_unix_ctp,    gl2_1, li177,     tue_s5).
session(gl2_sgbd_tp,     gl2_1, li116,     wed_s2).
session(gl2_archi_tdtp,  gl2_1, li2121bis, wed_s3).
session(gl2_compta_c,    gl2_1, a5,        thu_s1).
session(gl2_algebre2_c,  gl2_1, a5,        thu_s2).
session(gl2_apprep_c,    gl2_1, a5,        thu_s3).
session(gl2_apprep_tp,   gl2_1, li116,     thu_s4).
session(gl2_droit_c,     gl2_1, a5,        fri_s1).
session(gl2_csi_td,      gl2_1, r235,      fri_s2).

session(gl2_archi_c,     gl2_2, a5,        mon_s1).
session(gl2_algebre2_td, gl2_2, r229,      mon_s2).
session(gl2_anglais_td,  gl2_2, r103,      mon_s3).
session(gl2_analyse2_td, gl2_2, r235,      mon_s4).
session(gl2_analyse2_c,  gl2_2, a5,        tue_s1).
session(gl2_csi_c,       gl2_2, a5,        tue_s2).
session(gl2_sgbd_c,      gl2_2, a5,        tue_s3).
session(gl2_apprep_tp,   gl2_2, li212,     tue_s4).
session(gl2_csi_tp,      gl2_2, li175,     tue_s4).
session(gl2_sgbd_tp,     gl2_2, li116,     wed_s1).
session(gl2_java_ctp,    gl2_2, li2121,    wed_s2).
session(gl2_compta_c,    gl2_2, a5,        thu_s1).
session(gl2_algebre2_c,  gl2_2, a5,        thu_s2).
session(gl2_apprep_c,    gl2_2, a5,        thu_s3).
session(gl2_techweb_ctp, gl2_2, li175,     thu_s5).
session(gl2_droit_c,     gl2_2, a5,        fri_s1).
session(gl2_csi_td,      gl2_2, r235,      fri_s2).
session(gl2_archi_tdtp,  gl2_2, li210,     fri_s3).
session(gl2_unix_ctp,    gl2_2, li116,     fri_s5).

session(gl2_archi_c,     gl2_3, a5,        mon_s1).
session(gl2_anglais_td,  gl2_3, r247,      mon_s2).
session(gl2_analyse2_td, gl2_3, r247,      mon_s3).
session(gl2_algebre2_td, gl2_3, r213,      mon_s4).
session(gl2_analyse2_c,  gl2_3, a5,        tue_s1).
session(gl2_csi_c,       gl2_3, a5,        tue_s2).
session(gl2_sgbd_c,      gl2_3, a5,        tue_s3).
session(gl2_java_ctp,    gl2_3, li2121,    tue_s4).
session(gl2_apprep_tp,   gl2_3, li212,     tue_s4).
session(gl2_csi_tp,      gl2_3, li175,     tue_s4).
session(gl2_unix_ctp,    gl2_3, li177,     tue_s2).
session(gl2_java_ctp,    gl2_3, li2121,    wed_s1).
session(gl2_sgbd_tp,     gl2_3, li116,     wed_s2).
session(gl2_compta_c,    gl2_3, a5,        thu_s1).
session(gl2_algebre2_c,  gl2_3, a5,        thu_s2).
session(gl2_apprep_c,    gl2_3, a5,        thu_s3).
session(gl2_droit_c,     gl2_3, a5,        fri_s1).
session(gl2_archi_tdtp,  gl2_3, li210,     fri_s2).
session(gl2_csi_td,      gl2_3, r247,      fri_s3).
session(gl2_techweb_ctp, gl2_3, li2121,    fri_s5).

session(gl3_algo_ci,       gl3_1, r215,    mon_s1).
session(gl3_analyse_num_ci,gl3_1, r207,    mon_s2).
session(gl3_optim_ci,      gl3_1, r225,    mon_s3).
session(gl3_analyse_don_c, gl3_1, a6,      mon_s4).
session(gl3_analyse_don_tp,gl3_1, li175,   mon_s5).
session(gl3_prog_log_tdtp, gl3_1, li2121,  tue_s1).
session(gl3_bdd_rel_td,    gl3_1, r115,    tue_s2).
session(gl3_prog_log_c,    gl3_1, r231,    tue_s3).
session(gl3_bdd_rel_c,     gl3_1, a1,      tue_s4).
session(gl3_marketing_c,   gl3_1, a5,      wed_s1).
session(gl3_fsr_c,         gl3_1, a5,      wed_s2).
session(gl3_fsr_tp,        gl3_1, li116,   wed_s3).
session(gl3_bddnr_td,      gl3_1, li177,   wed_s3).
session(gl3_francais_ci,   gl3_1, r169,    thu_s1).
session(gl3_anglais_td,    gl3_1, r153,    thu_s2).
session(gl3_codesign_c,    gl3_1, r247,    thu_s3).
session(gl3_complexite_ci, gl3_1, r171,    thu_s4).
session(gl3_codesign_tp,   gl3_1, li116,   thu_s5).
session(gl3_proto_web_c,   gl3_1, a7,      fri_s1).
session(gl3_method_tp,     gl3_1, li173,   fri_s2).
session(gl3_method_c,      gl3_1, a2,      fri_s3).
session(gl3_ppp_tp,        gl3_1, li255,   fri_s4).
session(gl3_proto_web_tp,  gl3_1, li173,   sat_s1).
session(gl3_method_tp,     gl3_1, li173,   sat_s2).

session(gl3_francais2_ci,  gl3_2, r169,    mon_s1).
session(gl3_algo_ci,       gl3_2, r209,    mon_s2).
session(gl3_analyse_num_ci,gl3_2, r207,    mon_s3).
session(gl3_analyse_don_c, gl3_2, a6,      mon_s4).
session(gl3_analyse_don_tp,gl3_2, li175,   mon_s5).
session(gl3_bdd_rel_td,    gl3_2, r155,    tue_s1).
session(gl3_prog_log_tdtp, gl3_2, li2121,  tue_s2).
session(gl3_prog_log_c,    gl3_2, r231,    tue_s3).
session(gl3_bdd_rel_c,     gl3_2, a1,      tue_s4).
session(gl3_marketing_c,   gl3_2, a5,      wed_s1).
session(gl3_fsr_c,         gl3_2, a5,      wed_s2).
session(gl3_bddnr_td,      gl3_2, li177,   wed_s3).
session(gl3_fsr_tp,        gl3_2, li116,   wed_s3).
session(gl3_anglais_td,    gl3_2, r153,    thu_s1).
session(gl3_codesign_c,    gl3_2, r247,    thu_s3).
session(gl3_codesign_tp,   gl3_2, li177,   thu_s4).
session(gl3_complexite_ci, gl3_2, r171,    thu_s5).
session(gl3_optim_ci,      gl3_2, r215,    fri_s4).
session(gl3_proto_web_c,   gl3_2, a7,      fri_s1).
session(gl3_method_tp,     gl3_2, li173,   fri_s2).
session(gl3_method_c,      gl3_2, a2,      fri_s3).
session(gl3_ppp_tp,        gl3_2, li255,   fri_s5).
session(gl3_proto_web_tp,  gl3_2, li173,   sat_s1).
session(gl3_method_tp,     gl3_2, li173,   sat_s2).

session(gl4_devops_c,      gl4_1, r245,    mon_s1).
session(gl4_img_ci,        gl4_1, li2121,  mon_s2).
session(gl4_grh_c,         gl4_1, a1,      mon_s4).
session(gl4_deep_c,        gl4_1, r219,    tue_s1).
session(gl4_ihm_tp,        gl4_1, li177,   tue_s2).
session(gl4_deep_tp,       gl4_1, li208,   tue_s2).
session(gl4_img_tp,        gl4_1, li255,   tue_s4).
session(gl4_compil_tp,     gl4_1, li173,   tue_s4).
session(gl4_compil_ci,     gl4_1, r203,    wed_s2).
session(gl4_mgt_proj_ctp,  gl4_1, a5,      wed_s3).
session(gl4_test_c,        gl4_1, r239,    thu_s1).
session(gl4_bigdata_c,     gl4_1, a1,      thu_s2).
session(gl4_anglais_td,    gl4_1, r227,    thu_s3).
session(gl4_bigdata_tp,    gl4_1, li210,   thu_s4).
session(gl4_arch_log_c,    gl4_1, a2,      fri_s1).
session(gl4_devops_tp,     gl4_1, li116,   fri_s2).
session(gl4_arch_log_tp,   gl4_1, li177,   fri_s2).
session(gl4_proto_secu_c,  gl4_1, a2,      fri_s4).
session(gl4_proto_secu_tp, gl4_1, li177,   fri_s5).

session(gl4_devops_c,      gl4_2, r245,    mon_s1).
session(gl4_grh_c,         gl4_2, a1,      mon_s4).
session(gl4_deep_c,        gl4_2, r219,    tue_s1).
session(gl4_deep_tp,       gl4_2, li208,   tue_s2).
session(gl4_ihm_tp,        gl4_2, li177,   tue_s2).
session(gl4_compil_tp,     gl4_2, li173,   tue_s4).
session(gl4_img_tp,        gl4_2, li255,   tue_s4).
session(gl4_compil_ci,     gl4_2, r203,    wed_s1).
session(gl4_img_ci,        gl4_2, li2121,  wed_s3).
session(gl4_mgt_proj_ctp,  gl4_2, a5,      wed_s3).
session(gl4_test_c,        gl4_2, r239,    thu_s1).
session(gl4_bigdata_c,     gl4_2, a1,      thu_s2).
session(gl4_anglais_td,    gl4_2, r227,    thu_s3).
session(gl4_compil_tp,     gl4_2, li173,   thu_s4).
session(gl4_bigdata_tp,    gl4_2, li210,   thu_s4).
session(gl4_arch_log_c,    gl4_2, a2,      fri_s1).
session(gl4_devops_tp,     gl4_2, li116,   fri_s2).
session(gl4_arch_log_tp,   gl4_2, li177,   fri_s2).
session(gl4_proto_secu_c,  gl4_2, a2,      fri_s4).
session(gl4_proto_secu_tp, gl4_2, li177,   fri_s5).




day_of_slot(S, D) :- slot(S, D, _, _, _).

slot_duration(S, D) :- slot(S, _, _, _, D).

slots_on_day(Day, Slots) :-
    findall(S, slot(S, Day, _, _, _), Slots).

all_days([monday, tuesday, wednesday, thursday, friday, saturday]).

all_slots(Slots) :-
    findall(S, slot(S, _, _, _, _), Slots).


room_building(R, B) :- room(R, _, _, B, _).

room_energy_cost(R, C) :- room(R, _, _, _, C).

room_capacity(R, Cap) :- room(R, Cap, _, _, _).

room_equipment(R, E) :- room(R, _, E, _, _).

rooms_of_type(ReqEquip, Rooms) :-
    findall(R, (room(R, _, RoomEquip, _, _), compatible(ReqEquip, RoomEquip)), Rooms).


group_size(G, S) :- group(G, _, S).
group_size(G, S) :- subgroup(G, _, _, S).

group_level(G, L) :- group(G, L, _).

parent_group(SG, G) :- subgroup(SG, G, _, _).

subgroups_of(G, Subs) :-
    findall(SG, subgroup(SG, G, _, _), Subs).


course_instructor(C, I) :- course(C, _, _, _, _, _, _, I).

course_equipment(C, E) :- course(C, _, _, _, _, _, E, _).

course_level(C, L) :- course(C, _, L, _, _, _, _, _).

course_type(C, T) :- course(C, _, _, T, _, _, _, _).

courses_for_group(G, Courses) :-
    group_level(G, L),
    findall(C, course(C, _, L, _, _, _, _, _), Courses).


instructor_available_at(I, S) :- available(I, S).

available_slots_for(I, Slots) :-
    findall(S, available(I, S), Slots).




room_suitable(CourseID, RoomID, GroupID) :-
    course_equipment(CourseID, ReqEquip),
    room(RoomID, Cap, RoomEquip, _, _),
    compatible(ReqEquip, RoomEquip),
    group_size(GroupID, Size),
    Cap >= Size.

energy_consumed(R, DSlots, E) :-
    room_energy_cost(R, CostPerHour),
    E is CostPerHour * DSlots * 1.5.

session_energy(session(C, _, R, _), E) :-
    course(C, _, _, _, _, DSlots, _, _),
    energy_consumed(R, DSlots, E).

sessions_energy_sum([], 0).
sessions_energy_sum([H|T], Total) :-
    session_energy(H, E),
    sessions_energy_sum(T, Rest),
    Total is E + Rest.

building_daily_sessions(Schedule, B, D, Sessions) :-
    include(in_building_on_day(B, D), Schedule, Sessions).

in_building_on_day(B, D, session(_, _, R, S)) :-
    room_building(R, B),
    day_of_slot(S, D).

building_energy_on_day(Schedule, B, D, Total) :-
    building_daily_sessions(Schedule, B, D, Sessions),
    sessions_energy_sum(Sessions, Total).

energy_within_threshold(Schedule, B, D) :-
    building(B, _, Threshold),
    building_energy_on_day(Schedule, B, D, Total),
    Total =< Threshold.

total_weekly_energy(Schedule, Total) :-
    sessions_energy_sum(Schedule, Total).


ground_truth_sessions(Sessions) :-
    findall(session(C, G, R, S), session(C, G, R, S), Sessions).
