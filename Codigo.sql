-- Database: Tarea
--Codigo que crea la base de datos que vamos a utilizar a en el trabajo mandado en el master.
DROP DATABASE IF EXISTS "Tarea";
CREATE DATABASE "Tarea"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Spain.1252'
    LC_CTYPE = 'Spanish_Spain.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
/* Comprobamos cual es la base de datos que estamos utilizando actualmente para asegurarnos que estamos usando la base de
que nos interesa */
	select current_database();
-- Si la base de datos actual es la que queremos utilizar procederemos a crear primero las tablas 
/* ----------------------------------------------------------------------------------------------------------------------
                                             Tablas de dimensiones
-----------------------------------------------------------------------------------------------------------------------*/
--La primera tabla que se creara será la de los usuarios que están apuntados a la asociación
drop table if exists Usuarios;
CREATE TABLE if not exists Usuarios (
id_user Serial primary key,
nombre varchar (30) not null,
edad integer not null,
genero varchar(30) not null,
create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
email varchar(100) unique not null,
password varchar(50) not null
)

-- Comprobamos si la tabla se ha generado correctamente
select column_name, data_type, is_nullable, column_default from information_schema.columns where table_name = 'Usuarios';
select * from Usuarios;

-- Creamos la tabla Producto para poder guardar los productos que vendemos
drop table if exists Productos;
CREATE TABLE if not exists Productos (
id_Producto Serial primary key,
nombre varchar(30) not null,
descripcion text not null,
cantidad integer not null,
precio decimal not null
)

-- Comprobamos si la tabla se ha generado correctamente
select column_name, data_type, is_nullable, column_default from information_schema.columns where table_name = 'Productos';
select * from Productos;

-- Creamos la tabla de mesas 
drop table if exists Mesas;
CREATE TABLE if not exists Mesas (
id_Mesa serial primary key,
nombre varchar(30) not null,
capacidad integer not null,
ocupada boolean default FALSE
)

-- Comprobamos si la tabla se ha generado correctamente
select column_name, data_type, is_nullable, column_default from information_schema.columns where table_name = 'Mesas';
select * from Mesas;

-- Creamos la tabla de actividades 
drop table if exists Actividades;
CREATE TABLE if not exists Actividades (
id_Actividad serial primary key,
nombre varchar(100) not null,
descripcion text not null,
tipo varchar(50) not null
)

-- Comprobamos si la tabla se ha generado correctamente
select column_name, data_type, is_nullable, column_default from information_schema.columns where table_name = 'Actividades';
select * from Actividades;

/*----------------------------------------------------------------------------------------------------------------------
                                                     TABLAS DE HECHO
----------------------------------------------------------------------------------------------------------------------*/

-- Creación de la primera tabla de hecho 
drop table if exists Reservas;
create table if not exists Reservas (
id_reserva serial primary key,
id_usuario integer not null,
id_mesa integer not null,
id_actividad integer not null,
create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
reserva date not null,
participantes integer not null,
foreign key (id_usuario) references Usuarios(id_user),
foreign key (id_mesa) references Mesas(id_Mesa),
foreign key (id_actividad) references Actividades(id_Actividad)
)

-- Comprobamos si la tabla se ha generado correctamente
select column_name, data_type, is_nullable, column_default from information_schema.columns where table_name = 'Reservas';
select * from Reservas;

-- Creamos la segunda tabla de hechos
Drop table if exists Compras;
create table if not exists Compras (
id_compras serial primary key,
id_producto integer not null,
id_usuario integer not null,
create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
cantidad integer not null,
foreign key (id_producto) references Productos (id_Producto),
foreign key (id_usuario) references Usuarios(id_user)
)

-- Comprobamos si la tabla se ha generado correctamente
select column_name, data_type, is_nullable, column_default from information_schema.columns where table_name = 'Compras';
select * from Compras;

