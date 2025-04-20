
package com.clinicaodon.Entity;

import java.io.Serializable;
import java.util.List;

import jakarta.persistence.*;
import java.util.Date;



@Entity
@Table(name = "odontologo")
@PrimaryKeyJoinColumn(name = "id_odontologo")
public class Odontologo extends Persona implements Serializable {
    
    @Column(name = "id_odontologo")
    private Long id_odontologo;
    private String especialidad;
    
    @OneToMany(mappedBy = "odontologo")
    private List<Turno> turnos;
    
    @OneToOne
    @JoinColumn(name = "horario_id")
    private Horario horario;

    public Odontologo() {}

    public Odontologo(Long id_odontologo, String especialidad, List<Turno> turnos, Horario horario) {
        this.id_odontologo = id_odontologo;
        this.especialidad = especialidad;
        this.turnos = turnos;
        this.horario = horario;
    }



    // Getters y Setters (mismos que en tu implementación original)
    public Long getId_odontologo() {
        return id_odontologo;
    }

    public void setId_odontologo(Long id_odontologo) {
        this.id_odontologo = id_odontologo;
    }

    public String getEspecialidad() {
        return especialidad;
    }

    public void setEspecialidad(String especialidad) {
        this.especialidad = especialidad;
    }

    public List<Turno> getTurnos() {
        return turnos;
    }

    public void setTurnos(List<Turno> turnos) {
        this.turnos = turnos;
    }

    public Horario getHorario() {
        return horario;
    }

    public void setHorario(Horario horario) {
        this.horario = horario;
    }
}