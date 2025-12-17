package fintrix.dao;

import fintrix.model.Transaccion;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TransaccionDAO {

    public List<Transaccion> listarTransacciones() {
        List<Transaccion> lista = new ArrayList<>();
        String sql = "SELECT id, usuario_id, cuenta_id, categoria_id, fecha, tipo, descripcion, monto, created_at FROM transacciones ORDER BY id";

        try (Connection conn = Conexion.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Transaccion transaccion = new Transaccion();
                transaccion.setId(rs.getInt("id"));
                transaccion.setUsuario_id(rs.getInt("usuario_id"));
                transaccion.setCuenta_id(rs.getInt("cuenta_id"));
                transaccion.setCategoria_id(rs.getInt("categoria_id"));
                transaccion.setFecha(rs.getDate("fecha"));
                transaccion.setTipo(rs.getString("tipo"));
                transaccion.setDescripcion(rs.getString("descripcion"));
                transaccion.setMonto(rs.getDouble("monto"));
                transaccion.setCreado_en(rs.getTimestamp("created_at"));
                lista.add(transaccion);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }
    
    public List<Transaccion> listarTransaccionesPorUsuario(int usuarioId) throws Exception {
    List<Transaccion> lista = new ArrayList<>();
    String sql = "SELECT * FROM transacciones WHERE usuario_id = ?";

    try (Connection con = Conexion.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, usuarioId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Transaccion t = new Transaccion();
            t.setId(rs.getInt("id"));
            t.setUsuario_id(rs.getInt("usuario_id"));
            t.setCuenta_id(rs.getInt("cuenta_id"));
            t.setCategoria_id(rs.getInt("categoria_id"));
            t.setTipo(rs.getString("tipo"));
            t.setMonto(rs.getDouble("monto"));
            t.setDescripcion(rs.getString("descripcion"));
            t.setFecha(rs.getDate("fecha"));
            lista.add(t);
        }
    }
    return lista;
}


    public Transaccion obtenerTransaccionPorId(int id) {
        String sql = "SELECT * FROM transacciones WHERE id = ?";
        Transaccion transaccion = null;

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                transaccion = new Transaccion();
                transaccion.setId(rs.getInt("id"));
                transaccion.setUsuario_id(rs.getInt("usuario_id"));
                transaccion.setCuenta_id(rs.getInt("cuenta_id"));
                transaccion.setCategoria_id(rs.getInt("categoria_id"));
                transaccion.setFecha(rs.getDate("fecha"));
                transaccion.setTipo(rs.getString("tipo"));
                transaccion.setDescripcion(rs.getString("descripcion"));
                transaccion.setMonto(rs.getDouble("monto"));
                transaccion.setCreado_en(rs.getTimestamp("created_at"));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return transaccion;
    }

    public boolean crearTransaccion(Transaccion transaccion) {
        String sql = "INSERT INTO transacciones (usuario_id, cuenta_id, categoria_id, fecha, tipo, descripcion, monto) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = Conexion.getConnection()) {

            conn.setAutoCommit(false); // 🔥 Importante: iniciar transacción

            // 1. Guardar transacción
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, transaccion.getUsuario_id());
                pstmt.setInt(2, transaccion.getCuenta_id());
                pstmt.setInt(3, transaccion.getCategoria_id());
                pstmt.setDate(4, transaccion.getFecha());
                pstmt.setString(5, transaccion.getTipo());
                pstmt.setString(6, transaccion.getDescripcion());
                pstmt.setDouble(7, transaccion.getMonto());
                pstmt.executeUpdate();
            }

            // 2. Actualizar saldo de la cuenta
            String sqlUpdate = "UPDATE cuentas SET saldo_actual = saldo_actual + ? WHERE id = ?";
            try (PreparedStatement pstmt2 = conn.prepareStatement(sqlUpdate)) {
                pstmt2.setDouble(1, transaccion.getMonto());
                pstmt2.setInt(2, transaccion.getCuenta_id());
                pstmt2.executeUpdate();
            }

            conn.commit(); // Confirmar cambios
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean actualizarTransaccion(Transaccion transaccion) {
        String sql = "UPDATE transacciones SET cuenta_id = ?, categoria_id = ?, fecha = ?, tipo = ?, descripcion = ?, monto = ? "
                + "WHERE id = ?";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, transaccion.getCuenta_id());
            pstmt.setInt(2, transaccion.getCategoria_id());
            pstmt.setDate(3, transaccion.getFecha());          // java.sql.Date
            pstmt.setString(4, transaccion.getTipo());
            pstmt.setString(5, transaccion.getDescripcion());
            pstmt.setDouble(6, transaccion.getMonto());
            pstmt.setInt(7, transaccion.getId());
            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminarTransaccion(int id) {
        String sql = "DELETE FROM transacciones WHERE id = ?";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

    }

    public List<Transaccion> buscar(String criterio) {
        List<Transaccion> lista = new ArrayList<>();
        String sql = "SELECT * FROM transacciones "
                + "WHERE cuenta_id LIKE ? OR tipo LIKE ? OR descripcion LIKE ? OR monto LIKE ? "
                + "ORDER BY id ";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            String parametro = "%" + criterio + "%";
            pstmt.setString(1, parametro);
            pstmt.setString(2, parametro);
            pstmt.setString(3, parametro);
            pstmt.setString(4, parametro);

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Transaccion transaccion = new Transaccion();
                transaccion.setId(rs.getInt("id"));
                transaccion.setFecha(rs.getDate("fecha"));         // java.sql.Date
                transaccion.setTipo(rs.getString("tipo"));
                transaccion.setDescripcion(rs.getString("descripcion"));
                transaccion.setMonto(rs.getDouble("monto"));
                lista.add(transaccion);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

}
