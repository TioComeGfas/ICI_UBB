package net.frodo.app.repositorio;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import net.frodo.app.modelo.Operador;

public interface OperadorRepository extends CrudRepository<Operador, Integer> {

	@Query("select o from Operador o where o.id_empleado= ?1")
	public Operador obtenerOperadorByID(int id);
	
}
