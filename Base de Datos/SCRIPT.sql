------------------------------------------------------------------------------------
---------------------------------DROP-TERMPORAL-------------------------------------
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
ALTER TABLE REZAGADOS.Transaccion DROP CONSTRAINT FK_Transaccion_to_Factura;
ALTER TABLE REZAGADOS.Transaccion DROP CONSTRAINT FK_Transaccion_to_Tipo_Transaccion;
ALTER TABLE REZAGADOS.Transaccion DROP CONSTRAINT FK_Transaccion_to_Cuenta;
ALTER TABLE REZAGADOS.Factura DROP CONSTRAINT FK_Factura_to_Usuario;

if object_id('REZAGADOS.Rol') IS NOT NULL
DROP TABLE REZAGADOS.Rol;
if object_id('REZAGADOS.Funcionalidad') IS NOT NULL
DROP TABLE REZAGADOS.Funcionalidad;
if object_id('REZAGADOS.FuncionalidadXRol') IS NOT NULL
DROP TABLE REZAGADOS.FuncionalidadXRol;
if object_id('REZAGADOS.UsuarioXRol') IS NOT NULL
DROP TABLE REZAGADOS.UsuarioXRol;
if object_id('REZAGADOS.Cliente') IS NOT NULL
DROP TABLE REZAGADOS.Cliente;
if object_id('REZAGADOS.Administrador') IS NOT NULL
DROP TABLE REZAGADOS.Administrador;
if object_id('REZAGADOS.Retiro') IS NOT NULL
DROP TABLE REZAGADOS.Retiro;
if object_id('REZAGADOS.Cheque') IS NOT NULL
DROP TABLE REZAGADOS.Cheque;
if object_id('REZAGADOS.Banco') IS NOT NULL
DROP TABLE REZAGADOS.Banco;
if object_id('REZAGADOS.Transferencia') IS NOT NULL
DROP TABLE REZAGADOS.Transferencia;
if object_id('REZAGADOS.HistorialCuenta') IS NOT NULL
DROP TABLE REZAGADOS.HistorialCuenta;
if object_id('REZAGADOS.Moneda') IS NOT NULL
DROP TABLE REZAGADOS.Moneda;
if object_id('REZAGADOS.Transaccion') IS NOT NULL
DROP TABLE REZAGADOS.Transaccion;
if object_id('REZAGADOS.Usuario') IS NOT NULL
DROP TABLE REZAGADOS.Usuario;
if object_id('REZAGADOS.Tarjeta') IS NOT NULL
DROP TABLE REZAGADOS.Tarjeta;
if object_id('REZAGADOS.Factura') IS NOT NULL
DROP TABLE REZAGADOS.Factura;
if object_id('REZAGADOS.Pais') IS NOT NULL
DROP TABLE REZAGADOS.Pais;
if object_id('REZAGADOS.Cuenta') IS NOT NULL
DROP TABLE REZAGADOS.Cuenta;
if object_id('REZAGADOS.Deposito') IS NOT NULL
DROP TABLE REZAGADOS.Deposito;
if object_id('REZAGADOS.TipoDocumento') IS NOT NULL
DROP TABLE REZAGADOS.TipoDocumento;
if object_id('REZAGADOS.TipoTransaccion') IS NOT NULL
DROP TABLE REZAGADOS.TipoTransaccion;
if object_id('REZAGADOS.TipoCuenta') IS NOT NULL
DROP TABLE REZAGADOS.TipoCuenta;


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
Num_Transaccion numeric(18,2),);
ALTER TABLE REZAGADOS.Cheque ADD CONSTRAINT PK_Id_Cheque PRIMARY KEY (Id_Cheque);

CREATE TABLE REZAGADOS.Banco ( 
Id_Banco numeric (18,0) NOT NULL,
Nombre varchar(255),
Direccion varchar(255) NOT NULL,);
ALTER TABLE REZAGADOS.Banco ADD CONSTRAINT PK_Id_Banco PRIMARY KEY (Id_Banco);

CREATE TABLE REZAGADOS.Transaccion (
Id_Transaccion numeric(18,0) IDENTITY(1,1) NOT NULL,
Id_Factura numeric(18,0) NOT NULL,
Id_Cuenta numeric(18,0),
Id_Tipo_Transaccion numeric(18,0),
Importe numeric(18,2) NOT NULL, 
Fecha datetime,
Habilitada bit DEFAULT 1,);
ALTER TABLE REZAGADOS.Transaccion ADD CONSTRAINT PK_Id_Transaccion PRIMARY KEY (Id_Transaccion);

CREATE TABLE REZAGADOS.TipoTransaccion(
Id_Tipo_Transaccion numeric(18,0) IDENTITY(1,1) NOT NULL,
Tipo varchar(255),
Importe numeric(18,0) DEFAULT 0,);
ALTER TABLE REZAGADOS.TipoTransaccion ADD CONSTRAINT PK_Id_Tipo_Transaccion PRIMARY KEY (Id_Tipo_Transaccion);

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
ALTER TABLE REZAGADOS.Transaccion ADD CONSTRAINT FK_Transaccion_to_Factura
FOREIGN KEY (Id_Factura) REFERENCES REZAGADOS.Factura (Id_Factura)
;
ALTER TABLE REZAGADOS.Transaccion ADD CONSTRAINT FK_Transaccion_to_Tipo_Transaccion
FOREIGN KEY (Id_Tipo_Transaccion) REFERENCES REZAGADOS.TipoTransaccion (Id_Tipo_Transaccion)
;
ALTER TABLE REZAGADOS.Transaccion ADD CONSTRAINT FK_Transaccion_to_Cuenta
FOREIGN KEY (Id_Cuenta) REFERENCES REZAGADOS.Cuenta (Id_Cuenta)
;
ALTER TABLE REZAGADOS.Factura ADD CONSTRAINT FK_Factura_to_Usuario
FOREIGN KEY (Id_Usuario) REFERENCES REZAGADOS.Usuario (Id_Usuario)
;

