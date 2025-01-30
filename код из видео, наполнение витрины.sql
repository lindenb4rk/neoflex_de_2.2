SELECT info_operation, time_operation
	FROM logs.logs_info;

call dm_create_loan();
	
SELECT deal_rk, effective_from_date, effective_to_date, agreement_rk, account_rk, client_rk, department_rk, product_rk, product_name, deal_type_cd, deal_start_date, deal_name, deal_number, deal_sum, loan_holiday_type_cd, loan_holiday_start_date, loan_holiday_finish_date, loan_holiday_fact_finish_date, loan_holiday_finish_flg, loan_holiday_last_possible_date
	FROM dm.loan_holiday_info;









