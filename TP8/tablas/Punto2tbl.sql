CREATE TABLE REVISTA (
    ID_REV DOM_NRO,
    NOMBRE DOM_DESCRIPCION,
    CONSTRAINT PK_REVISTA PRIMARY KEY (ID_REV)
);

CREATE TABLE ANIO (
    ANIO DOM_NRO,
    ID_REV DOM_DESCRIPCION,
    CONSTRAINT PK_ANIO PRIMARY KEY (ANIO, ID_REV),
    CONSTRAINT FK_ANIO_REVISTA FOREIGN KEY (ID_REV) REFERENCES REVISTA(ID_REV)
);

CREATE TABLE EJEMPLAR (
    NUMERO DOM_NRO,
    PESO DOUBLE PRECISION DEFAULT 0 NOT NULL,
    CANTIDAD DOM_NRO,
    PAGINAS DOM_NRO,
    VALOR DOUBLE PRECISION DEFAULT 0 NOT NULL,
    ANIO DOM_NRO,
    ID_REV DOM_NRO,
    CONSTRAINT PK_EJEMPLAR PRIMARY KEY (NUMERO, ANIO, ID_REV),
    CONSTRAINT FK_EJEMPLAR_ANIO FOREIGN KEY (ANIO, ID_REV) REFERENCES ANIO(ANIO, ID_REV)
);

CREATE TABLE MATERIA (
    NOMBRE_MAT DOM_DESCRIPCION,
    CONSTRAINT PK_MATERIA PRIMARY KEY (NOMBRE_MAT)
);

CREATE TABLE ARTICULO (
    PAGINA_INICIO DOM_NRO,
    PAGINA_FIN DOM_NRO,
    NUMERO DOM_NRO,
    ANIO DOM_NRO,
    ID_REV DOM_NRO,
    NOMBRE_MAT DOM_DESCRIPCION,
    CONSTRAINT PK_ARTICULO PRIMARY KEY (PAGINA_INICIO, NUMERO, ANIO, ID_REV),
    CONSTRAINT FK_ARTICULO_NUMERO FOREIGN KEY (NUMERO, ANIO, ID_REV) REFERENCES EJEMPLAR(NUMERO, ANIO, ID_REV),
    CONSTRAINT FK_ARITCULO_MATERIA FOREIGN KEY (NOMBRE_MAT) REFERENCES MATERIA(NOMBRE_MAT)
);