package fintrix.model;

import java.sql.Timestamp;

public class Cuenta {
    private int id;
    private int usuario_id;
    private String nombre;
    private String tipo;
    private double saldo_inicial;
    private Timestamp creado_en;

    public Cuenta() {
    }

    public Cuenta(int id, int usuario_id, String nombre, String tipo, double saldo_inicial, Timestamp creado_en) {
        this.id = id;
        this.usuario_id = usuario_id;
        this.nombre = nombre;
        this.tipo = tipo;
        this.saldo_inicial = saldo_inicial;
        this.creado_en = creado_en;
    }

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

    public double getSaldo_inicial() {
        return saldo_inicial;
    }

    public void setSaldo_inicial(double saldo_inicial) {
        this.saldo_inicial = saldo_inicial;
    }

    public Timestamp getCreado_en() {
        return creado_en;
    }

    public void setCreado_en(Timestamp creado_en) {
        this.creado_en = creado_en;
    }
    
    
    
}