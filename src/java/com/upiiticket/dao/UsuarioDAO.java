/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.upiiticket.dao;

import com.upiiticket.model.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.sql.SQLException;

public class UsuarioDAO {
    private Connection con;

    public UsuarioDAO(Connection con) {
        this.con = con;
    }

    public List<Usuario> obtenerUsuarios() {
        List<Usuario> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM Usuarios";

        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                usuarios.add(new Usuario(
                    rs.getInt("id_usuario"),
                    rs.getString("nombre"),
                    rs.getString("correo"),
                    rs.getString("contrasena"),
                    rs.getString("rol")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return usuarios;
    }

public void insertarUsuario(Usuario usuario) {
    String sql = "INSERT INTO Usuarios (nombre, correo, contrasena, rol) VALUES (?, ?, ?, ?)";

    try (PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, usuario.getNombre());
        ps.setString(2, usuario.getCorreo());
        String password = usuario.getContrasena() == null ? "" : usuario.getContrasena();
        ps.setString(3, password);
        ps.setString(4, usuario.getRol());

        System.out.println("🔍 Ejecutando SQL: " + ps.toString());
        System.out.println("🔍 Contraseña enviada: " + password);
        ps.executeUpdate();
        System.out.println("✅ Usuario agregado a la base de datos.");
    } catch (Exception e) {
        System.out.println("❌ Error al insertar usuario:");
        e.printStackTrace();
    }
}

public Usuario validarUsuario(String correo, String contrasena) {
    String sql = "SELECT * FROM Usuarios WHERE correo = ? AND contrasena = ?";
    try (PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, correo);
        ps.setString(2, contrasena);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return new Usuario(
                    rs.getInt("id_usuario"),
                    rs.getString("nombre"),
                    rs.getString("correo"),
                    rs.getString("contrasena"),
                    rs.getString("rol")
                );
            }
        }
    } catch (Exception e) {
        System.out.println("❌ Error al validar usuario:");
        e.printStackTrace();
    }
    return null; // Retorna null si no se encuentra el usuario
}
public Usuario actualizarUsuario(int id, String nombre, String correo, String contrasena) {
    String sql = "UPDATE Usuarios SET nombre = ?, correo = ?, contrasena = ? WHERE id_usuario = ?";
    try (PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setString(1, nombre);
        ps.setString(2, correo);
        ps.setString(3, contrasena.isEmpty() ? obtenerContrasenaActual(id) : contrasena);
        ps.setInt(4, id);

        int filasActualizadas = ps.executeUpdate();
        if (filasActualizadas > 0) {
            return new Usuario(id, nombre, correo, contrasena, obtenerRol(id));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}

private String obtenerContrasenaActual(int id) throws SQLException {
    String sql = "SELECT contrasena FROM Usuarios WHERE id_usuario = ?";
    try (PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, id);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getString("contrasena");
            }
        }
    }
    return "";
}

private String obtenerRol(int id) throws SQLException {
    String sql = "SELECT rol FROM Usuarios WHERE id_usuario = ?";
    try (PreparedStatement ps = con.prepareStatement(sql)) {
        ps.setInt(1, id);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getString("rol");
            }
        }
    }
    return "Asistente";
}
    public static String[] obtenerCredencialesOrganizador(int idOrganizador) {
        String sql = "SELECT correo, contraseña FROM Usuarios WHERE id_usuario = ? AND rol = 'ORGANIZADOR'";
        try (Connection con = Conexion.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idOrganizador);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new String[]{rs.getString("correo"), rs.getString("contraseña")};
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // Si no encuentra el usuario
    }
}
