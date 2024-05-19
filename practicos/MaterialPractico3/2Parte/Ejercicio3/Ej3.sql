CREATE DATABASE IF NOT EXISTS ejercicio3;

USE ejercicio3;

-- Inicio inciso b)
CREATE TABLE IF NOT EXISTS articulos (
 nro_articulo INT NOT NULL,
 descripcion TEXT,
 precio DECIMAL,
 cantidad INT,
 stock_min INT,
 stock_max INT,
 mes_ult_mov INT,
 fecha_vto DATE,
  PRIMARY KEY ( nro_articulo ),
  CONSTRAINT defStock CHECK (stock_min <= stock_max),
  CONSTRAINT defPrecio CHECK (precio > 0 AND precio < 99999)
);

INSERT INTO articulos
 (nro_articulo, descripcion, precio, cantidad, stock_min, stock_max, mes_ult_mov, fecha_vto)
  VALUES
   (1, 'articulo 1', 100, 10, 1, 100, 1, '2010-10-10'),
   (2, 'articulo 2', 200, 20, 2, 200, 2, '2020-02-20')
   -- (3, 'articulo 3', 300, 30, 3, 300, 3, '2030-03-30')
;

INSERT INTO articulos
 (nro_articulo)
  VALUES
   (3),
   (4)
;

UPDATE articulos
 SET
  descripcion = 'articulo 3'
 WHERE
  nro_articulo = 3;

UPDATE articulos
 SET
  descripcion = 'articulo 4'
 WHERE 
  nro_articulo = 4;

UPDATE articulos
 SET
  nro_articulo = 3
 WHERE
  nro_articulo = 30;

SELECT * FROM articulos;
-- Fin inciso b)

-- Inicio inciso a)
CREATE TABLE IF NOT EXISTS municipios (
 municipio VARCHAR(100) NOT NULL PRIMARY KEY,
 provincia TEXT
);

CREATE TABLE IF NOT EXISTS vacunas (
 cod_vacuna INT NOT NULL PRIMARY KEY,
 nombre ENUM('COVID19', 'FIEBRE AMARILLA', 'DENGUE', 'BCG')
);

CREATE TABLE IF NOT EXISTS personas (
 dni INT NOT NULL PRIMARY KEY,
 nombre TEXT,
 edad INT,
 municipio VARCHAR(100),
  CONSTRAINT fk_personas_municipios FOREIGN KEY (municipio) REFERENCES municipios (municipio),
  CONSTRAINT defEdad CHECK (edad >= 0 AND edad <= 21)
);

CREATE TABLE IF NOT EXISTS contagios(
 dni INT NOT NULL PRIMARY KEY,
 cepa INT UNIQUE KEY,	
 -- también es primary key, pero ahora se pone unique key pq no puede haber 2 primary
  CONSTRAINT fk_contagios_personas FOREIGN KEY (dni) REFERENCES personas (dni)
);

CREATE TABLE IF NOT EXISTS vacunados (
 dni INT NOT NULL PRIMARY KEY,
 cod_vacuna INT NOT NULL UNIQUE KEY,
 -- también es primary key, pero ponemos unique pq no puede haber 2 primary
  CONSTRAINT fk_vacunados_personas FOREIGN KEY (dni) REFERENCES personas (dni),
  CONSTRAINT fk_vacunados_vacunas FOREIGN KEY (cod_vacuna) REFERENCES vacunas (cod_vacuna)
);

INSERT INTO municipios
 (municipio, provincia)
  VALUES
   ('Municipio 1', 'Provincia 1')
;

INSERT INTO vacunas
 (cod_vacuna, nombre)
  VALUES
   (1, 'COVID19')
;

INSERT INTO personas
 (dni, nombre, edad, municipio)
  VALUES
   (1, 'Nombre 1', 1, 'Municipio 1')
;

INSERT INTO contagios
 (dni, cepa)
  VALUES
   (1, 1)
;

INSERT INTO vacunados
 (dni, cod_vacuna)
  VALUES
   (1, 1)
;

SELECT * FROM municipios;
SELECT * FROM vacunas;
SELECT * FROM personas;
SELECT * FROM contagios;
SELECT * FROM vacunados;
-- Fin inciso a)
