prompt PL/SQL Developer import file
prompt Created on 2014年2月17日星期一 by Administrator
set feedback off
set define off
prompt Disabling triggers for SY_ADMIN_DEPTID...
alter table SY_ADMIN_DEPTID disable all triggers;
prompt Disabling foreign key constraints for SY_ADMIN_DEPTID...
alter table SY_ADMIN_DEPTID disable constraint FK_SY_ADMIN_DEPTID;
prompt Deleting SY_ADMIN_DEPTID...
delete from SY_ADMIN_DEPTID;
commit;
prompt Loading SY_ADMIN_DEPTID...
insert into SY_ADMIN_DEPTID (admin_no, admin_deptid)
values (1325, 'DEPT001');
insert into SY_ADMIN_DEPTID (admin_no, admin_deptid)
values (1324, 'DEPT001');
commit;
prompt 2 records loaded
prompt Enabling foreign key constraints for SY_ADMIN_DEPTID...
alter table SY_ADMIN_DEPTID enable constraint FK_SY_ADMIN_DEPTID;
prompt Enabling triggers for SY_ADMIN_DEPTID...
alter table SY_ADMIN_DEPTID enable all triggers;
set feedback on
set define on
prompt Done.
exit;