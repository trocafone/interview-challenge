# Interview challenge: Exámenes

## Objetivos

### Evaluar capacidad de resolución de problemas
Parte de nuestros desafíos consisten en poder dar solución a diferente clases de problemas que puedan surgir y poder implementar tecnologías nuevas de la mejor forma posible, por lo que la idea del ejercicio es ver cómo solucionar un problema que pueda surgir al intentar hacer funcionar una aplicación
### Evaluar experiencia en Docker
En este ejercicio hay tres Dockerfile diferentes y un docker-compose, cada uno con una complejidad diferente, pero todos tienen que funcionar para lograr que la app inicie correctamente

### Evaluar experiencia con Redis Bases de datos
En los diferentes scripts de bash hay queries hacia una base de datos postgres, la idea es que se pueda crear una tabla y hacer los chequeos correspondientes del servicio
También, para funcionar descarga los datos de conexión desde redis y los guarda en un archivo de variables y los mismos son escritos por un worker en un paso previo (durante docker-compose), por lo que la conexión a redis es fundamental desde diferentes contenedores, y la misma se encuentra con clave
## Problema
Hay 5 errores que no permiten que la aplicación funcione correctamente, los cuales se pueden encontrar en los archivos de docker-compose / Dockerfile y los scripts de bash (init.sh), una vez solucionados los mismos, debería poder hacerse log en la web localhost:81
## Se pide

### Arquitectura de la aplicación

Diagramar el funcionamiento de la aplicación basandose en el docker-compose y las conexiones realizadas por los scripts de inicio de cada contenedor

### Resumen de soluciones propuestas y mejoras a la plataforma
Hacer un pequeño resumen de cuáles fueron los pasos realizados para solucionar los problemas que se encontraron en la aplicación y proponer mejoras en caso de encontrarlas

## Entrega

Te vamos a pedir que la entrega la hagas por mail en un `.zip` o `.tar.gz` con la siguiente estructura:
```
examen/
├── documents/
│   ├── Diagrama.pdf
│   ├── Soluciones.md
├── code/
│   ├── (Código funcional)
└── README.md
```

El `README.md` es importante especificarlo por dos motivos:
1. Cualquier consideración, aclaración o definición que se haya hecho sobre el enunciado debería estar escrita aquí, cuestión que podamos entender el porque se tomó ciertas decisiones.
2. Si se hicieron cambios en la arquitectura/funcionamiento de la aplicación, explicar brevemente como se ejecuta y si hay alguna consideración al correrlo.

Seguramente el código sea pesado y no lo deje pasar por mail. Podés utilizar [WeTransfer](https://wetransfer.com/). También te recomendamos remover las dependencias antes de comprimir la carpeta.