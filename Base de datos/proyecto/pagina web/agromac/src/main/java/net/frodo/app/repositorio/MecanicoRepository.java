package net.frodo.app.repositorio;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import net.frodo.app.modelo.Mecanico;

public interface MecanicoRepository extends CrudRepository<Mecanico, Integer> {

	@Query("select m from Mecanico m where m.id_empleado= ?1")
	public Mecanico obtenerMecanicoByID(int id);
	
}
