<%@page import="com.clinicaodon.Entity.Turno"%>
<%@page import="com.clinicaodon.Entity.Odontologo"%>
<%@page import="com.clinicaodon.Entity.Paciente"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Turno turnoEditar = (Turno) session.getAttribute("turnoEditar");
    boolean enModoEdicion = turnoEditar != null;
    
    // Obtener listas para filtros
    List<Odontologo> listaOdontologos = (List) request.getSession().getAttribute("listaOdontologos");
    List<Paciente> listaPacientes = (List) request.getSession().getAttribute("listaPacientes");
    
    // Obtener mensaje de error si existe
    String error = (String) session.getAttribute("error");
    session.removeAttribute("error"); // Limpiar el mensaje después de mostrarlo
%>

<!DOCTYPE html>
<html>
    <%@include file="Layout/head.jsp" %>
    <link rel="stylesheet" href="css/style.css"/>
    <body class="sb-nav-fixed">
        <%@include file="Layout/navbar.jsp" %>

        <div id="layoutSidenav">
            <%@include file="Layout/layoutSidenav_nav.jsp" %>

            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Gestión de Turnos</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="../index.jsp">Inicio</a></li>
                            <li class="breadcrumb-item active">Ver Turnos</li>
                        </ol>
                        
                        <% if (error != null && !error.isEmpty()) { %>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <%= error %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <% } %>
                        
                        <!-- Filtros de búsqueda -->
                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-filter me-1"></i> Filtros de Búsqueda
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <!-- Filtro por odontólogo -->
                                    <div class="col-md-4">
                                        <form action="SvTurno" method="GET" class="mb-3">
                                            <input type="hidden" name="action" value="buscarPorOdontologo">
                                            <div class="input-group">
                                                <select class="form-select" name="odontologo_id" required>
                                                    <option value="">Seleccione un odontólogo</option>
                                                    <% if (listaOdontologos != null) { 
                                                        for (Odontologo odonto : listaOdontologos) { %>
                                                    <option value="<%= odonto.getId() %>"><%= odonto.getNombre() %> <%= odonto.getApellidos()%></option>
                                                    <% } } %>
                                                </select>
                                                <button class="btn btn-outline-primary" type="submit">Filtrar</button>
                                            </div>
                                        </form>
                                    </div>
                                    
                                    <!-- Filtro por paciente -->
                                    <div class="col-md-4">
                                        <form action="SvTurno" method="GET" class="mb-3">
                                            <input type="hidden" name="action" value="buscarPorPaciente">
                                            <div class="input-group">
                                                <select class="form-select" name="paciente_id" required>
                                                    <option value="">Seleccione un paciente</option>
                                                    <% if (listaPacientes != null) { 
                                                        for (Paciente pac : listaPacientes) { %>
                                                    <option value="<%= pac.getId() %>"><%= pac.getNombre() %> <%= pac.getApellidos() %></option>
                                                    <% } } %>
                                                </select>
                                                <button class="btn btn-outline-primary" type="submit">Filtrar</button>
                                            </div>
                                        </form>
                                    </div>
                                    
                                    <!-- Filtro por fecha -->
                                    <div class="col-md-4">
                                        <form action="SvTurno" method="GET" class="mb-3">
                                            <input type="hidden" name="action" value="buscarPorFecha">
                                            <div class="input-group">
                                                <input type="date" class="form-control" name="fecha" required>
                                                <button class="btn btn-outline-primary" type="submit">Filtrar</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                                
                                <!-- Botón para mostrar todos los turnos -->
                                <div class="row">
                                    <div class="col-12 text-center">
                                        <a href="SvTurno" class="btn btn-secondary">
                                            <i class="fas fa-sync-alt"></i> Mostrar Todos
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Tabla de turnos -->
                        <div class="card mb-4">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <span><i class="fas fa-calendar-alt me-1"></i> Turnos Registrados</span>
                                <a href="SvTurno?action=nuevoTurno" class="btn btn-primary btn-sm">
                                    <i class="fas fa-plus"></i> Nuevo Turno
                                </a>
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple" class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Fecha</th>
                                            <th>Hora</th>
                                            <th>Paciente</th>
                                            <th>Odontólogo</th>
                                            <th>Tratamiento</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>ID</th>
                                            <th>Fecha</th>
                                            <th>Hora</th>
                                            <th>Paciente</th>
                                            <th>Odontólogo</th>
                                            <th>Tratamiento</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                        <%
                                            List<Turno> listaTurnos = (List) request.getSession().getAttribute("listaTurnos");
                                            if (listaTurnos != null && !listaTurnos.isEmpty()) {
                                                for (Turno turno : listaTurnos) {
                                        %>
                                        <tr>
                                            <td><%= turno.getId_turno()%></td>
                                            <td><%= turno.getFecha_turno() %></td>
                                            <td><%= turno.getHora_turno() %></td>
                                            <td><%= turno.getPaciente().getNombre() %> <%= turno.getPaciente().getApellidos() %></td>
                                            <td><%= turno.getOdontologo().getNombre() %> <%= turno.getOdontologo().getApellidos() %></td>
                                            <td><%= turno.getTratamiento() %></td>
                                            <td>
                                                <form action="SvTurno" method="POST" class="d-inline">
                                                    <input type="hidden" name="action" value="eliminar">
                                                    <input type="hidden" name="id_turno" value="<%= turno.getId_turno()%>">
                                                    <button type="submit" class="btn btn-danger btn-sm" title="Eliminar" onclick="return confirm('¿Está seguro que desea eliminar este turno?')">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                </form>
                                                <a href="SvTurno?id=<%= turno.getId_turno()%>" class="btn btn-primary btn-sm" title="Editar">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                            </td>
                                        </tr>
                                        <% 
                                                }
                                            } else { 
                                        %>
                                        <tr>
                                            <td colspan="7" class="text-center">No hay turnos registrados.</td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </main>
                <%@include file="Layout/footer.jsp" %>
            </div>
        </div>

        <%@include file="Layout/script.jsp" %>
        <script>
            // Script para verificar disponibilidad dinámicamente (opcional)
            document.addEventListener('DOMContentLoaded', function() {
                // Aquí puedes agregar código JavaScript para mejorar la experiencia de usuario
                // Por ejemplo, verificación de disponibilidad en tiempo real con AJAX
            });
        </script>
    </body>
</html>