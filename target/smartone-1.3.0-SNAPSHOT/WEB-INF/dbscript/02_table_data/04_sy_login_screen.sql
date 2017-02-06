prompt PL/SQL Developer import file
prompt Created on 2014年5月4日 by Wzh
set feedback off
set define off
prompt Disabling triggers for SY_LOGIN_SCREEN...
alter table SY_LOGIN_SCREEN disable all triggers;
prompt Deleting SY_LOGIN_SCREEN...
delete from SY_LOGIN_SCREEN;
commit;
prompt Loading SY_LOGIN_SCREEN...
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (1001, '1001', '消息管理', null, null, to_date('17-02-2014 11:54:33', 'dd-mm-yyyy hh24:mi:ss'), 'administrator', null, null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (1, '1', '系统管理员', 'Administrator', '系统管理员', null, null, to_date('29-04-2014 12:02:24', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (173, '173', '销售业务员', 'Sales', '负责下销售订单', to_date('24-01-2013 14:59:14', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('29-04-2014 14:54:31', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (174, '174', '货品管理', 'Sales Assistant', '负责管理货品', to_date('31-01-2013 10:41:07', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('27-02-2014 14:16:17', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (10, '10', '人事担当', 'HR Officer', null, null, null, to_date('24-02-2014 12:11:11', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (11, '11', '考勤担当', 'Attendance Keeper', null, null, null, to_date('18-10-2013 11:44:51', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (18, '18', '项目管理', 'Working Hour Manager', null, null, null, to_date('17-02-2014 11:27:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (2, '2', '普通员工', 'Employee', null, null, null, to_date('21-04-2014 11:30:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (3, '3', '报表查看', 'Mid-High Manager', null, null, null, to_date('17-02-2014 10:33:25', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (5, '5', '审核者', 'Approver', '负责订单和人事申请的审核', null, null, to_date('17-02-2014 14:33:52', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (9, '9', '工资担当', 'Payroll Keeper ', null, null, null, to_date('17-02-2014 10:40:50', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (4, '4', '绩效管理', '评价担当', '评价担当', to_date('26-03-2012 11:19:55', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('29-09-2013 15:54:11', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (8, '8', '资产担当', 'Assets Keeper', '资产管理者', null, null, to_date('23-12-2013 17:19:43', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (171, '171', '供应商管理', 'ChannelManager', '公司内部管理供货商的人员', to_date('21-01-2013 11:42:04', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('18-02-2014 14:12:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (193, '193', '物料管理', 'Material Admin', null, to_date('27-04-2013 15:16:09', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('17-02-2014 11:26:45', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (203, '203', '财务担当', 'Finance Manager', '财务管理，主管财务的录入与展示', to_date('05-08-2013 09:48:56', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('28-01-2014 16:50:30', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (188, '188', '文档管理', 'Document Keeper', null, to_date('22-04-2013 15:02:50', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('17-02-2014 11:21:02', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (196, '196', 'ECN管理员', 'ECM Manager', null, to_date('28-04-2013 12:02:38', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('28-01-2014 16:50:12', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (195, '195', 'BOM管理者', ' BOM Manager', null, to_date('27-04-2013 15:17:55', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('28-01-2014 16:49:39', 'dd-mm-yyyy hh24:mi:ss'), null, null, 0, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (198, '198', '流程管理', 'Process Manager', null, to_date('15-05-2013 10:09:42', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('03-03-2014 16:13:21', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (220, '220', '库存管理', ' ', null, to_date('05-11-2013 10:52:42', 'dd-mm-yyyy hh24:mi:ss'), '25258457', to_date('17-02-2014 11:19:16', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (558, '558', 'hr_admin', 'hr_admin', '负责初始时添加部门、员工', to_date('29-01-2014 10:24:24', 'dd-mm-yyyy hh24:mi:ss'), 'administrator', to_date('17-02-2014 10:10:09', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (1000, '1000', '移动端管理', ' ', null, to_date('17-02-2014 11:35:00', 'dd-mm-yyyy hh24:mi:ss'), 'administrator', to_date('21-04-2014 11:47:14', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
insert into SY_LOGIN_SCREEN (screen_grant_no, screen_grant_id, screen_grant_name, screen_grant_en_name, description, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id, supplier_id)
values (1002, '1002', '订单货款确认', ' ', '负责确认订单货款', to_date('17-02-2014 14:40:34', 'dd-mm-yyyy hh24:mi:ss'), 'administrator', to_date('17-02-2014 14:41:22', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, 'wooribank', null);
commit;
prompt 24 records loaded
prompt Enabling triggers for SY_LOGIN_SCREEN...
alter table SY_LOGIN_SCREEN enable all triggers;
set feedback on
set define on
prompt Done.
exit;