CREATE SCHEMA futbol;
USE futbol;

CREATE TABLE locaciones (
    id_locacion INT NOT NULL AUTO_INCREMENT,
    locacion VARCHAR(100),
    PRIMARY KEY (id_locacion)
);

CREATE TABLE equipos (
    id_equipo INT NOT NULL AUTO_INCREMENT,
    equipo VARCHAR(100),
    id_locacion INT NOT NULL,
    PRIMARY KEY (id_equipo),
    FOREIGN KEY (id_locacion) REFERENCES locaciones(id_locacion) 
);

CREATE TABLE resultados (
    id_resultado INT NOT NULL AUTO_INCREMENT,
    resultado VARCHAR(100),
    PRIMARY KEY (id_resultado)
);

CREATE SCHEMA futbol;
USE futbol;

CREATE TABLE locaciones (
    id_locacion INT NOT NULL AUTO_INCREMENT,
    locacion VARCHAR(100),
    PRIMARY KEY (id_locacion)
);

CREATE TABLE equipos (
    id_equipo INT NOT NULL AUTO_INCREMENT,
    equipo VARCHAR(100),
    id_locacion INT NOT NULL,
    PRIMARY KEY (id_equipo),
    FOREIGN KEY (id_locacion) REFERENCES locaciones(id_locacion) 
);

CREATE TABLE resultados (
    id_resultado INT NOT NULL AUTO_INCREMENT,
    resultado VARCHAR(100),
    PRIMARY KEY (id_resultado)
);

CREATE TABLE campeonatos (
    id_campeonato INT NOT NULL AUTO_INCREMENT,
    campeonato VARCHAR(100),
    PRIMARY KEY (id_campeonato)
);

CREATE TABLE analisis_futbol_argentino (
    id_encuentro INT NOT NULL AUTO_INCREMENT,
    fecha_torneo INT,
    partido INT,
    goles_local INT,
    goles_visita INT,
    valor_mercado_local DECIMAL(18,2),
    altura_media_local DECIMAL(18,2),
    edad_media_local DECIMAL(18,2),
    edad_media_visita DECIMAL(18,2),
    valor_mercado_visita DECIMAL(18,2),
    altura_media_visita DECIMAL(18,2),
    fecha DATETIME,
    nombre_dia VARCHAR(100),
    apuesta_local DECIMAL(18,2),
    apuesta_visita DECIMAL(18,2),
    apuesta_empate DECIMAL(18,2),
    id_campeonato INT NOT NULL,
    id_equipo_local INT NOT NULL,
    id_equipo_visitante INT NOT NULL,
    id_locacion INT NOT NULL,
    id_resultado INT NOT NULL,
    FOREIGN KEY (id_campeonato) REFERENCES campeonatos(id_campeonato),
    FOREIGN KEY (id_equipo_local) REFERENCES equipos(id_equipo),
    FOREIGN KEY (id_equipo_visitante) REFERENCES equipos(id_equipo),
    FOREIGN KEY (id_locacion) REFERENCES locaciones(id_locacion),
    FOREIGN KEY (id_resultado) REFERENCES resultados(id_resultado),
    PRIMARY KEY (id_encuentro)
);

-- Vistas

-- Esta vista une las tablas relevantes y selecciona campos clave para el análisis de resultados.
CREATE VIEW Vista_Analisis_Resultados AS
SELECT
    A.id_encuentro,
    A.fecha_torneo,
    A.partido,
    A.goles_local,
    A.goles_visita,
    A.valor_mercado_local,
    A.altura_media_local,
    A.edad_media_local,
    A.edad_media_visita,
    A.valor_mercado_visita,
    A.altura_media_visita,
    A.fecha,
    A.nombre_dia,
    A.apuesta_local,
    A.apuesta_visita,
    A.apuesta_empate,
    C.campeonato AS campeonato,
	E.equipo AS equipo,
    EL.id_equipo AS id_equipo_local,
    EL.equipo AS equipo_local,
    EV.id_equipo AS id_equipo_visitante,
    EV.equipo AS equipo_visitante,
    L.locacion AS locacion,
    R.resultado AS resultado,
    R.id_resultado AS id_resultado
