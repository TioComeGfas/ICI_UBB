package net.frodo.app.repositorio;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import net.frodo.app.modelo.Administrativo;
import net.frodo.app.modelo.Empleado;
import net.frodo.app.modelo.Mecanico;
import net.frodo.app.modelo.Operador;
import net.frodo.app.modelo.TipoEspecialidad;

@Repository
public interface EmpleadoRepository extends CrudRepository<Empleado, Integer> {
	
	@Query("select e.id_empleado from Administrativo e")
	public List<Integer> getAdministrativo();
	
	@Query("select e.id_empleado from Operador e")
	public List<Integer> getOperador();
	
	@Query("select e.id_empleado from Mecanico e")
	public List<Integer> getMecanico();
	
	@Query("select e from Empleado e where e.id= ?1")
	public Empleado getEmpleado(int id);
	
	@Query("select e from Administrativo e where e.id_empleado= ?1")
	public Administrativo getTipoA(int id);
	
	@Query("select e from Mecanico e where e.id_empleado= ?1")
	public Mecanico getTipoM(int id);
	
	@Query("select e from Operador e where e.id_empleado= ?1")
	public Operador getTipoO(int id);
	
	@Query("select m from TipoEspecialidad m where m.id= ?1")
	public TipoEspecialidad getTipoEspecialidad(int id);
	
	@Query("select o from Operador o")
	public List<Operador> getOperadores();
	
	@Query("select m from Mecanico m")
	public List<Mecanico> getMecanicos();
	
	@Query("select a from Administrativo a")
	public List<Administrativo> getAdministradores();
	
	@Query("select m from Empleado m ")
	public List<Empleado> getInfoMecanico();
	
	@Query("select max(m.id) from Empleado m")
	public int getMaxIDEmpleado();
}
