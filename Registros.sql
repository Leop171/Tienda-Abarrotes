CREATE TABLE factura_encabezado_prueba(
fel VARCHAR(140) PRIMARY KEY,
fecha DATETIME DEFAULT GETDATE(),
fk_empleado_codigo VARCHAR(12),
total DECIMAL(10,2) NULL,
iva_total DECIMAL(10,2) NULL,
fk_empresa_nit VARCHAR(16) NULL,
fk_cliente_nit VARCHAR(16) NULL,
creacion DATETIME DEFAULT GETDATE(),
usuario VARCHAR(60) DEFAULT SUSER_SNAME(),
fecha_modifcacion DATETIME DEFAULT GETDATE(),
estado CHAR(1) DEFAULT 'a'
) 

GO

CREATE TABLE factura_detalle_prueba(
codigo INT IDENTITY(1, 1) PRIMARY KEY,
fecha DATETIME DEFAULT GETDATE(),
fk_producto_codigo VARCHAR(16) NULL,
precio_unitario DECIMAL(10,2) NULL,
cantidad INT NULL,
subtotal DECIMAL(10,2) NULL,
fk_factura_fel VARCHAR(140) NULL,
creacion DATETIME DEFAULT GETDATE(),
usuario VARCHAR(60) DEFAULT SUSER_SNAME(),
fecha_modifcacion DATETIME DEFAULT GETDATE(),
estado CHAR(1) DEFAULT 'a',
fila VARCHAR(60) 
) 

GO

-- CREAR LOS INSERTS PARA DETALLE
CREATE OR ALTER PROCEDURE spCrearIsnertsDetalle
AS
BEGIN
DECLARE @contador INT = 1
DECLARE @fecha_inicio VARCHAR(50) = '2023-08-01 00:00';
DECLARE @fecha_fin VARCHAR(50) = '2024-04-29 00:00';
DECLARE @fecha VARCHAR(80)
SET @fecha = DATEADD(DAY, CAST(RAND(CHECKSUM(NEWID())) * DATEDIFF(DAY, @fecha_inicio, @fecha_fin) AS INT), @fecha_inicio)
DECLARE @producto VARCHAR(40) = 'INV004'
DECLARE @precio_unitario DECIMAL(10,2) = '1.79'
DECLARE @cantidad INT = '10'
DECLARE @subtotal DECIMAL(10,2) = '17.90'
DECLARE @fk_fel VARCHAR(40) = '123465'
DECLARE @filas INT = 4
--DECLARE @fila_aleatoria
	WHILE(@contador < 500000)
	BEGIN

		INSERT INTO factura_detalle_prueba(fecha, fk_producto_codigo, precio_unitario, cantidad, subtotal, fk_factura_fel, fila)
		VALUES(@fecha, @producto, @precio_unitario, @cantidad, @subtotal, @fk_fel, @filas)
