/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.upiiticket.web;

import com.upiiticket.dao.Conexion;
import com.upiiticket.dao.EventoDAO;
import com.upiiticket.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;

@WebServlet("/ActualizarEvento")
public class ActualizarEvento extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        
        if (usuario == null || !"ORGANIZADOR".equalsIgnoreCase(usuario.getRol())) {
            response.sendRedirect("login.html?error=4");
            return;
        }

        int idEvento = Integer.parseInt(request.getParameter("id_evento"));
        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        String fecha = request.getParameter("fecha");
        String lugar = request.getParameter("lugar");

        try (Connection con = Conexion.getConnection()) {
            EventoDAO eventoDAO = new EventoDAO(con);
            boolean actualizado = eventoDAO.actualizarEvento(idEvento, titulo, descripcion, fecha, lugar, usuario.getId());

            if (actualizado) {
                response.sendRedirect("views/gestionarEventos.jsp?success=1");
            } else {
                response.sendRedirect("views/editarEvento.jsp?id=" + idEvento + "&error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("views/editarEvento.jsp?id=" + idEvento + "&error=2");
        }
    }
}

