package net.frodo.app.service;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.frodo.app.modelo.DetalleArriendo;
import net.frodo.app.repositorio.DetalleArriendoRepository;

@Service
public class DetalleArriendoServicesJPA implements IDetalleArriendoServices{

	@Autowired
	private DetalleArriendoRepository detalleRepo;
	
	@Override
	@Transactional(readOnly=true)
	public List<DetalleArriendo> getAllDetalles() {
		return detalleRepo.getAllDetallesArriendo();
	}
	
	

}
