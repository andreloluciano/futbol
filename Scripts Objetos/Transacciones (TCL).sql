-- Iniciar transacción, seteamos foreign key checks a 0 para poder borrar registros ya que son keys en otras tablas
SET AUTOCOMMIT = 0;
SET foreign_key_ckecks = 0; 

START TRANSACTION;

-- Borrar registros de la tabla Equipos
DELETE FROM Equipos WHERE id_equipo BETWEEN 1 AND 4;
SET foreign_key_ckecks = 1; 

-- Rollback completo
ROLLBACK;

-- Guardar cambios
COMMIT;

-- Iniciar transacción
START TRANSACTION;

-- Insertar registros en la tabla Locaciones
INSERT INTO locaciones (locacion) VALUES
    ('Buenos Aires'),
    ('Jujuy'),
    ('Salta'),
    ('Alta Gracia');
 savepoint checkpoint_1;

INSERT INTO Locaciones (locacion) VALUES
    ('Falda del Carmen'),
    ('Rio Cuarto'),
    ('Pilar'),
    ('Bariloche');
savepoint checkpoint_2;

-- Release Savepoint (eliminar primer checkpoint)
 RELEASE SAVEPOINT checkpoint_1;

-- Rollback hasta checkpoint_2 (comentado)
 ROLLBACK TO SAVEPOINT checkpoint_2;

-- Rollback completo
 ROLLBACK;

-- Guardar cambios
 COMMIT;