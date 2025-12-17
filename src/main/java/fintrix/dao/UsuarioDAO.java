package fintrix.dao;

import fintrix.model.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {

    public List<Usuario> listarUsuarios() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT id, nombre, email, created_at FROM usuarios ORDER BY nombre";

        try (Connection conn = Conexion.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setEmail(rs.getString("email"));
                usuario.setCreated_at(rs.getTimestamp("created_at"));
                lista.add(usuario);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    public Usuario obtenerPorId(int id) {
        String sql = "SELECT * FROM usuarios WHERE id = ?";
        Usuario usuario = null;

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setEmail(rs.getString("email"));
                usuario.setClave(rs.getString("clave"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return usuario;
    }

    public boolean Insertar(Usuario usuario) {
        String sqlUsuario = "INSERT INTO usuarios (nombre, email, clave) VALUES (?, ?, ?)";
        String sqlCuenta = "INSERT INTO cuentas (usuario_id, nombre_cuenta, tipo, saldo_inicial) VALUES (?, ?, ?, ?)";

        Connection conn = null;

        try {
            conn = Conexion.getConnection();
            conn.setAutoCommit(false); // 🔥 Iniciar transacción

            // Insertar usuario
            PreparedStatement psUsuario = conn.prepareStatement(sqlUsuario, Statement.RETURN_GENERATED_KEYS);
            psUsuario.setString(1, usuario.getNombre());
            psUsuario.setString(2, usuario.getEmail());
            psUsuario.setString(3, usuario.getClave());
            psUsuario.executeUpdate();

            // Obtener ID generado
            ResultSet rs = psUsuario.getGeneratedKeys();
            int userId = 0;

            if (rs.next()) {
                userId = rs.getInt(1);
            }

            // Crear cuenta en cero
            PreparedStatement psCuenta = conn.prepareStatement(sqlCuenta);
            psCuenta.setInt(1, userId);
            psCuenta.setString(2, "Cuenta principal");
            psCuenta.setString(3, "Ahorros");
            psCuenta.setDouble(4, 0.0);
            psCuenta.executeUpdate();

            conn.commit(); // ✔ Confirmar transacción
            return true;

        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback(); // 🔥 Revertir cambios si hubo error
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;

        } finally {
            try {
                if (conn != null) {
                    conn.close(); // 🔒 Cerrar conexión manualmente
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    public boolean actualizarUsuario(Usuario usuario) {
        String sql = "UPDATE usuarios SET nombre = ?, email = ?, clave = ? "
                + "WHERE id = ?";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, usuario.getNombre());
            pstmt.setString(2, usuario.getEmail());
            pstmt.setString(3, usuario.getClave());
            pstmt.setInt(4, usuario.getId());
            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminarUsuario(int id) {
        String sql = "DELETE FROM usuarios WHERE id = ?";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Usuario> buscar(String criterio) {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT id, nombre, email FROM usuarios WHERE nombre LIKE ? OR email LIKE ? ORDER BY id";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            String parametro = "%" + criterio + "%";
            pstmt.setString(1, parametro);
            pstmt.setString(2, parametro);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setEmail(rs.getString("email"));
                lista.add(usuario);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    public Usuario obtenerPorEmail(String email) {
        String sql = "SELECT * FROM usuarios WHERE email = ?";
        Usuario usuario = null;

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setEmail(rs.getString("email"));
                usuario.setClave(rs.getString("clave"));
                usuario.setProveedor(rs.getString("proveedor"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return usuario;
    }

    public boolean insertarUsuarioGoogle(String nombre, String email) {
        String sql = "INSERT INTO usuarios (nombre, email, proveedor) VALUES (?, ?, 'GOOGLE')";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, nombre);
            pstmt.setString(2, email);
            return pstmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Usuario login(String email, String clave) {
        Usuario usuario = null;
        String sql = "SELECT * FROM usuarios WHERE email = ? AND clave = ? AND proveedor = 'LOCAL'";

        try (Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, clave);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setEmail(rs.getString("email"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return usuario;
    }

}
