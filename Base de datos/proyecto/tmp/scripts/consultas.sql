--q1
	select cli.rut , cli.nombre
	from cliente as cli,arriendo as arri,direccion_arriendo as dir_arri,estado as est
	where cli.id = arri.id_cliente and dir_arri.id = arri.id_direccion and arri.id_estado = est.id and dir_arri.ciudad ='Chillan' and est.descripcion='a tiempo';

--q2
select calle , ciudad, fecha_inicio,fecha_termino , patente, horas_arriendo
from direccion_arriendo as dir, arriendo as arr, maquinaria as maq, detalle_arriendo as det
where dir.id = arr.id_direccion and det.id_maquinaria = maq.id and det.id_arriendo = arr.id and coalesce(det.id_operador,'0000') <>'0000' and arr.fecha_inicio between '2017-01-01' and '2017-01-31';

--q3
select patente,nombre,marca,modelo
from maquinaria,tipo_maquinaria
where maquinaria.id_tipo_maquinaria = tipo_maquinaria.id and maquinaria.id in(
	select id_maquinaria
		from detalle_arriendo
		group by id_maquinaria
		having count(*) = (
			select max(contador)
			from (
				select id_maquinaria, count(*) as contador
				from detalle_arriendo
				group by id_maquinaria) as tmp
			where id_maquinaria in (
				select id_arriendo
				from detalle_arriendo
				where id_arriendo in(
					select id
					from arriendo
					where fecha_inicio between '2018-01-01' and '2018-12-31'))));

--q4 reparar
select det.fecha,det.descripcion,mec.nombre
from detalle_mantencion as det ,mantencion as man,empleado as mec
where det.id_mantencion = man.id and man.id_mecanico = mec.id and det.fecha between '2018-01-01' and '2018-10-31' and det.id_maquinaria = '0004';

--q5
select *
from maquinaria
where id not in(
	select id_maquinaria
	from detalle_mantencion
	where fecha between current_date-90 and current_date);

--q6
select rut, nombre,cant_compras
from cliente
where id in(
	select id_cliente
	from arriendo
	where fecha between '2017-01-01' and '2017-12-31');

--q7
select distinct arr.fecha,cli.nombre,dir.calle, dir.ciudad, det.valor_total
from cliente as cli, arriendo as arr , direccion_arriendo as dir,detalle_arriendo as det
where cli.id = arr.id_cliente and det.id_arriendo = arr.id and dir.id = arr.id_direccion and arr.fecha between '2018-01-01' and '2018-12-31';

--q8 listar todos los clientes y su tipo y descuento
select cliente.nombre, cliente.telefono,cliente.rut,cliente.fecha_nacimiento,cliente.cant_compras, tipo_cliente.nombre,tipo_cliente.descuento
from cliente , tipo_cliente
where cliente.id_tipo_cliente = tipo_cliente.id
order by cliente.nombre;


	