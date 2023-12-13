CREATE SCHEMA futbol;
USE futbol;

CREATE TABLE "locaciones" (
	"id_locacion"	INTEGER NOT NULL,
	"locacion"	TEXT,
	PRIMARY KEY("id_locacion" AUTOINCREMENT)
);

CREATE TABLE "equipos" (
	"id_equipo"	INTEGER NOT NULL,
	"equipo"	TEXT,
	"id_locacion"	INTEGER NOT NULL,
	PRIMARY KEY("id_equipo" AUTOINCREMENT)
	FOREIGN KEY (id_locacion) REFERENCES locacion(id)
);

CREATE TABLE "resultados" (
	"id_resultado"	INTEGER NOT NULL,
	"resultado"	TEXT,
	PRIMARY KEY("id_resultado" AUTOINCREMENT)
);

CREATE TABLE "campeonatos" (
	"id_campeonato"	INTEGER NOT NULL,
	"campeonato"	TEXT,
	PRIMARY KEY("id_campeonato" AUTOINCREMENT)
);

CREATE TABLE "analisis futbol argentino" (
	"id_encuentro"	INTEGER NOT NULL,
	"fecha_torneo"	INTEGER,
	"partido"	INTEGER,
	"goles_local"	INTEGER,
	"goles_visita"	INTEGER,
	"valor_mercado_local"	NUMERIC,
	"altura_media_local"	NUMERIC,
	"edad_media_local"	NUMERIC,
	"valor_mercado_visita"	NUMERIC,
	"altura_media_visita"	NUMERIC,
	"fecha"	datetime,
	"nombre_dia"	TEXT,
	"apuesta_local"	NUMERIC,
	"apuesta_visita"	NUMERIC,
	"apuesta_empate"	NUMERIC,
	"id_campeonato"	INTEGER NOT NULL,
	"id_equipo_local"	INTEGER NOT NULL,
	"id_equipo_visitante"	INTEGER NOT NULL,
	"id_locacion"	INTEGER NOT NULL,
	"id_resultado"	INTEGER NOT NULL,
	FOREIGN KEY (id_campeonato) REFERENCES campeonatos(id),
	FOREIGN KEY (id_equipo_local) REFERENCES equipos(id),
	FOREIGN KEY (id_equipo_visitante) REFERENCES equipos(id),
	FOREIGN KEY (id_locacion) REFERENCES locaciones(id),
	FOREIGN KEY (id_resultado) REFERENCES resultados(id),
	PRIMARY KEY("id_encuentro" AUTOINCREMENT)
);
