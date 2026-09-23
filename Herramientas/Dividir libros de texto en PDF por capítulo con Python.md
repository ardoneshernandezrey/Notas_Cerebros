# Guía: dividir libros de texto en PDF por capítulo con Python

Esta guía documenta el proceso completo que construimos y probamos contra tres libros de texto distintos (Yamada, Sleisenger, Kandel). No es una receta rígida — cada libro tiene su propia estructura interna, y el paso 3 (verificación del outline) es precisamente el punto donde hay que mirar antes de asumir nada.

---

## 0. Mecanismo general: por qué esto funciona sin herramientas de pago

Un PDF no tiene "capítulos" como concepto — es una colección de páginas identificadas por número, más un índice opcional de navegación llamado **outline** (`outline` — /áut-lain/), que en la mayoría de los lectores se ve como los "marcadores" o "bookmarks" (`bookmark` — /búk-mark/) en el panel lateral. Ese outline es lo que la editorial usó para que el lector salte directo a "Capítulo 5" al hacer clic.

Cada entrada del outline apunta a una página real del PDF. Si el libro tiene ese outline (la mayoría de los libros académicos de editoriales grandes —Wiley, Elsevier, McGraw-Hill— sí lo traen), podemos leerlo programáticamente: extraer el par (título del capítulo, página donde empieza), y usar la diferencia entre el inicio de un capítulo y el inicio del siguiente para saber dónde termina cada uno. Con eso, copiar el rango de páginas correspondiente a un archivo nuevo es mecánico.

Las herramientas de pago (iLovePDF, Adobe, etc.) hacen exactamente esto por detrás. La diferencia es que aquí lo controlas tú, sin límite de páginas ni marca de agua.

---

## 1. Prerrequisitos (una sola vez)

### 1.1 — Instalar Miniconda (si no lo tienes)

Conda gestiona un entorno de Python aislado. Es preferible a `pip` global porque un entorno roto no te deja sin `python` en todo el sistema — solo dentro de ese entorno específico.

### 1.2 — Crear el entorno de trabajo (una sola vez, se reutiliza para todos los libros)

```bash
# Creamos un entorno llamado "split_pdf" con Python 3.11 — aislado del resto del sistema
conda create -n split_pdf python=3.11

# Lo activamos — mientras esté activo, "python" y "pip" apuntan a ESTE entorno
conda activate split_pdf
```

### 1.3 — Instalar las librerías necesarias

```bash
# python -m pip fuerza a usar el pip asociado a ESTE python específico
# (evita el conflicto de PATH entre Homebrew y conda que ya nos pasó una vez)
python -m pip install pypdf pymupdf
```

- `pypdf`: lee la estructura del PDF (outline, páginas) y escribe archivos nuevos.
- `pymupdf` (se importa como `fitz`): necesario más adelante para extraer texto respetando el orden de columnas.

### 1.4 — Instalar herramientas externas de reparación y extracción de texto (Homebrew)

```bash
brew install qpdf poppler
```

- `qpdf`: repara PDFs con la tabla de referencias (`xref`) dañada — necesario cuando `pypdf` lanza `PdfReadError` al abrir el archivo.
- `poppler`: trae `pdftotext`, útil para una extracción de texto rápida con la bandera `-layout`.

---

## 2. Por cada libro nuevo: crear carpeta y ubicar el PDF

```bash
cd ~/proyectos
mkdir split_NOMBRE_DEL_LIBRO
cd split_NOMBRE_DEL_LIBRO

# Copia el PDF aquí con un nombre simple, sin espacios ni caracteres raros
# (si el archivo original tiene una ruta con espacios, envuélvela en comillas dobles)
cp "/ruta/con espacios/al archivo original.pdf" libro.pdf

conda activate split_pdf
which python   # debe mostrar una ruta con "envs/split_pdf"
```

**Por qué renombrar:** trabajar con `libro.pdf` en vez del nombre original (largo, con espacios, a veces con apóstrofes) evita errores de sintaxis en bash y hace que los scripts sean reutilizables sin modificar rutas cada vez.

---

## 3. Verificar si el PDF tiene outline

Este es el paso que determina todo lo que sigue. No se asume — se verifica.

```python
# verificar_outline.py
from pypdf import PdfReader

reader = PdfReader("libro.pdf")
outline = reader.outline

print(f"Elementos en el outline: {len(outline)}")
print(outline[:5])
```

```bash
python verificar_outline.py
```

### 3.1 — Si aparece `PdfReadError` o `incorrect startxref pointer`

El archivo tiene la tabla de referencias internas dañada (común en PDFs bajados de repositorios). Repáralo antes de continuar:

