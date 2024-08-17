CREATE TABLE CLIENTE
(
  DNI integer NOT NULL,
  EMAIL DOM_DESCRIPCION,
  NOMBRE DOM_DESCRIPCION,
  APELLIDO DOM_DESCRIPCION,
  TELEFONO integer NOT NULL,
  CONSTRAINT PK_CLIENTE PRIMARY KEY (DNI),
  CONSTRAINT UNIQUE_EMAIL_CLIENTE UNIQUE (EMAIL)
);

CREATE TABLE AUTOMOVIL
(
  PATENTE char(6) NOT NULL,
  ANIO DOM_NRO,
  CONSTRAINT PK_AUTOMOVIL PRIMARY KEY (PATENTE)
);

CREATE TABLE COBERTURA
(
  CODIGO DOM_NRO NOT NULL,
  DESCRIPCION DOM_DESCRIPCION,
  CONSTRAINT PK_COBERTURA PRIMARY KEY (CODIGO)
);

CREATE TABLE POLIZA
(
  NRO_POL DOM_NRO NOT NULL,
  FECHA_DESDE date DEFAULT CURRENT_DATE NOT NULL,
  AL_DIA boolean DEFAULT FALSE NOT NULL,
  FECHA_HASTA date NOT NULL,
  DNI integer NOT NULL,
  PATENTE char(6) NOT NULL,
  CONSTRAINT PK_POLIZA PRIMARY KEY (NRO_POL),
  CONSTRAINT FK_POLIZA_CLIENTE FOREIGN KEY (DNI) REFERENCES CLIENTE(DNI),
  CONSTRAINT FK_POLIZA_AUTOMOVIL FOREIGN KEY (PATENTE) REFERENCES AUTOMOVIL(PATENTE)
);

CREATE TABLE ACCIDENTE
(
  NRO_ACC DOM_NRO NOT NULL,
  FECHA_OCURRENCIA date DEFAULT CURRENT_DATE NOT NULL,
  LUGAR DOM_DESCRIPCION,
  FAVORABLE boolean DEFAULT FALSE NOT NULL,
  MONTO double precision DEFAULT 0 NOT NULL,
  NRO_POL DOM_NRO,
  DESCRIPCION DOM_DESCRIPCION,
  CONSTRAINT PK_ACCIDENTE PRIMARY KEY (NRO_ACC),
  CONSTRAINT FK_ACCIDENTE_POLIZA FOREIGN KEY (NRO_POL) REFERENCES POLIZA(NRO_POL)
);

CREATE TABLE PAGO
(
  NRO_PAGO DOM_NRO NOT NULL,
  FECHA_PAGO date,
  FECHA_VEN date NOT NULL,
  MONTO double precision DEFAULT 0 NOT NULL,
  NRO_POL DOM_NRO NOT NULL,
  CONSTRAINT PK_PAGO PRIMARY KEY (NRO_PAGO,NRO_POL),
  CONSTRAINT FK_PAGO_POLIZA FOREIGN KEY (NRO_POL) REFERENCES POLIZA(NRO_POL)
);

