
--PRÀCTICA
CREATE OR REPLACE FUNCTION getRegistros() 
RETURNS TABLE (
				id_registro INTEGER,
				fecha_hora TIMESTAMP,
				cantidad INTEGER,
				monto NUMERIC,
				empleado VARCHAR,
				producto VARCHAR
			  )
AS $$
BEGIN
	RETURN QUERY
	SELECT R.id_registro,R.fecha_hora,R.cantidad,R.monto,E.nombre AS empleado,P.nombre AS producto 
	FROM REGISTRO R
	JOIN EMPLEADO E ON EMPLEADO_id_empleado=id_empleado 
	JOIN PRODUCTO P ON PRODUCTO_id_producto=id_producto;

END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION getHistorial()
RETURNS TABLE (
				id_historial INTEGER,
				fecha_hora TIMESTAMP,
				cantidad INTEGER,
				aumento_disminucion BOOLEAN,
				producto VARCHAR
			  )
AS 
$$
	BEGIN
		RETURN QUERY
			SELECT H.id_historial,H.fecha_hora,H.cantidad,H.aumento_disminucion,P.nombre AS producto
			FROM HISTORIAL H
			JOIN PRODUCTO P ON PRODUCTO_id_producto=id_producto;
	END;
$$
LANGUAGE plpgsql;

--HISTORIAL
CREATE OR REPLACE FUNCTION cambiosStock()
RETURNS TRIGGER
AS 
$$
	DECLARE
		diferencia INTEGER;
	BEGIN
		diferencia:= NEW.stock - OLD.stock;
				
		IF diferencia > 0 THEN
			INSERT INTO HISTORIAL( fecha_hora, cantidad, aumento_disminucion, producto_id_producto)
			VALUES(CURRENT_TIMESTAMP,diferencia,TRUE,NEW.id_producto);
		ELSE
			INSERT INTO HISTORIAL( fecha_hora, cantidad, aumento_disminucion, producto_id_producto )
			VALUES(CURRENT_TIMESTAMP,ABS(diferencia),FALSE,OLD.id_producto);
		END IF;
		
		RETURN NEW;
END;$$
LANGUAGE plpgsql;

CREATE TRIGGER actualizacionStock
AFTER UPDATE
ON PRODUCTO
FOR EACH ROW
EXECUTE PROCEDURE cambiosStock();


--INVENTARIAR
CREATE OR REPLACE FUNCTION verificarInventario()
RETURNS TRIGGER
AS
$$
	DECLARE
		stock INTEGER;
		diferencia INTEGER;
	BEGIN
		stock:=(SELECT P.stock FROM PRODUCTO P WHERE NEW.PRODUCTO_id_producto=P.id_producto);
		
		diferencia:=stock-NEW.cantidad;
		
		IF diferencia >= 0 THEN
			UPDATE PRODUCTO SET stock=diferencia WHERE id_producto=NEW.PRODUCTO_id_producto;
		ELSE
			NEW.id_producto:=-1;
		END IF;
				RETURN NEW;

	END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER gestionarStock
BEFORE INSERT 
ON REGISTRO
FOR EACH ROW
EXECUTE PROCEDURE verificarInventario();