/*----------------------------------------------------------------------------------------------------------------------
                                            REALIZAMOS LA INTRODUCCIÓN DE LOS DATOS
----------------------------------------------------------------------------------------------------------------------*/
-- Insertamos datos en la tabla de usuarios
insert into Usuarios (nombre, edad, genero, email, password) 
values
('Unai', 31, 'Hombre', 'unainigo1@gmail.com', 123456),
('Maria', 32, 'Mujer', 'maria@gmail.com', 324321),
('Aritz', 32, 'Hombre', 'aritz@gmail.com', 456789),
('Ane', 30, 'Mujer', 'ane@gmail.com', 987654),
('Jon', 29, 'Hombre', 'jon@gmail.com', 654321),
('Iker', 28, 'Hombre', 'iker@gmail.com', 345678),
('Ainhoa', 27, 'Mujer', 'ainhoa@gmail.com', 567890),
('Mikel', 26, 'Hombre', 'mikel@gmail.com', 789012),
('Nerea', 25, 'Mujer', 'nerea@gmail.com', 123456),
('Iñigo', 24, 'Hombre', 'iñigo@gmail.com', 654321),
('Ane', 23, 'Mujer', 'ane1@gmail.com', 123456),
('Jon', 22, 'Hombre', 'jon1@gmail.com', 654321),
('Iker', 21, 'Hombre', 'iker1@gmail.com', 345678),
('Ainhoa', 20, 'Mujer', 'ainhoa1@gmail.com', 567890),
('Mikel', 19, 'Hombre', 'mikel1@gmail.com', 789012),
('Nerea', 18, 'Mujer', 'nerea1@gmail.com', 123456),
('Iñigo', 17, 'Hombre', 'iñigo1@gmail.com', 654321),
('Ane', 16, 'Mujer', 'ane2@gmail.com', 123456),
('Jon', 15, 'Hombre', 'jon2@gmail.com', 654321),
('Iker', 14, 'Hombre', 'iker2@gmail.com', 345678),
('Ainhoa', 13, 'Mujer', 'ainhoa2@gmail.com', 567890),
('Mikel', 12, 'Hombre', 'mikel2@gmail.com', 789012),
('Nerea', 21, 'Mujer', 'nerea2@gmail.com', 123456),
('Iñigo', 30, 'Hombre', 'iñigo2@gmail.com', 654321),
('Ane', 19, 'Mujer', 'ane3@gmail.com', 123456),
('Jon', 18, 'Hombre', 'jon3@gmail.com', 654321),
('Iker', 27, 'Hombre', 'iker3@gmail.com', 345678),
('Ainhoa', 26, 'Mujer', 'ainhoa3@gmail.com', 567890),
('Paula', 25, 'Mujer', 'paula@gmail.com', 123456),
('Manuel', 24, 'Hombre', 'manuel@gmail.com', 123456),
('Laura', 23, 'Mujer', 'laura@gmail.com', 123456),
('David', 22, 'Hombre', 'david@gmail.com', 123456),
('Marta', 21, 'Mujer', 'marta@gmail.com', 123456),
('Silvia', 20, 'Mujer', 'silvia@gmail.com', 123456),
('Javier', 19, 'Hombre', 'javier@gmail.com', 123456),
('Cristina', 18, 'Mujer', 'cristina@gmail.com', 123456),
('Elena', 17, 'Mujer', 'elena@gmail.com', 123456),
('Pablo', 16, 'Hombre', 'pablo@gmail.com', 123456),
('Raquel', 25, 'Mujer', 'raquel@gmail.com', 123456),
('Sergio', 34, 'Hombre', 'sergio@gmail.com', 123456),
('Alba', 23, 'Mujer', 'alba@gmail.com', 123456),
('Jorge', 22, 'Hombre', 'jorge@gmail.com', 123456),
('Lucia', 21, 'Mujer', 'lucia@gmail.com', 123456),
('Adrian', 20, 'Hombre', 'adrian@gmail.com', 123456),
('Claudia', 19, 'Mujer', 'claudia@gmail.com', 123456),
('Hugo', 18, 'Hombre', 'hugo@gmail.com', 123456),
('Sara', 17, 'Mujer', 'sara@gmail.com', 123456),
('Alvaro', 46, 'Hombre', 'alvaro@gmail.com', 123456),
('Miriam', 45, 'Mujer', 'miriam@gmail.com', 123456),
('Raul', 44, 'Hombre', 'raul@gmail.com', 123456),
('Patricia', 43, 'Mujer', 'patricia@gmail.com', 123456);

