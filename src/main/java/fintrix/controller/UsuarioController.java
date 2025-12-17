package fintrix.controller;

import fintrix.dao.UsuarioDAO;
import fintrix.model.Usuario;
import java.io.Serializable;
import java.util.List;

public class UsuarioController implements Serializable {

    private static final long serialVersionUID = 1L;

    private UsuarioDAO usuarioDAO;
    private Usuario usuario;
    private List<Usuario> usuarios;
    private String mensaje;
    private String tipoMensaje;

    public UsuarioController() {
        this.usuarioDAO = new UsuarioDAO();
        this.usuario = new Usuario();
    }

    public String buscar(String criterio) {
        try {
            if (criterio != null && !criterio.trim().isEmpty()) {
                usuarios = usuarioDAO.buscar(criterio);
            } else {
                usuarios = usuarioDAO.listarUsuarios();
            }
            return "success";
        } catch (Exception e) {
            mensaje = "Error en la búsqueda: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public String obtenerporId(int id) {
        try {
            usuario = usuarioDAO.obtenerPorId(id);
            if (usuario == null) {
                mensaje = "Usuario no encontrado";
                tipoMensaje = "warning";
                return "notfound";
            }
            return "success";
        } catch (Exception e) {
            mensaje = "Error al obtener el usuario: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public String crear(Usuario nuevoUsuario) {
        try {
            if (usuarioDAO.Insertar(nuevoUsuario)) {
                mensaje = "Usuario creado exitosamente";
                tipoMensaje = "success";
                return "success";
            } else {
                mensaje = "Error al registrar el usuario";
                tipoMensaje = "danger";
                return "error";
            }
        } catch (Exception e) {
            mensaje = " Error: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public String actualizar(Usuario usuarioActualizado) {
        try {
            if (usuarioDAO.actualizarUsuario(usuarioActualizado)) {
                mensaje = "Usuario actualizado exitosamente";
                tipoMensaje = "success";
                return "success";
            } else {
                mensaje = "Error al actualizar el usuario";
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
            if (usuarioDAO.eliminarUsuario(id)) {
                mensaje = "Usuario eliminado exitosamente";
                tipoMensaje = "success";
                return "success";
            } else {
                mensaje = "Error al eliminar el usuario";
                tipoMensaje = "danger";
                return "error";
            }
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
            tipoMensaje = "danger";
            return null;
        }
    }

}
