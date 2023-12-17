USE futbol;

-- Calcula el total de partidos jugados en una fecha específica.
SELECT COUNT(*) AS total_partidos
FROM Vista_Analisis_Resultados
WHERE fecha = '2015-02-22';

-- Partidos con Mayor Cantidad de Goles (sumando los goles locales y de visitantes)
SELECT
    partido,
    EL.equipo AS equipo_local,
    EV.equipo AS equipo_visitante,
    goles_local + goles_visita AS total_goles
FROM
    Vista_Analisis_Resultados
JOIN equipos EL ON Vista_Analisis_Resultados.id_equipo_local = EL.id_equipo
JOIN equipos EV ON Vista_Analisis_Resultados.id_equipo_visitante = EV.id_equipo
ORDER BY total_goles DESC
LIMIT 10;

-- Equipo que más partidos tuvo y equipo que menos partidos tuvo
-- Más partidos
SELECT equipo, COUNT(*) AS total_partidos
FROM Vista_Analisis_Resultados
GROUP BY equipo
ORDER BY total_partidos DESC
LIMIT 1;

-- Menos partidos
SELECT equipo, COUNT(*) AS total_partidos
FROM Vista_Analisis_Resultados
GROUP BY equipo
ORDER BY total_partidos ASC
LIMIT 1;

-- Edad promedio de los equipos
SELECT equipo, AVG(edad_media_local) AS edad_promedio
FROM Vista_Analisis_Resultados
GROUP BY equipo
ORDER BY edad_promedio DESC;



