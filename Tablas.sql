-- Base de datos para un tienda de abarrotes
-- Fecha: 11-04-2024
-- Lenguaje: SQL 
-- BDMS: Magnament Studio

-- CREACION DE LAS TABLAS 
CREATE DATABASE CentroComercial5
GO
USE CentroComercial5
GO
CREATE TABLE empresa (
nit VARCHAR(16) PRIMARY KEY,
nombre VARCHAR(45) NOT NULL,
nombre_comercial VARCHAR(45) NOT NULL,
departamento VARCHAR(45) NOT NULL,
municipio VARCHAR(45) NOT NULL,
zona CHAR(2),
calle CHAR(2),
numero_casa VARCHAR(8),
telefono VARCHAR(12) NOT NULL,
correo VARCHAR(45) NOT NULL,
creacion DATETIME DEFAULT GETDATE(),
usuario VARCHAR(60) DEFAULT SUSER_SNAME(),
fecha_modifcacion DATETIME DEFAULT GETDATE(),
estado CHAR(1) DEFAULT 'a',
CONSTRAINT ckEstado_empresa CHECK(estado = 'a' OR estado = 'n')
)

GO

CREATE TABLE empleado (
codigo VARCHAR(12) PRIMARY KEY,
dpi VARCHAR(45) NOT NULL,
primer_nombre VARCHAR(45) NOT NULL,
segundo_nombre VARCHAR(45) NOT NULL,
tercer_nombre VARCHAR(45),
primer_apellido VARCHAR(45) NOT NULL,
segundo_apellido VARCHAR(45) NOT NULL,
apellido_casada VARCHAR(45),
nacimiento DATE NOT NULL,
genero CHAR(1) NOT NULL,
departamento VARCHAR(45) NOT NULL,
municipio VARCHAR(45) NOT NULL,
zona CHAR(1),
calle CHAR(2),
numero_casa VARCHAR(8),
telefono VARCHAR(12),
correo VARCHAR(45) NOT NULL,
creacion DATETIME DEFAULT GETDATE(),
usuario VARCHAR(60) DEFAULT SUSER_SNAME(),
fecha_modifcacion DATETIME DEFAULT GETDATE(),
estado CHAR(1) DEFAULT 'a',
fk_empresa_nit VARCHAR(16) DEFAULT '123456789-0' NOT NULL,
FOREIGN KEY(fk_empresa_nit) REFERENCES empresa(nit),
CONSTRAINT ckNacimiento CHECK(DATEDIFF(YEAR, nacimiento, GETDATE())>= 18),
CONSTRAINT ckGenero_empleado CHECK(genero = 'F' OR genero = 'M' ),
CONSTRAINT ckEstado_empleado CHECK(estado = 'a' OR estado = 'n')
) 

GO

CREATE TABLE cliente (
nit VARCHAR(16) PRIMARY KEY,
nombre VARCHAR(45),
apellido VARCHAR(45),
correo VARCHAR(45),
telefono VARCHAR(16),
nacimiento DATE,
genero CHAR(1),
creacion DATETIME DEFAULT GETDATE(),
usuario VARCHAR(60) DEFAULT SUSER_SNAME(),
fecha_modifcacion DATETIME DEFAULT GETDATE(),
estado CHAR(1) DEFAULT 'a',
CONSTRAINT ckGenero_cliente CHECK(genero = 'F' OR genero = 'M'),
CONSTRAINT ckEstado_cliente CHECK(estado = 'a' OR estado = 'n')
)

GO

CREATE TABLE proveedor (
codigo VARCHAR(12) PRIMARY KEY,
nit VARCHAR(16) NOT NULL,
nombre VARCHAR(45) NOT NULL,
departamento VARCHAR(45) NOT NULL,
municipio VARCHAR(45) NOT NULL,
zona CHAR(2),
calle CHAR(2),
numero_casa VARCHAR(8),
telefono VARCHAR(12) NOT NULL,
correo VARCHAR(45) NOT NULL,
creacion DATETIME DEFAULT GETDATE(),
usuario VARCHAR(60) DEFAULT SUSER_SNAME(),
fecha_modifcacion DATETIME DEFAULT GETDATE(),
estado CHAR(1) DEFAULT 'a',
CONSTRAINT ckEstado_proveedor CHECK(estado = 'a' OR estado = 'n')
)

GO

CREATE TABLE factura_encabezado(
fel VARCHAR(140) PRIMARY KEY,
fecha DATETIME DEFAULT GETDATE(),
total DECIMAL(10,2) NOT NULL,
iva_total DECIMAL(10,2) NOT NULL,
fk_empresa_nit VARCHAR(16) NOT NULL,
fk_cliente_nit VARCHAR(16) NOT NULL,
creacion DATETIME DEFAULT GETDATE(),
usuario VARCHAR(60) DEFAULT SUSER_SNAME(),
fecha_modifcacion DATETIME DEFAULT GETDATE(),
estado CHAR(1) DEFAULT 'a',
FOREIGN KEY (fk_empresa_nit) REFERENCES empresa(nit),
FOREIGN KEY (fk_cliente_nit) REFERENCES cliente(nit),
CONSTRAINT ckEstado_factura CHECK(estado = 'a' OR estado = 'n'),
CONSTRAINT ckTotal_factura CHECK(total > 0),
CONSTRAINT ckIva_factura CHECK(iva_total > 0)
) 

GO

