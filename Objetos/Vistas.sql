USE futbol;

-- Muestra una lista de las locaciones junto con los equipos asociados a cada una de ellas.
CREATE VIEW LocacionesyEquipos AS
SELECT L.locacion AS Locacion,
E.equipo AS Equipo
FROM Locaciones L
JOIN Equipos E ON L.id_locacion = E.id_locacion;

SELECT * FROM LocacionesyEquipos;

-- Muestra una lista de equipos que participaron en cada campeonato durante el período de 2015-2022.
CREATE VIEW CampeonatosyEquipos AS
SELECT C.campeonato AS Campeonato,
E.equipo AS Equipo
FROM Campeonatos C
JOIN Equipos E ON C.id_campeonato = E.id_equipo;

SELECT * FROM CampeonatosyEquipos;

-- Muestra un análisis de los resultados en la tabla principal
CREATE VIEW Vista_Analisis_Resultados AS
SELECT id_encuentro,
  goles_local,
  goles_visita,
  valor_mercado_local,
  valor_mercado_visita,
  edad_media_local,
  edad_media_visita
FROM analisis_futbol_argentino;

SELECT * FROM analisis_futbol_argentino;

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

SELECT *  FROM resultados_fecha

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

SELECT *  FROM partidosdomingoempate

