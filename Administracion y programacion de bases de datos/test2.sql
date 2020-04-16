create or replace FUNCTION pregunta1
 RETURN NUMBER IS
 dateNow DATE;
 CURSOR misAmigos IS SELECT * FROM amigos;
 elAmigo amigos%ROWTYPE;
 edadMin NUMBER:=100;
 idAmigo NUMBER;
 edadAmigo NUMBER;
BEGIN
    SELECT SYSDATE INTO dateNow FROM DUAL;
    FOR elAmigo IN misAmigos LOOP
        edadAmigo := (dateNow-elAmigo.fnac)/365 ;
        IF edadAmigo < edadMin  THEN
            edadMin := edadAmigo;
            idAmigo := elAmigo.id;
        END IF;
    END LOOP;  

    RETURN idAmigo;
END pregunta1;


create or replace procedure pregunta2 is
CURSOR misAmigos IS SELECT * FROM amigos;
CURSOR misCasados IS SELECT * FROM casados;  
elAmigo amigos%ROWTYPE;
elMatrimonio casados%ROWTYPE;
elPadre amigos.nombre%TYPE;
laMadre amigos.nombre%TYPE;
flag INTEGER;
BEGIN
    FOR elAmigo IN misAmigos LOOP
        flag := 0;
        FOR elMatrimonio IN misCasados LOOP
            IF elAmigo.idMadre = elMatrimonio.idm THEN
                flag:=1;
                SELECT nombre INTO elPadre FROM amigos where id = elAmigo.idPadre;
                SELECT nombre INTO laMadre FROM amigos where id = elAmigo.idMadre;                
                dbms_output.put_line('amigo: ' || elAmigo.nombre || ', telefono: '|| elAmigo.cel || ',nacimiento: ' || elAmigo.fnac || ', sexo: ' || elAmigo.sexo || ', padre: ' || elPadre || ', madre: ' || laMadre);
            END IF;

            IF flag = 0 THEN
                IF elAmigo.idPadre = elMatrimonio.idh THEN
                    SELECT nombre INTO elPadre FROM amigos where id = elAmigo.idPadre;
                    SELECT nombre INTO laMadre FROM amigos where id = elAmigo.idMadre;                
                    dbms_output.put_line('amigo: ' || elAmigo.nombre || ', telefono: '|| elAmigo.cel || ',nacimiento: ' || elAmigo.fnac || ', sexo: ' || elAmigo.sexo || ', padre: ' || elPadre || ', madre: ' || laMadre);
                END IF;
            END IF;
        END LOOP;
    END LOOP;
END;

create or replace TRIGGER pregunta3
BEFORE INSERT OR UPDATE ON casados
FOR EACH ROW
DECLARE

CURSOR misCasados IS SELECT * FROM casados;
miMatrimonio casados%ROWTYPE;
contadorSeparados INTEGER :=0;

BEGIN
    SELECT fnac INTO fechaHombre FROM AMIGOS WHERE id = :NEW.idH;
    SELECT fnac INTO fechaMujer FROM AMIGOS WHERE id = :NEW.idM;
    SELECT SYSDATE INTO fechaActual FROM DUAL;
    edadHombre := (fechaActual - fechaHombre) / 365;
    edadMujer := (fechaActual - fechaMujer) / 365;
    IF :NEW.fechaSep IS NULL THEN
        /* comprobamos que no existan mas de 10 matrimonios separados*/
        FOR miMatrimonio IN misCasados LOOP
            IF miMatrimonio.fechaSep IS NOT NULL THEN
                contadorSeparados := contadorSeparados +1;
            END IF;
        END LOOP;

        IF contadorSeparados > 10 THEN
            raise_application_error(-20000,  'ya existen mas de 10 matrimonios separados');
        END IF;
    END IF;
END;

//pregunta 4
package test2;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;

public class Test_2 {
    
    public static void main(String[] args) {
        Connection conexion;
        
        String jdbc = "jdbc:oracle:thin:@colvin.chillan.ubiobio.cl:1521:orcl" ;
        String usuario = "diego.inostroza1601";
        String pass = "diego1601";
        try{
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
            conexion = DriverManager.getConnection(jdbc, usuario, pass);
            conexion.setAutoCommit(false);
            
            mostrarMasJoven(conexion); //pregunta 1
            
        }catch(SQLException e){
            System.out.println("ERROR CON LA BDD ");
            e.printStackTrace();
            System.exit(1);
        }
    }
    
    public static void mostrarMasJoven(Connection conexion) throws SQLException{
        CallableStatement cs = conexion.prepareCall ("begin ? := pregunta1(); end;");
        cs.registerOutParameter(1,Types.INTEGER);
        cs.executeUpdate();
        
        int result = cs.getInt(1);
        
        cs = conexion.prepareCall ("begin ? := edad(?); end;");
        cs.registerOutParameter(1,Types.INTEGER);
        cs.setInt(2, result);
        cs.executeUpdate();
        
        int edad =  cs.getInt(1);
        
        Statement statment = conexion.createStatement();
        ResultSet set = statment.executeQuery("Select * from amigos");
        set.next();
        
        int idAmigo = set.getInt("id");
        String nombre = set.getString("nombre");
        int telefono = set.getInt("cel");
        String sexo = set.getString("sexo");
        int idPadre = set.getInt("idPadre");
        int idMadre = set.getInt("idMadre");
        
        set.close();
        statment.close();
        
        System.out.println("El amigo mas joven es: "+nombre+", "+telefono+","+edad+","+sexo);
        
        
    }
}