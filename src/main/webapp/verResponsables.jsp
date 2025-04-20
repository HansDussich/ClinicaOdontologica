<%@page import="com.clinicaodon.Entity.Responsable"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Responsable responsableEditar = (Responsable) session.getAttribute("responsableEditar");
    boolean enModoEdicion = responsableEditar != null;
    List<Responsable> listaResponsables = (List) session.getAttribute("listaResponsables");
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
                        <h1 class="mt-4">Lista de Responsables</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="index.jsp">Inicio</a></li>
                            <li class="breadcrumb-item active">Ver Responsables</li>
                        </ol>

                        <!-- Mensaje de depuración -->
                        <% if (listaResponsables == null || listaResponsables.isEmpty()) { %>
                        <div class="alert alert-warning">
                            No hay responsables disponibles o la lista no se ha cargado.
                        </div>
                        <% } else { %>
                        <div class="alert alert-info">
                            Se encontraron <%= listaResponsables.size() %> responsables.
                        </div>
                        <% } %>

                        <div class="card mb-4">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <span><i class="fas fa-table me-1"></i> Responsables Registrados</span>
                                <a href="altaResponsables.jsp" class="btn btn-primary btn-sm">
                                    <i class="fas fa-plus"></i> Nuevo Responsable
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
                                            <th>Fecha Nac.</th>
                                            <th>Tipo Responsable</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            if (listaResponsables != null && !listaResponsables.isEmpty()) {
                                                for (Responsable r : listaResponsables) {
                                        %>
                                        <tr>
                                            <td><%= r.getId() %></td>
                                            <td><%= r.getDni() %></td>
                                            <td><%= r.getNombre() %></td>
                                            <td><%= r.getApellidos() %></td>
                                            <td><%= r.getTelefono() %></td>
                                            <td><%= r.getDireccion() %></td>
                                            <td><%= r.getFecha_nac() %></td>
                                            <td><%= r.getTipo_responsable() %></td>
                                            <td>
                                                <form action="SvResponsable" method="POST" class="d-inline">
                                                    <input type="hidden" name="action" value="eliminar">
                                                    <input type="hidden" name="id" value="<%= r.getId() %>">
                                                    <button type="submit" class="btn btn-danger btn-sm" title="Eliminar">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                </form>
                                                <form action="SvResponsable" method="GET" class="d-inline">
                                                    <input type="hidden" name="id" value="<%= r.getId() %>">
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
                                            <td colspan="9" class="text-center">No hay responsables registrados.</td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <% if (enModoEdicion) { %>
                        <div class="card mb-4 border-warning shadow">
                            <div class="card-header bg-warning text-white">
                                <i class="fas fa-edit me-1"></i> Editar Responsable
                            </div>
                            <div class="card-body">
                                <form action="SvResponsable" method="POST">
                                    <input type="hidden" name="action" value="editar">
                                    <input type="hidden" name="id" value="<%= responsableEditar.getId() %>">

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="dni" name="dni" type="text" value="<%= responsableEditar.getDni() %>" required />
                                                <label for="dni">DNI</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="nombre" name="nombre" type="text" value="<%= responsableEditar.getNombre() %>" required />
                                                <label for="nombre">Nombre</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="apellidos" name="apellidos" type="text" value="<%= responsableEditar.getApellidos() %>" required />
                                                <label for="apellidos">Apellidos</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="telefono" name="telefono" type="text" value="<%= responsableEditar.getTelefono() %>" required />
                                                <label for="telefono">Teléfono</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="direccion" name="direccion" type="text" value="<%= responsableEditar.getDireccion() %>" required />
                                                <label for="direccion">Dirección</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="fechaNac" name="fechaNac" type="date" value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(responsableEditar.getFecha_nac()) %>" required />
                                                <label for="fechaNac">Fecha de Nacimiento</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-floating mb-3">
                                        <input class="form-control" id="tipo_responsable" name="tipo_responsable" type="text" value="<%= responsableEditar.getTipo_responsable() %>" required />
                                        <label for="tipo_responsable">Tipo de Responsable</label>
                                    </div>

                                    <div class="text-end">
                                        <button class="btn btn-success" type="submit">Guardar Cambios</button>
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
            
            
                <%@ include file="Layout/script.jsp" %>

                
                    <script>
        $(document).ready(function() {
            // DataTable ya debería estar inicializado en script.jsp
        });
    </script>
    
    </body>
</html>