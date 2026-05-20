name.py 
name = "ada lovelace" 
print(name.title())

La salida es:
Ada Lovalace

En este ejemplo, la variable 'name' se refiere a la cadena de texto que esta en minuscula 'ada lovelace'. El metodo 'title()' aparece despues de la v ariable en la llamada a 'print()'.
Un metodo es una accion que Python puede realizar con datos. El punto (.) delante de 'name' en 'name.title()' le dice a Python que haga actuar el metodo title() sobre la variable 'name'. 

Cada metodo va seguido de un par de parentesis porque los metodos suelen requeririr informacion adicional para hacer su trabajo. Esa informacion va entre parentesis. La funcion 'title()' no necesita informacion adicional; por eso, los parentesis estan vacios. 

El metodo 'title()' cambia cada palabra a formato de titulo, con inicial mayuscula en todas la palabras.
Hay otros muchos metodos utiles para tratar con mayuscula y minusculas. Podemos cambiar una cadena a todo mayuscula o todo minuscula asi:
	 
name = "Ada Lovelace" 
print(name.upper()) 
print(name.lower())

----> ADA LOVELACE
----> da lovelace

El metodo 'lower()' es espedialmente util para almacenar datos. Por regla general, no conviene fiarse del uso de las mayusculas que hagan nuestros usuarios, asi que podemos convertir las cadenas a minusculas antes de guardarlas. Despues, a la hora de mostrar informacion, podemos usar la grafia que tenga mas sentido para cada cadena. 

