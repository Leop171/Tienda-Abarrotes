/*
Reporte de Productos más Vendidos: Detalla los productos que han generado más ventas en un período 
específico, junto con las cantidades vendidas y los ingresos generados.
*/

CREATE OR ALTER PROCEDURE spProductosMasVendido (@fechaInicio DATETIME, @fechaFin DATETIME)
AS
BEGIN
	SELECT TOP 10 fd.fk_producto_codigo, p.nombre, p.presentacion, p.marca, i.precio_compra ,p.precio_unitario AS precio_venta, 
p.precio_unitario - i.precio_compra AS Ganacias_x_producto ,COUNT(*) AS Veces_vendido, (p.precio_unitario - i.precio_compra) * COUNT(*) AS Ganancias 
FROM factura_detalle fd JOIN producto p ON p.codigo = fd.fk_producto_codigo 
JOIN inventario i ON i.codigo = fd.fk_producto_codigo 
WHERE fd.fk_producto_codigo IN (
        SELECT fd.fk_producto_codigo 
        FROM factura_detalle 
        WHERE fd.fecha BETWEEN @fechaInicio AND @fechaFin
    )
GROUP BY fd.fk_producto_codigo, p.nombre, p.presentacion, p.marca, p.precio_unitario, i.precio_compra ORDER BY COUNT(*) DESC
END

GO
/*
EXECUTE spProductosMasVendido '2024-01-01', '2024-04-01'
*/

-- Reporte de Productos menos Vendidos: Identifica los productos con menor rotación de inventario.
CREATE OR ALTER PROCEDURE spProductosMenosVendido (@fechaInicio DATETIME, @fechaFin DATETIME)
AS
BEGIN
	SELECT TOP 10 fd.fk_producto_codigo, p.nombre, p.presentacion, p.marca, i.precio_compra ,p.precio_unitario AS precio_venta, 
p.precio_unitario - i.precio_compra AS Ganacias_x_producto ,COUNT(*) AS Veces_vendido, (p.precio_unitario - i.precio_compra) * COUNT(*) AS Ganancias 
FROM factura_detalle fd JOIN producto p ON p.codigo = fd.fk_producto_codigo 
JOIN inventario i ON i.codigo = fd.fk_producto_codigo 
WHERE fd.fk_producto_codigo IN (
        SELECT fd.fk_producto_codigo 
        FROM factura_detalle 
        WHERE fd.fecha BETWEEN @fechaInicio AND @fechaFin
    )
GROUP BY fd.fk_producto_codigo, p.nombre, p.presentacion, p.marca, p.precio_unitario, i.precio_compra ORDER BY COUNT(*) ASC
END
GO

/*
EXECUTE spProductosMenosVendido '2024-01-01', '2024-04-01'
*/
/*
- Reporte de Clientes Frecuentes: Identifica a los clientes más frecuentes y su rango de edad.
*/
CREATE OR ALTER PROCEDURE spReporteClientesMasFrecuentes 
AS
BEGIN
	SELECT TOP 10 c.nit, c.nombre, c.apellido, c.genero, --DATEDIFF(YEAR, c.nacimiento, GETDATE()) AS 'Edad',
	COUNT(*) AS 'Veces que compro',
	AVG(DATEPART(HOUR, fe.fecha)) AS 'Hora frecunte'
	FROM factura_encabezado fe JOIN cliente c ON c.nit = fe.fk_cliente_nit 
	GROUP BY c.nit, c.nombre, c.apellido, c.genero, c.nacimiento ORDER BY c.nit 
END
GO

/*
EXECUTE spReporteClientesMasFrecuentes
*/
-- Reporte de Ventas Totales por Período de Tiempo: Incluye el valor promedio de compra, frecuencia de compra, 
-- ganancias por período de tiempo
-- NO FUNCIONA
CREATE OR ALTER PROCEDURE spVentasTotales (@Anio INT)
AS 
BEGIN
	SELECT MONTH(fe.fecha) MONTH, DATENAME(MONTH, fe.fecha),COUNT(*) AS 'Ventas',CAST(ROUND(AVG(total),2) AS DECIMAL(10,2)) 'Promedio de compra', 
	SUM(fe.total) AS 'Total vendido', CAST(SUM(fe.total * 0.12)AS DECIMAL(10,2)) 'IVA generado'
	FROM factura_encabezado fe
	WHERE fe.fecha IS NOT NULL AND YEAR(fe.fecha) = @Anio GROUP BY MONTH(fe.fecha) ORDER BY [MONTH];	
END

/*
EXECUTE spVentasTotales 2023
*/
