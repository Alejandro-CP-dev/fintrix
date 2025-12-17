<!DOCTYPE html>

<html class="dark" lang="es"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Establecer Objetivos de Ahorro</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&amp;display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
        <style>
            .material-symbols-outlined {
                font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            }
        </style>
        <script>
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
        <div class="relative flex h-auto min-h-screen w-full flex-col overflow-x-hidden">
            <!-- Top App Bar -->
            <div class="flex items-center bg-background-light dark:bg-background-dark p-4 pb-2 justify-between sticky top-0 z-10">
                <div class="flex size-12 shrink-0 items-center">
                    <span class="material-symbols-outlined text-gray-800 dark:text-white" style="font-size: 24px;">arrow_back_ios_new</span>
                </div>
                <h2 class="text-gray-900 dark:text-white text-lg font-bold leading-tight tracking-[-0.015em] flex-1 text-center">Objetivos de Ahorro</h2>
                <div class="flex w-12 items-center justify-end">
                    <p class="text-primary text-base font-bold leading-normal tracking-[0.015em] shrink-0">Editar</p>
                </div>
            </div>
            <!-- Main Content Area -->
            <main class="flex-grow px-4">
                <!-- Create New Goal Button -->
                <div class="py-5">
                    <button class="flex min-w-[84px] max-w-[480px] cursor-pointer items-center justify-center overflow-hidden rounded-full h-12 px-5 flex-1 bg-primary text-white gap-2 w-full text-base font-bold leading-normal tracking-[0.015em]">
                        <span class="material-symbols-outlined text-white" style="font-size: 24px;">add</span>
                        <span class="truncate">Crear Nuevo Objetivo</span>
                    </button>
                </div>
                <!-- In Progress Section Header -->
                <h2 class="text-gray-900 dark:text-white text-[22px] font-bold leading-tight tracking-[-0.015em] pb-3 pt-5">En Progreso</h2>
                <!-- Goal Card 1: New Laptop -->
                <div class="pb-4 @container">
                    <div class="flex flex-col items-stretch justify-start rounded-xl shadow-[0_0_4px_rgba(0,0,0,0.1)] bg-white dark:bg-[#1C1E22]">
                        <div class="w-full bg-center bg-no-repeat aspect-video bg-cover rounded-t-xl" data-alt="Gradient background with shades of blue and purple for a tech feel" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuDPRi2dAKIrUIU2po50mEv2X-PIpKljB0HTicvmS9GPBi7QWi9CbKdjXfsMvNvHwv4rW8301M7YQPzZghLdKo0g-rJUaJlkeU0ligE3qkws1OYkn2WQ7kPUWJOy89mHBl-Gxw__5i8BTi0hJdPXTPY-j3ZJbPNYsVzYnbh0x9e4S84S8TSL3RwxgtiN1xDx1xjeinU6wNM1oT6XMBS0p5GAYm6-8VdZjPS0wl8xtNDrtJE4GsXpOSDOdelG1JseVix0swlv48F53-z9");'></div>
                        <div class="flex w-full min-w-72 grow flex-col items-stretch justify-center gap-1 p-4">
                            <p class="text-gray-900 dark:text-white text-lg font-bold leading-tight tracking-[-0.015em]">Nuevo Portátil</p>
                            <div class="flex flex-col gap-3 pt-2">
                                <div class="flex items-center justify-between text-sm text-gray-600 dark:text-[#9dabb9]">
                                    <p>$500 / $1,200</p>
                                    <p>Faltan 90 días</p>
                                </div>
                                <div class="rounded-full bg-gray-200 dark:bg-[#3b4754]">
                                    <div class="h-2 rounded-full bg-primary" style="width: 41%;"></div>
                                </div>
                            </div>
                            <div class="flex items-end justify-between pt-4">
                                <p class="text-primary text-base font-medium leading-normal">41% completado</p>
                                <button class="flex min-w-[84px] max-w-[480px] cursor-pointer items-center justify-center overflow-hidden rounded-full h-8 px-4 bg-primary/20 text-primary text-sm font-bold leading-normal">
                                    <span class="truncate">Añadir Ahorro</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Goal Card 2: Summer Trip -->
                <div class="pb-4 @container">
                    <div class="flex flex-col items-stretch justify-start rounded-xl shadow-[0_0_4px_rgba(0,0,0,0.1)] bg-white dark:bg-[#1C1E22]">
                        <div class="w-full bg-center bg-no-repeat aspect-video bg-cover rounded-t-xl" data-alt="Vibrant tropical beach scene" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuCySUTLX4YEY4aDMxiIXZjBUCaSp-daU9kTTUBvGvPNYXhAjI3sT3w9ZyHXNqM_fA9Bqu9jjuAYqKdwO4Z9WAv5Cg09Ha-u1cH63W5OI70JCH7G054oTOYuHgmO-KhFwv96hH8ipL7BgpRafcZzaOz4SHnaO3Lsgyq4QKMmCmJXaRC68GavM0W84dKd-OdaKrB8CM7dKyQsYoTJ7nYUedo78s0IZLgplscIKnaXQN-hemDomguT9bKyx1h9Rx4d86ik-R5DkEkNmQYO");'></div>
                        <div class="flex w-full min-w-72 grow flex-col items-stretch justify-center gap-1 p-4">
                            <p class="text-gray-900 dark:text-white text-lg font-bold leading-tight tracking-[-0.015em]">Viaje de Verano</p>
                            <div class="flex flex-col gap-3 pt-2">
                                <div class="flex items-center justify-between text-sm text-gray-600 dark:text-[#9dabb9]">
                                    <p>$1,125 / $1,500</p>
                                    <p>Faltan 30 días</p>
                                </div>
                                <div class="rounded-full bg-gray-200 dark:bg-[#3b4754]">
                                    <div class="h-2 rounded-full bg-primary" style="width: 75%;"></div>
                                </div>
                            </div>
                            <div class="flex items-end justify-between pt-4">
                                <p class="text-primary text-base font-medium leading-normal">75% completado</p>
                                <button class="flex min-w-[84px] max-w-[480px] cursor-pointer items-center justify-center overflow-hidden rounded-full h-8 px-4 bg-primary/20 text-primary text-sm font-bold leading-normal">
                                    <span class="truncate">Añadir Ahorro</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Completed Goals Section Header -->
                <h2 class="text-gray-900 dark:text-white text-[22px] font-bold leading-tight tracking-[-0.015em] pb-3 pt-5">Completados</h2>
                <!-- Completed Goal Card -->
                <div class="pb-8 @container">
                    <div class="flex flex-col items-stretch justify-start rounded-xl shadow-[0_0_4px_rgba(0,0,0,0.1)] bg-white dark:bg-[#1C1E22] opacity-70">
                        <div class="relative w-full bg-center bg-no-repeat aspect-video bg-cover rounded-t-xl" data-alt="A person holding a new video game controller" style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuBI6rkqDQTKpcXw7F2LfS_nZP-ZDT82PIoBOdXXMkQSY1wQO3hE7PPbnoXlJVDqXJC4RwXU_iuJkm555eaZ5VAJoEGgVzQkDeFUATo4LstqPyHBT6gpmL87BhltCZ1h_Jf36q5I2KDriT2qUsEDGpbZnt9i0AqryKhm3vPBJnKiWVT1vyCdBkDqkrysJ101x7kEuwU_uEMfj0Ev3x1XvnMsUxSO9sA6ZKl6qENFugM0Tq0NTe5IITij404KDcmvFS9xNbwZ-BcrgC42");'>
                            <div class="absolute inset-0 bg-black/50 rounded-t-xl flex items-center justify-center">
                                <span class="material-symbols-outlined text-white" style="font-size: 48px;">check_circle</span>
                            </div>
                        </div>
                        <div class="flex w-full min-w-72 grow flex-col items-stretch justify-center gap-1 p-4">
                            <p class="text-gray-900 dark:text-white text-lg font-bold leading-tight tracking-[-0.015em]">Nueva Consola</p>
                            <div class="flex items-end gap-3 justify-between">
                                <div class="flex flex-col gap-1">
                                    <p class="text-gray-600 dark:text-[#9dabb9] text-base font-normal leading-normal">Completado el 15/05</p>
                                    <p class="text-gray-600 dark:text-[#9dabb9] text-base font-normal leading-normal">$600 / $600</p>
                                </div>
                                <div class="flex min-w-[84px] max-w-[480px] cursor-default items-center justify-center overflow-hidden rounded-full h-8 px-4 bg-gray-200 dark:bg-[#3b4754] text-gray-500 dark:text-gray-400 text-sm font-medium leading-normal">
                                    <span class="truncate">Logrado</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </body></html>