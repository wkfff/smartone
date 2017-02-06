prompt PL/SQL Developer import file
prompt Created on 2014Äê1ÔÂ29ÈÕ by Yayoi
set feedback off
set define off
prompt Disabling triggers for PROCESS_ESS_RELATION...
alter table PROCESS_ESS_RELATION disable all triggers;
prompt Deleting PROCESS_ESS_RELATION...
delete from PROCESS_ESS_RELATION;
commit;
prompt Loading PROCESS_ESS_RELATION...
insert into PROCESS_ESS_RELATION (process_key, table_name)
values ('LeaveProcess', 'ess_apply_leave');
insert into PROCESS_ESS_RELATION (process_key, table_name)
values ('OvertimeProcess', 'ess_apply_ot');
insert into PROCESS_ESS_RELATION (process_key, table_name)
values ('BusiTripProcess', 'ess_apply_bt');
insert into PROCESS_ESS_RELATION (process_key, table_name)
values ('FeesProcess', 'ess_apply_exp');
insert into PROCESS_ESS_RELATION (process_key, table_name)
values ('ToolProcess', 'ess_apply_tool');
insert into PROCESS_ESS_RELATION (process_key, table_name)
values ('CardtimeProcess', 'ess_apply_card');
insert into PROCESS_ESS_RELATION (process_key, table_name)
values ('UpGradeProcess', 'hr_experience_inside');
insert into PROCESS_ESS_RELATION (process_key, table_name)
values ('ResignProcess', 'hr_resignation');
insert into PROCESS_ESS_RELATION (process_key, table_name)
values ('SalesOrderProcess', 'prostor_sales_order');
insert into PROCESS_ESS_RELATION (process_key, table_name)
values ('PurchaseOrderProcess', 'prostor_purchase_order');
commit;
prompt 10 records loaded
prompt Enabling triggers for PROCESS_ESS_RELATION...
alter table PROCESS_ESS_RELATION enable all triggers;
set feedback on
set define on
prompt Done.
exit;