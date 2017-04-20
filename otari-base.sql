drop database if exists otariB;
create database otariB;
use otariB;

create table Usuario(idUsuario int(6) auto_increment primary key, tipo varchar(20), nombre varchar(20), edad varchar(2), direccion varchar(30), 
contra varchar(50), correo varchar(40));

create table Menu(idMe int(3) auto_increment primary key, entrada varchar(20), principal varchar(20), postre varchar(20), bebidas varchar(20), foto blob );

create table Musica(idMu int(3) auto_increment primary key, genero varchar(20), personal varchar(20));

create table Decoracion(idProd int(4) auto_increment primary key, nombre varchar(50), precio float(6), descripcion varchar(50), foto blob);
 
create table Evento(idEvento int(4) auto_increment primary key, idUcreador int(6), fechaRegistro TIMESTAMP 
DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, nombre varchar(30),
fechaEvento datetime, lugar varchar(50), tipo varchar(20), invitados int(4), idMenu int(3), HoraI nvarchar(5), HoraF nvarchar(5), 
idMusica int(3), foreign key (idMenu) references Menu(idMe), foreign key(idMusica) references Musica(idMu));

drop procedure if exists AgregarUsuario;
delimiter //
create procedure AgregarUsuario(
in tip varchar(20), nom varchar(20), año varchar(2), direc varchar(30), con varchar(50), cor varchar(40))
begin
/*if(nom=" " ||*/
insert into Usuario(tipo, nombre, edad, direccion, contra, correo) values (tip, nom, año, direc, md5(con), cor);
end //
delimiter ;

drop procedure if exists AgregarEvento;
delimiter //
create procedure AgregarEvento(nombre varchar(30),lug varchar(50), tip varchar(20), inv int(4) , fechaEvento datetime , horaI nvarchar (5), horaF nvarchar(5))
begin
insert into Evento(nombre,lugar, tipo, invitados , fechaEvento ,  HoraI, HoraF ) values (nombre,lug, tip, inv , fechaEvento , horaI, horaF);
end //
delimiter ;

drop procedure if exists AgregarMusica;
delimiter //
create procedure AgregarMusica(gen varchar(20), per varchar(20))
begin
insert into Musica(genero, personal) values (gen, per);
end //

delimiter ;

drop procedure if exists AgregarProd;
delimiter //
create procedure AgregarMenu(ent varchar(20),  prin varchar(20), pos varchar(20), beb varchar(20), fot blob)
begin
insert into Menu(entrada, principal, postre, bebidas, foto) values (ent, prin, pos, beb, fot);
end //
delimiter ;
 
drop procedure if exists AgregarProd;
delimiter //
create procedure AgregarProd(nom varchar(50), pres float(6), descr varchar(50), fot blob)
begin
insert into Decoracion(nombre, precio, descripcion, foto) values (nom, pres, descr, fot);
end //
delimiter ;

drop procedure if exists AgregarMusEve;
delimiter //
create procedure AgregarMusEve(nom varchar(50), ent varchar(20), fuer varchar(20), pos varchar(20), beb varchar(29), mus varchar(20))
begin
insert into Evento.idMusica select Musica.idMu from Musica where Musica.genero = mus and Evento.nombre = nom;
insert into Menu(entrada, principal, postre, bebidas) values (ent,fuer, pos, beb);
insert into Evento(idMe) select Menu.id from Menu where Menu(entrada)=ent and Menu(principar)=fuer and Menu(postre)=pos and Menu(bebidas)=beb and Evento(nombre)=nom;
end //
delimiter ;

call AgregarUsuario('Administrador','Edgar',17,'Av. 679 no. 65', 'wasa', 'edgar_a_villa@hotmail.com');
call AgregarUsuario('Administrador','Diego',17,'no se','wase','no se');
call AgregarUsuario('Administrador','Ximi',17,'no se','wasi','no se');
call AgregarUsuario('Administrador','Raul',17,'no se','waso','no se');
call AgregarUsuario('Cliente','Chucho', 19,'Av. de los prados', 'wasu','chucho678@hotmail.com');

call AgregarMusica('bachata', 'un wey');
call AgregarMusica('Rock', 'otro wey');
call AgregarMusica('Banda', 'ese wey');
call AgregarMusica('Electronica', 'ese otro wey');

call AgregarMenu('ensalada', 'pavo', 'pastel', 'vino', 'foto');
call AgregarMenu('sopa', 'res', 'fruta en almivar', 'Agua', 'foto');
call AgregarMenu('fruta', 'huevo', 'yougurt', 'jugo', 'foto');

call AgregarEvento('pruba', 'lugarp', 'prueba', 60, 12/09/2015, '7:30', '8:30');

select * from Usuario;
select * from Evento;

select * from Menu;
select * from Decoracion;
select * from Musica;

/*select Musica.idMu from Musica where Musica.genero = 'bachata';