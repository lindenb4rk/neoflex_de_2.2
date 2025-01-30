CREATE
OR REPLACE PROCEDURE INSERT_VALUES () LANGUAGE PLPGSQL AS $$
DECLARE 
lines bigint;
BEGIN
COPY rd.deal_info
FROM 'D:\deal_info.csv'
WITH (FORMAT CSV, DELIMITER ',', HEADER, ENCODING 'WIN1251');

GET DIAGNOSTICS lines = ROW_COUNT;
CALL logs_insert('Copy to deal_info from file:'||lines||' lines');

END $$;

;

CREATE
OR REPLACE PROCEDURE preINSERT_VALUES_2 () LANGUAGE PLPGSQL AS $$
DECLARE 
lines bigint;
BEGIN
truncate rd.product_v2;

COPY rd.product_v2
FROM 'D:\product_info.csv'
WITH (FORMAT CSV, DELIMITER ',', HEADER, ENCODING 'WIN1251');

--логи,сколько поступило значений
GET DIAGNOSTICS lines = ROW_COUNT;
CALL logs_insert('Copy to product_v2(temp table) from file:'||lines||' lines');


END $$;

;


--RETURNING возвращает ИЗМЕНЁННЫЕ значения

CREATE
OR REPLACE PROCEDURE UPDATE_AND_INSERT_VALUES_2 () LANGUAGE PLPGSQL AS $$
DECLARE 
lines bigint;
BEGIN
--удаляем изменённые в основной таблице, наши "входящие" значения, используя ключ

WITH updates as (UPDATE rd.product as pr
	SET effective_from_date =  pr2.effective_from_date
--можно from заменить IN в WHERE 
FROM rd.product_v2 pr2 
	WHERE pr2.product_rk = pr.product_rk and pr2.product_name = pr.product_name  and pr.effective_from_date < pr2.effective_from_date
RETURNING pr.product_rk,pr.product_name)

--происходит изменение строк и удаление их из вставляемой таблицы
DELETE FROM rd.product_v2 
WHERE (product_rk,product_name) IN (select * from updates);

--логи,сколько удалили изменённых
GET DIAGNOSTICS lines = ROW_COUNT;
CALL logs_insert('DELETE FROM product_v2:'||lines||' lines');

INSERT INTO rd.product SELECT * FROM rd.product_v2;

--логи,сколько вставили значений
GET DIAGNOSTICS lines = ROW_COUNT;
CALL logs_insert('INSERT ONTO product:'||lines||' lines');

truncate rd.product_v2;

END $$;

;
