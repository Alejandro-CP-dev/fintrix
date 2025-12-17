<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*,java.time.*,java.text.NumberFormat,fintrix.dao.TransaccionDAO,fintrix.model.Transaccion,fintrix.dao.CuentaDAO,fintrix.model.Cuenta,fintrix.dao.CategoriaDAO,fintrix.model.Categoria,fintrix.dao.Conexion,fintrix.dao.PreferenciasDAO,fintrix.model.Preferencias" %>
<!DOCTYPE html>

<%
    String theme = (String) session.getAttribute("theme");

    try {
        // 1. VALIDACIÓN DE SESIÓN (OBLIGATORIA)
        Integer usuarioId = (Integer) session.getAttribute("usuarioId");
        if (usuarioId == null) {
            response.sendRedirect("../index.jsp");
            return;
        }

        // 2. CARGAR USUARIO
        fintrix.dao.UsuarioDAO udao = new fintrix.dao.UsuarioDAO();
        fintrix.model.Usuario uTmp = udao.obtenerPorId(usuarioId);

        if (uTmp == null) {
            session.invalidate();
            response.sendRedirect("../index.jsp");
            return;
        }

        // 3. CARGAR PREFERENCIAS SOLO SI NO EXISTEN EN SESIÓN
        if (theme == null) {
            fintrix.dao.PreferenciasDAO pDaoTmp = new fintrix.dao.PreferenciasDAO();
            fintrix.model.Preferencias pTmp
                    = pDaoTmp.obtenerPorUsuarioId(uTmp.getId());

            if (pTmp != null) {
                theme = pTmp.getTema() != null ? pTmp.getTema() : "dark";
                session.setAttribute("theme", theme);

                java.util.Locale currLocInit
                        = pDaoTmp.getLocaleForMoneda(pTmp.getMoneda());
                session.setAttribute("currencyLocale", currLocInit);
            } else {
                theme = "dark";
                session.setAttribute("theme", theme);
            }
        }

    } catch (Exception ex) {
        theme = "dark";
        session.setAttribute("theme", theme);
    }
