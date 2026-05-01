# ==================================================================================
# BUILD CON RINNO - QuantumLLAMA ETF Pro v6.0
# ==================================================================================
# RInno es compatible con R 4.5 y crea instaladores de Windows

cat("\n")
cat("═══════════════════════════════════════════════════════════\n")
cat("  BUILD CON RINNO - QuantumLLAMA ETF Pro v6.0\n")
cat("═══════════════════════════════════════════════════════════\n\n")

# ==================== INSTALAR DEPENDENCIAS =====================================

cat("1. Instalando RInno y dependencias...\n")

# Instalar RInno
if (!require("RInno", quietly = TRUE)) {
    cat("   Instalando RInno...\n")
    install.packages("RInno", repos = "https://cloud.r-project.org")
}

library(RInno)

# Instalar Inno Setup (necesario para crear instaladores de Windows)
cat("   Verificando Inno Setup...\n")
if (!RInno::check_inno_install()) {
    cat("   Instalando Inno Setup...\n")
    RInno::install_inno()
}

cat("   ✓ RInno configurado\n\n")

# ==================== CONFIGURACIÓN =============================================

cat("2. Configurando parámetros...\n")

app_name <- "QuantumLLAMA ETF Pro"
app_dir <- getwd()
app_version <- "6.0.0"

cat("   Nombre: ", app_name, "\n")
cat("   Versión: ", app_version, "\n")
cat("   Directorio: ", app_dir, "\n\n")

# ==================== CREAR ESTRUCTURA ==========================================

cat("3. Creando estructura de la aplicación...\n")

# Crear directorio de build
build_dir <- file.path(app_dir, "rinno_build")
if (!dir.exists(build_dir)) {
    dir.create(build_dir, recursive = TRUE)
}

# Copiar archivos necesarios
cat("   Copiando archivos de la aplicación...\n")

# Lista de archivos y carpetas a incluir
files_to_copy <- c(
    "app.R",
    "main.R",
    "Estrategia-ETF-Pro.R",
    "descargar_datos_fallback.R",
    "core",
    "data",
    "imagenes"
)

for (item in files_to_copy) {
    src <- file.path(app_dir, item)
    dst <- file.path(build_dir, item)

    if (file.exists(src)) {
        if (dir.exists(src)) {
            # Copiar directorio
            if (!dir.exists(dst)) {
                dir.create(dst, recursive = TRUE)
            }
            file.copy(src, dirname(dst), recursive = TRUE, overwrite = TRUE)
        } else {
            # Copiar archivo
            file.copy(src, dst, overwrite = TRUE)
        }
        cat("   ✓", item, "\n")
    }
}

cat("\n")

# ==================== CREAR LAUNCHER ============================================

cat("4. Creando launcher script...\n")

launcher_script <- file.path(build_dir, "launch_app.R")

launcher_code <- '# Launcher para QuantumLLAMA ETF Pro
suppressWarnings(suppressMessages({
    if (!require("pacman")) install.packages("pacman", repos = "https://cloud.r-project.org")
    pacman::p_load(
        quantmod, tidyquant, PerformanceAnalytics, tidyverse, xts, lubridate,
        caret, ranger, quadprog, tseries, TTR, zoo, gridExtra,
        shiny, shinydashboard, DT, openxlsx, doParallel, foreach
    )
}))

# Cargar la aplicación
source("main.R", encoding = "UTF-8")

# Lanzar Shiny
ejecutar_pro_v6(run_shiny = TRUE)
'

writeLines(launcher_code, launcher_script)
cat("   ✓ Launcher creado\n\n")

# ==================== CONFIGURAR RINNO ==========================================

cat("5. Configurando RInno...\n")

# Obtener paquetes necesarios
required_packages <- c(
    "quantmod", "tidyquant", "PerformanceAnalytics", "tidyverse",
    "xts", "lubridate", "caret", "ranger", "quadprog", "tseries",
    "TTR", "zoo", "gridExtra", "shiny", "shinydashboard", "DT",
    "openxlsx", "doParallel", "foreach", "pacman"
)

# Icono
icon_path <- file.path(app_dir, "build", "icon.png")
if (!file.exists(icon_path)) {
    icon_path <- ""
}

cat("   Generando configuración de instalador...\n")

# Crear configuración de RInno
RInno::create_app(
    app_name = "QuantumLLAMA_ETF_Pro",
    app_dir = build_dir,
    pkgs = required_packages,
    app_version = app_version,
    default_dir = "pf", # Program Files
    privilege = "lowest",
    app_desc = "Sistema Cuantitativo de Trading ETF con IA",
    publisher = "NBM Sistemas",
    main_url = "https://github.com/nbmsistemas",
    app_icon = icon_path,
    setup_icon = icon_path,
    license_file = "",
    info_before = "",
    info_after = "",
    user_browser = "electron",
    R_version = paste0(R.version$major, ".", R.version$minor)
)

cat("   ✓ Configuración creada\n\n")

# ==================== COMPILAR INSTALADOR =======================================

cat("6. Compilando instalador de Windows...\n")
cat("   (Esto puede tomar 10-15 minutos...)\n\n")

tryCatch(
    {
        RInno::compile_iss()

        cat("\n")
        cat("═══════════════════════════════════════════════════════════\n")
        cat("  ✓ INSTALADOR CREADO EXITOSAMENTE\n")
        cat("═══════════════════════════════════════════════════════════\n\n")

        cat("El instalador se encuentra en:\n")
        cat("  ", file.path(build_dir, "RInno_installer"), "\n\n")

        cat("Archivo: QuantumLLAMA_ETF_Pro_", app_version, "_Setup.exe\n\n")

        cat("Próximos pasos:\n")
        cat("  1. Prueba el instalador en tu PC\n")
        cat("  2. Prueba en una PC sin R instalado\n")
        cat("  3. Distribuye a tus seguidores\n\n")
    },
    error = function(e) {
        cat("\n")
        cat("═══════════════════════════════════════════════════════════\n")
        cat("  ✗ ERROR EN LA COMPILACIÓN\n")
        cat("═══════════════════════════════════════════════════════════\n\n")
        cat("Error: ", e$message, "\n\n")
        cat("Posibles soluciones:\n")
        cat("  1. Verifica que Inno Setup se instaló correctamente\n")
        cat("  2. Ejecuta como administrador\n")
        cat("  3. Revisa los logs arriba\n\n")
    }
)
