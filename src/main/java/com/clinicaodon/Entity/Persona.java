
package com.clinicaodon.Entity;

import java.io.Serializable;
import java.util.Date;
import jakarta.persistence.*;
import java.text.SimpleDateFormat;




@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@Table(name = "persona")
public class Persona implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String dni;
    private String nombre;
    private String apellidos;
    private String telefono;
    private String direccion;
    
    @Temporal(TemporalType.DATE)
    private Date fecha_nac;
    
    public Persona() {}

    public Persona(String dni, String nombre, String apellidos, String telefono, String direccion, Date fecha_nac) {
        this.dni = dni;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.telefono = telefono;
        this.direccion = direccion;
        this.fecha_nac = fecha_nac;
    }

    // Getters and Setters
    // (Mantener los existentes, pero eliminar el método setUsuario())

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public Date getFecha_nac() {
        return fecha_nac;
    }

    public void setFecha_nac(Date fecha_nac) {
        this.fecha_nac = fecha_nac;
    }
    
    
        public String getFechaNacFormateada() {
        if (this.fecha_nac != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("dd-mm-aaaa");
            return sdf.format(this.fecha_nac);
        }
        return null;
    }
}