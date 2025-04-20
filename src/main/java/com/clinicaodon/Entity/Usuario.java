
package com.clinicaodon.Entity;

import java.io.Serializable;

import jakarta.persistence.*;

@Entity
@Table(name = "usuario")
public class Usuario implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id_usuario;
    
    private String nombre_usuario;
    
    private String contraseña;
    
    private String rol;
    
    @OneToOne
    @JoinColumn(name = "persona_id")
    private Persona persona;
    
   // @OneToOne(mappedBy = "usuario")
    // private Secretario secretario;
    
    public Usuario() {}
    
    public Usuario(Long id_usuario, String nombre_usuario, String contraseña, String rol) {
        this.id_usuario = id_usuario;
        this.nombre_usuario = nombre_usuario;
        this.contraseña = contraseña;
        this.rol = rol;
    }
    
    // Constructor adicional con relación a persona
    public Usuario(Long id_usuario, String nombre_usuario, String contraseña, String rol, Persona persona) {
        this.id_usuario = id_usuario;
        this.nombre_usuario = nombre_usuario;
        this.contraseña = contraseña;
        this.rol = rol;
        this.persona = persona;
    }
    
    // Getters y Setters
    public Long getId_usuario() {
        return id_usuario;
    }
    
    public void setId_usuario(Long id_usuario) {
        this.id_usuario = id_usuario;
    }
    
    public String getNombre_usuario() {
        return nombre_usuario;
    }
    
    public void setNombre_usuario(String nombre_usuario) {
        this.nombre_usuario = nombre_usuario;
    }
    
    public String getContraseña() {
        return contraseña;
    }
    
    public void setContraseña(String contraseña) {
        this.contraseña = contraseña;
    }
    
    public String getRol() {
        return rol;
    }
    
    public void setRol(String rol) {
        this.rol = rol;
    }
    
    public Persona getPersona() {
        return persona;
    }
    
    public void setPersona(Persona persona) {
        this.persona = persona;
    }
   /* 
    public Secretario getSecretario() {
        return secretario;
    }
    
    public void setSecretario(Secretario secretario) {
        this.secretario = secretario;
    }
*/
}