CREATE TABLE inventario ( 
codigo VARCHAR(16) PRIMARY KEY,
fecha_entrada DATE DEFAULT GETDATE(),
lote VARCHAR(45) NOT NULL,
cantidad INT NOT NULL,
ubicacion VARCHAR(45) NOT NULL,
tipo VARCHAR(45),
precio_compra DECIMAL(10,2) NOT NULL,
vencimiento DATE NOT NULL,
fk_proveedor VARCHAR(12) NOT NULL,
creacion DATETIME DEFAULT GETDATE(),
usuario VARCHAR(60) DEFAULT SUSER_SNAME(),
fecha_modifcacion DATETIME DEFAULT GETDATE(),
estado CHAR(1) DEFAULT 'a',
FOREIGN KEY (fk_proveedor) REFERENCES proveedor(codigo),
CONSTRAINT ckEstado_inventario CHECK(estado = 'a' OR estado = 'n'),
CONSTRAINT ckCantidad_inventario CHECK(cantidad > 0)
)

GO

CREATE TABLE producto (
codigo VARCHAR(16) PRIMARY KEY,
fecha_ingreso DATE DEFAULT GETDATE(),
nombre VARCHAR(45) NOT NULL,
presentacion VARCHAR(45) NOT NULL,
marca VARCHAR(45) NOT NULL,
especificaciones VARCHAR(45),
precio_unitario DECIMAL(10,2) NOT NULL,
fk_inventario VARCHAR(16) NOT NULL,
creacion DATETIME DEFAULT GETDATE(),
usuario VARCHAR(60) DEFAULT SUSER_SNAME(),
fecha_modifcacion DATETIME DEFAULT GETDATE(),
estado CHAR(1) DEFAULT 'a',
FOREIGN KEY (fk_inventario) REFERENCES inventario(codigo),
CONSTRAINT ckEstado_producto CHECK(estado = 'a' OR estado = 'n'),
CONSTRAINT ckPrecio_producto CHECK(precio_unitario > 0)
)

GO

CREATE TABLE factura_detalle(
codigo INT IDENTITY(1, 1) PRIMARY KEY,
fecha DATETIME DEFAULT GETDATE(),
fk_producto_codigo VARCHAR(16) NOT NULL,
precio_unitario DECIMAL(10,2) NOT NULL,
cantidad INT NOT NULL,
subtotal DECIMAL(10,2) NOT NULL,
fk_factura_fel VARCHAR(140) NOT NULL,
creacion DATETIME DEFAULT GETDATE(),
usuario VARCHAR(60) DEFAULT SUSER_SNAME(),
fecha_modifcacion DATETIME DEFAULT GETDATE(),
estado CHAR(1) DEFAULT 'a',
FOREIGN KEY (fk_factura_fel) REFERENCES factura_encabezado(fel),
CONSTRAINT ckEstado_detalle CHECK(estado = 'a' OR estado = 'n'),
CONSTRAINT ckPrecio_detalle CHECK(precio_unitario > 0),
CONSTRAINT ckCantidad_detalle CHECK(cantidad > 0),
FOREIGN KEY (fk_producto_codigo) REFERENCES inventario(codigo)
) 

GO

CREATE TABLE producto_inventario(
fecha DATETIME DEFAULT GETDATE(),
fk_producto_codigo VARCHAR(16),
fk_inventario_codigo VARCHAR(16),
FOREIGN KEY (fk_producto_codigo) REFERENCES producto(codigo),
FOREIGN KEY (fk_inventario_codigo) REFERENCES inventario(codigo)
)

GO

CREATE TABLE usuario(
codigo INT PRIMARY KEY IDENTITY(1, 1),
nombre VARCHAR(40) NOT NULL UNIQUE,
contrasenia VARCHAR(40) NOT NULL,
rol VARCHAR(40) NOT NULL,
fk_codigo_empleado VARCHAR(12),
creacion DATETIME DEFAULT GETDATE(),
usuario VARCHAR(60) DEFAULT SUSER_SNAME(),
fecha_modifcacion DATETIME,
estado CHAR(1) DEFAULT 'a',
FOREIGN KEY(fk_codigo_empleado) REFERENCES empleado(codigo)
)

GO

CREATE TABLE modificacion(
codigo INT PRIMARY KEY IDENTITY(1, 1),
fecha DATETIME,
fila_afectada VARCHAR(50) NOT NULL,
tabla_afectada VARCHAR(30) NOT NULL,
columna_afectada VARCHAR(30),
usuario VARCHAR(70) NOT NULL,
tipo_modificacion VARCHAR(40) NOT NULL
)

GO

CREATE TABLE ##factura_detalle_temporal(
codigo INT,
fecha DATETIME DEFAULT GETDATE(),
fk_inventario VARCHAR(16) NOT NULL,
precio_unitario DECIMAL(10,2) NOT NULL,
cantidad INT NOT NULL,
subtotal DECIMAL(10,2) NOT NULL,
fk_factura_fel VARCHAR(140) NOT NULL)
GO
CREATE TABLE ##factura_encabezado_temporal(
fel VARCHAR(300) PRIMARY KEY,
fecha DATETIME DEFAULT GETDATE(),
total DECIMAL(10,2) NOT NULL,
iva_total DECIMAL(10,2) NOT NULL,
fk_empresa_nit VARCHAR(16) NOT NULL,
fk_cliente_nit VARCHAR(16) NOT NULL)

