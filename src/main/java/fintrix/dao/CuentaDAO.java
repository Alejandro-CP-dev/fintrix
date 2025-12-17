package fintrix.dao;

import fintrix.model.Cuenta;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CuentaDAO {

    public List<Cuenta> listarCuentasPorUsuario(int usuarioId) {
        List<Cuenta> lista = new ArrayList<>();
        String sql = "SELECT * FROM cuentas WHERE usuario_id = ? ORDER BY nombre_cuenta";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, usuarioId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Cuenta cuenta = new Cuenta();
                cuenta.setId(rs.getInt("id"));
                cuenta.setUsuario_id(rs.getInt("usuario_id"));
                cuenta.setNombre(rs.getString("nombre_cuenta"));
                cuenta.setTipo(rs.getString("tipo"));
                cuenta.setSaldo_inicial(rs.getDouble("saldo_inicial"));
                lista.add(cuenta);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    public Cuenta obtenerCuentaPorId(int id) {
        String sql = "SELECT * FROM cuentas WHERE id = ?";
        Cuenta cuenta = null;

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                cuenta = new Cuenta();
                cuenta.setId(rs.getInt("id"));
                cuenta.setUsuario_id(rs.getInt("usuario_id"));
                cuenta.setNombre(rs.getString("nombre_cuenta"));
                cuenta.setTipo(rs.getString("tipo"));
                cuenta.setSaldo_inicial(rs.getDouble("saldo_inicial"));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cuenta;
    }

    public boolean crearCuenta(Cuenta cuenta) {
        String sql = "INSERT INTO cuentas (usuario_id, nombre_cuenta, tipo, saldo_inicial, saldo_actual) VALUES (?, ?, ?, ?, ?)";

        
        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, cuenta.getUsuario_id());
            pstmt.setString(2, cuenta.getNombre());
            pstmt.setString(3, cuenta.getTipo());
            pstmt.setDouble(4, cuenta.getSaldo_inicial());
            pstmt.setDouble(5, cuenta.getSaldo_inicial());
            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean actualizarCuenta(Cuenta cuenta) {
        String sql = "UPDATE cuentas SET nombre_cuenta = ?, tipo = ?, saldo_inicial = ? WHERE id = ?";
        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, cuenta.getNombre());
            pstmt.setString(2, cuenta.getTipo());
            pstmt.setDouble(3, cuenta.getSaldo_inicial());
            pstmt.setInt(4, cuenta.getId());

            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean actualizarCuentaPorUsuario(Cuenta cuenta) {
        String sql = "UPDATE cuentas SET nombre_cuenta = ?, tipo = ?, saldo_inicial = ? WHERE id =  ? AND  usuario_id =  ?";
        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, cuenta.getNombre());
            pstmt.setString(2, cuenta.getTipo());
            pstmt.setDouble(3, cuenta.getSaldo_inicial());
            pstmt.setInt(4, cuenta.getId());
            pstmt.setInt(5, cuenta.getUsuario_id());

            return pstmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean actualizarSaldo(int cuentaId, double monto) {
        String sql = "UPDATE cuentas SET saldo_actual = saldo_actual + ? WHERE id = ?";
        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setDouble(1, monto);
            pstmt.setInt(2, cuentaId);

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminar(int id) {
        String sql = "DELETE FROM cuentas WHERE id = ?";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Cuenta> buscar(String criterio) {
        List<Cuenta> lista = new ArrayList<>();
        String sql = "SELECT * FROM cuentas "
                + "WHERE usuario_id LIKE ? OR nombre_cuenta LIKE ? OR tipo LIKE ? "
                + "ORDER BY nombre_cuenta";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            String parametro = "%" + criterio + "%";
            pstmt.setString(1, parametro);
            pstmt.setString(2, parametro);
            pstmt.setString(3, parametro);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Cuenta cuenta = new Cuenta();
                cuenta.setId(rs.getInt("id"));
                cuenta.setUsuario_id(rs.getInt("usuario_id"));
                cuenta.setNombre(rs.getString("nombre_cuenta"));
                cuenta.setTipo(rs.getString("tipo"));
                cuenta.setSaldo_inicial(rs.getDouble("saldo_inicial"));
                lista.add(cuenta);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    public boolean existeNombreParaUsuario(int usuarioId, String nombre, Integer excluirId) {
        String sql = "SELECT COUNT(*) FROM cuentas WHERE usuario_id = ? AND nombre_cuenta = ?" + (excluirId != null ? " AND id <> ?" : "");
        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, usuarioId);
            pstmt.setString(2, nombre);
            if (excluirId != null) {
                pstmt.setInt(3, excluirId);
            }
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
