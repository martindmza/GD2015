------------------------------------------------------------------------------------
---------------------------------DROP TERMPORAL-------------------------------------
------------------------------------------------------------------------------------

USE [GD1C2015]
GO

ALTER TABLE REZAGADOS.FuncionalidadXRol DROP CONSTRAINT FK_FuncionalidadXRol_to_Rol;
ALTER TABLE REZAGADOS.FuncionalidadXRol DROP CONSTRAINT FK_FuncionalidadXRol_to_Funcionalidad;
ALTER TABLE REZAGADOS.UsuarioXRol DROP CONSTRAINT FK_UsuarioXRol_to_Rol;
ALTER TABLE REZAGADOS.UsuarioXRol DROP CONSTRAINT FK_UsuarioXRol_to_Usuario;
ALTER TABLE REZAGADOS.Administrador DROP CONSTRAINT FK_Administrador_to_Usuario;
ALTER TABLE REZAGADOS.Cliente DROP CONSTRAINT FK_Cliente_to_Usuario;
ALTER TABLE REZAGADOS.Cliente DROP CONSTRAINT FK_Cliente_to_TipoDocumento;
ALTER TABLE REZAGADOS.Cliente DROP CONSTRAINT FK_Cliente_to_Pais;
ALTER TABLE REZAGADOS.Cuenta DROP CONSTRAINT FK_Cuenta_to_Usuario;
ALTER TABLE REZAGADOS.Cuenta DROP CONSTRAINT FK_Cuenta_to_TipoCuenta;
ALTER TABLE REZAGADOS.Cuenta DROP CONSTRAINT FK_Cuenta_to_Pais;
ALTER TABLE REZAGADOS.Cuenta DROP CONSTRAINT FK_Cuenta_to_Moneda;
ALTER TABLE REZAGADOS.HistorialCuenta DROP CONSTRAINT FK_Historial_Cuenta_to_Cuenta;
ALTER TABLE REZAGADOS.Deposito DROP CONSTRAINT FK_Deposito_to_Cuenta;
ALTER TABLE REZAGADOS.Deposito DROP CONSTRAINT FK_Deposito_to_Pais;
ALTER TABLE REZAGADOS.Deposito DROP CONSTRAINT FK_Deposito_to_Tarjeta;
ALTER TABLE REZAGADOS.Deposito DROP CONSTRAINT FK_Deposito_to_Moneda;
ALTER TABLE REZAGADOS.Tarjeta DROP CONSTRAINT FK_Tarjeta_to_Usuario;
ALTER TABLE REZAGADOS.Transferencia DROP CONSTRAINT FK_Transferencia_to_Cuenta_Emi;
ALTER TABLE REZAGADOS.Transferencia DROP CONSTRAINT FK_Transferencia_to_Cuenta_Dest;
ALTER TABLE REZAGADOS.Retiro DROP CONSTRAINT FK_Retiro_to_Cuenta;
ALTER TABLE REZAGADOS.Retiro DROP CONSTRAINT FK_Retiro_to_Moneda;
ALTER TABLE REZAGADOS.Cheque DROP CONSTRAINT FK_Cheque_to_Retiro;
ALTER TABLE REZAGADOS.Cheque DROP CONSTRAINT FK_Cheque_to_Banco;
ALTER TABLE REZAGADOS.Cheque DROP CONSTRAINT FK_Cheque_to_Moneda;
ALTER TABLE REZAGADOS.Item DROP CONSTRAINT FK_Item_to_Factura;
ALTER TABLE REZAGADOS.Item DROP CONSTRAINT FK_Item_to_Tipo_Item;
ALTER TABLE REZAGADOS.Item DROP CONSTRAINT FK_Item_to_Cuenta;
ALTER TABLE REZAGADOS.Factura DROP CONSTRAINT FK_Factura_to_Usuario;
ALTER TABLE REZAGADOS.HistorialUsuario DROP CONSTRAINT FK_Historial_Usuario_to_Usuario;

DROP TABLE REZAGADOS.Rol;
DROP TABLE REZAGADOS.Funcionalidad;
DROP TABLE REZAGADOS.FuncionalidadXRol;
DROP TABLE REZAGADOS.Usuario;
DROP TABLE REZAGADOS.UsuarioXRol;
DROP TABLE REZAGADOS.Administrador;
DROP TABLE REZAGADOS.Cliente;
DROP TABLE REZAGADOS.TipoDocumento;
DROP TABLE REZAGADOS.Tarjeta;
DROP TABLE REZAGADOS.Factura;
DROP TABLE REZAGADOS.Pais;
DROP TABLE REZAGADOS.Cuenta;
DROP TABLE REZAGADOS.Deposito;
DROP TABLE REZAGADOS.Retiro;
DROP TABLE REZAGADOS.Cheque;
DROP TABLE REZAGADOS.Banco;
DROP TABLE REZAGADOS.TipoCuenta;
DROP TABLE REZAGADOS.Transferencia;
DROP TABLE REZAGADOS.HistorialCuenta;
DROP TABLE REZAGADOS.Moneda;
DROP TABLE REZAGADOS.TipoItem;
DROP TABLE REZAGADOS.Item;
DROP TABLE REZAGADOS.HistorialUsuario;

DROP PROCEDURE REZAGADOS.Crear_Cliente;
DROP PROCEDURE REZAGADOS.Modificar_Cliente;
DROP PROCEDURE REZAGADOS.Eliminar_Cliente;
DROP PROCEDURE REZAGADOS.Alta_Usuario;
DROP PROCEDURE REZAGADOS.Baja_Usuario;
DROP PROCEDURE REZAGADOS.Alta_Cliente;
DROP PROCEDURE REZAGADOS.Baja_Cliente;
DROP PROCEDURE REZAGADOS.Crear_Rol;
DROP PROCEDURE REZAGADOS.Borrar_Rol;
DROP PROCEDURE REZAGADOS.Login;
DROP PROCEDURE REZAGADOS.Cambio_Contrasenia;
DROP PROCEDURE REZAGADOS.Baja_Rol;
DROP PROCEDURE REZAGADOS.Alta_Rol;
DROP PROCEDURE REZAGADOS.Modificar_Nombre_Rol;
DROP PROCEDURE REZAGADOS.Modificar_Funcionalidad;
DROP PROCEDURE REZAGADOS.Baja_Funcionalidad;
DROP PROCEDURE REZAGADOS.Desasignar_Rol;
DROP PROCEDURE REZAGADOS.Agregar_Funcionalidad;
DROP PROCEDURE REZAGADOS.Asignar_Rol;
DROP PROCEDURE REZAGADOS.Baja_Cuenta;
DROP PROCEDURE REZAGADOS.Alta_Cuenta;
DROP PROCEDURE REZAGADOS.Crear_Cuenta;
DROP PROCEDURE REZAGADOS.Modificar_Costo_Cuenta;

USE [GD1C2015]
GO
DROP SCHEMA [REZAGADOS]
GO

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
------------------------TRABAJO PRACTICO GESTION DE DATOS----------------------------
-------------------------------------------------------------------------------------
-----------------------------ESQUEMA REZAGADOS---------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

USE [GD1C2015]
GO
CREATE SCHEMA [REZAGADOS] AUTHORIZATION [gd]
GO

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
----------------------------------CREATE TABLES--------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

CREATE TABLE REZAGADOS.Rol(
Id_Rol numeric(18,0) IDENTITY(1,1) NOT NULL,
Nombre varchar(255) UNIQUE,
Habilitada bit DEFAULT 1,);
ALTER TABLE REZAGADOS.Rol ADD CONSTRAINT PK_Id_Rol PRIMARY KEY (Id_Rol);

