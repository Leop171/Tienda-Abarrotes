-- DEPUES DE CREAR EL DETALLE_TEMPORAL Y ENCABEZADO_TEMPORAL CONFIRMAMOS LA CREACION DE LA FACTURA
CREATE OR ALTER PROCEDURE spConfirmarFactura
AS
BEGIN
	IF (NOT EXISTS(SELECT * FROM sys.tables WHERE name = '##factura_encabezado')) 
		THROW 50061, 'El encabezado esta vacio o no existe', 1 -- Correcion
	ELSE IF(NOT EXISTS(SELECT * FROM sys.tables WHERE name = 'factura_detalle_temporal'))
		THROW 50062, 'El detalle esta vacio o no existe', 1 -- Correcion 2
	BEGIN TRANSACTION 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED

	-- DECLARAMOS LAS VARIABLES A UTILIZAR
		DECLARE @total DECIMAL(12,2)
		DECLARE @iva_total DECIMAL(12, 2)
		SELECT @total = SUM(subtotal) FROM ##factura_detalle_temporal
		SELECT @iva_total = @total / 112 * 100

	-- INSERTAMOS EN ENCABEZADO 
		INSERT INTO factura_encabezado(fel, total, iva_total, fk_empresa_nit, fk_cliente_nit)
		SELECT fel, @total, @iva_total, fk_empresa_nit, fk_cliente_nit FROM ##factura_encabezado_temporal

	 -- INSERTAMOS EN DETALLE
		INSERT INTO factura_detalle(fk_producto_codigo, precio_unitario, cantidad, subtotal, fk_factura_fel) 
		SELECT fk_inventario, precio_unitario, cantidad, subtotal, fk_factura_fel 
		FROM ##factura_detalle_temporal 
	
	-- ELIMINAMOS DETALLE_TEMPORAL
		DROP TABLE ##factura_detalle_temporal 

	-- ELIMINAMOS ENCABEZADO_TEMPORAL
		DROP TABLE ##factura_encabezado_temporal

	-- VOLVEMOS A CREAR DETALLE_TEMPORAL
		CREATE TABLE ##factura_detalle_temporal(
		codigo INT,
		fecha DATETIME DEFAULT GETDATE(),
		fk_inventario VARCHAR(16) NOT NULL,
		precio_unitario DECIMAL(10,2) NOT NULL,
		cantidad INT NOT NULL,
		subtotal DECIMAL(10,2) NOT NULL,
		fk_factura_fel VARCHAR(140) NOT NULL)
	
	-- VOLVEMOS A CREAR EL ENCABEZADO_TEMPORAL
		CREATE TABLE ##factura_encabezado_temporal(
		fel VARCHAR(300) PRIMARY KEY,
		fecha DATETIME DEFAULT GETDATE(),
		total DECIMAL(10,2) NOT NULL,
		iva_total DECIMAL(10,2) NOT NULL,
		fk_empresa_nit VARCHAR(16) NOT NULL,
		fk_cliente_nit VARCHAR(16) NOT NULL)
END

/*
EJEMPLO DE EJECUCION DEL PROCESO
EXECUTE spConfirmarFactura 
*/

