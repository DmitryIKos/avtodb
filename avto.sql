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
drop table avto
drop table a_type
drop database Avto
--создание базы

create table avto(
	id int identity primary key,
	price numeric(18,2),
	id_type int
)

create table sell(
	id int identity primary key,
	id_avto int,
	s_count int,
	s_date date,
	customer_type int
)

create table a_type(
	id int identity primary key,
	model nchar(10)
)

-- создание связей
alter table avto
add 
  constraint FK_Models
    foreign key (id_type) references a_type(id)


alter table sell
add
  constraint FK_sales
    foreign key (id_avto) references avto(id)


--ввод данных

insert into a_type (model)
  values
    ('mazda'),
	('mersedes'),
	('toyota'),
	('wv'),
	('opel')



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


*/
--------------------------------
select 1 as 'Номер отчета', 
'По типам авто' as 'Название отчета', 
isnull(sum(s.s_count), 0) as 'Кол-во авто',
isnull(sum(a.price*s.s_count), 0) as 'Сумма', 
 t.model as 'Марка', count(s.id) as 'К-во продаж'
from a_type t
left join avto a on a.id_type=t.id
left join sell s  on s.id_avto=a.id 
where (s.s_date between CONVERT(date,'01.01.2020',104) and CONVERT(date,'31.12.2020',104) or s.s_date IS NULL )
	
group by t.model 

union

select 2 as 'Номер отчета', 'По типам покупателей' as  'Название отчета', sum( s.s_count) as 'Кол-во авто', 
sum(a.price*s.s_count) as 'Сумма', 
(CASE   
      WHEN s.customer_type=1 THEN 'Физ.лицо'   
      WHEN s.customer_type=2 THEN 'Юр.лицо'  
   END   ) as 'Марка',
  count(s.id) as 'К-во продаж'
from sell s
left join avto a on a.id=s.id_avto
where s.s_date between CONVERT(date,'01.01.2020',104) and CONVERT(date,'31.12.2020',104)
group by s.customer_type
union

select 3 as 'Номер отчета', 'Итог' as  'Название отчета', sum( s.s_count) as 'Кол-во авто', 
sum(a.price*s.s_count) as 'Сумма', 
   '' as type_object, count(s.id) as 'К-во продаж'
from sell s
left join avto a on a.id=s.id_avto
where s.s_date between  CONVERT(date,'01.01.2020',104) and CONVERT(date,'31.12.2020',104)

order by 1
/*
 сделать отчет, содержащий данные последних продаж используя предложение OVER. 
*/


select 
distinct
s.id,t.id, t.model as 'марка', s.s_count as 'количество', a.price as 'цена',
	sum(s.s_count) over(partition by s.id_avto) as 'Кол-во проданных авто данной марки',
	sum(s.s_count*a.price) over(partition by a.id) as 'Сумма',
	count(s.id_avto) over(partition by s.id_avto) as 'К-во продаж', 
	max(s.s_date) over(partition by s.id_avto) as 'посл продажа'
 
from sell s
left join avto a on a.id=s.id_avto
left join a_type t on t.id=a.id_type 

--group by s.id
order by t.model