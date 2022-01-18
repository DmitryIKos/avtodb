
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