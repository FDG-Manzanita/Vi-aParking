package com.example.demo2.Repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.example.demo2.model.Usuario;

public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {

    @Query("SELECT u FROM Usuario u WHERE u.email = :email")
    Optional<Usuario> findByEmail(String email);
}
