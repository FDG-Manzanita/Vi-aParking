package com.example.demo2.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "vehiculos")
public class Vehiculo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idVehiculo")
    private Integer idVehiculo;

    @Column(name = "patente", nullable = false)
    private String patente;

    // Relación con la tabla Usuario (ManyToOne)
    @ManyToOne
    @JoinColumn(name = "usuario_id", referencedColumnName = "id_usuario") // Relaciona la columna "usuario_id" de la tabla vehiculos con la columna "idUsuario" de la tabla usuarios
    private Usuario usuario;

    // Getters y Setters
    public Integer getIdVehiculo() {
        return idVehiculo;
    }

    public void setIdVehiculo(Integer idVehiculo) {
        this.idVehiculo = idVehiculo;
    }

    public String getPatente() {
        return patente;
    }

    public void setPatente(String patente) {
        this.patente = patente;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }
}
