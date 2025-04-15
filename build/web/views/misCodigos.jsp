<%@ page import="java.sql.*, com.upiiticket.dao.Conexion" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="com.upiiticket.model.Usuario" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Códigos de Preventa</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            padding-top: 70px;
            background-color: #f5f5f5;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }
        
        .page-title {
            color: #2c3e50;
            font-size: 28px;
            margin: 0;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background-color: #2c3e50;
            color: white;
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s;
            border: none;
            cursor: pointer;
        }
        
        .btn:hover {
            background-color: #1a252f;
            transform: translateY(-2px);
        }
        
        .btn i {
            font-size: 14px;
        }
        
        /* Nuevo estilo para botón de fila virtual */
        .btn-fila {
            background-color: #FFD700;
            color: #2c3e50;
            padding: 8px 15px;
            font-size: 14px;
            margin-top: 10px;
        }
        
        .btn-fila:hover {
            background-color: #ffea80;
        }
        
        .filters {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }
        
        .search-box {
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 300px;
            font-size: 14px;
            transition: all 0.3s;
        }
        
        .search-box:focus {
            border-color: #FFD700;
            outline: none;
            box-shadow: 0 0 0 2px rgba(255, 215, 0, 0.2);
        }
        
        .btn-filter {
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s;
            font-weight: 500;
        }
        
        .btn-filter:hover {
            background-color: #2980b9;
        }
        
        .active-filter {
            background-color: #2c3e50 !important;
        }
        
        .codes-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
            max-height: 70vh;
            overflow-y: auto;
            padding: 10px;
            margin-bottom: 20px;
        }
        
        .code-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            transition: all 0.3s ease;
            border-left: 4px solid;
            position: relative;
            min-height: 200px;
            word-break: break-word;
            display: flex;
            flex-direction: column;
        }
        
        .code-card.unused {
            border-left-color: #4CAF50;
        }
        
        .code-card.used {
            border-left-color: #f44336;
        }
        
        .code-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }
        
        .event-name {
            color: #2c3e50;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        .code-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            margin-bottom: 15px;
        }
        
        .detail-item {
            font-size: 14px;
            color: #555;
        }
        
        .detail-item i {
            margin-right: 8px;
            color: #FFD700;
        }
        
        .code-value {
            font-size: 20px;
            font-weight: 600;
            letter-spacing: 1px;
            color: #2c3e50;
            margin: 10px 0;
            padding: 10px;
            background-color: #f8f9fa;
            border-radius: 4px;
            text-align: center;
            font-family: monospace;
        }
        
        .status-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
        }
        
        .unused-badge {
            background-color: #4CAF50;
            color: white;
        }
        
        .used-badge {
            background-color: #f44336;
            color: white;
        }
        
        .no-codes {
            text-align: center;
            color: #666;
            font-size: 18px;
            grid-column: 1 / -1;
            padding: 40px 0;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 20px;
        }
        
        .page-btn {
            padding: 8px 12px;
            background-color: #2c3e50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        
        .page-btn.active {
            background-color: #FFD700;
            color: #2c3e50;
        }
        
        .page-btn:hover:not(.active) {
            background-color: #1a252f;
        }
        
        .results-info {
            text-align: center;
            margin-bottom: 15px;
            color: #666;
            font-size: 14px;
        }
        
        .card-footer {
            margin-top: auto;
            display: flex;
            justify-content: flex-end;
        }
        
        @media (max-width: 768px) {
            .codes-container {
                grid-template-columns: 1fr;
            }
            
            .search-box {
                width: 100%;
            }
            
            .filters {
                flex-direction: column;
            }
            
            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .code-details {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="navbar.jsp" />
    
    <div class="main-container">
        <div class="page-header">
            <h1 class="page-title">Mis Códigos de Preventa</h1>
        </div>

        <!-- Filtros y búsqueda -->
        <div class="filters">
            <input type="text" id="searchInput" class="search-box" placeholder="Buscar por evento o código..." onkeyup="searchCards()">
            <button class="btn-filter active-filter" onclick="filterCodes('all')">Todos</button>
            <button class="btn-filter" onclick="filterCodes('unused')">No usados</button>
            <button class="btn-filter" onclick="filterCodes('used')">Usados</button>
            <a href="principalAsistente.jsp" class="btn">
                <i class="fas fa-arrow-left"></i> Volver al inicio
            </a>
        </div>

        <!-- Información de resultados -->
        <div class="results-info" id="resultsInfo"></div>

        <!-- Contenedor de tarjetas de códigos -->
        <div class="codes-container" id="codesContainer">
            <%
                HttpSession sesion = request.getSession();
                Usuario usuario = (Usuario) sesion.getAttribute("usuario");
                String correoUsuario = usuario != null ? usuario.getCorreo() : null;

                if (correoUsuario != null) {
                    Connection con = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    
                    try {
                        con = Conexion.getConnection();
                        String sql = "SELECT e.titulo AS nombre_evento, e.fecha, e.lugar, p.codigo, p.usado, e.id_evento " +
                                     "FROM Preventa p " +
                                     "JOIN Eventos e ON p.id_evento = e.id_evento " +
                                     "WHERE p.correo = ? " +
                                     "ORDER BY e.fecha DESC";
                        ps = con.prepareStatement(sql);
                        ps.setString(1, correoUsuario);
                        rs = ps.executeQuery();

                        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");

                        if (!rs.isBeforeFirst()) {
                            // No hay resultados
            %>
            <div class="no-codes">No tienes códigos de preventa registrados</div>
            <%
                        } else {
                            while (rs.next()) {
                                String estadoClass = rs.getBoolean("usado") ? "used" : "unused";
                                String estadoTexto = rs.getBoolean("usado") ? "Usado" : "No usado";
                                String fechaFormateada = dateFormat.format(rs.getTimestamp("fecha"));
            %>
            <div class="code-card <%= estadoClass %>" data-status="<%= estadoClass %>" data-event="<%= rs.getString("nombre_evento").toLowerCase() %>" data-code="<%= rs.getString("codigo").toLowerCase() %>">
                <span class="status-badge <%= estadoClass %>-badge"><%= estadoTexto %></span>
                <h3 class="event-name"><%= rs.getString("nombre_evento") %></h3>
                
                <div class="code-details">
                    <div class="detail-item">
                        <i class="fas fa-calendar-alt"></i>
                        <span><%= fechaFormateada %></span>
                    </div>
                    <div class="detail-item">
                        <i class="fas fa-map-marker-alt"></i>
                        <span><%= rs.getString("lugar") %></span>
                    </div>
                </div>
                
                <div class="code-value"><%= rs.getString("codigo") %></div>
                
                <!-- Botón para ir a la fila virtual -->
                <div class="card-footer">
                    <a href="filaVirtual.jsp?id_evento=<%= rs.getInt("id_evento") %>" class="btn btn-fila">
                        <i class="fas fa-users"></i> Ir a Fila Virtual
                    </a>
                </div>
            </div>
            <%
                            }
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) rs.close();
                        if (ps != null) ps.close();
                        if (con != null) con.close();
                    }
                } else {
            %>
            <div class="no-codes">No hay usuario autenticado</div>
            <%
                }
            %>
        </div>

        <!-- Paginación -->
        <div class="pagination" id="pagination">
            <!-- Los botones de paginación se generarán con JavaScript -->
        </div>
    </div>

    <script>
        // Variables para paginación
        let currentPage = 1;
        const itemsPerPage = 10;
        let filteredCards = [];
        
        // Inicializar la página
        document.addEventListener('DOMContentLoaded', function() {
            updateResultsInfo();
            setupPagination();
            showPage(currentPage);
            
            // Eliminar notificación al cargar la página
            fetch('EliminarNotificacionServlet', { method: 'POST' });
        });

        // Función para filtrar por estado (todos, no usados, usados)
        function filterCodes(filter) {
            const cards = document.querySelectorAll(".code-card");
            const buttons = document.querySelectorAll(".btn-filter");
            
            buttons.forEach(btn => {
                if (btn.textContent.toLowerCase().includes(filter)) {
                    btn.classList.add("active-filter");
                } else {
                    btn.classList.remove("active-filter");
                }
            });

            filteredCards = Array.from(cards).filter(card => {
                const status = card.getAttribute("data-status");
                if (filter === "all") {
                    return true;
                } else {
                    return status === filter;
                }
            });

            // Actualizar visibilidad de todas las tarjetas
            cards.forEach(card => {
                card.style.display = "none";
            });
            
            // Mostrar solo las tarjetas filtradas
            filteredCards.forEach(card => {
                card.style.display = "block";
            });

            currentPage = 1;
            updateResultsInfo();
            setupPagination();
            showPage(currentPage);
        }

        // Función para buscar en las tarjetas
        function searchCards() {
            const input = document.getElementById("searchInput");
            const searchTerm = input.value.toLowerCase();
            const cards = document.querySelectorAll(".code-card");
            
            filteredCards = Array.from(cards).filter(card => {
                const event = card.getAttribute("data-event");
                const code = card.getAttribute("data-code");
                return event.includes(searchTerm) || code.includes(searchTerm);
            });

            // Actualizar visibilidad de todas las tarjetas
            cards.forEach(card => {
                card.style.display = "none";
            });
            
            // Mostrar solo las tarjetas filtradas
            filteredCards.forEach(card => {
                card.style.display = "block";
            });

            currentPage = 1;
            updateResultsInfo();
            setupPagination();
            showPage(currentPage);
        }

        // Función para mostrar una página específica
        function showPage(page) {
            currentPage = page;
            const startIndex = (page - 1) * itemsPerPage;
            const endIndex = startIndex + itemsPerPage;
            
            // Ocultar todas las tarjetas primero
            const allCards = document.querySelectorAll(".code-card");
            allCards.forEach(card => {
                card.style.display = "none";
            });
            
            // Mostrar solo las tarjetas de la página actual
            for (let i = startIndex; i < endIndex && i < filteredCards.length; i++) {
                if (filteredCards[i]) {
                    filteredCards[i].style.display = "block";
                }
            }
            
            // Actualizar botones de paginación
            updatePaginationButtons();
            updateResultsInfo();
        }

        // Función para configurar la paginación
        function setupPagination() {
            const paginationDiv = document.getElementById("pagination");
            paginationDiv.innerHTML = "";
            
            const pageCount = Math.ceil(filteredCards.length / itemsPerPage);
            
            if (pageCount <= 1) return;
            
            // Botón Anterior
            const prevButton = document.createElement("button");
            prevButton.innerHTML = "&laquo;";
            prevButton.className = "page-btn";
            prevButton.onclick = () => {
                if (currentPage > 1) showPage(currentPage - 1);
            };
            paginationDiv.appendChild(prevButton);
            
            // Botones de página
            for (let i = 1; i <= pageCount; i++) {
                const pageButton = document.createElement("button");
                pageButton.textContent = i;
                pageButton.className = "page-btn" + (i === currentPage ? " active" : "");
                pageButton.onclick = () => showPage(i);
                paginationDiv.appendChild(pageButton);
            }
            
            // Botón Siguiente
            const nextButton = document.createElement("button");
            nextButton.innerHTML = "&raquo;";
            nextButton.className = "page-btn";
            nextButton.onclick = () => {
                if (currentPage < pageCount) showPage(currentPage + 1);
            };
            paginationDiv.appendChild(nextButton);
        }

        // Función para actualizar los botones de paginación
        function updatePaginationButtons() {
            const pageButtons = document.querySelectorAll(".page-btn");
            pageButtons.forEach(button => {
                button.classList.remove("active");
                if (button.textContent == currentPage) {
                    button.classList.add("active");
                }
            });
        }

        // Función para actualizar la información de resultados
        function updateResultsInfo() {
            const startIndex = (currentPage - 1) * itemsPerPage + 1;
            const endIndex = Math.min(currentPage * itemsPerPage, filteredCards.length);
            const total = filteredCards.length;
            
            document.getElementById("resultsInfo").textContent = 
                `Mostrando ${startIndex}-${endIndex} de ${total} códigos`;
        }
    </script>
</body>
</html>