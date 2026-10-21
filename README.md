# Artículo de regresión: Extracción de jugo de copoazú mediante licuefacción enzimática

Repositorio con datos experimentales de licuefacción enzimática de pulpa de copoazú, destinado al entrenamiento de modelos predictivos para el curso de Análisis de Regresión (UNAL Medellín).

Proyecto del curso **Análisis de Regresión** (2026-2), Universidad Nacional de Colombia, sede Medellín. Docente: Freddy Hernández Barajas. Autora/e: Juan José Espinel Espinel

## Objetivo

Aplicar modelos de regresión (diseño de superficie de respuesta) a los datos experimentales de un artículo científico para explicar y predecir el rendimiento y las características fisicoquímicas del jugo de copoazú en función de las variables de tiempo de incubación, temperatura y tipo de enzima pectinolítica.

## Artículo de referencia

Criollo-Nuñez, J., Fonseca-Blanco, J. D., Lopez-Hernandez, M. D., Sandoval-Aldana, A. P., & Criollo-Cruz, D. (2022). Estudio comparativo de dos enzimas pectinolíticas en la licuefacción de la pulpa de copoazú (Theobroma grandiflorum) y extracción de fibra dietaria. *Ingeniería y Competitividad*, 24(2), e22011586. https://doi.org/10.25100/iyc.v24i2.11586.

## Datos

El archivo `datos.xlsx` contiene las 11 corridas experimentales del estudio, obtenidas mediante un diseño de superficie de respuesta de fracciones de la serie 2k para minimizar la varianza[cite: 6, 7].

| Variable | Descripción | Tipo | Unidad / niveles |
| :--- | :--- | :--- | :--- |
| `tiempo` | Tiempo de acción/incubación | Numérica | horas (2 a 5)[cite: 6] |
| `temperatura` | Temperatura de incubación | Numérica | °C (15 a 45)[cite: 6] |
| `enzima` | Tipo de preparado enzimático | Categórica | Rapidase LIQ Plus, Rapidase Citrus, Mezcla[cite: 6] |
| `rendimiento` | Rendimiento del jugo extraído (variable respuesta) | Numérica | %[cite: 6, 7] |
| `solidos` | Sólidos solubles totales (variable respuesta) | Numérica | °Brix[cite: 6, 7] |
| `acidez` | Acidez total (variable respuesta) | Numérica | % de ácido cítrico[cite: 6, 7] |

## Estructura del repositorio

```text
Articulo_regresion/
├── README.md
└── datos.xlsx