CREATE TABLE REZAGADOS.FuncionalidadXRol (
Id_Rol numeric(18,0) NOT NULL,
Id_Funcionalidad numeric(18,0) NOT NULL,
Habilitada bit DEFAULT 1,);
ALTER TABLE REZAGADOS.FuncionalidadXRol ADD CONSTRAINT PK_Id_Funcionalidad_Rol PRIMARY KEY (Id_Funcionalidad, Id_Rol);

CREATE TABLE REZAGADOS.Funcionalidad (
Id_Funcionalidad numeric(18,0) IDENTITY(1,1) NOT NULL,
Nombre varchar(255) UNIQUE,
Habilitada bit DEFAULT 1,);
ALTER TABLE REZAGADOS.Funcionalidad ADD CONSTRAINT PK_Id_Funcionalidad PRIMARY KEY (Id_Funcionalidad);

CREATE TABLE REZAGADOS.Usuario (
Id_Usuario numeric(18,0) IDENTITY(1,1) NOT NULL,
Nombre varchar(255) UNIQUE, 
Contrasenia varchar(255),
Cantidad_Intentos_Fallidos numeric(18,0) DEFAULT 0,
Contrasenia_Modificada bit DEFAULT 0,
Fecha_Creacion datetime,
Fecha_Ult_Modif datetime,
Pregunta varchar(255),
Respuesta varchar(255),
Habilitada bit DEFAULT 1,);
ALTER TABLE REZAGADOS.Usuario ADD CONSTRAINT PK_Id_Usuario PRIMARY KEY (Id_Usuario);

CREATE TABLE REZAGADOS.HistorialUsuario(
Id_Historial_Usuario numeric (18,0) IDENTITY(1,1) NOT NULL,
Id_Usuario numeric (18,0),
Fecha datetime,
Contrasenia varchar(255),);
ALTER TABLE REZAGADOS.HistorialUsuario ADD CONSTRAINT PK_Id_Historial_Usuario PRIMARY KEY (Id_Historial_Usuario);

CREATE TABLE REZAGADOS.UsuarioXRol (
Id_Usuario numeric(18,0) NOT NULL,
Id_Rol numeric(18,0) NOT NULL,
Habilitada bit DEFAULT 1,);
ALTER TABLE REZAGADOS.UsuarioXRol ADD CONSTRAINT PK_Id_Usuario_Rol PRIMARY KEY (Id_Rol, Id_Usuario);

CREATE TABLE REZAGADOS.Administrador (
Id_Administrador numeric(18,0) IDENTITY(1,1) NOT NULL,
Id_Usuario numeric(18,0) NOT NULL,
Habilitada bit DEFAULT 1,);
ALTER TABLE REZAGADOS.Administrador ADD CONSTRAINT PK_Id_Administrador PRIMARY KEY (Id_Administrador);

CREATE TABLE REZAGADOS.Cliente (
Id_Cliente numeric(18, 0) IDENTITY(1,1) NOT NULL,
Id_Usuario numeric(18,0),
Nombre varchar(255),
Apellido varchar(255),
Id_Tipo_Documento numeric(18,0),
Nro_Documento numeric(18,0) UNIQUE,
Id_Pais numeric(18,0),
Direccion_Calle varchar(255),
Direccion_Numero_Calle numeric(18,0),
Direccion_Piso numeric(18,0),
Direccion_Departamento varchar(10),
Fecha_Nacimiento datetime,
Mail varchar(255) UNIQUE,
Localidad varchar(255),
Nacionalidad varchar(255),
Habilitada bit DEFAULT 1,);
ALTER TABLE REZAGADOS.Cliente ADD CONSTRAINT PK_Id_Cliente PRIMARY KEY (Id_Cliente);
				
CREATE TABLE REZAGADOS.TipoDocumento (
Id_Tipo_Documento numeric(18,0) NOT NULL,
Descripcion varchar(255) UNIQUE,);
ALTER TABLE REZAGADOS.TipoDocumento ADD CONSTRAINT PK_Id_Tipo_Documento PRIMARY KEY (Id_Tipo_Documento);

CREATE TABLE REZAGADOS.Pais (
Id_Pais numeric(18,0) NOT NULL,
Descripcion varchar(250) UNIQUE,);
ALTER TABLE REZAGADOS.Pais ADD CONSTRAINT PK_Id_Pais PRIMARY KEY (Id_Pais);

CREATE TABLE REZAGADOS.Cuenta (
Id_Cuenta numeric (18,0) NOT NULL,
Id_Usuario numeric(18,0) NOT NULL,
Id_Pais numeric(18,0),
Id_Tipo_Cuenta numeric (18,0),
Id_Moneda numeric (18,0) DEFAULT 1,
Estado varchar(255),
Fecha_Creacion datetime,
Fecha_Cierre datetime,
Saldo numeric (18,0) DEFAULT 0,);
ALTER TABLE REZAGADOS.Cuenta ADD CONSTRAINT PK_Id_Cuenta PRIMARY KEY (Id_Cuenta);

CREATE TABLE REZAGADOS.TipoCuenta (
Id_Tipo_Cuenta numeric (18,0) IDENTITY(1,1) NOT NULL,
Categoria varchar(255),
Costo numeric (18,0),
Dias_Vigencia numeric (18,0),);
ALTER TABLE REZAGADOS.TipoCuenta ADD CONSTRAINT PK_Id_Tipo_Cuenta PRIMARY KEY (Id_Tipo_Cuenta);

CREATE TABLE REZAGADOS.Moneda (
Id_Moneda numeric (18,0) IDENTITY(1,1) NOT NULL,
Descripcion  varchar(255),);
ALTER TABLE REZAGADOS.Moneda ADD CONSTRAINT PK_Id_Moneda PRIMARY KEY (Id_Moneda);

CREATE TABLE REZAGADOS.HistorialCuenta(
Id_Historial_Cuenta numeric (18,0) IDENTITY(1,1) NOT NULL,
Id_Cuenta numeric (18,0),
Fecha datetime,
Estado varchar(255),);
ALTER TABLE REZAGADOS.HistorialCuenta ADD CONSTRAINT PK_Id_Historial_Cuenta PRIMARY KEY (Id_Historial_Cuenta);

CREATE TABLE REZAGADOS.Deposito (
Id_Deposito numeric (18,0) IDENTITY (1,1) NOT NULL,
Codigo numeric (18,0),
Id_Cuenta numeric (18,0) NOT NULL,
Id_Tarjeta  numeric (18,0) NOT NULL,
Id_Pais numeric(18,0),
Id_Moneda numeric (18,0) DEFAULT 1,
Fecha datetime,
Importe numeric (18,2),);
ALTER TABLE REZAGADOS.Deposito ADD CONSTRAINT PK_Id_Deposito PRIMARY KEY (Id_Deposito);

CREATE TABLE REZAGADOS.Tarjeta (
Id_Tarjeta numeric (18,0) IDENTITY (1,1) NOT NULL,
Id_Usuario numeric(18,0) NOT NULL,
Numero varchar(255) NOT NULL,
Tipo varchar(255) NOT NULL, 
Codigo_Seguridad varchar(255) NOT NULL,
Fecha_Emision datetime,
Vencimiento datetime,
Habilitada bit DEFAULT 1,);
ALTER TABLE REZAGADOS.Tarjeta ADD CONSTRAINT PK_Id_Tarjeta PRIMARY KEY (Id_Tarjeta);

