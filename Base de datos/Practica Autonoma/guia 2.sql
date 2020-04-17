create table profesor
	(
	run_prof varchar(12) not null unique,
	nombre varchar(40),
	departamento varchar(20),
	primary key(run_prof)
	);

create table sala
	(
	numero int not null unique,
	capacidad int,
	aire_acon int,
	primary key (numero)
	);

create table curso
	(
	codigo varchar(3) not null unique,
	año int,
	semestre int,
	run_prof varchar(12),
	numero int,
	primary key (codigo),
	foreign key(run_prof) references profesor(run_prof),
	foreign key(numero) references sala(numero)
	);

create table alumno
	(
	run_alum varchar(12) not null unique,
	nombre varchar(40),
	carrera varchar(20),
	primary key(run_alum)
	);

create table cursar
	(
	run_alum varchar(12),
	codigo varchar(3),
	foreign key(run_alum) references alumno(run_alum),
	foreign key(codigo) references curso(codigo)
	);

insert into profesor 
	values('9.240.750-0','José Pérez','Ciencias'),
	('22.563.792-k','Manuel Ponce','Ciencias'),
	('19.190.288-2','Laura Jiménez','Informática'),
	('5.039.643-6','Paola Flores','Informática'),
	('18.718.641-3','Erick Grez','Informática');

insert into sala 
	values(7,30,0),
	(12,25,0),
	(13,30,1),
	(14,30,1),
	(23,15,1);

insert into curso 
	values('1',2017,1,'19.190.288-2',23),
	('4',2016,2,'9.240.750-0',13),
	('6',2018,1,'19.190.288-2',7),
	('8',2018,2,'9.240.750-0',13),
	('9',2015,1,'5.039.643-6',7);

insert into alumno 
	values('18.375.212-k','Miguel Arias','Ing. Alimentos'),
	('19.816.802-5','Alejandra Millar','Ing. Informática'),
	('16.733.684-1','Sofía Campos','Ing. Informática'),
	('16.277.929-k','Angélica Cádiz','Ing. Informática'),
	('18.342.194-8','Manuel Pérez','Nutrición');

insert into cursar 
	values('18.375.212-k','4'),
	('18.375.212-k','4'),
	('19.816.802-5','1'),
	('16.277.929-k','1'),
	('16.277.929-k','6');

insert into profesor values('18772579-2','Pablo Diaz','Ciencias');
insert into curso values (12,2013,2,'18772579-2',7);