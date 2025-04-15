/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.upiiticket.web;

import com.upiiticket.dao.Conexion;
import com.upiiticket.dao.EventoDAO;
import com.upiiticket.model.Evento;
import com.upiiticket.model.Usuario;
//import jakarta.resource.cci.Connection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.sql.Connection;

/**
 *
 * @author lpere
 */
@WebServlet("/CrearEventoServlet")
public class CrearEventoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Obtener la sesión y verificar que el usuario es un ORGANIZADOR
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        if (usuario == null || !"ORGANIZADOR".equalsIgnoreCase(usuario.getRol())) {
            response.sendRedirect("login.html?error=4"); 
            return;
        }

        // Obtener los parámetros del formulario
        String titulo = request.getParameter("titulo");
        String descripcion = request.getParameter("descripcion");
        String fechaStr = request.getParameter("fecha");
        String lugar = request.getParameter("lugar");
        String cupoStr = request.getParameter("cupo");

        // Validaciones básicas
        if (titulo == null || descripcion == null || fechaStr == null || lugar == null || cupoStr == null) {
            response.sendRedirect("views/crearEvento.jsp?error=DatosInvalidos");
            return;
        }

        // Convertir datos
        int cupo;
        Date fecha;
        try {
            cupo = Integer.parseInt(cupoStr);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            fecha = sdf.parse(fechaStr);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("views/crearEvento.jsp?error=FormatoIncorrecto");
            return;
        }

        // Crear objeto Evento
        Evento nuevoEvento = new Evento();
        nuevoEvento.setTitulo(titulo);
        nuevoEvento.setDescripcion(descripcion);
        nuevoEvento.setFecha(fecha);
        nuevoEvento.setLugar(lugar);
        nuevoEvento.setCupo_total(cupo);
        nuevoEvento.setId_organizador(usuario.getId());

        // Insertar en la BD
        try (Connection con = Conexion.getConnection()) {
            EventoDAO eventoDAO = new EventoDAO(con);
            boolean creado = eventoDAO.crearEvento(nuevoEvento);

            if (creado) {
                response.sendRedirect("views/gestionarEventos.jsp?success=EventoCreado");
            } else {
                response.sendRedirect("views/crearEvento.jsp?error=NoSePudoCrear");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("views/crearEvento.jsp?error=ErrorServidor");
        }
    }
}