CREATE TABLE REZAGADOS.Transferencia ( 
Id_Transferencia numeric (18,0) IDENTITY (1,1) NOT NULL,
Id_Cuenta_Emi numeric (18,0) NOT NULL,
Id_Cuenta_Dest numeric (18,0) NOT NULL,
Fecha datetime,
Id_Moneda numeric (18,0) DEFAULT 1,
Importe numeric(18,2) NOT NULL,);
ALTER TABLE REZAGADOS.Transferencia ADD CONSTRAINT PK_Id_Transferencia PRIMARY KEY (Id_Transferencia);

CREATE TABLE REZAGADOS.Retiro ( 
Id_Retiro numeric (18,0) NOT NULL,
Id_Cuenta numeric (18,0) NOT NULL,
Fecha datetime,
Id_Moneda numeric (18,0) DEFAULT 1,
Importe numeric(18,2) NOT NULL,);
ALTER TABLE REZAGADOS.Retiro ADD CONSTRAINT PK_Id_Retiro PRIMARY KEY (Id_Retiro);

CREATE TABLE REZAGADOS.Cheque ( 
Id_Cheque numeric (18,0) NOT NULL,
Id_Retiro numeric (18,0) NOT NULL,
Id_Banco numeric (18,0) NOT NULL,
Fecha datetime,
Id_Moneda numeric (18,0) DEFAULT 1,
Importe numeric(18,2) NOT NULL,
Num_Egreso numeric(18,2),
Num_Item numeric(18,2),);
ALTER TABLE REZAGADOS.Cheque ADD CONSTRAINT PK_Id_Cheque PRIMARY KEY (Id_Cheque);

CREATE TABLE REZAGADOS.Banco ( 
Id_Banco numeric (18,0) NOT NULL,
Nombre varchar(255),
Direccion varchar(255) NOT NULL,);
ALTER TABLE REZAGADOS.Banco ADD CONSTRAINT PK_Id_Banco PRIMARY KEY (Id_Banco);

CREATE TABLE REZAGADOS.Item (
Id_Item numeric(18,0) IDENTITY(1,1) NOT NULL,
Id_Factura numeric(18,0) NOT NULL,
Id_Cuenta numeric(18,0),
Id_Tipo_Item numeric(18,0),
Importe numeric(18,2) NOT NULL, 
Fecha datetime,
Habilitada bit DEFAULT 1,);
ALTER TABLE REZAGADOS.Item ADD CONSTRAINT PK_Id_Item PRIMARY KEY (Id_Item);

CREATE TABLE REZAGADOS.TipoItem(
Id_Tipo_Item numeric(18,0) IDENTITY(1,1) NOT NULL,
Tipo varchar(255),
Importe numeric(18,0) DEFAULT 0,);
ALTER TABLE REZAGADOS.TipoItem ADD CONSTRAINT PK_Id_Tipo_Item PRIMARY KEY (Id_Tipo_Item);

CREATE TABLE REZAGADOS.Factura (
Id_Factura numeric(18,0) NOT NULL,
Id_Usuario numeric(18,0) NOT NULL,
Fecha datetime NOT NULL,);
ALTER TABLE REZAGADOS.Factura ADD CONSTRAINT PK_Id_Factura PRIMARY KEY (Id_Factura);

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
------------------------------------CREAR FKS----------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

ALTER TABLE REZAGADOS.FuncionalidadXRol ADD CONSTRAINT FK_FuncionalidadXRol_to_Rol
FOREIGN KEY (Id_Rol) REFERENCES REZAGADOS.Rol (Id_Rol)
;
ALTER TABLE REZAGADOS.FuncionalidadXRol ADD CONSTRAINT FK_FuncionalidadXRol_to_Funcionalidad
FOREIGN KEY (Id_Funcionalidad) REFERENCES REZAGADOS.Funcionalidad (Id_Funcionalidad)
;
ALTER TABLE REZAGADOS.UsuarioXRol ADD CONSTRAINT FK_UsuarioXRol_to_Rol
FOREIGN KEY (Id_Rol) REFERENCES REZAGADOS.Rol (Id_Rol)
;
ALTER TABLE REZAGADOS.UsuarioXRol ADD CONSTRAINT FK_UsuarioXRol_to_Usuario
FOREIGN KEY (Id_Usuario) REFERENCES REZAGADOS.Usuario (Id_Usuario)
;
ALTER TABLE REZAGADOS.Administrador ADD CONSTRAINT FK_Administrador_to_Usuario
FOREIGN KEY (Id_Usuario) REFERENCES REZAGADOS.Usuario (Id_Usuario)
;
ALTER TABLE REZAGADOS.Cliente ADD CONSTRAINT FK_Cliente_to_Usuario
FOREIGN KEY (Id_Usuario) REFERENCES REZAGADOS.Usuario (Id_Usuario)
;
ALTER TABLE REZAGADOS.Cliente ADD CONSTRAINT FK_Cliente_to_TipoDocumento
FOREIGN KEY (Id_Tipo_Documento) REFERENCES REZAGADOS.TipoDocumento (Id_Tipo_Documento)
;
ALTER TABLE REZAGADOS.Cliente ADD CONSTRAINT FK_Cliente_to_Pais
FOREIGN KEY (Id_Pais) REFERENCES REZAGADOS.Pais (Id_Pais)
;
ALTER TABLE REZAGADOS.Cuenta ADD CONSTRAINT FK_Cuenta_to_Usuario
FOREIGN KEY (Id_Usuario) REFERENCES REZAGADOS.Usuario (Id_Usuario)
;
ALTER TABLE REZAGADOS.Cuenta ADD CONSTRAINT FK_Cuenta_to_TipoCuenta
FOREIGN KEY (Id_Tipo_Cuenta) REFERENCES REZAGADOS.TipoCuenta (Id_Tipo_Cuenta)
;
ALTER TABLE REZAGADOS.Cuenta ADD CONSTRAINT FK_Cuenta_to_Pais
FOREIGN KEY (Id_Pais) REFERENCES REZAGADOS.Pais (Id_Pais)
;
ALTER TABLE REZAGADOS.Cuenta ADD CONSTRAINT FK_Cuenta_to_Moneda
FOREIGN KEY (Id_Moneda) REFERENCES REZAGADOS.Moneda (Id_Moneda)
;
ALTER TABLE REZAGADOS.HistorialCuenta ADD CONSTRAINT FK_Historial_Cuenta_to_Cuenta
FOREIGN KEY (Id_Cuenta) REFERENCES REZAGADOS.Cuenta (Id_Cuenta)
;
ALTER TABLE REZAGADOS.Deposito ADD CONSTRAINT FK_Deposito_to_Cuenta
FOREIGN KEY (Id_Cuenta) REFERENCES REZAGADOS.Cuenta (Id_Cuenta)
;
ALTER TABLE REZAGADOS.Deposito ADD CONSTRAINT FK_Deposito_to_Pais
FOREIGN KEY (Id_Pais) REFERENCES REZAGADOS.Pais (Id_Pais)
;
ALTER TABLE REZAGADOS.Deposito ADD CONSTRAINT FK_Deposito_to_Tarjeta
FOREIGN KEY (Id_Tarjeta) REFERENCES REZAGADOS.Tarjeta (Id_Tarjeta)
;
ALTER TABLE REZAGADOS.Deposito ADD CONSTRAINT FK_Deposito_to_Moneda
FOREIGN KEY (Id_Moneda) REFERENCES REZAGADOS.Moneda (Id_Moneda)
;
ALTER TABLE REZAGADOS.Tarjeta ADD CONSTRAINT FK_Tarjeta_to_Usuario
FOREIGN KEY (Id_Usuario) REFERENCES REZAGADOS.Usuario (Id_Usuario)
;
ALTER TABLE REZAGADOS.Transferencia ADD CONSTRAINT FK_Transferencia_to_Cuenta_Emi
FOREIGN KEY (Id_Cuenta_Emi) REFERENCES REZAGADOS.Cuenta (Id_Cuenta)
;
ALTER TABLE REZAGADOS.Transferencia ADD CONSTRAINT FK_Transferencia_to_Cuenta_Dest
FOREIGN KEY (Id_Cuenta_Dest) REFERENCES REZAGADOS.Cuenta (Id_Cuenta)
;
ALTER TABLE REZAGADOS.Retiro ADD CONSTRAINT FK_Retiro_to_Cuenta
FOREIGN KEY (Id_Cuenta) REFERENCES REZAGADOS.Cuenta (Id_Cuenta)
;
ALTER TABLE REZAGADOS.Retiro ADD CONSTRAINT FK_Retiro_to_Moneda
FOREIGN KEY (Id_Moneda) REFERENCES REZAGADOS.Moneda (Id_Moneda)
;
ALTER TABLE REZAGADOS.Cheque ADD CONSTRAINT FK_Cheque_to_Retiro
FOREIGN KEY (Id_Retiro) REFERENCES REZAGADOS.Retiro (Id_Retiro)
;
ALTER TABLE REZAGADOS.Cheque ADD CONSTRAINT FK_Cheque_to_Banco
FOREIGN KEY (Id_Banco) REFERENCES REZAGADOS.Banco (Id_Banco)
;
ALTER TABLE REZAGADOS.Cheque ADD CONSTRAINT FK_Cheque_to_Moneda
FOREIGN KEY (Id_Moneda) REFERENCES REZAGADOS.Moneda (Id_Moneda)
;
ALTER TABLE REZAGADOS.Item ADD CONSTRAINT FK_Item_to_Factura
FOREIGN KEY (Id_Factura) REFERENCES REZAGADOS.Factura (Id_Factura)
;
ALTER TABLE REZAGADOS.Item ADD CONSTRAINT FK_Item_to_Tipo_Item
FOREIGN KEY (Id_Tipo_Item) REFERENCES REZAGADOS.TipoItem (Id_Tipo_Item)
;
ALTER TABLE REZAGADOS.Item ADD CONSTRAINT FK_Item_to_Cuenta
FOREIGN KEY (Id_Cuenta) REFERENCES REZAGADOS.Cuenta (Id_Cuenta)
;
ALTER TABLE REZAGADOS.Factura ADD CONSTRAINT FK_Factura_to_Usuario
FOREIGN KEY (Id_Usuario) REFERENCES REZAGADOS.Usuario (Id_Usuario)
;
ALTER TABLE REZAGADOS.HistorialUsuario ADD CONSTRAINT FK_Historial_Usuario_to_Usuario
FOREIGN KEY (Id_Usuario) REFERENCES REZAGADOS.Usuario (Id_Usuario)
;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
------------------------------------MIGRACION----------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

