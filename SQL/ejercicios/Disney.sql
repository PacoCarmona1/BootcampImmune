/* Realizar 20 consultas, de las cuales:
o Al menos 10, deben incluir un JOIN entre tablas*/



/*1.Obtener el número total de películas y programas de televisión lanzados por Disney por año.*/

SELECT release_year, COUNT(*) as total_titles
FROM peliculas.titles
GROUP BY release_year;

/*2.Obtener el nombre y la cantidad de créditos de los 5 actores con más créditos en la base de datos de Disney.*/

SELECT c.nombre, COUNT(*) as total_credits
FROM peliculas.credits c
GROUP BY c.nombre
ORDER BY total_credits DESC
LIMIT 5;

/*3.Obtener el título, el año de lanzamiento de las peliculas de los Avengers*/

SELECT t.titulo, t.release_year
FROM peliculas.titles t
WHERE t.titulo LIKE 'Avenger%'
GROUP BY t.titulo, t.release_year;

/*4.Obtener el nombre y la cantidad de créditos de todos los actores que han tenido más de 20 créditos en la base de datos de Disney.*/

SELECT c.nombre, COUNT(*) as total_credits
FROM peliculas.credits c
GROUP BY c.nombre
HAVING COUNT(*) > 20;

/*5.Obtener el nombre y la cantidad de créditos de todos los directores que han tenido más de 10 créditos en la base de datos de Disney.*/

SELECT c.nombre, COUNT(*) as total_credits
FROM peliculas.credits c
WHERE c.role = 'director'
GROUP BY c.nombre
HAVING COUNT(*) > 10;

/*6.Obtener el número total de créditos (actores, directores, escritores, etc.) asociados con cada título de Disney.*/

SELECT t.titulo, COUNT(*) as total_credits
FROM peliculas.titles t
JOIN peliculas.credits c ON t.id = c.id
GROUP BY t.titulo;

/*7.Obtener el número total de episodios de cada temporada de la serie "Mickey Mouse".*/

SELECT t.seasons, SUM(t.runtime) as total_runtime
FROM peliculas.titles t
WHERE t.titulo = 'Mickey Mouse'
GROUP BY t.seasons;

/*8.Obtener el número total de películas y programas de televisión lanzados por Disney por año.*/

SELECT release_year, COUNT(*) as total_titles
FROM peliculas.titles
GROUP BY release_year;

/*9.Obtener el número total de créditos (actores, directores, escritores, etc.) asociados con cada título de Disney.*/

SELECT t.titulo, COUNT(*) as total_credits
FROM peliculas.titles t
JOIN peliculas.credits c ON t.id = c.id
GROUP BY t.titulo;

/*10.La cantidad de títulos de películas lanzados por año, pero solo para aquellos años en los que se lanzaron al menos 5 películas.*/

SELECT release_year, COUNT(*) as num_titles
FROM peliculas.titles
WHERE tipo = 'movie'
GROUP BY release_year
HAVING COUNT(*) >= 5;

/*o Al menos 10, deben incluir GROUP BY/HAVING*/

/*1.Obtener el nombre de todos los actores y el título de las películas en las que aparecieron juntos en una película con una calificación de edad de "PG-13" 
en la base de datos de Disney.*/

SELECT c.nombre, t.titulo
FROM peliculas.credits c
JOIN peliculas.titles t ON c.id = t.id
WHERE c.role = 'actor' AND t.age_certification = 'PG-13';

/*2.Obtener el título y el número de todas las peliculas en las que trabajó el actor "Harrison Ford".*/

SELECT t.titulo
FROM peliculas.credits c
JOIN peliculas.titles t ON c.id = t.id
WHERE c.nombre = 'Harrison Ford' AND t.tipo = 'MOVIE';

/*3.Obtener el nombre de todos los actores y el título de las películas en las que aparecieron juntos en una película lanzada después de 1999
 en la base de datos de Disney.*/

SELECT c.nombre, t.titulo
FROM peliculas.credits c
JOIN peliculas.titles t ON c.id = t.id
WHERE c.role = 'actor' AND t.release_year > 1999;

/*4.Obtener el título y el año de lanzamiento de todas las películas en las que el director "Clarence Nash" trabajó.*/

SELECT t.titulo, t.release_year
FROM peliculas.credits c
JOIN peliculas.titles t ON c.id = t.id
WHERE c.nombre = 'Clarence Nash' AND t.tipo = 'MOVIE';

/*5.Obtener el nombre y la cantidad de créditos de todas las personas que han trabajado en la película "The Lion King".*/

SELECT c.nombre, COUNT(*) as total_credits
FROM peliculas.credits c
JOIN peliculas.titles t ON c.id = t.id
WHERE t.titulo = 'The Lion King'
GROUP BY c.nombre;

/*6.Obtener el nombre de todos los actores y el título de las películas en las que aparecieron juntos en una película con una calificación de edad de "TV-PG" 
en la base de datos de Disney.*/

SELECT c.nombre, t.titulo
FROM peliculas.credits c
JOIN peliculas.titles t ON c.id = t.id
WHERE c.role = 'actor' AND t.age_certification = 'TV-PG';

/*7.Obtener el título y la edad de certificación de todas las películas en las que actuó el actor "Tom Hanks".*/

SELECT t.titulo, t.age_certification
FROM peliculas.credits c
JOIN peliculas.titles t ON c.id = t.id
WHERE c.nombre = 'Tom Hanks';

/*8.Obtener el nombre de todos los actores y el título de las películas en las que aparecieron juntos en la base de datos de Disney.*/

SELECT c.nombre, t.titulo
FROM peliculas.credits c
JOIN peliculas.titles t ON c.id = t.id
WHERE c.role = 'actor';

/*9.Obtener el nombre, person_id y personaje interpretado por todos los actores que aparecieron en la película "The Lion King"*/

SELECT c.nombre, c.person_id, c.character
FROM peliculas.credits c
JOIN peliculas.titles t ON c.id = t.id
WHERE t.titulo = 'The Lion King'
AND c.role = 'actor';

/*10.Obtener el nombre de todos los actores y el título de las películas en las que aparecieron juntos en una película 
con una calificación de edad de "PG-13" en la base de datos de Disney.*/

SELECT c.nombre, t.titulo
FROM peliculas.credits c
JOIN peliculas.titles t ON c.id = t.id
WHERE c.role = 'actor' AND t.age_certification = 'PG-13';
