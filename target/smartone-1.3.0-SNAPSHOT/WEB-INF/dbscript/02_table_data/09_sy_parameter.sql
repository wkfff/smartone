prompt PL/SQL Developer import file
prompt Created on 2014��2��25�� by Wzh
set feedback off
set define off
prompt Disabling triggers for SY_PARAMETER...
alter table SY_PARAMETER disable all triggers;
prompt Deleting SY_PARAMETER...
delete from SY_PARAMETER;
commit;
prompt Loading SY_PARAMETER...
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (51, 'trainingApplySentMailFlag', '��ѵ������Ƿ����ʼ�֪ͨ�����', '��ѵ������Ƿ����ʼ�֪ͨ�����', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (63, 'checkBTApplyStartEndTime', '����ʼĩʱ��ǰ����', '����ʼĩʱ��ǰ����', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (64, 'checkBTApplyLeaveConflict', '�Ƿ�ִ�г������ݼٳ�ͻ���', '�Ƿ�ִ�г������ݼٳ�ͻ���', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (65, 'checkBTApplyBTConflict', '�Ƿ�ִ�г���������ͻ���', '�Ƿ�ִ�г���������ͻ���', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (52, 'cardApplySentMailFlag', '��������Ƿ����ʼ�֪ͨ�����', '��������Ƿ����ʼ�֪ͨ�����', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (53, 'matchApplySentMailFlag', 'ֵ��������Ƿ����ʼ�֪ͨ�����', 'ֵ��������Ƿ����ʼ�֪ͨ�����', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (54, 'checkAffairLeaveAnnual', '�¼������Ƿ�ִ��ʣ����ټ��', '�¼������Ƿ�ִ��ʣ����ټ��', 'false', 'ess0000', null, 'BOOLEAN', null, null, to_date('06-11-2012 17:10:50', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (55, 'checkAffairLeave', '�¼������Ƿ���֤ȫ���¼ٺϼ�����', '�¼������Ƿ���֤ȫ���¼ٺϼ�����', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (56, 'checkSickLeaveAnnual', '���������Ƿ���ʣ�����', '���������Ƿ���ʣ�����', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (57, 'checkSickLeave', '���������Ƿ���֤ȫ�겡�ٺϼ�����', '���������Ƿ���֤ȫ�겡�ٺϼ�����', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (58, 'checkDetailLock', '�Ƿ�����տ���������֤', '�Ƿ�����տ���������֤', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (59, 'cmmandAffirFlag', '�Ƿ���з������', '�Ƿ���з������', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (60, 'isCarApplyAfrrimFlag', '���������Ƿ������', '���������Ƿ������', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (61, 'payOpenAfrrimFlag', '�Ƿ���й��ʿ������', '�Ƿ���й��ʿ������', 'true', 'pa0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (62, 'otApplyEtnCheck', '�Ӱ������Ƿ�ִ�мӰ�ʱ������ѵ����ʱ���ͻ��� ', '�Ӱ������Ƿ�ִ�мӰ�ʱ������ѵ����ʱ���ͻ��� ', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (200, 'supervisorRoleNo', '����Ա��ɫ��', '����Ա��ɫ��', '134', 'ar0000', null, 'NUMBER', to_date('26-03-2012 10:32:44', 'dd-mm-yyyy hh24:mi:ss'), '20721174', to_date('26-03-2012 11:21:24', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (66, 'checkExpApplyExpConflict', '�Ƿ�ִ�з�����������������ͻ���', '�Ƿ�ִ�з�����������������ͻ���', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (1, 'alertEndContractDays', '��ͬ��������', '��ͬ��������', '60', 'mat0000', null, 'NUMBER', null, null, to_date('17-09-2013 15:35:08', 'dd-mm-yyyy hh24:mi:ss'), '25258464', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (2, 'alertProbationDays', '����ת������', '����ת������', '15', 'hr0000', null, 'NUMBER(14,4)', null, null, to_date('17-09-2013 13:56:58', 'dd-mm-yyyy hh24:mi:ss'), '25258464', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (3, 'alertPassportDays', '֤�յ�������', '֤�յ�������', '15', 'hr0000', null, 'NUMBER', null, null, to_date('17-09-2013 13:56:58', 'dd-mm-yyyy hh24:mi:ss'), '25258464', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (4, 'alertResignationDays', '��ְ�������ְ�������', '��ְ�������ְ�������', '90', 'hr0000', null, 'BOOLEAN', null, null, to_date('17-09-2013 13:56:58', 'dd-mm-yyyy hh24:mi:ss'), '25258464', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (5, 'logoImage', 'logo', 'logo', 'logo', 'hr0000', null, 'VARCHAR2', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (6, 'empidNums', '����λ��', '����λ��', '4', 'hr0000', null, 'NUMBER', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (7, 'transName', '�������', '�������', '2010,', 'hr0000', null, 'VARCHAR2', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (8, 'empIdPrefix', '����ǰ׺', '����ǰ׺', 'M-,K-,O-,J-,Z-,JF-,JL-,JFL-,H-,A-', 'hr0000', null, 'VARCHAR2', null, null, to_date('17-09-2013 13:56:30', 'dd-mm-yyyy hh24:mi:ss'), '25258464', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (9, 'empIdcardNo', '��˾��¼��Ա�����֤�����', '��˾��¼��Ա�����֤�����', '120,130924,130925', 'hr0000', null, 'VARCHAR2', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (10, 'empPattern', '�������', '�������', '{0}{1,date,yyyyMM}{2,number,100}', 'hr0000', null, 'VARCHAR2', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (11, 'isAddLastAffirmor', '�Ƿ�������һ�������', '�Ƿ�������һ�������', 'false', 'hr0000', null, 'BOOLEAN', null, null, to_date('20-03-2012 14:30:04', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (12, 'isRewardCmmandAffirFlag', '���������Ƿ������', '���������Ƿ������', 'true', 'hr0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (13, 'isPunCmmandAffirFlag', '�ͽ䷢���Ƿ������', '�ͽ䷢���Ƿ������', 'true', 'hr0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (14, 'isPromoteCmmandAffirFlag', 'ת�������Ƿ������', 'ת�������Ƿ������', 'true', 'hr0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (15, 'isResignationCmmandAffirFlag', '��ְ�����Ƿ������', '��ְ�����Ƿ������', 'false', 'hr0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (16, 'transLastAffirmor', '���һ������߹���', '���һ������߹���', null, 'hr0000', null, 'VARCHAR2', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (17, 'autoExeTransfer', '�������Զ���Ч', '�������Զ���Ч', 'false', 'hr0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (18, 'emailReplyAddr', 'E-MAIL�ظ���ַ', 'E-MAIL�ظ���ַ', 'sipingsoft.hrms@sipingsoft.com', 'ess0000', null, 'VARCHAR2', null, null, to_date('26-10-2012 13:26:48', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (19, 'emailReplyUserID', 'E-MAIL�ظ��û�', 'E-MAIL�ظ��û�', 'sipingsoft.hrms@sipingsoft.com', 'ess0000', null, 'VARCHAR2', null, null, to_date('26-10-2012 13:26:48', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (20, 'emailReplyPassword', 'E-MAIL�ظ�����', 'E-MAIL�ظ�����', 'sipingsoft147258', 'ess0000', null, 'VARCHAR2', null, null, to_date('26-10-2012 13:26:48', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (21, 'autoConfirm', '�Զ�����ȷ��', '�Զ�����ȷ��', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (22, 'containsOwner', 'ȡ�����ʱ�Ƿ�����Լ�', 'ȡ�����ʱ�Ƿ�����Լ�', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (23, 'autoSendMail', '�Զ�����һ������߷��ʼ�', '�Զ�����һ������߷��ʼ�', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (24, 'preConfirm', '�����Ƿ������ǰ����ȷ��', '�����Ƿ������ǰ����ȷ��', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (25, 'reConfirm', '�����Ƿ������ȷ�Ϻ�����ȷ��', '�����Ƿ������ȷ�Ϻ�����ȷ��', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (26, 'delAfterConfirm', '����ȷ�Ϻ��Ƿ����ɾ��', '����ȷ�Ϻ��Ƿ����ɾ��', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (27, 'modifiedAfterAffirm', '����Ƿ�ɷ���', '����Ƿ�ɷ���', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (28, 'checkOtApplyStartEndTime', '�Ӱ������Ƿ�ִ��ʼĩʱ���Ⱥ���', '�Ӱ������Ƿ�ִ��ʼĩʱ���Ⱥ���', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (29, 'checkOtApplyOtConflict', '�Ӱ������Ƿ�ִ�мӰ�ʱ����Ӱ�ʱ���ͻ���', '�Ӱ������Ƿ�ִ�мӰ�ʱ����Ӱ�ʱ���ͻ���', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (30, 'checkOtApplyShiftConflict', '�Ӱ������Ƿ�ִ�мӰ�ʱ������ʱ���ͻ���', '�Ӱ������Ƿ�ִ�мӰ�ʱ������ʱ���ͻ���', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (31, 'checkOtApplyLeaveConflict', '�Ӱ������Ƿ�ִ�мӰ�ʱ�����ݼ�ʱ���ͻ���', '�Ӱ������Ƿ�ִ�мӰ�ʱ�����ݼ�ʱ���ͻ���', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (32, 'checkOtApplyEvectionConflict', '�Ӱ������Ƿ�ִ�мӰ�ʱ�������ʱ���ͻ���', '�Ӱ������Ƿ�ִ�мӰ�ʱ�������ʱ���ͻ���', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (33, 'checkOtApplyMatchConflict', '�Ӱ������Ƿ�ִ�мӰ�ʱ����ֵ��ʱ���ͻ���', '�Ӱ������Ƿ�ִ�мӰ�ʱ����ֵ��ʱ���ͻ���', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (34, 'otApplyDaysBefore', '�Ӱ������*��ǰ�ļӰ�', '�Ӱ������*��ǰ�ļӰ�', '7', 'ess0000', '0:����(����������ʱ��Ӱ�),-X', 'NUMBER', null, null, to_date('01-11-2012 09:49:12', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (35, 'otApplyDaysAfter', '�Ӱ������*���ļӰ�', '�Ӱ������*���ļӰ�', '7', 'ess0000', '0:����(����������ʱ��Ӱ�),+X', 'NUMBER', null, null, to_date('01-11-2012 09:49:12', 'dd-mm-yyyy hh24:mi:ss'), '20721174', null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (36, 'otApplyTypeCheckFlag', '�Ӱ������жϱ�־', '�Ӱ������жϱ�־', '0', 'ess0000', '-1:���ж�(ȡ�ֹ��ύֵ);  0:�Զ��ж����ֹ��ύ���ݱȶ�;  1:ȡ�Զ��ж�ֵ;', 'NUMBER', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (37, 'otApplyMaxHours', '�Ӱ����ۼ�Сʱ������', '�Ӱ����ۼ�Сʱ������', '36', 'ess0000', '-1:���ж�(����������)', 'NUMBER', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (38, 'affairLeaveMaxHours', 'ȫ���¼��ۼ�Сʱ������', '���¼��ۼ�Сʱ������', '240', 'ess0000', '-1:���ж�(����������)', 'NUMBER', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (39, 'sickLeaveMaxHours', 'ȫ�겡���ۼ�Сʱ������', '�겡���ۼ�Сʱ������', '240', 'ess0000', '-1:���ж�(����������)', 'NUMBER', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (40, 'checkLeaveApplyStartEndTime', '�ݼ�ʼĩʱ��ǰ����', '�ݼ�ʼĩʱ��ǰ����', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (41, 'checkLeaveApplyOtConflict', '�Ƿ�ִ���ݼ���Ӱ��ͻ���', '�Ƿ�ִ���ݼ���Ӱ��ͻ���', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (42, 'checkLeaveApplyLeaveConflict', '�Ƿ�ִ���ݼ����ݼٳ�ͻ���', '�Ƿ�ִ���ݼ����ݼٳ�ͻ���', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (43, 'checkLeaveApplyMatchConflict', '�Ƿ�ִ���ݼ���ֵ���ͻ���', '�Ƿ�ִ���ݼ���ֵ���ͻ���', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (44, 'checkMatchApplyStartEndTime', 'ֵ��ʼĩʱ��ǰ����', 'ֵ��ʼĩʱ��ǰ����', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (45, 'checkMatchApplyOtConflict', '�Ƿ�ִ��ֵ����Ӱ��ͻ���', '�Ƿ�ִ��ֵ����Ӱ��ͻ���', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (46, 'checkMatchApplyLeaveConflict', '�Ƿ�ִ��ֵ�����ݼٳ�ͻ���', '�Ƿ�ִ��ֵ�����ݼٳ�ͻ���', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (47, 'checkMatchApplyMatchConflict', '�Ƿ�ִ��ֵ����ֵ���ͻ���', '�Ƿ�ִ��ֵ����ֵ���ͻ���', 'true', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (48, 'otApplySentMailFlag', '�Ӱ�������Ƿ����ʼ�֪ͨ�����', '�Ӱ�������Ƿ����ʼ�֪ͨ�����', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (49, 'leaveApplySentMailFlag', '�ݼ�������Ƿ����ʼ�֪ͨ�����', '�ݼ�������Ƿ����ʼ�֪ͨ�����', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
insert into SY_PARAMETER (parameter_no, parameter_id, desc_zh, desc_en, content, menu_code, remarks, data_type_code, create_date, created_by, update_date, updated_by, orderno, activity, cpny_id)
values (50, 'btApplySentMailFlag', '����������Ƿ����ʼ�֪ͨ�����', '����������Ƿ����ʼ�֪ͨ�����', 'false', 'ess0000', null, 'BOOLEAN', null, null, null, null, null, 1, 'wooribank');
commit;
prompt 67 records loaded
prompt Enabling triggers for SY_PARAMETER...
alter table SY_PARAMETER enable all triggers;
set feedback on
set define on
prompt Done.
exit;