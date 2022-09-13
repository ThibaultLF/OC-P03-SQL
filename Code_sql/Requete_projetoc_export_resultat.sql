-- Requête demandée pour le projet 3 d'OC

USE projetoc;

SET @@SESSION.CHARACTER_SET_CLIENT='utf8'; -- Permet de prendre en compte les accents

-- 1. Nombre total d'appartements vendus au 1er semestre 2020.


-- On rajoute les noms des colonnes avec une UNION.

SELECT 'Nombre d\'appartements vendus'
UNION ALL
SELECT COUNT(DISTINCT id_bien) AS 'Nombre d\'appartement vendus' FROM vente
JOIN bien USING(id_bien)
JOIN type_bien USING(code_type_local)
WHERE type_local = 'Appartement'
INTO OUTFILE 'D:/Documents/Etudes/OpenClassrooms/P3/Resultats/requete1.csv'
CHARACTER SET 'latin1'
FIELDS
		TERMINATED BY ';'
	LINES
		TERMINATED BY '\r\n';



-- 2. Proportion des ventes d'appartements par le nombre de pièces.




-- Création d'une table temp pour stocké les résultats de la requête et pouvoir l'appeler dans l'union.

CREATE TEMPORARY TABLE IF NOT EXISTS TMP_requete2 
WITH
	total AS (SELECT COUNT(*) AS tot FROM vente JOIN bien USING(id_bien) WHERE code_type_local = 2)
SELECT nb_piece AS 'Nombre de pièces', CONCAT(ROUND((count(*)/tot)*100, 2), ' %') AS 'Proportion des ventes d\'appartements'
FROM vente
JOIN total
JOIN bien USING(id_bien)
WHERE code_type_local = (SELECT code_type_local FROM type_bien WHERE type_local = 'Appartement')
GROUP BY nb_piece
ORDER BY nb_piece;


SELECT 'Nombre de pièces', 'Proportion des ventes d\'appartements'
UNION ALL
SELECT * FROM TMP_requete2
INTO OUTFILE 'D:/Documents/Etudes/OpenClassrooms/P3/Resultats/requete2.csv'
CHARACTER SET 'latin1'
FIELDS
		TERMINATED BY ';'
	LINES
		TERMINATED BY '\r\n';




-- 3. Liste des 10 départements où le prix du mètre carré est le plus élevé.


CREATE TEMPORARY TABLE IF NOT EXISTS TMP_requete3 
SELECT code_dep AS 'Département', ROUND(AVG(val_fon/surface_carrez)) AS prix_m FROM vente 
JOIN bien USING(id_bien) 
JOIN localisation USING(id_localisation) 
WHERE val_fon > 0 
GROUP BY code_dep 
ORDER BY prix_m DESC 
LIMIT 10;

SELECT 'Département', 'prix_m²'
UNION ALL
SELECT * FROM TMP_requete3
INTO OUTFILE 'D:/Documents/Etudes/OpenClassrooms/P3/Resultats/requete3.csv'
CHARACTER SET 'latin1'
FIELDS
		TERMINATED BY ';'
	LINES
		TERMINATED BY '\r\n';



-- 4. Prix moyen du mètre carré d'une maison en île de france.



SELECT 'Prix moyen du m² d\'une maison en IDF'
UNION ALL
SELECT CONCAT(TRUNCATE(AVG(val_fon/surface_carrez), 2), ' €') AS 'Prix moyen du m² d\'une maison en IDF' FROM vente
JOIN bien USING(id_bien)
JOIN localisation USING(id_localisation)
JOIN type_bien USING(code_type_local)
WHERE type_local = 'Maison'
	AND code_dep IN ('75','77','78','91','92','93','94','95') 
	AND val_fon > 0 
INTO OUTFILE 'D:/Documents/Etudes/OpenClassrooms/P3/Resultats/requete4.csv'
CHARACTER SET 'latin1'
FIELDS
		TERMINATED BY ';'
	LINES
		TERMINATED BY '\r\n'; 



-- 5. Liste des 10 appartements les plus chers avec le département et
-- le nombre de mètres carrés.



CREATE TEMPORARY TABLE IF NOT EXISTS TMP_requete5 
SELECT id_bien AS Identifiant, TRUNCATE(val_fon, 0) AS Prix, surface_carrez AS Surface, code_dep AS Département FROM vente
JOIN bien USING(id_bien)
JOIN localisation USING(id_localisation)
WHERE code_type_local = 2
ORDER BY val_fon DESC
LIMIT 10;

SELECT 'Identifiant', 'Prix', 'Surface', 'Département'
UNION ALL
SELECT * FROM TMP_requete5
INTO OUTFILE 'D:/Documents/Etudes/OpenClassrooms/P3/Resultats/requete5.csv'
CHARACTER SET 'latin1'
FIELDS
		TERMINATED BY ';'
	LINES
		TERMINATED BY '\r\n';




-- 6. Taux d'évolution du nombre de ventes entre le premier et le second trimestre de 2020.

CREATE TEMPORARY TABLE IF NOT EXISTS TMP_requete6
WITH
	trim1 AS (SELECT count(*) AS tot_trim1 FROM vente WHERE date_mut BETWEEN '2020-01-01' AND '2020-03-31'),
	trim2 AS (SELECT count(*) AS tot_trim2 FROM vente WHERE date_mut BETWEEN '2020-04-01' AND '2020-06-30')
