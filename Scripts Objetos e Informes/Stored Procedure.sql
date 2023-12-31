USE futbol

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
CALL InsertarEquipo('Nuevo Equipo', 1);


-- Eliminar Equipo (solamente escribir el ID del equipo que queremos eliminar)
DELIMITER //
CREATE PROCEDURE EliminarEquipo(
    IN p_id_equipo INT)
BEGIN
    DELETE FROM Equipos
    WHERE id_equipo = p_id_equipo;
END//

-- Para usar esta SP
CALL EliminarEquipo('Id del equipo')


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
CALL ActualizarEquipo('id equipo, nuevo nombre e id locacion')
