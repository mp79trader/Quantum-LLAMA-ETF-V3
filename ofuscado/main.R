# ==================================================================================
# CÓDIGO OFUSCADO - NO MODIFICAR
# ==================================================================================
# Este código ha sido ofuscado para protección de propiedad intelectual.
# Cualquier intento de modificación o reverse engineering está prohibido.
# Copyright (c) 2024 NBM Sistemas. Todos los derechos reservados.
# ==================================================================================

suppressWarnings(suppressMessages({
 if (!require("pacman")) install.packages("pacman", repos = "https://cloud.r-project.org")
 pacman::p_load(
 quantmod, tidyquant, PerformanceAnalytics, tidyverse, xts, lubridate,
 caret, ranger, quadprog, tseries, TTR, zoo, gridExtra,
 shiny, shinydashboard, DT, openxlsx, doParallel, foreach
 )
}))
options(warn =-1, scipen = 999, digits = 6)
Sys.setenv(TZ = "UTC")
set.seed(2025)
source("core/config.R", encoding = "UTF-8")
source("core/utils.R", encoding = "UTF-8")
source("Estrategia-ETF-Pro.R", encoding = "UTF-8")
if (dir.exists("imagenes")) {
 shiny::addResourcePath("imagenes", file.path(getwd(), "imagenes"))
}
cat("\n")
cat("═══════════════════════════════════════════════════════════\n")
cat(" SISTEMA CUANTITATIVO ETF PRO v6.0\n")
cat(" Arquitectura Modular-LLAMA IA Trading System\n")
cat("═══════════════════════════════════════════════════════════\n\n")
cat("✓ Módulos cargados correctamente\n")
cat("✓ Configuración lista\n")
cat("✓ Sistema listo para ejecutar\n\n")
is_production<-!interactive() || Sys.getenv("RENDER") != ""
if (is_production) {
 cat("🚀 Entorno de PRODUCCIÓN detectado\n")
 cat(" Shiny se iniciará desde app.R\n\n")
} else {
 cat("Para ejecutar:\n")
 cat(" ejecutar_pro_v6(run_shiny = TRUE) 
 cat(" ejecutar_pro_v6(run_shiny = FALSE) 
 cat("═══════════════════════════════════════════════════════════\n\n")
}