-- Insertamos datos en la tabla de Productos
insert into Productos (nombre, descripcion, cantidad, precio) 
values
('Coca cola zero', 'Refresco valido para niños', 100, 1.00),
('Pacharan', 'Bebida alcoholica no apta para niños', 50, 2.5),
('Cerveza', 'Bebida alcoholica de baja graducaión', 300, 3),
('Cerveza cero', 'Herejía no alcoholica que se permite beber solo cuando se vaya a coger coche', 150, 3),
('Agua', 'Bebida no alcoholica que se permite beber a todo el mundo', 200, 1.5),
('Coca cola', 'Refresco valido para niños', 100, 1.5),
('Fanta de naranja', 'Refresco valido para niños', 100, 1.5),
('Fanta de limón', 'Refresco valido para niños', 100, 1.5),
('Bolsa de patatas', 'Bolsa de patatas fritas', 100, 1.5),
('Chocolatina', 'Chocolatina de chocolate con leche', 100, 1.5),
('Sobre de mtg', 'Sobre de cartas de magic the gathering', 100, 5.5),
('Sobre de pokemon', 'Sobre de cartas de pokemon', 100, 6),
('Sobre de yugioh', 'Sobre de cartas de yugioh', 100, 5),
('Caja de mtg', 'Caja de cartas de magic the gathering', 50, 120),
('Caja de pokemon', 'Caja de cartas de pokemon', 50, 120),
('Caja de yugioh', 'Caja de cartas de yugioh', 50, 120),
('Juego de mesa', 'Juego de mesa para jugar en grupo', 50, 30),
('Juego de rol', 'Juego de rol para jugar en grupo', 50, 30);

-- Insertamos datos en la tabla de mesas
insert into Mesas (nombre, capacidad)
values 
('Rol', 8),
('Grande 1', 8),
('Grande 2', 8),
('Grande 3', 8),
('Pequeña 1', 4),
('Pequeña 2', 4),
('Pequeña 3', 4);

-- Insertamos datos en la tabla de actividades
insert into Actividades (nombre, descripcion , tipo)
values
('Torneo de Magic', 'Es un torneo que se realiza entre los socios de un tcg', 'TCG'),
('Torneo de warhammer TOW', 'un torneo que juegan varios socios cada X tiempo', 'Wargames'),
('Partidas a juegos de mesa', 'Quedada entre amigos para jugar a juegos de mesa', 'Juegos de mesa'),
('Comida de miembros', 'Comidas que realizan los diferentes miembros de la sociedad', 'ocio'),
('Partidas de rol', 'Partidas de rol que se realizan entre los socios de la sociedad', 'Rol'),
('Torneo de videojuegos', 'Torneo que se realiza entre los socios de la sociedad', 'Videojuegos'),
('Reunión de socios', 'Reunión que se realiza entre los socios de la sociedad', 'ocio'),
('Partidas de cartas', 'Partidas que se realizan entre los socios de la sociedad', 'Cartas');

-- Añadimos los datos de reservas desde un csv
COPY Reservas (id_usuario, id_mesa, id_actividad, reserva, participantes) FROM './Data/Raw/reservas.csv' DELIMITER ',' CSV HEADER;

-- Añadimos los datos de compras desde un csv
COPY Compras ( id_usuario, id_producto, cantidad) FROM './Data/Raw/compras.csv' DELIMITER ',' CSV HEADER;

/*----------------------------------------------------------------------------------------------------------------------
                                            FUNCIONES
----------------------------------------------------------------------------------------------------------------------*/

-- Función que nos permite obtener el total de compras realizadas por un usuario
create or replace function total_compras_usuario(p_id_usuario integer)
returns numeric as $$
declare
    total numeric;
begin
    select sum(c.cantidad * p.precio) into total
    from compras c
    join productos p on c.id_producto = p.id_producto
    where c.id_usuario = p_id_usuario;
    return coalesce(total, 0);
end;
$$ language plpgsql;

-- Función que nos permite obtener el total de reservas realizadas por un usuario
create or replace function total_reservas_usuario(p_id_usuario integer) 
returns integer as $$
declare
    total integer;
begin
    select count(*) into total
    from reservas
    where id_usuario = p_id_usuario;
    return total;
end;
$$ language plpgsql;