%>
<html class="<%= theme%>" lang="es"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Panel de control de finanzas</title>
        <link href="https://fonts.googleapis.com" rel="preconnect"/>
        <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>
        <link rel="stylesheet" href="style.css" type="text/css">

        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <style type="text/tailwindcss">
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
                            "primary": "#137fec",
                            "background-light": "#f6f7f8",
                            "background-dark": "#101922",
                        },
                        fontFamily: {
                            "display": ["Manrope", "sans-serif"]
                        },
                        borderRadius: {"DEFAULT": "1rem", "lg": "1.5rem", "xl": "2rem", "full": "9999px"},
                    },
                },
            }
        </script>
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
            List<Transaccion> ts = null;
            List<Cuenta> cs = null;
            try {
                ts = new TransaccionDAO().listarTransaccionesPorUsuario(usuarioId);
            } catch (Exception e) {
                ts = java.util.Collections.emptyList();
            }
            try {
                cs = new CuentaDAO().listarCuentasPorUsuario(usuarioId);
            } catch (Exception e) {
                cs = java.util.Collections.emptyList();
            }
            LocalDate hoy = LocalDate.now();
            YearMonth ym = YearMonth.from(hoy);
            double ingresosMes = 0.0, gastosMes = 0.0, totalIngresos = 0.0, totalGastos = 0.0;
            for (Transaccion t : ts) {
                LocalDate f = t.getFecha() != null ? t.getFecha().toLocalDate() : hoy;
                if ("Ingreso".equalsIgnoreCase(t.getTipo())) {
                    totalIngresos += t.getMonto();
                    if (YearMonth.from(f).equals(ym)) {
                        ingresosMes += t.getMonto();
                    }
                } else if ("Gasto".equalsIgnoreCase(t.getTipo())) {
                    totalGastos += t.getMonto();
                    if (YearMonth.from(f).equals(ym)) {
                        gastosMes += t.getMonto();
                    }
                }
            }
            double saldoInicial = 0.0;
            for (Cuenta c : cs) {
                saldoInicial += c.getSaldo_inicial();
            }
            double saldoActual = saldoInicial + totalIngresos - totalGastos;
            java.util.Locale currLocNF = (java.util.Locale) session.getAttribute("currencyLocale");
            if (currLocNF == null) {
                currLocNF = new java.util.Locale("es", "CO");
            }
            NumberFormat nf = NumberFormat.getCurrencyInstance(currLocNF);

            Map<Integer, String> catNames = new HashMap<>();
            try {
                for (Categoria c : new CategoriaDAO().listarCategorias()) {
                    catNames.put(c.getId(), c.getNombre());
                }
            } catch (Exception e) {
            }

            Map<String, Double> gastoPorCategoria = new HashMap<>();
            for (Transaccion t : ts) {
                LocalDate f = t.getFecha() != null ? t.getFecha().toLocalDate() : hoy;
                if (YearMonth.from(f).equals(ym) && "Gasto".equalsIgnoreCase(t.getTipo())) {
                    String key = catNames.getOrDefault(t.getCategoria_id(), "Otros");
                    gastoPorCategoria.put(key, gastoPorCategoria.getOrDefault(key, 0.0) + t.getMonto());
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

            double totalGastoMes = gastosMes;
            double v0 = top.get(0).getValue();
            double v1 = top.get(1).getValue();
            double v2 = top.get(2).getValue();
            double p0 = totalGastoMes > 0 ? (v0 / totalGastoMes) * 100.0 : 0.0;
            double p1 = totalGastoMes > 0 ? (v1 / totalGastoMes) * 100.0 : 0.0;
            double p2 = totalGastoMes > 0 ? (v2 / totalGastoMes) * 100.0 : 0.0;
            String p0s = String.format(java.util.Locale.US, "%.2f", p0);
            String p1s = String.format(java.util.Locale.US, "%.2f", p1);
            String p2s = String.format(java.util.Locale.US, "%.2f", p2);
            String o1s = String.format(java.util.Locale.US, "%.2f", -p0);
            String o2s = String.format(java.util.Locale.US, "%.2f", -(p0 + p1));

            List<Transaccion> recientes = new ArrayList<>(ts);
            java.util.Collections.sort(recientes, new java.util.Comparator<Transaccion>() {
                public int compare(Transaccion a, Transaccion b) {
                    java.sql.Date fa = a.getFecha();
                    java.sql.Date fb = b.getFecha();
                    long ta = fa != null ? fa.getTime() : 0L;
                    long tb = fb != null ? fb.getTime() : 0L;
                    return Long.compare(tb, ta);
                }
            });
            if (recientes.size() > 3)
                recientes = recientes.subList(0, 3);
        %>
        <div id="top" class="relative flex h-auto min-h-screen w-full flex-col overflow-x-hidden">
            <div class="flex flex-col flex-1 pb-24">
                <!-- TopAppBar -->
                <div class="flex items-center bg-background-light dark:bg-background-dark p-4 pb-2 justify-between sticky top-0 z-10">
                    <div class="flex size-12 shrink-0 items-center justify-start">
                        <button class="flex items-center justify-center rounded-full h-10 w-10 text-slate-800 dark:text-white">
                            <span class="material-symbols-outlined text-2xl"><a href="configuracion.jsp">person</a></span>
                        </button>
                    </div>
                    <h2 class="text-slate-900 dark:text-white text-lg font-bold leading-tight tracking-[-0.015em] flex-1 text-center">Resumen</h2>
                    <div class="flex w-12 items-center justify-end">
                        <button class="flex max-w-[480px] cursor-pointer items-center justify-center overflow-hidden rounded-full h-12 bg-transparent text-slate-800 dark:text-white gap-2 text-base font-bold leading-normal tracking-[0.015em] min-w-0 p-0">
                            <span class="material-symbols-outlined text-2xl"><a href="notificaciones.jsp">notifications</a></span>
                        </button>
                    </div>
                </div>
                <div class="px-4">
                    <%
                        boolean dbOk = Conexion.testConnection();
                        String dbMsg = dbOk ? "Conectado a la base de datos" : "No hay conexión a la base de datos";
                    %>
                    <div class="rounded-lg px-4 py-2 text-sm <%= dbOk ? "bg-green-100 text-green-700" : "bg-red-100 text-red-700"%>"><%= dbMsg%></div>
                </div>
                <!-- BodyText -->
                <p class="text-slate-500 dark:text-slate-400 text-base font-normal leading-normal pb-0 pt-4 px-4">Saldo Actual</p>
                <!-- HeadlineText -->
                <h1 class="text-slate-900 dark:text-white tracking-tight text-[32px] font-bold leading-tight px-4 text-left pb-3 pt-1"><%= nf.format(saldoActual)%></h1>
                <!-- ButtonGroup -->
                <div class="flex justify-stretch">
                    <div class="flex flex-1 gap-3 flex-wrap px-4 py-3 justify-start">
                        <button class="flex flex-1 min-w-[84px] max-w-[480px] cursor-pointer items-center justify-center overflow-hidden rounded-full h-12 px-4 bg-primary text-white text-sm font-bold leading-normal tracking-[0.015em] gap-2">
                            <span class="material-symbols-outlined text-xl">remove</span>
                            <span class="truncate"><a href="registro_transaccion.jsp">Añadir Gasto</a></span>
                        </button>
                        <button class="flex flex-1 min-w-[84px] max-w-[480px] cursor-pointer items-center justify-center overflow-hidden rounded-full h-12 px-4 bg-primary/20 text-primary text-sm font-bold leading-normal tracking-[0.015em] gap-2">
                            <span class="material-symbols-outlined text-xl">add</span>
                            <span class="truncate"><a href="registroT_ingreso.jsp">Añadir Ingreso</a></span>
                        </button>
                    </div>
                </div>
                <!-- Stats -->
                <div class="flex flex-wrap gap-4 p-4">
                    <div class="flex min-w-[158px] flex-1 flex-col gap-2 rounded-lg bg-white dark:bg-slate-800/50 p-6 shadow-sm">
                        <p class="text-slate-500 dark:text-slate-400 text-base font-medium leading-normal">Ingresos del Mes</p>
                        <p class="text-green-500 dark:text-green-400 tracking-light text-2xl font-bold leading-tight">+<%= nf.format(ingresosMes)%></p>
                    </div>
                    <div class="flex min-w-[158px] flex-1 flex-col gap-2 rounded-lg bg-white dark:bg-slate-800/50 p-6 shadow-sm">
                        <p class="text-slate-500 dark:text-slate-400 text-base font-medium leading-normal">Gastos del Mes</p>
                        <p class="text-red-500 dark:text-red-400 tracking-light text-2xl font-bold leading-tight">-<%= nf.format(gastosMes)%></p>
                    </div>
                </div>
                <!-- Donut Chart Card -->
                <div id="analisis" class="flex flex-col gap-4 p-4">
                    <h3 class="text-slate-900 dark:text-white text-lg font-bold leading-tight tracking-[-0.015em]">Gastos por Categoría</h3>
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
                            <div class="flex items-center justify-between text-sm">
                                <div class="flex items-center gap-2">
                                    <span class="w-3 h-3 rounded-full bg-blue-500"></span>
                                    <span class="text-slate-600 dark:text-slate-300"><%= top.get(0).getKey()%></span>
                                </div>
                                <span class="font-bold text-slate-800 dark:text-slate-100"><%= nf.format(top.get(0).getValue())%></span>
                            </div>
                            <div class="flex items-center justify-between text-sm">
                                <div class="flex items-center gap-2">
                                    <span class="w-3 h-3 rounded-full bg-purple-500"></span>
                                    <span class="text-slate-600 dark:text-slate-300"><%= top.get(1).getKey()%></span>
                                </div>
                                <span class="font-bold text-slate-800 dark:text-slate-100"><%= nf.format(top.get(1).getValue())%></span>
                            </div>
                            <div class="flex items-center justify-between text-sm">
                                <div class="flex items-center gap-2">
                                    <span class="w-3 h-3 rounded-full bg-yellow-500"></span>
                                    <span class="text-slate-600 dark:text-slate-300"><%= top.get(2).getKey()%></span>
                                </div>
                                <span class="font-bold text-slate-800 dark:text-slate-100"><%= nf.format(top.get(2).getValue())%></span>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Recent Transactions List -->
                <div id="movimientos" class="flex flex-col gap-4 p-4">
                    <div class="flex items-center justify-between">
                        <h3 class="text-slate-900 dark:text-white text-lg font-bold leading-tight tracking-[-0.015em]">Movimientos Recientes</h3>
                        <a class="text-primary text-sm font-bold" href="#">Ver todo</a>
                    </div>
                    <div class="flex flex-col gap-3">
                        <% for (Transaccion t : recientes) {
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
                    </div>
                </div>
                <!-- Accounts List -->
                <div id="cuentas" class="flex flex-col gap-4 p-4">
                    <div class="flex items-center justify-between">
                        <h3 class="text-slate-900 dark:text-white text-lg font-bold leading-tight tracking-[-0.015em]">Cuentas</h3>
                    </div>
                    <div class="flex flex-col gap-3">
                        <% for (Cuenta c : cs) {%>
                        <div class="flex items-center justify-between rounded-lg bg-white dark:bg-slate-800/50 p-4 shadow-sm">
                            <div class="flex items-center gap-4">
                                <div class="flex h-12 w-12 items-center justify-center rounded-full bg-slate-500/20 text-slate-500">
                                    <span class="material-symbols-outlined">account_balance_wallet</span>
                                </div>
                                <div>
                                    <p class="font-bold text-slate-800 dark:text-white"><%= c.getNombre()%></p>
                                    <p class="text-sm text-slate-500 dark:text-slate-400"><%= c.getTipo()%></p>
                                </div>
                            </div>
                            <p class="font-bold text-slate-800 dark:text-slate-100"><%= nf.format(c.getSaldo_inicial())%></p>
                        </div>
                        <% } %>
                        <% if (cs == null || cs.isEmpty()) { %>
                        <div class="rounded-lg bg-white dark:bg-slate-800/50 p-4 text-slate-600 dark:text-slate-300">
                            No hay cuentas registradas.
                        </div>
                        <% }%>
                    </div>
                </div>
            </div>
            <!-- Bottom Navigation Bar -->
            <div class="fixed bottom-0 left-0 right-0 h-20 bg-white/80 dark:bg-background-dark/80 backdrop-blur-lg border-t border-slate-200 dark:border-slate-800">
                <div class="flex justify-around items-center h-full max-w-lg mx-auto">
                    <a href="PControl_Finanzas.jsp" class="flex flex-col items-center justify-center text-primary w-16">
                        <span class="material-symbols-outlined text-3xl">dashboard</span>
                        <span class="text-xs font-bold">Resumen</span>
                    </a>
                    <a href="movimientos.jsp" class="flex flex-col items-center justify-center text-slate-400 dark:text-slate-500 w-16">
                        <span class="material-symbols-outlined text-3xl">receipt_long</span>
                        <span class="text-xs font-bold">Movimientos</span>
                    </a>
                    <a href="analisis.jsp" class="flex flex-col items-center justify-center text-slate-400 dark:text-slate-500 w-16">
                        <span class="material-symbols-outlined text-3xl">pie_chart</span>
                        <span class="text-xs font-bold">Análisis</span>
                    </a>
                    <a href="cuentas.jsp" class="flex flex-col items-center justify-center text-slate-400 dark:text-slate-500 w-16">
                        <span class="material-symbols-outlined text-3xl">account_balance_wallet</span>
                        <span class="text-xs font-bold">Cuentas</span>
                    </a>
                </div>
            </div>
        </div>
    </body></html>
