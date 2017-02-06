prompt PL/SQL Developer import file
prompt Created on 2014Äê1ÔÂ29ÈÕ by Yayoi
set feedback off
set define off
prompt Disabling triggers for SY_ADMIN...
alter table SY_ADMIN disable all triggers;
prompt Deleting SY_ADMIN...
delete from SY_ADMIN;
commit;
prompt Loading SY_ADMIN...
insert into SY_ADMIN (adminno, adminid, adminlevel, username, password, login_deptid, screen_grant_id, create_date, created_by, update_date, updated_by, orderno, activity, appcnt, set_app, cpny_id, account_type)
values (1324, 'administrator', null, 'admin', '21232f297a57a5a743894a0e4a801fc3', null, '1', to_date('28-01-2014 11:32:32', 'dd-mm-yyyy hh24:mi:ss'), 'system', to_date('28-01-2014 11:32:32', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, null, null, 'wooribank', 'SY');
insert into SY_ADMIN (adminno, adminid, adminlevel, username, password, login_deptid, screen_grant_id, create_date, created_by, update_date, updated_by, orderno, activity, appcnt, set_app, cpny_id, account_type)
values (1325, 'hr_admin', null, 'hr_admin', '5803c5846f10f116efc38e4f9c57399b', null, '558', to_date('28-01-2014 11:32:32', 'dd-mm-yyyy hh24:mi:ss'), 'system', to_date('28-01-2014 11:32:32', 'dd-mm-yyyy hh24:mi:ss'), null, null, 1, null, null, 'wooribank', 'HR');
commit;
prompt 2 records loaded
prompt Enabling triggers for SY_ADMIN...
alter table SY_ADMIN enable all triggers;
set feedback on
set define on
prompt Done.

exit;