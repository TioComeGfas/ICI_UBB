package net.frodo.app.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.frodo.app.modelo.Empleado;
import net.frodo.app.modelo.Mecanico;
import net.frodo.app.repositorio.EmpleadoRepository;
import net.frodo.app.repositorio.MecanicoRepository;

@Service
public class MecanicoServicesJPA implements IMecanicoServices{

	@Autowired
	private MecanicoRepository mecanicoRepo;
	@Autowired
	private EmpleadoRepository empleadoRepo;
	
	@Override
	@Transactional(readOnly=true)
	public Mecanico buscarPorID(int id) {
		return mecanicoRepo.obtenerMecanicoByID(id);
	}

	@Override
	@Transactional
	public void eliminarPorID(int id) {
		mecanicoRepo.deleteById(id);
	}

	@Override
	@Transactional
	public void guardar(Mecanico mecanico, Empleado empleado) {
		empleadoRepo.save(empleado);
		mecanicoRepo.save(mecanico);
	}

	@Override
	@Transactional(readOnly=true)
	public List<Mecanico> buscarTodas() {
		return (List<Mecanico>) mecanicoRepo.findAll();
	}

}
