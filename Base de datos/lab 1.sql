--crecion de tablas
CREATE TABLE especies(
	sno INT NOT NULL UNIQUE,
	nombre VARCHAR(30),
	alimento VARCHAR(40),
	PRIMARY KEY (sno));

CREATE TABLE eventos(
	eno INT NOT NULL UNIQUE,
	fecha DATE,
	pno INT,
	PRIMARY KEY (eno), 
	FOREIGN KEY pno REFERENCES peces;

CREATE TABLE tanques(
	tno INT NOT NULL UNIQUE,
	nombre_tanque VARCHAR(20),
	color_tanque VARCHAR(20),
	volumen INT,
	PRIMARY KEY(tno));

CREATE TABLE peces(
	pno INT NOT NULL UNIQUE,
	nombre_peces VARCHAR(20),
	color_peces VARCHAR(20),
	tno INT NOT NULL,
	sno INT NOT NULL,
	PRIMARY KEY(pno),
	FOREIGN KEY(tno) REFERENCES tanques,
	FOREIGN KEY(sno) REFERENCES especies);

--insercion de tuplas
INSERT INTO especies 
	VALUES (sno,nombre,alimento),
	(17,'delfin','arenque'),
	(22,'tiburon','cualquier cosa'),
	(74,'olomina','gusano'),
	(93,'ballena','mantequilla de mani'),
	(100,'pez espada','gusano'),
	(120,'pez globo','gusano');

INSERT INTO tanques
	VALUES(tno,nombre_tanque,color_tanque,volumen),
	(55,'charco','verde',300),
	(42,'letrina','azul',100),
	(35,'laguna','rojo',400),
	(85,'letrina','azul',100),
	(38,'playa','azul',200),
	(44,'laguna','verde',200);

INSERT INTO peces
	VALUES(pno,nombre_peces,color_peces,tno,sno),
	(164,'charlie','naranjo',42,74),
	(347,'flipper','negro',35,17),
	(228,'killer','blanco',52,22),
	(281,'albert','rojo',55,17),
	(119,'bonnie','azul',42,22),
	(388,'cory','morado',35,93),
	(700,'maureen','blanco',44,100),
	(800,'beni','rojo',55,17),
	(900,'nemo','rojo',44,74),
	(150,'vicky','rojo',55,100),
	(160,'mati','amarillo',41,100);

INSERT INTO eventos
	VALUES(eno,pno,fecha),
	(3456,347,'2010-10-26'),
	(6653,164,'2010-05-14'),
	(5644,347,'2010-05-15'),
	(5645,347,'2010-05-30'),
	(6789,281,'2010-04-30'),
	(5211,228,'2010-08-20'),
	(6719,700,'2010-10-22');

--borrado de tuplas
DELETE FROM peces WHERE color_peces='naranjo';
DELETE FROM peces WHERE nombre_peces='charlie';

--consultas

SELECT nombre
FROM especies
WHERE sno > 70;

SELECT nombre
FROM especies
WHERE alimento ='gusano';

SELECT nombre
FROM peces
WHERE color_peces = 'amarillo';

SELECT color_tanque
FROM tanques
WHERE nombre_tanque = 'letrina'

SELECT nombre
FROM tanques
WHERE color_tanque = 'rojo';

SELECT nombre_peces
FROM peces
WHERE sno = 10;

SELECT pno,nombre_peces, color_peces
FROM peces
WHERE sno IN (
	SELECT sno
	FROM especies
	WHERE alimento = 'gusano');

SELECT nombre
FROM especies
WHERE sno IN(
	SELECT sno
	FROM peces
	WHERE pno IN(
		SELECT pno
		FROM eventos
		WHERE fecha BETWEEN '2010-04-01' AND '2010-05-31'));

SELECT pno,nombre_peces,color_peces
FROM peces
WHERE pno,tno IN(
	SELECT pno,tno
	FROM eventos,tanques
	WHERE color_tanque = 'verde');

SELECT tno,nombre_tanque
FROM tanques
WHERE tno IN (
	SELECT tno
	FROM peces
	WHERE color_peces = 'azul' OR color_peces = 'rojo');

--11
SELECT pno,nombre_peces
FROM peces
WHERE sno IN(
	SELECT sno
	FROM especies
	WHERE alimento = 'gusano' AND )