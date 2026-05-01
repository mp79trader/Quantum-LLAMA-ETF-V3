# Configuración de CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org/"))

# Configuración de rendimiento
options(
    Ncpus = parallel::detectCores(),
    scipen = 999,
    stringsAsFactors = FALSE
)

# Configuración de timezone
Sys.setenv(TZ = "America/New_York")

# Mensaje de inicio
cat("Quantum Llama ETF System - Production Environment\n")
cat("R version:", R.version.string, "\n")
