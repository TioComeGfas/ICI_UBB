package net.frodo.app.modelo;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "mecanico")
public class Mecanico{

	@Id
	private int id_empleado;
	
	@Column(name="tarifa_por_hora")
	private int tarifa_por_hora;
	
	@Transient
	private String nombreCompleto;
	
	@ManyToOne
	@JoinColumn(name = "id_tipo_especialidad")
	private TipoEspecialidad tipoEspecialidad;
	
	@OneToMany(mappedBy="mecanico",fetch=FetchType.LAZY)
	private List<Mantencion> mantenciones;

	public Mecanico() {
	}

	public int getId_empleado() {
		return id_empleado;
	}

	public void setId_empleado(int id_empleado) {
		this.id_empleado = id_empleado;
	}

	public int getTarifa_por_hora() {
		return tarifa_por_hora;
	}

	public void setTarifa_por_hora(int tarifa_por_hora) {
		this.tarifa_por_hora = tarifa_por_hora;
	}

	public TipoEspecialidad getTipoEspecialidad() {
		return tipoEspecialidad;
	}

	public void setTipoEspecialidad(TipoEspecialidad tipoEspecialidad) {
		this.tipoEspecialidad = tipoEspecialidad;
	}

	public List<Mantencion> getMantenciones() {
		return mantenciones;
	}

	public void setMantenciones(List<Mantencion> mantenciones) {
		this.mantenciones = mantenciones;
	}

	public String getNombreCompleto() {
		return nombreCompleto;
	}

	public void setNombreCompleto(String nombreCompleto) {
		this.nombreCompleto = nombreCompleto;
	}

	
	
}