-- función que convierte las edades de los usuarios en rangos de edad
create or replace function rango_edad(p_edad integer)
returns text as $$
begin
    RETURN CASE
        WHEN p_edad < 18 THEN 'Menor de edad'
        WHEN p_edad < 65 THEN 'Adulto'
        ELSE 'Tercera edad'
    END;
end;
$$ language plpgsql;

-- Función que nos permite cambiar el formato de la fecha de la reserva a un formato más legible
create or replace function formato_fecha(p_fecha date)
returns text as $$
begin
    return to_char(p_fecha, 'DD/MM/YYYY');
end;
$$ language plpgsql;

-- Función que nos permite ver si dos mesas están reservadas al mismo tiempo y en caso de que lo estén
-- elimina la reserva de la mesa que se ha reservado más tarde
create or replace function validar_reserva_mesa(p_id_mesa integer, p_fecha date)
returns boolean as $$
declare
    reserva_existente integer;
begin
    select count(*) into reserva_existente
    from reservas
    where id_mesa = p_id_mesa and reserva = p_fecha;
    return reserva_existente > 0;
end;
$$ language plpgsql;

-- Función que nos permite calcular si quedan productos en stock para poder realizar una compra
create or replace function validar_stock_producto(p_id_producto integer, p_cantidad integer)
returns boolean as $$
declare
    stock integer;
begin
    select cantidad into stock
    from productos
    where id_producto = p_id_producto;
    if stock >= p_cantidad then
        return true;
    else
        return false;
    end if;
end;
$$ language plpgsql;

-- Función para actualizar cantidad de productos en la tabla de productos cuando se realiza una compra
create or replace function actualizar_cantidad_productos()
returns trigger as $$
begin
    update productos set cantidad = cantidad - new.cantidad where id_producto = new.id_producto;
    return new;
end;
$$ language plpgsql;

-- Función para actualizar la ocupación de las mesas cuando se realiza una reserva
create or replace function actualizar_ocupacion_mesas()
returns trigger as $$
begin
    update mesas set ocupada = true where id_mesa = new.id_mesa;
    return new;
end;
$$ language plpgsql;

-- Función para actualizar la ocupación de las mesas cuando se elimina una reserva
create or replace function actualizar_ocupacion_mesas_eliminar()
returns trigger as $$
begin
    update mesas set ocupada = false where id_mesa = old.id_mesa;
    return old;
end;
$$ language plpgsql;

/*---------------------------------------------------------------------------------------------------------------------------------------------
                                            Querys de comprobación y limpieza de datos
------------------------------------------------------------------------------------------------------------------------------------------------*/
-- Comenzamos con la limpieza de los datos de la tabla de usuarios, eliminando los registros que contengan nulos en cualquiera de sus campos
begin;
-- Eliminamos los registros con nulos en la tabla de usuarios
delete from Usuarios where nombre is null or edad is null or genero is null or email is null or password is null;
-- Comprobamos que los registros restantes
select * from Usuarios;
commit;

-- Continuamos con la limpieza de los datos de la tabla usuarios eliminando los registros que estén duplicados.
begin;
-- Eliminamos los registros duplicados en la tabla de usuarios
delete from Usuarios a using Usuarios b where a.id_user < b.id_user and a.nombre = b.nombre and a.edad = b.edad and a.genero = b.genero and a.email = b.email and a.password = b.password;
-- Comprobamos que los registros restantes no tienen duplicados
select * from Usuarios;
commit;

-- Comenzamos con la limpieza de los datos de la tabla de productos, eliminando los registros que contengan nulos en cualquiera de sus campos
begin;
-- Eliminamos los registros con nulos en la tabla de productos
delete from Productos where nombre is null or descripcion is null or cantidad is null or precio is null;
-- Comprobamos que los registros restantes
select * from Productos;
commit;

-- Continuamos con la limpieza de los datos de la tabla productos eliminando los registros que estén duplicados.
begin;
-- Eliminamos los registros duplicados en la tabla de productos
delete from Productos a using Productos b where a.id_producto < b.id_producto and a.nombre = b.nombre and a.descripcion = b.descripcion and a.cantidad = b.cantidad and a.precio = b.precio;
-- Comprobamos que los registros restantes no tienen duplicados
select * from Productos;
commit;

