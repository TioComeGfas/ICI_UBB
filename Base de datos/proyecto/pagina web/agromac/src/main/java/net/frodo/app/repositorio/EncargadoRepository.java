package net.frodo.app.repositorio;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import net.frodo.app.modelo.Encargado;

public interface EncargadoRepository extends CrudRepository<Encargado, Integer> {

	@Query("select e from Encargado e where e.cliente.id = ?1")
	public Encargado getEncargado(int id);
	
}
