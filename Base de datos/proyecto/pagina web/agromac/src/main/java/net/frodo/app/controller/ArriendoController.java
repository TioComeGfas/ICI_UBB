package net.frodo.app.controller;

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

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.frodo.app.modelo.Arriendo;
import net.frodo.app.modelo.Cliente;
import net.frodo.app.modelo.DetalleArriendo;
import net.frodo.app.modelo.DireccionArriendo;
import net.frodo.app.modelo.Encargado;
import net.frodo.app.modelo.Maquinaria;
import net.frodo.app.modelo.Operador;
import net.frodo.app.service.IArriendoServices;
import net.frodo.app.service.IClienteServices;
import net.frodo.app.service.MaquinariaServicesJPA;

@Controller
@RequestMapping(value = "/arriendo")
public class ArriendoController {

	@Autowired
	private IArriendoServices arriendoServicio;
	@Autowired
	private IClienteServices clienteServicio;

	int costMaq = 0;
	int costOpe = 0;

	@GetMapping(value = "/general")
	public String mostrarArriendo(Model model) {
		List<Arriendo> aux = arriendoServicio.buscarArriendos();
		for (int i = 0; i < aux.size(); i++) {
			List<DetalleArriendo> tmp = aux.get(i).getDetalles();
			int total = 0;
			for (int j = 0; j < tmp.size(); j++) {
				total += ((tmp.get(j).getMaquinaria().getValorPorHora() + tmp.get(j).getOperador().getTarifa())
						* aux.get(i).getHorasArriendo());
			}
			aux.get(i).setValorTotal(total);
		}
		model.addAttribute("arriendo", aux);
		return "arriendo/arriendo";
	}

	@GetMapping(value = "/crear")
	public String crearArriendo(@ModelAttribute Arriendo arriendo, Model model) {
		model.addAttribute("estadosS", getEstados());
		List<Cliente> list = arriendoServicio.buscarClientes();
		model.addAttribute("clientesS", list);
		model.addAttribute("operadoresS", updateOperadorLite(arriendoServicio.buscarOperador()));
		model.addAttribute("maquinariasS", arriendoServicio.buscarMaquinaria());
		return "arriendo/form_arriendo";
	}

	@GetMapping(value = "/editar")
	public String editarArriendo(@RequestParam("id_arriendo") int id, @ModelAttribute Arriendo arriendo, Model model) {

		arriendo = arriendoServicio.buscarArriendo(id);

		List<DetalleArriendo> det = arriendo.getDetalles();
		List<Maquinaria> tmp = new LinkedList<>();
		List<Operador> tmp2 = new LinkedList<>();

		for (int i = 0; i < det.size(); i++) {
			tmp.add(det.get(i).getMaquinaria());
			tmp2.add(det.get(i).getOperador());
		}

		arriendo.setMaquinas(tmp);
		arriendo.setOperadores(tmp2);

		model.addAttribute("arriendo", arriendo);
		model.addAttribute("maquina", tmp);
		model.addAttribute("operador", tmp2);
		model.addAttribute("cliente", arriendo.getCliente());
		model.addAttribute("estado", arriendo.getEstado());
		// select
		model.addAttribute("estadosS", getEstados());
		model.addAttribute("clientesS", arriendoServicio.buscarClientes());

		List<Operador> aux2 = updateOperadorLite(arriendoServicio.buscarOperador());
		for (int i = 0; i < tmp2.size(); i++) {
			aux2.remove(tmp2.get(i));
		}
		model.addAttribute("operadoresS", aux2);

		List<Maquinaria> aux = arriendoServicio.buscarMaquinaria();
		for (int i = 0; i < tmp.size(); i++) {
			aux.remove(tmp.get(i));
		}
		model.addAttribute("maquinariasS", aux);
		return "arriendo/form_arriendo";
	}

