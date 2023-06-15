/*EJERCICIOS CLASE 21 MARZO*/
/*GESTION EMPLEADOS(CONSULTA RESUMEN)*/
/*EJ 1*/

SELECT SUM(presupuesto) as "Suma de Presupuestos"
  FROM empleados.departamento;

/*EJ 2*/
SELECT AVG(presupuesto) as "Media presupuestos"
  FROM empleados.departamento;
  
/*EJ 3*/
SELECT MIN(presupuesto) 
  FROM empleados.departamento;
  
/*EJ 5*/
SELECT MAX(presupuesto)
  FROM empleados.departamento;
  
/*EJ 7*/
SELECT COUNT(*)
  FROM empleados.empleado;
  
/* EJERCICIOS TIENDA*/

/* EJ 37*/

SELECT COUNT(*)
  FROM tienda.producto;

/* EJ 38*/

SELECT COUNT(*)
  FROM tienda.fabricante;

/* EJ 39*/

SELECT COUNT(DISTINCT codigo_fabricante)
  FROM tienda.producto;

/* EJ 40*/

SELECT AVG(precio)
  FROM tienda.producto;

/* EJ 41*/

SELECT MIN(producto)
  FROM tienda.producto;

/* EJ 42*/

SELECT MAX(producto)
  FROM tienda.producto;
  
/* EJ 43*/

SELECT SUM(precio)
  FROM tienda.producto;
  
/* EJERCICIOS EMPLEADOS*/

/* EJ9*/

SELECT COUNT(*), codigo_departamento
  FROM empleados.empleado
 GROUP BY codigo_departamento;
 
 
/* EJERCICIOS VENTA*/

/* CONSULTAS RESUME*/

/* EJ 7*/

SELECT MAX(categoría), ciudad
  FROM ventas.cliente
  GROUP BY ciudad;
  
/* EJ 14*/
  
SELECT MAX(total), YEAR(fecha)
  FROM ventas.pedido
 GROUP BY YEAR(fecha);
 
/* EJERCICIOS TIENDA*/

/* EJ 54*/

SELECT COUNT(*)
  FROM tienda.producto
 WHERE precio >= 180;
 
/* EJ 56*/

SELECT AVG(precio) as "precio medio", codigo_fabricante
  FROM tienda.producto
GROUP BY codigo_fabricante;

/* EJ 52*/

SELECT MAX(precio), MIN(precio), AVG(precio), COUNT(*), codigo_fabricante
  FROM tienda.producto
GROUP BY codigo_fabricante
HAVING AVG(precio) >= 200;


SELECT *
  FROM ricos.ricos21
 WHERE country = "Spain" or country = "Spain "