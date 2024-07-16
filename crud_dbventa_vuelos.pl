:- use_module(library(odbc)).

% Conexión a la base de datos MySQL
connect :-
    odbc_connect('MSProlog', _, [
        user('root'),
        password(''),
        alias(mydb),
        open(once)
    ]).



% Operaciones CRUD para la tabla Avion
% Crear un avión
crear_avion(Modelo, Capacidad, Aerolinea, Affected) :-
    atomic_list_concat(['INSERT INTO Avion(modelo, capacidad, aerolinea) VALUES (\'', Modelo, '\', ', Capacidad, ', \'', Aerolinea, '\')'], SQL),
    odbc_query(mydb, SQL, Affected).
% Leer todos los aviones
leer_aviones(Aviones) :-
    odbc_query(mydb, 'SELECT * FROM Avion', Aviones).
% Actualizar un avión por ID
actualizar_avion(ID, Modelo, Capacidad, Aerolinea, Affected) :-
    atomic_list_concat(['UPDATE Avion SET modelo = \'', Modelo, '\', capacidad = ', Capacidad, ', aerolinea = \'', Aerolinea, '\' WHERE avion_id = ', ID], SQL),
    odbc_query(mydb, SQL, Affected).
% Borrar un avión por ID
borrar_avion(ID, Affected) :-
    atomic_list_concat(['DELETE FROM Avion WHERE avion_id = ', ID], SQL),
    odbc_query(mydb, SQL, Affected).



% Operaciones CRUD para la tabla Cliente
% Crear un cliente
crear_cliente(Nombre, Apellido, Email, Telefono, DNI, Affected) :-
    atomic_list_concat(['INSERT INTO Cliente(nombre, apellido, email, telefono, dni_cli) VALUES (\'', Nombre, '\', \'', Apellido, '\', \'', Email, '\', \'', Telefono, '\', \'', DNI, '\')'], SQL),
    odbc_query(mydb, SQL, Affected).
% Leer todos los clientes
leer_clientes(Clientes) :-
    odbc_query(mydb, 'SELECT * FROM Cliente', Clientes).
% Actualizar un cliente por ID
actualizar_cliente(ID, Nombre, Apellido, Email, Telefono, DNI, Affected) :-
    atomic_list_concat(['UPDATE Cliente SET nombre = \'', Nombre, '\', apellido = \'', Apellido, '\', email = \'', Email, '\', telefono = \'', Telefono, '\', dni_cli = \'', DNI, '\' WHERE cliente_id = ', ID], SQL),
    odbc_query(mydb, SQL, Affected).
% Borrar un cliente por ID
borrar_cliente(ID, Affected) :-
    atomic_list_concat(['DELETE FROM Cliente WHERE cliente_id = ', ID], SQL),
    odbc_query(mydb, SQL, Affected).



% Operaciones CRUD para la tabla Vuelo
% Crear un vuelo
crear_vuelo(Origen, Destino, FechaSalida, FechaLlegada, CodVuelo, Affected) :-
    atomic_list_concat(['INSERT INTO Vuelo(origen, destino, fecha_salida, fecha_llegada, cod_vuelo) VALUES (\'', Origen, '\', \'', Destino, '\', \'', FechaSalida, '\', \'', FechaLlegada, '\', \'', CodVuelo, '\')'], SQL),
    odbc_query(mydb, SQL, Affected).
% Leer todos los vuelos
leer_vuelos(Vuelos) :-
    odbc_query(mydb, 'SELECT * FROM Vuelo', Vuelos).
% Actualizar un vuelo por ID
actualizar_vuelo(ID, Origen, Destino, FechaSalida, FechaLlegada, CodVuelo, Affected) :-
    atomic_list_concat(['UPDATE Vuelo SET origen = \'', Origen, '\', destino = \'', Destino, '\', fecha_salida = \'', FechaSalida, '\', fecha_llegada = \'', FechaLlegada, '\', cod_vuelo = \'', CodVuelo, '\' WHERE vuelo_id = ', ID], SQL),
    odbc_query(mydb, SQL, Affected).
% Borrar un vuelo por ID
borrar_vuelo(ID, Affected) :-
    atomic_list_concat(['DELETE FROM Vuelo WHERE vuelo_id = ', ID], SQL),
    odbc_query(mydb, SQL, Affected).



% Operaciones CRUD para la tabla Reserva
% Crear un reserva
crear_reserva(FechaReserva, CodVuelo, DNICli, Affected) :-
    atomic_list_concat(['INSERT INTO Reserva(fecha_reserva, cod_vuelo, dni_cli) VALUES (\'', FechaReserva, '\', \'', CodVuelo, '\', \'', DNICli, '\')'], SQL),
    odbc_query(mydb, SQL, Affected).
% Leer todos los reservas
leer_reservas(Reservas) :-
    odbc_query(mydb, 'SELECT R.*, V.origen, V.destino, C.nombre, C.apellido FROM Reserva R JOIN Vuelo V ON R.cod_vuelo = V.cod_vuelo JOIN Cliente C ON R.dni_cli = C.dni_cli', Reservas).
% Actualizar un reserva por ID
actualizar_reserva(ID, FechaReserva, CodVuelo, DNICli, Affected) :-
    atomic_list_concat(['UPDATE Reserva SET fecha_reserva = \'', FechaReserva, '\', cod_vuelo = \'', CodVuelo, '\', dni_cli = \'', DNICli, '\' WHERE reserva_id = ', ID], SQL),
    odbc_query(mydb, SQL, Affected).
% Borrar un reserva por ID
borrar_reserva(ID, Affected) :-
    atomic_list_concat(['DELETE FROM Reserva WHERE reserva_id = ', ID], SQL),
    odbc_query(mydb, SQL, Affected).



% Operaciones CRUD para la tabla Asiento
% Crear un asiento
crear_asiento(NumeroAsiento, Clase, Estado, CodVuelo, Affected) :-
    atomic_list_concat(['INSERT INTO Asiento(numero_asiento, clase, estado, cod_vuelo) VALUES (\'', NumeroAsiento, '\', \'', Clase, '\', \'', Estado, '\', \'', CodVuelo, '\')'], SQL),
    odbc_query(mydb, SQL, Affected).
% Leer todos los asientos
leer_asientos(Asientos) :-
    odbc_query(mydb, 'SELECT A.*, V.origen, V.destino FROM Asiento A JOIN Vuelo V ON A.cod_vuelo = V.cod_vuelo', Asientos).
% Actualizar un asiento por ID
actualizar_asiento(ID, NumeroAsiento, Clase, Estado, CodVuelo, Affected) :-
    atomic_list_concat(['UPDATE Asiento SET numero_asiento = \'', NumeroAsiento, '\', clase = \'', Clase, '\', estado = \'', Estado, '\', cod_vuelo = \'', CodVuelo, '\' WHERE asiento_id = ', ID], SQL),
    odbc_query(mydb, SQL, Affected).
% Borrar un asiento por ID
borrar_asiento(ID, Affected) :-
    atomic_list_concat(['DELETE FROM Asiento WHERE asiento_id = ', ID], SQL),
    odbc_query(mydb, SQL, Affected).