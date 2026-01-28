# 📁 Guía de Archivos del Proyecto

Esta guía describe todos los archivos importantes del proyecto y su función.

## 📚 Documentación (raíz)

| Archivo | Descripción |
|---------|-------------|
| **README.md** | Documentación técnica completa del proyecto |
| **INICIO_RAPIDO.md** | Guía rápida para comenzar a usar la aplicación |
| **AUTENTICACION.md** | Información sobre OAuth2 y cómo implementar autenticación |
| **RESUMEN.md** | Resumen ejecutivo del proyecto completado |
| **ARCHIVOS.md** | Este archivo - índice de todos los archivos |
| **run.sh** | Script ejecutable para iniciar la aplicación |

## 🎯 Código fuente (lib/)

### 📦 Modelos (lib/models/)

| Archivo | Líneas | Descripción |
|---------|--------|-------------|
| **pictogram.dart** | ~55 | Modelo de datos para pictogramas con propiedades como ID, keywords, categorías, URLs de imágenes |
| **category.dart** | ~17 | Modelo de datos para categorías con ID, texto y descripción |

**Responsabilidad**: Definir la estructura de datos y proporcionar métodos de conversión desde JSON.

### 🔌 Servicios (lib/services/)

| Archivo | Líneas | Descripción |
|---------|--------|-------------|
| **arasaac_api_service.dart** | ~102 | Servicio que maneja todas las llamadas a la API de ARASAAC |

**Métodos principales**:
- `searchPictograms()` - Buscar pictogramas
- `getPictogramsByCategory()` - Obtener por categoría
- `getPictogramById()` - Obtener pictograma específico
- `getCategories()` - Listar categorías
- `getBestPictograms()` - Pictogramas más populares

### 🧠 Providers (lib/providers/)

| Archivo | Líneas | Descripción |
|---------|--------|-------------|
| **pictogram_provider.dart** | ~88 | Gestión de estado global usando Provider |

**Estado gestionado**:
- Lista de pictogramas actual
- Lista de categorías
- Estado de carga (loading)
- Errores
- Idioma actual

**Métodos principales**:
- `searchPictograms()` - Ejecutar búsqueda
- `loadPictogramsByCategory()` - Cargar por categoría
- `loadCategories()` - Cargar categorías
- `loadBestPictograms()` - Cargar populares

### 📱 Pantallas (lib/screens/)

| Archivo | Líneas | Descripción |
|---------|--------|-------------|
| **search_screen.dart** | ~180 | Pantalla principal de búsqueda con campo de texto y grid de resultados |
| **categories_screen.dart** | ~109 | Pantalla que muestra todas las categorías disponibles |
| **category_pictograms_screen.dart** | ~203 | Pantalla con todos los pictogramas de una categoría + descarga masiva |
| **pictogram_detail_screen.dart** | ~219 | Vista detallada de un pictograma con toda su información |

**Navegación**:
```
HomeScreen
├── SearchScreen (tab 1)
│   └── PictogramDetailScreen
└── CategoriesScreen (tab 2)
    └── CategoryPictogramsScreen
        └── PictogramDetailScreen
```

### 🧩 Widgets (lib/widgets/)

| Archivo | Líneas | Descripción |
|---------|--------|-------------|
| **pictogram_card.dart** | ~127 | Tarjeta reutilizable para mostrar un pictograma en el grid |
| **category_card.dart** | ~75 | Tarjeta reutilizable para mostrar una categoría |

**Características de PictogramCard**:
- Vista previa de imagen
- Botón de color/B-N
- Botón de descarga
- Click para ver detalle

**Características de CategoryCard**:
- Icono representativo
- Nombre de categoría
- Descripción
- Click para ver pictogramas

### 🚀 Principal (lib/)

| Archivo | Líneas | Descripción |
|---------|--------|-------------|
| **main.dart** | ~69 | Punto de entrada de la aplicación con configuración de tema y navegación |

**Estructura**:
- `MyApp` - Widget raíz con Provider y MaterialApp
- `HomeScreen` - Pantalla principal con NavigationBar
- Configuración de tema Material Design 3

## ⚙️ Configuración

### pubspec.yaml
**Dependencias principales**:
```yaml
http: ^1.2.0                      # HTTP client
provider: ^6.1.1                  # Gestión de estado
cached_network_image: ^3.3.1     # Caché de imágenes
flutter_cache_manager: ^3.3.1    # Gestor de caché
universal_html: ^2.2.4            # Descarga de archivos web
```

### web/index.html
- Configurado con título "ARASAAC Pictogramas"
- Meta descripción optimizada
- Configuración PWA base

## 📊 Estadísticas del proyecto

