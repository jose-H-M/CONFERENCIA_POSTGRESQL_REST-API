CREATE TABLE EMPLEADO (
    id_empleado  SERIAL,
    nombre       VARCHAR(30) NOT NULL,
    salario      NUMERIC(10, 2) NOT NULL
);

ALTER TABLE EMPLEADO ADD CONSTRAINT EMPLEADO_pk PRIMARY KEY ( id_empleado );

CREATE TABLE HISTORIAL (
    id_historial          SERIAL,
    fecha_hora            TIMESTAMP NOT NULL,
    cantidad              INTEGER NOT NULL,
    aumento_disminucion   BOOLEAN NOT NULL,
    producto_id_producto  INTEGER NOT NULL
);

ALTER TABLE HISTORIAL ADD CONSTRAINT HISTORIAL_pk PRIMARY KEY ( id_historial );

CREATE TABLE producto (
    id_producto  SERIAL,
    nombre       VARCHAR(30) NOT NULL,
    descripcion  VARCHAR(100) NOT NULL,
    stock        INTEGER NOT NULL,
    precio       NUMERIC(5, 2) NOT NULL
);

ALTER TABLE PRODUCTO ADD CONSTRAINT PRODUCTO_pk PRIMARY KEY ( id_producto );

ALTER TABLE PRODUCTO ADD CONSTRAINT PRODUCTO_nombre_un UNIQUE ( nombre );

CREATE TABLE REGISTRO (
    id_registro           SERIAL,
    cantidad              INTEGER NOT NULL,
    monto                 NUMERIC(5,2) NOT NULL,
    fecha_hora            TIMESTAMP NOT NULL,
    PRODUCTO_id_producto  INTEGER NOT NULL,
    EMPLEADO_id_empleado  INTEGER NOT NULL
);

ALTER TABLE REGISTRO ADD CONSTRAINT REGISTRO_pk PRIMARY KEY ( id_registro );

ALTER TABLE HISTORIAL
    ADD CONSTRAINT HISTORIAL_PRODUCTO_fk FOREIGN KEY ( PRODUCTO_id_producto )
        REFERENCES PRODUCTO ( id_producto ) ON DELETE CASCADE;

ALTER TABLE REGISTRO
    ADD CONSTRAINT REGISTRO_EMPLEADO_fk FOREIGN KEY ( EMPLEADO_id_empleado )
        REFERENCES EMPLEADO ( id_empleado ) ON DELETE CASCADE;

ALTER TABLE REGISTRO
    ADD CONSTRAINT REGISTRO_PRODUCTO_fk FOREIGN KEY ( PRODUCTO_id_producto )
        REFERENCES PRODUCTO ( id_producto ) ON DELETE CASCADE;



--Insertar empleados
INSERT INTO EMPLEADO(nombre,salario) VALUES('EMPLEADO 1',1000.50);
INSERT INTO EMPLEADO(nombre,salario) VALUES('EMPLEADO 2',1500.75);
INSERT INTO EMPLEADO(nombre,salario) VALUES('EMPLEADO 3',2500);
INSERT INTO EMPLEADO(nombre,salario) VALUES('EMPLEADO 4',3000);
INSERT INTO EMPLEADO(nombre,salario) VALUES('EMPLEADO 5',4000);
INSERT INTO EMPLEADO(nombre,salario) VALUES('EMPLEADO 6',2000);
INSERT INTO EMPLEADO(nombre,salario) VALUES('EMPLEADO 7',2000);


--Insertar productos
INSERT INTO PRODUCTO(nombre,descripcion,stock,precio) VALUES('Cloro magia blanca','Cloro, presentación de 200ml',5.25,10);
INSERT INTO PRODUCTO(nombre,descripcion,stock,precio) VALUES('Azistin manzana verde','Desinfectante presentación de un galón',62,5);
INSERT INTO PRODUCTO(nombre,descripcion,stock,precio) VALUES('Papel higienico','Unidad de papel higiendico',5,20);
INSERT INTO PRODUCTO(nombre,descripcion,stock,precio) VALUES('Mascarilla N95','Mascarilla desechable',19.5,15);
INSERT INTO PRODUCTO(nombre,descripcion,stock,precio) VALUES('Antibacterial Blumen Fresh','Alcohol en gel',24.99,3);
INSERT INTO PRODUCTO(nombre,descripcion,stock,precio) VALUES('Servilletas SULI BLANCA','Paquete de servilletas 500 unidades',3.5,9);
INSERT INTO PRODUCTO(nombre,descripcion,stock,precio) VALUES('Jugo de la granja','Jugo de naranja con pulpa',4,15);
INSERT INTO PRODUCTO(nombre,descripcion,stock,precio) VALUES('Café de jarrillita instantaneo','Sobre de cafe instantanio 8GR',2,17);
INSERT INTO PRODUCTO(nombre,descripcion,stock,precio) VALUES('Aua GREAT VALUE','Botella de agua purificada 1LT',3,15);
INSERT INTO PRODUCTO(nombre,descripcion,stock,precio) VALUES('Sopa Ramen.',' LAKY MEN CUP Pollo. 75 Gramos',5,10);

--Insertar registros
INSERT INTO REGISTRO(cantidad,monto,fecha_hora,PRODUCTO_id_producto,EMPLEADO_id_empleado) VALUES(2,100,NOW(),1,1);
INSERT INTO REGISTRO(cantidad,monto,fecha_hora,PRODUCTO_id_producto,EMPLEADO_id_empleado) VALUES(2,100,CURRENT_TIMESTAMP,2,2);
