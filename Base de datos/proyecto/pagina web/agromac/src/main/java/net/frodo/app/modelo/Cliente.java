	package net.frodo.app.modelo;

import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "cliente")
public class Cliente {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String nombre;
	private String apellido_p;
	private String apellido_m;
	private int telefono;
	private String rut;
	private Date fecha_nacimiento;
	private int cant_compras;
	@Transient
	private String nombreCompleto;

	@ManyToOne
	@JoinColumn(name="id_tipo_cliente")
	private TipoCliente tipoCliente;
	
	@OneToOne
	@JoinColumn(name = "id_direccion")
	private DireccionCliente direccion;
	
	@OneToMany(mappedBy="cliente",fetch=FetchType.LAZY)
	private List<Arriendo> arriendo;

	public Cliente() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public TipoCliente getTipoCliente() {
		return tipoCliente;
	}

	public void setTipoCliente(TipoCliente tipoCliente) {
		this.tipoCliente = tipoCliente;
	}

	public DireccionCliente getDireccion() {
		return direccion;
	}

	public void setDireccion(DireccionCliente direccion) {
		this.direccion = direccion;
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

	public Date getFecha_nacimiento() {
		return fecha_nacimiento;
	}

	public void setFecha_nacimiento(Date fecha_nacimiento) {
		this.fecha_nacimiento = fecha_nacimiento;
	}

	public int getTelefono() {
		return telefono;
	}

	public void setTelefono(int telefono) {
		this.telefono = telefono;
	}

	public String getRut() {
		return rut;
	}

	public void setRut(String rut) {
		this.rut = rut;
	}

	public Date getFechaNacimiento() {
		return fecha_nacimiento;
	}

	public void setFechaNacimiento(Date fechaNacimiento) {
		this.fecha_nacimiento = fechaNacimiento;
	}

	public int getCantArriendos() {
		return arriendo.size();
	}

	public void setCantArriendos(int cantArriendos) {
		this.cant_compras = cantArriendos;
	}

	@Override
	public String toString() {
		return "Cliente [id=" + id + ", nombre=" + nombre + ", apellido_p=" + apellido_p + ", apellido_m=" + apellido_m
				+ ", telefono=" + telefono + ", rut=" + rut + ", fecha_nacimiento=" + fecha_nacimiento
				+ ", cant_compras=" + cant_compras + ", tipoCliente=" + tipoCliente + ", direccion=" + direccion + "]";
	}

	public List<Arriendo> getArriendo() {
		return arriendo;
	}

	public void setArriendo(List<Arriendo> arriendo) {
		this.arriendo = arriendo;
	}
	
	
	public String getNombreCompleto() {
		return nombre+" "+apellido_p+" "+apellido_m;
	}

	public void setNombreCompleto(String nombreCompleto) {
		this.nombreCompleto = nombreCompleto;
	}

	public int getCant_compras() {
		return arriendo.size();
	}

	public void setCant_compras(int cant_compras) {
		this.cant_compras = cant_compras;
	}
	
}
