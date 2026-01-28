# Guía de Inicio Rápido - ARASAAC Pictogramas

## 🚀 Cómo ejecutar la aplicación

### Opción 1: Script automatizado
```bash
./run.sh
```

### Opción 2: Comando manual
```bash
flutter run -d chrome --web-port=8080
```

La aplicación se abrirá automáticamente en tu navegador en `http://localhost:8080`

## 📱 Funcionalidades principales

### 1. Búsqueda de Pictogramas
- Ve a la pestaña **"Buscar"**
- Escribe una palabra clave (ej: "casa", "comer", "feliz")
- Presiona Enter o el botón de búsqueda
- Explora los resultados

### 2. Navegación por Categorías
- Ve a la pestaña **"Categorías"**
- Selecciona una categoría (salud, comida, animales, etc.)
- Verás todos los pictogramas de esa categoría

### 3. Descargar Pictogramas

**Descarga individual:**
- Haz clic en el botón de descarga 📥 en cada pictograma
- Puedes cambiar entre color y blanco/negro antes de descargar

**Descarga masiva:**
- En la vista de categoría, haz clic en el botón 📥 en la barra superior
- Se descargarán todos los pictogramas de esa categoría

### 4. Ver detalles
- Haz clic en cualquier pictograma para ver:
  - Imagen en tamaño completo
  - Palabras clave asociadas
  - Categorías
  - Información adicional

## 🎨 Características

- **Vista en color y B/N**: Cambia entre versiones con un clic
- **Diseño responsive**: Funciona en cualquier tamaño de pantalla
- **Búsqueda rápida**: Resultados instantáneos desde la API de ARASAAC
- **Sin límites**: Acceso a más de 11,500 pictogramas gratuitos

## 🔧 Compilar para producción

Para crear una versión optimizada para desplegar en un servidor:

```bash
flutter build web
```

Los archivos compilados estarán en `build/web/`

## 📚 Recursos

- **API de ARASAAC**: https://api.arasaac.org/api
- **Portal ARASAAC**: https://arasaac.org
- **Documentación Flutter**: https://flutter.dev

## ❓ Problemas comunes

**La aplicación no inicia:**
- Verifica que Flutter esté instalado: `flutter --version`
- Ejecuta: `flutter pub get`
- Intenta: `flutter clean` y luego `flutter pub get`

**Las imágenes no cargan:**
- Verifica tu conexión a Internet
- La API de ARASAAC debe estar accesible

**Errores de compilación:**
- Ejecuta: `flutter analyze` para ver errores
- Verifica que todas las dependencias estén instaladas

## 🎯 Próximos pasos

Algunas ideas para mejorar la aplicación:

- Añadir soporte para múltiples idiomas
- Implementar favoritos/historial
- Añadir filtros avanzados de búsqueda
- Crear colecciones personalizadas
- Exportar múltiples pictogramas como PDF
- Modo offline con caché local

¡Disfruta explorando los pictogramas de ARASAAC! 🎉
