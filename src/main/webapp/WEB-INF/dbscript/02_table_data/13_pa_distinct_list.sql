prompt PL/SQL Developer import file
prompt Created on 2014��03��11�� by Administrator
set feedback off
set define off
prompt Disabling triggers for PA_DISTINCT_LIST...
alter table PA_DISTINCT_LIST disable all triggers;
prompt Deleting PA_DISTINCT_LIST...
delete from PA_DISTINCT_LIST;
commit;
prompt Loading PA_DISTINCT_LIST...
insert into PA_DISTINCT_LIST (FIELD_NAME, DISTINCT_FIELD, TABLE_NAME, ID, ACTIVITY, FIELD_EN_NAME, FIELD_KOR_NAME, LANG_GROUP, CPNY_ID)
values ('ְλ', 'POST_NAME', 'PA_HR_V', 5, 1, 'Post', null, '1', 'wooribank');

insert into PA_DISTINCT_LIST (FIELD_NAME, DISTINCT_FIELD, TABLE_NAME, ID, ACTIVITY, FIELD_EN_NAME, FIELD_KOR_NAME, LANG_GROUP, CPNY_ID)
values ('���ű��', 'DEPTID', 'PA_HR_V', 4, 1, 'Deptid', null, '1', 'wooribank');

insert into PA_DISTINCT_LIST (FIELD_NAME, DISTINCT_FIELD, TABLE_NAME, ID, ACTIVITY, FIELD_EN_NAME, FIELD_KOR_NAME, LANG_GROUP, CPNY_ID)
values ('Ա�����ͱ��', 'EMP_TYPE_CODE', 'PA_HR_V', 9, 1, 'EmpTypeCode', null, '1', 'wooribank');

insert into PA_DISTINCT_LIST (FIELD_NAME, DISTINCT_FIELD, TABLE_NAME, ID, ACTIVITY, FIELD_EN_NAME, FIELD_KOR_NAME, LANG_GROUP, CPNY_ID)
values ('��ְ����', 'JOIN_DATE', 'PA_HR_V', 4, 1, 'Join Date', null, '1', 'wooribank');

insert into PA_DISTINCT_LIST (FIELD_NAME, DISTINCT_FIELD, TABLE_NAME, ID, ACTIVITY, FIELD_EN_NAME, FIELD_KOR_NAME, LANG_GROUP, CPNY_ID)
values ('Ա��״̬', 'STATUS_NAME', 'PA_HR_V', 4, 1, 'Status Name', null, '1', 'wooribank');

insert into PA_DISTINCT_LIST (FIELD_NAME, DISTINCT_FIELD, TABLE_NAME, ID, ACTIVITY, FIELD_EN_NAME, FIELD_KOR_NAME, LANG_GROUP, CPNY_ID)
values ('����', 'CHINESENAME', 'PA_HR_V', 2, 1, 'Name', null, '1', 'wooribank');

insert into PA_DISTINCT_LIST (FIELD_NAME, DISTINCT_FIELD, TABLE_NAME, ID, ACTIVITY, FIELD_EN_NAME, FIELD_KOR_NAME, LANG_GROUP, CPNY_ID)
values ('����', 'DEPTNAME', 'PA_HR_V', 3, 1, 'Department', null, '1', 'wooribank');

insert into PA_DISTINCT_LIST (FIELD_NAME, DISTINCT_FIELD, TABLE_NAME, ID, ACTIVITY, FIELD_EN_NAME, FIELD_KOR_NAME, LANG_GROUP, CPNY_ID)
values ('����', 'EMPID', 'PA_HR_V', 1, 1, 'Emp ID', null, '0', 'wooribank');

insert into PA_DISTINCT_LIST (FIELD_NAME, DISTINCT_FIELD, TABLE_NAME, ID, ACTIVITY, FIELD_EN_NAME, FIELD_KOR_NAME, LANG_GROUP, CPNY_ID)
values ('״̬���', 'STATUS_CODE', 'PA_HR_V', 4, 1, 'Employee Status', null, '1', 'wooribank');

insert into PA_DISTINCT_LIST (FIELD_NAME, DISTINCT_FIELD, TABLE_NAME, ID, ACTIVITY, FIELD_EN_NAME, FIELD_KOR_NAME, LANG_GROUP, CPNY_ID)
values ('Ա������', 'EMP_TYPE_NAME', 'PA_HR_V', 9, 1, 'Employee Type', null, '1', 'wooribank');
commit;
prompt 10 records loaded
prompt Enabling triggers for PA_DISTINCT_LIST...
alter table PA_DISTINCT_LIST enable all triggers;
set feedback on
set define on
prompt Done.
exit;