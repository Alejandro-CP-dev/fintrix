package fintrix.dao;

import fintrix.model.Categoria;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoriaDAO {

    public List<Categoria> listarCategorias() {
        List<Categoria> lista = new ArrayList<>();
        String sql = "SELECT * FROM categorias";

        try (Connection conn = Conexion.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setId(rs.getInt("id"));
                categoria.setUsuario_id(rs.getInt("usuario_id"));
                categoria.setNombre(rs.getString("nombre"));
                categoria.setTipo(rs.getString("tipo"));
                lista.add(categoria);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }

    public List<Categoria> listarPorTipo(String tipo) {
        List<Categoria> lista = new ArrayList<>();
        String sql = "SELECT * FROM categorias WHERE tipo = ? ORDER BY nombre";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, tipo);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Categoria categoria = new Categoria();
                    categoria.setId(rs.getInt("id"));
                    categoria.setUsuario_id(rs.getInt("usuario_id"));
                    categoria.setNombre(rs.getString("nombre"));
                    categoria.setTipo(rs.getString("tipo"));
                    lista.add(categoria);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public void sembrarCategoriasGastoPorDefecto(int usuarioId) {
        String[] defaults = new String[]{
            "Supermercado",
            "Transporte",
            "Servicios públicos",
            "Salud",
            "Educación",
            "Vivienda",
            "Ocio",
            "Impuestos",
            "Seguro",
            "Entretenimiento",
            "Compras",
            "Restaurantes",
            "Ropa",
            "Hogar",
            "Internet",
            "Teléfono"
        };
        String checkSql = "SELECT id FROM categorias WHERE tipo = 'Gasto' AND nombre = ? LIMIT 1";
        String insertSql = "INSERT INTO categorias (usuario_id, nombre, tipo) VALUES (?, ?, 'Gasto')";
        try (Connection conn = Conexion.getConnection()) {
            try (PreparedStatement check = conn.prepareStatement(checkSql); PreparedStatement insert = conn.prepareStatement(insertSql)) {
                for (String nombre : defaults) {
                    check.setString(1, nombre);
                    try (ResultSet rs = check.executeQuery()) {
                        if (!rs.next()) {
                            insert.setInt(1, usuarioId);
                            insert.setString(2, nombre);
                            insert.executeUpdate();
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void sembrarCategoriasIngresoPorDefecto(int usuarioId) {
        String[] defaults = new String[]{
            "Salario",
            "Beca",
            "Intereses",
            "Ventas",
            "Reembolsos",
            "Regalos",
            "Freelance",
            "Dividendos",
            "Alquiler",
            "Otros ingresos"
        };
        String checkSql = "SELECT id FROM categorias WHERE tipo = 'Ingreso' AND nombre = ? LIMIT 1";
        String insertSql = "INSERT INTO categorias (usuario_id, nombre, tipo) VALUES (?, ?, 'Ingreso')";
        try (Connection conn = Conexion.getConnection()) {
            try (PreparedStatement check = conn.prepareStatement(checkSql); PreparedStatement insert = conn.prepareStatement(insertSql)) {
                for (String nombre : defaults) {
                    check.setString(1, nombre);
                    try (ResultSet rs = check.executeQuery()) {
                        if (!rs.next()) {
                            insert.setInt(1, usuarioId);
                            insert.setString(2, nombre);
                            insert.executeUpdate();
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Categoria obtenerCategoriaPorId(int id) {
        String sql = "SELECT * FROM categorias WHERE id = ?";
        Categoria categoria = null;

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                categoria = new Categoria();
                categoria.setId(rs.getInt("id"));
                categoria.setUsuario_id(rs.getInt("usuario_id"));
                categoria.setNombre(rs.getString("nombre"));
                categoria.setTipo(rs.getString("tipo"));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categoria;
    }

    public boolean crearCategoria(Categoria categoria) {
        String sql = "INSERT INTO categorias (usuario_id, nombre, tipo) VALUES (?, ?, ?)";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, categoria.getUsuario_id());
            pstmt.setString(2, categoria.getNombre());
            pstmt.setString(3, categoria.getTipo());
            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean actualizarCategoria(Categoria categoria) {
        String sql = "UPDATE categorias SET usuario_id = ?, nombre = ?, tipo = ? WHERE id = ?";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, categoria.getUsuario_id());
            pstmt.setString(2, categoria.getNombre());
            pstmt.setString(3, categoria.getTipo());
            pstmt.setInt(4, categoria.getId());
            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminarCategoria(int id) {
        String sql = "DELETE FROM categorias WHERE id = ?";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            int filasAfectadas = pstmt.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Categoria> buscar(String criterio) {
        List<Categoria> lista = new ArrayList<>();
        String sql = "SELECT * FROM categorias "
                + "WHERE nombre LIKE ? OR tipo LIKE ? "
                + "ORDER BY nombre";

        try (Connection conn = Conexion.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

            String parametro = "%" + criterio + "%";
            pstmt.setString(1, parametro);
            pstmt.setString(2, parametro);

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setId(rs.getInt("id"));
                categoria.setUsuario_id(rs.getInt("usuario_id"));
                categoria.setNombre(rs.getString("nombre"));
                categoria.setTipo(rs.getString("tipo"));
                lista.add(categoria);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    public List<Categoria> listarPorUsuario(int usuarioId) {
        List<Categoria> lista = new ArrayList<>();

        String sql = "SELECT * FROM categorias WHERE usuario_id = ? ORDER BY nombre";

        try (Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, usuarioId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Categoria c = new Categoria();
                c.setId(rs.getInt("id"));
                c.setUsuario_id(rs.getInt("usuario_id"));
                c.setNombre(rs.getString("nombre"));
                c.setTipo(rs.getString("tipo"));
                lista.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

}
