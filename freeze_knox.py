#!/usr/bin/env python3
"""
Script de contingencia y congelación para Samsung Galaxy Tab Active3 (SM-T575).
Deshabilita la suite de aprovisionamiento remoto de Knox Guard, MDM corporativo,
agentes de telemetría y mecanismos de actualización OTA para prevenir el Error 3020.
"""

import subprocess
import sys

# Lista consolidada de paquetes críticos a neutralizar
KNOX_MDM_PACKAGES = [
    # Núcleo Knox Guard y Enrolamiento Remoto
    "com.samsung.android.kgclient",
    "com.sec.enterprise.knox.cloudmdm.smdms",
    "com.samsung.klmsagent",
    "com.sec.enterprise.knox.attestation",
    "com.samsung.android.knox.attestation",
    
    # MDM y Gestión Corporativa
    "com.samsung.android.mdm",
    "com.sec.enterprise.mdm.services.simpin",
    "com.samsung.android.knox.kpecore",
    "com.samsung.android.knox.containercore",
    "com.samsung.android.knox.containeragent",
    "com.samsung.knox.keychain",
    
    # Telemetría, Logs y Notificaciones Knox
    "com.samsung.android.securitylogagent",
    "com.samsung.android.knox.pushmanager",
    "com.samsung.android.knox.analytics.uploader",
    "com.knox.vpn.proxyhandler",
    "com.samsung.knox.securefolder",
    
    # Agentes de Actualización OTA y Sincronización
    "com.wssyncmldm",
    "com.sec.android.soagent",
    "com.samsung.android.app.omcagent",
]

def check_adb_connection():
    try:
        res = subprocess.run(["adb", "devices"], capture_output=True, text=True, check=True)
        lines = [line for line in res.stdout.strip().splitlines() if line and not line.startswith("*")]
        devices = [line for line in lines[1:] if "\tdevice" in line]
        if not devices:
            print("[-] Error: No se encontró ningún dispositivo conectado y autorizado en ADB.")
            sys.exit(1)
        print(f"[+] Dispositivo detectado: {devices[0].split()[0]}")
    except FileNotFoundError:
        print("[-] Error: El binario 'adb' no está instalado o no se encuentra en el PATH.")
        sys.exit(1)

def freeze_packages():
    print("\n[+] Iniciando proceso de congelación de paquetes (pm disable-user --user 0)...\n")
    success_count = 0
    
    for pkg in KNOX_MDM_PACKAGES:
        # Verificar si el paquete existe en la imagen del sistema
        check = subprocess.run(
            ["adb", "shell", "pm", "list", "packages", "-u", pkg],
            capture_output=True,
            text=True
        )
        matches = [line.replace("package:", "").strip() for line in check.stdout.splitlines()]
        
        if pkg not in matches:
            print(f"  [·] {pkg:<45} -> No instalado en el firmware")
            continue
            
        cmd = ["adb", "shell", "pm", "disable-user", "--user", "0", pkg]
        result = subprocess.run(cmd, capture_output=True, text=True)
        
        if result.returncode == 0 and "disabled-user" in result.stdout:
            print(f"  [✓] {pkg:<45} -> CONGELADO")
            success_count += 1
        else:
            print(f"  [!] {pkg:<45} -> {result.stdout.strip() or result.stderr.strip()}")

    print(f"\n[+] Operación completada: {success_count} paquetes asegurados en estado 'disabled-user'.\n")

if __name__ == "__main__":
    check_adb_connection()
    freeze_packages()
