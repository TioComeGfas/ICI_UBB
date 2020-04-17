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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.frodo.app.modelo.Contrato;
import net.frodo.app.modelo.Empleado;
import net.frodo.app.service.IContratoServices;

@Controller
@RequestMapping(value = "/contrato")
public class ContratoController {
	
	@Autowired
	private IContratoServices contratoService;
	
	@GetMapping(value = "/general")
	public String mostrarContrato(Model model) {
		List<Empleado> emp = contratoService.getEmpleados();
		for(int i= 0; i < emp.size(); i++) {
			if(emp.get(i).getId() == 1) {
				emp.remove(i);
				break;
			}
		}
		model.addAttribute("contrato",emp);
		return "contrato/contrato";
	}
	
	@PostMapping(value="/save")
	public String guardarContrato(@ModelAttribute Contrato contrato,Model model,BindingResult result, HttpServletRequest request,
			RedirectAttributes attributes) {
		if (result.hasErrors()) {
			System.out.println("Existieron errores");
			return "contrato/form_contrato";
		}
		contratoService.insertar(contrato);
		attributes.addFlashAttribute("msg", "Los datos fueron guardados exitosamente!");
		return "redirect:/contrato/general";
	}
	
	@GetMapping(value="/editar")
	public String updateContrato(@RequestParam("id_contrato") int id,Model model) {
		model.addAttribute("contrato",contratoService.getContratoByID(id));
		return "contrato/form_contrato";
	}
	
	@GetMapping(value="/delete")
	public String deleteContrato(@RequestParam("id_contrato") int id,Model model,RedirectAttributes attributes) {
		contratoService.borrarPorID(id);
		attributes.addFlashAttribute("msg", "insertar algo!!!");
		return "redirect:/contrato/general";
	}

	@InitBinder
	public void initBinder(WebDataBinder webDataBinder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		webDataBinder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
	
}
