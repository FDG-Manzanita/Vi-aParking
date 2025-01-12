package com.example.Apis;
import java.util.List;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/auth")

public class UserController {

    private final UserRepository usuarioRepository;
    public UserController(UserRepository userRepository) {
        this.usuarioRepository = userRepository;
    }


    @GetMapping("/all")
    public List<usuarios> getAllUsuarios() {
        return usuarioRepository.findAll();
    }

   

    /**
     * @param usuario
     * @return
     */
    @PostMapping("/register")
public ResponseEntity<String> registerUser(@RequestBody usuarios usuario) {
    try {
        // Verificar si el correo ya está en uso
        Optional<usuarios> existingUser = usuarioRepository.findByEmail(usuario.getEmail());
        if (existingUser.isPresent()) {
            return ResponseEntity.status(400).body("El correo electrónico ya está registrado");
        }

        // Verificar si es residente y asegurarse de que 'cedula_pas' y 'direccion' no sean nulos
        if (usuario.getResidente_tipo() == 1) {
            if (usuario.getCedula_pas() == null || usuario.getCedula_pas().isEmpty()) {
                return ResponseEntity.status(400).body("El RUT o Pasaporte es obligatorio para residentes");
            }
            if (usuario.getDireccion() == null || usuario.getDireccion().isEmpty()) {
                return ResponseEntity.status(400).body("La dirección es obligatoria para residentes");
            }
        }

        // Asignar valores predeterminados
        usuario.setTipoUsuario((short) 1); // Cambiar el nombre a tipoUsuario (en lugar de tipo_usuario)

        // Guardar el usuario
        usuarioRepository.save(usuario);

        return ResponseEntity.status(201).body("Usuario registrado exitosamente");
    } catch (Exception e) {
        return ResponseEntity.status(500).body("Error al registrar usuario: " + e.getMessage());
    }
}


    @GetMapping("/usuario/{id}")
public ResponseEntity<usuarios> getUsuarioById(@PathVariable Integer id) {
    Optional<usuarios> usuario = usuarioRepository.findById(id);
    if (usuario.isPresent()) {
        return ResponseEntity.ok(usuario.get());
    } else {
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
    }
}

    @PutMapping("/{id}")
    public usuarios updateUsuario(@PathVariable Integer id, @RequestBody usuarios usuarioDetails) {
        usuarios usuario = usuarioRepository.findById(id).orElse(null);
        if (usuario != null) {
            usuario.setNombres(usuarioDetails.getNombres());
            usuario.setApellidos(usuarioDetails.getApellidos());
            usuario.setTelefono(usuarioDetails.getTelefono());
            usuario.setContraseña(usuarioDetails.getContraseña());
            usuario.setDireccion(usuarioDetails.getDireccion());
            usuario.setEmail(usuarioDetails.getEmail());
            usuario.setid_sector(usuarioDetails.getid_sector());
            usuario.setResidente_tipo(usuarioDetails.getResidente_tipo());
            usuario.setCedula_pas(usuarioDetails.getCedula_pas());
            usuario.setTipoUsuario(usuarioDetails.getTipoUsuario());

            return usuarioRepository.save(usuario);
        }
        return null;
    }

    @DeleteMapping("/{id}")
    public void deleteUsuario(@PathVariable Integer id) {
        usuarioRepository.deleteById(id);
    }
    

    public boolean verificarCredenciales(String email, String contraseña) {
        Optional<usuarios> usuarioOpt = usuarioRepository.findByEmail(email);
        if (usuarioOpt.isPresent()) {
            usuarios usuario = usuarioOpt.get();
            // Comparar la contraseña proporcionada
            return usuario.getContraseña().equals(contraseña);
        }
        return false;
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestParam String email, @RequestParam String contraseña) {
        boolean autenticado = verificarCredenciales(email, contraseña);
        if (autenticado) {
            return ResponseEntity.ok("Login exitoso");
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Credenciales inválidas");
        }
    }
            
}