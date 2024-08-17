CREATE TABLE ARTICULO
(
  ID_ART DOM_NRO NOT NULL,
  STOCK integer DEFAULT 0 NOT NULL,
  DESCRIPCION DOM_DESCRIPCION,
  PRECIO_BASE double precision DEFAULT 0 NOT NULL,
  CONSTRAINT PK_ARTICULO PRIMARY KEY (ID_ART)
);

CREATE TABLE SUCURSAL
(
  ID_SUC DOM_NRO NOT NULL,
  NOMBRE DOM_DESCRIPCION,
  CONSTRAINT PK_SUCURSAL PRIMARY KEY (ID_SUC)
);

CREATE TABLE EMPLEADO
(
  LEGAJO DOM_NRO NOT NULL,
  ID_SUC DOM_NRO,
  NOMBRE DOM_DESCRIPCION,
  APELLIDO DOM_DESCRIPCION,
  CONSTRAINT PK_EMPLEADO PRIMARY KEY (LEGAJO),
  CONSTRAINT FK_EMPLEADO_SUCURSAL FOREIGN KEY (ID_SUC) REFERENCES SUCURSAL(ID_SUC)
);

CREATE TABLE VENDE
(
  ID_ART DOM_NRO NOT NULL,
  ID_SUC DOM_NRO NOT NULL,
  STOCK integer DEFAULT 0 NOT NULL,
  PRECIO double precision DEFAULT 0 NOT NULL,
  CONSTRAINT PK_VENDE PRIMARY KEY (ID_ART,ID_SUC),
  CONSTRAINT FK_VENDE_ARTICULO FOREIGN KEY (ID_ART) REFERENCES ARTICULO(ID_ART),
  CONSTRAINT FK_VENDE_SUCURSAL FOREIGN KEY (ID_SUC) REFERENCES SUCURSAL(ID_SUC)
);