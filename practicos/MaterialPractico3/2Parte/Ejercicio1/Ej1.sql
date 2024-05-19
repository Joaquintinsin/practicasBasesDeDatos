CREATE SCHEMA IF NOT EXISTS ejercicio1;

-- Inciso a)
CREATE TABLE IF NOT EXISTS ejercicio1.articulo  (
 NUM_PRODUCTO  int NOT NULL,
 DESCRIPCION  varchar(40) default NULL,
 PRECIO  decimal(9,2) default NULL,
 CANTIDAD int NOT NULL,
 STOCK_MIN int NOT NULL,
 STOCK_MAX int NOT NULL,
 MES_ULT_MOV int NOT NULL,
 FECHA_VTO date NOT NULL,
  PRIMARY KEY  ( NUM_PRODUCTO ),
  CONSTRAINT stock CHECK (STOCK_MIN <= STOCK_MAX),
  CONSTRAINT precio CHECK (PRECIO > 0 AND PRECIO < 99999)
);
-- Fin inciso a

-- Inciso b
CREATE TABLE IF NOT EXISTS ejercicio1.municipios (
 MUNICIPIO varchar(45) NOT NULL,
 PROVINCIA varchar(45) DEFAULT NULL,
  PRIMARY KEY ( MUNICIPIO )
);

CREATE TABLE IF NOT EXISTS ejercicio1.personas (
 DNI int NOT NULL,
 NOMBRE varchar(45) default NULL,
 EDAD int default 0,
 MUNICIPIO varchar(45) NOT NULL,
  PRIMARY KEY  ( DNI ),
  CONSTRAINT foreing_key FOREIGN KEY ( MUNICIPIO ) REFERENCES ejercicio1.municipios ( MUNICIPIO ),
  CONSTRAINT nat_number CHECK ( DNI > 0 AND EDAD > 0 AND EDAD < 21)
);

CREATE TABLE IF NOT EXISTS ejercicio1.contagios (
 DNI int NOT NULL,
 CEPA int NOT NULL,
  PRIMARY KEY  ( CEPA ),
  CONSTRAINT foreing_key FOREIGN KEY ( DNI ) REFERENCES ejercicio1.personas ( DNI ),
  CONSTRAINT nat_number CHECK ( DNI > 0 )
);

DROP DOMAIN IF EXISTS TiposVacuna CASCADE;
CREATE DOMAIN TiposVacuna AS varchar(45) CHECK ( 
 VALUE IN (
  'COVID19',
  'FIEBRE AMARILLA',
  'DENGUE',
  'BCG'
 )
);

CREATE TABLE IF NOT EXISTS ejercicio1.vacunas (
 COD_VACUNA int NOT NULL,
 NOMBRE TiposVacuna DEFAULT NULL,
  PRIMARY KEY ( COD_VACUNA )
);

CREATE TABLE IF NOT EXISTS ejercicio1.vacunados (
 DNI int NOT NULL,
 COD_VACUNA int NOT NULL,
  CONSTRAINT foreing_key_dni FOREIGN KEY ( DNI ) REFERENCES ejercicio1.personas ( DNI ),
  CONSTRAINT foreing_key_cod FOREIGN KEY ( COD_VACUNA ) REFERENCES ejercicio1.vacunas ( COD_VACUNA ),
  CONSTRAINT nat_number CHECK ( DNI > 0 )
);
-- Fin inciso b

SELECT * FROM ejercicio1.articulo;
SELECT * FROM ejercicio1.contagios;
SELECT * FROM ejercicio1.municipios;
SELECT * FROM ejercicio1.personas;
SELECT * FROM ejercicio1.vacunados;
SELECT * FROM ejercicio1.vacunas;
