package net.frodo.app.service;

import java.util.List;
import java.util.Optional;

import net.frodo.app.modelo.Cliente;
import net.frodo.app.modelo.DireccionCliente;
import net.frodo.app.modelo.Encargado;
import net.frodo.app.modelo.TipoCliente;

public interface IClienteServices {
	
	//CRUD
	public void insertar(Cliente cliente);
	public void borrarPorID(int id);
	public List<Cliente> buscarTodas();
	public Cliente buscarPorID(int id);
	public Encargado getEncargado(int id);
	public void insertarEncargado(Encargado encargado);
	public TipoCliente getTipoClienteNew(int i);
	public void insertarDireccion(DireccionCliente direccion);
	
	public List<Cliente> getClientesPreferenciales();
	public List<Cliente> getClientesRegulares();
	
	public List<Cliente> getClienteConsulta1();
}
