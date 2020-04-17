package net.frodo.app.repositorio;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;

import net.frodo.app.modelo.DireccionEmpleado;

public interface DireccionEmpleadoRepository extends CrudRepository<DireccionEmpleado, Integer> {

}