DECLARE @fecha datetime
SET @fecha = getdate()

---------------------------------------PAIS------------------------------------------

INSERT INTO REZAGADOS.Pais (Id_Pais, Descripcion)(
SELECT Cli_Pais_Codigo, Cli_Pais_Desc
FROM gd_esquema.Maestra
GROUP BY Cli_Pais_Codigo, Cli_Pais_Desc
UNION
SELECT Cuenta_Dest_Pais_Codigo, Cuenta_Dest_Pais_Desc
FROM gd_esquema.Maestra
WHERE Cuenta_Dest_Pais_Codigo IS NOT NULL
GROUP BY Cuenta_Dest_Pais_Codigo, Cuenta_Dest_Pais_Desc
UNION
SELECT Cuenta_Pais_Codigo, Cuenta_Pais_Desc
FROM gd_esquema.Maestra
GROUP BY Cuenta_Pais_Codigo, Cuenta_Pais_Desc
)

--------------------------------------TIPODOCUMENTO--------------------------------------------

INSERT INTO REZAGADOS.TipoDocumento (Id_Tipo_Documento, Descripcion) (
SELECT Cli_Tipo_Doc_Cod, Cli_Tipo_Doc_Desc
FROM gd_esquema.Maestra
GROUP BY Cli_Tipo_Doc_Cod, Cli_Tipo_Doc_Desc
)

-------------------------------------------ROL--------------------------------------------------

INSERT INTO REZAGADOS.Rol (Nombre)
VALUES ('Administrador'),('Cliente')

--------------------------------------FUNCIONALIDAD---------------------------------------------

INSERT INTO REZAGADOS.Funcionalidad (Nombre)
VALUES ('ABM de Rol'), ('Registro de Usuario'), ('ABM de Cliente'), ('ABM de Cuenta'), ('Deposito'), ('Retiro de Efectivo'), ('Transferencias entre cuentas'), ('Facturación de Costos'), ('Consulta de saldos'), ('Listado Estadístico')

-------------------------------------ROLXFUNCIONALIDAD------------------------------------------

INSERT INTO REZAGADOS.FuncionalidadXRol (Id_Rol,Id_Funcionalidad)
SELECT R.Id_Rol, F.Id_Funcionalidad
FROM REZAGADOS.Rol R, REZAGADOS.Funcionalidad F
WHERE R.Nombre = 'Administrador'
UNION
SELECT R.Id_Rol, F.Id_Funcionalidad
FROM REZAGADOS.Rol R, REZAGADOS.Funcionalidad F
WHERE	R.Nombre = 'Cliente' AND
		F.Nombre IN ('ABM de Cliente', 'ABM de Cuenta', 'Deposito', 'Retiro de Efectivo', 'Transferencias entre cuentas', 'Facturación de Costos', 'Consulta de saldos')

------------------------------------------USUARIO--------------------------------------------------
---------------------------------EL-USERNAME-SERA-EL-MAIL------------------------------------------
----------------------LA-PASS-SERA-REZAGADOS-ENCRIPTADA-EN-SHA-256---------------------------------

INSERT INTO REZAGADOS.Usuario (Nombre, Contrasenia, Fecha_Creacion, Fecha_Ult_Modif)
SELECT DISTINCT Cli_Mail, 'd19501ed8c9de057fe8370035686d5e7a9686c2fddb68b57e1668e21917b3e87', @fecha, @fecha
FROM gd_esquema.Maestra
WHERE Cli_Mail IS NOT NULL

INSERT INTO REZAGADOS.Usuario (Nombre, Contrasenia, Fecha_Creacion, Fecha_Ult_Modif)
VALUES ('admin','e6b87050bfcb8143fcb8db0170a4dc9ed00d904ddd3e2a4ad1b1e8dc0fdc9be7', @fecha, @fecha)

----------------------------------------ADMINISTRADOR-----------------------------------------------

INSERT INTO REZAGADOS.Administrador(Id_Usuario)
SELECT DISTINCT Id_Usuario
FROM REZAGADOS.Usuario
WHERE Nombre = 'admin' 

-----------------------------------------CLIENTE-------------------------------------------------

