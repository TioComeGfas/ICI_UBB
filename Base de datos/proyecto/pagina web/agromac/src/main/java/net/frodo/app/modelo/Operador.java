package net.frodo.app.modelo;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "operador")
public class Operador {

	@Id
	private int id_empleado;

	@Column(name = "tarifa_por_hora")
	private int tarifa;
	@Transient
	private String nombreCompleto;
	@Transient
	private int telefono;
	
	@OneToMany(mappedBy="operador",fetch=FetchType.EAGER)
	private List<DetalleArriendo> detalles;
	
	
	public String getNombreCompleto() {
		return nombreCompleto;
	}

	public void setNombreCompleto(String nombreCompleto) {
		this.nombreCompleto = nombreCompleto;
	}

	public Operador() {
	}

	public int getTarifa() {
		return tarifa;
	}

	public void setTarifa(int tarifa) {
		this.tarifa = tarifa;
	}

	public int getId_empleado() {
		return id_empleado;
	}

	public void setId_empleado(int id_empleado) {
		this.id_empleado = id_empleado;
	}

	public List<DetalleArriendo> getDetalles() {
		return detalles;
	}

	public void setDetalles(List<DetalleArriendo> detalles) {
		this.detalles = detalles;
	}

	public int getTelefono() {
		return telefono;
	}

	public void setTelefono(int telefono) {
		this.telefono = telefono;
	}

	
	

}
