Muy buena pregunta. Aquí estás entrando en uno de los conceptos fundamentales de Python: **parámetros y argumentos**.

El código de la imagen es:

def square(length):  

for i in range(4):  

forward(length)  

left(90)

## 1. ¿Qué es `length`?

`length` es un **parámetro**.

Un parámetro es una variable que recibe un valor cuando llamamos a la función.

En esta línea:

def square(length):

estás definiendo una función llamada `square` que espera un dato llamado `length`.

---

## 2. ¿Quién recibe el valor?

La función `square()` recibe el valor.

Por ejemplo:

square(50)

Cuando Python ejecuta esto:

square(50)

hace internamente:

length = 50

y luego ejecuta:

for i in range(4):  

forward(50)  

left(90)

---

## 3. ¿Podría llamarse `reina`?

Sí.

El nombre del parámetro es arbitrario. Podría llamarse:

def square(reina):  

for i in range(4):  

forward(reina)  

left(90)

y funcionaría exactamente igual:

square(50)

Aquí Python haría:

reina = 50

y usaría ese valor.

Normalmente se usa `length` porque describe mejor lo que representa: la longitud del lado.

---

## 4. ¿Qué argumento recibe?

El **argumento** es el valor que le pasas al llamar la función.

Ejemplo:

square(50)

- `length` → parámetro
- `50` → argumento

Otro ejemplo:

square(100)

- `length` recibe `100`

---

## 5. ¿Qué ocurre dentro de la función?

Si llamas:

square(100)

Python lo interpreta aproximadamente así:

length = 100  

  

for i in range(4):  

forward(length)  

left(90)

o sea:

for i in range(4):  

forward(100)  

left(90)

y se dibuja un cuadrado de lado 100.

---

## Regla muy importante

No confundas:

def square(length):

con

square(50)

- `length` → parámetro (en la definición)
- `50` → argumento (en la llamada)

Una analogía:

def saludar(nombre):  

print("Hola", nombre)

Aquí `nombre` es el parámetro.

Cuando haces:

saludar("Ardon")

- `"Ardon"` es el argumento.
- `nombre` recibe `"Ardon"`.

Del mismo modo:

square(50)

- `50` es el argumento.
- `length` recibe `50`.

Piensa en el parámetro como una **caja vacía** y en el argumento como el **contenido que metes dentro de la caja cuando llamas la función**.