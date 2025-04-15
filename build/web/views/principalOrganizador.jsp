<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.upiiticket.model.Usuario"%>
<%@page import="com.upiiticket.dao.Conexion"%>
<%@page import="com.upiiticket.dao.EventoDAO"%>
<%@page import="com.upiiticket.model.Evento"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
    // Lógica original sin cambios
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("../login.html?error=3");
        return;
    }
    if (!"ORGANIZADOR".equalsIgnoreCase(usuario.getRol())) {
        response.sendRedirect("../login.html?error=4");
        return;
    }

    java.sql.Connection con = Conexion.getConnection();
    EventoDAO eventoDAO = new EventoDAO(con);
    List<Evento> listaEventos = eventoDAO.obtenerEventosPorOrganizador(usuario.getId());
    con.close();
    
    SimpleDateFormat dateFormat = new SimpleDateFormat("EEEE, d 'de' MMMM 'de' yyyy 'a las' hh:mm a");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Organizador | Plataforma Eventos</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Estilos idénticos a principalAsistente */
        body {
            padding-top: 70px;
            background-color: #f5f5f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .main-container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 30px;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            flex-wrap: wrap;
            gap: 20px;
        }
        
        .page-title {
            color: #2c3e50;
            font-size: 28px;
            margin: 0;
        }
        
        .username {
            color: #FFD700;
            font-weight: 600;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 10px 20px;
            background-color: #FFD700;
            color: #2c3e50;
            text-decoration: none;
            border-radius: 4px;
            font-weight: 600;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
        }
        
        .btn:hover {
            background-color: #e6c200;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .section-title {
            color: #2c3e50;
            font-size: 22px;
            margin: 30px 0 20px;
            border-bottom: 2px solid #FFD700;
            padding-bottom: 8px;
        }
        
        .events-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        
        .event-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            transition: all 0.3s ease;
            border-left: 4px solid #FFD700;
        }
        
        .event-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }
        
        .event-title {
            color: #2c3e50;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .event-description {
            color: #555;
            margin-bottom: 15px;
            line-height: 1.5;
        }
        
        .event-info {
            margin-bottom: 10px;
            font-size: 14px;
            color: #666;
        }
        
        .event-info i {
            margin-right: 8px;
            color: #FFD700;
        }
        
        .no-events {
            text-align: center;
            color: #666;
            font-size: 18px;
            grid-column: 1 / -1;
            padding: 40px 0;
        }
        
        /* Barra de navegación idéntica pero para organizador */
        .navbar {
            background: rgba(40, 40, 40, 0.95);
            padding: 10px 0;
            width: 100%;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            backdrop-filter: blur(5px);
            transition: transform 0.3s ease-in-out;
        }
        
        .navbar-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .user-welcome {
            color: #f0f0f0;
            font-size: 16px;
            font-weight: 500;
        }
        
        .username-nav {
            color: #FFD700;
            font-weight: 600;
        }
        
        .nav-list {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
            gap: 15px;
            align-items: center;
        }
        
        .nav-item {
            margin: 0;
        }
        
        .nav-link {
            color: #f0f0f0;
            text-decoration: none;
            font-size: 15px;
            padding: 8px 15px;
            border-radius: 4px;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            font-weight: 500;
            gap: 8px;
        }
        
        .nav-link:hover {
            background: rgba(255, 215, 0, 0.15);
            color: #FFD700;
        }
        
        .logout {
            background: rgba(255, 80, 80, 0.2);
            border: 1px solid rgba(255, 80, 80, 0.4);
        }
        
        .logout:hover {
            background: rgba(255, 80, 80, 0.3);
        }
        
        .navbar.hidden {
            transform: translateY(-100%);
        }
    </style>
</head>
<body>
    <!-- Barra de navegación similar pero adaptada para organizador -->
    <nav class="navbar" id="mainNavbar">
        <div class="navbar-container">
            <div class="user-welcome">
                <i class="fas fa-user-tie"></i> Organizador: <span class="username-nav"><%= usuario.getNombre() %></span>
            </div>
            <ul class="nav-list">
                <li class="nav-item"><a href="principalOrganizador.jsp" class="nav-link"><i class="fas fa-home"></i> Inicio</a></li>
                <li class="nav-item"><a href="crearEvento.jsp" class="nav-link"><i class="fas fa-plus-circle"></i> Crear Evento</a></li>
                <li class="nav-item"><a href="menuOrganizador.jsp" class="nav-link"><i class="fas fa-cog"></i> Configuración</a></li>
                <li class="nav-item"><a href="${pageContext.request.contextPath}/cerrarSesion" class="nav-link logout"><i class="fas fa-sign-out-alt"></i> Cerrar Sesión</a></li>
            </ul>
        </div>
    </nav>
    
    <div class="main-container">
        <div class="page-header">
            <h1 class="page-title">Bienvenido, <span class="username"><%= usuario.getNombre() %></span></h1>
            <a href="crearEvento.jsp" class="btn">
                <i class="fas fa-plus"></i> Crear Nuevo Evento
            </a>
        </div>
        
        <h2 class="section-title">
            <i class="fas fa-calendar-alt"></i> Mis Eventos
        </h2>
        
        <%
            if (listaEventos != null && !listaEventos.isEmpty()) {
        %>
            <div class="events-container">
                <%
                    for (Evento ev : listaEventos) {
                %>
                <div class="event-card">
                    <h3 class="event-title"><%= ev.getTitulo() %></h3>
                    <p class="event-description"><%= ev.getDescripcion() %></p>
                    
                    <div class="event-info">
                        <i class="fas fa-calendar-alt"></i>
                        <span><%= dateFormat.format(ev.getFecha()) %></span>
                    </div>
                    
                    <div class="event-info">
                        <i class="fas fa-map-marker-alt"></i>
                        <span><%= ev.getLugar() %></span>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        <%
            } else {
        %>
            <p class="no-events">No has creado ningún evento aún.</p>
        <%
            }
        %>
    </div>

    <script>
        // Mismo script de la barra de navegación
        document.addEventListener('DOMContentLoaded', function() {
            const navbar = document.getElementById('mainNavbar');
            let lastScroll = 0;
            
            window.addEventListener('scroll', function() {
                const currentScroll = window.pageYOffset;
                
                if (currentScroll <= 0) {
                    navbar.classList.remove('hidden');
                    return;
                }
                
                if (currentScroll > lastScroll && !navbar.classList.contains('hidden')) {
                    navbar.classList.add('hidden');
                } else if (currentScroll < lastScroll && navbar.classList.contains('hidden')) {
                    navbar.classList.remove('hidden');
                }
                
                lastScroll = currentScroll;
            });
        });
    </script>
</body>
</html>