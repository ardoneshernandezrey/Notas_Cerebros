¡Me parece una idea fantástica! Este código es muchísimo más sencillo que el anterior porque no usa decimales ni rangos complejos. Este método se llama **búsqueda por fuerza bruta** o "enumeración exhaustiva". En cristiano: va probando número por número (0, 1, 2, 3...) hasta que choca con la respuesta o se pasa.

Además, aquí respondes tu duda anterior: ¡mira la primera línea de código! Ahí es donde se pide el número `x`.

Vamos a despejar esa niebla paso a paso y con mucha calma.

---

### Paso 1: Pedir el número y empezar la adivinanza

```python
x = int(input('Enter an integer: '))
ans = 0

```

* **`x = int(input(...))`**: Aquí es donde el programa se detiene y te pide a ti que escribas un número entero en el teclado. Vamos a imaginar para todo este ejemplo que tú escribes el número **`8`**. Así que `x = 8`.
* **`ans = 0`**: Al igual que en el código anterior, `ans` es nuestra variable para ir probando respuestas. Pero en lugar de empezar en la mitad de un rango, aquí empezamos desde lo más básico: el número **`0`**.

---

### Paso 2: El bucle de fuerza bruta (`while`)

```python
while ans**3 < abs(x):
    ans = ans + 1

```

Este `while` se traduce como: *"Mientras mi intento al cubo (`ans3`) sea menor que el valor absoluto de `x` (es decir, menor que 8), súmale 1 a mi intento"*.

> **Nota rápida:** Usamos `abs(x)` (valor absoluto) para que, si el usuario escribe un número negativo como `-8`, el programa trabaje con `8` positivo durante la búsqueda y no se rompa.

Vamos a ver cómo corre este bucle vuelta por vuelta con nuestro `x = 8`:

* **Vuelta 1:** `ans` vale `0`. ¿Es `03` (0) menor que `8`? **Sí**.
Entonces entra al bucle y hace `ans = ans + 1`. Ahora `ans` vale **`1`**.
* **Vuelta 2:** `ans` vale `1`. ¿Es `13` (1) menor que `8`? **Sí**.
Entra al bucle y le suma 1. Ahora `ans` vale **`2`**.
* **Vuelta 3:** `ans` vale `2`. ¿Es `23` (8) menor que `8`? **NO**, 8 no es menor que 8, es igual.
Como la condición ya no se cumple, el bucle `while` **se detiene inmediatamente** y pasamos a las líneas de abajo.
*¡Ojo! En este momento exacto, `ans` se quedó valiendo `2`.*

---

### Paso 3: ¿Le atinamos o nos pasamos? (`if / else`)

Cuando el `while` termina, solo pueden haber pasado dos cosas: o encontramos la raíz exacta, o nos pasamos de largo (lo que significaría que el número no tiene una raíz cúbica perfecta, como pasaría si metiéramos un 9).

El código comprueba esto aquí:

```python
if ans**3 != abs(x):
    print(x, 'is not a perfect cube')

```

* **`if ans3 != abs(x):`**: El símbolo `!=` significa "diferente de". Pregunta: ¿Mi intento al cubo (`23 = 8`) es diferente de 8?
* Como no es diferente (son iguales), este `if` se ignora por completo y el código salta directo al `else:`.

---

### Paso 4: Devolver el resultado correcto

```python
else:
    if x < 0:
        ans = -ans
    print('Cube root of', x, 'is', ans)

```

Como estamos en el `else:`, significa que **sí encontramos la raíz perfecta**. Ahora solo falta un último detalle: arreglar el signo si el número original era negativo.

* **`if x < 0:`**: ¿El número que metiste al principio era menor que cero? En nuestro ejemplo metimos `8` (positivo), así que esto no se cumple. Pero si hubieras metido `-8`, este paso transformaría el `2` en `-2` (`ans = -ans`). Matemáticamente es perfecto, porque $-2 \times -2 \times -2 = -8$.
* **`print('Cube root of', x, 'is', ans)`**: Finalmente, el programa imprime en pantalla el resultado.

En nuestra consola veríamos:
`Cube root of 8 is 2`

---

### En resumen: ¿Por qué este código es más fácil?

Porque no tiene variables `low` ni `high`. No calcula mitades. Simplemente dice: *"Empiezo en 0. ¿Me falta? Le sumo 1. ¿Me sigue faltando? Le sumo otro 1..."*. Es una caminata paso a paso hacia adelante hasta llegar al número.

¿Sientes que este enfoque de ir sumando de 1 en 1 te ayuda a ver más claro cómo funcionan los bucles en Python?
