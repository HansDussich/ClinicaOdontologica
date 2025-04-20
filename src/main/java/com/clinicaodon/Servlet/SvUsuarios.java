package com.clinicaodon.Servlet;

import Controladora.ContUsuario;
import com.clinicaodon.Entity.Persona;
import com.clinicaodon.Entity.Usuario;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SvUsuarios", urlPatterns = {"/SvUsuarios"})
public class SvUsuarios extends HttpServlet {

    private final ContUsuario control = new ContUsuario();
    

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String tipo = request.getParameter("tipo");

    if ("getPersonasPorRol".equals(tipo)) {
        obtenerPersonasPorRol(request, response);
        return;
    }

    // Código existente (ver usuarios)
    String idParam = request.getParameter("id");
    if (idParam != null) {
        Long id = Long.valueOf(idParam);
        Usuario usuarioEditar = control.buscarUsuarioPorId(id);
        request.getSession().setAttribute("usuarioEditar", usuarioEditar);
    } else {
        request.getSession().removeAttribute("usuarioEditar");
    }

    List<Usuario> listaUsuarios = control.traerUsuarios();
    request.getSession().setAttribute("listaUsuarios", listaUsuarios);

    response.sendRedirect("verUsuarios.jsp");
}



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        switch (action) {
            case "crear":
                crearUsuario(request, response);
                break;
            case "editar":
                editarUsuario(request, response);
                break;
            case "eliminar":
                eliminarUsuario(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no válida");
        }

    }

private void crearUsuario(HttpServletRequest request, HttpServletResponse response)
        throws IOException {

    String nombreUsu = request.getParameter("nombre_usuario");
    String contrasena = request.getParameter("contrasena");
    String rol = request.getParameter("rol");
    String personaIdStr = request.getParameter("persona_id");

    boolean validacion = control.existeUsuario(nombreUsu);

    if (validacion) {
        response.sendRedirect("altaUsuario.jsp");
    } else {
        Usuario usu = new Usuario();
        usu.setNombre_usuario(nombreUsu);
        usu.setContraseña(contrasena);
        usu.setRol(rol);

        // Asociar Persona si es necesario
        if ("SECRETARIO".equals(rol) || "ODONTOLOGO".equals(rol)) {
            Long personaId = Long.valueOf(personaIdStr);
            Persona persona = control.traerPersonaPorId(personaId);
            usu.setPersona(persona); // Asegúrate que `Usuario` tenga un atributo `Persona` y su setter
        }

        control.crearUsuario(usu);
        response.sendRedirect("SvUsuarios");
    }
}


    private void editarUsuario(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long id = Long.valueOf(request.getParameter("id"));
        String nombreUsu = request.getParameter("nombre_usuario");
        String contrasena = request.getParameter("contrasena");
        String rol = request.getParameter("rol");

        Usuario usu = control.buscarUsuarioPorId(id); 

        if (usu != null) {
            usu.setNombre_usuario(nombreUsu);
            usu.setContraseña(contrasena);
            usu.setRol(rol);

            control.editarUsuario(usu);
        }

       response.sendRedirect("SvUsuarios");

    }

    private void eliminarUsuario(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long id = Long.valueOf(request.getParameter("id"));

        control.eliminarUsuario(id); 
        
        response.sendRedirect("SvUsuarios");

    }
    
private void obtenerPersonasPorRol(HttpServletRequest request, HttpServletResponse response)
        throws IOException {

    String rol = request.getParameter("rol");
    List<Persona> personas = null;

    if ("SECRETARIO".equalsIgnoreCase(rol)) {
        personas = control.traerSecretarios();
    } else if ("ODONTOLOGO".equalsIgnoreCase(rol)) {
        personas = control.traerOdontologos();
    }

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    if (personas != null) {
        StringBuilder json = new StringBuilder();
        json.append("[");

        for (int i = 0; i < personas.size(); i++) {
            Persona p = personas.get(i);
            json.append("{");
            json.append("\"id\":").append(p.getId()).append(",");
            json.append("\"nombre\":\"").append(p.getNombre()).append("\",");
            json.append("\"apellidos\":\"").append(p.getApellidos()).append("\"");
            json.append("}");

            if (i < personas.size() - 1) {
                json.append(",");
            }
        }

        json.append("]");

        response.getWriter().write(json.toString());
    } else {
        response.getWriter().write("[]");
    }
}

}
