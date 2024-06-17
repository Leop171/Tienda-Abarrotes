-- CREACION DE LOS TRIGGERS
-- TRIGGER DELETES DE EMPLEADO

CREATE OR ALTER TRIGGER trEmpleadoDelete ON empleado
AFTER DELETE 
AS 
BEGIN
	INSERT INTO modificacion (fecha, fila_afectada, tabla_afectada, usuario, tipo_modificacion)
	SELECT GETDATE(), deleted.codigo, 'empleado', SUSER_NAME(), 'DELETED' FROM deleted
END
GO

-- TRIGGER DELETES DE CLIENTE
CREATE OR ALTER TRIGGER trClienteDelete ON cliente
AFTER DELETE 
AS 
BEGIN
	INSERT INTO modificacion (fecha, fila_afectada, tabla_afectada, usuario, tipo_modificacion)
	SELECT GETDATE(), deleted.nit, 'cliente', SUSER_NAME(), 'DELETED' FROM deleted
END
GO

-- TRIGGER DELETES DE EMPRESA
CREATE OR ALTER TRIGGER trEmpresaDelete ON empresa
AFTER DELETE 
AS 
BEGIN
	INSERT INTO modificacion (fecha, fila_afectada, tabla_afectada, usuario, tipo_modificacion)
	SELECT GETDATE(), deleted.nit, 'empresa', SUSER_NAME(), 'DELETED' FROM deleted
END
GO

-- TRIGGER DELETES DE FACTURA_DETALLE
CREATE OR ALTER TRIGGER trFacturaDetalleDelete ON factura_detalle
AFTER DELETE 
AS 
BEGIN
	INSERT INTO modificacion (fecha, fila_afectada, tabla_afectada, usuario, tipo_modificacion)
	SELECT GETDATE(), deleted.codigo, 'factura_detalle', SUSER_NAME(), 'DELETED' FROM deleted
END
GO

-- TRIGGER DELETES DE FACTURA_ENCABEZADO
CREATE OR ALTER TRIGGER trFacturaEncabezadoDelte ON factura_encabezado
AFTER DELETE 
AS 
BEGIN
	INSERT INTO modificacion (fecha, fila_afectada, tabla_afectada, usuario, tipo_modificacion)
	SELECT GETDATE(), deleted.fel, 'factura_encabezado', SUSER_NAME(), 'DELETED' FROM deleted
END
GO

-- TRIGGER DELETES DE INVENTARIO
CREATE OR ALTER TRIGGER trInventarioDelete ON inventario
AFTER DELETE 
AS 
BEGIN
	INSERT INTO modificacion (fecha, fila_afectada, tabla_afectada, usuario, tipo_modificacion)
	SELECT GETDATE(), deleted.codigo, 'inventario', SUSER_NAME(), 'DELETED' FROM deleted
END
GO

-- TRIGGER DELETES DE PRODUCTO
CREATE OR ALTER TRIGGER trProductoDelete ON producto
AFTER DELETE 
AS 
BEGIN
	INSERT INTO modificacion (fecha, fila_afectada, tabla_afectada, usuario, tipo_modificacion)
	SELECT GETDATE(), deleted.codigo, 'producto', SUSER_NAME(), 'DELETED' FROM deleted
END
GO

-- TRIGGER DELETES DE PRODUCTO_INVENTARIO
CREATE OR ALTER TRIGGER trProductoInventarioDelete ON producto_inventario
AFTER DELETE 
AS 
BEGIN
	INSERT INTO modificacion (fecha, tabla_afectada, usuario, tipo_modificacion)
	VALUES (GETDATE(), 'producto_inventario', SUSER_NAME(), 'DELETED')
END
GO

-- TRIGGER DELETES DE PROVEEDOR
CREATE OR ALTER TRIGGER trProveedorDelete ON proveedor
AFTER DELETE 
AS 
BEGIN
	INSERT INTO modificacion (fecha, fila_afectada, tabla_afectada, usuario, tipo_modificacion)
	SELECT GETDATE(), deleted.codigo, 'proveedor', SUSER_NAME(), 'DELETED' FROM deleted
END

GO

-- CREACION DE LOS TRIGGERS PARA UPDATES
-- TRIGGER PARA UPDATES DE EMPLEADO
CREATE OR ALTER TRIGGER trEmpleadoUpdate ON empleado
	AFTER UPDATE
