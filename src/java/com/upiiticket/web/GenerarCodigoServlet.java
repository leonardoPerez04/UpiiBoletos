package com.upiiticket.web;

import com.upiiticket.dao.Conexion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;

@WebServlet("/GenerarCodigoServlet")
public class GenerarCodigoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String correoUsuario = request.getParameter("correo");
        String idEventoStr = request.getParameter("id_evento");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 🔹 Validaciones iniciales
        if (correoUsuario == null || correoUsuario.trim().isEmpty() || idEventoStr == null || idEventoStr.isEmpty()) {
            response.getWriter().write("{\"status\":\"error\", \"mensaje\":\"Correo o evento no válidos\"}");
            return;
        }

        int idEvento;
        try {
            idEvento = Integer.parseInt(idEventoStr);
        } catch (NumberFormatException e) {
            response.getWriter().write("{\"status\":\"error\", \"mensaje\":\"ID de evento no válido\"}");
            return;
        }

        // 🔹 Verificar si ya existe un código para este usuario y evento
        String codigoExistente = obtenerCodigoExistente(idEvento, correoUsuario);
        if (codigoExistente != null) {
            response.getWriter().write("{\"status\":\"info\", \"mensaje\":\"Ya tienes un código generado\", \"codigo\":\"" + codigoExistente + "\"}");
            return;
        }

        // 🔹 Generar nuevo código
        String codigo = generarCodigo();

        // 🔹 Guardar código en la BD
        if (guardarCodigoPreventa(idEvento, correoUsuario, codigo)) {
            request.getSession().setAttribute("nuevaNotificacion", true);
            response.getWriter().write("{\"status\":\"success\", \"mensaje\":\"Código generado con éxito\", \"codigo\":\"" + codigo + "\"}");
        } else {
            response.getWriter().write("{\"status\":\"error\", \"mensaje\":\"Error al generar el código\"}");
        }
    }

    private String generarCodigo() {
        String caracteres = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuilder codigo = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < 6; i++) {
            codigo.append(caracteres.charAt(random.nextInt(caracteres.length())));
        }
        return codigo.toString();
    }

    // 🔹 Verifica si el usuario ya tiene un código para este evento
    private String obtenerCodigoExistente(int idEvento, String correo) {
        String sql = "SELECT codigo FROM Preventa WHERE id_evento = ? AND correo = ?";
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idEvento);
            ps.setString(2, correo);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("codigo");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 🔹 Guardar el código en la tabla Preventa
    private boolean guardarCodigoPreventa(int idEvento, String correo, String codigo) {
        String sql = "INSERT INTO Preventa (id_evento, correo, codigo, usado) VALUES (?, ?, ?, FALSE)";
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idEvento);
            ps.setString(2, correo);
            ps.setString(3, codigo);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}

