# avtodb 
<p/>Задача:
	<br>Создать БД Автомобилей с таблицами:
	
	 -  Продажи
	 -  Автомобили
	 -  Модель автомобиля
Выбрать информацию о количестве и сумме продаж за 2020 год по:


	  - Типам автомобилей,
	  - Типам покупателей.
  	  - Подвести итог
	  
	  
    Создать отчет, содержащий данные последних продаж используя предложение OVER. 
    
  
    
 Для решения задачи используем 3 таблицы связанные между собой:
 
 Avto (id, price, id_type) номер, цена, тип автомобиля (из справочника автомобилей a_type)
 
 
 a_type (id, model)  номер автомобиля в справочнике и модель автомобиля
 
 
 sell (id_avto, s_count, s_date, customer_type)  номер автомобиля из таблицы Avto, количество, дата продажи, тип покупателя (юр. либо физ. лицо)
 
 [Скрипт по созданию](https://github.com/DmitryIKos/avtodb/blob/main/create.sql)


При вводе данных в таблицу возникла неопрделенность с датами ввиду различных настроек локали серверов SQL.

Для устранения неверного ввода было применено преобразование данных в формат DATE

[скрипт ввода данных](https://github.com/DmitryIKos/avtodb/blob/main/ins_data.sql)

Получили таблицы
<p/>
<img src=https://github.com/DmitryIKos/avtodb/blob/main/avto.JPG alt="автомобили">
<img src=https://github.com/DmitryIKos/avtodb/blob/main/a_type.JPG>
<img src=https://github.com/DmitryIKos/avtodb/blob/main/sell.JPG></p>

Автомобили Avto               справочник автомобилей a_type         продажи Sell


Отчеты обьеденены в общую таблицу с помощью UNION

[скрипт выполнения запросов](https://github.com/DmitryIKos/avtodb/blob/main/sel.sql)
<br>
<img src=https://github.com/DmitryIKos/avtodb/blob/main/sel.JPG>
<br><img src=https://github.com/DmitryIKos/avtodb/blob/main/sel2.JPG>

