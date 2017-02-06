prompt PL/SQL Developer import file
prompt Created on 2014��5��4�� by Wzh
set feedback off
set define off
prompt Disabling triggers for SY_LOGIN_SCREEN...
alter table SY_LOGIN_SCREEN disable all triggers;
prompt Deleting SY_LOGIN_SCREEN...
delete from SY_LOGIN_SCREEN;
commit;
prompt Loading SY_LOGIN_SCREEN...
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (1001, '1001', '��Ϣ����', null, null, to_date('17-02-2014 11:54:33', 'dd-mm-yyyy hh24:mi:ss'), 'administrator', null, null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (1, '1', 'ϵͳ����Ա', 'Administrator', 'ϵͳ����Ա', null, null, to_date('29-04-2014 12:02:24', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (173, '173', '����ҵ��Ա', 'Sales', '���������۶���', to_date('24-01-2013 14:59:14', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('29-04-2014 14:54:31', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (174, '174', '��Ʒ����', 'Sales Assistant', '��������Ʒ', to_date('31-01-2013 10:41:07', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('27-02-2014 14:16:17', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (10, '10', '���µ���', 'HR Officer', null, null, null, to_date('24-02-2014 12:11:11', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (11, '11', '���ڵ���', 'Attendance Keeper', null, null, null, to_date('18-10-2013 11:44:51', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (18, '18', '��Ŀ����', 'Working Hour Manager', null, null, null, to_date('17-02-2014 11:27:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (2, '2', '��ͨԱ��', 'Employee', null, null, null, to_date('21-04-2014 11:30:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (3, '3', '����鿴', 'Mid-High Manager', null, null, null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (5, '5', '�����', 'Approver', '���𶩵���������������', null, null, to_date('17-02-2014 14:33:52', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (9, '9', '���ʵ���', 'Payroll Keeper ', null, null, null, to_date('17-02-2014 10:40:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (4, '4', '��Ч����', '���۵���', '���۵���', to_date('26-03-2012 11:19:55', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('29-09-2013 15:54:11', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (8, '8', '�ʲ�����', 'Assets Keeper', '�ʲ�������', null, null, to_date('23-12-2013 17:19:43', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (171, '171', '��Ӧ�̹���', 'ChannelManager', '��˾�ڲ��������̵���Ա', to_date('21-01-2013 11:42:04', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('18-02-2014 14:12:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (193, '193', '���Ϲ���', 'Material Admin', null, to_date('27-04-2013 15:16:09', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('17-02-2014 11:26:45', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (203, '203', '���񵣵�', 'Finance Manager', '����������ܲ����¼����չʾ', to_date('05-08-2013 09:48:56', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('28-01-2014 16:50:30', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (188, '188', '�ĵ�����', 'Document Keeper', null, to_date('22-04-2013 15:02:50', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('17-02-2014 11:21:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (196, '196', 'ECN����Ա', 'ECM Manager', null, to_date('28-04-2013 12:02:38', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('28-01-2014 16:50:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (195, '195', 'BOM������', ' BOM Manager', null, to_date('27-04-2013 15:17:55', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('28-01-2014 16:49:39', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (198, '198', '���̹���', 'Process Manager', null, to_date('15-05-2013 10:09:42', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('03-03-2014 16:13:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (220, '220', '������', ' ', null, to_date('05-11-2013 10:52:42', 'dd-mm-yyyy hh24:mi:ss'), '25258457', to_date('17-02-2014 11:19:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (558, '558', 'hr_admin', 'hr_admin', '�����ʼʱ��Ӳ��š�Ա��', to_date('29-01-2014 10:24:24', 'dd-mm-yyyy hh24:mi:ss'), 'administrator', to_date('17-02-2014 10:10:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (1000, '1000', '�ƶ��˹���', ' ', null, to_date('17-02-2014 11:35:00', 'dd-mm-yyyy hh24:mi:ss'), 'administrator', to_date('21-04-2014 11:47:14', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (1002, '1002', '��������ȷ��', ' ', '����ȷ�϶�������', to_date('17-02-2014 14:40:34', 'dd-mm-yyyy hh24:mi:ss'), 'administrator', to_date('17-02-2014 14:41:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
commit;
prompt 24 records loaded
prompt Enabling triggers for SY_LOGIN_SCREEN...
alter table SY_LOGIN_SCREEN enable all triggers;
set feedback on
set define on
prompt Done.
exit;