prompt Importing table prostor_sales_model...
set feedback off
set define off
delete from prostor_sales_model;
commit;
insert into prostor_sales_model (SALES_MODE_NO, SALES_MODE_ID, SALES_MODE_NAME, SALES_MODE_EN_NAME, REMARK, CREATE_DATE, CREATED_BY, UPDATE_DATE, UPDATED_BY, ACTIVITY, CPNY_ID, STATUS, MOBILE_STATUS)
values ('0', 'SM00', '零售价(默认)', null, null, to_date('27-02-2014 14:45:12', 'dd-mm-yyyy hh24:mi:ss'), 'system', to_date('23-10-2014 14:01:28', 'dd-mm-yyyy hh24:mi:ss'), 'system', 1, 'wooribank', 1, 1);
commit;
prompt Done.
