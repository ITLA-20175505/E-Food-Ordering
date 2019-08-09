create database EFood
use EFood

create table TipoAB (
idTipoAB int identity(1,1),
nombreAB varchar(25) not null,
inactive bit default 0,
Constraint pk_TipoAB primary key(idTipoAB))

create table TipoServicio(
idTipoServicio int identity(1,1),
idTipoAB int not null,
nombreTS varchar(25) not null,
inactive bit default 0,
Constraint pk_TipoServicio primary key(idTipoServicio),
Constraint fk_TipoComida_TipoAB foreign key (idTipoAB) references TipoAB(idTipoAB))

create table Servicio(
idServicio int identity(1,1),
idTipoAB int not null,
idTipoServicio int null,
nombreServicio varchar(50),
descripcion text,
precio float,
tiempo int,
imagen text,
inactive bit default 0,
Constraint pk_Servicio primary key(idServicio),
Constraint fk_Servicio_TipoAB foreign key (idTipoAB) references TipoAB(idTipoAB),
Constraint fk_Servicio_TipoServicio foreign key(idTipoServicio) references TipoServicio(idTipoServicio))

create table Mesa(
idMesa int identity(1,1),
nombreMesa varchar(25),
inactive bit default 0,
Constraint pk_Mesa primary key(idMesa))

create table Orden(
idOrden int identity(1,1),
idMesa int not null,
Descripcion text,
Fecha Datetime,
inactive bit default 0,
Constraint pk_Orden primary key(idOrden),
Constraint fk_Orden_Mesa foreign key(idMesa) references Mesa(idMesa))

create table Detalle_Orden(
idOrden int not null,
idServicio int not null,
cantidad int not null,
Constraint pk_DetalleOrden primary key(idOrden,idServicio),
Constraint fk_DetalleOrden_idServicio foreign key (idServicio) references Servicio(idServicio),
Constraint fk_DetalleOrden_idOrden foreign key(idOrden) references Orden(idOrden))


/* Procedimiento para crear,Ver,Buscar, Actualizar y Eliminar Tipo de Alimento & Bebida y Visualizarlo */
go
create procedure crearTipoAB(@nombre varchar(25))
as
begin
insert into TipoAB values(@nombre,0);
end

go
create procedure verTipoAB
as
begin
Select * from TipoAB where inactive = 0
end
go

go
 create procedure buscarTipoAB(@idTipoAB int)
as
begin
select * from TipoAB where idTipoAB = @idTipoAB and inactive = 0
end 
go

go 
create procedure editarTipoAB(@idTipoAB int,@nombre varchar(25))
as
begin
update TipoAB set nombreAB = @nombre where idTipoAB = @idTipoAB
end
go

go
create procedure borrarTipoAB(@idTipoAB int)
as
begin
update TipoAB set inactive = 1 where idTipoAB = @idTipoAB
end
go

/* Procedimiento para crear,Buscar,Editar, Eliminar Tipo de Servicio y Visualizarlo */
go
create procedure crearTipoServicio(@idTipoAB int,@nombre varchar(25))
as
begin
insert into TipoServicio values(@idTipoAB,@nombre,0);
end

go
create procedure verTipoServicio
as
begin
Select tab.idTipoAB,tab.nombreAB,ts.idTipoServicio,ts.nombreTS,ts.inactive from TipoServicio ts inner join
TipoAB tab on ts.idTipoAB = tab.idTipoAB
end
go

 create procedure buscarTipoServicio(@idTipoServicio int)
as
begin
Select tab.idTipoAB,tab.nombreAB,ts.idTipoServicio,ts.nombreTS,ts.inactive from TipoServicio ts inner join
TipoAB tab on ts.idTipoAB = tab.idTipoAB where ts.idTipoServicio = @idTipoServicio and ts.inactive = 0
end 
go

go 
create procedure editarTipoServicio(@idTipoServicio int,@idTipoAB int,@nombre varchar(25))
as
begin
update TipoServicio set nombreTS = @nombre, idTipoAB = @idTipoAB where idTipoServicio = @idTipoServicio
end
go

