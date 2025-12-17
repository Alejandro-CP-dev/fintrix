<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*,java.text.NumberFormat,
         fintrix.dao.CuentaDAO,fintrix.model.Cuenta,
         fintrix.dao.PreferenciasDAO,fintrix.model.Preferencias,
         fintrix.dao.UsuarioDAO,fintrix.model.Usuario" %>

<%
    request.setCharacterEncoding("UTF-8");

    // ==============================
    //   PREFERENCIAS & SESIÓN
    // ==============================
    String theme = (String) session.getAttribute("theme");
    Integer usuarioId = (Integer) session.getAttribute("usuarioId");

    if (theme == null || session.getAttribute("currencyLocale") == null) {
        UsuarioDAO udao = new UsuarioDAO();
        Usuario u = (usuarioId != null) ? udao.obtenerPorId(usuarioId) : null;
        if (u == null) {
            List<Usuario> us = udao.listarUsuarios();
            if (!us.isEmpty()) {
                u = us.get(0);
                session.setAttribute("usuarioId", u.getId());
            }
        }
        if (u != null) {
            PreferenciasDAO pdao = new PreferenciasDAO();
            Preferencias p = pdao.obtenerPorUsuarioId(u.getId());
            theme = p.getTema();
            session.setAttribute("theme", theme);
            session.setAttribute("currencyLocale",
                    pdao.getLocaleForMoneda(p.getMoneda()));
        }
        if (theme == null) {
            theme = "dark";
        }
    }

    Locale currLoc = (Locale) session.getAttribute("currencyLocale");
    if (currLoc == null) {
        currLoc = new Locale("es", "CO");
    }
    NumberFormat nf = NumberFormat.getCurrencyInstance(currLoc);

    // ==============================
    //   CONTROL DE MENSAJES
    // ==============================
    String msg = null;
    String tipo = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String action = request.getParameter("action");
        try {
            CuentaDAO cdao = new CuentaDAO();

            // CREAR CUENTA
            if ("create".equalsIgnoreCase(action)) {
                String nombre = request.getParameter("nombre");
                String tipoCuenta = request.getParameter("tipo");
                String saldoStr = request.getParameter("saldo_inicial");

                double saldo = (saldoStr != null && saldoStr.trim().length() > 0)
                        ? Double.parseDouble(saldoStr)
                        : 0.0;

                if (nombre == null || nombre.trim().isEmpty()) {
                    msg = "El nombre es obligatorio";
                    tipo = "warning";
                } else if (saldo < 0) {
                    msg = "El saldo inicial no puede ser negativo";
                    tipo = "warning";
                } else if (cdao.existeNombreParaUsuario(usuarioId, nombre.trim(), null)) {
                    msg = "Ya existe una cuenta con ese nombre";
                    tipo = "warning";
                } else {
                    Cuenta c = new Cuenta();
                    c.setUsuario_id(usuarioId);
                    c.setNombre(nombre);
                    c.setTipo(tipoCuenta);
                    c.setSaldo_inicial(saldo);

                    boolean ok = cdao.crearCuenta(c);
                    msg = ok ? "Cuenta creada" : "Error al crear cuenta";
                    tipo = ok ? "success" : "danger";

                    if (ok) {
                        response.sendRedirect("cuentas.jsp");
                        return;
                    }
                }
            } // ACTUALIZAR CUENTA
            else if ("update".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String nombre = request.getParameter("nombre");
                String tipoCuenta = request.getParameter("tipo");
                double saldo = Double.parseDouble(request.getParameter("saldo_inicial"));

                if (nombre == null || nombre.trim().isEmpty()) {
                    msg = "El nombre es obligatorio";
                    tipo = "warning";
                } else if (saldo < 0) {
                    msg = "El saldo inicial no puede ser negativo";
                    tipo = "warning";
                } else if (cdao.existeNombreParaUsuario(usuarioId, nombre.trim(), id)) {
                    msg = "Ya existe una cuenta con ese nombre";
                    tipo = "warning";
                } else {
                    Cuenta c = new Cuenta();
                    c.setId(id);
                    c.setUsuario_id(usuarioId);
                    c.setNombre(nombre);
                    c.setTipo(tipoCuenta);
                    c.setSaldo_inicial(saldo);

                    boolean ok = cdao.actualizarCuentaPorUsuario(c);
                    msg = ok ? "Cuenta actualizada" : "Error al actualizar cuenta";
                    tipo = ok ? "success" : "danger";

                    if (ok) {
                        response.sendRedirect("cuentas.jsp");
                        return;
                    }
                }
            } // ELIMINAR CUENTA
            else if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean ok = cdao.eliminar(id);
                msg = ok ? "Cuenta eliminada" : "Error al eliminar cuenta";
                tipo = ok ? "success" : "danger";

                if (ok) {
                    response.sendRedirect("cuentas.jsp");
                    return;
                }
            }

        } catch (Exception ex) {
            msg = "Datos inválidos";
            tipo = "warning";
        }
    }

    // LISTADO DE CUENTAS
    List<Cuenta> cs = new CuentaDAO().listarCuentasPorUsuario(usuarioId);
