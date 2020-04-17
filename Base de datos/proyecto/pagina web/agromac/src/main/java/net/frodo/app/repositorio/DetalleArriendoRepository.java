package net.frodo.app.repositorio;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.w3c.dom.stylesheets.LinkStyle;

import net.frodo.app.modelo.DetalleArriendo;

public interface DetalleArriendoRepository extends CrudRepository<DetalleArriendo, Integer> {
	
	@Query("select d from DetalleArriendo d")
	public List<DetalleArriendo> getAllDetallesArriendo();
	
	@Query("select d from DetalleArriendo d where id_arriendo = ?1")
	public List<DetalleArriendo> getDetalleByArriendo(int id);
	
}
