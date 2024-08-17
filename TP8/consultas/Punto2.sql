INSERT INTO REVISTA (ID_REV, NOMBRE) 
VALUES (1, 'National Geographics');

INSERT INTO ANIO (ANIO, ID_REV) 
VALUES (2023, 1);

INSERT INTO ANIO (ANIO, ID_REV) 
VALUES (2023, 2);

INSERT INTO ANIO (ANIO, ID_REV) 
VALUES (2022, 1);

INSERT INTO EJEMPLAR (NUMERO, PESO, CANTIDAD, PAGINAS, VALOR, ANIO, ID_REV) 
VALUES (1, 150.5, 100, 50, 20.99, 2023, 1);

INSERT INTO EJEMPLAR (NUMERO, PESO, CANTIDAD, PAGINAS, VALOR, ANIO, ID_REV) 
VALUES (2, 120.8, 80, 40, 15.50, 2023, 1);

INSERT INTO EJEMPLAR (NUMERO, PESO, CANTIDAD, PAGINAS, VALOR, ANIO, ID_REV) 
VALUES (3, 200.2, 120, 60, 25.75, 2023, 2);

INSERT INTO MATERIA (NOMBRE_MAT) 
VALUES ('Ciencia');

INSERT INTO MATERIA (NOMBRE_MAT) 
VALUES ('Tecnología');

INSERT INTO MATERIA (NOMBRE_MAT) 
VALUES ('Historia');

INSERT INTO ARTICULO (PAGINA_INICIO, PAGINA_FIN, NUMERO, ANIO, ID_REV, NOMBRE_MAT, NOMBRE) 
VALUES (1, 10, 1, 2023, 1, 'Ciencia', 'Articulo1');

INSERT INTO ARTICULO (PAGINA_INICIO, PAGINA_FIN, NUMERO, ANIO, ID_REV, NOMBRE_MAT, NOMBRE) 
VALUES (11, 20, 2, 2023, 1, 'Tecnología', 'Articulo2');

INSERT INTO ARTICULO (PAGINA_INICIO, PAGINA_FIN, NUMERO, ANIO, ID_REV, NOMBRE_MAT, NOMBRE) 
VALUES (21, 30, 3, 2023, 2, 'Historia', 'Articulo3');

SELECT COUNT(*), A.NUMERO, R.NOMBRE
FROM ARTICULO A
INNER JOIN REVISTA R ON R.ID_REV = A.ID_REV
WHERE R.NOMBRE = 'National Geographics'
GROUP BY A.NUMERO, R.NOMBRE