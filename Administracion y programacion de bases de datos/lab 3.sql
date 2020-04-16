-- ejercicio 1
SET SERVEROUTPUT ON
DECLARE
CURSOR los_amigos_by_id(el_id amigos.id%TYPE) IS SELECT nombre FROM amigos WHERE id = el_id;
CURSOR los_casados IS SELECT * FROM casados;

nombre amigos.nombre%TYPE;
el_matrimonio_copia casados%ROWTYPE;
el_matrimonio casados%ROWTYPE;

contadorA NUMBER:= 0;
contadorB NUMBER:= 0;
estado boolean := false;
BEGIN

    FOR el_matrimonio IN los_casados LOOP
        FOR el_matrimonio_copia IN (SELECT * FROM casados) LOOP
            IF contadorA != contadorB THEN
                IF el_matrimonio.idh = el_matrimonio_copia.idh THEN
                    estado := true;
                END IF;
            END IF;
            contadorB := contadorB + 1;
        END LOOP;

        IF estado = false THEN
            OPEN los_amigos_by_id(el_matrimonio.idh);
            FETCH los_amigos_by_id INTO nombre;
            DBMS_OUTPUT.put_line('nombre: '|| nombre || ' y su id: '|| el_matrimonio.idh);
            CLOSE los_amigos_by_id;
        END IF;
        
        contadorA := contadorA + 1;
        estado := false;
        contadorA:=0;
        contadorB :=0;
    END LOOP;
END;

-- ejercicio 2

SET SERVEROUTPUT ON
DECLARE 
    CURSOR los_amigos_by_id(el_id amigos.id%TYPE) IS SELECT nombre FROM amigos WHERE id = el_id;
    CURSOR los_casados IS SELECT * FROM casados;

    nombre amigos.nombre%TYPE;
    el_matrimonio casados%ROWTYPE;

    idm NUMBER;
    idh NUMBER;
    maximo NUMBER := 0;
    años NUMBER;
    now DATE;
BEGIN
    SELECT SYSDATE INTO now FROM dual;

    FOR el_matrimonio IN los_casados LOOP
        IF el_matrimonio.fechasep IS NULL THEN
            años:= (now - el_matrimonio.fechaCas)/365;
        ELSE
            años:= (el_matrimonio.fechaSep - el_matrimonio.fechaCas)/365;
        END IF;

        IF maximo < años THEN
            maximo := años;
            idh:= el_matrimonio.idh;
            idm:= el_matrimonio.idm;
        END IF;
        
    END LOOP;

    OPEN los_amigos_by_id(idh);
    FETCH los_amigos_by_id INTO nombre;
    DBMS_OUTPUT.put_line('el hombre: ' || nombre);
    CLOSE los_amigos_by_id;

    OPEN los_amigos_by_id(idm);
    FETCH los_amigos_by_id INTO nombre;
    DBMS_OUTPUT.put_line('y la mujer: ' || nombre);
    CLOSE los_amigos_by_id;

    SET SERVEROUTPUT ON
DECLARE 
    CURSOR los_amigos_by_id(el_id amigos.id%TYPE) IS SELECT nombre FROM amigos WHERE id = el_id;
    CURSOR los_casados IS SELECT * FROM casados;

    nombre amigos.nombre%TYPE;
    el_matrimonio casados%ROWTYPE;

    idm NUMBER;
    idh NUMBER;
    maximo NUMBER := 0;
    años NUMBER;
    now DATE;
BEGIN
    SELECT SYSDATE INTO now FROM dual;

    FOR el_matrimonio IN los_casados LOOP
        IF el_matrimonio.fechasep IS NULL THEN
            años:= (now - el_matrimonio.fechaCas)/365;
        ELSE
            años:= (el_matrimonio.fechaSep - el_matrimonio.fechaCas)/365;
        END IF;

        IF maximo < años THEN
            maximo := años;
            idh:= el_matrimonio.idh;
            idm:= el_matrimonio.idm;
        END IF;
        
    END LOOP;

    OPEN los_amigos_by_id(idh);
    FETCH los_amigos_by_id INTO nombre;
    DBMS_OUTPUT.put_line('el hombre: ' || nombre);
    CLOSE los_amigos_by_id;

    OPEN los_amigos_by_id(idm);
    FETCH los_amigos_by_id INTO nombre;
    DBMS_OUTPUT.put_line('y la mujer: ' || nombre);
    CLOSE los_amigos_by_id;
    
    DBMS_OUTPUT.put_line('llevan  ' || maximo || ' años de casados');

END;