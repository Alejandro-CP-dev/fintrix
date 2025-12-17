<%@ page import="java.util.List,fintrix.dao.UsuarioDAO,fintrix.model.Usuario,fintrix.dao.Conexion,fintrix.dao.PreferenciasDAO,fintrix.model.Preferencias" %>
<!DOCTYPE html>

<%
    request.setCharacterEncoding("UTF-8");
    String theme = (String) session.getAttribute("theme");
    String themeParamInit = request.getParameter("dark_mode");
    if ("POST".equalsIgnoreCase(request.getMethod()) && themeParamInit != null) {
        String newThemeInit = ("dark".equalsIgnoreCase(themeParamInit) || "on".equalsIgnoreCase(themeParamInit)) ? "dark" : "light";
        theme = newThemeInit;
        session.setAttribute("theme", theme);
    }
    if (theme == null)
        theme = "dark";
%>
<html class="<%= theme%>" lang="es"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Perfil y Configuración</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;700;800&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>
        <style>
            .material-symbols-outlined {
                font-variation-settings:
                    'FILL' 0,
                    'wght' 400,
                    'GRAD' 0,
                    'opsz' 24;
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
                        borderRadius: {"DEFAULT": "1rem", "lg": "2rem", "xl": "3rem", "full": "9999px"},
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
        <div class="relative flex min-h-screen w-full flex-col group/design-root overflow-x-hidden">
            <!-- Top App Bar -->
            <header class="sticky top-0 z-10 flex h-14 items-center justify-between bg-background-light/80 px-4 py-2 backdrop-blur-sm dark:bg-background-dark/80">
                <div class="flex size-10 shrink-0 items-center justify-start">
                    <span class="material-symbols-outlined text-zinc-900 dark:text-white text-2xl"><a href="PControl_Finanzas.jsp">arrow_back_ios_new</a></span>
                </div>
                <h1 class="flex-1 text-center text-lg font-bold leading-tight tracking-[-0.015em] text-zinc-900 dark:text-white">Perfil y Configuración</h1>
                <div class="flex w-10 items-center justify-end">
                    <p class="shrink-0 text-base font-bold leading-normal tracking-[0.015em] text-primary">Guardar</p>
                </div>
            </header>
            <main class="flex flex-col gap-6 p-4 pt-6">
                <%
                    request.setCharacterEncoding("UTF-8");
                    Usuario perfil = null;
                    try {
                        Integer usuarioId = (Integer) session.getAttribute("usuarioId");
                        UsuarioDAO udao = new UsuarioDAO();
                        if (usuarioId != null) {
                            perfil = udao.obtenerPorId(usuarioId);
                        }
                        if (perfil == null) {
                            List<Usuario> todos = udao.listarUsuarios();
                            if (todos != null && !todos.isEmpty()) {
                                perfil = todos.get(0);
                                session.setAttribute("usuarioId", perfil.getId());
                            }
                        }
                        if (perfil == null) {
                            List<Usuario> encontrados = udao.buscar("@");
                            if (encontrados != null && !encontrados.isEmpty()) {
                                perfil = encontrados.get(0);
                                session.setAttribute("usuarioId", perfil.getId());
                            }
                        }
                    } catch (Exception e) {
                    }
                    PreferenciasDAO prefDao = new PreferenciasDAO();
                    Preferencias prefs = perfil != null ? prefDao.obtenerPorUsuarioId(perfil.getId()) : null;

                    String currParam = request.getParameter("currency");
                    if ("POST".equalsIgnoreCase(request.getMethod()) && currParam != null && prefs != null) {
                        prefs.setMoneda(currParam);
                        java.util.Locale setLoc = prefDao.getLocaleForMoneda(currParam);
                        session.setAttribute("currencyLocale", setLoc);
                        prefDao.guardar(prefs);
                    }
                    String notifParam = request.getParameter("notifications");
                    if ("POST".equalsIgnoreCase(request.getMethod()) && notifParam != null && prefs != null) {
                        boolean enabled = "on".equalsIgnoreCase(notifParam) || "true".equalsIgnoreCase(notifParam);
                        prefs.setNotificaciones(enabled);
                        session.setAttribute("notificationsEnabled", enabled);
                        prefDao.guardar(prefs);
                    }
                    String themeParam = request.getParameter("dark_mode");
                    if ("POST".equalsIgnoreCase(request.getMethod()) && themeParam != null && prefs != null) {
                        String newTheme = ("dark".equalsIgnoreCase(themeParam) || "on".equalsIgnoreCase(themeParam)) ? "dark" : "light";
                        prefs.setTema(newTheme);
                        session.setAttribute("theme", newTheme);
                        prefDao.guardar(prefs);
                    }
                    String pwdParam = request.getParameter("new_password");
                    if ("POST".equalsIgnoreCase(request.getMethod()) && pwdParam != null && perfil != null) {
                        perfil.setClave(pwdParam);
                        new UsuarioDAO().actualizarUsuario(perfil);
                    }
                    String faceParam = request.getParameter("face_id");
                    if ("POST".equalsIgnoreCase(request.getMethod()) && faceParam != null && prefs != null) {
                        boolean enabled = "on".equalsIgnoreCase(faceParam) || "true".equalsIgnoreCase(faceParam);
                        prefs.setFaceId(enabled);
                        session.setAttribute("faceIdEnabled", enabled);
                        prefDao.guardar(prefs);
                    }
                    String nombreParam = request.getParameter("nombre");
                    String emailParam = request.getParameter("email");
                    if ("POST".equalsIgnoreCase(request.getMethod()) && (nombreParam != null || emailParam != null) && perfil != null) {
                        if (nombreParam != null) {
                            perfil.setNombre(nombreParam);
                        }
                        if (emailParam != null) {
                            perfil.setEmail(emailParam);
                        }
                        new UsuarioDAO().actualizarUsuario(perfil);
                    }

                    java.util.Locale currLoc = new java.util.Locale("es", "CO");
                    String currCode = java.util.Currency.getInstance(currLoc).getCurrencyCode();
                    String monedaTexto = "COP Colombia";
                    Boolean notifEnabled = Boolean.TRUE;
                    String currentTheme = "dark";
                    Boolean faceEnabled = Boolean.FALSE;
                    String nombrePerfil = perfil != null && perfil.getNombre() != null ? perfil.getNombre() : "Carlos Valderrama";
                    String emailPerfil = perfil != null && perfil.getEmail() != null ? perfil.getEmail() : "carlos.valderrama@email.com";

                    if (prefs != null) {
                        currLoc = prefDao.getLocaleForMoneda(prefs.getMoneda());
                        session.setAttribute("currencyLocale", currLoc);
                        currCode = java.util.Currency.getInstance(currLoc).getCurrencyCode();
                        monedaTexto = "COP".equals(currCode) ? "COP Colombia" : currCode;
                        notifEnabled = prefs.getNotificaciones();
                        currentTheme = prefs.getTema();
                        faceEnabled = prefs.getFaceId();
                        session.setAttribute("theme", currentTheme);
                    }
                %>
                <!-- Profile Header -->
                <section class="flex w-full flex-col items-center gap-4">
                    <div class="w-full">
                        <%
                            boolean dbOk = Conexion.testConnection();
                            String dbMsg = dbOk ? "Conectado a la base de datos" : "No hay conexión a la base de datos";
                        %>
                        <div class="rounded-lg px-4 py-2 text-sm <%= dbOk ? "bg-green-100 text-green-700" : "bg-red-100 text-red-700"%>"><%= dbMsg%></div>
                    </div>
                    <%
                        String fotoPerfil = (String) session.getAttribute("fotoPerfil");

                        if (fotoPerfil == null || fotoPerfil.trim().isEmpty()) {
                            fotoPerfil = request.getContextPath() + "/img/default-user.png";
                        } else {
                            fotoPerfil = request.getContextPath() + "/" + fotoPerfil;
                        }
                    %>


                    <div class="bg-center bg-cover rounded-full h-28 w-28"
                         style="background-image: url('<%= fotoPerfil%>');">
                    </div>


                    <div class="flex flex-col items-center justify-center">
                        <p class="text-zinc-900 dark:text-white text-[22px] font-bold leading-tight tracking-[-0.015em] text-center"><%= nombrePerfil%></p>
                        <p class="text-zinc-500 dark:text-zinc-400 text-base font-normal leading-normal text-center"><%= emailPerfil%></p>
                    </div>
                    <form action="<%= request.getContextPath()%>/SubirFotoServlet"
                          method="post"
                          enctype="multipart/form-data">

                        <input type="file" name="foto" accept="image/*"
                               class="hidden" id="inputFoto"
                               onchange="this.form.submit()" />

                        <button type="button"
                                onclick="document.getElementById('inputFoto').click()"
                                class="flex min-w-[84px] max-w-sm items-center justify-center rounded-full h-10 px-6 bg-primary/10 text-primary text-sm font-bold w-full">
                            Cambiar foto
                        </button>
                    </form>


                </section>
                <!-- Personal Information Section -->
                <section class="flex flex-col gap-2">
                    <h2 class="px-2 text-lg font-bold leading-tight tracking-[-0.015em] text-zinc-900 dark:text-white">Información Personal</h2>
                    <div class="flex flex-col overflow-hidden rounded-lg bg-white dark:bg-zinc-800/50">
                        <form method="post" action="configuracion.jsp" class="flex items-center justify-between gap-4 px-4 min-h-14">
                            <div class="flex items-center gap-4">
                                <div class="flex size-10 shrink-0 items-center justify-center rounded-lg bg-zinc-200 dark:bg-zinc-700">
                                    <span class="material-symbols-outlined text-zinc-900 dark:text-white text-2xl">person</span>
                                </div>
                                <input name="nombre" value="<%= nombrePerfil%>" class="form-input rounded bg-white dark:bg-zinc-800 border border-zinc-300 dark:border-zinc-700 text-zinc-900 dark:text-white h-10 px-3" placeholder="Nombre"/>
                                <input name="email" value="<%= emailPerfil%>" class="form-input rounded bg-white dark:bg-zinc-800 border border-zinc-300 dark:border-zinc-700 text-zinc-900 dark:text-white h-10 px-3" placeholder="Email"/>
                            </div>
                            <button type="submit" class="flex min-w-[64px] cursor-pointer items-center justify-center overflow-hidden rounded-full h-9 px-4 bg-primary text-white text-sm font-bold leading-normal">Guardar</button>
                        </form>
                    </div>
                </section>
                <!-- Preferences Section -->
                <section class="flex flex-col gap-2">
                    <h2 class="px-2 text-lg font-bold leading-tight tracking-[-0.015em] text-zinc-900 dark:text-white">Preferencias</h2>
                    <div class="flex flex-col overflow-hidden rounded-lg bg-white dark:bg-zinc-800/50">
                        <form method="post" action="configuracion.jsp" class="flex items-center justify-between gap-4 px-4 min-h-14">
                            <div class="flex items-center gap-4">
                                <div class="flex size-10 shrink-0 items-center justify-center rounded-lg bg-zinc-200 dark:bg-zinc-700">
                                    <span class="material-symbols-outlined text-zinc-900 dark:text-white text-2xl">notifications</span>
                                </div>
                                <p class="flex-1 truncate text-base font-normal leading-normal text-zinc-900 dark:text-white">Activar notificaciones</p>
                            </div>
                            <div class="shrink-0">
                                <input type="checkbox" name="notifications" <%= notifEnabled ? "checked" : ""%> />
                                <button type="submit" class="ml-2 flex min-w-[64px] cursor-pointer items-center justify-center overflow-hidden rounded-full h-9 px-4 bg-primary/20 text-primary text-sm font-bold leading-normal">Guardar</button>
                            </div>
                        </form>
                        <div class="h-px w-full bg-zinc-200 dark:bg-zinc-700/50"></div>
                        <form method="post" action="configuracion.jsp" class="flex items-center justify-between gap-4 px-4 min-h-14 hover:bg-zinc-100 dark:hover:bg-zinc-800">
                            <div class="flex items-center gap-4">
                                <div class="flex size-10 shrink-0 items-center justify-center rounded-lg bg-zinc-200 dark:bg-zinc-700">
                                    <span class="material-symbols-outlined text-zinc-900 dark:text-white text-2xl">paid</span>
                                </div>
                                <p class="flex-1 truncate text-base font-normal leading-normal text-zinc-900 dark:text-white">Moneda</p>
                            </div>
                            <div class="flex shrink-0 items-center gap-2">
                                <p class="text-base font-normal leading-normal text-zinc-500 dark:text-zinc-400"><%= monedaTexto%></p>
                                <select name="currency" class="form-select rounded bg-white dark:bg-zinc-800 border border-zinc-300 dark:border-zinc-700 text-zinc-900 dark:text-white h-9 px-2">
                                    <option value="COP" <%= "COP".equals(currCode) ? "selected" : ""%>>COP Colombia</option>
                                    <option value="USD" <%= "USD".equals(currCode) ? "selected" : ""%>>USD</option>
                                </select>
                                <button type="submit" class="flex min-w-[64px] cursor-pointer items-center justify-center overflow-hidden rounded-full h-9 px-4 bg-primary/20 text-primary text-sm font-bold leading-normal">Aplicar</button>
                            </div>
                        </form>
                        <div class="h-px w-full bg-zinc-200 dark:bg-zinc-700/50"></div>
                        <form method="post" action="configuracion.jsp" class="flex items-center justify-between gap-4 px-4 min-h-14">
                            <div class="flex items-center gap-4">
                                <div class="flex size-10 shrink-0 items-center justify-center rounded-lg bg-zinc-200 dark:bg-zinc-700">
                                    <span class="material-symbols-outlined text-zinc-900 dark:text-white text-2xl">dark_mode</span>
                                </div>
                                <p class="flex-1 truncate text-base font-normal leading-normal text-zinc-900 dark:text-white">Modo Oscuro</p>
                            </div>
                            <div class="shrink-0 flex items-center gap-2">
                                <select name="dark_mode" class="form-select rounded bg-white dark:bg-zinc-800 border border-zinc-300 dark:border-zinc-700 text-zinc-900 dark:text-white h-9 px-2">
                                    <option value="dark" <%= "dark".equals(currentTheme) ? "selected" : ""%>>Oscuro</option>
                                    <option value="light" <%= "light".equals(currentTheme) ? "selected" : ""%>>Claro</option>
                                </select>
                                <button type="submit" class="flex min-w-[64px] cursor-pointer items-center justify-center overflow-hidden rounded-full h-9 px-4 bg-primary/20 text-primary text-sm font-bold leading-normal">Aplicar</button>
                            </div>
                        </form>
                    </div>
                </section>
                <!-- Security Section -->
                <section class="flex flex-col gap-2">
                    <h2 class="px-2 text-lg font-bold leading-tight tracking-[-0.015em] text-zinc-900 dark:text-white">Seguridad</h2>
                    <div class="flex flex-col overflow-hidden rounded-lg bg-white dark:bg-zinc-800/50">
                        <form method="post" action="configuracion.jsp" class="flex items-center justify-between gap-4 px-4 min-h-14">
                            <div class="flex items-center gap-4">
                                <div class="flex size-10 shrink-0 items-center justify-center rounded-lg bg-zinc-200 dark:bg-zinc-700">
                                    <span class="material-symbols-outlined text-zinc-900 dark:text-white text-2xl">password</span>
                                </div>
                                <input name="new_password" type="password" class="form-input rounded bg-white dark:bg-zinc-800 border border-zinc-300 dark:border-zinc-700 text-zinc-900 dark:text-white h-10 px-3" placeholder="Nueva contraseña"/>
                            </div>
                            <button type="submit" class="flex min-w-[64px] cursor-pointer items-center justify-center overflow-hidden rounded-full h-9 px-4 bg-primary text-white text-sm font-bold leading-normal">Guardar</button>
                        </form>
                        <div class="h-px w-full bg-zinc-200 dark:bg-zinc-700/50"></div>
                        <form method="post" action="configuracion.jsp" class="flex items-center justify-between gap-4 px-4 min-h-14">
                            <div class="flex items-center gap-4">
                                <div class="flex size-10 shrink-0 items-center justify-center rounded-lg bg-zinc-200 dark:bg-zinc-700">
                                    <span class="material-symbols-outlined text-zinc-900 dark:text-white text-2xl">face</span>
                                </div>
                                <p class="flex-1 truncate text-base font-normal leading-normal text-zinc-900 dark:text-white">Activar Face ID</p>
                            </div>
                            <div class="shrink-0">
                                <input type="checkbox" name="face_id" <%= faceEnabled ? "checked" : ""%> />
                                <button type="submit" class="ml-2 flex min-w-[64px] cursor-pointer items-center justify-center overflow-hidden rounded-full h-9 px-4 bg-primary/20 text-primary text-sm font-bold leading-normal">Guardar</button>
                            </div>
                        </form>
                    </div>
                </section>
                <!-- Actions -->
                <section class="flex flex-col gap-4 pt-4">
                    <button class="flex min-w-[84px] cursor-pointer items-center justify-center overflow-hidden rounded-full h-12 px-6 bg-red-500/10 text-red-500 text-base font-bold leading-normal w-full">
                        <span class="truncate"><a href="../index.jsp">Cerrar Sesión</a></span>
                    </button>
                    <div class="flex flex-col items-center justify-center gap-1 pb-8">
                        <p class="text-sm font-normal text-zinc-500 dark:text-zinc-400">Ayuda y Soporte</p>
                        <p class="text-sm font-normal text-zinc-500 dark:text-zinc-400">Política de Privacidad</p>
                    </div>
                </section>
            </main>
        </div>
    </body></html>