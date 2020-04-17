package net.frodo.app.repositorio;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;

import net.frodo.app.modelo.TipoCliente;

public interface TipoClienteRepository extends CrudRepository<TipoCliente, Integer> {

}
