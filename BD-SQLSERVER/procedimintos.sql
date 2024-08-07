select * from USUARIOS
go

create proc sp_RegistrarUsuario
(
	@Nombre varchar(100),
	@Apellido varchar(100),
	@Correo varchar(100),
	@Clave varchar(150),
	@Activo bit,
	@Mensaje varchar(600) output,
	@Resultado int output
)
as
begin
	SET @Resultado = 0
	if NOT EXISTS (SELECT *FROM USUARIOS WHERE Correo = @Correo)
	begin
		insert into USUARIOS(Nombre,Apellido,Correo,Clave,Activo) 
		values (@Nombre, @Apellido, @Correo, @Clave, @Activo);
		set @Resultado = SCOPE_IDENTITY()
	end
	else
		set @Mensaje = 'El correo del usuario ya existe'
end
go

create proc sp_EditarUsuario
(
	@IdUsuario int,
	@Nombre varchar(100),
	@Apellido varchar(100),
	@Correo varchar(100),
	@Activo bit,
	@Mensaje varchar(600) output,
	@Resultado bit output
)
as
begin
	SET @Resultado = 0
	if NOT EXISTS (SELECT *FROM USUARIOS WHERE Correo = @Correo and IdUsuario != @IdUsuario)
	begin
		
		update top(1) USUARIOS set
			Nombre = @Nombre,
			Apellido = @Apellido,
			Correo = @Correo,
			Activo = @Activo
		where IdUsuario = @IdUsuario

			Set @Resultado = 1
	end
	else
		set @Mensaje = 'El correo del usuario ya existe'
end
go
---------------------------------------------------------------
select Descripcion, Activo from CATEGORIA
go
create proc sp_RegistrarCategoria
(
	@Descripcion varchar(100),
	@Activo bit,
	@Mensaje varchar(600) output,
	@Resultado int output
)
as
begin
	SET @Resultado = 0
	if NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = @Descripcion)
	begin
		insert into CATEGORIA(Descripcion,Activo) 
		values (@Descripcion, @Activo);
		set @Resultado = SCOPE_IDENTITY()
	end
	else
		set @Mensaje = 'La categoria ya existe'
end
go
select * from CATEGORIA
drop proc sp_EditarCategoria
go
CREATE PROC sp_EditarCategoria
(
    @IdCategoria int,
    @Descripcion varchar(100),
    @Activo bit,
    @Mensaje varchar(600) output,
    @Resultado int output
)
AS
BEGIN
    SET @Resultado = 0
    IF NOT EXISTS (SELECT * FROM CATEGORIA WHERE Descripcion = @Descripcion AND IdCategoria != @IdCategoria)
    BEGIN
        UPDATE top(1) CATEGORIA 
        SET Descripcion = @Descripcion, Activo = @Activo
        WHERE IdCategoria = @IdCategoria

        SET @Resultado = 1
    END
    ELSE
    BEGIN
        -- Verificar si solo está cambiando el estado Activo
        IF EXISTS (SELECT * FROM CATEGORIA WHERE IdCategoria = @IdCategoria AND Descripcion = @Descripcion)
        BEGIN
            UPDATE top(1) CATEGORIA 
            SET Activo = @Activo
            WHERE IdCategoria = @IdCategoria

            SET @Resultado = 1
        END
        ELSE
        BEGIN
            SET @Mensaje = 'La categoria ya existe'
        END
    END
END
go
create proc sp_EliminarCategoria
(
	@IdCategoria int,
	@Mensaje varchar(600) output,
	@Resultado int output
)
as
begin
	SET @Resultado = 0
	if NOT EXISTS (SELECT * FROM Producto p 
	inner join CATEGORIA c on c.IdCategoria = p.IdCategoria
	WHERE p.IdCategoria = @IdCategoria)

	begin
		delete top(1) from CATEGORIA where IdCategoria = @IdCategoria
		set @Resultado = 1
	end
	else
		set @Mensaje = 'No se pueden eliminar las categorias que se encuentran relacionadas a uno o mas productos'
end
go
-------------------------------------------------------------
select * from MARCA
go

create proc sp_RegistrarMarca
(
	@Descripcion varchar(100),
	@Activo bit,
	@Mensaje varchar(600) output,
	@Resultado int output
)
as
begin
	SET @Resultado = 0
	if NOT EXISTS (SELECT * FROM MARCA WHERE Descripcion = @Descripcion)
	begin
		insert into MARCA(Descripcion,Activo) 
		values (@Descripcion, @Activo);
		set @Resultado = SCOPE_IDENTITY()
	end
	else
		set @Mensaje = 'La Marca ya existe'
end
go

create proc sp_EditarMarca
(
	@IdMarca int,
	@Descripcion varchar(100),
	@Activo bit,
	@Mensaje varchar(600) output,
	@Resultado int output
)
as
begin
	SET @Resultado = 0
	if NOT EXISTS (SELECT * FROM MARCA WHERE Descripcion = @Descripcion and IdMarca != @IdMarca)
	begin
		update top(1) MARCA 
		set Descripcion = @Descripcion, Activo = @Activo
		where IdMarca = @IdMarca
		set @Resultado = 1
	end
	else
		set @Mensaje = 'La marca ya existe'
