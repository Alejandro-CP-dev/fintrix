package fintrix.controller;

import fintrix.dao.TransaccionDAO;
import fintrix.model.Transaccion;
import java.io.Serializable;
import java.util.List;

public class TransaccionController implements Serializable {

    private static final long serialVersionUID = 1L;

    private TransaccionDAO transaccionDAO;
    private Transaccion transaccion;
    private List<Transaccion> transacciones;
    private String mensaje;
    private String tipoMensaje;

    public TransaccionController() {
        this.transaccionDAO = new TransaccionDAO();
        this.transaccion = new Transaccion();
    }

    public String listar() {
        try {
            transacciones = transaccionDAO.listarTransacciones();
            return "success";
        } catch (Exception e) {
            mensaje = "Error al listar transacciones: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public String buscar(String criterio) {
        try {
            if (criterio != null && !criterio.trim().isEmpty()) {
                transacciones = transaccionDAO.buscar(criterio);
            } else {
                transacciones = transaccionDAO.listarTransacciones();
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
            transaccion = transaccionDAO.obtenerTransaccionPorId(id);
            if (transaccion == null) {
                mensaje = "Transacción no encontrada";
                tipoMensaje = "warning";
                return "notfound";
            }
            return "success";
        } catch (Exception e) {
            mensaje = "Error al obtener la transacción: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public String crear(Transaccion nuevaTransaccion) {
        try {
            if (transaccionDAO.crearTransaccion(nuevaTransaccion)) {
                mensaje = "Transacción creada exitosamente";
                tipoMensaje = "success";
                return "success";
            } else {
                mensaje = "Error al registrar la transacción";
                tipoMensaje = "danger";
                return "error";
            }
        } catch (Exception e) {
            mensaje = " Error: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public String actualizar(Transaccion transaccionActualizada) {
        try {
            if (transaccionDAO.actualizarTransaccion(transaccionActualizada)) {
                mensaje = "Transacción actualizada exitosamente";
                tipoMensaje = "success";
                return "success";
            } else {
                mensaje = "Error al actualizar la transacción";
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
            if (transaccionDAO.eliminarTransaccion(id)) {
                mensaje = "Transacción eliminada exitosamente";
                tipoMensaje = "success";
                return "success";
            } else {
                mensaje = "Error al eliminar la transacción";
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
