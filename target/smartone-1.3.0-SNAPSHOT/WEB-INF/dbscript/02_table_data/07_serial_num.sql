prompt PL/SQL Developer import file
prompt Created on 2014年1月29日 by Yayoi
set feedback off
set define off
prompt Disabling triggers for SY_ORDER...
alter table SY_ORDER disable all triggers;
prompt Disabling triggers for SY_SERIAL_NUM...
alter table SY_SERIAL_NUM disable all triggers;
prompt Deleting SY_SERIAL_NUM...
delete from SY_SERIAL_NUM;
commit;
prompt Deleting SY_ORDER...
delete from SY_ORDER;
commit;
prompt Loading SY_ORDER...
insert into SY_ORDER (order_no, order_id, order_name, order_en_name, create_by, create_date, updated_by, update_date, activity, cpny_id)
values (41, 'PURCHASE_ID', '采购单', 'Purchase Order', null, sysdate, null, null, 1, 'wooribank');
insert into SY_ORDER (order_no, order_id, order_name, order_en_name, create_by, create_date, updated_by, update_date, activity, cpny_id)
values (42, 'SALES_ID', '销售单', 'Sales Order', null, sysdate, null, null, 1, 'wooribank');
insert into SY_ORDER (order_no, order_id, order_name, order_en_name, create_by, create_date, updated_by, update_date, activity, cpny_id)
values (43, 'INSTORAGE_ID', '入库单', 'Instorage Order', null, sysdate, null, null, 1, 'wooribank');
insert into SY_ORDER (order_no, order_id, order_name, order_en_name, create_by, create_date, updated_by, update_date, activity, cpny_id)
values (44, 'OUTSTORAGE_ID', '出库单', 'Outstorage Order', null, sysdate, null, null, 1, 'wooribank');
insert into SY_ORDER (order_no, order_id, order_name, order_en_name, create_by, create_date, updated_by, update_date, activity, cpny_id)
values (45, 'PRODUCT_ID', '货品编码', 'Product Code', null, sysdate, null, null, 1, 'wooribank');
commit;
prompt 5 records loaded
prompt Loading SY_SERIAL_NUM...
insert into SY_SERIAL_NUM (serial_num_no, order_id, sequence_name, prefix, middle_field, num_length, reset_model, create_by, create_date, updated_by, update_date, activity, cpny_id)
values (61, 'PURCHASE_ID', 'SY_PURCHASE_SERIAL_SEQ', null, null, null, null, null, sysdate, null, null, 1, 'wooribank');
insert into SY_SERIAL_NUM (serial_num_no, order_id, sequence_name, prefix, middle_field, num_length, reset_model, create_by, create_date, updated_by, update_date, activity, cpny_id)
values (62, 'SALES_ID', 'SY_SALES_SERIAL_SEQ', null, null, null, null, null, sysdate, null, null, 1, 'wooribank');
insert into SY_SERIAL_NUM (serial_num_no, order_id, sequence_name, prefix, middle_field, num_length, reset_model, create_by, create_date, updated_by, update_date, activity, cpny_id)
values (63, 'INSTORAGE_ID', 'SY_INSTORAGE_SERIAL_SEQ', null, null, null, null, null, sysdate, null, null, 1, 'wooribank');
insert into SY_SERIAL_NUM (serial_num_no, order_id, sequence_name, prefix, middle_field, num_length, reset_model, create_by, create_date, updated_by, update_date, activity, cpny_id)
values (64, 'OUTSTORAGE_ID', 'SY_OUTSTORAGE_SERIAL_SEQ', null, null, null, null, null, sysdate, null, null, 1, 'wooribank');
insert into SY_SERIAL_NUM (serial_num_no, order_id, sequence_name, prefix, middle_field, num_length, reset_model, create_by, create_date, updated_by, update_date, activity, cpny_id)
values (65, 'PRODUCT_ID', 'SY_PRODUCT_SERIAL_SEQ', null, null, null, null, null, sysdate, null, null, 1, 'wooribank');
commit;
prompt 5 records loaded
prompt Enabling triggers for SY_ORDER...
alter table SY_ORDER enable all triggers;
prompt Enabling triggers for SY_SERIAL_NUM...
alter table SY_SERIAL_NUM enable all triggers;
set feedback on
set define on
prompt Done.
exit;