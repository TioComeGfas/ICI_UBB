package net.frodo.app.service;

import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.frodo.app.modelo.Administrativo;
import net.frodo.app.modelo.Contrato;
import net.frodo.app.modelo.DireccionEmpleado;
import net.frodo.app.modelo.Empleado;
import net.frodo.app.modelo.Mecanico;
import net.frodo.app.modelo.Operador;
import net.frodo.app.modelo.TipoEspecialidad;
import net.frodo.app.repositorio.AdministrativoRepository;
import net.frodo.app.repositorio.ContratoRepository;
import net.frodo.app.repositorio.DireccionEmpleadoRepository;
import net.frodo.app.repositorio.EmpleadoRepository;
import net.frodo.app.repositorio.MecanicoRepository;
import net.frodo.app.repositorio.OperadorRepository;
import net.frodo.app.repositorio.TipoEspecialidadRepository;

@Service
public class EmpleadoServicesJPA implements IEmpleadoServices{

	@Autowired
	private EmpleadoRepository empleadoRepo;
	@Autowired
	private ContratoRepository contratoRepo;
	@Autowired
	private DireccionEmpleadoRepository dirEmpRepo;
	@Autowired
	private MecanicoRepository mecRepo;
	@Autowired
	private OperadorRepository opeRepo;
	@Autowired
	private AdministrativoRepository adminRepo;
	@Autowired
	private TipoEspecialidadRepository especialidadRepo;
	
	@Override
	@Transactional
	public void insertar(Empleado empleado, Contrato contrato, DireccionEmpleado direccion) {
		contratoRepo.save(contrato);
		dirEmpRepo.save(direccion);
		empleadoRepo.save(empleado);
	}
	
	@Override
	@Transactional
	public void borrarPorID(int id) {
		empleadoRepo.deleteById(id);
	}

	@Override
	@Transactional(readOnly=true)
	public List<Empleado> buscarTodas() {
		return aplicarTipo((List<Empleado>) empleadoRepo.findAll());
	}

	@Override
	@Transactional(readOnly=true)
	public Empleado buscarPorID(int id) {
		Empleado object = empleadoRepo.getEmpleado(id);
		object.setTipo(getTipoEmpleadoByID(id));
		return object;
	}

	
	
	@Override
	@Transactional(readOnly=true)
	public List<Integer> buscarAdministrativo() {
		return empleadoRepo.getAdministrativo();
	}

	@Override
	@Transactional(readOnly=true)
	public List<Integer> buscarMecanico() {
		return empleadoRepo.getMecanico();
	}

	@Override
	@Transactional(readOnly=true)
	public List<Integer> buscarOperador() {
		return empleadoRepo.getOperador();
	}
	
	@Override
	@Transactional(readOnly=true)
	public Mecanico buscarMecanicoByID(int id) {
		return empleadoRepo.getTipoM(id);
	}

	@Override
	@Transactional(readOnly=true)
	public Operador buscarOperadorByID(int id) {
		return empleadoRepo.getTipoO(id);
	}

	/**
	 * Encargado de buscar el tipo de empleado en la info
	 * @param lista
	 * @return
	 */
	private List<Empleado> aplicarTipo(List<Empleado> lista){
		List<Integer> admin = buscarAdministrativo();
		List<Integer> mec = buscarMecanico();
		List<Integer> oper = buscarOperador();
		
		for(int i = 0; i < lista.size(); i++) {
			for(int j=0; j < admin.size(); j++) {
				if(lista.get(i).getId() == admin.get(j)) {
					lista.get(i).setTipo(Empleado.ADMINISTRATIVO);
				}
			}
		}
		for(int i = 0; i < lista.size(); i++) {
			for(int j=0; j < mec.size(); j++) {
				if(lista.get(i).getId() == mec.get(j)) {
					lista.get(i).setTipo(Empleado.MECANICO);
				}
			}
		}
		for(int i = 0; i < lista.size(); i++) {
			for(int j=0; j < oper.size(); j++) {
				if(lista.get(i).getId() == oper.get(j)) {
					lista.get(i).setTipo(Empleado.OPERADOR);
				}
			}
		}
		return lista;
	}

	@Override
	@Transactional(readOnly=true)
	public byte getTipoEmpleadoByID(int id) {
		Mecanico mec = empleadoRepo.getTipoM(id);
		if(mec != null) return Empleado.MECANICO;
		Administrativo admin = empleadoRepo.getTipoA(id);
		if(admin != null) return Empleado.ADMINISTRATIVO;
		return Empleado.OPERADOR;
	}

	@Override
	@Transactional(readOnly=true)
	public TipoEspecialidad buscarTipoEspecialidadPorID(int id) {
		return empleadoRepo.getTipoEspecialidad(id);
	}

	@Override
	@Transactional(readOnly=true)
	public List<Empleado> buscarInformacionOperador() {
		
		List<Empleado> empleados = buscarTodas();
		List<Operador> operador = empleadoRepo.getOperadores();
		
		List<Empleado> ready = new LinkedList<>();
		for (int i = 0; i < empleados.size(); i++) {
			for(int j = 0; j < operador.size(); j++) {
				if(empleados.get(i).getId() == operador.get(j).getId_empleado()) {
					Empleado emp = empleados.get(i);
					emp.setTarifa(operador.get(j).getTarifa());
					ready.add(emp);
				}
			}
		}
		return ready;
	}

