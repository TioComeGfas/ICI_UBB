package net.frodo.app.repositorio;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import net.frodo.app.modelo.TipoMantencion;

public interface TipoMantencionRepository extends CrudRepository<TipoMantencion, Integer> {

	@Query("select t from TipoMantencion t where t.id= ?1")
	public TipoMantencion getTipoByID(int id);
}
