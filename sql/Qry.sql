use pharmacy
/*
select *
from Drugs
select * 
from Sell
select *
from Employees
select *
from E_numbers
select *
from Export
select *
from Company

Ctrl+C
for copy
Ctrl+X
for cut
Ctrl+V
for paste
*/

-- select the most expensive drug of each Gen_name
select Gen_name, max(Price) as max_price
from Drugs
group by Gen_name

--
create table trial( id int primary key,
ad char(5), constraint abc check(ad <> 'a'))

drop table trial
alter table trial
drop constraint abc

insert into trial values (1,'a')
--

/*select all attrib from company where the pharmacy Export orders with price 5000*/
select  distinct Co.CID, Co.C_name, Co.C_Address, Co.C_Arrive, Co.Rep_name, Co.C_telephone
from Company Co join Export Ex on Co.CID = Ex.CID
where  Ex.O_price = 5000

/*select all drugs that begin with ‘o’ alphapet*/
select * 
from Drugs
where D_name in(select D.D_name
	from Drugs D
	where D.D_name like 'O%' and D.Exist_Qnt > 0)

/*select */
select S1.Con_date,S1.Price_sale as S_income
from Sell S1
-- [top 1]: order by S1.T_price - S1.Price_sale desc
where S1.Price_sale = any(select max(S2.Price_sale)
	from Sell S2)

/*select */
select Ex.O_date, Ex.Order_Qnty, S.Consumed, S.Con_date, S.Price_sale - Ex.O_price as phar_income
--phar_income is the required
from Export Ex join Sell S on Ex.Barcode = S.Barcode
-- I execluded the salary from the calculation

/*select */
select	top 1 Drugs.D_name, Drugs.Gen_name, Drugs.Price, Sell.Consumed
from Sell join Drugs on Sell.Barcode = Drugs.Barcode
order by Sell.Consumed desc

/*select */
select top 1 with ties Company.C_Arrive,Company.C_name, Company.C_telephone
from Company
order by C_Arrive