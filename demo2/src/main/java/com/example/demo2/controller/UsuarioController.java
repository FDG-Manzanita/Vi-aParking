package com.example.demo2.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo2.Repository.UsuarioRepository;
import com.example.demo2.model.Usuario;

@RestController
@RequestMapping("/api/usuarios")
@CrossOrigin(origins = "*") // Permitir CORS
public class UsuarioController {

    private final UsuarioRepository usuarioRepository;

    // Constructor para inicializar usuarioRepository
    public UsuarioController(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    // Método para verificar credenciales y tipo de usuario
    public boolean verificarCredenciales(String email, String contraseña) {
        Optional<Usuario> usuarioOpt = usuarioRepository.findByEmail(email);
        if (usuarioOpt.isPresent()) {
            Usuario usuario = usuarioOpt.get();
            // Verificar contraseña y tipo de usuario
            return usuario.getContraseña().equals(contraseña) && usuario.getTipoUsuario() == 2;
        }
        return false;
    }

    // Endpoint para autenticación, solo permite usuarios con tipoUsuario = 2
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestParam String email, @RequestParam String contraseña) {
        boolean autenticado = verificarCredenciales(email, contraseña);
        if (autenticado) {
            return ResponseEntity.ok("Login exitoso");
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Credenciales inválidas o usuario no autorizado");
        }
    }

    // Obtener todos los usuarios
    @GetMapping
    public List<Usuario> getAllUsuarios() {
        return usuarioRepository.findAll();
    }

    // Obtener un usuario por su id
    @GetMapping("/{id}")
    public ResponseEntity<Usuario> getUsuarioById(@PathVariable Integer id) {
        Optional<Usuario> usuario = usuarioRepository.findById(id);
        return usuario.map(ResponseEntity::ok).orElseGet(() -> ResponseEntity.notFound().build());
    }

    // Obtener usuarios por TipoUsuario sin cambiar el repositorio
    @GetMapping("/buscarPorTipo")
    public ResponseEntity<List<Usuario>> buscarUsuariosPorTipo(@RequestParam("tipoUsuario") short tipoUsuario) {
        List<Usuario> usuarios = usuarioRepository.findAll();
        List<Usuario> usuariosFiltrados = usuarios.stream()
                .filter(usuario -> usuario.getTipoUsuario() == tipoUsuario)
                .toList();
        if (usuariosFiltrados.isEmpty()) {
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        }
        return new ResponseEntity<>(usuariosFiltrados, HttpStatus.OK);
    }

    // Crear un nuevo usuario
    @PostMapping
    public ResponseEntity<Usuario> createUsuario(@RequestBody Usuario usuario) {
        try {
            Usuario nuevoUsuario = usuarioRepository.save(usuario);
            return new ResponseEntity<>(nuevoUsuario, HttpStatus.CREATED);
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // Actualizar un usuario existente
    @PutMapping("/{id}")
    public ResponseEntity<Usuario> updateUsuario(@PathVariable Integer id, @RequestBody Usuario usuarioDetails) {
        Optional<Usuario> existingUsuario = usuarioRepository.findById(id);
        if (existingUsuario.isPresent()) {
            Usuario usuario = existingUsuario.get();
            usuario.setNombre(usuarioDetails.getNombre());
            usuario.setApellido(usuarioDetails.getApellido());
            usuario.setTelefono(usuarioDetails.getTelefono());
            usuario.setContraseña(usuarioDetails.getContraseña());
            usuario.setResidenteTipo(usuarioDetails.getResidenteTipo());
            usuario.setDireccion(usuarioDetails.getDireccion());
            usuario.setEmail(usuarioDetails.getEmail());
            usuario.setSector(usuarioDetails.getSector());
            usuario.setTipoUsuario(usuarioDetails.getTipoUsuario());
            usuario.setCedulaPas(usuarioDetails.getCedulaPas());
            return new ResponseEntity<>(usuarioRepository.save(usuario), HttpStatus.OK);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }

    // Eliminar un usuario por su id
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUsuario(@PathVariable Integer id) {
        if (usuarioRepository.existsById(id)) {
            usuarioRepository.deleteById(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        }
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }
}
