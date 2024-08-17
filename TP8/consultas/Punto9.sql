INSERT INTO GUIA (DNI, NOMBRE, APELLIDO, MAIL, TE) 
VALUES (1001, 'Juan', 'Gómez', 'juan.gomez@example.com', '555-1234');

INSERT INTO GUIA (DNI, NOMBRE, APELLIDO, MAIL, TE) 
VALUES (1002, 'María', 'Martínez', 'maria.martinez@example.com', '555-5678');

INSERT INTO GUIA (DNI, NOMBRE, APELLIDO, MAIL, TE) 
VALUES (1003, 'Carlos', 'López', 'carlos.lopez@example.com', '555-9876');


INSERT INTO CLIENTE (IDC, NOMBRE, APELLIDO, MAIL, DIRECCION) 
VALUES (2001, 'Luis', 'García', 'luis.garcia@example.com', 'Calle 123');

INSERT INTO CLIENTE (IDC, NOMBRE, APELLIDO, MAIL, DIRECCION) 
VALUES (2002, 'Ana', 'Sánchez', 'ana.sanchez@example.com', 'Avenida Principal');

INSERT INTO CLIENTE (IDC, NOMBRE, APELLIDO, MAIL, DIRECCION) 
VALUES (2003, 'Roberto', 'Díaz', 'roberto.diaz@example.com', 'Plaza Central');


INSERT INTO TOUR (IDT, DESCRIPCION, OBSERVACIONES) 
VALUES (3001, 'Tour de Ciudad', 'Recorrido por los lugares más emblemáticos de la ciudad');

INSERT INTO TOUR (IDT, DESCRIPCION, OBSERVACIONES) 
VALUES (3002, 'Aventura en la Naturaleza', 'Exploración de paisajes naturales y actividades al aire libre');

INSERT INTO TOUR (IDT, DESCRIPCION, OBSERVACIONES) 
VALUES (3003, 'Gastronomía Local', 'Degustación de platos tradicionales en restaurantes locales');

INSERT INTO VIAJE (IDV, FECHA, PRECIO, DNI, IDT) VALUES (4001, '2023-11-24', 100.00, 1001, 3001);
INSERT INTO VIAJE (IDV, FECHA, PRECIO, DNI, IDT) VALUES (4002, '2023-11-25', 150.00, 1002, 3002);
INSERT INTO VIAJE (IDV, FECHA, PRECIO, DNI, IDT) VALUES (4003, '2023-11-26', 120.00, 1003, 3003);

INSERT INTO CONTRATADO (IDV, IDC, CANTCUOTAS) VALUES (4001, 2001, 2);
INSERT INTO CONTRATADO (IDV, IDC, CANTCUOTAS) VALUES (4002, 2002, 3);
INSERT INTO CONTRATADO (IDV, IDC, CANTCUOTAS) VALUES (4003, 2003, 2);

INSERT INTO GUIA (DNI, NOMBRE, APELLIDO, MAIL, TE) VALUES (1004, 'Laura', 'García', 'laura.garcia@example.com', '555-1111');
INSERT INTO GUIA (DNI, NOMBRE, APELLIDO, MAIL, TE) VALUES (1005, 'Fernando', 'Díaz', 'fernando.diaz@example.com', '555-2222');
INSERT INTO GUIA (DNI, NOMBRE, APELLIDO, MAIL, TE) VALUES (1006, 'Sofía', 'Ramírez', 'sofia.ramirez@example.com', '555-3333');
INSERT INTO GUIA (DNI, NOMBRE, APELLIDO, MAIL, TE) VALUES (1007, 'Diego', 'Hernández', 'diego.hernandez@example.com', '555-4444');
INSERT INTO GUIA (DNI, NOMBRE, APELLIDO, MAIL, TE) VALUES (1008, 'Elena', 'Ortega', 'elena.ortega@example.com', '555-5555');