```bash
# --replace-input reescribe el mismo archivo con una estructura interna reconstruida desde cero
qpdf --replace-input libro.pdf
```

Vuelve a correr `verificar_outline.py`. Si los errores desaparecen, sigues normal. Esto nos pasó con Kandel — 225 MB con varios objetos de color mal formados en las figuras — y `qpdf` lo resolvió sin pérdida de contenido.

### 3.2 — Si `len(outline) == 0`

No hay outline embebido. El método cambia: hay que extraer texto de las primeras 15-20 páginas para localizar visualmente la tabla de contenidos y mapear capítulos a mano contra el número de página. Esto no lo necesitamos en ninguno de los tres libros trabajados, pero es la alternativa si te encuentras un PDF sin outline.

---

## 4. Listar el outline completo con su nivel de anidamiento

El outline puede ser plano (Yamada: capítulo tras capítulo, sin agrupar) o anidado (Sleisenger y Kandel: Partes que contienen Capítulos que contienen Secciones). Hay que verlo antes de decidir qué nivel filtrar.

```python
# listar_outline_completo.py
from pypdf import PdfReader

reader = PdfReader("libro.pdf")

def aplanar_outline(items, nivel=0):
    """
    Recorre el outline de forma recursiva porque puede tener sub-listas anidadas
    (ej: Parte -> Capítulo -> Sección). nivel indica la profundidad de cada elemento.
    """
    resultado = []
    for item in items:
        if isinstance(item, list):
            resultado.extend(aplanar_outline(item, nivel + 1))
        else:
            pagina = reader.get_destination_page_number(item)
            resultado.append((nivel, item.title, pagina))
    return resultado

plano = aplanar_outline(reader.outline)

for i, (nivel, titulo, pagina) in enumerate(plano):
    sangria = "  " * nivel
    print(f"{i:>4}  nivel={nivel}  pagina_pdf={pagina:>5}  {sangria}{titulo}")
```

```bash
python listar_outline_completo.py > outline_completo.txt
```

Revisa el archivo resultante y responde una pregunta antes de seguir: **¿en qué nivel están los capítulos reales, y hay algo mezclado en ese mismo nivel que no sea un capítulo?**

### Casos ya vistos

| Libro | Estructura | Filtro usado |
|---|---|---|
| Yamada | Outline plano; IDs ya son `'1'`, `'2'`... limpios | `titulo.isdigit()` |
| Sleisenger | Partes en nivel 0, capítulos en nivel 1 con título completo | `nivel == 1` |
| Kandel | Partes en nivel 0; nivel 1 mezcla capítulos numerados CON apéndices con letra y entradas de índice alfabético | `nivel == 1` **y** `re.match(r'^\d+\s', titulo)` |

Kandel es el caso más instructivo: filtrar solo por nivel no bastaba porque los apéndices ("A: Review of...") y las 26 letras del índice también viven en nivel 1. Hubo que añadir el patrón "empieza con dígito" para aislar solo los capítulos numerados.

**No hay un filtro universal.** Cada libro exige mirar la salida de este paso y decidir la condición correcta antes de generar nada.

---

## 5. Generar los PDFs por capítulo

Plantilla base — ajusta el filtro de `capitulos` según lo que confirmaste en el paso 4:

```python
# generar_pdfs_capitulos.py
from pypdf import PdfReader, PdfWriter
# import re   # descomenta si necesitas filtrar por patrón de texto (caso Kandel)

reader = PdfReader("libro.pdf")

def aplanar_outline(items, nivel=0):
    resultado = []
    for item in items:
        if isinstance(item, list):
            resultado.extend(aplanar_outline(item, nivel + 1))
        else:
            pagina = reader.get_destination_page_number(item)
            resultado.append((nivel, item.title, pagina))
    return resultado

plano = aplanar_outline(reader.outline)

# --- AJUSTA ESTA LÍNEA según el caso de tu libro (ver tabla del paso 4) ---
capitulos = [(titulo, pagina) for nivel, titulo, pagina in plano if nivel == 1]

total_paginas = len(reader.pages)

# El FINAL de cada capítulo no está en el outline — se infiere como la página
# anterior al inicio del siguiente capítulo. El último capítulo usa el total de páginas.
rangos = []
for i, (titulo, inicio) in enumerate(capitulos):
    if i + 1 < len(capitulos):
        fin = capitulos[i + 1][1] - 1
    else:
        fin = total_paginas - 1
    rangos.append((i + 1, titulo, inicio, fin))

# --- Front matter: desde la página 0 hasta justo antes del primer capítulo ---
inicio_fm = 0
fin_fm = capitulos[0][1] - 1
writer = PdfWriter()
for p in range(inicio_fm, fin_fm + 1):
    writer.add_page(reader.pages[p])
with open("00_frontmatter.pdf", "wb") as salida:
    writer.write(salida)
print(f"00_frontmatter.pdf: paginas {inicio_fm}-{fin_fm}")

# --- Un archivo por capítulo ---
for numero, titulo, inicio, fin in rangos:
    writer = PdfWriter()
    for p in range(inicio, fin + 1):
        writer.add_page(reader.pages[p])
    # zero-padding (relleno con ceros) para que el orden alfabético coincida con el numérico
    nombre = f"capitulo_{numero:03d}.pdf"
    with open(nombre, "wb") as salida:
        writer.write(salida)
    print(f"{nombre}: paginas PDF {inicio}-{fin}  ({fin - inicio + 1} paginas)  [{titulo}]")
```

