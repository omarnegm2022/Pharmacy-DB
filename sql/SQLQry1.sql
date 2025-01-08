create database pharmacy
go
use pharmacy
create type string from varchar(30);
create table Drugs (
Barcode int primary key,
D_name string,
Gen_name string not null, 
Usage string,
D_type string,
Price float,
Exist_Qnt int )

create table Employees(
EID int primary key,
F_name string,
L_name string,
W_hours int,
Age int not null,
Salary int)

create table E_numbers (
EID int  foreign key references Employees,
Phone_num string check (len(Phone_num) = 10),
 primary key(EID, Phone_num) )

 create table Company (
 CID int primary key,
 C_name string,
 C_Address string,
 C_Arrive int not null,
 Rep_name string)
/* we made telephone of company as single-valued, not as in ER -for simplicty-*/
 alter table Company 
 add C_telephone string check( len(C_telephone) = 10)

--* drop E_telephone to change the constraint to the proper 
--drop table E_numbers

create table Sell(

EID int foreign key references Employees,
Barcode int foreign key references Drugs,
T_price int,
Price_sale int default 0,
Consumed int default 0,
Con_date Datetime,
primary key(EID,Barcode,Con_date)
)
drop  table Sell





create table Export(
Barcode int foreign key references Drugs,
CID int foreign key references Company,
Order_Qnty int default 0,
O_date datetime,
O_price int,
primary key(Barcode,O_date)
)
drop table Export

-- 20 drugs, 10 companies, 5 employees

-- 5:30 or 8:00