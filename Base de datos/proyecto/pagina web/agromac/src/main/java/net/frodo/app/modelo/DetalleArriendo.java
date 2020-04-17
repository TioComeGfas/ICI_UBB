package net.frodo.app.modelo;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="detalle_arriendo")
public class DetalleArriendo{
	
	//@EmbeddedId
	//private DetalleArriendoPk pkey;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private int valor_total;
	@Transient
	private int[] maquinarias;
	
	@ManyToOne
	@JoinColumn(name="id_arriendo")
	private Arriendo arriendo;
	
	@ManyToOne
	@JoinColumn(name="id_maquinaria")
	private Maquinaria maquinaria;
	
	@ManyToOne
	@JoinColumn(name="id_operador")
	private Operador operador;

	public Arriendo getArriendo() {
		return arriendo;
	}

	public void setArriendo(Arriendo arriendo) {
		this.arriendo = arriendo;
	}

	public Operador getOperador() {
		return operador;
	}

	public void setOperador(Operador operador) {
		this.operador = operador;
	}

	public Maquinaria getMaquinaria() {
		return maquinaria;
	}

	public void setMaquinaria(Maquinaria maquinaria) {
		this.maquinaria = maquinaria;
	}

	public DetalleArriendo() {
	}

	public int getValor_total() {
		return valor_total;
	}

	public void setValor_total(int valor_total) {
		this.valor_total = valor_total;
	}

	/*
	public DetalleArriendoPk getPkey() {
		return pkey;
	}

	public void setPkey(DetalleArriendoPk pkey) {
		this.pkey = pkey;
	}	
	*/
	
	public int[] getMaquinarias() {
		return maquinarias;
	}

	public void setMaquinarias(int[] maquinarias) {
		this.maquinarias = maquinarias;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	
}
