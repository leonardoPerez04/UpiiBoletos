/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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

@WebServlet("/filaVirtual")
public class FilaVirtualServlet extends HttpServlet {

    private static final int DURACION_TURNO_MINUTOS = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response); // Redirige GET a POST
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idUsuario = Integer.parseInt(request.getParameter("id_usuario"));
        int idEvento = Integer.parseInt(request.getParameter("id_evento"));

        try (Connection con = Conexion.getConnection()) {
            if (!usuarioEnFila(con, idUsuario, idEvento)) {
                agregarUsuarioAFila(con, idUsuario, idEvento);
            }

            actualizarEstadosFila(con, idEvento);
            int posicion = obtenerPosicionEnFila(con, idUsuario, idEvento);
            String estadoUsuario = obtenerEstadoUsuario(con, idUsuario, idEvento);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"status\":\"success\", \"posicion\":" + posicion + ", \"estado\":\"" + estadoUsuario + "\"}");

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"status\":\"error\", \"mensaje\":\"Error en la fila virtual\"}");
        }
    }

    private boolean usuarioEnFila(Connection con, int idUsuario, int idEvento) throws Exception {
        String sql = "SELECT COUNT(*) FROM ListaEspera WHERE id_usuario = ? AND id_evento = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            ps.setInt(2, idEvento);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
    }

    private void agregarUsuarioAFila(Connection con, int idUsuario, int idEvento) throws Exception {
        String sql = "INSERT INTO ListaEspera (id_evento, id_usuario, fecha_ingreso, estado) VALUES (?, ?, CURRENT_TIMESTAMP, 'EN_COLA')";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idEvento);
            ps.setInt(2, idUsuario);
            ps.executeUpdate();
        }
    }

    private void actualizarEstadosFila(Connection con, int idEvento) throws Exception {
        String expirarSQL = "UPDATE ListaEspera SET estado = 'EXPIRADO' WHERE estado = 'ACTIVO' AND TIMESTAMPDIFF(MINUTE, fecha_ingreso, CURRENT_TIMESTAMP) > ?";
        try (PreparedStatement ps = con.prepareStatement(expirarSQL)) {
            ps.setInt(1, DURACION_TURNO_MINUTOS);
            ps.executeUpdate();
        }

        String verificarSQL = "SELECT COUNT(*) FROM ListaEspera WHERE id_evento = ? AND estado = 'ACTIVO'";
        try (PreparedStatement ps = con.prepareStatement(verificarSQL)) {
            ps.setInt(1, idEvento);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getInt(1) == 0) {
                String activarSQL = "UPDATE ListaEspera SET estado = 'ACTIVO' WHERE id_evento = ? AND estado = 'EN_COLA' ORDER BY fecha_ingreso ASC LIMIT 1";
                try (PreparedStatement ps2 = con.prepareStatement(activarSQL)) {
                    ps2.setInt(1, idEvento);
                    ps2.executeUpdate();
                }
            }
        }
    }

    private int obtenerPosicionEnFila(Connection con, int idUsuario, int idEvento) throws Exception {
        String sql = "SELECT COUNT(*) FROM ListaEspera WHERE id_evento = ? AND estado = 'EN_COLA' AND fecha_ingreso < (SELECT fecha_ingreso FROM ListaEspera WHERE id_usuario = ? AND id_evento = ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idEvento);
            ps.setInt(2, idUsuario);
            ps.setInt(3, idEvento);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) + 1;
            }
        }
        return -1;
    }

    private String obtenerEstadoUsuario(Connection con, int idUsuario, int idEvento) throws Exception {
        String sql = "SELECT estado FROM ListaEspera WHERE id_usuario = ? AND id_evento = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            ps.setInt(2, idEvento);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("estado");
            }
        }
        return "NO_ENCONTRADO";
    }
}
