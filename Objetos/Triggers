USE futbol

-- Primero creamos una tabla para de seguimiento de los usuarios

CREATE TABLE modificaciones (
  id_modificacion INT NOT NULL AUTO_INCREMENT,
  usuario_modificacion VARCHAR(45) NULL,
  fecha_modificacion DATE NULL,
  hora_modificacion DATETIME NULL,
  PRIMARY KEY (id_modificacion));


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