INSERT INTO REZAGADOS.Cliente (Id_Usuario, Nombre, Apellido, Id_Tipo_Documento, Nro_Documento, Id_Pais, Direccion_Calle, Direccion_Numero_Calle, Direccion_Piso, Direccion_Departamento, Fecha_Nacimiento, Mail, Localidad, Nacionalidad)
(
SELECT U.Id_Usuario, G.Cli_Nombre, G.Cli_Apellido,T.Id_Tipo_Documento, G.Cli_Nro_Doc, P.Id_Pais, G.Cli_Dom_Calle, G.Cli_Dom_Nro, G.Cli_Dom_Piso, G.Cli_Dom_Depto, G.Cli_Fecha_Nac, G.Cli_Mail, 'Capital Federal', 'Argentina'
FROM REZAGADOS.Usuario U, gd_esquema.Maestra G, REZAGADOS.TipoDocumento T, REZAGADOS.Pais P
WHERE U.Nombre = G.Cli_Mail AND P.Id_Pais = G.Cli_Pais_Codigo AND T.Id_Tipo_Documento = G.Cli_Tipo_Doc_Cod
GROUP BY U.Id_Usuario, G.Cli_Nombre, G.Cli_Apellido,T.Id_Tipo_Documento, G.Cli_Nro_Doc, P.Id_Pais, G.Cli_Dom_Calle, G.Cli_Dom_Nro, G.Cli_Dom_Piso, G.Cli_Dom_Depto, G.Cli_Fecha_Nac, G.Cli_Mail
)

-----------------------------------------USUARIOXROL--------------------------------------------------

INSERT INTO REZAGADOS.UsuarioXRol(Id_Usuario,Id_Rol)
SELECT C.Id_Usuario, R.Id_Rol 
FROM REZAGADOS.Cliente C, REZAGADOS.Rol R
WHERE R.Nombre = 'Cliente'
UNION
SELECT A.Id_Usuario, R.Id_Rol 
FROM REZAGADOS.Administrador A, REZAGADOS.Rol R
WHERE R.Nombre = 'Administrador' 

-----------------------------------------MONEDA---------------------------------------------------

INSERT INTO REZAGADOS.Moneda (Descripcion)
VALUES ('Dolar')

------------------------------------------BANCO---------------------------------------------------

INSERT INTO REZAGADOS.Banco (Id_Banco, Nombre, Direccion)
SELECT Banco_Cogido, Banco_Nombre, Banco_Direccion
FROM gd_esquema.Maestra
WHERE Banco_Cogido IS NOT NULL
GROUP BY Banco_Cogido, Banco_Nombre, Banco_Direccion

-----------------------------------------CUENTA---------------------------------------------------

INSERT INTO REZAGADOS.Cuenta (Id_Cuenta, Id_Usuario, Id_Pais, Estado, Fecha_Creacion, Fecha_Cierre)
SELECT g.Cuenta_Numero, u.Id_Usuario, g.Cuenta_Pais_Codigo, g.Cuenta_Estado, g.Cuenta_Fecha_Creacion, g.Cuenta_Fecha_Cierre
FROM gd_esquema.Maestra g, REZAGADOS.Usuario u
WHERE u.Nombre = g.Cli_Mail AND g.Cuenta_Dest_Fecha_Creacion IS NOT NULL
GROUP BY g.Cuenta_Numero, u.Id_Usuario, g.Cuenta_Pais_Codigo, g.Cuenta_Estado, g.Cuenta_Fecha_Creacion, g.Cuenta_Fecha_Cierre

-----------------------------------------TARJETA--------------------------------------------------

INSERT INTO REZAGADOS.Tarjeta (Id_Usuario, Numero, Tipo, Codigo_Seguridad, Fecha_Emision, Vencimiento)
SELECT u.Id_Usuario, Tarjeta_Numero, Tarjeta_Emisor_Descripcion, Tarjeta_Codigo_Seg, Tarjeta_Fecha_Emision, Tarjeta_Fecha_Vencimiento
FROM gd_esquema.Maestra g, REZAGADOS.Usuario u
WHERE Tarjeta_Numero IS NOT NULL  AND u.Nombre = g.Cli_Mail
GROUP BY u.Id_Usuario, Tarjeta_Numero, Tarjeta_Emisor_Descripcion, Tarjeta_Codigo_Seg, Tarjeta_Fecha_Emision, Tarjeta_Fecha_Vencimiento

----------------------------------------TIPOCUENTA------------------------------------------------

INSERT INTO REZAGADOS.TipoCuenta (Categoria, Costo, Dias_Vigencia)
VALUES ('Oro', 10, 10), ('Plata', 5, 20), ('Bronce', 5, 30), ('Gratis', 0, 0)

--------------------------------------------TIPOITEM-----------------------------------------------

INSERT INTO REZAGADOS.TipoItem (Tipo)
VALUES ('Comisión por transferencia.'), ('Creacion de cuenta'), ('Retiro'), ('Cheque')

------------------------------------------FACUTRA--------------------------------------------------

INSERT INTO REZAGADOS.Factura (Id_Factura, Id_Usuario, Fecha)
SELECT g.Factura_Numero, u.Id_Usuario, g.Factura_Fecha
FROM gd_esquema.Maestra g, REZAGADOS.Usuario u
WHERE u.Nombre = g.Cli_Mail AND g.Factura_Numero IS NOT NULL
GROUP BY g.Factura_Numero, u.Id_Usuario, g.Factura_Fecha
--FIJARSE ERROR SIN GROUP BY
--------------------------------------------ITEM----------------------------------------------------

INSERT INTO REZAGADOS.Item (Id_Factura, Id_Cuenta, Id_Tipo_Item, Importe, Fecha)
SELECT f.Id_Factura, c.Id_Cuenta, t.Id_Tipo_Item, g.Trans_Importe, g.Transf_Fecha
FROM gd_esquema.Maestra g, REZAGADOS.Factura f, REZAGADOS.Usuario u, REZAGADOS.Cuenta c, REZAGADOS.TipoItem t
WHERE f.Id_Factura = g.Factura_Numero AND u.Nombre = g.Cli_Mail AND c.Id_Usuario = u.Id_Usuario AND t.Tipo = g.Item_Factura_Descr

--------------------------------------------RETIRO----------------------------------------------------

INSERT INTO REZAGADOS.Retiro (Id_Retiro, Id_Cuenta, Fecha, Importe)
SELECT g.Retiro_Codigo, c.Id_Cuenta, g.Retiro_Fecha, g.Retiro_Importe
FROM gd_esquema.Maestra g, REZAGADOS.Cuenta c
WHERE g.Retiro_Codigo IS NOT NULL AND c.Id_Cuenta = g.Cuenta_Numero
GROUP BY g.Retiro_Codigo, c.Id_Cuenta, g.Retiro_Fecha, g.Retiro_Importe
--ERROR GROUP
----------------------------------------TRANSFERENCIA-------------------------------------------------

INSERT INTO REZAGADOS.Transferencia (Id_Cuenta_Emi, Id_Cuenta_Dest, Fecha, Importe)
SELECT Cuenta_Numero, Cuenta_Dest_Numero, Transf_Fecha, Trans_Importe
FROM gd_esquema.Maestra
WHERE Cuenta_Dest_Numero IS NOT NULL

-------------------------------------------DEPOSITO---------------------------------------------------

