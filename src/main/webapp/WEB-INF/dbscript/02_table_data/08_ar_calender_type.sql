prompt PL/SQL Developer import file
prompt Created on 2014��2��25�� by Wzh
set feedback off
set define off
prompt Disabling triggers for AR_CALENDER_TYPE...
alter table AR_CALENDER_TYPE disable all triggers;
prompt Deleting AR_CALENDER_TYPE...
delete from AR_CALENDER_TYPE;
commit;
prompt Loading AR_CALENDER_TYPE...
insert into AR_CALENDER_TYPE (type_id, type_name, type_en_name, descr, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (1, 'ƽ��', 'Weekday', null, null, null, null, null, 1, 'wooribank');
insert into AR_CALENDER_TYPE (type_id, type_name, type_en_name, descr, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (2, '����', 'Weekend', null, null, null, null, null, 1, 'wooribank');
insert into AR_CALENDER_TYPE (type_id, type_name, type_en_name, descr, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (3, '�ڼ�', 'Holiday', null, null, null, null, null, 1, 'wooribank');
commit;
prompt 3 records loaded
prompt Enabling triggers for AR_CALENDER_TYPE...
alter table AR_CALENDER_TYPE enable all triggers;
set feedback on
set define on
prompt Done.
exit;