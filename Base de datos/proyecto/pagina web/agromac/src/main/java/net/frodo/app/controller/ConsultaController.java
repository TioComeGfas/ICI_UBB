package net.frodo.app.controller;

import java.util.LinkedList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import net.frodo.app.modelo.Empleado;
import net.frodo.app.modelo.Mecanico;
import net.frodo.app.service.IArriendoServices;
import net.frodo.app.service.IClienteServices;
import net.frodo.app.service.IEmpleadoServices;
import net.frodo.app.service.IMecanicoServices;

@Controller
@RequestMapping(value = "/consulta")
public class ConsultaController {

	@Autowired
	private IClienteServices clienteServicio;
	@Autowired
	private IEmpleadoServices empServicio;
	@Autowired
	private IMecanicoServices mecServicio;
	
	
	@GetMapping(value = "/general")
	public String mostrarPrincipalB(Model model) {
		model.addAttribute("cliente",clienteServicio.getClienteConsulta1());
		
		int acumMan = 0;
		List<Mecanico> mecanicos = mecServicio.buscarTodas();
		for(int i = 0; i < mecanicos.size();i++) {
			acumMan+= mecanicos.get(i).getMantenciones().size();
		}
		
		int prom = acumMan / mecanicos.size();
		for(int i = 0; i < mecanicos.size();i++) {
			if(mecanicos.get(i).getMantenciones().size() >= prom) mecanicos.remove(i);
		}
		List<Empleado> list = new LinkedList<>();
		for(int i = 0; i < mecanicos.size();i++) {
			list.add(empServicio.buscarTodoEmpledo(mecanicos.get(i).getId_empleado()));
		}
		
		model.addAttribute("emp",list);
		return "consulta";
	}
	
	
}
