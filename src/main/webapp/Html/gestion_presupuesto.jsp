<!DOCTYPE html>

<html class="dark" lang="es"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Gestión de Presupuestos</title>
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
        <div class="relative mx-auto flex h-auto min-h-screen w-full max-w-md flex-col overflow-x-hidden">
            <!-- TopAppBar -->
            <header class="flex items-center p-4 pb-2">
                <div class="flex size-12 shrink-0 items-center justify-start">
                    <span class="material-symbols-outlined text-gray-500 dark:text-gray-400 text-3xl">account_balance_wallet</span>
                </div>
                <h1 class="flex-1 text-center text-lg font-bold leading-tight tracking-[-0.015em] text-gray-900 dark:text-white">Mis Presupuestos</h1>
                <div class="flex w-12 items-center justify-end">
                    <button class="flex h-12 cursor-pointer items-center justify-center overflow-hidden rounded-full bg-transparent text-gray-500 dark:text-gray-400">
                        <span class="material-symbols-outlined text-2xl">settings</span>
                    </button>
                </div>
            </header>
            <!-- Stats -->
            <section class="flex flex-col gap-4 p-4">
                <div class="flex flex-col gap-4 rounded-lg bg-white p-6 shadow-sm dark:bg-gray-800/50">
                    <div class="flex justify-between items-baseline">
                        <p class="text-base font-medium text-gray-500 dark:text-gray-400">Restante</p>
                        <p class="text-sm font-medium text-gray-500 dark:text-gray-400">Presupuesto: $800.00</p>
                    </div>
                    <p class="text-3xl font-bold leading-tight tracking-tight text-gray-900 dark:text-white">$350.00</p>
                    <div class="w-full overflow-hidden rounded-full bg-gray-200 dark:bg-gray-700">
                        <div class="h-2 rounded-full bg-primary" style="width: 56.25%;"></div>
                    </div>
                    <p class="text-right text-sm font-medium text-gray-500 dark:text-gray-400">$450.00 gastados</p>
                </div>
            </section>
            <!-- SegmentedButtons -->
            <div class="flex px-4 py-3">
                <div class="flex h-10 flex-1 items-center justify-center rounded-full bg-gray-200 p-1 dark:bg-gray-800/50">
                    <label class="flex h-full grow cursor-pointer items-center justify-center overflow-hidden rounded-full px-2 text-sm font-medium leading-normal text-gray-500 has-[:checked]:bg-white has-[:checked]:text-gray-900 has-[:checked]:shadow-sm dark:text-gray-400 dark:has-[:checked]:bg-gray-700 dark:has-[:checked]:text-white">
                        <span class="truncate">Mensual</span>
                        <input checked="" class="invisible w-0" name="timeframe" type="radio" value="Mensual"/>
                    </label>
                    <label class="flex h-full grow cursor-pointer items-center justify-center overflow-hidden rounded-full px-2 text-sm font-medium leading-normal text-gray-500 has-[:checked]:bg-white has-[:checked]:text-gray-900 has-[:checked]:shadow-sm dark:text-gray-400 dark:has-[:checked]:bg-gray-700 dark:has-[:checked]:text-white">
                        <span class="truncate">Semanal</span>
                        <input class="invisible w-0" name="timeframe" type="radio" value="Semanal"/>
                    </label>
                </div>
            </div>
            <!-- SectionHeader -->
            <h3 class="px-4 pb-2 pt-4 text-lg font-bold leading-tight tracking-[-0.015em] text-gray-900 dark:text-white">Categorías</h3>
            <!-- ListItem -->
            <div class="flex flex-col gap-3 px-4 pb-28">
                <div class="flex items-center gap-4 rounded-lg bg-white p-3 shadow-sm dark:bg-gray-800/50">
                    <div class="flex size-12 shrink-0 items-center justify-center rounded-full bg-primary/10 text-primary">
                        <span class="material-symbols-outlined">restaurant</span>
                    </div>
                    <div class="flex-1">
                        <div class="flex items-center justify-between">
                            <p class="text-base font-medium leading-normal text-gray-900 dark:text-white">Alimentos</p>
                            <p class="text-sm font-medium text-gray-900 dark:text-white">$150 / $200</p>
                        </div>
                        <div class="mt-2 w-full overflow-hidden rounded-full bg-gray-200 dark:bg-gray-700">
                            <div class="h-1.5 rounded-full bg-green-500" style="width: 75%;"></div>
                        </div>
                    </div>
                    <span class="material-symbols-outlined text-gray-400">chevron_right</span>
                </div>
                <div class="flex items-center gap-4 rounded-lg bg-white p-3 shadow-sm dark:bg-gray-800/50">
                    <div class="flex size-12 shrink-0 items-center justify-center rounded-full bg-primary/10 text-primary">
                        <span class="material-symbols-outlined">directions_bus</span>
                    </div>
                    <div class="flex-1">
                        <div class="flex items-center justify-between">
                            <p class="text-base font-medium leading-normal text-gray-900 dark:text-white">Transporte</p>
                            <p class="text-sm font-medium text-gray-900 dark:text-white">$80 / $100</p>
                        </div>
                        <div class="mt-2 w-full overflow-hidden rounded-full bg-gray-200 dark:bg-gray-700">
                            <div class="h-1.5 rounded-full bg-orange-500" style="width: 80%;"></div>
                        </div>
                    </div>
                    <span class="material-symbols-outlined text-gray-400">chevron_right</span>
                </div>
                <div class="flex items-center gap-4 rounded-lg bg-white p-3 shadow-sm dark:bg-gray-800/50">
                    <div class="flex size-12 shrink-0 items-center justify-center rounded-full bg-primary/10 text-primary">
                        <span class="material-symbols-outlined">theaters</span>
                    </div>
                    <div class="flex-1">
                        <div class="flex items-center justify-between">
                            <p class="text-base font-medium leading-normal text-gray-900 dark:text-white">Entretenimiento</p>
                            <p class="text-sm font-medium text-gray-900 dark:text-white">$150 / $150</p>
                        </div>
                        <div class="mt-2 w-full overflow-hidden rounded-full bg-gray-200 dark:bg-gray-700">
                            <div class="h-1.5 rounded-full bg-red-500" style="width: 100%;"></div>
                        </div>
                    </div>
                    <span class="material-symbols-outlined text-gray-400">chevron_right</span>
                </div>
                <div class="flex items-center gap-4 rounded-lg bg-white p-3 shadow-sm dark:bg-gray-800/50">
                    <div class="flex size-12 shrink-0 items-center justify-center rounded-full bg-primary/10 text-primary">
                        <span class="material-symbols-outlined">shopping_bag</span>
                    </div>
                    <div class="flex-1">
                        <div class="flex items-center justify-between">
                            <p class="text-base font-medium leading-normal text-gray-900 dark:text-white">Compras</p>
                            <p class="text-sm font-medium text-gray-900 dark:text-white">$70 / $200</p>
                        </div>
                        <div class="mt-2 w-full overflow-hidden rounded-full bg-gray-200 dark:bg-gray-700">
                            <div class="h-1.5 rounded-full bg-green-500" style="width: 35%;"></div>
                        </div>
                    </div>
                    <span class="material-symbols-outlined text-gray-400">chevron_right</span>
                </div>
                <div class="flex items-center gap-4 rounded-lg bg-white p-3 shadow-sm dark:bg-gray-800/50">
                    <div class="flex size-12 shrink-0 items-center justify-center rounded-full bg-primary/10 text-primary">
                        <span class="material-symbols-outlined">school</span>
                    </div>
                    <div class="flex-1">
                        <div class="flex items-center justify-between">
                            <p class="text-base font-medium leading-normal text-gray-900 dark:text-white">Educación</p>
                            <p class="text-sm font-medium text-gray-900 dark:text-white">$0 / $150</p>
                        </div>
                        <div class="mt-2 w-full overflow-hidden rounded-full bg-gray-200 dark:bg-gray-700">
                            <div class="h-1.5 rounded-full bg-green-500" style="width: 0%;"></div>
                        </div>
                    </div>
                    <span class="material-symbols-outlined text-gray-400">chevron_right</span>
                </div>
            </div>
            <!-- Floating Action Button -->
            <div class="fixed bottom-6 right-6" style="right: calc(50% - 200px + 24px); transform: translateX(50%);">
                <button class="flex h-16 w-16 items-center justify-center rounded-full bg-primary text-white shadow-lg">
                    <span class="material-symbols-outlined text-4xl">add</span>
                </button>
            </div>
        </div>
    </body></html>