<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.upiiticket.model.Usuario"%>
<%@page import="com.upiiticket.dao.Conexion"%>
<%@page import="com.upiiticket.dao.EventoDAO"%>
<%@page import="com.upiiticket.model.Evento"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
    // Verificar que el usuario inició sesión
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("../login.html?error=3"); // No hay sesión
        return;
    }
    // Verificar que sea Asistente
    if (!"ASISTENTE".equalsIgnoreCase(usuario.getRol())) {
        response.sendRedirect("../login.html?error=4"); // Rol inválido
        return;
    }

    // Obtener todos los eventos disponibles
    java.sql.Connection con = Conexion.getConnection();
    EventoDAO eventoDAO = new EventoDAO(con);
    List<Evento> listaEventos = eventoDAO.obtenerTodosLosEventos();
    con.close();
    
    SimpleDateFormat dateFormat = new SimpleDateFormat("EEEE, d 'de' MMMM 'de' yyyy 'a las' hh:mm a");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Principal Asistente</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            padding-top: 70px; /* Espacio para la navbar fija */
            background-color: #f5f5f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .welcome-section {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .welcome-title {
            color: #2c3e50;
            font-size: 28px;
            margin-bottom: 15px;
        }
        
        .username {
            color: #FFD700;
            font-weight: 600;
        }
        
        .eventos-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        
        .evento-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border-left: 4px solid #FFD700;
        }
        
        .evento-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }
        
        .evento-title {
            color: #2c3e50;
            font-size: 20px;
            margin-bottom: 10px;
            font-weight: 600;
        }
        
        .evento-descripcion {
            color: #555;
            margin-bottom: 15px;
            line-height: 1.5;
        }
        
        .evento-info {
            margin-bottom: 10px;
            font-size: 14px;
            color: #666;
        }
        
        .evento-info i {
            margin-right: 8px;
            color: #FFD700;
        }
        
        .btn {
            display: inline-block;
            background-color: #2c3e50;
            color: white;
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 500;
            transition: background-color 0.3s;
            border: none;
            cursor: pointer;
            margin-top: 10px;
        }
        
        .btn:hover {
            background-color: #1a252f;
        }
        
        .btn-gold {
            background-color: #FFD700;
            color: #2c3e50;
        }
        
        .btn-gold:hover {
            background-color: #e6c200;
        }
        
        .no-events {
            text-align: center;
            color: #666;
            font-size: 18px;
            margin-top: 40px;
        }
    </style>
</head>
<body>
    <jsp:include page="navbar.jsp" />
    
    <div class="main-container">
        <h1>Eventos Disponibles</h1>
        
        <%
            if (listaEventos != null && !listaEventos.isEmpty()) {
        %>
            <div class="eventos-container">
                <%
                    for (Evento ev : listaEventos) {
                %>
                <div class="evento-card">
                    <h3 class="evento-title"><%= ev.getTitulo() %></h3>
                    <p class="evento-descripcion"><%= ev.getDescripcion() %></p>
                    
                    <div class="evento-info">
                        <i class="fas fa-calendar-alt"></i>
                        <span><%= dateFormat.format(ev.getFecha()) %></span>
                    </div>
                    
                    <div class="evento-info">
                        <i class="fas fa-map-marker-alt"></i>
                        <span><%= ev.getLugar() %></span>
                    </div>
                    
                    <a href="solicitarCodigo.jsp?eventoId=<%= ev.getId_evento() %>" class="btn btn-gold">
                        <i class="fas fa-ticket-alt"></i> Obtener Boleto
                    </a>
                </div>
                <%
                    }
                %>
            </div>
        <%
            } else {
        %>
            <p class="no-events">No hay eventos disponibles en este momento.</p>
        <%
            }
        %>
    </div>
</body>
</html>

