<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.upiiticket.model.Usuario" %>
<%@ page import="com.upiiticket.model.Evento" %>
<%@ page import="com.upiiticket.dao.EventoDAO" %>
<%@ page import="com.upiiticket.dao.Conexion" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Connection" %>
<%
    // Verificar sesión
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuario") == null) {
        response.sendRedirect("../login.html");
        return;
    }
    
    Usuario usuario = (Usuario) sesion.getAttribute("usuario");
    
    // Verificar que sea ORGANIZADOR
    if (!"ORGANIZADOR".equalsIgnoreCase(usuario.getRol())) {
        response.sendRedirect("../login.html");
        return;
    }

    // Obtener evento a editar
    int idEvento = Integer.parseInt(request.getParameter("id"));
    Connection con = Conexion.getConnection();
    EventoDAO eventoDAO = new EventoDAO(con);
    Evento evento = eventoDAO.obtenerEventoPorId(idEvento);
    con.close();

    // Formatear fecha para input type="date"
    String fechaFormateada = evento.getFecha().toString().substring(0, 10);
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Evento | UpiiTicket</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #FFD700;
            --error-color: #e74c3c;
            --text-color: #333;
            --light-gray: #f5f5f5;
            --white: #ffffff;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light-gray);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-image: linear-gradient(135deg, rgba(44, 62, 80, 0.8) 0%, rgba(0, 0, 0, 0.8) 100%), url('https://images.unsplash.com/photo-1531058020387-3be344556be6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            color: var(--white);
        }
        
        .edit-container {
            width: 100%;
            max-width: 600px;
            padding: 40px;
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            transform: translateY(0);
            transition: all 0.3s ease;
            color: var(--primary-color);
        }
        
        .edit-container:hover {
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
            transform: translateY(-5px);
        }
        
        .title {
            text-align: center;
            margin-bottom: 30px;
            font-size: 28px;
            color: var(--primary-color);
            position: relative;
        }
        
        .title::after {
            content: '';
            display: block;
            width: 60px;
            height: 4px;
            background: var(--secondary-color);
            margin: 10px auto;
            border-radius: 2px;
        }
        
        .form-group {
            position: relative;
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--primary-color);
        }
        
        .form-control {
            width: 100%;
            padding: 15px;
            border: 2px solid #e1e1e1;
            border-radius: 6px;
            font-size: 16px;
            transition: all 0.3s;
            background-color: var(--light-gray);
        }
        
        .form-control:focus {
            border-color: var(--secondary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(255, 215, 0, 0.2);
            background-color: var(--white);
        }
        
        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }
        
        .btn {
            width: 100%;
            padding: 15px;
            background-color: var(--primary-color);
            color: var(--white);
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .btn:hover {
            background-color: #1a252f;
            transform: translateY(-2px);
        }
        
        .btn-secondary {
            background-color: #6c757d;
        }
        
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        
        .logo {
            text-align: center;
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
            color: var(--secondary-color);
        }
        
        @media (max-width: 768px) {
            .edit-container {
                padding: 30px 20px;
                margin: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="edit-container">
        <div class="logo">
            <i class="fas fa-ticket-alt"></i> UpiiTicket
        </div>
        <h2 class="title">Editar Evento</h2>
        
        <form action="../ActualizarEvento" method="post">
            <input type="hidden" name="id_evento" value="<%= evento.getId_evento() %>">
            
            <div class="form-group">
                <label for="titulo">Título:</label>
                <input type="text" id="titulo" name="titulo" value="<%= evento.getTitulo() %>" class="form-control" required>
            </div>
            
            <div class="form-group">
                <label for="descripcion">Descripción:</label>
                <textarea id="descripcion" name="descripcion" class="form-control" required><%= evento.getDescripcion() %></textarea>
            </div>
            
            <div class="form-group">
                <label for="fecha">Fecha y Hora:</label>
                <input type="datetime-local" id="fecha" name="fecha" value="<%= fechaFormateada.replace(' ', 'T') %>" class="form-control" required>
            </div>
            
            <div class="form-group">
                <label for="lugar">Lugar:</label>
                <input type="text" id="lugar" name="lugar" value="<%= evento.getLugar() %>" class="form-control" required>
            </div>
            
            <button type="submit" class="btn">
                <i class="fas fa-save"></i> Guardar Cambios
            </button>
            
            <a href="gestionarEventos.jsp" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Volver
            </a>
        </form>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const params = new URLSearchParams(window.location.search);
            
            if (params.has("error")) {
                // Mostrar mensaje de error si existe
                const errorDiv = document.createElement("div");
                errorDiv.className = "form-group error-message";
                errorDiv.innerHTML = `
                    <div style="color: var(--error-color); padding: 12px; margin-top: 20px;
                        border-radius: 6px; background-color: #fadbd8; text-align: center;
                        font-size: 14px; font-weight: 500;">
                        Hubo un error al actualizar el evento. Por favor intenta nuevamente.
                    </div>
                `;
                
                document.querySelector('form').insertBefore(errorDiv, document.querySelector('.form-group'));
                
                // Agitar el formulario para llamar la atención al error
                document.querySelector('.edit-container').animate([
                    { transform: 'translateX(0)' },
                    { transform: 'translateX(-10px)' },
                    { transform: 'translateX(10px)' },
                    { transform: 'translateX(0)' }
                ], {
                    duration: 300,
                    iterations: 2
                });
            }
            
            if (params.has("success")) {
                // Mostrar mensaje de éxito si existe
                const successDiv = document.createElement("div");
                successDiv.className = "form-group success-message";
                successDiv.innerHTML = `
                    <div style="color: #28a745; padding: 12px; margin-top: 20px;
                        border-radius: 6px; background-color: #d4edda; text-align: center;
                        font-size: 14px; font-weight: 500;">
                        Evento actualizado correctamente!
                    </div>
                `;
                
                document.querySelector('form').insertBefore(successDiv, document.querySelector('.form-group'));
            }
        });
    </script>
</body>
</html>