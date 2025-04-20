<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.clinicaodon.Entity.Odontologo"%>
<%@page import="com.clinicaodon.Entity.Paciente"%>
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
                        <h1>Nuevo Turno</h1>
        
        <% if(session.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <%= session.getAttribute("error") %>
                <% session.removeAttribute("error"); %>
            </div>
        <% } %>
        
        <form action="SvTurno" method="POST">
            <input type="hidden" name="action" value="crear">
            
            <div class="mb-3">
                <label for="odontologo_id" class="form-label">Odontólogo:</label>
                <select class="form-select" id="odontologo_id" name="odontologo_id" required>
                    <option value="">Seleccione un odontólogo</option>
                    <% 
                    List<Odontologo> listaOdontologos = (List<Odontologo>)session.getAttribute("listaOdontologos");
                    if(listaOdontologos != null && !listaOdontologos.isEmpty()){
                        for(Odontologo od : listaOdontologos) {
                    %>
                            <option value="<%= od.getId() %>"><%= od.getNombre() %> <%= od.getApellidos() %> - <%= od.getEspecialidad() %></option>
                    <%
                        }
                    }
                    %>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="paciente_id" class="form-label">Paciente:</label>
                <select class="form-select" id="paciente_id" name="paciente_id" required>
                    <option value="">Seleccione un paciente</option>
                    <% 
                    List<Paciente> listaPacientes = (List<Paciente>)session.getAttribute("listaPacientes");
                    if(listaPacientes != null && !listaPacientes.isEmpty()){
                        for(Paciente pac : listaPacientes) {
                    %>
                            <option value="<%= pac.getId() %>"><%= pac.getNombre() %> <%= pac.getApellidos() %> - DNI: <%= pac.getDni() %></option>
                    <%
                        }
                    }
                    %>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="fecha_turno" class="form-label">Fecha:</label>
                <input type="date" class="form-control" id="fecha_turno" name="fecha_turno" required>
            </div>
            
            <div class="mb-3">
                <label for="hora_turno" class="form-label">Hora:</label>
                <select class="form-select" id="hora_turno" name="hora_turno" required>
                    <option value="">Seleccione una hora</option>
                    <option value="08:00">08:00</option>
                    <option value="08:30">08:30</option>
                    <option value="09:00">09:00</option>
                    <option value="09:30">09:30</option>
                    <option value="10:00">10:00</option>
                    <option value="10:30">10:30</option>
                    <option value="11:00">11:00</option>
                    <option value="11:30">11:30</option>
                    <option value="12:00">12:00</option>
                    <option value="12:30">12:30</option>
                    <option value="14:00">14:00</option>
                    <option value="14:30">14:30</option>
                    <option value="15:00">15:00</option>
                    <option value="15:30">15:30</option>
                    <option value="16:00">16:00</option>
                    <option value="16:30">16:30</option>
                    <option value="17:00">17:00</option>
                    <option value="17:30">17:30</option>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="tratamiento" class="form-label">Tratamiento:</label>
                <input type="text" class="form-control" id="tratamiento" name="tratamiento" required>
            </div>
            
            <div id="disponibilidad-mensaje" class="mb-3" style="display: none;">
                <!-- Aquí se mostrará el mensaje de disponibilidad -->
            </div>
            
            <button type="submit" class="btn btn-primary">Guardar</button>
            <a href="SvTurno" class="btn btn-secondary">Cancelar</a>
        </form>
                </div>

                               </main>

    </div>
        </div>

    
    <script>
        // Script para verificar disponibilidad cuando se selecciona odontólogo, fecha y hora
        $(document).ready(function() {
            function verificarDisponibilidad() {
                var odontologoId = $('#odontologo_id').val();
                var fecha = $('#fecha_turno').val();
                var hora = $('#hora_turno').val();
                
                if(odontologoId && fecha && hora) {
                    $.ajax({
                        url: 'SvTurno',
                        type: 'POST',
                        data: {
                            action: 'verificarDisponibilidad',
                            odontologo_id: odontologoId,
                            fecha_turno: fecha,
                            hora_turno: hora
                        },
                        dataType: 'json',
                        success: function(response) {
                            var mensajeDiv = $('#disponibilidad-mensaje');
                            if(response.disponible) {
                                mensajeDiv.removeClass('alert-danger').addClass('alert alert-success');
                                mensajeDiv.html('Horario disponible para este odontólogo');
                            } else {
                                mensajeDiv.removeClass('alert-success').addClass('alert alert-danger');
                                mensajeDiv.html('Este horario ya está ocupado para el odontólogo seleccionado');
                            }
                            mensajeDiv.show();
                        },
                        error: function() {
                            $('#disponibilidad-mensaje').removeClass('alert-success').addClass('alert alert-danger');
                            $('#disponibilidad-mensaje').html('Error al verificar disponibilidad');
                            $('#disponibilidad-mensaje').show();
                        }
                    });
                }
            }
            
            $('#odontologo_id, #fecha_turno, #hora_turno').change(verificarDisponibilidad);
        });
    </script>
            <%@include file="Layout/script.jsp" %>

</body>
</html>