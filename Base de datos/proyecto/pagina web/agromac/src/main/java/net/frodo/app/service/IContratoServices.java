package net.frodo.app.service;

import java.util.List;
import java.util.Optional;

import net.frodo.app.modelo.Contrato;
import net.frodo.app.modelo.Empleado;

public interface IContratoServices {
	
	//METODOS
		public void insertar(Contrato contrato);
		public void borrarPorID(int id);
		public void borrarPorReferencia(Contrato contrato);
		public List<Contrato> buscarTodas();
		public Optional<Contrato> buscarPorID(int id);
		public Contrato getContratoByID(int id);
		public List<Empleado> getEmpleados();
}
