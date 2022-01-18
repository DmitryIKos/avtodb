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


order by t.model