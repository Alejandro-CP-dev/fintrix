package fintrix.model;

import java.sql.Timestamp;

public class Categoria{
    private int id;
    private int usuario_id;
    private String nombre;
    private String tipo;
    private Timestamp creado_en;

    // Constructor vacío
    public Categoria() {

    }
    // Constructor completo
    public Categoria(int id, int usuario_id, String nombre, String tipo, Timestamp creado_en) {
        this.id = id;
        this.usuario_id = usuario_id;
        this.nombre = nombre;
        this.tipo = tipo;
        this.creado_en = creado_en;
    }
    // Getters y Setters
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public int getUsuario_id() {
        return usuario_id;
    }
    public void setUsuario_id(int usuario_id) {
        this.usuario_id = usuario_id;
    }
    public String getNombre() {
        return nombre;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public String getTipo() {
        return tipo;
    }
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    public Timestamp getCreado_en() {
        return creado_en;
    }
    public void setCreado_en(Timestamp creado_en) {
        this.creado_en = creado_en;
    }
    

}