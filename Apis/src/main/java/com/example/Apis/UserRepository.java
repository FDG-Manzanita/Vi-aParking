package com.example.Apis;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<usuarios, Integer> {

    @Query("SELECT u FROM usuarios u WHERE u.Email = :email")
    Optional<usuarios> findByEmail(String email);

    @Query("SELECT u FROM usuarios u WHERE u.Email = :email AND u.contraseña = :contraseña")
    Optional<usuarios> findByEmailAndContraseña(String email, String contraseña);

    Optional<usuarios> findById(Integer id);
}