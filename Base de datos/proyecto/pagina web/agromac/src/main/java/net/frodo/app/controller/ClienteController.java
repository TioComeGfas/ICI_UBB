package net.frodo.app.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.frodo.app.modelo.Arriendo;
import net.frodo.app.modelo.Cliente;
import net.frodo.app.modelo.DetalleArriendo;
import net.frodo.app.modelo.Empleado;
import net.frodo.app.modelo.Encargado;
import net.frodo.app.modelo.TipoCliente;
import net.frodo.app.service.IClienteServices;

@Controller
@RequestMapping(value = "/cliente")
public class ClienteController {

	@Autowired
	private IClienteServices clienteServicio;

	@GetMapping(value = "/crear")
	public String crearCliente(@ModelAttribute Encargado encargado, Model model) {
		return "cliente/form_cliente";
	}

	@GetMapping(value = "/general")
	public String mostrarClientes(Model model) {
		model.addAttribute("info_clientes", updateCliente(clienteServicio.buscarTodas()));
		return "cliente/clienteA";
	}

	@GetMapping(value = "/editar")
	public String mostrarEditCliente(Model model,@ModelAttribute Encargado encargado, @RequestParam("id_cliente") int id) {
		Encargado enc = clienteServicio.getEncargado(id);
		Cliente cliente = clienteServicio.buscarPorID(id);
		if (enc == null) enc = new Encargado();
		encargado.setCliente(cliente);
		model.addAttribute("encargado", enc);
		model.addAttribute("cliente", cliente);
		return "cliente/form_cliente";
	}

	@GetMapping(value = "/info")
	public String mostrarInfoCliente(Model model, @RequestParam("id_cliente") int id) {
		Encargado encargado = clienteServicio.getEncargado(id);
		if (encargado != null) {
			encargado.setNombreCompleto(encargado.getNombre()+" "+encargado.getApellidoPaterno()+" "+encargado.getApellidoMaterno()); 
		}
		model.addAttribute("encargado", encargado);
		
		model.addAttribute("cliente", clienteServicio.buscarPorID(id));
		return "cliente/info_cliente";
	}

	@PostMapping(value = "/save")
	public String saveCliente(@ModelAttribute Encargado encargado, BindingResult result, HttpServletRequest request,
			RedirectAttributes attributes, Model model) {

		if (result.hasErrors()) {
			return "cliente/form_cliente";
		}
		
		if(encargado.getCliente().getId() == 0) encargado.getCliente().setTipoCliente(clienteServicio.getTipoClienteNew(1));
		clienteServicio.insertarEncargado(encargado);
		attributes.addFlashAttribute("msg", "Los datos fueron guardados exitosamente!");

		return "redirect:/cliente/general";
	}
	
	@GetMapping(value="/delete")
	public String deleteCliente(Model model ,@RequestParam("id_cliente") int id,RedirectAttributes attributes) {
		clienteServicio.borrarPorID(id);
		attributes.addFlashAttribute("msg", "Los datos de la pelicula fueron eliminados exitosamente!");
		return "redirect:/cliente/general";
	}
	
	
	private List<Cliente> updateCliente(List<Cliente> list) {
		for (int i = 0; i < list.size(); i++) {
			String nombre = list.get(i).getNombre() + " " + list.get(i).getApellido_p() + " "
					+ list.get(i).getApellido_m();
			//formato al rut
			String rutC = list.get(i).getRut();
			String runExit = "";
			for(int j=0; j < rutC.length() ; j++) {
				runExit = runExit+""+rutC.charAt(j);
				if(j==1 || j==4) runExit = runExit+".";
				if(j== 7) runExit = runExit+"-";
			}
			
			list.get(i).setRut(runExit);
			list.get(i).setNombreCompleto(nombre);
		}
		return list;
	}

	@InitBinder
	public void initBinder(WebDataBinder webDataBinder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		webDataBinder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

}