	@PostMapping(value = "/save")
	public String guardarArriendo(@ModelAttribute Arriendo arriendo, BindingResult result, HttpServletRequest request,
			RedirectAttributes attributes, Model model) {

		if (result.hasErrors()) {
			model = poblarSelect(model, arriendo.getIdCliente());
			return "arriendo/form_arriendo";
		}

		int[] idsMaq = arriendo.getArrayMaquinas();
		int[] idsOpe = arriendo.getArrayOperadores();

		if (idsMaq.length != idsOpe.length) {
			ObjectError error = new ObjectError("arriendo",
					"No ingreso la misma cantidad de operadores y maquinarias... recuerde que cada maquina debe tener un operador");
			result.addError(error);
			model = poblarSelect(model, arriendo.getIdCliente());
			return "arriendo/form_arriendo";
		}

		arriendo.setEstado(arriendoServicio.buscarEstadoByReferecia(arriendo.getEstado().getDescripcion()));

		arriendo.setCliente(arriendoServicio.buscarClienteByID(arriendo.getIdCliente()));

		if (clienteServicio.getEncargado(arriendo.getIdCliente()) == null) {
			if (!verificarEncargado(idsOpe)) {
				ObjectError error = new ObjectError("arriendo",
						"El cliente seleccionado no posee encargado, por favor registrar encargado si es necesario");
				result.addError(error);
				model = poblarError(model);
				return "arriendo/form_arriendo";
			}
		}

		List<DetalleArriendo> list = arriendoServicio.getDetallesByID(arriendo.getId());

		if (list.size() == idsMaq.length) {
			for (int i = 0; i < idsMaq.length; i++) {
				Maquinaria maquinaria = new Maquinaria();
				maquinaria.setId(idsMaq[i]);

				Operador operador = new Operador();
				operador.setId_empleado(idsOpe[i]);

				list.get(i).setMaquinaria(maquinaria);
				list.get(i).setOperador(operador);
				list.get(i).setArriendo(arriendo);
				arriendoServicio.insertar(list.get(i));
			}

		} else if (list.size() > idsMaq.length) {
			int cantDet = list.size();
			for (int i = 0; i < idsMaq.length; i++) {
				Maquinaria maquinaria = new Maquinaria();
				maquinaria.setId(idsMaq[i]);

				Operador operador = new Operador();
				operador.setId_empleado(idsOpe[i]);

				list.get(i).setMaquinaria(maquinaria);
				list.get(i).setOperador(operador);
				list.get(i).setArriendo(arriendo);
				arriendoServicio.insertar(list.get(i));
				cantDet--;
			}

			for (int i = cantDet; i < list.size(); i++)
				arriendoServicio.borrarDetalleByID(list.get(i).getId());

		} else {

			for (int i = 0; i < list.size(); i++) {
				Maquinaria maquinaria = new Maquinaria();
				maquinaria.setId(idsMaq[i]);

				Operador operador = new Operador();
				operador.setId_empleado(idsOpe[i]);

				list.get(i).setMaquinaria(maquinaria);
				list.get(i).setOperador(operador);
				list.get(i).setArriendo(arriendo);
				arriendoServicio.insertar(list.get(i));
			}

			for (int i = list.size(); i < idsMaq.length; i++) {
				DetalleArriendo detalle = new DetalleArriendo();

				Maquinaria maquinaria = new Maquinaria();
				maquinaria.setId(idsMaq[i]);

				Operador operador = new Operador();
				operador.setId_empleado(idsOpe[i]);

				detalle.setMaquinaria(maquinaria);
				detalle.setOperador(operador);
				detalle.setArriendo(arriendo);
				arriendoServicio.insertar(detalle);
			}

		}
		return "redirect:/arriendo/general";
	}

	@GetMapping("/delete")
	public String eliminarArriendo(Model model, @RequestParam("id_arriendo") int id, RedirectAttributes attributes) {
		arriendoServicio.borrarPorID(id);
		attributes.addFlashAttribute("msg", "Los datos de la pelicula fueron eliminados exitosamente!");
		return "redirect:/arriendo/general";
	}

