package net.frodo.app.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.frodo.app.modelo.Maquinaria;
import net.frodo.app.modelo.TipoMaquinaria;
import net.frodo.app.repositorio.MaquinariaRepository;
import net.frodo.app.repositorio.TipoMaquinariaRepository;

@Service
public class MaquinariaServicesJPA implements IMaquinariaServices{

	@Autowired
	private MaquinariaRepository maquinariaRepo;
	
	@Autowired
	private TipoMaquinariaRepository tipoMaquinariaRepo;
	
	@Override
	@Transactional
	public void insertar(Maquinaria maquinaria) {
		maquinariaRepo.save(maquinaria);
	}

	@Override
	@Transactional
	public void borrarPorID(int id) {
		maquinariaRepo.deleteById(id);
	}

	@Override
	@Transactional(readOnly=true)
	public List<Maquinaria> buscarTodas() {
		return (List<Maquinaria>) maquinariaRepo.findAll();
	}

	@Override
	@Transactional(readOnly=true)
	public List<TipoMaquinaria> getTipoMaquinaria() {
		return (List<TipoMaquinaria>) tipoMaquinariaRepo.findAll();
	}

	@Override
	@Transactional(readOnly=true)
	public Maquinaria obtenerMaquinariaById(int id) {
		return maquinariaRepo.getMaquinariaByID(id);
	}

	@Override
	@Transactional(readOnly=true)
	public TipoMaquinaria buscarTipoByReferencia(String nombre) {
		return tipoMaquinariaRepo.getTipoByReferencia(nombre);
	}

}