INSERT INTO REZAGADOS.Deposito (Codigo, Id_Cuenta, Id_Tarjeta, Id_Pais, Fecha, Importe)
SELECT g.Deposito_Codigo, g.Cuenta_Numero, t.Id_Tarjeta, g.Cuenta_Pais_Codigo, g.Deposito_Fecha, g.Deposito_Importe
FROM gd_esquema.Maestra g, REZAGADOS.Usuario u, REZAGADOS.Tarjeta t
WHERE g.Deposito_Codigo IS NOT NULL AND u.Nombre = g.Cli_Mail AND t.Id_Usuario = u.Id_Usuario
GROUP BY g.Deposito_Codigo, g.Cuenta_Numero, t.Id_Tarjeta, g.Cuenta_Pais_Codigo, g.Deposito_Fecha, g.Deposito_Importe

--------------------------------------------CHEQUE----------------------------------------------------

INSERT INTO REZAGADOS.Cheque (Id_Cheque, Id_Retiro, Id_Banco, Fecha, Importe)
SELECT Cheque_Numero, Retiro_Codigo, Banco_Cogido, Cheque_Fecha, Cheque_Importe
FROM gd_esquema.Maestra
WHERE Cheque_Numero IS NOT NULL
GROUP BY Cheque_Numero, Retiro_Codigo, Banco_Cogido, Cheque_Fecha, Cheque_Importe


--ERROR GROUP
----------------------------------------HISTORIALCUENTA-----------------------------------------------
----------------------------------------HISTORIALUSUARIO-----------------------------------------------

------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
--------------------------------------------PROCESOS--------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------

-----------------------------------------CREAR CLIENTE------------------------------------------------

USE [GD1C2015]
GO
CREATE PROCEDURE REZAGADOS.Crear_Cliente(
					@Nombre VARCHAR(255),
					@Apellido VARCHAR(255),
					@Tipo_Documento NUMERIC(18, 0),
					@Nro_Documento NUMERIC(18, 0),
					@Pais VARCHAR(255),
					@Direccion_Calle VARCHAR (255),
					@Direccion_Numero_Calle NUMERIC(18, 0),
					@Direccion_Piso NUMERIC(18,0),
					@Direccion_Departamento VARCHAR(10),
					@Fecha_Nacimiento DATETIME,
					@Mail VARCHAR(255),
					@Localidad VARCHAR(255),
					@Nacionalidad VARCHAR(255),
					@Username VARCHAR (255),
					@Password VARCHAR(255),
					@Resultado VARCHAR(255) OUTPUT)
AS 
BEGIN TRY
BEGIN TRANSACTION
BEGIN
IF (EXISTS(SELECT Mail FROM REZAGADOS.Cliente  WHERE @Mail = Mail) )
	BEGIN
	SET @Resultado = 'El e-mail ya existe.'
	END
ELSE
BEGIN
	INSERT INTO REZAGADOS.Usuario (Nombre, Contrasenia) VALUES (@Username, @Password)
	DECLARE @Id_Usuario NUMERIC(18,0)
	DECLARE @Id_Tipo_Documento NUMERIC(18,0)
	DECLARE @Id_Pais NUMERIC (18,0)
	SET @Id_Pais = (SELECT DISTINCT Id_Pais FROM REZAGADOS.Pais WHERE REZAGADOS.Pais.Descripcion = @Pais)
	SET @Id_Tipo_Documento = (SELECT DISTINCT Id_Tipo_Documento FROM REZAGADOS.TipoDocumento WHERE REZAGADOS.TipoDocumento.Descripcion = @Tipo_Documento)
	SET @Id_Usuario = (SELECT DISTINCT Id_Usuario FROM REZAGADOS.Usuario WHERE REZAGADOS.Usuario.Nombre = @Username)
	INSERT INTO REZAGADOS.Cliente (Id_Usuario, Nombre, Apellido, Id_Tipo_Documento, Nro_Documento, Id_Pais, Direccion_Calle, Direccion_Numero_Calle, Direccion_Piso, Direccion_Departamento, Fecha_Nacimiento, Mail, Localidad, Nacionalidad)
	VALUES (@Id_Usuario, @Nombre, @Apellido, @Id_Tipo_Documento, @Nro_Documento, @Id_Pais, @Direccion_Calle, @Direccion_Numero_Calle, @Direccion_Piso, @Direccion_Departamento, @Fecha_Nacimiento, @Mail, @Localidad, @Nacionalidad) 		
	INSERT INTO REZAGADOS.UsuarioXRol(Id_Usuario, Id_Rol) VALUES (@Id_Usuario, 2)			
	SET @Resultado = 'Los datos se guardaron exitosamente!'
	END
END
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH
GO

-----------------------------------------MODIFICAR CLIENTE------------------------------------------------

USE [GD1C2015]
GO
CREATE PROCEDURE REZAGADOS.Modificar_Cliente (
								@Id_Cliente NUMERIC(18,0),
								@Direccion_Calle VARCHAR (255),
								@Direccion_Numero_Calle NUMERIC(18, 0),
								@Direccion_Piso NUMERIC(18,0),
								@Direccion_Departamento VARCHAR(10),
								@Fecha_Nacimiento DATETIME,
								@Mail VARCHAR(255),
								@Localidad VARCHAR(255),
								@Nacionalidad VARCHAR(255),
								@Resultado VARCHAR(255) OUTPUT)
AS 
BEGIN
	IF (EXISTS(SELECT Mail FROM REZAGADOS.Cliente  WHERE @Mail = Mail) )
	BEGIN
	SET @Resultado = 'El e-mail ya existe.'
	END
ELSE
	BEGIN
	UPDATE REZAGADOS.Cliente
	SET
	[Direccion_Calle] = @Direccion_Calle,
	[Direccion_Numero_Calle] = @Direccion_Numero_Calle,
	[Direccion_Piso] = @Direccion_Piso,
	[Direccion_Departamento] = @Direccion_Departamento,
	[Fecha_Nacimiento] = @Fecha_Nacimiento,
	[Mail] = @Mail,
	[Localidad] = @Localidad,
	[Nacionalidad] = @Nacionalidad
	WHERE
   [Id_Cliente] = @Id_Cliente
  SET @Resultado = 'El cliente ha sido modificado!'
  END
END
GO

-----------------------------------------ELIMINAR CLIENTE------------------------------------------------

USE [GD1C2015]
GO
CREATE PROCEDURE REZAGADOS.Eliminar_Cliente  (@Id_Cliente NUMERIC(18,0))
AS
	BEGIN
		DECLARE @Id_Usuario NUMERIC(18,0) = (SELECT Id_Usuario FROM REZAGADOS.Cliente WHERE Id_Cliente = @Id_Cliente)
		UPDATE REZAGADOS.Cliente SET Habilitada=0 WHERE Id_Usuario=@Id_Usuario
	END
GO

-----------------------------------------ALTA USUARIO------------------------------------------------

USE [GD1C2015]
GO
CREATE PROCEDURE REZAGADOS.Alta_Usuario (@Nombre VARCHAR(255), @Respuesta VARCHAR(255) OUTPUT)
AS
	BEGIN
		DECLARE @Id_Usuario NUMERIC(18,0) = (SELECT Id_Usuario FROM REZAGADOS.Usuario WHERE Nombre = @Nombre)
		DECLARE @Contrasenia VARCHAR(255) = (SELECT Contrasenia FROM REZAGADOS.Usuario WHERE Nombre = @Nombre)
		UPDATE REZAGADOS.Usuario SET Habilitada=1 WHERE Id_Usuario=@Id_Usuario
		UPDATE REZAGADOS.Usuario SET Cantidad_Intentos_Fallidos = 0 WHERE Id_Usuario = @Id_Usuario
		SET @Respuesta = 'Usuario dado de alta, contraseña: ' + (@Contrasenia);
		END
