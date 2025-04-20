
package Controladora;

import JPAController.TurnoJpaController;
import JPAController.exceptions.NonexistentEntityException;
import com.clinicaodon.Entity.Odontologo;
import com.clinicaodon.Entity.Paciente;
import com.clinicaodon.Entity.Turno;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;



public class ContTurno {
    
    private final TurnoJpaController turnoJpa = new TurnoJpaController();

    
    // Método para crear un nuevo turno
    public void crearTurno(Turno turno) {
        turnoJpa.create(turno);
    }
    
    // Método para editar un turno existente
    public void editarTurno(Turno turno) {
        try {
            turnoJpa.edit(turno);
        } catch (Exception ex) {
            Logger.getLogger(ContTurno.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    // Método para eliminar un turno
    public void eliminarTurno(int id) {
        try {
            turnoJpa.destroy(id);
        } catch (NonexistentEntityException ex) {
            Logger.getLogger(ContTurno.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    // Método para obtener todos los turnos
    public List<Turno> traerTurnos() {
        return turnoJpa.findTurnoEntities();
    }
    
    // Método para buscar un turno por ID
    public Turno buscarTurnoPorId(int id) {
        return turnoJpa.findTurno(id);
    }
    
    // Método para buscar turnos por odontólogo
    public List<Turno> buscarTurnosPorOdontologo(Odontologo odontologo) {
        EntityManager em = turnoJpa.getEntityManager();
        try {
            Query query = em.createQuery("SELECT t FROM Turno t WHERE t.odontologo = :odontologo");
            query.setParameter("odontologo", odontologo);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    // Método para buscar turnos por paciente
    public List<Turno> buscarTurnosPorPaciente(Paciente paciente) {
        EntityManager em = turnoJpa.getEntityManager();
        try {
            Query query = em.createQuery("SELECT t FROM Turno t WHERE t.paciente = :paciente");
            query.setParameter("paciente", paciente);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    // Método para buscar turnos por fecha
    public List<Turno> buscarTurnosPorFecha(String fecha) {
        EntityManager em = turnoJpa.getEntityManager();
        try {
            Query query = em.createQuery("SELECT t FROM Turno t WHERE t.fecha_turno = :fecha");
            query.setParameter("fecha", fecha);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    // Método para verificar disponibilidad de horario para un odontólogo
    public boolean verificarDisponibilidad(Odontologo odontologo, String fecha, String hora) {
        EntityManager em = turnoJpa.getEntityManager();
        try {
            Query query = em.createQuery("SELECT COUNT(t) FROM Turno t WHERE t.odontologo = :odontologo AND t.fecha_turno = :fecha AND t.hora_turno = :hora");
            query.setParameter("odontologo", odontologo);
            query.setParameter("fecha", fecha);
            query.setParameter("hora", hora);
            Long count = (Long) query.getSingleResult();
            return count == 0; // Retorna true si no hay turnos existentes para ese odontólogo en esa fecha y hora
        } finally {
            em.close();
        }
    }
    public List<Turno> buscarTurnosPorOdontologoYFecha(Odontologo odontologo, String fecha) {
    // Get list of all appointments for the specified dentist
    List<Turno> turnosOdontologo = buscarTurnosPorOdontologo(odontologo);
    
    // Filter by date
    List<Turno> turnosFiltrados = new java.util.ArrayList<>();
    for (Turno turno : turnosOdontologo) {
        if (turno.getFecha_turno().equals(fecha)) {
            turnosFiltrados.add(turno);
        }
    }
    
    return turnosFiltrados;
}


}
