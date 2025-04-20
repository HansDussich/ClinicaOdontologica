/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.clinicaodon.Servlet;

import Controladora.ContOdontologo;
import Controladora.ContPaciente;
import Controladora.ContTurno;
import com.clinicaodon.Entity.Odontologo;
import com.clinicaodon.Entity.Paciente;
import com.clinicaodon.Entity.Turno;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "SvTurno", urlPatterns = {"/SvTurno"})
public class SvTurno extends HttpServlet {
    
    private final ContTurno control = new ContTurno();
    private final ContOdontologo odontologoControl = new ContOdontologo();
    private final ContPaciente pacienteControl = new ContPaciente();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        String action = request.getParameter("action");
        
        if (action != null && action.equals("nuevoTurno")) {
            // Cargar la lista de odontólogos y pacientes para el formulario de nuevo turno
            List<Odontologo> listaOdontologos = odontologoControl.traerOdontologos();
            List<Paciente> listaPacientes = pacienteControl.traerPacientes();
            
            request.getSession().setAttribute("listaOdontologos", listaOdontologos);
            request.getSession().setAttribute("listaPacientes", listaPacientes);
            RequestDispatcher dispatcher = request.getRequestDispatcher("altaTurno.jsp");
            dispatcher.forward(request, response);
        } else if (action != null && action.equals("buscarPorOdontologo")) {
            String odontologoIdStr = request.getParameter("odontologo_id");
            if (odontologoIdStr != null && !odontologoIdStr.isEmpty()) {
                Long odontologoId = Long.valueOf(odontologoIdStr);
                Odontologo odontologo = odontologoControl.buscarOdontologoPorId(odontologoId);
                if (odontologo != null) {
                    List<Turno> turnosFiltrados = control.buscarTurnosPorOdontologo(odontologo);
                    request.getSession().setAttribute("listaTurnos", turnosFiltrados);
                }
            }
            response.sendRedirect("verTurnos.jsp");
        } else if (action != null && action.equals("buscarPorPaciente")) {
            String pacienteIdStr = request.getParameter("paciente_id");
            if (pacienteIdStr != null && !pacienteIdStr.isEmpty()) {
                Long pacienteId = Long.valueOf(pacienteIdStr);
                Paciente paciente = pacienteControl.buscarPacientePorId(pacienteId);
                if (paciente != null) {
                    List<Turno> turnosFiltrados = control.buscarTurnosPorPaciente(paciente);
                    request.getSession().setAttribute("listaTurnos", turnosFiltrados);
                }
            }
            response.sendRedirect("verTurnos.jsp");
        } else if (action != null && action.equals("buscarPorFecha")) {
            String fecha = request.getParameter("fecha");
            if (fecha != null && !fecha.isEmpty()) {
                List<Turno> turnosFiltrados = control.buscarTurnosPorFecha(fecha);
                request.getSession().setAttribute("listaTurnos", turnosFiltrados);
            }
            response.sendRedirect("verTurnos.jsp");
        } else if (idParam != null) {
            // Editar un turno existente
            int id = Integer.parseInt(idParam);
            Turno turnoEditar = control.buscarTurnoPorId(id);
            
            // Cargar listas para el formulario de edición
            List<Odontologo> listaOdontologos = odontologoControl.traerOdontologos();
            List<Paciente> listaPacientes = pacienteControl.traerPacientes();
            
            request.getSession().setAttribute("listaOdontologos", listaOdontologos);
            request.getSession().setAttribute("listaPacientes", listaPacientes);
            request.getSession().setAttribute("turnoEditar", turnoEditar);
            response.sendRedirect("editarTurno.jsp");
        } else {
            // Mostrar todos los turnos
            request.getSession().removeAttribute("turnoEditar");
            List<Turno> listaTurnos = control.traerTurnos();
            request.getSession().setAttribute("listaTurnos", listaTurnos);
            response.sendRedirect("verTurnos.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no especificada");
            return;
        }
        
        switch (action) {
            case "crear":
                crearTurno(request, response);
                break;
            case "editar":
                editarTurno(request, response);
                break;
            case "eliminar":
                eliminarTurno(request, response);
                break;
            case "verificarDisponibilidad":
                verificarDisponibilidad(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no válida");
        }
    }
    
