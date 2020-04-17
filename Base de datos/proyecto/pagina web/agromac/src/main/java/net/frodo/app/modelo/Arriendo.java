package net.frodo.app.modelo;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "arriendo")
public class Arriendo {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	@Column(name = "fecha_inicio")
	private Date fechaInicio;
	@Column(name = "fecha_termino")
	private Date fechaTermino;
	@Column(name = "horas_arriendo")
	private int horasArriendo;

	@OneToOne
	@JoinColumn(name = "id_direccion")
	private DireccionArriendo direccion;

	@ManyToOne
	@JoinColumn(name = "id_cliente")
	private Cliente cliente;

	@ManyToOne
	@JoinColumn(name = "id_estado")
	private Estado estado;

	@OneToMany(mappedBy = "arriendo", fetch = FetchType.LAZY)
	private List<DetalleArriendo> detalles;

	@Transient
	private List<Maquinaria> maquinas;

	@Transient
	private List<Operador> operadores;

	@Transient
	private int[] arrayMaquinas;
	
	@Transient
	private int[] arrayOperadores;
	
	@Transient
	private int idCliente;

	@Transient
	private int valorTotal = 0;

	public Arriendo() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public DireccionArriendo getDireccion() {
		return direccion;
	}

	public void setDireccion(DireccionArriendo direccion) {
		this.direccion = direccion;
	}

	public Cliente getCliente() {
		return cliente;
	}

	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}

	public Estado getEstado() {
		return estado;
	}

	public void setEstado(Estado estado) {
		this.estado = estado;
	}

	public Date getFechaInicio() {
		return fechaInicio;
	}

	public void setFechaInicio(Date fechaInicio) {
		this.fechaInicio = fechaInicio;
	}

	public Date getFechaTermino() {
		return fechaTermino;
	}

	public void setFechaTermino(Date fechaTermino) {
		this.fechaTermino = fechaTermino;
	}

	public int getHorasArriendo() {
		return horasArriendo;
	}

	public void setHorasArriendo(int horasArriendo) {
		this.horasArriendo = horasArriendo;
	}

	public List<DetalleArriendo> getDetalles() {
		return detalles;
	}

	public void setDetalles(List<DetalleArriendo> detalles) {
		this.detalles = detalles;
	}

	public List<Maquinaria> getMaquinas() {
		return maquinas;
	}

	public void setMaquinas(List<Maquinaria> maquinas) {
		this.maquinas = maquinas;
	}

	public int getValorTotal() {
		return valorTotal;
	}

	public void setValorTotal(int valorTotal) {
		this.valorTotal = valorTotal;
	}

	public int[] getArrayMaquinas() {
		return arrayMaquinas;
	}

	public void setArrayMaquinas(int[] arrayMaquinas) {
		this.arrayMaquinas = arrayMaquinas;
	}

	public List<Operador> getOperadores() {
		return operadores;
	}

	public void setOperadores(List<Operador> operadores) {
		this.operadores = operadores;
	}

	public int[] getArrayOperadores() {
		return arrayOperadores;
	}

	public void setArrayOperadores(int[] arrayOperadores) {
		this.arrayOperadores = arrayOperadores;
	}

	public int getIdCliente() {
		return idCliente;
	}

	public void setIdCliente(int idCliente) {
		this.idCliente = idCliente;
	}
	
	

}
