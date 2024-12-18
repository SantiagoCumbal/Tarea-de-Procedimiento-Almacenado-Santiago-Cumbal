CREATE DATABASE GestionClientes;
USE GestionClientes;
CREATE TABLE cliente (
    ClienteID INT AUTO_INCREMENT PRIMARY KEY,  
    Nombre VARCHAR(100),                      
    Estatura DECIMAL(5,2),                    
    FechaNacimiento DATE,                     
    Sueldo DECIMAL(10,2)                      
);

INSERT INTO cliente (Nombre, Estatura, FechaNacimiento, Sueldo) VALUES
('Carlos Gómez', 1.80, '1992-03-15', 3200.50),
('Ana Martínez', 1.65, '1988-07-20', 2800.75),
('Luis Fernández', 1.75, '1995-11-30', 2500.00),
('Sofía Torres', 1.62, '1990-05-10', 3100.25),
('Miguel Sánchez', 1.85, '1987-01-25', 3500.00);


delimiter $$
create procedure ObtenerClientes()
begin
    select * from cliente;
end$$
delimiter ;
call ObtenerClientes();

delimiter $$
create procedure InsertarCliente( in Nombre varchar(100), in Estatura decimal(5,2), in FechaNacimiento date, in Sueldo decimal(10,2))
begin
    insert into cliente (Nombre, Estatura, FechaNacimiento, Sueldo) values (Nombre, Estatura, FechaNacimiento, Sueldo);
end$$
delimiter ;

call InsertarCliente('Juan Pérez', 1.75, '1990-05-10', 2500.00);
call ObtenerClientes();

delimiter $$
create procedure ActualizarSueldo(in p_ClienteID int, in p_NuevoSueldo decimal(10,2))
begin
    update cliente set Sueldo = p_NuevoSueldo where ClienteID = p_ClienteID;
end$$
delimiter ;

call ActualizarSueldo(1, 3000.00);
call ObtenerClientes();

delimiter $$
create procedure EliminarCliente( in p_ClienteID int )
begin
    delete from cliente where ClienteID = p_ClienteID;
end$$
delimiter ;
call EliminarCliente(1);


CALL VerificarEdad('2000-01-01', @resultado);
SELECT @resultado;

CREATE TABLE ordenes (
    OrdenID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT,
    FechaOrden DATE,
    MontoTotal DECIMAL(10,2),
    FOREIGN KEY (ClienteID) REFERENCES cliente(ClienteID)
);

DELIMITER $$
CREATE PROCEDURE InsertarOrden(IN p_ClienteID INT, IN p_FechaOrden DATE, IN p_MontoTotal DECIMAL(10,2))
BEGIN
    INSERT INTO ordenes (ClienteID, FechaOrden, MontoTotal)
    VALUES (p_ClienteID, p_FechaOrden, p_MontoTotal);
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE ActualizarOrden(IN p_OrdenID INT, IN p_NuevoMonto DECIMAL(10,2))
BEGIN
    UPDATE ordenes
    SET MontoTotal = p_NuevoMonto
    WHERE OrdenID = p_OrdenID;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE EliminarOrden(IN p_OrdenID INT)
BEGIN
    DELETE FROM ordenes
    WHERE OrdenID = p_OrdenID;
END$$
DELIMITER ;
