prompt PL/SQL Developer import file
prompt Created on 2014年3月11日 by Administrator
set feedback off
set define off
prompt Disabling triggers for AR_CONDITION_LIST...
alter table AR_CONDITION_LIST disable all triggers;
prompt Disabling triggers for AR_DYNAMIC_GROUP...
alter table AR_DYNAMIC_GROUP disable all triggers;
prompt Disabling triggers for AR_DYNAMIC_GROUP_EMP...
alter table AR_DYNAMIC_GROUP_EMP disable all triggers;
prompt Disabling triggers for AR_ITEM...
alter table AR_ITEM disable all triggers;
prompt Disabling triggers for AR_ITEM_PARAM...
alter table AR_ITEM_PARAM disable all triggers;
prompt Disabling triggers for AR_SHIFT010...
alter table AR_SHIFT010 disable all triggers;
prompt Disabling triggers for AR_SHIFT020...
alter table AR_SHIFT020 disable all triggers;
prompt Disabling triggers for AR_STA_ITEM...
alter table AR_STA_ITEM disable all triggers;
prompt Disabling triggers for AR_STA_FORMULAR...
alter table AR_STA_FORMULAR disable all triggers;
prompt Disabling foreign key constraints for AR_ITEM_PARAM...
alter table AR_ITEM_PARAM disable constraint FK_AR_ITEM_PARAM;
prompt Disabling foreign key constraints for AR_STA_FORMULAR...
alter table AR_STA_FORMULAR disable constraint FK_AR_STA_FORMULAR;
prompt Deleting AR_STA_FORMULAR...
delete from AR_STA_FORMULAR;
commit;
prompt Deleting AR_STA_ITEM...
delete from AR_STA_ITEM;
commit;
prompt Deleting AR_SHIFT020...
delete from AR_SHIFT020;
commit;
prompt Deleting AR_SHIFT010...
delete from AR_SHIFT010;
commit;
prompt Deleting AR_ITEM_PARAM...
delete from AR_ITEM_PARAM;
commit;
prompt Deleting AR_ITEM...
delete from AR_ITEM;
commit;
prompt Deleting AR_DYNAMIC_GROUP_EMP...
delete from AR_DYNAMIC_GROUP_EMP;
commit;
prompt Deleting AR_DYNAMIC_GROUP...
delete from AR_DYNAMIC_GROUP;
commit;
prompt Deleting AR_CONDITION_LIST...
delete from AR_CONDITION_LIST;
commit;
prompt Loading AR_CONDITION_LIST...
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (5, 'EMP_TYPE_NAME', '员工区分', 'AR_EMP_INFO_V', 'Emp Distinction', 'EMP_TYPE_EN_NAME');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (9, 'POST_NAME', '职务', 'AR_EMP_INFO_V', 'Post Name', 'POST_EN_NAME');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (10, 'POST_GRADE_NAME', '职级', 'AR_EMP_INFO_V', 'Post Grade Name', 'POST_GRADE_EN_NAME');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (13, 'STATUS_NAME', '员工状态', 'AR_EMP_INFO_V', 'Status Name', 'STATUS_EN_NAME');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (6, 'SEX', '性别', 'AR_EMP_INFO_V', 'Sex', 'SEX_EN_NAME');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (1, 'EMPID', '工号', 'AR_EMP_INFO_V', 'Emp ID', 'EMPID');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (4, 'DEPTNAME', '部门', 'AR_EMP_INFO_V', 'Dept Name', 'DEPT_EN_NAME');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (2, 'CHINESENAME', '姓名', 'AR_EMP_INFO_V', 'Chinese Name', 'CHINESE_PINYIN');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (7, 'POSITION_NAME', '职位', 'AR_EMP_INFO_V', 'Position Name', 'POSITION_EN_NAME');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (3, 'CHINESE_PINYIN', '拼音名', 'AR_EMP_INFO_V', 'Chinese Pinyin', 'CHINESE_PINYIN');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (8, 'POST_GROUP_NAME', '职群', 'AR_EMP_INFO_V', 'Post Group Name', 'POST_GROUP_EN_NAME');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (14, 'JOIN_TYPE', '员工类别', 'AR_EMP_INFO_V', 'Join Type', 'JOIN_TYPE_EN_NAME');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (15, 'WORK_AREA_NAME', '保险类型', 'AR_EMP_INFO_V', 'Work Area Name', 'WORK_AREA_EN_NAME');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (5, 'EMP_TYPE_NAME', '员工区分', 'AR_EMP_INFO_V', 'Emp Distinction', 'EMP_TYPE_EN_NAME');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (9, 'POST_NAME', '职务', 'AR_EMP_INFO_V', 'Post Name', 'POST_EN_NAME');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (10, 'POST_GRADE_NAME', '职级', 'AR_EMP_INFO_V', 'Post Grade Name', 'POST_GRADE_EN_NAME');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (13, 'STATUS_NAME', '员工状态', 'AR_EMP_INFO_V', 'Status Name', 'STATUS_EN_NAME');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (6, 'SEX', '性别', 'AR_EMP_INFO_V', 'Sex', 'SEX_EN_NAME');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (1, 'EMPID', '工号', 'AR_EMP_INFO_V', 'Emp ID', 'EMPID');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (4, 'DEPTNAME', '部门', 'AR_EMP_INFO_V', 'Dept Name', 'DEPT_EN_NAME');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (2, 'CHINESENAME', '姓名', 'AR_EMP_INFO_V', 'Chinese Name', 'CHINESE_PINYIN');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (7, 'POSITION_NAME', '职位', 'AR_EMP_INFO_V', 'Position Name', 'POSITION_EN_NAME');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (3, 'CHINESE_PINYIN', '拼音名', 'AR_EMP_INFO_V', 'Chinese Pinyin', 'CHINESE_PINYIN');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (8, 'POST_GROUP_NAME', '职群', 'AR_EMP_INFO_V', 'Post Group Name', 'POST_GROUP_EN_NAME');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (14, 'JOIN_TYPE', '员工类别', 'AR_EMP_INFO_V', 'Join Type', 'JOIN_TYPE_EN_NAME');
insert into AR_CONDITION_LIST (condition_no, field_id, field_name, table_name, field_en_name, field_en_id)
values (15, 'WORK_AREA_NAME', '保险类型', 'AR_EMP_INFO_V', 'Work Area Name', 'WORK_AREA_EN_NAME');
commit;
prompt 26 records loaded
prompt Loading AR_DYNAMIC_GROUP...
insert into AR_DYNAMIC_GROUP (group_no, group_name, group_en_name, group_type, description, create_date, created_by, update_date, updated_by, activity, cpny_id, deptid)
values (9, '正常白班班组', '正常白班班组', null, '正常白班班组 9 ~ 12 ，13~18', null, '300', to_date('30-08-2012 16:59:14', 'dd-mm-yyyy hh24:mi:ss'), '20721174', 1, 'wooribank', null);
commit;
prompt 1 records loaded
prompt Loading AR_DYNAMIC_GROUP_EMP...
prompt Table is empty
prompt Loading AR_ITEM...
insert into AR_ITEM (item_no, item_id, item_name, item_en_name, short_name, description, item_group_code, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (1, 'ATT_D_1', '迟到', 'Tardiness', 'S1', '超过上班时间2个小时以上，视为迟到', 'ProprietaryGroup', null, null, null, null, 1, 'wooribank');
insert into AR_ITEM (item_no, item_id, item_name, item_en_name, short_name, description, item_group_code, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (3, 'ATT_D_3', '平日加班', 'Weekday OT', 'OT1', '在“正常出勤”基础上的加班', 'OverTimeGroup', null, null, null, null, 1, 'wooribank');
insert into AR_ITEM (item_no, item_id, item_name, item_en_name, short_name, description, item_group_code, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (4, 'ATT_D_4', '周末加班', 'Weekend OT', 'OT2', '在“公休日”基础上的加班', 'OverTimeGroup', null, null, to_date('28-09-2013 17:48:43', 'dd-mm-yyyy hh24:mi:ss'), null, 1, 'wooribank');
insert into AR_ITEM (item_no, item_id, item_name, item_en_name, short_name, description, item_group_code, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (5, 'ATT_D_5', '节假加班', 'Holiday OT', 'OT3', '在“节假日”基础上的加班', 'OverTimeGroup', null, null, to_date('28-09-2013 17:48:23', 'dd-mm-yyyy hh24:mi:ss'), null, 1, 'wooribank');
insert into AR_ITEM (item_no, item_id, item_name, item_en_name, short_name, description, item_group_code, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (8, 'ATT_D_8', '旷工', 'Absence', 'S2', '无故缺勤', 'ProprietaryGroup', null, null, null, null, 1, 'wooribank');
insert into AR_ITEM (item_no, item_id, item_name, item_en_name, short_name, description, item_group_code, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (9, 'ATT_D_9', '公出', 'BusinessOut', 'B1', '因公国内出差', 'SpecialGroup', null, null, to_date('08-11-2013 10:31:00', 'dd-mm-yyyy hh24:mi:ss'), null, 1, 'wooribank');
insert into AR_ITEM (item_no, item_id, item_name, item_en_name, short_name, description, item_group_code, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (10, 'ATT_D_10', '出差', 'Domestic Travel', 'B2', '因公国外出差', 'SpecialGroup', null, null, to_date('08-11-2013 10:30:31', 'dd-mm-yyyy hh24:mi:ss'), null, 1, 'wooribank');
insert into AR_ITEM (item_no, item_id, item_name, item_en_name, short_name, description, item_group_code, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (14, 'ATT_D_14', '哺乳假', 'Casual Leave', 'H1', '员工产假期满后至婴儿满一周岁前为哺乳期（医疗机构确诊为体弱儿的，为一年半）。 在哺乳期内，每天工作时间内哺乳二次，每次30分钟，或合并为一次60分钟。如多胎生育的，每多一个增加30分钟。具体授乳时间由本部门安排,  经人力资源部批准备案。 配偶生育后，男性员工可享受3天带薪假期。', 'LeavelGroup', null, null, to_date('15-08-2012 13:43:26', 'dd-mm-yyyy hh24:mi:ss'), null, 1, 'wooribank');
insert into AR_ITEM (item_no, item_id, item_name, item_en_name, short_name, description, item_group_code, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (15, 'ATT_D_15', '正常出勤', 'Work', 'N1', '正常出勤', 'NormalGroup', null, null, null, null, 1, 'wooribank');
insert into AR_ITEM (item_no, item_id, item_name, item_en_name, short_name, description, item_group_code, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (16, 'ATT_D_16', '病假', 'Sick Leave', 'H3', '病假员工超过一天以上者需出具县级以上医疗机构的医疗诊断书。病假期间工资按日基本工资的70%计算。 年累计病假超过三十天病假者是否进入医疗期或辞退。', 'LeavelGroup', null, null, null, null, 1, 'wooribank');
insert into AR_ITEM (item_no, item_id, item_name, item_en_name, short_name, description, item_group_code, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (17, 'ATT_D_17', '婚假', 'Marriage Leave', 'H5', '符合国家规定结婚条件的员工，可享受三天的婚假（双休日和法定节假日除外）。符合国家规定的晚婚政策的员工其晚婚假十天。 婚假须在结婚一年内休完（以结婚证书日期为准），过期作废。', 'LeavelGroup', null, null, null, null, 1, 'wooribank');
insert into AR_ITEM (item_no, item_id, item_name, item_en_name, short_name, description, item_group_code, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (18, 'ATT_D_18', '产假', 'Maternity Leave', 'H7', '顺产产假为90天（产前15天，产后75天）；难产105天（产前15天，产后90天），产假时间以医疗机构的证明为准。', 'LeavelGroup', null, null, null, null, 1, 'wooribank');
insert into AR_ITEM (item_no, item_id, item_name, item_en_name, short_name, description, item_group_code, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (20, 'ATT_D_20', '事假', 'Without Pay Leave', 'H9', '所有假期申请，必须经部门经理批准后方可生效。 事假必须事先申请。如遇突发事件不能事先请假的，必须在事假次日补清事假的全部手续。 事假年累计不应超过15天，不应连续超过十天。 ', 'LeavelGroup', null, null, null, null, 1, 'wooribank');
insert into AR_ITEM (item_no, item_id, item_name, item_en_name, short_name, description, item_group_code, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (22, 'ATT_D_22', '年假', '年假', 'H10', '员工在公司工作满十二个月后的次月有带薪年假 五 天（双休和法定节假日除外  ）。工作五年（含五年）至十年者，年休假七  天。 年假当年有效，过期作废。  员工休年假须提前一周申请。', 'LeavelGroup', null, null, to_date('01-04-2012 15:55:03', 'dd-mm-yyyy hh24:mi:ss'), null, 1, 'wooribank');
insert into AR_ITEM (item_no, item_id, item_name, item_en_name, short_name, description, item_group_code, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (24, 'ATT_D_24', '丧假', 'Bereft Leave', 'H2', '员工直系亲属及隔辈亲属辞世时，即员工及其配偶的父母、配偶及子女等，均可获三天带薪假期。路途较远而适当申请的路程假，均应由部门经理批准（不得超过七天）。', 'LeavelGroup', null, null, null, null, 1, 'wooribank');
insert into AR_ITEM (item_no, item_id, item_name, item_en_name, short_name, description, item_group_code, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (30, 'ATT_D_30', '休息', 'Rest', 'N4', '不发生任何考勤异常情况的非正常出勤状态.', 'NormalGroup', null, null, null, null, 1, 'wooribank');
insert into AR_ITEM (item_no, item_id, item_name, item_en_name, short_name, description, item_group_code, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (39, 'ATT_D_39', '早退', null, 'S5', '早退', 'ProprietaryGroup', null, null, null, null, 1, 'wooribank');
insert into AR_ITEM (item_no, item_id, item_name, item_en_name, short_name, description, item_group_code, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (25, 'ATT_D_25', '倒休假', '到休假', 'H3', '加班到休假', 'LeavelGroup', null, null, to_date('26-09-2013 13:48:15', 'dd-mm-yyyy hh24:mi:ss'), null, 1, 'wooribank');
insert into AR_ITEM (item_no, item_id, item_name, item_en_name, short_name, description, item_group_code, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (48, 'ATT_D_48', '工伤假', 'WorkingHurt', 'H11', '因工伤请假', 'LeavelGroup', to_date('23-09-2013 18:37:45', 'dd-mm-yyyy hh24:mi:ss'), '25258456', to_date('25-09-2013 14:47:22', 'dd-mm-yyyy hh24:mi:ss'), null, 1, 'wooribank');
commit;
prompt 19 records loaded
prompt Loading AR_ITEM_PARAM...
insert into AR_ITEM_PARAM (ar_param_no, ar_item_no, ar_group_no, unit, unit_value, min_value, max_value, depend_item, replace_item, card_flag, card_from_flag, card_from_offset, card_from_relation, card_to_flag, card_to_offset, card_to_relation, apply_flag, apply_type, apply_fullday_value, apply_card_priority, date_type, activity)
values (125, 30, 'constant', 'HOUR', 8, 8, 8, null, null, 1, 1, 0, '＝', 1, 0, '＝', 0, null, 8, 0, '2,3', 1);
insert into AR_ITEM_PARAM (ar_param_no, ar_item_no, ar_group_no, unit, unit_value, min_value, max_value, depend_item, replace_item, card_flag, card_from_flag, card_from_offset, card_from_relation, card_to_flag, card_to_offset, card_to_relation, apply_flag, apply_type, apply_fullday_value, apply_card_priority, date_type, activity)
values (382, 25, 'constant', 'HOUR', 0, 0, 8, null, null, 0, 1, 0, '＞', 1, 0, '＞', 1, 'LeaveType010', 8, 1, '1', 1);
insert into AR_ITEM_PARAM (ar_param_no, ar_item_no, ar_group_no, unit, unit_value, min_value, max_value, depend_item, replace_item, card_flag, card_from_flag, card_from_offset, card_from_relation, card_to_flag, card_to_offset, card_to_relation, apply_flag, apply_type, apply_fullday_value, apply_card_priority, date_type, activity)
values (62, 8, 'constant', 'HOUR', 0, 0, 8, null, null, 0, 1, 0, '＝', 1, 0, '＝', 0, null, 8, 0, '1', 1);
insert into AR_ITEM_PARAM (ar_param_no, ar_item_no, ar_group_no, unit, unit_value, min_value, max_value, depend_item, replace_item, card_flag, card_from_flag, card_from_offset, card_from_relation, card_to_flag, card_to_offset, card_to_relation, apply_flag, apply_type, apply_fullday_value, apply_card_priority, date_type, activity)
values (63, 9, 'constant', 'HOUR', 1, 8, 8, null, null, 0, 1, 0, '＞', 1, 0, '＞', 1, 'WT1', 8, 1, '1,2,3', 1);
insert into AR_ITEM_PARAM (ar_param_no, ar_item_no, ar_group_no, unit, unit_value, min_value, max_value, depend_item, replace_item, card_flag, card_from_flag, card_from_offset, card_from_relation, card_to_flag, card_to_offset, card_to_relation, apply_flag, apply_type, apply_fullday_value, apply_card_priority, date_type, activity)
values (64, 10, 'constant', 'HOUR', 1, 8, 8, null, null, 0, 1, 0, '＝', 1, 0, '＝', 1, 'WT2', 8, 1, '1,2,3', 1);
insert into AR_ITEM_PARAM (ar_param_no, ar_item_no, ar_group_no, unit, unit_value, min_value, max_value, depend_item, replace_item, card_flag, card_from_flag, card_from_offset, card_from_relation, card_to_flag, card_to_offset, card_to_relation, apply_flag, apply_type, apply_fullday_value, apply_card_priority, date_type, activity)
values (68, 14, 'constant', 'HOUR', 0, 0, 8, null, null, 0, 1, 0, '＞', 1, 0, '＞', 1, 'LeaveType007', 8, 1, '1', 1);
insert into AR_ITEM_PARAM (ar_param_no, ar_item_no, ar_group_no, unit, unit_value, min_value, max_value, depend_item, replace_item, card_flag, card_from_flag, card_from_offset, card_from_relation, card_to_flag, card_to_offset, card_to_relation, apply_flag, apply_type, apply_fullday_value, apply_card_priority, date_type, activity)
values (69, 17, 'constant', 'HOUR', 0, 0, 8, null, null, 0, 1, 0, '＞', 1, 0, '＞', 1, 'LeaveType001', 8, 1, '1', 1);
insert into AR_ITEM_PARAM (ar_param_no, ar_item_no, ar_group_no, unit, unit_value, min_value, max_value, depend_item, replace_item, card_flag, card_from_flag, card_from_offset, card_from_relation, card_to_flag, card_to_offset, card_to_relation, apply_flag, apply_type, apply_fullday_value, apply_card_priority, date_type, activity)
values (71, 18, 'constant', 'HOUR', 0, 0, 8, null, null, 0, 1, 0, '＝', 1, 0, '＝', 1, 'LeaveType006', 8, 1, '1,2,3', 1);
insert into AR_ITEM_PARAM (ar_param_no, ar_item_no, ar_group_no, unit, unit_value, min_value, max_value, depend_item, replace_item, card_flag, card_from_flag, card_from_offset, card_from_relation, card_to_flag, card_to_offset, card_to_relation, apply_flag, apply_type, apply_fullday_value, apply_card_priority, date_type, activity)
values (73, 20, 'constant', 'HOUR', 0, 0, 8, null, null, 0, 1, 0, '＝', 1, 0, '＝', 1, 'LeaveType009', 8, 1, '1', 1);
insert into AR_ITEM_PARAM (ar_param_no, ar_item_no, ar_group_no, unit, unit_value, min_value, max_value, depend_item, replace_item, card_flag, card_from_flag, card_from_offset, card_from_relation, card_to_flag, card_to_offset, card_to_relation, apply_flag, apply_type, apply_fullday_value, apply_card_priority, date_type, activity)
values (74, 22, 'constant', 'HOUR', 0, 0, 8, null, null, 0, 1, 0, '＝', 1, 0, '＝', 1, 'LeaveType005', 8, 1, '1', 1);
insert into AR_ITEM_PARAM (ar_param_no, ar_item_no, ar_group_no, unit, unit_value, min_value, max_value, depend_item, replace_item, card_flag, card_from_flag, card_from_offset, card_from_relation, card_to_flag, card_to_offset, card_to_relation, apply_flag, apply_type, apply_fullday_value, apply_card_priority, date_type, activity)
values (1, 1, 'constant', 'HOUR', 0, 0, 8, null, null, 0, 1, 0, '＝', 1, 0, '＝', 0, null, 8, 0, '1', 1);
insert into AR_ITEM_PARAM (ar_param_no, ar_item_no, ar_group_no, unit, unit_value, min_value, max_value, depend_item, replace_item, card_flag, card_from_flag, card_from_offset, card_from_relation, card_to_flag, card_to_offset, card_to_relation, apply_flag, apply_type, apply_fullday_value, apply_card_priority, date_type, activity)
values (22, 3, 'constant', 'HOUR', 0, 0, 8, null, null, 0, 0, 0, '＞', 0, 0, '＞', 1, 'WorkingOtType01', 8, 2, '1', 1);
insert into AR_ITEM_PARAM (ar_param_no, ar_item_no, ar_group_no, unit, unit_value, min_value, max_value, depend_item, replace_item, card_flag, card_from_flag, card_from_offset, card_from_relation, card_to_flag, card_to_offset, card_to_relation, apply_flag, apply_type, apply_fullday_value, apply_card_priority, date_type, activity)
values (23, 4, 'constant', 'HOUR', 0, 0, 24, null, null, 1, 1, 0, '＞', 1, 0, '＞', 1, 'WorkingOtType02', 8, 2, '2', 1);
insert into AR_ITEM_PARAM (ar_param_no, ar_item_no, ar_group_no, unit, unit_value, min_value, max_value, depend_item, replace_item, card_flag, card_from_flag, card_from_offset, card_from_relation, card_to_flag, card_to_offset, card_to_relation, apply_flag, apply_type, apply_fullday_value, apply_card_priority, date_type, activity)
values (24, 5, 'constant', 'HOUR', 0, 0, 24, null, null, 1, 1, 0, '＞', 1, 0, '＞', 1, 'WorkingOtType03', 8, 2, '3', 1);
insert into AR_ITEM_PARAM (ar_param_no, ar_item_no, ar_group_no, unit, unit_value, min_value, max_value, depend_item, replace_item, card_flag, card_from_flag, card_from_offset, card_from_relation, card_to_flag, card_to_offset, card_to_relation, apply_flag, apply_type, apply_fullday_value, apply_card_priority, date_type, activity)
values (101, 15, 'constant', 'HOUR', 0, 0, 8, null, null, 1, 1, 1, '＝', 1, 0, '＝', 0, null, 8, 0, '1', 1);
insert into AR_ITEM_PARAM (ar_param_no, ar_item_no, ar_group_no, unit, unit_value, min_value, max_value, depend_item, replace_item, card_flag, card_from_flag, card_from_offset, card_from_relation, card_to_flag, card_to_offset, card_to_relation, apply_flag, apply_type, apply_fullday_value, apply_card_priority, date_type, activity)
values (121, 16, 'constant', 'HOUR', 0, 0, 8, null, null, 0, 1, 0, '＞', 1, 0, '＞', 1, 'LeaveType003', 8, 1, '1', 1);
insert into AR_ITEM_PARAM (ar_param_no, ar_item_no, ar_group_no, unit, unit_value, min_value, max_value, depend_item, replace_item, card_flag, card_from_flag, card_from_offset, card_from_relation, card_to_flag, card_to_offset, card_to_relation, apply_flag, apply_type, apply_fullday_value, apply_card_priority, date_type, activity)
values (141, 24, 'constant', 'HOUR', 0, 0, 8, null, null, 0, 1, 0, '＞', 1, 0, '＞', 1, 'LeaveType002', 8, 1, '1', 1);
insert into AR_ITEM_PARAM (ar_param_no, ar_item_no, ar_group_no, unit, unit_value, min_value, max_value, depend_item, replace_item, card_flag, card_from_flag, card_from_offset, card_from_relation, card_to_flag, card_to_offset, card_to_relation, apply_flag, apply_type, apply_fullday_value, apply_card_priority, date_type, activity)
values (282, 39, 'constant', 'HOUR', 0, 0, 8, null, null, 0, 0, 0, '＞', 0, 0, '＞', 0, null, 8, 0, '1', 1);
insert into AR_ITEM_PARAM (ar_param_no, ar_item_no, ar_group_no, unit, unit_value, min_value, max_value, depend_item, replace_item, card_flag, card_from_flag, card_from_offset, card_from_relation, card_to_flag, card_to_offset, card_to_relation, apply_flag, apply_type, apply_fullday_value, apply_card_priority, date_type, activity)
values (402, 48, 'constant', 'HOUR', 0, 0, 8, null, null, 0, 1, 0, '＞', 1, 0, '＞', 1, 'LeaveType004', 8, 1, '1', 1);
commit;
prompt 19 records loaded
prompt Loading AR_SHIFT010...
insert into AR_SHIFT010 (shift_no, shift_id, shift_name, shift_en_name, date_type_id, descr, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (31, 'SHIFT_31', '保安-早-冬', 'Security Keeper01', null, null, to_date('30-09-2013 14:53:47', 'dd-mm-yyyy hh24:mi:ss'), '25258456', to_date('19-11-2013 08:42:05', 'dd-mm-yyyy hh24:mi:ss'), '20721174', 1, 'wooribank');
insert into AR_SHIFT010 (shift_no, shift_id, shift_name, shift_en_name, date_type_id, descr, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (29, 'SHIFT_29', '正常白班-冬', 'Common WorkHour', null, null, to_date('30-09-2013 14:51:17', 'dd-mm-yyyy hh24:mi:ss'), '25258456', to_date('19-11-2013 08:42:12', 'dd-mm-yyyy hh24:mi:ss'), '20721174', 1, 'wooribank');
insert into AR_SHIFT010 (shift_no, shift_id, shift_name, shift_en_name, date_type_id, descr, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (30, 'SHIFT_30', '周末节假休息', 'Weekend Holiday', null, null, to_date('30-09-2013 14:52:36', 'dd-mm-yyyy hh24:mi:ss'), '25258456', to_date('19-11-2013 08:15:32', 'dd-mm-yyyy hh24:mi:ss'), '20721174', 1, 'wooribank');
insert into AR_SHIFT010 (shift_no, shift_id, shift_name, shift_en_name, date_type_id, descr, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (37, 'SHIFT_37', '厨师01-冬', 'Cook01', null, null, to_date('19-11-2013 11:13:48', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, null, 1, 'wooribank');
insert into AR_SHIFT010 (shift_no, shift_id, shift_name, shift_en_name, date_type_id, descr, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (41, 'SHIFT_41', '安质02-冬', 'QuantityChecker02', null, null, to_date('19-11-2013 11:19:11', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('19-11-2013 11:19:16', 'dd-mm-yyyy hh24:mi:ss'), '20721174', 1, 'wooribank');
insert into AR_SHIFT010 (shift_no, shift_id, shift_name, shift_en_name, date_type_id, descr, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (38, 'SHIFT_38', '厨师02-冬', 'Cook02', null, null, to_date('19-11-2013 11:14:06', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, null, 1, 'wooribank');
insert into AR_SHIFT010 (shift_no, shift_id, shift_name, shift_en_name, date_type_id, descr, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (39, 'SHIFT_39', '厨房03-冬', 'Cook03', null, null, to_date('19-11-2013 11:14:23', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, null, 1, 'wooribank');
insert into AR_SHIFT010 (shift_no, shift_id, shift_name, shift_en_name, date_type_id, descr, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (34, 'SHIFT_34', '车间夜班01-冬', 'Working Shop01', null, null, to_date('19-11-2013 10:09:47', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('19-11-2013 11:08:18', 'dd-mm-yyyy hh24:mi:ss'), '20721174', 1, 'wooribank');
insert into AR_SHIFT010 (shift_no, shift_id, shift_name, shift_en_name, date_type_id, descr, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (35, 'SHIFT_35', '车间夜班02-冬', 'Working Shop02', null, null, to_date('19-11-2013 11:08:18', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, null, 1, 'wooribank');
insert into AR_SHIFT010 (shift_no, shift_id, shift_name, shift_en_name, date_type_id, descr, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (36, 'SHIFT_36', '车间夜班03-冬', 'Working Shop03', null, null, to_date('19-11-2013 11:08:36', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, null, 1, 'wooribank');
insert into AR_SHIFT010 (shift_no, shift_id, shift_name, shift_en_name, date_type_id, descr, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (40, 'SHIFT_40', '安质01-冬', 'QuantityChecker01', null, null, to_date('19-11-2013 11:18:49', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('19-11-2013 11:18:55', 'dd-mm-yyyy hh24:mi:ss'), '20721174', 1, 'wooribank');
insert into AR_SHIFT010 (shift_no, shift_id, shift_name, shift_en_name, date_type_id, descr, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (32, 'SHIFT_32', '保安-中-冬', 'Security Keeper02', null, null, to_date('07-11-2013 08:13:03', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('19-11-2013 08:42:05', 'dd-mm-yyyy hh24:mi:ss'), '20721174', 1, 'wooribank');
insert into AR_SHIFT010 (shift_no, shift_id, shift_name, shift_en_name, date_type_id, descr, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (33, 'SHIFT_33', '保安-晚-冬', 'Security Keeper03', null, null, to_date('07-11-2013 08:14:05', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('19-11-2013 08:42:05', 'dd-mm-yyyy hh24:mi:ss'), '20721174', 1, 'wooribank');
insert into AR_SHIFT010 (shift_no, shift_id, shift_name, shift_en_name, date_type_id, descr, create_date, created_by, update_date, updated_by, activity, cpny_id)
values (42, 'SHIFT_42', '宿管-冬', 'Dormitory01', null, null, to_date('19-11-2013 11:28:58', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, null, 1, 'wooribank');
commit;
prompt 14 records loaded
prompt Loading AR_SHIFT020...
insert into AR_SHIFT020 (pk_no, shift_no, ar_item_no, begin_day_offset, from_time, end_day_offset, to_time, create_date, created_by, update_date, updated_by)
values (45, 31, 15, 0, to_date('12-12-2011 07:30:00', 'dd-mm-yyyy hh24:mi:ss'), 0, to_date('12-12-2011 15:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-09-2013 14:57:18', 'dd-mm-yyyy hh24:mi:ss'), '25258456', to_date('07-11-2013 10:42:50', 'dd-mm-yyyy hh24:mi:ss'), '20721174');
insert into AR_SHIFT020 (pk_no, shift_no, ar_item_no, begin_day_offset, from_time, end_day_offset, to_time, create_date, created_by, update_date, updated_by)
values (42, 29, 15, 0, to_date('12-12-2012 08:00:00', 'dd-mm-yyyy hh24:mi:ss'), 0, to_date('12-12-2012 12:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-09-2013 14:51:51', 'dd-mm-yyyy hh24:mi:ss'), '25258456', null, null);
insert into AR_SHIFT020 (pk_no, shift_no, ar_item_no, begin_day_offset, from_time, end_day_offset, to_time, create_date, created_by, update_date, updated_by)
values (43, 29, 15, 0, to_date('12-12-2011 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), 0, to_date('12-12-2011 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('30-09-2013 14:52:14', 'dd-mm-yyyy hh24:mi:ss'), '25258456', to_date('07-11-2013 09:50:22', 'dd-mm-yyyy hh24:mi:ss'), '20721174');
insert into AR_SHIFT020 (pk_no, shift_no, ar_item_no, begin_day_offset, from_time, end_day_offset, to_time, create_date, created_by, update_date, updated_by)
values (44, 30, 30, 0, to_date('12-12-2011', 'dd-mm-yyyy'), 1, to_date('12-12-2011', 'dd-mm-yyyy'), to_date('30-09-2013 14:53:20', 'dd-mm-yyyy hh24:mi:ss'), '25258456', to_date('19-11-2013 10:03:35', 'dd-mm-yyyy hh24:mi:ss'), '20721174');
insert into AR_SHIFT020 (pk_no, shift_no, ar_item_no, begin_day_offset, from_time, end_day_offset, to_time, create_date, created_by, update_date, updated_by)
values (52, 37, 15, 0, to_date('12-12-2012 07:30:00', 'dd-mm-yyyy hh24:mi:ss'), 0, to_date('12-12-2012 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('19-11-2013 11:15:07', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, null);
insert into AR_SHIFT020 (pk_no, shift_no, ar_item_no, begin_day_offset, from_time, end_day_offset, to_time, create_date, created_by, update_date, updated_by)
values (54, 38, 15, 0, to_date('12-12-2012 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 0, to_date('12-12-2012 23:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('19-11-2013 11:16:27', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, null);
insert into AR_SHIFT020 (pk_no, shift_no, ar_item_no, begin_day_offset, from_time, end_day_offset, to_time, create_date, created_by, update_date, updated_by)
values (56, 40, 15, 0, to_date('12-12-2012 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), 1, to_date('12-12-2012', 'dd-mm-yyyy'), to_date('19-11-2013 11:19:52', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, null);
insert into AR_SHIFT020 (pk_no, shift_no, ar_item_no, begin_day_offset, from_time, end_day_offset, to_time, create_date, created_by, update_date, updated_by)
values (49, 34, 15, 0, to_date('12-12-2012 17:00:00', 'dd-mm-yyyy hh24:mi:ss'), 1, to_date('12-12-2012 01:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('19-11-2013 11:11:02', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, null);
insert into AR_SHIFT020 (pk_no, shift_no, ar_item_no, begin_day_offset, from_time, end_day_offset, to_time, create_date, created_by, update_date, updated_by)
values (50, 35, 15, 0, to_date('12-12-2012 17:30:00', 'dd-mm-yyyy hh24:mi:ss'), 1, to_date('12-12-2012 01:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('19-11-2013 11:11:55', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, null);
insert into AR_SHIFT020 (pk_no, shift_no, ar_item_no, begin_day_offset, from_time, end_day_offset, to_time, create_date, created_by, update_date, updated_by)
values (51, 36, 15, 0, to_date('12-12-2012 19:00:00', 'dd-mm-yyyy hh24:mi:ss'), 1, to_date('12-12-2012 03:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('19-11-2013 11:12:59', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, null);
insert into AR_SHIFT020 (pk_no, shift_no, ar_item_no, begin_day_offset, from_time, end_day_offset, to_time, create_date, created_by, update_date, updated_by)
values (53, 37, 15, 0, to_date('12-12-2012 15:00:00', 'dd-mm-yyyy hh24:mi:ss'), 0, to_date('12-12-2012 17:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('19-11-2013 11:15:50', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, null);
insert into AR_SHIFT020 (pk_no, shift_no, ar_item_no, begin_day_offset, from_time, end_day_offset, to_time, create_date, created_by, update_date, updated_by)
values (55, 39, 15, 0, to_date('12-12-2012 06:00:00', 'dd-mm-yyyy hh24:mi:ss'), 0, to_date('12-12-2012 14:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('19-11-2013 11:17:26', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, null);
insert into AR_SHIFT020 (pk_no, shift_no, ar_item_no, begin_day_offset, from_time, end_day_offset, to_time, create_date, created_by, update_date, updated_by)
values (57, 41, 15, 0, to_date('12-12-2011 13:00:00', 'dd-mm-yyyy hh24:mi:ss'), 0, to_date('12-12-2011 21:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('19-11-2013 11:24:16', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('19-11-2013 11:28:09', 'dd-mm-yyyy hh24:mi:ss'), '20721174');
insert into AR_SHIFT020 (pk_no, shift_no, ar_item_no, begin_day_offset, from_time, end_day_offset, to_time, create_date, created_by, update_date, updated_by)
values (47, 32, 15, 0, to_date('12-12-2011 15:30:00', 'dd-mm-yyyy hh24:mi:ss'), 0, to_date('12-12-2011 23:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('07-11-2013 08:13:46', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('07-11-2013 10:43:03', 'dd-mm-yyyy hh24:mi:ss'), '20721174');
insert into AR_SHIFT020 (pk_no, shift_no, ar_item_no, begin_day_offset, from_time, end_day_offset, to_time, create_date, created_by, update_date, updated_by)
values (48, 33, 15, 0, to_date('12-12-2011 23:30:00', 'dd-mm-yyyy hh24:mi:ss'), 1, to_date('12-12-2011 07:30:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('07-11-2013 08:14:49', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('07-11-2013 10:47:22', 'dd-mm-yyyy hh24:mi:ss'), '20721174');
insert into AR_SHIFT020 (pk_no, shift_no, ar_item_no, begin_day_offset, from_time, end_day_offset, to_time, create_date, created_by, update_date, updated_by)
values (58, 42, 15, 0, to_date('12-12-2012 10:30:00', 'dd-mm-yyyy hh24:mi:ss'), 0, to_date('12-12-2012 19:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('19-11-2013 11:29:48', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, null);
commit;
prompt 16 records loaded
prompt Loading AR_STA_ITEM...
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (2, 'ATT_M_2', '病假(天)', 'Sick Leave', 'DAY', .1, 14, '200701', null, 'NUMBER(14,4)', to_date('08-09-2011 09:32:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (6, 'ATT_M_6', '旷工(天)', 'Absence', 'DAY', .1, 6, '200701', null, 'NUMBER(14,4)', to_date('08-09-2011 09:32:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (7, 'ATT_M_7', '平日加班(h)', 'Weekday OT', 'HOUR', .1, 5, '200701', null, 'NUMBER(14,4)', to_date('08-09-2011 09:32:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (8, 'ATT_M_8', '周末加班(h)', 'Weekend OT', 'HOUR', .1, 3, '200701', null, 'NUMBER(14,4)', to_date('08-09-2011 09:32:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (9, 'ATT_M_9', '节日加班(天)', 'Holiday OT', 'DAY', .1, 4, '200701', null, 'NUMBER(14,4)', to_date('08-09-2011 09:32:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (12, 'ATT_M_12', '婚假(天)', 'Marriage Leave', 'DAY', .1, 16, '200701', null, 'NUMBER(14,4)', to_date('08-09-2011 09:32:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (15, 'ATT_M_15', '丧假(天)', 'Bereavement Leave', 'DAY', .1, 17, '200701', null, 'NUMBER(14,4)', to_date('08-09-2011 09:32:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (20, 'ATT_M_20', '年假', 'Annual Vacation', 'DAY', .5, 20, '200701', null, 'NUMBER(14,4)', to_date('08-09-2011 09:32:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (29, 'ATT_M_29', '出差', 'Domestic Travel', 'DAY', .5, 28, '200701', null, 'NUMBER(14,4)', to_date('08-09-2011 09:32:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (30, 'ATT_M_30', '公出', 'Overseas Travel', 'DAY', .5, 29, '200701', null, 'NUMBER(14,4)', to_date('08-09-2011 09:32:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (62, 'ATT_M_62', '事假时数', 'Without Pay Leave', 'HOUR', .5, 25, '200701', null, 'NUMBER(14,4)', to_date('08-09-2011 09:32:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (53, 'ATT_M_53', '早退(次)', 'Leave_Early', 'DAY', 1, 13, '200701', null, 'NUMBER(14,4)', to_date('08-09-2011 09:32:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (39, 'ATT_M_39', '产假(天)', 'Maternity Leave', 'DAY', 1, 18, '200701', null, 'NUMBER(14,4)', to_date('08-09-2011 09:32:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (41, 'ATT_M_41', '哺乳假', 'Casual Leave', 'DAY', .5, 22, '200701', null, 'NUMBER(14,4)', to_date('08-09-2011 09:32:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (52, 'ATT_M_52', '迟到(30min内)次数', 'Tardiness1', 'DAY', 1, 11, '200701', null, 'NUMBER(14,4)', to_date('08-09-2011 09:32:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (56, 'ATT_M_56', '应出勤天数', 'Regular Work Days', 'DAY', 1, 30, '200701', null, 'NUMBER(14,4)', to_date('08-09-2011 09:32:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (58, 'ATT_M_58', '实际出勤天数(天)', 'Actual Work Days', 'DAY', .1, 1, '200701', null, 'NUMBER(14,4)', to_date('08-09-2011 09:32:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (63, 'ATT_M_63', '事假', 'Without Pay Leave', 'DAY', .1, 26, '200701', null, 'NUMBER(14,4)', to_date('08-09-2011 09:32:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (65, 'ATT_M_65', '加班总时间', 'Total Overtime', 'HOUR', .5, 21, '200701', null, 'NUMBER(14,4)', to_date('08-09-2011 09:32:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (73, 'ATT_M_73', '本月天数', 'MONTH_DAYS', 'DAY', 1, 31, '201005', null, 'NUMBER(14,4)', to_date('08-09-2011 09:32:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (45, 'ATT_M_45', '无薪假时数', 'Not pay', 'DAY', .5, 27, '200701', null, 'NUMBER(14,4)', to_date('08-09-2011 09:32:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (21, 'ATT_M_21', '到休假', '到休假', 'DAY', .5, 23, '200701', null, 'NUMBER(14,4)', to_date('08-09-2011 09:32:14', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (115, 'ATT_M_115', '迟到(30min外)次数', 'Tardiness2', 'DAY', 1, 12, null, null, 'NUMBER(14,4)', to_date('18-09-2013 10:58:19', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (118, 'ATT_M_118', '工伤假(天)', 'WorkingHurt', 'HOUR', .1, 15, null, null, 'NUMBER(14,4)', to_date('23-09-2013 18:53:29', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (113, 'ATT_M_113', '夜班天数(天)', 'Night_Days', 'DAY', 1, 10, null, null, 'NUMBER(14,4)', to_date('18-09-2013 10:11:50', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (114, 'ATT_M_114', '正休天数', 'Weekend_Days', 'DAY', 1, 2, null, null, 'NUMBER(14,4)', to_date('18-09-2013 10:33:27', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 1, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (117, 'ATT_M_117', '法定假日', 'LegalHolidays', 'DAY', 1, 19, null, null, 'NUMBER(14,4)', to_date('23-09-2013 17:45:41', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (110, 'ATT_M_110', '考勤合计(21.75天制)', 'Total_Att1', 'DAY', .1, 7, null, null, 'NUMBER(14,4)', to_date('17-09-2013 11:22:22', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (112, 'ATT_M_112', '正常出勤天数(天)', 'Normal_Work_Days', 'DAY', .1, 0, null, null, 'NUMBER(14,4)', to_date('18-09-2013 10:03:38', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (111, 'ATT_M_111', '考勤合计(26天制_厨师)', 'Total_Att2', 'DAY', .1, 8, null, null, 'NUMBER(14,4)', to_date('17-09-2013 13:37:15', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
insert into AR_STA_ITEM (item_no, item_id, item_name, item_en_name, unit, min_unit, calcu_order, from_date, to_date, datatype, create_date, created_by, update_date, updated_by, activity, cpny_id, description)
values (119, 'ATT_M_119', '考勤合计(车间管理、起重+行车)', 'Total_Att3', 'DAY', .1, 9, null, null, 'NUMBER(14,4)', to_date('24-09-2013 16:20:11', 'dd-mm-yyyy hh24:mi:ss'), null, to_date('24-09-2013 16:21:23', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 0, 'wooribank', null);
commit;
prompt 31 records loaded
prompt Loading AR_STA_FORMULAR...
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (130, 53, 'ATT_ITEM.ATT_D_39  > 0', 'COUNT( ATT_ITEM.ATT_D_39 )*8*60', null, null, null, null, null, to_date('16-08-2012 10:50:59', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('18-09-2013 10:59:40', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 1, ' 早退 ');
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (132, 62, null, ' SUM(ATT_ITEM.ATT_D_20 )', null, null, null, null, null, to_date('07-11-2012 09:27:23', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, null, 1, ' 事假 ');
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (77, 9, null, 'SUM(ATT_ITEM.ATT_D_5) ', null, null, null, null, null, null, null, to_date('18-09-2013 11:05:20', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 1, null);
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (78, 2, null, 'SUM(ATT_ITEM.ATT_D_16)', null, null, null, null, null, null, null, to_date('18-09-2013 11:03:22', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 1, null);
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (79, 12, null, 'SUM(ATT_ITEM.ATT_D_17) ', null, null, null, null, null, null, null, to_date('18-09-2013 11:03:36', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 1, ' ');
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (80, 41, null, 'SUM(ATT_ITEM.ATT_D_14)', null, null, null, null, null, null, null, null, null, 1, null);
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (82, 15, null, 'SUM(ATT_ITEM.ATT_D_24)', null, null, null, null, null, null, null, to_date('18-09-2013 11:03:49', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 1, null);
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (83, 20, null, 'SUM(ATT_ITEM.ATT_D_22)', null, null, null, null, null, null, null, null, null, 1, null);
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (85, 6, null, 'SUM(ATT_ITEM.ATT_D_8)', null, null, null, null, null, null, null, to_date('18-09-2013 11:29:04', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 1, null);
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (87, 63, ' STA_ITEM.ATT_M_62  > = 3', ' SUM(ATT_ITEM.ATT_D_20 )', null, null, null, null, null, null, null, to_date('22-11-2012 14:53:31', 'dd-mm-yyyy hh24:mi:ss'), '20721174', 1, null);
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (88, 39, null, 'SUM(ATT_ITEM.ATT_D_18)', null, null, null, null, null, null, null, null, null, 1, null);
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (90, 52, 'ATT_ITEM.ATT_D_1 > 0 AND  ATT_ITEM.ATT_D_1  < =30', 'COUNT(ATT_ITEM.ATT_D_1)*8*60', null, null, null, null, null, null, null, to_date('18-09-2013 11:37:50', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 1, '迟到时间小于30分钟');
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (91, 29, null, 'SUM(ATT_ITEM.ATT_D_9)', null, null, null, null, null, null, null, null, null, 1, null);
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (92, 30, null, 'SUM(ATT_ITEM.ATT_D_10)', null, null, null, null, null, null, null, null, null, 1, null);
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (96, 56, null, 'GET_AR_MONTH_DAYS(STA_ITEM.AR_MONTH)*8*60-GET_AR_MONTH_WEEKENDS(STA_ITEM.AR_MONTH)', null, null, null, null, null, null, null, to_date('23-09-2013 16:20:59', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 1, null);
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (97, 58, '1=1', 'SUM(ATT_ITEM.ATT_D_15)+SUM(ATT_ITEM.ATT_D_4)+SUM(ATT_ITEM.ATT_D_5) ', null, null, null, null, null, null, null, to_date('26-09-2013 17:33:46', 'dd-mm-yyyy hh24:mi:ss'), '20721176', 1, null);
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (99, 65, null, 'SUM( ATT_ITEM.ATT_D_3 ) + SUM( ATT_ITEM.ATT_D_4 ) + SUM( ATT_ITEM.ATT_D_5 )', null, null, null, null, null, null, null, to_date('23-09-2013 16:07:07', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 1, ' 平日加班  +  休日加班  +  节日加班 ');
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (75, 7, null, 'SUM(ATT_ITEM.ATT_D_3)', null, null, null, null, null, null, null, null, null, 1, null);
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (76, 8, null, 'SUM(ATT_ITEM.ATT_D_4)', null, null, null, null, null, null, null, null, null, 1, null);
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (110, 73, null, 'GET_AR_MONTH_DAYS(STA_ITEM.AR_MONTH)*8*60', null, null, null, null, null, null, null, to_date('18-09-2013 10:48:41', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 1, null);
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (131, 21, null, ' SUM(ATT_ITEM.ATT_D_25 )', null, null, null, null, null, to_date('31-10-2012 15:53:44', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, null, 1, null);
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (138, 112, '1=1', 'SUM(ATT_ITEM.ATT_D_15)', null, null, null, null, null, to_date('18-09-2013 10:04:53', 'dd-mm-yyyy hh24:mi:ss'), '25258456', to_date('26-09-2013 17:32:46', 'dd-mm-yyyy hh24:mi:ss'), '20721176', 1, null);
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (139, 114, '1=1', 'GET_AR_MONTH_WEEKENDS(STA_ITEM.AR_MONTH)', null, null, null, null, null, to_date('18-09-2013 10:45:44', 'dd-mm-yyyy hh24:mi:ss'), '25258456', to_date('26-09-2013 17:34:03', 'dd-mm-yyyy hh24:mi:ss'), '20721176', 1, '月周日天数');
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (143, 117, null, 'GET_LEGAL_HOLIDAYS(STA_ITEM.AR_MONTH)', null, null, null, null, null, to_date('23-09-2013 17:50:06', 'dd-mm-yyyy hh24:mi:ss'), '25258456', to_date('25-09-2013 15:01:45', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 1, '计算法定假日公式');
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (136, 110, null, 'SUM( ATT_ITEM.ATT_D_15 ) + SUM( ATT_ITEM.ATT_D_4 ) * 2 + SUM(  ATT_ITEM.ATT_D_3 ) * 1.5 + SUM( ATT_ITEM.ATT_D_5 ) * 3 +  SUM(ATT_ITEM.ATT_D_22 )  - 3 * SUM( ATT_ITEM.ATT_D_8 ) + SUM( ATT_ITEM.ATT_D_24 ) + SUM( ATT_ITEM.ATT_D_17 ) + SUM( ATT_ITEM.ATT_D_9 ) + SUM( ATT_ITEM.ATT_D_10 )  + SUM( ATT_ITEM.ATT_D_48 ) + MAX(GET_LEGAL_HOLIDAYS(STA_ITEM.AR_MONTH))', null, null, null, null, null, to_date('17-09-2013 11:22:39', 'dd-mm-yyyy hh24:mi:ss'), '25258456', to_date('24-09-2013 17:07:12', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 1, ' 正常出勤  +  休日加班  * 2 +  节日加班  * 1.5 +  节日加班  * 3 +  年假   - 3 *  旷工  +  丧假  +  婚假  +  国内出差  +  国外出差  + 工伤假 +法定假日计算公式(最后公式：MAX(GET_LEGAL_HOLIDAYS(STA_ITEM.AR_MONTH))用于计算法定假日，请无随意更改)');
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (137, 111, null, '(SUM( ATT_ITEM.ATT_D_15 ) + SUM( ATT_ITEM.ATT_D_4 ) + SUM( ATT_ITEM.ATT_D_3 ) + SUM( ATT_ITEM.ATT_D_5 )  + SUM( ATT_ITEM.ATT_D_24 ) + SUM( ATT_ITEM.ATT_D_17 ) + SUM( ATT_ITEM.ATT_D_48 ) ) + MAX(GET_AR_MONTH_WEEKENDS(STA_ITEM.AR_MONTH))', null, null, null, null, null, to_date('17-09-2013 13:40:30', 'dd-mm-yyyy hh24:mi:ss'), '25258456', to_date('25-09-2013 14:57:18', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 1, ' 正常出勤  +  休日加班  +  平日加班  +  节日加班    +  丧假  +  婚假  +  工伤假  + 正休天数');
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (140, 115, ' ATT_ITEM.ATT_D_1  > 30', 'COUNT(ATT_ITEM.ATT_D_1)*8*60', null, null, null, null, null, to_date('18-09-2013 11:32:38', 'dd-mm-yyyy hh24:mi:ss'), '25258456', to_date('18-09-2013 11:38:04', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 1, '迟到时间大于30分钟');
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (142, 113, null, 'GET_AR_MONTH_NIGHTDAYS(STA_ITEM.AR_MONTH,STA_ITEM.EMPID)', null, null, null, null, null, to_date('18-09-2013 17:26:55', 'dd-mm-yyyy hh24:mi:ss'), '25258456', to_date('25-09-2013 15:00:41', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 1, '夜班天数');
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (144, 118, null, 'SUM( ATT_ITEM.ATT_D_48 )', null, null, null, null, null, to_date('23-09-2013 18:55:19', 'dd-mm-yyyy hh24:mi:ss'), '25258456', null, null, 1, ' 工伤假 ');
insert into AR_STA_FORMULAR (formular_no, item_no, condition, formular, condition_var, formular_var, table_name, column_type, ar_type_no, create_date, created_by, update_date, updated_by, orderno, description)
values (145, 119, null, 'SUM( ATT_ITEM.ATT_D_15 ) + SUM( ATT_ITEM.ATT_D_4 )  + SUM( ATT_ITEM.ATT_D_5 ) * 3 +  SUM(ATT_ITEM.ATT_D_22 )  - 3 * SUM( ATT_ITEM.ATT_D_8 ) + SUM( ATT_ITEM.ATT_D_24 ) + SUM( ATT_ITEM.ATT_D_17 ) +  SUM( ATT_ITEM.ATT_D_48 ) + MAX(GET_LEGAL_HOLIDAYS(STA_ITEM.AR_MONTH))', null, null, null, null, null, to_date('24-09-2013 16:22:50', 'dd-mm-yyyy hh24:mi:ss'), '25258456', to_date('25-09-2013 14:59:58', 'dd-mm-yyyy hh24:mi:ss'), '25258456', 1, '正常出勤   + 休日加班  +   节日加班  * 3 +   年假    - 3 *   旷工   +  丧假  +  婚假  +    工伤假  + （法定假日）MAX( GET_LEGAL_HOLIDAYS( 考勤月 ) ) ');
commit;
prompt 30 records loaded
prompt Enabling foreign key constraints for AR_ITEM_PARAM...
alter table AR_ITEM_PARAM enable constraint FK_AR_ITEM_PARAM;
prompt Enabling foreign key constraints for AR_STA_FORMULAR...
alter table AR_STA_FORMULAR enable constraint FK_AR_STA_FORMULAR;
prompt Enabling triggers for AR_CONDITION_LIST...
alter table AR_CONDITION_LIST enable all triggers;
prompt Enabling triggers for AR_DYNAMIC_GROUP...
alter table AR_DYNAMIC_GROUP enable all triggers;
prompt Enabling triggers for AR_DYNAMIC_GROUP_EMP...
alter table AR_DYNAMIC_GROUP_EMP enable all triggers;
prompt Enabling triggers for AR_ITEM...
alter table AR_ITEM enable all triggers;
prompt Enabling triggers for AR_ITEM_PARAM...
alter table AR_ITEM_PARAM enable all triggers;
prompt Enabling triggers for AR_SHIFT010...
alter table AR_SHIFT010 enable all triggers;
prompt Enabling triggers for AR_SHIFT020...
alter table AR_SHIFT020 enable all triggers;
prompt Enabling triggers for AR_STA_ITEM...
alter table AR_STA_ITEM enable all triggers;
prompt Enabling triggers for AR_STA_FORMULAR...
alter table AR_STA_FORMULAR enable all triggers;
set feedback on
set define on
prompt Done.
exit;