FROM
    analisis_futbol_argentino A
JOIN campeonatos C ON A.id_campeonato = C.id_campeonato
JOIN equipos E ON A.id_equipo_local = E.id_equipo
JOIN equipos EL ON A.id_equipo_local = EL.id_equipo
JOIN equipos EV ON A.id_equipo_visitante = EV.id_equipo
JOIN locaciones L ON A.id_locacion = L.id_locacion
JOIN resultados R ON A.id_resultado = R.id_resultado;

-- Muestra una lista de las locaciones junto con los equipos asociados a cada una de ellas.
CREATE VIEW LocacionesyEquipos AS
SELECT L.locacion AS Locacion,
E.equipo AS Equipo
FROM Locaciones L
JOIN Equipos E ON L.id_locacion = E.id_locacion;

-- Para ver esta Vista:
-- SELECT * FROM LocacionesyEquipos;

-- Muestra una lista de equipos que participaron en cada campeonato durante el período de 2015-2022.
CREATE VIEW CampeonatosyEquipos AS
SELECT C.campeonato AS Campeonato,
E.equipo AS Equipo
FROM Campeonatos C
JOIN Equipos E ON C.id_campeonato = E.id_equipo;

-- Para ver esta Vista
-- SELECT * FROM CampeonatosyEquipos;

-- Muestra un análisis de los resultados en la tabla principal
CREATE VIEW Vista_Analisis_Principal AS
SELECT id_encuentro,
  goles_local,
  goles_visita,
  valor_mercado_local,
  valor_mercado_visita,
  edad_media_local,
  edad_media_visita
FROM analisis_futbol_argentino;

-- Para ver esta Vista
-- SELECT * FROM analisis_futbol_principal;

-- Muestra los equipos, dónde se llevaron a cabo y el resultado del partido, ordenado por fecha
CREATE VIEW resultados_fecha AS
SELECT A.fecha AS Fecha,
       E1.equipo AS EquipoLocal,
       E2.equipo AS EquipoVisitante,
       L.locacion AS Locacion,
       R.resultado AS Resultado
FROM analisis_futbol_argentino A
JOIN Equipos E1 ON A.id_equipo_local = E1.id_equipo
JOIN Equipos E2 ON A.id_equipo_visitante = E2.id_equipo
JOIN Locaciones L ON A.id_locacion = L.id_locacion
JOIN Resultados R ON A.id_resultado = R.id_resultado
ORDER BY A.fecha;

-- Para ver esta Vista
-- SELECT *  FROM resultados_fecha

-- Muestra los partidos jugados el día domingo, que hayan resultado en empate y ordenados en fecha descendiente
CREATE VIEW partidosdomingoempate AS
SELECT A.fecha AS Fecha,
       E1.equipo AS EquipoLocal,
       E2.equipo AS EquipoVisitante
FROM analisis_futbol_argentino A
JOIN Equipos E1 ON A.id_equipo_local = E1.id_equipo
JOIN Equipos E2 ON A.id_equipo_visitante = E2.id_equipo
WHERE DAYOFWEEK(A.fecha) = 1  
      AND A.id_resultado = 3  
ORDER BY A.fecha DESC;

-- Para ver esta Vista
-- SELECT *  FROM partidosdomingoempate

-- Stored Procedures

-- Insertar Equipo Nuevo (primero escribir el nombre del equipo nuevo, luego el id locacion, esta locación debe ser una id existente)
DELIMITER //
CREATE PROCEDURE InsertarEquipo(
    IN p_nombre_equipo VARCHAR(100),
    IN p_id_locacion INT)
BEGIN
    INSERT INTO Equipos (equipo, id_locacion)
    VALUES (p_nombre_equipo, p_id_locacion);
