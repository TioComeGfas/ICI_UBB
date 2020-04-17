SELECT DISTINCT año
FROM curso
ORDER BY año;

SELECT nombre
FROM profesor
WHERE departamento = 'Ciencias';

SELECT *
FROM curso
WHERE semestre = 2 AND numero = 13;

SELECT codigo,numero
FROM curso
WHERE año BETWEEN 2014 AND 2016;

SELECT codigo,numero
FROM curso
WHERE año BETWEEN 2015 AND 2018 AND año != 2016;

SELECT *
FROM alumno
WHERE run_alum LIKE '%18%';

SELECT *
FROM profesor AS p ,curso as c,sala as s
WHERE  p.run_prof = c.run_prof AND c.numero = s.numero;

SELECT c.*,p.nombre,p.departamento
FROM curso AS c,profesor AS p
WHERE c.semestre = 2 AND c.numero = 7 AND c.run_prof = p.run_prof;

SELECT *
FROM curso
WHERE run_prof IN(
	SELECT run_prof
	FROM profesor
	WHERE nombre = 'José Pérez');
