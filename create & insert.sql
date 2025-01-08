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
Exist_Qnt int)

create table Employees( 
EID int primary key, 
F_name string,
L_name string,
W_hours int,
Age int not null,
Salary int)

create table E_numbers(
EID int foreign key references Employees,  
Phone_num string check (len(Phone_num) = 10),
primary key (EID, Phone_num))


create table Company(
CID int primary key,
C_name string, 
C_Address string, 
C_Arrive int not null, 
Rep_name string)

alter table Company 
add C_telephone string check(len(C_telephone) = 10)

create table Sell(
EID int foreign key references Employees,
Barcode int foreign key references Drugs, 
T_price int, 
Price_sale int default 0, 
Consumed int default 0, 
Con_date Datetime, 
primary key (EID, Barcode, Con_date))


create table Export(
Barcode int foreign key references Drugs, 
CID int foreign key references Company, 
Order_Qnty int default 0, 
O_date Datetime,
O_price int,
primary key (Barcode, O_date))

/* --------------------------------------------------- */

INSERT INTO  Drugs (barcode,D_name,Gen_name, Usage, D_type , Price ,Exist_Qnt)
 VALUES
( 1000, 'OLFEN',  'diclofenace', 'treat mild to moderate pain' ,'ampoule', 26.5 ,10),
( 1001, 'OLFEN', 'diclofenace'  , 'treat mild to moderate pain' , 'tablet' , 24 ,10),
( 1002, 'PREX','pregabalin' ,'management of neuropathic','capsoul' , 92,  10),
( 1003, 'Claritine'  , 'loratadine'   , 'antihistamine'  ,  'tablet' , 43 , 10 ),
( 1004, 'Claritine' , 'loratadine'  , 'antihistamine', 'syroup',  21,  	10 ),
( 1005, 'lorine',   'loratadine',  'antihistamine',  'tablet',  	16.8,   	10),
( 1006, 'lorine',   'loratadine',  'antihistamine',  'syroup', 16.8,10),
( 1007, 'epifenac',  ' diclofenac sodium',  'Analgesic and antipyretic', 'drop', 9, 10),
( 1008, 'epifenac',' diclofenac sodium', 'Analgesic and antipyretic', 'tablet', 12, 10),
( 1009, 'epifenac', 'diclofenac sodium',  'Analgesic and antipyretic',  'Supp',  8, 	10),
( 1010, 'epifenac' ,' diclofenac sodium ','Analgesic and antipyretic'  ,'ampoule',  18, 10),
( 1011, 'voltaren', 'diclofenac sodium', 'Analgesic and antipyretic',  'tablet', 45, 10),
( 1012, 'voltaren',  'diclofenac sodium', 'Analgesic and antipyretic' , 'sup',  9, 10),
( 1013, 'voltaren' ,'diclofenac sodium' ,'Analgesic and antipyretic', 'Amp', 58,	10),
( 1014, 'voltaren', 'diclofenac sodium', 'Analgesic and antipyretic', 'drop' ,  23.6, 10),
( 1015, 'antodine', 'famotidine',' Ulcers',  'tablet' , 58.5, 10),
( 1016, 'antodine', 'famotidine',  'Ulcers',  'ampoule',  27,  10),
( 1017, 'omez', 'omeprazole', 'Ulcers',  'capsoul' , 73,  10),
( 1018, 'pantoloc', 'pantoprazole',  'Ulcers'   ,'tablet'  ,21  ,  10),
( 1019, 'hibiotic',  'amoxicillin+clavulanic' , 'antibiotic', 'tablet', 91, 10 );


INSERT INTO Company (CID, C_name, C_telephone,  C_Address, C_Arrive, Rep_name)
VALUES
		(1, 'Ibnsina pharma', '1552345341', ' EL Mahala', 1, 'Ahmed Alaa' ),
		(2, 'Degla pharm', '1227472055', 'Alexandria', 7, 'Ali Farag' ),
		(3, 'Pharco', '0502331030', 'El Mansora', 2, 'Mona Ahmed' ),
		(4, 'Promise Pharma', '1014449490', 'Kafrelsheikh', 2, 'Ali Salem' ),
		(5, 'Pharma Plus', '1025689357', 'Tanta', 1, 'Michael Hamdy'),
		(6, 'Ramacin', '1141601065', 'El Mansora', 2, 'Doha Abdullah'),
		(7, 'Elixir pharma Delta office', '4035774102', 'Tanta', 1, 'Hassan Sabry'),
		(8, 'Beta Pharm', '3412050101', 'Cairo', 4, 'Adel Seleem' ),
		(9, 'Adwia SAE', '3330222135', 'Cairo', 4,'Maged Sobhy' ),
		(10, 'Amecath', '3033122231', 'Cairo', 4, 'Yara Saied');


INSERT INTO Employees (EID ,F_name ,L_name ,W_hours ,Age ,Salary)
values
		(10, 'Vishal', 'Verma',5,24,2500),
		(11,'Vivek', 'Diwan',5,23,2500),
		(12,'Ahmed','Samy',7,35,2520),
		(13,'Maged','Keshk',7,31,2520),
		(14,'Yasser','Ali',8,37,2530);


INSERT INTO E_numbers (EID,Phone_num )
values
		(10,'1035667866'),	(10,'1156357989'),
		(11,'1025896217'),
		(12,'1535795216'),	(12,'1235798567'),	(12,'1135678953'),
		(13,'1056479823'),
		(14,'1235676535'),	(14,'1154879536');


INSERT INTO  Sell (EID, Barcode, T_price, Price_sale, Consumed, Con_date)
 VALUES
		( 10, 1000, 79.5, 63.6, 3, '2022-12-03 05:35:24'),
		( 10, 1000, 79.5, 63.6, 3, '2022-12 -04 04:22:12' ),
		( 12, 1009, 8 , 6.4, 5, '2022-12-21 04:22:12' ),
		( 14, 1004,  21,  16.8, 3, '2022-10-11 04:22:12'),
		( 12, 1009, 8 ,6.4, 3, '2023-1-5 04:22:12'),
		( 13, 1008, 48, 38.4, 4, '2022-05-01 06:20:29'),
		( 11, 1003, 258, 206.4, 6,  '2022-08-20 11:43:50'),
		( 14, 1018, 42, 33.6, 2, '2022-10-15 09:15:00');


INSERT INTO Export(Barcode ,CID, Order_Qnty, O_date, O_price)
Values 
		(1000, 5, 100, '2018-02-12 10:25:25', 1500),
		(1015, 7, 125, '2020-06-17 05:36:01', 5000),
		(1015, 7, 125, '2019-12-15 07:57:51', 5000),
		(1010, 3, 300, '2022-01-25 03:10:18', 2500),
		(1012, 5, 2000, '2020-02-05 05:16:00', 15000),
		(1009, 7, 1000, '2021-10-05 12:05:01', 5000);