INSERT INTO CLIENTE (IDC, NOMBRE, APELLIDO, MAIL, DIRECCION) VALUES (2004, 'Julián', 'Pérez', 'julian.perez@example.com', 'Calle 456');
INSERT INTO CLIENTE (IDC, NOMBRE, APELLIDO, MAIL, DIRECCION) VALUES (2005, 'Silvia', 'Fernández', 'silvia.fernandez@example.com', 'Avenida Secundaria');
INSERT INTO CLIENTE (IDC, NOMBRE, APELLIDO, MAIL, DIRECCION) VALUES (2006, 'Gabriel', 'López', 'gabriel.lopez@example.com', 'Ruta Panorámica');
INSERT INTO CLIENTE (IDC, NOMBRE, APELLIDO, MAIL, DIRECCION) VALUES (2007, 'Natalia', 'Gómez', 'natalia.gomez@example.com', 'Plaza del Centro');
INSERT INTO CLIENTE (IDC, NOMBRE, APELLIDO, MAIL, DIRECCION) VALUES (2008, 'Iván', 'Díaz', 'ivan.diaz@example.com', 'Calle Principal');

INSERT INTO TOUR (IDT, DESCRIPCION, OBSERVACIONES) VALUES (3004, 'Historia Local', 'Recorrido por sitios históricos de la ciudad');
INSERT INTO TOUR (IDT, DESCRIPCION, OBSERVACIONES) VALUES (3005, 'Aventura Extrema', 'Actividades extremas para los amantes de la adrenalina');
INSERT INTO TOUR (IDT, DESCRIPCION, OBSERVACIONES) VALUES (3006, 'Cata de Vinos', 'Visita a viñedos locales con degustación de vinos');
INSERT INTO TOUR (IDT, DESCRIPCION, OBSERVACIONES) VALUES (3007, 'Caminata en la Naturaleza', 'Excursión por senderos naturales y bosques');
INSERT INTO TOUR (IDT, DESCRIPCION, OBSERVACIONES) VALUES (3008, 'Arte y Cultura', 'Exploración de galerías y eventos culturales');

INSERT INTO VIAJE (IDV, FECHA, PRECIO, DNI, IDT) VALUES (4004, '2023-11-27', 80.00, 1004, 3004);
INSERT INTO VIAJE (IDV, FECHA, PRECIO, DNI, IDT) VALUES (4005, '2023-11-28', 120.00, 1005, 3005);
INSERT INTO VIAJE (IDV, FECHA, PRECIO, DNI, IDT) VALUES (4006, '2023-11-29', 100.00, 1006, 3006);
INSERT INTO VIAJE (IDV, FECHA, PRECIO, DNI, IDT) VALUES (4007, '2023-11-30', 90.00, 1007, 3007);
INSERT INTO VIAJE (IDV, FECHA, PRECIO, DNI, IDT) VALUES (4008, '2023-12-01', 110.00, 1008, 3008);

INSERT INTO CONTRATADO (IDV, IDC, CANTCUOTAS) VALUES (4004, 2004, 2);
INSERT INTO CONTRATADO (IDV, IDC, CANTCUOTAS) VALUES (4005, 2005, 3);
INSERT INTO CONTRATADO (IDV, IDC, CANTCUOTAS) VALUES (4006, 2006, 2);
INSERT INTO CONTRATADO (IDV, IDC, CANTCUOTAS) VALUES (4007, 2007, 4);
INSERT INTO CONTRATADO (IDV, IDC, CANTCUOTAS) VALUES (4008, 2008, 3);

SELECT MAX(SUB.SUMA) AS TOTAL, SUB.DNI, SUB.NOMBRE, SUB.APELLIDO
FROM (
    SELECT SUM(V.PRECIO) AS SUMA, G.DNI, G.NOMBRE, G.APELLIDO
    FROM GUIA G
    INNER JOIN VIAJE V ON V.DNI = G.DNI
    INNER JOIN CONTRATADO C ON C.IDV = V.IDV
    INNER JOIN CLIENTE CL ON CL.IDC = C.IDC
    GROUP BY G.DNI, G.NOMBRE, G.APELLIDO
) AS SUB
GROUP BY SUB.DNI, SUB.SUMA, SUB.NOMBRE, SUB.APELLIDO
HAVING SUB.SUMA = (
    SELECT MAX(SUB2.SUMA) AS TOTAL
      FROM (
      SELECT SUM(V.PRECIO) AS SUMA, G.DNI
      FROM GUIA G
      INNER JOIN VIAJE V ON V.DNI = G.DNI
      INNER JOIN CONTRATADO C ON C.IDV = V.IDV
      INNER JOIN CLIENTE CL ON CL.IDC = C.IDC
      GROUP BY G.DNI
    ) AS SUB2
)