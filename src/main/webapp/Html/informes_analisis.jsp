<!DOCTYPE html>

<html class="dark" lang="es"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Informes y Análisis Financiero</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&amp;display=swap" rel="stylesheet"/>
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
        <div class="relative flex h-auto min-h-screen w-full flex-col group/design-root overflow-x-hidden">
            <!-- Top App Bar -->
            <header class="flex items-center bg-background-light dark:bg-background-dark p-4 pb-2 justify-between sticky top-0 z-10">
                <div class="flex size-12 shrink-0 items-center justify-start">
                    <button class="flex items-center justify-center p-2 rounded-full hover:bg-white/10 active:bg-white/20">
                        <span class="material-symbols-outlined text-zinc-900 dark:text-white">arrow_back</span>
                    </button>
                </div>
                <h1 class="text-zinc-900 dark:text-white text-lg font-bold leading-tight tracking-[-0.015em] flex-1 text-center">Análisis</h1>
                <div class="flex w-12 items-center justify-end">
                    <button class="flex max-w-[480px] cursor-pointer items-center justify-center overflow-hidden rounded-full h-12 bg-transparent text-zinc-900 dark:text-white gap-2 text-base font-bold leading-normal tracking-[0.015em] min-w-0 p-0 hover:bg-white/10 active:bg-white/20">
                        <span class="material-symbols-outlined">add_card</span>
                    </button>
                </div>
            </header>
            <!-- Segmented Buttons for Time Range -->
            <div class="flex px-4 py-3">
                <div class="flex h-10 flex-1 items-center justify-center rounded-full bg-zinc-200 dark:bg-zinc-800 p-1">
                    <label class="flex cursor-pointer h-full grow items-center justify-center overflow-hidden rounded-full px-2 has-[:checked]:bg-background-light has-[:checked]:dark:bg-background-dark has-[:checked]:shadow-sm text-zinc-500 dark:text-zinc-400 has-[:checked]:text-zinc-900 has-[:checked]:dark:text-white text-sm font-medium leading-normal transition-colors">
                        <span class="truncate">Semana</span>
                        <input class="invisible w-0" name="time-range" type="radio" value="Semana"/>
                    </label>
                    <label class="flex cursor-pointer h-full grow items-center justify-center overflow-hidden rounded-full px-2 has-[:checked]:bg-background-light has-[:checked]:dark:bg-background-dark has-[:checked]:shadow-sm text-zinc-500 dark:text-zinc-400 has-[:checked]:text-zinc-900 has-[:checked]:dark:text-white text-sm font-medium leading-normal transition-colors">
                        <span class="truncate">Mes</span>
                        <input checked="" class="invisible w-0" name="time-range" type="radio" value="Mes"/>
                    </label>
                    <label class="flex cursor-pointer h-full grow items-center justify-center overflow-hidden rounded-full px-2 has-[:checked]:bg-background-light has-[:checked]:dark:bg-background-dark has-[:checked]:shadow-sm text-zinc-500 dark:text-zinc-400 has-[:checked]:text-zinc-900 has-[:checked]:dark:text-white text-sm font-medium leading-normal transition-colors">
                        <span class="truncate">Año</span>
                        <input class="invisible w-0" name="time-range" type="radio" value="Año"/>
                    </label>
                </div>
            </div>
            <!-- Key Metric Cards (KPIs) -->
            <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 p-4">
                <div class="flex flex-col gap-2 rounded-lg p-4 border border-zinc-200 dark:border-zinc-800 bg-white/50 dark:bg-black/20">
                    <p class="text-zinc-600 dark:text-zinc-400 text-sm font-medium leading-normal">Total Gastado</p>
                    <p class="text-zinc-900 dark:text-white tracking-tight text-2xl font-bold leading-tight">?450.75</p>
                </div>
                <div class="flex flex-col gap-2 rounded-lg p-4 border border-zinc-200 dark:border-zinc-800 bg-white/50 dark:bg-black/20">
                    <p class="text-zinc-600 dark:text-zinc-400 text-sm font-medium leading-normal">Total Ahorrado</p>
                    <p class="text-zinc-900 dark:text-white tracking-tight text-2xl font-bold leading-tight">?120.00</p>
                </div>
                <div class="flex col-span-1 sm:col-span-3 flex-col gap-2 rounded-lg p-4 border border-zinc-200 dark:border-zinc-800 bg-white/50 dark:bg-black/20">
                    <p class="text-zinc-600 dark:text-zinc-400 text-sm font-medium leading-normal">Ingresos</p>
                    <p class="text-zinc-900 dark:text-white tracking-tight text-2xl font-bold leading-tight">?800.00</p>
                </div>
            </div>
            <!-- Spending by Category (Donut Chart) -->
            <section class="px-4 py-2">
                <h3 class="text-zinc-900 dark:text-white text-lg font-bold leading-tight tracking-[-0.015em] pb-3">Gastos por Categoría</h3>
                <div class="rounded-lg p-6 border border-zinc-200 dark:border-zinc-800 bg-white/50 dark:bg-black/20">
                    <div class="relative mx-auto flex h-48 w-48 items-center justify-center">
                        <svg class="h-full w-full" viewbox="0 0 36 36">
                        <path class="stroke-zinc-200 dark:stroke-zinc-800" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831" fill="none" stroke-width="3"></path>
                        <path class="stroke-primary" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831" fill="none" stroke-dasharray="45, 100" stroke-width="3"></path>
                        <path class="stroke-emerald-500" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831" fill="none" stroke-dasharray="30, 100" stroke-dashoffset="-45" stroke-width="3"></path>
                        <path class="stroke-amber-500" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831" fill="none" stroke-dasharray="15, 100" stroke-dashoffset="-75" stroke-width="3"></path>
                        <path class="stroke-purple-500" d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831" fill="none" stroke-dasharray="10, 100" stroke-dashoffset="-90" stroke-width="3"></path>
                        </svg>
                        <div class="absolute flex flex-col items-center">
                            <p class="text-zinc-600 dark:text-zinc-400 text-sm font-normal">Gastos del mes</p>
                            <p class="text-zinc-900 dark:text-white text-2xl font-bold">?450.75</p>
                        </div>
                    </div>
                    <div class="mt-6 grid grid-cols-2 gap-x-6 gap-y-3 text-sm">
                        <div class="flex items-center gap-2"><div class="h-2 w-2 rounded-full bg-primary"></div><span class="text-zinc-900 dark:text-white">Comida</span></div>
                        <div class="flex items-center gap-2"><div class="h-2 w-2 rounded-full bg-emerald-500"></div><span class="text-zinc-900 dark:text-white">Transporte</span></div>
                        <div class="flex items-center gap-2"><div class="h-2 w-2 rounded-full bg-amber-500"></div><span class="text-zinc-900 dark:text-white">Suscripciones</span></div>
                        <div class="flex items-center gap-2"><div class="h-2 w-2 rounded-full bg-purple-500"></div><span class="text-zinc-900 dark:text-white">Ocio</span></div>
                    </div>
                </div>
            </section>
            <!-- Monthly Evolution Chart (Bar Chart) -->
            <section class="px-4 py-4">
                <div class="flex min-w-72 flex-1 flex-col gap-2">
                    <h3 class="text-zinc-900 dark:text-white text-lg font-bold leading-tight tracking-[-0.015em]">Evolución Mensual</h3>
                    <p class="text-zinc-900 dark:text-white tracking-tight text-[32px] font-bold leading-tight truncate">?349.25</p>
                    <div class="flex gap-1">
                        <p class="text-zinc-600 dark:text-zinc-400 text-sm font-normal leading-normal">Balance este mes</p>
                        <p class="text-emerald-500 text-sm font-medium leading-normal">+15% vs mes anterior</p>
                    </div>
                    <div class="grid min-h-[180px] grid-flow-col gap-4 grid-rows-[1fr_auto] items-end justify-items-center px-1 pt-4">
                        <div class="w-full flex flex-col items-center justify-end gap-1"><div class="bg-primary/30 w-full rounded" style="height: 45%;"></div><div class="bg-primary w-full rounded" style="height: 20%;"></div></div>
                        <p class="text-zinc-500 dark:text-zinc-400 text-[13px] font-medium leading-normal">Ene</p>
                        <div class="w-full flex flex-col items-center justify-end gap-1"><div class="bg-primary/30 w-full rounded" style="height: 50%;"></div><div class="bg-primary w-full rounded" style="height: 25%;"></div></div>
                        <p class="text-zinc-500 dark:text-zinc-400 text-[13px] font-medium leading-normal">Feb</p>
                        <div class="w-full flex flex-col items-center justify-end gap-1"><div class="bg-primary/30 w-full rounded" style="height: 60%;"></div><div class="bg-primary w-full rounded" style="height: 20%;"></div></div>
                        <p class="text-zinc-500 dark:text-zinc-400 text-[13px] font-medium leading-normal">Mar</p>
                        <div class="w-full flex flex-col items-center justify-end gap-1"><div class="bg-primary/30 w-full rounded" style="height: 40%;"></div><div class="bg-primary w-full rounded" style="height: 35%;"></div></div>
                        <p class="text-zinc-500 dark:text-zinc-400 text-[13px] font-medium leading-normal">Abr</p>
                        <div class="w-full flex flex-col items-center justify-end gap-1"><div class="bg-primary/30 w-full rounded" style="height: 70%;"></div><div class="bg-primary w-full rounded" style="height: 15%;"></div></div>
                        <p class="text-zinc-500 dark:text-zinc-400 text-[13px] font-medium leading-normal">May</p>
                        <div class="w-full flex flex-col items-center justify-end gap-1"><div class="bg-primary/30 w-full rounded" style="height: 80%;"></div><div class="bg-primary w-full rounded" style="height: 30%;"></div></div>
                        <p class="text-zinc-500 dark:text-zinc-400 text-[13px] font-medium leading-normal">Jun</p>
                    </div>
                    <div class="flex items-center gap-4 text-xs mt-2 pl-1">
                        <div class="flex items-center gap-1.5"><div class="w-2.5 h-2.5 rounded-sm bg-primary/30"></div><span class="text-zinc-600 dark:text-zinc-400">Ingresos</span></div>
                        <div class="flex items-center gap-1.5"><div class="w-2.5 h-2.5 rounded-sm bg-primary"></div><span class="text-zinc-600 dark:text-zinc-400">Gastos</span></div>
                    </div>
                </div>
            </section>
            <!-- Recent Transactions List -->
            <section class="px-4 py-4 pb-24">
                <h3 class="text-zinc-900 dark:text-white text-lg font-bold leading-tight tracking-[-0.015em] pb-3">Últimos Movimientos</h3>
                <div class="flex flex-col gap-2">
                    <div class="flex items-center gap-4 rounded-lg p-3 bg-white/50 dark:bg-black/20">
                        <div class="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-primary/20 text-primary">
                            <span class="material-symbols-outlined">shopping_cart</span>
                        </div>
                        <div class="flex-1">
                            <p class="font-semibold text-zinc-900 dark:text-white">Supermercado</p>
                            <p class="text-sm text-zinc-500 dark:text-zinc-400">Hoy</p>
                        </div>
                        <p class="font-semibold text-red-500">-?45.50</p>
                    </div>
                    <div class="flex items-center gap-4 rounded-lg p-3 bg-white/50 dark:bg-black/20">
                        <div class="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-emerald-500/20 text-emerald-500">
                            <span class="material-symbols-outlined">account_balance_wallet</span>
                        </div>
                        <div class="flex-1">
                            <p class="font-semibold text-zinc-900 dark:text-white">Beca Estudio</p>
                            <p class="text-sm text-zinc-500 dark:text-zinc-400">Ayer</p>
                        </div>
                        <p class="font-semibold text-emerald-500">+?300.00</p>
                    </div>
                    <div class="flex items-center gap-4 rounded-lg p-3 bg-white/50 dark:bg-black/20">
                        <div class="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-purple-500/20 text-purple-500">
                            <span class="material-symbols-outlined">subscriptions</span>
                        </div>
                        <div class="flex-1">
                            <p class="font-semibold text-zinc-900 dark:text-white">Suscripción Spotify</p>
                            <p class="text-sm text-zinc-500 dark:text-zinc-400">Hace 3 días</p>
                        </div>
                        <p class="font-semibold text-red-500">-?9.99</p>
                    </div>
                </div>
            </section>
            <!-- Floating Action Button (FAB) -->
            <div class="fixed bottom-6 right-6">
                <button class="flex h-14 w-14 items-center justify-center rounded-full bg-primary text-white shadow-lg hover:bg-primary/90 active:bg-primary/80">
                    <span class="material-symbols-outlined !text-3xl">add</span>
                </button>
            </div>
        </div>
    </body></html>