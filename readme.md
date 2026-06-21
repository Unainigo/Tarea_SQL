# Proyecto Módulo SQL  
## Unai Iñigo Insausti

El proyecto tiene como objetivo el diseño, implementación y análisis de una base de datos relacional orientada al análisis de la base de datos de una sociedad con la tecnología de postgresql y pgadmin 4.

La base de datos que voy a utilizar se construye en base a datos de ventas y reservas generadas con la IA de chatgpt y en el resto de tablas datos que me he inventado yo directamente.

---

## Alcance del análisis de la sociedad

El análisis de la sociedad como he comentado anteriormente incluye el analisis de las reservas de las mesas dentro de la sociedad y también de las compras que realiza cada usuario:

- Análisis de las reservas realizadas por usuario.  
- Análisis de las compras que realizan los usuarios.  
- Información de las reservas realizadas por los usuarios.  
- Clasificación de las reservas por rangos de edad del usuario.   

---

## MODELO DE DATOS

Se ha implementado un modelo, compuesto por:

- 1 Tabla de Hechos: **reservas**, **compras** 
- 4 Tablas de dimensiones: **usuarios**, **mesas**, **actividades**, **productos**  

---

## GRANULARIDAD DE LAS TABLAS

### reservas
- Granularidad: una fila por reserva.  
- Contiene las métricas principales de las reservas, con las columnas:, id_reserva, id_usuario, id_mesa, id_actividad, create_time, reserva, participantes.

### compras
- Granularidad: en cada fila hay una compra.  
- Permite el análisis de las compras, con las columnas: id_compras, id_producto, id_usuario, create_time, cantidad.

### usuarios
- Granularidad: una fila por usuario.  
- Contiene información única de cada usuario, con las columnas: id_user, nombre, edad, género, Create_time, email, password

### mesas
- Granularidad: una fila por mesa.  
- Categoriza las mesas, con las columnas: id_mesa, nombre, ocupada, capacidad.

### producto
- Granularidad: una fila por producto.  
- Clasifica los productos, con las columnas: id_producto, nombre, descripción, cantidad y precio.

### actividades
- Granularidad: una fila por actividad.  
- Clasifica los productos, con las columnas: id_actividad, nombre, descripción y tipo.
---

## DECISIONES DE DISEÑO (PK, FK Y CONSTRAINTS)

Se utilizan claves primarias numéricas generadas automáticamente en todas las tablas de dimensiones porque nos permiten la independencia respecto a los identificadores del sistema origen, mejorar el rendimiento en joins, flexibilidad ante cambios futuros en los datos fuente.

Las claves foráneas en la tablas de hechos garantizan la coherencia de los datos, asegurando que cada compra y reserva esten asociada a dimensiones válidas.

Se eligieron estas claves porque facilitan las consultas analíticas y reflejan relaciones reales cada compra y reserva siempre ocurre en un contexto. Esto asegura que los registros estén correctamente relacionados entre las tablas, evitando errores y garantizando resultados confiables.

Al crear las tablas, se definieron restricciones para asegurar la calidad y coherencia de los datos.

Se utilizó UNIQUE para garantizar que los valores de una columna sean únicos.

---

## ANÁLISIS EXPLORATORIO DE DATOS

Para el análisis exploratorio, se realizaron diversas consultas en PostgresSQL sobre la base de datos, con el objetivo de extraer conclusiones.

### Consultas básicas y agregaciones

Se realizaron las siguientes consultas:

1. En la primera consulta que realizamos se obtiene cuales son los productos con un mayor rango de ventas dentro de la asociación y podemos observar que esos productos en nuestro caso son el agua y la cerveza.

2. En la segunda consulta podemos observar que de esos dos productos más vendidos el agua se ha vendido 63 veces mientras que la cerveza 56.

3. La siguiente consulta nos sirve para ver la edad media de las personas que realizan la activida siendo la actividad con edad media más alta las partidas a juegos de mesa siendo una media de edad de 23,71 años.

4. Podemos observar en la siguiente consulta que la mayor cantidad de reservas las realizan los adultos para realizar torneos de videojuegos con un total de 92 reservas. En la segunda posición nos volveriamos a encontrar a los adultos de nuevo realizando reservas para jugar juegos de mesa con 87 reservas.

5. Podemos observar que las mesas más reservadas por los adultos serían la pequeña 3 con una reserva de 111 veces mientras que los menores de edad prefieren reservar la mesa del rol que la han reservado 32 veces.

6. Dentro de la asociación las mesas más reservadas serían la mesa pequeña 3 y la mesa pequeña 2.

---
