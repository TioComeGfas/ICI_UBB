package net.frodo.app.service;

import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.frodo.app.modelo.Cliente;
import net.frodo.app.modelo.DireccionCliente;
import net.frodo.app.modelo.Encargado;
import net.frodo.app.modelo.TipoCliente;
import net.frodo.app.repositorio.ArriendoRepository;
import net.frodo.app.repositorio.ClienteRepository;
import net.frodo.app.repositorio.DireccionClienteRepository;
import net.frodo.app.repositorio.EncargadoRepository;
import net.frodo.app.repositorio.EstadoRepository;

@Service
public class ClienteServicesJPA implements IClienteServices {

	@Autowired
	private ClienteRepository clienteRepo;
	@Autowired
	private EncargadoRepository encargadoRepo;
	@Autowired
	private DireccionClienteRepository direccionRepo;
	@Autowired
	private ArriendoRepository arrRepo;
	@Autowired
	private EstadoRepository eRepo;
	
	@Override
	@Transactional
	public void insertar(Cliente cliente) {
		clienteRepo.save(cliente);
	}

	@Override
	@Transactional
	public void borrarPorID(int id) {
		clienteRepo.deleteById(id);
	}

	@Override
	@Transactional(readOnly=true)
	public List<Cliente> buscarTodas() {
		return (List<Cliente>) clienteRepo.findAll();
	}

	@Override
	@Transactional(readOnly=true)
	public Encargado getEncargado(int id) {
		return encargadoRepo.getEncargado(id);
	}

	@Override
	@Transactional
	public void insertarEncargado(Encargado encargado) {
		direccionRepo.save(encargado.getCliente().getDireccion());
		clienteRepo.save(encargado.getCliente());
		encargadoRepo.save(encargado);
	}

	@Override
	@Transactional(readOnly=true)
	public TipoCliente getTipoClienteNew(int i) {
		return clienteRepo.getTipoDefault(i);
	}

	@Override
	@Transactional
	public void insertarDireccion(DireccionCliente direccion) {
		direccionRepo.save(direccion);
	}

	@Override
	@Transactional(readOnly=true)
	public Cliente buscarPorID(int id) {
		return clienteRepo.getClienteByID(id);
	}

	@Override
	@Transactional(readOnly=true)
	public List<Cliente> getClientesPreferenciales() {
		return clienteRepo.getClientesPreferenciales();
	}

	@Override
	@Transactional(readOnly=true)
	public List<Cliente> getClientesRegulares() {
		return clienteRepo.getClientesRegulares();
	}

	@Override
	public List<Cliente> getClienteConsulta1() {
		return arrRepo.getConsulta1("Chillan", "a tiempo");
	}

	
}
