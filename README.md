# ARASAAC Pictogramas

Aplicación web en Flutter para buscar, visualizar y descargar pictogramas de [ARASAAC](https://arasaac.org), el portal aragonés de Comunicación Aumentativa y Alternativa.

## 🌐 Demo en vivo

La aplicación está desplegada automáticamente en GitHub Pages: [https://pablomgrela.github.io/arasaac/](https://pablomgrela.github.io/arasaac/)

## Características

- 🔍 **Búsqueda de pictogramas**: Busca pictogramas por palabras clave en español
- 📂 **Navegación por categorías**: Explora pictogramas organizados por categorías
- 🎨 **Vista en color y blanco/negro**: Cambia entre versiones de color y monocromo
- ⬇️ **Descarga individual**: Descarga pictogramas uno por uno
- 📦 **Descarga masiva**: Descarga todos los pictogramas de una categoría
- 📱 **Diseño responsive**: Funciona en cualquier tamaño de pantalla

## Tecnologías utilizadas

- **Flutter Web**: Framework de desarrollo
- **Provider**: Gestión de estado
- **API de ARASAAC**: https://api.arasaac.org/api
- **Cached Network Image**: Carga eficiente de imágenes

## Instalación y ejecución

### Requisitos previos

- Flutter SDK instalado (versión 3.0 o superior)
- Un navegador web moderno

### Pasos para ejecutar

1. Clona o descarga este repositorio

2. Instala las dependencias:
```bash
flutter pub get
```

3. Ejecuta la aplicación en modo desarrollo:
```bash
flutter run -d chrome
```

4. Para compilar la aplicación para producción:
```bash
flutter build web
```

Los archivos compilados estarán en la carpeta `build/web/`

## 🚀 Despliegue en GitHub Pages

La aplicación se despliega automáticamente en GitHub Pages mediante GitHub Actions. Cada vez que se hace push a la rama `main`, se ejecuta el workflow que:

1. Compila la aplicación Flutter para web
2. Sube los archivos compilados a GitHub Pages
3. La aplicación queda disponible en: [https://pablomgrela.github.io/arasaac/](https://pablomgrela.github.io/arasaac/)

El workflow de despliegue se encuentra en `.github/workflows/deploy.yml`.

## Estructura del proyecto

```
lib/
├── models/           # Modelos de datos (Pictogram, Category)
├── services/         # Servicios de API (ArasaacApiService)
├── providers/        # Gestión de estado (PictogramProvider)
├── screens/          # Pantallas de la aplicación
│   ├── search_screen.dart
│   ├── categories_screen.dart
│   ├── category_pictograms_screen.dart
│   └── pictogram_detail_screen.dart
├── widgets/          # Widgets reutilizables
│   ├── pictogram_card.dart
│   └── category_card.dart
└── main.dart         # Punto de entrada de la aplicación
```

## Uso

### Búsqueda de pictogramas

1. En la pestaña "Buscar", escribe una palabra clave en el campo de búsqueda
2. Presiona Enter o el botón de búsqueda
3. Navega por los resultados y haz clic en cualquier pictograma para ver más detalles

### Navegación por categorías

1. Ve a la pestaña "Categorías"
2. Selecciona una categoría
3. Explora todos los pictogramas de esa categoría
4. Usa el botón de descarga en la barra superior para descargar todos los pictogramas

### Descarga de pictogramas

- **Individual**: Haz clic en el botón de descarga en cada tarjeta de pictograma
- **Masiva**: En la vista de categoría, usa el botón de descarga en la barra superior

## API de ARASAAC

Esta aplicación utiliza la API pública de ARASAAC. Endpoints principales:

- `GET /api/pictograms/{lang}/search/{query}` - Buscar pictogramas
- `GET /api/pictograms/{lang}/search/category/{category}` - Pictogramas por categoría
- `GET /api/categories/{lang}` - Obtener categorías
- `GET /api/pictograms/{lang}/bestsellers` - Pictogramas más populares

Imágenes: `https://static.arasaac.org/pictograms/{id}/{id}_nocolor.png`

### 🔓 Acceso público sin autenticación

Esta aplicación **NO requiere autenticación** porque utiliza únicamente endpoints públicos de solo lectura. La API de ARASAAC permite acceso libre para buscar, visualizar y descargar pictogramas.

ARASAAC proporciona autenticación OAuth2 (https://auth.arasaac.org/) para operaciones avanzadas como crear/modificar pictogramas o gestionar usuarios, pero no es necesaria para esta aplicación.

> 💡 Si en el futuro necesitas añadir autenticación, consulta el archivo `AUTENTICACION.md` para más detalles.

## Créditos

- **ARASAAC**: Portal Aragonés de la Comunicación Aumentativa y Alternativa
- API y pictogramas proporcionados por [ARASAAC.org](https://arasaac.org)
- Desarrollado con Flutter

## Licencia

Los pictogramas de ARASAAC están sujetos a su propia licencia. Consulta [arasaac.org](https://arasaac.org) para más información.
