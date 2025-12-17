package fintrix.dao;

import fintrix.model.Preferencias;
import java.sql.*;

public class PreferenciasDAO {

    public void ensureSchema() {
        String sql = "CREATE TABLE IF NOT EXISTS preferencias_usuario (" +
                "usuario_id INT PRIMARY KEY, " +
                "moneda VARCHAR(8) NOT NULL, " +
                "tema VARCHAR(16) NOT NULL, " +
                "notificaciones TINYINT(1) NOT NULL, " +
                "face_id TINYINT(1) NOT NULL)";
        try (Connection conn = Conexion.getConnection(); Statement stmt = conn.createStatement()) {
            stmt.execute(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Preferencias obtenerPorUsuarioId(int usuarioId) {
        ensureSchema();
        String sql = "SELECT usuario_id, moneda, tema, notificaciones, face_id FROM preferencias_usuario WHERE usuario_id = ?";
        try (Connection conn = Conexion.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, usuarioId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Preferencias p = new Preferencias();
                    p.setUsuario_id(rs.getInt("usuario_id"));
                    p.setMoneda(rs.getString("moneda"));
                    p.setTema(rs.getString("tema"));
                    p.setNotificaciones(rs.getInt("notificaciones") == 1);
                    p.setFaceId(rs.getInt("face_id") == 1);
                    return p;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Preferencias def = new Preferencias();
        def.setUsuario_id(usuarioId);
        def.setMoneda("COP");
        def.setTema("dark");
        def.setNotificaciones(true);
        def.setFaceId(false);
        guardar(def);
        return def;
    }

    public boolean guardar(Preferencias pref) {
        ensureSchema();
        String sql = "INSERT INTO preferencias_usuario (usuario_id, moneda, tema, notificaciones, face_id) " +
                "VALUES (?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE moneda=VALUES(moneda), tema=VALUES(tema), notificaciones=VALUES(notificaciones), face_id=VALUES(face_id)";
        try (Connection conn = Conexion.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pref.getUsuario_id());
            ps.setString(2, pref.getMoneda());
            ps.setString(3, pref.getTema());
            ps.setInt(4, pref.getNotificaciones() ? 1 : 0);
            ps.setInt(5, pref.getFaceId() ? 1 : 0);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public java.util.Locale getLocaleForMoneda(String moneda) {
        if ("COP".equalsIgnoreCase(moneda)) return new java.util.Locale("es","CO");
        return new java.util.Locale("en","US");
    }
}
