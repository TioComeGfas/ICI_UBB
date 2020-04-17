package net.frodo.app.service;

import java.util.List;

import net.frodo.app.modelo.Administrativo;
import net.frodo.app.modelo.Empleado;

public interface IAdministrativoServices {

	public Administrativo buscarPorID(int id);
	public void eliminarPorID(int id);
	public void guardar(Administrativo admin,Empleado empleado);
	public List<Administrativo> buscarTodas();
	
}
