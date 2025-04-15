<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fila Virtual | UpiiTicket</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #FFD700;
            --text-color: #333;
            --light-gray: #f5f5f5;
            --white: #ffffff;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-image: linear-gradient(135deg, rgba(44, 62, 80, 0.8) 0%, rgba(0, 0, 0, 0.8) 100%), 
                              url('https://images.unsplash.com/photo-1531058020387-3be344556be6?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: var(--white);
        }
        
        .fila-container {
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            padding: 40px;
            width: 100%;
            max-width: 500px;
            text-align: center;
            color: var(--primary-color);
        }
        
        .logo {
            font-size: 24px;
            font-weight: bold;
            color: var(--secondary-color);
            margin-bottom: 20px;
        }
        
        .status-card {
            background-color: var(--light-gray);
            border-radius: 8px;
            padding: 20px;
            margin: 20px 0;
        }
        
        .status-info {
            font-size: 18px;
            margin-bottom: 10px;
        }
        
        .status-value {
            font-size: 24px;
            font-weight: bold;
        }
        
        .btn-comprar {
            background-color: var(--secondary-color);
            color: var(--primary-color);
            padding: 15px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            margin-top: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="fila-container">
        <div class="logo">
            <i class="fas fa-ticket-alt"></i> UpiiTicket
        </div>
        <h1>Fila Virtual</h1>
        
        <div class="status-card">
            <div class="status-info">Tu posición actual:</div>
            <div class="status-value" id="posicion">${posicion}</div>
        </div>
        
        <div class="status-card">
            <div class="status-info">Estado:</div>
            <div class="status-value" id="estado">${estado}</div>
        </div>
        
        <a id="btnComprar" href="compraBoletos.jsp?id_evento=${idEvento}" class="btn-comprar" 
           style="${estado eq 'ACTIVO' ? '' : 'display: none;'}">
            <i class="fas fa-shopping-cart"></i> Ir a Comprar
        </a>
        
        <div style="margin-top: 20px; color: #666;">
            <i class="fas fa-sync-alt"></i> Actualizando automáticamente...
        </div>
    </div>

    <script>
        // Función para actualizar la información periódicamente
        function actualizarFila() {
            fetch(window.location.href, {
                headers: {
                    'X-Requested-With': 'XMLHttpRequest'
                }
            })
            .then(response => response.text())
            .then(html => {
                const parser = new DOMParser();
                const doc = parser.parseFromString(html, 'text/html');
                
                // Actualizar posición y estado
                document.getElementById('posicion').textContent = 
                    doc.getElementById('posicion').textContent;
                document.getElementById('estado').textContent = 
                    doc.getElementById('estado').textContent;
                
                // Mostrar/ocultar botón de compra
                const btnComprar = document.getElementById('btnComprar');
                if(doc.getElementById('estado').textContent === 'ACTIVO') {
                    btnComprar.style.display = 'flex';
                    // Animación para llamar la atención
                    btnComprar.animate([
                        { transform: 'scale(1)' },
                        { transform: 'scale(1.05)' },
                        { transform: 'scale(1)' }
                    ], { duration: 300, iterations: 3 });
                } else {
                    btnComprar.style.display = 'none';
                }
            })
            .catch(error => console.error('Error:', error));
        }
        
        // Actualizar cada 5 segundos
        setInterval(actualizarFila, 5000);
    </script>
</body>
</html>