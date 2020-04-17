package net.frodo.app.repositorio;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import net.frodo.app.modelo.TipoMaquinaria;

public interface TipoMaquinariaRepository extends CrudRepository<TipoMaquinaria, Integer> {

	@Query("select t from TipoMaquinaria t where nombre= ?1")
	public TipoMaquinaria getTipoByReferencia(String nombre);
}