-- ESTE ES EL CODIGO QUE ACTUALMENTE ESTA FUNCIONANDO 05/04/2024 12:05pm
-- INSERTAR DATOS EN DETALLE
CREATE OR ALTER PROCEDURE InsertarDetalleFactura3 (@fk_factura_fel VARCHAR(140), @codigo VARCHAR(20),
@fk_producto_codigo VARCHAR(16), @cantidad INT)
AS
BEGIN
	BEGIN TRY
	BEGIN -- VALIDAR DATOS DE ENTRADA
		IF (@fk_factura_fel IS NULL OR LTRIM(RTRIM(@fk_factura_fel)) = '')
			THROW 50031, 'El fel es nulo o está vacío', 1;

		ELSE IF (@codigo IS NULL OR LTRIM(RTRIM(@codigo)) = '')
			THROW 50032, 'El codigo es nulo o esta vacio', 1;

		ELSE IF (@fk_producto_codigo IS NULL OR LTRIM(RTRIM(@fk_producto_codigo)) = '')
			THROW 50033, 'El codigo de producto es null o esta vacio', 1;
			
		ELSE IF(@cantidad IS NULL OR @cantidad < 0)
			THROW 50034, 'La cantidad de producto es null o menor a 0', 1;
	END
	-- VARAIBALES A UTLIZAR AL INICIAR LA TRANSACCION
	DECLARE @subtotal DECIMAL(14, 4)
	DECLARE @existencia INT
	SELECT @existencia = cantidad FROM inventario WHERE @fk_producto_codigo = codigo

	-- VALIDAMOS QUE EL CODIGO DE PRODUCTO INGRESADO SEA UN PRODUCTO EXSITENTE
	IF EXISTS (SELECT codigo FROM inventario WHERE @fk_producto_codigo = codigo) 

		-- VALIDAMOS EXISTENCIA PARA EL PRODUCTO QUE SE SOLICITA
		IF EXISTS(SELECT cantidad FROM inventario WHERE @fk_producto_codigo = codigo AND cantidad > @cantidad )		

			BEGIN
				BEGIN TRANSACTION
				SET TRANSACTION ISOLATION LEVEL READ COMMITTED

				-- BUSCAMOS EL PRECIO UNITARIO DEL PRODUCTO INGRESADO 
				BEGIN
					DECLARE @precio_unitario DECIMAL(10,2) 
					SELECT @precio_unitario = precio_unitario FROM producto 
					WHERE fk_inventario = @fk_producto_codigo

				-- CALCULAMOS EL SUBTOTAL (CANTIDAD SOLICITADA * PRECIO UNITARIO DEL PROCUTO)
					SELECT @subtotal = @precio_unitario *  @cantidad WHERE @fk_producto_codigo = @fk_producto_codigo
				END

				-- ASIGNAMOS EL SUBTOTAL DEL REGISTRO Y CALCULAMOS IVA				
				DECLARE @total DECIMAL(12,2)
				DECLARE @iva_total DECIMAL(12, 2)
				DECLARE @codigo_fel VARCHAR(100)
				SELECT @total = SUM(subtotal) FROM ##factura_detalle_temporal
				SELECT @iva_total = @total / 112 * 100	
				--SELECT @fk_producto_codigo = fel FROM ##factura_encabezado_temporal

				-- SI EL PRODUCTO YA EXISTE EN LA FACTURA QUE ESTAMOS PROCESANDO....
				IF EXISTS(SELECT fk_inventario FROM ##factura_detalle_temporal WHERE fk_inventario =
				@fk_producto_codigo)
					BEGIN

						-- ACTUALIZAMOS LA CANTIDAD
						UPDATE ##factura_detalle_temporal SET cantidad = cantidad + @cantidad
						WHERE fk_inventario = @fk_producto_codigo
						-- ACTUALIZAMOS EL SUBTOTAL
						UPDATE ##factura_detalle_temporal SET subtotal = cantidad * precio_unitario 
						WHERE fk_inventario = @fk_producto_codigo

						-- ACTULIZAMOS EL TOTAL
						UPDATE ##factura_encabezado_temporal SET total = @total --WHERE fel = @fk_factura_fel--@fk_producto_codigo
						UPDATE ##factura_encabezado_temporal SET iva_total = @iva_total --WHERE fel = @fk_factura_fel--@fk_producto_codigo


						BEGIN -- PREVISULIZAMOS LA FACTURA CON EL NUEVO PRODCUTO INSERTADO
							SELECT * FROM ##factura_encabezado_temporal	
							SELECT * FROM ##factura_detalle_temporal				
							COMMIT
						END


					END
				ELSE -- SI EL PRODUCTO AUN NO EXISTE EN LA FACTURA QUE ESTAMOS PROCESANDO
					BEGIN
					-- INSERTAMOS EL NUEVO REGISTRO 
						INSERT INTO ##factura_detalle_temporal(codigo, fk_inventario, precio_unitario, cantidad, subtotal, fk_factura_fel) 
						VALUES(@codigo, @fk_producto_codigo, @precio_unitario, @cantidad, @subtotal, @fk_factura_fel)
						BEGIN

							-- ACTULIZAMOS EL SUBTOTAL PARA EL REGISTRO
							UPDATE ##factura_detalle_temporal SET subtotal = cantidad * precio_unitario 
							WHERE fk_inventario = @fk_producto_codigo

							-- ACTUALIZAMOS EL TOTAL PARA EL REGISTRO
							UPDATE ##factura_encabezado_temporal SET total = @total --WHERE fel = @fk_factura_fel --@fk_producto_codigo
							UPDATE ##factura_encabezado_temporal SET iva_total = @iva_total --WHERE fel = @fk_factura_fel --@fk_producto_codigo

						END

						BEGIN -- PREVISUALIZAMOS LA FACTURA CON LOS NUEVOS REGISTROS
							SELECT * FROM ##factura_encabezado_temporal	
							SELECT * FROM ##factura_detalle_temporal				
						END

						COMMIT
					END
			END
			ELSE  -- ERROR NO CONTAMOS CON ESTA CANTIDAD DE PRODUCTO
				THROW 50035, 'Cantidad no disponible', 1;

	-- ERROR ESE CODIGO DE PROCUTO NO EXISTE
	ELSE IF NOT EXISTS(SELECT codigo FROM inventario WHERE @fk_producto_codigo = codigo)
		THROW 50036, 'Producto no existente', 1;
	END TRY

	BEGIN CATCH -- ASIGANAMOS VARIABLES A LOS VALORES DEL ERROR
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;
		DECLARE @ErrorNumber INT;

        SELECT @ErrorMessage = ERROR_MESSAGE(), 
               @ErrorSeverity = ERROR_SEVERITY(),
               @ErrorState = ERROR_STATE(),
			   @ErrorNumber = ERROR_NUMBER();

		-- EN CASO DE HABER UN ERROR LO IMPRIMIMOS EN PANTALLA
        PRINT 'Error ' + CONCAT(@ErrorNumber, ': ' ,@ErrorMessage);

    END CATCH;
