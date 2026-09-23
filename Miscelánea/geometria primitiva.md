# Guía Teórica y Práctica: Del Pensamiento Geométrico al Algoritmo Iterativo

**Materia:** Introducción a la Ciencia de la Computación / Programación en Python

**Tema:** Razonamiento Algorítmico, Método de Herón (Newton-Raphson) y Ejecución en Terminal

**Propósito:** Documento de estudio, análisis profundo y repaso autodidacta

---

## 1. Fundamentos Teóricos: Conocimiento Declarativo vs. Imperativo

En las ciencias de la computación —y de forma central en el enfoque pedagógico de asignaturas como el *MIT 6.0001*— la resolución de problemas parte de la distinción fundamental entre dos tipos de conocimiento:

### Conocimiento Declarativo (*What is*)

Establece enunciados de verdad o relaciones conceptuales. Nos indica **qué es** un objeto o meta, pero no proporciona los pasos mecánicos para alcanzarlo o construirlo.

> **Ejemplo:**
> *"La raíz cuadrada de un número $x$ es un número $y$ tal que $y \times y = x$."*
> Esta afirmación define de forma precisa la propiedad matemática de la raíz cuadrada, pero no le enseña a un procesador cómo encontrar la cifra exacta partiendo de un número arbitrario.

### Conocimiento Imperativo (*How to*)

Define la receta, el procedimiento o el algoritmo paso a paso que debe ejecutarse para alcanzar una solución. La computadora opera exclusivamente mediante instrucciones imperativas.

> **Ejemplo:**
> *"Toma un número $x$. Asigna una suposición inicial $g$. Divide $x$ entre $g$ para hallar el segundo lado $y$. Promedia $g$ e $y$ para obtener una suposición corregida. Repite este ciclo hasta que $g \times g$ esté lo suficientemente cerca de $x$."*

---

## 2. La Intuición Detrás del Algoritmo: La Pinza Numérica

Para calcular la raíz cuadrada de un número $x$ (por ejemplo, $x = 16$), buscamos un valor $y$ que cumpla $y \cdot y = 16$.

Si conceptualizamos el área total como $16$, podemos ver cualquier intento de multiplicación $y_1 \cdot y_2 = 16$ como las dimensiones de un **rectángulo**:

$$\text{Base} \times \text{Altura} = \text{Área}$$

```
Rectángulo deforme (3 x 5.333):          Cuadrado perfecto (4 x 4):
+-----------------------+               +-----------------+
|                       | 5.333         |                 | 4.0
+-----------------------+               |                 |
          3.0                           +-----------------+
                                               4.0

```

### El principio de la compensación

* Si elegimos una base $g = 3$, la altura resultante debe ser necesariamente $16 / 3 = 5.333$.
* Como $3 \neq 5.333$, la figura no es un cuadrado.
* **Comportamiento de la pinza:**
* Un lado ($3$) queda **por debajo** del valor real ($\sqrt{16} = 4$).
* El otro lado ($5.333$) queda **por encima** del valor real.


* El valor exacto de la raíz cuadrada ($4$) queda **atrapado lógicamente entre ambos extremos**:

$$3 < \mathbf{4} < 5.333$$

### El promedio como fuerza de convergencia

Para equilibrar la figura y acercarla a un cuadrado, el punto medio de los dos lados proporciona una estimación significativamente más cercana:

$$g_{\text{nuevo}} = \frac{\text{Base} + \text{Altura}}{2} = \frac{3 + 5.3333}{2} = 4.1666$$

Al recalcular la nueva altura con este $g_{\text{nuevo}}$:

$$\text{Altura}_{\text{nueva}} = \frac{16}{4.1666} = 3.840$$

La pinza se ha estrechado notablemente:


$$3.840 < \mathbf{4} < 4.1666$$

---

## 3. Simulación Traza Paso a Paso (Iteraciones para $x = 16$, $g_0 = 3$)

A continuación se detalla la traza de ejecución numérica del algoritmo de Herón, observando cómo disminuye el margen de error en cada paso:

| Iteración ($n$) | Base ($g$) | Altura ($y = x / g$) | Error Absoluto ($\vert{}g^2 - x\vert{}$) | Promedio Siguiente ($g_{n+1}$) |
| --- | --- | --- | --- | --- |
| **0 (Inicio)** | $3.0000$ | $5.3333$ | $\vert{}9.0 - 16\vert{} = 7.0000$ | $\frac{3 + 5.3333}{2} = \mathbf{4.1666}$ |
| **1** | $4.1666$ | $3.8400$ | $\vert{}17.3605 - 16\vert{} = 1.3605$ | $\frac{4.1666 + 3.8400}{2} = \mathbf{4.0033}$ |
| **2** | $4.0033$ | $3.9967$ | $\vert{}16.0264 - 16\vert{} = 0.0264$ | $\frac{4.0033 + 3.9967}{2} = \mathbf{4.0000013}$ |
| **3** | $4.0000013$ | $3.9999987$ | $\vert{}16.00001 - 16\vert{} = 0.00001$ | *Evaluación inferior a la tolerancia* |