```bash
python generar_pdfs_capitulos.py
```

---

## 6. Verificar integridad (obligatorio, no opcional)

Confirma que la suma de páginas de todos los fragmentos coincide con el total del original — detecta páginas perdidas o duplicadas que un vistazo manual no atrapa.

```python
# verificar_integridad.py
from pypdf import PdfReader
import os

original = PdfReader("libro.pdf")
total_original = len(original.pages)

# Filtramos por PATRÓN de nombre de fragmento generado, no por excluir el original por nombre
# (excluir por nombre exacto falla si hay diferencias de mayúsculas/minúsculas)
archivos_generados = sorted(
    f for f in os.listdir(".")
    if f.endswith(".pdf") and (f.startswith("capitulo_") or f.startswith("00_") or f.startswith("99_"))
)

suma_paginas = sum(len(PdfReader(f).pages) for f in archivos_generados)

print(f"Archivos contados como fragmentos: {len(archivos_generados)}")
print(f"Páginas en el original: {total_original}")
print(f"Suma de páginas en los fragmentos: {suma_paginas}")
print("OK: coincide exactamente" if suma_paginas == total_original else "ALERTA: hay discrepancia")
```

```bash
python verificar_integridad.py
```

Si da "ALERTA", la discrepancia casi siempre es una de estas dos causas (ambas nos pasaron):
- El PDF original quedó incluido sin querer en el conteo de fragmentos (comparación de nombre sensible a mayúsculas).
- Alguna sección del libro (front matter, apéndices) quedó fuera del rango cubierto por los capítulos y no se generó su propio archivo.

---

## 7. (Opcional) Índice de referencia rápida

Para no tener que abrir cada PDF a ciegas cuando buscas un tema:

```python
# construir_indice.py
from pypdf import PdfReader
import os

archivos = sorted(f for f in os.listdir(".") if f.startswith("capitulo_") and f.endswith(".pdf"))
lineas_indice = []

for archivo in archivos:
    reader = PdfReader(archivo)
    primera_pagina = reader.pages[0].extract_text()
    resumen = " ".join(primera_pagina.split("\n")[:2]).strip()
    lineas_indice.append(f"{archivo}: {resumen}")

with open("indice_capitulos.md", "w") as salida:
    salida.write("\n".join(lineas_indice))
```

Uso desde terminal, sin abrir nada:

```bash
grep -i "palabra clave" indice_capitulos.md
```

---

## 8. Extraer texto de un capítulo para lectura o traducción

### 8.1 — Por qué `pdftotext -layout` no siempre basta

Un PDF no tiene concepto de "orden de lectura" — cada letra está posicionada por coordenadas (x, y), sin saber que forma parte de una columna. En un libro a dos columnas, si dos bloques de texto están a la misma altura vertical, un extractor simple los intercala línea por línea, mezclando dos ideas distintas de columnas opuestas. `pdftotext -layout` reduce el problema pero no lo elimina.

### 8.2 — Extracción por bloques con PyMuPDF (mejor para dos columnas)

```python
# extraer_texto_columnas.py
import sys
import fitz  # nombre de importación del paquete pymupdf

numero = sys.argv[1]
pdf_origen = f"capitulo_{int(numero):03d}.pdf"
md_destino = f"capitulo_{int(numero):03d}.md"

doc = fitz.open(pdf_origen)
texto_completo = []

for pagina in doc:
    ancho_pagina = pagina.rect.width
    punto_medio = ancho_pagina / 2

    bloques = pagina.get_text("blocks")  # cada bloque: (x0, y0, x1, y1, texto, ...)

    # Separamos por columna según de qué lado del punto medio empieza cada bloque (x0)
    columna_izq = sorted([b for b in bloques if b[0] < punto_medio], key=lambda b: b[1])
    columna_der = sorted([b for b in bloques if b[0] >= punto_medio], key=lambda b: b[1])

    # Reconstruimos: toda la columna izquierda primero, luego toda la derecha
    for bloque in columna_izq + columna_der:
        texto_completo.append(bloque[4])

with open(md_destino, "w") as salida:
    salida.write("\n".join(texto_completo))
```

