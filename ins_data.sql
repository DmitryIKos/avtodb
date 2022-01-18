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
    ('2','1',CONVERT(date,'01.12.2020',104),'1'),
	('1','1',CONVERT(date,'15.05.2020',104),'1'),
	('5','1',CONVERT(date,'20.07.2019',104),'1'),
	('3','3',CONVERT(date,'04.11.2020',104),'2'),
	('2','1',CONVERT(date,'25.02.2020',104),'1'),
	('1','1',CONVERT(date,'12.03.2020',104),'1'),
	('3','1',CONVERT(date,'19.08.2020',104),'1'),
	('5','1',CONVERT(date,'14.02.2019',104),'1')