<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*,java.time.*,java.text.NumberFormat,fintrix.dao.TransaccionDAO,fintrix.model.Transaccion,fintrix.dao.CategoriaDAO,fintrix.model.Categoria,fintrix.dao.PreferenciasDAO,fintrix.model.Preferencias,fintrix.dao.UsuarioDAO,fintrix.model.Usuario" %>
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
    List<Transaccion> ts = null;
    List<Categoria> categorias = null;
    if (usuarioId != null) {
        ts = new TransaccionDAO().listarTransaccionesPorUsuario(usuarioId);
    } else {
        ts = java.util.Collections.emptyList();
    }

    try {
        categorias = new CategoriaDAO().listarPorUsuario(usuarioId);
    } catch (Exception e) {
        categorias = java.util.Collections.emptyList();
    }
    Map<Integer, String> catNames = new HashMap<>();
    for (Categoria c : categorias) {
        catNames.put(c.getId(), c.getNombre());
    }
    LocalDate hoy = LocalDate.now();
    YearMonth ym = YearMonth.from(hoy);
    double gastosMes = 0.0;
    Map<String, Double> gastoPorCategoria = new HashMap<>();
    for (Transaccion t : ts) {
        LocalDate f = t.getFecha() != null ? t.getFecha().toLocalDate() : hoy;
        if (YearMonth.from(f).equals(ym) && "Gasto".equalsIgnoreCase(t.getTipo())) {
            String key = catNames.getOrDefault(t.getCategoria_id(), "Otros");
            gastoPorCategoria.put(key, gastoPorCategoria.getOrDefault(key, 0.0) + t.getMonto());
            gastosMes += t.getMonto();
        }
    }
    List<Map.Entry<String, Double>> top = new ArrayList<>(gastoPorCategoria.entrySet());
    java.util.Collections.sort(top, new java.util.Comparator<Map.Entry<String, Double>>() {
        public int compare(Map.Entry<String, Double> a, Map.Entry<String, Double> b) {
            return Double.compare(b.getValue(), a.getValue());
        }
    });
    while (top.size() < 3) {
        top.add(new AbstractMap.SimpleEntry<>("-", 0.0));
    }
    double v0 = top.get(0).getValue(), v1 = top.get(1).getValue(), v2 = top.get(2).getValue();
    double p0 = gastosMes > 0 ? (v0 / gastosMes) * 100.0 : 0.0, p1 = gastosMes > 0 ? (v1 / gastosMes) * 100.0 : 0.0, p2 = gastosMes > 0 ? (v2 / gastosMes) * 100.0 : 0.0;
    String p0s = String.format(java.util.Locale.US, "%.2f", p0), p1s = String.format(java.util.Locale.US, "%.2f", p1), p2s = String.format(java.util.Locale.US, "%.2f", p2);
    String o1s = String.format(java.util.Locale.US, "%.2f", -p0), o2s = String.format(java.util.Locale.US, "%.2f", -(p0 + p1));