### Código Dart
- **Total archivos**: 11
- **Total líneas**: ~1,500
- **Modelos**: 2
- **Servicios**: 1
- **Providers**: 1
- **Pantallas**: 4
- **Widgets**: 2
- **Principal**: 1

### Documentación
- **Total archivos**: 6
- **Total páginas**: ~15 equivalentes

## 🗂️ Estructura visual completa

```
arasaac_pictogramas/
│
├── 📚 Documentación
│   ├── README.md (principal)
│   ├── INICIO_RAPIDO.md (guía rápida)
│   ├── AUTENTICACION.md (OAuth2 futuro)
│   ├── RESUMEN.md (resumen ejecutivo)
│   └── ARCHIVOS.md (este archivo)
│
├── 🚀 Scripts
│   └── run.sh (ejecutar app)
│
├── ⚙️ Configuración
│   ├── pubspec.yaml (dependencias)
│   └── analysis_options.yaml (linter)
│
├── 🌐 Web
│   ├── index.html (configurado)
│   └── manifest.json (PWA)
│
└── 💻 Código (lib/)
    │
    ├── 📦 Capa de datos
    │   ├── models/
    │   │   ├── pictogram.dart (estructura de pictograma)
    │   │   └── category.dart (estructura de categoría)
    │   │
    │   └── services/
    │       └── arasaac_api_service.dart (comunicación API)
    │
    ├── 🧠 Capa de lógica
    │   └── providers/
    │       └── pictogram_provider.dart (estado global)
    │
    ├── 🎨 Capa de presentación
    │   ├── screens/ (pantallas completas)
    │   │   ├── search_screen.dart
    │   │   ├── categories_screen.dart
    │   │   ├── category_pictograms_screen.dart
    │   │   └── pictogram_detail_screen.dart
    │   │
    │   └── widgets/ (componentes reutilizables)
    │       ├── pictogram_card.dart
    │       └── category_card.dart
    │
    └── main.dart (punto de entrada)
```

## 🔍 Archivos por responsabilidad

### 📥 Entrada de datos (API)
- `lib/services/arasaac_api_service.dart` - Obtiene datos de ARASAAC

### 💾 Modelos de datos
- `lib/models/pictogram.dart` - Define estructura de pictograma
- `lib/models/category.dart` - Define estructura de categoría

### 🎮 Lógica de negocio
- `lib/providers/pictogram_provider.dart` - Gestiona estado y operaciones

### 🎨 Interfaz de usuario
- `lib/screens/*.dart` - Pantallas completas
- `lib/widgets/*.dart` - Componentes reutilizables
- `lib/main.dart` - Configuración y tema

### 📖 Información
- `*.md` - Documentación
- `run.sh` - Automatización

## 🎯 Flujo de datos

```
1. Usuario interactúa con UI (screens/widgets)
        ↓
2. UI llama a métodos de Provider
        ↓
3. Provider llama a ArasaacApiService
        ↓
4. Service hace HTTP request a API
        ↓
5. API responde con JSON
        ↓
6. Service convierte JSON a modelos (Pictogram/Category)
        ↓
7. Provider actualiza estado
        ↓
8. UI se actualiza automáticamente (Provider notifica)
        ↓
9. Usuario ve los resultados
```

## 📝 Convenciones del proyecto

### Nombres de archivos
- Snake case: `pictogram_card.dart`
- Descriptivos: `category_pictograms_screen.dart`

### Nombres de clases
- Pascal case: `PictogramCard`
- Sufijos: `Screen`, `Provider`, `Service`

### Estructura de clases
```dart
// 1. Imports
import 'package:flutter/material.dart';

// 2. Clase principal
class MyWidget extends StatelessWidget {
  // 3. Propiedades
  final String title;

  // 4. Constructor
  const MyWidget({super.key, required this.title});

  // 5. Métodos
  @override
  Widget build(BuildContext context) {
    // ...
  }
}
```

## 🔧 Archivos importantes para modificar

### Para cambiar la UI
- `lib/screens/*.dart` - Layouts de pantallas
- `lib/widgets/*.dart` - Componentes
- `lib/main.dart` - Tema y colores

### Para cambiar la lógica
- `lib/providers/pictogram_provider.dart` - Operaciones y estado
- `lib/services/arasaac_api_service.dart` - Llamadas a API

### Para añadir funcionalidades
1. Crear nuevo modelo en `lib/models/`
2. Añadir métodos en `lib/services/`
3. Actualizar provider en `lib/providers/`
4. Crear pantalla/widget en `lib/screens/` o `lib/widgets/`

## ✅ Conclusión

Esta estructura de archivos sigue las mejores prácticas de Flutter:
- **Separación de responsabilidades**
- **Código reutilizable**
- **Fácil de mantener**
- **Escalable**

Todos los archivos están bien organizados y documentados para facilitar futuras mejoras.
