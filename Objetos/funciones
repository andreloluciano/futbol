USE futbol

-- Esta función nos da el nombre del equipo según el ID que le demos

DELIMITER //
CREATE FUNCTION NombreEquipo(p_id_equipo INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE nombre_equipo VARCHAR(100);
    SELECT equipo INTO nombre_equipo
    FROM Equipos
    WHERE id_equipo = p_id_equipo;
    RETURN nombre_equipo;
END;
//

-- Para utilizarla debemos ingresar la siguiente query
SELECT NombreEquipo(1);

-- Esta función obtiene la cantidad de partidos jugados por equipo según si ID

DELIMITER //
CREATE FUNCTION CantidadPartidosJugados(p_id_equipo INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad_partidos INT;
    SELECT COUNT(*) INTO cantidad_partidos
    FROM analisis_futbol_argentino
    WHERE id_equipo_local = p_id_equipo OR id_equipo_visitante = p_id_equipo;
    RETURN cantidad_partidos;
END;
//

-- Para utilizar esta funcion debemos ingresar la siguiente query
SELECT CantidadPartidosJugados(1);
