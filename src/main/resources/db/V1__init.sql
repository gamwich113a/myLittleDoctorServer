-- voir pour setter la taille max de la colonne varchar ou passer en clob

CREATE TABLE utilisateur (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  nom varchar(50) NOT NULL,
  prenom varchar(50) DEFAULT NULL,
  mdp varchar(50) NULL,
  date_naissance date NULL,
  email varchar(100) NULL,
  sexe int,
  role int,
  atelier_en_cours bigint(20) DEFAULT NULL,
  cursus_id bigint(20) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY UK_utilisateur (nom,prenom)
);

CREATE TABLE cursus (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  annee_des integer,
  region_formation integer, 
  hopital_id bigint(20) DEFAULT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE hopital (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  nom varchar(255),
  ville varchar(50),
  departement int, 
  PRIMARY KEY (id)
);

CREATE TABLE geste (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  geste_id bigint(20),
  description varchar(255),
  atelier_id bigint(20),
  PRIMARY KEY (id),
  UNIQUE KEY UK_geste (description)  
);

CREATE TABLE atelier (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  titre varchar(100) DEFAULT NULL,
  date_debut datetime DEFAULT NULL,
  date_fin datetime DEFAULT NULL,
  description varchar(2048) DEFAULT NULL,
  lieu varchar(100) DEFAULT NULL,
  createur_id bigint(20) DEFAULT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY UK_atelier (titre)
);


CREATE TABLE rapport (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  titre varchar(100) DEFAULT NULL,
  date_saisie datetime DEFAULT NULL,
  rapport varchar(2048) DEFAULT NULL,
  atelier_id bigint(20) DEFAULT NULL,
  utilisateur_id bigint(20) DEFAULT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE topo (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  atelier_id bigint(20) DEFAULT NULL,
  utilisateur_id bigint(20) DEFAULT NULL,
  titre varchar(100) DEFAULT NULL,
  description varchar(2048) DEFAULT NULL,
  date_saisie datetime DEFAULT NULL,
  date_update datetime DEFAULT NULL,
  etape bigint(20) DEFAULT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE topo_url (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  titre varchar(100) DEFAULT NULL,
  url varchar(2048) DEFAULT NULL,
  topo_id bigint(20) DEFAULT NULL,
  type int(1),
  PRIMARY KEY (id)
);


CREATE TABLE evaluation (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  date_saisie datetime DEFAULT NULL,
  note integer DEFAULT 0,
  commentaire varchar(2048) DEFAULT NULL,
  nombre_pratique_an int,
  -- il evalue un atelier ou il s evalue sur un geste
  atelier_id bigint(20) DEFAULT NULL,
  geste_id bigint(20) DEFAULT NULL,
  formateur_id bigint(20) DEFAULT NULL,
  utilisateur_id bigint(20) DEFAULT NULL,
  PRIMARY KEY (id)
);



insert into geste (description, atelier_id) values('Ligature artère iliaque interne', 1);
insert into geste (description, atelier_id) values('Hystérectomie voie basse', 2);
insert into geste (description) values('Périnée complet compliqué');
insert into geste (description) values('Cure de prolapsus voie basse');
insert into geste (description) values('Pfannensteil');
insert into geste (description) values('Suture Aorte');
insert into geste (description) values('Suture intestin');
insert into geste (description) values('Suture Vessie');
insert into geste (description) values('Curage pelvien par laparotomie');
insert into geste (description) values('Hystéroscopie : endométrectomie');
insert into geste (description) values('Hystéroscopie : section de cloison');
insert into geste (description) values('Hystéroscopie : résection de polype/myome');
insert into geste (description) values('Curage lombo aortique par laparotomie');


insert into cursus (annee_des,region_formation,hopital_id) values (5,75,262);
insert into utilisateur (nom,prenom,mdp,date_naissance,sexe,role,cursus_id) values ('Gauroy','Elodie','Adam2018','1985-04-23',2,2,1);

insert into cursus (annee_des,region_formation,hopital_id) values (1,75,1);
insert into utilisateur (nom,prenom,mdp,date_naissance,sexe,role,cursus_id) values ('Arlebois','Nicolas','hera','1982-07-29',1,2,2);

insert into cursus (annee_des,region_formation,hopital_id) values (1,75,1);
insert into utilisateur (nom,prenom,mdp,date_naissance,sexe,role,cursus_id) values ('a','a','a','1982-07-29',1,2,3);


insert into atelier (titre,date_debut,date_fin,description,lieu,createur_id) values ('Atelier1', '2018-01-01','2019-01-01','Description de l''atelier de test','salle 001',1);
insert into atelier (titre,date_debut,date_fin,description,lieu,createur_id) values ('Atelier2', '2018-01-01','2019-01-01','Description de l''atelier 2','salle 002',1);

insert into topo (atelier_id, utilisateur_id, titre,  description, date_saisie, date_update, etape) values (1,1,'topo de l''atelier 1', '<h1>ceci est le topo de l''atelier1</h1><br><b>thytrhththfthfhfghgfhgfhgfh</b><br><u>test retour ligne</u>', '2018-04-07', null, null);
insert into topo (atelier_id, utilisateur_id, titre,  description, date_saisie, date_update, etape) values (1,1,null, 'topo step 1 atelier 1', '2018-04-07', null, 1);
insert into topo (atelier_id, utilisateur_id, titre,  description, date_saisie, date_update, etape) values (1,1,null, 'topo step 2 atelier 1', '2018-04-07', null, 2);

insert into topo_url (titre,url,topo_id,type) values ('Url 1 Atelier 1','https://fr.wikipedia.org/wiki/Gyn%C3%A9cologie',1,1);
insert into topo_url (titre,url,topo_id,type) values ('Url 2 Atelier 1','iEk75-2GgGk',1,2);


insert into topo (atelier_id, utilisateur_id, titre,  description, date_saisie, date_update, etape) values (2,1,'topo de l''atelier 2', 'ceci est le topo de l''atelier2', '2018-04-07', null, null);
insert into topo (atelier_id, utilisateur_id, titre,  description, date_saisie, date_update, etape) values (2,1,null, 'topo step 1 atelier 2', '2018-04-07', null, 1);
insert into topo (atelier_id, utilisateur_id, titre,  description, date_saisie, date_update, etape) values (2,1,null, 'topo step 2 atelier 2', '2018-04-07', null, 2);


insert into hopital (nom,departement,ville) values('Centre de Santé LNA Santé',78,'Achères');
insert into hopital (nom,departement,ville) values('Hôpital Privé Nord-Parisien',95,'Sarcelles');
insert into hopital (nom,departement,ville) values('Maison de Santé d''Épinay LNA Santé',93,'Épinay-sur-Seine');
insert into hopital (nom,departement,ville) values('Groupe Hospitalier Diaconesses - Croix Saint-Simon',75,'Paris 20');
insert into hopital (nom,departement,ville) values('Hôpital Gériatrique Les Magnolias (HPGM)',91,'Ballainvilliers');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Manhès',91,'Fleury-Mérogis');
insert into hopital (nom,departement,ville) values('Hôpital Chirurgical Marie Lannelongue',92,'Le Plessis-Robinson');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Intercommunal Robert Ballanger',93,'Aulnay-sous-Bois');
insert into hopital (nom,departement,ville) values('Établissement public de Santé Barthélemy Durand',91,'Étampes');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Théophile Roussel Etablissement Public de Santé Mentale Interdépartemental',78,'Montesson');
insert into hopital (nom,departement,ville) values('Clinique du Bourget (Ramsay - Générale de Santé)',93,'Le Bourget');
insert into hopital (nom,departement,ville) values('Clinique du Mont Valérien CLINEA',92,'Rueil-Malmaison');
insert into hopital (nom,departement,ville) values('Clinique du Bois d''Amour (Ramsay - Générale de Santé)',93,'Drancy');
insert into hopital (nom,departement,ville) values('Clinique Les Platanes - Soins de Suite et de Réadaptation Traitement des Troubles de l''Addiction (Ramsay - Générale de Santé)',93,'Épinay-sur-Seine');
insert into hopital (nom,departement,ville) values('Centre de Rééducation et de Réadaptation Fonctionnelles La Châtaigneraie Convention',75,'Paris 15');
insert into hopital (nom,departement,ville) values('Centre de Réadaptation Fonctionnelle APARC',78,'Rosny-sur-Seine');
insert into hopital (nom,departement,ville) values('LADAPT Hauts-de-Seine - Centre SSR',92,'Châtillon');
insert into hopital (nom,departement,ville) values('Centre Médical et Pédagogique de Varennes Jarcy',91,'Varennes-Jarcy');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Sud Essonne Dourdan Etampes, Site d''Etampes',91,'Étampes');
insert into hopital (nom,departement,ville) values('Hôpital de Bullion Pédiatrie et Rééducation',78,'Bullion');
insert into hopital (nom,departement,ville) values('Centre de Médecine Nucléaire Paris Nord',95,'Sarcelles');
insert into hopital (nom,departement,ville) values('Clinique Saint-Faron Groupe Salvia Santé',77,'Mareuil-lès-Meaux');
insert into hopital (nom,departement,ville) values('Hôpital Privé de Marne la Vallée (Ramsay - Générale de Santé)',94,'Bry-sur-Marne');
insert into hopital (nom,departement,ville) values('Polyclinique de Villeneuve-Saint-Georges (Ramsay - Générale de Santé)',94,'Villeneuve-Saint-Georges');
insert into hopital (nom,departement,ville) values('Centre de dialyse Diaverum',92,'Levallois-Perret');
insert into hopital (nom,departement,ville) values('Clinique Internationale du Parc Monceau',75,'Paris 17');
insert into hopital (nom,departement,ville) values('Clinique Jouvenet (Ramsay - Générale de Santé)',75,'Paris 16');
insert into hopital (nom,departement,ville) values('Clinique Hartmann',92,'Neuilly-sur-Seine');
insert into hopital (nom,departement,ville) values('Clinique Les Jardins de Brunoy (DomusCliniques)',91,'Brunoy');
insert into hopital (nom,departement,ville) values('Centre Médico-Chirurgical Georges-Bizet',75,'Paris 16');
insert into hopital (nom,departement,ville) values('Korian Hôpital des Courses',78,'Maisons-Laffitte');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Privé du Montgardé',78,'Aubergenville');
insert into hopital (nom,departement,ville) values('Centre Chirurgical Pierre Cherest',92,'Neuilly-sur-Seine');
insert into hopital (nom,departement,ville) values('Clinique Les Charmilles - Hôpital Privé de Paris Essonne',91,'Arpajon');
insert into hopital (nom,departement,ville) values('Hôpital Privé de l''Ouest Parisien (Ramsay - Générale de Santé)',78,'Trappes');
insert into hopital (nom,departement,ville) values('Centre Cardiologique du Nord - Porte de Paris',93,'Saint-Denis');
insert into hopital (nom,departement,ville) values('Clinique Les Jardins de Brunoy (DomusCliniques)',91,'Brunoy');
insert into hopital (nom,departement,ville) values('Hôpital Privé de Vitry - Clinique Pasteur (Elsan)',94,'Vitry-sur-Seine');
insert into hopital (nom,departement,ville) values('Hôpital Privé d''Athis-Mons - Site Jules Vallès',91,'Athis-Mons');
insert into hopital (nom,departement,ville) values('Centre Gératrique Denis Forestier',78,'La Verrière');
insert into hopital (nom,departement,ville) values('Clinique Médicale du Parc',95,'Saint-Ouen-l''Aumône');
insert into hopital (nom,departement,ville) values('Clinique Geoffroy Saint-Hilaire (Ramsay - Générale de Santé)',75,'Paris 05');
insert into hopital (nom,departement,ville) values('Hôpital Privé du Vert Galant (Ramsay - Générale de Santé)',93,'Tremblay-en-France');
insert into hopital (nom,departement,ville) values('Clinique d''Esthétique Chirurgicale Alphand',75,'Paris 16');
insert into hopital (nom,departement,ville) values('Clinique Montevideo',92,'Boulogne-Billancourt');
insert into hopital (nom,departement,ville) values('Centre de Consultations Chirurgicales des Gresillons',92,'Gennevilliers');
insert into hopital (nom,departement,ville) values('Clinique Saint-Brice (Elsan)',77,'Provins');
insert into hopital (nom,departement,ville) values('Clinique Saint-Faron Groupe Salvia Santé',77,'Mareuil-lès-Meaux');
insert into hopital (nom,departement,ville) values('Clinique Les Martinets (Ramsay - Générale de Santé)',92,'Rueil-Malmaison');
insert into hopital (nom,departement,ville) values('Clinique Internationale du Parc Monceau',75,'Paris 17');
insert into hopital (nom,departement,ville) values('Clinique du Trocadéro S.A.S. Clinique Paul Doumer',75,'Paris 16');
insert into hopital (nom,departement,ville) values('Clinique Marcel Sembat CCBB (Ramsay - Générale de Santé)',92,'Boulogne-Billancourt');
insert into hopital (nom,departement,ville) values('Clinique Médico-Chirurgicale Les Fontaines',77,'Melun');
insert into hopital (nom,departement,ville) values('Clinique de l''Estrée (Elsan)',93,'Stains');
insert into hopital (nom,departement,ville) values('Clinique Sainte-Thérèse',75,'Paris 17');
insert into hopital (nom,departement,ville) values('Clinique Médicale Laënnec',92,'Malakoff');
insert into hopital (nom,departement,ville) values('Centre de dialyse Diaverum',92,'Levallois-Perret');
insert into hopital (nom,departement,ville) values('Centre d''Hémodialyse DIAVERUM',77,'Montereau-Fault-Yonne');
insert into hopital (nom,departement,ville) values('Clinique de La Maye (Ramsay - Générale de Santé)',78,'Versailles');
insert into hopital (nom,departement,ville) values('Clinique Saint-Louis (Elsan)',78,'Poissy');
insert into hopital (nom,departement,ville) values('Korian Hôpital des Courses',78,'Maisons-Laffitte');
insert into hopital (nom,departement,ville) values('Clinique Sainte-Isabelle',92,'Neuilly-sur-Seine');
insert into hopital (nom,departement,ville) values('Hôpital Privé du Vert Galant (Ramsay - Générale de Santé)',93,'Tremblay-en-France');
insert into hopital (nom,departement,ville) values('Clinique du Mont-Louis',75,'Paris 11');
insert into hopital (nom,departement,ville) values('Clinique Lambert (Ramsay - Générale de Santé)',92,'La Garenne-Colombes');
insert into hopital (nom,departement,ville) values('Centre d''Hémodialyse DIAVERUM',77,'Montereau-Fault-Yonne');
insert into hopital (nom,departement,ville) values('Hôpital Privé de l''Est Parisien (Ramsay - Générale de Santé)',93,'Aulnay-sous-Bois');
insert into hopital (nom,departement,ville) values('Clinique Pasteur (DomusCliniques)',91,'Ris-Orangis');
insert into hopital (nom,departement,ville) values('Clinique de l''Estrée (Elsan)',93,'Stains');
insert into hopital (nom,departement,ville) values('Clinique de la Dhuys',93,'Bagnolet');
insert into hopital (nom,departement,ville) values('Centre de dialyse Alfadial',77,'Avon');
insert into hopital (nom,departement,ville) values('Clinique Maussins-Nollet (Ramsay - Générale de Santé)',75,'Paris 19');
insert into hopital (nom,departement,ville) values('Centre de Médecine Nucléaire Paris Nord',95,'Sarcelles');
insert into hopital (nom,departement,ville) values('Clinique du Trocadéro S.A.S. Clinique Paul Doumer',75,'Paris 16');
insert into hopital (nom,departement,ville) values('Clinique de La Muette (Ramsay - Générale de Santé)',75,'Paris 16');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Privé de l''Europe',78,'Le Port-Marly');
insert into hopital (nom,departement,ville) values('Clinique du Parisis Groupe Sainte Marie',95,'Cormeilles-en-Parisis');
insert into hopital (nom,departement,ville) values('Centre Gératrique Denis Forestier',78,'La Verrière');
insert into hopital (nom,departement,ville) values('Clinique Vauban',93,'Livry-Gargan');
insert into hopital (nom,departement,ville) values('Polyclinique de la Région Mantaise',78,'Mantes-la-Jolie');
insert into hopital (nom,departement,ville) values('Centre Médico-Chirurgical Floréal',93,'Bagnolet');
insert into hopital (nom,departement,ville) values('Centre Cardiologique du Nord - Porte de Paris',93,'Saint-Denis');
insert into hopital (nom,departement,ville) values('Hôpital Privé de Vitry - Clinique des Noriets (Elsan)',94,'Vitry-sur-Seine');
insert into hopital (nom,departement,ville) values('Hôpital Privé de Marne Chantereine (Ramsay - Générale de Santé)',77,'Brou-sur-Chantereine');
insert into hopital (nom,departement,ville) values('Clinique du Landy (Ramsay - Générale de Santé)',93,'Saint-Ouen');
insert into hopital (nom,departement,ville) values('Clinique de Bercy',94,'Charenton-le-Pont');
insert into hopital (nom,departement,ville) values('Centre Cardiologique d''Evecquemont',78,'Évecquemont');
insert into hopital (nom,departement,ville) values('Pôle de Santé du Plateau',92,'Meudon');
insert into hopital (nom,departement,ville) values('Clinique Saint-Jean-L''Ermitage',77,'Dammarie-les-Lys');
insert into hopital (nom,departement,ville) values('Clinique La Montagne (Ramsay - Générale de Santé)',92,'Courbevoie');
insert into hopital (nom,departement,ville) values('Clinique Internationale du Parc Monceau',75,'Paris 17');
insert into hopital (nom,departement,ville) values('Clinique Les Charmilles - Hôpital Privé de Paris Essonne',91,'Arpajon');
insert into hopital (nom,departement,ville) values('Hôpital Privé de Marne Chantereine (Ramsay - Générale de Santé)',77,'Brou-sur-Chantereine');
insert into hopital (nom,departement,ville) values('Clinique du Mousseau (Ramsay - Générale de Santé)',91,'Évry');
insert into hopital (nom,departement,ville) values('CLINEA - Clinique La Concorde',94,'Alfortville');
insert into hopital (nom,departement,ville) values('Clinique du Trocadéro S.A.S. Clinique Paul Doumer',75,'Paris 16');
insert into hopital (nom,departement,ville) values('Hôpital Privé d’Athis-Mons - Site Jules Vallès',91,'Athis-Mons');
insert into hopital (nom,departement,ville) values('Centre de Médecine Nucléaire et de TEP',95,'Eaubonne');
insert into hopital (nom,departement,ville) values('Hôpital Privé d’Athis-Mons - Site Caron',91,'Athis-Mons');
insert into hopital (nom,departement,ville) values('Clinique d''Esthétique Chirurgicale Alphand',75,'Paris 16');
insert into hopital (nom,departement,ville) values('Clinique Claude Bernard',95,'Ermont');
insert into hopital (nom,departement,ville) values('Clinique du Val-d''Or',92,'Saint-Cloud');
insert into hopital (nom,departement,ville) values('Pôle de Santé du Plateau',92,'Meudon');
insert into hopital (nom,departement,ville) values('Clinique du Louvre',75,'Paris 01');
insert into hopital (nom,departement,ville) values('Clinique du Mont-Louis',75,'Paris 11');
insert into hopital (nom,departement,ville) values('Clinique du Landy (Ramsay - Générale de Santé)',93,'Saint-Ouen');
insert into hopital (nom,departement,ville) values('Hôpital Privé de l''Est Parisien (Ramsay - Générale de Santé)',93,'Aulnay-sous-Bois');
insert into hopital (nom,departement,ville) values('Clinique de l''Alma',75,'Paris 07');
insert into hopital (nom,departement,ville) values('Clinique Les Jardins de Brunoy (DomusCliniques)',91,'Brunoy');
insert into hopital (nom,departement,ville) values('Clinique du Parisis Groupe Sainte Marie',95,'Cormeilles-en-Parisis');
insert into hopital (nom,departement,ville) values('Centre d''Hémodialyse DIAVERUM',77,'Montereau-Fault-Yonne');
insert into hopital (nom,departement,ville) values('Clinique Jeanne d''Arc',75,'Paris 13');
insert into hopital (nom,departement,ville) values('Maison de Chirurgie Clinique Turin',75,'Paris 08');
insert into hopital (nom,departement,ville) values('Clinique Saint-Louis (Elsan)',78,'Poissy');
insert into hopital (nom,departement,ville) values('Centre de dialyse Diaverum',92,'Levallois-Perret');
insert into hopital (nom,departement,ville) values('Hôpital Privé d''Antony (Ramsay - Générale de Santé)',92,'Antony');
insert into hopital (nom,departement,ville) values('Clinique Médico-Chirurgicale Les Fontaines',77,'Melun');
insert into hopital (nom,departement,ville) values('Clinique du Souffle Paris Clinique Milan',75,'Paris 09');
insert into hopital (nom,departement,ville) values('Centre Chirurgical Ambroise Paré',92,'Neuilly-sur-Seine');
insert into hopital (nom,departement,ville) values('Clinique Nescens Paris Spontini',75,'Paris 16');
insert into hopital (nom,departement,ville) values('Hôpital Privé de Vitry - Clinique des Noriets (Elsan)',94,'Vitry-sur-Seine');
insert into hopital (nom,departement,ville) values('Clinique Conti (Elsan)',95,'L''Isle-Adam');
insert into hopital (nom,departement,ville) values('Polyclinique du Plateau (Ramsay - Générale de Santé)',95,'Bezons');
insert into hopital (nom,departement,ville) values('Centre de dialyse Alfadial',77,'Avon');
insert into hopital (nom,departement,ville) values('Clinique de l''Essonne',91,'Évry');
insert into hopital (nom,departement,ville) values('Clinique Jouvenet (Ramsay - Générale de Santé)',75,'Paris 16');
insert into hopital (nom,departement,ville) values('Clinique Les Charmilles - Hôpital Privé de Paris Essonne',91,'Arpajon');
insert into hopital (nom,departement,ville) values('Clinique Les Martinets (Ramsay - Générale de Santé)',92,'Rueil-Malmaison');
insert into hopital (nom,departement,ville) values('Centre Cardiologique du Nord',93,'Saint-Denis');
insert into hopital (nom,departement,ville) values('Clinique Médicale Laënnec',92,'Malakoff');
insert into hopital (nom,departement,ville) values('Hôpital Privé de l''Est Parisien (Ramsay - Générale de Santé)',93,'Aulnay-sous-Bois');
insert into hopital (nom,departement,ville) values('Clinique du Souffle Paris Clinique Milan',75,'Paris 09');
insert into hopital (nom,departement,ville) values('Centre Cardiologique du Nord - Porte de Paris',93,'Saint-Denis');
insert into hopital (nom,departement,ville) values('Korian Hôpital des Courses',78,'Maisons-Laffitte');
insert into hopital (nom,departement,ville) values('Clinique du Parisis Groupe Sainte Marie',95,'Cormeilles-en-Parisis');
insert into hopital (nom,departement,ville) values('Centre de dialyse Diaverum',92,'Levallois-Perret');
insert into hopital (nom,departement,ville) values('Clinique Paris V (Ramsay - Générale de Santé)',75,'Paris 05');
insert into hopital (nom,departement,ville) values('Clinique des Lilas',93,'Les Lilas');
insert into hopital (nom,departement,ville) values('Clinique Claude Bernard',95,'Ermont');
insert into hopital (nom,departement,ville) values('Clinique Blomet (Ramsay - Générale de Santé)',75,'Paris 15');
insert into hopital (nom,departement,ville) values('Clinique Maussins-Nollet (Ramsay - Générale de Santé)',75,'Paris 19');
insert into hopital (nom,departement,ville) values('Clinique Vauban',93,'Livry-Gargan');
insert into hopital (nom,departement,ville) values('Hôpital Privé de Parly II Le Chesnay (Ramsay - Générale de Santé)',78,'Le Chesnay');
insert into hopital (nom,departement,ville) values('Polyclinique de Villeneuve-Saint-Georges (Ramsay - Générale de Santé)',94,'Villeneuve-Saint-Georges');
insert into hopital (nom,departement,ville) values('Clinique de Bercy',94,'Charenton-le-Pont');
insert into hopital (nom,departement,ville) values('Pôle de Santé du Plateau',92,'Meudon');
insert into hopital (nom,departement,ville) values('Hôpital Privé Paul d''Egine (Ramsay - Générale de Santé)',94,'Champigny-sur-Marne');
insert into hopital (nom,departement,ville) values('Hôpital Privé de l''Ouest Parisien (Ramsay - Générale de Santé)',78,'Trappes');
insert into hopital (nom,departement,ville) values('Hôpital Privé de Marne la Vallée (Ramsay - Générale de Santé)',94,'Bry-sur-Marne');
insert into hopital (nom,departement,ville) values('Centre Gératrique Denis Forestier',78,'La Verrière');
insert into hopital (nom,departement,ville) values('linique Médico-Chirurgicale Les Fontaines',77,'Melun');
insert into hopital (nom,departement,ville) values('Clinique Vauban',93,'Livry-Gargan');
insert into hopital (nom,departement,ville) values('Hôpital Privé d''Antony (Ramsay - Générale de Santé)',92,'Antony');
insert into hopital (nom,departement,ville) values('Centre de Consultations Chirurgicales des Gresillons',92,'Gennevilliers');
insert into hopital (nom,departement,ville) values('Clinique Hartmann',92,'Neuilly-sur-Seine');
insert into hopital (nom,departement,ville) values('Maison Médicale Jeanne Garnier',75,'Paris 15');
insert into hopital (nom,departement,ville) values('Institut Arthur Vernes',75,'Paris 06');
insert into hopital (nom,departement,ville) values('Institut Mutualiste Montsouris',75,'Paris 14');
insert into hopital (nom,departement,ville) values('Hôpital Cognacq-Jay',75,'Paris 15');
insert into hopital (nom,departement,ville) values('Hôpital Nord 92',92,'Villeneuve-la-Garenne');
insert into hopital (nom,departement,ville) values('Hôpital de Jour l''Etincelle CRF',75,'Paris 18');
insert into hopital (nom,departement,ville) values('Institut Hospitalier Franco-Britannique (IHFB)',92,'Levallois-Perret');
insert into hopital (nom,departement,ville) values('Groupe Hospitalier Diaconesses - Croix Saint-Simon - Site Reuilly',75,'Paris 12');
insert into hopital (nom,departement,ville) values('Polyclinique de la Forêt Groupe Saint Gatien',77,'Fontainebleau');
insert into hopital (nom,departement,ville) values('Hôpital Léopold Bellan',75,'Paris 14');
insert into hopital (nom,departement,ville) values('Hôpital Jean Jaurès',75,'Paris 19');
insert into hopital (nom,departement,ville) values('Hôpital Américain de Paris',92,'Neuilly-sur-Seine');
insert into hopital (nom,departement,ville) values('Maison Médicale Notre Dame du Lac',92,'Rueil-Malmaison');
insert into hopital (nom,departement,ville) values('AURA (Association pour l''Utilisation du Rein Artificiel)',75,'Paris 15');
insert into hopital (nom,departement,ville) values('Hôpital Saint-Camille',94,'Bry-sur-Marne');
insert into hopital (nom,departement,ville) values('Polyclinique d''Aubervilliers',93,'Aubervilliers');
insert into hopital (nom,departement,ville) values('Hôpital Forcilles, Hôpital Privé ESPIC',77,'Férolles-Attilly');
insert into hopital (nom,departement,ville) values('Maternité Sainte-Félicité',75,'Paris 15');
insert into hopital (nom,departement,ville) values('Centre Hospitalier de Bligny',91,'Briis-sous-Forges');
insert into hopital (nom,departement,ville) values('Fondation Ophtalmologique Adolphe de Rothschild',75,'Paris 19');
insert into hopital (nom,departement,ville) values('Hôpital d''Instruction des Armées du Val de Grâce',75,'Paris 05');
insert into hopital (nom,departement,ville) values('Hôpital des Gardiens de la Paix',75,'Paris 13');
insert into hopital (nom,departement,ville) values('Centre de Gérontologie Henry Dunant',75,'Paris 16');
insert into hopital (nom,departement,ville) values('Maternité des Lilas',93,'Les Lilas');
insert into hopital (nom,departement,ville) values('Hôpital La Porte Verte',78,'Versailles');
insert into hopital (nom,departement,ville) values('Hôpital La Porte Verte',78,'Versailles');
insert into hopital (nom,departement,ville) values('Hôpital Saint-Jean',92,'Gennevilliers');
insert into hopital (nom,departement,ville) values('Institut Curie',75,'Paris 05');
insert into hopital (nom,departement,ville) values('Hôpital des Gardiens de la Paix',75,'Paris 13');
insert into hopital (nom,departement,ville) values('Hôpital Foch',92,'Suresnes');
insert into hopital (nom,departement,ville) values('Groupe Hospitalier Paris Saint-Joseph',75,'Paris 14');
insert into hopital (nom,departement,ville) values('Unité de Psycho-Gériatrie Piaget - Hôpital Simone Veil',95,'Eaubonne');
insert into hopital (nom,departement,ville) values('Centre Hospitalier',95,'Gonesse');
insert into hopital (nom,departement,ville) values('Hôpitaux Universitaires Paris Seine-Saint-Denis - Hôpital Avicenne (AP-HP)',93,'Bobigny');
insert into hopital (nom,departement,ville) values('Groupe Hospitalier Cochin - Saint-Vincent de Paul (A.P.-H.P.) - Hôpital Cochin',75,'Paris 14');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Intercommunal de Meulan - Les Mureaux',78,'Les Mureaux');
insert into hopital (nom,departement,ville) values('Hôpitaux Universitaires Paris-Sud, Hôpital Bicêtre (AP-HP)',94,'Le Kremlin-Bicêtre');
insert into hopital (nom,departement,ville) values('Hôtel-Dieu de Paris (AP-HP)',75,'Paris 04');
insert into hopital (nom,departement,ville) values('Centre Hospitalier de Meaux',77,'Meaux');
insert into hopital (nom,departement,ville) values('Hôpital de Jour Gériatrique',95,'Eaubonne');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Spécialisé Roger Prévot',95,'Moisselles');
insert into hopital (nom,departement,ville) values('Unité Fonctionnelle Psychiatrie Adultes',75,'Paris 06');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Intercommunal de Meulan - Les Mureaux',78,'Meulan');
insert into hopital (nom,departement,ville) values('Centre de Chirurgie Esthétique Paris-Ouest',92,'Courbevoie');
insert into hopital (nom,departement,ville) values('Centre Hospitalier de Melun',77,'Melun');
insert into hopital (nom,departement,ville) values('Centre Hospitalier de Rambouillet',78,'Rambouillet');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Intercommunal de Villeneuve-Saint-Georges Lucie et Raymond Aubrac',94,'Villeneuve-Saint-Georges');
insert into hopital (nom,departement,ville) values('Groupe Hospitalier Broca - La Rochefoucauld (AP-HP) - Hôpital Broca - Centre de Gérontologie Clinique',75,'Paris 13');
insert into hopital (nom,departement,ville) values('Centre Hospitalier d''Orsay',91,'Orsay');
insert into hopital (nom,departement,ville) values('Centre Hospitalier de Juvisy-sur-Orge',91,'Juvisy-sur-Orge');
insert into hopital (nom,departement,ville) values('Hôpital Paul Brousse (AP-HP)',94,'Villejuif');
insert into hopital (nom,departement,ville) values('Groupe Hospitalier Necker Enfants Malades (AP-HP)',75,'Paris 15');
insert into hopital (nom,departement,ville) values('Hôpital Emile Roux - Rattaché au Groupe Hospitalier Hôpitaux Universitaires Henri Mondor (AP-HP)',94,'Limeil-Brévannes');
insert into hopital (nom,departement,ville) values('Centre Hospitalier',78,'Houdan');
insert into hopital (nom,departement,ville) values('Centre Hospitalier les Murets',94,'La Queue-en-Brie');
insert into hopital (nom,departement,ville) values('Groupe Public de Santé Perray-Vaucluse',91,'Épinay-sur-Orge');
insert into hopital (nom,departement,ville) values('Centre Hospitalier de Juvisy-sur-Orge',91,'Juvisy-sur-Orge');
insert into hopital (nom,departement,ville) values('Centre Hospitalier de Saint-Denis - Hôpital Delafontaine',93,'Saint-Denis');
insert into hopital (nom,departement,ville) values('Hôpitaux Universitaires Paris-Sud, Hôpital Bicêtre (AP-HP)',94,'Le Kremlin-Bicêtre');
insert into hopital (nom,departement,ville) values('Hôpital Saint-Antoine (AP-HP)',75,'Paris 12');
insert into hopital (nom,departement,ville) values('Centre Hospitalier de Rambouillet',78,'Rambouillet');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Sud Francilien (CHSF)',91,'Corbeil-Essonnes');
insert into hopital (nom,departement,ville) values('Hôpitaux de Saint-Maurice',94,'Saint-Maurice');
insert into hopital (nom,departement,ville) values('Institution Nationale des Invalides',75,'Paris 07');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Courbevoie Neuilly-sur-Seine',92,'Courbevoie');
insert into hopital (nom,departement,ville) values('Hôpital La Rochefoucauld (AP-HP)',75,'Paris 14');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Intercommunal de Poissy-Saint-Germain-en-Laye',78,'Saint-Germain-en-Laye');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Intercommunal de Meulan - Les Mureaux',78,'Les Mureaux');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Victor Dupouy',95,'Argenteuil');
insert into hopital (nom,departement,ville) values('Groupe Hospitalier Broca - La Rochefoucauld (AP-HP) - Hôpital Broca - Centre de Gérontologie Clinique',75,'Paris 13');
insert into hopital (nom,departement,ville) values('Centre Hospitalier',95,'Gonesse');
insert into hopital (nom,departement,ville) values('Hôpitaux Universitaires Paris Ile de France Ouest - Site Sainte Périne (A.P. - H.P.)',75,'Paris 16');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Chaville, Ville d''Avray, St-Cloud Jean Rostand',92,'Sèvres');
insert into hopital (nom,departement,ville) values('Hôpital Raymond Poincaré (AP-HP)',92,'Garches');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Intercommunal de Meulan - Les Mureaux',78,'Meulan');
insert into hopital (nom,departement,ville) values('Etablissement Public de Santé de Ville Evrard',93,'Neuilly-sur-Marne');
insert into hopital (nom,departement,ville) values('Hôpital Emile Roux - Rattaché au Groupe Hospitalier Hôpitaux Universitaires Henri Mondor (AP-HP)',94,'Limeil-Brévannes');
insert into hopital (nom,departement,ville) values('Centre Hospitalier les Murets',94,'La Queue-en-Brie');
insert into hopital (nom,departement,ville) values('Groupe Hospitalier Necker Enfants Malades (AP-HP)',75,'Paris 15');
insert into hopital (nom,departement,ville) values('Fondation Vallée, Hôpital Public de Pédopsychiatrie',94,'Gentilly');
insert into hopital (nom,departement,ville) values('Centre Hospitalier de Marne-la-Vallée',77,'Jossigny');
insert into hopital (nom,departement,ville) values('Hôtel-Dieu de Paris (AP-HP)',75,'Paris 04');
insert into hopital (nom,departement,ville) values('Hôpital Paul Brousse (AP-HP)',94,'Villejuif');
insert into hopital (nom,departement,ville) values('Hôpital Le Parc',95,'Taverny');
insert into hopital (nom,departement,ville) values('Hôpital Robert Debré (AP-HP)',75,'Paris 19');
insert into hopital (nom,departement,ville) values('Centre Hospitalier de Melun',77,'Melun');
insert into hopital (nom,departement,ville) values('Hôpital Antoine Beclère AP-HP',92,'Clamart');
insert into hopital (nom,departement,ville) values('Centre Hospitalier de Rambouillet',78,'Rambouillet');
insert into hopital (nom,departement,ville) values('Centre Hospitalier',77,'Brie-Comte-Robert');
insert into hopital (nom,departement,ville) values('Centre Hospitalier du Sud Seine-et-Marne',77,'Fontainebleau');
insert into hopital (nom,departement,ville) values('Centre Hospitalier de Meaux',77,'Meaux');
insert into hopital (nom,departement,ville) values('Centre de Chirurgie Esthétique Paris-Ouest',92,'Courbevoie');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Sud Francilien (CHSF)',91,'Corbeil-Essonnes');
insert into hopital (nom,departement,ville) values('Hôpitaux Universitaires Paris Seine-Saint-Denis - Hôpital Avicenne (AP-HP)',93,'Bobigny');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Intercommunal de Villeneuve-Saint-Georges Lucie et Raymond Aubrac',94,'Villeneuve-Saint-Georges');
insert into hopital (nom,departement,ville) values('Centre Hospitalier National d''Ophtalmologie des Quinze-Vingts',75,'Paris 12');
insert into hopital (nom,departement,ville) values('Centre Hospitalier de la Mauldre - Site Saint Louis',78,'Jouars-Pontchartrain');
insert into hopital (nom,departement,ville) values('Centre Hospitalier de Jouarre',77,'Jouarre');
insert into hopital (nom,departement,ville) values('Groupe Hospitalier Hôpitaux Universitaires Henri Mondor (AP-HP)',94,'Créteil');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Intercommunal de Meulan - Les Mureaux',78,'Meulan');
insert into hopital (nom,departement,ville) values('Hôpital Rothschild (AP-HP)',75,'Paris 12');
insert into hopital (nom,departement,ville) values('Hôpitaux Universitaires Paris Ile de France Ouest - Site Sainte Périne (A.P. - H.P.)',75,'Paris 16');
insert into hopital (nom,departement,ville) values('Hôpital Européen Georges-Pompidou (AP-HP)',75,'Paris 15');
insert into hopital (nom,departement,ville) values('Etablissement Public de Santé de Ville Evrard',93,'Neuilly-sur-Marne');
insert into hopital (nom,departement,ville) values('Hôpital Saint-Antoine (AP-HP)',75,'Paris 12');
insert into hopital (nom,departement,ville) values('Groupe Hospitalier Universitaire Saint-Louis - Lariboisière - Fernand Widal, Hôpital Fernand-Widal (AP-HP)',75,'Paris 10');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Intercommunal André Grégoire',93,'Montreuil');
insert into hopital (nom,departement,ville) values('Groupe Hospitalier Saint-Louis - Lariboisière - Fernand Widal, Hôpital Lariboisière (AP-HP)',75,'Paris 10');
insert into hopital (nom,departement,ville) values('Centre Hospitalier d''Orsay',91,'Orsay');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Intercommunal des Quatre Villes',92,'Saint-Cloud');
insert into hopital (nom,departement,ville) values('Centre Hospitalier de Courbevoie - Neuilly-sur-Seine',92,'Neuilly-sur-Seine');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Intercommunal de Meulan - Les Mureaux',78,'Les Mureaux');
insert into hopital (nom,departement,ville) values('Etablissement Public de Santé National',94,'Fresnes');
insert into hopital (nom,departement,ville) values('Hôpital Robert Debré (AP-HP)',75,'Paris 19');
insert into hopital (nom,departement,ville) values('Etablissement Public Gérontologique de Tournan EHPAD',77,'Tournan-en-Brie');
insert into hopital (nom,departement,ville) values('Centre Hospitalier National d''Ophtalmologie des Quinze-Vingts',75,'Paris 12');
insert into hopital (nom,departement,ville) values('Hôpital Général (et Service Hospitalier Frédéric Joliot)',91,'Orsay');
insert into hopital (nom,departement,ville) values('Hôpital La Rochefoucauld (AP-HP)',75,'Paris 14');
insert into hopital (nom,departement,ville) values('Etablissement Public de Santé de Ville Evrard',93,'Neuilly-sur-Marne');
insert into hopital (nom,departement,ville) values('Groupement Hospitalier Intercommunal du Vexin',95,'Magny-en-Vexin');
insert into hopital (nom,departement,ville) values('Hôpital Tenon (AP-HP)',75,'Paris 20');
insert into hopital (nom,departement,ville) values('Groupe Hospitalier Hôpitaux Universitaires Henri Mondor (AP-HP)',94,'Créteil');
insert into hopital (nom,departement,ville) values('Unité Fonctionnelle Psychiatrie Adultes',75,'Paris 06');
insert into hopital (nom,departement,ville) values('Hôpital Saint-Antoine (AP-HP)',75,'Paris 12');
insert into hopital (nom,departement,ville) values('Hôpital Simone Veil',95,'Montmorency');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Spécialisé Roger Prévot',95,'Moisselles');
insert into hopital (nom,departement,ville) values('Centre Hospitalier',78,'Houdan');
insert into hopital (nom,departement,ville) values('Groupe Hospitalier Intercommunal Le Raincy-Montfermeil, Site de Montfermeil',93,'Montfermeil');
insert into hopital (nom,departement,ville) values('Centre d''Accueil et de Soins Hospitaliers de Nanterre Hôpital Max Fourestier',92,'Nanterre');
insert into hopital (nom,departement,ville) values('Hôpital Corentin-Celton (AP-HP)',92,'Issy-les-Moulineaux');
insert into hopital (nom,departement,ville) values('Hôpital de Jour Gériatrique',95,'Eaubonne');
insert into hopital (nom,departement,ville) values('Groupe Hospitalier Saint-Louis - Lariboisière - Fernand Widal, Hôpital Lariboisière (AP-HP)',75,'Paris 10');
insert into hopital (nom,departement,ville) values('Groupe Hospitalier Cochin - Saint-Vincent de Paul (A.P.-H.P.) - Hôpital Cochin',75,'Paris 14');
insert into hopital (nom,departement,ville) values('Hôpital Antoine Beclère AP-HP',92,'Clamart');
insert into hopital (nom,departement,ville) values('Institution Nationale des Invalides',75,'Paris 07');
insert into hopital (nom,departement,ville) values('Hôpital Paul Brousse (AP-HP)',94,'Villejuif');
insert into hopital (nom,departement,ville) values('Centre Hospitalier Intercommunal de Meulan - Les Mureaux',78,'Les Mureaux');