go
create procedure borrarTipoServicio(@idTipoServicio int)
as
begin
update TipoServicio set inactive = 1 where idTipoServicio = @idTipoServicio
end
go



/* Procedimiento para crear,buscar,editar,eliminar Servicio y Visualizarlo */
go
create procedure crearServicio(@idTipoAB int,@idTipoServicio int,@nombre varchar(50),@descripcion text,@precio float,@tiempo int,@imagen text)
as
begin
insert into Servicio (idTipoAB,idTipoServicio,nombreServicio,descripcion,precio,tiempo,imagen,inactive)
 values(@idTipoAB,@idTipoServicio,@nombre,@descripcion,@precio,@tiempo,@imagen,0);
end

go
create procedure verServicio
as
begin
Select s.idServicio,tab.idTipoAB,tab.nombreAB,ts.idTipoServicio,ts.nombreTS,s.nombreServicio,s.descripcion,s.precio,
s.tiempo,s.imagen,s.inactive from Servicio s inner join
TipoAB tab on s.idTipoAB = tab.idTipoAB inner join TipoServicio ts on ts.idTipoServicio = s.idTipoServicio where s.inactive = 0
end
go
create procedure filtroServicioAB(@idTipoAB int)
as
begin
Select s.idServicio,tab.idTipoAB,tab.nombreAB,ts.idTipoServicio,ts.nombreTS,s.nombreServicio,s.descripcion,s.precio,s.tiempo,
s.imagen,s.inactive from Servicio s inner join
TipoAB tab on s.idTipoAB = tab.idTipoAB inner join TipoServicio ts on ts.idTipoServicio = s.idTipoServicio where s.inactive = 0 and s.idTipoAB = @idTipoAB
end
go
create procedure filtroServicioTS(@idTipoServicio int)
as
begin
Select s.idServicio,tab.idTipoAB,tab.nombreAB,ts.idTipoServicio,ts.nombreTS,s.nombreServicio,s.descripcion,s.precio,s.tiempo,
s.imagen,s.inactive from Servicio s inner join
TipoAB tab on s.idTipoAB = tab.idTipoAB inner join TipoServicio ts on ts.idTipoServicio = s.idTipoServicio where s.inactive = 0 
and s.idTipoServicio = @idTipoServicio
end
go
create procedure buscarServicio(@idServicio int)
as
begin
Select s.idServicio,tab.idTipoAB,tab.nombreAB,ts.idTipoServicio,ts.nombreTS,s.nombreServicio,s.descripcion,s.precio,s.tiempo,
s.imagen,s.inactive from Servicio s inner join
TipoAB tab on s.idTipoAB = tab.idTipoAB inner join TipoServicio ts on ts.idTipoServicio = s.idTipoServicio
 where s.idServicio = @idServicio and s.inactive = 0
end 
go

go 
create procedure editarServicio(@idServicio int,@idTipoAB int,@idTipoServicio int,@nombre varchar(50),@descripcion text,
@precio float,@tiempo int,@imagen text)
as
begin
update Servicio set nombreServicio = @nombre, idTipoAB = @idTipoAB,idTipoServicio = @idTipoServicio,
descripcion = @descripcion,precio = @precio,tiempo =@tiempo,imagen =@imagen  where idServicio = @idServicio
end
go

go
create procedure borrarServicio(@idServicio int)
as
begin
update Servicio set inactive = 1 where idServicio = @idServicio
end
go


/* Procedimiento para crear,buscar,editar,eliminar Mesa y Visualizarlo */
go
create procedure crearMesa(@nombre varchar(50))
as
begin
insert into Mesa values(@nombre,0);
end

go
create procedure verMesa
as
begin
Select * from Mesa where inactive = 0
end

go
create procedure buscarMesa(@idMesa int)
as
begin
Select * from Mesa where idMesa = @idMesa and inactive = 0
end 
go

go 
create procedure editarMesa(@idMesa int,@nombre varchar(25))
as
begin
update Mesa set nombreMesa = @nombre where idMesa = @idMesa
end
go

go
create procedure borrarMesa(@idMesa int)
as
begin
update Mesa set inactive = 1 where idMesa = @idMesa
end
go


