<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%@include file="Layout/head.jsp" %>
    <link rel="stylesheet" href="css/style.css"/>

    <body class="sb-nav-fixed">
        <!-- Incluir navbar -->
        <%@include file="Layout/navbar.jsp" %>

        <div id="layoutSidenav">
            <!-- Incluir el layoutSidenav_nav -->
            <%@include file="Layout/layoutSidenav_nav.jsp" %>

            <div id="layoutSidenav_content">

                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">Alta Horario</h1>
                        <ol class="breadcrumb mb-4">
                            <li class="breadcrumb-item"><a href="index.jsp">Inicio</a></li>
                            <li class="breadcrumb-item"><a href="verHorarios.jsp">Ver Horarios</a></li>
                            <li class="breadcrumb-item active">Alta Horarios</li>
                        </ol>

                        <div class="card mb-4">
                            <div class="card-header">
                                <i class="fas fa-user-plus me-1"></i>
                                Nuevo Horario
                            </div>
                            <div class="card-body">
                                
                                <form action="SvHorario" method="POST" >
                                    <input type="hidden" name="action" value="crear">

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="horario_inicio" name="horario_inicio" type="time" required />
                                                <label for="horario_inicio">Horario de Inicio</label>
                                            </div>
                                        </div>
                                       <div class="col-md-6">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="horario_fin" name="horario_fin" type="time" required />
                                                <label for="horario_fin">Horario de Fin</label>
                                            </div>
                                        </div>
                                    </div>

                                   

                                    <!-- Botones fuera del row de inputs -->
                                    <div class="mt-4 mb-0">
                                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                            <a href="verHorario.jsp" class="btn btn-secondary">Cancelar</a>
                                            <button type="submit" class="btn btn-primary">Guardar Horario</button>
                                        </div>
                                    </div>


                            </div>

                            </form>
                        </div>
                    </div>

                </main>
                <%@include file="Layout/footer.jsp" %>

            </div>
        </div>


        <!-- Scripts -->
        <%@include file="Layout/script.jsp" %>
    </body>
</html>