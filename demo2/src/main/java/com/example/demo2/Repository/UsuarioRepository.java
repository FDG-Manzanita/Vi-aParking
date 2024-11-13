package com.example.demo2.Repository;
import org.springframework.data.jpa.repository.JpaRepository;

import com.example.demo2.model.Usuario;





public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
}