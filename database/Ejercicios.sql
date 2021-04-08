
CREATE TABLE LIBRO
(
	cod_libro SERIAL,
	nombre VARCHAR(30),
	descripcion VARCHAR(30)
);

INSERT INTO LIBRO(nombre,descripcion) VALUES('libro1','descripcion1');
INSERT INTO LIBRO(nombre,descripcion) VALUES('libro2','descripcion2');
INSERT INTO LIBRO(nombre,descripcion) VALUES('libro3','descripcion3');
INSERT INTO LIBRO(nombre,descripcion) VALUES('libro4','descripcion4');
INSERT INTO LIBRO(nombre,descripcion) VALUES('libro5','descripcion5');
INSERT INTO LIBRO(nombre,descripcion) VALUES('libro6','descripcion6');

--Ejercicio1
CREATE OR REPLACE FUNCTION resta(val1 INTEGER, val2 INTEGER)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN val1+val2;
END;
$$

--Ejercicio2

CREATE OR REPLACE FUNCTION myFactorial(num INTEGER)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
	DECLARE
		resultado INTEGER := 1;
	BEGIN
	
		IF num = 0 THEN
			RETURN resultado;
		ELSE
			RETURN num*factorial(num-1);
		END IF;
	END;
$$

--Ejercicio 3
CREATE OR REPLACE FUNCTION getLibrosFormat()
RETURNS TEXT
LANGUAGE plpgsql
AS $$
	DECLARE
		libros TEXT default '';
		cur_libros CURSOR FOR SELECT * FROM LIBRO;
		rec_libro RECORD;
	BEGIN
		OPEN cur_libros;
		
		LOOP
		FETCH cur_libros INTO rec_libro;
		EXIT WHEN NOT FOUND;
		libros:=libros||'nombre->'||rec_libro.nombre||', description->'||rec_libro.descripcion||'; ';
		
		END LOOP;
		
		CLOSE cur_libros;
		
		RETURN libros;
	END;
$$
