package net.frodo.app.service;

import java.util.List;

import net.frodo.app.modelo.Empleado;
import net.frodo.app.modelo.Operador;

public interface IOperadorServices {
	
	public Operador buscarPorID(int id);
	public void eliminarPorID(int id);
	public void guardar(Operador operador,Empleado empleado);
	public List<Operador> buscarTodas();
}
