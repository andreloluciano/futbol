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








