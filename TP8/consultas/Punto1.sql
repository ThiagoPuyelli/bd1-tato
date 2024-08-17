insert into EDITORIAL values(1, 'Billiken');
insert into EDITORIAL values(2, 'Rockstar');

insert into LIBRO values(34232, 'El principito', 3, 1);
insert into LIBRO values(5161556, 'La caperusita roja', 3, 1);

insert into EJEMPLAR values (1, false, 34232);
insert into EJEMPLAR values (2, false, 34232);
insert into EJEMPLAR values (3, false, 34232);
insert into EJEMPLAR values (1, false, 5161556);
insert into EJEMPLAR values (2, false, 5161556);
insert into EJEMPLAR values (3, false, 5161556);

insert into CARRERA values (1, 'Sistemas');
insert into CARRERA values (2, 'Enfermeria');

insert into ALUMNO values (190242, 45293957, 'Thiago Puyelli', 1);
insert into ALUMNO values (1804562, 45293912, 'Franco Ochoa', 2);
insert into ALUMNO values (1801515, 452948484, 'Julian Buzzi', 1);

insert into PRESTO (FECHA_INICIO, FECHA_LIMITE, LEGAJO, ISBN, ID_EJ)
values (CURRENT_DATE - 7, CURRENT_DATE - 3, 190242, 34232, 1);
insert into PRESTO (FECHA_INICIO, FECHA_DEVOLUCION, FECHA_LIMITE, LEGAJO, ISBN, ID_EJ)
values (CURRENT_DATE - 7, CURRENT_DATE - 4, CURRENT_DATE - 3, 1804562, 34232, 1);
insert into PRESTO (FECHA_INICIO,FECHA_LIMITE, LEGAJO, ISBN, ID_EJ) 
values (CURRENT_DATE - 7, CURRENT_DATE - 3, 1801515, 34232, 2);

SELECT A.*, L.*, E.*
FROM PRESTO P
INNER JOIN EJEMPLAR E ON E.ISBN = P.ISBN AND E.ID_EJ = P.ID_EJ AND P.FECHA_DEVOLUCION IS null AND P.FECHA_LIMITE >= CURRENT_DATE
INNER JOIN LIBRO L ON E.ISBN = L.ISBN
INNER JOIN ALUMNO A ON A.LEGAJO = P.LEGAJO;


