DECLARE
-- Un ejemplo de cursor explicito
  CURSOR  amg IS
  SELECT * FROM amigos;
  elamigo amigos%ROWTYPE;
  mm20 INTEGER; m2030 INTEGER; m3040 INTEGER; mm40 INTEGER;
  hm20 INTEGER; h2030 INTEGER; h3040 INTEGER; hm40 INTEGER;
  edad  INTEGER;
  FechaSistema DATE;
 BEGIN
  mm20:=0; m2030:=0; m3040:=0;mm40:=0;
  hm20:=0; h2030:=0; h3040:=0;hm40:=0;
-- Fecha del sistema
 SELECT SYSDATE INTO FechaSistema FROM DUAL;
 FOR elamigo in amg LOOP
-- se calcula la edad (en años) de cada amigo
   edad := (FechaSistema - elamigo.fnac) / 365;
-- Mujeres
   IF (elamigo.sexo='F') THEN
    IF edad < 20 THEN mm20 := mm20+1;
      ELSIF edad >= 20 and edad <=30  THEN m2030 := m2030+1;
      ELSIF edad >= 30 and edad <=40  THEN m3040 := m3040+1;
      ELSE mm40 := mm40 +1;
    END IF;
-- Hombres
   ELSE
    IF edad < 20 THEN hm20 := hm20+1;
      ELSIF edad >= 20 and edad <=30  THEN h2030 := h2030+1;
      ELSIF edad >= 30 and edad <=40  THEN h3040 := h3040+1;
      ELSE hm40 := hm40 +1;
    END IF;
  END IF;
 END LOOP;
 -- impresión de la tabla
   dbms_output.put_line( '-----------------Rango de edades ----------'  );
   dbms_output.put_line( '   < 20    [20,30]   [30,40]   >40      Total '   );
   dbms_output.put_line( '--------------------------------------------'  );
   dbms_output.put_line( 'Mj ' || mm20 || '       ' || m2030 || '       ' || m3040 || '      ' || '     ' ||  mm40|| '    ' ||  (mm20+m2030+m3040+mm40));
   dbms_output.put_line( 'Hm ' || hm20 || '       ' || h2030 || '       ' || h3040 || '      ' || '     ' ||  hm40 || '    ' || (hm20+h2030+h3040+hm40));
   dbms_output.put_line( '---------------------------------------------'  );
   dbms_output.put_line( 'Tt ' || (mm20+hm20) || '       ' || (h2030+m2030) || '       ' || (m3040+h3040) || '      ' || '     ' || (mm40+ hm40) || '    ' || (mm20+hm20+m2030+h2030+m3040+h3040+mm40+hm40));
   dbms_output.put_line( '---------------------------------------------'  );
END;
