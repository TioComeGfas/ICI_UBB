package net.frodo.app.repositorio;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import net.frodo.app.modelo.Estado;

public interface EstadoRepository extends CrudRepository<Estado, Integer> {

	@Query("select a from Estado a where a.descripcion = ?1")
	public Estado buscarEstadoByReferecia(String data);
}
