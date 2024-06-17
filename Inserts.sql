-- i
INSERT INTO empleado (codigo, dpi, primer_nombre, segundo_nombre, tercer_nombre, primer_apellido, segundo_apellido, apellido_casada, nacimiento, genero, departamento, municipio, zona, calle, numero_casa, telefono, correo) VALUES
('EMP001', '1234567890101', 'Juan', 'Carlos', 'Andr�s', 'L�pez', 'P�rez', NULL, '1990-05-15', 'M', 'Guatemala', 'Guatemala', 'U', 'AB', '123', '5551234567', 'juan.lopez@example.com'),
('EMP002', '2345678901022', 'Mar�a', 'Isabel', NULL, 'Gonz�lez', 'Rodr�guez', NULL, '1988-12-28', 'F', 'Guatemala', 'Mixco', 'U', 'CD', '456', '5552345678', 'maria.gonzalez@example.com'),
('EMP003', '3456789010233', 'Luis', 'Miguel', '�ngel', 'Mart�nez', 'L�pez', NULL, '1995-07-10', 'M', 'Guatemala', 'Villa Nueva', 'R', 'EF', '789', '5553456789', 'luis.martinez@example.com'),
('EMP004', '4567890102344', 'Ana', 'Luc�a', NULL, 'P�rez', 'Garc�a', NULL, '1992-03-20', 'F', 'Escuintla', 'Escuintla', 'U', 'GH', '101', '5554567890', 'ana.perez@example.com'),
('EMP005', '5678901023455', 'Carlos', 'Roberto', NULL, 'Hern�ndez', 'Mart�nez', NULL, '1987-09-05', 'M', 'Sacatep�quez', 'Antigua Guatemala', 'R', 'IJ', '202', '5555678901', 'carlos.hernandez@example.com'),
('EMP006', '6789010234566', 'Laura', 'Patricia', NULL, 'G�mez', 'Rodas', NULL, '1998-11-12', 'F', 'Quetzaltenango', 'Quetzaltenango', 'U', 'KL', '303', '5556789012', 'laura.gomez@example.com'),
('EMP007', '7890102345677', 'Javier', 'Francisco', 'Alejandro', 'Garc�a', 'Ram�rez', NULL, '1993-02-28', 'M', 'Chimaltenango', 'Chimaltenango', 'R', 'MN', '404', '5557890123', 'javier.garcia@example.com'),
('EMP008', '8901023456788', 'Rosa', 'Elena', NULL, 'S�nchez', 'D�az', NULL, '1990-08-17', 'F', 'Suchitep�quez', 'Mazatenango', 'R', 'OP', '505', '5558901234', 'rosa.sanchez@example.com'),
('EMP009', '9010234567899', 'David', 'Jos�', NULL, 'Rodr�guez', 'L�pez', NULL, '1997-06-25', 'M', 'Jalapa', 'Jalapa', 'U', 'QR', '606', '5559012345', 'david.rodriguez@example.com'),
('EMP010', '0102345678900', 'Carmen', 'Gabriela', 'Isabel', 'Paz', 'Morales', NULL, '1985-04-30', 'F', 'Quich�', 'Santa Cruz del Quich�', 'U', 'ST', '707', '5550123456', 'carmen.paz@example.com'),
('EMP011', '1234567890123', 'Pedro', 'Antonio', 'Jos�', 'Ch�vez', 'Guti�rrez', NULL, '1991-10-08', 'M', 'Retalhuleu', 'Retalhuleu', 'R', 'UV', '808', '5551234567', 'pedro.chavez@example.com'),
('EMP012', '2345678901234', 'Silvia', 'Lorena', 'Mar�a', 'D�az', 'Fuentes', NULL, '1996-09-22', 'F', 'Alta Verapaz', 'Cob�n', 'U', 'WX', '909', '5552345678', 'silvia.diaz@example.com'),
('EMP013', '3456789012345', 'Manuel', 'Fernando', 'Javier', 'Castro', 'Ordo�ez', NULL, '1989-12-13', 'M', 'Izabal', 'Puerto Barrios', 'R', 'YZ', '010', '5553456789', 'manuel.castro@example.com'),
('EMP014', '4567890123456', 'Sof�a', 'Alejandra', NULL, 'G�mez', 'Rivas', NULL, '1994-07-07', 'F', 'San Marcos', 'San Marcos', 'U', 'AB', '111', '5554567890', 'sofia.gomez@example.com'),
('EMP015', '5678901234567', 'Jorge', 'Alberto', NULL, 'Herrera', 'V�squez', NULL, '1999-03-18', 'M', 'Pet�n', 'Flores', 'R', 'CD', '212', '5555678901', 'jorge.herrera@example.com'),
('EMP016', '6789012345678', 'Diana', 'Marisol', 'Leticia', 'P�rez', 'M�ndez', NULL, '1986-02-09', 'F', 'Huehuetenango', 'Huehuetenango', 'R', 'EF', '313', '5556789012', 'diana.perez@example.com'),
('EMP017', '7890123456789', 'Jos�', 'Carlos', 'Manuel', 'Ram�rez', 'Soto', NULL, '1993-11-24', 'M', 'Quetzaltenango', 'Quetzaltenango', 'U', 'GH', '414', '5557890123', 'jose.ramirez@example.com'),
('EMP018', '8901234567890', 'Marcela', 'Guadalupe', 'Victoria', 'Garc�a', 'Ch�vez', NULL, '1988-08-05', 'F', 'Escuintla', 'Escuintla', 'R', 'IJ', '515', '5558901234', 'marcela.garcia@example.com'),
('EMP019', '9012345678901', 'Ricardo', 'Francisco', NULL, 'Mendoza', 'Cruz', NULL, '1997-05-30', 'M', 'Guatemala', 'Mixco', 'U', 'KL', '616', '5559012345', 'ricardo.mendoza@example.com'),
('EMP020', '0123456789012', 'Elena', 'Ver�nica', NULL, 'Santos', 'Ortega', NULL, '1987-04-11', 'F', 'Guatemala', 'Guatemala', 'R', 'MN', '717', '5550123456', 'elena.santos@example.com');

