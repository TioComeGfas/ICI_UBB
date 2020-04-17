package net.frodo.app.modelo;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "tipo_especialidad")
public class TipoEspecialidad {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String nombre;
	@Column(name="detalle")
	private String detalles;
	
	@OneToMany(mappedBy="tipoEspecialidad",fetch=FetchType.LAZY)
	private List<Mecanico> mecanicos;
	
	public TipoEspecialidad() {}

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

	public String getDetalles() {
		return detalles;
	}

	public void setDetalles(String detalles) {
		this.detalles = detalles;
	}

	public List<Mecanico> getMecanicos() {
		return mecanicos;
	}

	public void setMecanicos(List<Mecanico> mecanicos) {
		this.mecanicos = mecanicos;
	}
	
	
}
