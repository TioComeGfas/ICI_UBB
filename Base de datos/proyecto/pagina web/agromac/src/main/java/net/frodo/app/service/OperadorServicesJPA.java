package net.frodo.app.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.frodo.app.modelo.Empleado;
import net.frodo.app.modelo.Operador;
import net.frodo.app.repositorio.EmpleadoRepository;
import net.frodo.app.repositorio.OperadorRepository;

@Service
public class OperadorServicesJPA implements IOperadorServices {

	@Autowired
	private OperadorRepository operadorRepo;
	@Autowired
	private EmpleadoRepository empleadoRepo;
	
	@Override
	@Transactional(readOnly=true)
	public Operador buscarPorID(int id) {
		return operadorRepo.obtenerOperadorByID(id);
	}
	@Override
	@Transactional
	public void eliminarPorID(int id) {
		operadorRepo.deleteById(id);
	}
	@Override
	@Transactional
	public void guardar(Operador operador, Empleado empleado) {
		empleadoRepo.save(empleado);
		operadorRepo.save(operador);
	}
	@Override
	@Transactional(readOnly=true)
	public List<Operador> buscarTodas() {
		return (List<Operador>) operadorRepo.findAll();
	}
	
	
}
