#!/usr/bin/env bash
# ==============================================================================
# Script de contingencia y congelación para Samsung Galaxy Tab Active3 (SM-T575)
# Deshabilita la suite de Knox Guard, MDM, telemetría y agentes OTA.
# ==============================================================================

set -euo pipefail

# Comprobar presencia de adb
if ! command -v adb >/dev/null 2>&1; then
    echo "[-] Error: 'adb' no está instalado o no está en el PATH." >&2
    exit 1
fi

# Comprobar dispositivo
device_count=$(adb devices | grep -v "List of devices" | grep -c "device" || true)
if [ "$device_count" -lt 1 ]; then
    echo "[-] Error: No se detecta ningún dispositivo autorizado mediante adb." >&2
    exit 1
fi

echo "[+] Dispositivo conectado. Procediendo a congelar paquetes Knox / MDM / OTA..."
echo ""

packages=(
    # Núcleo Knox Guard y Enrolamiento Remoto
    "com.samsung.android.kgclient"
    "com.sec.enterprise.knox.cloudmdm.smdms"
    "com.samsung.klmsagent"
    "com.sec.enterprise.knox.attestation"
    "com.samsung.android.knox.attestation"
    
    # MDM y Gestión Corporativa
    "com.samsung.android.mdm"
    "com.sec.enterprise.mdm.services.simpin"
    "com.samsung.android.knox.kpecore"
    "com.samsung.android.knox.containercore"
    "com.samsung.android.knox.containeragent"
    "com.samsung.knox.keychain"
    
    # Telemetría, Logs y Notificaciones Knox
    "com.samsung.android.securitylogagent"
    "com.samsung.android.knox.pushmanager"
    "com.samsung.android.knox.analytics.uploader"
    "com.knox.vpn.proxyhandler"
    "com.samsung.knox.securefolder"
    
    # Agentes de Actualización OTA y Sincronización
    "com.wssyncmldm"
    "com.sec.android.soagent"
    "com.samsung.android.app.omcagent"
)

for pkg in "${packages[@]}"; do
    printf "[-] Procesando: %-45s ... " "$pkg"
    # Ejecutar disable-user para el usuario 0
    res=$(adb shell pm disable-user --user 0 "$pkg" 2>/dev/null || true)
    if [[ "$res" == *"disabled-user"* ]]; then
        echo "CONGELADO"
    else
        echo "OMITIDO / NO PRESENTE"
    fi
done

echo ""
echo "[✓] Proceso finalizado con éxito."
