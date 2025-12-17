<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*,java.text.NumberFormat,java.time.LocalDate,fintrix.dao.TransaccionDAO,fintrix.model.Transaccion,fintrix.dao.PreferenciasDAO,fintrix.model.Preferencias,fintrix.dao.UsuarioDAO,fintrix.model.Usuario,fintrix.dao.CategoriaDAO,fintrix.model.Categoria" %>
<!DOCTYPE html>

<%
    request.setCharacterEncoding("UTF-8");
    String theme = (String) session.getAttribute("theme");
    Integer usuarioId = (Integer) session.getAttribute("usuarioId");
    if (theme == null || session.getAttribute("currencyLocale") == null) {
        UsuarioDAO udao = new UsuarioDAO();
        Usuario u = null;
        if (usuarioId != null) {
            u = udao.obtenerPorId(usuarioId);
        }
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
            java.util.Locale loc = pdao.getLocaleForMoneda(p.getMoneda());
            session.setAttribute("currencyLocale", loc);
        }
        if (theme == null) {
            theme = "dark";
        }
    }
    java.util.Locale currLoc = (java.util.Locale) session.getAttribute("currencyLocale");
    if (currLoc == null) {
        currLoc = new java.util.Locale("es", "CO");
    }
    NumberFormat nf = NumberFormat.getCurrencyInstance(currLoc);
