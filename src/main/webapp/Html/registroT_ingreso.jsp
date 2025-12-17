<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List,fintrix.dao.CategoriaDAO,fintrix.model.Categoria,java.time.LocalDate,java.sql.Date,fintrix.dao.TransaccionDAO,fintrix.model.Transaccion,fintrix.dao.CuentaDAO,fintrix.model.Cuenta" %>
<!DOCTYPE html>
<html class="dark" lang="es"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Registro de Transacciones - Ingreso</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200;300;400;500;600;700;800&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>
        <style>
            .material-symbols-outlined {
                font-variation-settings:
                    'FILL' 0,
                    'wght' 400,
                    'GRAD' 0,
                    'opsz' 24
            }
        </style>
        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            "primary": "#34C759",
                            "background-light": "#F2F2F7",
                            "background-dark": "#101922",
                        },
                        fontFamily: {
                            "display": ["Manrope", "sans-serif"]
                        },
                        borderRadius: {
                            "DEFAULT": "1rem",
                            "lg": "2rem",
                            "xl": "3rem",
                            "full": "9999px"
                        },
                    },
                },
            }
        </script>
        <style>
            body {
                min-height: max(884px, 100dvh);
            }
        </style>
        <style>
            body {
                min-height: max(884px, 100dvh);
            }
        </style>
    </head>
    <body class="bg-background-light dark:bg-background-dark font-display">
        <%

            Integer usuarioId = (Integer) session.getAttribute("usuarioId");
            request.setCharacterEncoding("UTF-8");
            List<Categoria> categorias = null;
            List<Cuenta> cuentas = null;
            try {
                new CategoriaDAO().sembrarCategoriasIngresoPorDefecto(1);
            } catch (Exception e) {
            }
            try {
                categorias = new CategoriaDAO().listarPorTipo("Ingreso");
            } catch (Exception e) {
                categorias = java.util.Collections.emptyList();
            }
            try {
                cuentas = new CuentaDAO().listarCuentasPorUsuario(usuarioId);
            } catch (Exception e) {
                cuentas = java.util.Collections.emptyList();
            }
            String hoy = LocalDate.now().toString();
            String msg = null;
            String tipo = null;
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String montoStr = request.getParameter("monto");
                String descripcion = request.getParameter("descripcion");
                String categoriaStr = request.getParameter("categoria_id");
                String fechaStr = request.getParameter("fecha");
                String cuentaStr = request.getParameter("cuenta_id");
                try {
                    double monto = Double.parseDouble(montoStr);
                    int categoriaId = Integer.parseInt(categoriaStr);
                    int cuentaId = Integer.parseInt(cuentaStr);
                    Date fecha = Date.valueOf(fechaStr);
                    Transaccion t = new Transaccion();
                    t.setUsuario_id(usuarioId);
                    t.setCuenta_id(cuentaId);
                    t.setCategoria_id(categoriaId);
                    t.setFecha(fecha);
                    t.setTipo("Ingreso");
                    t.setDescripcion(descripcion);
                    t.setMonto(monto);
                    boolean ok = new TransaccionDAO().crearTransaccion(t);
                    if (ok) {
                        new CuentaDAO().actualizarSaldo(cuentaId, monto); // ← AQUI
                        response.sendRedirect("PControl_Finanzas.jsp");
                        return;
                    } else {
                        msg = "Error al guardar el ingreso";
                        tipo = "danger";
                    }
                } catch (Exception ex) {
                    msg = "Datos inválidos";
                    tipo = "warning";
                }
            }
        %>
        <div class="relative flex h-auto min-h-screen w-full flex-col">
            <header class="flex items-center p-4 pb-2 justify-between sticky top-0 z-10 bg-background-light dark:bg-background-dark">
                <div class="flex size-10 shrink-0 items-center justify-center">
                    <span class="material-symbols-outlined text-gray-800 dark:text-gray-200"><a href="PControl_Finanzas.jsp">close</a></span>
                </div>
                <h1 class="text-gray-900 dark:text-white text-lg font-bold leading-tight tracking-[-0.015em] flex-1 text-center">Nuevo Ingreso</h1>
                <div class="flex size-10 shrink-0 items-center justify-center"></div>
            </header>
            <main class="flex-1 px-4 py-2">
                <form id="ingreso-form" class="w-full" method="post" action="registroT_ingreso.jsp">
                    <div class="flex py-3">
                        <div class="flex h-12 flex-1 items-center justify-center rounded-xl bg-gray-200 dark:bg-gray-800 p-1">
                            <label class="group flex cursor-pointer h-full grow items-center justify-center overflow-hidden rounded-lg px-2 has-[:checked]:bg-white has-[:checked]:dark:bg-black has-[:checked]:shadow-md">
                                <span class="truncate text-red-500 font-bold text-base leading-normal"><a href="registro_transaccion.jsp">Gasto</a></span>
                                <input class="sr-only" name="transaction_type" type="radio" value="Gasto"/>
                            </label>
                            <label class="group flex cursor-pointer h-full grow items-center justify-center overflow-hidden rounded-lg px-2 has-[:checked]:bg-white has-[:checked]:dark:bg-black has-[:checked]:shadow-md">
                                <span class="truncate text-green-500 font-bold text-base leading-normal">Ingreso</span>
                                <input checked="" class="sr-only" name="transaction_type" type="radio" value="Ingreso"/>
                            </label>
                        </div>
                    </div>
                    <div class="flex max-w-[480px] flex-wrap items-end gap-4 py-3">
                        <label class="flex flex-col min-w-40 flex-1">
                            <p class="text-gray-800 dark:text-white text-base font-medium leading-normal pb-2">Monto</p>
                            <input name="monto" class="form-input flex w-full min-w-0 flex-1 resize-none overflow-hidden rounded-xl text-gray-900 dark:text-white focus:outline-0 focus:ring-2 focus:ring-primary border-none bg-gray-200 dark:bg-gray-800 h-14 placeholder:text-gray-500 dark:placeholder:text-gray-400 p-4 text-base font-normal leading-normal" placeholder="$0.00" type="number" step="0.01" min="0" value=""/>
                        </label>
                    </div>
                    <div class="flex max-w-[480px] flex-wrap items-end gap-4 py-3">
                        <label class="flex flex-col min-w-40 flex-1">
                            <p class="text-gray-800 dark:text-white text-base font-medium leading-normal pb-2">Descripción</p>
                            <input name="descripcion" class="form-input flex w-full min-w-0 flex-1 resize-none overflow-hidden rounded-xl text-gray-900 dark:text-white focus:outline-0 focus:ring-2 focus:ring-primary border-none bg-gray-200 dark:bg-gray-800 h-14 placeholder:text-gray-500 dark:placeholder:text-gray-400 p-4 text-base font-normal leading-normal" placeholder="Beca de estudios" value=""/>
                        </label>
                    </div>
                    <div class="mt-4 flex flex-col gap-4 overflow-hidden rounded-xl">
                        <div class="flex items-center gap-4 p-4 min-h-14 justify-between bg-gray-200 dark:bg-gray-800 rounded-xl">
                            <div class="flex items-center gap-4">
                                <div class="text-gray-900 dark:text-white flex items-center justify-center rounded-lg shrink-0 size-10">
                                    <span class="material-symbols-outlined">category</span>
                                </div>
                                <p class="text-gray-900 dark:text-white text-base font-normal leading-normal">Categoría</p>
                            </div>
                            <div class="flex items-center gap-2">
                                <select name="categoria_id" required class="form-select rounded-xl bg-white dark:bg-slate-800 border border-slate-300 dark:border-slate-700 text-gray-900 dark:text-white h-12 px-3">
                                    <option value="">Seleccione categoría</option>
                                    <% for (Categoria c : categorias) {%>
                                    <option value="<%= c.getId()%>"><%= c.getNombre()%></option>
                                    <% } %>
                                </select>
                            </div>
                        </div>
                        <div class="flex items-center gap-4 p-4 min-h-14 justify-between bg-gray-200 dark:bg-gray-800 rounded-xl">
                            <div class="flex items-center gap-4">
                                <div class="text-gray-900 dark:text-white flex items-center justify-center rounded-lg shrink-0 size-10">
                                    <span class="material-symbols-outlined">account_balance_wallet</span>
                                </div>
                                <p class="text-gray-900 dark:text-white text-base font-normal leading-normal">Cuenta</p>
                            </div>
                            <div class="flex items-center gap-2">
                                <select name="cuenta_id" required class="form-select rounded-xl bg-white dark:bg-slate-800 border border-slate-300 dark:border-slate-700 text-gray-900 dark:text-white h-12 px-3">
                                    <option value="">Seleccione cuenta</option>
                                    <% for (Cuenta cu : cuentas) {%>
                                    <option value="<%= cu.getId()%>"><%= cu.getNombre()%> - <%= cu.getTipo()%></option>
                                    <% }%>
                                </select>
                            </div>
                        </div>
                        <div class="flex items-center gap-4 p-4 min-h-14 justify-between bg-gray-200 dark:bg-gray-800 rounded-xl">
                            <div class="flex items-center gap-4">
                                <div class="text-gray-900 dark:text-white flex items-center justify-center rounded-lg shrink-0 size-10">
                                    <span class="material-symbols-outlined">calendar_month</span>
                                </div>
                                <p class="text-gray-900 dark:text-white text-base font-normal leading-normal">Fecha</p>
                            </div>
                            <div class="flex items-center gap-2">
                                <input type="date" name="fecha" value="<%= hoy%>" class="form-input rounded-xl bg-white dark:bg-slate-800 border border-slate-300 dark:border-slate-700 text-gray-900 dark:text-white h-12 px-3"/>
                            </div>
                        </div>
                    </div>
                </form>
            </main>
            <footer class="p-4 pt-8 sticky bottom-0 z-10 bg-background-light dark:bg-background-dark">
                <% if (msg != null) {%>
                <p class="text-center text-sm <%="danger".equals(tipo) ? "text-red-500" : "text-yellow-500"%>"><%= msg%></p>
                <% }%>
                <button type="submit" form="ingreso-form" class="flex w-full items-center justify-center rounded-xl bg-primary h-14 text-white text-lg font-bold leading-normal shadow-lg shadow-primary/30 hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary focus:ring-offset-background-light dark:focus:ring-offset-background-dark">
                    Guardar Ingreso
                </button>
            </footer>
        </div>

    </body></html>