-- i
INSERT INTO empresa (nit, nombre, nombre_comercial, departamento, municipio, zona, calle, numero_casa, telefono, correo) VALUES
('123456789-0', 'ACME Corporation', 'ACME Corp', 'Guatemala', 'Guatemala', '01', 'AB', '123', '5559876543', 'info@acmecorp.com');

-- i
INSERT INTO cliente (nit, nombre, apellido, correo, telefono, nacimiento, genero) VALUES
('4638925453', 'Mar�a', 'L�pez', 'maria.lopez@example.com', '5551234567', '1990-05-15', 'F'),
('2946293845', 'Juan', 'Gonz�lez', 'juan.gonzalez@example.com', '5552345678', '1988-12-28', 'M'),
('9583026432', 'Luis', 'Mart�nez', 'luis.martinez@example.com', '5553456789', '1995-07-10', 'M'),
('1648237234', 'Ana', 'P�rez', 'ana.perez@example.com', '5554567890', '1992-03-20', 'F'),
('1236229104', 'Carlos', 'Hern�ndez', 'carlos.hernandez@example.com', '5555678901', '1987-09-05', 'M'),
('9362534929', 'Laura', 'G�mez', 'laura.gomez@example.com', '5556789012', '1998-11-12', 'F'),
('5739108343', 'Javier', 'Garc�a', 'javier.garcia@example.com', '5557890123', '1993-02-28', 'M'),
('2847201845', 'Rosa', 'S�nchez', 'rosa.sanchez@example.com', '5558901234', '1990-08-17', 'F'),
('0284678239', 'David', 'Rodr�guez', 'david.rodriguez@example.com', '5559012345', '1997-06-25', 'M'),
('8767384932', 'Carmen', 'Paz', 'carmen.paz@example.com', '5550123456', '1985-04-30', 'F'),
('2947320148', 'Pedro', 'Ch�vez', 'pedro.chavez@example.com', '5551234567', '1991-10-08', 'M'),
('1384620302', 'Silvia', 'D�az', 'silvia.diaz@example.com', '5552345678', '1996-09-22', 'F'),
('2937451812', 'Manuel', 'Castro', 'manuel.castro@example.com', '5553456789', '1989-12-13', 'M'),
('4379237634', 'Sof�a', 'G�mez', 'sofia.gomez@example.com', '5554567890', '1994-07-07', 'F'),
('3634820034', 'Jorge', 'Herrera', 'jorge.herrera@example.com', '5555678901', '1999-03-18', 'M'),
('0456782387', 'Diana', 'P�rez', 'diana.perez@example.com', '5556789012', '1986-02-09', 'F'),
('2487425234', 'Jos�', 'Ram�rez', 'jose.ramirez@example.com', '5557890123', '1993-11-24', 'M'),
('3948761543', 'Marcela', 'Garc�a', 'marcela.garcia@example.com', '5558901234', '1988-08-05', 'F'),
('3948125674', 'Ricardo', 'Mendoza', 'ricardo.mendoza@example.com', '5559012345', '1997-05-30', 'M'),
('1209834765', 'Elena', 'Santos', 'elena.santos@example.com', '5550123456', '1987-04-11', 'F');

