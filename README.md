# QuantumLLAMA ETF Pro v6.0

![Version](https://img.shields.io/badge/version-6.0.0-blue.svg)
![R](https://img.shields.io/badge/R-%3E%3D%204.0-blue.svg)
![License](https://img.shields.io/badge/License-Proprietary-red.svg)

Sistema Cuantitativo de Trading con IA especializado en ETFs, diseñado para operar en MetaTrader 5 (MT5).

## 🚀 Descripción

QuantumLLAMA ETF Pro es una solución avanzada de trading algorítmico que combina el poder estadístico de R con la capacidad de ejecución de MetaTrader 5. Utiliza algoritmos de aprendizaje automático para identificar patrones en ETFs y ejecutar estrategias de alta confianza.

## 🛠️ Características Principales

- **Estrategia Cuantitativa:** Algoritmos optimizados para el mercado de ETFs.
- **Integración con MT5:** Bridge robusto para ejecución en tiempo real.
- **Interfaz Gráfica:** Dashboard interactivo desarrollado con Shiny y encapsulado en Electron.
- **Gestión de Riesgo:** Control dinámico de posición y stop-loss avanzado.
- **Análisis de Resultados:** Generación automática de reportes detallados en Excel y visualizaciones (PNG).

## 📂 Estructura del Proyecto 

```text
├── core/               # Lógica central (configuración, datos, bridge MT5)
├── ui/                 # Componentes de la interfaz de usuario
├── data/               # Almacenamiento de datos históricos y temporales
├── Resultados_PRO_v6/  # Reportes, métricas y señales generadas
├── main.R              # Punto de entrada principal para R
├── main.js             # Punto de entrada principal para Electron
└── package.json        # Configuración del entorno Node.js/Electron
```

## ⚙️ Requisitos

- [R](https://www.r-project.org/) (>= 4.0)
- [Node.js](https://nodejs.org/) & NPM
- [MetaTrader 5](https://www.metatrader5.com/) con el terminal activo.
- Dependencias de R: `shiny`, `reticulate`, `PerformanceAnalytics`, etc. (ver `reparar_dependencias.R`).

## 🔧 Instalación y Uso

1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com/mp79trader/Quantum-LLAMA-ETF-V3.git
   cd Quantum-LLAMA-ETF-V3
   ```

2. **Configurar el entorno:**
   Ejecutar el script de reparación de dependencias en R:
   ```R
   source("reparar_dependencias.R")
   ```

3. **Instalar dependencias de Node.js:**
   ```bash
   npm install
   ```

4. **Ejecutar la aplicación:**
   Puedes usar los scripts batch proporcionados o ejecutar directamente:
   ```bash
   npm start
   ```

## 📄 Licencia

Este software es propiedad exclusiva de **NBM Sistemas**. Todos los derechos reservados. Consulte el archivo `LICENSE.txt` para obtener más detalles sobre los términos de uso personal y restricciones.

---
Desarrollado por [NBM Sistemas](https://github.com/nbmsistemas).
