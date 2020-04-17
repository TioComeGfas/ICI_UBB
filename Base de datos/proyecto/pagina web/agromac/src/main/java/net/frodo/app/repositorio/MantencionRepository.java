package net.frodo.app.repositorio;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import net.frodo.app.modelo.Mantencion;

public interface MantencionRepository extends CrudRepository<Mantencion, Integer> {

	@Query("select m from Mantencion m")
	public List<Mantencion> getMantencionesAll();
	
	@Query("select m from Mantencion m where m.id= ?1")
	public Mantencion getMantencionByID(int id);
	
}
