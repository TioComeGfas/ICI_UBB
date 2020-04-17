CREATE TABLE ARRIENDO(
	id int NOT NULL UNIQUE,
	tarifa_base int,
	PRIMARY KEY(id));

CREATE TABLE DETALLE_ARRIENDO(
	id_arriendo int NOT NULL UNIQUE,
	horas_arriendo int,
	fecha date,
	valor_total int,
	FOREIGN KEY(id_arriendo) REFERENCES ARRIENDO(id));

CREATE TABLE CLIENTE(
	id int NOT NULL UNIQUE,
	id_detalle_arriendo int NOT NULL UNIQUE,
	rut int,
	fecha_nacimiento date,
	nombre varchar(30),
	telefono int,
	direccion varchar (30), --valor multivariable, cambiar
	PRIMARY KEY(id),
	FOREIGN KEY(id_detalle_arriendo) REFERENCES DETALLE_ARRIENDO (id_arriendo));

CREATE TABLE TIPO_CLIENTE(
	id int NOT NULL UNIQUE,
	nombre varchar(20),
	descuento int,
	FOREIGN KEY(id) REFERENCES CLIENTE(id));

CREATE TABLE ENCARGADO(
	id int NOT NULL UNIQUE,
	id_cliente int NOT NULL UNIQUE,
	rut int,
	nombre varchar(30),
	telefono int,
	PRIMARY KEY (id),
	FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id));

CREATE TABLE EMPLEADO(
	id int NOT NULL UNIQUE,
	nombre varchar(30),
	rut int,
	telefono int,
	direccion varchar(30),
	fecha_nacimiento date,
	PRIMARY KEY (id));

CREATE TABLE CONTRATO(
	id int NOT NULL UNIQUE,
	id_empleado int NOT NULL UNIQUE,
	fecha_inicio date,
	fecha_fin date,
	PRIMARY KEY (id),
	FOREIGN KEY (id_empleado) REFERENCES EMPLEADO(id));

CREATE TABLE OPERADOR(
	id_empleado int NOT NULL UNIQUE,
	id_arriendo int NOT NULL UNIQUE,
	tarifa_por_hora int,
	FOREIGN KEY (id_empleado)REFERENCES EMPLEADO(id),
	FOREIGN KEY (id_arriendo)REFERENCES ARRIENDO(id));

CREATE TABLE ADMINISTRATIVO(
	id_empleado int NOT NULL UNIQUE,
	tarifa_por_hora int,
	FOREIGN KEY(id_empleado) REFERENCES EMPLEADO(id));

CREATE TABLE MECANICO(
	id_empleado int NOT NULL UNIQUE,
	tarifa_por_hora int,
	FOREIGN KEY(id_empleado) REFERENCES EMPLEADO(id));

CREATE TABLE TIPO_ESPECIALIDAD(
	id_mecanico int NOT NULL UNIQUE,
	años int,
	detalle varchar(100),
	FOREIGN KEY(id_mecanico) REFERENCES MECANICO(id_empleado));

CREATE TABLE MANTENCION(
	id int NOT NULL UNIQUE,
	costo int,
	PRIMARY KEY(id));												 
												 
CREATE TABLE MAQUIARIA(
	id int NOT NULL UNIQUE,
	id_mantencion int NOT NULL UNIQUE,
	marca varchar(20),
	modelo varchar(20),
	patente varchar(10),
	kilometraje int,
	PRIMARY KEY(id),
	FOREIGN KEY(id_mantencion) REFERENCES MANTENCION(id));

CREATE TABLE DETALLE_MANTENCION(
	id_mantencion int NOT NULL UNIQUE,
	fecha date,
	descripcion varchar(100),
	horas_trabajadas int,
	FOREIGN KEY(id_mantencion)REFERENCES MANTENCION(id));

CREATE TABLE TIPO_MANTENCION(
	id_detalle_mantencion int NOT NULL UNIQUE,
	nombre varchar(20),
	FOREIGN KEY(id_detalle_mantencion) REFERENCES DETALLE_MANTENCION(id_mantencion));