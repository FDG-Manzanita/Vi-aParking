package com.example.report.repository;

import com.example.report.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
    // Método para buscar un usuario por su correo electrónico
    User findByEmail(String email);
}
