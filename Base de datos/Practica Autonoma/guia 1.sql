--creacion de tablas
CREATE TABLE CLASE(
	clave int NOT NULL UNIQUE,
	tiempo_prest int,
	PRIMARY KEY (clave))
	ON DELETE SET NULL ON UPDATE CASCADE;

CREATE TABLE USUARIO(
	carnet int NOT NULL UNIQUE,
	nombre varchar(20) NOT NULL,
	direccion varchar(20) NOT NULL,
	PRIMARY KEY (carnet))
	ON DELETE SET NULL ON UPDATE CASCADE;

CREATE TABLE LIBRO(
	codigo char(10) NOT NULL UNIQUE,
	autor varchar(20),
	titulo varchar(20) NOT NULL,
	editor varchar(20),
	clase int,
	PRIMARY KEY (codigo),
	FOREIGN KEY (clase) REFERENCES CLASE(clave))
	ON DELETE SET NULL ON UPDATE CASCADE;

CREATE TABLE PRESTAMO(
	codigo char(10),
	carnet int,
	fecha_inicio date,
	fecha_fin date,
	FOREIGN KEY (codigo) REFERENCES LIBRO(codigo),
	FOREIGN KEY (carnet) REFERENCES USUARIO(carnet));

-- insercion de datos
INSERT INTO CLASE (clave,tiempo_prest)
	VALUES (1,2),
	(2,4),
	(3,6);

INSERT INTO USUARIO (carnet,nombre,direccion) 
	VALUES (1111111,'Juan Carlos I','Prat 560'),
	(2222222,'Jaime Duran','Carrera 60'),
	(3333333,'Josefa Perez','Libertad 605');

INSERT INTO LIBRO (codigo,autor,titulo,editor,clase)
	VALUES ('CA110230','ROJAS , MANUEL','HIJO DE LADRO','ALFAGUARA',3),
	('CA110231','ROJAS ,MANUEL','VASO DE LECHE','ALFAGUARA',3),
	('CB1020','ELMASRI, RAME','MACGRAWHILL',1);

INSERT INTO PRESTAMO (codigo,carnet,fecha_inicio,fecha_fin)
	VALUES ('CA110230',2222222,'2011-03-18','2011-03-22'),
	('CA110231',3333333,'2011-03-22','2011-03-23'),
	('CB1020',1111111,'2011-04-10','2011-03-04'),
	('CB1020',2222222,'2011-03-01','2011-03-04');

--consultas

--A basica
	SELECT titulo
	FROM LIBRO,CLASE
	WHERE clave = clase AND tiempo_prest >= 4;

--A anidada
	SELECT titulo
	FROM LIBRO
	WHERE clase IN (
		SELECT clave
		FROM CLASE
		WHERE tiempo_prest >= 4);

--B basica
	SELECT A.carnet,A.nombre,A.direccion
	FROM USUARIO AS A,LIBRO AS B, PRESTAMO AS C
	WHERE B.codigo = C.codigo AND A.carnet = C.carnet AND B.clase = 1;

--B anidada
	SELECT carnet, nombre, direccion
	FROM USUARIO
	WHERE carnet IN(
		SELECT carnet
		FROM PRESTAMO
		WHERE codigo IN (
			SELECT codigo
			FROM LIBRO
			WHERE clase = 1));

--C
	SELECT *
	FROM LIBRO
	WHERE editor LIKE '%AL%';

--D
	SELECT *
	FROM LIBRO
	WHERE editor LIKE '_L%';

--E
	SELECT codigo,carnet
	FROM PRESTAMO
	WHERE fecha_inicio BETWEEN '2011-03-01' AND '2011-03-20';

--F basica
	SELECT titulo
	FROM LIBRO, CLASE
	WHERE clase = clave AND (tiempo_prest BETWEEN 2 AND 6);

--F anidada
	SELECT titulo
	FROM LIBRO
	WHERE clase IN (
		SELECT clave
		FROM CLASE
		WHERE tiempo_prest BETWEEN 2 AND 6);

--G basica
	SELECT A.titulo, B.nombre
	FROM LIBRO AS A,USUARIO AS B,PRESTAMO AS C
	WHERE A.codigo = C.codigo AND B.carnet = C.carnet AND (C.fecha_inicio BETWEEN '2011-01-01' AND '2011-12-31')
	ORDER BY titulo, nombre;

--G anidada
	SELECT titulo,nombre
	FROM LIBRO,USUARIO
	WHERE codigo,carnet IN (
		SELECT codigo,carnet
		FROM PRESTAMO
		WHERE fecha_inicio BETWEEN '2011-01-01' AND '2011-12-31');