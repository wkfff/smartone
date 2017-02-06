prompt PL/SQL Developer import file
prompt Created on 2014��02��27�� by Administrator
set feedback off
set define off
prompt Disabling triggers for PROCESS_OBJECT_TYPE_INFO...
alter table PROCESS_OBJECT_TYPE_INFO disable all triggers;
prompt Deleting PROCESS_OBJECT_TYPE_INFO...
delete from PROCESS_OBJECT_TYPE_INFO;
commit;
prompt Loading PROCESS_OBJECT_TYPE_INFO...
insert into PROCESS_OBJECT_TYPE_INFO (object_type_id, object_type_name, description, created_by, create_date, updated_by, update_date, activity, cpny_id, orderno, object_type_en_name, parent_type_id, depth, default_status_id)
values ('ECM', '���������', null, null, null, null, null, 1, null, null, 'CN Type', 'SPERP', 1, null); 
insert into PROCESS_OBJECT_TYPE_INFO (object_type_id, object_type_name, description, created_by, create_date, updated_by, update_date, activity, cpny_id, orderno, object_type_en_name, parent_type_id, depth, default_status_id)
values ('SPERP', 'ERP����', null, null, null, null, null, 1, null, null, 'ERP Type', 'wooribank', 0, null);
insert into PROCESS_OBJECT_TYPE_INFO (object_type_id, object_type_name, description, created_by, create_date, updated_by, update_date, activity, cpny_id, orderno, object_type_en_name, parent_type_id, depth, default_status_id)
values ('DOC', '�ĵ�����', null, null, null, null, null, 1, null, null, 'Document Type', 'SPERP', 1, null);
insert into PROCESS_OBJECT_TYPE_INFO (object_type_id, object_type_name, description, created_by, create_date, updated_by, update_date, activity, cpny_id, orderno, object_type_en_name, parent_type_id, depth, default_status_id)
values ('MAT', '��������', null, null, null, null, null, 1, null, null, 'Materail Type', 'SPERP', 1, null);
insert into PROCESS_OBJECT_TYPE_INFO (object_type_id, object_type_name, description, created_by, create_date, updated_by, update_date, activity, cpny_id, orderno, object_type_en_name, parent_type_id, depth, default_status_id)
values ('BOM', 'BOM����', null, null, null, null, null, 1, null, null, 'BOM Type', 'SPERP', 1, null);
insert into PROCESS_OBJECT_TYPE_INFO (object_type_id, object_type_name, description, created_by, create_date, updated_by, update_date, activity, cpny_id, orderno, object_type_en_name, parent_type_id, depth, default_status_id)
values ('ORDER', '��������', null, null, null, null, null, 1, null, null, 'Order Type', 'SPERP', 1, null);
commit;
prompt 6 records loaded
prompt Enabling triggers for PROCESS_OBJECT_TYPE_INFO...
alter table PROCESS_OBJECT_TYPE_INFO enable all triggers;
set feedback on
set define on
prompt Done.
exit;