GO

-----------------------------------------BAJA USUARIO------------------------------------------------

USE [GD1C2015]
GO
CREATE PROCEDURE REZAGADOS.Baja_Usuario (@Nombre varchar(255))
AS
	BEGIN
		DECLARE @Id_Usuario NUMERIC(18,0) = (SELECT Id_Usuario FROM REZAGADOS.Usuario WHERE Nombre = @Nombre)
		UPDATE REZAGADOS.Usuario SET Habilitada=0 WHERE Id_Usuario=@Id_Usuario
	END
GO

-----------------------------------------ALTA CLIENTE------------------------------------------------

USE [GD1C2015]
GO
CREATE PROCEDURE REZAGADOS.Alta_Cliente (@Id_Cliente varchar(255))
AS
	BEGIN
		DECLARE @Id_Usuario NUMERIC(18,0) = (SELECT Id_Usuario FROM REZAGADOS.Cliente WHERE Id_Cliente = CAST(@Id_Cliente AS NUMERIC(18,0)))
		UPDATE REZAGADOS.Cliente SET Habilitada=1 WHERE Id_Usuario=@Id_Usuario
	END
GO

-----------------------------------------BAJA CLIENTE------------------------------------------------

USE [GD1C2015]
GO
CREATE PROCEDURE REZAGADOS.Baja_Cliente (@Id_Cliente varchar(255))
AS
	BEGIN
		DECLARE @Id_Usuario NUMERIC(18,0) = (SELECT Id_Usuario FROM REZAGADOS.Cliente WHERE Id_Cliente = CAST(@Id_Cliente AS NUMERIC(18,0)))
		UPDATE REZAGADOS.Cliente SET Habilitada=0 WHERE Id_Usuario=@Id_Usuario
	END
GO

-----------------------------------------CREAR ROL------------------------------------------------

USE [GD1C2015]
GO
CREATE PROCEDURE REZAGADOS.Crear_Rol(@Nombre_Rol NVARCHAR(255), @Respuesta INT OUTPUT)
AS
BEGIN
	IF EXISTS(SELECT * FROM REZAGADOS.Rol WHERE Rol.Nombre = @Nombre_Rol)
	BEGIN
		SET @Respuesta = -1
	END
	ELSE
	BEGIN
		INSERT INTO REZAGADOS.Rol VALUES (@Nombre_Rol, 1)
		SET @Respuesta = (SELECT Id_Rol FROM REZAGADOS.Rol WHERE Rol.Nombre = @Nombre_Rol)
	END
END
GO

-----------------------------------------BORRAR ROL------------------------------------------------

USE [GD1C2015]
GO
CREATE PROCEDURE REZAGADOS.Borrar_Rol(@Nombre_Rol NVARCHAR(255), @Respuesta INT OUTPUT)
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM REZAGADOS.Rol WHERE Rol.Nombre = @Nombre_Rol)
	BEGIN
		SET @Respuesta = -1
	END
	ELSE
	BEGIN
		DELETE FROM REZAGADOS.Rol WHERE Nombre=@Nombre_Rol
		SET @Respuesta = 1
	END
END
GO

-----------------------------------------LOGIN------------------------------------------------

USE [GD1C2015]
GO
CREATE PROCEDURE REZAGADOS.Login (@Usuario NVARCHAR(255), @Pass NVARCHAR(255), @Respuesta NVARCHAR(255) OUTPUT, @Respuesta_Contra NVARCHAR(255) OUTPUT)
AS 
BEGIN                  
DECLARE @Existe_Usuario INT = (SELECT COUNT(*) FROM REZAGADOS.Usuario WHERE Nombre = @Usuario);                                     
IF (@Existe_Usuario = 1)
BEGIN             
DECLARE @Habilitado INT = (SELECT COUNT(*) FROM REZAGADOS.Usuario WHERE Nombre = @Usuario AND Habilitada = 1);
IF(@Habilitado = 1)
	BEGIN                            
	DECLARE @Cantidad_Intentos_Fallidos INT = (SELECT Cantidad_Intentos_Fallidos FROM REZAGADOS.Usuario WHERE Nombre = @Usuario); 
	IF (@Cantidad_Intentos_Fallidos < 3)
	BEGIN
		DECLARE @Existe_Usuario_Contrasenia INT = (SELECT COUNT(*) FROM REZAGADOS.Usuario WHERE Nombre = @Usuario and Contrasenia = @Pass);
		IF (@Existe_Usuario_Contrasenia = 1)
		BEGIN
			UPDATE REZAGADOS.Usuario SET Cantidad_Intentos_Fallidos=0 WHERE Nombre = @Usuario;
			DECLARE @Existe_Rol INT = (SELECT COUNT(R.Id_Rol) FROM REZAGADOS.Usuario U, REZAGADOS.UsuarioXRol R WHERE U.Nombre = @Usuario AND U.Id_Usuario = R.Id_Usuario)				
			IF (@Existe_Rol = 0)
			SET @Respuesta = 'El usuario no tiene asignado un rol, o el rol ha sido inhabilitado'
			ELSE								
			SET @Respuesta = 'Abrir Sesion'
		END
		ELSE
		BEGIN
		UPDATE REZAGADOS.Usuario SET Cantidad_Intentos_Fallidos=(Cantidad_Intentos_Fallidos+1) WHERE Nombre = @Usuario;
		SET @Cantidad_Intentos_Fallidos = (@Cantidad_Intentos_Fallidos + 1);
		DECLARE @Cantidad_Intentos_Fallidos_String NVARCHAR(255) = @Cantidad_Intentos_Fallidos;
		SET @Respuesta = 'Contraseña incorrecta, vuelva a intentarlo. Cantidad de intentos fallidos: ' + (@Cantidad_Intentos_Fallidos_String);
		END
	END
	ELSE
		BEGIN
		DECLARE @Id_User NUMERIC(18,0) = (SELECT Id_Usuario FROM REZAGADOS.Usuario WHERE Nombre = @Usuario)
		UPDATE REZAGADOS.Usuario SET Habilitada = 0 WHERE @Id_User = Id_Usuario
		SET @Respuesta = 'Su usuario esta bloqueado, por sobrepasar la cantidad de logueos incorrectos';
		END  
	END
	ELSE
	SET @Respuesta = 'El Usuario se encuentra inhabilitado'
END
ELSE 
SET @Respuesta = 'No existe el usuario, vuelva a intentarlo';                              
END
GO

-----------------------------------------CAMBIO CONTRASEÑA------------------------------------------------

USE [GD1C2015]
GO
CREATE PROCEDURE REZAGADOS.Cambio_Contrasenia (@Id_Usuario NUMERIC(18,0), @ContraseniaNueva VARCHAR(255), @Respuesta VARCHAR(255) OUTPUT)
AS
BEGIN
	UPDATE REZAGADOS.Usuario SET Contrasenia = @ContraseniaNueva	WHERE Id_Usuario = @Id_Usuario;
	UPDATE REZAGADOS.Usuario SET Contrasenia_Modificada = 1 WHERE Id_Usuario = @Id_Usuario;
	SET @Respuesta = 'Contraseña cambiada correctamente!'
END
GO

-----------------------------------------BAJA ROL------------------------------------------------

