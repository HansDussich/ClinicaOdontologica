
package com.clinicaodon.Servlet;

import Controladora.ContHorario;
import Controladora.ContOdontologo;
import com.clinicaodon.Entity.Odontologo;
import com.clinicaodon.Entity.Horario;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "SvOdontologo", urlPatterns = {"/SvOdontologo"})
public class SvOdontologo extends HttpServlet {
    
    private final ContOdontologo control = new ContOdontologo();
    private final ContHorario horarioControl = new ContHorario(); // Suponiendo que tienes un controlador para Horario
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String idParam = request.getParameter("id");
    String action = request.getParameter("action");
    
    if (action != null && action.equals("buscarEspecialidad")) {
        String especialidad = request.getParameter("especialidad");
        List<Odontologo> listaFiltrada = control.buscarPorEspecialidad(especialidad);
        request.getSession().setAttribute("listaOdontologos", listaFiltrada);
        response.sendRedirect("verOdontologos.jsp");
    } else if (action != null && action.equals("nuevoOdontologo")) {
        // Cargar la lista de horarios disponibles
        List<Horario> listaHorarios = horarioControl.traerHorarios();
        request.getSession().setAttribute("listaHorarios", listaHorarios);
        response.sendRedirect("altaOdontologo.jsp");
    } else if (idParam != null) {
        Long id = Long.valueOf(idParam);
        Odontologo odontologoEditar = control.buscarOdontologoPorId(id);
        // También cargar la lista de horarios para la edición
        List<Horario> listaHorarios = horarioControl.traerHorarios();
        request.getSession().setAttribute("listaHorarios", listaHorarios);
        request.getSession().setAttribute("odontologoEditar", odontologoEditar);
        response.sendRedirect("editarOdontologo.jsp");
    } else {
        request.getSession().removeAttribute("odontologoEditar");
        List<Odontologo> listaOdontologos = control.traerOdontologos();
        request.getSession().setAttribute("listaOdontologos", listaOdontologos);
        response.sendRedirect("verOdontologos.jsp");
    }
}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "crear":
                crearOdontologo(request, response);
                break;
            case "editar":
                editarOdontologo(request, response);
                break;
            case "eliminar":
                eliminarOdontologo(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no válida");
        }
    }
    
    private void crearOdontologo(HttpServletRequest request, HttpServletResponse response)
        throws IOException {
    try {
        // Datos de Persona (clase padre)
        String dni = request.getParameter("dni");
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String telefono = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");
        String fechaNacStr = request.getParameter("fecha_nac");
        
        // Convertir fecha
        SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
        Date fechaNac = formato.parse(fechaNacStr);
        
        // Datos específicos de Odontologo
        String especialidad = request.getParameter("especialidad");
        
        // Obtener el ID del horario seleccionado
        String horarioIdStr = request.getParameter("horario_id");
        
        // Crear el objeto Odontologo
        Odontologo odontologo = new Odontologo();
        odontologo.setDni(dni);
        odontologo.setNombre(nombre);
        odontologo.setApellidos(apellidos);
        odontologo.setTelefono(telefono);
        odontologo.setDireccion(direccion);
        odontologo.setFecha_nac(fechaNac);
        odontologo.setEspecialidad(especialidad);
        
        // Si se seleccionó un horario, asignarlo
        if (horarioIdStr != null && !horarioIdStr.isEmpty()) {
            int horarioId = Integer.parseInt(horarioIdStr);
            Horario horario = horarioControl.traerHorario(horarioId);
            if (horario != null) {
                odontologo.setHorario(horario);
            }
        }
        
        // Guardar el odontólogo
        control.crearOdontologo(odontologo);
        
        response.sendRedirect("SvOdontologo");
    } catch (ParseException ex) {
        Logger.getLogger(SvOdontologo.class.getName()).log(Level.SEVERE, null, ex);
    }
}
    
    private void editarOdontologo(HttpServletRequest request, HttpServletResponse response) throws IOException {
    try {
        Long id = Long.valueOf(request.getParameter("id"));
        
        // Datos de Persona (clase padre)
        String dni = request.getParameter("dni");
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String telefono = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");
        String fechaNacStr = request.getParameter("fecha_nac");
        
        // Convertir fecha
        SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
        Date fechaNac = formato.parse(fechaNacStr);
        
        // Datos específicos de Odontologo
        String especialidad = request.getParameter("especialidad");
        
        // Obtener el ID del horario seleccionado
        String horarioIdStr = request.getParameter("horario_id");
        
        // Buscar el odontólogo a editar
        Odontologo odontologo = control.buscarOdontologoPorId(id);
        
        if (odontologo != null) {
            // Actualizar datos de persona
            odontologo.setDni(dni);
            odontologo.setNombre(nombre);
            odontologo.setApellidos(apellidos);
            odontologo.setTelefono(telefono);
            odontologo.setDireccion(direccion);
            odontologo.setFecha_nac(fechaNac);
            
            // Actualizar datos de odontólogo
            odontologo.setEspecialidad(especialidad);
            
            // Actualizar horario
            if (horarioIdStr != null && !horarioIdStr.isEmpty()) {
                int horarioId = Integer.parseInt(horarioIdStr);
                Horario horario = horarioControl.traerHorario(horarioId);
                if (horario != null) {
                    odontologo.setHorario(horario);
                }
            } else {
                // Si no se seleccionó horario, quitar el actual si existe
                odontologo.setHorario(null);
            }
            
            // Guardar los cambios
            control.editarOdontologo(odontologo);
        }
        
        response.sendRedirect("SvOdontologo");
    } catch (ParseException ex) {
        Logger.getLogger(SvOdontologo.class.getName()).log(Level.SEVERE, null, ex);
    }
}
    
    private void eliminarOdontologo(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Long id = Long.valueOf(request.getParameter("id"));
        
        // Primero, obtener el odontólogo para acceder a su horario
        Odontologo odontologo = control.buscarOdontologoPorId(id);
        if (odontologo != null && odontologo.getHorario() != null) {
            // Almacenar el ID del horario para eliminarlo después
            int idHorario = odontologo.getHorario().getId_horario();
            
            // Eliminar el odontólogo
            control.eliminarOdontologo(id);
            
            // Eliminar el horario asociado
            horarioControl.eliminarHorario(idHorario);
        } else {
            // Si no tiene horario, solo eliminar el odontólogo
            control.eliminarOdontologo(id);
        }
        
        response.sendRedirect("SvOdontologo");
    }
}