package net.frodo.app.service;

import java.util.List;

import net.frodo.app.modelo.Administrativo;
import net.frodo.app.modelo.Contrato;
import net.frodo.app.modelo.DireccionEmpleado;
import net.frodo.app.modelo.Empleado;
import net.frodo.app.modelo.Mecanico;
import net.frodo.app.modelo.Operador;
import net.frodo.app.modelo.TipoEspecialidad;

public interface IEmpleadoServices {

	public void insertar(Empleado empleado,Contrato contrato,DireccionEmpleado direccion);
	public void borrarPorID(int id);
	public List<Empleado> buscarTodas();
	public Empleado buscarPorID(int id);
	public byte getTipoEmpleadoByID(int id);
	public TipoEspecialidad buscarTipoEspecialidadPorID(int id);
	
	public List<Integer> buscarAdministrativo();
	public List<Integer> buscarMecanico();
	public Mecanico buscarMecanicoByID(int id);
	public List<Integer> buscarOperador();
	public Operador buscarOperadorByID(int id);
	
	public List<Empleado> buscarInformacionOperador();
	public List<Empleado> buscarInformacionMecanico();
	public List<Empleado> buscarInformacionAdministrativo();
	
	public void insertarMecanico(Empleado empleado, Mecanico mecanico,Contrato contrato,DireccionEmpleado direccion);
	public void insertarAdministrativo(Empleado empleado, Administrativo administrativo,Contrato contrato,DireccionEmpleado direccion);
	public void insertarOperador(Empleado empleado, Operador operador,Contrato contrato,DireccionEmpleado direccion);
	
	public void actualizarMecanico(Empleado empleado, Mecanico mecanico,Contrato contrato,DireccionEmpleado direccion);
	public void actualizarAdministrativo(Empleado empleado, Administrativo administrativo,Contrato contrato,DireccionEmpleado direccion);
	public void actualizarOperador(Empleado empleado, Operador operador,Contrato contrato,DireccionEmpleado direccion);
	
	public int buscarMaxID();
	public Empleado buscarTodoEmpledo(int id);
	public boolean existe(int id);
	
	public Contrato buscarContratoByID(int id);
}
