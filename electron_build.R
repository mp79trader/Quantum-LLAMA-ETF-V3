# ==================================================================================
# ELECTRON BUILD SCRIPT - QuantumLLAMA ETF Pro v6.0
# ==================================================================================
# Este script empaqueta la aplicación Shiny en un ejecutable de Windows usando electricShine

cat("\n")
cat("═══════════════════════════════════════════════════════════\n")
cat("  ELECTRON BUILD - QuantumLLAMA ETF Pro v6.0\n")
cat("═══════════════════════════════════════════════════════════\n\n")

# ==================== INSTALAR DEPENDENCIAS =====================================

cat("1. Verificando e instalando dependencias...\n")

# Instalar electricShine si no está disponible
if (!require("electricShine", quietly = TRUE)) {
    cat("   Instalando electricShine...\n")
    install.packages("electricShine", repos = "https://cloud.r-project.org")
}

library(electricShine)

cat("   ✓ electricShine cargado\n\n")

# ==================== CONFIGURACIÓN DEL BUILD ===================================

cat("2. Configurando parámetros del build...\n")

# Información de la aplicación
app_name <- "QuantumLLAMA-ETF-Pro"
app_description <- "Sistema Cuantitativo de Trading ETF con IA"
app_version <- "6.0.0"
app_author <- "NBM Sistemas"

# Directorios
project_dir <- getwd()
build_dir <- file.path(project_dir, "electron_build")
app_root <- project_dir

# Archivo de entrada de la app
shiny_app_file <- "app.R"

# Icono (si existe)
icon_path <- file.path(project_dir, "build", "icon.ico")
if (!file.exists(icon_path)) {
    icon_path <- NULL
    cat("   ⚠️  No se encontró icon.ico, se usará el icono por defecto\n")
}

cat("   Nombre: ", app_name, "\n")
cat("   Versión: ", app_version, "\n")
cat("   Directorio: ", project_dir, "\n")
cat("   Build output: ", build_dir, "\n\n")

# ==================== PREPARAR ENTORNO ==========================================

cat("3. Preparando entorno de build...\n")

# Crear directorio de build si no existe
if (!dir.exists(build_dir)) {
    dir.create(build_dir, recursive = TRUE)
    cat("   ✓ Directorio de build creado\n")
} else {
    cat("   ✓ Directorio de build ya existe\n")
}

# Verificar que app.R existe
if (!file.exists(file.path(project_dir, shiny_app_file))) {
    stop("ERROR: No se encontró app.R en el directorio del proyecto")
}
cat("   ✓ app.R encontrado\n\n")

# ==================== EJECUTAR BUILD ============================================

cat("4. Iniciando proceso de build con electricShine...\n")
cat("   (Esto puede tomar varios minutos - se descargará R portable y paquetes)\n\n")

tryCatch(
    {
        electricShine::buildApp(
            app_name = app_name,
            product_name = "QuantumLLAMA ETF Pro",
            description = app_description,
            semantic_version = app_version,
            author = app_author,

            # Rutas
            app_root = app_root,
            build_path = build_dir,

            # Configuración de R
            r_version = "4.3.0", # Versión estable de R
            cran_like_url = "https://cran.r-project.org",

            # Paquetes necesarios (todos los que usa tu app)
            function_name = "shinyApp",
            package_install_opts = list(
                repos = "https://cloud.r-project.org",
                dependencies = TRUE,
                type = "binary"
            ),

            # Configuración de Electron
            nodejs_path = "node",
            nodejs_version = "20.18.0",

            # Plataforma
            platform = "win32",
            arch = "x64",

            # Icono
            icon = icon_path,

            # Opciones adicionales
            run_build = TRUE,
            verbose = TRUE
        )

        cat("\n")
        cat("═══════════════════════════════════════════════════════════\n")
        cat("  ✓ BUILD COMPLETADO EXITOSAMENTE\n")
        cat("═══════════════════════════════════════════════════════════\n\n")

        cat("El instalador se encuentra en:\n")
        cat("  ", file.path(build_dir, "dist"), "\n\n")

        cat("Próximos pasos:\n")
        cat("  1. Navega a la carpeta 'electron_build/dist/'\n")
        cat("  2. Ejecuta el instalador .exe\n")
        cat("  3. Prueba la aplicación instalada\n\n")
    },
    error = function(e) {
        cat("\n")
        cat("═══════════════════════════════════════════════════════════\n")
        cat("  ✗ ERROR EN EL BUILD\n")
        cat("═══════════════════════════════════════════════════════════\n\n")
        cat("Error: ", e$message, "\n\n")
        cat("Posibles soluciones:\n")
        cat("  1. Verifica que Node.js esté instalado: node --version\n")
        cat("  2. Verifica que todas las dependencias de R estén instaladas\n")
        cat("  3. Revisa los logs arriba para más detalles\n\n")
    }
)
