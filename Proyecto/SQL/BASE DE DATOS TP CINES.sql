-- DROP DATABASE complejo_cines;

-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS complejo_cines;

-- Usar la base de datos
USE complejo_cines;

CREATE TABLE IF NOT EXISTS pelicula (
	id INT NOT NULL PRIMARY KEY CHECK (id > 0),
    genero ENUM('Acción', 'Aventura', 'Comedia', 'Drama', 'Ciencia ficción', 'Fantasía', 
				'Terror', 'Suspense', 'Romance', 'Animación', 'Crimen', 'Misterio', 'Documental',
                'Musical', 'Guerra', 'Biografía', 'Histórica', 'Western', 'Cine negro', 'Superhéroes',
                'Deportes', 'Familiar', 'Infantil', 'Experimental', 'Independiente', 'Road movie', 
                'Cine de arte', 'Cine del Oeste', 'Cine erótico', 'Cine político', 'Cine social', 
                'Cine de autor', 'Cine experimental', 'Cine de culto', 'Cine de animación para adultos'),
	idioma_original VARCHAR(255) NOT NULL,
    url TEXT,
    duracion TIME,
    calificacion DECIMAL(2,1), -- calificacion del 0.0 a 5.0
    fecha_estreno_Argentina DATE,
    resumen TEXT,
    titulo_distribucion VARCHAR(255) NOT NULL,
    titulo_original VARCHAR(255) NOT NULL,
    titulo_espaniol VARCHAR(255) NOT NULL
);

-- Tabla de cines
CREATE TABLE IF NOT EXISTS cine (
    nombre VARCHAR(255) NOT NULL PRIMARY KEY,
    direccion VARCHAR(255) NOT NULL,
    telefono INT NOT NULL CHECK (telefono > 0)
);

CREATE TABLE IF NOT EXISTS sala (
    id INT NOT NULL PRIMARY KEY CHECK (id > 0),
    cant_Butacas INT NOT NULL CHECK (cant_Butacas > 0),
    nombre_cine VARCHAR(255) NOT NULL,
    FOREIGN KEY (nombre_cine) REFERENCES cine(nombre)
);

CREATE TABLE IF NOT EXISTS funcion (
    codigo INT NOT NULL PRIMARY KEY CHECK (codigo > 0),
    fecha DATE,
    hora_comienzo TIME,
    id_sala INT, 
    FOREIGN KEY (id_sala) REFERENCES sala(id)
);

CREATE TABLE IF NOT EXISTS pais (
	nombre VARCHAR(255) NOT NULL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS persona (
	nombre VARCHAR(255) NOT NULL PRIMARY KEY,
    nacionalidad VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS director (
	nombre VARCHAR(255) NOT NULL PRIMARY KEY,
    reg_historico INT DEFAULT 0,
    FOREIGN KEY (nombre) REFERENCES persona(nombre)
);


CREATE TABLE IF NOT EXISTS actor (
	nombre VARCHAR(255) NOT NULL PRIMARY KEY,
    reg_historico INT DEFAULT 0,
    FOREIGN KEY (nombre) REFERENCES persona(nombre)
);

CREATE TABLE IF NOT EXISTS protagonista (
	nombre VARCHAR(255) NOT NULL PRIMARY KEY,
    FOREIGN KEY (nombre) REFERENCES actor(nombre)
);

CREATE TABLE IF NOT EXISTS reparto (
	nombre VARCHAR(255) NOT NULL PRIMARY KEY,
    FOREIGN KEY (nombre) REFERENCES actor(nombre)
);

CREATE TABLE IF NOT EXISTS origen_produccion (
	id INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    anio INT CHECK (anio >= 1895),
    PRIMARY KEY (id, nombre),
    FOREIGN KEY (id) REFERENCES pelicula(id),
    FOREIGN KEY (nombre) REFERENCES pais(nombre)
);

CREATE TABLE IF NOT EXISTS dirige (
	id INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    PRIMARY KEY (id, nombre),
    FOREIGN KEY (id) REFERENCES pelicula(id),
    FOREIGN KEY (nombre) REFERENCES director(nombre)
);

CREATE TABLE IF NOT EXISTS proyecta (
	id INT NOT NULL,
    codigo_funcion INT NOT NULL,
    PRIMARY KEY (id, codigo_funcion),
    FOREIGN KEY (id) REFERENCES pelicula(id),
    FOREIGN KEY (codigo_funcion) REFERENCES funcion(codigo)
);

CREATE TABLE IF NOT EXISTS es_reparto (
	id INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    PRIMARY KEY (id, nombre),
    FOREIGN KEY (id) REFERENCES pelicula(id),
    FOREIGN KEY (nombre) REFERENCES reparto(nombre)
);

CREATE TABLE IF NOT EXISTS es_protagonista (
	id INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    PRIMARY KEY (id, nombre),
    FOREIGN KEY (id) REFERENCES pelicula(id),
    FOREIGN KEY (nombre) REFERENCES protagonista(nombre)
);

-- Crear el trigger
DELIMITER //
CREATE TRIGGER after_dirigir
AFTER INSERT ON dirige
FOR EACH ROW
BEGIN
    -- Actualizar la participacion del director
    UPDATE director
    SET reg_historico = reg_historico + 1
    WHERE nombre = NEW.nombre;
END;
//
DELIMITER ;

-- Crear el trigger
DELIMITER //
CREATE TRIGGER after_protaginizar
AFTER INSERT ON es_protagonista
FOR EACH ROW
BEGIN
    -- Actualizar la participacion del actor
    UPDATE actor
    SET reg_historico = reg_historico + 1
    WHERE nombre = NEW.nombre;
END;
//
DELIMITER ;


-- Crear el trigger
DELIMITER //
CREATE TRIGGER after_extra
AFTER INSERT ON es_reparto
FOR EACH ROW
BEGIN
    -- Actualizar la participacion del actor
    UPDATE actor
    SET reg_historico = reg_historico + 1
    WHERE nombre = NEW.nombre;
END;
//
DELIMITER ;
