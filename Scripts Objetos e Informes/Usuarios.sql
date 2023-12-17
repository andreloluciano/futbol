USE futbol;

-- Usuario solo lectura
CREATE USER 'invitado'@'localhost' IDENTIFIED BY 'Invitado1';

-- permisos de solo lectura a todas las tablas
GRANT SELECT ON futbol.* TO 'invitado'@'localhost';

-- no deja que elimine registros
REVOKE DELETE ON futbol.* FROM 'invitado'@'localhost';

-- ver el usuario creado
SELECT User, Host FROM mysql.user WHERE User = 'invitado';
-- ver sus permisos
SHOW GRANTS FOR 'invitado'@'localhost';

-- usuario con permisos de lectura, insert y update
CREATE USER 'staff'@'localhost' IDENTIFIED BY 'Staff123';

-- permisos de lectura, insert y update
GRANT SELECT, INSERT, UPDATE ON futbol.* TO 'staff'@'localhost';

-- no deja que elimine registros
REVOKE DELETE ON futbol.* FROM 'staff'@'localhost';

-- ver el usuario creado
SELECT User, Host FROM mysql.user WHERE User = 'staff';
-- ver sus permisos
SHOW GRANTS FOR 'staff'@'localhost';

