package com.example.report.controller;

import com.example.report.model.Jugador;
import com.example.report.repository.JugadorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession; // Asegúrate de importar HttpSession

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class DashboardController {

    @Autowired
    private JugadorRepository jugadorRepository;

    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        // Verificar si hay una sesión activa
        if (session.getAttribute("user") == null) {
            return "redirect:/auth/acceder"; // Redirige al login si no hay sesión
        }

        // Obtener la lista de jugadores
        List<Jugador> jugadores = jugadorRepository.findAll();
        model.addAttribute("jugadores", jugadores);

        // Calcular la cantidad de jugadores por equipo
        Map<String, Integer> jugadoresPorEquipo = new HashMap<>();
        for (Jugador jugador : jugadores) {
            String equipoNombre = jugador.getEquipo().getNombre(); // Obtener el nombre del equipo
            jugadoresPorEquipo.put(equipoNombre, jugadoresPorEquipo.getOrDefault(equipoNombre, 0) + 1);
        }
        model.addAttribute("jugadoresPorEquipo", jugadoresPorEquipo); // Añadir los datos al modelo

        return "dashboard"; // Retornar la vista del dashboard
    }
}
