package com.example.Apis;
import com.fasterxml.jackson.annotation.JsonInclude;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;


@Entity
//@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
@Table(name = "usuarios")
//Estuctura Basica
public class usuarios {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_usuario")  // Usa el nombre exacto en la base de datos
    private int idUsuario;

    @Column(name = "Nombres")
    private String Nombres;

    @Column(name = "Apellidos")
    private String Apellidos;

    @Column(name = "telefono")
    private Integer telefono;

    @Column(name = "contraseña")
    private String contraseña;

    @Column(name = "residente_tipo")
    private Integer residente_tipo;

    @Column(name = "Direccion")
    private String Direccion;

    @Column(name = "Email")
    private String Email;

    @Column(nullable = true)
    private Integer id_sector = null;

    @Column(name = "Tipo_Usuario")
    private short TipoUsuario;

    @Column(name = "Cedula_pas")
    private String Cedula_pas;

   


    // Constructores

    public usuarios(int idUsuario, String nombres, String apellidos, Integer telefono, String contraseña,
            int residente_tipo, String direccion, String email, int id_sector, short tipoUsuario, String cedula_pas) {
        this.idUsuario = idUsuario;
        this.Nombres = nombres;
        this.Apellidos = apellidos;
        this.telefono = telefono;
        this.contraseña = contraseña;
        this.residente_tipo = residente_tipo;
        this.Direccion = direccion;
        this.Email = email;
        this.id_sector = id_sector;
        this.TipoUsuario = tipoUsuario;
        this.Cedula_pas = cedula_pas;
    }

    public usuarios() {
    }

    //Getters and Setters


    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombres() {
        return Nombres;
    }

    public void setNombres(String nombres) {
        Nombres = nombres;
    }

    public String getApellidos() {
        return Apellidos;
    }

    public void setApellidos(String apellidos) {
        Apellidos = apellidos;
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

    public int getResidente_tipo() {
        return residente_tipo;
    }

    public void setResidente_tipo(int residente_tipo) {
        this.residente_tipo = residente_tipo;
    }

    public String getDireccion() {
        return Direccion;
    }

    public void setDireccion(String direccion) {
        Direccion = direccion;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
    }

    public int getid_sector() {
        return id_sector;
    }

    public void setid_sector(int id_sector) {
        this.id_sector = id_sector;
    }

    public short getTipoUsuario() {
        return TipoUsuario;
    }

    public void setTipoUsuario(short tipoUsuario) {
        TipoUsuario = tipoUsuario;
    }

    public String getCedula_pas() {
        return Cedula_pas;
    }

    public void setCedula_pas(String cedula_pas) {
        Cedula_pas = cedula_pas;
    }

    

}
