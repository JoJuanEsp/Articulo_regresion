# ==============================================================================
# ANÁLISIS DESCRIPTIVO - LICUEFACCIÓN ENZIMÁTICA DE PULPA DE COPOAZÚ
# Artículo: Criollo-Nuñez et al. (2022), Revista Ingeniería y Competitividad
# Repositorio GitHub: JoJuanEsp/Articulo_regresion
# ==============================================================================
library(readxl)
library(dplyr)
library(ggplot2)



url_datos <- "https://raw.githubusercontent.com/JoJuanEsp/Articulo_regresion/main/datos.xlsx"

archivos_locales <- list.files(pattern = "^datos(_2)?\\.xlsx$", ignore.case = TRUE)

if (length(archivos_locales) > 0) {
  archivo_lectura <- archivos_locales[1]
  datos_raw <- read_excel(archivo_lectura)
} else {
  temp_file <- tempfile(fileext = ".xlsx")
  download.file(url_datos, destfile = temp_file, mode = "wb", quiet = TRUE)
  datos_raw <- read_excel(temp_file)
}

datos <- as.data.frame(datos_raw)

# 3. Conversión Explícita y Limpieza de Tipos de Datos
# Función auxiliar para convertir texto/comas a números reales
a_numerico <- function(x) {
  as.numeric(gsub(",", ".", as.character(x)))
}

# Conversión forzada a numérico de las variables cuantitativas
datos$Rendimiento_pct <- a_numerico(datos$Rendimiento_pct)
datos$Solidos_Brix    <- a_numerico(datos$Solidos_Brix)
datos$Acidez_pct      <- a_numerico(datos$Acidez_pct)
datos$Temperatura_C   <- a_numerico(datos$Temperatura_C)

# Corrección de la celda de tiempo (corrige el número de serie de fecha 46145)
datos$Tiempo_h <- a_numerico(datos$Tiempo_h)
datos$Tiempo_h[is.na(datos$Tiempo_h) | datos$Tiempo_h > 10] <- 3.5

# Conversión de la variable cualitativa a factor
datos$Tipo_Enzima <- as.factor(datos$Tipo_Enzima)

# 4. Resumen Estadístico en Consola
cat("\n====================================================\n")
cat("  RESUMEN DESCRIPTIVO: LICUEFACCIÓN DE COPOAZÚ      \n")
cat("====================================================\n")

cat("\n--- Estructura de la Base de Datos ---\n")
print(dim(datos))

cat("\n--- Primeras Observaciones ---\n")
print(head(datos))

cat("\n--- Estadísticas Descriptivas Generales ---\n")
print(summary(datos))

cat("\n--- Promedios por Tipo de Enzima ---\n")
resumen_enzima <- datos %>%
  group_by(Tipo_Enzima) %>%
  summarise(
    Muestras         = n(),
    Rendimiento_Prom = round(mean(Rendimiento_pct), 2),
    Rendimiento_SD   = round(sd(Rendimiento_pct), 2),
    Brix_Prom        = round(mean(Solidos_Brix), 2),
    Acidez_Prom      = round(mean(Acidez_pct), 2)
  )
print(as.data.frame(resumen_enzima))

cat("\n--- Matriz de Correlación de Pearson ---\n")
num_vars <- datos %>% select(Tiempo_h, Temperatura_C, Rendimiento_pct, Solidos_Brix, Acidez_pct)
print(round(cor(num_vars), 3))

# 5. Visualizaciones de Alta Calidad con ggplot2

# Gráfico 1: Rendimiento (%) por Tipo de Enzima
g1 <- ggplot(datos, aes(x = Tipo_Enzima, y = Rendimiento_pct, fill = Tipo_Enzima)) +
  geom_boxplot(alpha = 0.6, outlier.shape = NA) +
  geom_jitter(width = 0.1, size = 2.5, alpha = 0.8) +
  scale_fill_brewer(palette = "Set2") +
  labs(
    title = "Rendimiento del Jugo según el Tipo de Enzima",
    subtitle = "Comparación entre Rapidase Citrus, Rapidase LIQ Plus y Mezcla",
    x = "Tipo de Enzima",
    y = "Rendimiento (%)"
  ) +
  theme(legend.position = "none")

# Gráfico 2: Sólidos Brix vs. Rendimiento (%) por Temperatura
g2 <- ggplot(datos, aes(x = Solidos_Brix, y = Rendimiento_pct, color = factor(Temperatura_C))) +
  geom_point(size = 3, alpha = 0.9) +
  geom_smooth(method = "lm", se = FALSE, linetype = "dashed", linewidth = 0.7) +
  scale_color_brewer(palette = "Dark2") +
  labs(
    title = "Sólidos Solubles (°Brix) vs. Rendimiento (%)",
    x = "Sólidos Solubles (°Brix)",
    y = "Rendimiento (%)",
    color = "Temperatura (°C)"
  )

# Gráfico 3: Perfil de Rendimiento Medio por Temperatura
g3 <- ggplot(datos, aes(x = Temperatura_C, y = Rendimiento_pct, color = Tipo_Enzima, group = Tipo_Enzima)) +
  stat_summary(fun = mean, geom = "line", linewidth = 1) +
  stat_summary(fun = mean, geom = "point", size = 3) +
  scale_color_brewer(palette = "Set1") +
  labs(
    title = "Perfil de Rendimiento Medio por Temperatura",
    x = "Temperatura (°C)",
    y = "Rendimiento Promedio (%)",
    color = "Tipo de Enzima"
  )

# Despliegue de gráficos
print(g1)
print(g2)
print(g3)