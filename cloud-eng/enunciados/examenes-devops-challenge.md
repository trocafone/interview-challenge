# Interview challenge: Exámenes

## Objetivos

### Evaluar experiencia en Docker
Más allá de que en Trocafone usamos varios lenguajes que permiten otros paradigmas a parte de POO (como por ej Python, PHP y Javascript) nuestro codebase es mayoritariamente OO. Es por eso que necesitamos que nuestros desarrolladores tengan una base sólida en ese paradigma.

> Te pedimos que no te preocupes por el “over engineering”, en este caso particular, y que uses todos los recursos de POO que conozcas y que puedan ser aplicados al problema que te planteamos abajo. 

### Evaluar experiencia con Bases de datos
Si bien usamos bases NOSQL para algunos microservicios y otras cosas, nuestra base de datos principal es una base de tipo relacional. Es por eso que buscamos que todos los desarrolladores tengan experiencia trabajando con este tipo de bases.

### Evaluar experiencia con Redis

### Evaluar experiencia con PHP y Apache

## Problema

### Contexto
Se busca crear una web app para la toma de exámenes de forma online.

Un profesor, un recruiter o cualquiera que desee va a poder crear un examen en nuestra app y luego enviarlo mediante un link a otros usuarios para que lo contesten.

La app va a ser web y mobile. Pero nos vamos a enfocar en el backend para este caso.
Puntualmente en la API REST.

El primer paso es hacer un [MVP](https://en.wikipedia.org/wiki/Minimum_viable_product) y para esto definimos los siguientes requerimientos.

### Requerimientos
Un examen debe poder ser creado y contestado por cualquier usuario del sistema.

Cada usuario solo debe poder contestar un mismo examen una única vez. 

Cada examen debe poder soportar una cantidad ilimitada de preguntas.

Cada examen debe poder ser contestado por muchos usuarios.

Cuando un usuario termina de contestar un examen, la app debe mostrarle el puntaje que obtuvo; el cual está definido como la cantidad de preguntas correctas sobre el total de preguntas.

El usuario evaluador debe poder ver todas las respuestas y el puntaje de cada examen contestado.

Cada pregunta debe pertenecer a uno de los siguientes tres tipos:

- **Multiple choice**:
Para este tipo de pregunta se deben definir las opciones posibles así como cuál es la opción correcta.
La pregunta se considera contestada correctamente cuando la opción seleccionada es la opción que fue definida como correcta.

- **Verdadero / Falso**:
Para este tipo de pregunta se debe definir la respuesta correcta como “verdadero” o como “falso”.
La pregunta se considera contestada correctamente cuando la respuesta seleccionada es igual a la que fue definida como correcta.

- **Texto libre**:
Para este tipo de pregunta se debe definir como respuesta correcta un texto.
La pregunta se considera contestada correctamente cuando el texto ingresado es completamente igual al texto definido como “texto correcto”.

----------------

> Para referencia, en la app final, un examen contestado previo al envio, debería terminar viéndose de la siguiente manera
> ![Examen ejemplo](./assets/examen.png)

## Se pide

### Esquema de base de datos

Un diagrama (no migración) que muestre un esquema de base de datos relacional que satisfaga las necesidades de esta app. Deben verse claramente las tablas con sus columnas mínimamente necesarias, así como las relaciones entre estas tablas. Reflejar en el diagrama las columnas que son primary key, foreign key y en caso de necesitar índices, uniques u otros constrains.

Para este ejercicio, pedimos que no se use el tipo de datos JSON/JSONB, ni se puede serializar estructuras compuestas en tipos de datos simples (ej: pasar un json serializado en un VARCHAR/TEXT).

> No es necesario ERD estricto pero recomendamos hacer un [ERD con esta tool](https://www.lucidchart.com/pages/examples/er-diagram-tool).

### Diagrama de clases
Un diagrama que muestre un esquema de clases que satisfaga los requerimientos descritos. Deben poder verse claramente las clases con sus propiedades, métodos clave, así como las relaciones entre estas clases.
Aprovechamos para remarcar que no vamos a juzgar “over engineering”, como ya fue comentado en la sección de objetivos.

> No es necesario UML estricto pero recomendamos hacer un [Diagrama de clases UML con esta tool](https://www.lucidchart.com/pages/examples/uml_diagram_tool).

### Definición de la interfaz de la API
Para las siguientes funcionalidades:
1. Obtener la definición de un examen (título, descripción, preguntas, etc)
2. Enviar las respuestas de un examen y ver el puntaje obtenido.

Crear un documento en el cual se defina:
- El endpoint a usar (definir el path y método HTTP, con los parámetros que pueda tener)
- Un ejemplo del body del request
- Un ejemplo del body de la response
- Códigos de respuesta HTTP

> Para definir los bodies no hace falta utilizar un JSON schema o similar.
Dar simplemente un ejemplo en base al examen modelo que se presenta en los requerimientos. Hacer comentarios explicativos sobre los campos que se crean necesarios.

### Implementación de un caso de uso
Plasmar el diagrama de clases en algún lenguaje a elección y desarrollar el código necesario para satisfacer el caso de uso (2) del punto anterior:

> El usuario contesta un examen y obtiene su puntaje.

Escribir tests que demuestren el correcto funcionamiento de la solución partiendo de un examen ya levantado en memoria y un JSON representado la contestación de un usuario. 

No es necesario incluir la base de datos, ni hacer el endpoint del punto anterior; nos queremos enfocar solo en el modelo. Tampoco es necesario implementar clases y código que estén en el diagrama de clases pero que no participen en este caso de uso particular.


## Entrega

Te vamos a pedir que la entrega la hagas por mail en un `.zip` o `.tar.gz` con la siguiente estructura:
```
examen/
├── documents/
│   ├── diagrama_de_clases.pdf
│   ├── diagrama_erd.pdf
│   └── interfaz.md
├── code/
│   ├── ...
│   ├── src/
│   └── test/
└── README.md
```

El `README.md` es importante especificarlo por dos motivos:
1. Cualquier consideración, aclaración o definición que se haya hecho sobre el enunciado debería estar escrita aquí, cuestión que podamos entender el porque se tomó ciertas decisiones.
2. Si no utilizaste nuestro scaffold, explicar brevemente como se corre el código y si hay alguna consideración al correrlo.

Seguramente el código sea pesado y no lo deje pasar por mail. Podés utilizar [WeTransfer](https://wetransfer.com/). También te recomendamos remover las dependencias antes de comprimir la carpeta.

### Código
Para no perder tiempo con la creación de la estructura base para correr el código dejamos disponibles scaffolds para Node con ES6 (próximamente Typescript, Python y PHP).

> Obviamente, no es obligatorio usarlo, por lo tanto si quisieras hacerlo en otra tecnologia, o con tu propio scaffold, bienvenido!
Lo único que te vamos a pedir en ese caso, es que nos indiques bien cómo ejecutar los tests de tu aplicación en el `README.md`