%>
<html class="<%= theme%>" lang="es"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Análisis</title>
        <link href="https://fonts.googleapis.com" rel="preconnect"/>
        <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <script id="tailwind-config"> tailwind.config = {darkMode: "class", theme: {extend: {colors: {"primary": "#137fec", "background-light": "#f6f7f8", "background-dark": "#101922"}, fontFamily: {"display": ["Manrope", "sans-serif"]}, borderRadius: {"DEFAULT": "1rem", "lg": "1.5rem", "xl": "2rem", "full": "9999px"}}}}</script>
        <style> body {
            min-height: max(884px, 100dvh);
        } </style>
    </head>
    <body class="bg-background-light dark:bg-background-dark font-display">
        <div class="relative flex h-auto min-h-screen w-full flex-col overflow-x-hidden">
            <div class="flex items-center bg-background-light dark:bg-background-dark p-4 pb-2 justify-between sticky top-0 z-10">
                <div class="flex size-12 shrink-0 items-center justify-start"><a href="PControl_Finanzas.jsp" class="flex items-center justify-center rounded-full h-10 w-10 text-slate-800 dark:text-white"><span class="material-symbols-outlined text-2xl">arrow_back_ios_new</span></a></div>
                <h2 class="text-slate-900 dark:text-white text-lg font-bold leading-tight tracking-[-0.015em] flex-1 text-center">Análisis</h2>
                <div class="flex w-12 items-center justify-end"></div>
            </div>
            <div class="flex flex-col gap-4 p-4">
                <div class="flex flex-col gap-4 p-4">
                    <h3 class="text-slate-900 dark:text-white text-lg font-bold leading-tight tracking-[-0.015em]">Gastos del mes</h3>
                    <div class="flex flex-col items-center justify-center rounded-lg bg-white dark:bg-slate-800/50 p-6 gap-6 shadow-sm">
                        <div class="relative w-40 h-40">
                            <svg class="w-full h-full" viewbox="0 0 36 36">
                            <path class="stroke-current text-blue-500" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" fill="none" stroke-dasharray="<%= p0s%>, 100" stroke-width="4"></path>
                            <path class="stroke-current text-purple-500" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" fill="none" stroke-dasharray="<%= p1s%>, 100" stroke-dashoffset="<%= o1s%>" stroke-width="4"></path>
                            <path class="stroke-current text-yellow-500" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" fill="none" stroke-dasharray="<%= p2s%>, 100" stroke-dashoffset="<%= o2s%>" stroke-width="4"></path>
                            </svg>
                            <div class="absolute inset-0 flex flex-col items-center justify-center">
                                <span class="text-slate-500 dark:text-slate-400 text-sm">Total Gastado</span>
                                <span class="text-slate-900 dark:text-white text-xl font-bold"><%= nf.format(gastosMes)%></span>
                            </div>
                        </div>
                        <div class="w-full flex flex-col gap-3">
                            <div class="flex items-center justify-between text-sm"><div class="flex items-center gap-2"><span class="w-3 h-3 rounded-full bg-blue-500"></span><span class="text-slate-600 dark:text-slate-300"><%= top.get(0).getKey()%></span></div><span class="font-bold text-slate-800 dark:text-slate-100"><%= nf.format(top.get(0).getValue())%></span></div>
                            <div class="flex items-center justify-between text-sm"><div class="flex items-center gap-2"><span class="w-3 h-3 rounded-full bg-purple-500"></span><span class="text-slate-600 dark:text-slate-300"><%= top.get(1).getKey()%></span></div><span class="font-bold text-slate-800 dark:text-slate-100"><%= nf.format(top.get(1).getValue())%></span></div>
                            <div class="flex items-center justify-between text-sm"><div class="flex items-center gap-2"><span class="w-3 h-3 rounded-full bg-yellow-500"></span><span class="text-slate-600 dark:text-slate-300"><%= top.get(2).getKey()%></span></div><span class="font-bold text-slate-800 dark:text-slate-100"><%= nf.format(top.get(2).getValue())%></span></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="fixed bottom-0 left-0 right-0 h-20 bg-white/80 dark:bg-background-dark/80 backdrop-blur-lg border-t border-slate-200 dark:border-slate-800">
                <div class="flex justify-around items-center h-full max-w-lg mx-auto">
                    <a href="PControl_Finanzas.jsp" class="flex flex-col items-center justify-center text-slate-400 dark:text-slate-500 w-16"><span class="material-symbols-outlined text-3xl">dashboard</span><span class="text-xs font-bold">Resumen</span></a>
                    <a href="movimientos.jsp" class="flex flex-col items-center justify-center text-slate-400 dark:text-slate-500 w-16"><span class="material-symbols-outlined text-3xl">receipt_long</span><span class="text-xs font-bold">Movimientos</span></a>
                    <a href="analisis.jsp" class="flex flex-col items-center justify-center text-primary w-16"><span class="material-symbols-outlined text-3xl">pie_chart</span><span class="text-xs font-bold">Análisis</span></a>
                    <a href="cuentas.jsp" class="flex flex-col items-center justify-center text-slate-400 dark:text-slate-500 w-16"><span class="material-symbols-outlined text-3xl">account_balance_wallet</span><span class="text-xs font-bold">Cuentas</span></a>
                </div>
            </div>
        </div>
    </body></html>
