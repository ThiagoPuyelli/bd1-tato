insert into TIPOUVA VALUES ('VIOLETA');
insert into TIPOUVA VALUES ('BLANCO');
insert into TIPOUVA VALUES ('VERDE');

insert into vino values ('TRAPICHE');
insert into vino values ('ALARIS');
insert into vino values ('COSECHA TARDIA');

INSERT INTO COMPUESTO VALUES ('VIOLETA', 'COSECHA TARDIA', 10);
insert into SIVINO VALUES ('VIOLETA');

SELECT SUM(C.PORCENTAJE), C.NOMBREVINO
FROM COMPUESTO C
GROUP BY C.NOMBREVINO
HAVING SUM(c.PORCENTAJE) <> 100;