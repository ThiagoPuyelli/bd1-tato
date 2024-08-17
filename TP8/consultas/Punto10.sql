INSERT INTO EQUIPO (ID_E) VALUES (1); 
INSERT INTO EQUIPO (ID_E) VALUES (2); 
INSERT INTO EQUIPO (ID_E) VALUES (3);


INSERT INTO AUTORIDAD (ID_A, NOMBRE, APELLIDO) VALUES (1, 'Nombre1', 'Apellido1');
INSERT INTO AUTORIDAD (ID_A, NOMBRE, APELLIDO) VALUES (2, 'Nombre2', 'Apellido2');
INSERT INTO AUTORIDAD (ID_A, NOMBRE, APELLIDO) VALUES (3, 'Nombre3', 'Apellido3');


INSERT INTO LUGAR (ESTADIO) VALUES ('Estadio1'); 
INSERT INTO LUGAR (ESTADIO) VALUES ('Estadio2');
INSERT INTO LUGAR (ESTADIO) VALUES ('Estadio3');


INSERT INTO PARTIDO (ID_P, FECHA, HORA_DESDE, HORA_HASTA, GOLES_LOCAL, GOLES_VISITANTE, RESULTADO, JL1, JL2, AR, ESTADIO, VISITANTE, LOCALE) 
VALUES (1, '2023-11-24', '15:00', '17:00', 2, 1, 'local', 1, 2, 3, 'Estadio1', 1, 2);
INSERT INTO PARTIDO (ID_P, FECHA, HORA_DESDE, HORA_HASTA, GOLES_LOCAL, GOLES_VISITANTE, RESULTADO, JL1, JL2, AR, ESTADIO, VISITANTE, LOCALE) 
VALUES (2, '2023-11-25', '16:00', '18:00', 0, 0, 'empate', 2, 3, 1, 'Estadio2', 2, 3);
INSERT INTO PARTIDO (ID_P, FECHA, HORA_DESDE, HORA_HASTA, GOLES_LOCAL, GOLES_VISITANTE, RESULTADO, JL1, JL2, AR, ESTADIO, VISITANTE, LOCALE) 
VALUES (3, '2023-11-26', '14:00', '16:00', 1, 3, 'visitante', 3, 1, 2, 'Estadio3', 3, 1);
INSERT INTO PARTIDO (ID_P, FECHA, HORA_DESDE, HORA_HASTA, GOLES_LOCAL, GOLES_VISITANTE, RESULTADO, JL1, JL2, AR, ESTADIO, VISITANTE, LOCALE) 
VALUES (4, '2023-11-20', '19:00', '21:00', null, null, null, 3, 1, 2, 'Estadio3', 3, 1);

SELECT * 
FROM PARTIDO P
WHERE P.RESULTADO IS NOT NULL;