prompt PL/SQL Developer import file
prompt Created on 2014年2月25日 by Wzh
set feedback off
set define off
prompt Disabling triggers for SY_PARAMETER...
alter table SY_PARAMETER disable all triggers;
prompt Deleting SY_PARAMETER...
delete from SY_PARAMETER;
commit;
prompt Loading SY_PARAMETER...
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (51, 'trainingApplySentMailFlag', '培训申请后是否发送邮件通知审核者', '培训申请后是否发送邮件通知审核者', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (63, 'checkBTApplyStartEndTime', '出差始末时间前后检查', '出差始末时间前后检查', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (64, 'checkBTApplyLeaveConflict', '是否执行出差与休假冲突检查', '是否执行出差与休假冲突检查', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (65, 'checkBTApplyBTConflict', '是否执行出差与出差冲突检查', '是否执行出差与出差冲突检查', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (52, 'cardApplySentMailFlag', '打卡申请后是否发送邮件通知审核者', '打卡申请后是否发送邮件通知审核者', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (53, 'matchApplySentMailFlag', '值班申请后是否发送邮件通知审核者', '值班申请后是否发送邮件通知审核者', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (54, 'checkAffairLeaveAnnual', '事假申请是否执行剩于年假检查', '事假申请是否执行剩于年假检查', 'false', 'ess0000', null, 'BOOLEAN', null, null, to_date('06-11-2012 17:10:50', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (55, 'checkAffairLeave', '事假申请是否验证全年事假合计上限', '事假申请是否验证全年事假合计上限', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (56, 'checkSickLeaveAnnual', '病假申请是否检查剩余年假', '病假申请是否检查剩余年假', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (57, 'checkSickLeave', '病假申请是否验证全年病假合计上限', '病假申请是否验证全年病假合计上限', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (58, 'checkDetailLock', '是否进行日考勤锁定验证', '是否进行日考勤锁定验证', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (59, 'cmmandAffirFlag', '是否进行发令审核', '是否进行发令审核', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (60, 'isCarApplyAfrrimFlag', '车辆申请是否须审核', '车辆申请是否须审核', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (61, 'payOpenAfrrimFlag', '是否进行工资开放审核', '是否进行工资开放审核', 'true', 'pa0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (62, 'otApplyEtnCheck', '加班申请是否执行加班时间与培训申请时间冲突检查 ', '加班申请是否执行加班时间与培训申请时间冲突检查 ', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (200, 'supervisorRoleNo', '考勤员角色号', '考勤员角色号', '134', 'ar0000', null, 'NUMBER', to_date('26-03-2012 10:32:44', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('26-03-2012 11:21:24', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (66, 'checkExpApplyExpConflict', '是否执行费用申请与费用申请冲突检查', '是否执行费用申请与费用申请冲突检查', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (1, 'alertEndContractDays', '合同到期提醒', '合同到期提醒', '60', 'mat0000', null, 'NUMBER', null, null, to_date('17-09-2013 15:35:08', 'dd-mm-yyyy hh24:mi:ss'), '25258464', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (2, 'alertProbationDays', '试用转正提醒', '试用转正提醒', '15', 'hr0000', null, 'NUMBER(14,4)', null, null, to_date('17-09-2013 13:56:58', 'dd-mm-yyyy hh24:mi:ss'), '25258464', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (3, 'alertPassportDays', '证照到期提醒', '证照到期提醒', '15', 'hr0000', null, 'NUMBER', null, null, to_date('17-09-2013 13:56:58', 'dd-mm-yyyy hh24:mi:ss'), '25258464', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (4, 'alertResignationDays', '离职后可再入职间隔天数', '离职后可再入职间隔天数', '90', 'hr0000', null, 'BOOLEAN', null, null, to_date('17-09-2013 13:56:58', 'dd-mm-yyyy hh24:mi:ss'), '25258464', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (5, 'logoImage', 'logo', 'logo', 'logo', 'hr0000', null, 'VARCHAR2', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (6, 'empidNums', '工号位数', '工号位数', '4', 'hr0000', null, 'NUMBER', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (7, 'transName', '人事令号', '人事令号', '2010,', 'hr0000', null, 'VARCHAR2', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (8, 'empIdPrefix', '工号前缀', '工号前缀', 'M-,K-,O-,J-,Z-,JF-,JL-,JFL-,H-,A-', 'hr0000', null, 'VARCHAR2', null, null, to_date('17-09-2013 13:56:30', 'dd-mm-yyyy hh24:mi:ss'), '25258464', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (9, 'empIdcardNo', '公司不录用员工身份证号码段', '公司不录用员工身份证号码段', '120,130924,130925', 'hr0000', null, 'VARCHAR2', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (10, 'empPattern', '工号组成', '工号组成', '{0}{1,date,yyyyMM}{2,number,100}', 'hr0000', null, 'VARCHAR2', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (11, 'isAddLastAffirmor', '是否添加最后一级审核者', '是否添加最后一级审核者', 'false', 'hr0000', null, 'BOOLEAN', null, null, to_date('20-03-2012 14:30:04', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (12, 'isRewardCmmandAffirFlag', '奖励发令是否须审核', '奖励发令是否须审核', 'true', 'hr0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (13, 'isPunCmmandAffirFlag', '惩戒发令是否须审核', '惩戒发令是否须审核', 'true', 'hr0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (14, 'isPromoteCmmandAffirFlag', '转正发令是否须审核', '转正发令是否须审核', 'true', 'hr0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (15, 'isResignationCmmandAffirFlag', '离职发令是否须审核', '离职发令是否须审核', 'false', 'hr0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (16, 'transLastAffirmor', '最后一级审核者工号', '最后一级审核者工号', null, 'hr0000', null, 'VARCHAR2', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (17, 'autoExeTransfer', '人事令自动生效', '人事令自动生效', 'false', 'hr0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (18, 'emailReplyAddr', 'E-MAIL回复地址', 'E-MAIL回复地址', 'sipingsoft.hrms@sipingsoft.com', 'ess0000', null, 'VARCHAR2', null, null, to_date('26-10-2012 13:26:48', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (19, 'emailReplyUserID', 'E-MAIL回复用户', 'E-MAIL回复用户', 'sipingsoft.hrms@sipingsoft.com', 'ess0000', null, 'VARCHAR2', null, null, to_date('26-10-2012 13:26:48', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (20, 'emailReplyPassword', 'E-MAIL回复密码', 'E-MAIL回复密码', 'sipingsoft147258', 'ess0000', null, 'VARCHAR2', null, null, to_date('26-10-2012 13:26:48', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (21, 'autoConfirm', '自动人事确认', '自动人事确认', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (22, 'containsOwner', '取审核者时是否包含自己', '取审核者时是否包含自己', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (23, 'autoSendMail', '自动向下一级审核者发邮件', '自动向下一级审核者发邮件', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (24, 'preConfirm', '人事是否可以提前进行确认', '人事是否可以提前进行确认', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (25, 'reConfirm', '人事是否可以在确认后重新确认', '人事是否可以在确认后重新确认', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (26, 'delAfterConfirm', '人事确认后是否可以删除', '人事确认后是否可以删除', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (27, 'modifiedAfterAffirm', '审核是否可反悔', '审核是否可反悔', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (28, 'checkOtApplyStartEndTime', '加班申请是否执行始末时间先后检查', '加班申请是否执行始末时间先后检查', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (29, 'checkOtApplyOtConflict', '加班申请是否执行加班时间与加班时间冲突检查', '加班申请是否执行加班时间与加班时间冲突检查', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (30, 'checkOtApplyShiftConflict', '加班申请是否执行加班时间与班次时间冲突检查', '加班申请是否执行加班时间与班次时间冲突检查', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (31, 'checkOtApplyLeaveConflict', '加班申请是否执行加班时间与休假时间冲突检查', '加班申请是否执行加班时间与休假时间冲突检查', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (32, 'checkOtApplyEvectionConflict', '加班申请是否执行加班时间与出差时间冲突检查', '加班申请是否执行加班时间与出差时间冲突检查', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (33, 'checkOtApplyMatchConflict', '加班申请是否执行加班时间与值班时间冲突检查', '加班申请是否执行加班时间与值班时间冲突检查', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (34, 'otApplyDaysBefore', '加班可申请*天前的加班', '加班可申请*天前的加班', '7', 'ess0000', '0:当天(可申请任意时间加班),-X', 'NUMBER', null, null, to_date('01-11-2012 09:49:12', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (35, 'otApplyDaysAfter', '加班可申请*天后的加班', '加班可申请*天后的加班', '7', 'ess0000', '0:当天(可申请任意时间加班),+X', 'NUMBER', null, null, to_date('01-11-2012 09:49:12', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (36, 'otApplyTypeCheckFlag', '加班类型判断标志', '加班类型判断标志', '0', 'ess0000', '-1:不判断(取手工提交值);  0:自动判断与手工提交数据比对;  1:取自动判断值;', 'NUMBER', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (37, 'otApplyMaxHours', '加班月累计小时数上限', '加班月累计小时数上限', '36', 'ess0000', '-1:不判断(可无限申请)', 'NUMBER', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (38, 'affairLeaveMaxHours', '全年事假累计小时数上限', '年事假累计小时数上限', '240', 'ess0000', '-1:不判断(可无限申请)', 'NUMBER', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (39, 'sickLeaveMaxHours', '全年病假累计小时数上限', '年病假累计小时数上限', '240', 'ess0000', '-1:不判断(可无限申请)', 'NUMBER', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (40, 'checkLeaveApplyStartEndTime', '休假始末时间前后检查', '休假始末时间前后检查', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (41, 'checkLeaveApplyOtConflict', '是否执行休假与加班冲突检查', '是否执行休假与加班冲突检查', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (42, 'checkLeaveApplyLeaveConflict', '是否执行休假与休假冲突检查', '是否执行休假与休假冲突检查', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (43, 'checkLeaveApplyMatchConflict', '是否执行休假与值班冲突检查', '是否执行休假与值班冲突检查', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (44, 'checkMatchApplyStartEndTime', '值班始末时间前后检查', '值班始末时间前后检查', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (45, 'checkMatchApplyOtConflict', '是否执行值班与加班冲突检查', '是否执行值班与加班冲突检查', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (46, 'checkMatchApplyLeaveConflict', '是否执行值班与休假冲突检查', '是否执行值班与休假冲突检查', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (47, 'checkMatchApplyMatchConflict', '是否执行值班与值班冲突检查', '是否执行值班与值班冲突检查', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (48, 'otApplySentMailFlag', '加班申请后是否发送邮件通知审核者', '加班申请后是否发送邮件通知审核者', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (49, 'leaveApplySentMailFlag', '休假申请后是否发送邮件通知审核者', '休假申请后是否发送邮件通知审核者', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (50, 'btApplySentMailFlag', '出差申请后是否发送邮件通知审核者', '出差申请后是否发送邮件通知审核者', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
commit;
prompt 67 records loaded
prompt Enabling triggers for SY_PARAMETER...
alter table SY_PARAMETER enable all triggers;
set feedback on
set define on
prompt Done.
exit;