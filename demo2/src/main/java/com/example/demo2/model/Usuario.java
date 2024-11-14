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
@Table(name = "usuarios")
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id_usuario")
    private Integer idUsuario;

    @Column(name = "Nombres")
    private String Nombres;

    @Column(name = "Apellidos")
    private String Apellidos;

    @Column(name = "telefono") 
    private Integer telefono;

    @Column(name = "contraseña")
    private String contraseña;

    @Column(name = "residente_tipo")
    private Integer residentetipo;

    @Column(name = "Direccion")
    private String Direccion;

    @Column(name = "Email")
    private String email;

    @ManyToOne()  // Usa LAZY loading si los sectores son entidades grandes.
    @JoinColumn(name = "id_sector", referencedColumnName = "id_sector")
    private Sector sector;

    @Column(name = "Tipo_Usuario")
    private short tipoUsuario;

    @Column(name = "Cedula_pas")
    private String Cedulapas;

    // Getters y Setters

    public Integer getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Integer idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombre() {
        return Nombres;
    }

    public void setNombre(String Nombres) {
        this.Nombres = Nombres;
    }

    public String getApellido() {
        return Apellidos;
    }

    public void setApellido(String Apellidos) {
        this.Apellidos = Apellidos;
    }

    public Integer getTelefono() {
        return telefono;
    }

    public void setTelefono(Integer telefono) {
        this.telefono = telefono;
    }

    public String getContraseña() {
        return contraseña;
    }

    public void setContraseña(String contraseña) {
        this.contraseña = contraseña;
    }

    public Integer getResidenteTipo() {
        return  residentetipo;
    }

    public void setResidenteTipo(Integer residentetipo) {
        this.residentetipo = residentetipo;
    }

    public String getDireccion() {
        return Direccion;
    }

    public void setDireccion(String Direccion) {
        this.Direccion = Direccion;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Sector getSector() {
        return sector;
    }

    public void setSector(Sector sector) {
        this.sector = sector;
    }

    public short getTipoUsuario() {
        return tipoUsuario;
    }

    public void setTipoUsuario(short tipoUsuario) {
        this.tipoUsuario = tipoUsuario;
    }

    public String getCedulaPas() {
        return Cedulapas;
    }

    public void setCedulaPas(String Cedulapas) {
        this.Cedulapas = Cedulapas;
    }
}