USE [GD1C2015]
GO
CREATE PROCEDURE REZAGADOS.Baja_Rol(@Nombre_Rol varchar(255))
AS
BEGIN
UPDATE REZAGADOS.Rol SET Habilitada=0 WHERE Nombre = @Nombre_Rol
DECLARE @Codigo_Rol INT = (SELECT Id_Rol FROM REZAGADOS.ROL WHERE Nombre = @Nombre_Rol)
DELETE FROM REZAGADOS.UsuarioXRol WHERE Id_Rol = @Codigo_Rol
END
GO

-----------------------------------------ALTA ROL------------------------------------------------

USE [GD1C2015]
GO
CREATE PROCEDURE REZAGADOS.Alta_Rol(@Nombre_Rol VARCHAR(255))
AS
BEGIN
UPDATE REZAGADOS.Rol SET Habilitada=1 WHERE Nombre = @Nombre_Rol
END
GO

-----------------------------------------MODIFICAR NOMBRE ROL------------------------------------------------

USE [GD1C2015]
GO
CREATE PROCEDURE REZAGADOS.Modificar_Nombre_Rol(@Nombre_Rol VARCHAR(255), @Nombre_Viejo VARCHAR(255))
AS
BEGIN
UPDATE REZAGADOS.Rol SET Nombre = @Nombre_Rol WHERE Nombre = @Nombre_Viejo
END
GO

-----------------------------------------MODIFICAR FUNCIONALIDAD--------------------------------------------

USE [GD1C2015]
GO
CREATE PROCEDURE REZAGADOS.Modificar_Funcionalidad(@Nombre_Func VARCHAR(255),@Nombre_Viejo VARCHAR(255))
AS
BEGIN
UPDATE REZAGADOS.Funcionalidad SET Nombre = @Nombre_Func WHERE Nombre = @Nombre_Viejo
END
GO

-----------------------------------------BAJA FUNCIONALIDAD------------------------------------------------

USE [GD1C2015]
GO
CREATE PROCEDURE REZAGADOS.Baja_Funcionalidad(@Nombre_Func VARCHAR(255), @Nombre_Rol VARCHAR(255))
AS
BEGIN TRY
BEGIN TRANSACTION
	BEGIN	
		DELETE FROM REZAGADOS.FuncionalidadXRol WHERE Id_Rol= (SELECT Id_Rol FROM REZAGADOS.Rol WHERE Nombre = @Nombre_Rol)  AND Id_Funcionalidad = (SELECT Id_Funcionalidad FROM REZAGADOS.Funcionalidad WHERE Nombre = @Nombre_Func) 
	END
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH
GO

-----------------------------------------DESASIGNAR ROL------------------------------------------------

USE [GD1C2015]
GO
CREATE PROCEDURE REZAGADOS.Desasignar_Rol(@Nombre_Usuario VARCHAR(255), @Nombre_Rol VARCHAR(255))
AS
BEGIN TRY
BEGIN TRANSACTION
	BEGIN
		DELETE FROM REZAGADOS.UsuarioXRol WHERE Id_Rol= (SELECT Id_Rol FROM REZAGADOS.Rol WHERE Nombre = @Nombre_Rol)  AND Id_Usuario = (SELECT Id_Usuario from REZAGADOS.Usuario WHERE Nombre = @Nombre_Usuario) 
	END
COMMIT TRANSACTION
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
END CATCH
GO

-----------------------------------------AGREGAR FUNCIONALIDAD------------------------------------------------

USE [GD1C2015]
GO
CREATE PROCEDURE REZAGADOS.Agregar_Funcionalidad (@Nombre_Rol VARCHAR(255), @Nombre_Func VARCHAR(255))
AS 
Begin 
BEGIN TRY
BEGIN TRANSACTION      
	INSERT INTO REZAGADOS.FuncionalidadXRol(Id_Rol,Id_Funcionalidad) values ((SELECT Id_Rol from REZAGADOS.Rol WHERE Nombre = @Nombre_Rol),(SELECT Id_Funcionalidad FROM REZAGADOS.Funcionalidad WHERE Nombre = @Nombre_Func))
 COMMIT TRANSACTION
 END TRY
 BEGIN CATCH
 ROLLBACK TRANSACTION
 END CATCH  
 END
 GO

-----------------------------------------ASIGNAR ROL------------------------------------------------

USE [GD1C2015]
GO
CREATE PROCEDURE REZAGADOS.Asignar_Rol (@Nombre_Usuario VARCHAR(255), @Nombre_Rol VARCHAR(255))
AS 
BEGIN 
BEGIN TRY
BEGIN TRANSACTION      
    INSERT INTO REZAGADOS.UsuarioXRol(Id_Usuario,Id_Rol) values ((SELECT Id_Usuario from REZAGADOS.Usuario WHERE Nombre = @Nombre_Usuario),(SELECT Id_Rol from REZAGADOS.Rol WHERE Nombre = @Nombre_Rol))
COMMIT TRANSACTION
END TRY
BEGIN CATCH 
ROLLBACK TRANSACTION
END CATCH   
END
GO

-----------------------------------------BAJA CUENTA------------------------------------------------

USE [GD1C2015]
GO
CREATE PROCEDURE REZAGADOS.Baja_Cuenta(@Nro_Cuenta VARCHAR(255))
AS
BEGIN
UPDATE REZAGADOS.Cuenta SET Estado='Inhabilitado' WHERE Cuenta.Id_Cuenta = @Nro_Cuenta
END
GO

-----------------------------------------ALTA ROL------------------------------------------------

USE [GD1C2015]
GO
CREATE PROCEDURE REZAGADOS.Alta_Cuenta(@Nro_Cuenta VARCHAR(255))
AS
BEGIN
UPDATE REZAGADOS.Cuenta SET Estado='Habilitado' WHERE Cuenta.Id_Cuenta = @Nro_Cuenta
END
GO

----------------------------------------CREAR CUENTA------------------------------------------------

USE [GD1C2015]
GO
CREATE PROCEDURE REZAGADOS.Crear_Cuenta(@Id_Cuenta NUMERIC(18,0), @Id_Usuario NUMERIC(18,0), @Pais VARCHAR(255), @Moneda VARCHAR(255), @Fecha DATETIME, @Tipo VARCHAR(255))
AS
BEGIN
IF NOT EXISTS (SELECT COUNT(*) FROM REZAGADOS.Cuenta WHERE Id_Cuenta=@Id_Cuenta)
BEGIN
INSERT INTO REZAGADOS.Cuenta(Id_Cuenta, Id_Usuario, Id_Pais, Id_Tipo_Cuenta, Id_Moneda, Estado, Fecha_Creacion)
VALUES (@Id_Cuenta, @Id_Usuario, (SELECT Id_Pais FROM REZAGADOS.Pais WHERE Id_Pais=@Pais), (SELECT Id_Tipo_Cuenta FROM REZAGADOS.TipoCuenta WHERE Categoria=@Tipo), (SELECT Id_Moneda FROM REZAGADOS.Moneda WHERE Descripcion=@Moneda), 'Pendiente de activación', @Fecha)
END
END
GO

----------------------------------------MODIFICAR COSTO CUENTA------------------------------------------------

USE [GD1C2015]
GO
CREATE PROCEDURE REZAGADOS.Modificar_Costo_Cuenta (@Categoria VARCHAR(255), @Costo NUMERIC (18,0))
AS
BEGIN
IF EXISTS (SELECT Id_Tipo_Cuenta FROM REZAGADOS.TipoCuenta WHERE Categoria=@Categoria)
UPDATE REZAGADOS.TipoCuenta SET Costo = @Costo WHERE Categoria=@Categoria
END
GO

----------------------------------------------TARJETAS-------------------------------------------------------