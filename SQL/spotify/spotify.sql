/*1. Seleccionar el nombre y la fecha de la última actualización de cada artista:*/

SELECT sp_artista.NAME, MAX(sp_artista_estadisticas.FECHA) AS ultima_actualizacion
FROM spotify.sp_artista
JOIN spotify.sp_artista_estadisticas ON sp_artista.ARTIST_ID = sp_artista_estadisticas.ARTIST_ID
GROUP BY sp_artista.NAME;

/*2. Seleccionar todos los artistas y sus estadísticas:*/

SELECT sp_artista.NAME, sp_artista_estadisticas.FECHA, sp_artista_estadisticas.POPULARITY, sp_artista_estadisticas.NUM_FOLLOWERS
FROM spotify.sp_artista
JOIN spotify.sp_artista_estadisticas ON sp_artista.ARTIST_ID = sp_artista_estadisticas.ARTIST_ID;

/*3. Seleccionar los artistas que han tenido una popularidad mayor a 80 en cualquier momento:*/

SELECT sp_artista.NAME, sp_artista_estadisticas.FECHA, sp_artista_estadisticas.POPULARITY, sp_artista_estadisticas.NUM_FOLLOWERS
FROM sp_artista
INNER JOIN sp_artista_estadisticas ON sp_artista.ARTIST_ID = sp_artista_estadisticas.ARTIST_ID
WHERE sp_artista_estadisticas.POPULARITY > 80;

/*4. Seleccionar los artistas con más de 1 millón de seguidores:*/

SELECT sp_artista.NAME, sp_artista_estadisticas.FECHA, sp_artista_estadisticas.POPULARITY, sp_artista_estadisticas.NUM_FOLLOWERS
FROM spotify.sp_artista
JOIN spotify.sp_artista_estadisticas ON sp_artista.ARTIST_ID = sp_artista_estadisticas.ARTIST_ID
WHERE sp_artista_estadisticas.NUM_FOLLOWERS > 1000000;

/*5. Seleccionar el número total de seguidores de todos los artistas:*/

SELECT SUM(NUM_FOLLOWERS) AS total_seguidores
FROM spotify.sp_artista_estadisticas;

/*6.Seleccionar el artista con la mayor cantidad de seguidores:*/

SELECT sp_artista.NAME, MAX(sp_artista_estadisticas.NUM_FOLLOWERS) AS max_seguidores
FROM spotify.sp_artista
JOIN spotify.sp_artista_estadisticas ON sp_artista.ARTIST_ID = sp_artista_estadisticas.ARTIST_ID
GROUP BY sp_artista.NAME
ORDER BY max_seguidores DESC
LIMIT 1;


/*7. Seleccionar los artistas que han tenido una popularidad mayor al promedio de popularidad:*/

SELECT sp_artista.NAME, sp_artista_estadisticas.FECHA, sp_artista_estadisticas.POPULARITY, sp_artista_estadisticas.NUM_FOLLOWERS
FROM spotify.sp_artista
INNER JOIN spotify.sp_artista_estadisticas ON sp_artista.ARTIST_ID = sp_artista_estadisticas.ARTIST_ID
WHERE sp_artista_estadisticas.POPULARITY > (
    SELECT AVG(POPULARITY)
     FROM spotify.sp_artista_estadisticas);
     
/*8. Listar el nombre y la popularidad de los artistas que tuvieron una popularidad superior a 80 en abril de 2020:*/

SELECT DISTINCT sp_artista.NAME, sp_artista_estadisticas.POPULARITY
FROM spotify.sp_artista
JOIN spotify.sp_artista_estadisticas ON sp_artista.ARTIST_ID = sp_artista_estadisticas.ARTIST_ID
WHERE sp_artista_estadisticas.FECHA LIKE '%/04/20' AND sp_artista_estadisticas.POPULARITY > 90;


/*9. Listar los artistas que tienen estadísticas registradas y que tuvieron más de 50000 seguidores en algún momento:*/

SELECT sp_artista.NAME
FROM spotify.sp_artista
JOIN (
    SELECT ARTIST_ID
    FROM spotify.sp_artista_estadisticas
    WHERE NUM_FOLLOWERS > 50000
) AS t
ON sp_artista.ARTIST_ID = t.ARTIST_ID;

/*10. Listar los artistas que tienen estadísticas registradas y que tuvieron una popularidad mayor a 70 en al menos una fecha:*/

SELECT sp_artista.NAME
FROM spotify.sp_artista
JOIN (
    SELECT ARTIST_ID
    FROM spotify.sp_artista_estadisticas
    WHERE POPULARITY > 70
) AS t
ON sp_artista.ARTIST_ID = t.ARTIST_ID;

/*11. Listar los artistas que tienen estadísticas registradas y que tuvieron más de 100000 seguidores en alguna fecha en 2020:*/

SELECT DISTINCT sp_artista.NAME
FROM spotify.sp_artista
JOIN (
    SELECT ARTIST_ID
    FROM spotify.sp_artista_estadisticas
    WHERE FECHA LIKE '%20' AND NUM_FOLLOWERS > 100000
) AS t
ON sp_artista.ARTIST_ID = t.ARTIST_ID;

/*12. Seleccionar el nombre del artista y el número de seguidores en la fecha más reciente registrada:*/

SELECT sp_artista.name, sp_artista_estadisticas.num_followers
FROM spotify.sp_artista
JOIN (
  SELECT artist_id, MAX(fecha) AS fecha
  FROM spotify.sp_artista_estadisticas
  GROUP BY artist_id
) AS ultima_fecha ON sp_artista.artist_id = ultima_fecha.artist_id
JOIN spotify.sp_artista_estadisticas ON ultima_fecha.artist_id = sp_artista_estadisticas.artist_id AND ultima_fecha.fecha = sp_artista_estadisticas.fecha;


/*13. Seleccionar el nombre del artista con la popularidad más alta:*/


SELECT NAME
FROM spotify.sp_artista
WHERE artist_id = (
  SELECT artist_id
  FROM spotify.sp_artista_estadisticas
  ORDER BY popularity DESC
  LIMIT 1
);
/*14. Seleccionar el nombre de los artistas que tienen más de 50.000.000 seguidores y cuya popularidad es mayor a 80:*/


SELECT NAME
FROM spotify.sp_artista
WHERE artist_id IN (
  SELECT artist_id
  FROM spotify.sp_artista_estadisticas
  WHERE num_followers > 50000000 AND popularity > 80
);
/*15. Encontrar el artista con la mayor cantidad de seguidores:*/

SELECT NAME, NUM_FOLLOWERS
FROM spotify.sp_artista_estadisticas
JOIN spotify.sp_artista ON sp_artista_estadisticas.artist_id = sp_artista.artist_id
WHERE num_followers = (
  SELECT MAX(num_followers) 
  FROM spotify.sp_artista_estadisticas
);

/*16. Encontrar los artistas que han ganado popularidad desde la última vez que se registraron estadísticas:*/

SELECT NAME 
FROM spotify.sp_artista_estadisticas
JOIN spotify.sp_artista ON sp_artista_estadisticas.artist_id = sp_artista.artist_id
WHERE popularity > (
  SELECT popularity 
  FROM spotify.sp_artista_estadisticas AS s2
  WHERE sp_artista_estadisticas.artist_id = s2.artist_id
  ORDER BY fecha DESC
  LIMIT 1
);