--		PRINT CONCAT('(''',@fecha,'''', ', ''',@producto,'''', ', ''', @precio_unitario,'''', ', ''', @cantidad, ''', ''', @subtotal, ''', ''', @fk_fel,''', ''', @filas, '''),')
		SET @contador = @contador + 1

		SELECT TOP 1 @producto = codigo FROM producto ORDER BY NEWID();
		SELECT @precio_unitario = precio_unitario FROM producto WHERE codigo = @producto
		SET @cantidad = CAST(RAND() * 10 + 1 AS INT)
		SET @subtotal = @cantidad *  @precio_unitario
		IF(@filas > 0)
			BEGIN
				SET @filas = @filas - 1 
				SET @fk_fel = @fk_fel
				SET @fecha = @fecha
			END
		ELSE
			BEGIN
				SET @fk_fel = @fk_fel + 1
				SET @filas = CAST(RAND() * 6 + 1 AS INT)
				SET @fecha = DATEADD(MINUTE, CAST(RAND(CHECKSUM(NEWID())) * DATEDIFF(MINUTE, @fecha_inicio, @fecha_fin) AS INT), @fecha_inicio)
			END
	END
END

GO
/*
EXECUTE spCrearIsnertsDetalle
*/

SELECT * FROM factura_detalle_prueba
-- RECORRER DETALLE PARA CREAR LOS REGISTROS DE ENCABEZADO
CREATE OR ALTER PROCEDURE spInsertsEncabezado
AS 
BEGIN
	DECLARE @fecha VARCHAR(70), @fel VARCHAR(70), @empleado VARCHAR(12), @codigo_producto VARCHAR(60), @precio_unitario DECIMAL(10, 2), 
		@cantidad DECIMAL(10, 2), @subtotal DECIMAL(10, 2), @total DECIMAL(10, 2) = 0, @iva_total DECIMAL(10, 2),
		@nit_empresa VARCHAR(60), @nit_cliente VARCHAR(60), @fila INT
	
	DECLARE curInsertarEncabezado CURSOR SCROLL 
	FOR SELECT fecha, fk_factura_fel, subtotal, fila FROM factura_detalle_prueba

	OPEN curInsertarEncabezado
	FETCH NEXT FROM curInsertarEncabezado INTO @fecha, @fel, @subtotal, @fila

	WHILE @@FETCH_STATUS = 0
	BEGIN	
		IF(@fila > 0)
		BEGIN
			SET @total = @total + @subtotal
			FETCH NEXT FROM curInsertarEncabezado INTO @fecha, @fel, @subtotal, @fila
		END
		ELSE
		BEGIN
			SELECT TOP 1 @nit_cliente = nit FROM cliente ORDER BY NEWID()
			SELECT TOP 1 @empleado = codigo FROM empleado ORDER BY NEWID()
			SET @nit_empresa = '123456789-0'
			SELECT @total = @total + @subtotal
			SELECT @iva_total = @total / 1.12
			
			INSERT INTO factura_encabezado_prueba(fel, fecha, fk_empleado_codigo, total, iva_total, fk_empresa_nit, fk_cliente_nit)
			VALUES(@fel, @fecha, @empleado, @total, @iva_total, @nit_empresa, @nit_cliente)
--			PRINT CONCAT(@fecha, ' ; ', @fel, ' ; ',@empleado, ' ; ',@total, ' ; ', @iva_total, ' ; ', @nit_empresa, ' ; ', @nit_cliente, ' ),')
			
			FETCH NEXT FROM curInsertarEncabezado INTO @fecha, @fel, @subtotal, @fila
			SET @total = 0
			SET @iva_total = 0

		END
	END

	CLOSE curInsertarEncabezado
	DEALLOCATE curInsertarEncabezado
END

/*
EXECUTE spInsertsEncabezado
*/
GO

--VISUALIZAR LOS DATOS EN ENCABEZADO POR FEL
CREATE OR ALTER VIEW vVerFacturaFelPrueba
AS
SELECT c.fel, c.fecha, c.fk_empresa_nit AS nit_emisor, c.fk_cliente_nit AS nit_receptor, cl.nombre AS nombre,
cl.apellido AS apellido, em.nombre_comercial AS empresa, c.total AS Total, c.iva_total AS 'Total sin iva'
FROM factura_encabezado c JOIN cliente cl ON cl.nit = c.fk_cliente_nit 
JOIN empresa em ON em.nit = c.fk_empresa_nit

GO

-- VISUALIZAR LOS DATOS EN DETALLE POR FEL
CREATE OR ALTER VIEW vVerDetalleFelPrueba
AS
SELECT fd.fk_factura_fel, fd.fk_producto_codigo, p.nombre, p.presentacion, p.especificaciones, fd.precio_unitario,
fd.cantidad, fd.subtotal FROM factura_detalle fd JOIN producto p ON fd.fk_producto_codigo = p.codigo

GO

-- PROCESO PARA VER EL DETALLE Y EL ENCABEZADO POR EL MISMO FEL
CREATE OR ALTER PROCEDURE spVerFacturaCompleta (@fel VARCHAR(140))
AS
BEGIN
	BEGIN
		SELECT * FROM vVerFacturaFelPrueba WHERE fel = @fel
	END
	BEGIN
		SELECT * FROM vVerDetalleFelPrueba WHERE fk_factura_fel = @fel
	END
END

GO
/*
EXECUTE spVerFacturaCompleta '124384'
*/
-- PASAR DE DETALLE_PRUEBA A DETALLE DE VERDAD
CREATE OR ALTER PROCEDURE spPasarEncabezado
AS
BEGIN
	DECLARE @fel VARCHAR(70), @fecha VARCHAR(100), @total DECIMAL(10, 2), @iva_total DECIMAL(10, 2), @fk_empresa_nit VARCHAR(100),
	@fk_cliente_nit VARCHAR(60)

	
	DECLARE curPasarEncabezado CURSOR SCROLL 
	FOR SELECT fel, fecha, total, iva_total, fk_empresa_nit, fk_cliente_nit FROM factura_encabezado_prueba

	OPEN curPasarEncabezado
	FETCH NEXT FROM curPasarEncabezado INTO @fel, @fecha, @total, @iva_total, @fk_empresa_nit, @fk_cliente_nit

	WHILE @@FETCH_STATUS = 0
	BEGIN	

		--INSERT INTO factura_encabezado(fel, fecha, total, iva_total, fk_empresa_nit, fk_cliente_nit)
		--VALUES(@fel, @fecha, @total, @iva_total, @fk_empresa_nit, @fk_cliente_nit)
		

		FETCH NEXT FROM curPasarEncabezado INTO @fel, @fecha, @total, @iva_total, @fk_empresa_nit, @fk_cliente_nit

	END

	CLOSE curPasarEncabezado
	DEALLOCATE curPasarEncabezado
END
GO
/*
EXECUTE spPasarEncabezado
*/

-- PASAR DE ENCABEZADO_PRUEBA A ENCABEZADO DE VERDAD
CREATE OR ALTER PROCEDURE spPasarDetalle
AS
BEGIN
	DECLARE @fel VARCHAR(70), @fecha VARCHAR(100), @fk_producto_codigo VARCHAR(60), @precio_unitario DECIMAL(10, 2), @cantidad INT,
	@subtotal DECIMAL(10, 2), @fk_factura_fel VARCHAR(60)
	
	DECLARE curPasarDetalle CURSOR SCROLL 
	FOR SELECT fecha, fk_producto_codigo, precio_unitario, cantidad, subtotal, fk_factura_fel FROM factura_detalle_prueba

	OPEN curPasarDetalle
	FETCH NEXT FROM curPasarDetalle INTO @fecha, @fk_producto_codigo, @precio_unitario, @cantidad, @subtotal, @fk_factura_fel

	WHILE @@FETCH_STATUS = 0
	BEGIN	


--		INSERT INTO factura_detalle(fecha, fk_producto_codigo, precio_unitario, cantidad, subtotal, fk_factura_fel)
--		VALUES(@fecha, @fk_producto_codigo, @precio_unitario, @cantidad, @subtotal, @fk_factura_fel)	

		FETCH NEXT FROM curPasarDetalle INTO @fecha, @fk_producto_codigo, @precio_unitario, @cantidad, @subtotal, @fk_factura_fel

	END

	CLOSE curPasarDetalle
	DEALLOCATE curPasarDetalle
END
/*
EXECUTE spPasarDetalle
*/


