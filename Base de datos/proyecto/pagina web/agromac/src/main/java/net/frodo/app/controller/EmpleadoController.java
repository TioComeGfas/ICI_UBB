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
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.frodo.app.modelo.Administrativo;
import net.frodo.app.modelo.Arriendo;
import net.frodo.app.modelo.Contrato;
import net.frodo.app.modelo.DetalleArriendo;
import net.frodo.app.modelo.Empleado;
import net.frodo.app.modelo.Encargado;
import net.frodo.app.modelo.Mantencion;
import net.frodo.app.modelo.Maquinaria;
import net.frodo.app.modelo.Mecanico;
import net.frodo.app.modelo.Operador;
import net.frodo.app.modelo.TipoEspecialidad;
import net.frodo.app.service.EmpleadoServicesJPA;
import net.frodo.app.service.IAdministrativoServices;
import net.frodo.app.service.IEmpleadoServices;
import net.frodo.app.service.IMecanicoServices;
import net.frodo.app.service.IOperadorServices;

@Controller
@RequestMapping(value = "/empleado")
public class EmpleadoController {
	
	@Autowired
	private IEmpleadoServices servicioEmpleado;
	@Autowired
	private IMecanicoServices servicioMecanico;
	@Autowired
	private IAdministrativoServices servicioAdministrativo;
	@Autowired
	private IOperadorServices servicioOperador;
	
	@GetMapping(value = "/general")
	public String mostrarEmpleado(Model model) {
		List<Empleado> lista = obtenerInfoGeneral();
		for(int i= 0; i < lista.size(); i++) {
			if(lista.get(i).getId() == 1) {
				lista.remove(i);
				break;
			}
		}
		model.addAttribute("emp",lista);
		return "empleado/empleado";
	}	
	
	@GetMapping(value = "/info")
	public String mostrarInfoEmpleado(Model model,@RequestParam("id_empleado") int id) {
		Empleado empleado = servicioEmpleado.buscarPorID(id);
		
		if(empleado.getTipo() == Empleado.MECANICO) {
			Mecanico mec = servicioEmpleado.buscarMecanicoByID(id);
			model.addAttribute("especialidad",servicioEmpleado.buscarTipoEspecialidadPorID(id));
			model.addAttribute("mantenciones",mec.getMantenciones());		
			model.addAttribute("mecanico",mec);
			
		}else if (empleado.getTipo() == Empleado.OPERADOR) {
			boolean exist = false;
			Operador operador = servicioEmpleado.buscarOperadorByID(id);
			List<DetalleArriendo> det = operador.getDetalles();
			List<Arriendo> arr = new LinkedList<>();
			for(int i=0; i < det.size(); i++) {
				for(int j=0; j < arr.size(); j++) {
					if(det.get(i).getArriendo() == arr.get(j)) exist = true;
				}
				if(!exist)arr.add(det.get(i).getArriendo());
			}
			model.addAttribute("arriendo",arr);
			model.addAttribute("operador",operador);
		}
		
		Contrato contrato = servicioEmpleado.buscarContratoByID(empleado.getContrato().getId());
		model.addAttribute("contrato",contrato);
		model.addAttribute("empleado",empleado);
		return "empleado/info_empleado";
	}
	
	@GetMapping(value = "/delete")
	public String eliminarEmpleado(Model model ,@RequestParam("id_empleado") int id,RedirectAttributes attributes) {
		servicioEmpleado.borrarPorID(id);
		attributes.addFlashAttribute("msg", "Los datos de la pelicula fueron eliminados exitosamente!");
		return "redirect:/empleado/general";
	}

	@GetMapping(value = "/crear")
	public String crearEmpleado(Model model,@ModelAttribute Empleado empleado) {
		return "empleado/form_empleado";
	}
	
	@GetMapping(value="/editar")
	public String editarEmpleado(Model model, @RequestParam("id_empleado") int id) {
		Empleado empleado = servicioEmpleado.buscarTodoEmpledo(id);
		model.addAttribute("empleado",empleado);
		
		return "empleado/form_empleado";
	}
	
	@PostMapping(value = "/save")
	public String saveEmpleado(@ModelAttribute Empleado empleado, BindingResult result, HttpServletRequest request,
			RedirectAttributes attributes, Model model) {

		if (result.hasErrors()) return "empleado/form_empleado";
		
		if(empleado.getNombre().length() > 20 || empleado.getApellido_p().length() > 20 || empleado.getApellido_m().length() > 20) {
			ObjectError error = new ObjectError("empleado","Ah superado el largo maximo del nombre o apellidos (max=20 caracteres)");
			result.addError(error);
			return "empleado/form_empleado";
		}
		
		boolean existe = servicioEmpleado.existe(empleado.getId());
		System.out.println(existe);
		
		if(empleado.getTipo() == Empleado.MECANICO) {
			TipoEspecialidad especialidad = new TipoEspecialidad();
			if(existe) especialidad = servicioMecanico.buscarPorID(empleado.getId()).getTipoEspecialidad();
			especialidad.setDetalles(empleado.getDetalleEspecialidad());
			especialidad.setNombre(empleado.getNombreEspecialidad());
			
			Mecanico mecanico= new Mecanico();
			if(existe) mecanico.setId_empleado(empleado.getId());
			mecanico.setTarifa_por_hora(empleado.getTarifa());
			mecanico.setTipoEspecialidad(especialidad);
			
			if(existe) servicioEmpleado.actualizarMecanico(empleado, mecanico, empleado.getContrato(), empleado.getDireccion());
			else servicioEmpleado.insertarMecanico(empleado, mecanico, empleado.getContrato(), empleado.getDireccion());	
		}else if(empleado.getTipo() == Empleado.ADMINISTRATIVO) {
			Administrativo admin = new Administrativo();
			if(existe) admin.setId_empleado(empleado.getId());
			admin.setTarifa(empleado.getTarifa());
			
			if(existe) servicioEmpleado.actualizarAdministrativo(empleado, admin, empleado.getContrato(), empleado.getDireccion());
			else servicioEmpleado.insertarAdministrativo(empleado, admin, empleado.getContrato(), empleado.getDireccion());
		}else {
			
			if(empleado.getTarifa() < 5000 || empleado.getTarifa() > 8000) {
				ObjectError error = new ObjectError("empleado","Recuerde que la tarifa del operador debe ser entre $5000 y $8000");
				result.addError(error);
				return "empleado/form_empleado";
			}
			
			Operador operador = new Operador();
			if(existe) operador.setId_empleado(empleado.getId());
			operador.setTarifa(empleado.getTarifa());
			if(existe) servicioEmpleado.actualizarOperador(empleado, operador, empleado.getContrato(), empleado.getDireccion());
			else servicioEmpleado.insertarOperador(empleado, operador, empleado.getContrato(), empleado.getDireccion());
		}
		
		attributes.addFlashAttribute("msg", "Los datos fueron guardados exitosamente!");
		return "redirect:/empleado/general";
	}
	
	private List<Empleado> obtenerInfoGeneral(){
		List<Empleado> list1 = servicioEmpleado.buscarInformacionAdministrativo();
		List<Empleado> list2 = servicioEmpleado.buscarInformacionMecanico();
		List<Empleado> list3 = servicioEmpleado.buscarInformacionOperador();
		List<Empleado> exit = new LinkedList<>();
		
		exit.addAll(list1);
		exit.addAll(list2);
		exit.addAll(list3);
		
		return exit;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder webDataBinder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		webDataBinder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
}
