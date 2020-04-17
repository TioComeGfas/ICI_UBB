package net.frodo.app.modelo;

import java.util.LinkedList;
import java.util.List;

import javax.persistence.Column;
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
import javax.transaction.Transactional;
import javax.validation.executable.ValidateOnExecution;

@Entity
@Table(name = "maquinaria")
public class Maquinaria {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;
	private String marca;
	private String modelo;
	private String patente;
	private int kilometraje;
	@Column(name = "valor_por_hora")
	private int valorPorHora;
	
	@ManyToOne
	@JoinColumn(name = "id_tipo_maquinaria")
	private TipoMaquinaria tipoMaquinaria;
	
	@OneToMany(mappedBy="maquinaria",fetch= FetchType.LAZY)
	private List<DetalleArriendo> detallesA;
	
	@OneToMany(mappedBy="maquinaria",fetch=FetchType.LAZY)
	private List<Mantencion> detallesM;
	
	public Maquinaria() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public TipoMaquinaria getTipoMaquinaria() {
		return tipoMaquinaria;
	}

	public void setTipoMaquinaria(TipoMaquinaria tipoMaquinaria) {
		this.tipoMaquinaria = tipoMaquinaria;
	}

	public String getMarca() {
		return marca;
	}

	public void setMarca(String marca) {
		this.marca = marca;
	}

	public String getModelo() {
		return modelo;
	}

	public void setModelo(String modelo) {
		this.modelo = modelo;
	}

	public String getPatente() {
		return patente;
	}

	public void setPatente(String patente) {
		this.patente = patente;
	}

	public int getKilometraje() {
		return kilometraje;
	}

	public void setKilometraje(int kilometraje) {
		this.kilometraje = kilometraje;
	}

	public int getValorPorHora() {
		return valorPorHora;
	}

	public void setValorPorHora(int valorPorHora) {
		this.valorPorHora = valorPorHora;
	}

	public List<DetalleArriendo> getDetallesA() {
		return detallesA;
	}

	public void setDetallesA(List<DetalleArriendo> detallesA) {
		this.detallesA = detallesA;
	}

	public List<Mantencion> getDetallesM() {
		return detallesM;
	}

	public void setDetallesM(List<Mantencion> detallesM) {
		this.detallesM = detallesM;
	}
	
}
