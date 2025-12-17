package fintrix.model;

public class Preferencias {
    private int usuario_id;
    private String moneda; // e.g., "COP", "USD"
    private String tema;   // "dark" or "light"
    private boolean notificaciones;
    private boolean faceId;

    public int getUsuario_id() { return usuario_id; }
    public void setUsuario_id(int usuario_id) { this.usuario_id = usuario_id; }

    public String getMoneda() { return moneda; }
    public void setMoneda(String moneda) { this.moneda = moneda; }

    public String getTema() { return tema; }
    public void setTema(String tema) { this.tema = tema; }

    public boolean getNotificaciones() { return notificaciones; }
    public void setNotificaciones(boolean notificaciones) { this.notificaciones = notificaciones; }

    public boolean getFaceId() { return faceId; }
    public void setFaceId(boolean faceId) { this.faceId = faceId; }
}
