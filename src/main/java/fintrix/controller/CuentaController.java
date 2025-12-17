package fintrix.controller;

import fintrix.dao.CuentaDAO;
import fintrix.model.Cuenta;
import java.io.Serializable;
import java.util.List;

public class CuentaController implements Serializable {

    private static final long serialVersionUID = 1L;

    private CuentaDAO cuentaDAO;
    private Cuenta cuenta;
    private List<Cuenta> cuentas;
    private String mensaje;
    private String tipoMensaje;

    public CuentaController() {
        this.cuentaDAO = new CuentaDAO();
        this.cuenta = new Cuenta();
    }

    public String listar() {
        try {
            cuentas = cuentaDAO.listarCuentasPorUsuario(0);
            return "success";
        } catch (Exception e) {
            mensaje = "Error al listar las cuentas: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public String buscar(String criterio) {
        try {
            if (criterio != null && !criterio.trim().isEmpty()) {
                cuentas = cuentaDAO.buscar(criterio);
            } else {
                cuentas = cuentaDAO.listarCuentasPorUsuario(0);
            }
            return "success";
        } catch (Exception e) {
            mensaje = "Error en la búsqueda: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public String obtenerPorId(int id) {
        try {
            cuenta = cuentaDAO.obtenerCuentaPorId(id);
            if (cuenta == null) {
                mensaje = "Cuenta no encontrada";
                tipoMensaje = "warning";
                return "notfound";
            }
            return "success";
        } catch (Exception e) {
            mensaje = "Error al obtener la cuenta: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public String crear(Cuenta nuevaCuenta) {
        try {
            if (cuentaDAO.crearCuenta(nuevaCuenta)) {
                mensaje = "Cuenta creada exitosamente";
                tipoMensaje = "success";
                return "success";
            } else {
                mensaje = "Error al registrar la cuenta";
                tipoMensaje = "danger";
                return "error";
            }
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
            tipoMensaje = "danger";
            return "error";
        }
    }

    public String actualizar(Cuenta cuentaActualizada) {
        try {
            if (cuentaDAO.actualizarCuenta(cuentaActualizada)) {
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
            if (cuentaDAO.eliminar(id)) {
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

    public Cuenta getCuenta() {
        return cuenta;
    }

    public void setCuenta(Cuenta cuenta) {
        this.cuenta = cuenta;
    }

    public List<Cuenta> getCuentas() {
        return cuentas;
    }

    public void setCuentas(List<Cuenta> cuentas) {
        this.cuentas = cuentas;
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
