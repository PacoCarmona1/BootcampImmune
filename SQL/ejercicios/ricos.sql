/* 500 RICOS DEL MUNDO*/

/*EJERCICIO 1*/
/*1. En primer lugar, es fundamental conocer los datos que queremos analizar.
Para ellos, vamos a visualizar todos los datos de la tabla.*/

SELECT *
  FROM ricos.ricos21;

 
/*EJERCICIO 2*/
/*2. ¿De cuántos países diferentes son las personas que se encuentran en la lista?
¿Cuáles son esos países?*/

SELECT DISTINCT country
  FROM ricos.ricos21;
 
SELECT COUNT(DISTINCT country) AS "Número de países diferentes"
FROM ricos.ricos21;
 
/*EJERCICIO 3*/

/*3. ¿A qué sectores profesionales pertenecen las personas de la lista? */

SELECT DISTINCT Industry
  FROM ricos.ricos21;

/*EJERCICIO 4*/
/*4. ¿Qué personas componen el TOP10 de las personas más ricas en 2021?*/

SELECT *
  FROM ricos.ricos21
ORDER BY Rango ASC
LIMIT 10;
 
/*EJERCICIO 5*/
/*5. ¿Cuál es el patrimonio medio de las personas de la lista?*/

SELECT AVG(total) as "Patrimonio medio"
  FROM ricos.ricos21;

 
/*EJERCICIO 6*/
/*6. ¿En qué puesto se encuentra Amancio Ortega? ¿Cuál es su patrimonio?*/

SELECT *
  FROM ricos.ricos21
 WHERE name = "Amancio Ortega";
 
/*EJERCICIO 7*/
/*7. ¿Qué personas se llaman Robert (o Rob…)?*/

SELECT *
  FROM ricos.ricos21
 WHERE name like "Rob%";
 
/*EJERCICIO 8*/
/*8. ¿Qué personas tienen un nombre que termina con la letra w?*/

SELECT *
  FROM ricos.ricos21
 WHERE name like "%w";
 
/*EJERCICIO 9*/
/*9. ¿Qué personas de España componen la lista?*/

SELECT *
  FROM ricos.ricos21
 WHERE country like "%Spain%";
 
/*EJERCICIO 10*/
/*10. Patrimonio medio por sector.*/

SELECT Industry, AVG(total) as "Patrimonio Medio"
  FROM ricos.ricos21
 GROUP BY Industry;
 
/*EJERCICIO 11*/
/*11. TOP5 sectores con mayor patrimonio medio.*/

SELECT Industry, AVG(total) as "Patrimonio Medio"
  FROM ricos.ricos21
GROUP BY Industry 
ORDER BY Industry
LIMIT 5;

/*EJERCICIO 12*/
/*12. Patrimonio total por país y sector, ordenado por país*/

SELECT country, industry, SUM(total) as Patrimonio_total
  FROM ricos.ricos21
GROUP BY country, industry
ORDER BY country;
 
/*EJERCICIO 13*/
/*13. ¿Hay alguna persona de China que trabaje en el sector de la tecnología?*/

SELECT *
  FROM ricos.ricos21
 WHERE country = "china" and industry = "technology";
 
/*EJERCICIO 14*/
/*14. Patrimonio medio de las personas cuyo nombre empieza por la letra k 
agrupado por país.*/

SELECT AVG(total) as Patrimonio_Medio
  FROM ricos.ricos21
 WHERE name like "k%"
ORDER BY country;
 
 
