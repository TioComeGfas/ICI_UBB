package net.frodo.app.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.frodo.app.modelo.Arriendo;
import net.frodo.app.modelo.Cliente;
import net.frodo.app.modelo.DireccionArriendo;
import net.frodo.app.modelo.DetalleArriendo;
import net.frodo.app.modelo.Empleado;
import net.frodo.app.modelo.Estado;
import net.frodo.app.modelo.Maquinaria;
import net.frodo.app.modelo.Operador;
import net.frodo.app.repositorio.ArriendoRepository;
import net.frodo.app.repositorio.ClienteRepository;
import net.frodo.app.repositorio.DetalleArriendoRepository;
import net.frodo.app.repositorio.DireccionArriendoRepository;
import net.frodo.app.repositorio.EmpleadoRepository;
import net.frodo.app.repositorio.EstadoRepository;
import net.frodo.app.repositorio.MaquinariaRepository;
import net.frodo.app.repositorio.OperadorRepository;

@Service
public class ArriendoServicesJPA implements IArriendoServices{

	@Autowired
	private ArriendoRepository arriendoRepo;
	@Autowired
	private ClienteRepository clienteRepo;
	@Autowired
	private EstadoRepository estadoRepo;
	@Autowired
	private OperadorRepository operadorRepo;
	@Autowired
	private MaquinariaRepository maquinariaRepo;
	@Autowired
	private DetalleArriendoRepository detArriendoRepo;
	@Autowired
	private EmpleadoRepository empleadoRepo;
	@Autowired
	private DireccionArriendoRepository dirArriendoRepo;
	
	
	@Override
	@Transactional
	public void insertar(DetalleArriendo detalleArriendo) {
		dirArriendoRepo.save(detalleArriendo.getArriendo().getDireccion());
		arriendoRepo.save(detalleArriendo.getArriendo());
		detArriendoRepo.save(detalleArriendo);
	}
	
	@Override
	@Transactional
	public void borrarPorID(int id) {
		arriendoRepo.deleteById(id);
	}
	
	@Override
	@Transactional(readOnly=true)
	public List<DetalleArriendo> getDetallesByID(int id) {
		return detArriendoRepo.getDetalleByArriendo(id);
	}

	@Override
	@Transactional(readOnly=true)
	public List<Cliente> buscarClientes() {
		return (List<Cliente>) clienteRepo.findAll();
	}

	@Override
	@Transactional(readOnly=true)
	public List<Estado> buscarEstados() {
		return (List<Estado>) estadoRepo.findAll();
	}

	@Override
	@Transactional(readOnly=true)
	public List<Operador> buscarOperador() {
		return (List<Operador>) operadorRepo.findAll();
	}

	@Override
	@Transactional(readOnly=true)
	public List<Maquinaria> buscarMaquinaria() {
		return (List<Maquinaria>) maquinariaRepo.findAll();
	}

	@Override
	@Transactional(readOnly=true)
	public List<DetalleArriendo> buscarDetallesArriendo() {
		return (List<DetalleArriendo>) detArriendoRepo.findAll();
	}
	
	@Override
	@Transactional(readOnly=true)
	public List<Arriendo> buscarArriendos() {
		return (List<Arriendo>) arriendoRepo.findAll();
	}

	@Override
	@Transactional(readOnly=true)
	public String buscarNombreOperador(int id) {
		Empleado emp = empleadoRepo.getEmpleado(id); 
		return emp.getNombre()+" "+emp.getApellido_p()+" "+emp.getApellido_m();
	}

	@Override
	@Transactional(readOnly=true)
	public int buscarCostoMaquinariaByID(int id) {
		return maquinariaRepo.getMaquinariaByID(id).getValorPorHora();
	}

	@Override
	@Transactional(readOnly=true)
	public Arriendo buscarArriendo(int id) {
		return arriendoRepo.buscarArriendoByID(id);
	}

	@Override
	public Estado buscarEstadoByReferecia(String data) {
		return estadoRepo.buscarEstadoByReferecia(data);
	}

	@Override
	public void borrarDetalleByID(int id) {
		detArriendoRepo.deleteById(id);
	}

	@Override
	public Cliente buscarClienteByID(int id) {
		return clienteRepo.getClienteByID(id);
	}

	@Override
	public int buscarTelefonoOperador(int id) {
		return empleadoRepo.getEmpleado(id).getTelefono();
	}

	
}