SELECT tot_trim1 AS 'Vente 1er trimestre', tot_trim2 AS 'Vente 2ème trimestre', CONCAT(ROUND(((tot_trim2/tot_trim1)-1)*100,2), ' %') AS 'Taux d\'évolution' FROM trim1 JOIN trim2;

SELECT 'Vente 1er trimestre', 'Vente 2ème trimestre', 'Taux d\'évolution'
UNION ALL
SELECT * FROM TMP_requete6
INTO OUTFILE 'D:/Documents/Etudes/OpenClassrooms/P3/Resultats/requete6.csv'
CHARACTER SET 'latin1'
FIELDS
		TERMINATED BY ';'
	LINES
		TERMINATED BY '\r\n';




-- 7. Liste des communes où le nombre de ventes a augmenté d'au moins 20% entre le premier et
-- le second trimestre 2020.


WITH 
	-- Nombre de bien vendu au premier semestre par commune
	trim1 AS (SELECT l.id_localisation, l.commune,count(*) AS nb1 FROM vente
				JOIN bien USING(id_bien)
				JOIN localisation AS l USING(id_localisation)
				WHERE date_mut <= '2020-03-31'
				GROUP BY l.id_localisation, l.commune
				ORDER BY l.commune),
	-- Nombre de bien vendu au second semestre par commune
	trim2 AS (SELECT l.id_localisation, l.commune,count(*) AS nb2 FROM vente
				JOIN bien USING(id_bien)
				JOIN localisation AS l USING(id_localisation)
				WHERE date_mut > '2020-03-31'
				GROUP BY l.id_localisation, l.commune
				ORDER BY l.commune),
	cte3 AS (SELECT t.commune, (nb2-nb1)/nb1 AS tx, nb1, nb2 FROM trim1 AS t
				JOIN trim2 USING(id_localisation)),
	cte4 AS (SELECT 'Commune', 'Vente 1er trimestre', 'Vente 2ème trimestre', 'Taux d\'évolution'  UNION ALL SELECT commune, nb1, nb2, CONCAT(ROUND(tx*100), ' %') FROM cte3 WHERE tx>=0.2)
SELECT * FROM cte4
INTO OUTFILE 'D:/Documents/Etudes/OpenClassrooms/P3/Resultats/requete7.csv'
CHARACTER SET 'latin1'
FIELDS
		TERMINATED BY ';'
	LINES
		TERMINATED BY '\r\n';




-- 8. Différence en pourcentage du prix au mètre carré entre un appartement de 2 pièces et
-- un appartement de 3 pièces.



WITH
	cte1 AS (SELECT AVG(val_fon/surface_carrez) AS px2 FROM vente
				JOIN bien USING(id_bien)
                WHERE code_type_local = 2 AND nb_piece =2 AND val_fon > 0),
	cte2 AS (SELECT AVG(val_fon/surface_carrez) AS px3 FROM vente
				JOIN bien USING(id_bien)
                WHERE code_type_local = 2 AND nb_piece =3 AND val_fon > 0),
	cte3 AS (SELECT 'Prix m² 2pièces', 'Prix m² 3 pièces', 'Différence du prix au m² entre un appartement 2 pièces et 3 pièces' UNION ALL SELECT ROUND(px2), ROUND(px3), CONCAT(ROUND(((px3-px2)/px2)*100, 2), ' %') FROM cte1 JOIN cte2)
SELECT * FROM cte3
INTO OUTFILE 'D:/Documents/Etudes/OpenClassrooms/P3/Resultats/requete8.csv'
CHARACTER SET 'latin1'
FIELDS
		TERMINATED BY ';'
	LINES
		TERMINATED BY '\r\n';

	

-- 9. Les moyennes de valeurs foncières pour le top 3 des communes des départements 
-- suivants: 6, 13, 33, 59 et 69.


CREATE TEMPORARY TABLE IF NOT EXISTS TMP_requete9 
WITH
	cte1 AS (SELECT commune, AVG(val_fon) AS px, code_dep FROM vente 
			JOIN bien USING(id_bien)
			JOIN localisation USING(id_localisation)
			WHERE code_dep IN ('6', '13', '33', '59', '69') AND val_fon > 0 
			GROUP BY id_localisation, commune),
	cte2 AS (SELECT *, RANK() OVER(PARTITION BY code_dep ORDER BY px DESC) AS top
			FROM cte1),
	cte3 AS (SELECT code_dep, commune AS Commune, ROUND(px) AS Prix, top FROM cte2 WHERE top <=3) 
SELECT * FROM cte3 ORDER BY FIELD(code_dep, '6', '13', '33', '59', '69');


SELECT 'Département', 'Commune', 'Prix', 'top'
UNION ALL
SELECT * FROM TMP_requete9
INTO OUTFILE 'D:/Documents/Etudes/OpenClassrooms/P3/Resultats/requete9.csv'
CHARACTER SET 'latin1'
FIELDS
		TERMINATED BY ';'
	LINES
		TERMINATED BY '\r\n';


SET @@SESSION.CHARACTER_SET_CLIENT='cp850'; -- On remet les caractères par défaut