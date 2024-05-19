-- La modificación de la tabla está al último, todo lo primero es para crearla y ponerle datos
-- Entonces los alter table son la resolución del ejercicio 4.

CREATE DATABASE IF NOT EXISTS ejercicio4;

USE ejercicio4;

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
;

INSERT INTO articulos
 (nro_articulo)
  VALUES
   (3),
   (4)
;

UPDATE articulos
 SET
  descripcion = 'articulo 3',
  precio = 300,
  cantidad = 30,
  stock_min = 3,
  stock_max = 300,
  mes_ult_mov = 3,
  fecha_vto = '2030-03-30'
 WHERE
  nro_articulo = 3;

UPDATE articulos
 SET
  descripcion = 'articulo 4',
  precio = 400,
  cantidad = 40,
  stock_min = 4,
  stock_max = 400,
  mes_ult_mov = 4,
  fecha_vto = '2040-04-04'
 WHERE 
  nro_articulo = 4;

SELECT * FROM articulos;

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

-- Resolución ejercicio 4

-- Modificar la tabla vacunados de manera tal que al borrar un cod_vacuna
-- se va a borrar la información en otras tablas que hayan estado en relación
-- con ese código que se borró
ALTER TABLE vacunados 
ADD CONSTRAINT deleteCascade
FOREIGN KEY (cod_vacuna)
REFERENCES vacunas (cod_vacuna)
ON DELETE CASCADE;

-- Para borrar un constraint existente:
-- ALTER TABLE vacunados DROP CONSTRAINT deleteCascade;

-- Modificar la tabla vacunados de manera tal que agregamos el constraint
-- sobre la foreign key dni que referencia a personas.dni para que cuando
-- se quiera borrar una persona vacunada, no lo permita hacer, es decir
-- si hay un dni vacunado (en la tabla vacunados) y se lo quiere borrar,
-- no se permite hacer
ALTER TABLE vacunados
ADD CONSTRAINT notDeletingVacinatedPersons
FOREIGN KEY (dni)
REFERENCES personas (dni)
ON DELETE RESTRICT;

/*
-> Ejemplos de borrar Constraints:

Borrar una restricción de clave foránea (Foreign Key)
	ALTER TABLE nombre_tabla DROP FOREIGN KEY nombre_constraint;
Ejemplo:
	ALTER TABLE vacunados DROP FOREIGN KEY fk_vacunas;

Borrar una restricción de verificación (Check Constraint)
	usar triggers

Borrar una restricción de clave primaria
	ALTER TABLE nombre_tabla DROP PRIMARY KEY;
Ejemplo:
	ALTER TABLE personas DROP PRIMARY KEY;
Hay que tener ojo con borrar claves primarias porque puede que una tabla quede sin clave primaria, lo que está mal
Asi que luego de borrar debería agregarse una nueva, salvo que se sepa lo que se está haciendo realmente
*/
