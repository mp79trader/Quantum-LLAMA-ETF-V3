# Script de Reparación de Dependencias
# Ejecutar este script si la aplicación no inicia

cat("================================================\n")
cat("REPARACIÓN DE DEPENDENCIAS QUANTUM LLAMA\n")
cat("================================================\n\n")

# 1. Instalar paquetes de R faltantes
cat("[1/3] Verificando paquetes de R...\n")

paquetes <- c("shinyWidgets", "reticulate", "shinydashboard", "pacman")

for (pkg in paquetes) {
    if (!require(pkg, character.only = TRUE)) {
        cat(sprintf("  Instalando %s...\n", pkg))
        install.packages(pkg, repos = "https://cloud.r-project.org")
    } else {
        cat(sprintf("  ✓ %s ya instalado\n", pkg))
    }
}

# 2. Verificar Python y MetaTrader5
cat("\n[2/3] Verificando entorno Python...\n")
library(reticulate)

tryCatch(
    {
        py_config <- py_config()
        cat("  Python encontrado en:", py_config$python, "\n")

        if (py_module_available("MetaTrader5")) {
            cat("  ✓ Librería MetaTrader5 instalada\n")
        } else {
            cat("  ⚠ Librería MetaTrader5 NO encontrada\n")
            cat("  Intentando instalar...\n")
            py_install("MetaTrader5", pip = TRUE)

            if (py_module_available("MetaTrader5")) {
                cat("  ✓ Instalación exitosa\n")
            } else {
                cat("  ❌ Error instalando MetaTrader5. Instale manualmente con: pip install MetaTrader5\n")
            }
        }
    },
    error = function(e) {
        cat("  ❌ Error verificando Python:", e$message, "\n")
    }
)

# 3. Prueba de carga
cat("\n[3/3] Prueba de carga de módulos...\n")
tryCatch(
    {
        source("core/mt5_bridge.R")
        cat("  ✓ Módulo MT5 carga correctamente\n")
    },
    error = function(e) {
        cat("  ❌ Error cargando módulo MT5:", e$message, "\n")
    }
)

cat("\n================================================\n")
cat("PROCESO COMPLETADO\n")
cat("Presione ENTER para salir...\n")
readLines(n = 1)
