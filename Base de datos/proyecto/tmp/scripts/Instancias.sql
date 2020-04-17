CREATE TABLE Direccion_Cliente(
	ID serial not null unique,
	calle varchar(30)not null,
	ciudad varchar(20) not null,
	PRIMARY KEY(ID));

CREATE TABLE Direccion_Empleado(
	ID serial not null unique,
	calle varchar(30)not null,
	ciudad varchar(20) not null,
	PRIMARY KEY(ID));

CREATE TABLE Direccion_Arriendo(
	ID serial not null unique,
	calle varchar(30) not null,
	ciudad varchar(20) not null,
	PRIMARY KEY(ID));

CREATE TABLE Tipo_Cliente(
	ID serial not null unique,
	nombre varchar(30) not null,
	descuento int not null,
	PRIMARY KEY(ID));

CREATE TABLE Tipo_Maquinaria(
	ID serial not null unique,
	nombre varchar(20) not null,
	PRIMARY KEY(ID));

CREATE TABLE Tipo_Mantencion(
	ID serial not null unique,
	nombre varchar(20) not null,
	PRIMARY KEY(ID));

CREATE TABLE Tipo_Especialidad(
	ID serial not null unique,
	nombre varchar(20) DEFAULT 'sin detalles',
	detalle varchar(100),
	PRIMARY KEY(ID));

CREATE TABLE Contrato(
	ID serial not null unique,
	fecha_inicio date not null,
	fecha_fin date not null,
	salario integer not null,
	PRIMARY KEY (ID));

