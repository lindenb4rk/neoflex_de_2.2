/*
--Анализировал входящие данные
SELECT deal_rk, deal_num, deal_name, deal_sum, client_rk, account_rk, agreement_rk, deal_start_date, department_rk, product_rk, deal_type_cd--, effective_from_date, effective_to_date
	FROM rd.deal_info_v2
	union all
	SELECT deal_rk, deal_num, deal_name, deal_sum, client_rk, account_rk, agreement_rk, deal_start_date, department_rk, product_rk, deal_type_cd--, effective_from_date, effective_to_date
	FROM rd.deal_info*/


	/*

	SELECT 
	--по идее: ключ
	di.deal_rk, di.deal_num, di.deal_name,
	di2.deal_rk, di2.deal_num, di2.deal_name,
	--сравнение остальных значений
	di.deal_sum, di.client_rk, di.account_rk, di.agreement_rk, di.deal_start_date, di.department_rk, di.product_rk, di.deal_type_cd,--, effective_from_date, effective_to_date
		di2.deal_sum, di2.client_rk, di2.account_rk, di2.agreement_rk, di2.deal_start_date, di2.department_rk, di2.product_rk, di2.deal_type_cd--, effective_from_date, effective_to_date
	FROM rd.deal_info as di
	join rd.deal_info_v2 as di2 on di.deal_rk = di2.deal_rk
	*/



--SELECT * FROM logs.logs_info;

--select * from rd.deal_info;

--deal_info
call insert_values();

--SELECT * FROM logs.logs_info;
/*
--"ошибочность данных"
SELECT pr2.product_rk, pr2.product_name, pr2.effective_from_date, pr2.effective_to_date,pr.product_rk, pr.product_name, pr.effective_from_date, pr.effective_to_date
	FROM rd.product_v2 pr2
	join rd.product pr on pr2.product_rk = pr.product_rk and pr2.product_name != pr.product_name  
	*/


call preinsert_values_2();

--SELECT * FROM logs.logs_info;

call UPDATE_AND_INSERT_VALUES_2 ();

/*
--product, какие значения изменяются
SELECT
	PR.PRODUCT_RK,
	PR.PRODUCT_NAME,
	PR.EFFECTIVE_FROM_DATE,
	PR.EFFECTIVE_TO_DATE,
	PR2.EFFECTIVE_FROM_DATE,
	PR2.EFFECTIVE_TO_DATE
FROM
	RD.PRODUCT AS PR
	JOIN RD.PRODUCT_V2 AS PR2 ON PR2.PRODUCT_RK = PR.PRODUCT_RK
	AND PR2.PRODUCT_NAME = PR.PRODUCT_NAME
	AND PR.EFFECTIVE_FROM_DATE < PR2.EFFECTIVE_FROM_DATE
*/