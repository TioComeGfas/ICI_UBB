package net.frodo.app.service;

import java.util.List;
import java.util.Optional;

import net.frodo.app.modelo.Maquinaria;
import net.frodo.app.modelo.TipoMaquinaria;

public interface IMaquinariaServices {
	
	public void insertar(Maquinaria maquinaria);
	public Maquinaria obtenerMaquinariaById(int id);
	public void borrarPorID(int id);
	public List<Maquinaria> buscarTodas();
	public List<TipoMaquinaria> getTipoMaquinaria();
	
	public TipoMaquinaria buscarTipoByReferencia(String nombre);
	
	
}
