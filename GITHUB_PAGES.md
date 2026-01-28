# Configuración de GitHub Pages

Este documento explica cómo completar la configuración de GitHub Pages para tu aplicación Flutter.

## ✅ Cambios realizados

Se ha creado automáticamente:

1. **Workflow de GitHub Actions** (`.github/workflows/deploy.yml`)
   - Compila la aplicación Flutter para web
   - Despliega automáticamente a GitHub Pages
   - Se ejecuta en cada push a la rama `main`
   - También se puede ejecutar manualmente

2. **Actualización del README.md**
   - Añadido enlace a la demo en vivo
   - Añadida sección sobre el despliegue automático

## 🔧 Configuración necesaria en GitHub

Para que el despliegue funcione, necesitas **habilitar GitHub Pages** en tu repositorio:

### Pasos a seguir:

1. **Fusiona el Pull Request**
   - Primero, fusiona este PR en la rama `main`
   - Esto añadirá el workflow de GitHub Actions al repositorio

2. **Ve a tu repositorio en GitHub**
   - https://github.com/PabloMGrela/arasaac

3. **Accede a Settings (Configuración)**
   - Haz clic en la pestaña "Settings" en la parte superior

4. **Configura GitHub Pages**
   - En el menú lateral izquierdo, busca y haz clic en "Pages"
   - En la sección "Build and deployment":
     - **Source**: Selecciona "GitHub Actions"
   - Guarda los cambios

5. **Ejecuta el workflow manualmente (opcional)**
   - Ve a la pestaña "Actions"
   - Selecciona "Deploy Flutter Web to GitHub Pages"
   - Haz clic en "Run workflow" y selecciona la rama `main`
   - O simplemente espera al próximo push a `main` para que se ejecute automáticamente

6. **Espera el despliegue**
   - El workflow tardará unos minutos en ejecutarse
   - Puedes ver el progreso en la pestaña "Actions" del repositorio
   - Una vez completado, tu aplicación estará disponible en:
     - **https://pablomgrela.github.io/arasaac/**

## 📋 Verificación

Después de que el workflow se complete:

1. Ve a la pestaña "Actions" en tu repositorio
2. Deberías ver un workflow exitoso llamado "Deploy Flutter Web to GitHub Pages"
3. Visita https://pablomgrela.github.io/arasaac/ para ver tu aplicación en vivo

## 🔄 Despliegues futuros

Una vez configurado, cada vez que hagas push a la rama `main`:
- El workflow se ejecutará automáticamente
- La aplicación se recompilará
- Los cambios se desplegarán a GitHub Pages

## 🛠️ Ejecutar el workflow manualmente

También puedes ejecutar el workflow manualmente:

1. Ve a "Actions" en tu repositorio
2. Selecciona "Deploy Flutter Web to GitHub Pages" en el menú lateral
3. Haz clic en "Run workflow"
4. Selecciona la rama `main`
5. Haz clic en "Run workflow"

## 📝 Notas importantes

- **Base href**: El workflow está configurado con `--base-href="/arasaac/"` porque GitHub Pages sirve el sitio desde `https://username.github.io/repository-name/`
- **Permisos**: El workflow ya tiene los permisos necesarios configurados (`pages: write`, `id-token: write`)
- **Cache**: Flutter SDK se cachea para acelerar los builds futuros

## ❓ Solución de problemas

Si el despliegue falla:

1. **Revisa los logs del workflow**:
   - Ve a "Actions" → selecciona el workflow fallido → revisa los logs

2. **Verifica los permisos**:
   - Settings → Actions → General → Workflow permissions
   - Asegúrate de que "Read and write permissions" está habilitado

3. **Verifica GitHub Pages**:
   - Settings → Pages
   - Confirma que "Source" está configurado como "GitHub Actions"

## 🎉 ¡Listo!

Una vez completados estos pasos, tu aplicación Flutter estará desplegada en GitHub Pages y se actualizará automáticamente con cada cambio en la rama `main`.
