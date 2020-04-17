package net.frodo.app.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.frodo.app.modelo.Administrativo;
import net.frodo.app.modelo.Empleado;
import net.frodo.app.repositorio.AdministrativoRepository;
import net.frodo.app.repositorio.EmpleadoRepository;


@Service
public class AdministrativoServicesJPA implements IAdministrativoServices {

	@Autowired
	private AdministrativoRepository adminRepo;
	@Autowired
	private EmpleadoRepository empleadoRepo;
	
	
	@Override
	@Transactional(readOnly=true)
	public Administrativo buscarPorID(int id) {
		return adminRepo.obtenerAdminByID(id);
	}

	@Override
	@Transactional
	public void eliminarPorID(int id) {
		adminRepo.deleteById(id);
	}

	@Override
	@Transactional
	public void guardar(Administrativo admin,Empleado empleado) {
		empleadoRepo.save(empleado);
		adminRepo.save(admin);
	}

	@Override
	@Transactional(readOnly=true)
	public List<Administrativo> buscarTodas() {
		return (List<Administrativo>) adminRepo.findAll();
	}

}