	@Override
	@Transactional(readOnly=true)
	public List<Empleado> buscarInformacionMecanico() {
		List<Empleado> empleados = buscarTodas();
		List<Mecanico> mecanico = empleadoRepo.getMecanicos();
		
		List<Empleado> ready = new LinkedList<>();
		for (int i = 0; i < empleados.size(); i++) {
			for(int j = 0; j < mecanico.size(); j++) {
				if(empleados.get(i).getId() == mecanico.get(j).getId_empleado()) {
					Empleado emp = empleados.get(i);
					emp.setTarifa(mecanico.get(j).getTarifa_por_hora());
					emp.setEspecialidad(mecanico.get(j).getTipoEspecialidad().getNombre());
					ready.add(emp);
				}
			}
		}
		return ready;
	}

	@Override
	@Transactional(readOnly=true)
	public List<Empleado> buscarInformacionAdministrativo() {
		List<Empleado> empleados = buscarTodas();
		List<Administrativo> admin = empleadoRepo.getAdministradores();
		
		List<Empleado> ready = new LinkedList<>();
		for (int i = 0; i < empleados.size(); i++) {
			for(int j = 0; j < admin.size(); j++) {
				if(empleados.get(i).getId() == admin.get(j).getId_empleado()) {
					Empleado emp = empleados.get(i);
					emp.setTarifa(admin.get(j).getTarifa());
					ready.add(emp);
				}
			}
		}
		return ready;
	}

	@Override
	@Transactional
	public void insertarMecanico(Empleado empleado, Mecanico mecanico, Contrato contrato, DireccionEmpleado direccion) {
		contratoRepo.save(contrato);
		dirEmpRepo.save(direccion);
		empleadoRepo.save(empleado);
		especialidadRepo.save(mecanico.getTipoEspecialidad());
		mecanico.setId_empleado(buscarMaxID());
		mecRepo.save(mecanico);
	}

	@Override
	@Transactional
	public void insertarAdministrativo(Empleado empleado, Administrativo administrativo, Contrato contrato,
			DireccionEmpleado direccion) {
		contratoRepo.save(contrato);
		dirEmpRepo.save(direccion);
		empleadoRepo.save(empleado);
		administrativo.setId_empleado(buscarMaxID());
		adminRepo.save(administrativo);
		
	}

	@Override
	@Transactional
	public void insertarOperador(Empleado empleado, Operador operador, Contrato contrato, DireccionEmpleado direccion) {
		contratoRepo.save(contrato);
		dirEmpRepo.save(direccion);
		empleadoRepo.save(empleado);
		operador.setId_empleado(buscarMaxID());
		opeRepo.save(operador);
		
	}

	@Override
	@Transactional(readOnly=true)
	public int buscarMaxID() {
		return empleadoRepo.getMaxIDEmpleado();
	}

	@Override
	public Empleado buscarTodoEmpledo(int id) {
		Empleado empleado = empleadoRepo.getEmpleado(id);
		if(mecRepo.existsById(id)) {
			Mecanico mec = mecRepo.obtenerMecanicoByID(id);
			empleado.setDetalleEspecialidad(mec.getTipoEspecialidad().getDetalles());
			empleado.setNombreEspecialidad(mec.getTipoEspecialidad().getNombre());
			empleado.setTarifa(mec.getTarifa_por_hora());
			empleado.setTipo(2);
		}else if (adminRepo.existsById(id)) {
			empleado.setTarifa(adminRepo.obtenerAdminByID(id).getTarifa());
			empleado.setTipo(1);
		}
		else {
			empleado.setTarifa(opeRepo.obtenerOperadorByID(id).getTarifa());
			empleado.setTipo(3);
		}
		
		return empleado;
	}

	@Override
	public boolean existe(int id) {
		return empleadoRepo.existsById(id);
	}

	@Override
	public void actualizarMecanico(Empleado empleado, Mecanico mecanico, Contrato contrato,
			DireccionEmpleado direccion) {
		contratoRepo.save(contrato);
		dirEmpRepo.save(direccion);
		empleadoRepo.save(empleado);
		especialidadRepo.save(mecanico.getTipoEspecialidad());
		mecRepo.save(mecanico);
		
	}

	@Override
	public void actualizarAdministrativo(Empleado empleado, Administrativo administrativo, Contrato contrato,
			DireccionEmpleado direccion) {
		contratoRepo.save(contrato);
		dirEmpRepo.save(direccion);
		empleadoRepo.save(empleado);
		adminRepo.save(administrativo);
	}

	@Override
	public void actualizarOperador(Empleado empleado, Operador operador, Contrato contrato,
			DireccionEmpleado direccion) {
		contratoRepo.save(contrato);
		dirEmpRepo.save(direccion);
		empleadoRepo.save(empleado);
		opeRepo.save(operador);
	}

	@Override
	public Contrato buscarContratoByID(int id) {
		return contratoRepo.getContratoByID(id);
	}


}
