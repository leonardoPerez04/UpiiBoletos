/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.upiiticket.model;

import java.util.Date;

public class Evento {
    private int id_evento;
    private String titulo;
    private String descripcion;
    private Date fecha;
    private String lugar;
    private int cupo_total;
    private int id_organizador;

    public Evento() {
    }

    public Evento(int id_evento, String titulo, String descripcion, Date fecha, 
                  String lugar, int cupo_total, int id_organizador) {
        this.id_evento = id_evento;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.fecha = fecha;
        this.lugar = lugar;
        this.cupo_total = cupo_total;
        this.id_organizador = id_organizador;
    }

    // Getters y Setters
    public int getId_evento() {
        return id_evento;
    }

    public void setId_evento(int id_evento) {
        this.id_evento = id_evento;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getLugar() {
        return lugar;
    }

    public void setLugar(String lugar) {
        this.lugar = lugar;
    }

    public int getCupo_total() {
        return cupo_total;
    }

    public void setCupo_total(int cupo_total) {
        this.cupo_total = cupo_total;
    }

    public int getId_organizador() {
        return id_organizador;
    }

    public void setId_organizador(int id_organizador) {
        this.id_organizador = id_organizador;
    }
}