CREATE TABLE Empleado(
	ID serial not null unique,
	ID_Direccion int not null,
	ID_Contrato int not null,
	nombre varchar(20) not null,
	apellido_p varchar(20) not null,
	apellido_m  varchar(20) not null,
	rut varchar(12) not null,
	telefono int not null,
	fecha_nacimiento date,
	PRIMARY KEY(ID),
	FOREIGN KEY(ID_Direccion) REFERENCES Direccion_Empleado(ID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (ID_Contrato) REFERENCES Contrato(ID) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE Mecanico(
	ID_Empleado int not null unique,
	ID_Tipo_Especialidad int,
	tarifa_por_hora int not null,
	FOREIGN KEY(ID_Empleado) REFERENCES Empleado(ID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(ID_Tipo_Especialidad) REFERENCES Tipo_Especialidad(ID) ON DELETE SET NULL ON UPDATE CASCADE);

CREATE TABLE Administrativo(
	ID_Empleado int not null unique,
	tarifa_por_hora int not null,
	FOREIGN KEY(ID_Empleado) REFERENCES Empleado(ID) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE Operador(
	ID_Empleado int not null unique,
	tarifa_por_hora int not null,
	CHECK(tarifa_por_hora BETWEEN 5000 AND 8000),
	FOREIGN KEY(ID_Empleado) REFERENCES Empleado(ID) ON DELETE CASCADE ON UPDATE CASCADE );

CREATE TABLE Cliente(
	ID serial not null unique,
	ID_Tipo_Cliente int not null,
	ID_Direccion int not null,
	nombre varchar(30) not null,
	apellido_p varchar(20) not null,
	apellido_m  varchar(20) not null,
	telefono int not null,
	rut varchar(12) not null,
	fecha_nacimiento date,
	cant_compras int not null,
	PRIMARY KEY(ID),
	FOREIGN KEY(ID_Direccion) REFERENCES Direccion_Cliente(ID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(ID_Tipo_Cliente) REFERENCES Tipo_Cliente(ID) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE Encargado(
	ID serial not null unique,
	ID_Cliente int not null unique,
	nombre varchar(20) not null,
	apellido_p varchar(20) not null,
	apellido_m  varchar(20) not null,
	telefono integer not null,
	PRIMARY KEY(ID),
	FOREIGN KEY(ID_Cliente) REFERENCES Cliente(ID) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE Estado(
	ID serial not null unique,
	descripcion varchar(100),
	PRIMARY KEY(ID));

CREATE TABLE Arriendo(
	ID serial not null unique,
	ID_Direccion int not null,
	ID_Cliente int not null,
	ID_Estado int not null,
	fecha_inicio date not null,
	fecha_termino date not null,
	horas_arriendo int not null,
	CHECK (horas_arriendo >= 4),
	PRIMARY KEY (ID),
	FOREIGN KEY(ID_Estado) REFERENCES Estado(ID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(ID_Direccion) REFERENCES Direccion_Arriendo(ID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE Maquinaria(
	ID serial not null unique,
	ID_Tipo_Maquinaria int not null,
	marca varchar(12) not null,
	modelo varchar(12) not null,
	patente varchar(12) DEFAULT 'sin patente',
	kilometraje int not null,
	valor_por_hora int not null,
	CHECK(valor_por_hora > 10000),
	PRIMARY KEY(ID),
	FOREIGN KEY(ID_Tipo_Maquinaria) REFERENCES Tipo_Maquinaria(ID) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE Detalle_Arriendo(
	ID serial not null unique,
	ID_Arriendo int not null,
	ID_Operador int,
	ID_Maquinaria int not null,
	valor_total int not null,
	FOREIGN KEY(ID_Arriendo) REFERENCES Arriendo(ID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(ID_Operador) REFERENCES Operador(ID_Empleado) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(ID_Maquinaria) REFERENCES Maquinaria(ID) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE Mantencion(
	ID serial not null unique,
	ID_Maquinaria int not null,
	ID_Tipo_Mantencion int not null,
	ID_Mecanico int not null,
	fecha date not null,
	horas_trabajadas int not null,
	descripcion varchar(100) DEFAULT 'sin descripción',
	PRIMARY KEY(ID),
	FOREIGN KEY(ID_Mecanico) REFERENCES Mecanico(ID_Empleado) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(ID_Maquinaria) REFERENCES Maquinaria(ID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(ID_Tipo_Mantencion) REFERENCES Tipo_Mantencion(ID) ON DELETE CASCADE ON UPDATE CASCADE );

-- ===================
-- Insersion de datos
-- ===================

INSERT INTO Direccion_Cliente (calle,ciudad)
	VALUES ('Cabildo 615','Chillan'),
		('Isabel Riquelme 120','Chillan'),
		('Los Puelches','Los Colihues'),
		('Arturo Prat 590','Chillan'),
		('Claudio Arrau 954','Coihueco'),
		('Gamero 913','Chillan'),
		('5 de abril 670','Chillan'),
		('20 de agosto 1670','Pinto'),
		('Cabildo 1030','Chillan'),
		('Los pericos 570','San Carlos');

INSERT INTO Direccion_Empleado (calle,ciudad)
	VALUES ('Arturo Prat 310','Chillan'),
	('Los Puelches 1958','Chillan'),
	('El Roble 670','Coihueco'),
	('Cabildo 980','Chillan'),
	('Sargento Aldea 650','Chillan'),
	('Antonio Varas 1750','San Carlos'),
	('Baquedano 2050','Pinto'),
	('Los Nogales 1050','Los Colihues'),
	('11 de septiembre','San Carlos'),
	('Los Guindos 2070','Coihueco');

INSERT INTO Direccion_Arriendo (calle,ciudad)
	VALUES ('Arturo Prat 960','San Carlos'),
	('Los Puelches 59','Portezuelo'),
	('El Roble 700','Chillan'),
	('Los Naranjos 940','Chillan'),
	('Circunvalacion 1090','Pinto'),
	('Antonio Varas 50','Chillan'),
	('Las Rosas 1047','Coihueco'),
	('Baquedano 1282','Los Colihues'),
	('Mariano Egaña 150','Chillan'),
	('Conde del Maule 269','Pinto');

INSERT INTO Tipo_Cliente (nombre,descuento)
	VALUES ('Basico',0),
	('Basico',5),
	('Preferencial',10),
	('Preferencial',15),
	('Preferencial',20),
	('Preferencial',25),
	('Preferencial',30),
	('Preferencial',35),
	('Preferencial',40),
	('Preferencial',45),
	('Preferencial',50);

INSERT INTO Tipo_Maquinaria (nombre)
	VALUES ('tractor'),
		('Generador'),
		('Camion'),
		('trillador'),
		('grua'),
		('sembradora'),
		('moto cultivadora'),
		('rotoenfardadora'),
		('cosechadoras'),
		('camioneta');

INSERT INTO Tipo_Mantencion (nombre)
	VALUES ('aceite'),
		('neumaticos'),
		('accesorios internos'),
		('unidad de control'),
		('luces'),
		('frenos'),
		('suspension'),
		('motor'),
		('accesorios externos'),
		('completa');

INSERT INTO Tipo_Especialidad (nombre,detalle)
	VALUES ('Electrico','sin especificar'),
		('Electronico','sin especificar'),
		('Telecomunicador','sin especificar'),
		('Transmision','sin especificar'),
		('Programador CPU','sin especificar'),
		('Accesorios externos','sin especificar'),
		('Frenos','sin especificar'),
		('Suspension','sin especificar'),
		('Mecanico','sin especificar'),
		('Accesorios internos','sin especificar');

INSERT INTO Contrato (fecha_inicio,fecha_fin,salario)
	VALUES ('2018-01-01','2020-12-31',500000),
		('2018-01-01','2022-12-31',500000),
		('2017-01-01','2022-12-31',750000),
		('2015-01-01','2020-12-31',600000),
		('2016-01-01','2022-12-31',500000),
		('2012-01-01','2020-12-31',600000),
		('2015-01-01','2018-12-31',900000),
		('2010-01-01','2020-12-31',1000000),
		('2013-01-01','2023-12-31',1000000),
		('2018-01-01','2020-12-31',500000);

INSERT INTO Empleado (ID_Direccion,ID_Contrato,nombre,apellido_p,apellido_m,rut,telefono,fecha_nacimiento)
	VALUES (1,1,'sin operador','','','',0,'1900-01-01'),
		(1,1,'Juan','Gabriel','Sanchez','181111111',11111111,'1998-06-05'),
		(2,2,'Michelle','Bachelet','Perez','1822222222',22222222,'1990-05-12'),
		(3,3,'Augusto','Pinochet','Lopez','1833333333',33333333,'1990-06-15'),
		(4,4,'Adolf','Hitler','Puga','1844444444',44444444,'1980-06-12'),
		(5,5,'Alan','Osorio','Baeza','1855555555',55555555,'1995-04-12'),
		(6,6,'Bayron','Perez','Martinez','1866666666',66666666,'1992-12-12'),
		(7,7,'Yandel','Perez','Moncada','1877777777',77777777,'1991-05-12'),
		(8,8,'Jhonatan','Moncada','Mendez','1888888888',88888888,'1999-11-12'),
		(9,9,'Yissenia','Moreno','Osorio','1899999999',99999999,'1993-05-12'),
		(10,10,'Patricia','Rojas','Rojas','1812345678',91111111,'1975-10-12');

INSERT INTO Mecanico(ID_Empleado,ID_Tipo_Especialidad,tarifa_por_hora)
	VALUES (2,1,5000),
		(3,7,6000),
		(5,8,5000);

INSERT INTO Administrativo(ID_Empleado,tarifa_por_hora)
	VALUES (2,5000),
		(4,4000),
		(6,3000);

INSERT INTO Operador(ID_Empleado,tarifa_por_hora)
	VALUES (1,5000),
		(7,7000),
		(8,5000),
		(9,5000),
		(10,8000);

INSERT INTO Cliente(ID_Tipo_Cliente,ID_Direccion,nombre,apellido_p,apellido_m,telefono,rut,fecha_nacimiento,cant_compras)
	VALUES (2,1,'Federico','Rojas','Rojas',11111111,'191111111','1990-01-10',0),
		(2,2,'Antonio','Norambuena','Abarca',22222222,'192222222','1989-02-11',0),
		(2,3,'Marcela','Alejandra','Martinez',33333333,'193333333','1992-03-06',0),
		(3,4,'Juliana','Moncada','Perez',44444444,'194444444','1990-02-20',0),
		(4,5,'Joaquin','Moncada','Soto',55555555,'195555555','1991-04-21',0),
		(4,6,'Jose','Moncada','Gonzalez',66666666,'196666666','1995-06-01',0),
		(2,7,'Flor','Cortes','Cisternas',77777777,'197777777','1998-04-02',0),
		(2,8,'Fredy','Moncada','Torres',88888888,'198888888','1985-10-04',0),
		(3,9,'Ignacio','Gutierrez','Luksic',99999999,'199999999','1989-11-07',0),
		(2,10,'Felipe','Soto','Colón',12345678,'191234567','1990-07-29',0);

INSERT INTO Encargado(ID_Cliente,nombre,apellido_p,apellido_m,telefono)
	VALUES (1,'Alan','Moreno','Troncoso',11111111),
		(2,'Pedro','Contreras','Mendez',22222222),
		(3,'Camila','Martinez','Garrido',33333333),
		(7,'Camilo','Moncada','Fernandez',44444444),
		(8,'Alejandra','Martinez','Olave',55555555),
		(9,'Fernando','Fuentes','Milla',66666666),
		(10,'Patricia','Rojas','Henriquez',77777777);

INSERT INTO Estado(descripcion)
	VALUES ('en proceso'),
		('a tiempo'),
		('atrasado'),
		('con desperfecto');

INSERT INTO Arriendo (ID_Direccion,ID_Cliente,ID_Estado,fecha_inicio,fecha_termino,horas_arriendo)
	VALUES (1,1,1,'2018-10-01','2018-10-01',4),
		(2,2,2,'2018-09-29','2018-09-30',24),
		(3,3,2,'2018-10-02','2018-10-02',8),
		(4,4,2,'2018-10-02','2018-10-02',6),
		(5,5,2,'2018-10-03','2018-10-03',10),
		(6,6,2,'2017-01-20','2017-01-20',12),
		(7,7,3,'2017-01-22','2017-01-22',10),
		(8,8,4,'2018-10-20','2018-10-30',240),
		(9,9,3,'2018-09-20','2018-09-20',4),
		(10,10,2,'2018-10-18','2018-10-18',8);

INSERT INTO Maquinaria(ID_Tipo_Maquinaria,marca,modelo,patente,kilometraje,valor_por_hora)
	VALUES (1,'acuenta','abc','aaaaaa',50000,15000),
		(2,'lider','def','sin patente',100000,20000),
		(3,'frog','ghi','cccccc',90000,25000),
		(4,'xxx','jkl','dddddd',80000,30000),
		(5,'jhon deere','mnñ','eeeeee',120000,11000),
		(6,'resident','opq','ffffff',90000,15000),
		(7,'cumnsi','rst','gggggg',100000,30000),
		(8,'super10','uvw','hhhhhh',11000,13000),
		(9,'yyy','xyz','iiiiii',70000,26000),
		(10,'zzz','aab','jjjjjj',130000,35000);

INSERT INTO Detalle_Arriendo(ID_Arriendo,ID_Operador,ID_Maquinaria,valor_total)
	VALUES (1,1,1,180000),
		(2,1,2,480000),
		(3,1,3,900000),
		(4,7,4,370000),
		(5,8,5,128000),
		(6,9,6,120000),
		(7,1,7,300000),
		(8,1,8,169000),
		(9,1,9,312000),
		(10,1,1,420000);

INSERT INTO Mantencion(ID_Maquinaria,ID_Tipo_Mantencion,ID_Mecanico,fecha,horas_trabajadas,descripcion)
	VALUES (1,1,2,'2017-05-29',5,'sin descripción'),
		(2,2,3,'2017-06-30',4,'sin descripción'),
		(3,3,5,'2018-01-20',5,'sin descripción'),
		(4,4,2,'2018-05-19',5,'sin descripción'),
		(5,5,3,'2018-04-15',3,'sin descripción'),
		(6,6,5,'2018-10-29',5,'sin descripción'),
		(7,7,2,'2018-05-12',2,'sin descripción'),
		(8,8,3,'2018-10-09',5,'sin descripción'),
		(9,9,5,'2018-04-01',1,'sin descripción'),
		(10,10,2,'2018-11-02',5,'sin descripción');