```bash
python extraer_texto_columnas.py 14
```

Este método asume que toda la página tiene el mismo layout de dos columnas — revisa la primera página de cada capítulo (suele tener un bloque de título a ancho completo) por si necesita ajuste manual.

### 8.3 — Limpieza de ruido tipográfico

```python
# limpiar_texto.py
import sys
import re

numero = sys.argv[1]
archivo = f"capitulo_{int(numero):03d}.md"

with open(archivo) as f:
    texto = f.read()

# Soft hyphen (­, U+00AD) = guion invisible de justificación que rompe palabras al extraer.
# Aparece en DOS posiciones posibles según dónde cortó el bloque de PyMuPDF:
texto = re.sub(r"­\n", "", texto)   # caso: "word­\n" + "next"  -> palabra partida al FINAL del bloque
texto = re.sub(r"\n­", "", texto)   # caso: "the \n­largest"    -> palabra partida al INICIO del bloque siguiente

# Reduce 3+ saltos de línea consecutivos a un separador de párrafo limpio
texto = re.sub(r"\n{3,}", "\n\n", texto)

with open(archivo, "w") as f:
    f.write(texto)
```

```bash
python limpiar_texto.py 14
```

Verificación de que no quedó ningún soft hyphen suelto:

```bash
python3 -c "
with open('capitulo_014.md', encoding='utf-8') as f:
    print('soft hyphens restantes:', f.read().count(chr(0xAD)))
"
```

---

## 9. Problemas reales que ya resolvimos (referencia rápida)

| Síntoma | Causa | Solución |
|---|---|---|
| `ModuleNotFoundError: No module named 'pypdf'` | El entorno conda no estaba activo en esa terminal, o se cerró y se abrió una nueva | `conda activate split_pdf`, verificar con `which python` |
| `error: externally managed environment` al hacer `pip install` | El `pip` que resolvió el `PATH` era el de Homebrew, no el del entorno conda activo | Usar `python -m pip install ...` en vez de `pip install ...` directo |
| `PdfReadError` / `incorrect startxref pointer` al abrir el PDF | Tabla de referencias internas (`xref`) dañada, común en descargas de repositorios | `qpdf --replace-input libro.pdf` |
| `ALERTA: hay discrepancia` en la verificación de integridad | El PDF original se contó como si fuera un fragmento más (comparación de nombre sensible a mayúsculas) | Filtrar fragmentos por patrón de nombre (`capitulo_`, `00_`), no por excluir el original por nombre exacto |
| Texto de dos columnas mezclado línea por línea | `pdftotext -layout` no distingue columnas a la misma altura vertical | Usar `extraer_texto_columnas.py` (PyMuPDF, agrupa por bloque y columna) |
| Palabras partidas con un carácter raro (`­`) | Soft hyphen de justificación tipográfica, capturado como texto visible | `limpiar_texto.py`, cubriendo ambos lados de la frontera del bloque |
| Archivo generado pero "no aparece" en Finder | Finder estaba navegado a otra carpeta, no a la de trabajo | `pwd` en terminal para la ruta exacta, luego `Cmd+Shift+G` en Finder y pegarla |
| `Warning: Invalid Font Weight` (o similar) durante extracción | Metadata de fuente mal codificada en el PDF original — no afecta el texto extraído | Ignorar, o silenciar con `stderr=subprocess.DEVNULL` si usas `pdftotext` vía `subprocess` |

---

## Resumen del flujo completo

```
verificar_outline.py  →  (si falla: qpdf --replace-input)
        ↓
listar_outline_completo.py  →  decidir el filtro correcto para ESTE libro
        ↓
generar_pdfs_capitulos.py
        ↓
verificar_integridad.py  →  debe dar "OK"
        ↓
(opcional) construir_indice.py
        ↓
(por capítulo, según necesites leer/traducir)
extraer_texto_columnas.py N  →  limpiar_texto.py N
```

Nada de esto se automatiza a ciegas de principio a fin — el paso 4 (decidir el filtro) exige mirar la salida real de cada libro antes de generar nada. Esa verificación intermedia es la que evitó, en el caso de Kandel, que apéndices e índice terminaran mezclados con los capítulos.
