#!/bin/bash

# Script de despliegue para Infinity Task Protocol en ICP local
# Basado en las instrucciones de despliegue proporcionadas.

# Salir inmediatamente si un comando falla
set -e

echo "Iniciando el proceso de despliegue local de Infinity Task Protocol..."

echo "1. Clonando el repositorio de Infinity Task Protocol..."
#
git clone https://github.com/Infinity-Task-Protocol/Infinity-task-protocol.git
echo "   Repositorio clonado."

# Navegar al directorio del proyecto
PROJECT_DIR="Infinity-task-protocol"
if [ ! -d "$PROJECT_DIR" ]; then
    echo "Error: El directorio $PROJECT_DIR no fue clonado correctamente. Asegúrate de tener Git instalado y acceso al repositorio."
    exit 1
fi
echo "2. Navegando al directorio del proyecto: $PROJECT_DIR"
#
cd "$PROJECT_DIR"
echo "   Ubicación actual: $(pwd)"

echo "3. Iniciando DFX en modo limpio y en segundo plano..."
#
dfx start --clean --background
echo "   DFX iniciado. Esto puede tomar unos segundos..."

echo "4. Generando código del backend (candid Rust/TypeScript)..."
#
dfx generate backend
echo "   Código del backend generado."

echo "5. Descargando dependencias de DFX..."
#
dfx deps pull
echo "   Dependencias de DFX descargadas."

echo "6. Inicializando dependencia Internet Identity (para autenticación de usuarios)..."
#
dfx deps init internet_identity
echo "   Internet Identity inicializado."

echo "7. Inicializando dependencia ICP Ledger para entorno local..."
# El argumento está en una sola línea y correctamente entrecomillado para el shell.
dfx deps init icp_ledger --argument "(variant { Init = record { minting_account = \"$(dfx ledger account-id)\"; initial_values = vec {}; send_whitelist = vec {}; transfer_fee = opt record { e8s = 10_000 : nat64; }; token_symbol = opt \"LICP\"; token_name = opt \"Local ICP\"; } })"
echo "   ICP Ledger inicializado."

echo "8. Desplegando dependencias (Internet Identity y ICP Ledger)..."
#
dfx deps deploy
echo "   Dependencias desplegadas."

echo "9. Desplegando el canister principal del backend (main.mo)..."
#
dfx deploy backend
echo "   Backend desplegado."

echo "10. Navegando al directorio del frontend para construir la aplicación web..."
#
cd src/frontend
echo "    Cambiado al directorio del frontend: $(pwd)"

echo "11. Instalando dependencias de Node.js para el frontend..."
#
npm install
echo "    Dependencias de frontend instaladas."

echo "12. Construyendo la aplicación frontend para producción..."
#
npm run build
echo "    Aplicación frontend construida."

echo "--------------------------------------------------------"
echo "Proceso de despliegue local de Infinity Task Protocol completado con éxito."
echo "La Dapp ahora debería estar accesible a través del puerto local de DFX."
echo "Puedes detener DFX en cualquier momento con el comando 'dfx stop' desde la raíz del proyecto."
echo "--------------------------------------------------------"
