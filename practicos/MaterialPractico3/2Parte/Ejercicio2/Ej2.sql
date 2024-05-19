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

-- Inicio Ejercicio 2
INSERT INTO ejercicio1.articulo 
(NUM_PRODUCTO, DESCRIPCION, PRECIO,CANTIDAD, STOCK_MIN, STOCK_MAX, MES_ULT_MOV, FECHA_VTO)
 VALUES
  (1,'coquito', 2, 5, 10, 100, 5, '2025-04-24'),
  (2,'neq', 30, 3, 10, 300, 1, '2025-04-24'),
  (3,'fis', 21, 3, 10, 300, 2, '2025-04-24'),
  (4,'des', 18, 9, 10, 900, 12, '2025-04-24')
;

SELECT * FROM ejercicio1.articulo;

INSERT INTO ejercicio1.municipios 
 (MUNICIPIO, PROVINCIA)
  VALUES
   ('Muni','Prov'),
   ('Deek','Prov'),
   ('Cop','Prov'),
   ('Vus','Vorp'),
   ('Bus','Vorp'),
   ('Nus','Vorp')
;

INSERT INTO ejercicio1.personas
 (DNI, NOMBRE, EDAD, MUNICIPIO)
  VALUES
   (20418100,'Coo Bre', 2, 'Muni'),
   (10814200,'Neq Fis', 19, 'Muni'),
   (81420001,'Des Fis', 20, 'Muni'),
   (41812010,'Gre Jin', 5, 'Muni')
;

SELECT * FROM ejercicio1.contagios;
SELECT * FROM ejercicio1.municipios;
SELECT * FROM ejercicio1.personas;
SELECT * FROM ejercicio1.vacunados;
SELECT * FROM ejercicio1.vacunas;
