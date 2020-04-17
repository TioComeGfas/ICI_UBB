package net.frodo.app.service;

import java.util.List;
import java.util.Optional;

import net.frodo.app.modelo.Empleado;
import net.frodo.app.modelo.Mantencion;
import net.frodo.app.modelo.Maquinaria;
import net.frodo.app.modelo.Mecanico;
import net.frodo.app.modelo.TipoMantencion;

public interface IMantencionServices {
	
	public void insertar(Mantencion mantencion);
	public void borrarPorID(int id);
	public List<Mantencion> buscarTodas();
	public Mantencion buscarPorID(int id);
	
	public List<TipoMantencion> buscarAllTipos();
	public List<String> buscarInfoMecanico();
	public List<String> buscarInfoMaquinaria();
	public List<Mecanico> buscarMecanicos();
	public List<Maquinaria> buscarMaquinarias();
	public String buscarInfoMecanicoByID(int id_empleado);
	
	public Maquinaria buscarMaqByID(int id);
	public Mecanico buscarMecByID(int id);
	public TipoMantencion buscarTipoByID(int id);
	public Empleado buscarMecanicoByID(int id);

}
