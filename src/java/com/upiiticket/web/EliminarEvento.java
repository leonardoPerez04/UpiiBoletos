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

@WebServlet("/EliminarEvento")
public class EliminarEvento extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        if (usuario == null || !"ORGANIZADOR".equalsIgnoreCase(usuario.getRol())) {
            response.sendRedirect("login.html?error=4");
            return;
        }

        int idEvento;
        try {
            idEvento = Integer.parseInt(request.getParameter("id_evento"));
        } catch (NumberFormatException e) {
            response.sendRedirect("views/gestionarEventos.jsp?error=FormatoInválido");
            return;
        }

        try (Connection con = Conexion.getConnection()) {
            EventoDAO eventoDAO = new EventoDAO(con);
            boolean eliminado = eventoDAO.eliminarEvento(idEvento, usuario.getId());

            if (eliminado) {
                response.sendRedirect("views/gestionarEventos.jsp?success=EventoEliminado");
            } else {
                response.sendRedirect("views/gestionarEventos.jsp?error=NoSePudoEliminar");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("views/gestionarEventos.jsp?error=ErrorServidor");
        }
    }
}