END;

/*
EJEMPLO DE EJECUCION DEL PROCESO
EXECUTE InsertarDetalleFactura3 @codigo = '499999', @fk_producto_codigo = 'INV010', 
@cantidad = 6, @fk_factura_fel = '234644'
*/

-- INSERTAR DATOS EN FACTURA_ENCABEZADO
-- INSERTAR DATOS EN FACTURA
CREATE OR ALTER PROCEDURE spInsertarFacturaEncabezado @fel VARCHAR(140), @fk_cliente_nit VARCHAR(16)
AS
BEGIN TRY
    BEGIN TRANSACTION
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	-- VALIDAMOS LOS DATOS DE ENTRADA
    IF (@fk_cliente_nit IS NULL OR LTRIM(RTRIM(@fk_cliente_nit)) = '')
        THROW 500001, 'El NIT del cliente es nulo o está vacío', 1;
    ELSE IF (@fel IS NULL OR LTRIM(RTRIM(@fel)) = '')
        THROW 50002, 'El número FEL es nulo o está vacío', 1;

	-- BUSCAMOS QUE EL FEL QUE VAMOS A USAR AUN NO EXISTA EN UNA FACTURA
    IF NOT EXISTS(SELECT fel FROM factura_encabezado WHERE fel = @fel)

		-- BUSCAMOS QUE EL FEL QUE VAMOS A USAR NO SE REPITA EN ENCABEZADO
        IF NOT EXISTS(SELECT fel FROM ##factura_encabezado_temporal WHERE fel = @fel)
        BEGIN -- DECLARAMOS LAS VARIABLES QUE VAMOS A USAR
            DECLARE @total DECIMAL(12, 2) = 1;
            DECLARE @iva_total DECIMAL(12, 2) = 1;
            DECLARE @fk_empresa_nit VARCHAR(30) = '123456789-0';

			-- INSERTAMOS LOS DATOS EN ENCABEZADO
            INSERT INTO ##factura_encabezado_temporal(fel, total, iva_total, fk_empresa_nit, fk_cliente_nit) 
            VALUES (@fel, @total, @iva_total, @fk_empresa_nit, @fk_cliente_nit);

			-- PREVISUALIZAMOS NUESTRO ENCABEZADO
            SELECT * FROM ##factura_encabezado_temporal;

            COMMIT;
        END
        ELSE
            THROW 50004, 'Un usuario solo puede crear una factura a la vez', 1;
    ELSE
        THROW 50003, 'Numero de fel ya existente', 1;

END TRY
BEGIN CATCH
	DECLARE @ErrorMessage NVARCHAR(4000);
	DECLARE @ErrorSeverity INT;
	DECLARE @ErrorState INT;
	DECLARE @ErrorNumber INT;

	SELECT	@ErrorNumber = ERROR_NUMBER(),
			@ErrorMessage = ERROR_MESSAGE(), 
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

       PRINT 'Error ' + CONCAT(@ErrorNumber, ': ' ,@ErrorMessage);

END CATCH;

/*
EJEMPLO DE EJECUCION DEL PROCESO
EXECUTE spInsertarFacturaEncabezado '234644', '0456782387'
*/