-- Comenzamos con la limpieza de los datos de la tabla de mesas, eliminando los registros que contengan nulos en cualquiera de sus campos
begin;
-- Eliminamos los registros con nulos en la tabla de mesas
delete from Mesas where nombre is null or capacidad is null;
-- Comprobamos que los registros restantes
select * from Mesas;
commit;

-- Continuamos con la limpieza de los datos de la tabla actividades eliminando los registros que estén duplicados.
begin;
-- Eliminamos los registros duplicados en la tabla de actividades
delete from Actividades a using Actividades b where a.id_actividad < b.id_actividad and a.nombre = b.nombre and a.descripcion = b.descripcion and a.tipo = b.tipo;
-- Comprobamos que los registros restantes no tienen duplicados
select * from Actividades;
commit;

-- Continuamos eliminando los datos nulos de la tabla de actividades
begin;
-- Eliminamos los registros con nulos en la tabla de actividades
delete from Actividades where nombre is null or descripcion is null or tipo is null;
-- Comprobamos que los registros restantes
select * from Actividades;
commit;

-- Comenzamos con la limpieza de los datos de la tabla de reservas, eliminando los registros que contengan nulos en cualquiera de sus campos
begin;
-- Eliminamos los registros con nulos en la tabla de reservas
delete from Reservas where id_usuario is null or id_mesa is null or id_actividad is null or reserva is null or participantes is null;
-- Comprobamos que los registros restantes
select * from Reservas;
commit;

-- Comenzamos con la limpieza de los datos de la tabla de compras, eliminando los registros que contengan nulos en cualquiera de sus campos
begin;
-- Eliminamos los registros con nulos en la tabla de compras
delete from Compras where id_producto is null or id_usuario is null or cantidad is null;
-- Comprobamos que los registros restantes
select * from Compras;
commit;

-- llamada a la función que cambia el formato de la fecha de la reserva a un formato más legible
do $$
declare
    r record;
begin
    alter table reservas add column fecha_formateada varchar(20);
    for r in (select * from reservas)
    loop
        update reservas
        set fecha_formateada = formato_fecha(r.reserva)
        where id_reserva = r.id_reserva;
    end loop;
end;
$$;

-- llama a la función que convierte las edades de los usuarios en rangos de edad
DO $$
declare
    r RECORD;
begin
    alter table Usuarios add column categoria_edad varchar(20);
    for r in (select * from Usuarios)
    loop
        update Usuarios
        set categoria_edad = rango_edad(r.edad)
        where id_user = r.id_user;
    end loop;
end $$;

/* llamada a la función que nos permite ver si dos mesas están reservadas al mismo tiempo y en caso de que lo estén
-- elimina la reserva de la mesa que se ha reservado más tarde
do $$
declare
    r record;
begin
    for r in (select * from reservas)
    loop
        if validar_reserva_mesa(r.id_mesa, r.reserva) then
            delete from reservas
            where id_reserva = r.id_reserva;
        end if;
    end loop;
end;
$$;
*/
-- llamada a la función que nos permite ver si quedan productos en stock para poder realizar una compra 
-- y en caso de que no queden productos elimina esa compra de la tabla de compras
-- recorre todas las compras y elimina las que no tienen stock suficiente
do $$
declare
    r record;
begin
    for r in (select * from Compras)
    loop
        if not validar_stock_producto(r.id_producto, r.cantidad) then
            delete from Compras where id_compras = r.id_compras;
        end if;
    end loop;
end;
$$;

/*----------------------------------------------------------------------------------------------------------------------
                                 Querys para responder a las preguntas del trabajo
----------------------------------------------------------------------------------------------------------------------*/
/* Las principales preguntas del trabajo serían cuales son los productos más vendidos, cuales son las actividades
que más se realizan ordenadas por la edad de los usuarios que las realizan, cuales son las mesas que más se
resevan */

-- Productos más vendidos
select nombre from productos join compras on productos.id_producto = compras.id_producto 
group by nombre order by count(compras.id_producto) desc;

-- Número de productos más vendidos por cada producto
select nombre, count(compras.id_producto) as total_ventas from productos join compras on productos.id_producto = compras.id_producto
group by nombre order by total_ventas desc;

