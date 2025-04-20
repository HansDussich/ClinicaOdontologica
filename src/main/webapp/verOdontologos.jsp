<%@page import="com.clinicaodon.Entity.Odontologo"%>
<%@page import="com.clinicaodon.Entity.Horario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    List<Odontologo> listaOdontologos = (List) request.getSession().getAttribute("listaOdontologos");
    List<Horario> listaHorarios = (List) request.getSession().getAttribute("listaHorarios");
%>

<!DOCTYPE html>
<html>
<%@ include file="Layout/head.jsp" %>
<link rel="stylesheet" href="css/style.css"/>
<body class="sb-nav-fixed">
    <%@ include file="Layout/navbar.jsp" %>
    <div id="layoutSidenav">
        <%@ include file="Layout/layoutSidenav_nav.jsp" %>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">Listado de Odontólogos</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="index.jsp">Inicio</a></li>
                        <li class="breadcrumb-item active">Odontólogos</li>
                    </ol>
                    
                    <!-- Mensaje de depuración -->
                    <% if (listaOdontologos == null || listaOdontologos.isEmpty()) { %>
                    <div class="alert alert-warning">
                        No hay odontólogos disponibles o la lista no se ha cargado.
                    </div>
                    <% } else { %>
                    <div class="alert alert-info">
                        Se encontraron <%= listaOdontologos.size() %> odontólogos.
                    </div>
                    <% } %>
                    
                    <!-- Buscador por especialidad -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-search me-1"></i>
                            Buscar por Especialidad
                        </div>
                        <div class="card-body">
                            <form action="SvOdontologo" method="GET">
                                <div class="row">
                                    <div class="col-md-8">
                                        <input type="hidden" name="action" value="buscarEspecialidad">
                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="especialidad" name="especialidad" type="text" placeholder="Especialidad" />
                                            <label for="especialidad">Especialidad</label>
                                        </div>
                                    </div>
                                    <div class="col-md-4 d-flex align-items-center">
                                        <button class="btn btn-primary" type="submit"><i class="fas fa-search"></i> Buscar</button>
                                        <a href="SvOdontologo" class="btn btn-secondary ms-2"><i class="fas fa-redo"></i> Mostrar Todos</a>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            Odontólogos Registrados
                            <div class="float-end">
                                <a href="SvOdontologo?action=nuevoOdontologo" class="btn btn-success btn-sm"><i class="fas fa-plus"></i> Nuevo Odontólogo</a>
                            </div>
                        </div>
                        <div class="card-body">
                            <table id="datatablesSimple" class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>DNI</th>
                                        <th>Nombre</th>
                                        <th>Apellidos</th>
                                        <th>Especialidad</th>
                                        <th>Teléfono</th>
                                        <th>Horario</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tfoot>
                                    <tr>
                                        <th>ID</th>
                                        <th>DNI</th>
                                        <th>Nombre</th>
                                        <th>Apellidos</th>
                                        <th>Especialidad</th>
                                        <th>Teléfono</th>
                                        <th>Horario</th>
                                        <th>Acciones</th>
                                    </tr>
                                </tfoot>
                                <tbody>
                                    <% if(listaOdontologos != null) { %>
                                        <% for (Odontologo odontologo : listaOdontologos) { %>
                                            <tr>
                                                <td><%= odontologo.getId()%></td>
                                                <td><%= odontologo.getDni() %></td>
                                                <td><%= odontologo.getNombre() %></td>
                                                <td><%= odontologo.getApellidos() %></td>
                                                <td><%= odontologo.getEspecialidad() %></td>
                                                <td><%= odontologo.getTelefono() %></td>
                                                <td>
                                                    <% if (odontologo.getHorario() != null) { %>
                                                        <%= odontologo.getHorario().getHorario_inicio() %> - <%= odontologo.getHorario().getHorario_fin() %>
                                                    <% } else { %>
                                                        <span class="text-muted">No asignado</span>
                                                    <% } %>
                                                </td>
                                                <td>
                                                    <div class="d-flex">
                                                        <!-- Botón para ver detalles -->
                                                        <button type="button" class="btn btn-info btn-sm me-1" 
                                                                data-bs-toggle="modal" data-bs-target="#detalleModal<%= odontologo.getId()%>">
                                                            <i class="fas fa-eye"></i>
                                                        </button>
                                                        
                                                        <!-- Botón para editar -->
                                                        <a href="SvOdontologo?id=<%= odontologo.getId()%>" class="btn btn-warning btn-sm me-1">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                        
                                                        <!-- Botón para eliminar -->
                                                        <form action="SvOdontologo" method="POST" style="display:inline;" 
                                                              onsubmit="return confirm('¿Está seguro que desea eliminar este odontólogo?');">
                                                            <input type="hidden" name="action" value="eliminar">
                                                            <input type="hidden" name="id" value="<%= odontologo.getId()%>">
                                                            <button type="submit" class="btn btn-danger btn-sm">
                                                                <i class="fas fa-trash-alt"></i>
                                                            </button>
                                                        </form>
                                                    </div>
                                                </td>
                                            </tr>
                                            
                                            <!-- Modal de Detalles -->
                                            <div class="modal fade" id="detalleModal<%= odontologo.getId()%>" tabindex="-1" aria-labelledby="detalleModalLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-lg">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="detalleModalLabel">Detalles del Odontólogo</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="row">
                                                                <div class="col-md-6">
                                                                    <h6>Información Personal</h6>
                                                                    <p><strong>ID:</strong> <%= odontologo.getId()%></p>
                                                                    <p><strong>DNI:</strong> <%= odontologo.getDni() %></p>
                                                                    <p><strong>Nombre:</strong> <%= odontologo.getNombre() %> <%= odontologo.getApellidos() %></p>
                                                                    <p><strong>Teléfono:</strong> <%= odontologo.getTelefono() %></p>
                                                                    <p><strong>Dirección:</strong> <%= odontologo.getDireccion() %></p>
                                                                    <p><strong>Fecha de Nacimiento:</strong> <%= odontologo.getFecha_nac() %></p>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <h6>Información Profesional</h6>
                                                                    <p><strong>Especialidad:</strong> <%= odontologo.getEspecialidad() %></p>
                                                                    <p><strong>Horario de Atención:</strong>
                                                                        <% if (odontologo.getHorario() != null) { %>
                                                                            <%= odontologo.getHorario().getHorario_inicio() %> - <%= odontologo.getHorario().getHorario_fin() %>
                                                                        <% } else { %>
                                                                            <span class="text-muted">No asignado</span>
                                                                        <% } %>
                                                                    </p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        <% } %>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
            <%@ include file="Layout/footer.jsp" %>
        </div>
    </div>
    <%@ include file="Layout/script.jsp" %>
    
    <!-- Script adicional para confirmación de eliminación -->
    <script>
        $(document).ready(function() {
            // DataTable ya debería estar inicializado en script.jsp
        });
    </script>
</body>
</html>