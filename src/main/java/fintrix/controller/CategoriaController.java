package fintrix.controller;

import fintrix.dao.CategoriaDAO;
import fintrix.model.Categoria;
import java.io.Serializable;
import java.util.List;

public class CategoriaController implements Serializable {

    private static final long serialVersionUID = 1L;

    private CategoriaDAO categoriaDAO;
    private Categoria categoria;
    private List<Categoria> categorias;
    private String mensaje;
    private String tipoMensaje;

    public CategoriaController() {
        this.categoriaDAO = new CategoriaDAO();
        this.categoria = new Categoria();
    }

    public String listar() {
        try {
            categorias = categoriaDAO.listarCategorias();
            return "success";
        } catch (Exception e) {
            mensaje = "Error al listar categorias: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public String buscar(String criterio) {
        try {
            if (criterio != null && !criterio.trim().isEmpty()) {
                categorias = categoriaDAO.buscar(criterio);
            } else {
                categorias = categoriaDAO.listarCategorias();
            }
            return "success";
        } catch (Exception e) {
            mensaje = "Erro en la búsqueda: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public String obtenerporId(int id) {
        try {
            categoria = categoriaDAO.obtenerCategoriaPorId(id);
            if (categoria == null) {
                mensaje = "Categoria no encontrada";
                tipoMensaje = "warning";
                return "notfound";
            }
            return "success";
        } catch (Exception e) {
            mensaje = "Error al obtener la categoria: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public String crear(Categoria nuevaCategoria) {
        try {
            if (categoriaDAO.crearCategoria(nuevaCategoria)) {
                mensaje = "Categoría creada exitosamente";
                tipoMensaje = "success";
                return "success";
            } else {
                mensaje = "Error al registrar la categoría";
                tipoMensaje = "danger";
                return "error";
            }
        } catch (Exception e) {
            mensaje = " Error: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public String actualizar(Categoria categoriaActualizada) {
        try {
            if (categoriaDAO.actualizarCategoria(categoriaActualizada)) {
                mensaje = "Categoría actualizada exitosamente";
                tipoMensaje = "success";
                return "success";
            } else {
                mensaje = "Error al actualizar la categoría";
                tipoMensaje = "danger";
                return "error";
            }
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public String eliminar(int id) {
        try {
            if (categoriaDAO.eliminarCategoria(id)) {
                mensaje = "Categoria eliminada exitosamente";
                tipoMensaje = "success";
                return "success";
            } else {
                mensaje = "Error al eliminar la categoría";
                tipoMensaje = "danger";
                return "error";
            }
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
            tipoMensaje = "danger";
            return null;
        }
    }

    public Categoria getCategoria() {
        return categoria;
    }

    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }

    public List<Categoria> getCategorias() {
        return categorias;
    }

    public void setCategorias(List<Categoria> categorias) {
        this.categorias = categorias;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public String getTipoMensaje() {
        return tipoMensaje;
    }

    public void setTipoMensaje(String tipoMensaje) {
        this.tipoMensaje = tipoMensaje;
    }

}
