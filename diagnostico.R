# ==================================================================================
# DIAGNÓSTICO - Sistema Cuantitativo ETF Pro v6.0
# ==================================================================================
# Este script ayuda a diagnosticar problemas de carga del sistema

cat("\n")
cat("═══════════════════════════════════════════════════════════\n")
cat("  DIAGNÓSTICO DEL SISTEMA\n")
cat("═══════════════════════════════════════════════════════════\n\n")

# 1. Verificar directorio de trabajo
cat("1. Directorio de trabajo actual:\n")
cat("   ", getwd(), "\n\n")

# 2. Verificar que estamos en el directorio correcto
expected_dir <- "D:/AlgoTradingMT5/QuantumLLAMAETF"
if (normalizePath(getwd(), winslash = "/") != normalizePath(expected_dir, winslash = "/")) {
    cat("⚠️  ADVERTENCIA: No estás en el directorio correcto\n")
    cat("   Cambiando a: ", expected_dir, "\n\n")
    setwd(expected_dir)
} else {
    cat("✓ Directorio correcto\n\n")
}

# 3. Verificar archivos necesarios
cat("2. Verificando archivos necesarios:\n")
archivos_necesarios <- c(
    "main.R",
    "Estrategia-ETF-Pro.R",
    "core/config.R",
    "core/utils.R"
)

todos_existen <- TRUE
for (archivo in archivos_necesarios) {
    existe <- file.exists(archivo)
    todos_existen <- todos_existen && existe
    cat("   ", ifelse(existe, "✓", "✗"), " ", archivo, "\n")
}
cat("\n")

if (!todos_existen) {
    cat("❌ ERROR: Faltan archivos necesarios\n")
    cat("   Verifica que estés en el directorio correcto\n\n")
    stop("Archivos faltantes")
}

# 4. Intentar cargar los módulos uno por uno
cat("3. Cargando módulos:\n")

tryCatch(
    {
        cat("   Cargando core/config.R... ")
        source("core/config.R", encoding = "UTF-8")
        cat("✓\n")
    },
    error = function(e) {
        cat("✗\n")
        cat("   ERROR:", e$message, "\n")
        stop("Error en core/config.R")
    }
)

tryCatch(
    {
        cat("   Cargando core/utils.R... ")
        source("core/utils.R", encoding = "UTF-8")
        cat("✓\n")
    },
    error = function(e) {
        cat("✗\n")
        cat("   ERROR:", e$message, "\n")
        stop("Error en core/utils.R")
    }
)

tryCatch(
    {
        cat("   Cargando Estrategia-ETF-Pro.R... ")
        source("Estrategia-ETF-Pro.R", encoding = "UTF-8")
        cat("✓\n")
    },
    error = function(e) {
        cat("✗\n")
        cat("   ERROR:", e$message, "\n")
        stop("Error en Estrategia-ETF-Pro.R")
    }
)

cat("\n")

# 5. Verificar que la función existe
cat("4. Verificando función ejecutar_pro_v6:\n")
if (exists("ejecutar_pro_v6")) {
    cat("   ✓ Función encontrada\n")
    cat("   Tipo:", class(ejecutar_pro_v6), "\n\n")
} else {
    cat("   ✗ Función NO encontrada\n\n")
    stop("La función ejecutar_pro_v6 no está definida")
}

# 6. Todo OK
cat("═══════════════════════════════════════════════════════════\n")
cat("✓ DIAGNÓSTICO COMPLETADO EXITOSAMENTE\n")
cat("═══════════════════════════════════════════════════════════\n\n")

cat("El sistema está listo. Puedes ejecutar:\n")
cat("  ejecutar_pro_v6(run_shiny = TRUE)   # Con interfaz GUI\n")
cat("  ejecutar_pro_v6(run_shiny = FALSE)  # Solo backtesting\n\n")