end
go

create proc sp_EliminarMarca
(
	@IdMarca int,
	@Mensaje varchar(600) output,
	@Resultado int output
)
as
begin
	SET @Resultado = 0
	if NOT EXISTS (SELECT * FROM Producto p 
	inner join Marca m on m.IdMarca = p.IdMarca
	WHERE p.IdMarca = @IdMarca)

	begin
		delete top(1) from MARCA where IdMarca = @IdMarca
		set @Resultado = 1
	end
	else
		set @Mensaje = 'No se pueden eliminar las marcas que se encuentran relacionadas a uno o mas productos'
end
go
--------------------------------------------------------------
select * from Producto
go

create proc sp_RegistrarProducto
(
	@Nombre varchar(100),
	@Descripcion varchar(100),
	@IdMarca varchar(100),
	@IdCategoria varchar(100),
	@Precio decimal (10,2),
	@Stock int,
	@Activo bit,
	@Mensaje varchar(600) output,
	@Resultado int output
)
as
begin
	SET @Resultado = 0
		insert into Producto(Nombre, Descripcion, IdMarca, IdCategoria, Precio, Stock, Activo) 
		values (@Nombre, @Descripcion, @IdMarca, @IdCategoria, @Precio, @Stock, @Activo);
		set @Resultado = SCOPE_IDENTITY()
end
go

create proc sp_EditarProducto
(
	@IdProducto int,
	@Nombre varchar(100),
	@Descripcion varchar(100),
	@IdMarca varchar(100),
	@IdCategoria varchar(100),
	@Precio decimal (10,2),
	@Stock int,
	@Activo bit,
	@Mensaje varchar(600) output,
	@Resultado int output
)
as
begin
	SET @Resultado = 0
		update top(1) Producto set
		Nombre = @Nombre,
		Descripcion = @Descripcion, 
		IdMarca = @IdMarca,
		IdCategoria = @IdCategoria,
		Precio =@Precio,
		Stock = @Stock,
		Activo = @Activo
		where IdProducto = @IdProducto

		set @Resultado = 1
end

go
create proc sp_EliminarProducto
(
	@IdProducto int,
	@Mensaje varchar(600) output,
	@Resultado int output
)
as
begin
	SET @Resultado = 0
	if NOT EXISTS (SELECT * FROM DETALLE_VENTA d 
	inner join Producto p on p.IdProducto = d.IdProducto
	WHERE p.IdProducto = @IdProducto)

	begin
		delete top(1) from Producto where IdProducto = @IdProducto
		set @Resultado = 1
	end
	else
		set @Mensaje = 'El producto se relaciona con un venta'
end
go

select p.IdProducto, p.Nombre, p.Descripcion, 
m.IdMarca, m.Descripcion[DesMarca],
c.IdCategoria, c.Descripcion[DesCate],
p.Precio, p.Stock,p.RutaImagen,p.NombreImagen, p.Activo
from Producto p
inner join MARCA m on m.IdMarca = p.IdMarca
inner join CATEGORIA c on c.IdCategoria = p.IdCategoria

go

create proc sp_ReporteDashboard as
begin

select
	(select COUNT(*) from CLIENTE) [TotalCliente],

	(select ISNULL(SUM(cantidad), 0) from DETALLE_VENTA) [TotalVenta],

	(select COUNT(*) from Producto) [TotalProducto]
end

go



create proc sp_ReporteVentas(
@fechaInicio varchar(10),
@fechaFin varchar(10),
@idTransaccion varchar(50)
) as
begin
	set dateformat dmy;
		select CONVERT(char(10), v.FechaVenta, 103)[FechaVenta], CONCAT(c.Nombre, ' ', c.Apellido) [Cliente],
		p.Nombre [Producto], p.Precio, dv.Cantidad, dv.Total, v.IdTransaccion
		from DETALLE_VENTA dv
		inner join Producto p on p.IdProducto = dv.IdProducto
		inner join VENTA v on v.IdVenta = dv.IdVenta
		inner join CLIENTE c on c.IdCliente = v.IdCliente
		where convert(date, v.FechaVenta) between @fechaInicio and @fechaFin
		and v.IdTransaccion = iif(@idTransaccion = '', v.IdTransaccion, @idTransaccion)
end

go

create proc sp_RegistrarCliente(
@Nombre varchar(100),
@Apellido varchar(100),
@Correo varchar(100),
@Clave varchar(150),
@Mensaje varchar(500) output,
@Resultado int output
) as
begin
	SET @Resultado = 0
	if not exists (select * from CLIENTE where Correo = @Correo)
	begin
		insert into CLIENTE(Nombre, Apellido, Correo, Clave, Restablecer) 
		values (@Nombre, @Apellido, @Correo, @Clave, 0)

		set @Resultado = SCOPE_IDENTITY()
	end
	else
	set @Mensaje = 'El correo ya está en uso por otro usuario.'
