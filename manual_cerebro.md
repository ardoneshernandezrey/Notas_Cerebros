# 🧠 PROTOCOLO DEL CEREBRO DIGITAL (v1.0)
# Autor: Ardon
# Herramientas: Zsh + Vim + Grep (Sin bloatware)

## 1. FILOSOFÍA
Este sistema está diseñado para eliminar la fricción.
- **Captura:** Papel y lápiz (mientras estudio).
- **Procesamiento:** Terminal y Vim (al finalizar).
- **Almacenamiento:** Texto plano (.md) en `~/Notas_Cerebro`.
- **Objetivo:** Aprender Python e Inglés, no configurar herramientas.

---

## 2. COMANDOS DEL SISTEMA
Estas son las funciones personalizadas que viven en mi `.zshrc`.

### 📝 A. Crear / Editar Notas
Comando: `nota [nombre_del_tema]`
- **Uso:** `nota python_listas`
- **Acción:** Abre Vim. Si la nota no existe, la crea. Si existe, la edita.
- **Regla de Oro:** Usar guiones bajos `_` en lugar de espacios.

### 📂 B. Ver Notas Recientes
Comando: `nota` (sin argumentos)
- **Acción:** Muestra una lista de las últimas notas modificadas. Útil para retomar donde lo dejé.

### 🔎 C. Buscador (Google Personal)
Comando: `buscar [palabra_clave]`
- **Uso:** `buscar diccionarios`
- **Acción:** Busca esa palabra DENTRO de todos los archivos en `~/Notas_Cerebro`.
- **Salida:** Muestra el nombre del archivo y la línea exacta donde aparece.

### 📔 D. Bitácora / Diario
Comando: `diario "texto entre comillas"`
- **Uso:** `diario "Hoy entendí los bucles while"`
- **Acción:** Añade la fecha y el texto al final del archivo `diario.md` automáticamente.
- **Nota:** No abre Vim, es solo para captura rápida.

---

## 3. FLUJO DE TRABAJO (WORKFLOW)

### Paso 1: Estudio Activo (Consumo)
**Contexto:** Viendo video de "Píldoras Informáticas" o leyendo "English Grammar".
- **Herramienta:** Libreta física y bolígrafo.
- **Acción:** Tomar notas sucias, diagramas y dudas. No tocar el ordenador.

### Paso 2: Consolidación (Producción)
**Contexto:** Al terminar la lección o al día siguiente.
- **Acción:** Abrir terminal.
- **Comando:** `nota py_tema_nuevo` o `nota eng_tema_nuevo`.
- **Tarea:** Transcribir SOLO los conceptos clave y ejemplos de código. Traducir lo aprendido a mis propias palabras.

### Paso 3: Recuperación (Consulta)
**Contexto:** Programando en Jupyter Lab y olvidé la sintaxis.
- **Acción:** No ir a Google. Ir a mi terminal.
- **Comando:** `buscar sintaxis`.
- **Resultado:** Refuerzo mi propia memoria y mis propios apuntes.

---

## 4. MANTENIMIENTO
Si alguna vez necesito cambiar la carpeta de notas o ajustar los comandos:
1. Editar configuración: `vim ~/.zshrc`
2. Buscar la sección: `# 🧠 CEREBRO DIGITAL`
3. Guardar cambios: `:wq`
4. Recargar cerebro: `source ~/.zshrc`

---
*"La herramienta es el medio, el conocimiento es el fin."*