/* Procedimiento para crear,editar,buscar,eliminar Orden y Visualizarlas */
go
create procedure crearOrden(@idMesa int,@descripcion text,@fecha DateTime)
as
begin
insert into Orden (idMesa,Descripcion,Fecha,inactive) values(@idMesa,@descripcion,@fecha,0);
end

go
create procedure verOrden
as
begin
select o.idOrden,m.idMesa,m.nombreMesa,o.Descripcion,o.fecha,o.inactive from Orden o inner join
Mesa m on o.idMesa = m.idMesa where o.inactive = 0
end

go
create procedure buscarOrden(@idOrden int)
as
begin
select o.idOrden,m.idMesa,m.nombreMesa,o.Descripcion,o.fecha,o.inactive from Orden o inner join
Mesa m on o.idMesa = m.idMesa where o.inactive = 0 and idOrden = @idOrden
end 
go

go 
create procedure editarOrden(@idOrden int,@idMesa int,@descripcion text,@fecha DateTime)
as
begin
update Orden set idMesa = @idMesa,Descripcion = @descripcion,Fecha = @fecha where idOrden = @idOrden
end
go

go
create procedure borrarOrden(@idOrden int)
as
begin
update Orden set inactive = 1 where idOrden = @idOrden
end
go

/* Procedimiento para crear Detalle de Orden y Visualizarlas */
go
create procedure crearDetalleOrden(@idOrden int,@idServicio int,@cantidad int)
as
begin
insert into Detalle_Orden values(@idOrden,@idServicio,@cantidad);
end

go
create procedure verDetalleOrden
as
begin
select do.idOrden,s.idServicio,s.nombreServicio,s.precio,do.cantidad,(do.cantidad * s.precio) as Total from
Detalle_Orden do inner join Servicio s on do.idServicio = s.idServicio
end

go
create procedure buscarDetalleOrden(@idOrden int)
as
begin
select do.idOrden,s.idServicio,s.nombreServicio,s.precio,do.cantidad,(do.cantidad * s.precio) as Total from
Detalle_Orden do inner join Servicio s on do.idServicio = s.idServicio where do.idOrden = 0 and do.idOrden = @idOrden
end 
go

go 
create procedure editarDetalleOrden(@idOrden int,@idServicio int,@cantidad int)
as
begin
update Detalle_Orden set idServicio = @idServicio,cantidad = @cantidad where idOrden = @idOrden and idServicio = @idServicio
end
go

go
create procedure borrarDetalleOrden(@idOrden int,@idServicio int)
as
begin
delete Detalle_Orden where idOrden =  @idOrden and idServicio = @idServicio
end
go

/* TESTEANDO PROCEDURES */
exec crearTipoAB 'Entradas'
exec crearTipoAB 'Bebidas'
exec crearTipoServicio 1,'Refrescos'
exec crearServicio 2,1,'Vino Tinto','Botella',750,10,'nada'
exec crearServicio 1,2,'Pan','Agua',750,10,'nada'
exec crearMesa 'Mesa 1'
exec crearOrden 1,'Freddy Soto','2017-06-20 09:34:00'
exec crearDetalleOrden 1,1,5

exec verTipoAB
exec verTipoServicio
exec verServicio
exec filtroServicioAB 1
exec verMesa
exec verOrden
exec verDetalleOrden

exec buscarTipoAB 1
exec buscarTipoServicio 1
exec buscarServicio 1
exec buscarMesa 1
exec buscarOrden 1
exec buscarDetalleOrden 1

exec editarTipoAB 1,'Plato Fuerte'
exec editarTipoServicio 1,1,'Refrescos'
exec editarServicio 1,1,1,'no lo se','tampoco se',77,7,'4'
exec editarMesa 1,'mesa 2'
exec editarOrden 1,1,'fulano','2017-06-20 09:34:00'
exec editarDetalleOrden 1,1,1

exec borrarTipoAB 1
exec borrarTipoServicio 1
exec borrarMesa 1
exec borrarOrden 1
exec borrarDetalleOrden 1,1

exec filtroServicioTS 2