> **Observación clave:** En solo 3 iteraciones, el error relativo pasa de $7.0$ a $0.00001$. Esta propiedad matemática se denomina **convergencia cuadrática**.

---

## 4. Implementación en Python Comentada

El siguiente script en Python traduce la lógica desarrollada a código ejecutable mediante un bucle `while`:

```python
# ==============================================================================
# Algoritmo de Herón / Newton-Raphson para Cálculo de Raíz Cuadrada
# ==============================================================================

# --- PASO A: Declaración de Variables Iniciales ---
x = 16.0          # Cifra objetivo a la que se calculará la raíz
g = 3.0           # Estimación inicial (suposición)
tolerancia = 0.0001 # Criterio de parada (margen de error máximo aceptable)

# --- PASO B: Cálculo del segundo lado inicial ---
y = x / g         # Divide el área entre la base para obtener la altura

# --- PASOS C y D: Bucle de Corrección Iterativa ---
# La función abs() obtiene el valor absoluto de la diferencia.
# El bucle continúa ejecutándose mientras el error sea superior a la tolerancia.
while abs((g * g) - x) > tolerancia:
    # PASO C: Actualización de 'g' calculando el punto medio
    g = (g + y) / 2
    
    # PASO D: Recálculo del lado 'y' en función del nuevo valor de 'g'
    y = x / g

# --- Salida de Resultados ---
print(f"La raíz cuadrada aproximada de {x} es {g}")

```

### Desglose analítico del bucle:

1. **`abs((g * g) - x)`**: Mide la distancia escalar pura entre el área actual ($g^2$) y el objetivo ($x$), ignorando si el error es positivo o negativo.
2. **`g = (g + y) / 2`**: Reasigna la variable $g$. En memoria, el valor anterior es destruido y reemplazado por la nueva media.
3. **`y = x / g`**: Reajusta de forma inmediata el valor complementario utilizando el nuevo $g$ actualizado en la línea anterior.

---

## 5. Arquitectura del Entorno de Trabajo y Terminal (macOS)

Para integrar la teoría con la ejecución real en máquina, se establecieron y analizaron los siguientes elementos del entorno operativo:

### Estrategia de Gestión de Materiales (MIT OpenCourseWare)

* **Visualización de Cursos descargados (`.zip`):** Al descomprimir los materiales del sitio oficial del MIT, el archivo `index.html` puede abrirse directamente desde la línea de comandos en el navegador nativo mediante:
```bash
open -a Safari index.html

```


* **Integración con Editores de Texto:** Evitar la apertura involuntaria de archivos HTML en editores de consola como Vim/Neovim especificando explícitamente la aplicación objetivo (`-a Safari` o `-a "Google Chrome"`).

### Automatización en Shell (`~/.zshrc`)

Estructura del sistema de notas personalizado tipo *Zettelkasten* configurado en el archivo de entorno `.zshrc`:

```bash
# Directorio base para captura de notas
export NOTAS_DIR="$HOME/Notas_Cerebro"

# Función interactiva para visualización y edición en Markdown
nota() {
    mkdir -p "$NOTAS_DIR"
    if [ -z "$1" ]; then
        echo "📂 Notas recientes en $NOTAS_DIR:"
        ls -lt "$NOTAS_DIR" | head -n 10
    else
        vim "$NOTAS_DIR/$1.md"
    fi
}

```

---

## 6. Síntesis Pedagógica para el Repaso

1. **La computadora no adivina:** Requiere un algoritmo iterativo que reduzca sistemáticamente el margen de error.
2. **El patrón de actualización de variables:** En programación, en lugar de declarar variables infinitas ($g_1, g_2, g_3$), se **reutiliza y sobreescribe** la memoria dentro de un bucle (`g = (g + y) / 2`).
3. **El criterio de convergencia:** Los bucles de cálculo numérico no buscan la igualdad exacta `g * g == x` (debido a limitaciones de precisión en punto flotante), sino que verifican que la diferencia sea inferior a una **tolerancia** prefijada (`abs(error) < tolerancia`).