-- Actividades más realizadas ordenadas por la edad media de los usuarios que las realizan
select actividades.nombre, round(avg(usuarios.edad),2) as edad_media from actividades
join reservas on actividades.id_actividad = reservas.id_actividad
join usuarios on reservas.id_usuario = usuarios.id_user
group by actividades.nombre
order by edad_media desc;

-- Actividades más realizadas por el rango de edad de los usuarios que las realizan
select actividades.nombre, rango_edad(usuarios.edad) as rango_edad, count(reservas.id_actividad) as total_reservas from actividades
join reservas on actividades.id_actividad = reservas.id_actividad
join usuarios on reservas.id_usuario = usuarios.id_user
group by actividades.nombre, rango_edad(usuarios.edad)
order by total_reservas desc;

-- Mesas más reservadas por el rango de edad de los usuarios que las reservan
select mesas.nombre, rango_edad(usuarios.edad) as rango_edad, count(reservas.id_mesa) as total_reservas from mesas
join reservas on mesas.id_mesa = reservas.id_mesa
join usuarios on reservas.id_usuario = usuarios.id_user
group by mesas.nombre, rango_edad(usuarios.edad)
order by total_reservas desc;

-- Mesas más reservadas
select mesas.nombre, count(reservas.id_mesa) as reservas_totales from mesas
join reservas on mesas.id_mesa = reservas.id_mesa
group by mesas.nombre
order by reservas_totales desc;

/* --------------------------------------------------------------------------------------------------------------
                                            TRIGGERS
---------------------------------------------------------------------------------------------------------------*/

-- Creamos el trigger que se ejecutará después de insertar una nueva compra
create trigger trigger_actualizar_cantidad_productos
after insert on compras
for each row
execute function actualizar_cantidad_productos();

-- Creamos el trigger que se ejecutará después de insertar una nueva reserva
create trigger trigger_actualizar_ocupacion_mesas
after insert on reservas
for each row
execute function actualizar_ocupacion_mesas();

-- Creamos el trigger que se ejecutará después de eliminar una reserva
create trigger trigger_actualizar_ocupacion_mesas_eliminar
after delete on reservas
for each row
execute function actualizar_ocupacion_mesas_eliminar();

/*----------------------------------------------------------------------------------------------------------------------
                                            VISTAS
----------------------------------------------------------------------------------------------------------------------*/

-- vista que nos permite ver las reservas de los usuarios con sus datos personales y los datos de la reserva
create or replace view vista_reservas_usuarios as
select usuarios.nombre as nombre_usuario, usuarios.edad, usuarios.genero, reservas.reserva, reservas.participantes, mesas.nombre as nombre_mesa, actividades.nombre as nombre_actividad
from reservas
join usuarios on reservas.id_usuario = usuarios.id_user
join mesas on reservas.id_mesa = mesas.id_mesa
join actividades on reservas.id_actividad = actividades.id_actividad;

-- vista que nos permite ver las compras de los usuarios con sus datos personales y los datos de la compra
create or replace view vista_compras_usuarios as
select usuarios.nombre as nombre_usuario, usuarios.edad, usuarios.genero, compras.cantidad, productos.nombre as nombre_producto, productos.precio
from compras
join usuarios on compras.id_usuario = usuarios.id_user
join productos on compras.id_producto = productos.id_producto;



/*----------------------------------------------------------------------------------------------------------------------
                                            PROCEDIMIENTOS
----------------------------------------------------------------------------------------------------------------------*/

-- Procedimiento que nos permite obtener el total de compras y reservas realizadas por un usuario
create or replace procedure total_compras_reservas_usuario(p_id_usuario integer, out total_compras numeric, out total_reservas integer)
as $$
begin
    select total_compras_usuario(p_id_usuario) into total_compras;
    select total_reservas_usuario(p_id_usuario) into total_reservas;
end;
$$ language plpgsql;

-- Procedimiento que nos permite obtener el total de compras y reservas realizadas por todos los usuarios
create or replace procedure total_compras_reservas_todos(out total_compras numeric, out total_reservas integer)
as $$
begin
    select sum(cantidad * precio) into total_compras from compras join productos on compras.id_producto = productos.id_producto;
    select count(*) into total_reservas from reservas;
end;
$$ language plpgsql;
