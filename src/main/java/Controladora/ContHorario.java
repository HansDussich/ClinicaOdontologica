
package Controladora;


import JPAController.HorarioJpaController;
import JPAController.exceptions.NonexistentEntityException;
import com.clinicaodon.Entity.Horario;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.List;



public class ContHorario {

    HorarioJpaController jpa = new HorarioJpaController();

    public void crearHorario(Horario hor) {
        jpa.create(hor);
    }

    public List<Horario> traerHorarios() {
        List<Horario> horarios = jpa.findHorarioEntities();
        return horarios;
    }

        public Horario traerHorario(int id) {
        return jpa.findHorario(id);
    }
    
    public void editarHorario(Horario horario) {
        try {
            jpa.edit(horario);
        } catch (Exception ex) {
            Logger.getLogger(ContHorario.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void eliminarHorario(int id) {
        try {
            jpa.destroy(id);
        } catch (NonexistentEntityException ex) {
            Logger.getLogger(ContHorario.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
