package net.frodo.app.repositorio;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import net.frodo.app.modelo.Contrato;

public interface ContratoRepository extends CrudRepository<Contrato, Integer> {

	@Query("select c from Contrato c where c.id= ?1")
	public Contrato getContratoByID(int id);

}
