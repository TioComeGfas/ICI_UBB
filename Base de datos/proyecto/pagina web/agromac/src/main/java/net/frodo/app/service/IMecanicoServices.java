package net.frodo.app.service;

import java.util.List;

import net.frodo.app.modelo.Empleado;
import net.frodo.app.modelo.Mecanico;

public interface IMecanicoServices {

	public Mecanico buscarPorID(int id);
	public void eliminarPorID(int id);
	public void guardar(Mecanico mecanico,Empleado empleado);
	public List<Mecanico> buscarTodas();
}
