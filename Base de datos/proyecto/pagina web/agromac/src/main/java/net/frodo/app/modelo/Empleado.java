package net.frodo.app.modelo;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "empleado")
public class Empleado {
	
	@Transient
	public static final byte ADMINISTRATIVO = 1;
	@Transient
	public static final byte MECANICO = 2;
	@Transient
	public static final byte OPERADOR = 3;
	@Transient
	private int tipo;
	@Transient
	private int tarifa;
	@Transient
	private String detalleEspecialidad;
	@Transient
	private String NombreEspecialidad;
	@Transient
	private String nombreCompleto;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String nombre;
	private String apellido_p;
	private String apellido_m;
	private String rut;
	private int telefono;
	private Date fecha_nacimiento;
	
	@OneToOne
	@JoinColumn(name="id_direccion")
	private DireccionEmpleado direccion;
	@OneToOne
	@JoinColumn(name="id_contrato")
	private Contrato contrato;

	public Empleado() {
		
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getApellido_p() {
		return apellido_p;
	}

	public void setApellido_p(String apellido_p) {
		this.apellido_p = apellido_p;
	}

	public String getApellido_m() {
		return apellido_m;
	}

	public void setApellido_m(String apellido_m) {
		this.apellido_m = apellido_m;
	}

	public String getRut() {
		return rut;
	}

	public void setRut(String rut) {
		this.rut = rut;
	}

	public int getTelefono() {
		return telefono;
	}

	public void setTelefono(int telefono) {
		this.telefono = telefono;
	}

	public Date getFecha_nacimiento() {
		return fecha_nacimiento;
	}

	public void setFecha_nacimiento(Date fecha_nacimiento) {
		this.fecha_nacimiento = fecha_nacimiento;
	}

	public DireccionEmpleado getDireccion() {
		return direccion;
	}

	public void setDireccion(DireccionEmpleado direccion) {
		this.direccion = direccion;
	}

	public Contrato getContrato() {
		return contrato;
	}

	public void setContrato(Contrato contrato) {
		this.contrato = contrato;
	}

	public int getTipo() {
		return tipo;
	}

	public void setTipo(int tipo) {
		this.tipo = tipo;
	}

	public int getTarifa() {
		return tarifa;
	}

	public void setTarifa(int tarifa) {
		this.tarifa = tarifa;
	}

	public String getEspecialidad() {
		return detalleEspecialidad;
	}

	public void setEspecialidad(String especialidad) {
		this.detalleEspecialidad = especialidad;
	}

	public String getNombreCompleto() {
		return nombre+" "+apellido_p+" "+apellido_m;
	}

	public void setNombreCompleto(String nombreCompleto) {
		this.nombreCompleto = nombreCompleto;
	}

	public String getNombreEspecialidad() {
		return NombreEspecialidad;
	}

	public void setNombreEspecialidad(String nombreEspecialidad) {
		NombreEspecialidad = nombreEspecialidad;
	}

	public String getDetalleEspecialidad() {
		return detalleEspecialidad;
	}

	public void setDetalleEspecialidad(String detalleEspecialidad) {
		this.detalleEspecialidad = detalleEspecialidad;
	}

	
	
}
