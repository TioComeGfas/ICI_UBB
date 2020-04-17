package net.frodo.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

	@GetMapping(value = "/")
	public String mostrarPrincipal(Model model) {
		return "login";
	}

	@GetMapping(value = "/home")
	public String mostrarPrincipalB(Model model) {
		return "starter";
	}

}
