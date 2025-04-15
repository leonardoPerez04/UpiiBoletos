/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.upiiticket.dao;

import com.upiiticket.model.Evento;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.sql.Timestamp;

public class EventoDAO {
    private Connection con;

    public EventoDAO(Connection con) {
        this.con = con;
    }

    // 🔹 1. Obtener todos los eventos
    public List<Evento> obtenerTodosLosEventos() {
        List<Evento> lista = new ArrayList<>();
        String sql = "SELECT * FROM Eventos";

        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Evento e = new Evento();
                e.setId_evento(rs.getInt("id_evento"));
                e.setTitulo(rs.getString("titulo"));
                e.setDescripcion(rs.getString("descripcion"));
                e.setFecha(rs.getTimestamp("fecha"));
                e.setLugar(rs.getString("lugar"));
                e.setCupo_total(rs.getInt("cupo_total"));
                e.setId_organizador(rs.getInt("id_organizador"));
                lista.add(e);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return lista;
    }

    // 🔹 2. Obtener eventos de un organizador específico
    public List<Evento> obtenerEventosPorOrganizador(int idUsuario) {
        List<Evento> lista = new ArrayList<>();
        String sql = "SELECT * FROM Eventos WHERE id_organizador = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Evento e = new Evento();
                    e.setId_evento(rs.getInt("id_evento"));
                    e.setTitulo(rs.getString("titulo"));
                    e.setDescripcion(rs.getString("descripcion"));
                    e.setFecha(rs.getTimestamp("fecha"));
                    e.setLugar(rs.getString("lugar"));
                    e.setCupo_total(rs.getInt("cupo_total"));
                    e.setId_organizador(rs.getInt("id_organizador"));
                    lista.add(e);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return lista;
    }

    // 🔹 3. Crear un nuevo evento
    public boolean crearEvento(Evento e) {
        String sql = "INSERT INTO Eventos (titulo, descripcion, fecha, lugar, cupo_total, id_organizador) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, e.getTitulo());
            ps.setString(2, e.getDescripcion());
            ps.setTimestamp(3, new java.sql.Timestamp(e.getFecha().getTime()));
            ps.setString(4, e.getLugar());
            ps.setInt(5, e.getCupo_total());
            ps.setInt(6, e.getId_organizador());

            return ps.executeUpdate() > 0;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }
    public Evento obtenerEventoPorId(int idEvento) {
    Evento evento = null;
    String sql = "SELECT * FROM eventos WHERE id_evento = ?";
    
    try (PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, idEvento);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            evento = new Evento();
            evento.setId_evento(rs.getInt("id_evento"));
            evento.setTitulo(rs.getString("titulo"));
            evento.setDescripcion(rs.getString("descripcion"));
            evento.setFecha(rs.getDate("fecha"));
            evento.setLugar(rs.getString("lugar"));
            evento.setId_organizador(rs.getInt("id_organizador"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return evento;
}
    
 public boolean actualizarEvento(int idEvento, String titulo, String descripcion, String fecha, String lugar, int idOrganizador) {
    String sql = "UPDATE eventos SET titulo = ?, descripcion = ?, fecha = ?, lugar = ? WHERE id_evento = ? AND id_organizador = ?";
    
    try (PreparedStatement stmt = con.prepareStatement(sql)) {
        stmt.setString(1, titulo);
        stmt.setString(2, descripcion);
        
        // Convertir la fecha a Timestamp
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
        LocalDateTime fechaLDT = LocalDateTime.parse(fecha, formatter);
        Timestamp fechaSQL = Timestamp.valueOf(fechaLDT);

        stmt.setTimestamp(3, fechaSQL);
        stmt.setString(4, lugar);
        stmt.setInt(5, idEvento);
        stmt.setInt(6, idOrganizador);

        int filasActualizadas = stmt.executeUpdate();
        return filasActualizadas > 0;
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
    }
public boolean eliminarEvento(int idEvento, int idOrganizador) {
    String verificarSQL = "SELECT id_evento FROM eventos WHERE id_evento = ? AND id_organizador = ?";
    String eliminarSQL = "DELETE FROM eventos WHERE id_evento = ? AND id_organizador = ?";

    try (PreparedStatement stmtVerificar = con.prepareStatement(verificarSQL)) {
        stmtVerificar.setInt(1, idEvento);
        stmtVerificar.setInt(2, idOrganizador);
        ResultSet rs = stmtVerificar.executeQuery();
        
        if (!rs.next()) {
            return false; // El evento no existe o no pertenece al organizador
        }
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }

    try (PreparedStatement stmtEliminar = con.prepareStatement(eliminarSQL)) {
        stmtEliminar.setInt(1, idEvento);
        stmtEliminar.setInt(2, idOrganizador);

        int filasEliminadas = stmtEliminar.executeUpdate();
        return filasEliminadas > 0;
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}

}