AS
BEGIN
	DECLARE @accion VARCHAR(200)
	DECLARE @fecha_modificacion DATE = GETDATE()

	UPDATE empleado SET fecha_modifcacion = GETDATE() FROM empleado 
	INNER JOIN inserted ON empleado.codigo = inserted.codigo;
	
	IF UPDATE(codigo) SET @accion = CONCAT('1, ',  @accion)
	ELSE IF UPDATE(dpi) SET @accion = CONCAT('2, ',  @accion)
	ELSE IF UPDATE(primer_nombre) SET @accion = CONCAT('3, ',  @accion)
	ELSE IF UPDATE(segundo_nombre) SET @accion = CONCAT('4, ',  @accion)
	ELSE IF UPDATE(tercer_nombre) SET @accion = CONCAT('5, ',  @accion)
	ELSE IF UPDATE(primer_apellido) SET @accion = CONCAT('6, ',  @accion)
	ELSE IF UPDATE(segundo_apellido) SET @accion = CONCAT('7, ',  @accion)
	ELSE IF UPDATE(apellido_casada) SET @accion = CONCAT('8, ',  @accion)
	ELSE IF UPDATE(nacimiento) SET @accion = CONCAT('9, ',  @accion)
	ELSE IF UPDATE(genero) SET @accion = CONCAT('10, ',  @accion)
	ELSE IF UPDATE(departamento) SET @accion = CONCAT('11, ',  @accion)
	ELSE IF UPDATE(municipio) SET @accion = CONCAT('12, ',  @accion)
	ELSE IF UPDATE(zona) SET @accion = CONCAT('13, ',  @accion)
	ELSE IF UPDATE(calle) SET @accion = CONCAT('14, ',  @accion)
	ELSE IF UPDATE(numero_casa) SET @accion = CONCAT('15, ',  @accion)
	ELSE IF UPDATE(telefono) SET @accion = CONCAT('16, ',  @accion)
	ELSE IF UPDATE(correo) SET @accion = CONCAT('17, ',  @accion)
	ELSE IF UPDATE(creacion) SET @accion = CONCAT('18, ',  @accion)
	ELSE IF UPDATE(usuario) SET @accion = CONCAT('19, ',  @accion)
	ELSE IF UPDATE(fecha_modifcacion) SET @accion = CONCAT('20, ',  @accion)
	ELSE IF UPDATE(estado) SET @accion = CONCAT('21, ',  @accion)
	ELSE IF UPDATE(fk_empresa_nit) SET @accion = CONCAT('22, ',  @accion)

	INSERT INTO modificacion (fecha, fila_afectada, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
	SELECT GETDATE(), inserted.codigo, 'empleado', @accion, SUSER_NAME(), 'UPDATE' FROM inserted
END

GO

-- TRIGGERS PARA UPDATES DE CLIENTE
CREATE OR ALTER TRIGGER trClienteUpdate ON cliente
	AFTER UPDATE
AS
BEGIN
	DECLARE @accion VARCHAR(30)
	DECLARE @fecha_modificacion DATE = GETDATE()

	UPDATE cliente SET fecha_modifcacion = GETDATE() FROM cliente 
	INNER JOIN inserted ON cliente.nit = inserted.nit;

	IF UPDATE(nit) SET @accion = CONCAT('1, ',  @accion)
	ELSE IF UPDATE(nombre) SET @accion = CONCAT('2, ',  @accion)
	ELSE IF UPDATE(apellido) SET @accion = CONCAT('3, ',  @accion)
	ELSE IF UPDATE(correo) SET @accion = CONCAT('4, ',  @accion)
	ELSE IF UPDATE(telefono) SET @accion = CONCAT('5, ',  @accion)
	ELSE IF UPDATE(nacimiento) SET @accion = CONCAT('6, ',  @accion)
	ELSE IF UPDATE(genero) SET @accion = CONCAT('7, ',  @accion)
	ELSE IF UPDATE(creacion) SET @accion = CONCAT('8, ',  @accion)
	ELSE IF UPDATE(usuario) SET @accion = CONCAT('9, ',  @accion)
	ELSE IF UPDATE(fecha_modifcacion) SET @accion = CONCAT('10, ',  @accion)
	ELSE IF UPDATE(estado) SET @accion = CONCAT('11, ',  @accion)

	INSERT INTO modificacion (fecha, fila_afectada, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
	SELECT GETDATE(), inserted.nit, 'cliente', @accion, SUSER_NAME(), 'UPDATE' FROM inserted
END

GO

-- TRIGGERS PARA UPDATES DE EMPRESA
CREATE OR ALTER TRIGGER trEmpresaUpdate ON empresa
	AFTER UPDATE
AS
BEGIN
	DECLARE @accion VARCHAR(30)
	DECLARE @fecha_modificacion DATE = GETDATE()

	UPDATE empresa SET fecha_modifcacion = GETDATE() FROM empresa 
	INNER JOIN inserted ON empresa.nit = inserted.nit;

	IF UPDATE(nit) SET @accion = CONCAT('1, ',  @accion)
	ELSE IF UPDATE(nombre) SET @accion = CONCAT('2, ',  @accion)
	ELSE IF UPDATE(nombre_comercial) SET @accion = CONCAT('3, ',  @accion)
	ELSE IF UPDATE(departamento) SET @accion = CONCAT('4, ',  @accion)
	ELSE IF UPDATE(municipio) SET @accion = CONCAT('5, ',  @accion)
	ELSE IF UPDATE(zona) SET @accion = CONCAT('6, ',  @accion)
	ELSE IF UPDATE(calle) SET @accion = CONCAT('7, ',  @accion)
	ELSE IF UPDATE(numero_casa) SET @accion = CONCAT('8, ',  @accion)
	ELSE IF UPDATE(telefono) SET @accion = CONCAT('9, ',  @accion)
	ELSE IF UPDATE(correo) SET @accion = CONCAT('10, ',  @accion)
	ELSE IF UPDATE(creacion) SET @accion = CONCAT('11, ',  @accion)
	ELSE IF UPDATE(usuario) SET @accion = CONCAT('12, ',  @accion)
	ELSE IF UPDATE(fecha_modifcacion) SET @accion = CONCAT('13, ',  @accion)
	ELSE IF UPDATE(estado) SET @accion = CONCAT('14, ',  @accion)

	INSERT INTO modificacion (fecha, fila_afectada, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
	SELECT GETDATE(), inserted.nit, 'empresa', @accion, SUSER_NAME(), 'UPDATE' FROM inserted
END

GO

-- TRIGGER PARA FACTURA_DETALLE
CREATE OR ALTER TRIGGER trFactura_DetalleUpdate ON factura_detalle
	AFTER UPDATE
AS
BEGIN
	DECLARE @accion VARCHAR(30)
	DECLARE @fecha_modificacion DATE = GETDATE()

	UPDATE factura_detalle SET fecha_modifcacion = GETDATE() FROM factura_detalle 
	INNER JOIN inserted ON factura_detalle.codigo = inserted.codigo;

	IF UPDATE(codigo) SET @accion = CONCAT('1, ',  @accion)
	ELSE IF UPDATE(fecha) SET @accion = CONCAT('2, ',  @accion)
	ELSE IF UPDATE(fk_producto_codigo) SET @accion = CONCAT('3, ',  @accion)
	ELSE IF UPDATE(precio_unitario) SET @accion = CONCAT('4, ',  @accion)
	ELSE IF UPDATE(cantidad) SET @accion = CONCAT('5, ',  @accion)
	ELSE IF UPDATE(subtotal) SET @accion = CONCAT('6, ',  @accion)
	ELSE IF UPDATE(fk_factura_fel) SET @accion = CONCAT('7, ',  @accion)
	ELSE IF UPDATE(creacion) SET @accion = CONCAT('8, ',  @accion)
	ELSE IF UPDATE(usuario) SET @accion = CONCAT('9, ',  @accion)
	ELSE IF UPDATE(fecha_modifcacion) SET @accion = CONCAT('10, ',  @accion)
	ELSE IF UPDATE(estado) SET @accion = CONCAT('11, ',  @accion)

	INSERT INTO modificacion (fecha, fila_afectada, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
	SELECT GETDATE(), inserted.codigo, 'factura_detalle', @accion, SUSER_NAME(), 'UPDATE' FROM inserted
END

GO

-- TRIGGER PARA FACTURA_ENCABEZADO
CREATE OR ALTER TRIGGER trFactura_EncabezadoUpdate ON factura_encabezado
	AFTER UPDATE
AS
BEGIN
	DECLARE @accion VARCHAR(30)
	DECLARE @fecha_modificacion DATE = GETDATE()

	UPDATE factura_encabezado SET fecha_modifcacion = GETDATE() FROM factura_encabezado 
	INNER JOIN inserted ON factura_encabezado.fel = inserted.fel;


	IF UPDATE(fel) SET @accion = CONCAT('1, ',  @accion)
	ELSE IF UPDATE(fecha) SET @accion = CONCAT('2, ',  @accion)
	ELSE IF UPDATE(total) SET @accion = CONCAT('3, ',  @accion)
	ELSE IF UPDATE(iva_total) SET @accion = CONCAT('4, ',  @accion)
	ELSE IF UPDATE(fk_empresa_nit) SET @accion = CONCAT('5, ',  @accion)
	ELSE IF UPDATE(fk_cliente_nit) SET @accion = CONCAT('6, ',  @accion)
	ELSE IF UPDATE(creacion) SET @accion = CONCAT('7, ',  @accion)
	ELSE IF UPDATE(usuario) SET @accion = CONCAT('8, ',  @accion)
	ELSE IF UPDATE(fecha_modifcacion) SET @accion = CONCAT('9, ',  @accion)
	ELSE IF UPDATE(estado) SET @accion = CONCAT('10, ',  @accion)

	INSERT INTO modificacion (fecha, fila_afectada, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
	SELECT GETDATE(), inserted.fel, 'factura_encabezado', @accion, SUSER_NAME(), 'UPDATE' FROM inserted
END

GO

-- TRIGGER PARA INVENTARIO
CREATE OR ALTER TRIGGER trInventarioUpdate ON inventario
	AFTER UPDATE
AS
BEGIN
	DECLARE @accion VARCHAR(30)
	DECLARE @fecha_modificacion DATE = GETDATE()

	UPDATE inventario SET fecha_modifcacion = GETDATE() FROM inventario 
	INNER JOIN inserted ON inventario.codigo = inventario.codigo;

	IF UPDATE(codigo) SET @accion = CONCAT('1, ',  @accion)
	ELSE IF UPDATE(fecha_entrada) SET @accion = CONCAT('2, ',  @accion)
	ELSE IF UPDATE(lote) SET @accion = CONCAT('3, ',  @accion)
	ELSE IF UPDATE(cantidad) SET @accion = CONCAT('4, ',  @accion)
	ELSE IF UPDATE(ubicacion) SET @accion = CONCAT('5, ',  @accion)
	ELSE IF UPDATE(tipo) SET @accion = CONCAT('6, ',  @accion)
	ELSE IF UPDATE(precio_compra) SET @accion = CONCAT('7, ',  @accion)
	ELSE IF UPDATE(vencimiento) SET @accion = CONCAT('8, ',  @accion)
	ELSE IF UPDATE(fk_proveedor) SET @accion = CONCAT('9, ',  @accion)
	ELSE IF UPDATE(creacion) SET @accion = CONCAT('10, ',  @accion)
	ELSE IF UPDATE(usuario) SET @accion = CONCAT('11, ',  @accion)
	ELSE IF UPDATE(fecha_modifcacion) SET @accion = CONCAT('12, ',  @accion)
	ELSE IF UPDATE(estado) SET @accion = CONCAT('13, ',  @accion)

	INSERT INTO modificacion (fecha, fila_afectada, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
	SELECT GETDATE(), inserted.codigo, 'inventario', @accion, SUSER_NAME(), 'UPDATE' FROM inserted
END

GO

-- TRIGGER PARA MODIFICACION
CREATE OR ALTER TRIGGER trModificacionUpdate ON modificacion
	AFTER UPDATE
AS
BEGIN
	DECLARE @accion VARCHAR(30)


	IF UPDATE(codigo) SET @accion = CONCAT('1, ',  @accion)
	ELSE IF UPDATE(fecha) SET @accion = CONCAT('2, ',  @accion)
	ELSE IF UPDATE(fila_afectada) SET @accion = CONCAT('3, ',  @accion)
	ELSE IF UPDATE(tabla_afectada) SET @accion = CONCAT('4, ',  @accion)
	ELSE IF UPDATE(columna_afectada) SET @accion = CONCAT('5, ',  @accion)
	ELSE IF UPDATE(usuario) SET @accion = CONCAT('6, ',  @accion)
	ELSE IF UPDATE(tipo_modificacion) SET @accion = CONCAT('7, ',  @accion)

	INSERT INTO modificacion (fecha, fila_afectada, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
	SELECT GETDATE(), inserted.codigo, 'modificacion', @accion, SUSER_NAME(), 'UPDATE' FROM inserted
END

GO

-- TRIGGER PARA PRODUCTO
CREATE OR ALTER TRIGGER trProductoUpdate ON producto
	AFTER UPDATE
AS
BEGIN
	DECLARE @accion VARCHAR(30)
	DECLARE @fecha_modificacion DATE = GETDATE()

	UPDATE producto SET fecha_modifcacion = GETDATE() FROM producto 
	INNER JOIN inserted ON producto.codigo = inserted.codigo;

	IF UPDATE(codigo) SET @accion = CONCAT('1, ',  @accion)
	ELSE IF UPDATE(fecha_ingreso) SET @accion = CONCAT('2, ',  @accion)
	ELSE IF UPDATE(nombre) SET @accion = CONCAT('3, ',  @accion)
	ELSE IF UPDATE(presentacion) SET @accion = CONCAT('4, ',  @accion)
	ELSE IF UPDATE(marca) SET @accion = CONCAT('5, ',  @accion)
	ELSE IF UPDATE(especificaciones) SET @accion = CONCAT('6, ',  @accion)
	ELSE IF UPDATE(precio_unitario) SET @accion = CONCAT('7, ',  @accion)
	ELSE IF UPDATE(fk_inventario) SET @accion = CONCAT('8, ',  @accion)
	ELSE IF UPDATE(creacion) SET @accion = CONCAT('9, ',  @accion)
	ELSE IF UPDATE(usuario) SET @accion = CONCAT('10, ',  @accion)
	ELSE IF UPDATE(fecha_modifcacion) SET @accion = CONCAT('11, ',  @accion)
	ELSE IF UPDATE(estado) SET @accion = CONCAT('12, ',  @accion)

	INSERT INTO modificacion (fecha, fila_afectada, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
	SELECT GETDATE(), inserted.codigo, 'producto', @accion, SUSER_NAME(), 'UPDATE' FROM inserted
END

GO

-- TRIGGER PARA PRODUCTO_INVENTARIO
CREATE OR ALTER TRIGGER trProductoInventarioUpdate ON producto_inventario
	AFTER UPDATE
AS
BEGIN
	DECLARE @accion VARCHAR(30)

	IF UPDATE(fecha) SET @accion = 'fecha'
	ELSE IF UPDATE(fk_producto_codigo) SET @accion = CONCAT('1, ',  @accion)
	ELSE IF UPDATE(fk_inventario_codigo) SET @accion = CONCAT('2, ',  @accion)

	INSERT INTO modificacion (fecha, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
	SELECT GETDATE(), 'producto_inventario', @accion, SUSER_NAME(), 'UPDATE' FROM inserted
END

GO

-- TRIGGER PARA UPDATES DE EMPLEADO
CREATE OR ALTER TRIGGER trProveedorUpdate ON proveedor
	AFTER UPDATE
AS
BEGIN
	DECLARE @accion VARCHAR(200)	
	DECLARE @fecha_modificacion DATE = GETDATE()

	UPDATE proveedor SET fecha_modifcacion = GETDATE() FROM proveedor 
	INNER JOIN inserted ON proveedor.codigo = inserted.codigo;

	IF UPDATE(codigo) SET @accion = CONCAT('1, ',  @accion)
	ELSE IF UPDATE(nit) SET @accion = CONCAT('2, ',  @accion)
	ELSE IF UPDATE(nombre) SET @accion = CONCAT('3, ',  @accion)
	ELSE IF UPDATE(departamento) SET @accion = CONCAT('4, ',  @accion)
	ELSE IF UPDATE(municipio) SET @accion = CONCAT('5, ',  @accion)
	ELSE IF UPDATE(zona) SET @accion = CONCAT('6, ',  @accion)
	ELSE IF UPDATE(calle) SET @accion = CONCAT('7, ',  @accion)
	ELSE IF UPDATE(numero_casa) SET @accion = CONCAT('8, ',  @accion)
	ELSE IF UPDATE(telefono) SET @accion = CONCAT('9, ',  @accion)
	ELSE IF UPDATE(correo) SET @accion = CONCAT('10, ',  @accion)
	ELSE IF UPDATE(creacion) SET @accion = CONCAT('11, ',  @accion)
	ELSE IF UPDATE(usuario) SET @accion = CONCAT('12, ',  @accion)
	ELSE IF UPDATE(fecha_modifcacion) SET @accion = CONCAT('13, ',  @accion)
	ELSE IF UPDATE(estado) SET @accion = CONCAT('14, ',  @accion)

	INSERT INTO modificacion (fecha, fila_afectada, tabla_afectada, columna_afectada, usuario, tipo_modificacion)
	SELECT GETDATE(), inserted.codigo, 'proveedor', @accion, SUSER_NAME(), 'UPDATE' FROM inserted
	
END

-- TRIGGER QUE DESCUENTA DE INVENTARIO
-- DESCUENTA LOS PRODUCTOS DEL INVENTARIO CADA VEZ QUE SE INSERTA EN DETALLE
CREATE OR ALTER TRIGGER trDescontarInventario ON factura_detalle
AFTER INSERT 
AS 
BEGIN
	DECLARE @fk_codigo_producto VARCHAR(30)
	DECLARE @cantidad INT
	SELECT @fk_codigo_producto = fk_producto_codigo FROM inserted
	SELECT @cantidad = cantidad FROM inserted
	UPDATE inventario SET cantidad = cantidad - @cantidad WHERE codigo = @fk_codigo_producto
END


