use master
go
create database DISCOS_DB
go

use DISCOS_DB
go
-- CONFIGURACION ANSI NULLS ON, una instruccion SELECT que usa WHERE
-- column_name<>NULL devuelve cero filas aunque haya valores
-- que no sean NULL en column_name
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ESTILOS](
	  [Id] [int] IDENTITY(1,1) NOT NULL,
	  [Descripcion] [varchar](100) NULL,
      CONSTRAINT [PK_ESTILOS] PRIMARY KEY CLUSTERED 
      (
	    [Id] ASC
      )
)
GO

USE DISCOS_DB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPOSEDICION](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_TIPOSEDICION] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
)
GO
USE DISCOS_DB
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DISCOS](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [varchar](100) NULL,
	[FechaLanzamiento] [smalldatetime] NULL,
	[CantidadCanciones] [int] NULL,
	[UrlImagenTapa] [varchar](200) NULL,
	[IdEstilo] [int] NULL,
	[IdTipoEdicion] [int] NULL,
 CONSTRAINT [PK_DISCOS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)
)
GO
USE DISCOS_DB
GO
-- DATOS --
insert into ESTILOS values ('Pop Punk')
insert into ESTILOS values ('Pop')
insert into ESTILOS values ('Rock')
insert into ESTILOS values ('Grunge')
insert into TIPOSEDICION values ('Vinilo')
insert into TIPOSEDICION values ('CD')
insert into TIPOSEDICION values ('Tape')
insert into DISCOS values ('Pablo Honey', '01-01-1992', 12, 'https://cdns-images.dzcdn.net/images/cover/f08424290260e58c6d76275253b316fd/264x264.jpg', 2, 1)
insert into DISCOS values ('Siempre es hoy', '01-01-2002', 17, 'https://www.cmtv.com.ar/tapas-cd/ceratisiempre.jpg', 3, 3)
-- Ejercicios Consultas SQL --
-- 1. Traer todos los discos con su respectivo estilo. La consulta debe mostrar: --
-- Nombre de disco, Fecha de lanzamiento, Estilo (no el id, sino la descripcion). --

USE DISCOS_DB
GO

SELECT * FROM DISCOS
SELECT * FROM ESTILOS
SELECT * FROM TIPOSEDICION

SELECT D.Titulo, D.FechaLanzamiento, E.Descripcion FROM DISCOS D, ESTILOS E
WHERE D.IdEstilo = E.Id

--2. Insertar al menos dos estilos nuevos y un tipo de edicion de disco --
INSERT INTO ESTILOS VALUES ('Disco')
INSERT INTO ESTILOS VALUES ('Metal')
INSERT INTO TIPOSEDICION VALUES ('DVD')

--3. Insertar al menos dos discos nuevos cargando correctamente su información.--
insert into DISCOS values ('HOY', '11-11-2011', 13, 'https://www.cmtv.com.ar/tapas-cd/ceratisiempre.jpg', 2, 4)
insert into DISCOS values ('MAÑANA', '02-12-2012', 10, 'https://www.cmtv.com.ar/tapas-cd/ceratisiempre.jpg', 1, 3)

--4. Actualizar al menos un disco modificando la cantidad de canciones y --
-- la fecha de lanzamiento. No te olvides del Where. --
--MODIFICAR UNA FILA --
UPDATE DISCOS set CantidadCanciones = 10, FechaLanzamiento = GETDATE() where Id = 1 

--5. Borrar un disco a elección --
DELETE FROM DISCOS WHERE Id = 3

--6. Traer todos los estilos que estén asociados a algún disco. --
SELECT D.IdEstilo, E.Descripcion Genero FROM DISCOS D, ESTILOS E
WHERE D.IdEstilo = E.Id

--7. Traer todos los discos con el siguiente formato: Nombre, Estilo, Edición(todo texto). --
SELECT D.Titulo Nombre, E.Descripcion Estilo, T.Descripcion Edición 
FROM DISCOS D, ESTILOS E, TIPOSEDICION T
WHERE D.IdEstilo = E.Id AND D.IdTipoEdicion = T.Id

--8. Traer todos los discos que contengan en su nombre la sílaba "ho". --
SELECT D.Titulo Nombre FROM DISCOS D
WHERE D.Titulo LIKE '%ho%'
-- ----------------------------------------------------------------------- --