-- i
INSERT INTO proveedor (codigo, nit, nombre, departamento, municipio, zona, calle, numero_casa, telefono, correo) VALUES
('PROV001', '123456789-0', 'Proveedor Uno', 'Guatemala', 'Guatemala', '01', 'AB', '123', '5551112222', 'proveedor1@example.com'),
('PROV002', '234567890-1', 'Proveedor Dos', 'Sacatep�quez', 'Antigua Guatemala', '02', 'CD', '456', '5552223333', 'proveedor2@example.com'),
('PROV003', '345678901-2', 'Proveedor Tres', 'Chimaltenango', 'Chimaltenango', '03', 'EF', '789', '5553334444', 'proveedor3@example.com'),
('PROV004', '456789010-3', 'Proveedor Cuatro', 'Escuintla', 'Escuintla', '04', 'GH', '101', '5554445555', 'proveedor4@example.com'),
('PROV005', '567890102-4', 'Proveedor Cinco', 'Quetzaltenango', 'Quetzaltenango', '05', 'IJ', '202', '5555556666', 'proveedor5@example.com'),
('PROV006', '678901023-5', 'Proveedor Seis', 'Huehuetenango', 'Huehuetenango', '06', 'KL', '303', '5556667777', 'proveedor6@example.com'),
('PROV007', '789010234-6', 'Proveedor Siete', 'Suchitep�quez', 'Mazatenango', '07', 'MN', '404', '5557778888', 'proveedor7@example.com'),
('PROV008', '890102345-7', 'Proveedor Ocho', 'Jalapa', 'Jalapa', '08', 'OP', '505', '5558889999', 'proveedor8@example.com'),
('PROV009', '901023456-8', 'Proveedor Nueve', 'Alta Verapaz', 'Cob�n', '09', 'QR', '606', '5559990000', 'proveedor9@example.com'),
('PROV010', '010234567-9', 'Proveedor Diez', 'Izabal', 'Puerto Barrios', '10', 'ST', '707', '5550001111', 'proveedor10@example.com'),
('PROV011', '123456789-0', 'Proveedor Once', 'Quich�', 'Santa Cruz del Quich�', '11', 'UV', '808', '5551112222', 'proveedor11@example.com'),
('PROV012', '234567890-1', 'Proveedor Doce', 'Retalhuleu', 'Retalhuleu', '12', 'WX', '909', '5552223333', 'proveedor12@example.com'),
('PROV013', '345678901-2', 'Proveedor Trece', 'San Marcos', 'San Marcos', '13', 'YZ', '010', '5553334444', 'proveedor13@example.com'),
('PROV014', '456789010-3', 'Proveedor Catorce', 'Pet�n', 'Flores', '14', 'AB', '111', '5554445555', 'proveedor14@example.com'),
('PROV015', '567890102-4', 'Proveedor Quince', 'Huehuetenango', 'Huehuetenango', '15', 'CD', '212', '5555556666', 'proveedor15@example.com'),
('PROV016', '678901023-5', 'Proveedor Diecis�is', 'Quetzaltenango', 'Quetzaltenango', '16', 'EF', '313', '5556667777', 'proveedor16@example.com'),
('PROV017', '789010234-6', 'Proveedor Diecisiete', 'Guatemala', 'Mixco', '17', 'GH', '414', '5557778888', 'proveedor17@example.com'),
('PROV018', '890102345-7', 'Proveedor Dieciocho', 'Escuintla', 'Escuintla', '18', 'IJ', '515', '5558889999', 'proveedor18@example.com'),
('PROV019', '901023456-8', 'Proveedor Diecinueve', 'Guatemala', 'Guatemala', '19', 'KL', '616', '5559990000', 'proveedor19@example.com'),
('PROV020', '010234567-9', 'Proveedor Veinte', 'Guatemala', 'Guatemala', '20', 'MN', '717', '5550001111', 'proveedor20@example.com');

