
package Controladora;

import JPAController.PersonaJpaController;
import JPAController.UsuarioJpaController;
import JPAController.exceptions.NonexistentEntityException;
import com.clinicaodon.Entity.Odontologo;
import com.clinicaodon.Entity.Persona;
import com.clinicaodon.Entity.Secretario;
import com.clinicaodon.Entity.Usuario;
import jakarta.persistence.EntityManager;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


public class ContUsuario {
    
    UsuarioJpaController jpa = new UsuarioJpaController();
    PersonaJpaController per = new PersonaJpaController();
 
    public void crearUsuario(Usuario usu) {
        jpa.create(usu);
    }

    public List<Usuario> traerUsuarios() {
        List<Usuario> usuarios = jpa.findUsuarioEntities(); 
        return usuarios;
    }


    public Usuario traerUsuario(Long id_editar) {
        return jpa.findUsuario(id_editar);
    }

    public void editarUsuario(Usuario usu) {
        try {
            jpa.edit(usu);
        } catch (Exception ex) {
            Logger.getLogger(ContUsuario.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean comprobarAcceso(String usuario, String contrasena) {
        List<Usuario> listaUsuario = new ArrayList<>();

        listaUsuario = jpa.findUsuarioEntities();
        for (Usuario usu : listaUsuario) {
            if (usu.getNombre_usuario().equals(usuario)) {
                if (usu.getContraseña().equals(contrasena)) {
                    return true;
                }
            }
        }
        return false;
    }

    public boolean existeUsuario(String nombreUsu) {
        List<Usuario> listaUsuario = new ArrayList<>();

        listaUsuario = jpa.findUsuarioEntities();
        for (Usuario usu : listaUsuario) {
            if (usu.getNombre_usuario().equals(nombreUsu)) {

                return true;
            }
        }
        return false;
    }

    public void eliminarUsuario(Long id) {
        try {
            jpa.destroy(id);
        } catch (NonexistentEntityException ex) {
            Logger.getLogger(ContUsuario.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
     public Usuario buscarUsuarioPorId(Long id){
        return jpa.findUsuario(id);
    }

     
     public List<Persona> traerSecretarios() {
    List<Persona> todos = per.findPersonaEntities(); // o como obtengas todas las personas
    List<Persona> secretarios = new ArrayList<>();

    for (Persona p : todos) {
        if (p instanceof Secretario) {
            secretarios.add(p);
        }
    }
    return secretarios;
}

public List<Persona> traerOdontologos() {
    List<Persona> todos = per.findPersonaEntities();
    List<Persona> odontologos = new ArrayList<>();

    for (Persona p : todos) {
        if (p instanceof Odontologo) {
            odontologos.add(p);
        }
    }
    return odontologos;
}
public Persona traerPersonaPorId(Long id) {
    return per.findPersona(id);
}


public String obtenerRolUsuario(String nombreUsuario) {
    EntityManager em = null;
    try {
        em = jpa.getEntityManager();

        Usuario usuario = em.createQuery(
            "SELECT u FROM Usuario u WHERE u.nombreUsuario = :nombre", 
            Usuario.class)
            .setParameter("nombre", nombreUsuario)
            .getSingleResult();

        if (usuario != null && usuario.getRol() != null) {
            return usuario.getRol().toUpperCase(); // ADMIN, SECRETARIO, ODONTOLOGO
        } else {
            return "INDEFINIDO";
        }

    } catch (Exception e) {
        e.printStackTrace();
        return "INDEFINIDO";
    } finally {
        if (em != null && em.isOpen()) {
            em.close();
        }
    }
}

}
