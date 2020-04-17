package net.frodo.app.modelo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

@Entity
@Table(name = "administrativo")
public class Administrativo {

	@Id
	private int id_empleado;

	@Column(name = "tarifa_por_hora")
	private int tarifa;

	public Administrativo() {
	}

	public int getTarifa() {
		return tarifa;
	}

	public int getId_empleado() {
		return id_empleado;
	}

	public void setId_empleado(int id_empleado) {
		this.id_empleado = id_empleado;
	}

	public void setTarifa(int tarifa) {
		this.tarifa = tarifa;
	}

}
