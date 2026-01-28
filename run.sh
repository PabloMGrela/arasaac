#!/bin/bash
# Script para ejecutar la aplicación ARASAAC Pictogramas

echo "🚀 Iniciando ARASAAC Pictogramas..."
echo ""
echo "La aplicación se abrirá en tu navegador en:"
echo "http://localhost:8080"
echo ""
echo "Presiona Ctrl+C para detener la aplicación"
echo ""

flutter run -d chrome --web-port=8080
