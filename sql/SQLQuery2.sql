use pharmacy
 create trigger trial
 on Export
after Insert
 as begin

update Export
set Barcode = 1
where O_date = '2020-06-17 05:36:01'

 end

  drop trigger trial
