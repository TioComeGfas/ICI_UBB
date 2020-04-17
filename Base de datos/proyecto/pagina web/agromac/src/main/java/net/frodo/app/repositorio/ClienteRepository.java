package net.frodo.app.repositorio;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import net.frodo.app.modelo.Cliente;
import net.frodo.app.modelo.TipoCliente;

public interface ClienteRepository extends CrudRepository<Cliente, Integer> {

	
	@Query("select c from Cliente c where c.tipoCliente.id > 1")
	public List<Cliente> getClientesPreferenciales();
	
	@Query("select c from Cliente c where c.tipoCliente.id = 1")
	public List<Cliente> getClientesRegulares();
	
	@Query("select c from Cliente c where c.id= ?1")
	public Cliente getClienteByID(int id);
	
	@Query("select t from TipoCliente t where t.id= ?1")
	public TipoCliente getTipoDefault(int i);
	
	@Query("select c.id from Cliente c join DireccionCliente d on c.direccion.id = d.id where d.ciudad = ?1")
	public List <Integer> getClienteChillan(String ciudad);
	
	
}
