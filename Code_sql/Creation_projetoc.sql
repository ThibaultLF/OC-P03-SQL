CREATE DATABASE projetoc;

USE projetoc;


CREATE TABLE type_bien (
                code_type_local TINYINT NOT NULL,
                type_local VARCHAR(20) NOT NULL,
                PRIMARY KEY (code_type_local)
);


CREATE TABLE localisation (
                id_localisation INT AUTO_INCREMENT NOT NULL,
                code_commune INT NOT NULL,
                code_dep CHAR(3) NOT NULL,
                commune VARCHAR(50) NOT NULL,
                PRIMARY KEY (id_localisation)
);


CREATE TABLE bien (
                id_bien INT AUTO_INCREMENT NOT NULL,
                code_type_local TINYINT NOT NULL,
                surface_carrez DECIMAL(8,3) NOT NULL,
                nb_piece SMALLINT NOT NULL,
                id_localisation INT NOT NULL,
                PRIMARY KEY (id_bien)
);


CREATE TABLE vente (
                id_vente INT AUTO_INCREMENT NOT NULL,
                date_mut DATE NOT NULL,
                val_fon DECIMAL(10,2),
                id_bien INT NOT NULL,
                PRIMARY KEY (id_vente)
);


ALTER TABLE bien ADD CONSTRAINT type_bien_bien_fk
FOREIGN KEY (code_type_local)
REFERENCES type_bien (code_type_local)
ON DELETE NO ACTION
ON UPDATE CASCADE;

ALTER TABLE bien ADD CONSTRAINT localisation_bien_fk
FOREIGN KEY (id_localisation)
REFERENCES localisation (id_localisation)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE vente ADD CONSTRAINT bien_vente_fk
FOREIGN KEY (id_bien)
REFERENCES bien (id_bien)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE localisation 
ADD UNIQUE unique_code_commune_code_dep (code_commune, code_dep);

ALTER TABLE bien
ADD UNIQUE unique_all_bien (id_localisation, code_type_local, surface_carrez, nb_piece);