	@GetMapping(value = "/info")
	public String infoArriendo(Model model, @RequestParam("id_arriendo") int id) {
		Arriendo arriendo = arriendoServicio.buscarArriendo(id);
		List<DetalleArriendo> list = arriendo.getDetalles();
		List<Maquinaria> maq = new LinkedList<>();
		List<Operador> ope = new LinkedList<>();

		costMaq = 0;
		costOpe = 0;

		for (int i = 0; i < list.size(); i++) {
			maq.add(list.get(i).getMaquinaria());
			costMaq += list.get(i).getMaquinaria().getValorPorHora() * arriendo.getHorasArriendo();
			ope.add(list.get(i).getOperador());
		}

		Encargado encargado = clienteServicio.getEncargado(arriendo.getCliente().getId());
		if (encargado != null)
			encargado.setNombreCompleto(encargado.getNombre() + " " + encargado.getApellidoPaterno() + " "
					+ encargado.getApellidoMaterno());

		model.addAttribute("encargado", encargado);
		model.addAttribute("operadores", updateOperador(ope, arriendo.getHorasArriendo()));
		model.addAttribute("arriendo", arriendo);
		model.addAttribute("maquinarias", maq);
		model.addAttribute("detalles", list);
		model.addAttribute("totalMaq", costMaq);
		model.addAttribute("totalArr", (costMaq + costOpe));
		model.addAttribute("totalOpe", costOpe);

		return "arriendo/info_arriendo";
	}

	@InitBinder
	public void initBinder(WebDataBinder webDataBinder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		webDataBinder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

	private List<Operador> updateOperador(List<Operador> list, int hrs) {
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getId_empleado() != 1) {
				list.get(i).setNombreCompleto(arriendoServicio.buscarNombreOperador(list.get(i).getId_empleado()));
				list.get(i).setTelefono(arriendoServicio.buscarTelefonoOperador(list.get(i).getId_empleado()));
				costOpe += list.get(i).getTarifa() * hrs;
			} else {
				list.remove(i);
			}
		}
		return list;
	}

	private List<Operador> updateOperadorLite(List<Operador> list) {
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setNombreCompleto(arriendoServicio.buscarNombreOperador(list.get(i).getId_empleado()));
			list.get(i).setTelefono(arriendoServicio.buscarTelefonoOperador(list.get(i).getId_empleado()));
		}
		return list;
	}

	private Model poblarSelect(Model model, int idCliente) {
		model.addAttribute("estadosS", getEstados());

		List<Cliente> list = arriendoServicio.buscarClientes();
		for (int i = 0; i < list.size(); i++)
			if (idCliente == list.get(i).getId())
				list.remove(i);
		model.addAttribute("clientesS", list);
		model.addAttribute("operadoresS", updateOperador(arriendoServicio.buscarOperador(), 0));
		model.addAttribute("maquinariasS", arriendoServicio.buscarMaquinaria());
		return model;
	}

	private Model poblarError(Model model) {
		model.addAttribute("estadosS", getEstados());
		List<Cliente> list = arriendoServicio.buscarClientes();
		model.addAttribute("clientesS", list);
		model.addAttribute("operadoresS", updateOperador(arriendoServicio.buscarOperador(), 0));
		model.addAttribute("maquinariasS", arriendoServicio.buscarMaquinaria());
		return model;
	}

	private List<String> getEstados() {
		List<String> tmp = new LinkedList<>();
		tmp.add("en proceso");
		tmp.add("a tiempo");
		tmp.add("atrasado");
		tmp.add("con desperfecto");
		return tmp;
	}

	private boolean verificarEncargado(int[] array) {
		for (int i = 0; i < array.length; i++)
			if (array[i] == 1)
				return false;
		return true;
	}
}
