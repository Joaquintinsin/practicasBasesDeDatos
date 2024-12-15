CREATE DATABASE IF NOT EXISTS ejercicio5;

USE ejercicio5;

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

CREATE TABLE IF NOT EXISTS contagios (
 dni INT NOT NULL,
 cepa INT,	
  PRIMARY KEY (dni, cepa),
  CONSTRAINT fk_contagios_personas FOREIGN KEY (dni) REFERENCES personas (dni)
);

CREATE TABLE IF NOT EXISTS vacunados (
 dni INT NOT NULL,
 cod_vacuna INT NOT NULL,
  PRIMARY KEY (dni, cod_vacuna),
  CONSTRAINT fk_vacunados_personas FOREIGN KEY (dni) REFERENCES personas (dni),
  CONSTRAINT fk_vacunados_vacunas FOREIGN KEY (cod_vacuna) REFERENCES vacunas (cod_vacuna)
);

-- INSERT INTO municipios
--  (municipio, provincia)
--   VALUES
--    ('Municipio 1', 'Provincia 1')
-- ;

-- INSERT INTO vacunas
--  (cod_vacuna, nombre)
--   VALUES
--    (1, 'COVID19')
-- ;

-- INSERT INTO personas
--  (dni, nombre, edad, municipio)
--   VALUES
--    (1, 'Nombre 1', 1, 'Municipio 1')
-- ;

-- INSERT INTO contagios
--  (dni, cepa)
--   VALUES
--    (1, 1)
-- ;

-- INSERT INTO vacunados
--  (dni, cod_vacuna)
--   VALUES
--    (1, 1)
-- ;

SELECT * FROM municipios;
SELECT * FROM vacunas;
SELECT * FROM personas;
SELECT * FROM contagios;
SELECT * FROM vacunados;

-- Inciso a) La cantidad de dosis de vacunas colocadas por cada vacuna existente
SELECT COUNT(*) FROM vacunados;

-- Inciso b) La persona que tiene el maximo numero de vacunas colocadas
SELECT personas.dni, personas.nombre, COUNT(vacunados.dni) AS num_vacunas
FROM personas LEFT JOIN vacunados ON personas.dni = vacunados.dni
GROUP BY personas.dni, personas.nombre
ORDER BY num_vacunas DESC
LIMIT 1;


select personas.dni, personas.nombre, COUNT(vacunados.dni) AS num_vacunas
FROM (select max(*) from num_vacunas)
