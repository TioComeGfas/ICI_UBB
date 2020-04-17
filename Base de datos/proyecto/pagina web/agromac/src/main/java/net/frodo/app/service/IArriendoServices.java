package net.frodo.app.service;

import java.util.List;

import net.frodo.app.modelo.Arriendo;
import net.frodo.app.modelo.Cliente;
import net.frodo.app.modelo.DetalleArriendo;
import net.frodo.app.modelo.Estado;
import net.frodo.app.modelo.Maquinaria;
import net.frodo.app.modelo.Operador;

public interface IArriendoServices {
	
	//METODOS
	public void insertar(DetalleArriendo detalleArriendo);
	public void borrarPorID(int id);
	public void borrarDetalleByID(int id);
	public List<DetalleArriendo> getDetallesByID(int id);
	
	public List<Cliente> buscarClientes();
	public List<Estado> buscarEstados();
	public List<Operador> buscarOperador();
	public List<Maquinaria> buscarMaquinaria();
	public List<Arriendo> buscarArriendos();
	public List<DetalleArriendo>buscarDetallesArriendo();
	public String buscarNombreOperador(int id);
	public int buscarTelefonoOperador(int id);
	public int buscarCostoMaquinariaByID(int id);
	public Arriendo buscarArriendo(int id);
	public Estado buscarEstadoByReferecia(String data);
	public Cliente buscarClienteByID(int id);
}