end

go

create proc sp_ExisteCarrito(
@IdProducto int,
@IdCliente int,
@Resultado bit output
) as
begin
	if exists (select * from CARRITO where IdCliente = @IdCliente and IdProducto = @IdProducto)
		set @Resultado = 1
	else
		set @Resultado = 0
end

go

create proc sp_OperacionCarrito(
@IdCliente int,
@IdProducto int,
@Sumar bit,
@Mensaje varchar(500) output,
@Resultado bit output
) as
begin
	set @Resultado = 1
	set @Mensaje = ''

	declare @existeCarrito bit = iif(exists(select * from CARRITO where IdCliente = @IdCliente and IdProducto = @IdProducto), 1, 0)
	declare @stockProducto int = (select Stock from Producto where IdProducto = @IdProducto)

	begin try
		
		begin transaction OPERACION
		
		if(@Sumar = 1)
		begin

			if(@stockProducto > 0)
			begin
				
				if(@existeCarrito = 1)
					update CARRITO set Cantidad = Cantidad + 1 where IdCliente = @IdCliente and IdProducto = @IdProducto
				else
					insert into CARRITO(IdCliente, IdProducto, Cantidad) values(@IdCliente, @IdProducto, 1)

				update Producto set Stock = Stock - 1 where IdProducto = @IdProducto
			end
			else
			begin
				set @Resultado = 0
				set @Mensaje = 'Este producto no cuenta con suficiente stock en este momento. Nos disculpamos por cualquier inconveniente y le agradecemos su comprensión.'
			end

		end
		else
		begin
			update CARRITO set Cantidad = Cantidad - 1 where IdCliente = @IdCliente and IdProducto = @IdProducto
			update Producto set Stock = Stock + 1 where IdProducto = @IdProducto
		end

		commit transaction OPERACION

	end try
	begin catch
		set @Resultado = 0
		set @Mensaje = ERROR_MESSAGE()
		rollback transaction OPERACION
	end catch

end

go

create function fn_obtenerCarritoCliente(
@IdCliente int
)
returns table as
return(
	select p.IdProducto, m.Descripcion[Desmarca], p.Nombre, p.Precio, c.Cantidad, p.RutaImagen, p.NombreImagen
	from CARRITO c
	inner join Producto p on p.IdProducto = c.IdProducto
	inner join MARCA m on m.IdMarca = p.IdMarca
	where c.IdCliente = @IdCliente
)

go


create proc sp_EliminarCarrito(
@IdCliente int,
@IdProducto int,
@Resultado bit output
) as
begin
	set @Resultado = 1
	declare @CantidadProducto int = (select Cantidad from CARRITO where IdCliente = @IdCliente and IdProducto = @IdProducto)

	begin try
		
		begin transaction OPERACION
		
			update Producto set Stock = Stock + @CantidadProducto where IdProducto = @IdProducto
			delete top(1) from CARRITO where IdCliente = @IdCliente and IdProducto = @IdProducto

		commit transaction OPERACION

	end try
	begin catch
		set @Resultado = 0
		rollback transaction OPERACION
	end catch

end

go

Create TYPE [dbo].[EDetalles_Venta] as table (
	[IdProducto] int null,
	[Cantidad] int null,
	[Total] decimal(18,2) null
)

go

create procedure usp_RegistrarVenta(
@IdCliente int, 
@TotalProducto int,
@MontoTotal decimal(18,2),
@Contacto varchar(100),
@IdDistrito varchar(3),
@Telefono varchar(50),
@Direccion varchar(100),
@IdTransaccion varchar(50),
@DetellaVenta [EDetalles_Venta] READONLY,
@Resultado bit output,
@Mensaje varchar(500) output
) as begin

	begin try
		declare @IdVenta int = 0
		set @Resultado = 1
		set @Mensaje = ''

		begin transaction registro
			
			insert into VENTA(IdCliente, TotalProducto, MontoTotal, Contacto, IdDistrito, Telefono, Direccion, IdTransaccion)
			values (@IdCliente, @TotalProducto, @MontoTotal, @Contacto, @IdDistrito, @Telefono, @Direccion, @IdTransaccion)
			
			set @IdVenta = scope_identity();

			insert into DETALLE_VENTA(IdVenta, IdProducto, Cantidad, Total)
			select @IdVenta, IdProducto, Cantidad, Total from @DetellaVenta

			delete from CARRITO where IdCliente = @IdCliente

		commit transaction registro
	end try
	begin catch
		set @Resultado = 1
		set @Mensaje = ERROR_MESSAGE()
		rollback transaction registro
	end catch

end

go		


create function fn_ListarCompra(
@IdCliente int
) returns table
as 
return
(
	select p.RutaImagen, p.NombreImagen,p.Nombre, p.Precio,dv.Cantidad, dv.Total, v.IdTransaccion
	from DETALLE_VENTA dv
	inner join Producto p on p.IdProducto = dv.IdProducto
	inner join VENTA v on v.IdVenta = dv.IdVenta
	where v.IdCliente = @IdCliente

)
go