-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
------------------------------------MIGRACION----------------------------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

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
VALUES ('Login y Seguridad'), ('ABM de Rol'), ('Registro de Usuario'), ('ABM de Cliente'), ('ABM de Cuenta'), ('Deposito'), ('Retiro de Efectivo'), ('Transferencias entre cuentas'), ('Facturación de Costos'), ('Consulta de saldos'), ('Listado Estadístico')

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
SELECT DISTINCT Cli_Mail, 'd19501ed8c9de057fe8370035686d5e7a9686c2fddb68b57e1668e21917b3e87', GETDATE(), GETDATE()
FROM gd_esquema.Maestra
WHERE Cli_Mail IS NOT NULL

INSERT INTO REZAGADOS.Usuario (Nombre, Contrasenia, Fecha_Creacion, Fecha_Ult_Modif)
VALUES ('admin','e6b87050bfcb8143fcb8db0170a4dc9ed00d904ddd3e2a4ad1b1e8dc0fdc9be7', GETDATE(), GETDATE()) 

----------------------------------------ADMINISTRADOR-----------------------------------------------

INSERT INTO REZAGADOS.Administrador(Id_Usuario)
SELECT DISTINCT Id_Usuario
FROM REZAGADOS.Usuario
WHERE Nombre = 'admin' 

-----------------------------------------USUARIOXROL--------------------------------------------------

INSERT INTO REZAGADOS.UsuarioXRol(Id_Usuario,Id_Rol)
SELECT A.Id_Usuario, R.Id_Rol 
FROM REZAGADOS.Administrador A, REZAGADOS.Rol R
WHERE R.Nombre = 'Administrador' 
UNION
SELECT C.Id_Usuario, R.Id_Rol 
FROM REZAGADOS.Cliente C, REZAGADOS.Rol R
WHERE R.Nombre = 'Cliente'

-----------------------------------------CLIENTE-------------------------------------------------

INSERT INTO REZAGADOS.Cliente (Id_Usuario, Nombre, Apellido, Id_Tipo_Documento, Id_Pais, Direccion_Calle, Direccion_Numero_Calle, Direccion_Piso, Direccion_Departamento, Fecha_Nacimiento, Mail, Localidad, Nacionalidad)
(
SELECT U.Id_Usuario, G.Cli_Nombre, G.Cli_Apellido,T.Id_Tipo_Documento, P.Id_Pais, G.Cli_Dom_Calle, G.Cli_Dom_Nro, G.Cli_Dom_Piso, G.Cli_Dom_Depto, G.Cli_Fecha_Nac, G.Cli_Mail, 'Capital Federal', 'Argentina'
FROM REZAGADOS.Usuario U, gd_esquema.Maestra G, REZAGADOS.TipoDocumento T, REZAGADOS.Pais P
WHERE U.Nombre = G.Cli_Mail AND P.Id_Pais = G.Cli_Pais_Codigo AND T.Id_Tipo_Documento = G.Cli_Tipo_Doc_Cod
GROUP BY U.Id_Usuario, G.Cli_Nombre, G.Cli_Apellido,T.Id_Tipo_Documento, P.Id_Pais, G.Cli_Dom_Calle, G.Cli_Dom_Nro, G.Cli_Dom_Piso, G.Cli_Dom_Depto, G.Cli_Fecha_Nac, G.Cli_Mail
)

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

INSERT INTO REZAGADOS.TipoCuenta (Categoria)
VALUES ('Oro'), ('Plata'), ('Bronce'), ('Gratis')

-------------------------------------TIPOTRANSACCION-----------------------------------------------

INSERT INTO REZAGADOS.TipoTransaccion (Tipo)
VALUES ('Comisión por transferencia.'), ('Creacion de cuenta'), ('Retiro'), ('Cheque')

------------------------------------------FACUTRA--------------------------------------------------

INSERT INTO REZAGADOS.Factura (Id_Factura, Id_Usuario, Fecha)
SELECT g.Factura_Numero, u.Id_Usuario, g.Factura_Fecha
FROM gd_esquema.Maestra g, REZAGADOS.Usuario u
WHERE u.Nombre = g.Cli_Mail AND g.Factura_Numero IS NOT NULL

-----------------------------------------TRANSACCION--------------------------------------------------

INSERT INTO REZAGADOS.Transaccion (Id_Factura, Id_Cuenta, Id_Tipo_Transaccion, Importe, Fecha)
SELECT f.Id_Factura, c.Id_Cuenta, t.Id_Tipo_Transaccion, g.Trans_Importe, g.Transf_Fecha
FROM gd_esquema.Maestra g, REZAGADOS.Factura f, REZAGADOS.Usuario u, REZAGADOS.Cuenta c, REZAGADOS.TipoTransaccion t
WHERE f.Id_Factura = g.Factura_Numero AND u.Nombre = g.Cli_Mail AND c.Id_Usuario = u.Id_Usuario AND t.Tipo = g.Item_Factura_Descr

--------------------------------------------RETIRO----------------------------------------------------

INSERT INTO REZAGADOS.Retiro (Id_Retiro, Id_Cuenta, Fecha, Importe)
SELECT g.Retiro_Codigo, c.Id_Cuenta, g.Retiro_Fecha, g.Retiro_Importe
FROM gd_esquema.Maestra g, REZAGADOS.Cuenta c
WHERE g.Retiro_Codigo IS NOT NULL AND c.Id_Cuenta = g.Cuenta_Numero

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

--¿¿HISTORIALCUENTA??

