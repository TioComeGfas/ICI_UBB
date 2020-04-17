--q1
select distinct run_alum, nombre
from alumno
where run_alum in (
	
	select run_alum
	from cursar
	where codigo in(
		select codigo
		from curso
		where numero in(
			select numero
			from sala
			where capacidad > (
				select min(capacidad)
				from sala 
				where aire_acon = 1))));

--q2
select distinct run_prof, nombre
from profesor
where run_prof in(
	select run_prof
	from curso
	where numero in(
		select numero
		from sala
		where capacidad < (
			select avg(capacidad)
			from sala
			where aire_acon = 1)));

--q3
select count(*) as cant_salas, min(capacidad) as min_cap, max(capacidad) as max_cap , avg(capacidad) as cap_promedio
from sala;

--q4
select distinct run_alum, nombre
from alumno
where run_alum in(
	select run_alum
	from cursar
	where codigo in(
		select curso.codigo
		from profesor,curso
		where profesor.run_prof = curso.run_prof and profesor.departamento <> 'ciencias' and curso.numero in (
			select numero
			from sala
			where capacidad in (
				select max(capacidad)
				from sala))));

--q5
select *
from sala
where numero in(
	select numero
	from curso);

--q6
