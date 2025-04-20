<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.clinicaodon.Entity.Turno"%>
<%@page import="com.clinicaodon.Entity.Odontologo"%>
<%@page import="com.clinicaodon.Entity.Paciente"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Turno</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h2 class="text-center">Editar Turno</h2>
                    </div>
                    <div class="card-body">
                        <% 
                            String error = (String) session.getAttribute("error");
                            if (error != null) {
                        %>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <%= error %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <% 
                            session.removeAttribute("error");
                            }
                            
                            Turno turno = (Turno) session.getAttribute("turnoEditar");
                            List<Odontologo> listaOdontologos = (List<Odontologo>) session.getAttribute("listaOdontologos");
                            List<Paciente> listaPacientes = (List<Paciente>) session.getAttribute("listaPacientes");
                            
                            if (turno != null && listaOdontologos != null && listaPacientes != null) {
                        %>
                        <form action="SvTurno" method="POST">
                            <input type="hidden" name="action" value="editar">
                            <input type="hidden" name="id_turno" value="<%= turno.getId_turno() %>">
                            
                            <div class="mb-3">
                                <label for="fecha_turno" class="form-label">Fecha:</label>
                                <input type="date" class="form-control" id="fecha_turno" name="fecha_turno" value="<%= turno.getFecha_turno() %>" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="hora_turno" class="form-label">Hora:</label>
                                <input type="time" class="form-control" id="hora_turno" name="hora_turno" value="<%= turno.getHora_turno() %>" required>
                            </div>
                            
                            <div class="mb-3">
                                <label for="odontologo_id" class="form-label">Odontólogo:</label>
                                <select class="form-select" id="odontologo_id" name="odontologo_id" required>
                                    <option value="">Seleccione un odontólogo</option>
                                    <% for (Odontologo odontologo : listaOdontologos) { %>
                                        <option value="<%= odontologo.getId() %>" <%= (turno.getOdontologo() != null && turno.getOdontologo().getId() == odontologo.getId()) ? "selected" : "" %>>
                                            <%= odontologo.getNombre() %> <%= odontologo.getApellidos() %> - <%= odontologo.getEspecialidad() %>
                                        </option>
                                    <% } %>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label for="paciente_id" class="form-label">Paciente:</label>
                                <select class="form-select" id="paciente_id" name="paciente_id" required>
                                    <option value="">Seleccione un paciente</option>
                                    <% for (Paciente paciente : listaPacientes) { %>
                                        <option value="<%= paciente.getId() %>" <%= (turno.getPaciente() != null && turno.getPaciente().getId() == paciente.getId()) ? "selected" : "" %>>
                                            <%= paciente.getNombre() %> <%= paciente.getApellidos() %> - DNI: <%= paciente.getDni() %>
                                        </option>
                                    <% } %>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label for="tratamiento" class="form-label">Tratamiento:</label>
                                <textarea class="form-control" id="tratamiento" name="tratamiento" rows="3" required><%= turno.getTratamiento() %></textarea>
                            </div>
                            
                            <div id="disponibilidadAlert" style="display: none;" class="alert alert-warning">
                                El odontólogo no está disponible en la fecha y hora seleccionadas.
                            </div>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="SvTurno" class="btn btn-secondary me-md-2">Cancelar</a>
                                <button type="button" class="btn btn-info me-md-2" onclick="verificarDisponibilidad()">Verificar disponibilidad</button>
                                <button type="submit" class="btn btn-primary">Guardar cambios</button>
                            </div>
                        </form>
                        <% } else { %>
                        <div class="alert alert-danger">
                            No se encontró el turno a editar o faltan datos necesarios.
                            <div class="mt-3">
                                <a href="SvTurno" class="btn btn-primary">Volver a la lista de turnos</a>
                            </div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        function verificarDisponibilidad() {
            const odontologoId = document.getElementById('odontologo_id').value;
            const fecha = document.getElementById('fecha_turno').value;
            const hora = document.getElementById('hora_turno').value;
            const turnoId = <%= turno != null ? turno.getId_turno() : 0 %>;
            
            if (!odontologoId || !fecha || !hora) {
                alert('Por favor complete los campos de odontólogo, fecha y hora para verificar disponibilidad.');
                return;
            }
            
            // Realizar petición AJAX para verificar disponibilidad
            fetch('SvTurno?action=verificarDisponibilidad&odontologo_id=' + odontologoId + '&fecha_turno=' + fecha + '&hora_turno=' + hora + '&id_turno=' + turnoId, {
                method: 'POST'
            })
            .then(response => response.json())
            .then(data => {
                const alertElement = document.getElementById('disponibilidadAlert');
                if (data.disponible) {
                    alertElement.style.display = 'none';
                    alert('¡Horario disponible! Puede guardar el turno.');
                } else {
                    alertElement.style.display = 'block';
                }
            })
            .catch(error => {
                console.error('Error al verificar disponibilidad:', error);
                alert('Ocurrió un error al verificar disponibilidad. Intente nuevamente.');
            });
        }
    </script>
</body>
</html>