package com.clinicaodon.Servlet;

import Controladora.ContHorario;

import com.clinicaodon.Entity.Horario;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "SvHorario", urlPatterns = {"/SvHorario"})
public class SvHorario extends HttpServlet {

    ContHorario control = new ContHorario();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Listar todos los horarios
        List<Horario> listaHorarios = control.traerHorarios();
        HttpSession ms = request.getSession();
        ms.setAttribute("listaHorarios", listaHorarios);
        response.sendRedirect("verHorarios.jsp");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("eliminar".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                control.eliminarHorario(id);
            } else {
                String inicio = request.getParameter("horario_inicio");
                String fin = request.getParameter("horario_fin");

                Horario horario = new Horario();
                horario.setHorario_inicio(inicio);
                horario.setHorario_fin(fin);

                control.crearHorario(horario);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al procesar el horario");
        }
        response.sendRedirect("SvHorario");

    }
}