END//

-- Para usar esta SP 
-- CALL InsertarEquipo('Nuevo Equipo', 1);


-- Eliminar Equipo (solamente escribir el ID del equipo que queremos eliminar)
DELIMITER //
CREATE PROCEDURE EliminarEquipo(
    IN p_id_equipo INT)
BEGIN
    DELETE FROM Equipos
    WHERE id_equipo = p_id_equipo;
END//

-- Para usar esta SP
-- CALL EliminarEquipo('Id del equipo')


-- Actualizar datos de un Equipo, actualiza nombre y locacion de un equipo (insertar id equipo que queremos editar y actualizar el nombre e id locacion)
DELIMITER //
CREATE PROCEDURE ActualizarEquipo(
    IN p_id_equipo INT,
    IN p_nuevo_nombre_equipo VARCHAR(100),
    IN p_nueva_locacion INT)
BEGIN
    UPDATE Equipos
    SET equipo = p_nuevo_nombre_equipo, id_locacion = p_nueva_locacion
    WHERE id_equipo = p_id_equipo;
END//

-- Para usar esta SP
-- CALL ActualizarEquipo('id equipo, nuevo nombre e id locacion')

-- Funciones

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
-- SELECT NombreEquipo(1);

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
-- SELECT CantidadPartidosJugados(1);



-- Triggers

-- Primero creamos una tabla para de seguimiento de los usuarios

CREATE TABLE modificaciones (
  `id_modificacion` INT NOT NULL AUTO_INCREMENT,
  `usuario_modificacion` VARCHAR(45) NULL,
  `fecha_modificacion` DATE NULL,
  `hora_modificacion` DATETIME NULL,
  PRIMARY KEY (`id_modificacion`));


-- Este trigger se activará antes de un UPDATE y registrará al usuario, la fecha y la hora 

DELIMITER //
CREATE TRIGGER Update_AnalisisFutbolArgentino
BEFORE UPDATE ON analisis_futbol_argentino
FOR EACH ROW
BEGIN
    INSERT INTO modificaciones (usuario_modificacion, fecha_modificacion, hora_modificacion)
    VALUES ('analisis_futbol_argentino', CURRENT_USER(), CURRENT_DATE(), CURRENT_TIME());
END;
//

-- Este trigger se activará si insertan un gol de visita o local con un valor de -1, cambiandolo a un default de 0

DELIMITER //
CREATE TRIGGER before_insertar_goles
BEFORE INSERT ON analisis_futbol_argentino
FOR EACH ROW
BEGIN
    IF NEW.goles_local = -1 THEN
        SET NEW.goles_local = 0;
    END IF;
    
    IF NEW.goles_visita = -1 THEN
        SET NEW.goles_visita = 0;
    END IF;
END;
//

-- Usuarios

-- Usuario solo lectura
CREATE USER 'invitado'@'localhost' IDENTIFIED BY 'Invitado1';

-- permisos de solo lectura a todas las tablas
GRANT SELECT ON futbol.* TO 'invitado'@'localhost';

-- no deja que elimine registros
REVOKE DELETE ON futbol.* FROM 'invitado'@'localhost';

-- ver el usuario creado
-- SELECT User, Host FROM mysql.user WHERE User = 'invitado';
-- ver sus permisos
-- SHOW GRANTS FOR 'invitado'@'localhost';

-- usuario con permisos de lectura, insert y update
CREATE USER 'staff'@'localhost' IDENTIFIED BY 'Staff123';

-- permisos de lectura, insert y update
GRANT SELECT, INSERT, UPDATE ON futbol.* TO 'staff'@'localhost';

-- no deja que elimine registros
REVOKE DELETE ON futbol.* FROM 'staff'@'localhost';

-- ver el usuario creado
-- SELECT User, Host FROM mysql.user WHERE User = 'staff';
-- ver sus permisos
-- SHOW GRANTS FOR 'staff'@'localhost';







