USE projetoc;

-- Chargement des données du fichier type_bien.

LOAD DATA LOCAL INFILE 'D:/Documents/Etudes/OpenClassrooms/P3/V2/type_bien.csv'
	INTO TABLE type_bien
	FIELDS
		TERMINATED BY ';'
	LINES
		TERMINATED BY '\r\n'
	IGNORE 1 LINES
	(code_type_local, type_local);

-- Chargement des données du fichier localisation.

LOAD DATA LOCAL INFILE 'D:/Documents/Etudes/OpenClassrooms/P3/V2/localisation.csv'
	INTO TABLE localisation
	FIELDS
		TERMINATED BY ';'
	LINES
		TERMINATED BY '\r\n'
	IGNORE 1 LINES
	(id_localisation, code_commune, code_dep, commune);

-- Chargement des données du fichier bien.

LOAD DATA LOCAL INFILE 'D:/Documents/Etudes/OpenClassrooms/P3/V2/bien.csv'
	INTO TABLE bien
	FIELDS
		TERMINATED BY ';'
	LINES
		TERMINATED BY '\r\n'
	IGNORE 1 LINES
	(id_bien, code_type_local, surface_carrez, nb_piece, id_localisation);

-- Chargement des données du fichier vente.

LOAD DATA LOCAL INFILE 'D:/Documents/Etudes/OpenClassrooms/P3/V2/vente.csv'
	INTO TABLE vente
	FIELDS
		TERMINATED BY ';'
	LINES
		TERMINATED BY '\r\n'
	IGNORE 1 LINES
	(id_vente, date_mut, val_fon, id_bien);