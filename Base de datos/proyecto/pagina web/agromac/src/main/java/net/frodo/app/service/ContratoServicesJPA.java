package net.frodo.app.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.frodo.app.modelo.Contrato;
import net.frodo.app.modelo.Empleado;
import net.frodo.app.repositorio.ContratoRepository;
import net.frodo.app.repositorio.EmpleadoRepository;

@Transactional
@Service
public class ContratoServicesJPA implements IContratoServices{

	@Autowired
	private ContratoRepository contratoRepo;
	@Autowired
	private EmpleadoRepository empleadoRepo;
	
	@Override
	@Transactional
	public void insertar(Contrato contrato) {
		contratoRepo.save(contrato);
	}

	@Override
	@Transactional
	public void borrarPorID(int id) {
		contratoRepo.deleteById(id);
	}
	
	@Override
	@Transactional
	public void borrarPorReferencia(Contrato contrato) {
		contratoRepo.delete(contrato);
	}

	@Override
	@Transactional(readOnly=true)
	public List<Contrato> buscarTodas() {
		return (List<Contrato>) contratoRepo.findAll();
	}

	@Override
	@Transactional(readOnly=true)
	public Optional<Contrato> buscarPorID(int id) {
		return contratoRepo.findById(id);
	}

	@Override
	@Transactional(readOnly=true)
	public Contrato getContratoByID(int id) {
		return contratoRepo.getContratoByID(id);
	}

	@Override
	@Transactional(readOnly=true)
	public List<Empleado> getEmpleados() {
		return (List<Empleado>) empleadoRepo.findAll();
	}

	

}
