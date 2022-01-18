/*
	������� �� ����������� � ���������:
	�������, ����������, ������ ����������
	������� ���������� � ���������� � ����� ������ �� 2020 ��� ��:
	����� �����������,
	����� �����������.
	�������� ����
*/
--�������� ���� ������

/*
alter table avto drop constraint   FK_Models
alter table sell drop constraint   FK_Sales

drop table avto
drop table a_type
drop table sell

--drop database Avto
--�������� ����
-- create database Avto
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

-- �������� ������
alter table avto
add 
  constraint FK_Models
    foreign key (id_type) references a_type(id)


alter table sell
add
  constraint FK_sales
    foreign key (id_avto) references avto(id)


--���� ������

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
    ('2','1',CONVERT(date,'01.12.2020',104),'1'),
	('1','1',CONVERT(date,'15.05.2020',104),'1'),
	('5','1',CONVERT(date,'20.07.2019',104),'1'),
	('3','3',CONVERT(date,'04.11.2020',104),'2'),
	('2','1',CONVERT(date,'25.02.2020',104),'1'),
	('1','1',CONVERT(date,'12.03.2020',104),'1'),
	('3','1',CONVERT(date,'19.08.2020',104),'1'),
	('5','1',CONVERT(date,'14.02.2019',104),'1')
*/


--------------------------------
select 1 as '����� ������', 
'�� ����� ����' as '�������� ������', 
isnull(sum(s.s_count), 0) as '���-�� ����',
isnull(sum(a.price*s.s_count), 0) as '�����', 
 t.model as '�����', count(s.id) as '�-�� ������'
from a_type t
left join avto a on a.id_type=t.id
left join sell s  on s.id_avto=a.id 
where (s.s_date between CONVERT(date,'01.01.2020',104) and CONVERT(date,'31.12.2020',104) or s.s_date IS NULL )
	
group by t.model 

union

select 2 as '����� ������', '�� ����� �����������' as  '�������� ������', sum( s.s_count) as '���-�� ����', 
sum(a.price*s.s_count) as '�����', 
(CASE   
      WHEN s.customer_type=1 THEN '���.����'   
      WHEN s.customer_type=2 THEN '��.����'  
   END   ) as '�����',
  count(s.id) as '�-�� ������'
from sell s
left join avto a on a.id=s.id_avto
where s.s_date between CONVERT(date,'01.01.2020',104) and CONVERT(date,'31.12.2020',104)
group by s.customer_type
union

select 3 as '����� ������', '����' as  '�������� ������', sum( s.s_count) as '���-�� ����', 
sum(a.price*s.s_count) as '�����', 
   '' as type_object, count(s.id) as '�-�� ������'
from sell s
left join avto a on a.id=s.id_avto
where s.s_date between  CONVERT(date,'01.01.2020',104) and CONVERT(date,'31.12.2020',104)

order by 1
/*
 ������� �����, ���������� ������ ��������� ������ ��������� ����������� OVER. 
*/


select 
distinct
s.id,t.id, t.model as '�����', s.s_count as '����������', a.price as '����',
	sum(s.s_count) over(partition by s.id_avto) as '���-�� ��������� ���� ������ �����',
	sum(s.s_count*a.price) over(partition by a.id) as '�����',
	count(s.id_avto) over(partition by s.id_avto) as '�-�� ������', 
	max(s.s_date) over(partition by s.id_avto) as '���� �������'
 
from sell s
left join avto a on a.id=s.id_avto
left join a_type t on t.id=a.id_type 


order by t.model