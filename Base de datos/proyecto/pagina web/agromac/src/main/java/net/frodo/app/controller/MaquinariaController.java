package net.frodo.app.controller;

import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.frodo.app.modelo.Arriendo;
import net.frodo.app.modelo.DetalleArriendo;

import net.frodo.app.modelo.Mantencion;
import net.frodo.app.modelo.Maquinaria;
import net.frodo.app.modelo.TipoMaquinaria;
import net.frodo.app.service.IMaquinariaServices;

@Controller
@RequestMapping(value = "/maquinaria")
public class MaquinariaController {
	
	@Autowired
	private IMaquinariaServices maquinariaService;
	
	@GetMapping(value = "/tipo/general")
	public String mostrarTipoMaquinaria(Model model) {
		model.addAttribute("maquinaria",maquinariaService.getTipoMaquinaria());
		return "maquinaria/maquinariaT";
	}

	@GetMapping(value = "/general")
	public String mostrarMaquinaria(Model model) {
		model.addAttribute("maquinaria",maquinariaService.buscarTodas());
		return "maquinaria/maquinaria";
	}
	
	@GetMapping(value = "/crear")
	public String mostrarFormMaquinaria(Model model,@ModelAttribute Maquinaria maquinaria) {
		model.addAttribute("tipo",getTipos());
		return "maquinaria/form_maquinaria";
	}
	
	@GetMapping(value="/editar")
	public String editMaquinaria(Model model, @RequestParam("id_maquinaria") int id,@ModelAttribute Maquinaria maquinaria) {
		model.addAttribute("tipo",getTipos());
		model.addAttribute("maquinaria",maquinariaService.obtenerMaquinariaById(id));
		return "maquinaria/form_maquinaria";
	}
	
	@PostMapping(value="/save")
	public String saveMaquinaria(Model model,@ModelAttribute Maquinaria maquinaria,BindingResult result, HttpServletRequest request,
			RedirectAttributes attributes) {
		
		if (result.hasErrors()) {
			System.out.println("Existieron errores");
			return "maquinaria/form_cliente";
		}
		
		maquinaria.setTipoMaquinaria(maquinariaService.buscarTipoByReferencia(maquinaria.getTipoMaquinaria().getNombre()));
		
		maquinariaService.insertar(maquinaria);
		attributes.addFlashAttribute("msg", "Los datos fueron guardados exitosamente!");
		return "redirect:/maquinaria/general";
	}
	
	@GetMapping(value="/delete")
	public String deleteMquinaria(Model model,@RequestParam("id_maquinaria") int id,RedirectAttributes attributes) {
		maquinariaService.borrarPorID(id);
		attributes.addFlashAttribute("msg", "Los datos de la pelicula fueron eliminados exitosamente!");
		return "redirect:/maquinaria/general";
	}
	
	@GetMapping(value="/info")
	public String infoMaquinaria(Model model,@RequestParam("id_maquinaria") int id) {
		
		Maquinaria maq = maquinariaService.obtenerMaquinariaById(id);
		
		//insertamos solo los arriendos no repetidos
		List<DetalleArriendo> detArr = maq.getDetallesA();
		List<Arriendo> arr = new LinkedList<>();
		boolean existeArr;
		for(int i = 0; i < detArr.size(); i++){
			existeArr = false;
			for(int j = 0; j < arr.size(); j++) {
				if(detArr.get(i).getArriendo().getId() == arr.get(j).getId()) existeArr = true;
			}
			if(!existeArr) arr.add(detArr.get(i).getArriendo());
		}
		
		List<Mantencion> man = maq.getDetallesM();
		model.addAttribute("mantencion",man);
		model.addAttribute("arriendo",arr);
		model.addAttribute("maq",maq);

		return "maquinaria/info_maquinaria";
	}
	
	//valor para el select
	private List<String> getTipos(){
		List<TipoMaquinaria> tmp = maquinariaService.getTipoMaquinaria();
		List<String> lista = new LinkedList<>(); 
		for(int i=0; i < tmp.size();i++) {
			lista.add(tmp.get(i).getNombre());
		}
		return lista;
	}
	
}