-- i
INSERT INTO inventario (codigo, lote, cantidad, ubicacion, tipo, precio_compra, vencimiento, fk_proveedor) VALUES
('INV001', 'Lote001', 100, 'Estanter�a 1', 'Cereal', 5.99, '2025-03-10', 'PROV001'),
('INV002', 'Lote002', 80, 'Estanter�a 2', 'Enlatado', 3.49, '2025-04-15', 'PROV002'),
('INV003', 'Lote003', 120, 'Estanter�a 3', 'Bebida', 1.99, '2025-05-20', 'PROV003'),
('INV004', 'Lote004', 50, 'Estanter�a 4', 'Botanas', 2.79, '2025-06-25', 'PROV004'),
('INV005', 'Lote005', 90, 'Estanter�a 5', 'L�cteos', 4.29, '2025-07-30', 'PROV005'),
('INV006', 'Lote006', 60, 'Estanter�a 6', 'Frutas', 1.49, '2025-08-05', 'PROV006'),
('INV007', 'Lote007', 110, 'Estanter�a 7', 'Verduras', 2.99, '2025-09-10', 'PROV007'),
('INV008', 'Lote008', 70, 'Estanter�a 8', 'Congelados', 6.99, '2025-10-15', 'PROV008'),
('INV009', 'Lote009', 100, 'Estanter�a 9', 'Panader�a', 0.99, '2025-11-20', 'PROV009'),
('INV010', 'Lote010', 85, 'Estanter�a 10', 'Dulces', 1.25, '2025-12-25', 'PROV010'),
('INV011', 'Lote011', 95, 'Estanter�a 11', 'Cereal', 4.99, '2025-01-05', 'PROV011'),
('INV012', 'Lote012', 75, 'Estanter�a 12', 'Enlatado', 2.99, '2025-02-10', 'PROV012'),
('INV013', 'Lote013', 65, 'Estanter�a 13', 'Bebida', 1.79, '2025-03-15', 'PROV013'),
('INV014', 'Lote014', 120, 'Estanter�a 14', 'Botanas', 3.49, '2025-04-20', 'PROV014'),
('INV015', 'Lote015', 55, 'Estanter�a 15', 'L�cteos', 5.29, '2025-05-25', 'PROV015'),
('INV016', 'Lote016', 105, 'Estanter�a 16', 'Frutas', 1.99, '2025-06-30', 'PROV016'),
('INV017', 'Lote017', 80, 'Estanter�a 17', 'Verduras', 2.49, '2025-07-05', 'PROV017'),
('INV018', 'Lote018', 70, 'Estanter�a 18', 'Congelados', 7.49, '2025-08-10', 'PROV018'),
('INV019', 'Lote019', 110, 'Estanter�a 19', 'Panader�a', 1.29, '2025-09-15', 'PROV019'),
('INV020', 'Lote020', 95, 'Estanter�a 20', 'Dulces', 1.50, '2025-10-20', 'PROV020');
-- i
INSERT INTO producto (codigo, nombre, presentacion, marca, especificaciones, precio_unitario, fk_inventario) VALUES
('INV001', 'Arroz', '1 kg', 'Diana', 'Grano largo', 2.99, 'INV001'),
('INV002', 'Frijoles', '1 lb', 'La Famosa', 'Negros', 1.49, 'INV002'),
('INV003', 'Aceite', '1 litro', 'Unilever', 'Vegetal', 5.99, 'INV003'),
('INV004', 'Az�car', '2 lb', 'Polar', 'Blanca', 1.79, 'INV004'),
('INV005', 'Harina de trigo', '5 lb', 'El Gallo', 'Todo uso', 3.49, 'INV005'),
('INV006', 'Sal', '1 kg', 'Salvo', 'Fina', 0.99, 'INV006'),
('INV007', 'Caf�', '250 g', 'Britt', 'Tostado y molido', 7.99, 'INV007'),
('INV008', 'Leche', '1 litro', 'Dos Pinos', 'Entera', 2.49, 'INV008'),
('INV009', 'Pan', '400 g', 'Bimbo', 'Blanco', 1.29, 'INV009'),
('INV010', 'Galletas', '200 g', 'Mar�a', 'Integrales', 1.99, 'INV010'),
('INV011', 'Refresco', '2 litros', 'Pepsi', 'Sabor cola', 3.49, 'INV011'),
('INV012', 'Jab�n de ba�o', '4 unidades', 'Dove', 'Hidratante', 6.99, 'INV012'),
('INV013', 'Papel higi�nico', '6 rollos', 'Scott', 'Doble hoja', 5.49, 'INV013'),
('INV014', 'Detergente', '1 kg', 'Ariel', 'Polvo', 8.99, 'INV014'),
('INV015', 'Pasta dental', '150 g', 'Colgate', 'Blanqueadora', 3.99, 'INV015'),
('INV016', 'Cereal', '500 g', 'Kellogg\s', 'Multigrano', 4.49, 'INV016'),
('INV017', 'Salsa de tomate', '400 g', 'Heinz', 'Casera', 2.79, 'INV017'),
('INV018', 'Agua embotellada', '1.5 litros', 'Cristal', 'Sin gas', 1.19, 'INV018'),
('INV019', 'Yogur', '150 g', 'Yoplait', 'Natural', 1.69, 'INV019'),
('INV020', 'Chocolate', '100 g', 'Hershey\s', 'Negro', 2.29, 'INV020');
-- i
INSERT INTO producto_inventario(fk_producto_codigo, fk_inventario_codigo) VALUES 
('PROD001', 'INV001'),
('PROD002', 'INV002'),
('PROD003', 'INV003'),
('PROD004', 'INV004'),
('PROD005', 'INV005'),
('PROD006', 'INV006'),
('PROD007', 'INV007'),
('PROD008', 'INV008'),
('PROD009', 'INV009'),
('PROD010', 'INV010'),
('PROD011', 'INV011'),
('PROD012', 'INV012'),
('PROD013', 'INV013'),
('PROD014', 'INV014'),
('PROD015', 'INV015'),
('PROD016', 'INV016'),
('PROD017', 'INV017'),
('PROD018', 'INV018'),
('PROD019', 'INV019'),
('PROD020', 'INV020');