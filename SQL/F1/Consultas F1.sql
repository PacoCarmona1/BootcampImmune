/*1. Mostrar la lista de todos los circuitos de Fórmula 1 junto con su ubicación geográfica*/

SELECT nombre, concat(location, ', ', country) AS ubicacion
  FROM f1.circuits;

/*2. Mostrar el nombre, la fecha y la ubicación de todas las carreras en el año 2022:*/

SELECT nombre, fecha
  FROM f1.races 
 WHERE año = 2022;
 
/*3. Mostrar la cantidad de carreras que se han celebrado en cada país:*/

SELECT country, COUNT(*) AS races
  FROM f1.circuits
GROUP BY country
ORDER BY races DESC;


/*4. Mostrar la lista de todas las carreras de Fórmula 1 junto con el nombre del circuito y la fecha de la carrera:*/

SELECT races.nombre, circuits.nombre, races.fecha
  FROM f1.races
  JOIN f1.circuits ON races.circuitId = circuits.circuitId
ORDER BY races.fecha DESC;

/*5. Obtener el nombre y la ubicación de todos los circuitos que tienen una altitud superior a 1000 metros.*/

SELECT nombre, location
  FROM f1.circuits
 WHERE alt > 1000;


/*6. Mostrar el nombre del equipo y la cantidad de puntos obtenidos en todas las carreras:*/

SELECT nombre, SUM(results.points) AS total_points
  FROM f1.constructors
  JOIN f1.results ON constructors.constructorId = results.constructorId
GROUP BY nombre
ORDER BY total_points DESC;

/*7. Mostrar los 10 circuitos que han albergado la mayor cantidad de carreras de F1, ordenados por el número total de carreras en orden descendente:*/

SELECT circuits.nombre, COUNT(*) AS total_races
  FROM f1.races
  JOIN f1.circuits ON circuits.circuitId = races.circuitId
GROUP BY circuits.nombre
ORDER BY total_races DESC
LIMIT 10;

/*8. Obtener la cantidad de carreras que se han celebrado en cada temporada:*/

SELECT año, COUNT(*) AS races
  FROM f1.races
 GROUP BY año
 ORDER BY año ASC;

 /*9. ¿Cuál es el promedio de tiempo de pit stops por carrera?*/
 
SELECT AVG(duration) AS avg_pit_stop_duration, races.nombre AS race
  FROM f1.pit_stops 
  JOIN f1.races ON pit_stops.raceId = races.raceId
GROUP BY races.nombre
ORDER BY avg_pit_stop_duration ASC;


/*10. Mostrar el nombre del equipo y el tiempo de vuelta más rápido registrado por un piloto de ese equipo:*/

SELECT constructors.nombre, MIN(lap_times.tiempo)
  FROM f1.constructors
  JOIN f1.results ON constructors.constructorId = results.constructorId
  JOIN f1.lap_times ON results.driverId = lap_times.driverId
GROUP BY constructors.nombre;


/*11. Mostrar la cantidad de carreras ganadas por cada piloto:*/

SELECT CONCAT(drivers.forename, ' ', drivers.surname) AS Nombre_piloto, COUNT(results.position) AS Victorias
  FROM f1.drivers
  JOIN f1.results ON drivers.driverId = results.driverId
 WHERE results.position = 1
GROUP BY Nombre_piloto;

/*12. Mostrar el nombre del piloto y el total de puntos que ha acumulado a lo largo de su carrera.*/

SELECT CONCAT(drivers.forename, ' ', drivers.surname) AS Nombre_piloto, SUM(results.points) AS total_points
  FROM f1.drivers
  JOIN f1.results ON drivers.driverId = results.driverId
GROUP BY Nombre_piloto
ORDER BY total_points DESC;

/*13. Mostrar el circuito con el tiempo total de todas las vueltas más bajo de todos los circuitos de la Fórmula 1 en horas.*/