%>
<html class="<%= theme%>" lang="es"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Movimientos</title>
        <link href="https://fonts.googleapis.com" rel="preconnect"/>
        <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <script id="tailwind-config">
            tailwind.config = {darkMode: "class", theme: {extend: {colors: {"primary": "#137fec", "background-light": "#f6f7f8", "background-dark": "#101922"}, fontFamily: {"display": ["Manrope", "sans-serif"]}, borderRadius: {"DEFAULT": "1rem", "lg": "1.5rem", "xl": "2rem", "full": "9999px"}}}}
        </script>
        <style> body {
            min-height: max(884px, 100dvh);
        } </style>
    </head>
    <body class="bg-background-light dark:bg-background-dark font-display">
        <div class="relative flex h-auto min-h-screen w-full flex-col overflow-x-hidden">
            <div class="flex items-center bg-background-light dark:bg-background-dark p-4 pb-2 justify-between sticky top-0 z-10">
                <div class="flex size-12 shrink-0 items-center justify-start">
                    <a href="PControl_Finanzas.jsp" class="flex items-center justify-center rounded-full h-10 w-10 text-slate-800 dark:text-white"><span class="material-symbols-outlined text-2xl">arrow_back_ios_new</span></a>
                </div>
                <h2 class="text-slate-900 dark:text-white text-lg font-bold leading-tight tracking-[-0.015em] flex-1 text-center">Movimientos</h2>
                <div class="flex w-12 items-center justify-end"></div>
            </div>
            <div class="flex flex-col gap-4 p-4">
                <div class="flex justify-stretch">
                    <div class="flex flex-1 gap-3 flex-wrap px-0 py-0 justify-start">
                        <a class="flex flex-1 min-w-[84px] max-w-[480px] items-center justify-center overflow-hidden rounded-full h-12 px-4 bg-primary text-white text-sm font-bold gap-2" href="registro_transaccion.jsp">
                            <span class="material-symbols-outlined text-xl">remove</span>
                            <span class="truncate">Añadir Gasto</span>
                        </a>
                        <a class="flex flex-1 min-w-[84px] max-w-[480px] items-center justify-center overflow-hidden rounded-full h-12 px-4 bg-primary/20 text-primary text-sm font-bold gap-2" href="registroT_ingreso.jsp">
                            <span class="material-symbols-outlined text-xl">add</span>
                            <span class="truncate">Añadir Ingreso</span>
                        </a>
                    </div>
                </div>
                <%
                    List<Transaccion> tsAll = new TransaccionDAO().listarTransaccionesPorUsuario(usuarioId);
                    List<Categoria> categorias = new CategoriaDAO().listarPorUsuario(usuarioId);
                    String fdesde = request.getParameter("fecha_desde");
                    String fhasta = request.getParameter("fecha_hasta");
                    String tipoSel = request.getParameter("tipo");
                    String catSel = request.getParameter("categoria_id");
                    Integer catId = null;
                    try {
                        if (catSel != null && catSel.trim().length() > 0) {
                            catId = Integer.parseInt(catSel);
                        }
                    } catch (Exception ex) {
                    }
                    LocalDate desde = null, hasta = null;
                    try {
                        if (fdesde != null && !fdesde.isEmpty()) {
                            desde = LocalDate.parse(fdesde);
                        }
                    } catch (Exception ex) {
                    }
                    try {
                        if (fhasta != null && !fhasta.isEmpty()) {
                            hasta = LocalDate.parse(fhasta);
                        }
                    } catch (Exception ex) {
                    }
                    List<Transaccion> ts = new ArrayList<>();
                    for (Transaccion t : tsAll) {
                        boolean ok = true;

                        
                        if (usuarioId != null) {
                            ok = ok && t.getUsuario_id() == usuarioId.intValue();
                        }

                        if (tipoSel != null && tipoSel.length() > 0 && !"Todos".equalsIgnoreCase(tipoSel)) {
                            ok = ok && tipoSel.equalsIgnoreCase(t.getTipo());
                        }

                        if (catId != null) {
                            ok = ok && t.getCategoria_id() == catId.intValue();
                        }

                        LocalDate ft = t.getFecha() != null ? t.getFecha().toLocalDate() : null;
                        if (desde != null && ft != null) {
                            ok = ok && !ft.isBefore(desde);
                        }
                        if (hasta != null && ft != null) {
                            ok = ok && !ft.isAfter(hasta);
                        }

                        if (ok) {
                            ts.add(t);
                        }
                    }

                    java.util.Collections.sort(ts, new java.util.Comparator<Transaccion>() {
                        public int compare(Transaccion a, Transaccion b) {
                            java.sql.Date fa = a.getFecha();
                            java.sql.Date fb = b.getFecha();
                            long ta = fa != null ? fa.getTime() : 0L;
                            long tb = fb != null ? fb.getTime() : 0L;
                            return Long.compare(tb, ta);
                        }
                    });
                %>
                <form method="get" action="movimientos.jsp" class="flex flex-wrap gap-2 items-end">
                    <input type="date" name="fecha_desde" value="<%= fdesde != null ? fdesde : ""%>" class="form-input rounded bg-white dark:bg-zinc-800 border border-zinc-300 dark:border-zinc-700 text-zinc-900 dark:text-white h-10 px-3" />
                    <input type="date" name="fecha_hasta" value="<%= fhasta != null ? fhasta : ""%>" class="form-input rounded bg-white dark:bg-zinc-800 border border-zinc-300 dark:border-zinc-700 text-zinc-900 dark:text-white h-10 px-3" />
                    <select name="tipo" class="form-select rounded bg-white dark:bg-zinc-800 border border-zinc-300 dark:border-zinc-700 text-zinc-900 dark:text-white h-10 px-2">
                        <option value="Todos" <%= (tipoSel == null || "Todos".equalsIgnoreCase(tipoSel)) ? "selected" : ""%>>Todos</option>
                        <option value="Ingreso" <%= "Ingreso".equalsIgnoreCase(tipoSel) ? "selected" : ""%>>Ingreso</option>
                        <option value="Gasto" <%= "Gasto".equalsIgnoreCase(tipoSel) ? "selected" : ""%>>Gasto</option>
                    </select>
                    <select name="categoria_id" class="form-select rounded bg-white dark:bg-zinc-800 border border-zinc-300 dark:border-zinc-700 text-zinc-900 dark:text-white h-10 px-2">
                        <option value="">Todas las categorías</option>
                        <% for (Categoria c : categorias) {%>
                        <option value="<%= c.getId()%>" <%= (catId != null && catId.intValue() == c.getId()) ? "selected" : ""%>><%= c.getNombre()%></option>
                        <% } %>
                    </select>
                    <button type="submit" class="rounded-full h-10 px-4 bg-primary text-white text-sm font-bold">Filtrar</button>
                </form>
                <div class="flex flex-col gap-3">
                    <% for (Transaccion t : ts) {
                            boolean ingreso = "Ingreso".equalsIgnoreCase(t.getTipo());%>
                    <div class="flex items-center justify-between rounded-lg bg-white dark:bg-slate-800/50 p-4 shadow-sm">
                        <div class="flex items-center gap-4">
                            <div class="flex h-12 w-12 items-center justify-center rounded-full <%= ingreso ? "bg-green-500/20 text-green-500" : "bg-primary/20 text-primary"%>">
                                <span class="material-symbols-outlined"><%= ingreso ? "payments" : "receipt_long"%></span>
                            </div>
                            <div>
                                <p class="font-bold text-slate-800 dark:text-white"><%= t.getDescripcion() != null ? t.getDescripcion() : (ingreso ? "Ingreso" : "Gasto")%></p>
                                <p class="text-sm text-slate-500 dark:text-slate-400"><%= t.getFecha() != null ? t.getFecha().toString() : ""%></p>
                            </div>
                        </div>
                        <p class="font-bold <%= ingreso ? "text-green-500 dark:text-green-400" : "text-red-500 dark:text-red-400"%>"><%= (ingreso ? "+" : "-") + nf.format(t.getMonto())%></p>
                    </div>
                    <% } %>
                    <% if (ts == null || ts.isEmpty()) { %>
                    <div class="rounded-lg bg-white dark:bg-slate-800/50 p-4 text-slate-600 dark:text-slate-300">No hay movimientos registrados.</div>
                    <% }%>
                </div>
            </div>
            <div class="fixed bottom-0 left-0 right-0 h-20 bg-white/80 dark:bg-background-dark/80 backdrop-blur-lg border-t border-slate-200 dark:border-slate-800">
                <div class="flex justify-around items-center h-full max-w-lg mx-auto">
                    <a href="PControl_Finanzas.jsp" class="flex flex-col items-center justify-center text-slate-400 dark:text-slate-500 w-16"><span class="material-symbols-outlined text-3xl">dashboard</span><span class="text-xs font-bold">Resumen</span></a>
                    <a href="movimientos.jsp" class="flex flex-col items-center justify-center text-primary w-16"><span class="material-symbols-outlined text-3xl">receipt_long</span><span class="text-xs font-bold">Movimientos</span></a>
                    <a href="analisis.jsp" class="flex flex-col items-center justify-center text-slate-400 dark:text-slate-500 w-16"><span class="material-symbols-outlined text-3xl">pie_chart</span><span class="text-xs font-bold">Análisis</span></a>
                    <a href="cuentas.jsp" class="flex flex-col items-center justify-center text-slate-400 dark:text-slate-500 w-16"><span class="material-symbols-outlined text-3xl">account_balance_wallet</span><span class="text-xs font-bold">Cuentas</span></a>
                </div>
            </div>
        </div>
    </body></html>
