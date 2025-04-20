
package com.clinicaodon.Entity;

import java.io.Serializable;
import jakarta.persistence.*;



@Entity
@Table(name = "turno")
public class Turno implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id_turno;
    
    private String fecha_turno;
    private String hora_turno;
    private String tratamiento;
    
    @ManyToOne
    @JoinColumn(name = "odontologo_id")
    private Odontologo odontologo;
    
    @ManyToOne
    @JoinColumn(name = "paciente_id")
    private Paciente paciente;
    
    public Turno() {}

    public Turno(int id_turno, String fecha_turno, String hora_turno, String tratamiento, Odontologo odontologo, Paciente paciente) {
        this.id_turno = id_turno;
        this.fecha_turno = fecha_turno;
        this.hora_turno = hora_turno;
        this.tratamiento = tratamiento;
        this.odontologo = odontologo;
        this.paciente = paciente;
    }


    // Getters and Setters
    public int getId_turno() {
        return id_turno;
    }
    
    public void setId_turno(int id_turno) {
        this.id_turno = id_turno;
    }
    
    public String getFecha_turno() {
        return fecha_turno;
    }
    
    public void setFecha_turno(String fecha_turno) {
        this.fecha_turno = fecha_turno;
    }
    
    public String getHora_turno() {
        return hora_turno;
    }
    
    public void setHora_turno(String hora_turno) {
        this.hora_turno = hora_turno;
    }
    
    public String getTratamiento() {
        return tratamiento;
    }
    
    public void setTratamiento(String tratamiento) {
        this.tratamiento = tratamiento;
    }
    
    public Odontologo getOdontologo() {
        return odontologo;
    }
    
    public void setOdontologo(Odontologo odontologo) {
        this.odontologo = odontologo;
    }
    
    public Paciente getPaciente() {
        return paciente;
    }
    
    public void setPaciente(Paciente paciente) {
        this.paciente = paciente;
    }
}