package net.frodo.app.service;

import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.frodo.app.modelo.Empleado;
import net.frodo.app.modelo.Mantencion;
import net.frodo.app.modelo.Maquinaria;
import net.frodo.app.modelo.Mecanico;
import net.frodo.app.modelo.TipoMantencion;
import net.frodo.app.repositorio.EmpleadoRepository;
import net.frodo.app.repositorio.MantencionRepository;
import net.frodo.app.repositorio.MaquinariaRepository;
import net.frodo.app.repositorio.MecanicoRepository;
import net.frodo.app.repositorio.TipoMantencionRepository;

@Service
public class MantencionServicesJPA implements IMantencionServices{

	@Autowired
	private MantencionRepository mantencionRepo;
	@Autowired
	private TipoMantencionRepository tipoRepo;
	@Autowired
	private EmpleadoRepository empRepo;
	@Autowired
	private MaquinariaRepository maqRepo;
	@Autowired
	private MecanicoRepository mecRepo;

	@Override
	@Transactional
	public void borrarPorID(int id) {
		mantencionRepo.deleteById(id);
	}

	@Override
	@Transactional(readOnly=true)
	public List<Mantencion> buscarTodas() {
		return (List<Mantencion>) mantencionRepo.findAll();
	}

	@Override
	@Transactional(readOnly=true)
	public Mantencion buscarPorID(int id) {
		return mantencionRepo.getMantencionByID(id);
	}

	@Override
	@Transactional(readOnly=true)
	public List<TipoMantencion> buscarAllTipos() {
		return (List<TipoMantencion>) tipoRepo.findAll();
	}

	@Override
	@Transactional(readOnly=true)
	public List<String> buscarInfoMecanico() {
		List<Empleado> tmp = empRepo.getInfoMecanico();
		List<Integer> mec = empRepo.getMecanico();
		List<String> lista = new LinkedList<>();
		for(int i = 0; i < tmp.size(); i++) for(int j=0; j< mec.size(); j++) if(tmp.get(i).getId() == mec.get(j)) lista.add(tmp.get(i).getNombre()+" "+tmp.get(i).getApellido_p()+" "+tmp.get(i).getApellido_m());
		return lista;
	}

	@Override
	@Transactional(readOnly=true)
	public List<String> buscarInfoMaquinaria() {
		List<Maquinaria> tmp = (List<Maquinaria>) maqRepo.findAll();
		
		List<String> lista = new LinkedList<>();
		for(int i=0; i < tmp.size(); i++) {
			lista.add(tmp.get(i).getMarca()+"-"+tmp.get(i).getModelo());
		}
		return lista;
	}

	@Override
	@Transactional(readOnly=true)
	public List<Mecanico> buscarMecanicos() {
		return (List<Mecanico>) mecRepo.findAll();
	}

	@Override
	@Transactional(readOnly=true)
	public List<Maquinaria> buscarMaquinarias() {
		return (List<Maquinaria>) maqRepo.findAll();
	}

	@Override
	public void insertar(Mantencion mantencion) {
		mantencionRepo.save(mantencion);
	}

	@Override
	public String buscarInfoMecanicoByID(int id_empleado) {
		return empRepo.getEmpleado(id_empleado).getNombreCompleto();
	}

	@Override
	public Maquinaria buscarMaqByID(int id) {
		return maqRepo.getMaquinariaByID(id);
	}

	@Override
	public Mecanico buscarMecByID(int id) {
		return mecRepo.obtenerMecanicoByID(id);
	}

	@Override
	public TipoMantencion buscarTipoByID(int id) {
		return tipoRepo.getTipoByID(id);
	}

	@Override
	public Empleado buscarMecanicoByID(int id) {
		return empRepo.getEmpleado(id);
	}

	
}
