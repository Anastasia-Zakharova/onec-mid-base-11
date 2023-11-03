
#Область ПрограммныйИнтерфейс
//+++Захарова: ДополнительныйОбщийМодуль вызывается в Общем Модуле "ПодключаемыеКоманды.ПриСозданииНаСервере".

//Добавить дополнительные реквизиты и команду в зависимости от выбранного документа
Процедура ДоработатьФормыДокументов(Форма) Экспорт
//Добавить дополнительные реквизиты и команду в зависимости от выбранного документа
	
	ИмяФормы = Форма.ИмяФормы;
	
	Если ИмяФормы = "Документ.ЗаказПокупателя.Форма.ФормаДокумента" Тогда
		ДобавитьПолеКонтактноеЛицоВГруппаШапкаПраво(Форма);
		ДобавитьПолеСогласованнаяСкидкаИКомандуПересчитатьТаблицуВГруппаСкидки(Форма)
	ИначеЕсли ИмяФормы = "Документ.ПоступлениеТоваровУслуг.Форма.ФормаДокумента" Тогда
		ДобавитьПолеКонтактноеЛицоВГруппаШапкаПраво(Форма);
	ИначеЕсли ИмяФормы = "Документ.РеализацияТоваровУслуг.Форма.ФормаДокумента" Тогда
		ДобавитьПолеКонтактноеЛицоВГруппаШапкаПраво(Форма);
	ИначеЕсли ИмяФормы = "Документ.ОплатаОтПокупателя.Форма.ФормаДокумента" Тогда
		ВставитПолеКонтактноеЛицоНаФормуПередОснование(Форма);
	ИначеЕсли ИмяФормы = "Документ.ОплатаПоставщику.Форма.ФормаДокумента" Тогда
		ВставитПолеКонтактноеЛицоНаФормуПередСуммаДокумента(Форма);
	КонецЕсли;
	
КонецПроцедуры

//---Захарова
#КонецОбласти

#Область СлужебныеПроцедурыИФункции
//+++Захарова: Дополнительные СлужебныеПроцедурыИФункции

Процедура ДобавитьПолеКонтактноеЛицоВГруппаШапкаПраво(Форма)
//Добавить НовоеПолеВвода на Формы Документов "ЗаказПокупателя", "ПоступлениеТоваровУслуг","РеализацияТоваровУслуг"
	
	НовоеПолеВвода =Форма.Элементы.Добавить("КонтактноеЛицо", Тип("ПолеФормы"), Форма.Элементы.ГруппаШапкаПраво);
	НовоеПолеВвода_Вид_ПутьКДанным(НовоеПолеВвода);
	
КонецПроцедуры

Процедура ВставитПолеКонтактноеЛицоНаФормуПередОснование(Форма)
//Добавить НовоеПолеВвода на Форму Документа "ОплатаОтПокупателя"
	
	НовоеПолеВвода = Форма.Элементы.Вставить("ДЗ_КонтактноеЛицо", Тип("ПолеФормы"),, Форма.Элементы.Основание);
	НовоеПолеВвода_Вид_ПутьКДанным(НовоеПолеВвода);
	
КонецПроцедуры

Процедура ВставитПолеКонтактноеЛицоНаФормуПередСуммаДокумента(Форма)
//Добавить НовоеПолеВвода на Форму Документа "ОплатаПоставщику"
	
	НовоеПолеВвода = Форма.Элементы.Вставить("ДЗ_КонтактноеЛицо", Тип("ПолеФормы"),, Форма.Элементы.СуммаДокумента);
	НовоеПолеВвода_Вид_ПутьКДанным(НовоеПолеВвода);
	
КонецПроцедуры

Процедура НовоеПолеВвода_Вид_ПутьКДанным(НовоеПолеВвода)
//Устанавить Вид и ПутьКДанным для НовоеПолеВвода "КонтактноеЛицо"
	
	НовоеПолеВвода.Вид = ВидПоляФормы.ПолеВвода; 
	НовоеПолеВвода.ПутьКДанным = "Объект.ДЗ_КонтактноеЛицо";
	
КонецПроцедуры

Процедура ДобавитьПолеСогласованнаяСкидкаИКомандуПересчитатьТаблицуВГруппаСкидки(Форма)
//Добавить на ФормуДокумента "ЗаказПокупателя":
//Группы "ГруппаСкидка", Реквизита "СогласованнаяСкидка", Команды "ПересчитатьТаблицу"
	
	ГруппаСкидки = СоздатьГруппаСкидок(Форма);
	
	ДобавитьРеквизитСогласованнаяСкидка(ГруппаСкидки, Форма);
	
	СоздатьКомандуПересчитатьТаблицу(ГруппаСкидки, Форма);
	
КонецПроцедуры

Функция СоздатьГруппаСкидок(Форма)
//Добавить на ФормуДокумента Группу "ГруппаСкидка"
	
	ГруппаСкидки =Форма.Элементы.Добавить("ГруппаСкидки",Тип("ГруппаФормы"),Форма);
	Форма.Элементы.Переместить(ГруппаСкидки, Форма.Элементы.ГруппаШапкаЛево);
	ГруппаСкидки.Вид = ВидГруппыФормы.ОбычнаяГруппа;
	ГруппаСкидки.Отображение = ОтображениеОбычнойГруппы.Нет;
	ГруппаСкидки.Группировка = ГруппировкаПодчиненныхЭлементовФормы.ГоризонтальнаяВсегда;
	ГруппаСкидки.ОтображатьЗаголовок = Ложь;
	
	Возврат ГруппаСкидки;
	
КонецФункции

Процедура ДобавитьРеквизитСогласованнаяСкидка(ГруппаСкидки, Форма)
//Добавить на ФормуДокумента Реквизит "СогласованнаяСкидка"
	
	НовыйЭлемент =Форма.Элементы.Добавить("СогласованнаяСкидка",Тип("ПолеФормы"),ГруппаСкидки);
	НовыйЭлемент.Вид = ВидПоляФормы.ПолеВвода;
	НовыйЭлемент.ПутьКДанным = "Объект.ДЗ_СогласованнаяСкидка";
	НовыйЭлемент.УстановитьДействие("ПриИзменении","ДЗ_ПриИзмененииСогласованнаяСкидка");
	
КонецПроцедуры

Процедура СоздатьКомандуПересчитатьТаблицу(ГруппаСкидки, Форма)
//Добавить на ФормуДокумента Команду "ПересчитатьТаблицу"
	
	НоваяКоманда =Форма.Команды.Добавить("ПересчитатьТаблицу");
	НоваяКоманда.Заголовок = "Пересчитать таблицу";
	НоваяКоманда.Отображение = ОтображениеКнопки.КартинкаИТекст;
	НоваяКоманда.Картинка = БиблиотекаКартинок.Перечитать;
	НоваяКоманда.Действие = "ДЗ_КомандаПересчитатьТаблицу";
	
	НоваяКнопка =Форма.Элементы.Добавить("КнопкаПересчитатьТаблицу",Тип("КнопкаФормы"),ГруппаСкидки);
	НоваяКнопка.ИмяКоманды = "ПересчитатьТаблицу";
	НоваяКнопка.Вид = ВидКнопкиФормы.ОбычнаяКнопка;
	НоваяКнопка.ЦветФона = WebЦвета.МятныйКрем;
	
КонецПроцедуры

//---Захарова
#КонецОбласти

