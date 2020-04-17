package net.frodo.app.repositorio;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import net.frodo.app.modelo.Maquinaria;

public interface MaquinariaRepository extends CrudRepository<Maquinaria, Integer> {
	
	@Query("select m from Maquinaria m where m.id= ?1")
	public Maquinaria getMaquinariaByID(int id);
	
}