%>

<!DOCTYPE html>
<html class="<%= theme%>" lang="es">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

        <title>Cuentas</title>

        <!-- Fuentes -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;700;800&display=swap" rel="stylesheet">

        <!-- Icons -->
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>

        <!-- Tailwind -->
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>

        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            primary: "#137fec",
                            "background-light": "#f6f7f8",
                            "background-dark": "#101922"
                        },
                        fontFamily: {display: ["Manrope", "sans-serif"]},
                        borderRadius: {DEFAULT: "1rem", lg: "1.5rem", xl: "2rem"}
                    }
                }
            };
        </script>

    </head>

    <body class="bg-background-light dark:bg-background-dark font-display">
        <div class="relative min-h-screen flex flex-col">

            <!-- HEADER -->
            <header class="flex items-center p-4 pb-2 bg-background-light dark:bg-background-dark sticky top-0 z-10">
                <a href="PControl_Finanzas.jsp"
                   class="flex items-center justify-center rounded-full h-10 w-10 text-slate-800 dark:text-white">
                    <span class="material-symbols-outlined text-2xl">arrow_back_ios_new</span>
                </a>
                <h2 class="text-lg font-bold text-center flex-1 text-slate-900 dark:text-white">Cuentas</h2>
                <div class="w-10"></div>
            </header>

            <!-- CONTENIDO -->
            <main class="flex flex-col gap-4 p-4">

                <!-- MENSAJE -->
                <% if (msg != null) {%>
                <div class="rounded-lg px-4 py-2 text-sm
                     <%= "success".equals(tipo) ? "bg-green-100 text-green-700"
                             : ("danger".equals(tipo) ? "bg-red-100 text-red-700"
                             : "bg-yellow-100 text-yellow-700")%>">
                    <%= msg%>
                </div>
                <% } %>

                <!-- CREAR CUENTA -->
                <section class="flex flex-col gap-2 rounded-lg bg-white dark:bg-slate-800/50 p-4">
                    <h3 class="text-lg font-bold text-slate-900 dark:text-white">Crear cuenta</h3>

                    <form method="post" class="flex flex-wrap gap-2 items-end">
                        <input name="nombre" placeholder="Nombre"
                               class="form-input rounded bg-white dark:bg-zinc-800 border
                               border-zinc-300 dark:border-zinc-700 text-zinc-900 dark:text-white h-10 px-3"/>

                        <select name="tipo"
                                class="form-select rounded bg-white dark:bg-zinc-800 border
                                border-zinc-300 dark:border-zinc-700 text-zinc-900 dark:text-white h-10 px-2">
                            <option value="Ahorros">Ahorros</option>
                            <option value="Corriente">Corriente</option>
                            <option value="Tarjeta">Tarjeta</option>
                        </select>

                        <input type="number" step="0.01" name="saldo_inicial" placeholder="Saldo inicial"
                               class="form-input rounded bg-white dark:bg-zinc-800 border
                               border-zinc-300 dark:border-zinc-700 text-zinc-900 dark:text-white h-10 px-3"/>

                        <input type="hidden" name="action" value="create"/>

                        <button class="rounded-full h-10 px-4 bg-primary text-white text-sm font-bold">
                            Guardar
                        </button>
                    </form>
                </section>

                <!-- LISTA DE CUENTAS -->
                <section class="flex flex-col gap-3">
                    <% if (cs.isEmpty()) { %>
                    <div class="rounded-lg bg-white dark:bg-slate-800/50 p-4 text-slate-600 dark:text-slate-300">
                        No hay cuentas registradas.
                    </div>
                    <% } %>

                    <% for (Cuenta c : cs) {%>
                    <div class="flex flex-col md:flex-row md:items-center md:justify-between
                         gap-4 rounded-lg bg-white dark:bg-slate-800/50 p-4 shadow">

                        <!-- INFO -->
                        <div class="flex items-center gap-4">
                            <div class="h-12 w-12 rounded-full bg-slate-500/20 text-slate-500 flex items-center justify-center">
                                <span class="material-symbols-outlined">account_balance_wallet</span>
                            </div>

                            <!-- FORM EDITAR -->
                            <form method="post" class="flex flex-wrap items-center gap-2">
                                <input type="hidden" name="id" value="<%= c.getId()%>" />

                                <input name="nombre" value="<%= c.getNombre()%>"
                                       class="form-input rounded bg-white dark:bg-zinc-800 border
                                       border-zinc-300 dark:border-zinc-700 text-zinc-900 dark:text-white h-10 px-3"/>

                                <select name="tipo"
                                        class="form-select rounded bg-white dark:bg-zinc-800 border
                                        border-zinc-300 dark:border-zinc-700 text-zinc-900 dark:text-white h-10 px-2">
                                    <option value="Ahorros" <%= c.getTipo().equals("Ahorros") ? "selected" : ""%>>Ahorros</option>
                                    <option value="Corriente" <%= c.getTipo().equals("Corriente") ? "selected" : ""%>>Corriente</option>
                                    <option value="Tarjeta" <%= c.getTipo().equals("Tarjeta") ? "selected" : ""%>>Tarjeta</option>
                                </select>

                                <input type="number" step="0.01" name="saldo_inicial"
                                       value="<%= c.getSaldo_inicial()%>"
                                       class="form-input rounded bg-white dark:bg-zinc-800 border
                                       border-zinc-300 dark:border-zinc-700 text-zinc-900 dark:text-white h-10 px-3"/>

                                <input type="hidden" name="action" value="update"/>
                                <button class="rounded-full h-10 px-4 bg-primary text-white text-sm font-bold">
                                    Guardar
                                </button>  
                            </form>
                        </div>

                        <!-- ELIMINAR -->
                        <form method="post" class="self-end md:self-center">
                            <input type="hidden" name="id" value="<%= c.getId()%>"/>
                            <input type="hidden" name="action" value="delete"/>
                            <button class="rounded-full h-10 px-4 bg-red-500 text-white text-sm font-bold">
                                Eliminar
                            </button>
                        </form>

                    </div>
                    <% }%>
                </section>
            </main>

            <!-- NAV -->
            <nav class="fixed bottom-0 left-0 right-0 h-20 bg-white/80 dark:bg-background-dark/80 backdrop-blur-lg border-t">
                <div class="flex justify-around items-center h-full max-w-lg mx-auto">

                    <a href="PControl_Finanzas.jsp"
                       class="flex flex-col items-center text-slate-400 dark:text-slate-500">
                        <span class="material-symbols-outlined text-3xl">dashboard</span>
                        <span class="text-xs font-bold">Resumen</span>
                    </a>

                    <a href="movimientos.jsp"
                       class="flex flex-col items-center text-slate-400 dark:text-slate-500">
                        <span class="material-symbols-outlined text-3xl">receipt_long</span>
                        <span class="text-xs font-bold">Movimientos</span>
                    </a>

                    <a href="analisis.jsp"
                       class="flex flex-col items-center text-slate-400 dark:text-slate-500">
                        <span class="material-symbols-outlined text-3xl">pie_chart</span>
                        <span class="text-xs font-bold">Análisis</span>
                    </a>

                    <a href="cuentas.jsp"
                       class="flex flex-col items-center text-primary">
                        <span class="material-symbols-outlined text-3xl">account_balance_wallet</span>
                        <span class="text-xs font-bold">Cuentas</span>
                    </a>

                </div>
            </nav>

        </div>
    </body>
</html>