<!DOCTYPE html>
<html class="dark" lang="es"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Notificaciones</title>
        <link href="https://fonts.googleapis.com" rel="preconnect"/>
        <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>
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
                        borderRadius: {
                            "DEFAULT": "1rem",
                            "lg": "1.5rem",
                            "xl": "2rem",
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
        <div class="relative flex h-auto min-h-screen w-full flex-col overflow-x-hidden">
            <div class="flex flex-1 flex-col pb-24">
                <div class="flex items-center justify-between bg-background-light dark:bg-background-dark p-4 pb-2 sticky top-0 z-10">
                    <div class="flex size-12 shrink-0 items-center justify-start">
                        <button class="flex h-10 w-10 items-center justify-center rounded-full text-slate-800 dark:text-white">
                            <span class="material-symbols-outlined text-2xl"><a href="PControl_Finanzas.jsp">arrow_back</a></span>
                        </button>
                    </div>
                    <h2 class="flex-1 text-center text-lg font-bold leading-tight tracking-[-0.015em] text-slate-900 dark:text-white">Notificaciones</h2>
                </div>
                <div class="flex flex-col gap-4 p-4">
                    <div>
                        <h3 class="px-4 pb-2 text-sm font-bold text-slate-500 dark:text-slate-400">Nuevas</h3>
                        <div class="flex flex-col gap-3">
                            <div class="flex items-start gap-4 rounded-lg bg-white dark:bg-slate-800/50 p-4 shadow-sm">
                                <div class="mt-1 flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-red-500/20 text-red-500">
                                    <span class="material-symbols-outlined">warning</span>
                                </div>
                                <div class="flex-1">
                                    <p class="font-bold text-slate-800 dark:text-white">Alerta de presupuesto excedido</p>
                                    <p class="text-sm text-slate-600 dark:text-slate-300">Has superado tu presupuesto de "Ocio" para este mes.</p>
                                    <p class="pt-1 text-xs text-slate-500 dark:text-slate-400">Hace 5 minutos</p>
                                </div>
                                <span class="mt-1 h-2.5 w-2.5 shrink-0 rounded-full bg-primary"></span>
                            </div>
                            <div class="flex items-start gap-4 rounded-lg bg-white dark:bg-slate-800/50 p-4 shadow-sm">
                                <div class="mt-1 flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-blue-500/20 text-blue-500">
                                    <span class="material-symbols-outlined">receipt</span>
                                </div>
                                <div class="flex-1">
                                    <p class="font-bold text-slate-800 dark:text-white">Recordatorio de pago de factura</p>
                                    <p class="text-sm text-slate-600 dark:text-slate-300">Tu factura de internet vence ma�ana.</p>
                                    <p class="pt-1 text-xs text-slate-500 dark:text-slate-400">Hace 2 horas</p>
                                </div>
                                <span class="mt-1 h-2.5 w-2.5 shrink-0 rounded-full bg-primary"></span>
                            </div>
                        </div>
                    </div>
                    <div>
                        <h3 class="px-4 pb-2 text-sm font-bold text-slate-500 dark:text-slate-400">Anteriores</h3>
                        <div class="flex flex-col gap-3">
                            <div class="flex items-start gap-4 rounded-lg bg-white/50 dark:bg-slate-800/30 p-4">
                                <div class="mt-1 flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-green-500/20 text-green-500">
                                    <span class="material-symbols-outlined">check_circle</span>
                                </div>
                                <div class="flex-1">
                                    <p class="font-medium text-slate-700 dark:text-slate-200">Transacci�n confirmada</p>
                                    <p class="text-sm text-slate-500 dark:text-slate-400">Tu pago de $45.00 a la librer�a ha sido exitoso.</p>
                                    <p class="pt-1 text-xs text-slate-500 dark:text-slate-400">Ayer</p>
                                </div>
                            </div>
                            <div class="flex items-start gap-4 rounded-lg bg-white/50 dark:bg-slate-800/30 p-4">
                                <div class="mt-1 flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-purple-500/20 text-purple-500">
                                    <span class="material-symbols-outlined">savings</span>
                                </div>
                                <div class="flex-1">
                                    <p class="font-medium text-slate-700 dark:text-slate-200">Objetivo de ahorro alcanzado</p>
                                    <p class="text-sm text-slate-500 dark:text-slate-400">�Felicidades! Has alcanzado tu objetivo de "Ahorro para Viaje".</p>
                                    <p class="pt-1 text-xs text-slate-500 dark:text-slate-400">Hace 3 d�as</p>
                                </div>
                            </div>
                            <div class="flex items-start gap-4 rounded-lg bg-white/50 dark:bg-slate-800/30 p-4">
                                <div class="mt-1 flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-green-500/20 text-green-500">
                                    <span class="material-symbols-outlined">payments</span>
                                </div>
                                <div class="flex-1">
                                    <p class="font-medium text-slate-700 dark:text-slate-200">Ingreso recibido</p>
                                    <p class="text-sm text-slate-500 dark:text-slate-400">Has recibido $500.00 de tu Beca Mensual.</p>
                                    <p class="pt-1 text-xs text-slate-500 dark:text-slate-400">1 de Mar, 2024</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="fixed bottom-0 left-0 right-0 h-20 border-t border-slate-200 bg-white/80 backdrop-blur-lg dark:border-slate-800 dark:bg-background-dark/80">
                <div class="mx-auto flex h-full max-w-lg items-center justify-around">
                    <button class="flex w-16 flex-col items-center justify-center text-slate-400 dark:text-slate-500">
                        <span class="material-symbols-outlined text-3xl">dashboard</span>
                        <span class="text-xs font-bold">Resumen</span>
                    </button>
                    <button class="flex w-16 flex-col items-center justify-center text-slate-400 dark:text-slate-500">
                        <span class="material-symbols-outlined text-3xl">receipt_long</span>
                        <span class="text-xs font-bold">Movimientos</span>
                    </button>
                    <button class="flex w-16 flex-col items-center justify-center text-slate-400 dark:text-slate-500">
                        <span class="material-symbols-outlined text-3xl">pie_chart</span>
                        <span class="text-xs font-bold">An�lisis</span>
                    </button>
                    <button class="flex w-16 flex-col items-center justify-center text-slate-400 dark:text-slate-500">
                        <span class="material-symbols-outlined text-3xl">account_balance_wallet</span>
                        <span class="text-xs font-bold">Cuentas</span>
                    </button>
                </div>
            </div>
        </div>

    </body></html>
