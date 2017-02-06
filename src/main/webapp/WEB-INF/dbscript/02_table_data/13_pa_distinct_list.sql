prompt PL/SQL Developer import file
prompt Created on 2014年03月11日 by Administrator
set feedback off
set define off
prompt Disabling triggers for PA_DISTINCT_LIST...
alter table PA_DISTINCT_LIST disable all triggers;
prompt Deleting PA_DISTINCT_LIST...
delete from PA_DISTINCT_LIST;
commit;
prompt Loading PA_DISTINCT_LIST...
insert into PA_DISTINCT_LIST (FIELD_NAME, DISTINCT_FIELD, TABLE_NAME, ID, ACTIVITY, FIELD_EN_NAME, FIELD_KOR_NAME, LANG_GROUP, CPNY_ID)
values ('职位', 'POST_NAME', 'PA_HR_V', 5, 1, 'Post', null, '1', 'wooribank');

insert into PA_DISTINCT_LIST (FIELD_NAME, DISTINCT_FIELD, TABLE_NAME, ID, ACTIVITY, FIELD_EN_NAME, FIELD_KOR_NAME, LANG_GROUP, CPNY_ID)
values ('部门编号', 'DEPTID', 'PA_HR_V', 4, 1, 'Deptid', null, '1', 'wooribank');

insert into PA_DISTINCT_LIST (FIELD_NAME, DISTINCT_FIELD, TABLE_NAME, ID, ACTIVITY, FIELD_EN_NAME, FIELD_KOR_NAME, LANG_GROUP, CPNY_ID)
values ('员工类型编号', 'EMP_TYPE_CODE', 'PA_HR_V', 9, 1, 'EmpTypeCode', null, '1', 'wooribank');

insert into PA_DISTINCT_LIST (FIELD_NAME, DISTINCT_FIELD, TABLE_NAME, ID, ACTIVITY, FIELD_EN_NAME, FIELD_KOR_NAME, LANG_GROUP, CPNY_ID)
values ('入职日期', 'JOIN_DATE', 'PA_HR_V', 4, 1, 'Join Date', null, '1', 'wooribank');

insert into PA_DISTINCT_LIST (FIELD_NAME, DISTINCT_FIELD, TABLE_NAME, ID, ACTIVITY, FIELD_EN_NAME, FIELD_KOR_NAME, LANG_GROUP, CPNY_ID)
values ('员工状态', 'STATUS_NAME', 'PA_HR_V', 4, 1, 'Status Name', null, '1', 'wooribank');

insert into PA_DISTINCT_LIST (FIELD_NAME, DISTINCT_FIELD, TABLE_NAME, ID, ACTIVITY, FIELD_EN_NAME, FIELD_KOR_NAME, LANG_GROUP, CPNY_ID)
values ('姓名', 'CHINESENAME', 'PA_HR_V', 2, 1, 'Name', null, '1', 'wooribank');

insert into PA_DISTINCT_LIST (FIELD_NAME, DISTINCT_FIELD, TABLE_NAME, ID, ACTIVITY, FIELD_EN_NAME, FIELD_KOR_NAME, LANG_GROUP, CPNY_ID)
values ('部门', 'DEPTNAME', 'PA_HR_V', 3, 1, 'Department', null, '1', 'wooribank');

insert into PA_DISTINCT_LIST (FIELD_NAME, DISTINCT_FIELD, TABLE_NAME, ID, ACTIVITY, FIELD_EN_NAME, FIELD_KOR_NAME, LANG_GROUP, CPNY_ID)
values ('工号', 'EMPID', 'PA_HR_V', 1, 1, 'Emp ID', null, '0', 'wooribank');

insert into PA_DISTINCT_LIST (FIELD_NAME, DISTINCT_FIELD, TABLE_NAME, ID, ACTIVITY, FIELD_EN_NAME, FIELD_KOR_NAME, LANG_GROUP, CPNY_ID)
values ('状态编号', 'STATUS_CODE', 'PA_HR_V', 4, 1, 'Employee Status', null, '1', 'wooribank');

insert into PA_DISTINCT_LIST (FIELD_NAME, DISTINCT_FIELD, TABLE_NAME, ID, ACTIVITY, FIELD_EN_NAME, FIELD_KOR_NAME, LANG_GROUP, CPNY_ID)
values ('员工区分', 'EMP_TYPE_NAME', 'PA_HR_V', 9, 1, 'Employee Type', null, '1', 'wooribank');
commit;
prompt 10 records loaded
prompt Enabling triggers for PA_DISTINCT_LIST...
alter table PA_DISTINCT_LIST enable all triggers;
set feedback on
set define on
prompt Done.
exit;