package fintrix.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Transaccion {

    private int id;
    private int usuario_id;
    private int cuenta_id;
    private int categoria_id;
    private Date fecha;
    private String tipo;
    private String descripcion;
    private double monto;
    private Timestamp creado_en;

    // Constructor vacio
    public Transaccion() {
    }

    // Constructor completo
    public Transaccion(int id,int usuario_id, int cuenta_id, int categoria_id, Date fecha, String tipo, String descripcion, double monto, Timestamp creado_en) {
        this.id = id;
        this.usuario_id = usuario_id;
        this.cuenta_id = cuenta_id;
        this.categoria_id = categoria_id;
        this.fecha = fecha;
        this.tipo = tipo;
        this.descripcion = descripcion;
        this.monto = monto;
        this.creado_en = creado_en;
    }

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCuenta_id() {
        return cuenta_id;
    }

    public void setCuenta_id(int cuenta_id) {
        this.cuenta_id = cuenta_id;
    }

    public int getCategoria_id() {
        return categoria_id;
    }

    public void setCategoria_id(int categoria_id) {
        this.categoria_id = categoria_id;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public double getMonto() {
        return monto;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }

    public Timestamp getCreado_en() {
        return creado_en;
    }

    public void setCreado_en(Timestamp creado_en) {
        this.creado_en = creado_en;
    }

    public void setUsuario_id(int usuario_id) {
        this.usuario_id = usuario_id;
    }

    public int getUsuario_id() {
        return usuario_id;
    }

}
