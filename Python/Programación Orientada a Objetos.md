# Guía de Estudio: Programación Orientada a Objetos - Clases en Python

Esta guía proporciona un enfoque práctico y estructurado para comprender las clases en Python, utilizando los principios de claridad y el enfoque 80/20 del material original de _Python Basics_.

## 1. Introducción a las Clases y Objetos

En Python, cada valor tiene un **tipo de dato**. Como se establece en el Capítulo 4.1, las cadenas de texto son del tipo `str` y los números enteros son `int`. Una **clase** es, esencialmente, un nuevo tipo de dato definido por el programador que sirve como "plantilla" para crear objetos.

Cuando utilizas la función `type()` en la ventana interactiva (REPL), Python te indica a qué clase pertenece un objeto:

```python
>>> type("Hola Mundo")
<class 'str'>
>>> type(42)
<class 'int'>
>>> type(3.14)
<class 'float'>
```

Al crear una clase, estás definiendo un nuevo tipo de objeto que puede tener sus propias características y comportamientos únicos, extendiendo las capacidades del lenguaje más allá de los tipos integrados.

## 2. Definición de una Clase

Para crear una clase propia, se utiliza la palabra clave `class` seguida del nombre de la clase (usualmente en _PascalCase_).

Siguiendo la estructura de la **anatomía de una función** (Capítulo 6.2), una clase se compone de una firma (signature) y un cuerpo. La firma termina con dos puntos (`:`) y el cuerpo de la clase debe estar indentado. Al igual que en las funciones y estructuras de control, la indentación estándar es de **cuatro espacios**.

```python
class Dog:
    # El cuerpo de la clase comienza aquí, indentado con 4 espacios
    pass
```

**Nota:** La palabra clave `pass` se utiliza como un marcador de posición cuando el cuerpo de una clase o función aún no tiene código, evitando errores de sintaxis mientras diseñas la estructura.

## 3. Instanciación: Creando Objetos a partir de Clases

Una clase funciona como un plano o "blueprint". El proceso de crear un objeto específico a partir de esa plantilla se llama **instanciación**.

A diferencia de las variables literales vistas en los Capítulos 4 y 5 (donde asignas un valor directamente como `x = 5`), para instanciar una clase llamas al nombre de la clase seguido de paréntesis, de forma similar a como llamarías a una función:

```python
>>> mi_perro = Dog()
>>> type(mi_perro)
<class '__main__.Dog'>
```

Aquí, `mi_perro` es una **instancia** u objeto específico de la clase `Dog`.

## 4. El Método `__init__` y el parámetro `self`

Para que los objetos tengan un **estado** inicial (datos como nombre o edad), se utiliza el método especial `__init__`. Este es el "inicializador" que Python ejecuta automáticamente al momento de la instanciación.

- `**__init__**`: Define cómo se construye el objeto y qué datos necesita al nacer.
- `**self**`: Representa a la instancia específica que se está creando. Permite que el código dentro de la clase acceda y asigne atributos al objeto actual.

**Nota:** Siguiendo las guías de estilo **PEP 8** (mencionadas en el Capítulo 3.3), el uso de `self` es una convención técnica que debe seguirse rigurosamente. Aunque técnicamente podrías usar otro nombre, `self` es el estándar que garantiza que tu código sea legible para otros programadores.

```python
class Dog:
    def __init__(self, name, age):
        self.name = name  # Atributo de instancia
        self.age = age    # Atributo de instancia
```

## 5. Atributos de Instancia vs. Atributos de Clase

Es fundamental diferenciar el origen y el acceso a los datos. En POO, los atributos representan el **Estado** del objeto.

- **Atributos de Instancia:** Se definen dentro de `__init__` usando `self.nombre`. Son únicos para cada objeto (ej. cada perro tiene su propio nombre).
- **Atributos de Clase:** Se definen fuera de cualquier método. Son compartidos por todas las instancias de la clase (ej. la especie).

**Resolución de Scope (Regla LEGB):** Al igual que en el Capítulo 6.6, Python utiliza una jerarquía para encontrar nombres. Si buscas un atributo en una instancia y no existe, Python subirá al nivel de la clase (siguiendo la lógica de **Enclosing Scope** o alcance envolvente) para intentar encontrarlo allí.

- **Instancia:** Cambiar `self.name` solo afecta a ese perro.
- **Clase:** Cambiar un atributo de clase (como `species = "Canis familiaris"`) afecta la percepción de todas las instancias que no tengan ese atributo definido localmente.

## 6. Métodos de Instancia: Comportamiento de los Objetos

Los métodos son funciones definidas dentro de una clase que determinan el **Comportamiento** del objeto (qué puede _hacer_). Al definirlos, siempre deben incluir `self` como primer parámetro para poder interactuar con los datos del objeto.

Puedes utilizar **f-strings** (Capítulo 4.7) para mostrar información del estado del objeto de forma dinámica:

```python
class Dog:
    species = "Canis familiaris"

    def __init__(self, name, age):
        self.name = name
        self.age = age

    # Método de instancia (Comportamiento)
    def bark(self):
        return f"{self.name} dice: ¡Guau!"

    def birthday(self):
        self.age = self.age + 1
        return f"¡{self.name} ahora tiene {self.age} años!"
```

## 7. Ejercicios de Revisión

1. Define una clase llamada `Car` que sea una plantilla vacía (usa `pass`).
2. Agrega un método `__init__` a la clase `Car` que acepte dos parámetros de instancia: `color` y `mileage` (kilometraje).
3. Instancia un objeto de la clase `Car` que sea de color "azul" y tenga "20,000" de kilometraje. Usa `print()` e interpolación de hilos (f-strings) para mostrar ambos atributos.
4. **Reto:** Añade un método llamado `drive` que reciba un número de kilómetros como argumento y los sume al atributo `mileage` actual del objeto.

## 8. Resumen y Recursos Adicionales

### Puntos Clave (Key Takeaways)

- Una **clase** es el plano (blueprint) y un **objeto** es la casa construida (instancia).
- El **Estado** se guarda en los atributos; el **Comportamiento** se define en los métodos.
- `__init__` es el método que inicializa los datos del objeto al crearse.
- `self` es la referencia necesaria para que el objeto se reconozca a sí mismo y a sus datos.

**Importante:** La consistencia en la indentación de 4 espacios y el uso de nombres descriptivos (PEP 8) no son solo sugerencias; son la base para que el intérprete de Python entienda la jerarquía de tus clases y para que tu código sea profesional.