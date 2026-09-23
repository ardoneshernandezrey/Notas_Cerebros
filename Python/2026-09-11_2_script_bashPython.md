```python
# Generar tanto el script en Python como el script en Bash listos para guardar y ejecutar.

python_script_content = '''#!/usr/bin/env python3
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
        devices = [line for line in lines[1:] if "\\tdevice" in line]
        if not devices:
            print("[-] Error: No se encontró ningún dispositivo conectado y autorizado en ADB.")
            sys.exit(1)
        print(f"[+] Dispositivo detectado: {devices[0].split()[0]}")
    except FileNotFoundError:
        print("[-] Error: El binario 'adb' no está instalado o no se encuentra en el PATH.")
        sys.exit(1)

def freeze_packages():
    print("\\n[+] Iniciando proceso de congelación de paquetes (pm disable-user --user 0)...\\n")
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

    print(f"\\n[+] Operación completada: {success_count} paquetes asegurados en estado 'disabled-user'.\\n")

if __name__ == "__main__":
    check_adb_connection()
    freeze_packages()
'''

bash_script_content = '''#!/usr/bin/env bash
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
'''

with open("freeze_knox.py", "w") as f:
    f.write(python_script_content)

with open("freeze_knox.sh", "w") as f:
    f.write(bash_script_content)

print("Archivos generados: freeze_knox.py y freeze_knox.sh")


```

```text
Archivos generados: freeze_knox.py y freeze_knox.sh


```

Tus archivos de respaldo están listos:

Script en Bash:


Script en Python:


---

### Cómo crearlos o ejecutarlos directamente en tu terminal

Puedes descargar los archivos generados o guardarlos directamente con los siguientes comandos en tu terminal:

#### Opción 1: Versión Bash rápida (`freeze_knox.sh`)

Para crearlo y darle permisos de ejecución en tu Mac o entorno Linux:

```bash
cat << 'EOF' > freeze_knox.sh
#!/usr/bin/env bash
set -euo pipefail

if ! command -v adb >/dev/null 2>&1; then
    echo "[-] Error: 'adb' no está instalado o no se encuentra en el PATH." >&2
    exit 1
fi

device_count=$(adb devices | grep -v "List of devices" | grep -c "device" || true)
if [ "$device_count" -lt 1 ]; then
    echo "[-] Error: No se detecta ningún dispositivo autorizado mediante adb." >&2
    exit 1
fi

echo "[+] Dispositivo detectado. Congelando paquetes críticos..."

packages=(
    "com.samsung.android.kgclient"
    "com.sec.enterprise.knox.cloudmdm.smdms"
    "com.samsung.klmsagent"
    "com.sec.enterprise.knox.attestation"
    "com.samsung.android.knox.attestation"
    "com.samsung.android.mdm"
    "com.sec.enterprise.mdm.services.simpin"
    "com.samsung.android.knox.kpecore"
    "com.samsung.android.knox.containercore"
    "com.samsung.android.knox.containeragent"
    "com.samsung.knox.keychain"
    "com.samsung.android.securitylogagent"
    "com.samsung.android.knox.pushmanager"
    "com.samsung.android.knox.analytics.uploader"
    "com.knox.vpn.proxyhandler"
    "com.samsung.knox.securefolder"
    "com.wssyncmldm"
    "com.sec.android.soagent"
    "com.samsung.android.app.omcagent"
)

for pkg in "${packages[@]}"; do
    printf "[-] %-45s ... " "$pkg"
    res=$(adb shell pm disable-user --user 0 "$pkg" 2>/dev/null || true)
    if [[ "$res" == *"disabled-user"* ]]; then
        echo "CONGELADO"
    else
        echo "OMITIDO / NO DISPONIBLE"
    fi
done

echo "[✓] Configuración aplicada exitosamente."
EOF

chmod +x freeze_knox.sh

```

Para correrlo en cualquier momento:

```bash
./freeze_knox.sh

```

---

#### Opción 2: Versión Python (`freeze_knox.py`)

Si prefieres mantenerlo dentro de tus herramientas de Python:

```bash
python3 freeze_knox.py

```

### Qué cubre este conjunto de paquetes:

1. **Knox Guard / Enrolamiento:** Apaga `kgclient`, `cloudmdm.smdms` y los agentes de atestación para impedir que el dispositivo intente registrarse o reportarse a los servidores de Samsung.
2. **MDM / Enterprise:** Neutraliza el núcleo de directivas corporativas (`kpecore`, `mdm`, `containercore`).
3. **Mecanismos OTA:** Deshabilita `wssyncmldm`, `soagent` y `omcagent`, impidiendo que el sistema busque, descargue o instale actualizaciones que reescriban las particiones.
