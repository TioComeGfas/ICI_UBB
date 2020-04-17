package net.frodo.app.modelo;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "tipo_maquinaria")
public class TipoMaquinaria {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private String nombre;
	
	@OneToMany(mappedBy="tipoMaquinaria",fetch=FetchType.LAZY)
	private List<Maquinaria> maquinarias;
	
	public TipoMaquinaria() {}

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

	public List<Maquinaria> getMaquinarias() {
		return maquinarias;
	}

	public void setMaquinarias(List<Maquinaria> maquinarias) {
		this.maquinarias = maquinarias;
	}
	
	
	
}
