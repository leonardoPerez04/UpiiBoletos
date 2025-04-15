<%-- 
    Document   : navbar
    Created on : 25 mar. 2025, 22:10:05
    Author     : lpere
--%>

<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.upiiticket.model.Usuario" %>
<%
    HttpSession sesion = request.getSession();
    Boolean nuevaNotificacion = (Boolean) sesion.getAttribute("nuevaNotificacion");
    int notificaciones = (nuevaNotificacion != null && nuevaNotificacion) ? 1 : 0;
    Usuario usuario = (Usuario) sesion.getAttribute("usuario");
%>

<nav class="navbar">
    <div class="navbar-container">
        <div class="user-welcome">
            <i class="fas fa-user-circle"></i> Bienvenido, <span class="username"><%= usuario != null ? usuario.getNombre() : "Invitado" %></span>
        </div>
        <ul class="nav-list">
            <li class="nav-item"><a href="principalAsistente.jsp" class="nav-link"><i class="fas fa-home"></i> Inicio</a></li>
            <li class="nav-item">
                <a href="misCodigos.jsp" class="nav-link"><i class="fas fa-ticket-alt"></i> Mis Códigos 
                    <% if (notificaciones > 0) { %>
                        <span class="notificacion"><%= notificaciones %></span>
                    <% } %>
                </a>
            </li>
            <li class="nav-item"><a href="menuAsistente.jsp" class="nav-link"><i class="fas fa-cog"></i> Configuración</a></li>
            <li class="nav-item"><a href="${pageContext.request.contextPath}/cerrarSesion" class="nav-link logout"><i class="fas fa-sign-out-alt"></i> Cerrar Sesión</a></li>
        </ul>
    </div>
</nav>

<style>
    /* Estilos mejorados para la barra de navegación */
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
    
    .username {
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
    
    .notificacion {
        background-color: #ff4757;
        color: white;
        border-radius: 50%;
        padding: 2px 6px;
        font-size: 11px;
        margin-left: 5px;
        font-weight: bold;
        animation: pulse 1.5s infinite;
    }
    
    @keyframes pulse {
        0% { transform: scale(1); }
        50% { transform: scale(1.1); }
        100% { transform: scale(1); }
    }
</style>