SELECT circuits.nombre AS circuit,
  SUM(lap_times.milliseconds)/1000/60/60 AS Total_Horas
  FROM f1.lap_times 
   JOIN f1.races ON lap_times.raceId = races.raceId 
   JOIN f1.circuits ON races.circuitId = circuits.circuitId
 GROUP BY circuits.nombre
 ORDER BY Total_Horas ASC
 LIMIT 1;
 
/*14. Mostrar la cantidad de carreras ganadas por cada equipo:*/
/*RESULTADO NO ES CIERTO POR LA FALTA DE DATOS EN ALGUNAS TABLAS*/

SELECT constructors.nombre, COUNT(results.position) AS wins
  FROM f1.constructors
  JOIN f1.results ON constructors.constructorId = results.constructorId
 WHERE results.position = 1
GROUP BY constructors.nombre;

/*15. Mostrar todos los circuitos de Fórmula 1 en un país determinado*/

SELECT DISTINCT circuits.nombre, circuits.location
  FROM f1.circuits
  JOIN f1.races ON races.circuitId = circuits.circuitId
 WHERE circuits.country = 'Italy';

/*16. Mostrar los detalles de todas las carreras en una temporada específica, incluyendo la posición final de los pilotos en la tabla de clasificación:*/

SELECT races.nombre, races.fecha, results.position, drivers.forename, drivers.surname, constructors.nombre
  FROM f1.results
  JOIN f1.races ON races.raceId = results.raceId
  JOIN f1.drivers ON drivers.driverId = results.driverId
  JOIN f1.constructors ON constructors.constructorId = results.constructorId
 WHERE races.año = 2007
ORDER BY results.position ASC;

/*17. ¿Que resultados obtuvo Fernando Alonso en el año 2008?*/

SELECT races.nombre AS carrera, races.fecha AS fecha, results.position AS posicion
  FROM f1.results
  JOIN f1.races ON results.raceId = races.raceId
  JOIN f1.drivers ON results.driverId = drivers.driverId
 WHERE drivers.driverId = 5 AND races.año = 2008
ORDER BY races.fecha ASC;


/*18. Devuelve el nombre y la nacionalidad de los pilotos que han ganado al menos una carrera en un
circuito ubicado en un país que ha organizado más de 10 carreras de F1:*/

SELECT drivers.surname, drivers.nationality
  FROM f1.drivers
 WHERE driverId IN (
    SELECT results.driverId
    FROM f1.results
    INNER JOIN f1.races ON results.raceId = races.raceId
    INNER JOIN f1.circuits ON races.circuitId = circuits.circuitId
    WHERE circuits.country IN (
        SELECT circuits.country
        FROM f1.circuits
        INNER JOIN f1.races ON circuits.circuitId = races.circuitId
        GROUP BY circuits.country
        HAVING COUNT(DISTINCT races.año) > 10
    )
    AND results.position = 1
);

 /*19. Mostrar el promedio de puntos obtenidos por cada constructor en cada temporarada en la tabla constructor_standings de la base de datos de la Fórmula 1.
Solo se consideran aquellos constructores que tienen al menos 5 registros en la tabla constructor_standings.*/
        
SELECT c.nombre AS constructor_nombre, cs.constructorId, AVG(cs.points) AS Promedio_puntos
  FROM f1.constructor_standings cs
  JOIN f1.constructors c ON c.constructorId = cs.constructorId
 WHERE cs.constructorId IN (
  SELECT constructorId
    FROM f1.constructor_standings
  GROUP BY constructorId
  HAVING COUNT(*) >= 5
)
GROUP BY cs.constructorId, c.nombre;

 /*20. Obtener la posición final y el tiempo más rápido de cada conductor en cada carrera en la temporada 2008:*/

SELECT r.raceId, r.nombre, concat(d.forename, '  ', d.surname) AS driver, res.position, res.time
  FROM f1.races r
  JOIN f1.results res ON r.raceId = res.raceId
  JOIN f1.drivers d ON d.driverId = res.driverId
 WHERE r.año = 2008
AND res.position = 1
AND res.time IN (
		SELECT MIN(time) 
		  FROM f1.results 
         WHERE raceId = res.raceId AND driverId = res.driverId
        );


