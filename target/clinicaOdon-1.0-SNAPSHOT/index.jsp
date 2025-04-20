<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="com.clinicaodon.Entity.Turno" %>
<%@page import="com.clinicaodon.Entity.Odontologo" %>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
<%@page import="Controladora.ContTurno" %>
<%@page import="Controladora.ContUsuario" %>
<%@page import="Controladora.ContOdontologo" %>

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
                        <div class="text-center my-4">
                            <h1 class="display-5 fw-bold text-primary">Clínica Odontológica</h1>
                        </div>

                        <hr class="my-4"/>

                        <!-- Sección de Turnos -->
                        <div class="card shadow mb-4">
                            <div class="card-header bg-primary text-white">
                                <i class="fas fa-calendar-alt me-2"></i> Turnos del Día
                            </div>
                            
                            <div class="card-body">
                                <%
                                    String usuarioActual = (String) session.getAttribute("usuario");
                                    ContTurno controlTurno = new ContTurno();
                                    ContUsuario controlUsuario = new ContUsuario();
                                    ContOdontologo controlOdontologo = new ContOdontologo();
                                    
                                    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                                    String fechaHoy = formatter.format(new Date());
                                    
                                    List<Turno> turnosAMostrar = new ArrayList<>();
                                    String rol = controlUsuario.obtenerRolUsuario(usuarioActual);
                                    
                                    if (rol.equals("ODONTOLOGO")) {
                                        Odontologo odontologo = controlOdontologo.buscarOdontologoPorUsuario(usuarioActual);
                                        if (odontologo != null) {
                                            turnosAMostrar = controlTurno.buscarTurnosPorOdontologo(odontologo);
                                        }
                                    } else {
                                        turnosAMostrar = controlTurno.buscarTurnosPorFecha(fechaHoy);
                                    }
                                %>

                                <div class="table-responsive">
                                    <table class="table table-hover align-middle" id="tablaTurnos">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Fecha</th>
                                                <th>Hora</th>
                                                <th>Paciente</th>
                                                <th>Odontólogo</th>
                                                <th>Tratamiento</th>
                                                <th>Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% if (turnosAMostrar != null && !turnosAMostrar.isEmpty()) { %>
                                                <% for (Turno turno : turnosAMostrar) { %>
                                                    <tr>
                                                        <td><%= turno.getFecha_turno() %></td>
                                                        <td><%= turno.getHora_turno() %></td>
                                                        <td><%= turno.getPaciente().getNombre() + " " + turno.getPaciente().getApellidos() %></td>
                                                        <td><%= turno.getOdontologo().getNombre() + " " + turno.getOdontologo().getApellidos() %></td>
                                                        <td><%= turno.getTratamiento() %></td>
                                                        <td>
                                                            <div class="d-flex">
                                                                <a href="SvTurno?id=<%= turno.getId_turno() %>" class="btn btn-sm btn-outline-primary me-2" title="Editar">
                                                                    <i class="fas fa-edit"></i>
                                                                </a>
                                                                <form action="SvTurno" method="POST" onsubmit="return confirm('¿Está seguro que desea eliminar este turno?');">
                                                                    <input type="hidden" name="action" value="eliminar">
                                                                    <input type="hidden" name="id_turno" value="<%= turno.getId_turno() %>">
                                                                    <button type="submit" class="btn btn-sm btn-outline-danger" title="Eliminar">
                                                                        <i class="fas fa-trash"></i>
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                <% } %>
                                            <% } else { %>
                                                <tr>
                                                    <td colspan="6" class="text-center text-muted">No hay turnos disponibles</td>
                                                </tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <!-- Sección de Imagen -->
                        <div class="card shadow mb-5">
                            <div class="card-header bg-info text-white">
                                <i class="fas fa-smile-beam me-2"></i> El mejor servicio con el mejor personal
                            </div>
                            <div class="card-body text-center">
                                <img src="img/odontologia.jpg" class="img-fluid rounded shadow-sm" style="max-height: 350px;" alt="Odontología" />
                            </div>
                        </div>

                    </div>
                </main>
                <%@include file="Layout/footer.jsp" %>
            </div>
        </div>

            <script>
$(document).ready(function () {
    if ($.fn.DataTable.isDataTable('#tablaTurnos')) {
        $('#tablaTurnos').DataTable().clear().destroy();
    }

    $('#tablaTurnos').DataTable({
        dom: 'Bfrtip',
        buttons: [
            {
                extend: 'copy',
                className: 'btn btn-outline-primary rounded-pill shadow-sm',
                text: '<i class="fas fa-copy"></i> Copiar',
                titleAttr: 'Copiar'
            },
            {
                extend: 'csv',
                className: 'btn btn-outline-success rounded-pill shadow-sm',
                text: '<i class="fas fa-file-csv"></i> CSV',
                titleAttr: 'Exportar CSV'
            },
            {
                extend: 'excel',
                className: 'btn btn-outline-success rounded-pill shadow-sm',
                text: '<i class="fas fa-file-excel"></i> Excel',
                titleAttr: 'Exportar Excel'
            },
            {
                extend: 'pdf',
                className: 'btn btn-outline-danger rounded-pill shadow-sm',
                text: '<i class="fas fa-file-pdf"></i> PDF',
                titleAttr: 'Exportar PDF'
            },
            {
                extend: 'print',
                className: 'btn btn-outline-dark rounded-pill shadow-sm',
                text: '<i class="fas fa-print"></i> Imprimir',
                titleAttr: 'Imprimir'
            }
        ],
        language: {
            url: '//cdn.datatables.net/plug-ins/1.13.6/i18n/es-ES.json'
        },
        responsive: true
    });
});
</script>


        <%@include file="Layout/script.jsp" %>
    </body>
</html>
