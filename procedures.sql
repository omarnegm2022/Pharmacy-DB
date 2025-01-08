use pharmacy
--Here, we define functions, triggers, procedures, transactions and views used on the database

go	--		FUNCTIONS	--
create function Get_AnnualSalary()
returns table
as	-- This functions gets the monthly Salary of each employee from the database and gives his salary in year
return (

	select F_name + ' ' + L_name as full_name,
	Salary*12 as annual_salary
	from Employees	)
-- end of function Get_drugNames creation

/*Use this query to try the function:
	select* from dbo.Get_AnnualSalary()
*/
go
create function Get_drugNames(@G_name string)
returns table
as	-- This function gets the generic name(Gen_name) of the drug and gives all info about related drugs from the database.
return(
	select *
	from Drugs
	where Gen_name = @G_name	)
-- end of function Get_drugNames creation

/*Use this query to try the function: #remember that returns all info, not just the name
select * from dbo.Get_drugNames('loratadine')
*/
go	-- end of FUNCTIONS ,	next: TRIGGERS	--
create trigger D_quantity
on Sell
After insert
as	/* This trigger used on each sell insertion(one tuple at operation)
 to modify the exist_quantity in Drugs table according to the recent inserted tuple in the Sell tuple. */
begin
declare @number int; -- consumed quantity
declare @code int;	-- barcode of drug
select @number = i.Consumed , @code = i.Barcode
from inserted i;	-- a table created by the program at execution of the trigger.
update Drugs 
set Drugs.Exist_Qnt = Drugs.Exist_Qnt - @number
where @code = Drugs.Barcode
-- Those queries below to show the result of trigger
select Exist_Qnt
from Drugs
where Barcode = @code

select *
from Sell
where Barcode = @code 
end	-- end of trigger D_quantity creation

/* If you want to disable this trigger, execute the following:
	drop trigger D_quantity
*/

/*Use this query to try the trigger:
	insert into Sell (Barcode,EID,Con_date,Consumed)
			values(1000,13,'2022-12-03 12:35:24',2)
--We decided that the sell operation is for one kind of drugs at a time.
*/
go		--		end of TRIGGERS ,	next: PROCEDURES	--
create procedure buy
--The following are the attributes of Sell table(except @D_price is of one item of drug):
@B_code int, @con int,	@D_price float, @sale float, @date datetime, @ID int
as	-- This procedure is created to be executed in a transaction, as realistic buying process
begin
declare @T_price float
set @T_price = @con *@D_price	-- gets the total price

insert into Sell (Barcode,EID,Con_date,Consumed,T_price,Price_sale)
values (@B_code,@ID,@date, @con,@T_price, @T_price*(1-@sale))  
end	-- end of procedure buy creation
go

/* Just if you want to replace this procedure with another one:
	drop procedure buy
*/
create procedure set_salary 
@hrs int, @ID int, @age int
as	-- This procedure is used to set the value of the derived_attribute: Salary in Employees table
begin
-- This procedure is only applicable for newly added employees.
	insert into Employees (EID,W_hours,Age)
	values(@ID,@hrs,@age)
	update Employees
	set Salary = 2500 +((@hrs-5)*10)
	where EID = @ID
end	-- end of procedure set_salary creation

/* Use the procedure:
execute set_salary @hrs = 7, @ID = 15, @age = 19
*/
/*Show the result of the procedure:
	select *
	from Employees
	where EID = 15
*/

/* If you want to modify this procedure -from scratch-:
	drop procedure set_salary
*/
go		--		end of PROCEDURES ,	next: TRANSACTIONS	--
begin transaction -- transaction of buying
declare @q_check int;	--used to decide completion of transaction
declare @B int = 1001;	-- to get the Barcode from the procedure

execute buy @B_code = @B, @con = 15, @D_price = 26.5, @sale = .20, @date = '2015-12-03 12:35:10',
		@ID = 13;

select @q_check = Drugs.Exist_Qnt
from Drugs
where Drugs.Barcode = @B

if @q_check >= 0	
-- i.e. consumed quantity is less than or equal the available quantity of this drug in the pharmacy
commit
else
rollback 
-- end ofnbuying transaction

/* To ensure the transaction is valid, use this query:
	--(Firstly modify @con in the execute command)
	select *
	from Drugs
	where Barcode = 1001	-- set the barcode of the drug as chosen in the transaction body.
*/
go		--		end of TRANSACTIONS ,	finally: VIEWS	--
create view Stock as
-- It shows only the drug name and the available quantity in the pharmacy, to know if we need to order some from the company.
select D_name, Exist_Qnt
from Drugs
go

/* Try the view:
	select *
	from Stock
*/
create view delivery as
-- It shows necessary information about companies to choose a specific one for an urgent request of drugs.
select C_name,C_Arrive,Rep_name,('0' + ''+C_telephone) as rep_telephone
from Company

/* If this view is not necessary:
	drop view delivery
*/

/* Try the delivery view:
	select *
	from delivery
*/
go		--		end of VIEWS	--

/* snippets while implementing the project */
--delete from Sell
--delete from Drugs
--params: consumed, drug_price
--function to get reciep for what have been bought before, by datetime.

create procedure emp_sell
@emp_name string	--searches only by first name.
as
begin
select Employees.F_name, Employees.L_name, sum(sell.Consumed) as num_drugs
from Sell join Employees on sell.EID = Employees.EID
where Employees.F_name = @emp_name
group by Employees.F_name, Employees.L_name
end 

execute emp_sell @emp_name = 'Ahmed'

-- drop procedure emp_sell
