CREATE TABLE PROVINCIA
(
  NOMBREPROV DOM_DESCRIPCION NOT NULL,
  CONSTRAINT PK_PROVINCIA PRIMARY KEY (NOMBREPROV)
);

CREATE TABLE VINO
(
  NOMBREVINO DOM_DESCRIPCION NOT NULL,
  CONSTRAINT PK_VINO PRIMARY KEY (NOMBREVINO)
);

CREATE TABLE TIPOUVA
(
  NOMBREUVA DOM_DESCRIPCION NOT NULL,
  CONSTRAINT PK_UVA PRIMARY KEY (NOMBREUVA)
);

CREATE TABLE SIVINO
(
  NOMBREUVA DOM_DESCRIPCION NOT NULL,
  CONSTRAINT PK_SIVINO PRIMARY KEY (NOMBREUVA),
  CONSTRAINT FK_SIVINO_VINO FOREIGN KEY (NOMBREUVA) REFERENCES TIPOUVA(NOMBREUVA)
);

CREATE TABLE NOVINO
(
  NOMBREUVA DOM_DESCRIPCION NOT NULL,
  CONSTRAINT PK_NOVINO PRIMARY KEY (NOMBREUVA),
  CONSTRAINT FK_NOVINO_VINO FOREIGN KEY (NOMBREUVA) REFERENCES TIPOUVA(NOMBREUVA)
);

CREATE TABLE FINCA
(
  NOMBREFINCA DOM_DESCRIPCION NOT NULL,
  NOMBREPROV DOM_DESCRIPCION,
  DIRECCION DOM_DESCRIPCION,
  CONSTRAINT PK_FINCA PRIMARY KEY (NOMBREFINCA),
  CONSTRAINT FK_FINCA_PROVINCIA FOREIGN KEY (NOMBREPROV) REFERENCES PROVINCIA(NOMBREPROV)
);

CREATE TABLE COMPUESTO
(
  NOMBREUVA DOM_DESCRIPCION NOT NULL,
  NOMBREVINO DOM_DESCRIPCION NOT NULL,
  PORCENTAJE integer DEFAULT 0 NOT NULL,
  CONSTRAINT PK_COMPUESTO PRIMARY KEY (NOMBREUVA,NOMBREVINO)
  CONSTRAINT FK_COMPUESTO_NOMBREUVA FOREIGN KEY (NOMBREUVA) REFERENCES TIPOUVA(NOMBREUVA),
  CONSTRAINT FK_COMPUESTO_NOMBREVINO FOREIGN KEY (NOMBREVINO) REFERENCES SIVINO(NOMBREVINO)
);

CREATE TABLE HACE
(
  NOMBREFINCA DOM_DESCRIPCION NOT NULL,
  NOMBREUVA DOM_DESCRIPCION NOT NULL,
  CALIDAD integer DEFAULT 1 NOT NULL,
  CONSTRAINT PK_HACE PRIMARY KEY (NOMBREFINCA,NOMBREUVA),
  CONSTRAINT FK_HACE_NOMBREFINCA FOREIGN KEY (NOMBREFINCA) REFERENCES FINCA(NOMBREFINCA),
  CONSTRAINT FK_HACE_NOMBREUVA FOREIGN KEY (NOMBREUVA) REFERENCES TIPOUVA(NOMBREUVA)
);