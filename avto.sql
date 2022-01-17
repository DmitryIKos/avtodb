/*
	создать БД Автомобилей с таблицами:
	Продажи, Автомобили, Модель автомобиля
	Выбрать информацию о количестве и сумме продаж за 2020 год по:
	Типам автомобилей,
	Типам покупателей.
	Подвести итог
*/
--удаление базы данных
/*
drop table sell
go
drop table avto
go
drop table a_type
go

--создание базы
create table avto(
	id int identity primary key,
	price numeric(18,2),
	id_type int
)
go
create table sell(
	id int identity primary key,
	id_avto int,
	s_count int,
	s_date date,
	customer_type int
)
go
create table a_type(
	id int identity primary key,
	model nchar(10)
)
go
-- создание связей
alter table avto
add 
  constraint FK_Models
    foreign key (id_type) references a_type(id)
go

alter table sell
add
  constraint FK_sales
    foreign key (id_avto) references avto(id)
go

--ввод данных

insert into a_type (model)
  values
    ('mazda'),
	('mersedes'),
	('toyota'),
	('wv'),
	('opel')
go


insert into avto (price,id_type)
  values
    ('2000','1'),
	('5000','2'),
	('4000','4'),
	('5780','1'),
	('3400','5'),
	('1250','2'),
	('2300','3'),
	('7900','5')
go

insert into sell (id_avto,s_count,s_date,customer_type)
  values
    ('2','1', '01.12.2020','1'),
	('1','1', '15.05.2020','1'),
	('5','1', '20.07.2019','1'),
	('3','3', '04.11.2020','2'),
	('2','1', '25.02.2020','1'),
	('1','1', '12.03.2020','1'),
	('3','1', '19.08.2020','1'),
	('5','1', '14.02.2019','1')
go
*/
--------------------------------
select 1 as index_rep, 
'По типам авто' as type_rep, sum(s.s_count) as count_avto, 
sum(a.price*s.s_count) as sum_avto, 
 t.model as type_object, count(s.id) as rows_count
from a_type t
left join avto a on a.id_type=t.id
left join sell s  on s.id_avto=a.id 
where (s.s_date between '01.01.2020' and '31.12.2020') or s.s_date is null
group by t.model 

union

select 2 as index_rep, 'По типам покупателей' as type_rep, sum( s.s_count) as count_avto, 
sum(a.price*s.s_count) as sum_avto, 
(CASE   
      WHEN s.customer_type=1 THEN 'Физ.лицо'   
      WHEN s.customer_type=2 THEN 'Юр.лицо'   
   END   ) as type_object,
  count(s.id) as rows_count
   --type_object=iif(s.customer_type=1, 'Физ.лицо', 'Юр.лицо')
from sell s
left join avto a on a.id=s.id_avto
where s.s_date between '01.01.2020' and '31.12.2020'
group by s.customer_type
union

select 3 as index_rep, 'Итог' as type_rep, sum( s.s_count) as count_avto, 
sum(a.price*s.s_count) as sum_avto, 
   '' as type_object, count(s.id) as rows_count
from sell s
left join avto a on a.id=s.id_avto
where s.s_date between '01.01.2020' and '31.12.2020'

order by 1