    private void crearTurno(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            // Obtener datos del formulario
            String fecha = request.getParameter("fecha_turno");
            String hora = request.getParameter("hora_turno");
            String tratamiento = request.getParameter("tratamiento");
            
            // Obtener odontólogo seleccionado
            String odontologoIdStr = request.getParameter("odontologo_id");
            Long odontologoId = Long.valueOf(odontologoIdStr);
            Odontologo odontologo = odontologoControl.buscarOdontologoPorId(odontologoId);
            
            // Obtener paciente seleccionado
            String pacienteIdStr = request.getParameter("paciente_id");
            Long pacienteId = Long.valueOf(pacienteIdStr);
            Paciente paciente = pacienteControl.buscarPacientePorId(pacienteId);
            
            // Verificar disponibilidad
            if (control.verificarDisponibilidad(odontologo, fecha, hora)) {
                // Crear objeto Turno
                Turno turno = new Turno();
                turno.setFecha_turno(fecha);
                turno.setHora_turno(hora);
                turno.setTratamiento(tratamiento);
                turno.setOdontologo(odontologo);
                turno.setPaciente(paciente);
                
                // Guardar el turno
                control.crearTurno(turno);
                
                // Redirigir a la lista de turnos
                response.sendRedirect("SvTurno");
            } else {
                // Si no hay disponibilidad, mostrar mensaje de error
                request.getSession().setAttribute("error", "El odontólogo no está disponible en esa fecha y hora");
                response.sendRedirect("altaTurno.jsp");
            }
        } catch (Exception ex) {
            Logger.getLogger(SvTurno.class.getName()).log(Level.SEVERE, null, ex);
            request.getSession().setAttribute("error", "Error al crear el turno: " + ex.getMessage());
            response.sendRedirect("altaTurno.jsp");
        }
    }
    
    private void editarTurno(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            // Obtener ID del turno a editar
            int id = Integer.parseInt(request.getParameter("id_turno"));
            
            // Buscar el turno existente
            Turno turno = control.buscarTurnoPorId(id);
            
            if (turno != null) {
                // Obtener datos del formulario
                String fecha = request.getParameter("fecha_turno");
                String hora = request.getParameter("hora_turno");
                String tratamiento = request.getParameter("tratamiento");
                
                // Obtener odontólogo seleccionado
                String odontologoIdStr = request.getParameter("odontologo_id");
                Long odontologoId = Long.valueOf(odontologoIdStr);
                Odontologo odontologo = odontologoControl.buscarOdontologoPorId(odontologoId);
                
                // Obtener paciente seleccionado
                String pacienteIdStr = request.getParameter("paciente_id");
                Long pacienteId = Long.valueOf(pacienteIdStr);
                Paciente paciente = pacienteControl.buscarPacientePorId(pacienteId);
                
                // Si se cambia el odontólogo, fecha u hora, verificar disponibilidad
                boolean verificarDisponibilidad = !turno.getOdontologo().equals(odontologo) || 
                                                !turno.getFecha_turno().equals(fecha) || 
                                                !turno.getHora_turno().equals(hora);
                
                if (!verificarDisponibilidad || control.verificarDisponibilidad(odontologo, fecha, hora)) {
                    // Actualizar datos del turno
                    turno.setFecha_turno(fecha);
                    turno.setHora_turno(hora);
                    turno.setTratamiento(tratamiento);
                    turno.setOdontologo(odontologo);
                    turno.setPaciente(paciente);
                    
                    // Guardar los cambios
                    control.editarTurno(turno);
                    
                    // Redirigir a la lista de turnos
                    response.sendRedirect("SvTurno");
                } else {
                    // Si no hay disponibilidad, mostrar mensaje de error
                    request.getSession().setAttribute("error", "El odontólogo no está disponible en esa fecha y hora");
                    response.sendRedirect("editarTurno.jsp");
                }
            } else {
                request.getSession().setAttribute("error", "Turno no encontrado");
                response.sendRedirect("SvTurno");
            }
        } catch (Exception ex) {
            Logger.getLogger(SvTurno.class.getName()).log(Level.SEVERE, null, ex);
            request.getSession().setAttribute("error", "Error al editar el turno: " + ex.getMessage());
            response.sendRedirect("SvTurno");
        }
    }
    
    private void eliminarTurno(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id_turno"));
            control.eliminarTurno(id);
            response.sendRedirect("SvTurno");
        } catch (Exception ex) {
            Logger.getLogger(SvTurno.class.getName()).log(Level.SEVERE, null, ex);
            request.getSession().setAttribute("error", "Error al eliminar el turno: " + ex.getMessage());
            response.sendRedirect("SvTurno");
        }
    }
    
    private void verificarDisponibilidad(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            String odontologoIdStr = request.getParameter("odontologo_id");
            String fecha = request.getParameter("fecha_turno");
            String hora = request.getParameter("hora_turno");
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            
            if (odontologoIdStr != null && !odontologoIdStr.isEmpty() && fecha != null && !fecha.isEmpty() && hora != null && !hora.isEmpty()) {
                Long odontologoId = Long.valueOf(odontologoIdStr);
                Odontologo odontologo = odontologoControl.buscarOdontologoPorId(odontologoId);
                
                if (odontologo != null) {
                    boolean disponible = control.verificarDisponibilidad(odontologo, fecha, hora);
                    out.print("{\"disponible\": " + disponible + "}");
                } else {
                    out.print("{\"error\": \"Odontólogo no encontrado\"}");
                }
            } else {
                out.print("{\"error\": \"Datos incompletos\"}");
            }
            
            out.flush();
        } catch (Exception ex) {
            Logger.getLogger(SvTurno.class.getName()).log(Level.SEVERE, null, ex);
            response.setContentType("application/json");
            response.getWriter().print("{\"error\": \"" + ex.getMessage() + "\"}");
        }
    }
    
    
}