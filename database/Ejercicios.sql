
CREATE TABLE LIBRO
(
	cod_libro SERIAL,
	nombre VARCHAR(30),
	descripcion VARCHAR(30)
);


CREATE TABLE INSERT_LIBRO
(
	cod_libro SERIAL,
	nombre VARCHAR(30) NOT NULL,
	fecha_hora TIMESTAMP NOT NULL
);


-- USANDO LENGUAJE SQL

-- 1)

CREATE OR REPLACE FUNCTION sumar(
	INTEGER,
	INTEGER
)
RETURNS INTEGER
AS
'SELECT $1+$2;'
LANGUAGE SQL;

-- 2)
CREATE OR REPLACE PROCEDURE cargarLibros()
AS
$$
	INSERT INTO LIBRO(nombre,descripcion) VALUES('libro2','descripcion2');
	INSERT INTO LIBRO(nombre,descripcion) VALUES('libro3','descripcion3');
	INSERT INTO LIBRO(nombre,descripcion) VALUES('libro4','descripcion4');
	INSERT INTO LIBRO(nombre,descripcion) VALUES('libro5','descripcion5');
	INSERT INTO LIBRO(nombre,descripcion) VALUES('libro6','descripcion6');
$$
LANGUAGE SQL;


--3)

CREATE OR REPLACE FUNCTION getLibrosSQL()
RETURNS TABLE 
AS
'SELECT * FROM LIBROS;'
LANGUAGE SQL;


-- USANDO LENGUAJE PL/PGSQL


--1)

CREATE OR REPLACE FUNCTION resta(val1 INTEGER, val2 INTEGER)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN val1-val2;
END;
$$

--Ej2)
CREATE OR REPLACE FUNCTION obtenerLibrosPLPGSQL()
RETURNS TABLE (
	cod_libro INTEGER,
	nombre VARCHAR(30),
	descripcion VARCHAR(30)
)
AS
$$
BEGIN
	RETURN QUERY
		SELECT * FROM LIBRO;
END;
$$
LANGUAGE PLPGSQL;


--3)

CREATE OR REPLACE FUNCTION miFactorial(
	p_num INTEGER
)
RETURNS INTEGER
AS
$$
DECLARE
	p_result INTEGER:= 1;
BEGIN
	IF p_num = 0 THEN
		RETURN p_result;
	ELSE
	 	RETURN p_num * factorial(p_num-1);
	END IF;
END;
$$


--4)
CREATE OR REPLACE FUNCTION obtenerLibrosFormat()
RETURNS TEXT
AS
$$
DECLARE
	cur_libros CURSOR FOR SELECT * FROM LIBRO;
	rec_libro RECORD;
	resultado TEXT DEFAULT '';
BEGIN
	OPEN cur_libros;
	LOOP 
	FETCH cur_libros INTO rec_libro;
	EXIT WHEN NOT FOUND;
		resultado := resultado || '{ cod: ' || rec_libro.cod_libro || ', name: ' || rec_libro.nombre || '},';
	END LOOP;
	CLOSE cur_libros;
	
	RETURN RTRIM(resultado,',');
	
END;
$$
LANGUAGE PLPGSQL;



-- TRIGGERS

-- FUNCION ASOCIADA
CREATE OR REPLACE FUNCTION registrarInsersionLibro()
RETURNS TRIGGER
AS
$$	
BEGIN
	INSERT INTO INSERT_LIBRO(fecha_hora,nombre) VALUES(CURRENT_TIMESTAMP,NEW.nombre);
	RETURN NEW;
END;
$$
LANGUAGE PLPGSQL;

-- TRIGGER

CREATE TRIGGER auditarLibros
AFTER INSERT
ON LIBRO
FOR EACH ROW
EXECUTE PROCEDURE registrarInsersionLibro();



