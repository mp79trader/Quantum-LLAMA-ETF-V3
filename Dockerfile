FROM rocker/r-ver:4.3.0

# Instalar dependencias del sistema (incluyendo las necesarias para ragg)
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libcairo2-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# Establecer directorio de trabajo
WORKDIR /app

# Copiar archivos de la aplicación
COPY . .

# Instalar pacman primero
RUN R -e "install.packages('pacman', repos='https://cloud.r-project.org/')"

# Instalar todos los paquetes necesarios usando pacman
RUN R -e "pacman::p_load( \
    shiny, \
    shinydashboard, \
    quantmod, \
    tidyquant, \
    PerformanceAnalytics, \
    tidyverse, \
    xts, \
    lubridate, \
    caret, \
    ranger, \
    quadprog, \
    tseries, \
    TTR, \
    zoo, \
    gridExtra, \
    DT, \
    openxlsx, \
    doParallel, \
    foreach \
    )"

# Crear directorio para resultados
RUN mkdir -p Resultados_PRO_v6

# Exponer puerto
EXPOSE 3838

# Comando para ejecutar la aplicación
CMD ["R", "-e", "shiny::runApp('app.R', host='0.0.0.0', port=as.numeric(Sys.getenv('PORT', '3838')))"]
