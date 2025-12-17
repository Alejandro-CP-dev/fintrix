<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="fintrix.dao.UsuarioDAO,fintrix.model.Usuario" %>
<!DOCTYPE html>
<html class="dark" lang="es"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Registro de Usuario</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200;300;400;500;600;700;800&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>
        <style>
            .material-symbols-outlined {
                font-variation-settings: 'FILL' 0,
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
                min-height: max(884px, 100 dvh);
            }
        </style>
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
            request.setCharacterEncoding("UTF-8");
            String mensaje = null;
            String tipo = null;
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String nombre = request.getParameter("nombre");
                String email = request.getParameter("email");
                String clave = request.getParameter("clave");
                String confirmar = request.getParameter("confirmar");
                if (nombre != null && !nombre.trim().isEmpty() &&
                    email != null && !email.trim().isEmpty() &&
                    clave != null && !clave.trim().isEmpty() &&
                    clave.equals(confirmar)) {
                    UsuarioDAO dao = new UsuarioDAO();
                    Usuario u = new Usuario();
                    u.setNombre(nombre);
                    u.setEmail(email);
                    u.setClave(clave);
                    boolean ok = dao.Insertar(u);
                    if (ok) {
                        response.sendRedirect("../index.jsp");
                        return;
                    } else {
                        mensaje = "Error al registrar el usuario";
                        tipo = "danger";
                    }
                } else {
                    mensaje = "Datos inválidos o contraseñas no coinciden";
                    tipo = "warning";
                }
            }
        %>
        <div class="relative flex h-auto min-h-screen w-full flex-col items-center bg-background-light dark:bg-background-dark group/design-root overflow-x-hidden p-4">
            <main class="flex w-full max-w-md flex-col items-center pt-8">
                <div class="flex items-center justify-center h-16 w-16 bg-primary rounded-lg mb-6">
                    <span class="material-symbols-outlined text-white text-4xl">
                        account_balance_wallet
                    </span>
                </div>
                <h1 class="text-slate-900 dark:text-white text-3xl font-bold tracking-tight text-center pb-8">Crea tu cuenta</h1>
                <% if (mensaje != null) { %>
                <p class="text-center text-sm <%="danger".equals(tipo) ? "text-red-500" : "text-yellow-500"%>"><%= mensaje %></p>
                <% } %>
                <form class="w-full space-y-4" method="post" action="registro_usuario.jsp">
                    <div class="flex max-w-full flex-wrap items-end">
                        <label class="flex flex-col min-w-40 flex-1">
                            <p class="text-slate-600 dark:text-slate-300 text-base font-medium leading-normal pb-2">Nombre Completo</p>
                            <input name="nombre" required class="form-input flex w-full min-w-0 flex-1 resize-none overflow-hidden rounded text-slate-900 dark:text-white focus:outline-0 focus:ring-0 border border-slate-300 dark:border-slate-700 bg-background-light dark:bg-background-dark focus:border-primary h-14 placeholder:text-slate-400 dark:placeholder:text-slate-500 p-4 text-base font-normal leading-normal" placeholder="Ingresa tu nombre completo" value=""/>
                        </label>
                    </div>
                    <div class="flex max-w-full flex-wrap items-end">
                        <label class="flex flex-col min-w-40 flex-1">
                            <p class="text-slate-600 dark:text-slate-300 text-base font-medium leading-normal pb-2">Correo Electrónico</p>
                            <input name="email" required class="form-input flex w-full min-w-0 flex-1 resize-none overflow-hidden rounded text-slate-900 dark:text-white focus:outline-0 focus:ring-0 border border-slate-300 dark:border-slate-700 bg-background-light dark:bg-background-dark focus:border-primary h-14 placeholder:text-slate-400 dark:placeholder:text-slate-500 p-4 text-base font-normal leading-normal" placeholder="Ingresa tu correo electrónico" type="email" value=""/>
                        </label>
                    </div>
                    <div class="flex max-w-full flex-wrap items-end">
                        <label class="flex flex-col min-w-40 flex-1">
                            <p class="text-slate-600 dark:text-slate-300 text-base font-medium leading-normal pb-2">Contraseña</p>
                            <div class="flex w-full flex-1 items-stretch rounded">
                                <input name="clave" required class="form-input flex w-full min-w-0 flex-1 resize-none overflow-hidden rounded-l text-slate-900 dark:text-white focus:outline-0 focus:ring-0 border border-slate-300 dark:border-slate-700 bg-background-light dark:bg-background-dark focus:border-primary h-14 placeholder:text-slate-400 dark:placeholder:text-slate-500 p-4 border-r-0 pr-2 text-base font-normal leading-normal" placeholder="Crea una contraseña" type="password" value=""/>
                                <button class="text-slate-400 dark:text-slate-500 flex border border-slate-300 dark:border-slate-700 bg-background-light dark:bg-background-dark items-center justify-center px-4 rounded-r border-l-0" type="button">
                                    <span class="material-symbols-outlined">visibility_off</span>
                                </button>
                            </div>
                        </label>
                    </div>
                    <div class="flex max-w-full flex-wrap items-end">
                        <label class="flex flex-col min-w-40 flex-1">
                            <p class="text-slate-600 dark:text-slate-300 text-base font-medium leading-normal pb-2">Confirmar Contraseña</p>
                            <div class="flex w-full flex-1 items-stretch rounded">
                                <input name="confirmar" required class="form-input flex w-full min-w-0 flex-1 resize-none overflow-hidden rounded-l text-slate-900 dark:text-white focus:outline-0 focus:ring-0 border border-slate-300 dark:border-slate-700 bg-background-light dark:bg-background-dark focus:border-primary h-14 placeholder:text-slate-400 dark:placeholder:text-slate-500 p-4 border-r-0 pr-2 text-base font-normal leading-normal" placeholder="Confirma tu contraseña" type="password" value=""/>
                                <button class="text-slate-400 dark:text-slate-500 flex border border-slate-300 dark:border-slate-700 bg-background-light dark:bg-background-dark items-center justify-center px-4 rounded-r border-l-0" type="button">
                                    <span class="material-symbols-outlined">visibility_off</span>
                                </button>
                            </div>
                        </label>
                    </div>
                    <div class="pt-6 pb-4 w-full">
                        <button type="submit" class="flex w-full items-center justify-center rounded bg-primary h-14 text-white text-base font-bold leading-normal">Registrarse</button>
                    </div>
                </form>
                <div class="text-center">
                    <p class="text-slate-600 dark:text-slate-400 text-sm">
                        ¿Ya tienes una cuenta? <a class="font-bold text-primary hover:underline" href="../index.jsp">Iniciar sesión</a>
                    </p>
                </div>
            </main>
        </div>
    </body></html>
