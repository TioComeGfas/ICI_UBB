package net.frodo.app.repositorio;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import net.frodo.app.modelo.Administrativo;

public interface AdministrativoRepository extends CrudRepository<Administrativo, Integer> {

	@Query("select a from Administrativo a where a.id_empleado= ?1")
	public Administrativo obtenerAdminByID(int id);
}
