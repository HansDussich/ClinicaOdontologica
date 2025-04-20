<%@page import="com.clinicaodon.Entity.Secretario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Secretario secretarioEditar = (Secretario) session.getAttribute("secretarioEditar");
    boolean enModoEdicion = secretarioEditar != null;
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
                        <h1 class="mt-4">Lista de Secretarios</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="../index.jsp">Inicio</a></li>
                            <li class="breadcrumb-item active">Ver Secretarios</li>
                        </ol>

                        <div class="card mb-4">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <span><i class="fas fa-table me-1"></i> Secretarios Registrados</span>
                                <a href="altaSecretarios.jsp" class="btn btn-primary btn-sm">
                                    <i class="fas fa-plus"></i> Nuevo Secretario
                                </a>
                            </div>
                            <div class="card-body">
                                <table id="datatablesSimple" class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>DNI</th>
                                            <th>Nombre</th>
                                            <th>Apellidos</th>
                                            <th>Teléfono</th>
                                            <th>Dirección</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>ID</th>
                                            <th>DNI</th>
                                            <th>Nombre</th>
                                            <th>Apellidos</th>
                                            <th>Teléfono</th>
                                            <th>Dirección</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                        <%
                                            List<Secretario> listaSecretarios = (List<Secretario>) request.getSession().getAttribute("listaSecretarios");
                                            if (listaSecretarios != null) {
                                                for (Secretario sec : listaSecretarios) {
                                        %>
                                        <tr>
                                            <td><%= sec.getId() %></td>
                                            <td><%= sec.getDni() %></td>
                                            <td><%= sec.getNombre() %></td>
                                            <td><%= sec.getApellidos() %></td>
                                            <td><%= sec.getTelefono() %></td>
                                            <td><%= sec.getDireccion() %></td>
                                            <td>
                                                <form action="SvSecretario" method="POST" class="d-inline">
                                                    <input type="hidden" name="action" value="eliminar">
                                                    <input type="hidden" name="id" value="<%= sec.getId() %>">
                                                    <button type="submit" class="btn btn-danger btn-sm" title="Eliminar">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                </form>
                                                <form action="SvSecretario" method="GET" class="d-inline">
                                                    <input type="hidden" name="id" value="<%= sec.getId() %>">
                                                    <button type="submit" class="btn btn-primary btn-sm" title="Editar">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                        <% 
                                                }
                                            } else { 
                                        %>
                                        <tr>
                                            <td colspan="7" class="text-center">No hay secretarios registrados.</td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <% if (enModoEdicion) { %>
                        <div class="card mb-4 border-warning shadow">
                            <div class="card-header bg-warning text-white">
                                <i class="fas fa-edit me-1"></i> Editar Secretario
                            </div>
                            <div class="card-body">
                                <form action="SvSecretario" method="POST">
                                    <input type="hidden" name="action" value="editar">
                                    <input type="hidden" name="id" value="<%= secretarioEditar.getId() %>">

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="dni" name="dni" type="text" value="<%= secretarioEditar.getDni() %>" required />
                                                <label for="dni">DNI</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="nombre" name="nombre" type="text" value="<%= secretarioEditar.getNombre() %>" required />
                                                <label for="nombre">Nombre</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="apellidos" name="apellidos" type="text" value="<%= secretarioEditar.getApellidos() %>" required />
                                                <label for="apellidos">Apellidos</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="telefono" name="telefono" type="text" value="<%= secretarioEditar.getTelefono() %>" required />
                                                <label for="telefono">Teléfono</label>
                                            </div>
                                        </div>
                                    </div>

                                     <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="direccion" name="direccion" type="text" value="<%= secretarioEditar.getDireccion()%>" required />
                                                <label for="direccion">Direccion</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="fechaNac" name="fechaNac" type="date" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(secretarioEditar.getFecha_nac()) %>"  required />
                                                <label for="fechaNac">Fecha Nacimiento</label>
                                            </div>
                                        </div>
                                    </div>
                                                
                                                 <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="sector" name="sector" type="text" value="<%= secretarioEditar.getSector()%>" required />
                                                <label for="sector">Sector</label>
                                            </div>
                                        </div>

                                    <div class="mt-4 mb-0 d-flex justify-content-end">
                                        <a href="SvSecretario" class="btn btn-secondary me-2">Cancelar</a>
                                        <button type="submit" class="btn btn-warning text-white">Guardar Cambios</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <% } %>

                    </div>
                </main>
                <%@include file="Layout/footer.jsp" %>
            </div>
        </div>

        <%@include file="Layout/script.jsp" %>
    </body>
</html>
