package net.frodo.app.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
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

import net.frodo.app.modelo.Empleado;
import net.frodo.app.modelo.Mantencion;
import net.frodo.app.modelo.Mecanico;
import net.frodo.app.service.IMantencionServices;
import net.frodo.app.service.MantencionServicesJPA;

@Controller
@RequestMapping(value = "/mantencion")
public class MantencionController {

	@Autowired
	private IMantencionServices mantencionServices;

	@GetMapping(value = "/general")
	public String mostrarMantencion(Model model) {
		List<Mantencion> man = mantencionServices.buscarTodas();
		Date fecha = new Date();
		model.addAttribute("mantencion", man);
		model.addAttribute("fechaActual", fecha);
		return "mantencion/mantencion";
	}

	@GetMapping(value = "/tipo")
	public String mostrarTipoMantencion(Model model) {
		model.addAttribute("mantencion", mantencionServices.buscarAllTipos());
		return "mantencion/mantencionT";
	}
	
	@GetMapping(value="/editar")
	public String editarMantencion(Model model, @ModelAttribute Mantencion mantencion,@RequestParam("id_mantencion") int id) {
		
		Mantencion m = mantencionServices.buscarPorID(id);
		model.addAttribute("man",m);
		
		model.addAttribute("tipos", mantencionServices.buscarAllTipos());
		model.addAttribute("mecanicos", updateMecanico(mantencionServices.buscarMecanicos()));
		model.addAttribute("maquinarias", mantencionServices.buscarMaquinarias());
		model.addAttribute("mantenciones",mantencionServices.buscarTodas());
		return "mantencion/form_mantencion";
	}

	@GetMapping(value = "/crear")
	public String crearMantencion(Model model, @ModelAttribute Mantencion mantencion) {
		model.addAttribute("tipos", mantencionServices.buscarAllTipos());
		model.addAttribute("mecanicos", updateMecanico(mantencionServices.buscarMecanicos()));
		model.addAttribute("maquinarias", mantencionServices.buscarMaquinarias());
		model.addAttribute("mantenciones",mantencionServices.buscarTodas());
		return "mantencion/form_mantencion";
	}

	@PostMapping(value = "/save")
	public String guardarMantencion(@ModelAttribute Mantencion mantencion, BindingResult result,
			HttpServletRequest request, RedirectAttributes attributes, Model model) {

		if (result.hasErrors())
			return "mantencion/form_mantencion";
		
		mantencion.setMaquinaria(mantencionServices.buscarMaqByID(mantencion.getIdMaquina()));
		mantencion.setMecanico(mantencionServices.buscarMecByID(mantencion.getIdMecanico()));
		mantencion.setTipoMantencion(mantencionServices.buscarTipoByID(mantencion.getIdTipo()));

		mantencionServices.insertar(mantencion);
		

		return "redirect:/mantencion/general";
	}

	@GetMapping(value = "/delete")
	public String eliminarMantencion(Model model, @RequestParam("id_mantencion") int id,
			RedirectAttributes attributes) {

		mantencionServices.borrarPorID(id);
		return "redirect:/mantencion/general";
	}
	
	@GetMapping(value = "/info")
	public String infoMantencion(Model model, @RequestParam("id_mantencion") int id,
			RedirectAttributes attributes) {

		Mantencion mantencion = mantencionServices.buscarPorID(id);
	
		Empleado empleado = mantencionServices.buscarMecanicoByID(mantencion.getMecanico().getId_empleado());
		empleado.setTarifa(mantencion.getMecanico().getTarifa_por_hora());
		
		model.addAttribute("maq",mantencion.getMaquinaria());
		model.addAttribute("tipo",mantencion.getTipoMantencion());
		model.addAttribute("mec",empleado);
		model.addAttribute("man",mantencion);
		
		return "mantencion/info_mantencion";
	}

	private List<Mecanico> updateMecanico(List<Mecanico> list) {
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setNombreCompleto(mantencionServices.buscarInfoMecanicoByID(list.get(i).getId_empleado()));
		}
		return list;
	}

	@InitBinder
	public void initBinder(WebDataBinder webDataBinder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		webDataBinder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
}