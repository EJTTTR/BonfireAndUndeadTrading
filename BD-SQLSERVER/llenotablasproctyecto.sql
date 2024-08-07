USE [master]
GO
/****** Object:  Database [DBPROYECTOCARRITO]    Script Date: 18/07/2024 20:55:42 ******/
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'DBPROYECTOCARRITO')
BEGIN
CREATE DATABASE [DBPROYECTOCARRITO]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DBPROYECTOCARRITO', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\DBPROYECTOCARRITO.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DBPROYECTOCARRITO_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\DBPROYECTOCARRITO_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
END
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DBPROYECTOCARRITO].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET ARITHABORT OFF 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET  MULTI_USER 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET QUERY_STORE = OFF
GO
USE [DBPROYECTOCARRITO]
GO
/****** Object:  Table [dbo].[CARRITO]    Script Date: 18/07/2024 20:55:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CARRITO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CARRITO](
	[IdCarrito] [int] IDENTITY(1,1) NOT NULL,
	[IdCliente] [int] NULL,
	[IdProducto] [int] NULL,
	[Cantidad] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCarrito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CATEGORIA]    Script Date: 18/07/2024 20:55:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CATEGORIA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CATEGORIA](
	[IdCategoria] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](100) NULL,
	[Activo] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CLIENTE]    Script Date: 18/07/2024 20:55:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CLIENTE]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CLIENTE](
	[IdCliente] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NULL,
	[Apellido] [varchar](100) NULL,
	[Correo] [varchar](100) NULL,
	[Clave] [varchar](150) NULL,
	[Restablecer] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DETALLE_VENTA]    Script Date: 18/07/2024 20:55:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DETALLE_VENTA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DETALLE_VENTA](
	[IdDetalleVenta] [int] IDENTITY(1,1) NOT NULL,
	[IdVenta] [int] NULL,
	[IdProducto] [int] NULL,
	[Cantidad] [int] NULL,
	[Total] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDetalleVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DISTRITO]    Script Date: 18/07/2024 20:55:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DISTRITO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DISTRITO](
	[IdDistrito] [varchar](3) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
	[IdMunicipio] [varchar](3) NOT NULL,
	[IdProvincia] [varchar](2) NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[MARCA]    Script Date: 18/07/2024 20:55:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MARCA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MARCA](
	[IdMarca] [int] IDENTITY(1,1) NOT NULL,
	[Descripcion] [varchar](100) NULL,
	[Activo] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdMarca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[MUNICIPIO]    Script Date: 18/07/2024 20:55:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MUNICIPIO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MUNICIPIO](
	[IdMunicipio] [varchar](3) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL,
	[IdProvincia] [varchar](2) NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Producto]    Script Date: 18/07/2024 20:55:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Producto]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Producto](
	[IdProducto] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](500) NULL,
	[Descripcion] [varchar](500) NULL,
	[IdMarca] [int] NULL,
	[IdCategoria] [int] NULL,
	[Precio] [decimal](10, 2) NULL,
	[Stock] [int] NULL,
	[RutaImagen] [varchar](100) NULL,
	[NombreImagen] [varchar](100) NULL,
	[Activo] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[PROVINCIA]    Script Date: 18/07/2024 20:55:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PROVINCIA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PROVINCIA](
	[IdProvincia] [varchar](2) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[USUARIOS]    Script Date: 18/07/2024 20:55:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[USUARIOS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[USUARIOS](
	[IdUsuario] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NULL,
	[Apellido] [varchar](100) NULL,
	[Correo] [varchar](100) NULL,
	[Clave] [varchar](150) NULL,
	[Restablecer] [bit] NULL,
	[Activo] [bit] NULL,
	[FechaRegistro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[VENTA]    Script Date: 18/07/2024 20:55:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VENTA]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[VENTA](
	[IdVenta] [int] IDENTITY(1,1) NOT NULL,
	[IdCliente] [int] NULL,
	[TotalProducto] [int] NULL,
	[MontoTotal] [decimal](10, 2) NULL,
	[Contacto] [varchar](50) NULL,
	[IdProvincia] [varchar](20) NULL,
	[Telefono] [varchar](50) NULL,
	[Direccion] [varchar](100) NULL,
	[IdTransaccion] [varchar](50) NULL,
	[FechaVenta] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[IdVenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[CATEGORIA] ON 
GO
INSERT [dbo].[CATEGORIA] ([IdCategoria], [Descripcion], [Activo], [FechaRegistro]) VALUES (1, N'Video juegos', 1, CAST(N'2024-07-18T19:57:21.920' AS DateTime))
GO
INSERT [dbo].[CATEGORIA] ([IdCategoria], [Descripcion], [Activo], [FechaRegistro]) VALUES (2, N'Consolas', 1, CAST(N'2024-07-18T19:57:21.920' AS DateTime))
GO
INSERT [dbo].[CATEGORIA] ([IdCategoria], [Descripcion], [Activo], [FechaRegistro]) VALUES (3, N'Mandos', 1, CAST(N'2024-07-18T19:57:21.920' AS DateTime))
GO
INSERT [dbo].[CATEGORIA] ([IdCategoria], [Descripcion], [Activo], [FechaRegistro]) VALUES (4, N'Almacenamiento', 1, CAST(N'2024-07-18T19:57:21.920' AS DateTime))
GO
INSERT [dbo].[CATEGORIA] ([IdCategoria], [Descripcion], [Activo], [FechaRegistro]) VALUES (5, N'Teclado', 1, CAST(N'2024-07-18T19:57:21.920' AS DateTime))
GO
INSERT [dbo].[CATEGORIA] ([IdCategoria], [Descripcion], [Activo], [FechaRegistro]) VALUES (6, N'Mouse', 1, CAST(N'2024-07-18T19:57:21.920' AS DateTime))
GO
INSERT [dbo].[CATEGORIA] ([IdCategoria], [Descripcion], [Activo], [FechaRegistro]) VALUES (7, N'Audifonos', 1, CAST(N'2024-07-18T19:57:21.920' AS DateTime))
GO
INSERT [dbo].[CATEGORIA] ([IdCategoria], [Descripcion], [Activo], [FechaRegistro]) VALUES (8, N'Laptops', 1, CAST(N'2024-07-18T19:57:21.920' AS DateTime))
GO
INSERT [dbo].[CATEGORIA] ([IdCategoria], [Descripcion], [Activo], [FechaRegistro]) VALUES (9, N'PC de escritorio', 1, CAST(N'2024-07-18T19:57:21.920' AS DateTime))
GO
INSERT [dbo].[CATEGORIA] ([IdCategoria], [Descripcion], [Activo], [FechaRegistro]) VALUES (10, N'Cables de video', 1, CAST(N'2024-07-18T20:00:03.370' AS DateTime))
GO
INSERT [dbo].[CATEGORIA] ([IdCategoria], [Descripcion], [Activo], [FechaRegistro]) VALUES (11, N'Procesadores', 1, CAST(N'2024-07-18T20:02:30.037' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[CATEGORIA] OFF
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'001', N'Distrito Nacional', N'001', N'01')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'002', N'Las Lagunas', N'039', N'06')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'003', N'Majagual', N'001', N'02')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'004', N'Tábara Arriba', N'010', N'02')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'005', N'Los Toros', N'011', N'02')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'006', N'Guayabal', N'003', N'03')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'007', N'El Salado', N'013', N'03')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'008', N'Villa Central', N'017', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'009', N'Canoa', N'017', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'010', N'El Peñón', N'018', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'011', N'Pescadería', N'018', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'012', N'Vicente Noble', N'027', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'013', N'Los Patos', N'025', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'014', N'Las Auyamas', N'005', N'05')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'015', N'Los Arroyos', N'031', N'05')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'016', N'Manuel Bueno', N'029', N'05')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'017', N'Guananico', N'091', N'20')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'018', N'Sabaneta de Yásica', N'095', N'20')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'019', N'Estero Hondo', N'094', N'20')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'020', N'Maimón', N'089', N'20')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'021', N'Cabarete', N'095', N'20')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'022', N'San Víctor', N'052', N'09')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'023', N'Villa Trina', N'052', N'09')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'024', N'Juan López', N'052', N'09')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'025', N'El Rosario', N'048', N'08')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'026', N'Pedro Sánchez', N'048', N'08')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'027', N'Santa Lucía', N'048', N'08')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'028', N'El Cedro', N'048', N'08')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'029', N'Los Hatillos', N'048', N'08')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'030', N'La Romana', N'060', N'12')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'031', N'Guaymate', N'061', N'12')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'032', N'Villa Hermosa', N'062', N'12')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'033', N'Benerito', N'058', N'11')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'034', N'La Otra Banda', N'058', N'11')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'035', N'Verón-Punta Cana', N'058', N'11')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'036', N'Boca de Yuma', N'059', N'11')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'037', N'Sabana de la Mar', N'149', N'31')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'038', N'Elupina Cordero de Las Cañitas', N'148', N'31')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'039', N'Las Galeras', N'101', N'22')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'040', N'El Valle', N'148', N'31')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'041', N'El Limón', N'102', N'22')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'042', N'Los Ríos', N'012', N'03')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'043', N'Monción', N'143', N'29')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'044', N'Guayabal', N'014', N'03')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'045', N'El Llano', N'041', N'07')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'046', N'Pedro Santana', N'045', N'07')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'047', N'Bánica', N'046', N'07')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'048', N'Matayaya', N'119', N'25')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'049', N'Juma Bejucal', N'071', N'15')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'050', N'Río Verde Arriba', N'063', N'13')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'051', N'Cutupú', N'063', N'13')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'052', N'Tavera', N'063', N'13')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'053', N'Rincón', N'066', N'13')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'054', N'El Ranchito', N'066', N'13')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'055', N'Jima Abajo', N'066', N'13')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'056', N'Juan Adrián', N'073', N'15')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'057', N'Hato Damas', N'104', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'058', N'San Gregorio de Nigua', N'109', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'059', N'Cambita El Pueblecito', N'106', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'060', N'Hato Nuevo', N'151', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'061', N'Palmarejo-Villa Linda', N'151', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'062', N'La Victoria', N'152', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'063', N'San Luis', N'150', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'064', N'El Carril', N'108', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'065', N'Hato Viejo', N'111', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'066', N'La Colonia', N'113', N'24')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'067', N'Nizao-Las Auyamas', N'113', N'24')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'068', N'Los Patos', N'025', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'069', N'Cabeza de Toro', N'025', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'070', N'La Ciénaga', N'023', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'071', N'Santana', N'125', N'26')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'072', N'Bayahibe', N'059', N'11')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'073', N'Sabana Grande de Boyá', N'083', N'17')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'074', N'Don Juan', N'084', N'17')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'075', N'Gonzalo', N'083', N'17')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'076', N'Peralvillo', N'082', N'17')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'077', N'Boyá', N'083', N'17')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'078', N'El Puerto', N'082', N'17')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'079', N'La Cuaba', N'155', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'080', N'Pedro Brand', N'155', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'081', N'La Guáyiga', N'155', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'082', N'La Caleta', N'153', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'083', N'San José de Los Llanos', N'126', N'26')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'084', N'El Puerto', N'126', N'26')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'085', N'Santa Lucía', N'126', N'26')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'086', N'Cayacoa', N'126', N'26')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'087', N'Ramón Santana', N'125', N'26')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'088', N'El Limón', N'102', N'22')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'089', N'Las Galeras', N'101', N'22')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'090', N'El Cedro', N'048', N'08')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'091', N'La Higuera', N'002', N'02')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'092', N'Sabaneta', N'141', N'29')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'093', N'Arroyo Al Medio', N'067', N'14')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'094', N'El Factor', N'069', N'14')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'095', N'Las Gordas', N'067', N'14')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'096', N'La Entrada', N'068', N'14')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'097', N'San Francisco de Macorís', N'039', N'06')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'098', N'Sabana Grande de Hostos', N'040', N'06')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'099', N'Jima Arriba', N'066', N'13')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'100', N'Las Taranas', N'040', N'06')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'101', N'Angelina', N'040', N'06')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'102', N'Cenoví', N'039', N'06')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'103', N'Pantoja', N'151', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'104', N'Villa Sombrero', N'087', N'19')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'105', N'Pizarrete', N'087', N'19')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'106', N'Paya', N'087', N'19')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'107', N'Villa Fundación', N'087', N'19')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'108', N'Sabana Buey', N'087', N'19')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'109', N'El Carretón', N'087', N'19')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'110', N'Las Barías-La Estancia', N'087', N'19')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'111', N'Matanzas', N'088', N'19')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'112', N'La Sabina', N'088', N'19')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'113', N'Quita Sueño', N'151', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'114', N'El Rosario', N'048', N'08')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'115', N'El Valle', N'148', N'31')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'116', N'El Puerto', N'126', N'26')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'117', N'Pedro Brand', N'155', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'118', N'La Guáyiga', N'155', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'119', N'La Cuaba', N'155', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'120', N'Benerito', N'058', N'11')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'121', N'Las Lagunas de Nisibón', N'058', N'11')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'122', N'San Luis', N'150', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'123', N'La Victoria', N'152', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'124', N'Santa Bárbara de Samaná', N'101', N'22')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'125', N'El Limón', N'102', N'22')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'126', N'Las Galeras', N'101', N'22')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'127', N'El Valle', N'148', N'31')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'128', N'Caimito', N'047', N'08')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'129', N'Vicente Noble', N'027', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'130', N'Las Clavellinas', N'027', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'131', N'El Higüero', N'152', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'132', N'La Guayiga', N'155', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'133', N'San Luis', N'150', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'134', N'La Victoria', N'152', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'135', N'Boca Chica', N'153', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'136', N'San Antonio de Guerra', N'154', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'137', N'Pedro Brand', N'155', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'138', N'San Gregorio de Nigua', N'109', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'139', N'Hato Viejo', N'111', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'140', N'El Carril', N'108', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'141', N'Cambita El Pueblecito', N'106', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'142', N'Yaguate', N'111', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'143', N'Villa Altagracia', N'110', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'144', N'Sabana Grande de Palenque', N'108', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'145', N'Los Cacaos', N'107', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'146', N'Bajos de Haina', N'105', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'147', N'San Cristóbal', N'104', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'148', N'Quita Sueño', N'151', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'149', N'Los Alcarrizos', N'151', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'150', N'Santo Domingo Este', N'150', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'151', N'Villa Fundación', N'087', N'19')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'152', N'Villa Jaragua', N'016', N'03')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'153', N'Jicomé', N'144', N'30')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'154', N'Mata de Santa Cruz', N'077', N'16')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'155', N'Palo Verde', N'074', N'16')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'156', N'Cana Chapetón', N'076', N'16')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'157', N'San Fernando de Monte Cristi', N'074', N'16')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'158', N'Loma de Cabrera', N'030', N'05')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'159', N'Cañongo', N'028', N'05')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'160', N'El Carril', N'108', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'161', N'Hatillo', N'104', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'162', N'Yaguate', N'111', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'163', N'El Pomier', N'104', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'164', N'Hato Nuevo', N'151', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'165', N'Palmarejo-Villa Linda', N'151', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'166', N'Quita Sueño', N'151', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'167', N'Pedro Brand', N'155', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'168', N'La Guáyiga', N'155', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'169', N'La Cuaba', N'155', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'170', N'La Ciénaga', N'023', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'171', N'Los Patos', N'025', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'172', N'Cabeza de Toro', N'025', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'173', N'San Rafael', N'025', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'174', N'Pescadería', N'018', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'175', N'Batey Uno', N'017', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'176', N'Paraíso', N'025', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'177', N'Fundación', N'021', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'178', N'La Guázara', N'017', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'179', N'El Peñón', N'018', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'180', N'Canoa', N'018', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'181', N'Quita Coraza', N'018', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'182', N'Vicente Noble', N'027', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'183', N'Jaquimeyes', N'022', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'184', N'Polo', N'026', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'185', N'Cabral', N'018', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'186', N'El Cachón', N'018', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'187', N'Canoa', N'018', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'188', N'Cristóbal', N'012', N'03')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'189', N'Los Arroyos', N'012', N'03')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'190', N'Galván', N'013', N'03')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'191', N'Uvilla', N'016', N'03')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'192', N'Mena', N'015', N'03')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'193', N'Monserrat', N'015', N'03')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'194', N'El Salado', N'013', N'03')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'195', N'El Palmar', N'013', N'03')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'196', N'El Naranjo', N'013', N'03')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'197', N'Santa Bárbara', N'101', N'22')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'198', N'El Limón', N'102', N'22')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'199', N'Las Galeras', N'101', N'22')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'200', N'Sánchez', N'103', N'22')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'201', N'Las Terrenas', N'102', N'22')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'202', N'Majagual', N'001', N'02')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'203', N'Proyecto 4', N'001', N'02')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'204', N'Clavijo', N'001', N'02')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'205', N'Quisqueya', N'001', N'02')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'206', N'El Rosario', N'048', N'08')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'207', N'Pedro Sánchez', N'048', N'08')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'208', N'Santa Lucía', N'048', N'08')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'209', N'El Cedro', N'048', N'08')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'210', N'Los Hatillos', N'048', N'08')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'211', N'Vicente Noble', N'027', N'04')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'212', N'Los Botados', N'080', N'17')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'213', N'Los Jovillos', N'080', N'17')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'214', N'Don Juan', N'084', N'17')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'215', N'Los Ganchos', N'084', N'17')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'216', N'Gonzalo', N'083', N'17')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'217', N'Boyá', N'083', N'17')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'218', N'Sabana Grande de Boyá', N'083', N'17')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'219', N'Peralvillo', N'082', N'17')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'220', N'La Cuaba', N'155', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'221', N'La Guáyiga', N'155', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'222', N'Hato Nuevo', N'151', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'223', N'Palmarejo-Villa Linda', N'151', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'224', N'Quita Sueño', N'151', N'32')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'225', N'San Gregorio de Nigua', N'109', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'226', N'El Carril', N'108', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'227', N'Los Cacaos', N'107', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'228', N'Sabana Grande de Palenque', N'108', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'229', N'Yaguate', N'111', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'230', N'Villa Altagracia', N'110', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'231', N'Cambita El Pueblecito', N'106', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'232', N'Bajos de Haina', N'105', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'233', N'San Cristóbal', N'104', N'23')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'234', N'Sabaneta', N'141', N'29')
GO
INSERT [dbo].[DISTRITO] ([IdDistrito], [Descripcion], [IdMunicipio], [IdProvincia]) VALUES (N'235', N'Los Almácigos', N'142', N'29')
GO
SET IDENTITY_INSERT [dbo].[MARCA] ON 
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (1, N'Samsung', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (2, N'Sony', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (3, N'Microsoft', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (4, N'Apple', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (5, N'Logitech', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (6, N'HP', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (7, N'Dell', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (8, N'Lenovo', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (9, N'Acer', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (10, N'Asus', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (11, N'Toshiba', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (12, N'LG', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (13, N'Panasonic', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (14, N'Huawei', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (15, N'Xiaomi', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (16, N'Nokia', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (17, N'Razer', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (18, N'Corsair', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (19, N'Gigabyte', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (20, N'MSI', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (21, N'Alienware', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (22, N'HyperX', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (23, N'SteelSeries', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (24, N'BenQ', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (25, N'Philips', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (26, N'JBL', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (27, N'Beats', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (28, N'Sennheiser', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (29, N'Creative', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (30, N'Kingston', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (31, N'SanDisk', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (32, N'Western Digital', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (33, N'Seagate', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (34, N'From Software', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (35, N'Nintendo', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (36, N'Capcom', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (37, N'Electronic Arts', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (38, N'Ubisoft', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (39, N'Square Enix', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (40, N'Rockstar Games', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (41, N'Bethesda Game Studios', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (42, N'CD Projekt Red', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (43, N'Bandai Namco Entertainment', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (44, N'Activision', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (45, N'Blizzard Entertainment', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (46, N'Konami', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (47, N'Sega', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
INSERT [dbo].[MARCA] ([IdMarca], [Descripcion], [Activo], [FechaRegistro]) VALUES (48, N'Insomniac Games', 1, CAST(N'2024-07-18T20:04:02.690' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[MARCA] OFF
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'001', N'Santo Domingo de Guzmán', N'01')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'002', N'Azua de Compostela', N'02')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'003', N'Estebanía', N'02')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'004', N'Guayabal', N'02')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'005', N'Las Charcas', N'02')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'006', N'Las Yayas de Viajama', N'02')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'007', N'Padre Las Casas', N'02')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'008', N'Peralta', N'02')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'009', N'Pueblo Viejo', N'02')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'010', N'Sabana Yegua', N'02')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'011', N'Tábara Arriba', N'02')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'012', N'Neiba', N'03')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'013', N'Galván', N'03')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'014', N'Los Ríos', N'03')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'015', N'Tamayo', N'03')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'016', N'Villa Jaragua', N'03')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'017', N'Barahona', N'04')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'018', N'Cabral', N'04')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'019', N'El Peñón', N'04')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'020', N'Enriquillo', N'04')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'021', N'Fundación', N'04')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'022', N'Jaquimeyes', N'04')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'023', N'La Ciénaga', N'04')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'024', N'Las Salinas', N'04')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'025', N'Paraíso', N'04')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'026', N'Polo', N'04')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'027', N'Vicente Noble', N'04')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'028', N'Dajabón', N'05')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'029', N'El Pino', N'05')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'030', N'Loma de Cabrera', N'05')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'031', N'Partido', N'05')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'032', N'Restauración', N'05')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'033', N'Duarte', N'06')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'034', N'Arenoso', N'06')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'035', N'Castillo', N'06')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'036', N'Eugenio María de Hostos', N'06')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'037', N'Las Guáranas', N'06')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'038', N'Pimentel', N'06')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'039', N'San Francisco de Macorís', N'06')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'040', N'Villa Riva', N'06')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'041', N'El Llano', N'07')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'042', N'Comendador', N'07')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'043', N'Hondo Valle', N'07')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'044', N'Juan Santiago', N'07')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'045', N'Pedro Santana', N'07')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'046', N'Bánica', N'07')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'047', N'El Seibo', N'08')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'048', N'Miches', N'08')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'049', N'Espaillat', N'09')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'050', N'Gaspar Hernández', N'09')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'051', N'Jamao al Norte', N'09')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'052', N'Moca', N'09')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'053', N'Cayetano Germosén', N'09')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'054', N'Jimaní', N'10')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'055', N'La Descubierta', N'10')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'056', N'Mella', N'10')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'057', N'Postrer Río', N'10')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'058', N'Higüey', N'11')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'059', N'San Rafael del Yuma', N'11')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'060', N'La Romana', N'12')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'061', N'Guaymate', N'12')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'062', N'Villa Hermosa', N'12')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'063', N'Concepción de La Vega', N'13')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'064', N'Constanza', N'13')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'065', N'Jarabacoa', N'13')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'066', N'Jima Abajo', N'13')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'067', N'Nagua', N'14')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'068', N'Cabrera', N'14')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'069', N'El Factor', N'14')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'070', N'Río San Juan', N'14')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'071', N'Bonao', N'15')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'072', N'Maimón', N'15')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'073', N'Piedra Blanca', N'15')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'074', N'Monte Cristi', N'16')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'075', N'Castañuelas', N'16')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'076', N'Guayubín', N'16')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'077', N'Las Matas de Santa Cruz', N'16')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'078', N'Pepillo Salcedo', N'16')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'079', N'Villa Vásquez', N'16')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'080', N'Monte Plata', N'17')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'081', N'Bayaguana', N'17')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'082', N'Peralvillo', N'17')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'083', N'Sabana Grande de Boyá', N'17')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'084', N'Yamasá', N'17')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'085', N'Pedernales', N'18')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'086', N'Oviedo', N'18')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'087', N'Baní', N'19')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'088', N'Matanzas', N'19')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'089', N'Puerto Plata', N'20')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'090', N'Altamira', N'20')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'091', N'Guananico', N'20')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'092', N'Imbert', N'20')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'093', N'Los Hidalgos', N'20')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'094', N'Luperón', N'20')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'095', N'Sosúa', N'20')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'096', N'Villa Isabela', N'20')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'097', N'Villa Montellano', N'20')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'098', N'Salcedo', N'21')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'099', N'Tenares', N'21')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'100', N'Villa Tapia', N'21')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'101', N'Samaná', N'22')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'102', N'Las Terrenas', N'22')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'103', N'Sánchez', N'22')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'104', N'San Cristóbal', N'23')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'105', N'Bajos de Haina', N'23')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'106', N'Cambita Garabitos', N'23')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'107', N'Los Cacaos', N'23')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'108', N'Sabana Grande de Palenque', N'23')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'109', N'San Gregorio de Nigua', N'23')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'110', N'Villa Altagracia', N'23')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'111', N'Yaguate', N'23')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'112', N'San José de Ocoa', N'24')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'113', N'Sabana Larga', N'24')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'114', N'Rancho Arriba', N'24')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'115', N'San Juan de la Maguana', N'25')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'116', N'Bohechío', N'25')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'117', N'El Cercado', N'25')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'118', N'Juan de Herrera', N'25')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'119', N'Las Matas de Farfán', N'25')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'120', N'Vallejuelo', N'25')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'121', N'San Pedro de Macorís', N'26')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'122', N'Consuelo', N'26')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'123', N'Guayacanes', N'26')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'124', N'Quisqueya', N'26')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'125', N'Ramón Santana', N'26')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'126', N'San José de los Llanos', N'26')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'127', N'Cotuí', N'27')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'128', N'Cevicos', N'27')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'129', N'Fantino', N'27')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'130', N'La Mata', N'27')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'131', N'Santiago de los Caballeros', N'28')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'132', N'Bisonó', N'28')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'133', N'Jánico', N'28')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'134', N'Licey al Medio', N'28')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'135', N'Puñal', N'28')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'136', N'San José de las Matas', N'28')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'137', N'Sabana Iglesia', N'28')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'138', N'Tamboril', N'28')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'139', N'Villa Bisonó', N'28')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'140', N'Villa González', N'28')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'141', N'Sabaneta', N'29')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'142', N'Los Almácigos', N'29')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'143', N'Monción', N'29')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'144', N'Mao', N'30')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'145', N'Esperanza', N'30')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'146', N'Laguna Salada', N'30')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'147', N'Hato Mayor del Rey', N'31')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'148', N'El Valle', N'31')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'149', N'Sabana de la Mar', N'31')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'150', N'Santo Domingo Este', N'32')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'151', N'Santo Domingo Oeste', N'32')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'152', N'Santo Domingo Norte', N'32')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'153', N'Boca Chica', N'32')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'154', N'San Antonio de Guerra', N'32')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'155', N'Los Alcarrizos', N'32')
GO
INSERT [dbo].[MUNICIPIO] ([IdMunicipio], [Descripcion], [IdProvincia]) VALUES (N'156', N'Pedro Brand', N'32')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'01', N'Distrito Nacional')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'02', N'Azua')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'03', N'Baoruco')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'04', N'Barahona')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'05', N'Dajabón')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'06', N'Duarte')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'07', N'Elías Piña')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'08', N'El Seibo')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'09', N'Espaillat')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'10', N'Independencia')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'11', N'La Altagracia')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'12', N'La Romana')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'13', N'La Vega')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'14', N'María Trinidad Sánchez')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'15', N'Monseñor Nouel')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'16', N'Monte Cristi')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'17', N'Monte Plata')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'18', N'Pedernales')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'19', N'Peravia')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'20', N'Puerto Plata')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'21', N'Hermanas Mirabal')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'22', N'Samaná')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'23', N'San Cristóbal')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'24', N'San José de Ocoa')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'25', N'San Juan')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'26', N'San Pedro de Macorís')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'27', N'Sánchez Ramírez')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'28', N'Santiago')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'29', N'Santiago Rodríguez')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'30', N'Valverde')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'31', N'Hato Mayor')
GO
INSERT [dbo].[PROVINCIA] ([IdProvincia], [Descripcion]) VALUES (N'32', N'Santo Domingo')
GO
SET IDENTITY_INSERT [dbo].[USUARIOS] ON 
GO
INSERT [dbo].[USUARIOS] ([IdUsuario], [Nombre], [Apellido], [Correo], [Clave], [Restablecer], [Activo], [FechaRegistro]) VALUES (1, N'test nombre', N'test apellido', N'test@example.com', N'ECD71870D1963316A97E3AC3408C9835AD8CF0F3C1BC703527C30265534F75AE', 0, 1, CAST(N'2024-07-18T19:49:35.027' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[USUARIOS] OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__CATEGORIA__Activ__37A5467C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CATEGORIA] ADD  DEFAULT ((1)) FOR [Activo]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__CATEGORIA__Fecha__38996AB5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CATEGORIA] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__CLIENTE__Restabl__45F365D3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CLIENTE] ADD  DEFAULT ((0)) FOR [Restablecer]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__CLIENTE__FechaRe__46E78A0C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CLIENTE] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__MARCA__Activo__3B75D760]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[MARCA] ADD  DEFAULT ((1)) FOR [Activo]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__MARCA__FechaRegi__3C69FB99]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[MARCA] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Producto__Precio__412EB0B6]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Producto] ADD  DEFAULT ((0)) FOR [Precio]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Producto__Activo__4222D4EF]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Producto] ADD  DEFAULT ((1)) FOR [Activo]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Producto__FechaR__4316F928]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Producto] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__USUARIOS__Restab__5535A963]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[USUARIOS] ADD  DEFAULT ((0)) FOR [Restablecer]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__USUARIOS__Activo__5629CD9C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[USUARIOS] ADD  DEFAULT ((1)) FOR [Activo]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__USUARIOS__FechaR__571DF1D5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[USUARIOS] ADD  DEFAULT (getdate()) FOR [FechaRegistro]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__VENTA__FechaVent__4E88ABD4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[VENTA] ADD  DEFAULT (getdate()) FOR [FechaVenta]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__CARRITO__IdClien__49C3F6B7]') AND parent_object_id = OBJECT_ID(N'[dbo].[CARRITO]'))
ALTER TABLE [dbo].[CARRITO]  WITH CHECK ADD FOREIGN KEY([IdCliente])
REFERENCES [dbo].[CLIENTE] ([IdCliente])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__CARRITO__IdProdu__4AB81AF0]') AND parent_object_id = OBJECT_ID(N'[dbo].[CARRITO]'))
ALTER TABLE [dbo].[CARRITO]  WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[Producto] ([IdProducto])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__DETALLE_V__IdPro__52593CB8]') AND parent_object_id = OBJECT_ID(N'[dbo].[DETALLE_VENTA]'))
ALTER TABLE [dbo].[DETALLE_VENTA]  WITH CHECK ADD FOREIGN KEY([IdProducto])
REFERENCES [dbo].[Producto] ([IdProducto])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__DETALLE_V__IdVen__5165187F]') AND parent_object_id = OBJECT_ID(N'[dbo].[DETALLE_VENTA]'))
ALTER TABLE [dbo].[DETALLE_VENTA]  WITH CHECK ADD FOREIGN KEY([IdVenta])
REFERENCES [dbo].[VENTA] ([IdVenta])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Producto__IdCate__403A8C7D]') AND parent_object_id = OBJECT_ID(N'[dbo].[Producto]'))
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD FOREIGN KEY([IdCategoria])
REFERENCES [dbo].[CATEGORIA] ([IdCategoria])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Producto__IdMarc__3F466844]') AND parent_object_id = OBJECT_ID(N'[dbo].[Producto]'))
ALTER TABLE [dbo].[Producto]  WITH CHECK ADD FOREIGN KEY([IdMarca])
REFERENCES [dbo].[MARCA] ([IdMarca])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__VENTA__IdCliente__4D94879B]') AND parent_object_id = OBJECT_ID(N'[dbo].[VENTA]'))
ALTER TABLE [dbo].[VENTA]  WITH CHECK ADD FOREIGN KEY([IdCliente])
REFERENCES [dbo].[CLIENTE] ([IdCliente])
GO
USE [master]
GO
ALTER DATABASE [DBPROYECTOCARRITO] SET  READ_WRITE 
GO
