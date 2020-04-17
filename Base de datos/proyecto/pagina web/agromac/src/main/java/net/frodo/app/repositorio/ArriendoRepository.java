package net.frodo.app.repositorio;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import net.frodo.app.modelo.Arriendo;
import net.frodo.app.modelo.Cliente;

public interface ArriendoRepository extends CrudRepository<Arriendo, Integer> {
	
	@Query("select a from Arriendo a where a.id = ?1")
	public Arriendo buscarArriendoByID(int id);
	
	@Query("select a.cliente from Arriendo a where a.cliente.direccion.ciudad= ?1 and a.estado.descripcion = ?2 ")
	public List<Cliente> getConsulta1(String a, String b);
}
