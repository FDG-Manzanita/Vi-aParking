package com.example.report.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.report.model.User;
import com.example.report.repository.UserRepository;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/auth")
public class AuthController {
    @Autowired
    private UserRepository userRepository;

    @GetMapping("/acceder")
    public String login() {
        return "login"; // Retorna la vista de login
    }

    @PostMapping("/acceder")
    public String login(User user, HttpSession session, Model model) {
        User dbUser = userRepository.findByEmail(user.getEmail());
        if (dbUser != null && dbUser.getPassword().equals(user.getPassword())) {
            session.setAttribute("user", dbUser);
            return "redirect:/dashboard"; // Redirige a dashboard si las credenciales son correctas
        }
        model.addAttribute("error", "Credenciales incorrectas");
        return "login"; // Retorna a la vista de login si hay un error
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // Invalida la sesión
        return "redirect:/auth/acceder"; // Redirige al login
    }
}
