<!DOCTYPE html>
<html class="dark" lang="es">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Inicio de Sesion</title>

        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>

        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200;300;400;500;600;700;800&display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>

        <script>
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            primary: "#137fec",
                            "background-light": "#f6f7f8",
                            "background-dark": "#101922",
                        },
                        fontFamily: {
                            display: ["Manrope", "sans-serif"]
                        },
                        borderRadius: {
                            DEFAULT: "1rem",
                            lg: "2rem",
                            xl: "3rem",
                            full: "9999px"
                        },
                    },
                },
            }
        </script>

        <style>
            body {
                min-height: max(884px, 100dvh);
            }
            .material-symbols-outlined {
                font-size: 24px;
            }
        </style>
    </head>

    <body class="bg-background-light dark:bg-background-dark font-display">
        <div class="relative flex min-h-screen w-full flex-col items-center justify-center p-4">

            <div class="w-full max-w-sm text-center">
                <!-- Logo -->
                <div class="mb-8 flex h-20 w-20 mx-auto items-center justify-center rounded-xl bg-primary/20">
                    <span class="material-symbols-outlined text-primary text-5xl">
                        account_balance_wallet
                    </span>
                </div>

                <h1 class="text-3xl font-bold text-slate-900 dark:text-white">
                    FINTRIX
                </h1>
                <p class="mt-2 text-slate-600 dark:text-slate-400">
                    Inicia sesión o regístrate para continuar
                </p>

                <!-- FORMULARIO -->
                <form action="/Fintrix/Html/Login.jsp" method="post">



                    <!-- Email -->
                    <div class="text-left">
                        <label class="text-sm font-medium text-slate-800 dark:text-slate-200">
                            Correo Electronico
                        </label>
                        <div class="relative mt-1">
                            <span class="material-symbols-outlined absolute left-4 top-3 text-slate-500">
                                mail
                            </span>
                            <input
                                type="email" name="email"
                                required
                                placeholder="tu@email.com"
                                class="form-input w-full h-12 pl-12 pr-4 rounded-lg bg-white dark:bg-slate-800
                                border-slate-300 dark:border-slate-700
                                text-slate-900 dark:text-white
                                focus:ring-2 focus:ring-primary/20 focus:border-primary">
                        </div>
                    </div>

                    <!-- Password -->
                    <div class="text-left">
                        <label class="text-sm font-medium text-slate-800 dark:text-slate-200">
                            Contraseña
                        </label>
                        <div class="relative mt-1">
                            <span class="material-symbols-outlined absolute left-4 top-3 text-slate-500">
                                lock
                            </span>
                            <input
                                type="password" name="clave"
                                required
                                placeholder="Ingresa tu contraseña"
                                class="form-input w-full h-12 pl-12 pr-4 rounded-lg bg-white dark:bg-slate-800
                                border-slate-300 dark:border-slate-700
                                text-slate-900 dark:text-white
                                focus:ring-2 focus:ring-primary/20 focus:border-primary">
                        </div>
                    </div>

                    <!-- Forgot -->
                    <div class="text-right">
                        <a href="#" class="text-sm text-primary font-medium hover:underline">
                            .
                        </a>
                    </div>

                    <!-- BotÃ³n -->
                    <button type="submit" class="flex h-12 w-full items-center justify-center rounded-lg bg-primary text-white text-base font-semibold leading-normal transition-colors hover:bg-primary/90">
                        Iniciar Sesion
                    </button>

                    <div class="flex items-center gap-3">
                        <div class="h-px w-full bg-slate-300 dark:bg-slate-700"></div>
                        <span class="text-sm text-slate-500">o</span>
                        <div class="h-px w-full bg-slate-300 dark:bg-slate-700"></div>
                    </div>

                    <button
                        type="button"
                        id="google-login"
                        class="flex h-12 w-full items-center justify-center gap-3 rounded-lg border border-slate-300 dark:border-slate-700 bg-white dark:bg-slate-800 text-slate-700 dark:text-slate-200 font-semibold hover:bg-slate-50 dark:hover:bg-slate-700 transition"
                        onclick="onSignIn(googleUser)">
                        <img src="https://developers.google.com/identity/images/g-logo.png" alt="Google" class="h-5 w-5">
                        Continuar con Google
                    </button>

                </form>

                <!-- Registro -->
                <p class="mt-8 text-sm text-slate-600 dark:text-slate-400">
                    ¿No tienes cuenta?
                    <a href="Html/registro_usuario.jsp" class="text-primary font-semibold hover:underline">
                        Regí­strate
                    </a>
                </p>
            </div>

        </div>
        <script>
            document.getElementById("google-login").addEventListener("click", function () {

                const clientId =
                        "98988323402-69becp4ocs53usgf56oqbea1i6ig5jbc.apps.googleusercontent.com";

                const redirectUri =
                        "http://localhost:8080/Fintrix/google-callback";

                const scope = "email profile";

                const googleAuthUrl =
                        "https://accounts.google.com/o/oauth2/v2/auth" +
                        "?response_type=code" +
                        "&client_id=" + encodeURIComponent(clientId) +
                        "&redirect_uri=" + encodeURIComponent(redirectUri) +
                        "&scope=" + encodeURIComponent(scope) +
                        "&prompt=select_account";


                window.location.href = googleAuthUrl;
            });
        </script>
    </body>
</html>
