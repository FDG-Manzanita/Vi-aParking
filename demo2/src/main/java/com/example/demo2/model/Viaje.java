package com.example.demo2.model;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;

@Entity
@Table(name = "viajes")
public class Viaje {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer idViajes;

    private String destino;

    private String origen;

    @Temporal(TemporalType.TIMESTAMP)
    private Date fecha;

    private boolean estado;

    @ManyToOne
    @JoinColumn(name = "UsuarioID", referencedColumnName = "id_usuario")
    private Usuario usuario;

    // Getters y Setters
    public Integer getIdViaje() {
        return idViajes;
    }

    public void setIdViaje(Integer idViajes) {
        this.idViajes = idViajes;
    }

    public String getDestino() {
        return destino;
    }

    public void setDestino(String destino) {
        this.destino = destino;
    }

    public String getOrigen() {
        return origen;
    }

    public void setOrigen(String origen) {
        this.origen = origen;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public boolean isEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }
}
