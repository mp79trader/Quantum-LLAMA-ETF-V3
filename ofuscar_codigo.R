# ==================================================================================
# OFUSCADOR DE CÓDIGO R - QuantumLLAMA ETF Pro
# ==================================================================================
# Este script ofusca el código R para protegerlo de miradas indiscretas

cat("\n")
cat("═══════════════════════════════════════════════════════════\n")
cat("  OFUSCADOR DE CÓDIGO R - QuantumLLAMA ETF Pro\n")
cat("═══════════════════════════════════════════════════════════\n\n")

# Función para generar nombres aleatorios
generar_nombre_aleatorio <- function(prefijo = "var") {
    paste0(prefijo, "_", paste(sample(c(letters, 0:9), 8, replace = TRUE), collapse = ""))
}

# Función para ofuscar un archivo R
ofuscar_archivo <- function(archivo_entrada, archivo_salida) {
    cat("Ofuscando:", archivo_entrada, "...\n")

    # Leer el archivo
    codigo <- readLines(archivo_entrada, warn = FALSE, encoding = "UTF-8")

    # Eliminar comentarios
    codigo <- gsub("#.*$", "", codigo)

    # Eliminar líneas vacías
    codigo <- codigo[nzchar(trimws(codigo))]

    # Comprimir espacios múltiples
    codigo <- gsub("\\s+", " ", codigo)

    # Eliminar espacios alrededor de operadores (opcional, hace más difícil de leer)
    codigo <- gsub(" *<- *", "<-", codigo)
    codigo <- gsub(" *== *", "==", codigo)
    codigo <- gsub(" *\\+ *", "+", codigo)
    codigo <- gsub(" *- *", "-", codigo)
    codigo <- gsub(" *\\* *", "*", codigo)
    codigo <- gsub(" */ *", "/", codigo)

    # Agregar header de advertencia
    header <- c(
        "# ==================================================================================",
        "# CÓDIGO OFUSCADO - NO MODIFICAR",
        "# ==================================================================================",
        "# Este código ha sido ofuscado para protección de propiedad intelectual.",
        "# Cualquier intento de modificación o reverse engineering está prohibido.",
        "# Copyright (c) 2024 NBM Sistemas. Todos los derechos reservados.",
        "# ==================================================================================",
        ""
    )

    codigo_final <- c(header, codigo)

    # Escribir archivo ofuscado
    writeLines(codigo_final, archivo_salida, useBytes = TRUE)
    cat("  ✓ Guardado en:", archivo_salida, "\n")
}

# ==================== OFUSCAR ARCHIVOS PRINCIPALES ================================

cat("\n1. Creando carpeta de archivos ofuscados...\n")
dir.create("ofuscado", showWarnings = FALSE)

archivos_a_ofuscar <- c(
    "main.R",
    "Estrategia-ETF-Pro.R",
    "app.R"
)

cat("\n2. Ofuscando archivos...\n")
for (archivo in archivos_a_ofuscar) {
    if (file.exists(archivo)) {
        archivo_salida <- file.path("ofuscado", archivo)
        ofuscar_archivo(archivo, archivo_salida)
    } else {
        cat("  ⚠ No encontrado:", archivo, "\n")
    }
}

# Copiar carpetas necesarias
cat("\n3. Copiando carpetas necesarias...\n")
carpetas <- c("core", "data", "imagenes")
for (carpeta in carpetas) {
    if (dir.exists(carpeta)) {
        destino <- file.path("ofuscado", carpeta)
        if (!dir.exists(destino)) {
            dir.create(destino, recursive = TRUE)
        }
        file.copy(carpeta, "ofuscado", recursive = TRUE, overwrite = TRUE)
        cat("  ✓", carpeta, "\n")
    }
}

cat("\n")
cat("═══════════════════════════════════════════════════════════\n")
cat("  ✓ OFUSCACIÓN COMPLETADA\n")
cat("═══════════════════════════════════════════════════════════\n\n")

cat("Archivos ofuscados guardados en: ofuscado/\n\n")

cat("PRÓXIMOS PASOS:\n")
cat("1. Revisa los archivos en la carpeta 'ofuscado/'\n")
cat("2. Copia el contenido de 'ofuscado/' a tu proyecto principal\n")
cat("3. Reconstruye el ejecutable con: npm run build\n\n")

cat("NOTA: La ofuscación elimina comentarios y comprime el código,\n")
cat("haciéndolo muy difícil de entender para usuarios no autorizados.\n\n")
