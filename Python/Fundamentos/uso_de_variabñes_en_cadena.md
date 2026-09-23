Uso de variables en cadenas 

En algunas situaciones, nos interesa usar un valor de variables dentro de una cadena. Por ejemplo, puede que queramos que dos variables representen un nombre y un apellido, respectivamente, y combinar esos valores para mostar el nombre completo de alguien: 

full_name.py
first_name = "ada" 
last_name = "lovelace" 
full_name = f"{first_name} {last_name}" 
print(full_name)

Para insertar el valor de una variable en una cadena, coloque la letra 'f' justo antes de abrir las comillas. Ponga entre llaves el nombre o los nombres de cualquier variable que quiera usar dentro de la cadena. Python reemplazara cada variable con su valor cuando se muestre la cadena. 
