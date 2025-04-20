
<%@page import="com.clinicaodon.Entity.Horario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
                        <h1 class="mt-4">Lista de Horarios</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="index.jsp">Inicio</a></li>
                            <li class="breadcrumb-item active">Ver Horarios</li>
                        </ol>

                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-table me-1"></i>
                                Horarios Registrados
                                <div class="float-end">
                                    <a href="altaHorario.jsp" class="btn btn-primary btn-sm">
                                        <i class="fas fa-plus"></i> Nuevo Horario
                                    </a>
                                </div>
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple" class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Hora de Inicio</th>
                                            <th>Hora de fin</th>
                                            <th width="10%">Acciones</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>ID</th>
                                            <th>Hora de Inicio</th>
                                            <th>Hora de fin</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </tfoot>
                                    <%
    List<Horario> listaHorarios = (List) request.getSession().getAttribute("listaHorarios");
    if (listaHorarios != null) {
        for (Horario hor : listaHorarios) {
%>
            <tr>
                <td><%= hor.getId_horario()%></td>
                <td><%= hor.getHorario_inicio()%></td>
                <td><%= hor.getHorario_fin()%></td>
                <td>
                    <form action="SvHorario" method="POST" style="display:inline;">
                        <input type="hidden" name="action" value="eliminar">
                        <input type="hidden" name="id" value="<%= hor.getId_horario()%>">
                        <button type="submit" class="btn btn-danger btn-sm">
                            <i class="fas fa-trash-alt"></i>
                        </button>
                    </form>
                </td>
            </tr>
<%
        }
    } else {
%>
            <tr>
                <td colspan="4">No hay horarios disponibles.</td>
            </tr>
<%
    }
%>

                                </table>
                            </div>
                        </div>
                    </div>
                </main>

                <%@include file="Layout/footer.jsp" %>
            </div>
        </div>

        <%@include file="Layout/script.jsp" %>
    </body>
</html>
