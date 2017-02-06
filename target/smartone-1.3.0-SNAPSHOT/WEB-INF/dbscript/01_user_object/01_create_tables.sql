------------------------------------------------------
-- Export file for user TEST                        --
-- Created by Administrator on 2014-02-10, 12:14:52 --
------------------------------------------------------

set define off
spool tables.log

prompt
prompt Creating table ACTION_INFO
prompt ==========================
prompt
create table ACTION_INFO
(
  action_no         NUMBER not null,
  empid             VARCHAR2(20),
  action_way_code   VARCHAR2(20),
  action_time       DATE,
  action_content    VARCHAR2(200),
  remark            VARCHAR2(200),
  action_state_code VARCHAR2(20),
  created_by        VARCHAR2(20),
  created_date      DATE,
  updated_by        VARCHAR2(20),
  updated_date      DATE,
  activity          NUMBER(1),
  order_no          NUMBER,
  cpny_id           VARCHAR2(20),
  reminder          NUMBER(1),
  action_type_code  VARCHAR2(20)
)
;
comment on table ACTION_INFO
  is '���Ϣ��';
comment on column ACTION_INFO.action_no
  is 'NO';
comment on column ACTION_INFO.empid
  is 'Ա������';
comment on column ACTION_INFO.action_way_code
  is '��ʽ';
comment on column ACTION_INFO.action_time
  is 'ʱ��';
comment on column ACTION_INFO.action_content
  is '����';
comment on column ACTION_INFO.remark
  is '��ע';
comment on column ACTION_INFO.action_state_code
  is '�״̬';
comment on column ACTION_INFO.created_by
  is '������';
comment on column ACTION_INFO.created_date
  is '��������';
comment on column ACTION_INFO.updated_by
  is '������';
comment on column ACTION_INFO.updated_date
  is '��������';
comment on column ACTION_INFO.activity
  is '�Ƿ񼤻�';
comment on column ACTION_INFO.order_no
  is '����';
comment on column ACTION_INFO.cpny_id
  is '��˾id';
comment on column ACTION_INFO.reminder
  is '����Ƿ�����';
comment on column ACTION_INFO.action_type_code
  is '����ͣ�������';
alter table ACTION_INFO
  add constraint PK_ACTION_INFO primary key (ACTION_NO);

prompt
prompt Creating table AR_ANNUAL_HOLIDAY
prompt ================================
prompt
create table AR_ANNUAL_HOLIDAY
(
  holiday_no      NUMBER(10) not null,
  empid           VARCHAR2(20),
  holiday_date    VARCHAR2(4),
  curr_y_holiday  NUMBER(3,1) default 0,
  spec_holiday    NUMBER(3,1) default 0,
  used_holiday    NUMBER(3,1) default 0,
  used_sp_holiday NUMBER(3,1) default 0,
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  order_no        NUMBER(10),
  activity        NUMBER(1)
)
;
comment on column AR_ANNUAL_HOLIDAY.holiday_date
  is '������';
comment on column AR_ANNUAL_HOLIDAY.curr_y_holiday
  is '�����������';
comment on column AR_ANNUAL_HOLIDAY.spec_holiday
  is 'ʣ�����';
comment on column AR_ANNUAL_HOLIDAY.used_holiday
  is '��ʹ�����';
create index EMP_HOLIDAY_IDX on AR_ANNUAL_HOLIDAY (EMPID, HOLIDAY_DATE);
alter table AR_ANNUAL_HOLIDAY
  add constraint PK_AR_ANNUAL_HOLIDAY primary key (HOLIDAY_NO);

prompt
prompt Creating table AR_APPLY_RESULT
prompt ==============================
prompt
create table AR_APPLY_RESULT
(
  apply_no       NUMBER not null,
  empid          VARCHAR2(20) not null,
  apply_type     VARCHAR2(30) not null,
  apply_date     VARCHAR2(20),
  from_time      DATE not null,
  to_time        DATE not null,
  apply_deduct   NUMBER(8,2),
  app_type       VARCHAR2(20),
  apply_deduct_2 NUMBER(8,2)
)
;
create unique index AR_RESULT_INDEX on AR_APPLY_RESULT (EMPID, APPLY_TYPE, APPLY_DATE, APPLY_NO);
alter table AR_APPLY_RESULT
  add primary key (APPLY_NO, EMPID, APPLY_TYPE);

prompt
prompt Creating table AR_CALENDER
prompt ==========================
prompt
create table AR_CALENDER
(
  ddate          DATE not null,
  iyear          NUMBER(10),
  imonth         NUMBER(10),
  iday           NUMBER(10),
  iweek          NUMBER(10),
  workdayflag    NUMBER(10) not null,
  typeid         NUMBER(10),
  overtypeid     NUMBER(10),
  typeid_default NUMBER(10),
  shift_no       NUMBER,
  ddate_str      VARCHAR2(20)
)
;
comment on column AR_CALENDER.workdayflag
  is '�Ƿ�����־';
comment on column AR_CALENDER.typeid
  is '��������';
comment on column AR_CALENDER.ddate_str
  is 'YYYY/MM/DD';
alter table AR_CALENDER
  add constraint AR_CALENDER_PK primary key (DDATE);

prompt
prompt Creating table AR_CALENDER_GROUP
prompt ================================
prompt
create table AR_CALENDER_GROUP
(
  ddate          DATE not null,
  iyear          NUMBER(10),
  imonth         NUMBER(10),
  iday           NUMBER(10),
  iweek          NUMBER(10),
  workdayflag    NUMBER(10) not null,
  typeid         NUMBER(10),
  overtypeid     NUMBER(10),
  typeid_default NUMBER(10),
  group_id       VARCHAR2(20) not null,
  shift_no       NUMBER
)
;
alter table AR_CALENDER_GROUP
  add constraint PK_AR_CALENDER_GROUP primary key (GROUP_ID, DDATE);

prompt
prompt Creating table AR_CALENDER_TYPE
prompt ===============================
prompt
create table AR_CALENDER_TYPE
(
  type_id      NUMBER(10) not null,
  type_name    VARCHAR2(80),
  type_en_name VARCHAR2(80),
  descr        VARCHAR2(500),
  create_date  DATE,
  created_by   VARCHAR2(20),
  update_date  DATE,
  updated_by   VARCHAR2(20),
  activity     NUMBER,
  cpny_id      VARCHAR2(20)
)
;

prompt
prompt Creating table AR_CONDITION_LIST
prompt ================================
prompt
create table AR_CONDITION_LIST
(
  condition_no  NUMBER,
  field_id      VARCHAR2(50),
  field_name    VARCHAR2(50),
  table_name    VARCHAR2(100),
  field_en_name VARCHAR2(50),
  field_en_id   VARCHAR2(50)
)
;

prompt
prompt Creating table HR_EMPLOYEE
prompt ==========================
prompt
create table HR_EMPLOYEE
(
  empid                 VARCHAR2(20) not null,
  deptid                VARCHAR2(20) not null,
  chinesename           VARCHAR2(40),
  chinese_pinyin        VARCHAR2(40),
  englishname           VARCHAR2(20),
  position_id           VARCHAR2(20),
  duty_code             VARCHAR2(20),
  post_id               VARCHAR2(20),
  post_grade_id         VARCHAR2(20),
  post_coef             VARCHAR2(20),
  post_column_code      VARCHAR2(20),
  post_grade_level_code VARCHAR2(20),
  post_group_id         VARCHAR2(20),
  status_code           VARCHAR2(20),
  join_date             DATE,
  left_date             DATE,
  hire_date             DATE,
  end_probation_date    DATE,
  join_type_code        VARCHAR2(20),
  emp_type_code         VARCHAR2(20),
  costcenter            VARCHAR2(20),
  create_date           DATE,
  created_by            VARCHAR2(20),
  update_date           DATE,
  updated_by            VARCHAR2(20),
  activity              NUMBER(1),
  orderno               NUMBER(10),
  cpny_id               VARCHAR2(20),
  positionaltitle       VARCHAR2(20),
  post_level_id         VARCHAR2(20)
)
;
comment on table HR_EMPLOYEE
  is 'Ա��������Ϣ��';
comment on column HR_EMPLOYEE.empid
  is '#*����';
comment on column HR_EMPLOYEE.deptid
  is '#*����';
comment on column HR_EMPLOYEE.chinesename
  is '#*��������';
comment on column HR_EMPLOYEE.chinese_pinyin
  is '����ƴ��';
comment on column HR_EMPLOYEE.englishname
  is 'Ӣ������';
comment on column HR_EMPLOYEE.position_id
  is 'ְ��';
comment on column HR_EMPLOYEE.duty_code
  is 'ְ��';
comment on column HR_EMPLOYEE.post_id
  is '#*ְλ';
comment on column HR_EMPLOYEE.post_grade_id
  is 'ְ��';
comment on column HR_EMPLOYEE.post_coef
  is '����';
comment on column HR_EMPLOYEE.post_group_id
  is 'ְȺ';
comment on column HR_EMPLOYEE.status_code
  is '#*Ա��״̬';
comment on column HR_EMPLOYEE.join_date
  is '#*¼������';
comment on column HR_EMPLOYEE.hire_date
  is '��ְ����';
comment on column HR_EMPLOYEE.end_probation_date
  is '#ת������';
comment on column HR_EMPLOYEE.emp_type_code
  is '#*Ա������';
comment on column HR_EMPLOYEE.cpny_id
  is '��˾���';
comment on column HR_EMPLOYEE.positionaltitle
  is 'ְ��';
alter table HR_EMPLOYEE
  add constraint PK_HR_EMPLOYEE primary key (EMPID);

prompt
prompt Creating table AR_DETAIL
prompt ========================
prompt
create table AR_DETAIL
(
  pk_no        NUMBER(10) not null,
  empid        VARCHAR2(20) not null,
  ar_item_no   NUMBER(10) not null,
  from_time    DATE,
  to_time      DATE,
  shift_no     NUMBER(10),
  ar_date_str  VARCHAR2(10) not null,
  ar_month_str VARCHAR2(6),
  quantity     NUMBER(8,2),
  lock_yn      VARCHAR2(1),
  date_type    NUMBER,
  unit         VARCHAR2(20),
  app_type     VARCHAR2(20),
  app_no       VARCHAR2(20)
)
;
alter table AR_DETAIL
  add constraint PK_AR_DETAIL primary key (AR_DATE_STR, EMPID, AR_ITEM_NO);
alter table AR_DETAIL
  add constraint FK_AR_DETAIL_EMP foreign key (EMPID)
  references HR_EMPLOYEE (EMPID)
  disable;

prompt
prompt Creating table AR_DETAIL_FL
prompt ===========================
prompt
create table AR_DETAIL_FL
(
  pk_no        NUMBER(10) not null,
  empid        VARCHAR2(20) not null,
  ar_item_no   NUMBER(10) not null,
  from_time    DATE,
  to_time      DATE,
  shift_no     NUMBER(10),
  ar_date_str  VARCHAR2(10) not null,
  ar_month_str VARCHAR2(6),
  quantity     NUMBER(6,2),
  lock_yn      VARCHAR2(1),
  date_type    NUMBER,
  unit         VARCHAR2(20)
)
;

prompt
prompt Creating table AR_DETAIL_LOCK
prompt =============================
prompt
create table AR_DETAIL_LOCK
(
  lock_no      NUMBER not null,
  ar_date_str  VARCHAR2(10) not null,
  ar_month_str VARCHAR2(10) not null,
  status       VARCHAR2(20) not null,
  create_date  DATE default SYSDATE,
  created_by   VARCHAR2(20),
  update_date  DATE default SYSDATE,
  updated_by   VARCHAR2(20),
  activity     NUMBER(1)
)
;
comment on column AR_DETAIL_LOCK.ar_date_str
  is '�������ڣ���ʽ��YYYY-MM-DD';
comment on column AR_DETAIL_LOCK.ar_month_str
  is '������';
comment on column AR_DETAIL_LOCK.status
  is '״̬��LockStatus010/������LockStatus020/δ����';
alter table AR_DETAIL_LOCK
  add primary key (AR_DATE_STR);

prompt
prompt Creating table AR_DETAIL_STAT
prompt =============================
prompt
create table AR_DETAIL_STAT
(
  empid       VARCHAR2(20),
  ar_date_str VARCHAR2(10),
  stat        NUMBER
)
;

prompt
prompt Creating table AR_DETAIL_SUMMARY
prompt ================================
prompt
create table AR_DETAIL_SUMMARY
(
  ar_date                   CHAR(10) not null,
  empid                     VARCHAR2(10) not null,
  shift_name                VARCHAR2(50),
  abroad_biz_trip_d         NUMBER,
  abroad_edu_d              NUMBER,
  absenteeism_d             NUMBER,
  annual_vacation_d         NUMBER,
  bereft_leave_d            NUMBER,
  casual_leave_d            NUMBER,
  domestic_biz_trip_d       NUMBER,
  holiday_ot_d              NUMBER,
  industry_injury_d         NUMBER,
  intra_edu_d               NUMBER,
  marriage_leave_d          NUMBER,
  maternity_leave_d         NUMBER,
  outer_edu_d               NUMBER,
  prenatal_diagnosis_d      NUMBER,
  rest_d                    NUMBER,
  reward_leave_d            NUMBER,
  sick_leave_d              NUMBER,
  special_leave_d           NUMBER,
  special_maternity_leave_d NUMBER,
  tardiness_d               NUMBER,
  weekday_ot_d              NUMBER,
  weekend_ot_d              NUMBER,
  without_pay_leave_d       NUMBER,
  work_d                    NUMBER,
  cpy_intra_edu_d           NUMBER,
  cpy_outer_edu_d           NUMBER,
  extra_leave_d             NUMBER,
  marriage_kindred_lea_d    NUMBER,
  minglingxiujia_d          NUMBER,
  annual_vacation_fl_d      NUMBER,
  cstardiness_d             NUMBER,
  earlyday_d                NUMBER,
  shift                     VARCHAR2(50),
  typeid                    NUMBER,
  date_type                 NUMBER
)
;
alter table AR_DETAIL_SUMMARY
  add primary key (AR_DATE, EMPID);

prompt
prompt Creating table AR_DETAIL_T
prompt ==========================
prompt
create table AR_DETAIL_T
(
  empid        VARCHAR2(20),
  ar_item_no   NUMBER(10),
  from_time    DATE,
  to_time      DATE,
  shift_no     NUMBER(10),
  ar_date_str  VARCHAR2(10),
  ar_month_str VARCHAR2(6),
  quantity     NUMBER(6,2),
  lock_yn      VARCHAR2(1),
  date_type    NUMBER,
  unit         VARCHAR2(20)
)
;

prompt
prompt Creating table AR_DETAIL_TEMP
prompt =============================
prompt
create global temporary table AR_DETAIL_TEMP
(
  empid        VARCHAR2(20),
  ar_item_no   NUMBER(10),
  from_time    DATE,
  to_time      DATE,
  shift_no     NUMBER(10),
  ar_date_str  VARCHAR2(10),
  ar_month_str VARCHAR2(6),
  quantity     NUMBER(8,2),
  lock_yn      VARCHAR2(1),
  date_type    INTEGER,
  unit         VARCHAR2(20),
  item_type    NUMBER(10),
  no           NUMBER not null
)
on commit delete rows;
comment on column AR_DETAIL_TEMP.item_type
  is '������Ŀ��λ';

prompt
prompt Creating table AR_DYNAMIC_GROUP
prompt ===============================
prompt
create table AR_DYNAMIC_GROUP
(
  group_no      NUMBER not null,
  group_name    VARCHAR2(50) not null,
  group_en_name VARCHAR2(50),
  group_type    VARCHAR2(20),
  description   VARCHAR2(200),
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  activity      NUMBER not null,
  cpny_id       VARCHAR2(20) not null,
  deptid        VARCHAR2(20)
)
;
comment on table AR_DYNAMIC_GROUP
  is 'Ϊ�鶨�����������';
comment on column AR_DYNAMIC_GROUP.group_type
  is 'ϵͳ�������';
alter table AR_DYNAMIC_GROUP
  add constraint PK_AR_DYNAMIC_GROUP primary key (GROUP_NO);
alter table AR_DYNAMIC_GROUP
  add constraint UK_AR_DYNAMIC_GROUP unique (GROUP_NAME, CPNY_ID);

prompt
prompt Creating table AR_DYNAMIC_GROUP_EMP
prompt ===================================
prompt
create table AR_DYNAMIC_GROUP_EMP
(
  empid    VARCHAR2(20) not null,
  group_no NUMBER not null
)
;

prompt
prompt Creating table AR_EATERY_RECORDS
prompt ================================
prompt
create table AR_EATERY_RECORDS
(
  record_no           NUMBER(10) not null,
  card_no             VARCHAR2(50),
  r_time              DATE,
  repast_type         VARCHAR2(50),
  eatery_data_type    VARCHAR2(50),
  active              VARCHAR2(1),
  insert_by           VARCHAR2(1),
  empid               VARCHAR2(20),
  operator_id         VARCHAR2(10),
  insert_time         DATE,
  remark              VARCHAR2(100),
  interface_record_id NUMBER
)
;
comment on table AR_EATERY_RECORDS
  is 'ʳ�����Ѽ�¼��';
comment on column AR_EATERY_RECORDS.card_no
  is 'ID Card ӡˢ����';
comment on column AR_EATERY_RECORDS.r_time
  is 'ˢ��ʱ��';
comment on column AR_EATERY_RECORDS.repast_type
  is '�Ͳ�����';
comment on column AR_EATERY_RECORDS.eatery_data_type
  is 'ʳ����������';
comment on column AR_EATERY_RECORDS.insert_by
  is '''H''= INSERTED BY HUMAN BEING  ''M'' = inserted by Machine';
comment on column AR_EATERY_RECORDS.empid
  is '���ֶβ�ʹ�ã�ͨ�����Ź���������';
comment on column AR_EATERY_RECORDS.operator_id
  is '����ԱID';
comment on column AR_EATERY_RECORDS.insert_time
  is '�ֹ��������ݵ�ʱ��';
alter table AR_EATERY_RECORDS
  add primary key (RECORD_NO);

prompt
prompt Creating table AR_EMP_CARD
prompt ==========================
prompt
create table AR_EMP_CARD
(
  card_no     VARCHAR2(50) not null,
  empid       VARCHAR2(20),
  from_date   DATE not null,
  to_date     DATE,
  card_id     VARCHAR2(20),
  activity    NUMBER(1),
  create_date DATE,
  created_by  VARCHAR2(20),
  update_date DATE,
  updated_by  VARCHAR2(20)
)
;
comment on table AR_EMP_CARD
  is 'Ա����ϵ��';
comment on column AR_EMP_CARD.from_date
  is '��ʼ����';
comment on column AR_EMP_CARD.to_date
  is '��������';
comment on column AR_EMP_CARD.card_id
  is 'ID Card ӡˢ����';

prompt
prompt Creating table AR_EMP_CARD_TEMP
prompt ===============================
prompt
create table AR_EMP_CARD_TEMP
(
  card_no     VARCHAR2(50) not null,
  empid       VARCHAR2(20) not null,
  from_date   DATE,
  to_date     DATE,
  no          NUMBER(10) not null,
  active      NUMBER(1),
  create_date DATE,
  created_by  VARCHAR2(20),
  update_date DATE,
  updated_by  VARCHAR2(20),
  serial      VARCHAR2(20)
)
;
comment on column AR_EMP_CARD_TEMP.card_no
  is 'ID Card ӡˢ����';
comment on column AR_EMP_CARD_TEMP.empid
  is 'Ա��ID';
comment on column AR_EMP_CARD_TEMP.from_date
  is '��ʼ����';
comment on column AR_EMP_CARD_TEMP.to_date
  is '��������';

prompt
prompt Creating table AR_GROUP
prompt =======================
prompt
create table AR_GROUP
(
  group_id    VARCHAR2(20) not null,
  group_name  VARCHAR2(40),
  description VARCHAR2(50),
  priority    NUMBER
)
;
alter table AR_GROUP
  add primary key (GROUP_ID);

prompt
prompt Creating table AR_GROUP_CONDITIONS
prompt ==================================
prompt
create table AR_GROUP_CONDITIONS
(
  group_condition_no NUMBER,
  group_no           NUMBER not null,
  field_name         VARCHAR2(40) not null,
  relation           VARCHAR2(40),
  value1             VARCHAR2(4000),
  value2             VARCHAR2(4000)
)
;
comment on table AR_GROUP_CONDITIONS
  is 'Ϊÿ�����趨������';
alter table AR_GROUP_CONDITIONS
  add primary key (GROUP_NO, FIELD_NAME);

prompt
prompt Creating table AR_GROUP_CONTROL
prompt ===============================
prompt
create table AR_GROUP_CONTROL
(
  pk_no        NUMBER(10) not null,
  group_no     NUMBER(10),
  ar_month     VARCHAR2(6),
  ar_day_str   VARCHAR2(10),
  ar_item_no   NUMBER(10),
  from_time    DATE,
  to_time      DATE,
  control_type VARCHAR2(20),
  edit_by      NUMBER(10),
  edit_date    DATE
)
;

prompt
prompt Creating table AR_GROUP_DETAIL
prompt ==============================
prompt
create table AR_GROUP_DETAIL
(
  group_no  NUMBER(10),
  empid     VARCHAR2(15),
  from_date DATE,
  to_date   DATE
)
;

prompt
prompt Creating table AR_HISTORY
prompt =========================
prompt
create table AR_HISTORY
(
  ar_month        CHAR(6),
  deptname        VARCHAR2(100),
  deptid          VARCHAR2(20),
  chinesename     VARCHAR2(40),
  empid           VARCHAR2(20),
  emp_type_name   VARCHAR2(50),
  status_code     VARCHAR2(20),
  position_id     VARCHAR2(20),
  status_name     VARCHAR2(50),
  post_id         VARCHAR2(20),
  post_name       VARCHAR2(50),
  post_grade_id   VARCHAR2(20),
  card_no         VARCHAR2(200),
  post_group_id   VARCHAR2(20),
  join_date       DATE,
  emp_type_code   VARCHAR2(20),
  att_m_112       NUMBER,
  att_m_58        NUMBER,
  position_name   VARCHAR2(50),
  att_m_114       NUMBER,
  post_grade_name VARCHAR2(50),
  att_m_8         NUMBER,
  post_group_name VARCHAR2(50),
  att_m_9         NUMBER,
  att_m_7         NUMBER,
  att_m_6         NUMBER,
  att_m_110       NUMBER,
  att_m_119       NUMBER,
  att_m_113       NUMBER,
  att_m_52        NUMBER,
  att_m_115       NUMBER,
  att_m_53        NUMBER,
  att_m_2         NUMBER,
  att_m_118       NUMBER,
  att_m_12        NUMBER,
  att_m_15        NUMBER,
  att_m_39        NUMBER,
  att_m_117       NUMBER,
  att_m_20        NUMBER,
  att_m_111       NUMBER,
  att_m_65        NUMBER,
  att_m_41        NUMBER,
  att_m_21        NUMBER,
  att_m_62        NUMBER,
  att_m_63        NUMBER,
  att_m_45        NUMBER,
  att_m_29        NUMBER,
  att_m_30        NUMBER,
  att_m_56        NUMBER,
  att_m_73        NUMBER
)
;

prompt
prompt Creating table AR_HISTORY_201309
prompt ================================
prompt
create table AR_HISTORY_201309
(
  ar_month        CHAR(6),
  deptid          VARCHAR2(20),
  deptname        VARCHAR2(100),
  chinesename     VARCHAR2(40),
  empid           VARCHAR2(20),
  emp_type_name   VARCHAR2(50),
  position_id     VARCHAR2(20),
  post_id         VARCHAR2(20),
  post_grade_id   VARCHAR2(20),
  status_code     VARCHAR2(20),
  post_group_id   VARCHAR2(20),
  status_name     VARCHAR2(50),
  post_name       VARCHAR2(50),
  position_name   VARCHAR2(50),
  post_grade_name VARCHAR2(50),
  post_group_name VARCHAR2(50),
  card_no         VARCHAR2(200),
  att_m_112       NUMBER,
  att_m_58        NUMBER,
  att_m_114       NUMBER,
  att_m_8         NUMBER,
  att_m_9         NUMBER,
  att_m_7         NUMBER,
  att_m_6         NUMBER,
  att_m_110       NUMBER,
  att_m_111       NUMBER,
  att_m_119       NUMBER,
  att_m_113       NUMBER,
  att_m_52        NUMBER,
  att_m_115       NUMBER,
  att_m_53        NUMBER,
  att_m_2         NUMBER,
  att_m_118       NUMBER,
  att_m_12        NUMBER,
  att_m_15        NUMBER,
  att_m_39        NUMBER,
  att_m_117       NUMBER,
  att_m_20        NUMBER,
  att_m_65        NUMBER,
  att_m_41        NUMBER,
  att_m_21        NUMBER,
  att_m_62        NUMBER,
  att_m_63        NUMBER,
  att_m_45        NUMBER,
  att_m_29        NUMBER,
  att_m_30        NUMBER,
  att_m_56        NUMBER,
  att_m_73        NUMBER
)
;

prompt
prompt Creating table AR_HISTORY_201310
prompt ================================
prompt
create table AR_HISTORY_201310
(
  ar_month        CHAR(6),
  deptid          VARCHAR2(20),
  deptname        VARCHAR2(100),
  chinesename     VARCHAR2(40),
  empid           VARCHAR2(20),
  emp_type_name   VARCHAR2(50),
  position_id     VARCHAR2(20),
  post_id         VARCHAR2(20),
  post_grade_id   VARCHAR2(20),
  status_code     VARCHAR2(20),
  post_group_id   VARCHAR2(20),
  status_name     VARCHAR2(50),
  post_name       VARCHAR2(50),
  position_name   VARCHAR2(50),
  post_grade_name VARCHAR2(50),
  post_group_name VARCHAR2(50),
  card_no         VARCHAR2(200),
  att_m_112       NUMBER,
  att_m_58        NUMBER,
  att_m_114       NUMBER,
  att_m_8         NUMBER,
  att_m_9         NUMBER,
  att_m_7         NUMBER,
  att_m_6         NUMBER,
  att_m_110       NUMBER,
  att_m_119       NUMBER,
  att_m_113       NUMBER,
  att_m_52        NUMBER,
  att_m_115       NUMBER,
  att_m_111       NUMBER,
  att_m_53        NUMBER,
  att_m_2         NUMBER,
  att_m_118       NUMBER,
  att_m_12        NUMBER,
  att_m_15        NUMBER,
  att_m_39        NUMBER,
  att_m_117       NUMBER,
  att_m_20        NUMBER,
  att_m_65        NUMBER,
  att_m_41        NUMBER,
  att_m_21        NUMBER,
  att_m_62        NUMBER,
  att_m_63        NUMBER,
  att_m_45        NUMBER,
  att_m_29        NUMBER,
  att_m_30        NUMBER,
  att_m_56        NUMBER,
  att_m_73        NUMBER
)
;

prompt
prompt Creating table AR_HISTORY_201311
prompt ================================
prompt
create table AR_HISTORY_201311
(
  ar_month        CHAR(6),
  deptid          VARCHAR2(20),
  deptname        VARCHAR2(100),
  chinesename     VARCHAR2(40),
  empid           VARCHAR2(20),
  emp_type_name   VARCHAR2(50),
  position_id     VARCHAR2(20),
  post_id         VARCHAR2(20),
  post_grade_id   VARCHAR2(20),
  status_code     VARCHAR2(20),
  post_group_id   VARCHAR2(20),
  status_name     VARCHAR2(50),
  post_name       VARCHAR2(50),
  position_name   VARCHAR2(50),
  post_grade_name VARCHAR2(50),
  post_group_name VARCHAR2(50),
  card_no         VARCHAR2(200),
  att_m_112       NUMBER,
  att_m_58        NUMBER,
  att_m_114       NUMBER,
  att_m_8         NUMBER,
  att_m_9         NUMBER,
  att_m_7         NUMBER,
  att_m_6         NUMBER,
  att_m_110       NUMBER,
  att_m_119       NUMBER,
  att_m_113       NUMBER,
  att_m_52        NUMBER,
  att_m_115       NUMBER,
  att_m_53        NUMBER,
  att_m_111       NUMBER,
  att_m_2         NUMBER,
  att_m_118       NUMBER,
  att_m_12        NUMBER,
  att_m_15        NUMBER,
  att_m_39        NUMBER,
  att_m_117       NUMBER,
  att_m_20        NUMBER,
  att_m_65        NUMBER,
  att_m_41        NUMBER,
  att_m_21        NUMBER,
  att_m_62        NUMBER,
  att_m_63        NUMBER,
  att_m_45        NUMBER,
  att_m_29        NUMBER,
  att_m_30        NUMBER,
  att_m_56        NUMBER,
  att_m_73        NUMBER
)
;

prompt
prompt Creating table AR_HISTORY_201401
prompt ================================
prompt
create table AR_HISTORY_201401
(
  ar_month        CHAR(6),
  deptname        VARCHAR2(100),
  deptid          VARCHAR2(20),
  chinesename     VARCHAR2(40),
  empid           VARCHAR2(20),
  emp_type_name   VARCHAR2(50),
  status_code     VARCHAR2(20),
  position_id     VARCHAR2(20),
  status_name     VARCHAR2(50),
  post_id         VARCHAR2(20),
  post_name       VARCHAR2(50),
  post_grade_id   VARCHAR2(20),
  card_no         VARCHAR2(200),
  post_group_id   VARCHAR2(20),
  join_date       DATE,
  emp_type_code   VARCHAR2(20),
  att_m_112       NUMBER,
  att_m_58        NUMBER,
  position_name   VARCHAR2(50),
  att_m_114       NUMBER,
  post_grade_name VARCHAR2(50),
  att_m_8         NUMBER,
  post_group_name VARCHAR2(50),
  att_m_9         NUMBER,
  att_m_7         NUMBER,
  att_m_6         NUMBER,
  att_m_110       NUMBER,
  att_m_119       NUMBER,
  att_m_113       NUMBER,
  att_m_52        NUMBER,
  att_m_115       NUMBER,
  att_m_53        NUMBER,
  att_m_2         NUMBER,
  att_m_118       NUMBER,
  att_m_12        NUMBER,
  att_m_15        NUMBER,
  att_m_39        NUMBER,
  att_m_117       NUMBER,
  att_m_20        NUMBER,
  att_m_111       NUMBER,
  att_m_65        NUMBER,
  att_m_41        NUMBER,
  att_m_21        NUMBER,
  att_m_62        NUMBER,
  att_m_63        NUMBER,
  att_m_45        NUMBER,
  att_m_29        NUMBER,
  att_m_30        NUMBER,
  att_m_56        NUMBER,
  att_m_73        NUMBER
)
;

prompt
prompt Creating table AR_ITEM
prompt ======================
prompt
create table AR_ITEM
(
  item_no         NUMBER(10) not null,
  item_id         VARCHAR2(25),
  item_name       VARCHAR2(50) not null,
  item_en_name    VARCHAR2(50),
  short_name      VARCHAR2(20),
  description     VARCHAR2(2000),
  item_group_code VARCHAR2(20),
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  activity        NUMBER,
  cpny_id         VARCHAR2(20)
)
;
comment on column AR_ITEM.item_id
  is '������ĿID';
alter table AR_ITEM
  add constraint PK_AR_ITEM primary key (ITEM_NO);
alter table AR_ITEM
  add constraint UK_AR_ITEM unique (ITEM_ID);

prompt
prompt Creating table AR_ITEM_PARAM
prompt ============================
prompt
create table AR_ITEM_PARAM
(
  ar_param_no         NUMBER not null,
  ar_item_no          NUMBER not null,
  ar_group_no         VARCHAR2(10) not null,
  unit                VARCHAR2(10),
  unit_value          NUMBER,
  min_value           NUMBER,
  max_value           NUMBER,
  depend_item         VARCHAR2(50),
  replace_item        VARCHAR2(50),
  card_flag           NUMBER,
  card_from_flag      NUMBER,
  card_from_offset    NUMBER,
  card_from_relation  VARCHAR2(10),
  card_to_flag        NUMBER,
  card_to_offset      NUMBER,
  card_to_relation    VARCHAR2(10),
  apply_flag          NUMBER,
  apply_type          VARCHAR2(50),
  apply_fullday_value NUMBER,
  apply_card_priority NUMBER,
  date_type           VARCHAR2(50),
  activity            NUMBER not null
)
;
alter table AR_ITEM_PARAM
  add constraint PK_AR_ITEM_PARAM primary key (AR_PARAM_NO);
alter table AR_ITEM_PARAM
  add constraint FK_AR_ITEM_PARAM foreign key (AR_ITEM_NO)
  references AR_ITEM (ITEM_NO) on delete cascade;

prompt
prompt Creating table AR_MAC_RECORD
prompt ============================
prompt
create table AR_MAC_RECORD
(
  record_no      NUMBER(10) not null,
  card_id        VARCHAR2(50),
  empid          VARCHAR2(20),
  r_time         DATE,
  att_date       DATE,
  card_door_type VARCHAR2(3),
  in_flag        VARCHAR2(1),
  in_id          VARCHAR2(20),
  remark         VARCHAR2(100),
  activity       NUMBER(1),
  create_date    DATE,
  created_by     VARCHAR2(10),
  update_date    DATE,
  updated_by     VARCHAR2(20)
)
;
comment on table AR_MAC_RECORD
  is '����ˢ����¼';
comment on column AR_MAC_RECORD.record_no
  is '����ˢ�����ݱ�';
comment on column AR_MAC_RECORD.card_id
  is 'ID Card ӡˢ����';
comment on column AR_MAC_RECORD.empid
  is '���ֶβ�ʹ�ã�ͨ�����Ź���������';
comment on column AR_MAC_RECORD.r_time
  is 'ˢ��ʱ��';
comment on column AR_MAC_RECORD.att_date
  is '��������';
comment on column AR_MAC_RECORD.card_door_type
  is '����������';
comment on column AR_MAC_RECORD.in_flag
  is '''H''= INSERTED BY HUMAN BEING  ''M'' = inserted by Machine';
comment on column AR_MAC_RECORD.in_id
  is '������';
alter table AR_MAC_RECORD
  add primary key (RECORD_NO);

prompt
prompt Creating table AR_OPTIONS
prompt =========================
prompt
create table AR_OPTIONS
(
  option_no    NUMBER,
  option_name  VARCHAR2(15),
  option_value VARCHAR2(2000)
)
;

prompt
prompt Creating table AR_RECORDS
prompt =========================
prompt
create table AR_RECORDS
(
  record_no   VARCHAR2(20) not null,
  empid       VARCHAR2(20),
  enter_time  DATE,
  out_time    DATE,
  lock_yn     VARCHAR2(2),
  ar_date_str DATE,
  create_date DATE,
  state       VARCHAR2(2),
  update_date DATE,
  update_by   VARCHAR2(20),
  activity    NUMBER(1),
  cpny_id     VARCHAR2(20),
  created_by  VARCHAR2(20)
)
;

prompt
prompt Creating table AR_SCHEDULE
prompt ==========================
prompt
create table AR_SCHEDULE
(
  pk_no        NUMBER(10) not null,
  empid        VARCHAR2(20) not null,
  ar_item_no   NUMBER(10),
  from_time    DATE,
  to_time      DATE,
  shift_no     NUMBER(10),
  ar_date_str  VARCHAR2(10) not null,
  ar_month_str VARCHAR2(6),
  lock_yn      VARCHAR2(1)
)
;
comment on column AR_SCHEDULE.ar_date_str
  is '�Ű�����';
alter table AR_SCHEDULE
  add constraint PK_AR_SCHEDULE primary key (AR_DATE_STR, EMPID);

prompt
prompt Creating table AR_SCHEDULE_GROUP
prompt ================================
prompt
create table AR_SCHEDULE_GROUP
(
  pk_no       NUMBER(10) not null,
  group_id    VARCHAR2(20),
  ar_item_no  NUMBER(10),
  from_time   DATE,
  to_time     DATE,
  shift_nos   VARCHAR2(200),
  shift_names VARCHAR2(200),
  lock_yn     VARCHAR2(1)
)
;

prompt
prompt Creating table AR_SCHEDULE_GROUP_ITEM
prompt =====================================
prompt
create table AR_SCHEDULE_GROUP_ITEM
(
  pk_no        NUMBER(10) not null,
  groupid      VARCHAR2(20),
  ar_item_no   NUMBER(10),
  from_time    DATE,
  to_time      DATE,
  shift_no     NUMBER(10),
  ar_date_str  VARCHAR2(10),
  ar_month_str VARCHAR2(6),
  lock_yn      VARCHAR2(1)
)
;

prompt
prompt Creating table AR_SCREEN_GRANT
prompt ==============================
prompt
create table AR_SCREEN_GRANT
(
  screen_code     VARCHAR2(250),
  screen_grant_no VARCHAR2(200),
  selectr         NUMBER,
  insertr         NUMBER,
  updater         NUMBER,
  deleter         NUMBER,
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  orderno         NUMBER(10),
  activity        NUMBER(1)
)
;

prompt
prompt Creating table AR_SHIFT010
prompt ==========================
prompt
create table AR_SHIFT010
(
  shift_no      NUMBER(10) not null,
  shift_id      VARCHAR2(20),
  shift_name    VARCHAR2(50),
  shift_en_name VARCHAR2(50),
  date_type_id  NUMBER,
  descr         VARCHAR2(200),
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  activity      NUMBER,
  cpny_id       VARCHAR2(20)
)
;
alter table AR_SHIFT010
  add constraint PK_AR_SHIFT010 primary key (SHIFT_NO);

prompt
prompt Creating table AR_SHIFT020
prompt ==========================
prompt
create table AR_SHIFT020
(
  pk_no            NUMBER(10) not null,
  shift_no         NUMBER(10),
  ar_item_no       NUMBER(10),
  begin_day_offset NUMBER(10),
  from_time        DATE,
  end_day_offset   NUMBER(10),
  to_time          DATE,
  create_date      DATE,
  created_by       VARCHAR2(20),
  update_date      DATE,
  updated_by       VARCHAR2(20)
)
;
alter table AR_SHIFT020
  add constraint PK_AR_SHIFT020 primary key (PK_NO);
alter table AR_SHIFT020
  add constraint UK_AR_SHIFT020 unique (SHIFT_NO, AR_ITEM_NO, BEGIN_DAY_OFFSET, FROM_TIME, END_DAY_OFFSET, TO_TIME);

prompt
prompt Creating table AR_SHIFT_EATERY
prompt ==============================
prompt
create table AR_SHIFT_EATERY
(
  shift_no    NUMBER(10) not null,
  repast_type VARCHAR2(50) not null,
  active      VARCHAR2(1) default 1
)
;
alter table AR_SHIFT_EATERY
  add primary key (SHIFT_NO, REPAST_TYPE);

prompt
prompt Creating table AR_SHIFT_GROUP
prompt =============================
prompt
create table AR_SHIFT_GROUP
(
  group_no      NUMBER,
  group_id      VARCHAR2(20),
  group_name    VARCHAR2(50),
  group_en_name VARCHAR2(50),
  shift_no      NUMBER(10),
  descr         VARCHAR2(200),
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  activity      NUMBER,
  cpny_id       VARCHAR2(20)
)
;

prompt
prompt Creating table AR_SHIFT_GROUP_EMP
prompt =================================
prompt
create table AR_SHIFT_GROUP_EMP
(
  group_no VARCHAR2(20),
  empid    VARCHAR2(20),
  s_date   DATE,
  e_date   DATE,
  no       NUMBER(10)
)
;

prompt
prompt Creating table AR_SPECIAL_EMP
prompt =============================
prompt
create table AR_SPECIAL_EMP
(
  special_no         NUMBER,
  special_group_name VARCHAR2(50),
  create_date        DATE,
  to_date            DATE,
  from_date          DATE,
  card_into          NUMBER,
  empidnotin         VARCHAR2(2500),
  description        VARCHAR2(1000)
)
;

prompt
prompt Creating table AR_SPECIAL_EMP_CONDITIONS
prompt ========================================
prompt
create table AR_SPECIAL_EMP_CONDITIONS
(
  special_condition_no NUMBER,
  special_no           NUMBER,
  field_name           VARCHAR2(40),
  relation             VARCHAR2(40),
  value1               VARCHAR2(50),
  value2               VARCHAR2(50)
)
;

prompt
prompt Creating table AR_STATISTIC_DATE
prompt ================================
prompt
create table AR_STATISTIC_DATE
(
  stat_no         NUMBER(10) not null,
  description     VARCHAR2(20) not null,
  valid_date_from DATE not null,
  valid_date_to   DATE not null,
  start_date      NUMBER,
  end_date        NUMBER,
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  activity        NUMBER,
  cpny_id         VARCHAR2(20),
  cycle_type_code VARCHAR2(20)
)
;
comment on table AR_STATISTIC_DATE
  is '����ʱ���';

prompt
prompt Creating table AR_STATISTIC_LOG
prompt ===============================
prompt
create table AR_STATISTIC_LOG
(
  ar_log_no      NUMBER(10),
  statistic_date DATE,
  created_by     VARCHAR2(20)
)
;
alter table AR_STATISTIC_LOG
  add unique (AR_LOG_NO);

prompt
prompt Creating table AR_STA_ITEM
prompt ==========================
prompt
create table AR_STA_ITEM
(
  item_no      NUMBER not null,
  item_id      VARCHAR2(40),
  item_name    VARCHAR2(50),
  item_en_name VARCHAR2(50),
  unit         VARCHAR2(10),
  min_unit     NUMBER,
  calcu_order  NUMBER,
  from_date    VARCHAR2(6),
  to_date      VARCHAR2(6),
  datatype     VARCHAR2(20),
  create_date  DATE default SYSDATE,
  created_by   VARCHAR2(20),
  update_date  DATE default SYSDATE,
  updated_by   VARCHAR2(20),
  activity     NUMBER(1) default 1,
  cpny_id      VARCHAR2(20),
  description  VARCHAR2(4000)
)
;
alter table AR_STA_ITEM
  add primary key (ITEM_NO);

prompt
prompt Creating table AR_STA_FORMULAR
prompt ==============================
prompt
create table AR_STA_FORMULAR
(
  formular_no   NUMBER not null,
  item_no       NUMBER,
  condition     VARCHAR2(2000),
  formular      VARCHAR2(4000),
  condition_var VARCHAR2(1000),
  formular_var  VARCHAR2(1000),
  table_name    VARCHAR2(20),
  column_type   VARCHAR2(20),
  ar_type_no    NUMBER,
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  orderno       NUMBER,
  description   VARCHAR2(1000)
)
;
alter table AR_STA_FORMULAR
  add constraint PK_AR_STA_FORMULAR primary key (FORMULAR_NO);
alter table AR_STA_FORMULAR
  add constraint UK_AR_STA_FORMULAR unique (ITEM_NO, CONDITION, FORMULAR);
alter table AR_STA_FORMULAR
  add constraint FK_AR_STA_FORMULAR foreign key (ITEM_NO)
  references AR_STA_ITEM (ITEM_NO) on delete cascade;

prompt
prompt Creating table AR_STA_PARAM
prompt ===========================
prompt
create table AR_STA_PARAM
(
  par_name       VARCHAR2(50) not null,
  par_table_name VARCHAR2(50)
)
;
alter table AR_STA_PARAM
  add primary key (PAR_NAME);

prompt
prompt Creating table AR_SUPERVISOR
prompt ============================
prompt
create table AR_SUPERVISOR
(
  supervisor_no NUMBER,
  supervisor_id VARCHAR2(20) not null,
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  activity      NUMBER
)
;
comment on table AR_SUPERVISOR
  is '����Ա��';
alter table AR_SUPERVISOR
  add constraint PK_AR_SUPERVISOR primary key (SUPERVISOR_ID);

prompt
prompt Creating table AR_SUPERVISOR_INFO
prompt =================================
prompt
create table AR_SUPERVISOR_INFO
(
  ar_supervisor_no  NUMBER(10),
  ar_supervisor_id  VARCHAR2(20) not null,
  supervised_deptid VARCHAR2(10) not null,
  create_date       DATE,
  created_by        VARCHAR2(20),
  update_date       DATE,
  updated_by        VARCHAR2(20),
  orderno           NUMBER(10),
  activity          NUMBER(1)
)
;
alter table AR_SUPERVISOR_INFO
  add constraint PK_AR_SUPERVISOR_INFO primary key (AR_SUPERVISOR_ID, SUPERVISED_DEPTID);
alter table AR_SUPERVISOR_INFO
  add constraint FK_AR_SUPERVISOR_INFO foreign key (AR_SUPERVISOR_ID)
  references AR_SUPERVISOR (SUPERVISOR_ID);

prompt
prompt Creating table AR_SY_MENU
prompt =========================
prompt
create table AR_SY_MENU
(
  menu_code        VARCHAR2(50) not null,
  menu_no          NUMBER(10),
  menu_intro       VARCHAR2(250),
  menu_img         VARCHAR2(25),
  menu_parent_code VARCHAR2(50),
  depth            NUMBER(10),
  table_name       VARCHAR2(50),
  menu_url         VARCHAR2(250),
  key_no           VARCHAR2(50),
  create_date      DATE,
  created_by       VARCHAR2(20),
  update_date      DATE,
  updated_by       VARCHAR2(20),
  orderno          NUMBER(10),
  activity         NUMBER(1)
)
;

prompt
prompt Creating table AR_TABLE_REMARK
prompt ==============================
prompt
create table AR_TABLE_REMARK
(
  table_name     VARCHAR2(30),
  column_name    VARCHAR2(30),
  data_type      VARCHAR2(106),
  remark         NVARCHAR2(200),
  data_length    NUMBER,
  data_precision NUMBER
)
;

prompt
prompt Creating table AR_TYPE
prompt ======================
prompt
create table AR_TYPE
(
  ar_type_no   NUMBER not null,
  ar_type_name VARCHAR2(50),
  descr        VARCHAR2(200)
)
;
alter table AR_TYPE
  add primary key (AR_TYPE_NO);

prompt
prompt Creating table AR_UPDATE_FLAG
prompt =============================
prompt
create table AR_UPDATE_FLAG
(
  ar_day      VARCHAR2(10) not null,
  empid       VARCHAR2(18) not null,
  updated_yn  VARCHAR2(1),
  update_time DATE
)
;

prompt
prompt Creating table AR_VAC_EMP
prompt =========================
prompt
create table AR_VAC_EMP
(
  vacation_no NUMBER(10) not null,
  empid       VARCHAR2(20) not null,
  vac_tp      VARCHAR2(20) not null,
  vac_id      VARCHAR2(20) not null,
  strt_date   DATE not null,
  end_date    DATE not null,
  tot_vac_cnt NUMBER(5,2),
  create_date DATE default SYSDATE,
  created_by  VARCHAR2(20),
  update_date DATE default SYSDATE,
  updated_by  VARCHAR2(20),
  activity    NUMBER(1),
  del_vac_cnt NUMBER(5,2) default 0
)
;
comment on column AR_VAC_EMP.vac_tp
  is '�ݼ�����';
comment on column AR_VAC_EMP.vac_id
  is '�ݼ�ID���ƣ�������٣�2007���¼٣�200706
Wooribank���ID : "��ʼ����-��������"';
comment on column AR_VAC_EMP.strt_date
  is 'ʹ�õĿ�ʼ����';
comment on column AR_VAC_EMP.end_date
  is 'ʹ�õĽ�������';
comment on column AR_VAC_EMP.tot_vac_cnt
  is '�ݼ�������';
alter table AR_VAC_EMP
  add primary key (VACATION_NO);

prompt
prompt Creating table AR_VAC_MASTER
prompt ============================
prompt
create table AR_VAC_MASTER
(
  vac_no      NUMBER(10) not null,
  vac_tp      VARCHAR2(20) not null,
  strt_month  VARCHAR2(6) not null,
  end_month   VARCHAR2(6) not null,
  vac_day_cnt NUMBER(5,2),
  create_date DATE default SYSDATE,
  created_by  VARCHAR2(20),
  update_date DATE default SYSDATE,
  updated_by  VARCHAR2(20),
  activity    NUMBER(1)
)
;
comment on table AR_VAC_MASTER
  is 'VACATION_MASTER';
comment on column AR_VAC_MASTER.vac_tp
  is 'VACATION_TYPE';
comment on column AR_VAC_MASTER.strt_month
  is 'START_MONTH';
comment on column AR_VAC_MASTER.end_month
  is 'END_MONTH';
comment on column AR_VAC_MASTER.vac_day_cnt
  is 'VACATION_DAY_COUNT';
alter table AR_VAC_MASTER
  add primary key (VAC_NO);

prompt
prompt Creating table AR_VISIT_CARD
prompt ============================
prompt
create table AR_VISIT_CARD
(
  no            NUMBER(10) not null,
  card_no       VARCHAR2(50) not null,
  name          VARCHAR2(50),
  from_date     DATE,
  to_date       DATE,
  active        NUMBER(1),
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  remark        VARCHAR2(100),
  principal     VARCHAR2(50),
  visitor_amont NUMBER
)
;
comment on table AR_VISIT_CARD
  is '�����߹�ϵ��';
comment on column AR_VISIT_CARD.card_no
  is 'ID Card ӡˢ����';
comment on column AR_VISIT_CARD.name
  is '����������';
comment on column AR_VISIT_CARD.from_date
  is '��ʼ����';
comment on column AR_VISIT_CARD.to_date
  is '��������';
comment on column AR_VISIT_CARD.active
  is '״̬����ʼ��ʱ״̬Ϊ0�������Ĺ�ϵ����״̬Ϊ1';
comment on column AR_VISIT_CARD.principal
  is '������';
comment on column AR_VISIT_CARD.visitor_amont
  is '��������';
alter table AR_VISIT_CARD
  add primary key (NO);

prompt
prompt Creating table ASS_ASSET_INFO
prompt =============================
prompt
create table ASS_ASSET_INFO
(
  asset_no             VARCHAR2(20) not null,
  asset_id             VARCHAR2(20) not null,
  asset_name_code      VARCHAR2(20),
  asset_category_code  VARCHAR2(20),
  asset_model          VARCHAR2(20),
  manufacturer         VARCHAR2(20),
  manufacture_date     DATE,
  international_number VARCHAR2(20),
  purchase_date        DATE,
  net_salvage_value    VARCHAR2(20),
  service_life         NUMBER(10),
  original_value       VARCHAR2(20),
  net_value            VARCHAR2(20),
  depreciation_way     VARCHAR2(20),
  status_code          VARCHAR2(20),
  status_remark        VARCHAR2(200),
  description          VARCHAR2(30),
  deptid               VARCHAR2(20),
  user_id              VARCHAR2(20),
  remark               VARCHAR2(200),
  photopath            VARCHAR2(100),
  orderno              NUMBER(10),
  create_date          DATE,
  created_by           VARCHAR2(20),
  update_date          DATE,
  updated_by           VARCHAR2(20),
  activity             NUMBER(1),
  remove_remark        VARCHAR2(200),
  allow_borrow         VARCHAR2(10),
  cpny_id              VARCHAR2(20),
  asset_name           VARCHAR2(40),
  asset_en_name        VARCHAR2(40),
  amount               NUMBER(10),
  warehouse            VARCHAR2(100)
)
;
comment on column ASS_ASSET_INFO.asset_no
  is '�ʲ����';
comment on column ASS_ASSET_INFO.asset_id
  is '�ʲ����';
comment on column ASS_ASSET_INFO.asset_name_code
  is '�ʲ�����';
comment on column ASS_ASSET_INFO.asset_category_code
  is '�ʲ����';
comment on column ASS_ASSET_INFO.asset_model
  is '��Ʒ�ͺ�';
comment on column ASS_ASSET_INFO.manufacturer
  is '��������';
comment on column ASS_ASSET_INFO.manufacture_date
  is '��������';
comment on column ASS_ASSET_INFO.international_number
  is '���ʱ��';
comment on column ASS_ASSET_INFO.purchase_date
  is '��������';
comment on column ASS_ASSET_INFO.net_salvage_value
  is '����ֵ��';
comment on column ASS_ASSET_INFO.service_life
  is 'ʹ������';
comment on column ASS_ASSET_INFO.original_value
  is 'ԭ��ֵ';
comment on column ASS_ASSET_INFO.net_value
  is '����ֵ';
comment on column ASS_ASSET_INFO.depreciation_way
  is '�۾ɷ�ʽ';
comment on column ASS_ASSET_INFO.status_code
  is '�ʲ�״̬';
comment on column ASS_ASSET_INFO.status_remark
  is '״̬��ע';
comment on column ASS_ASSET_INFO.description
  is '�ʲ�����';
comment on column ASS_ASSET_INFO.deptid
  is '����';
comment on column ASS_ASSET_INFO.user_id
  is 'ʹ����Ա';
comment on column ASS_ASSET_INFO.remark
  is '��ע';
comment on column ASS_ASSET_INFO.photopath
  is 'ͼƬ·��';
comment on column ASS_ASSET_INFO.remove_remark
  is '�Ƴ���ע';
comment on column ASS_ASSET_INFO.allow_borrow
  is '�Ƿ�������';
comment on column ASS_ASSET_INFO.cpny_id
  is '��˾ID';
comment on column ASS_ASSET_INFO.asset_name
  is '����';
comment on column ASS_ASSET_INFO.asset_en_name
  is 'Ӣ������';
alter table ASS_ASSET_INFO
  add constraint PK_ASS_ASSERT primary key (ASSET_ID);

prompt
prompt Creating table BOM_HEADER_INFO
prompt ==============================
prompt
create table BOM_HEADER_INFO
(
  bom_id           VARCHAR2(20) not null,
  factory_id       VARCHAR2(20),
  bom_type_id      VARCHAR2(20),
  created_by       VARCHAR2(20),
  create_date      DATE,
  updated_by       VARCHAR2(20),
  update_date      DATE,
  activity         NUMBER(1),
  order_no         NUMBER,
  cpny_id          VARCHAR2(20) not null,
  change_no        VARCHAR2(20),
  s_date           DATE,
  amount           VARCHAR2(20),
  amount_unit_code VARCHAR2(20),
  mat_v_id         VARCHAR2(20),
  description      VARCHAR2(400),
  bom_name         VARCHAR2(20),
  bom_status_id    VARCHAR2(20),
  loss_rate        NUMBER(10,4),
  process_no       VARCHAR2(20)
)
;
comment on column BOM_HEADER_INFO.bom_id
  is 'BOM��';
comment on column BOM_HEADER_INFO.factory_id
  is '����';
comment on column BOM_HEADER_INFO.bom_type_id
  is '��;';
comment on column BOM_HEADER_INFO.created_by
  is '������';
comment on column BOM_HEADER_INFO.create_date
  is '��������';
comment on column BOM_HEADER_INFO.updated_by
  is '������';
comment on column BOM_HEADER_INFO.update_date
  is '��������';
comment on column BOM_HEADER_INFO.activity
  is '�Ƿ񼤻�';
comment on column BOM_HEADER_INFO.order_no
  is '����';
comment on column BOM_HEADER_INFO.cpny_id
  is '��˾id';
comment on column BOM_HEADER_INFO.change_no
  is '�����';
comment on column BOM_HEADER_INFO.s_date
  is '��Ч����';
comment on column BOM_HEADER_INFO.amount
  is '��λ';
comment on column BOM_HEADER_INFO.amount_unit_code
  is '����';
comment on column BOM_HEADER_INFO.mat_v_id
  is '�������ϣ����ϻ����ĵ��ţ�';
comment on column BOM_HEADER_INFO.description
  is '����';
comment on column BOM_HEADER_INFO.bom_name
  is 'BOM����';
comment on column BOM_HEADER_INFO.bom_status_id
  is 'BOM״̬';
comment on column BOM_HEADER_INFO.loss_rate
  is '�����';
comment on column BOM_HEADER_INFO.process_no
  is '��˺�';
alter table BOM_HEADER_INFO
  add constraint PK_BOM_HEADER_INFO primary key (BOM_ID, CPNY_ID);

prompt
prompt Creating table BOM_ITEM_INFO
prompt ============================
prompt
create table BOM_ITEM_INFO
(
  bom_item_id       VARCHAR2(20) not null,
  bom_id            VARCHAR2(20),
  change_no         VARCHAR2(20),
  s_date            DATE,
  e_date            DATE,
  mat_v_id          VARCHAR2(20),
  factory_id        VARCHAR2(20),
  amount            NUMBER(10),
  amount_unit_code  VARCHAR2(20),
  created_by        VARCHAR2(20),
  create_date       DATE,
  updated_by        VARCHAR2(20),
  update_date       DATE,
  activity          NUMBER(1),
  order_no          NUMBER,
  cpny_id           VARCHAR2(20),
  bom_category_code VARCHAR2(20),
  bom_item_name     VARCHAR2(20),
  description       VARCHAR2(400),
  loss_rate         NUMBER(10,4)
)
;
comment on table BOM_ITEM_INFO
  is 'BOM�ڵ��';
comment on column BOM_ITEM_INFO.bom_item_id
  is '�ڵ���';
comment on column BOM_ITEM_INFO.bom_id
  is '���ڵ���';
comment on column BOM_ITEM_INFO.change_no
  is '�����';
comment on column BOM_ITEM_INFO.s_date
  is '��ʼʱ��';
comment on column BOM_ITEM_INFO.e_date
  is '����ʱ��';
comment on column BOM_ITEM_INFO.mat_v_id
  is '�������ϣ����ϻ����ĵ��ţ�';
comment on column BOM_ITEM_INFO.factory_id
  is '���Ź���';
comment on column BOM_ITEM_INFO.amount
  is '����';
comment on column BOM_ITEM_INFO.amount_unit_code
  is '��λ';
comment on column BOM_ITEM_INFO.created_by
  is '������';
comment on column BOM_ITEM_INFO.create_date
  is '��������';
comment on column BOM_ITEM_INFO.updated_by
  is '������';
comment on column BOM_ITEM_INFO.update_date
  is '��������';
comment on column BOM_ITEM_INFO.activity
  is '�Ƿ񼤻�';
comment on column BOM_ITEM_INFO.order_no
  is '����';
comment on column BOM_ITEM_INFO.cpny_id
  is '��˾id';
comment on column BOM_ITEM_INFO.bom_category_code
  is 'BOM����';
comment on column BOM_ITEM_INFO.bom_item_name
  is '�ڵ�����';
comment on column BOM_ITEM_INFO.description
  is '����';
comment on column BOM_ITEM_INFO.loss_rate
  is '�����';
alter table BOM_ITEM_INFO
  add constraint PK_BOM_ITEM_INFO primary key (BOM_ITEM_ID);

prompt
prompt Creating table BP_BUSIPART_INFO
prompt ===============================
prompt
create table BP_BUSIPART_INFO
(
  bp_id             VARCHAR2(20) not null,
  bp_parent_id      VARCHAR2(20),
  bp_type_code      VARCHAR2(20),
  bp_partner_id     VARCHAR2(20),
  bp_org_code       VARCHAR2(20),
  cpny_id           VARCHAR2(20),
  order_no          NUMBER(10),
  hierarchy_level   NUMBER(5),
  tree_node_code    VARCHAR2(30),
  activity          NUMBER(1),
  created_by        VARCHAR2(20),
  created_date      DATE,
  updated_by        VARCHAR2(20),
  updated_date      DATE,
  partner_type_code VARCHAR2(20),
  division_code     VARCHAR2(100),
  remark            VARCHAR2(200)
)
;
comment on column BP_BUSIPART_INFO.bp_id
  is 'BP��Ψһkey';
comment on column BP_BUSIPART_INFO.bp_parent_id
  is '��BP����һ��BP ID';
comment on column BP_BUSIPART_INFO.bp_type_code
  is 'BP������';
comment on column BP_BUSIPART_INFO.bp_partner_id
  is 'BP�ĳ�ԱID';
comment on column BP_BUSIPART_INFO.bp_org_code
  is 'BP��org area id';
comment on column BP_BUSIPART_INFO.cpny_id
  is '��˾ID';
comment on column BP_BUSIPART_INFO.order_no
  is '�����';
comment on column BP_BUSIPART_INFO.hierarchy_level
  is 'BP�ڲ㼶�еĲ�����1Ϊ���ϼ�';
comment on column BP_BUSIPART_INFO.tree_node_code
  is '��ʶ��BP�ڲ㼶�е�λ��';
comment on column BP_BUSIPART_INFO.activity
  is '�Ƿ����';
comment on column BP_BUSIPART_INFO.created_by
  is '������';
comment on column BP_BUSIPART_INFO.created_date
  is '��������';
comment on column BP_BUSIPART_INFO.updated_by
  is '������';
comment on column BP_BUSIPART_INFO.updated_date
  is '��������';
comment on column BP_BUSIPART_INFO.partner_type_code
  is '�������';
comment on column BP_BUSIPART_INFO.division_code
  is '��ҵ����';
comment on column BP_BUSIPART_INFO.remark
  is '��ע';
alter table BP_BUSIPART_INFO
  add constraint PK_BUSIPARTER_KEY primary key (BP_ID);

prompt
prompt Creating table BP_SALARY_BASIC
prompt ==============================
prompt
create table BP_SALARY_BASIC
(
  basic_salary_id VARCHAR2(20) not null,
  reference       VARCHAR2(20),
  complete_goal   NUMBER(10),
  return_value    NUMBER(10),
  activity        NUMBER(1),
  cpny_id         VARCHAR2(20)
)
;
comment on table BP_SALARY_BASIC
  is 'ҵ����������ʶ��ձ�';
comment on column BP_SALARY_BASIC.basic_salary_id
  is '����';
comment on column BP_SALARY_BASIC.reference
  is '�ο����ԣ����۶�����ۼ�����';
comment on column BP_SALARY_BASIC.complete_goal
  is '���Ŀ�꣨>=��ֵ����RETURN_VALUE��';
comment on column BP_SALARY_BASIC.return_value
  is '����ֵ';
alter table BP_SALARY_BASIC
  add constraint PK_BP_SALARY_BASIC primary key (BASIC_SALARY_ID);

prompt
prompt Creating table BP_SALARY_MONTH_BONUS
prompt ====================================
prompt
create table BP_SALARY_MONTH_BONUS
(
  month_bonus_salary_id VARCHAR2(20) not null,
  reference             VARCHAR2(20),
  complete_goal         NUMBER(10),
  return_value          NUMBER(10),
  activity              NUMBER(1),
  cpny_id               VARCHAR2(20)
)
;
comment on table BP_SALARY_MONTH_BONUS
  is 'ҵ����ÿ�½������ձ�';
comment on column BP_SALARY_MONTH_BONUS.month_bonus_salary_id
  is '����';
comment on column BP_SALARY_MONTH_BONUS.reference
  is '�ο����ԣ����۶�����ۼ�����';
comment on column BP_SALARY_MONTH_BONUS.complete_goal
  is '���Ŀ�꣨>=��ֵ����RETURN_VALUE��';
comment on column BP_SALARY_MONTH_BONUS.return_value
  is '����ֵ';
alter table BP_SALARY_MONTH_BONUS
  add constraint PK_BP_SALARY_MONTH_BONUS primary key (MONTH_BONUS_SALARY_ID);

prompt
prompt Creating table BP_SALE_PERF_COUNT
prompt =================================
prompt
create table BP_SALE_PERF_COUNT
(
  bp_id      VARCHAR2(20),
  product_id VARCHAR2(20),
  month      VARCHAR2(20),
  amount     NUMBER(10),
  volume     NUMBER(10),
  activty    NUMBER(1),
  cpny_id    VARCHAR2(20),
  bp_spc_id  VARCHAR2(20) not null
)
;
comment on table BP_SALE_PERF_COUNT
  is '����������ҵ����Sales Performance��ͳ��';
comment on column BP_SALE_PERF_COUNT.bp_id
  is 'ҵ����';
comment on column BP_SALE_PERF_COUNT.product_id
  is '��Ʒ';
comment on column BP_SALE_PERF_COUNT.month
  is 'ͳ�Ƶ��·ݣ�YYYYMM��';
comment on column BP_SALE_PERF_COUNT.amount
  is '��������';
comment on column BP_SALE_PERF_COUNT.volume
  is '���۶�';
comment on column BP_SALE_PERF_COUNT.bp_spc_id
  is '����';
alter table BP_SALE_PERF_COUNT
  add constraint PK_BP_SP_COUNT primary key (BP_SPC_ID);

prompt
prompt Creating table CHA_BASIC_INFO
prompt =============================
prompt
create table CHA_BASIC_INFO
(
  channel_id       VARCHAR2(20) not null,
  channel_name     VARCHAR2(100),
  province         VARCHAR2(20),
  city             VARCHAR2(20),
  area             VARCHAR2(20),
  address          VARCHAR2(200),
  license_no       VARCHAR2(40),
  telephone        VARCHAR2(20),
  fax              VARCHAR2(20),
  orderno          NUMBER(10),
  create_date      DATE,
  created_by       VARCHAR2(20),
  update_date      DATE,
  updated_by       VARCHAR2(20),
  activity         NUMBER(1),
  remark           VARCHAR2(200),
  cha_basic_no     NUMBER(10) not null,
  cpny_id          VARCHAR2(20),
  channel_en_name  VARCHAR2(100),
  total_credit     NUMBER(10),
  left_credit      NUMBER(10),
  cha_level        NUMBER(10),
  cha_experience   NUMBER(10),
  group_code       VARCHAR2(20),
  join_date        DATE,
  status_code      VARCHAR2(20),
  remove_remark    VARCHAR2(200),
  credit_unit_code VARCHAR2(20),
  sales_area_id    VARCHAR2(20),
  type_code        VARCHAR2(20),
  division_code    VARCHAR2(200)
)
;
comment on table CHA_BASIC_INFO
  is '��Ʒ������Ϣ��';
comment on column CHA_BASIC_INFO.channel_id
  is '�����̱��';
comment on column CHA_BASIC_INFO.channel_name
  is '����������';
comment on column CHA_BASIC_INFO.province
  is 'ʡ��';
comment on column CHA_BASIC_INFO.city
  is '����';
comment on column CHA_BASIC_INFO.area
  is '����';
comment on column CHA_BASIC_INFO.address
  is '��ַ';
comment on column CHA_BASIC_INFO.license_no
  is '���֤���';
comment on column CHA_BASIC_INFO.telephone
  is '�绰';
comment on column CHA_BASIC_INFO.fax
  is '����';
comment on column CHA_BASIC_INFO.channel_en_name
  is 'Ӣ����';
comment on column CHA_BASIC_INFO.total_credit
  is '�����ö��';
comment on column CHA_BASIC_INFO.left_credit
  is 'ʣ�����ö��';
comment on column CHA_BASIC_INFO.cha_level
  is '�ȼ���Ԥ����';
comment on column CHA_BASIC_INFO.cha_experience
  is '���飨Ԥ����';
comment on column CHA_BASIC_INFO.group_code
  is '�����̷��飨Ԥ����';
comment on column CHA_BASIC_INFO.join_date
  is '��������';
comment on column CHA_BASIC_INFO.status_code
  is '״̬';
comment on column CHA_BASIC_INFO.remove_remark
  is '�Ƴ���ע';
comment on column CHA_BASIC_INFO.credit_unit_code
  is '���õ�λ��RMB����Ԫ�ȣ�Ԥ��';
comment on column CHA_BASIC_INFO.sales_area_id
  is '���۵ص��ţ�Ԥ����';
comment on column CHA_BASIC_INFO.type_code
  is '����������';
comment on column CHA_BASIC_INFO.division_code
  is '��ҵ����';
alter table CHA_BASIC_INFO
  add constraint PK_CHA_BASIC primary key (CHANNEL_ID);

prompt
prompt Creating table CHA_CONTACT_INFO
prompt ===============================
prompt
create table CHA_CONTACT_INFO
(
  cha_contact_no   NUMBER(10),
  cha_contact_id   VARCHAR2(20) not null,
  contact_name     VARCHAR2(100),
  channel_id       VARCHAR2(20),
  gender_code      VARCHAR2(20),
  common_cellphone VARCHAR2(20),
  backup_cellphone VARCHAR2(20),
  common_telephone VARCHAR2(20),
  qq_number        VARCHAR2(20),
  email            VARCHAR2(40),
  create_date      DATE,
  created_by       VARCHAR2(20),
  update_date      DATE,
  updated_by       VARCHAR2(20),
  activity         NUMBER(1),
  orderno          NUMBER(10),
  remark           VARCHAR2(200),
  cpny_id          VARCHAR2(20),
  contact_en_name  VARCHAR2(100)
)
;
comment on table CHA_CONTACT_INFO
  is '��������ϵ����Ϣ��';
comment on column CHA_CONTACT_INFO.cha_contact_id
  is '��ϵ�˱��';
comment on column CHA_CONTACT_INFO.contact_name
  is '��ϵ������';
comment on column CHA_CONTACT_INFO.channel_id
  is '����������';
comment on column CHA_CONTACT_INFO.gender_code
  is '�Ա�';
comment on column CHA_CONTACT_INFO.common_cellphone
  is '�����ֻ�';
comment on column CHA_CONTACT_INFO.backup_cellphone
  is '�����ֻ�';
comment on column CHA_CONTACT_INFO.common_telephone
  is '���õ绰';
comment on column CHA_CONTACT_INFO.qq_number
  is 'QQ��';
comment on column CHA_CONTACT_INFO.email
  is 'Email';
comment on column CHA_CONTACT_INFO.remark
  is '��ע';
comment on column CHA_CONTACT_INFO.contact_en_name
  is '��ϵ��Ӣ������Ԥ����';
alter table CHA_CONTACT_INFO
  add constraint PK_CHA_CONTACT primary key (CHA_CONTACT_ID);

prompt
prompt Creating table COMPUTER
prompt =======================
prompt
create table COMPUTER
(
  id     NUMBER,
  brand  NVARCHAR2(20),
  cpu    NVARCHAR2(20),
  gpu    NVARCHAR2(20),
  memory NVARCHAR2(20),
  price  NUMBER
)
;

prompt
prompt Creating table CONTACT
prompt ======================
prompt
create table CONTACT
(
  id        NUMBER(11) not null,
  firstname VARCHAR2(20),
  lastname  VARCHAR2(20),
  email     VARCHAR2(20)
)
;
alter table CONTACT
  add constraint COST_ID_PK primary key (ID);

prompt
prompt Creating table CUST_ACTION_INFO
prompt ===============================
prompt
create table CUST_ACTION_INFO
(
  cust_action_no         NUMBER,
  cust_id                VARCHAR2(20),
  emp_id                 VARCHAR2(20),
  cust_action_way_code   VARCHAR2(20),
  cust_action_time       DATE,
  cust_action_content    VARCHAR2(3000),
  remark                 VARCHAR2(1000),
  cust_action_state_code VARCHAR2(20),
  created_by             VARCHAR2(20),
  created_date           DATE,
  updated_by             VARCHAR2(20),
  updated_date           DATE,
  activity               NUMBER(1),
  order_no               NUMBER,
  cpny_id                VARCHAR2(20),
  reminder               NUMBER(1),
  purchase_tend_code     VARCHAR2(20),
  trace_status_code      VARCHAR2(20),
  action_type_code       VARCHAR2(20),
  mobilephone            VARCHAR2(20),
  contact                VARCHAR2(50)
)
;
comment on column CUST_ACTION_INFO.cust_action_no
  is 'NO';
comment on column CUST_ACTION_INFO.cust_id
  is 'Ŀ��ͻ�';
comment on column CUST_ACTION_INFO.emp_id
  is 'ҵ��Ա��';
comment on column CUST_ACTION_INFO.cust_action_way_code
  is '��ʽ';
comment on column CUST_ACTION_INFO.cust_action_time
  is 'ʱ��';
comment on column CUST_ACTION_INFO.cust_action_content
  is '����';
comment on column CUST_ACTION_INFO.remark
  is '��ע';
comment on column CUST_ACTION_INFO.cust_action_state_code
  is '�״̬';
comment on column CUST_ACTION_INFO.created_by
  is '������';
comment on column CUST_ACTION_INFO.created_date
  is '��������';
comment on column CUST_ACTION_INFO.updated_by
  is '������';
comment on column CUST_ACTION_INFO.updated_date
  is '��������';
comment on column CUST_ACTION_INFO.activity
  is '�Ƿ񼤻�';
comment on column CUST_ACTION_INFO.order_no
  is '����';
comment on column CUST_ACTION_INFO.cpny_id
  is '��˾id';
comment on column CUST_ACTION_INFO.reminder
  is '����Ƿ�����';
comment on column CUST_ACTION_INFO.purchase_tend_code
  is '��������';
comment on column CUST_ACTION_INFO.trace_status_code
  is '����״̬';
comment on column CUST_ACTION_INFO.action_type_code
  is '����ͣ�����or�طã�';
comment on column CUST_ACTION_INFO.mobilephone
  is '��ϵ��ʽ';
comment on column CUST_ACTION_INFO.contact
  is '��ϵ��';

prompt
prompt Creating table CUST_APPENDIX_INFO
prompt =================================
prompt
create table CUST_APPENDIX_INFO
(
  cust_appen_no     NUMBER(10) not null,
  cust_id           VARCHAR2(20) not null,
  appendix_name     VARCHAR2(20),
  appendix_format   VARCHAR2(20),
  original_name     VARCHAR2(100),
  store_path        VARCHAR2(100),
  target_group_code VARCHAR2(20),
  orderno           NUMBER(10),
  create_date       DATE,
  created_by        VARCHAR2(20),
  update_date       DATE,
  updated_by        VARCHAR2(20),
  activity          NUMBER(1),
  remark            VARCHAR2(200),
  remove_remark     VARCHAR2(200),
  cpny_id           VARCHAR2(20),
  status_code       VARCHAR2(20),
  cust_appen_id     VARCHAR2(20) not null
)
;
comment on table CUST_APPENDIX_INFO
  is '�ͻ�������Ϣ��';
comment on column CUST_APPENDIX_INFO.cust_id
  is '�����ͻ����';
comment on column CUST_APPENDIX_INFO.appendix_name
  is '��������';
comment on column CUST_APPENDIX_INFO.appendix_format
  is '������ʽ';
comment on column CUST_APPENDIX_INFO.original_name
  is 'ԭ��';
comment on column CUST_APPENDIX_INFO.store_path
  is '�洢·��';
comment on column CUST_APPENDIX_INFO.target_group_code
  is 'Ŀ����Ⱥ��������';
comment on column CUST_APPENDIX_INFO.remove_remark
  is '�Ƴ���ע';
comment on column CUST_APPENDIX_INFO.status_code
  is '״̬�����ò�����';
comment on column CUST_APPENDIX_INFO.cust_appen_id
  is '�������';
alter table CUST_APPENDIX_INFO
  add constraint PK_CUST_APPE primary key (CUST_APPEN_ID);

prompt
prompt Creating table CUST_BASIC_INFO
prompt ==============================
prompt
create table CUST_BASIC_INFO
(
  cust_no                 VARCHAR2(20) not null,
  cust_id                 VARCHAR2(20) not null,
  cust_en_name            VARCHAR2(100),
  cust_name               VARCHAR2(100),
  cust_type_code          VARCHAR2(20),
  cust_status_code        VARCHAR2(20),
  province                VARCHAR2(20),
  city                    VARCHAR2(20),
  area                    VARCHAR2(20),
  address                 VARCHAR2(200),
  telephone               VARCHAR2(60),
  mobilephone             VARCHAR2(60),
  fax                     VARCHAR2(20),
  order_no                NUMBER(10),
  owner_id                VARCHAR2(20),
  created_date            DATE,
  created_by              VARCHAR2(20),
  updated_date            DATE,
  updated_by              VARCHAR2(20),
  description             VARCHAR2(200),
  remark                  VARCHAR2(200),
  remove_remark           VARCHAR2(200),
  activity                NUMBER(1),
  cpny_id                 VARCHAR2(20),
  email                   VARCHAR2(50),
  credit_amount           NUMBER(20,4),
  credit_amount_unit_code VARCHAR2(20),
  telephone_x             VARCHAR2(60),
  mobilephone_x           VARCHAR2(60),
  contact                 VARCHAR2(20),
  qq_id                   VARCHAR2(20),
  cust_level_code         VARCHAR2(20),
  bank                    VARCHAR2(100),
  bank_account            VARCHAR2(100),
  taxpayer_idcode         VARCHAR2(100),
  office_province         VARCHAR2(20),
  office_city             VARCHAR2(20),
  office_area             VARCHAR2(20),
  office_address          VARCHAR2(200),
  taobao_id               VARCHAR2(100),
  CUST_SALES_MODE_CODE    VARCHAR2(20),
  CUST_SALES_MODE         VARCHAR2(20)
)
;
comment on column CUST_BASIC_INFO.cust_no
  is 'no';
comment on column CUST_BASIC_INFO.cust_id
  is '#*�ͻ����';
comment on column CUST_BASIC_INFO.cust_en_name
  is 'Ӣ������';
comment on column CUST_BASIC_INFO.cust_name
  is '#*�ͻ�����';
comment on column CUST_BASIC_INFO.cust_type_code
  is '#*�ͻ�����';
comment on column CUST_BASIC_INFO.cust_status_code
  is '�ͻ���״̬���Ͽͻ��¿ͻ���';
comment on column CUST_BASIC_INFO.province
  is 'ע���ַ���ڵ�ʡ��';
comment on column CUST_BASIC_INFO.city
  is 'ע���ַ���ڵ���';
comment on column CUST_BASIC_INFO.area
  is 'ע���ַ���ڵ���';
comment on column CUST_BASIC_INFO.address
  is 'ע���ַ���ڵĵ�ַ';
comment on column CUST_BASIC_INFO.telephone
  is '#����';
comment on column CUST_BASIC_INFO.mobilephone
  is '�ֻ�';
comment on column CUST_BASIC_INFO.fax
  is '����';
comment on column CUST_BASIC_INFO.order_no
  is '�����';
comment on column CUST_BASIC_INFO.owner_id
  is 'ӵ����ID';
comment on column CUST_BASIC_INFO.created_date
  is '��������';
comment on column CUST_BASIC_INFO.created_by
  is '������';
comment on column CUST_BASIC_INFO.updated_date
  is '��������';
comment on column CUST_BASIC_INFO.updated_by
  is '������';
comment on column CUST_BASIC_INFO.description
  is '����';
comment on column CUST_BASIC_INFO.remark
  is '��ע';
comment on column CUST_BASIC_INFO.remove_remark
  is 'ɾ����ע';
comment on column CUST_BASIC_INFO.activity
  is '�Ƿ񼤻�';
comment on column CUST_BASIC_INFO.cpny_id
  is '��˾id';
comment on column CUST_BASIC_INFO.email
  is '����';
comment on column CUST_BASIC_INFO.credit_amount
  is '���ö��';
comment on column CUST_BASIC_INFO.credit_amount_unit_code
  is '���õĵ�λ';
comment on column CUST_BASIC_INFO.contact
  is '��ϵ��';
comment on column CUST_BASIC_INFO.bank
  is '��������';
comment on column CUST_BASIC_INFO.bank_account
  is '�����˺�';
comment on column CUST_BASIC_INFO.taxpayer_idcode
  is '��˰��ʶ����';
comment on column CUST_BASIC_INFO.office_province
  is '�칫��ַ���ڵ�ʡ��';
comment on column CUST_BASIC_INFO.office_city
  is '�칫��ַ���ڵĳ���';
comment on column CUST_BASIC_INFO.office_area
  is '�칫��ַ���ڵĵ���';
comment on column CUST_BASIC_INFO.office_address
  is '��ַ';
comment on column CUST_BASIC_INFO.cust_sales_mode_code
  is '#*���۷�ʽ';
alter table CUST_BASIC_INFO
  add constraint CUST_PK_ID_KEY primary key (CUST_NO);

prompt
prompt Creating table CUST_CONTACTS
prompt ============================
prompt
create table CUST_CONTACTS
(
  contacts_id        NUMBER(10),
  contacts_type      VARCHAR2(30),
  contacts_name      VARCHAR2(100),
  contacts_mobile1   VARCHAR2(11),
  contacts_mobile2   VARCHAR2(11),
  contacts_telephone VARCHAR2(20),
  contacts_email     VARCHAR2(50),
  contacts_fax       VARCHAR2(50),
  contacts_address   VARCHAR2(200),
  cust_id            VARCHAR2(20),
  cpny_id            VARCHAR2(20),
  contacts_en_name   VARCHAR2(100),
  contacts_province  VARCHAR2(20),
  contacts_city      VARCHAR2(20),
  contacts_area      VARCHAR2(20)
)
;
comment on column CUST_CONTACTS.contacts_id
  is '�ñ��ID';
comment on column CUST_CONTACTS.contacts_type
  is '��ϵ�˵�����,�йؼ���ϵ�˺ͷǹؼ���ϵ��';
comment on column CUST_CONTACTS.contacts_name
  is '#*��ϵ��';
comment on column CUST_CONTACTS.contacts_mobile1
  is '#*�ֻ�';
comment on column CUST_CONTACTS.contacts_mobile2
  is '�ֻ���2';
comment on column CUST_CONTACTS.contacts_telephone
  is '�̶��绰';
comment on column CUST_CONTACTS.contacts_email
  is '#����';
comment on column CUST_CONTACTS.contacts_fax
  is '����';
comment on column CUST_CONTACTS.contacts_address
  is '#��ַ';
comment on column CUST_CONTACTS.cust_id
  is '���ڵĿͻ�ID';
comment on column CUST_CONTACTS.cpny_id
  is '���ڵĹ�˾ID';
comment on column CUST_CONTACTS.contacts_en_name
  is 'Ӣ������';
comment on column CUST_CONTACTS.contacts_province
  is '����ʡ��';
comment on column CUST_CONTACTS.contacts_city
  is '���ڵĳ���';
comment on column CUST_CONTACTS.contacts_area
  is '���ڵ��ؼ�';
create unique index CUST_CONTACTS_SEQ on CUST_CONTACTS (CONTACTS_ID);

prompt
prompt Creating table CUST_RECEIVER
prompt ============================
prompt
create table CUST_RECEIVER
(
  receiver_id        NUMBER(10),
  receiver_name      VARCHAR2(100),
  receiver_mobile1   VARCHAR2(11),
  receiver_mobile2   VARCHAR2(11),
  receiver_email     VARCHAR2(30),
  receiver_address   VARCHAR2(100),
  cust_id            VARCHAR2(20),
  cpny_id            VARCHAR2(20),
  receiver_en_name   VARCHAR2(100),
  receiver_province  VARCHAR2(20),
  receiver_city      VARCHAR2(20),
  receiver_area      VARCHAR2(20),
  receiver_telephone VARCHAR2(20)
)
;

prompt
prompt Creating table DOC_FILE_INFO
prompt ============================
prompt
create table DOC_FILE_INFO
(
  file_id      VARCHAR2(20) not null,
  doc_id       VARCHAR2(20) not null,
  file_name    VARCHAR2(100),
  file_path    VARCHAR2(500),
  description  VARCHAR2(200),
  file_version VARCHAR2(20),
  created_by   VARCHAR2(20),
  create_date  DATE,
  updated_by   VARCHAR2(20),
  update_date  DATE,
  locked       NUMBER(1),
  activity     NUMBER(1),
  cpny_id      VARCHAR2(20),
  check_date   DATE,
  checked_by   VARCHAR2(20)
)
;
comment on column DOC_FILE_INFO.file_id
  is '�ļ����';
comment on column DOC_FILE_INFO.doc_id
  is '�ĵ����';
comment on column DOC_FILE_INFO.file_name
  is '�ļ�����';
comment on column DOC_FILE_INFO.file_path
  is '�ļ�·��';
comment on column DOC_FILE_INFO.description
  is '�ļ�����';
comment on column DOC_FILE_INFO.file_version
  is '�ļ��汾';
comment on column DOC_FILE_INFO.created_by
  is '������';
comment on column DOC_FILE_INFO.create_date
  is '��������';
comment on column DOC_FILE_INFO.updated_by
  is '������';
comment on column DOC_FILE_INFO.update_date
  is '��������';
comment on column DOC_FILE_INFO.locked
  is '�Ƿ�����';
comment on column DOC_FILE_INFO.activity
  is '�Ƿ����';
comment on column DOC_FILE_INFO.cpny_id
  is '��˾���';
comment on column DOC_FILE_INFO.check_date
  is '�������';
comment on column DOC_FILE_INFO.checked_by
  is '�����';

prompt
prompt Creating table DOC_INFO
prompt =======================
prompt
create table DOC_INFO
(
  doc_id        VARCHAR2(20) not null,
  doc_name      VARCHAR2(100) not null,
  description   VARCHAR2(200),
  doc_type_id   VARCHAR2(20),
  doc_status_id VARCHAR2(20),
  doc_version   VARCHAR2(20) not null,
  created_by    VARCHAR2(20),
  create_date   DATE,
  updated_by    VARCHAR2(20),
  update_date   DATE,
  activity      NUMBER(1),
  cpny_id       VARCHAR2(20) not null,
  doc_part      VARCHAR2(20) not null,
  change_no     VARCHAR2(20),
  s_date        DATE,
  e_date        DATE,
  ori_id        VARCHAR2(20),
  process_no    VARCHAR2(20)
)
;
comment on column DOC_INFO.doc_id
  is '�ĵ����';
comment on column DOC_INFO.doc_name
  is '�ĵ�����';
comment on column DOC_INFO.description
  is '�ĵ�����';
comment on column DOC_INFO.doc_type_id
  is '�ĵ�����';
comment on column DOC_INFO.doc_status_id
  is '�ĵ�״̬';
comment on column DOC_INFO.doc_version
  is '�ĵ��汾';
comment on column DOC_INFO.created_by
  is '������';
comment on column DOC_INFO.create_date
  is '��������';
comment on column DOC_INFO.updated_by
  is '������';
comment on column DOC_INFO.update_date
  is '��������';
comment on column DOC_INFO.activity
  is '�Ƿ����';
comment on column DOC_INFO.cpny_id
  is '��˾���';
comment on column DOC_INFO.doc_part
  is '�ĵ�����';
comment on column DOC_INFO.ori_id
  is '�汾�ű��ǰ��ID����汾��Ϊ1��DOC_ID��ͬ';
comment on column DOC_INFO.process_no
  is '��������˺�';
alter table DOC_INFO
  add constraint DOC_KEY primary key (DOC_ID, CPNY_ID);

prompt
prompt Creating table DOC_OBJECT_REL
prompt =============================
prompt
create table DOC_OBJECT_REL
(
  doc_id         VARCHAR2(20),
  object_id      VARCHAR2(20),
  object_type_id VARCHAR2(20),
  created_by     VARCHAR2(20),
  create_date    DATE,
  updated_by     VARCHAR2(20),
  update_date    DATE,
  activity       NUMBER(1),
  cpny_id        VARCHAR2(20)
)
;

prompt
prompt Creating table ECM_CHANGE_NO_INFO
prompt =================================
prompt
create table ECM_CHANGE_NO_INFO
(
  change_no        VARCHAR2(20) not null,
  change_status_id VARCHAR2(20),
  s_date           DATE,
  change_type_id   VARCHAR2(20),
  reason           VARCHAR2(2000),
  description      VARCHAR2(2000),
  created_by       VARCHAR2(20),
  create_date      DATE,
  updated_by       VARCHAR2(20),
  update_date      DATE,
  approved_by      VARCHAR2(20),
  approve_date     DATE,
  activity         NUMBER(1),
  cpny_id          VARCHAR2(20),
  orderno          NUMBER(10),
  process_no       VARCHAR2(20),
  e_date           DATE
)
;
comment on table ECM_CHANGE_NO_INFO
  is '�������Ϣ';
comment on column ECM_CHANGE_NO_INFO.change_no
  is '�����';
comment on column ECM_CHANGE_NO_INFO.change_status_id
  is '״̬';
comment on column ECM_CHANGE_NO_INFO.s_date
  is '��ʼʱ��';
comment on column ECM_CHANGE_NO_INFO.change_type_id
  is '����';
comment on column ECM_CHANGE_NO_INFO.reason
  is 'ԭ��';
comment on column ECM_CHANGE_NO_INFO.description
  is '����';
comment on column ECM_CHANGE_NO_INFO.created_by
  is '������';
comment on column ECM_CHANGE_NO_INFO.create_date
  is '��������';
comment on column ECM_CHANGE_NO_INFO.updated_by
  is '������';
comment on column ECM_CHANGE_NO_INFO.update_date
  is '��������';
comment on column ECM_CHANGE_NO_INFO.approved_by
  is '�����';
comment on column ECM_CHANGE_NO_INFO.approve_date
  is '�������';
comment on column ECM_CHANGE_NO_INFO.activity
  is '�Ƿ����';
comment on column ECM_CHANGE_NO_INFO.cpny_id
  is '��˾���';
comment on column ECM_CHANGE_NO_INFO.process_no
  is '��˺�';
comment on column ECM_CHANGE_NO_INFO.e_date
  is '��������';
alter table ECM_CHANGE_NO_INFO
  add constraint PK_ECM_CHANGE_NO_INFO primary key (CHANGE_NO);

prompt
prompt Creating table ECM_CHANGE_OBJECT_INFO
prompt =====================================
prompt
create table ECM_CHANGE_OBJECT_INFO
(
  change_no       VARCHAR2(20) not null,
  object_category VARCHAR2(20),
  object_id       VARCHAR2(20),
  created_by      VARCHAR2(20),
  create_date     DATE,
  updated_by      VARCHAR2(20),
  update_date     DATE,
  is_updated      NUMBER(1),
  activity        NUMBER(1),
  cpny_id         VARCHAR2(20) not null
)
;
comment on table ECM_CHANGE_OBJECT_INFO
  is '��������';
comment on column ECM_CHANGE_OBJECT_INFO.change_no
  is '�����';
comment on column ECM_CHANGE_OBJECT_INFO.object_category
  is '��������';
comment on column ECM_CHANGE_OBJECT_INFO.object_id
  is '������';
comment on column ECM_CHANGE_OBJECT_INFO.created_by
  is '������';
comment on column ECM_CHANGE_OBJECT_INFO.create_date
  is '��������';
comment on column ECM_CHANGE_OBJECT_INFO.updated_by
  is '������';
comment on column ECM_CHANGE_OBJECT_INFO.update_date
  is '��������';
comment on column ECM_CHANGE_OBJECT_INFO.is_updated
  is '�Ƿ��Ѹ���';
comment on column ECM_CHANGE_OBJECT_INFO.activity
  is '�Ƿ����';
comment on column ECM_CHANGE_OBJECT_INFO.cpny_id
  is '��˾���';

prompt
prompt Creating table ESS_AFFIRM
prompt =========================
prompt
create table ESS_AFFIRM
(
  ess_affirm_no NUMBER,
  apply_no      NUMBER not null,
  affirm_flag   NUMBER,
  affirm_level  NUMBER,
  affirmor_id   VARCHAR2(20) not null,
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  activity      NUMBER(1),
  apply_type    VARCHAR2(20) not null,
  app_remark    VARCHAR2(200)
)
;
comment on column ESS_AFFIRM.ess_affirm_no
  is '������Ϣ��ţ�ϵͳ�Զ����ɣ�';
comment on column ESS_AFFIRM.apply_no
  is '������(�ο�������������)';
comment on column ESS_AFFIRM.affirm_flag
  is '�Ƿ���ñ��,0Ϊδ����,1Ϊ����ͨ��,2Ϊ����δͨ��';
comment on column ESS_AFFIRM.affirm_level
  is '�����ߵȼ�';
comment on column ESS_AFFIRM.affirmor_id
  is '�����߹���';
comment on column ESS_AFFIRM.apply_type
  is '��������';
create unique index ESS_AFFIRM_PK on ESS_AFFIRM (APPLY_NO, APPLY_TYPE, AFFIRM_LEVEL, AFFIRMOR_ID);
create unique index ESS_AFFIRM_UNIQUE_NO on ESS_AFFIRM (ESS_AFFIRM_NO);

prompt
prompt Creating table ESS_APPLY_BT
prompt ===========================
prompt
create table ESS_APPLY_BT
(
  bt_no         NUMBER not null,
  empid         VARCHAR2(20),
  bt_type_code  VARCHAR2(20),
  bt_from_time  DATE,
  bt_to_time    DATE,
  bt_content    VARCHAR2(2000),
  bt_reason     VARCHAR2(2000),
  bt_remark     VARCHAR2(2000),
  bt_wa_empid   VARCHAR2(20),
  create_date   DATE,
  created_by    VARCHAR2(20),
  updated_by    VARCHAR2(20),
  update_date   DATE,
  orderno       NUMBER,
  time_stamp    VARCHAR2(20),
  affirm_flag   NUMBER(1) default 0,
  activity      NUMBER(1),
  cancel_remark VARCHAR2(200),
  con_remark    VARCHAR2(200),
  processid     VARCHAR2(20),
  bt_city       VARCHAR2(20),
  bt_province   VARCHAR2(20)
)
;
comment on table ESS_APPLY_BT
  is '�ݼ�����';
comment on column ESS_APPLY_BT.bt_no
  is '�Զ����';
comment on column ESS_APPLY_BT.empid
  is '������';
comment on column ESS_APPLY_BT.bt_type_code
  is '�ݼ�����';
comment on column ESS_APPLY_BT.bt_from_time
  is '�ݼٿ�ʼʱ��';
comment on column ESS_APPLY_BT.bt_to_time
  is '�ݼٽ���ʱ��';
comment on column ESS_APPLY_BT.bt_reason
  is '�ݼ�ԭ��';
comment on column ESS_APPLY_BT.bt_wa_empid
  is '����������';
comment on column ESS_APPLY_BT.create_date
  is '��¼��������';
comment on column ESS_APPLY_BT.created_by
  is '��¼������';
comment on column ESS_APPLY_BT.updated_by
  is '��¼�޸���';
comment on column ESS_APPLY_BT.update_date
  is '��¼�޸�����';
comment on column ESS_APPLY_BT.affirm_flag
  is '���״̬';
comment on column ESS_APPLY_BT.activity
  is '����״̬';
comment on column ESS_APPLY_BT.processid
  is '���̴���ID';
create index IDX_ESS_APPLY_TB on ESS_APPLY_BT (EMPID, BT_TYPE_CODE);
alter table ESS_APPLY_BT
  add constraint PK_ESS_APPLY_TB primary key (BT_NO);

prompt
prompt Creating table ESS_APPLY_CARD
prompt =============================
prompt
create table ESS_APPLY_CARD
(
  card_no         NUMBER not null,
  empid           VARCHAR2(20),
  card_door_type  VARCHAR2(3),
  r_time          DATE,
  card_reason     VARCHAR2(2000),
  card_id         VARCHAR2(50),
  att_date        DATE,
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  affirm_flag     NUMBER(1) default 0,
  activity        NUMBER(1) default 1,
  cancel_remark   VARCHAR2(20),
  processid       VARCHAR2(40),
  attendance_flag NUMBER(1) default 0
)
;
comment on column ESS_APPLY_CARD.card_no
  is '�����';
comment on column ESS_APPLY_CARD.empid
  is '������ID';
comment on column ESS_APPLY_CARD.card_door_type
  is '�����ű�־(in ����,out ����)';
comment on column ESS_APPLY_CARD.card_reason
  is '����ԭ��';
comment on column ESS_APPLY_CARD.card_id
  is '����';
comment on column ESS_APPLY_CARD.create_date
  is '��������';
comment on column ESS_APPLY_CARD.created_by
  is '������';
comment on column ESS_APPLY_CARD.update_date
  is '��������';
comment on column ESS_APPLY_CARD.updated_by
  is '������';
comment on column ESS_APPLY_CARD.processid
  is '����ID';
comment on column ESS_APPLY_CARD.attendance_flag
  is '������˺��Ƿ��¼�ڿ��ڱ�ı�־';
alter table ESS_APPLY_CARD
  add constraint PK_ESS_CARD_APPLY_TB primary key (CARD_NO);

prompt
prompt Creating table ESS_APPLY_ETN
prompt ============================
prompt
create table ESS_APPLY_ETN
(
  etn_no        NUMBER,
  seq_year_plan VARCHAR2(30),
  empid         VARCHAR2(20),
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  remark        VARCHAR2(500),
  activity      NUMBER default 0,
  etn_affirm    NUMBER default 0
)
;
comment on column ESS_APPLY_ETN.etn_no
  is '��ˮ��';
comment on column ESS_APPLY_ETN.seq_year_plan
  is '��������';
comment on column ESS_APPLY_ETN.empid
  is '������';
comment on column ESS_APPLY_ETN.create_date
  is '��������';
comment on column ESS_APPLY_ETN.created_by
  is '������';
comment on column ESS_APPLY_ETN.update_date
  is '��������';
comment on column ESS_APPLY_ETN.updated_by
  is '������';
comment on column ESS_APPLY_ETN.remark
  is '��ע';
comment on column ESS_APPLY_ETN.activity
  is '�Ƿ��Ծ';

prompt
prompt Creating table ESS_APPLY_EXP
prompt ============================
prompt
create table ESS_APPLY_EXP
(
  exp_no        NUMBER not null,
  empid         VARCHAR2(20),
  exp_type_code VARCHAR2(20),
  exp_from_time DATE,
  exp_to_time   DATE,
  exp_content   VARCHAR2(2000),
  exp_reason    VARCHAR2(2000),
  exp_remark    VARCHAR2(2000),
  create_date   DATE,
  created_by    VARCHAR2(20),
  updated_by    VARCHAR2(20),
  update_date   DATE,
  orderno       NUMBER,
  time_stamp    VARCHAR2(20),
  affirm_flag   NUMBER(1) default 0,
  activity      NUMBER(1) default 0,
  cancel_remark VARCHAR2(200),
  con_remark    VARCHAR2(200),
  bt_no         VARCHAR2(20),
  moneyamount   NUMBER,
  processid     VARCHAR2(20)
)
;
comment on table ESS_APPLY_EXP
  is '��������';
create index IDX_ESS_APPLY_EXP on ESS_APPLY_EXP (EMPID, EXP_TYPE_CODE);
alter table ESS_APPLY_EXP
  add constraint PK_ESS_APPLY_EXP primary key (EXP_NO);

prompt
prompt Creating table ESS_APPLY_EXP_DETAIL
prompt ===================================
prompt
create table ESS_APPLY_EXP_DETAIL
(
  exp_no            NUMBER not null,
  exp_type_code     VARCHAR2(20) not null,
  exp_number        NUMBER(10,2),
  exp_currency_unit VARCHAR2(20),
  exp_exchange_rate NUMBER(10,2),
  exp_remark        VARCHAR2(200),
  create_date       DATE,
  created_by        VARCHAR2(20),
  updated_by        VARCHAR2(20),
  update_date       DATE,
  orderno           NUMBER,
  time_stamp        VARCHAR2(20),
  exp_affirm        NUMBER(1) default 0,
  activity          NUMBER(1) default 0,
  cancel_remark     VARCHAR2(200),
  con_remark        VARCHAR2(200),
  exp_from_time     DATE,
  exp_to_time       DATE
)
;
comment on table ESS_APPLY_EXP_DETAIL
  is '������ϸ';
comment on column ESS_APPLY_EXP_DETAIL.exp_type_code
  is '��������';
comment on column ESS_APPLY_EXP_DETAIL.exp_number
  is '���';
comment on column ESS_APPLY_EXP_DETAIL.exp_currency_unit
  is '���ҵ�λ';
comment on column ESS_APPLY_EXP_DETAIL.exp_exchange_rate
  is '����';
comment on column ESS_APPLY_EXP_DETAIL.exp_remark
  is '��ע';

prompt
prompt Creating table ESS_APPLY_LEAVE
prompt ==============================
prompt
create table ESS_APPLY_LEAVE
(
  leave_no        NUMBER not null,
  empid           VARCHAR2(20),
  leave_type_code VARCHAR2(20),
  leave_from_time DATE,
  leave_to_time   DATE,
  leave_reason    VARCHAR2(2000),
  affirm_flag     NUMBER(1) default 0,
  leave_remark    VARCHAR2(2000),
  leave_wa_empid  VARCHAR2(20),
  create_date     DATE,
  created_by      VARCHAR2(20),
  updated_by      VARCHAR2(20),
  update_date     DATE,
  orderno         NUMBER,
  activity        NUMBER,
  cancel_remark   VARCHAR2(200),
  con_remark      VARCHAR2(200),
  processid       VARCHAR2(20)
)
;
comment on table ESS_APPLY_LEAVE
  is '�ݼ�����';
comment on column ESS_APPLY_LEAVE.leave_no
  is '�Զ����';
comment on column ESS_APPLY_LEAVE.empid
  is '������';
comment on column ESS_APPLY_LEAVE.leave_type_code
  is '�ݼ�����';
comment on column ESS_APPLY_LEAVE.leave_from_time
  is '�ݼٿ�ʼʱ��';
comment on column ESS_APPLY_LEAVE.leave_to_time
  is '�ݼٽ���ʱ��';
comment on column ESS_APPLY_LEAVE.leave_reason
  is '�ݼ�ԭ��';
comment on column ESS_APPLY_LEAVE.leave_wa_empid
  is '����������';
comment on column ESS_APPLY_LEAVE.create_date
  is '��¼��������';
comment on column ESS_APPLY_LEAVE.created_by
  is '��¼������';
comment on column ESS_APPLY_LEAVE.updated_by
  is '��¼�޸���';
comment on column ESS_APPLY_LEAVE.update_date
  is '��¼�޸�����';
comment on column ESS_APPLY_LEAVE.activity
  is '����״̬';
comment on column ESS_APPLY_LEAVE.processid
  is '���̴���ʵ��id';
create index IDX_ESS_LEAVE_TYPE_EMP on ESS_APPLY_LEAVE (EMPID, LEAVE_TYPE_CODE);
alter table ESS_APPLY_LEAVE
  add constraint PK_ESS_LEAVE_APPLY_TB primary key (LEAVE_NO);

prompt
prompt Creating table ESS_APPLY_ONDUTY
prompt ===============================
prompt
create table ESS_APPLY_ONDUTY
(
  onduty_no        NUMBER not null,
  empid            VARCHAR2(20),
  onduty_type_code VARCHAR2(20),
  onduty_from_time DATE,
  onduty_to_time   DATE,
  onduty_content   VARCHAR2(255),
  onduty_remarks   VARCHAR2(255),
  onduty_affirm    NUMBER(1),
  create_date      DATE,
  created_by       VARCHAR2(20),
  updated_by       VARCHAR2(20),
  update_date      DATE,
  activity         NUMBER default 0
)
;
comment on table ESS_APPLY_ONDUTY
  is 'on duty';
alter table ESS_APPLY_ONDUTY
  add constraint PK_ESS_MATCH_APPLY_TB primary key (ONDUTY_NO);

prompt
prompt Creating table ESS_APPLY_OT
prompt ===========================
prompt
create table ESS_APPLY_OT
(
  ot_no         NUMBER(10) not null,
  empid         VARCHAR2(20),
  ot_type_code  VARCHAR2(20),
  ot_from_time  VARCHAR2(20),
  ot_to_time    VARCHAR2(20),
  affirm_flag   NUMBER(1) default 0,
  con_remark    VARCHAR2(2000),
  ot_content    VARCHAR2(2000),
  ot_deduction  NUMBER(10,1),
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  orderno       NUMBER(10),
  activity      NUMBER(1),
  cancel_remark VARCHAR2(200),
  processid     VARCHAR2(20)
)
;
alter table ESS_APPLY_OT
  add constraint PK_ESS_APPLY_OT primary key (OT_NO);
alter table ESS_APPLY_OT
  add constraint UK_ESS_APPLY_OT unique (OT_NO, OT_TYPE_CODE);

prompt
prompt Creating table ESS_APPLY_TOOL
prompt =============================
prompt
create table ESS_APPLY_TOOL
(
  tool_no          NUMBER(10) not null,
  empid            VARCHAR2(20),
  tool_type_code   VARCHAR2(20),
  borrow_date      DATE,
  tool_from_time   VARCHAR2(20),
  tool_to_time     VARCHAR2(20),
  affirm_flag      NUMBER(1) default 0,
  con_remark       VARCHAR2(2000),
  tool_content     VARCHAR2(2000),
  return_date      DATE,
  return_type_code VARCHAR2(20),
  return_remark    VARCHAR2(2000),
  create_date      DATE,
  created_by       VARCHAR2(20),
  update_date      DATE,
  updated_by       VARCHAR2(20),
  orderno          NUMBER(10),
  activity         NUMBER(1),
  cancel_remark    VARCHAR2(200),
  tool_remark      VARCHAR2(2000),
  processid        VARCHAR2(20),
  return_flag      NUMBER(1) default 0,
  broken_info      VARCHAR2(20),
  asset_no         NUMBER(10)
)
;
comment on column ESS_APPLY_TOOL.affirm_flag
  is '���״̬��Ĭ��δ���';
comment on column ESS_APPLY_TOOL.activity
  is 'ɾ����־';
comment on column ESS_APPLY_TOOL.return_flag
  is '�黹״̬��Ĭ��δ�黹';
comment on column ESS_APPLY_TOOL.broken_info
  is '�������';
comment on column ESS_APPLY_TOOL.asset_no
  is '�ʲ����';
alter table ESS_APPLY_TOOL
  add constraint PK_ESS_APPLY_TOOL primary key (TOOL_NO);

prompt
prompt Creating table ESS_PROJECT
prompt ==========================
prompt
create table ESS_PROJECT
(
  pro_no      NUMBER(10) not null,
  pro_name    VARCHAR2(200) not null,
  pro_en_name VARCHAR2(200),
  pro_module  VARCHAR2(200),
  start_date  DATE,
  end_date    DATE,
  description VARCHAR2(2000),
  remark      VARCHAR2(2000),
  create_date DATE,
  created_by  VARCHAR2(20),
  update_date DATE,
  updated_by  VARCHAR2(20),
  orderno     NUMBER(10),
  activity    NUMBER(1),
  cpny_id     VARCHAR2(20),
  quantity    NUMBER(10,2) default 0,
  type_code   VARCHAR2(20)
)
;
alter table ESS_PROJECT
  add constraint ESS_PROJECT primary key (PRO_NO);

prompt
prompt Creating table ESS_PRODUCTION_ORDER
prompt ===================================
prompt
create table ESS_PRODUCTION_ORDER
(
  prod_no     NUMBER(10) not null,
  prod_id     VARCHAR2(18),
  pro_no      NUMBER(10),
  drawing_no  VARCHAR2(18),
  quantity    NUMBER(10,2),
  remark      VARCHAR2(2000),
  created_by  VARCHAR2(20),
  create_date DATE,
  updated_by  VARCHAR2(20),
  update_date DATE,
  activity    NUMBER(1),
  cpny_id     VARCHAR2(20),
  weight      NUMBER(10,2),
  unit_price  NUMBER(10,2)
)
;
alter table ESS_PRODUCTION_ORDER
  add constraint ESS_PRO_NO_PK primary key (PROD_NO);
alter table ESS_PRODUCTION_ORDER
  add constraint ESS_PROD_NO_UK unique (PROD_ID);
alter table ESS_PRODUCTION_ORDER
  add constraint ESS_PRO_NO_FK foreign key (PRO_NO)
  references ESS_PROJECT (PRO_NO);

prompt
prompt Creating table ESS_APPLY_WH
prompt ===========================
prompt
create table ESS_APPLY_WH
(
  wh_no               NUMBER(10) not null,
  empid               VARCHAR2(20),
  prod_no             NUMBER(10),
  start_date          DATE,
  end_date            DATE,
  work_content        VARCHAR2(2000),
  remark              VARCHAR2(2000),
  work_hour           NUMBER(10,4),
  create_date         DATE,
  created_by          VARCHAR2(20),
  update_date         DATE,
  updated_by          VARCHAR2(20),
  orderno             NUMBER(10),
  activity            NUMBER(1),
  cancel_remark       VARCHAR2(200),
  affirm_flag         NUMBER(1),
  con_remark          VARCHAR2(200),
  proj_pros_type_code VARCHAR2(20)
)
;
alter table ESS_APPLY_WH
  add constraint PK_ESS_APPLY_WH primary key (WH_NO);
alter table ESS_APPLY_WH
  add constraint FK_ESS_APPLY_WH foreign key (PROD_NO)
  references ESS_PRODUCTION_ORDER (PROD_NO) on delete cascade;

prompt
prompt Creating table ESS_APPLY_WH_TEMP
prompt ================================
prompt
create table ESS_APPLY_WH_TEMP
(
  wh_no         NUMBER(10),
  empid         VARCHAR2(20) not null,
  pro_no        NUMBER(10) not null,
  start_date    DATE not null,
  end_date      DATE,
  work_content  VARCHAR2(2000),
  remark        VARCHAR2(2000),
  work_hour     NUMBER(10,1) not null,
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  orderno       NUMBER(10),
  activity      NUMBER(1),
  cancel_remark VARCHAR2(200),
  affirm_flag   NUMBER(1),
  con_remark    VARCHAR2(200)
)
;

prompt
prompt Creating table ESS_CHECK_CODE
prompt =============================
prompt
create table ESS_CHECK_CODE
(
  username   VARCHAR2(50) not null,
  c_mail     VARCHAR2(50) not null,
  check_code VARCHAR2(40) not null,
  end_date   DATE not null,
  activity   NUMBER(1) default 1 not null,
  cpny_id    VARCHAR2(20)
)
;

prompt
prompt Creating table ESS_FAMILY
prompt =========================
prompt
create table ESS_FAMILY
(
  family_no            NUMBER(10),
  empid                VARCHAR2(20) not null,
  fam_type_code        VARCHAR2(20) not null,
  fam_name             VARCHAR2(40) not null,
  fam_name_pinyin      VARCHAR2(50),
  fam_borndate         DATE,
  fam_idcard           VARCHAR2(30),
  fam_educ_code        VARCHAR2(20),
  fam_occup_code       VARCHAR2(20),
  fam_nationality_code VARCHAR2(20),
  fam_home_addr        VARCHAR2(100),
  fam_phone            VARCHAR2(20),
  create_date          DATE,
  created_by           VARCHAR2(20),
  update_date          DATE,
  updated_by           VARCHAR2(20),
  orderno              NUMBER(10),
  activity             NUMBER(1),
  fam_degree           VARCHAR2(40),
  fam_company_name     VARCHAR2(200)
)
;

prompt
prompt Creating table ESS_HEALTH
prompt =========================
prompt
create table ESS_HEALTH
(
  health_no          NUMBER(10),
  empid              VARCHAR2(20) not null,
  height             VARCHAR2(10),
  weight             VARCHAR2(10),
  blood_type_code    VARCHAR2(20),
  l_eye_sight        VARCHAR2(10),
  r_eye_sight        VARCHAR2(10),
  rh                 VARCHAR2(10),
  color_blind        VARCHAR2(10),
  physical_test_date DATE not null,
  create_date        DATE,
  created_by         VARCHAR2(20),
  update_date        DATE,
  updated_by         VARCHAR2(20),
  orderno            NUMBER(10),
  activity           NUMBER(1),
  content            VARCHAR2(200)
)
;

prompt
prompt Creating table ESS_LANGUAGE
prompt ===========================
prompt
create table ESS_LANGUAGE
(
  language_no             NUMBER(10),
  language_type_code      VARCHAR2(20) not null,
  exam_name_code          VARCHAR2(20) not null,
  empid                   VARCHAR2(20) not null,
  language_level_code     VARCHAR2(20) not null,
  mark                    VARCHAR2(10),
  date_obtained           DATE,
  create_date             DATE,
  created_by              VARCHAR2(20),
  update_date             DATE,
  updated_by              VARCHAR2(20),
  orderno                 NUMBER(10),
  activity                NUMBER(1),
  qualification_institute VARCHAR2(100)
)
;

prompt
prompt Creating table ESS_LEAVE_PARAMETER
prompt ==================================
prompt
create table ESS_LEAVE_PARAMETER
(
  parameter_no    NUMBER not null,
  parameter_id    VARCHAR2(10),
  leave_type_code VARCHAR2(20) not null,
  leave_length_s  NUMBER(5,2) not null,
  leave_length_e  NUMBER(5,2) not null,
  affirm_level    NUMBER(1) not null,
  post_id         VARCHAR2(20),
  deptid          VARCHAR2(20),
  remarks         VARCHAR2(200),
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  orderno         NUMBER(10),
  activity        NUMBER(1) not null,
  cpny_id         VARCHAR2(20) not null
)
;
comment on table ESS_LEAVE_PARAMETER
  is '�ݼٲ���';
alter table ESS_LEAVE_PARAMETER
  add constraint PK_ESS_LEAVE_PARAMETER primary key (PARAMETER_NO);
alter table ESS_LEAVE_PARAMETER
  add constraint UK_ESS_LEAVE_PARAMETER unique (LEAVE_TYPE_CODE, LEAVE_LENGTH_S, LEAVE_LENGTH_E, POST_ID, DEPTID, CPNY_ID);

prompt
prompt Creating table ESS_MILITARY_SERVICE
prompt ===================================
prompt
create table ESS_MILITARY_SERVICE
(
  military_no         NUMBER(10),
  empid               VARCHAR2(20) not null,
  military_status     NUMBER(1),
  military_type_code  VARCHAR2(20),
  military_level_code VARCHAR2(20),
  military_area_code  VARCHAR2(20),
  start_date          DATE not null,
  end_date            DATE,
  create_date         DATE,
  created_by          VARCHAR2(20),
  update_date         DATE,
  updated_by          VARCHAR2(20),
  orderno             NUMBER(10),
  activity            NUMBER(1)
)
;

prompt
prompt Creating table ESS_OT_PARAMETER
prompt ===============================
prompt
create table ESS_OT_PARAMETER
(
  parameter_no NUMBER not null,
  parameter_id VARCHAR2(10),
  ot_type_code VARCHAR2(20) not null,
  ot_length_s  NUMBER(5,2) not null,
  ot_length_e  NUMBER(5,2) not null,
  affirm_level NUMBER(1) not null,
  post_id      VARCHAR2(20),
  deptid       VARCHAR2(20),
  remarks      VARCHAR2(200),
  create_date  DATE,
  created_by   VARCHAR2(20),
  update_date  DATE,
  updated_by   VARCHAR2(20),
  orderno      NUMBER(10),
  activity     NUMBER(1) not null,
  cpny_id      VARCHAR2(20) not null
)
;
comment on table ESS_OT_PARAMETER
  is '�ݼٲ���';
alter table ESS_OT_PARAMETER
  add constraint PK_ESS_OT_PARAMETER primary key (PARAMETER_NO);
alter table ESS_OT_PARAMETER
  add constraint UK_ESS_OT_PARAMETER unique (OT_TYPE_CODE, OT_LENGTH_S, OT_LENGTH_E, POST_ID, DEPTID, CPNY_ID);

prompt
prompt Creating table ESS_PERSONAL_INFO
prompt ================================
prompt
create table ESS_PERSONAL_INFO
(
  empid                 VARCHAR2(20) not null,
  create_date           DATE,
  created_by            VARCHAR2(20),
  update_date           DATE,
  updated_by            VARCHAR2(20),
  activity              NUMBER(1),
  affirm_flag           NUMBER(1),
  degree_code           VARCHAR2(20),
  edu_his_code          VARCHAR2(20),
  major_code            VARCHAR2(20),
  gender_code           VARCHAR2(20),
  birthday              DATE,
  religion_code         VARCHAR2(20),
  nation_code           VARCHAR2(20),
  nationality_code      VARCHAR2(20),
  bornplace_code        VARCHAR2(20),
  polity_code           VARCHAR2(20),
  membership            VARCHAR2(20),
  marital_status_code   VARCHAR2(20),
  wedding_date          DATE,
  idcard_type_code      VARCHAR2(20),
  idcard_no             VARCHAR2(30),
  idcard_province       VARCHAR2(20),
  idcard_city           VARCHAR2(20),
  idcard_area           VARCHAR2(20),
  idcard_address        VARCHAR2(200),
  home_province         VARCHAR2(20),
  home_city             VARCHAR2(20),
  home_area             VARCHAR2(20),
  home_address          VARCHAR2(200),
  idcard_postalcode     VARCHAR2(10),
  home_postalcode       VARCHAR2(10),
  p_email               VARCHAR2(50),
  c_email               VARCHAR2(50),
  office_phone          VARCHAR2(40),
  home_phone            VARCHAR2(40),
  cellphone             VARCHAR2(40),
  fax                   VARCHAR2(20),
  file_relation_code    VARCHAR2(20),
  file_relation_address VARCHAR2(50),
  workage               NUMBER default 0,
  photopath             VARCHAR2(100),
  ssn                   VARCHAR2(20),
  hafn                  VARCHAR2(20),
  shift_code            VARCHAR2(20),
  supplier_code         VARCHAR2(20),
  cancel_remark         VARCHAR2(200),
  remark                VARCHAR2(200)
)
;
comment on table ESS_PERSONAL_INFO
  is 'Ա��������Ϣ��';
comment on column ESS_PERSONAL_INFO.degree_code
  is 'ѧλ';
comment on column ESS_PERSONAL_INFO.edu_his_code
  is 'ѧ��';
comment on column ESS_PERSONAL_INFO.major_code
  is 'רҵ';
comment on column ESS_PERSONAL_INFO.gender_code
  is '�Ա�';
comment on column ESS_PERSONAL_INFO.birthday
  is '����';
comment on column ESS_PERSONAL_INFO.religion_code
  is '�ڽ�����';
comment on column ESS_PERSONAL_INFO.nation_code
  is '����';
comment on column ESS_PERSONAL_INFO.nationality_code
  is '����';
comment on column ESS_PERSONAL_INFO.bornplace_code
  is '����';
comment on column ESS_PERSONAL_INFO.polity_code
  is '������ò';
comment on column ESS_PERSONAL_INFO.membership
  is '�����Ա';
comment on column ESS_PERSONAL_INFO.marital_status_code
  is '����״��';
comment on column ESS_PERSONAL_INFO.wedding_date
  is '�������';
comment on column ESS_PERSONAL_INFO.idcard_type_code
  is '��������';
comment on column ESS_PERSONAL_INFO.idcard_no
  is '���֤��';
comment on column ESS_PERSONAL_INFO.idcard_province
  is '���֤��ַ';
comment on column ESS_PERSONAL_INFO.idcard_city
  is '���֤��ַ';
comment on column ESS_PERSONAL_INFO.idcard_area
  is '���֤��ַ';
comment on column ESS_PERSONAL_INFO.idcard_address
  is '���֤��ַ';
comment on column ESS_PERSONAL_INFO.home_province
  is '��ͥ��ַ';
comment on column ESS_PERSONAL_INFO.home_city
  is '��ͥ��ַ';
comment on column ESS_PERSONAL_INFO.home_area
  is '��ͥ��ַ';
comment on column ESS_PERSONAL_INFO.home_address
  is '��ͥ��ַ';
comment on column ESS_PERSONAL_INFO.idcard_postalcode
  is '�ʱ�';
comment on column ESS_PERSONAL_INFO.home_postalcode
  is '�ʱ�';
comment on column ESS_PERSONAL_INFO.p_email
  is '��������';
comment on column ESS_PERSONAL_INFO.c_email
  is '��˾����';
comment on column ESS_PERSONAL_INFO.office_phone
  is '�칫�ҵ绰';
comment on column ESS_PERSONAL_INFO.home_phone
  is '��ͥ�绰/�̶��绰';
comment on column ESS_PERSONAL_INFO.cellphone
  is '�ƶ��绰';
comment on column ESS_PERSONAL_INFO.fax
  is '����';
comment on column ESS_PERSONAL_INFO.file_relation_code
  is '������ϵ';
comment on column ESS_PERSONAL_INFO.file_relation_address
  is '������ַ';
comment on column ESS_PERSONAL_INFO.workage
  is '����(��)';
alter table ESS_PERSONAL_INFO
  add constraint PK_ESS_PERSONAL_INFO primary key (EMPID);

prompt
prompt Creating table ESS_PROJECT_EMP
prompt ==============================
prompt
create table ESS_PROJECT_EMP
(
  pro_no              NUMBER(10) not null,
  empid               VARCHAR2(20),
  start_date          DATE not null,
  end_date            DATE not null,
  remark              VARCHAR2(200),
  create_date         DATE,
  created_by          VARCHAR2(20),
  update_date         DATE,
  updated_by          VARCHAR2(20),
  orderno             NUMBER(10),
  activity            NUMBER(1),
  quantity            NUMBER(10,4) default 0,
  proj_pros_type_code VARCHAR2(20) not null
)
;
alter table ESS_PROJECT_EMP
  add constraint PK_ESS_PROJECT_EMP_01 primary key (PRO_NO, START_DATE, END_DATE, PROJ_PROS_TYPE_CODE);
alter table ESS_PROJECT_EMP
  add constraint FK_ESS_PROJECT_EMP_02 foreign key (PRO_NO)
  references ESS_PROJECT (PRO_NO) on delete cascade;

prompt
prompt Creating table ESS_QUALIFICATION
prompt ================================
prompt
create table ESS_QUALIFICATION
(
  qual_no          NUMBER(10),
  qual_name_code   VARCHAR2(20) not null,
  qualification_no VARCHAR2(30),
  empid            VARCHAR2(20) not null,
  grade_obtained   VARCHAR2(50),
  mark             VARCHAR2(10),
  qual_location    VARCHAR2(100),
  start_qual_date  DATE,
  end_qual_date    DATE,
  create_date      DATE,
  created_by       VARCHAR2(20),
  update_date      DATE,
  updated_by       VARCHAR2(20),
  orderno          NUMBER(10),
  activity         NUMBER(1),
  qual_institute   VARCHAR2(100)
)
;

prompt
prompt Creating table ETN_CLASS_TABLE
prompt ==============================
prompt
create table ETN_CLASS_TABLE
(
  plan_code  VARCHAR2(30) not null,
  class_code VARCHAR2(30) not null,
  class_name VARCHAR2(50)
)
;

prompt
prompt Creating table ETN_EDU_COMPANY
prompt ==============================
prompt
create table ETN_EDU_COMPANY
(
  seq_company  NUMBER not null,
  company_name VARCHAR2(50),
  con_man      VARCHAR2(50),
  address      VARCHAR2(50),
  telephone    VARCHAR2(50),
  fax          VARCHAR2(50),
  http_address VARCHAR2(50),
  class_name   VARCHAR2(100),
  teacher      VARCHAR2(100),
  strength     VARCHAR2(100),
  content      VARCHAR2(100),
  description  VARCHAR2(500)
)
;

prompt
prompt Creating table ETN_END_TEACHER_SATISFY
prompt ======================================
prompt
create table ETN_END_TEACHER_SATISFY
(
  etn_plan_no   NUMBER,
  teacher_no    NUMBER,
  satisfy_score NUMBER(5,1)
)
;

prompt
prompt Creating table ETN_FACT_PLAN
prompt ============================
prompt
create table ETN_FACT_PLAN
(
  seq_etn_plan        NUMBER,
  empid               VARCHAR2(30),
  satisfact_rate      VARCHAR2(50),
  exam_score          NUMBER(5,1),
  makeup_score        NUMBER(5,1),
  appraise_result     VARCHAR2(50),
  content             VARCHAR2(30),
  attitude_score      NUMBER(5,1),
  attitude_result     NUMBER(5,1),
  empname             VARCHAR2(30),
  exam_score_a        NUMBER(5,1),
  exam_score_b        NUMBER(5,1),
  exam_score_c        NUMBER(5,1),
  exam_score_d        NUMBER(5,1),
  makeup_score_a      NUMBER(5,1),
  makeup_score_b      NUMBER(5,1),
  makeup_score_c      NUMBER(5,1),
  makeup_score_d      NUMBER(5,1),
  attitude_score_a    NUMBER(5,1),
  attitude_score_b    NUMBER(5,1),
  documentpath        VARCHAR2(150),
  etn_time            NUMBER(5,1),
  etn_post_grade_code VARCHAR2(50)
)
;
comment on column ETN_FACT_PLAN.satisfact_rate
  is '�ɼ��ȼ�';
comment on column ETN_FACT_PLAN.exam_score
  is '���۳ɼ�';
comment on column ETN_FACT_PLAN.makeup_score
  is '���۳ɼ�(����������)';
comment on column ETN_FACT_PLAN.appraise_result
  is '�����ܳɼ�';
comment on column ETN_FACT_PLAN.attitude_score
  is '��ɼ�';
comment on column ETN_FACT_PLAN.documentpath
  is '������·��';
comment on column ETN_FACT_PLAN.etn_time
  is '����ѧʱ';

prompt
prompt Creating table ETN_FEE
prompt ======================
prompt
create table ETN_FEE
(
  etn_plan_no    NUMBER,
  fee_teach_text NUMBER(15,2),
  fee_ground     NUMBER(15,2),
  fee_eatting    NUMBER(15,2),
  fee_quarter    NUMBER(15,2),
  fee_trrafic    NUMBER(15,2),
  fee_passport   NUMBER(15,2),
  fee_visa       NUMBER(15,2),
  fee_insure     NUMBER(15,2),
  fee_living     NUMBER(15,2),
  fee_other      NUMBER(15,2),
  exploitation   NUMBER(15,2)
)
;

prompt
prompt Creating table ETN_HISTORY
prompt ==========================
prompt
create table ETN_HISTORY
(
  etn_emp_id     VARCHAR2(20) not null,
  etn_type       VARCHAR2(100),
  etn_item       VARCHAR2(100),
  etn_project    VARCHAR2(100),
  etn_mode       VARCHAR2(100),
  etn_time       VARCHAR2(100),
  etn_start_date DATE,
  etn_end_date   DATE,
  etn_mark       VARCHAR2(100),
  etn_grade      VARCHAR2(100)
)
;
comment on column ETN_HISTORY.etn_type
  is '��������';
comment on column ETN_HISTORY.etn_item
  is '������Ŀ';
comment on column ETN_HISTORY.etn_project
  is '��������';
comment on column ETN_HISTORY.etn_mode
  is '������ʽ';
comment on column ETN_HISTORY.etn_time
  is '����ʱ��';
comment on column ETN_HISTORY.etn_start_date
  is '������ʼ����';
comment on column ETN_HISTORY.etn_end_date
  is '������������';
comment on column ETN_HISTORY.etn_mark
  is '�ۺϳɼ�';
comment on column ETN_HISTORY.etn_grade
  is '���˵ȼ�';

prompt
prompt Creating table ETN_LETTER
prompt =========================
prompt
create table ETN_LETTER
(
  etn_letter_seq  NUMBER not null,
  etn_empid       VARCHAR2(50),
  letter_type     VARCHAR2(50),
  letter_number   VARCHAR2(50),
  letter_date     DATE,
  first_date      DATE,
  second_date     DATE,
  period_validity VARCHAR2(50),
  letter_dept     VARCHAR2(50),
  content         VARCHAR2(100),
  name            VARCHAR2(100),
  etn_plan_no     NUMBER
)
;
comment on column ETN_LETTER.etn_empid
  is '����';
comment on column ETN_LETTER.letter_type
  is '֤������(code)';
comment on column ETN_LETTER.letter_number
  is '֤���';
comment on column ETN_LETTER.letter_date
  is 'ȡ֤����';
comment on column ETN_LETTER.period_validity
  is '��Ч��';
comment on column ETN_LETTER.letter_dept
  is '��֤��';
comment on column ETN_LETTER.content
  is '�ȼ�';

prompt
prompt Creating table ETN_OPSCORE
prompt ==========================
prompt
create table ETN_OPSCORE
(
  seq_no          NUMBER not null,
  plan_no         NUMBER not null,
  pno             NUMBER not null,
  exam_score      NUMBER(5,1),
  makeup_score    NUMBER(5,1),
  appraise_result VARCHAR2(20),
  content         VARCHAR2(20),
  contentname     VARCHAR2(20),
  attitude_score  NUMBER(5,1)
)
;

prompt
prompt Creating table ETN_PLAN
prompt =======================
prompt
create table ETN_PLAN
(
  seq_etn_plan          NUMBER,
  plan_edu_item_code    NUMBER(15,2),
  plan_class_type       NUMBER(15,2),
  plan_edu_type_code    VARCHAR2(30),
  plan_edu_place        VARCHAR2(40),
  plan_start_date       DATE,
  plan_end_date         DATE,
  plan_edu_time         NUMBER,
  plan_appraise_content VARCHAR2(200),
  plan_code             VARCHAR2(50),
  year_plan_no          NUMBER,
  plan_edu_time_danwei  NUMBER(1) default 0,
  plan_edu_sort_code    VARCHAR2(20),
  plan_sort_code        VARCHAR2(20),
  etnformat             VARCHAR2(20),
  plan_perrior_count    VARCHAR2(50),
  etn_year_no           NUMBER
)
;
comment on column ETN_PLAN.seq_etn_plan
  is '�ƻ����';
comment on column ETN_PLAN.plan_edu_item_code
  is '������Ŀ���';
comment on column ETN_PLAN.plan_class_type
  is '�γ�����';
comment on column ETN_PLAN.plan_edu_type_code
  is '�γ����ͱ��';
comment on column ETN_PLAN.plan_edu_place
  is '��������';
comment on column ETN_PLAN.plan_start_date
  is 'ʵʩ��ʼ����';
comment on column ETN_PLAN.plan_end_date
  is 'ʵʩ��������';
comment on column ETN_PLAN.plan_edu_time
  is 'ʵʩ��ʱ';
comment on column ETN_PLAN.plan_appraise_content
  is '��������';
comment on column ETN_PLAN.plan_code
  is '�γ����ͱ��';
comment on column ETN_PLAN.year_plan_no
  is '��ȼƻ����';
comment on column ETN_PLAN.plan_edu_time_danwei
  is '����ʱ�䵥λ';
comment on column ETN_PLAN.plan_edu_sort_code
  is '����������';
comment on column ETN_PLAN.plan_sort_code
  is '��������';
comment on column ETN_PLAN.etnformat
  is '������ʽ';
comment on column ETN_PLAN.plan_perrior_count
  is '�����ڴ�';
comment on column ETN_PLAN.etn_year_no
  is '��ȼƻ��ı��';

prompt
prompt Creating table ETN_PLAN1
prompt ========================
prompt
create table ETN_PLAN1
(
  seq_etn_plan          NUMBER not null,
  plan_edu_item_code    VARCHAR2(50),
  plan_class_type       VARCHAR2(50),
  plan_edu_type_code    VARCHAR2(30),
  plan_edu_place        VARCHAR2(40),
  plan_start_date       DATE,
  plan_end_date         DATE,
  plan_edu_time         NUMBER,
  plan_appraise_content VARCHAR2(200),
  plan_code             VARCHAR2(50),
  year_plan_no          NUMBER,
  plan_edu_time_danwei  NUMBER(1)
)
;
alter table ETN_PLAN1
  add constraint PK_ETN_PLAN1 primary key (SEQ_ETN_PLAN);

prompt
prompt Creating table ETN_PLAN_GROUP
prompt =============================
prompt
create table ETN_PLAN_GROUP
(
  seq_etn_plan NUMBER,
  empid        VARCHAR2(30)
)
;

prompt
prompt Creating table ETN_PLAN_KINDS
prompt =============================
prompt
create table ETN_PLAN_KINDS
(
  seq_plan_kinds       NUMBER not null,
  plan_edu_item_code   VARCHAR2(30),
  plan_class_type_code VARCHAR2(500),
  plan_code            VARCHAR2(30),
  etn_fit_group        VARCHAR2(500),
  plan_sort_code       VARCHAR2(500),
  plan_edu_sort_code   VARCHAR2(500)
)
;
comment on column ETN_PLAN_KINDS.seq_plan_kinds
  is '�����';
comment on column ETN_PLAN_KINDS.plan_edu_item_code
  is '������Ŀ';
comment on column ETN_PLAN_KINDS.plan_class_type_code
  is '��������';
comment on column ETN_PLAN_KINDS.plan_code
  is '������';
comment on column ETN_PLAN_KINDS.etn_fit_group
  is '���ö���';
comment on column ETN_PLAN_KINDS.plan_sort_code
  is '��������';
alter table ETN_PLAN_KINDS
  add constraint PK_ETN_PLAN_KINDS primary key (SEQ_PLAN_KINDS);

prompt
prompt Creating table ETN_PLAN_TEACHER
prompt ===============================
prompt
create table ETN_PLAN_TEACHER
(
  etn_plan_no NUMBER,
  teacher_no  NUMBER
)
;

prompt
prompt Creating table ETN_PROTOCOL
prompt ===========================
prompt
create table ETN_PROTOCOL
(
  seq_protocol_etn       NUMBER not null,
  protocol_code          VARCHAR2(30),
  protocol_name          VARCHAR2(30),
  protocol_personal_name VARCHAR2(30),
  protocol_start_date    DATE,
  protocol_end_date      DATE,
  protocol_term          NUMBER,
  protocol_content       VARCHAR2(200),
  protocol_empid         VARCHAR2(30),
  yearplan_no            VARCHAR2(30),
  fell_back_fee          NUMBER,
  all_fell_back_fee      NUMBER,
  protocol_date          DATE,
  protocol_cut_date      DATE
)
;
alter table ETN_PROTOCOL
  add constraint PK_ETN_PROTOCOL primary key (SEQ_PROTOCOL_ETN);

prompt
prompt Creating table ETN_REFERENCE
prompt ============================
prompt
create table ETN_REFERENCE
(
  reference_seq NUMBER not null,
  code          VARCHAR2(50),
  names         VARCHAR2(100),
  path          VARCHAR2(100)
)
;

prompt
prompt Creating table ETN_RESULT_TABLE
prompt ===============================
prompt
create table ETN_RESULT_TABLE
(
  result_seq          NUMBER not null,
  etn_plan_no         NUMBER,
  empid               VARCHAR2(50),
  chinesename         VARCHAR2(50),
  department          VARCHAR2(50),
  station             VARCHAR2(50),
  etn_plan_type_code  VARCHAR2(100),
  etn_teacher         VARCHAR2(100),
  etn_start_date      DATE,
  edu_dept            VARCHAR2(100),
  edu_place           VARCHAR2(100),
  content             VARCHAR2(100),
  satisfact_rate      VARCHAR2(50),
  exam_score          NUMBER(5,1),
  makeup_score        NUMBER(5,1),
  appraise_result     VARCHAR2(50),
  attitude_score      NUMBER(5,1),
  classtime           VARCHAR2(10),
  exam_score_a        NUMBER(5,1),
  exam_score_b        NUMBER(5,1),
  exam_score_c        NUMBER(5,1),
  exam_score_d        NUMBER(5,1),
  makeup_score_a      NUMBER(5,1),
  makeup_score_b      NUMBER(5,1),
  makeup_score_c      NUMBER(5,1),
  makeup_score_d      NUMBER(5,1),
  attitude_score_a    NUMBER(5,1),
  attitude_score_b    NUMBER(5,1),
  documentpath        VARCHAR2(150),
  etn_time            NUMBER(5,1),
  etn_post_grade_code VARCHAR2(50)
)
;
comment on column ETN_RESULT_TABLE.edu_dept
  is '��ѵ����';
comment on column ETN_RESULT_TABLE.content
  is '��ע';
comment on column ETN_RESULT_TABLE.classtime
  is '��ʱ��';

prompt
prompt Creating table ETN_STANDARD
prompt ===========================
prompt
create table ETN_STANDARD
(
  seq_standard        NUMBER,
  etn_plan_no         NUMBER,
  exam_score_rate     NUMBER(5,2),
  attitude_score_rate NUMBER(5,2),
  etn_sl              NUMBER(5,2),
  etn_sh              NUMBER(5,2),
  etn_al              NUMBER(5,2),
  etn_ah              NUMBER(5,2),
  etn_bl              NUMBER(5,2),
  etn_bh              NUMBER(5,2),
  etn_cl              NUMBER(5,2),
  etn_ch              NUMBER(5,2),
  etn_dl              NUMBER(5,2),
  etn_dh              NUMBER(5,2)
)
;

prompt
prompt Creating table ETN_SYCODE
prompt =========================
prompt
create table ETN_SYCODE
(
  code_no     NUMBER(10) not null,
  code_id     VARCHAR2(20) not null,
  code_name   VARCHAR2(50) not null,
  description VARCHAR2(200),
  parent_code VARCHAR2(50),
  depth       NUMBER(10),
  create_date DATE,
  created_by  VARCHAR2(20),
  update_date DATE,
  updated_by  VARCHAR2(20),
  orderno     NUMBER(10),
  activity    NUMBER(1)
)
;

prompt
prompt Creating table ETN_TEACHER
prompt ==========================
prompt
create table ETN_TEACHER
(
  seq_etn_teacher        NUMBER not null,
  teacher_name           VARCHAR2(30),
  teacher_belong         VARCHAR2(100),
  teacher_sex            VARCHAR2(30),
  teacher_enable_class   VARCHAR2(500),
  out_teacher_content    VARCHAR2(500),
  out_teacher_connection VARCHAR2(500),
  out_teacher_fee        NUMBER,
  teacher_flag           VARCHAR2(30),
  teacher_post           VARCHAR2(500),
  teacher_techang        VARCHAR2(50),
  out_teacher_address    VARCHAR2(500)
)
;
alter table ETN_TEACHER
  add constraint PK_ETN_TEACHER primary key (SEQ_ETN_TEACHER);

prompt
prompt Creating table ETN_TEACHER_FACT_ACTIVITY
prompt ========================================
prompt
create table ETN_TEACHER_FACT_ACTIVITY
(
  teacher_no            NUMBER,
  edu_start_date        DATE,
  edu_end_date          DATE,
  etn_edu_time          NUMBER,
  etn_satisfact_score   NUMBER,
  etn_manage_department VARCHAR2(100)
)
;

prompt
prompt Creating table ETN_TEACHER_FEE
prompt ==============================
prompt
create table ETN_TEACHER_FEE
(
  etn_plan_no      NUMBER,
  teacher_no       NUMBER,
  teacher_name     VARCHAR2(30),
  teacher_edu_time NUMBER,
  teacher_fee_hour NUMBER
)
;

prompt
prompt Creating table ETN_TEACHER_SATISFACT
prompt ====================================
prompt
create table ETN_TEACHER_SATISFACT
(
  etn_plan_no      NUMBER,
  teacher_no       NUMBER,
  score            NUMBER,
  class_name_group VARCHAR2(200),
  edu_department   VARCHAR2(100),
  remark           VARCHAR2(200)
)
;
comment on column ETN_TEACHER_SATISFACT.etn_plan_no
  is '�����ڴ�(etn_plan.seq_etn_plan)';
comment on column ETN_TEACHER_SATISFACT.teacher_no
  is '������';
comment on column ETN_TEACHER_SATISFACT.score
  is '��ʦ����';
comment on column ETN_TEACHER_SATISFACT.class_name_group
  is '���ڿγ�';
comment on column ETN_TEACHER_SATISFACT.edu_department
  is '�������ܲ�������';
comment on column ETN_TEACHER_SATISFACT.remark
  is '��ע';

prompt
prompt Creating table ETN_TEACHINGMATERIAL_MANAGE
prompt ==========================================
prompt
create table ETN_TEACHINGMATERIAL_MANAGE
(
  seq_teachtext_ma NUMBER not null,
  plan_code        VARCHAR2(50),
  class_name       VARCHAR2(50),
  class_edition    VARCHAR2(50),
  class_brief      VARCHAR2(100),
  modify_date      DATE,
  modify_person    VARCHAR2(30),
  book_name        VARCHAR2(50)
)
;
alter table ETN_TEACHINGMATERIAL_MANAGE
  add constraint PK_ETN_TEACHINGMATERIAL_MANAGE primary key (SEQ_TEACHTEXT_MA);

prompt
prompt Creating table ETN_WHOLE_RESULT
prompt ===============================
prompt
create table ETN_WHOLE_RESULT
(
  etn_plan_no         NUMBER,
  eligibility_rate    NUMBER,
  makeup_success_rate NUMBER,
  count_fell_back     NUMBER,
  connt_award         NUMBER(5)
)
;

prompt
prompt Creating table ETN_WHOLE_SATISFACTION
prompt =====================================
prompt
create table ETN_WHOLE_SATISFACTION
(
  etn_plan_no             NUMBER not null,
  whole_satisfaction      NUMBER(5,2),
  edu_term_satisfaction   NUMBER(5,2),
  edu_place_satisfaction  NUMBER(5,2),
  edu_methord_satisfact   NUMBER(5,2),
  edu_teacher_total_satis NUMBER(5,2),
  edu_class_satisfaction  NUMBER(5,2),
  edu_remark              VARCHAR2(200)
)
;
alter table ETN_WHOLE_SATISFACTION
  add constraint PK_ETN_WHOLE_SATISFACTION primary key (ETN_PLAN_NO);

prompt
prompt Creating table ETN_YEARPLAN_FIT_DEPT
prompt ====================================
prompt
create table ETN_YEARPLAN_FIT_DEPT
(
  plan_code         VARCHAR2(30),
  fit_department_id VARCHAR2(50)
)
;

prompt
prompt Creating table ETN_YEAR_PLAN
prompt ============================
prompt
create table ETN_YEAR_PLAN
(
  seq_year_plan        NUMBER not null,
  plan_code            VARCHAR2(30),
  plan_edu_item_code   VARCHAR2(30),
  plan_class_type_code VARCHAR2(500),
  plan_fit_group       VARCHAR2(30),
  plan_edu_time        NUMBER(5,1),
  plan_perrior_count   VARCHAR2(50),
  plan_start_date      DATE,
  plan_end_date        DATE,
  plan_edu_type_code   VARCHAR2(30),
  plan_intend_fee      NUMBER(15,2),
  plan_color           VARCHAR2(30),
  plan_flag            VARCHAR2(30),
  manage_department    VARCHAR2(500),
  promotion_needed     VARCHAR2(30),
  type_edu_result      VARCHAR2(30),
  plan_edu_time_danwei NUMBER(1) default 0,
  plan_edu_remark      VARCHAR2(20),
  plan_edu_emp_num     VARCHAR2(50),
  plan_edu_sort_code   VARCHAR2(20),
  plan_sort_code       VARCHAR2(20),
  etnformat            VARCHAR2(20),
  class_name           VARCHAR2(1000),
  quantity             NUMBER,
  edu_type             VARCHAR2(50),
  plan_man_count       NUMBER,
  shiyongduixiang      VARCHAR2(100),
  submityn             NUMBER
)
;
comment on column ETN_YEAR_PLAN.seq_year_plan
  is '�ƻ����';
comment on column ETN_YEAR_PLAN.plan_code
  is '�γ�����';
comment on column ETN_YEAR_PLAN.plan_edu_item_code
  is '��Ŀ���';
comment on column ETN_YEAR_PLAN.plan_class_type_code
  is '�γ����ͱ��';
comment on column ETN_YEAR_PLAN.plan_fit_group
  is '���ö���';
comment on column ETN_YEAR_PLAN.plan_edu_time
  is '����ʱ��';
comment on column ETN_YEAR_PLAN.plan_perrior_count
  is '�����ڴ�';
comment on column ETN_YEAR_PLAN.plan_start_date
  is '��ʼʱ��';
comment on column ETN_YEAR_PLAN.plan_end_date
  is '����ʱ��';
comment on column ETN_YEAR_PLAN.plan_edu_type_code
  is '������ʽ';
comment on column ETN_YEAR_PLAN.plan_intend_fee
  is 'Ԥ�����';
comment on column ETN_YEAR_PLAN.plan_color
  is '��ɫ';
comment on column ETN_YEAR_PLAN.plan_flag
  is '�Ƿ����';
comment on column ETN_YEAR_PLAN.manage_department
  is '���ܲ���';
comment on column ETN_YEAR_PLAN.promotion_needed
  is 'ְ������';
comment on column ETN_YEAR_PLAN.type_edu_result
  is '�ƻ���ʱ';
comment on column ETN_YEAR_PLAN.plan_edu_time_danwei
  is '�����¼���λ';
comment on column ETN_YEAR_PLAN.plan_edu_remark
  is 'ÿ�ܼ�Ъ��������';
comment on column ETN_YEAR_PLAN.plan_edu_sort_code
  is '����������';
comment on column ETN_YEAR_PLAN.plan_sort_code
  is '��������';
comment on column ETN_YEAR_PLAN.etnformat
  is '������ʽ';
comment on column ETN_YEAR_PLAN.class_name
  is '�����γ�����';
comment on column ETN_YEAR_PLAN.quantity
  is '��������';
comment on column ETN_YEAR_PLAN.edu_type
  is '��������';
comment on column ETN_YEAR_PLAN.plan_man_count
  is '�ƻ���ʱ';
comment on column ETN_YEAR_PLAN.shiyongduixiang
  is '���ö���';
comment on column ETN_YEAR_PLAN.submityn
  is '�Ƿ��ύ������';
alter table ETN_YEAR_PLAN
  add constraint PK_ETN_YEAR_PLAN primary key (SEQ_YEAR_PLAN);

prompt
prompt Creating table ETN_YEAR_PLAN_STATISTIC
prompt ======================================
prompt
create table ETN_YEAR_PLAN_STATISTIC
(
  year_plan_year    DATE,
  total_edu_time    NUMBER,
  total_edu_perrior NUMBER,
  total_edu_fee     NUMBER
)
;

prompt
prompt Creating table EVA_ADD_SUBTRACTION
prompt ==================================
prompt
create table EVA_ADD_SUBTRACTION
(
  evs_add_subtraction_seq VARCHAR2(20) not null,
  ev_item_id              VARCHAR2(20),
  ev_item_process_id      VARCHAR2(20),
  ev_emp_id               VARCHAR2(20),
  ev_item_add_subtraction FLOAT,
  ev_period_id            VARCHAR2(20),
  ev_item_add_sub_idea    VARCHAR2(400)
)
;
comment on column EVA_ADD_SUBTRACTION.ev_item_add_subtraction
  is '�Ӽ���';
comment on column EVA_ADD_SUBTRACTION.ev_item_add_sub_idea
  is '�Ӽ������';
alter table EVA_ADD_SUBTRACTION
  add constraint EVS_ADD_SUBTRACTION_PK primary key (EVS_ADD_SUBTRACTION_SEQ);

prompt
prompt Creating table EVA_ADD_SUB_NORM
prompt ===============================
prompt
create table EVA_ADD_SUB_NORM
(
  seq_evs_add_sub_norm NUMBER not null,
  evs_norm_item_id     VARCHAR2(20),
  evs_norm_mark        FLOAT,
  evs_norm_operation   VARCHAR2(20)
)
;
comment on column EVA_ADD_SUB_NORM.seq_evs_add_sub_norm
  is 'SEQ';
comment on column EVA_ADD_SUB_NORM.evs_norm_item_id
  is '�Ӽ�������ĿID';
comment on column EVA_ADD_SUB_NORM.evs_norm_mark
  is '��ֵ';
comment on column EVA_ADD_SUB_NORM.evs_norm_operation
  is '������';
alter table EVA_ADD_SUB_NORM
  add constraint EVS_ADD_SUB_NORM_SEQ primary key (SEQ_EVS_ADD_SUB_NORM);

prompt
prompt Creating table EVA_PERIOD
prompt =========================
prompt
create table EVA_PERIOD
(
  ev_period_no        NUMBER(10) not null,
  ev_year             VARCHAR2(4) not null,
  ev_period_id        VARCHAR2(20) not null,
  ev_period_name      VARCHAR2(50) not null,
  ev_period_en_name   VARCHAR2(50),
  ev_start_date       DATE,
  ev_end_date         DATE,
  ev_parent_period_id VARCHAR2(20),
  ev_description      VARCHAR2(500),
  ev_remark           VARCHAR2(200),
  create_date         DATE,
  created_by          VARCHAR2(20),
  update_date         DATE,
  updated_by          VARCHAR2(20),
  time_stamp          VARCHAR2(20),
  activity            NUMBER(1) default 1 not null,
  orderno             NUMBER(10),
  cpny_id             VARCHAR2(20) not null
)
;
alter table EVA_PERIOD
  add constraint PK_EVS_PERIOD primary key (EV_PERIOD_ID);

prompt
prompt Creating table EVA_PERIOD_TYPE
prompt ==============================
prompt
create table EVA_PERIOD_TYPE
(
  ev_period_id VARCHAR2(20) not null,
  ev_type_id   VARCHAR2(20) not null,
  create_date  DATE,
  created_by   VARCHAR2(20),
  update_date  DATE,
  updated_by   VARCHAR2(20),
  time_stamp   VARCHAR2(20),
  activity     NUMBER(1) default 1,
  description  VARCHAR2(200),
  remark       VARCHAR2(200),
  ev_type_no   NUMBER(10) not null
)
;
alter table EVA_PERIOD_TYPE
  add constraint PK_EVS_PERIOD_TYPE primary key (EV_PERIOD_ID, EV_TYPE_ID);
alter table EVA_PERIOD_TYPE
  add constraint FK_EVS_PERIOD_TYPE foreign key (EV_PERIOD_ID)
  references EVA_PERIOD (EV_PERIOD_ID) on delete cascade;

prompt
prompt Creating table EVA_TYPE_ITEM
prompt ============================
prompt
create table EVA_TYPE_ITEM
(
  ev_period_id  VARCHAR2(20) not null,
  ev_type_id    VARCHAR2(20) not null,
  ev_item_id    VARCHAR2(20) not null,
  ev_item_order NUMBER not null,
  evsemptype    VARCHAR2(20),
  description   VARCHAR2(200),
  remark        VARCHAR2(200),
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  activity      NUMBER(1) not null,
  orderno       NUMBER(10),
  cpny_id       VARCHAR2(20) not null,
  ev_percentage FLOAT default 0 not null
)
;
comment on column EVA_TYPE_ITEM.evsemptype
  is '����Ⱥ��';
comment on column EVA_TYPE_ITEM.ev_percentage
  is '��Ŀռ��';
alter table EVA_TYPE_ITEM
  add constraint PK_EVS_TYPE_ITEM primary key (EV_PERIOD_ID, EV_TYPE_ID, EV_ITEM_ID);
alter table EVA_TYPE_ITEM
  add constraint FK_EVS_TYPE_ITEM_PERIOD foreign key (EV_PERIOD_ID, EV_TYPE_ID)
  references EVA_PERIOD_TYPE (EV_PERIOD_ID, EV_TYPE_ID) on delete cascade;

prompt
prompt Creating table EVA_COLUMN
prompt =========================
prompt
create table EVA_COLUMN
(
  ev_period_id VARCHAR2(20) not null,
  ev_type_id   VARCHAR2(20) not null,
  ev_item_id   VARCHAR2(20) not null,
  ev_column_id VARCHAR2(20) not null,
  column_order NUMBER
)
;
comment on column EVA_COLUMN.ev_period_id
  is '��������';
comment on column EVA_COLUMN.ev_type_id
  is '��������';
comment on column EVA_COLUMN.ev_item_id
  is '������Ŀ';
comment on column EVA_COLUMN.ev_column_id
  is '������';
comment on column EVA_COLUMN.column_order
  is '������˳��';
alter table EVA_COLUMN
  add constraint FK_EVS_COLU_REFERENCE_EVS_TYPE foreign key (EV_PERIOD_ID, EV_TYPE_ID, EV_ITEM_ID)
  references EVA_TYPE_ITEM (EV_PERIOD_ID, EV_TYPE_ID, EV_ITEM_ID)
  disable;

prompt
prompt Creating table EVA_DEPT
prompt =======================
prompt
create table EVA_DEPT
(
  ev_period_id      VARCHAR2(20) not null,
  ev_dept_id        VARCHAR2(20) not null,
  ev_dept_name      VARCHAR2(50),
  ev_dept_level     NUMBER,
  ev_parent_dept_id VARCHAR2(20),
  ev_dept_grade_id  VARCHAR2(20),
  ev_dept_norm      NUMBER,
  activity          NUMBER
)
;
comment on table EVA_DEPT
  is '���ű������ȼ����ٽ�����Ի���׼�ٷֱ�����';
alter table EVA_DEPT
  add constraint PK_EVS_DEPT primary key (EV_PERIOD_ID, EV_DEPT_ID);

prompt
prompt Creating table EVA_EMP
prompt ======================
prompt
create table EVA_EMP
(
  ev_period_id               VARCHAR2(20) not null,
  ev_emp_id                  VARCHAR2(20) not null,
  ev_emp_name                VARCHAR2(50),
  ev_dept_id                 VARCHAR2(20),
  ev_dept_name               VARCHAR2(200),
  ev_post_group_id           VARCHAR2(20),
  ev_post_group_name         VARCHAR2(200),
  ev_type_id                 VARCHAR2(20),
  ev_process_id              VARCHAR2(20),
  ev_mark                    FLOAT,
  ev_grade_id                VARCHAR2(20),
  activity                   NUMBER,
  ev_default_grade_id        VARCHAR2(20),
  ev_order                   NUMBER,
  ev_emp_cnt                 NUMBER,
  update_date                DATE,
  updated_by                 VARCHAR2(20),
  ev_achive_dept_grade_id    VARCHAR2(20),
  ev_achive_ability_grade_id VARCHAR2(20),
  ev_post_grade_id           VARCHAR2(20),
  ev_post_grade_name         VARCHAR2(50),
  ev_position_id             VARCHAR2(20),
  ev_position_name           VARCHAR2(50),
  ev_avg_mark                FLOAT,
  ev_rank                    NUMBER,
  first_cal_flag             VARCHAR2(10),
  ev_final_mark              FLOAT
)
;
comment on column EVA_EMP.ev_mark
  is '����ҵ�����۷���-��������ҵ�����۷���';
comment on column EVA_EMP.ev_grade_id
  is '����ҵ�����۵ȼ�';
comment on column EVA_EMP.ev_default_grade_id
  is 'Ĭ�ϵȼ�';
comment on column EVA_EMP.ev_order
  is '�ȼ�Ĭ�ϵ�˳��';
comment on column EVA_EMP.ev_emp_cnt
  is '�����������';
comment on column EVA_EMP.ev_achive_dept_grade_id
  is '�������۵ȼ�';
comment on column EVA_EMP.ev_post_grade_id
  is 'ְ��ID';
comment on column EVA_EMP.ev_post_grade_name
  is 'ְ��NAME';
comment on column EVA_EMP.ev_position_id
  is 'ְλID';
comment on column EVA_EMP.ev_position_name
  is 'ְλNAME';
comment on column EVA_EMP.ev_avg_mark
  is '����ƽ����';
comment on column EVA_EMP.ev_rank
  is '����,����';
comment on column EVA_EMP.first_cal_flag
  is '�Ƿ�������Ŀ��ֵ�һ�ε���';
comment on column EVA_EMP.ev_final_mark
  is '���շ���';
alter table EVA_EMP
  add constraint PK_EVS_EMP primary key (EV_PERIOD_ID, EV_EMP_ID);
alter table EVA_EMP
  add constraint FK_EVS_EMP_DEPT foreign key (EV_PERIOD_ID, EV_DEPT_ID)
  references EVA_DEPT (EV_PERIOD_ID, EV_DEPT_ID)
  disable;
alter table EVA_EMP
  add constraint FK_EVS_EMP_TYPE_PERIOD foreign key (EV_PERIOD_ID, EV_TYPE_ID)
  references EVA_PERIOD_TYPE (EV_PERIOD_ID, EV_TYPE_ID);

prompt
prompt Creating table EVA_ITEM_DETAIL
prompt ==============================
prompt
create table EVA_ITEM_DETAIL
(
  seq_ev_item_detail        NUMBER(20) not null,
  ev_period_id              VARCHAR2(20) not null,
  ev_emp_id                 VARCHAR2(20) not null,
  ev_item_id                VARCHAR2(20) not null,
  ev_detail_prop            FLOAT,
  ev_detail_order           NUMBER,
  ev_item_type              VARCHAR2(20),
  ev_item_method            VARCHAR2(20),
  ev_item_range             VARCHAR2(4000),
  ev_item_mark_value        VARCHAR2(100),
  ev_item_mark_name         VARCHAR2(100),
  seq_ev_common_item_detail NUMBER(20),
  ev_total_achive           FLOAT default 0,
  ev_mark_range             VARCHAR2(100)
)
;
comment on column EVA_ITEM_DETAIL.ev_item_type
  is '��Ŀ����';
comment on column EVA_ITEM_DETAIL.ev_item_method
  is '���۷���';
comment on column EVA_ITEM_DETAIL.ev_item_range
  is '��Ŀ��Ч��Χ';
comment on column EVA_ITEM_DETAIL.ev_item_mark_value
  is '��Ŀȡֵ��׼ ����';
comment on column EVA_ITEM_DETAIL.ev_item_mark_name
  is '��Ŀȡֵ��׼ ѡ������';
comment on column EVA_ITEM_DETAIL.seq_ev_common_item_detail
  is '������Ŀ������ĿID';
comment on column EVA_ITEM_DETAIL.ev_total_achive
  is '��ʵ��';
comment on column EVA_ITEM_DETAIL.ev_mark_range
  is '����������Ŀ�ĵ÷ַ�Χ';
alter table EVA_ITEM_DETAIL
  add constraint PK_EVS_ITEM_DETAIL primary key (SEQ_EV_ITEM_DETAIL);
alter table EVA_ITEM_DETAIL
  add constraint FK_EVS_ITEM_DETAIL_EMP foreign key (EV_PERIOD_ID, EV_EMP_ID)
  references EVA_EMP (EV_PERIOD_ID, EV_EMP_ID);

prompt
prompt Creating table EVA_COLUMN_DETAIL
prompt ================================
prompt
create table EVA_COLUMN_DETAIL
(
  seq_ev_item_detail NUMBER(20) not null,
  ev_column_detail   VARCHAR2(4000),
  ev_column_id       VARCHAR2(20) not null,
  ev_unit            VARCHAR2(20)
)
;
alter table EVA_COLUMN_DETAIL
  add constraint FK_EVS_ITEM_COLUMN_DETAIL foreign key (SEQ_EV_ITEM_DETAIL)
  references EVA_ITEM_DETAIL (SEQ_EV_ITEM_DETAIL);

prompt
prompt Creating table EVA_COLUMN_DETAIL_LZY
prompt ====================================
prompt
create table EVA_COLUMN_DETAIL_LZY
(
  seq_ev_item_detail NUMBER(20) not null,
  ev_column_detail   VARCHAR2(4000),
  ev_column_id       VARCHAR2(20) not null,
  ev_unit            VARCHAR2(20)
)
;

prompt
prompt Creating table EVA_COMMON_COLUMN_DETAIL
prompt =======================================
prompt
create table EVA_COMMON_COLUMN_DETAIL
(
  seq_ev_common_item_detail NUMBER not null,
  ev_column_detail          VARCHAR2(4000),
  ev_column_id              VARCHAR2(20) not null
)
;

prompt
prompt Creating table EVA_COMMON_ITEM_DETAIL
prompt =====================================
prompt
create table EVA_COMMON_ITEM_DETAIL
(
  seq_ev_common_item_detail NUMBER(20) not null,
  ev_period_id              VARCHAR2(20) not null,
  ev_item_id                VARCHAR2(20) not null,
  ev_detail_prop            FLOAT,
  ev_detail_order           NUMBER,
  ev_type_id                VARCHAR2(20) not null,
  ev_item_type              VARCHAR2(20),
  ev_item_method            VARCHAR2(20),
  ev_item_range             VARCHAR2(4000),
  ev_item_mark_value        VARCHAR2(100),
  ev_item_mark_name         VARCHAR2(100),
  ev_item_mark_range        VARCHAR2(100)
)
;
comment on column EVA_COMMON_ITEM_DETAIL.ev_item_type
  is '��Ŀ����';
comment on column EVA_COMMON_ITEM_DETAIL.ev_item_method
  is '���۷���';
comment on column EVA_COMMON_ITEM_DETAIL.ev_item_range
  is '��Ŀ��Ч��Χ';
comment on column EVA_COMMON_ITEM_DETAIL.ev_item_mark_value
  is '��Ŀȡֵ��׼ ����';
comment on column EVA_COMMON_ITEM_DETAIL.ev_item_mark_name
  is '��Ŀȡֵ��׼ ѡ������';
comment on column EVA_COMMON_ITEM_DETAIL.ev_item_mark_range
  is '��Ŀ��ַ�Χ';
alter table EVA_COMMON_ITEM_DETAIL
  add constraint PK_EVS_COMMON_ITEM_DETAIL primary key (SEQ_EV_COMMON_ITEM_DETAIL);

prompt
prompt Creating table EVA_DEPT_RADIO
prompt =============================
prompt
create table EVA_DEPT_RADIO
(
  ev_period_id     VARCHAR2(20) not null,
  ev_dept_id       VARCHAR2(20) not null,
  ev_dept_grade_id VARCHAR2(20) not null,
  ev_grade_id      VARCHAR2(20) not null,
  ev_grade_prop    FLOAT,
  ev_wage_radio    FLOAT
)
;
create unique index IDX_EVS_DEPT_RADIO on EVA_DEPT_RADIO (EV_DEPT_GRADE_ID, EV_GRADE_ID, EV_DEPT_ID, EV_PERIOD_ID);
alter table EVA_DEPT_RADIO
  add constraint FK_EVS_DEPT_RADIO_DEPT foreign key (EV_PERIOD_ID, EV_DEPT_ID)
  references EVA_DEPT (EV_PERIOD_ID, EV_DEPT_ID);

prompt
prompt Creating table EVA_DETAIL_MARK
prompt ==============================
prompt
create table EVA_DETAIL_MARK
(
  seq_ev_item_detail NUMBER(20) not null,
  ev_process_id      VARCHAR2(20) not null,
  ev_mark            FLOAT,
  ev_idea            VARCHAR2(2000),
  ev_prop            VARCHAR2(20)
)
;
alter table EVA_DETAIL_MARK
  add constraint PK_EVS_DETAIL_MARK primary key (SEQ_EV_ITEM_DETAIL, EV_PROCESS_ID);
alter table EVA_DETAIL_MARK
  add constraint FK_EVS_DETAIL_MARK foreign key (SEQ_EV_ITEM_DETAIL)
  references EVA_ITEM_DETAIL (SEQ_EV_ITEM_DETAIL);

prompt
prompt Creating table EVA_DETAIL_MARK_LZY
prompt ==================================
prompt
create table EVA_DETAIL_MARK_LZY
(
  seq_ev_item_detail NUMBER(20) not null,
  ev_process_id      VARCHAR2(20) not null,
  ev_mark            FLOAT,
  ev_idea            VARCHAR2(2000),
  ev_prop            VARCHAR2(20)
)
;

prompt
prompt Creating table EVA_DEVSELF
prompt ==========================
prompt
create table EVA_DEVSELF
(
  evsid       NUMBER(10) not null,
  empid       VARCHAR2(10),
  evitem      VARCHAR2(500),
  evway       VARCHAR2(500),
  evyear      VARCHAR2(50),
  checkself   VARCHAR2(500),
  ideaself    VARCHAR2(500),
  masterid    VARCHAR2(10),
  checkmaster VARCHAR2(500),
  ideamaster  VARCHAR2(500),
  evstate     NUMBER(10),
  evchild     VARCHAR2(500),
  evlevel     NUMBER(10),
  viewidea    VARCHAR2(500)
)
;

prompt
prompt Creating table EVA_EDU_NORM
prompt ===========================
prompt
create table EVA_EDU_NORM
(
  seq_evs_edu_norm NUMBER not null,
  emp_post_grade   VARCHAR2(20),
  emp_hour         NUMBER,
  emp_edu_mark     FLOAT
)
;
alter table EVA_EDU_NORM
  add constraint SEQ_EVS_EDU_NORM primary key (SEQ_EVS_EDU_NORM);

prompt
prompt Creating table EVA_EMPTEMP
prompt ==========================
prompt
create table EVA_EMPTEMP
(
  ev_period_id               VARCHAR2(20) not null,
  ev_emp_id                  VARCHAR2(20) not null,
  ev_emp_name                VARCHAR2(50),
  ev_dept_id                 VARCHAR2(20),
  ev_dept_name               VARCHAR2(200),
  ev_post_group_id           VARCHAR2(20),
  ev_post_group_name         VARCHAR2(200),
  ev_type_id                 VARCHAR2(20),
  ev_process_id              VARCHAR2(20),
  ev_mark                    FLOAT,
  ev_grade_id                VARCHAR2(20),
  activity                   NUMBER,
  ev_default_grade_id        VARCHAR2(20),
  ev_order                   NUMBER,
  ev_emp_cnt                 NUMBER,
  update_date                DATE,
  updated_by                 VARCHAR2(20),
  ev_achive_dept_grade_id    VARCHAR2(20),
  ev_achive_ability_grade_id VARCHAR2(20),
  ev_post_grade_id           VARCHAR2(20),
  ev_post_grade_name         VARCHAR2(50),
  ev_position_id             VARCHAR2(20),
  ev_position_name           VARCHAR2(50),
  ev_avg_mark                FLOAT,
  ev_rank                    NUMBER
)
;

prompt
prompt Creating table EVA_EMP_ITEM_PROCESS
prompt ===================================
prompt
create table EVA_EMP_ITEM_PROCESS
(
  ev_item_id         VARCHAR2(20),
  ev_item_mark       FLOAT,
  ev_item_grade_id   VARCHAR2(20),
  ev_item_process_id VARCHAR2(20),
  ev_emp_id          VARCHAR2(20),
  ev_period_id       VARCHAR2(20),
  update_date        DATE,
  updated_by         VARCHAR2(20)
)
;

prompt
prompt Creating table EVA_EMP_LZY2
prompt ===========================
prompt
create table EVA_EMP_LZY2
(
  empid VARCHAR2(50),
  a     VARCHAR2(50)
)
;

prompt
prompt Creating table EVA_EXPERIENCE_NORM
prompt ==================================
prompt
create table EVA_EXPERIENCE_NORM
(
  seq_evs_experience_norm NUMBER not null,
  emp_post_grade          VARCHAR2(20),
  emp_year                NUMBER,
  emp_experience_mark     FLOAT
)
;
alter table EVA_EXPERIENCE_NORM
  add constraint SEQ_EVS_EXPERIENCE_NORM primary key (SEQ_EVS_EXPERIENCE_NORM);

prompt
prompt Creating table EVA_FACT_ACHIEVEMENT
prompt ===================================
prompt
create table EVA_FACT_ACHIEVEMENT
(
  seq_evs_fact       NUMBER not null,
  ev_period_id       VARCHAR2(20),
  ev_month           NUMBER,
  ev_mark            FLOAT default 0,
  ev_remark          VARCHAR2(200),
  activity           NUMBER,
  empid              VARCHAR2(20),
  seq_ev_item_detail NUMBER
)
;
comment on column EVA_FACT_ACHIEVEMENT.seq_evs_fact
  is '����';
comment on column EVA_FACT_ACHIEVEMENT.ev_period_id
  is '�����ڼ�';
comment on column EVA_FACT_ACHIEVEMENT.ev_month
  is '������(1~6��)';
comment on column EVA_FACT_ACHIEVEMENT.ev_mark
  is '�÷�';
comment on column EVA_FACT_ACHIEVEMENT.ev_remark
  is '��ע';
comment on column EVA_FACT_ACHIEVEMENT.activity
  is '��Ч��1��Ч����Ч';
comment on column EVA_FACT_ACHIEVEMENT.empid
  is '����';
comment on column EVA_FACT_ACHIEVEMENT.seq_ev_item_detail
  is '��������ĿID';
alter table EVA_FACT_ACHIEVEMENT
  add constraint PK_EVS_FACT primary key (SEQ_EVS_FACT);

prompt
prompt Creating table EVA_GROUP
prompt ========================
prompt
create table EVA_GROUP
(
  evs_group_id   NUMBER(10) not null,
  evs_group_name VARCHAR2(20),
  create_date    DATE,
  created_by     VARCHAR2(20),
  update_date    DATE,
  updated_by     VARCHAR2(20),
  orderno        NUMBER(10),
  activity       NUMBER(1) not null,
  remark         VARCHAR2(1000)
)
;
comment on column EVA_GROUP.evs_group_id
  is '����Ⱥ��ID';
comment on column EVA_GROUP.evs_group_name
  is '����Ⱥ��NAME';
comment on column EVA_GROUP.orderno
  is '�������';
comment on column EVA_GROUP.activity
  is '1���ã�0������';
comment on column EVA_GROUP.remark
  is '����';

prompt
prompt Creating table EVA_HISTORY
prompt ==========================
prompt
create table EVA_HISTORY
(
  pa_month    VARCHAR2(20),
  empid       VARCHAR2(20),
  total_score NUMBER(6,2),
  cpny_id     VARCHAR2(20)
)
;

prompt
prompt Creating table EVA_ITEM_CAL_RULE
prompt ================================
prompt
create table EVA_ITEM_CAL_RULE
(
  ev_grade_id         VARCHAR2(30),
  ev_grade_start_mark NUMBER,
  ev_grade_end_mark   NUMBER
)
;
comment on column EVA_ITEM_CAL_RULE.ev_grade_id
  is '�ȼ�ID';
comment on column EVA_ITEM_CAL_RULE.ev_grade_start_mark
  is '��ʼ��';
comment on column EVA_ITEM_CAL_RULE.ev_grade_end_mark
  is '������';

prompt
prompt Creating table EVA_ITEM_DETAIL_LZY
prompt ==================================
prompt
create table EVA_ITEM_DETAIL_LZY
(
  seq_ev_item_detail        NUMBER(20) not null,
  ev_period_id              VARCHAR2(20) not null,
  ev_emp_id                 VARCHAR2(20) not null,
  ev_item_id                VARCHAR2(20) not null,
  ev_detail_prop            FLOAT,
  ev_detail_order           NUMBER,
  ev_item_type              VARCHAR2(20),
  ev_item_method            VARCHAR2(20),
  ev_item_range             VARCHAR2(4000),
  ev_item_mark_value        VARCHAR2(100),
  ev_item_mark_name         VARCHAR2(100),
  seq_ev_common_item_detail NUMBER(20),
  ev_total_achive           FLOAT,
  ev_mark_range             VARCHAR2(100)
)
;

prompt
prompt Creating table EVA_ITEM_PROCESS_MARK
prompt ====================================
prompt
create table EVA_ITEM_PROCESS_MARK
(
  ev_period_id  VARCHAR2(20) not null,
  ev_emp_id     VARCHAR2(20) not null,
  ev_process_id VARCHAR2(20) not null,
  ev_item_id    VARCHAR2(20) not null,
  ev_mark       FLOAT,
  ev_remark     VARCHAR2(200)
)
;
alter table EVA_ITEM_PROCESS_MARK
  add constraint PK_EVS_ITEM_PROCESS_MARK primary key (EV_PERIOD_ID, EV_EMP_ID, EV_ITEM_ID, EV_PROCESS_ID);
alter table EVA_ITEM_PROCESS_MARK
  add constraint FK_EMP_ITEM_MARK foreign key (EV_PERIOD_ID, EV_EMP_ID)
  references EVA_EMP (EV_PERIOD_ID, EV_EMP_ID);

prompt
prompt Creating table EVA_ITEM_PROCESS_MARK_LZY
prompt ========================================
prompt
create table EVA_ITEM_PROCESS_MARK_LZY
(
  ev_period_id  VARCHAR2(20) not null,
  ev_emp_id     VARCHAR2(20) not null,
  ev_process_id VARCHAR2(20) not null,
  ev_item_id    VARCHAR2(20) not null,
  ev_mark       FLOAT,
  ev_remark     VARCHAR2(200)
)
;

prompt
prompt Creating table EVA_KPI_BEVALIDATER
prompt ==================================
prompt
create table EVA_KPI_BEVALIDATER
(
  eva_kpi_id  VARCHAR2(40),
  post_id     VARCHAR2(20),
  pa_month    VARCHAR2(20),
  created_by  VARCHAR2(20),
  create_date DATE default SYSDATE,
  update_date DATE default SYSDATE,
  updated_by  VARCHAR2(20),
  activity    NUMBER(1) default 1,
  cpny_id     VARCHAR2(20),
  max_score   NUMBER(6,2),
  min_score   NUMBER(6,2)
)
;

prompt
prompt Creating table EVA_KPI_INFO
prompt ===========================
prompt
create table EVA_KPI_INFO
(
  kpi_no          NUMBER(10) not null,
  kpi_name        VARCHAR2(200),
  kpi_level       NUMBER(1),
  kpi_weight      NUMBER(3,2),
  kpi_description VARCHAR2(2000),
  kpi_standard    NUMBER(3,2),
  kpi_checker     VARCHAR2(20),
  kpi_post_id     VARCHAR2(20),
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  orderno         NUMBER(10),
  activity        NUMBER(1),
  kpi_parent_no   NUMBER(10),
  cpny_id         VARCHAR2(20)
)
;
comment on table EVA_KPI_INFO
  is '����KPI��Ϣ';
comment on column EVA_KPI_INFO.kpi_no
  is '����';
comment on column EVA_KPI_INFO.kpi_name
  is 'KPI����';
comment on column EVA_KPI_INFO.kpi_level
  is '�ȼ�';
comment on column EVA_KPI_INFO.kpi_weight
  is 'Ȩ��';
comment on column EVA_KPI_INFO.kpi_description
  is '����';
comment on column EVA_KPI_INFO.kpi_standard
  is '��׼����˵İٷֱȣ�';
comment on column EVA_KPI_INFO.kpi_checker
  is '�����';
comment on column EVA_KPI_INFO.kpi_post_id
  is '�����ְλ';
comment on column EVA_KPI_INFO.kpi_parent_no
  is '����';
alter table EVA_KPI_INFO
  add constraint PK_EVA_KPI_INFO primary key (KPI_NO);
alter table EVA_KPI_INFO
  add constraint PF_EVA_KPI_INFO_PARENT foreign key (KPI_PARENT_NO)
  references EVA_KPI_INFO (KPI_NO) on delete cascade;

prompt
prompt Creating table EVA_KPI_ITEM
prompt ===========================
prompt
create table EVA_KPI_ITEM
(
  eva_kpi_no      NUMBER not null,
  eva_type_id     VARCHAR2(40),
  eva_kpi_id      VARCHAR2(40),
  eva_kpi_name    VARCHAR2(200),
  eva_kpi_en_name VARCHAR2(200),
  created_by      VARCHAR2(20),
  create_date     DATE default SYSDATE,
  updated_by      VARCHAR2(20),
  update_date     DATE default SYSDATE,
  activity        NUMBER(1) default 1,
  cpny_id         VARCHAR2(20),
  kpi_define      VARCHAR2(4000),
  cal_des         VARCHAR2(4000),
  kpi_standard    VARCHAR2(50)
)
;
alter table EVA_KPI_ITEM
  add constraint PK_EVA_KPI_ITEM_NO primary key (EVA_KPI_NO);

prompt
prompt Creating table EVA_KPI_SCORE
prompt ============================
prompt
create table EVA_KPI_SCORE
(
  no           NUMBER not null,
  empid        VARCHAR2(20),
  eva_kpi_id   VARCHAR2(40),
  pa_month     VARCHAR2(20),
  score        NUMBER(6,2),
  activity     NUMBER(1) default 1,
  created_by   VARCHAR2(20),
  updated_by   VARCHAR2(20),
  create_date  DATE,
  update_date  DATE,
  cpny_id      VARCHAR2(20),
  description  VARCHAR2(4000),
  validater_id VARCHAR2(20)
)
;
alter table EVA_KPI_SCORE
  add constraint PK_EVA_KPI_SCORE_NO primary key (NO);

prompt
prompt Creating table EVA_KPI_TYPE
prompt ===========================
prompt
create table EVA_KPI_TYPE
(
  eva_type_no      NUMBER not null,
  eva_type_id      VARCHAR2(40),
  eva_type_name    VARCHAR2(200),
  eva_type_en_name VARCHAR2(200),
  created_by       VARCHAR2(20),
  create_date      DATE default SYSDATE,
  updated_by       VARCHAR2(20),
  update_date      DATE default SYSDATE,
  activity         NUMBER(1) default 1,
  cpny_id          VARCHAR2(20),
  description      VARCHAR2(4000)
)
;
alter table EVA_KPI_TYPE
  add constraint PK_EVA_KPI_TYPE_NO primary key (EVA_TYPE_NO);

prompt
prompt Creating table EVA_KPI_VALIDATER
prompt ================================
prompt
create table EVA_KPI_VALIDATER
(
  eva_kpi_id  VARCHAR2(40),
  empid       VARCHAR2(20),
  start_date  DATE,
  end_date    DATE,
  created_by  VARCHAR2(20),
  create_date DATE default SYSDATE,
  updated_by  VARCHAR2(20),
  update_date DATE default SYSDATE,
  activity    NUMBER(1) default 1,
  cpny_id     VARCHAR2(20)
)
;

prompt
prompt Creating table EVA_MASTER
prompt =========================
prompt
create table EVA_MASTER
(
  ev_period_id      VARCHAR2(20) not null,
  ev_emp_id         VARCHAR2(20) not null,
  ev_process_id     VARCHAR2(20) not null,
  ev_master         VARCHAR2(20),
  ev_appendable     NUMBER,
  ev_append_value   VARCHAR2(500),
  ev_append_name    VARCHAR2(1000),
  ev_append_default FLOAT,
  ev_append         FLOAT,
  ev_append_reason  VARCHAR2(500),
  ev_submitted      NUMBER,
  ev_item_id        VARCHAR2(20)
)
;
comment on column EVA_MASTER.ev_item_id
  is '������ĿID';

prompt
prompt Creating table EVA_MASTER_LZY
prompt =============================
prompt
create table EVA_MASTER_LZY
(
  ev_period_id      VARCHAR2(20) not null,
  ev_emp_id         VARCHAR2(20) not null,
  ev_process_id     VARCHAR2(20) not null,
  ev_master         VARCHAR2(20),
  ev_appendable     NUMBER,
  ev_append_value   VARCHAR2(500),
  ev_append_name    VARCHAR2(1000),
  ev_append_default FLOAT,
  ev_append         FLOAT,
  ev_append_reason  VARCHAR2(500),
  ev_submitted      NUMBER,
  ev_item_id        VARCHAR2(20)
)
;

prompt
prompt Creating table EVA_NORM
prompt =======================
prompt
create table EVA_NORM
(
  seq_evs_norm  NUMBER not null,
  ev_dept_grade VARCHAR2(20),
  ev_emp_grade  VARCHAR2(20),
  ev_emp_count  NUMBER,
  activity      VARCHAR2(20),
  ev_emp_sum    NUMBER
)
;
alter table EVA_NORM
  add constraint PK_EVS_NORM primary key (SEQ_EVS_NORM);

prompt
prompt Creating table EVA_TYPE_PROCESS
prompt ===============================
prompt
create table EVA_TYPE_PROCESS
(
  ev_period_id     VARCHAR2(20) not null,
  ev_type_id       VARCHAR2(20) not null,
  ev_process_id    VARCHAR2(20) not null,
  ev_process_order NUMBER not null,
  ev_process_sdate DATE,
  ev_process_edate DATE,
  description      VARCHAR2(200),
  remark           VARCHAR2(200),
  create_date      DATE,
  created_by       VARCHAR2(20),
  update_date      DATE,
  updated_by       VARCHAR2(20),
  activity         NUMBER(1),
  orderno          NUMBER(10),
  cpny_id          VARCHAR2(20),
  ev_percentage    FLOAT not null,
  ev_operate_id    VARCHAR2(20)
)
;
comment on column EVA_TYPE_PROCESS.ev_percentage
  is '����ռ��';
alter table EVA_TYPE_PROCESS
  add constraint PK_EVS_TYPE_PROCESS primary key (EV_PERIOD_ID, EV_TYPE_ID, EV_PROCESS_ID);
alter table EVA_TYPE_PROCESS
  add constraint FK_EVS_TYPE_PROCESS_PERIOD foreign key (EV_PERIOD_ID, EV_TYPE_ID)
  references EVA_PERIOD_TYPE (EV_PERIOD_ID, EV_TYPE_ID) on delete cascade;

prompt
prompt Creating table EVA_RELATION
prompt ===========================
prompt
create table EVA_RELATION
(
  ev_period_id     VARCHAR2(20) not null,
  ev_type_id       VARCHAR2(20) not null,
  ev_item_id       VARCHAR2(20) not null,
  ev_process_id    VARCHAR2(20) not null,
  ev_process_prop  FLOAT,
  ev_operate_id    VARCHAR2(20),
  ev_item_prop     FLOAT,
  ev_marks_value   VARCHAR2(200),
  ev_marks_name    VARCHAR2(200),
  ev_marks_default NUMBER,
  cpny_id          VARCHAR2(20)
)
;
comment on column EVA_RELATION.ev_process_prop
  is '����ռ��';
comment on column EVA_RELATION.ev_item_prop
  is '��Ŀռ��';
alter table EVA_RELATION
  add constraint PK_EVS_RELATION primary key (EV_PERIOD_ID, EV_TYPE_ID, EV_ITEM_ID, EV_PROCESS_ID);
alter table EVA_RELATION
  add constraint FK_EVS_RELATION_EVS_TYPE_ITEM foreign key (EV_PERIOD_ID, EV_TYPE_ID, EV_ITEM_ID)
  references EVA_TYPE_ITEM (EV_PERIOD_ID, EV_TYPE_ID, EV_ITEM_ID) on delete cascade;
alter table EVA_RELATION
  add constraint FK_EVS_RELATION_TYPE_PROCESS foreign key (EV_PERIOD_ID, EV_TYPE_ID, EV_PROCESS_ID)
  references EVA_TYPE_PROCESS (EV_PERIOD_ID, EV_TYPE_ID, EV_PROCESS_ID) on delete cascade;

prompt
prompt Creating table EVE_EMP
prompt ======================
prompt
create table EVE_EMP
(
  ev_empid           VARCHAR2(20) not null,
  turn_type_code     VARCHAR2(20) not null,
  end_probation_date DATE,
  create_date        DATE,
  created_by         VARCHAR2(20),
  update_date        DATE,
  updated_by         VARCHAR2(20),
  time_stamp         VARCHAR2(20),
  activity           NUMBER(1) default 1 not null,
  orderno            NUMBER(10),
  ev_s_work_flag     NUMBER(1) default 0,
  ev_s_item_flag     NUMBER(1) default 0,
  ev_1_item_flag     NUMBER(1) default 0,
  ev_2_item_flag     NUMBER(1) default 0,
  ev_3_item_flag     NUMBER(1) default 0
)
;
alter table EVE_EMP
  add constraint PK_EVE_EMP primary key (EV_EMPID, TURN_TYPE_CODE);
alter table EVE_EMP
  add constraint FK_EVE_EMP foreign key (EV_EMPID)
  references HR_EMPLOYEE (EMPID) on delete cascade;

prompt
prompt Creating table EVE_EMP_ITEM
prompt ===========================
prompt
create table EVE_EMP_ITEM
(
  ev_item_no     NUMBER(10) not null,
  ev_empid       VARCHAR2(20) not null,
  ev_item        VARCHAR2(2000) not null,
  ev_s_item      VARCHAR2(2000),
  ev_m_item      VARCHAR2(2000),
  ev_percentage  FLOAT default 0 not null,
  ev_score       FLOAT default 0,
  ev_s_score     FLOAT default 0,
  ev_1_score     FLOAT default 0,
  ev_2_score     FLOAT default 0,
  ev_3_score     FLOAT default 0,
  ev_com_score   FLOAT default 0,
  create_date    DATE,
  created_by     VARCHAR2(20),
  update_date    DATE,
  updated_by     VARCHAR2(20),
  time_stamp     VARCHAR2(20),
  activity       NUMBER(1) default 1 not null,
  orderno        NUMBER(10),
  turn_type_code VARCHAR2(20) not null
)
;
alter table EVE_EMP_ITEM
  add constraint PK_EVE_EMP_ITEM primary key (EV_ITEM_NO);
alter table EVE_EMP_ITEM
  add constraint UK_EVE_EMP_ITEM unique (EV_EMPID, EV_ITEM, TURN_TYPE_CODE);
alter table EVE_EMP_ITEM
  add constraint FK_EVE_EMP_ITEM foreign key (EV_EMPID)
  references HR_EMPLOYEE (EMPID) on delete cascade;

prompt
prompt Creating table EVE_WORK_PLAN
prompt ============================
prompt
create table EVE_WORK_PLAN
(
  ev_no           NUMBER(10) not null,
  ev_empid        VARCHAR2(20) not null,
  ev_work_content VARCHAR2(2000) not null,
  ev_start_date   DATE,
  ev_end_date     DATE,
  ev_score        FLOAT,
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  time_stamp      VARCHAR2(20),
  activity        NUMBER(1) default 1 not null,
  orderno         NUMBER(10),
  cpny_id         VARCHAR2(20),
  turn_type_code  VARCHAR2(20) not null,
  ev_s_work       VARCHAR2(2000)
)
;
alter table EVE_WORK_PLAN
  add constraint PK_EVE_WORK_PLAN primary key (EV_NO);
alter table EVE_WORK_PLAN
  add constraint UK_EVE_WORK_PLAN unique (EV_EMPID, EV_WORK_CONTENT, TURN_TYPE_CODE);
alter table EVE_WORK_PLAN
  add constraint FK_EVE_WORK_PLAN foreign key (EV_EMPID)
  references HR_EMPLOYEE (EMPID) on delete cascade;

prompt
prompt Creating table EVJ_PERIOD
prompt =========================
prompt
create table EVJ_PERIOD
(
  ev_year               VARCHAR2(8),
  ev_parent_period_id   VARCHAR2(20),
  ev_period_id          VARCHAR2(20) not null,
  ev_parent_period_flag NUMBER,
  ev_period_name        VARCHAR2(50),
  ev_public             NUMBER
)
;
alter table EVJ_PERIOD
  add constraint PK_EVJ_PERIOD primary key (EV_PERIOD_ID);

prompt
prompt Creating table EVJ_DEPT
prompt =======================
prompt
create table EVJ_DEPT
(
  ev_period_id      VARCHAR2(20) not null,
  ev_dept_id        VARCHAR2(20) not null,
  ev_dept_name      VARCHAR2(50),
  ev_dept_level     NUMBER,
  ev_parent_dept_id VARCHAR2(20),
  ev_dept_grade_id  VARCHAR2(20),
  ev_dept_norm      NUMBER,
  activity          NUMBER
)
;
comment on table EVJ_DEPT
  is '���ű������ȼ����ٽ�����Ի���׼�ٷֱ�����';
alter table EVJ_DEPT
  add constraint PK_EVJ_DEPT primary key (EV_PERIOD_ID, EV_DEPT_ID);
alter table EVJ_DEPT
  add constraint FK_EVJ_DEPT_PERIOD foreign key (EV_PERIOD_ID)
  references EVJ_PERIOD (EV_PERIOD_ID);

prompt
prompt Creating table EVJ_DEPT_RADIO
prompt =============================
prompt
create table EVJ_DEPT_RADIO
(
  ev_period_id     VARCHAR2(20) not null,
  ev_dept_id       VARCHAR2(20) not null,
  ev_dept_grade_id VARCHAR2(20) not null,
  ev_grade_id      VARCHAR2(20) not null,
  ev_grade_prop    FLOAT,
  ev_wage_radio    FLOAT
)
;
create unique index IDX_EVJ_DEPT_RADIO on EVJ_DEPT_RADIO (EV_DEPT_GRADE_ID, EV_GRADE_ID, EV_DEPT_ID, EV_PERIOD_ID);
alter table EVJ_DEPT_RADIO
  add constraint FK_EVJ_DEPT_RADIO_DEPT foreign key (EV_PERIOD_ID, EV_DEPT_ID)
  references EVJ_DEPT (EV_PERIOD_ID, EV_DEPT_ID);

prompt
prompt Creating table EVJ_PERIOD_TYPE
prompt ==============================
prompt
create table EVJ_PERIOD_TYPE
(
  ev_period_id VARCHAR2(20) not null,
  ev_type_id   VARCHAR2(20) not null
)
;
alter table EVJ_PERIOD_TYPE
  add constraint PK_EVJ_PERIOD_TYPE primary key (EV_PERIOD_ID, EV_TYPE_ID);
alter table EVJ_PERIOD_TYPE
  add constraint FK_EVJ_PERIOD_TYPE foreign key (EV_PERIOD_ID)
  references EVJ_PERIOD (EV_PERIOD_ID);

prompt
prompt Creating table EVJ_EMP
prompt ======================
prompt
create table EVJ_EMP
(
  ev_period_id       VARCHAR2(20) not null,
  ev_emp_id          VARCHAR2(20) not null,
  ev_emp_name        VARCHAR2(50),
  ev_dept_id         VARCHAR2(20),
  ev_dept_name       VARCHAR2(200),
  ev_post_group_id   VARCHAR2(20),
  ev_post_group_name VARCHAR2(200),
  ev_type_id         VARCHAR2(20),
  ev_process_id      VARCHAR2(20),
  ev_mark            FLOAT,
  ev_grade_id        VARCHAR2(20),
  activity           NUMBER,
  evsemptype         VARCHAR2(20)
)
;
comment on column EVJ_EMP.evsemptype
  is '����Ⱥ��';
alter table EVJ_EMP
  add constraint PK_EVJ_EMP primary key (EV_PERIOD_ID, EV_EMP_ID);
alter table EVJ_EMP
  add constraint FK_EVJ_EMP_DEPT foreign key (EV_PERIOD_ID, EV_DEPT_ID)
  references EVJ_DEPT (EV_PERIOD_ID, EV_DEPT_ID);
alter table EVJ_EMP
  add constraint FK_EVJ_EMP_TYPE_PERIOD foreign key (EV_PERIOD_ID, EV_TYPE_ID)
  references EVJ_PERIOD_TYPE (EV_PERIOD_ID, EV_TYPE_ID);

prompt
prompt Creating table EVJ_MASTER
prompt =========================
prompt
create table EVJ_MASTER
(
  ev_period_id      VARCHAR2(20) not null,
  ev_emp_id         VARCHAR2(20) not null,
  ev_process_id     VARCHAR2(20) not null,
  ev_item_id        VARCHAR2(20) not null,
  ev_master         VARCHAR2(20),
  ev_mark           FLOAT,
  ev_appendable     NUMBER,
  ev_append_value   VARCHAR2(500),
  ev_append_name    VARCHAR2(1000),
  ev_append_default FLOAT,
  ev_append         FLOAT,
  ev_append_reason  VARCHAR2(500),
  ev_submitted      NUMBER
)
;
create unique index IDX_EVJ_MASTER on EVJ_MASTER (EV_PERIOD_ID, EV_EMP_ID, EV_PROCESS_ID, EV_ITEM_ID);
alter table EVJ_MASTER
  add constraint FK_EVJ_MASTER_EMP foreign key (EV_PERIOD_ID, EV_EMP_ID)
  references EVJ_EMP (EV_PERIOD_ID, EV_EMP_ID);

prompt
prompt Creating table EVJ_TYPE_ITEM
prompt ============================
prompt
create table EVJ_TYPE_ITEM
(
  ev_period_id  VARCHAR2(20) not null,
  ev_type_id    VARCHAR2(20) not null,
  ev_item_id    VARCHAR2(20) not null,
  ev_item_order NUMBER not null
)
;
alter table EVJ_TYPE_ITEM
  add constraint PK_EVJ_TYPE_ITEM primary key (EV_PERIOD_ID, EV_TYPE_ID, EV_ITEM_ID);
alter table EVJ_TYPE_ITEM
  add constraint FK_EVJ_TYPE_ITEM_PERIOD foreign key (EV_PERIOD_ID, EV_TYPE_ID)
  references EVJ_PERIOD_TYPE (EV_PERIOD_ID, EV_TYPE_ID);

prompt
prompt Creating table EVJ_TYPE_PROCESS
prompt ===============================
prompt
create table EVJ_TYPE_PROCESS
(
  ev_period_id     VARCHAR2(20) not null,
  ev_type_id       VARCHAR2(20) not null,
  ev_process_id    VARCHAR2(20) not null,
  ev_process_order NUMBER not null,
  ev_process_sdate DATE,
  ev_process_edate DATE
)
;
alter table EVJ_TYPE_PROCESS
  add constraint PK_EVJ_TYPE_PROCESS primary key (EV_PERIOD_ID, EV_TYPE_ID, EV_PROCESS_ID);
alter table EVJ_TYPE_PROCESS
  add constraint FK_EVJ_TYPE_PROCESS_PERIOD foreign key (EV_PERIOD_ID, EV_TYPE_ID)
  references EVJ_PERIOD_TYPE (EV_PERIOD_ID, EV_TYPE_ID);

prompt
prompt Creating table EVJ_RELATION
prompt ===========================
prompt
create table EVJ_RELATION
(
  ev_period_id     VARCHAR2(20) not null,
  ev_type_id       VARCHAR2(20) not null,
  ev_item_id       VARCHAR2(20) not null,
  ev_process_id    VARCHAR2(20) not null,
  ev_process_prop  FLOAT,
  ev_operate_id    VARCHAR2(20),
  ev_item_prop     FLOAT,
  ev_marks_value   VARCHAR2(500),
  ev_marks_name    VARCHAR2(1000),
  ev_marks_default NUMBER
)
;
alter table EVJ_RELATION
  add constraint PK_EVJ_RELATION primary key (EV_PERIOD_ID, EV_TYPE_ID, EV_ITEM_ID, EV_PROCESS_ID);
alter table EVJ_RELATION
  add constraint FK_EVJ_RELATION_EVJ_TYPE_ITEM foreign key (EV_PERIOD_ID, EV_TYPE_ID, EV_ITEM_ID)
  references EVJ_TYPE_ITEM (EV_PERIOD_ID, EV_TYPE_ID, EV_ITEM_ID);
alter table EVJ_RELATION
  add constraint FK_EVJ_RELATION_TYPE_PROCESS foreign key (EV_PERIOD_ID, EV_TYPE_ID, EV_PROCESS_ID)
  references EVJ_TYPE_PROCESS (EV_PERIOD_ID, EV_TYPE_ID, EV_PROCESS_ID);

prompt
prompt Creating table EV_ACHIVE_ABILITY_NORM
prompt =====================================
prompt
create table EV_ACHIVE_ABILITY_NORM
(
  ev_achive_ability_norm_seq NUMBER not null,
  post_grade_id              VARCHAR2(20),
  ev_achive_grade_id         VARCHAR2(20),
  ev_ability_grade_id        VARCHAR2(20),
  ev_result_grade_id         VARCHAR2(20),
  ev_position_id             VARCHAR2(20)
)
;
alter table EV_ACHIVE_ABILITY_NORM
  add constraint EV_ACHIVE_ABILITY_NORM_SEQ primary key (EV_ACHIVE_ABILITY_NORM_SEQ);

prompt
prompt Creating table EV_ACHIVE_DEPT_NORM
prompt ==================================
prompt
create table EV_ACHIVE_DEPT_NORM
(
  ev_achive_dept_norm_seq NUMBER not null,
  post_grade_id           VARCHAR2(20),
  ev_achive_grade_id      VARCHAR2(20),
  ev_dept_grade_id        VARCHAR2(20),
  ev_result_grade_id      VARCHAR2(20),
  ev_position_id          VARCHAR2(20)
)
;
alter table EV_ACHIVE_DEPT_NORM
  add constraint EV_ACHIVE_DEPT_NORM_SEQ primary key (EV_ACHIVE_DEPT_NORM_SEQ);

prompt
prompt Creating table EV_EXTRA_ITEM
prompt ============================
prompt
create table EV_EXTRA_ITEM
(
  ev_extra_item_id   VARCHAR2(20) not null,
  ev_empid           VARCHAR2(20) not null,
  ev_period_id       VARCHAR2(20) not null,
  ev_extra_item_mark FLOAT,
  create_date        DATE,
  created_by         VARCHAR2(20),
  update_date        DATE,
  updated_by         VARCHAR2(20),
  activity           NUMBER(1)
)
;
alter table EV_EXTRA_ITEM
  add constraint EVS_EXTRA_ITEM_PK primary key (EV_EMPID, EV_PERIOD_ID, EV_EXTRA_ITEM_ID);

prompt
prompt Creating table FICO_ACCOUNT
prompt ===========================
prompt
create table FICO_ACCOUNT
(
  account_no   NUMBER not null,
  account_name VARCHAR2(200),
  description  VARCHAR2(2000),
  status_id    VARCHAR2(20),
  created_by   VARCHAR2(20),
  create_date  DATE,
  updated_by   VARCHAR2(20),
  update_date  DATE,
  activity     NUMBER(1),
  order_no     NUMBER,
  cpny_id      VARCHAR2(20),
  money_amount NUMBER
)
;
comment on table FICO_ACCOUNT
  is '�˻���Ϣ��';
comment on column FICO_ACCOUNT.account_no
  is '����';
comment on column FICO_ACCOUNT.account_name
  is '�˻���';
comment on column FICO_ACCOUNT.description
  is '����';
comment on column FICO_ACCOUNT.status_id
  is '״̬';
comment on column FICO_ACCOUNT.created_by
  is '������';
comment on column FICO_ACCOUNT.create_date
  is '��������';
comment on column FICO_ACCOUNT.updated_by
  is '������';
comment on column FICO_ACCOUNT.update_date
  is '��������';
comment on column FICO_ACCOUNT.activity
  is '�Ƿ񼤻�';
comment on column FICO_ACCOUNT.order_no
  is '����';
comment on column FICO_ACCOUNT.cpny_id
  is '��˾id';
comment on column FICO_ACCOUNT.money_amount
  is '�˻����п��';
alter table FICO_ACCOUNT
  add constraint PK_FICO_ACCOUNT primary key (ACCOUNT_NO);

prompt
prompt Creating table FICO_INCOME_INVOICE
prompt ==================================
prompt
create table FICO_INCOME_INVOICE
(
  invoice_no     NUMBER not null,
  account_id     VARCHAR2(20),
  reference      VARCHAR2(4000),
  customer_id    VARCHAR2(20),
  payment_type   VARCHAR2(20),
  remark         VARCHAR2(4000),
  payable_amount NUMBER,
  invoice_date   DATE,
  subject        VARCHAR2(200),
  comments       VARCHAR2(4000),
  due_date       DATE,
  payment_date   DATE,
  status_id      VARCHAR2(20),
  created_by     VARCHAR2(20),
  create_date    DATE,
  updated_by     VARCHAR2(20),
  update_date    DATE,
  activity       NUMBER(1),
  order_no       NUMBER,
  cpny_id        VARCHAR2(20)
)
;
comment on table FICO_INCOME_INVOICE
  is '������˱�';
comment on column FICO_INCOME_INVOICE.invoice_no
  is '���';
comment on column FICO_INCOME_INVOICE.account_id
  is '�˻�';
comment on column FICO_INCOME_INVOICE.reference
  is '�ο�';
comment on column FICO_INCOME_INVOICE.customer_id
  is '�ͻ�';
comment on column FICO_INCOME_INVOICE.payment_type
  is '֧������';
comment on column FICO_INCOME_INVOICE.remark
  is '��ע';
comment on column FICO_INCOME_INVOICE.payable_amount
  is '֧�����';
comment on column FICO_INCOME_INVOICE.invoice_date
  is '��Ʊ����';
comment on column FICO_INCOME_INVOICE.subject
  is '���⣨��������';
comment on column FICO_INCOME_INVOICE.comments
  is '������';
comment on column FICO_INCOME_INVOICE.due_date
  is '��ֹ����';
comment on column FICO_INCOME_INVOICE.payment_date
  is '��������';
comment on column FICO_INCOME_INVOICE.status_id
  is '״̬';
comment on column FICO_INCOME_INVOICE.created_by
  is '������';
comment on column FICO_INCOME_INVOICE.create_date
  is '��������';
comment on column FICO_INCOME_INVOICE.updated_by
  is '������';
comment on column FICO_INCOME_INVOICE.update_date
  is '��������';
comment on column FICO_INCOME_INVOICE.activity
  is '�Ƿ񼤻�';
comment on column FICO_INCOME_INVOICE.order_no
  is '����';
comment on column FICO_INCOME_INVOICE.cpny_id
  is '��˾id';
alter table FICO_INCOME_INVOICE
  add constraint PK_FICO_INCOME_INVOICE primary key (INVOICE_NO);

prompt
prompt Creating table FICO_INVOICE
prompt ===========================
prompt
create table FICO_INVOICE
(
  invoice_no     NUMBER not null,
  project_id     VARCHAR2(20),
  customer_id    VARCHAR2(20),
  account_id     VARCHAR2(20),
  type_id        VARCHAR2(20),
  status_id      VARCHAR2(20),
  remark         VARCHAR2(4000),
  payable_amount NUMBER,
  invoice_date   DATE,
  subject        VARCHAR2(200),
  comments       VARCHAR2(4000),
  due_date       DATE,
  payment_date   DATE,
  created_by     VARCHAR2(20),
  create_date    DATE,
  updated_by     VARCHAR2(20),
  update_date    DATE,
  activity       NUMBER(1),
  order_no       NUMBER,
  cpny_id        VARCHAR2(20)
)
;
comment on table FICO_INVOICE
  is '������˱�';
comment on column FICO_INVOICE.invoice_no
  is '���';
comment on column FICO_INVOICE.project_id
  is '��Ŀ';
comment on column FICO_INVOICE.customer_id
  is '�˿�';
comment on column FICO_INVOICE.account_id
  is '�˺�';
comment on column FICO_INVOICE.type_id
  is '����';
comment on column FICO_INVOICE.status_id
  is '״̬';
comment on column FICO_INVOICE.remark
  is '��ע';
comment on column FICO_INVOICE.payable_amount
  is 'Ӧ�����';
comment on column FICO_INVOICE.invoice_date
  is '��Ʊ����';
comment on column FICO_INVOICE.subject
  is '���⣨��������';
comment on column FICO_INVOICE.comments
  is '������';
comment on column FICO_INVOICE.due_date
  is '��ֹ����';
comment on column FICO_INVOICE.payment_date
  is '��������';
comment on column FICO_INVOICE.created_by
  is '������';
comment on column FICO_INVOICE.create_date
  is '��������';
comment on column FICO_INVOICE.updated_by
  is '������';
comment on column FICO_INVOICE.update_date
  is '��������';
comment on column FICO_INVOICE.activity
  is '�Ƿ񼤻�';
comment on column FICO_INVOICE.order_no
  is '����';
comment on column FICO_INVOICE.cpny_id
  is '��˾id';
alter table FICO_INVOICE
  add constraint PK_FICO_INVOICE primary key (INVOICE_NO);

prompt
prompt Creating table FICO_TASK
prompt ========================
prompt
create table FICO_TASK
(
  task_no       NUMBER not null,
  task_date     DATE,
  assign_date   DATE,
  status_id     VARCHAR2(20),
  project_id    VARCHAR2(20),
  customer_id   VARCHAR2(20),
  customer_text VARCHAR2(2000),
  title         VARCHAR2(200),
  reference     VARCHAR2(2000),
  comments      VARCHAR2(2000),
  contact_id    VARCHAR2(20),
  commit_date   DATE,
  created_by    VARCHAR2(20),
  create_date   DATE,
  updated_by    VARCHAR2(20),
  update_date   DATE,
  activity      NUMBER(1),
  order_no      NUMBER,
  cpny_id       VARCHAR2(20)
)
;
comment on table FICO_TASK
  is '���������';
comment on column FICO_TASK.task_no
  is '����';
comment on column FICO_TASK.task_date
  is '��������';
comment on column FICO_TASK.assign_date
  is '��������';
comment on column FICO_TASK.status_id
  is '״̬';
comment on column FICO_TASK.project_id
  is '��Ŀ';
comment on column FICO_TASK.customer_id
  is '�ͻ�';
comment on column FICO_TASK.customer_text
  is '�ͻ��ı�';
comment on column FICO_TASK.title
  is '����';
comment on column FICO_TASK.reference
  is '�ο�';
comment on column FICO_TASK.comments
  is '����';
comment on column FICO_TASK.contact_id
  is '��ϵ��';
comment on column FICO_TASK.created_by
  is '������';
comment on column FICO_TASK.create_date
  is '��������';
comment on column FICO_TASK.updated_by
  is '������';
comment on column FICO_TASK.update_date
  is '��������';
comment on column FICO_TASK.activity
  is '�Ƿ񼤻�';
comment on column FICO_TASK.order_no
  is '����';
comment on column FICO_TASK.cpny_id
  is '��˾id';
alter table FICO_TASK
  add constraint PK_FICO_TASK primary key (TASK_NO);

prompt
prompt Creating table FICO_TASK_POSITION
prompt =================================
prompt
create table FICO_TASK_POSITION
(
  title       VARCHAR2(200),
  net_sum     NUMBER,
  comments    VARCHAR2(2000),
  type_id     VARCHAR2(20),
  person_days NUMBER,
  begin_date  DATE,
  end_date    DATE,
  task_no     NUMBER,
  position_no NUMBER not null,
  status_id   VARCHAR2(20),
  created_by  VARCHAR2(20),
  create_date DATE,
  updated_by  VARCHAR2(20),
  update_date DATE,
  activity    NUMBER(1),
  order_no    NUMBER,
  cpny_id     VARCHAR2(20)
)
;
comment on table FICO_TASK_POSITION
  is '����λ�ñ�';
comment on column FICO_TASK_POSITION.title
  is '����';
comment on column FICO_TASK_POSITION.net_sum
  is '��ֵ';
comment on column FICO_TASK_POSITION.comments
  is '��ע';
comment on column FICO_TASK_POSITION.type_id
  is '����';
comment on column FICO_TASK_POSITION.person_days
  is '����';
comment on column FICO_TASK_POSITION.begin_date
  is '��ʼ����';
comment on column FICO_TASK_POSITION.end_date
  is '��������';
comment on column FICO_TASK_POSITION.task_no
  is '���������';
comment on column FICO_TASK_POSITION.position_no
  is '����';
comment on column FICO_TASK_POSITION.status_id
  is '״̬';
comment on column FICO_TASK_POSITION.created_by
  is '������';
comment on column FICO_TASK_POSITION.create_date
  is '��������';
comment on column FICO_TASK_POSITION.updated_by
  is '������';
comment on column FICO_TASK_POSITION.update_date
  is '��������';
comment on column FICO_TASK_POSITION.activity
  is '�Ƿ񼤻�';
comment on column FICO_TASK_POSITION.order_no
  is '����';
comment on column FICO_TASK_POSITION.cpny_id
  is '��˾id';
alter table FICO_TASK_POSITION
  add constraint PK_FICO_TASK_POSITION primary key (POSITION_NO);

prompt
prompt Creating table HR_ACT_BUSINESS
prompt ==============================
prompt
create table HR_ACT_BUSINESS
(
  act_biz_no            NUMBER(10) not null,
  empid                 VARCHAR2(20) not null,
  trans_no              VARCHAR2(20),
  trans_code            VARCHAR2(20) not null,
  biz_code              VARCHAR2(20) not null,
  start_date            DATE not null,
  end_date              DATE,
  remark                VARCHAR2(500),
  deptid                VARCHAR2(20),
  position_code         VARCHAR2(20),
  duty_code             VARCHAR2(20),
  post_code             VARCHAR2(20),
  post_grade_code       VARCHAR2(20),
  post_coef             VARCHAR2(20),
  post_column_code      VARCHAR2(20),
  post_grade_level_code VARCHAR2(20),
  post_group_code       VARCHAR2(20),
  status_code           VARCHAR2(20),
  join_type_code        VARCHAR2(20),
  emp_type_code         VARCHAR2(20),
  create_date           DATE,
  created_by            VARCHAR2(20),
  update_date           DATE,
  updated_by            VARCHAR2(20),
  activity              NUMBER(1),
  affrim_flag           NUMBER(1),
  orderno               NUMBER(10),
  cancel_remark         VARCHAR2(500)
)
;
comment on table HR_ACT_BUSINESS
  is '����ҵ�����';
comment on column HR_ACT_BUSINESS.biz_code
  is '����ҵ��';
comment on column HR_ACT_BUSINESS.start_date
  is '��Ч����';
comment on column HR_ACT_BUSINESS.end_date
  is '����ʱ��';
comment on column HR_ACT_BUSINESS.remark
  is '��ע';
create index IDX_HR_ACT_EMP on HR_ACT_BUSINESS (EMPID);
alter table HR_ACT_BUSINESS
  add constraint PK_ACT_BIZ_NO primary key (ACT_BIZ_NO);
alter table HR_ACT_BUSINESS
  add constraint UK_ACT_BIZ_NO unique (EMPID, BIZ_CODE, START_DATE);

prompt
prompt Creating table HR_ADDITIONAL_INFO
prompt =================================
prompt
create table HR_ADDITIONAL_INFO
(
  additional_no  NUMBER(10) not null,
  empid          VARCHAR2(20) not null,
  event_date     DATE,
  info_type_code VARCHAR2(20),
  details        VARCHAR2(200),
  register_id    VARCHAR2(20),
  create_date    DATE,
  created_by     VARCHAR2(20),
  update_date    DATE,
  updated_by     VARCHAR2(20),
  orderno        NUMBER(10),
  activity       NUMBER(1)
)
;
comment on table HR_ADDITIONAL_INFO
  is '������Ϣ';
comment on column HR_ADDITIONAL_INFO.event_date
  is '��������';
comment on column HR_ADDITIONAL_INFO.info_type_code
  is '��Ϣ����';
comment on column HR_ADDITIONAL_INFO.details
  is '��ϸ����';
comment on column HR_ADDITIONAL_INFO.register_id
  is '�Ǽ���';
alter table HR_ADDITIONAL_INFO
  add constraint PK_HR_ADDITIONAL_INFO primary key (ADDITIONAL_NO);
alter table HR_ADDITIONAL_INFO
  add constraint FK_EMP_ADDITIONAL_INFO foreign key (EMPID)
  references HR_EMPLOYEE (EMPID);

prompt
prompt Creating table HR_BUSINESS
prompt ==========================
prompt
create table HR_BUSINESS
(
  biz_no         NUMBER not null,
  biz_id         VARCHAR2(20) not null,
  biz_name       VARCHAR2(50) not null,
  biz_en_name    VARCHAR2(50),
  description    VARCHAR2(200),
  post_group_id  VARCHAR2(10),
  post_column_id VARCHAR2(20),
  post_grade_id  VARCHAR2(20),
  post_id        VARCHAR2(20),
  position_id    VARCHAR2(20),
  create_date    DATE,
  created_by     VARCHAR2(20),
  update_date    DATE,
  updated_by     VARCHAR2(20),
  orderno        NUMBER(10),
  activity       NUMBER(1),
  cpny_id        VARCHAR2(20)
)
;
comment on table HR_BUSINESS
  is 'ְְ����Ϣ��';
alter table HR_BUSINESS
  add constraint PK_HR_BUSINESS primary key (BIZ_ID);

prompt
prompt Creating table HR_COMPANY
prompt =========================
prompt
create table HR_COMPANY
(
  cpny_id         VARCHAR2(10) not null,
  cpny_location   VARCHAR2(20),
  cpny_name       VARCHAR2(50) not null,
  cpny_en_name    VARCHAR2(50),
  cpny_addr       VARCHAR2(100),
  cpny_postalcode VARCHAR2(10),
  cpny_intro      VARCHAR2(2000),
  cpny_history    VARCHAR2(2000),
  cpny_web_addr   VARCHAR2(100),
  cpny_tel_no     VARCHAR2(20),
  cpny_fax_no     VARCHAR2(20),
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  orderno         NUMBER(10),
  activity        NUMBER(1),
  cpny_tel_no1    VARCHAR2(20)
)
;
comment on table HR_COMPANY
  is '��˾��Ϣ';
comment on column HR_COMPANY.cpny_id
  is '��˾ID';
comment on column HR_COMPANY.cpny_location
  is '��ַλ��';
comment on column HR_COMPANY.cpny_name
  is '��˾����';
comment on column HR_COMPANY.cpny_addr
  is '��Ϣ��ַ';
comment on column HR_COMPANY.cpny_postalcode
  is '��������';
comment on column HR_COMPANY.cpny_intro
  is '��˾���';
comment on column HR_COMPANY.cpny_history
  is '��˾��ʷ';
comment on column HR_COMPANY.cpny_web_addr
  is '��˾��վ';
comment on column HR_COMPANY.cpny_tel_no
  is '�绰';
comment on column HR_COMPANY.cpny_fax_no
  is '����';
comment on column HR_COMPANY.cpny_tel_no1
  is '�绰1';
alter table HR_COMPANY
  add constraint PK_HR_COMPANY primary key (CPNY_ID);

prompt
prompt Creating table HR_CONTRACT
prompt ==========================
prompt
create table HR_CONTRACT
(
  contract_no         NUMBER(10),
  empid               VARCHAR2(20) not null,
  total_period        NUMBER(10),
  contract_type_code  VARCHAR2(20),
  contract_cont_code  VARCHAR2(20),
  contract_kind_code  VARCHAR2(20),
  start_contract_date DATE,
  end_contract_date   DATE,
  first_contract_date DATE,
  next_contract_date  DATE,
  remark              VARCHAR2(200),
  renewable           NUMBER(10),
  create_date         DATE,
  created_by          VARCHAR2(20),
  update_date         DATE,
  updated_by          VARCHAR2(20),
  orderno             NUMBER(10),
  activity            NUMBER(1)
)
;
comment on table HR_CONTRACT
  is '��ͬ��Ϣ';
comment on column HR_CONTRACT.total_period
  is '���ڼ����';
comment on column HR_CONTRACT.contract_type_code
  is '��ͬ����';
comment on column HR_CONTRACT.contract_kind_code
  is '��ͬ����';
comment on column HR_CONTRACT.renewable
  is '��ǩ���';
create unique index PK_HR_CONTRACT on HR_CONTRACT (CONTRACT_NO);

prompt
prompt Creating table HR_CONTRACT_APPENDIX
prompt ===================================
prompt
create table HR_CONTRACT_APPENDIX
(
  appendix_no        NUMBER(10),
  contract_no        NUMBER(10),
  empid              VARCHAR2(20) not null,
  original_file_name VARCHAR2(200),
  modified_file_name VARCHAR2(200),
  file_suffix        VARCHAR2(20),
  remark             VARCHAR2(200),
  create_date        DATE,
  created_by         VARCHAR2(20),
  update_date        DATE,
  updated_by         VARCHAR2(20),
  orderno            NUMBER(10),
  activity           NUMBER(1)
)
;
comment on table HR_CONTRACT_APPENDIX
  is '��ͬ����';
create unique index PK_HR_CONTRACT_APPENDIX on HR_CONTRACT_APPENDIX (APPENDIX_NO);

prompt
prompt Creating table HR_DEPARTMENT
prompt ============================
prompt
create table HR_DEPARTMENT
(
  deptno         NUMBER,
  deptid         VARCHAR2(20) not null,
  deptname       VARCHAR2(100),
  dept_en_name   VARCHAR2(100),
  cpny_id        VARCHAR2(10),
  date_created   DATE,
  date_ended     DATE,
  parent_dept_id VARCHAR2(20),
  dept_level     NUMBER(1),
  manager_emp_id VARCHAR2(20),
  deptcode       VARCHAR2(20),
  area_code      VARCHAR2(20),
  description    VARCHAR2(200),
  create_date    DATE,
  created_by     VARCHAR2(20),
  update_date    DATE,
  updated_by     VARCHAR2(20),
  orderno        NUMBER(10),
  activity       NUMBER(1),
  set_app        VARCHAR2(20)
)
;
comment on table HR_DEPARTMENT
  is '���ű�';
comment on column HR_DEPARTMENT.deptno
  is 'SEQ';
comment on column HR_DEPARTMENT.deptid
  is '����ID';
comment on column HR_DEPARTMENT.deptname
  is '��������';
comment on column HR_DEPARTMENT.dept_en_name
  is 'Ӣ������';
comment on column HR_DEPARTMENT.cpny_id
  is '��˾ID';
comment on column HR_DEPARTMENT.date_created
  is '��������';
comment on column HR_DEPARTMENT.date_ended
  is '��������';
comment on column HR_DEPARTMENT.parent_dept_id
  is '��������ID';
comment on column HR_DEPARTMENT.dept_level
  is '���ŵȼ�';
comment on column HR_DEPARTMENT.manager_emp_id
  is '���Ź�����ID';
comment on column HR_DEPARTMENT.deptcode
  is '�������';
comment on column HR_DEPARTMENT.area_code
  is '��������';
comment on column HR_DEPARTMENT.description
  is '����';
create index HR_DEPT_PRENT_ID_INX on HR_DEPARTMENT (PARENT_DEPT_ID);
alter table HR_DEPARTMENT
  add constraint PK_HR_DEPARTMENT primary key (DEPTID);

prompt
prompt Creating table HR_DEPT_QUOTA
prompt ============================
prompt
create table HR_DEPT_QUOTA
(
  deptid       VARCHAR2(20),
  position_id  VARCHAR2(20),
  quota_number NUMBER(4) default 0,
  cpny_id      VARCHAR2(20),
  created_by   VARCHAR2(20),
  create_date  DATE,
  updated_by   VARCHAR2(20),
  update_date  DATE,
  activity     NUMBER(1),
  description  VARCHAR2(200),
  post_id      VARCHAR2(20)
)
;

prompt
prompt Creating table HR_DISPATCH
prompt ==========================
prompt
create table HR_DISPATCH
(
  disp_no       NUMBER not null,
  trans_no      VARCHAR2(40),
  trans_code    VARCHAR2(20),
  empid         VARCHAR2(20),
  deptid        VARCHAR2(20),
  contents      VARCHAR2(1000),
  start_date    DATE,
  end_date      DATE,
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  activity      NUMBER(1),
  dis_type_code VARCHAR2(20),
  dis_target    VARCHAR2(50),
  remark        VARCHAR2(50),
  affirm_flag   VARCHAR2(20),
  status_code   VARCHAR2(20),
  cancel_remark VARCHAR2(200),
  cpny_id       VARCHAR2(20),
  executed      NUMBER(1) default 0
)
;
comment on table HR_DISPATCH
  is '��ǲ';
comment on column HR_DISPATCH.trans_no
  is '�������';
comment on column HR_DISPATCH.trans_code
  is '��������';
comment on column HR_DISPATCH.contents
  is '��ǲ��';
comment on column HR_DISPATCH.affirm_flag
  is '״̬';
comment on column HR_DISPATCH.status_code
  is 'Ա��״̬';
comment on column HR_DISPATCH.cpny_id
  is '��˾���';
alter table HR_DISPATCH
  add constraint PK_HR_DISPATCH primary key (DISP_NO);
alter table HR_DISPATCH
  add constraint UK_HR_DISPATCH unique (TRANS_CODE, EMPID, START_DATE);

prompt
prompt Creating table HR_DOCUMENT
prompt ==========================
prompt
create table HR_DOCUMENT
(
  doc_no        NUMBER(10) not null,
  empid         VARCHAR2(20) not null,
  doc_type_code VARCHAR2(100),
  doc_id        VARCHAR2(20),
  obtained_date DATE,
  sign_dept     VARCHAR2(200) not null,
  content       VARCHAR2(200),
  address       VARCHAR2(20),
  grade         VARCHAR2(20),
  start_date    DATE,
  end_date      DATE,
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  orderno       NUMBER(10),
  activity      NUMBER(1),
  remark        VARCHAR2(200)
)
;
comment on table HR_DOCUMENT
  is '֤����Ϣ';
comment on column HR_DOCUMENT.doc_type_code
  is '֤������';
comment on column HR_DOCUMENT.doc_id
  is '֤�����';
comment on column HR_DOCUMENT.obtained_date
  is '�����';
comment on column HR_DOCUMENT.sign_dept
  is '���λ';
comment on column HR_DOCUMENT.start_date
  is '��ʼ����';
comment on column HR_DOCUMENT.end_date
  is '��������';
alter table HR_DOCUMENT
  add constraint HR_DOCUMENT primary key (DOC_NO);

prompt
prompt Creating table HR_EDUCATION
prompt ===========================
prompt
create table HR_EDUCATION
(
  educ_no          NUMBER(10) not null,
  empid            VARCHAR2(20) not null,
  major_code       VARCHAR2(100),
  degree_code      VARCHAR2(20),
  edu_his_code     VARCHAR2(20),
  institution_name VARCHAR2(200) not null,
  content          VARCHAR2(2000),
  address          VARCHAR2(200),
  grade            VARCHAR2(200),
  start_date       DATE,
  end_date         DATE,
  create_date      DATE,
  created_by       VARCHAR2(20),
  update_date      DATE,
  updated_by       VARCHAR2(20),
  orderno          NUMBER(10),
  activity         NUMBER(1),
  remark           VARCHAR2(2000)
)
;
comment on column HR_EDUCATION.major_code
  is 'רҵ';
comment on column HR_EDUCATION.degree_code
  is 'ѧλ';
comment on column HR_EDUCATION.edu_his_code
  is 'ѧ��';
comment on column HR_EDUCATION.institution_name
  is 'ѧУ��';
comment on column HR_EDUCATION.content
  is '�γ�����';
comment on column HR_EDUCATION.grade
  is '�ȼ�';
comment on column HR_EDUCATION.start_date
  is '��ʼʱ��';
comment on column HR_EDUCATION.end_date
  is '��������';
alter table HR_EDUCATION
  add constraint HR_EDUCTION primary key (EDUC_NO);

prompt
prompt Creating table HR_EMP_BINARY_PHOTO
prompt ==================================
prompt
create table HR_EMP_BINARY_PHOTO
(
  empid        VARCHAR2(20) not null,
  binary_photo BLOB,
  create_date  DATE,
  created_by   VARCHAR2(20),
  update_date  DATE,
  updated_by   VARCHAR2(20),
  activity     NUMBER(1)
)
;

prompt
prompt Creating table HR_EMP_BUSINESS
prompt ==============================
prompt
create table HR_EMP_BUSINESS
(
  empid       VARCHAR2(20) not null,
  biz_code    VARCHAR2(20) not null,
  start_date  DATE not null,
  end_date    DATE,
  create_date DATE,
  created_by  VARCHAR2(20),
  update_date DATE,
  updated_by  VARCHAR2(20),
  orderno     NUMBER,
  activity    NUMBER
)
;
comment on table HR_EMP_BUSINESS
  is 'Ա������ҵ���';
alter table HR_EMP_BUSINESS
  add primary key (EMPID, BIZ_CODE, START_DATE);

prompt
prompt Creating table HR_EMP_INFO
prompt ==========================
prompt
create table HR_EMP_INFO
(
  empid         VARCHAR2(20) not null,
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  activity      NUMBER(1),
  orderno       NUMBER(10),
  ssn           VARCHAR2(20),
  hafn          VARCHAR2(20),
  shift_code    VARCHAR2(20),
  supplier_code VARCHAR2(20),
  si_remark     VARCHAR2(2000),
  added_infor1  VARCHAR2(1000),
  added_infor2  VARCHAR2(1000),
  fund_remark   VARCHAR2(2000)
)
;
comment on table HR_EMP_INFO
  is 'Ա����Ϣ��';
comment on column HR_EMP_INFO.ssn
  is '#��ᱣ�ձ��';
comment on column HR_EMP_INFO.hafn
  is '#ס����������';
comment on column HR_EMP_INFO.shift_code
  is '#��������';
comment on column HR_EMP_INFO.supplier_code
  is '#��Ӧ��λ';
comment on column HR_EMP_INFO.si_remark
  is '�籣˵��';
comment on column HR_EMP_INFO.added_infor1
  is '�����ֶ�1';
comment on column HR_EMP_INFO.added_infor2
  is '�����ֶ�2';
comment on column HR_EMP_INFO.fund_remark
  is '������˵��';
alter table HR_EMP_INFO
  add constraint PK_HR_EMP_INFO primary key (EMPID);

prompt
prompt Creating table HR_EMP_PA_INFO
prompt =============================
prompt
create table HR_EMP_PA_INFO
(
  pa_no          NUMBER not null,
  empid          VARCHAR2(20) not null,
  cost_center    VARCHAR2(15),
  vender_code    VARCHAR2(15),
  bank_code      VARCHAR2(60),
  bank_area_code VARCHAR2(50),
  bank_city_code VARCHAR2(50),
  card_no        VARCHAR2(200),
  card_name      VARCHAR2(200),
  calc_flag      VARCHAR2(4) not null,
  remark         VARCHAR2(200),
  create_date    DATE,
  created_by     VARCHAR2(20),
  update_date    DATE,
  updated_by     VARCHAR2(20),
  activity       NUMBER(1),
  orderno        NUMBER(10),
  cpny_id        VARCHAR2(20)
)
;
comment on table HR_EMP_PA_INFO
  is 'Ա���ʻ���Ϣ';
alter table HR_EMP_PA_INFO
  add constraint PK_HR_EMP_PA_INFO primary key (PA_NO);
alter table HR_EMP_PA_INFO
  add constraint UK_HR_EMP_PA_INFO unique (EMPID, CARD_NO, BANK_CODE);

prompt
prompt Creating table HR_EMP_STATUS_HISTORY
prompt ====================================
prompt
create table HR_EMP_STATUS_HISTORY
(
  empid           VARCHAR2(20) not null,
  deptid          VARCHAR2(20),
  date_str        VARCHAR2(10) not null,
  position_code   VARCHAR2(20),
  post_code       VARCHAR2(20),
  post_grade_code VARCHAR2(20),
  status_code     VARCHAR2(20),
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  activity        NUMBER(1),
  data_no         NUMBER,
  biz_str         VARCHAR2(500),
  area            VARCHAR2(20)
)
;
alter table HR_EMP_STATUS_HISTORY
  add primary key (EMPID, DATE_STR);

prompt
prompt Creating table HR_EMP_STATUS_HISTORY_TEST
prompt =========================================
prompt
create table HR_EMP_STATUS_HISTORY_TEST
(
  empid           VARCHAR2(20) not null,
  deptid          VARCHAR2(20),
  date_str        VARCHAR2(10) not null,
  position_code   VARCHAR2(20),
  post_code       VARCHAR2(20),
  post_grade_code VARCHAR2(20),
  status_code     VARCHAR2(20),
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  activity        NUMBER(1),
  data_no         NUMBER,
  biz_str         VARCHAR2(500),
  area            VARCHAR2(20)
)
;
alter table HR_EMP_STATUS_HISTORY_TEST
  add primary key (EMPID, DATE_STR);
alter table HR_EMP_STATUS_HISTORY_TEST
  add foreign key (EMPID)
  references HR_EMPLOYEE (EMPID);

prompt
prompt Creating table HR_EXPERIENCE_INSIDE
prompt ===================================
prompt
create table HR_EXPERIENCE_INSIDE
(
  exp_inside_no             NUMBER(10) not null,
  trans_no                  VARCHAR2(40),
  trans_code                VARCHAR2(20),
  empid                     VARCHAR2(20) not null,
  deptid                    VARCHAR2(20),
  position_id               VARCHAR2(20),
  duty_code                 VARCHAR2(20),
  post_id                   VARCHAR2(20),
  post_grade_id             VARCHAR2(20),
  post_coef                 VARCHAR2(20),
  post_column_code          VARCHAR2(20),
  post_grade_level_code     VARCHAR2(20),
  post_group_id             VARCHAR2(20),
  status_code               VARCHAR2(20),
  start_date                DATE not null,
  end_date                  DATE,
  end_probation_date        DATE,
  join_type_code            VARCHAR2(20),
  emp_type_code             VARCHAR2(20),
  remark                    VARCHAR2(200),
  pre_deptid                VARCHAR2(20),
  pre_position_id           VARCHAR2(20),
  pre_duty_code             VARCHAR2(20),
  pre_post_id               VARCHAR2(20),
  pre_post_grade_id         VARCHAR2(20),
  pre_post_coef             VARCHAR2(20),
  pre_post_column_code      VARCHAR2(20),
  pre_post_grade_level_code VARCHAR2(20),
  pre_post_group_id         VARCHAR2(20),
  pre_status_code           VARCHAR2(20),
  pre_join_type_code        VARCHAR2(20),
  pre_emp_type_code         VARCHAR2(20),
  create_date               DATE,
  created_by                VARCHAR2(20),
  update_date               DATE,
  updated_by                VARCHAR2(20),
  activity                  NUMBER(1) default 1,
  affirm_flag               NUMBER(1) default 0,
  orderno                   NUMBER(1),
  cancel_remark             VARCHAR2(200),
  cpny_id                   VARCHAR2(20),
  executed                  NUMBER(1) default 0,
  processid                 VARCHAR2(20),
  positionaltitle           VARCHAR2(20),
  post_level_id             VARCHAR2(20),
  pre_post_level_id         VARCHAR2(20)
)
;
comment on table HR_EXPERIENCE_INSIDE
  is '���ھ�����
ְ��仯
ְ������
���ŵ���';
comment on column HR_EXPERIENCE_INSIDE.trans_no
  is '����������';
comment on column HR_EXPERIENCE_INSIDE.trans_code
  is '��������(������������)';
comment on column HR_EXPERIENCE_INSIDE.position_id
  is 'ְλ';
comment on column HR_EXPERIENCE_INSIDE.post_id
  is 'ְ����루added by liuzhengyang 2010-9-1��';
comment on column HR_EXPERIENCE_INSIDE.post_grade_id
  is 'ְ��ȼ�';
comment on column HR_EXPERIENCE_INSIDE.post_group_id
  is 'ְȺ���루added by liuzhengyang 2010-9-1��';
comment on column HR_EXPERIENCE_INSIDE.remark
  is '��ע';
comment on column HR_EXPERIENCE_INSIDE.activity
  is 'ɾ�����';
comment on column HR_EXPERIENCE_INSIDE.cpny_id
  is '��˾���';
comment on column HR_EXPERIENCE_INSIDE.executed
  is '������������Ƿ���Ч: 0δ��Ч 1����Ч';
comment on column HR_EXPERIENCE_INSIDE.processid
  is '����ID';
comment on column HR_EXPERIENCE_INSIDE.positionaltitle
  is 'ְ��';
create index IDX_HR_EXP_INS_TYPE_EMP on HR_EXPERIENCE_INSIDE (TRANS_CODE, EMPID);
create index IDX_HR_EXP_TRANS_EMP_DATE on HR_EXPERIENCE_INSIDE (TRANS_CODE, EMPID, START_DATE);
alter table HR_EXPERIENCE_INSIDE
  add primary key (EXP_INSIDE_NO);

prompt
prompt Creating table HR_EXPERIENCE_INSIDE_HISTORY
prompt ===========================================
prompt
create table HR_EXPERIENCE_INSIDE_HISTORY
(
  exp_inside_history_no NUMBER(10) not null,
  empid                 VARCHAR2(20) not null,
  deptid                VARCHAR2(20),
  post_grade_code       VARCHAR2(20),
  position_code         VARCHAR2(20),
  status_code           VARCHAR2(20),
  trans_no              NUMBER,
  post_group_code       VARCHAR2(50),
  post_code             VARCHAR2(50)
)
;
comment on column HR_EXPERIENCE_INSIDE_HISTORY.post_group_code
  is 'ְȺ���루added by liuzhengyang 2010-9-1��';
comment on column HR_EXPERIENCE_INSIDE_HISTORY.post_code
  is 'ְ����루added by liuzhengyang 2010-9-1��';
alter table HR_EXPERIENCE_INSIDE_HISTORY
  add primary key (EXP_INSIDE_HISTORY_NO);

prompt
prompt Creating table HR_FAMILY
prompt ========================
prompt
create table HR_FAMILY
(
  family_no            NUMBER(10),
  empid                VARCHAR2(20) not null,
  fam_type_code        VARCHAR2(20) not null,
  fam_name             VARCHAR2(40) not null,
  fam_name_pinyin      VARCHAR2(50),
  fam_borndate         DATE,
  fam_idcard           VARCHAR2(30),
  fam_edu_his_code     VARCHAR2(50),
  fam_occup_code       VARCHAR2(20),
  fam_nationality_code VARCHAR2(20),
  fam_home_addr        VARCHAR2(100),
  fam_phone            VARCHAR2(20),
  fam_company_name     VARCHAR2(100),
  create_date          DATE,
  created_by           VARCHAR2(20),
  update_date          DATE,
  updated_by           VARCHAR2(20),
  orderno              NUMBER(10),
  activity             NUMBER(1),
  fam_position         VARCHAR2(50),
  remark               VARCHAR2(100),
  live_yn              VARCHAR2(20)
)
;
comment on table HR_FAMILY
  is '����ϵ';
comment on column HR_FAMILY.fam_type_code
  is '��ϵ';
comment on column HR_FAMILY.fam_borndate
  is '��������';
comment on column HR_FAMILY.fam_idcard
  is '���֤��';
comment on column HR_FAMILY.fam_edu_his_code
  is 'ѧ��';
comment on column HR_FAMILY.fam_occup_code
  is '����';
comment on column HR_FAMILY.fam_nationality_code
  is '����';
comment on column HR_FAMILY.fam_home_addr
  is '�����ص�';
comment on column HR_FAMILY.fam_phone
  is '�绰';
comment on column HR_FAMILY.fam_company_name
  is '������λ';
comment on column HR_FAMILY.fam_position
  is 'ְλ';
comment on column HR_FAMILY.remark
  is '��ע';
comment on column HR_FAMILY.live_yn
  is '�Ƿ�һͬ��ס';
alter table HR_FAMILY
  add constraint PK_HR_EMP_FAMILY primary key (EMPID, FAM_TYPE_CODE, FAM_NAME);

prompt
prompt Creating table HR_FILE
prompt ======================
prompt
create table HR_FILE
(
  file_emp_no            NUMBER(10),
  empid                  VARCHAR2(20) not null,
  file_no                VARCHAR2(10) not null,
  file_position_id       VARCHAR2(30),
  file_date              DATE,
  file_status_code       VARCHAR2(20),
  create_date            DATE,
  created_by             VARCHAR2(20),
  update_date            DATE,
  updated_by             VARCHAR2(20),
  orderno                NUMBER(10),
  activity               NUMBER(1),
  comments               VARCHAR2(150),
  file_located_institute VARCHAR2(50),
  file_out_info          VARCHAR2(100)
)
;
comment on table HR_FILE
  is '������';
alter table HR_FILE
  add constraint PK_HR_FILE primary key (EMPID);

prompt
prompt Creating table HR_GRADE_STANDARD
prompt ================================
prompt
create table HR_GRADE_STANDARD
(
  seq_standard_no NUMBER not null,
  deptid          VARCHAR2(10) not null,
  activity        NUMBER default 1,
  standard_1      VARCHAR2(10),
  standard_2      VARCHAR2(10),
  standard_3      VARCHAR2(10),
  standard_4      VARCHAR2(10),
  standard_5      VARCHAR2(10),
  standard_6      VARCHAR2(10),
  standard_7      VARCHAR2(10),
  standard_other  VARCHAR2(10),
  create_date     DATE,
  create_by       VARCHAR2(20),
  startdate_1     DATE,
  enddate_1       DATE,
  startdate_2     DATE,
  enddate_2       DATE,
  startdate_3     DATE,
  enddate_3       DATE,
  startdate_4     DATE,
  enddate_4       DATE,
  startdate_5     DATE,
  enddate_5       DATE,
  startdate_6     DATE,
  enddate_6       DATE,
  startdate_7     DATE,
  enddate_7       DATE,
  startdate_other DATE,
  enddate_other   DATE,
  standard_8      VARCHAR2(10),
  standard_9      VARCHAR2(10)
)
;

prompt
prompt Creating table HR_HEALTH
prompt ========================
prompt
create table HR_HEALTH
(
  health_no            NUMBER(10) not null,
  empid                VARCHAR2(20) not null,
  pmh                  VARCHAR2(20),
  check_yn_code        VARCHAR2(20),
  check_result_code    VARCHAR2(20),
  description          VARCHAR2(2000),
  physical_date        DATE not null,
  height               NUMBER(3) default 0,
  weight               NUMBER(3) default 0,
  shoulder_breadth     NUMBER(3) default 0,
  sleeve_length        NUMBER(3) default 0,
  coat_length          NUMBER(3) default 0,
  bust                 NUMBER(3) default 0,
  waist                NUMBER(3) default 0,
  hip                  NUMBER(3) default 0,
  trousers_length      NUMBER(3) default 0,
  skirt_length         NUMBER(3) default 0,
  shoe_size            NUMBER(3) default 0,
  l_eye_ucva           VARCHAR2(20),
  l_eye_cva            VARCHAR2(20),
  l_eye_disease        VARCHAR2(20),
  r_eye_ucva           VARCHAR2(20),
  r_eye_cva            VARCHAR2(20),
  r_eye_disease        VARCHAR2(20),
  color_vision_code    VARCHAR2(20),
  l_ear_audibility     VARCHAR2(20),
  l_ear_disease        VARCHAR2(20),
  r_ear_audibility     VARCHAR2(20),
  r_ear_disease        VARCHAR2(20),
  l_nose               VARCHAR2(20),
  r_nose               VARCHAR2(20),
  olfactory_code       VARCHAR2(20),
  breath               NUMBER(3),
  sphygmus             NUMBER(3),
  blood_pressure_mix   VARCHAR2(20),
  blood_pressure_max   VARCHAR2(20),
  cbc                  VARCHAR2(20),
  blood_type_code      VARCHAR2(20),
  rh                   VARCHAR2(20),
  growth_and_nutrition VARCHAR2(20),
  blood_sugar          VARCHAR2(20),
  ot                   VARCHAR2(20),
  pt                   VARCHAR2(20),
  hbsag                VARCHAR2(20),
  hbs                  VARCHAR2(20),
  hbeag                VARCHAR2(20),
  hbe                  VARCHAR2(20),
  hbc                  VARCHAR2(20),
  abdominal_check      VARCHAR2(20),
  remark               VARCHAR2(2000),
  create_date          DATE,
  created_by           VARCHAR2(20),
  update_date          DATE,
  updated_by           VARCHAR2(20),
  orderno              NUMBER(10),
  activity             NUMBER(1),
  cpny_id              VARCHAR2(20)
)
;
comment on table HR_HEALTH
  is '������Ϣ��';
comment on column HR_HEALTH.pmh
  is '������ʷ';
comment on column HR_HEALTH.check_yn_code
  is '������';
comment on column HR_HEALTH.check_result_code
  is '�����';
comment on column HR_HEALTH.description
  is '�������';
comment on column HR_HEALTH.physical_date
  is '�������';
comment on column HR_HEALTH.height
  is '��� cm';
comment on column HR_HEALTH.weight
  is '���� kg';
comment on column HR_HEALTH.shoulder_breadth
  is '��� cm';
comment on column HR_HEALTH.sleeve_length
  is '�䳤 cm ';
comment on column HR_HEALTH.coat_length
  is '�³� cm';
comment on column HR_HEALTH.bust
  is '��Χ cm';
comment on column HR_HEALTH.waist
  is '��Χ cm';
comment on column HR_HEALTH.hip
  is '��Χ cm';
comment on column HR_HEALTH.trousers_length
  is '�㳤 cm';
comment on column HR_HEALTH.skirt_length
  is 'ȹ�� cm';
comment on column HR_HEALTH.shoe_size
  is 'Ь�� cm';
comment on column HR_HEALTH.l_eye_ucva
  is '����������';
comment on column HR_HEALTH.l_eye_cva
  is '���������';
comment on column HR_HEALTH.l_eye_disease
  is '���ۼ�';
comment on column HR_HEALTH.r_eye_ucva
  is '����������';
comment on column HR_HEALTH.r_eye_cva
  is '�ҽ�������';
comment on column HR_HEALTH.r_eye_disease
  is '���ۼ�';
comment on column HR_HEALTH.color_vision_code
  is 'ɫ��';
comment on column HR_HEALTH.l_ear_audibility
  is '������';
comment on column HR_HEALTH.l_ear_disease
  is '�����';
comment on column HR_HEALTH.r_ear_audibility
  is '������';
comment on column HR_HEALTH.r_ear_disease
  is '�Ҷ���';
comment on column HR_HEALTH.l_nose
  is '�����';
comment on column HR_HEALTH.r_nose
  is '�ұ���';
comment on column HR_HEALTH.olfactory_code
  is '���';
comment on column HR_HEALTH.breath
  is '���� ��/��';
comment on column HR_HEALTH.sphygmus
  is '���� ��/��';
comment on column HR_HEALTH.blood_pressure_mix
  is '����ѹ';
comment on column HR_HEALTH.blood_pressure_max
  is '����ѹ';
comment on column HR_HEALTH.cbc
  is 'Ѫ����';
comment on column HR_HEALTH.blood_type_code
  is 'Ѫ��';
comment on column HR_HEALTH.rh
  is 'RHѪ��';
comment on column HR_HEALTH.growth_and_nutrition
  is '������Ӫ��';
comment on column HR_HEALTH.blood_sugar
  is 'Ѫ�ǣ�lotte:�ģ�';
comment on column HR_HEALTH.ot
  is '��lotte:�Σ�';
comment on column HR_HEALTH.pt
  is '��lotte:Ƣ��';
comment on column HR_HEALTH.hbsag
  is '��lotte:�Σ�';
comment on column HR_HEALTH.hbs
  is '��lotte:Ƥ����';
comment on column HR_HEALTH.hbeag
  is '��lotte:��͸��';
comment on column HR_HEALTH.hbe
  is '��lotte:���������';
comment on column HR_HEALTH.hbc
  is '��lotte:�ι��ܣ�';
comment on column HR_HEALTH.abdominal_check
  is '�������';
comment on column HR_HEALTH.remark
  is '��ע';
comment on column HR_HEALTH.cpny_id
  is '��˾���';
alter table HR_HEALTH
  add constraint PK_HR_HEALTH primary key (HEALTH_NO);

prompt
prompt Creating table HR_INTERVIEW
prompt ===========================
prompt
create table HR_INTERVIEW
(
  interview_no      NUMBER(10) not null,
  empid             VARCHAR2(20),
  deptid            VARCHAR2(20),
  post_grade_code   VARCHAR2(20),
  post_grade        VARCHAR2(20),
  interview_date    DATE,
  interview_content VARCHAR2(500),
  deptname          VARCHAR2(100),
  create_id         VARCHAR2(20),
  create_date       DATE,
  chinesename       VARCHAR2(20)
)
;
comment on table HR_INTERVIEW
  is '��̸��¼';
comment on column HR_INTERVIEW.deptid
  is '����ID';
comment on column HR_INTERVIEW.post_grade_code
  is 'ְ��ID';
comment on column HR_INTERVIEW.post_grade
  is 'ְ��';
comment on column HR_INTERVIEW.interview_date
  is '��̸����';
comment on column HR_INTERVIEW.interview_content
  is '��̸����';
comment on column HR_INTERVIEW.deptname
  is '��������';
comment on column HR_INTERVIEW.create_id
  is '��¼��';
comment on column HR_INTERVIEW.create_date
  is '��¼��������';
alter table HR_INTERVIEW
  add constraint PK_HR_INTERVIEW primary key (INTERVIEW_NO);

prompt
prompt Creating table HR_IT_LEVEL
prompt ==========================
prompt
create table HR_IT_LEVEL
(
  it_no          NUMBER(10) not null,
  empid          VARCHAR2(20),
  exam_type_code VARCHAR2(20),
  it_level_code  VARCHAR2(20),
  mark           VARCHAR2(10),
  obtained_date  DATE,
  create_date    DATE,
  created_by     VARCHAR2(20),
  update_date    DATE,
  updated_by     VARCHAR2(20),
  activity       NUMBER(1),
  it_institute   VARCHAR2(20),
  description    VARCHAR2(200),
  remark         VARCHAR2(200)
)
;
comment on table HR_IT_LEVEL
  is 'IT�ȼ�';
comment on column HR_IT_LEVEL.exam_type_code
  is 'IT������';
comment on column HR_IT_LEVEL.it_level_code
  is '�ȼ�';
comment on column HR_IT_LEVEL.mark
  is '����';
comment on column HR_IT_LEVEL.obtained_date
  is 'ȡ������';
comment on column HR_IT_LEVEL.it_institute
  is '֤������';
comment on column HR_IT_LEVEL.description
  is '����';
comment on column HR_IT_LEVEL.remark
  is '��ע';
alter table HR_IT_LEVEL
  add constraint PK_HR_IT_LEVEL primary key (IT_NO);

prompt
prompt Creating table HR_LANGUAGE_LEVEL
prompt ================================
prompt
create table HR_LANGUAGE_LEVEL
(
  language_no         NUMBER(10),
  empid               VARCHAR2(20) not null,
  language_type_code  VARCHAR2(20) not null,
  exam_type_code      VARCHAR2(20) not null,
  language_level_code VARCHAR2(20) not null,
  mark                VARCHAR2(10),
  date_obtained       DATE,
  language_location   VARCHAR2(50),
  language_card_no    VARCHAR2(50),
  lan_institute       VARCHAR2(100),
  create_date         DATE,
  created_by          VARCHAR2(20),
  update_date         DATE,
  updated_by          VARCHAR2(20),
  orderno             NUMBER(10),
  activity            NUMBER(1),
  description         VARCHAR2(200),
  remark              VARCHAR2(200)
)
;
comment on table HR_LANGUAGE_LEVEL
  is '�����';
comment on column HR_LANGUAGE_LEVEL.language_type_code
  is '��������';
comment on column HR_LANGUAGE_LEVEL.exam_type_code
  is '������';
comment on column HR_LANGUAGE_LEVEL.language_level_code
  is '�ȼ�';
comment on column HR_LANGUAGE_LEVEL.mark
  is '����';
comment on column HR_LANGUAGE_LEVEL.date_obtained
  is 'ȡ֤����';
comment on column HR_LANGUAGE_LEVEL.language_location
  is 'ȡ֤����';
comment on column HR_LANGUAGE_LEVEL.language_card_no
  is '֤���';
create unique index PK_HR_LANGUAGE_LEVEL on HR_LANGUAGE_LEVEL (LANGUAGE_NO);
alter table HR_LANGUAGE_LEVEL
  add constraint FK_EMP_LANGUAGE_LEVEL primary key (EMPID, LANGUAGE_TYPE_CODE, LANGUAGE_LEVEL_CODE);

prompt
prompt Creating table HR_MILITARY_SERVICE
prompt ==================================
prompt
create table HR_MILITARY_SERVICE
(
  military_no         NUMBER(10),
  empid               VARCHAR2(20) not null,
  military_status     NUMBER(1),
  military_type_code  VARCHAR2(20),
  military_level_code VARCHAR2(20),
  military_area_code  VARCHAR2(20),
  start_date          DATE not null,
  end_date            DATE,
  create_date         DATE,
  created_by          VARCHAR2(20),
  update_date         DATE,
  updated_by          VARCHAR2(20),
  orderno             NUMBER(10),
  activity            NUMBER(1)
)
;
comment on table HR_MILITARY_SERVICE
  is '������Ϣ��';
comment on column HR_MILITARY_SERVICE.military_type_code
  is '����';
comment on column HR_MILITARY_SERVICE.military_level_code
  is '����';
comment on column HR_MILITARY_SERVICE.military_area_code
  is '����';
comment on column HR_MILITARY_SERVICE.start_date
  is '���ۿ�ʼ��';
comment on column HR_MILITARY_SERVICE.end_date
  is '���۽�����';
alter table HR_MILITARY_SERVICE
  add constraint PK_HR_MILITARY_SERVICE primary key (EMPID, START_DATE);

prompt
prompt Creating table HR_PERSONAL_INFO
prompt ===============================
prompt
create table HR_PERSONAL_INFO
(
  empid                 VARCHAR2(20) not null,
  degree_code           VARCHAR2(20),
  edu_his_code          VARCHAR2(20),
  major_code            VARCHAR2(20),
  gender_code           VARCHAR2(20),
  birthday              DATE,
  religion_code         VARCHAR2(20),
  nation_code           VARCHAR2(20),
  nationality_code      VARCHAR2(20),
  bornplace_code        VARCHAR2(20),
  polity_code           VARCHAR2(20),
  membership            VARCHAR2(20),
  marital_status_code   VARCHAR2(20),
  wedding_date          DATE,
  idcard_type_code      VARCHAR2(20),
  idcard_no             VARCHAR2(30),
  idcard_province       VARCHAR2(20),
  idcard_city           VARCHAR2(20),
  idcard_area           VARCHAR2(20),
  idcard_address        VARCHAR2(200),
  home_province         VARCHAR2(20),
  home_city             VARCHAR2(20),
  home_area             VARCHAR2(20),
  home_address          VARCHAR2(200),
  idcard_postalcode     VARCHAR2(10),
  home_postalcode       VARCHAR2(10),
  p_email               VARCHAR2(50),
  c_email               VARCHAR2(50),
  office_phone          VARCHAR2(40),
  home_phone            VARCHAR2(40),
  cellphone             VARCHAR2(40),
  fax                   VARCHAR2(20),
  file_relation_code    VARCHAR2(20),
  file_relation_address VARCHAR2(50),
  workage               NUMBER default 0,
  photopath             VARCHAR2(100),
  orderno               NUMBER(10),
  create_date           DATE,
  created_by            VARCHAR2(20),
  update_date           DATE,
  updated_by            VARCHAR2(20),
  activity              NUMBER(1),
  cpny_id               VARCHAR2(20),
  positionaltitle       VARCHAR2(20)
)
;
comment on table HR_PERSONAL_INFO
  is 'Ա��������Ϣ��';
comment on column HR_PERSONAL_INFO.empid
  is '����';
comment on column HR_PERSONAL_INFO.degree_code
  is 'ѧλ';
comment on column HR_PERSONAL_INFO.edu_his_code
  is 'ѧ��';
comment on column HR_PERSONAL_INFO.major_code
  is 'רҵ';
comment on column HR_PERSONAL_INFO.gender_code
  is '�Ա�';
comment on column HR_PERSONAL_INFO.birthday
  is '����';
comment on column HR_PERSONAL_INFO.religion_code
  is '�ڽ�����';
comment on column HR_PERSONAL_INFO.nation_code
  is '����';
comment on column HR_PERSONAL_INFO.nationality_code
  is '����';
comment on column HR_PERSONAL_INFO.bornplace_code
  is '����';
comment on column HR_PERSONAL_INFO.polity_code
  is '������ò';
comment on column HR_PERSONAL_INFO.membership
  is '�����Ա';
comment on column HR_PERSONAL_INFO.marital_status_code
  is '����״��';
comment on column HR_PERSONAL_INFO.wedding_date
  is '�������';
comment on column HR_PERSONAL_INFO.idcard_type_code
  is '��������';
comment on column HR_PERSONAL_INFO.idcard_no
  is '#*���֤��';
comment on column HR_PERSONAL_INFO.idcard_province
  is '���֤��ַ';
comment on column HR_PERSONAL_INFO.idcard_city
  is '���֤��ַ';
comment on column HR_PERSONAL_INFO.idcard_area
  is '���֤��ַ';
comment on column HR_PERSONAL_INFO.idcard_address
  is '���֤��ַ';
comment on column HR_PERSONAL_INFO.home_province
  is '��ͥ��ַ';
comment on column HR_PERSONAL_INFO.home_city
  is '��ͥ��ַ';
comment on column HR_PERSONAL_INFO.home_area
  is '��ͥ��ַ';
comment on column HR_PERSONAL_INFO.home_address
  is '��ͥ��ַ';
comment on column HR_PERSONAL_INFO.idcard_postalcode
  is '�ʱ�';
comment on column HR_PERSONAL_INFO.home_postalcode
  is '�ʱ�';
comment on column HR_PERSONAL_INFO.p_email
  is '#��������';
comment on column HR_PERSONAL_INFO.c_email
  is '#��˾����';
comment on column HR_PERSONAL_INFO.office_phone
  is '�칫�ҵ绰';
comment on column HR_PERSONAL_INFO.home_phone
  is '��ͥ�绰/�̶��绰';
comment on column HR_PERSONAL_INFO.cellphone
  is '�ƶ��绰';
comment on column HR_PERSONAL_INFO.fax
  is '����';
comment on column HR_PERSONAL_INFO.file_relation_code
  is '������ϵ';
comment on column HR_PERSONAL_INFO.file_relation_address
  is '������ַ';
comment on column HR_PERSONAL_INFO.workage
  is '����(��)';
comment on column HR_PERSONAL_INFO.cpny_id
  is '��˾���';
comment on column HR_PERSONAL_INFO.positionaltitle
  is 'ְ��';
alter table HR_PERSONAL_INFO
  add constraint PK_HR_PERSONAL primary key (EMPID);

prompt
prompt Creating table HR_PLURALITY
prompt ===========================
prompt
create table HR_PLURALITY
(
  plu_no        NUMBER(10) not null,
  empid         VARCHAR2(20),
  trans_no      VARCHAR2(40),
  trans_code    VARCHAR2(20),
  reason        VARCHAR2(100),
  work_contents VARCHAR2(200),
  start_date    DATE,
  end_date      DATE,
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  activity      NUMBER(1),
  deptid        VARCHAR2(20),
  post_id       VARCHAR2(20),
  affirm_flag   NUMBER(1),
  remark        VARCHAR2(200),
  cancel_remark VARCHAR2(200),
  cpny_id       VARCHAR2(20),
  executed      NUMBER(1) default 0
)
;
comment on table HR_PLURALITY
  is '��ְ��';
comment on column HR_PLURALITY.trans_no
  is '�������';
comment on column HR_PLURALITY.trans_code
  is '��������';
comment on column HR_PLURALITY.reason
  is '��ְԭ��';
comment on column HR_PLURALITY.work_contents
  is '��ְ��������';
comment on column HR_PLURALITY.deptid
  is '��ְ����';
comment on column HR_PLURALITY.post_id
  is '��ְְλ';
comment on column HR_PLURALITY.cpny_id
  is '��˾ID';
alter table HR_PLURALITY
  add constraint PK_HR_CONCURRENT_POST primary key (PLU_NO);

prompt
prompt Creating table HR_POSITION
prompt ==========================
prompt
create table HR_POSITION
(
  position_no      NUMBER not null,
  position_id      VARCHAR2(20) not null,
  position_name    VARCHAR2(50) not null,
  position_en_name VARCHAR2(50),
  description      VARCHAR2(200),
  post_group_id    VARCHAR2(10),
  post_column_id   VARCHAR2(20),
  post_grade_id    VARCHAR2(20),
  post_id          VARCHAR2(20),
  create_date      DATE,
  created_by       VARCHAR2(20),
  update_date      DATE,
  updated_by       VARCHAR2(20),
  orderno          NUMBER(10),
  activity         NUMBER(1),
  cpny_id          VARCHAR2(20)
)
;
comment on table HR_POSITION
  is 'ְְ����Ϣ��';
alter table HR_POSITION
  add constraint PK_HR_POSITION primary key (POSITION_ID);

prompt
prompt Creating table HR_POST
prompt ======================
prompt
create table HR_POST
(
  post_no        NUMBER not null,
  post_id        VARCHAR2(20) not null,
  post_name      VARCHAR2(50) not null,
  post_en_name   VARCHAR2(50),
  description    VARCHAR2(200),
  post_group_id  VARCHAR2(10),
  post_column_id VARCHAR2(20),
  position_id    VARCHAR2(20),
  create_date    DATE,
  created_by     VARCHAR2(20),
  update_date    DATE,
  updated_by     VARCHAR2(20),
  orderno        NUMBER(10),
  activity       NUMBER(1),
  cpny_id        VARCHAR2(20)
)
;
comment on table HR_POST
  is 'ְλ��λ��Ϣ��';
alter table HR_POST
  add constraint PK_HR_POST primary key (POST_ID);

prompt
prompt Creating table HR_POST_COLUMN
prompt =============================
prompt
create table HR_POST_COLUMN
(
  post_column_no      NUMBER not null,
  post_column_id      VARCHAR2(10) not null,
  post_column_name    VARCHAR2(20) not null,
  post_column_en_name VARCHAR2(50),
  description         VARCHAR2(200),
  post_group_id       VARCHAR2(20),
  create_date         DATE,
  created_by          VARCHAR2(20),
  update_date         DATE,
  updated_by          VARCHAR2(20),
  orderno             NUMBER(10),
  activity            NUMBER(1),
  cpny_id             VARCHAR2(20) not null
)
;
comment on table HR_POST_COLUMN
  is 'ְ����Ϣ��';
alter table HR_POST_COLUMN
  add constraint PK_HR_POST_COLUMN primary key (POST_COLUMN_ID);

prompt
prompt Creating table HR_POST_GRADE
prompt ============================
prompt
create table HR_POST_GRADE
(
  post_grade_no      NUMBER not null,
  post_grade_id      VARCHAR2(20) not null,
  post_grade_name    VARCHAR2(50) not null,
  post_grade_en_name VARCHAR2(50),
  post_grade_value   VARCHAR2(30),
  description        VARCHAR2(200),
  post_group_id      VARCHAR2(20),
  post_column_id     VARCHAR2(20),
  create_date        DATE,
  created_by         VARCHAR2(20),
  update_date        DATE,
  updated_by         VARCHAR2(20),
  orderno            NUMBER(10),
  activity           NUMBER(1),
  cpny_id            VARCHAR2(20)
)
;
comment on table HR_POST_GRADE
  is 'ְ����Ϣ';
alter table HR_POST_GRADE
  add constraint PK_HR_POST_GRADE primary key (POST_GRADE_ID);

prompt
prompt Creating table HR_POST_GRADE_LEVEL
prompt ==================================
prompt
create table HR_POST_GRADE_LEVEL
(
  post_grade_level_id      VARCHAR2(20) not null,
  post_grade_level_no      NUMBER not null,
  post_grade_level_name    VARCHAR2(50) not null,
  post_grade_level_en_name VARCHAR2(50),
  post_grade_level_value   VARCHAR2(30),
  description              VARCHAR2(200),
  post_group_id            VARCHAR2(20),
  post_column_id           VARCHAR2(20),
  post_grade_id            VARCHAR2(20),
  create_date              DATE,
  created_by               VARCHAR2(20),
  update_date              DATE,
  updated_by               VARCHAR2(20),
  orderno                  NUMBER(10),
  activity                 NUMBER(1),
  cpny_id                  VARCHAR2(20)
)
;
alter table HR_POST_GRADE_LEVEL
  add constraint PK_HR_POST_GRADE_LEVEL primary key (POST_GRADE_LEVEL_ID);

prompt
prompt Creating table HR_POST_GROUP
prompt ============================
prompt
create table HR_POST_GROUP
(
  post_group_no      NUMBER not null,
  post_group_id      VARCHAR2(10) not null,
  post_group_name    VARCHAR2(50) not null,
  post_group_en_name VARCHAR2(50),
  description        VARCHAR2(200),
  create_date        DATE,
  created_by         VARCHAR2(20),
  update_date        DATE,
  updated_by         VARCHAR2(20),
  orderno            NUMBER(10),
  activity           NUMBER(6) not null,
  cpny_id            VARCHAR2(20) not null
)
;
comment on table HR_POST_GROUP
  is 'ְȺ��Ϣ��';
alter table HR_POST_GROUP
  add constraint PK_HR_POST_GROUP primary key (POST_GROUP_NO);
alter table HR_POST_GROUP
  add constraint UK_HR_POST_GROUP unique (POST_GROUP_ID);

prompt
prompt Creating table HR_POST_ID_LEVEL
prompt ===============================
prompt
create table HR_POST_ID_LEVEL
(
  post_id       VARCHAR2(20),
  post_grade_id VARCHAR2(20),
  basic_salary  NUMBER(10,2),
  kpi_salary    NUMBER(10,2),
  activity      NUMBER(1),
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  cpny_id       VARCHAR2(20)
)
;

prompt
prompt Creating table HR_POST_LEVEL
prompt ============================
prompt
create table HR_POST_LEVEL
(
  post_grade_no      NUMBER not null,
  post_grade_id      VARCHAR2(20) not null,
  post_grade_name    VARCHAR2(50) not null,
  post_grade_en_name VARCHAR2(50),
  post_grade_value   VARCHAR2(30),
  description        VARCHAR2(200),
  post_group_id      VARCHAR2(20),
  post_column_id     VARCHAR2(20),
  create_date        DATE,
  created_by         VARCHAR2(20),
  update_date        DATE,
  updated_by         VARCHAR2(20),
  orderno            NUMBER(10),
  activity           NUMBER(1),
  cpny_id            VARCHAR2(20)
)
;

prompt
prompt Creating table HR_POST_RECORDS
prompt ==============================
prompt
create table HR_POST_RECORDS
(
  no            NUMBER(10),
  empid         VARCHAR2(20),
  start_date    DATE,
  end_date      DATE,
  post_id       VARCHAR2(20),
  status_code   VARCHAR2(20),
  flag          NUMBER(1),
  activity      NUMBER(1),
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  post_level_id VARCHAR2(20),
  deptid        VARCHAR2(20)
)
;

prompt
prompt Creating table HR_PROBATION
prompt ===========================
prompt
create table HR_PROBATION
(
  probation_no            NUMBER(10),
  empid                   VARCHAR2(20) not null,
  probation_date          DATE,
  probation_mark          FLOAT,
  schedule_probation_date DATE,
  content                 VARCHAR2(100),
  create_date             DATE,
  created_by              VARCHAR2(20),
  update_date             DATE,
  updated_by              VARCHAR2(20),
  activity                NUMBER(10)
)
;
comment on table HR_PROBATION
  is '���ñ�';
alter table HR_PROBATION
  add constraint PK_HR_PROBATION primary key (EMPID);
alter table HR_PROBATION
  add unique (PROBATION_NO);
alter table HR_PROBATION
  add constraint FK_EMP_PROBATION foreign key (EMPID)
  references HR_EMPLOYEE (EMPID);

prompt
prompt Creating table HR_PUNISHMENT
prompt ============================
prompt
create table HR_PUNISHMENT
(
  punishment_no       NUMBER(10) not null,
  empid               VARCHAR2(20) not null,
  trans_no            VARCHAR2(20),
  trans_code          VARCHAR2(20),
  pun_type_code       VARCHAR2(20) not null,
  violation_type_code VARCHAR2(20),
  violation_type      VARCHAR2(100),
  punished_date       DATE not null,
  date_released       DATE,
  punisher_code       VARCHAR2(20),
  pun_reason          VARCHAR2(100),
  pun_result          VARCHAR2(100),
  create_date         DATE,
  created_by          VARCHAR2(20),
  update_date         DATE,
  updated_by          VARCHAR2(20),
  orderno             NUMBER(10),
  activity            NUMBER(1),
  remark              VARCHAR2(100),
  affirm_flag         NUMBER(1),
  cancel_remark       VARCHAR2(100),
  pun_amount          NUMBER(8,4),
  cpny_id             VARCHAR2(20),
  executed            NUMBER(1) default 0
)
;
comment on table HR_PUNISHMENT
  is '�ͽ���Ϣ��';
comment on column HR_PUNISHMENT.trans_no
  is '�������';
comment on column HR_PUNISHMENT.trans_code
  is '�������ʹ���';
comment on column HR_PUNISHMENT.pun_type_code
  is '�ͽ�����';
comment on column HR_PUNISHMENT.violation_type_code
  is 'Υ�����ʹ���';
comment on column HR_PUNISHMENT.violation_type
  is 'Υ������';
comment on column HR_PUNISHMENT.punished_date
  is '�ͽ�����';
comment on column HR_PUNISHMENT.date_released
  is '��������';
comment on column HR_PUNISHMENT.punisher_code
  is '�ͽ�Ȩ��';
comment on column HR_PUNISHMENT.pun_reason
  is '�ͽ�ԭ��';
comment on column HR_PUNISHMENT.pun_result
  is '�ͽ���';
comment on column HR_PUNISHMENT.pun_amount
  is '�ͽ���';
comment on column HR_PUNISHMENT.cpny_id
  is '��˾���';
alter table HR_PUNISHMENT
  add constraint PK_HR_PUNISHMENT primary key (PUNISHMENT_NO);

prompt
prompt Creating table HR_QUALIFICATION
prompt ===============================
prompt
create table HR_QUALIFICATION
(
  qual_no         NUMBER(10) not null,
  empid           VARCHAR2(20) not null,
  qual_type_code  VARCHAR2(20) not null,
  date_obtained   DATE,
  qual_grade_code VARCHAR2(50),
  qual_card_no    VARCHAR2(200),
  qual_location   VARCHAR2(200),
  mark            VARCHAR2(200),
  start_qual_date DATE,
  end_qual_date   DATE,
  qual_institute  VARCHAR2(2000),
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  orderno         NUMBER(10),
  activity        NUMBER(1),
  description     VARCHAR2(2000),
  remark          VARCHAR2(2000),
  cpny_id         VARCHAR2(20),
  qual_card_name  VARCHAR2(40),
  annual_date     DATE
)
;
comment on table HR_QUALIFICATION
  is '�ʸ�֤��';
comment on column HR_QUALIFICATION.qual_type_code
  is '#*֤������';
comment on column HR_QUALIFICATION.date_obtained
  is '#*�����';
comment on column HR_QUALIFICATION.qual_grade_code
  is '֤�鼶��';
comment on column HR_QUALIFICATION.qual_card_no
  is '#*֤����';
comment on column HR_QUALIFICATION.qual_location
  is '#*��֤����';
comment on column HR_QUALIFICATION.mark
  is '����';
comment on column HR_QUALIFICATION.start_qual_date
  is '��ʼ����';
comment on column HR_QUALIFICATION.end_qual_date
  is '#*��Ч��ֹ����';
comment on column HR_QUALIFICATION.description
  is '����';
comment on column HR_QUALIFICATION.remark
  is '��ע';
comment on column HR_QUALIFICATION.cpny_id
  is '��˾���';
comment on column HR_QUALIFICATION.qual_card_name
  is '֤������';
comment on column HR_QUALIFICATION.annual_date
  is '��������';
alter table HR_QUALIFICATION
  add primary key (QUAL_NO);
alter table HR_QUALIFICATION
  add constraint FK_EMP_QUALIFICATION foreign key (EMPID)
  references HR_EMPLOYEE (EMPID);

prompt
prompt Creating table HR_RESIGNATION
prompt =============================
prompt
create table HR_RESIGNATION
(
  resign_no          NUMBER(10),
  trans_no           VARCHAR2(40),
  trans_code         VARCHAR2(20),
  empid              VARCHAR2(20) not null,
  resign_type_code   VARCHAR2(20) not null,
  resign_reason_code VARCHAR2(20),
  resign_date        DATE not null,
  resign_reason      VARCHAR2(2000),
  new_company        VARCHAR2(200),
  resign_fine        VARCHAR2(20),
  remark             VARCHAR2(2000),
  prev_position_code VARCHAR2(20),
  prev_grade_code    VARCHAR2(20),
  prev_deptid        VARCHAR2(20),
  prev_salary        NUMBER(8,2),
  create_date        DATE,
  created_by         VARCHAR2(20),
  update_date        DATE,
  updated_by         VARCHAR2(20),
  orderno            NUMBER(10),
  activity           NUMBER(1),
  affirm_flag        NUMBER(1),
  cancel_remark      VARCHAR2(2000),
  cpny_id            VARCHAR2(20),
  processid          VARCHAR2(20),
  executed           NUMBER(1)
)
;
comment on table HR_RESIGNATION
  is '��ְ��';
comment on column HR_RESIGNATION.trans_no
  is '�������';
comment on column HR_RESIGNATION.trans_code
  is '��������';
comment on column HR_RESIGNATION.resign_type_code
  is '��ְ����';
comment on column HR_RESIGNATION.resign_reason_code
  is '��ְԭ��';
comment on column HR_RESIGNATION.resign_reason
  is '��ְ����';
comment on column HR_RESIGNATION.resign_fine
  is 'ΥԼ��';
comment on column HR_RESIGNATION.activity
  is 'ɾ�����';
comment on column HR_RESIGNATION.cpny_id
  is '��˾���';
comment on column HR_RESIGNATION.executed
  is '��� �����Ƿ���Ч:0 δ��Ч  1 ����Ч';
alter table HR_RESIGNATION
  add constraint PK_HR_RESIGNATION primary key (RESIGN_TYPE_CODE, EMPID, RESIGN_DATE)
  disable;
alter table HR_RESIGNATION
  add constraint FK_EMP_RESIGN foreign key (EMPID)
  references HR_EMPLOYEE (EMPID);

prompt
prompt Creating table HR_REWARD
prompt ========================
prompt
create table HR_REWARD
(
  reward_no             NUMBER(10),
  trans_no              VARCHAR2(40),
  trans_code            VARCHAR2(20),
  empid                 VARCHAR2(20) not null,
  reward_type_code      VARCHAR2(20) not null,
  reward_date           DATE not null,
  reward_contents       VARCHAR2(200),
  reward_sort_code      VARCHAR2(20),
  achievement_type_code VARCHAR2(20),
  reward_grade_code     VARCHAR2(20),
  reward_amount         NUMBER,
  reward_bonus          NUMBER(7),
  create_date           DATE,
  created_by            VARCHAR2(20),
  update_date           DATE,
  updated_by            VARCHAR2(20),
  orderno               NUMBER(10),
  activity              NUMBER(1),
  remark                VARCHAR2(200),
  affirm_flag           NUMBER(1),
  cancel_remark         VARCHAR2(200),
  cpny_id               VARCHAR2(20),
  reward_reason         VARCHAR2(200),
  executed              NUMBER(1) default 0
)
;
comment on table HR_REWARD
  is '������Ϣ��';
comment on column HR_REWARD.reward_type_code
  is '��������';
comment on column HR_REWARD.reward_date
  is '��������';
comment on column HR_REWARD.reward_contents
  is '��������';
comment on column HR_REWARD.reward_sort_code
  is '��������';
comment on column HR_REWARD.achievement_type_code
  is '�������ʹ���';
comment on column HR_REWARD.reward_grade_code
  is '��������';
comment on column HR_REWARD.reward_amount
  is '�������';
comment on column HR_REWARD.reward_bonus
  is '--����';
comment on column HR_REWARD.cpny_id
  is '��˾���';
comment on column HR_REWARD.reward_reason
  is '��������';
comment on column HR_REWARD.executed
  is '�Ƿ���Ч';

prompt
prompt Creating table HR_STUDYING
prompt ==========================
prompt
create table HR_STUDYING
(
  study_no           NUMBER(10),
  empid              VARCHAR2(20) not null,
  trans_no           VARCHAR2(40),
  trans_code         VARCHAR2(20),
  studying_type_code VARCHAR2(20),
  research_type_code VARCHAR2(20),
  institution_name   VARCHAR2(100),
  subject            VARCHAR2(100),
  degree_code        VARCHAR2(20),
  country            VARCHAR2(20),
  expense            NUMBER(10,2),
  period             DATE,
  start_date         DATE not null,
  end_date           DATE,
  study_contents     VARCHAR2(200),
  create_date        DATE,
  created_by         VARCHAR2(20),
  update_date        DATE,
  updated_by         VARCHAR2(20),
  orderno            NUMBER(10),
  activity           NUMBER(1)
)
;
comment on table HR_STUDYING
  is '������ѧ';
comment on column HR_STUDYING.trans_no
  is '�������';
comment on column HR_STUDYING.trans_code
  is '��������';
comment on column HR_STUDYING.studying_type_code
  is '��ѧ��';
comment on column HR_STUDYING.research_type_code
  is '��������';
comment on column HR_STUDYING.institution_name
  is '����';
comment on column HR_STUDYING.subject
  is 'רҵ';
comment on column HR_STUDYING.country
  is '����';
comment on column HR_STUDYING.expense
  is '����';
comment on column HR_STUDYING.period
  is '�������';
alter table HR_STUDYING
  add constraint PK_HR_STUDYING primary key (EMPID, START_DATE);
alter table HR_STUDYING
  add constraint FK_HR_EMP_STUDY foreign key (EMPID)
  references HR_EMPLOYEE (EMPID);

prompt
prompt Creating table HR_SUSPENSION
prompt ============================
prompt
create table HR_SUSPENSION
(
  suspend_no        NUMBER(10),
  trans_no          VARCHAR2(40),
  trans_code        VARCHAR2(20),
  empid             VARCHAR2(20) not null,
  suspend_type_code VARCHAR2(10) not null,
  start_date        DATE not null,
  end_date          DATE,
  suspend_reason    VARCHAR2(200),
  create_date       DATE,
  created_by        VARCHAR2(20),
  update_date       DATE,
  updated_by        VARCHAR2(20),
  orderno           NUMBER(10),
  activity          NUMBER(1),
  cancel_remark     VARCHAR2(200),
  cpny_id           VARCHAR2(20),
  affirm_flag       NUMBER(1)
)
;
comment on table HR_SUSPENSION
  is '��ְ��';
comment on column HR_SUSPENSION.suspend_type_code
  is '��ְ����';
comment on column HR_SUSPENSION.start_date
  is '��ʼ����';
comment on column HR_SUSPENSION.end_date
  is '��������';
comment on column HR_SUSPENSION.suspend_reason
  is '��ְԭ��';
comment on column HR_SUSPENSION.cpny_id
  is '��˾���';
comment on column HR_SUSPENSION.affirm_flag
  is '�Ƿ�ͬ��';
alter table HR_SUSPENSION
  add constraint PK_HR_SUSPENSION primary key (EMPID, START_DATE);
alter table HR_SUSPENSION
  add constraint FK_EMP_SUSPENSION foreign key (EMPID)
  references HR_EMPLOYEE (EMPID);

prompt
prompt Creating table HR_TRAINING_INSIDE
prompt =================================
prompt
create table HR_TRAINING_INSIDE
(
  train_in_no      NUMBER(10) not null,
  empid            VARCHAR2(20) not null,
  course_code      VARCHAR2(20),
  course_type_code VARCHAR2(20),
  place            VARCHAR2(200),
  mark             VARCHAR2(200),
  start_date       DATE,
  end_date         DATE,
  create_date      DATE,
  created_by       VARCHAR2(20),
  update_date      DATE,
  updated_by       VARCHAR2(20),
  orderno          NUMBER,
  activity         NUMBER(1)
)
;
comment on table HR_TRAINING_INSIDE
  is '˾�ڽ���';
comment on column HR_TRAINING_INSIDE.course_code
  is '�γ���';
comment on column HR_TRAINING_INSIDE.course_type_code
  is '�γ�����';
comment on column HR_TRAINING_INSIDE.place
  is '����';
comment on column HR_TRAINING_INSIDE.mark
  is '����';
alter table HR_TRAINING_INSIDE
  add constraint PK_HR_COMPANY_TRAINING primary key (TRAIN_IN_NO, EMPID);
alter table HR_TRAINING_INSIDE
  add constraint FK_HR_EMP_TRAIN_IN foreign key (EMPID)
  references HR_EMPLOYEE (EMPID);

prompt
prompt Creating table HR_TRAINING_OUTSIDE
prompt ==================================
prompt
create table HR_TRAINING_OUTSIDE
(
  train_out_no       NUMBER(10) not null,
  empid              VARCHAR2(20) not null,
  course_name        VARCHAR2(200),
  course_type_code   VARCHAR2(20),
  institution_name   VARCHAR2(200),
  place              VARCHAR2(200),
  mark               VARCHAR2(200),
  start_date         DATE,
  end_date           DATE,
  description        VARCHAR2(2000),
  remark             VARCHAR2(2000),
  create_date        DATE,
  created_by         VARCHAR2(20),
  update_date        DATE,
  updated_by         VARCHAR2(20),
  orderno            NUMBER,
  activity           NUMBER(1),
  class_hour         NUMBER(10),
  course_content     VARCHAR2(2000),
  teaching_methods   VARCHAR2(100),
  evaluation_methods VARCHAR2(100),
  teacher            VARCHAR2(20)
)
;
comment on table HR_TRAINING_OUTSIDE
  is '˾����ѵ';
comment on column HR_TRAINING_OUTSIDE.course_name
  is '�γ���';
comment on column HR_TRAINING_OUTSIDE.course_type_code
  is '�γ�����';
comment on column HR_TRAINING_OUTSIDE.place
  is '����';
comment on column HR_TRAINING_OUTSIDE.mark
  is '����';
alter table HR_TRAINING_OUTSIDE
  add constraint PK_HR_TRAIN_IN primary key (TRAIN_OUT_NO, EMPID);
alter table HR_TRAINING_OUTSIDE
  add constraint FK_HR_EMP_TRAIN_OUT foreign key (EMPID)
  references HR_EMPLOYEE (EMPID);

prompt
prompt Creating table HR_UPGRADE_INFO
prompt ==============================
prompt
create table HR_UPGRADE_INFO
(
  upgrade_type_id  VARCHAR2(20) not null,
  upgrade_type     VARCHAR2(30),
  upgrade_object   VARCHAR2(30),
  upgrade_flag     CHAR(1),
  salary_flag      CHAR(1),
  upgrade_standard VARCHAR2(100),
  upgrade_remark   VARCHAR2(100),
  create_date      DATE,
  created_by       VARCHAR2(20),
  update_date      DATE,
  updated_by       VARCHAR2(20),
  orderno          NUMBER(10),
  activity         NUMBER(1)
)
;
alter table HR_UPGRADE_INFO
  add constraint PK_HR_UPGRADE_INFO primary key (UPGRADE_TYPE_ID);

prompt
prompt Creating table HR_UPGRADE_HISTORY
prompt =================================
prompt
create table HR_UPGRADE_HISTORY
(
  upgrade_type_id     VARCHAR2(20) not null,
  empid               VARCHAR2(20) not null,
  prev_grade_code     VARCHAR2(20),
  current_grade_code  VARCHAR2(20) not null,
  available_from_date DATE not null,
  available_to_date   DATE,
  create_date         DATE,
  created_by          VARCHAR2(20),
  update_date         DATE,
  updated_by          VARCHAR2(20),
  orderno             NUMBER(10),
  activity            NUMBER(1)
)
;
alter table HR_UPGRADE_HISTORY
  add constraint PK_HR_UPGRADE_HISTORY primary key (UPGRADE_TYPE_ID, EMPID, AVAILABLE_FROM_DATE);
alter table HR_UPGRADE_HISTORY
  add constraint FK_EMP_UPGRADE_HIS foreign key (EMPID)
  references HR_EMPLOYEE (EMPID);
alter table HR_UPGRADE_HISTORY
  add constraint FK_HR_UPGRADE_INFO foreign key (UPGRADE_TYPE_ID)
  references HR_UPGRADE_INFO (UPGRADE_TYPE_ID);

prompt
prompt Creating table HR_WORK_EXPERIENCE
prompt =================================
prompt
create table HR_WORK_EXPERIENCE
(
  work_exper_no NUMBER(10) not null,
  empid         VARCHAR2(20),
  cpny_name     VARCHAR2(200),
  dept_name     VARCHAR2(200),
  position      VARCHAR2(200),
  leave_reason  VARCHAR2(2000),
  work_content  VARCHAR2(2000),
  post          VARCHAR2(200),
  grade         VARCHAR2(200),
  start_date    DATE,
  end_date      DATE,
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  orderno       NUMBER(10),
  activity      NUMBER(1)
)
;
comment on table HR_WORK_EXPERIENCE
  is '���������';
comment on column HR_WORK_EXPERIENCE.cpny_name
  is '��˾��';
comment on column HR_WORK_EXPERIENCE.dept_name
  is '������';
comment on column HR_WORK_EXPERIENCE.position
  is 'ְλ��';
comment on column HR_WORK_EXPERIENCE.leave_reason
  is '��ְ����';
comment on column HR_WORK_EXPERIENCE.start_date
  is '��ʼ����';
comment on column HR_WORK_EXPERIENCE.end_date
  is '��������';
alter table HR_WORK_EXPERIENCE
  add constraint PRIMARY_KEY primary key (WORK_EXPER_NO);

prompt
prompt Creating table INFO_TYPE
prompt ========================
prompt
create table INFO_TYPE
(
  type_no      NUMBER(10),
  type_id      VARCHAR2(20) not null,
  type_name    VARCHAR2(50),
  type_en_name VARCHAR2(50),
  activity     NUMBER,
  cpny_id      VARCHAR2(50)
)
;
alter table INFO_TYPE
  add constraint PK_INFO_TYPE primary key (TYPE_ID);

prompt
prompt Creating table INFO_TABLE
prompt =========================
prompt
create table INFO_TABLE
(
  table_no      NUMBER(38),
  table_id      VARCHAR2(50) not null,
  type_id       VARCHAR2(20),
  table_name    VARCHAR2(50),
  table_en_name VARCHAR2(50),
  activity      NUMBER(1),
  cpny_id       VARCHAR2(20)
)
;
alter table INFO_TABLE
  add constraint PK_INFO_TABLE primary key (TABLE_ID);
alter table INFO_TABLE
  add constraint FK_INFO_TABLE foreign key (TYPE_ID)
  references INFO_TYPE (TYPE_ID) on delete cascade;

prompt
prompt Creating table INFO_FIELD
prompt =========================
prompt
create table INFO_FIELD
(
  field_no      NUMBER(10) not null,
  field_id      VARCHAR2(50) not null,
  table_id      VARCHAR2(50) not null,
  field_name    VARCHAR2(50),
  field_en_name VARCHAR2(50),
  code          VARCHAR2(200),
  activity      NUMBER(1) not null,
  cpny_id       VARCHAR2(50) not null,
  orderno       NUMBER(10)
)
;
alter table INFO_FIELD
  add constraint PK_INFO_FIELD primary key (FIELD_ID, TABLE_ID);
alter table INFO_FIELD
  add constraint FK_INFO_FIELD foreign key (TABLE_ID)
  references INFO_TABLE (TABLE_ID) on delete cascade;

prompt
prompt Creating table INFO_FIELD_TEMP
prompt ==============================
prompt
create table INFO_FIELD_TEMP
(
  field_no      NUMBER(10) not null,
  field_id      VARCHAR2(50) not null,
  table_id      VARCHAR2(50) not null,
  field_name    VARCHAR2(50),
  field_en_name VARCHAR2(50),
  code          VARCHAR2(200),
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  orderno       NUMBER(10),
  activity      NUMBER(1) not null,
  cpny_id       VARCHAR2(50) not null
)
;
alter table INFO_FIELD_TEMP
  add constraint PK_INFO_FIELD_TEMP primary key (FIELD_ID, TABLE_ID);

prompt
prompt Creating table I_AR_ANNUAL_HOLIDAY
prompt ==================================
prompt
create table I_AR_ANNUAL_HOLIDAY
(
  holiday_no      NUMBER(10),
  empid           VARCHAR2(20),
  holiday_date    VARCHAR2(4),
  curr_y_holiday  NUMBER(3,1) default 0,
  spec_holiday    NUMBER(3,1) default 0,
  used_holiday    NUMBER(3,1) default 0,
  used_sp_holiday NUMBER(3,1) default 0,
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  order_no        NUMBER(10),
  activity        NUMBER(1)
)
;

prompt
prompt Creating table MAT_INFO
prompt =======================
prompt
create table MAT_INFO
(
  mat_id           VARCHAR2(20) not null,
  mat_name         VARCHAR2(100),
  mat_type_id      VARCHAR2(20),
  mat_unit_code    VARCHAR2(20),
  rough_weight     NUMBER(10),
  net_weight       NUMBER(10),
  weight_unit_code VARCHAR2(20),
  length           NUMBER(10),
  width            NUMBER(10),
  height           NUMBER(10),
  length_unit_code VARCHAR2(20),
  created_by       VARCHAR2(20),
  create_date      DATE,
  updated_by       VARCHAR2(20),
  update_date      DATE,
  activity         NUMBER(1),
  orderno          NUMBER,
  cpny_id          VARCHAR2(20),
  is_separated     NUMBER(1),
  remark           VARCHAR2(2000),
  mat_description  VARCHAR2(2000),
  mat_en_name      VARCHAR2(200),
  photopath        VARCHAR2(200),
  mat_no           NUMBER(10) not null,
  mat_status_id    VARCHAR2(20),
  old_name         VARCHAR2(200),
  bp_name          VARCHAR2(200),
  process_no       VARCHAR2(20)
)
;
comment on table MAT_INFO
  is '������Ϣ��';
comment on column MAT_INFO.mat_id
  is '���Ϻ�';
comment on column MAT_INFO.mat_name
  is '����';
comment on column MAT_INFO.mat_type_id
  is '����';
comment on column MAT_INFO.mat_unit_code
  is '���ϸ�����λ';
comment on column MAT_INFO.rough_weight
  is 'ë��';
comment on column MAT_INFO.net_weight
  is '����';
comment on column MAT_INFO.weight_unit_code
  is '������λ';
comment on column MAT_INFO.length
  is '��';
comment on column MAT_INFO.width
  is '��';
comment on column MAT_INFO.height
  is '��';
comment on column MAT_INFO.length_unit_code
  is '���ȵ�λ';
comment on column MAT_INFO.created_by
  is '������';
comment on column MAT_INFO.create_date
  is '��������';
comment on column MAT_INFO.updated_by
  is '������';
comment on column MAT_INFO.update_date
  is '��������';
comment on column MAT_INFO.activity
  is '�Ƿ񼤻�';
comment on column MAT_INFO.orderno
  is '����';
comment on column MAT_INFO.cpny_id
  is '��˾id';
comment on column MAT_INFO.is_separated
  is '�ܷ�ֳɸ�С�Ĳ���';
comment on column MAT_INFO.remark
  is '��ע';
comment on column MAT_INFO.mat_description
  is '����';
comment on column MAT_INFO.mat_en_name
  is 'Ӣ������';
comment on column MAT_INFO.photopath
  is 'ͼ��·��';
comment on column MAT_INFO.old_name
  is '������';
comment on column MAT_INFO.bp_name
  is '�ͻ�����';
comment on column MAT_INFO.process_no
  is '��˺�';
alter table MAT_INFO
  add constraint PK_MAT_INFO primary key (MAT_ID);
alter table MAT_INFO
  add constraint UK_MAT_INFO unique (MAT_NO);

prompt
prompt Creating table MAT_STOCK_INFO
prompt =============================
prompt
create table MAT_STOCK_INFO
(
  mat_stock_no       NUMBER(10) not null,
  mat_id             VARCHAR2(20),
  mat_storage_id     VARCHAR2(20),
  max_quantity       NUMBER(10),
  left_quantity      NUMBER(10),
  quantity_unit_code VARCHAR2(20),
  create_date        VARCHAR2(20),
  created_by         VARCHAR2(20),
  update_date        VARCHAR2(20),
  updated_by         VARCHAR2(20),
  activity           NUMBER(1),
  orderno            NUMBER(10),
  cpny_id            VARCHAR2(20)
)
;
comment on table MAT_STOCK_INFO
  is '���Ͽ���';
comment on column MAT_STOCK_INFO.mat_id
  is '��Ʒ';
comment on column MAT_STOCK_INFO.mat_storage_id
  is '�ֿ�';
comment on column MAT_STOCK_INFO.max_quantity
  is '�������';
comment on column MAT_STOCK_INFO.left_quantity
  is 'ʣ������';
comment on column MAT_STOCK_INFO.quantity_unit_code
  is '������λ��ͳһΪ֧��';
alter table MAT_STOCK_INFO
  add constraint PK_MAT_STOCK primary key (MAT_STOCK_NO);

prompt
prompt Creating table MAT_STOCK_RECORD
prompt ===============================
prompt
create table MAT_STOCK_RECORD
(
  mat_stock_rec_no   NUMBER(10) not null,
  mat_storage_id     VARCHAR2(20),
  mat_id             VARCHAR2(20),
  mat_quantity       NUMBER(10),
  type_code          VARCHAR2(20),
  order_id           VARCHAR2(20),
  create_date        DATE,
  created_by         VARCHAR2(20),
  activity           NUMBER(1),
  remark             VARCHAR2(200),
  quantity_unit_code VARCHAR2(20)
)
;
comment on table MAT_STOCK_RECORD
  is '���Ͽ���޸ļ�¼��';
comment on column MAT_STOCK_RECORD.mat_stock_rec_no
  is '����';
comment on column MAT_STOCK_RECORD.mat_storage_id
  is '�ֿ���';
comment on column MAT_STOCK_RECORD.mat_id
  is '��Ʒ��';
comment on column MAT_STOCK_RECORD.mat_quantity
  is '��Ʒ����';
comment on column MAT_STOCK_RECORD.type_code
  is '���ͣ����⡢��⣩';
comment on column MAT_STOCK_RECORD.order_id
  is '��Ӧ�Ķ�����';
comment on column MAT_STOCK_RECORD.quantity_unit_code
  is '��λ';
alter table MAT_STOCK_RECORD
  add constraint PK_MAT_STOCK_HISTORY primary key (MAT_STOCK_REC_NO);

prompt
prompt Creating table MAT_STORAGE_INFO
prompt ===============================
prompt
create table MAT_STORAGE_INFO
(
  mat_storage_no NUMBER(10) not null,
  mat_storage_id VARCHAR2(20),
  storage_name   VARCHAR2(100),
  place_code     VARCHAR2(20),
  address        VARCHAR2(200),
  remark         VARCHAR2(200),
  create_date    VARCHAR2(20),
  created_by     VARCHAR2(20),
  update_date    DATE,
  updated_by     VARCHAR2(20),
  activity       NUMBER(1),
  orderno        NUMBER(10),
  cpny_id        VARCHAR2(20),
  charger        VARCHAR2(20),
  begin_date     DATE,
  end_date       DATE
)
;
comment on table MAT_STORAGE_INFO
  is '���ϲֿ��';
comment on column MAT_STORAGE_INFO.mat_storage_no
  is '����������';
comment on column MAT_STORAGE_INFO.mat_storage_id
  is '�ֿ���';
comment on column MAT_STORAGE_INFO.storage_name
  is '�ֿ���';
comment on column MAT_STORAGE_INFO.place_code
  is '�ص㣨ͬ��˾���ţ�';
comment on column MAT_STORAGE_INFO.address
  is '��ϸ��ַ';
comment on column MAT_STORAGE_INFO.remark
  is '��ע';
comment on column MAT_STORAGE_INFO.charger
  is '������';
comment on column MAT_STORAGE_INFO.begin_date
  is '��ʼ����';
comment on column MAT_STORAGE_INFO.end_date
  is '��������';
alter table MAT_STORAGE_INFO
  add constraint PK_MAT_STORAGE primary key (MAT_STORAGE_NO);

prompt
prompt Creating table MOBILE_ADV
prompt =========================
prompt
create table MOBILE_ADV
(
  adv_no      VARCHAR2(20),
  adv_id      VARCHAR2(20),
  product_no  VARCHAR2(20),
  photopath   VARCHAR2(100),
  create_date DATE,
  created_by  VARCHAR2(20),
  update_date DATE,
  updated_by  VARCHAR2(20),
  activity    NUMBER(1),
  cpny_id     VARCHAR2(20)
)
;

prompt
prompt Creating table MOBILE_AREA
prompt ==========================
prompt
create table MOBILE_AREA
(
  m_area_no   VARCHAR2(20),
  m_area_id   VARCHAR2(20),
  m_area_name VARCHAR2(50),
  create_date DATE,
  created_by  VARCHAR2(20),
  update_date DATE,
  updated_by  VARCHAR2(20),
  activity    NUMBER(1),
  cpny_id     VARCHAR2(20),
  orderno     NUMBER
)
;

prompt
prompt Creating table MOBILE_AREA_PRODUCT
prompt ==================================
prompt
create table MOBILE_AREA_PRODUCT
(
  m_area_no   VARCHAR2(20),
  product_no  VARCHAR2(20),
  create_date DATE,
  created_by  VARCHAR2(20),
  update_date DATE,
  updated_by  VARCHAR2(20),
  activity    NUMBER(1),
  cpny_id     VARCHAR2(20)
)
;

prompt
prompt Creating table MOBILE_INVITATION
prompt ================================
prompt
create table MOBILE_INVITATION
(
  invitation_no VARCHAR2(20),
  invitation_id VARCHAR2(20),
  cust_no       VARCHAR2(20),
  bind_status   VARCHAR2(20),
  remark        VARCHAR2(100),
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  activity      NUMBER(1),
  cpny_id       VARCHAR2(20),
  use_status    VARCHAR2(10)
)
;
comment on column MOBILE_INVITATION.bind_status
  is '��״̬��bind0:δ�󶨣�bind1:�Ѱ󶨣�';
comment on column MOBILE_INVITATION.use_status
  is 'ʹ��״̬��use0:δʹ�ã�use1:��ʹ�ã�';

prompt
prompt Creating table ORD_ERROR_MESSAGE
prompt ================================
prompt
create table ORD_ERROR_MESSAGE
(
  code       VARCHAR2(20) not null,
  message    VARCHAR2(1000),
  en_message VARCHAR2(1000)
)
;
alter table ORD_ERROR_MESSAGE
  add constraint PK_ORD_ERROR_MSG primary key (CODE);

prompt
prompt Creating table SY_CODE
prompt ======================
prompt
create table SY_CODE
(
  code_no      NUMBER(10) not null,
  code_id      VARCHAR2(30) not null,
  code_name    VARCHAR2(50) not null,
  code_en_name VARCHAR2(50),
  description  VARCHAR2(200),
  parent_code  VARCHAR2(50),
  depth        NUMBER(10),
  create_date  DATE,
  created_by   VARCHAR2(20),
  update_date  DATE,
  updated_by   VARCHAR2(20),
  orderno      NUMBER(10),
  activity     NUMBER(1),
  cpny_id      VARCHAR2(20)
)
;
comment on table SY_CODE
  is 'CODE';
create index SY_CODE_PARENT on SY_CODE (PARENT_CODE);
alter table SY_CODE
  add constraint PK_SY_CODE primary key (CODE_ID);
alter table SY_CODE
  add constraint UK_SY_CODE unique (CODE_NO);

prompt
prompt Creating table ORD_ORDER_INFO
prompt =============================
prompt
create table ORD_ORDER_INFO
(
  order_no              NUMBER(10),
  order_id              VARCHAR2(20) not null,
  money_paid            NUMBER(20,4),
  money_paid_unit_code  VARCHAR2(20),
  verified_by           VARCHAR2(20),
  pro_quantity          NUMBER(10),
  busi_date             DATE,
  status_code           VARCHAR2(20),
  orderno               NUMBER(10),
  created_date          DATE,
  created_by            VARCHAR2(20),
  updated_date          DATE,
  updated_by            VARCHAR2(20),
  activity              NUMBER(1),
  remark                VARCHAR2(200),
  bill_id               NVARCHAR2(20),
  verified_date         DATE,
  cpny_id               VARCHAR2(10),
  del_remark            VARCHAR2(200),
  app_remark            VARCHAR2(200),
  ord_type_code         VARCHAR2(20),
  product_id            VARCHAR2(20),
  money_total           NUMBER(20,4),
  channel_id            VARCHAR2(20),
  money_total_unit_code VARCHAR2(20),
  sales_area_code       VARCHAR2(20),
  dist_channel_code     VARCHAR2(20),
  division_code         VARCHAR2(20),
  price                 NUMBER(10,2),
  price_unit_code       VARCHAR2(20),
  empid                 VARCHAR2(20),
  cust_id               VARCHAR2(20),
  province              VARCHAR2(20),
  city                  VARCHAR2(20),
  area                  VARCHAR2(20),
  address               VARCHAR2(200),
  salary                NUMBER(10,2)
)
;
comment on table ORD_ORDER_INFO
  is '������';
comment on column ORD_ORDER_INFO.order_no
  is '�б�ţ�Ψһ��';
comment on column ORD_ORDER_INFO.order_id
  is '�������';
comment on column ORD_ORDER_INFO.money_paid
  is '#�ɹ������Ѹ����';
comment on column ORD_ORDER_INFO.money_paid_unit_code
  is '#�ɹ�������λ';
comment on column ORD_ORDER_INFO.verified_by
  is '�����';
comment on column ORD_ORDER_INFO.pro_quantity
  is '��Ʒ����';
comment on column ORD_ORDER_INFO.busi_date
  is '�������ڣ�������';
comment on column ORD_ORDER_INFO.status_code
  is '����״̬';
comment on column ORD_ORDER_INFO.orderno
  is '��������У�������';
comment on column ORD_ORDER_INFO.created_date
  is '��������';
comment on column ORD_ORDER_INFO.created_by
  is '������';
comment on column ORD_ORDER_INFO.updated_date
  is '�����������';
comment on column ORD_ORDER_INFO.updated_by
  is '���������';
comment on column ORD_ORDER_INFO.activity
  is '�Ƿ񼤻�ɼ���';
comment on column ORD_ORDER_INFO.remark
  is '��ע';
comment on column ORD_ORDER_INFO.bill_id
  is '��Ʊ��ţ�������';
comment on column ORD_ORDER_INFO.verified_date
  is '�������';
comment on column ORD_ORDER_INFO.cpny_id
  is 'COMPANY ID(����)';
comment on column ORD_ORDER_INFO.del_remark
  is 'ɾ��ʱ�ı�ע';
comment on column ORD_ORDER_INFO.app_remark
  is '���ʱ�ı�ע';
comment on column ORD_ORDER_INFO.ord_type_code
  is '��������';
comment on column ORD_ORDER_INFO.product_id
  is '��Ʒ���';
comment on column ORD_ORDER_INFO.money_total
  is '�ܼ۸�';
comment on column ORD_ORDER_INFO.channel_id
  is '#�ɹ����������̱��';
comment on column ORD_ORDER_INFO.money_total_unit_code
  is '�����ܼۻ��ұ��';
comment on column ORD_ORDER_INFO.sales_area_code
  is '��������';
comment on column ORD_ORDER_INFO.dist_channel_code
  is '���۷�ʽ';
comment on column ORD_ORDER_INFO.division_code
  is '��Ʒ����';
comment on column ORD_ORDER_INFO.price
  is '@���۶�������';
comment on column ORD_ORDER_INFO.price_unit_code
  is '@���۶������ҵ�λ';
comment on column ORD_ORDER_INFO.empid
  is '@���۶����µ�ҵ��Ա';
comment on column ORD_ORDER_INFO.cust_id
  is '@���۶�������Ĺ˿�';
comment on column ORD_ORDER_INFO.province
  is 'ʡ';
comment on column ORD_ORDER_INFO.city
  is '��';
comment on column ORD_ORDER_INFO.area
  is '��';
comment on column ORD_ORDER_INFO.address
  is '��ַ';
comment on column ORD_ORDER_INFO.salary
  is '���ζ������';
alter table ORD_ORDER_INFO
  add constraint PK_ORD_ORDER_ID primary key (ORDER_ID);
alter table ORD_ORDER_INFO
  add constraint FK_ORD_MONEY1_ID foreign key (MONEY_TOTAL_UNIT_CODE)
  references SY_CODE (CODE_ID) on delete cascade;
alter table ORD_ORDER_INFO
  add constraint FK_ORD_MONEY_ID foreign key (MONEY_PAID_UNIT_CODE)
  references SY_CODE (CODE_ID) on delete cascade;
alter table ORD_ORDER_INFO
  add constraint FK_ORD_ORDER_STATE foreign key (STATUS_CODE)
  references SY_CODE (CODE_ID) on delete cascade;

prompt
prompt Creating table ORG_AREA_INFO
prompt ============================
prompt
create table ORG_AREA_INFO
(
  org_area_id      VARCHAR2(20) not null,
  org_area_code    VARCHAR2(20) not null,
  org_area_name    VARCHAR2(10),
  used             NUMBER(1) default 0,
  activity         NUMBER(1) default 1,
  org_area_en_name VARCHAR2(10)
)
;
comment on table ORG_AREA_INFO
  is '��������';
comment on column ORG_AREA_INFO.org_area_id
  is 'Ψһ���';
comment on column ORG_AREA_INFO.org_area_code
  is '�������';
comment on column ORG_AREA_INFO.org_area_name
  is '��������';
comment on column ORG_AREA_INFO.used
  is '�Ƿ�ռ��';
comment on column ORG_AREA_INFO.activity
  is '�Ƿ���ã��������';
comment on column ORG_AREA_INFO.org_area_en_name
  is '����Ӣ������';
alter table ORG_AREA_INFO
  add constraint PK_ID primary key (ORG_AREA_ID);
alter table ORG_AREA_INFO
  add constraint UK_CODE unique (ORG_AREA_CODE);

prompt
prompt Creating table PAY_TENEMENT_ALLOWANCE
prompt =====================================
prompt
create table PAY_TENEMENT_ALLOWANCE
(
  allowance_no        NUMBER(10),
  empid               VARCHAR2(20) not null,
  deptid              VARCHAR2(20),
  position_code       VARCHAR2(20),
  post_grade_code     VARCHAR2(20),
  contract_start_date DATE,
  contract_end_date   DATE,
  apply_start_date    DATE,
  apply_end_date      DATE,
  house_owner         VARCHAR2(100),
  idcard_no           VARCHAR2(50),
  office_phone        VARCHAR2(20),
  reside_number       NUMBER,
  pay_account         VARCHAR2(50),
  chummage_pay_date   VARCHAR2(20),
  rent                NUMBER,
  pay_period          NUMBER,
  tenement_allowance  NUMBER,
  numerical_ceiling   NUMBER,
  welfare_start_date  DATE,
  welfare_end_date    DATE,
  apply_times         NUMBER,
  pay_month           VARCHAR2(20) not null,
  address             VARCHAR2(500),
  remark              VARCHAR2(500),
  create_date         DATE,
  created_by          VARCHAR2(20),
  update_date         DATE,
  updated_by          VARCHAR2(20),
  activity            NUMBER(1),
  remittance          NUMBER
)
;
comment on column PAY_TENEMENT_ALLOWANCE.contract_start_date
  is '��ͬ��ʼ����';
comment on column PAY_TENEMENT_ALLOWANCE.contract_end_date
  is '��ͬ��������';
comment on column PAY_TENEMENT_ALLOWANCE.apply_start_date
  is '���뿪ʼ����';
comment on column PAY_TENEMENT_ALLOWANCE.apply_end_date
  is '�����������';
comment on column PAY_TENEMENT_ALLOWANCE.house_owner
  is '����/�н�';
comment on column PAY_TENEMENT_ALLOWANCE.idcard_no
  is '���֤/�н�����';
comment on column PAY_TENEMENT_ALLOWANCE.office_phone
  is '��ϵ�绰';
comment on column PAY_TENEMENT_ALLOWANCE.reside_number
  is '��ס����';
comment on column PAY_TENEMENT_ALLOWANCE.pay_account
  is '����ʻ�';
comment on column PAY_TENEMENT_ALLOWANCE.chummage_pay_date
  is '����֧������';
comment on column PAY_TENEMENT_ALLOWANCE.rent
  is '�����';
comment on column PAY_TENEMENT_ALLOWANCE.pay_period
  is '֧������';
comment on column PAY_TENEMENT_ALLOWANCE.tenement_allowance
  is '�ⷿ�������';
comment on column PAY_TENEMENT_ALLOWANCE.numerical_ceiling
  is '����޶�';
comment on column PAY_TENEMENT_ALLOWANCE.welfare_start_date
  is '������ʼ����';
comment on column PAY_TENEMENT_ALLOWANCE.welfare_end_date
  is '������������';
comment on column PAY_TENEMENT_ALLOWANCE.apply_times
  is '��ǰ�������';
comment on column PAY_TENEMENT_ALLOWANCE.pay_month
  is '����֧����';
comment on column PAY_TENEMENT_ALLOWANCE.address
  is '�ⷿ��ַ';
comment on column PAY_TENEMENT_ALLOWANCE.remark
  is '��ע';
comment on column PAY_TENEMENT_ALLOWANCE.remittance
  is '�����';
alter table PAY_TENEMENT_ALLOWANCE
  add primary key (EMPID, PAY_MONTH);

prompt
prompt Creating table PA_ANNUAL_SALARY_HIS100504
prompt =========================================
prompt
create table PA_ANNUAL_SALARY_HIS100504
(
  empid               VARCHAR2(20) not null,
  rectify_date        DATE not null,
  rectify_reason      VARCHAR2(100),
  annual_salary       NUMBER,
  eatery_allowance    NUMBER,
  traffic_allowance   NUMBER,
  household_allowance NUMBER,
  remark              VARCHAR2(200),
  activity            NUMBER,
  create_date         DATE,
  created_by          VARCHAR2(20),
  update_date         DATE,
  updated_by          VARCHAR2(20)
)
;

prompt
prompt Creating table PA_ANNUAL_SALARY_HISTORY
prompt =======================================
prompt
create table PA_ANNUAL_SALARY_HISTORY
(
  empid               VARCHAR2(20) not null,
  rectify_date        DATE not null,
  rectify_reason      VARCHAR2(100),
  annual_salary       NUMBER,
  eatery_allowance    NUMBER,
  traffic_allowance   NUMBER,
  household_allowance NUMBER,
  remark              VARCHAR2(200),
  activity            NUMBER,
  create_date         DATE,
  created_by          VARCHAR2(20),
  update_date         DATE,
  updated_by          VARCHAR2(20),
  tenement_allow      NUMBER,
  bonus               NUMBER,
  evs_bonus           NUMBER
)
;
comment on table PA_ANNUAL_SALARY_HISTORY
  is '��н������ʷ��';
comment on column PA_ANNUAL_SALARY_HISTORY.rectify_date
  is '��������';
comment on column PA_ANNUAL_SALARY_HISTORY.rectify_reason
  is '����ԭ��';
comment on column PA_ANNUAL_SALARY_HISTORY.annual_salary
  is '��н';
comment on column PA_ANNUAL_SALARY_HISTORY.eatery_allowance
  is '�Ͳ�';
comment on column PA_ANNUAL_SALARY_HISTORY.traffic_allowance
  is '��ͨ��';
comment on column PA_ANNUAL_SALARY_HISTORY.household_allowance
  is '�������';
comment on column PA_ANNUAL_SALARY_HISTORY.tenement_allow
  is 'ס������';
comment on column PA_ANNUAL_SALARY_HISTORY.bonus
  is '����';
comment on column PA_ANNUAL_SALARY_HISTORY.evs_bonus
  is '�ɹ���';
alter table PA_ANNUAL_SALARY_HISTORY
  add constraint PK_ANNUAL_SALARY_HISTORY primary key (EMPID, RECTIFY_DATE);
alter table PA_ANNUAL_SALARY_HISTORY
  add foreign key (EMPID)
  references HR_EMPLOYEE (EMPID);

prompt
prompt Creating table PA_BASIC_ITEM
prompt ============================
prompt
create table PA_BASIC_ITEM
(
  item_no            NUMBER not null,
  item_id            VARCHAR2(50) not null,
  item_name          VARCHAR2(50) not null,
  item_en_name       VARCHAR2(50),
  distinct_field_1st VARCHAR2(50),
  distinct_field_2nd VARCHAR2(50),
  datatype           VARCHAR2(50),
  description        VARCHAR2(200),
  orderno            NUMBER,
  default_val        VARCHAR2(50),
  create_date        DATE,
  created_by         VARCHAR2(20),
  update_date        DATE,
  updated_by         VARCHAR2(20),
  activity           NUMBER,
  flag               NUMBER default 1 not null,
  cpny_id            VARCHAR2(20)
)
;
alter table PA_BASIC_ITEM
  add primary key (ITEM_ID);
alter table PA_BASIC_ITEM
  add unique (ITEM_NO);

prompt
prompt Creating table PA_BASIC_DATA
prompt ============================
prompt
create table PA_BASIC_DATA
(
  basic_data_no   NUMBER not null,
  item_no         NUMBER not null,
  field1_value    VARCHAR2(50),
  return_value    VARCHAR2(50),
  field2_value    VARCHAR2(50),
  field1_en_value VARCHAR2(50),
  field2_en_value VARCHAR2(50),
  start_date      DATE,
  end_date        DATE,
  remark          VARCHAR2(500),
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  activity        NUMBER(1),
  reason_code     VARCHAR2(20)
)
;
create index IDX_PA_BASIC_DATA_ITEM_FIELD on PA_BASIC_DATA (ITEM_NO, FIELD1_VALUE);
alter table PA_BASIC_DATA
  add constraint PK_PA_BASIC_DATA primary key (BASIC_DATA_NO);
alter table PA_BASIC_DATA
  add constraint UK_PA_BASIC_DATA unique (ITEM_NO, FIELD1_VALUE, START_DATE, END_DATE);
alter table PA_BASIC_DATA
  add constraint FK_PA_BASIC_DATA foreign key (ITEM_NO)
  references PA_BASIC_ITEM (ITEM_NO);

prompt
prompt Creating table PA_BASIC_DATA_LIST
prompt =================================
prompt
create table PA_BASIC_DATA_LIST
(
  field1_value     VARCHAR2(50),
  field2_value     VARCHAR2(50),
  field1_en_value  VARCHAR2(50),
  field1_kor_value VARCHAR2(50),
  field2_en_value  VARCHAR2(50),
  field2_kor_value VARCHAR2(50)
)
;

prompt
prompt Creating table PA_BONUS_EMP
prompt ===========================
prompt
create table PA_BONUS_EMP
(
  bonus_no    NUMBER,
  pa_month    VARCHAR2(10) not null,
  empid       VARCHAR2(20) not null,
  create_date DATE,
  created_by  VARCHAR2(20),
  update_date DATE,
  updated_by  VARCHAR2(20),
  orderno     NUMBER(10),
  activity    NUMBER(1),
  remark      VARCHAR2(200)
)
;
comment on column PA_BONUS_EMP.bonus_no
  is '���,�����޸ĺ�ɾ��';
comment on column PA_BONUS_EMP.pa_month
  is '������';
comment on column PA_BONUS_EMP.empid
  is '����';
create index IDX_PA_SEQ_NO_2 on PA_BONUS_EMP (BONUS_NO);
alter table PA_BONUS_EMP
  add constraint PK_PA_BONUS_PERSONNEL primary key (PA_MONTH, EMPID);

prompt
prompt Creating table PA_BONUS_FORMULAR
prompt ================================
prompt
create table PA_BONUS_FORMULAR
(
  formular_no NUMBER not null,
  item_no     NUMBER not null,
  pa_month    VARCHAR2(6) not null,
  condition   VARCHAR2(2000),
  formular    VARCHAR2(2000),
  description VARCHAR2(2000),
  remark      VARCHAR2(2000),
  create_date DATE,
  created_by  VARCHAR2(20),
  update_date DATE,
  updated_by  VARCHAR2(20),
  orderno     NUMBER(10),
  activity    NUMBER
)
;
create index INX_PA_BONUS_FORMULAR on PA_BONUS_FORMULAR (PA_MONTH, ITEM_NO);
alter table PA_BONUS_FORMULAR
  add constraint PK_PA_BONUS_FORMULAR primary key (FORMULAR_NO);
alter table PA_BONUS_FORMULAR
  add constraint UK_PA_BONUS_FORMULAR unique (ITEM_NO, PA_MONTH, CONDITION, FORMULAR);

prompt
prompt Creating table PA_BONUS_HISTORY
prompt ===============================
prompt
create table PA_BONUS_HISTORY
(
  bonus_month          VARCHAR2(20),
  pa_month             VARCHAR2(20),
  bonus_formular_month VARCHAR2(20),
  empid                VARCHAR2(20),
  chinesename          VARCHAR2(40),
  chinese_pinyin       VARCHAR2(40),
  deptname             VARCHAR2(100),
  deptid               VARCHAR2(20),
  scheduled_days       NUMBER,
  vacant_state         NUMBER,
  holiday_days         NUMBER,
  actual_work_days     NUMBER,
  b_item_1             NUMBER,
  b_item_2             NUMBER,
  b_item_3             NUMBER,
  i_bonus_6            NUMBER,
  i_bonus_5            NUMBER,
  bonus_2              NUMBER,
  bonus_3              NUMBER,
  bonus_4              NUMBER,
  pre_tax_pay          NUMBER,
  taxable_pay          NUMBER
)
;

prompt
prompt Creating table PA_BONUS_HISTORY_201206
prompt ======================================
prompt
create table PA_BONUS_HISTORY_201206
(
  bonus_month          VARCHAR2(20),
  pa_month             VARCHAR2(20),
  bonus_formular_month VARCHAR2(20)
)
;

prompt
prompt Creating table PA_BONUS_ITEM
prompt ============================
prompt
create table PA_BONUS_ITEM
(
  item_no      NUMBER not null,
  item_id      VARCHAR2(50) not null,
  item_name    VARCHAR2(50),
  item_en_name VARCHAR2(50),
  description  VARCHAR2(4000),
  datatype     VARCHAR2(20),
  calcu_order  NUMBER,
  precision    NUMBER,
  carry_bit    NUMBER,
  calc_flag    VARCHAR2(4),
  create_date  DATE,
  created_by   VARCHAR2(20),
  update_date  DATE,
  updated_by   VARCHAR2(20),
  orderno      NUMBER(10),
  activity     NUMBER(1),
  cpny_id      VARCHAR2(20),
  type_id      VARCHAR2(20)
)
;
comment on column PA_BONUS_ITEM.item_no
  is '��Ŀ���';
comment on column PA_BONUS_ITEM.item_id
  is '��ĿID';
comment on column PA_BONUS_ITEM.item_name
  is '��Ŀ����';
comment on column PA_BONUS_ITEM.item_en_name
  is 'Ӣ������';
comment on column PA_BONUS_ITEM.description
  is '����';
comment on column PA_BONUS_ITEM.datatype
  is '��������';
comment on column PA_BONUS_ITEM.calcu_order
  is '����˳��';
comment on column PA_BONUS_ITEM.precision
  is '����';
comment on column PA_BONUS_ITEM.carry_bit
  is '��λ';
comment on column PA_BONUS_ITEM.calc_flag
  is '�Ƿ��빤���й���';
comment on column PA_BONUS_ITEM.type_id
  is '��������';
create index INX_PA_BONUS_ITEM on PA_BONUS_ITEM (ITEM_NO);
alter table PA_BONUS_ITEM
  add constraint PK_PA_BONUS_ITEM primary key (ITEM_ID);

prompt
prompt Creating table PA_BONUS_PARAM_ITEM
prompt ==================================
prompt
create table PA_BONUS_PARAM_ITEM
(
  param_no           NUMBER not null,
  param_id           VARCHAR2(50) not null,
  param_name         VARCHAR2(50) not null,
  param_en_name      VARCHAR2(50),
  distinct_field_1st VARCHAR2(50),
  distinct_field_2nd VARCHAR2(50),
  pa_month           VARCHAR2(6) not null,
  datatype           VARCHAR2(50),
  description        VARCHAR2(200),
  param_type_code    VARCHAR2(50),
  default_val        VARCHAR2(50),
  create_date        DATE,
  created_by         VARCHAR2(20),
  update_date        DATE,
  updated_by         VARCHAR2(20),
  order_no           NUMBER(10),
  activity           NUMBER(1),
  cpny_id            VARCHAR2(20)
)
;
create index INX_PA_BONUS_PARAM_ITEM on PA_BONUS_PARAM_ITEM (PARAM_NO);
alter table PA_BONUS_PARAM_ITEM
  add constraint PK_PA_BONUS_PARAM_ITEM primary key (PARAM_NO);
alter table PA_BONUS_PARAM_ITEM
  add constraint UK_PA_BONUS_PARAM_ITEM unique (PARAM_ID, PA_MONTH);

prompt
prompt Creating table PA_BONUS_PARAM_DATA
prompt ==================================
prompt
create table PA_BONUS_PARAM_DATA
(
  param_data_no   NUMBER not null,
  param_no        NUMBER not null,
  field1_value    VARCHAR2(20),
  return_value    VARCHAR2(200),
  field2_value    VARCHAR2(20),
  field1_en_value VARCHAR2(50),
  field2_en_value VARCHAR2(50),
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  order_no        NUMBER(10),
  activity        NUMBER(1),
  remark          VARCHAR2(200)
)
;
create index IDX_PA_BONUS_PARAM_DATA on PA_BONUS_PARAM_DATA (PARAM_NO, FIELD1_VALUE, FIELD2_VALUE);
alter table PA_BONUS_PARAM_DATA
  add constraint PK_PA_BONUS_PARAM_DATA primary key (PARAM_DATA_NO);
alter table PA_BONUS_PARAM_DATA
  add constraint FK_PA_BONUS_PARAM_DATA foreign key (PARAM_NO)
  references PA_BONUS_PARAM_ITEM (PARAM_NO) on delete cascade;

prompt
prompt Creating table PA_BONUS_PARAM_DATA_T
prompt ====================================
prompt
create table PA_BONUS_PARAM_DATA_T
(
  param_data_no   NUMBER not null,
  param_no        NUMBER not null,
  field1_value    VARCHAR2(20),
  return_value    VARCHAR2(200),
  field2_value    VARCHAR2(20),
  field1_en_value VARCHAR2(50),
  field2_en_value VARCHAR2(50),
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  order_no        NUMBER(10),
  activity        NUMBER(1),
  remark          VARCHAR2(200),
  ud_date         DATE,
  ud_by           VARCHAR2(20),
  flag            NUMBER(1)
)
;
create index IDX_PA_BONUS_PARAM_DATA_T on PA_BONUS_PARAM_DATA_T (PARAM_NO, FIELD1_VALUE, FIELD2_VALUE);

prompt
prompt Creating table PA_BONUS_PARAM_DATA_TEMP
prompt =======================================
prompt
create table PA_BONUS_PARAM_DATA_TEMP
(
  param_data_no   NUMBER not null,
  param_no        NUMBER not null,
  field1_value    VARCHAR2(20),
  return_value    VARCHAR2(200),
  field2_value    VARCHAR2(20),
  field1_en_value VARCHAR2(50),
  field2_en_value VARCHAR2(50),
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  order_no        NUMBER(10),
  activity        NUMBER(1),
  remark          VARCHAR2(200)
)
;

prompt
prompt Creating table PA_BONUS_TYPE
prompt ============================
prompt
create table PA_BONUS_TYPE
(
  type_no      NUMBER not null,
  type_id      VARCHAR2(50) not null,
  type_name    VARCHAR2(50),
  type_en_name VARCHAR2(50),
  description  VARCHAR2(2000),
  tax_way_code VARCHAR2(20),
  create_date  DATE,
  created_by   VARCHAR2(20),
  update_date  DATE,
  updated_by   VARCHAR2(20),
  orderno      NUMBER(10),
  activity     NUMBER(1) not null,
  cpny_id      VARCHAR2(20) not null
)
;
comment on column PA_BONUS_TYPE.type_id
  is '����ID';
comment on column PA_BONUS_TYPE.type_name
  is '��������';
comment on column PA_BONUS_TYPE.type_en_name
  is '����Ӣ������';
comment on column PA_BONUS_TYPE.description
  is '����';
comment on column PA_BONUS_TYPE.tax_way_code
  is '��˰��ʽ';
alter table PA_BONUS_TYPE
  add constraint PK_PA_BONUS_TYPE primary key (TYPE_NO);
alter table PA_BONUS_TYPE
  add constraint UK_PA_BONUS_TYPE unique (TYPE_ID);
alter table PA_BONUS_TYPE
  add constraint FK_PA_BONUS_TYPE foreign key (CPNY_ID)
  references HR_COMPANY (CPNY_ID);

prompt
prompt Creating table PA_DAILY_ITEM
prompt ============================
prompt
create table PA_DAILY_ITEM
(
  item_no       NUMBER not null,
  item_name     VARCHAR2(50),
  descr         VARCHAR2(500),
  datatype      VARCHAR2(20),
  calcu_order   NUMBER,
  item_type     VARCHAR2(50),
  pricision     NUMBER,
  carry_bit     NUMBER,
  item_en_name  VARCHAR2(50),
  item_kor_name VARCHAR2(50),
  item_id       VARCHAR2(50)
)
;
alter table PA_DAILY_ITEM
  add constraint PK_PA_DAILY_ITEM primary key (ITEM_NO);

prompt
prompt Creating table PA_DAILY_FORMULAR
prompt ================================
prompt
create table PA_DAILY_FORMULAR
(
  formular_no   NUMBER not null,
  item_no       NUMBER not null,
  condition     VARCHAR2(4000),
  formular      VARCHAR2(4000),
  condition_seq NUMBER,
  description   VARCHAR2(2000)
)
;
alter table PA_DAILY_FORMULAR
  add constraint PK_PA_DAILY_FORMULAR primary key (FORMULAR_NO);
alter table PA_DAILY_FORMULAR
  add constraint FK_PA_DAILY_FORMULAR foreign key (ITEM_NO)
  references PA_DAILY_ITEM (ITEM_NO);

prompt
prompt Creating table PA_DAILY_HISTORY
prompt ===============================
prompt
create table PA_DAILY_HISTORY
(
  pa_date                   CHAR(10),
  empid                     VARCHAR2(20),
  chinesename               VARCHAR2(40),
  pinyinname                VARCHAR2(40),
  englishname               VARCHAR2(20),
  koreanname                VARCHAR2(40),
  position_code             VARCHAR2(20),
  position                  VARCHAR2(50),
  position_en_name          VARCHAR2(50),
  position_kor_name         VARCHAR2(50),
  duty_code                 VARCHAR2(20),
  duty                      VARCHAR2(50),
  duty_en_name              VARCHAR2(50),
  duty_kor_name             VARCHAR2(50),
  post_code                 VARCHAR2(20),
  post                      VARCHAR2(50),
  post_en_name              VARCHAR2(50),
  post_kor_name             VARCHAR2(50),
  post_group_id             VARCHAR2(10),
  post_group_name           VARCHAR2(50),
  post_group_en_name        VARCHAR2(50),
  post_group_kor_name       VARCHAR2(50),
  post_grade_code           VARCHAR2(20),
  post_grade                VARCHAR2(50),
  post_grade_en_name        VARCHAR2(50),
  post_grade_kor_name       VARCHAR2(50),
  post_coef                 VARCHAR2(20),
  post_grade_level_name     VARCHAR2(50),
  post_grade_level_en_name  VARCHAR2(50),
  post_grade_level_kor_name VARCHAR2(50),
  status_code               VARCHAR2(20),
  status                    VARCHAR2(50),
  status_en_name            VARCHAR2(50),
  status_kor_name           VARCHAR2(50),
  date_started              DATE,
  date_left                 DATE,
  end_probation_date        DATE,
  join_type_code            VARCHAR2(20),
  join_type                 VARCHAR2(50),
  join_type_en_name         VARCHAR2(50),
  join_type_kor_name        VARCHAR2(50),
  work_area_id              VARCHAR2(20),
  work_area                 VARCHAR2(50),
  work_area_en_name         VARCHAR2(50),
  work_area_kor_name        VARCHAR2(50),
  cpny_id                   VARCHAR2(10),
  cpny_name                 VARCHAR2(50),
  deptid                    VARCHAR2(20),
  department                VARCHAR2(100),
  dept_en_name              VARCHAR2(100),
  dept_kor_name             VARCHAR2(100),
  deptfullname              VARCHAR2(4000),
  idcard_no                 VARCHAR2(30),
  passport_no               VARCHAR2(40),
  nation_code               VARCHAR2(20),
  nation                    VARCHAR2(50),
  nation_en_name            VARCHAR2(50),
  nation_kor_name           VARCHAR2(50),
  nationality_code          VARCHAR2(20),
  nationality               VARCHAR2(50),
  nationality_en_name       VARCHAR2(50),
  nationality_kor_name      VARCHAR2(50),
  polity_code               VARCHAR2(20),
  polity                    VARCHAR2(50),
  polity_en_name            VARCHAR2(50),
  polity_kor_name           VARCHAR2(50),
  reg_type_code             VARCHAR2(20),
  regtype                   VARCHAR2(50),
  regtype_en_name           VARCHAR2(50),
  regtype_kor_name          VARCHAR2(50),
  bornplace_code            VARCHAR2(20),
  bornplace                 VARCHAR2(50),
  bornplace_en_name         VARCHAR2(50),
  bornplace_kor_name        VARCHAR2(50),
  frequency_duty_d          VARCHAR2(50),
  domestic_biz_trip_d       NUMBER,
  abroad_biz_trip_d         NUMBER,
  weekday_ot_d              NUMBER,
  weekend_ot_d              NUMBER,
  holiday_ot_d              NUMBER,
  absenteeism_d             NUMBER,
  unpaid_leave_d            NUMBER,
  casual_leave_d            NUMBER,
  compassionate_leave_d     NUMBER,
  sick_leave_d              NUMBER,
  card_miss_d               NUMBER,
  tardiness_d               NUMBER,
  truancy_d                 NUMBER,
  insurance_base            NUMBER,
  probation_ration          NUMBER,
  standard_wage             NUMBER,
  post_allowance            NUMBER,
  quality_allowance         NUMBER,
  special_allowance         NUMBER,
  subsidy_allowance         NUMBER,
  variable_pay              NUMBER,
  before_taxable_plus       NUMBER,
  after_taxable_deduct      NUMBER,
  after_taxable_plus        NUMBER,
  before_taxable_deduct     NUMBER,
  base_pay                  NUMBER,
  daily_wages               NUMBER,
  hourly_pay                NUMBER,
  duty_allowance            NUMBER,
  biz_trip_allowance        NUMBER,
  other_allowance           NUMBER,
  holidy_ot_pay             NUMBER,
  weekday_ot_pay            NUMBER,
  weekend_ot_pay            NUMBER,
  ot_pay_totail             NUMBER,
  absenteeism_deduct        NUMBER,
  convert_absent_deduct     NUMBER,
  card_miss_deduct          NUMBER,
  casual_leave_deduct       NUMBER,
  compassionate_deduct      NUMBER,
  unpaid_leave_deduct       NUMBER,
  sick_leave_deduct         NUMBER,
  absent_deduct_total       NUMBER,
  salary_payable            NUMBER
)
;

prompt
prompt Creating table PA_DIFFERENCE_PERSONNEL
prompt ======================================
prompt
create table PA_DIFFERENCE_PERSONNEL
(
  pa_month    VARCHAR2(10) not null,
  empid       VARCHAR2(20) not null,
  seq_no      NUMBER,
  create_date DATE,
  created_by  VARCHAR2(20),
  update_date DATE,
  updated_by  VARCHAR2(20),
  orderno     NUMBER(10),
  activity    NUMBER(1)
)
;
comment on column PA_DIFFERENCE_PERSONNEL.pa_month
  is '������';
comment on column PA_DIFFERENCE_PERSONNEL.empid
  is '����';
comment on column PA_DIFFERENCE_PERSONNEL.seq_no
  is '���,�����޸ĺ�ɾ��';
create index IDX_PA_SEQ_NO_3 on PA_DIFFERENCE_PERSONNEL (SEQ_NO);
alter table PA_DIFFERENCE_PERSONNEL
  add constraint PK_PA_DIFFERENCE_PERSONNEL primary key (PA_MONTH, EMPID);

prompt
prompt Creating table PA_DISTINCT_LIST
prompt ===============================
prompt
create table PA_DISTINCT_LIST
(
  field_name     VARCHAR2(50),
  distinct_field VARCHAR2(50) not null,
  table_name     VARCHAR2(50) not null,
  id             NUMBER,
  activity       NUMBER(1) not null,
  field_en_name  VARCHAR2(50),
  field_kor_name VARCHAR2(50),
  lang_group     VARCHAR2(50),
  cpny_id        VARCHAR2(20) not null
)
;
comment on column PA_DISTINCT_LIST.lang_group
  is '���Է��飺0,������;  1,������;  2, Ӣ����;  3, ������;  4,code ��';
alter table PA_DISTINCT_LIST
  add primary key (DISTINCT_FIELD, TABLE_NAME);

prompt
prompt Creating table PA_EXPENSE_TYPE
prompt ==============================
prompt
create table PA_EXPENSE_TYPE
(
  pa_expense_seq   NUMBER not null,
  expense_type     NUMBER not null,
  expense_formular VARCHAR2(3000),
  tag              NUMBER,
  debitcredit      VARCHAR2(10),
  descr            VARCHAR2(100)
)
;
alter table PA_EXPENSE_TYPE
  add constraint PK_PA_EXPENSE_TYPE primary key (EXPENSE_TYPE);

prompt
prompt Creating table PA_FORMULAR
prompt ==========================
prompt
create table PA_FORMULAR
(
  formular_no NUMBER not null,
  item_no     NUMBER not null,
  pa_month    VARCHAR2(6),
  condition   VARCHAR2(4000),
  formular    VARCHAR2(4000),
  description VARCHAR2(2000),
  remark      VARCHAR2(2000),
  create_date DATE,
  created_by  VARCHAR2(20),
  update_date DATE,
  updated_by  VARCHAR2(20),
  orderno     NUMBER,
  activity    NUMBER default 1
)
;
alter table PA_FORMULAR
  add constraint PK_PA_FORMULAR primary key (FORMULAR_NO);

prompt
prompt Creating table PA_FORMULAR_DAY
prompt ==============================
prompt
create table PA_FORMULAR_DAY
(
  formular_no   NUMBER not null,
  pa_item_no    NUMBER not null,
  condition     VARCHAR2(4000),
  formular      VARCHAR2(4000),
  condition_seq NUMBER,
  description   VARCHAR2(2000)
)
;

prompt
prompt Creating table PA_HISTORY
prompt =========================
prompt
create table PA_HISTORY
(
  pa_month          CHAR(6),
  empid             VARCHAR2(20),
  pa_formular_month CHAR(6),
  chinesename       VARCHAR2(40),
  deptname          VARCHAR2(100),
  deptid            VARCHAR2(20),
  status_name       VARCHAR2(50),
  status_code       VARCHAR2(20),
  post_name         VARCHAR2(50),
  post_id           VARCHAR2(20),
  post_grade_id     VARCHAR2(20),
  post_grade_name   VARCHAR2(50),
  position_id       VARCHAR2(20),
  position_name     VARCHAR2(50),
  post_group_name   VARCHAR2(50),
  post_group_id     VARCHAR2(20),
  emp_type_name     VARCHAR2(50),
  card_no           VARCHAR2(200),
  att_m_112         NUMBER,
  att_m_58          NUMBER,
  att_m_114         NUMBER,
  att_m_8           NUMBER,
  att_m_9           NUMBER,
  att_m_7           NUMBER,
  att_m_6           NUMBER,
  att_m_110         NUMBER,
  att_m_119         NUMBER,
  att_m_113         NUMBER,
  att_m_52          NUMBER,
  att_m_115         NUMBER,
  att_m_53          NUMBER,
  att_m_2           NUMBER,
  att_m_118         NUMBER,
  att_m_12          NUMBER,
  att_m_15          NUMBER,
  att_m_39          NUMBER,
  att_m_117         NUMBER,
  att_m_20          NUMBER,
  i_pa_12           NUMBER,
  i_pa_29           NUMBER,
  i_pa_28           NUMBER,
  pa_146            NUMBER,
  pa_147            NUMBER,
  pa_148            NUMBER,
  pa_149            NUMBER,
  pa_150            NUMBER,
  i_pa_32           NUMBER,
  pa_151            NUMBER,
  i_pa_33           NUMBER,
  i_pa_35           NUMBER,
  i_pa_34           NUMBER,
  join_date         DATE,
  emp_type_code     VARCHAR2(20),
  i_pa_37           NUMBER,
  i_pa_36           NUMBER,
  pa_153            NUMBER,
  pa_154            NUMBER,
  pa_155            NUMBER,
  pa_156            NUMBER,
  pa_157            NUMBER,
  pa_158            NUMBER,
  pa_159            NUMBER
)
;

prompt
prompt Creating table PA_HISTORYTEMP
prompt =============================
prompt
create table PA_HISTORYTEMP
(
  pa_month                CHAR(6),
  area                    VARCHAR2(50),
  empid                   VARCHAR2(20),
  chinesename             VARCHAR2(40),
  pinyinname              VARCHAR2(40),
  deptid                  VARCHAR2(20),
  department              VARCHAR2(100),
  deptfullname            VARCHAR2(4000),
  part                    VARCHAR2(4000),
  post                    VARCHAR2(50),
  post_grade              VARCHAR2(50),
  position                VARCHAR2(50),
  emp_type_name           VARCHAR2(50),
  work_area               VARCHAR2(50),
  status                  VARCHAR2(50),
  biz                     VARCHAR2(4000),
  join_type               VARCHAR2(50),
  date_started            DATE,
  end_probation_date      DATE,
  date_left               DATE,
  nationality             VARCHAR2(50),
  tenement_month          VARCHAR2(20),
  tenement_allowance      NUMBER,
  welfare_start_date      DATE,
  welfare_end_date        DATE,
  cpny_name               VARCHAR2(50),
  dispatch_type           VARCHAR2(50),
  history_join_date       DATE,
  normal_date             DATE,
  englishname             VARCHAR2(20),
  ev_grade_code           VARCHAR2(50),
  koreanname              VARCHAR2(40),
  dept_en_name            VARCHAR2(100),
  scheduled_days          NUMBER,
  dept_kor_name           VARCHAR2(100),
  vacant_state            NUMBER,
  holiday_days            NUMBER,
  insurance_base          NUMBER,
  post_group_name         VARCHAR2(50),
  medicare_base           NUMBER,
  housing_fund_base       NUMBER,
  cashier_base            NUMBER,
  annual_salary           NUMBER,
  cashier_adjust_range    NUMBER,
  repast_base             NUMBER,
  traffic_base            NUMBER,
  festa_base              NUMBER,
  repast_base2            NUMBER,
  work_injury_base        NUMBER,
  cpy_childbirth_ins_app  NUMBER,
  cpy_work_injury_ins_app NUMBER,
  per_unemp_ins_deduct    NUMBER,
  per_childb_ins_deduct   NUMBER,
  per_accum_fund_deduct   NUMBER,
  cpy_medicare_ins_deduct NUMBER,
  cpy_unemp_ins_deduct    NUMBER,
  cpy_childb_ins_deduct   NUMBER,
  cpy_accum_fund_deduct   NUMBER,
  cpy_integra_ins_deduct  NUMBER,
  special_ot_pay          NUMBER,
  adjust_addition         NUMBER,
  dollar_rate             NUMBER,
  per_retire_ins_deduct   NUMBER,
  praxis_rate             NUMBER,
  probation_rate          NUMBER,
  pending_assign_rate     NUMBER,
  bandh_rate              NUMBER,
  festa_allow_flag        NUMBER,
  eva_bonus_koean         NUMBER,
  bonus_flag              NUMBER,
  bonus_tax_flag          NUMBER,
  biz_trip_allow          NUMBER,
  training_allow          NUMBER,
  tax_benchmark_adjust    NUMBER,
  supple_medicare_deduct  NUMBER,
  eva_bonus_flag          NUMBER,
  smock_allow             NUMBER,
  instructor_allow        NUMBER,
  congratulate_allow      NUMBER,
  pension                 NUMBER,
  retroactive_pay         NUMBER,
  before_taxable_plus     NUMBER,
  before_taxable_deduct   NUMBER,
  after_taxable_plus      NUMBER,
  after_taxable_deduct    NUMBER,
  evaluate_rate           NUMBER,
  achievement_bonus       NUMBER,
  per_medicare_ins_deduct NUMBER,
  cpy_retire_ins_deduct   NUMBER,
  child_supple_medicare   NUMBER,
  service_charge_deduct   NUMBER,
  deposit_fruit_bonus     NUMBER,
  month_pay               NUMBER,
  base_pay                NUMBER,
  basic_pay               NUMBER,
  daily_pay               NUMBER,
  cashier_allow_normal    NUMBER,
  bonus_flag_pq           NUMBER,
  cashier_allow_deduct    NUMBER,
  weekday_ot_pay          NUMBER,
  weekend_ot_pay          NUMBER,
  holidy_ot_pay           NUMBER,
  cashier_allow           NUMBER,
  allow_total             NUMBER,
  monthly_bonus_norm      NUMBER,
  daily_bonus_norm        NUMBER,
  bonus                   NUMBER,
  local_eva_rate          NUMBER,
  eva_bonus               NUMBER,
  bonus_total             NUMBER,
  support_allow           NUMBER,
  tenement_allow          NUMBER,
  repast_allow            NUMBER,
  traffic_allow           NUMBER,
  area_grade              CHAR(50),
  live_allow_normal       NUMBER,
  live_allow_deduct       NUMBER,
  live_allow              NUMBER,
  festa_allow             NUMBER,
  subsidy_total           NUMBER,
  casual_leave_deduct     NUMBER,
  absenteeism_deduct      NUMBER,
  no_pay_leave_deduct     NUMBER,
  att_deduct_total        NUMBER,
  per_retire_ins          NUMBER,
  per_medicare_ins        NUMBER,
  per_unemploy_ins        NUMBER,
  per_childbirth_ins      NUMBER,
  per_accumulation_fund   NUMBER,
  per_ins_total           NUMBER,
  other_allow_total       NUMBER,
  cpy_retire_ins          NUMBER,
  cpy_medicare_ins        NUMBER,
  cpy_unemploy_ins        NUMBER,
  cpy_work_injury_ins     NUMBER,
  cpy_childbirth_ins      NUMBER,
  cpy_accumulation_fund   NUMBER,
  integrative_ins         NUMBER,
  supplement_medicare     NUMBER,
  ins_service_charge      NUMBER,
  cpy_ins_total           NUMBER,
  salary_payable          NUMBER,
  pre_tax_pay             NUMBER,
  tax_benchmark           NUMBER,
  taxable_pay             NUMBER,
  per_bonus               NUMBER,
  avg_bonus               NUMBER,
  tax_ratio               NUMBER,
  bonus_tax_ratio         NUMBER,
  algorithm_meduct        NUMBER,
  bonus_alg_meduct        NUMBER,
  income_tax              NUMBER,
  bonus_tax               NUMBER,
  net_bonus               NUMBER,
  perpaid_allow_deduct    NUMBER,
  other_deduct_total      NUMBER,
  net_pay                 NUMBER
)
;

prompt
prompt Creating table PA_HISTORYTEMPS
prompt ==============================
prompt
create table PA_HISTORYTEMPS
(
  pa_month                CHAR(6),
  area                    VARCHAR2(50),
  empid                   VARCHAR2(20),
  chinesename             VARCHAR2(40),
  pinyinname              VARCHAR2(40),
  deptid                  VARCHAR2(20),
  department              VARCHAR2(100),
  deptfullname            VARCHAR2(4000),
  part                    VARCHAR2(4000),
  post                    VARCHAR2(50),
  post_grade              VARCHAR2(50),
  position                VARCHAR2(50),
  emp_type_name           VARCHAR2(50),
  work_area               VARCHAR2(50),
  status                  VARCHAR2(50),
  biz                     VARCHAR2(4000),
  join_type               VARCHAR2(50),
  date_started            DATE,
  end_probation_date      DATE,
  date_left               DATE,
  nationality             VARCHAR2(50),
  tenement_month          VARCHAR2(20),
  tenement_allowance      NUMBER,
  welfare_start_date      DATE,
  welfare_end_date        DATE,
  cpny_name               VARCHAR2(50),
  dispatch_type           VARCHAR2(50),
  history_join_date       DATE,
  normal_date             DATE,
  englishname             VARCHAR2(20),
  koreanname              VARCHAR2(40),
  dept_en_name            VARCHAR2(100),
  dept_kor_name           VARCHAR2(100),
  ev_grade_code           VARCHAR2(50),
  post_group_name         VARCHAR2(50),
  scheduled_days          NUMBER,
  vacant_state            NUMBER,
  holiday_days            NUMBER,
  insurance_base          NUMBER,
  medicare_base           NUMBER,
  housing_fund_base       NUMBER,
  cashier_base            NUMBER,
  annual_salary           NUMBER,
  cashier_adjust_range    NUMBER,
  repast_base             NUMBER,
  traffic_base            NUMBER,
  festa_base              NUMBER,
  repast_base2            NUMBER,
  work_injury_base        NUMBER,
  cpy_childbirth_ins_app  NUMBER,
  jiangjin_bufa_paiqian   NUMBER,
  cpy_work_injury_ins_app NUMBER,
  per_unemp_ins_deduct    NUMBER,
  per_childb_ins_deduct   NUMBER,
  per_accum_fund_deduct   NUMBER,
  cpy_medicare_ins_deduct NUMBER,
  cpy_unemp_ins_deduct    NUMBER,
  cpy_childb_ins_deduct   NUMBER,
  cpy_accum_fund_deduct   NUMBER,
  cpy_integra_ins_deduct  NUMBER,
  special_ot_pay          NUMBER,
  adjust_addition         NUMBER,
  dollar_rate             NUMBER,
  per_retire_ins_deduct   NUMBER,
  praxis_rate             NUMBER,
  probation_rate          NUMBER,
  pending_assign_rate     NUMBER,
  bandh_rate              NUMBER,
  festa_allow_flag        NUMBER,
  eva_bonus_koean         NUMBER,
  bonus_flag              NUMBER,
  bonus_tax_flag          NUMBER,
  biz_trip_allow          NUMBER,
  training_allow          NUMBER,
  tax_benchmark_adjust    NUMBER,
  supple_medicare_deduct  NUMBER,
  eva_bonus_flag          NUMBER,
  smock_allow             NUMBER,
  instructor_allow        NUMBER,
  congratulate_allow      NUMBER,
  pension                 NUMBER,
  retroactive_pay         NUMBER,
  before_taxable_plus     NUMBER,
  before_taxable_deduct   NUMBER,
  after_taxable_plus      NUMBER,
  after_taxable_deduct    NUMBER,
  evaluate_rate           NUMBER,
  achievement_bonus       NUMBER,
  per_medicare_ins_deduct NUMBER,
  cpy_retire_ins_deduct   NUMBER,
  child_supple_medicare   NUMBER,
  service_charge_deduct   NUMBER,
  deposit_fruit_bonus     NUMBER,
  bonus_flag_pq           NUMBER,
  adjust_addition_bonus   NUMBER,
  jingji_buchang_jin      NUMBER,
  month_pay               NUMBER,
  eva_bonus_bq_flag       NUMBER,
  base_pay                NUMBER,
  cashier_allow_bf        NUMBER,
  live_allow_bf           NUMBER,
  basic_pay               NUMBER,
  daily_pay               NUMBER,
  cashier_allow_normal    NUMBER,
  cashier_allow_deduct    NUMBER,
  cashier_allow_count     NUMBER,
  weekday_ot_pay          NUMBER,
  weekend_ot_pay          NUMBER,
  holidy_ot_pay           NUMBER,
  cashier_allow           NUMBER,
  allow_total             NUMBER,
  monthly_bonus_norm      NUMBER,
  daily_bonus_norm        NUMBER,
  bonus                   NUMBER,
  local_eva_rate          NUMBER,
  eva_bonus               NUMBER,
  bonus_total             NUMBER,
  support_allow           NUMBER,
  tenement_allow          NUMBER,
  repast_allow            NUMBER,
  traffic_allow           NUMBER,
  area_grade              CHAR(50),
  live_allow_normal       NUMBER,
  live_allow_deduct       NUMBER,
  live_allow              NUMBER,
  festa_allow             NUMBER,
  subsidy_total           NUMBER,
  casual_leave_deduct     NUMBER,
  absenteeism_deduct      NUMBER,
  no_pay_leave_deduct     NUMBER,
  att_deduct_total        NUMBER,
  per_retire_ins          NUMBER,
  per_medicare_ins        NUMBER,
  per_unemploy_ins        NUMBER,
  per_childbirth_ins      NUMBER,
  per_accumulation_fund   NUMBER,
  per_ins_total           NUMBER,
  other_allow_total       NUMBER,
  cpy_retire_ins          NUMBER,
  cpy_medicare_ins        NUMBER,
  cpy_unemploy_ins        NUMBER,
  cpy_work_injury_ins     NUMBER,
  cpy_childbirth_ins      NUMBER,
  cpy_accumulation_fund   NUMBER,
  integrative_ins         NUMBER,
  supplement_medicare     NUMBER,
  ins_service_charge      NUMBER,
  cpy_ins_total           NUMBER,
  salary_payable          NUMBER,
  pre_tax_pay             NUMBER,
  tax_benchmark           NUMBER,
  taxable_pay             NUMBER,
  per_bonus               NUMBER,
  avg_bonus               NUMBER,
  tax_ratio               NUMBER,
  bonus_tax_ratio         NUMBER,
  algorithm_meduct        NUMBER,
  bonus_alg_meduct        NUMBER,
  income_tax              NUMBER,
  bonus_tax               NUMBER,
  net_bonus               NUMBER,
  perpaid_allow_deduct    NUMBER,
  other_deduct_total      NUMBER,
  net_pay                 NUMBER
)
;

prompt
prompt Creating table PA_HISTORY_201308
prompt ================================
prompt
create table PA_HISTORY_201308
(
  pa_month          CHAR(6),
  empid             VARCHAR2(20),
  pa_formular_month CHAR(6),
  chinesename       VARCHAR2(40),
  deptname          VARCHAR2(100),
  deptid            VARCHAR2(20),
  status_name       VARCHAR2(50),
  status_code       VARCHAR2(20),
  post_name         VARCHAR2(50),
  post_id           VARCHAR2(20),
  post_grade_id     VARCHAR2(20),
  post_grade_name   VARCHAR2(50),
  position_id       VARCHAR2(20),
  position_name     VARCHAR2(50),
  post_group_name   VARCHAR2(50),
  post_group_id     VARCHAR2(20),
  emp_type_name     VARCHAR2(50),
  card_no           VARCHAR2(200),
  att_m_112         NUMBER,
  att_m_58          NUMBER,
  att_m_114         NUMBER,
  att_m_8           NUMBER,
  att_m_9           NUMBER,
  att_m_7           NUMBER,
  att_m_6           NUMBER,
  att_m_110         NUMBER,
  att_m_119         NUMBER,
  att_m_113         NUMBER,
  att_m_52          NUMBER,
  att_m_115         NUMBER,
  att_m_53          NUMBER,
  att_m_2           NUMBER,
  att_m_118         NUMBER,
  att_m_12          NUMBER,
  att_m_15          NUMBER,
  att_m_39          NUMBER,
  att_m_117         NUMBER,
  att_m_20          NUMBER,
  i_pa_12           NUMBER,
  i_pa_29           NUMBER,
  i_pa_28           NUMBER,
  pa_146            NUMBER,
  pa_147            NUMBER
)
;

prompt
prompt Creating table PA_HISTORY_201309
prompt ================================
prompt
create table PA_HISTORY_201309
(
  pa_month          CHAR(6),
  empid             VARCHAR2(20),
  pa_formular_month CHAR(6),
  chinesename       VARCHAR2(40),
  deptname          VARCHAR2(100),
  deptid            VARCHAR2(20),
  status_name       VARCHAR2(50),
  status_code       VARCHAR2(20),
  post_name         VARCHAR2(50),
  post_id           VARCHAR2(20),
  post_grade_id     VARCHAR2(20),
  post_grade_name   VARCHAR2(50),
  position_id       VARCHAR2(20),
  position_name     VARCHAR2(50),
  post_group_name   VARCHAR2(50),
  post_group_id     VARCHAR2(20),
  emp_type_name     VARCHAR2(50),
  card_no           VARCHAR2(200),
  att_m_112         NUMBER,
  att_m_58          NUMBER,
  att_m_114         NUMBER,
  att_m_8           NUMBER,
  att_m_9           NUMBER,
  att_m_7           NUMBER,
  att_m_6           NUMBER,
  att_m_110         NUMBER,
  att_m_119         NUMBER,
  att_m_113         NUMBER,
  att_m_52          NUMBER,
  att_m_115         NUMBER,
  att_m_53          NUMBER,
  att_m_2           NUMBER,
  att_m_118         NUMBER,
  att_m_12          NUMBER,
  att_m_15          NUMBER,
  att_m_39          NUMBER,
  att_m_117         NUMBER,
  att_m_20          NUMBER,
  i_pa_12           NUMBER,
  i_pa_29           NUMBER,
  i_pa_28           NUMBER,
  pa_146            NUMBER,
  pa_147            NUMBER,
  pa_148            NUMBER,
  pa_149            NUMBER,
  pa_150            NUMBER,
  i_pa_32           NUMBER,
  pa_151            NUMBER
)
;

prompt
prompt Creating table PA_HISTORY_201312
prompt ================================
prompt
create table PA_HISTORY_201312
(
  pa_month          CHAR(6),
  empid             VARCHAR2(20),
  pa_formular_month CHAR(6),
  chinesename       VARCHAR2(40),
  deptname          VARCHAR2(100),
  deptid            VARCHAR2(20),
  status_name       VARCHAR2(50),
  status_code       VARCHAR2(20),
  post_name         VARCHAR2(50),
  post_id           VARCHAR2(20),
  post_grade_id     VARCHAR2(20),
  post_grade_name   VARCHAR2(50),
  position_id       VARCHAR2(20),
  position_name     VARCHAR2(50),
  post_group_name   VARCHAR2(50),
  post_group_id     VARCHAR2(20),
  emp_type_name     VARCHAR2(50),
  card_no           VARCHAR2(200),
  att_m_112         NUMBER,
  att_m_58          NUMBER,
  att_m_114         NUMBER,
  att_m_8           NUMBER,
  att_m_9           NUMBER,
  att_m_7           NUMBER,
  att_m_6           NUMBER,
  att_m_110         NUMBER,
  att_m_119         NUMBER,
  att_m_113         NUMBER,
  att_m_52          NUMBER,
  att_m_115         NUMBER,
  att_m_53          NUMBER,
  att_m_2           NUMBER,
  att_m_118         NUMBER,
  att_m_12          NUMBER,
  att_m_15          NUMBER,
  att_m_39          NUMBER,
  att_m_117         NUMBER,
  att_m_20          NUMBER,
  i_pa_12           NUMBER,
  i_pa_29           NUMBER,
  i_pa_28           NUMBER,
  pa_146            NUMBER,
  pa_147            NUMBER,
  pa_148            NUMBER,
  pa_149            NUMBER,
  pa_150            NUMBER,
  i_pa_32           NUMBER,
  pa_151            NUMBER,
  i_pa_33           NUMBER,
  i_pa_35           NUMBER,
  i_pa_34           NUMBER,
  join_date         DATE,
  emp_type_code     VARCHAR2(20),
  i_pa_37           NUMBER,
  i_pa_36           NUMBER,
  pa_153            NUMBER,
  pa_154            NUMBER,
  pa_155            NUMBER,
  pa_156            NUMBER,
  pa_157            NUMBER,
  pa_158            NUMBER,
  pa_159            NUMBER
)
;

prompt
prompt Creating table PA_HR_DAILY
prompt ==========================
prompt
create table PA_HR_DAILY
(
  empid_d                    VARCHAR2(20),
  chinesename_d              VARCHAR2(40),
  chinese_pinyin_d           VARCHAR2(40),
  englishname_d              VARCHAR2(20),
  deptid_d                   VARCHAR2(20),
  department_d               VARCHAR2(4000),
  date_str_d                 VARCHAR2(10),
  position_code_d            VARCHAR2(20),
  position_d                 VARCHAR2(4000),
  post_code_d                VARCHAR2(20),
  post_d                     VARCHAR2(4000),
  post_grade_code_d          VARCHAR2(20),
  postgrade_d                VARCHAR2(4000),
  post_group_name_d          VARCHAR2(4000),
  status_code_d              VARCHAR2(20),
  status_d                   VARCHAR2(4000),
  biz_str_d                  VARCHAR2(500),
  area_code_d                VARCHAR2(20),
  area_d                     VARCHAR2(4000),
  date_started_d             DATE not null,
  date_left_d                DATE,
  end_probation_date_d       DATE,
  welfare_start_date_d       DATE not null,
  welfare_end_date_d         DATE not null,
  live_emp_special_date_d    CHAR(10),
  housing_emp_special_date_d CHAR(10),
  apply_start_date_d         DATE not null,
  apply_end_date_d           DATE not null,
  ynlink                     CHAR(1)
)
;

prompt
prompt Creating table PA_INFO_HISTORY
prompt ==============================
prompt
create table PA_INFO_HISTORY
(
  pamonth   VARCHAR2(8),
  empid     VARCHAR2(20),
  item_name VARCHAR2(50),
  val       VARCHAR2(500)
)
;

prompt
prompt Creating table PA_INS_EMP
prompt =========================
prompt
create table PA_INS_EMP
(
  ins_no      NUMBER not null,
  pa_month    VARCHAR2(10) not null,
  empid       VARCHAR2(20) not null,
  create_date DATE,
  created_by  VARCHAR2(20),
  update_date DATE,
  updated_by  VARCHAR2(20),
  orderno     NUMBER(10),
  activity    NUMBER(1) default 1,
  remark      VARCHAR2(200)
)
;
comment on column PA_INS_EMP.ins_no
  is '���';
comment on column PA_INS_EMP.pa_month
  is '������';
comment on column PA_INS_EMP.empid
  is '����';
create index IDX_PA_SEQ_NO_1 on PA_INS_EMP (INS_NO);
alter table PA_INS_EMP
  add constraint PK_PA_INS_EMP primary key (PA_MONTH, EMPID);

prompt
prompt Creating table PA_INS_FORMULAR
prompt ==============================
prompt
create table PA_INS_FORMULAR
(
  formular_no NUMBER not null,
  item_no     NUMBER not null,
  pa_month    VARCHAR2(6) not null,
  condition   VARCHAR2(2000),
  formular    VARCHAR2(2000) not null,
  description VARCHAR2(2000),
  remark      VARCHAR2(2000),
  create_date DATE,
  created_by  VARCHAR2(20),
  update_date DATE,
  updated_by  VARCHAR2(20),
  orderno     NUMBER,
  activity    NUMBER default 1
)
;
create index INX_PA_INSURANCE_FORMULAR on PA_INS_FORMULAR (ITEM_NO);
alter table PA_INS_FORMULAR
  add constraint PK_PA_INS_FORMULAR primary key (FORMULAR_NO);
alter table PA_INS_FORMULAR
  add constraint UK_PA_INS_FORMULAR unique (ITEM_NO, CONDITION, FORMULAR, PA_MONTH);

prompt
prompt Creating table PA_INS_HISTORY
prompt =============================
prompt
create table PA_INS_HISTORY
(
  pa_month           VARCHAR2(10) not null,
  empid              VARCHAR2(20) not null,
  ins_formular_month CHAR(6),
  chinesename        VARCHAR2(40),
  chinese_pinyin     VARCHAR2(40),
  deptid             VARCHAR2(20),
  deptname           VARCHAR2(100),
  ins_month          CHAR(6),
  b_item_1           NUMBER,
  b_item_2           NUMBER,
  b_item_3           NUMBER,
  i_ins_13           NUMBER,
  i_ins_14           NUMBER,
  i_ins_15           NUMBER,
  i_ins_16           NUMBER,
  i_ins_17           NUMBER,
  i_ins_18           NUMBER,
  i_ins_19           NUMBER,
  i_ins_20           NUMBER,
  i_ins_21           NUMBER,
  i_ins_22           NUMBER,
  i_ins_1            NUMBER,
  i_ins_2            NUMBER,
  i_ins_3            NUMBER,
  i_ins_4            NUMBER,
  i_ins_5            NUMBER,
  i_ins_6            NUMBER,
  i_ins_7            NUMBER,
  i_ins_8            NUMBER,
  i_ins_9            NUMBER,
  i_ins_10           NUMBER,
  i_ins_11           NUMBER,
  i_ins_12           NUMBER,
  ins_1              NUMBER,
  ins_2              NUMBER,
  ins_3              NUMBER,
  ins_4              NUMBER,
  ins_5              NUMBER,
  ins_6              NUMBER,
  ins_7              NUMBER,
  ins_8              NUMBER,
  ins_9              NUMBER,
  ins_10             NUMBER,
  ins_11             NUMBER,
  ins_12             NUMBER,
  ins_13             NUMBER,
  ins_14             NUMBER,
  ins_15             NUMBER,
  ins_16             NUMBER,
  ins_17             NUMBER,
  ins_18             NUMBER,
  ins_19             NUMBER,
  ins_20             NUMBER,
  ins_50             NUMBER,
  ins_51             NUMBER,
  ins_52             NUMBER,
  ins_53             NUMBER,
  ins_54             NUMBER,
  ins_55             NUMBER,
  ins_56             NUMBER,
  ins_57             NUMBER,
  ins_58             NUMBER,
  ins_59             NUMBER,
  ins_60             NUMBER,
  ins_61             NUMBER,
  englishname        VARCHAR2(20),
  hire_date          DATE,
  join_date          DATE,
  end_probation_date DATE,
  left_date          DATE
)
;
alter table PA_INS_HISTORY
  add constraint PK_PA_INSURANCE_HISTORY primary key (PA_MONTH, EMPID);

prompt
prompt Creating table PA_INS_HISTORY_201206
prompt ====================================
prompt
create table PA_INS_HISTORY_201206
(
  pa_month           VARCHAR2(10),
  empid              VARCHAR2(20),
  ins_formular_month CHAR(6),
  chinesename        VARCHAR2(40),
  chinese_pinyin     VARCHAR2(40),
  deptid             VARCHAR2(20),
  deptname           VARCHAR2(100),
  ins_month          CHAR(6),
  b_item_1           NUMBER,
  b_item_2           NUMBER,
  b_item_3           NUMBER,
  i_ins_13           NUMBER,
  i_ins_14           NUMBER,
  i_ins_15           NUMBER,
  i_ins_16           NUMBER,
  i_ins_17           NUMBER,
  i_ins_18           NUMBER,
  i_ins_19           NUMBER,
  i_ins_20           NUMBER,
  i_ins_21           NUMBER,
  i_ins_22           NUMBER,
  i_ins_1            NUMBER,
  i_ins_2            NUMBER,
  i_ins_3            NUMBER,
  i_ins_4            NUMBER,
  i_ins_5            NUMBER,
  i_ins_6            NUMBER,
  i_ins_7            NUMBER,
  i_ins_8            NUMBER,
  i_ins_9            NUMBER,
  i_ins_10           NUMBER,
  i_ins_11           NUMBER,
  i_ins_12           NUMBER,
  ins_1              NUMBER,
  ins_2              NUMBER,
  ins_3              NUMBER,
  ins_4              NUMBER,
  ins_5              NUMBER,
  ins_6              NUMBER,
  ins_7              NUMBER,
  ins_8              NUMBER,
  ins_9              NUMBER,
  ins_10             NUMBER,
  ins_11             NUMBER,
  ins_12             NUMBER,
  ins_13             NUMBER,
  ins_14             NUMBER,
  ins_15             NUMBER,
  ins_16             NUMBER,
  ins_17             NUMBER,
  ins_18             NUMBER,
  ins_19             NUMBER,
  ins_20             NUMBER,
  ins_50             NUMBER,
  ins_51             NUMBER,
  ins_52             NUMBER,
  ins_53             NUMBER,
  ins_54             NUMBER,
  ins_55             NUMBER,
  ins_56             NUMBER,
  ins_57             NUMBER,
  ins_58             NUMBER,
  ins_59             NUMBER,
  ins_60             NUMBER,
  ins_61             NUMBER,
  englishname        VARCHAR2(20),
  hire_date          DATE,
  join_date          DATE,
  end_probation_date DATE,
  left_date          DATE
)
;

prompt
prompt Creating table PA_INS_ITEM
prompt ==========================
prompt
create table PA_INS_ITEM
(
  item_no      NUMBER not null,
  item_id      VARCHAR2(50) not null,
  item_name    VARCHAR2(50),
  item_en_name VARCHAR2(100),
  description  VARCHAR2(4000),
  datatype     VARCHAR2(20),
  calcu_order  NUMBER,
  precision    NUMBER(10,10),
  carry_bit    NUMBER(10,10),
  create_date  DATE,
  created_by   VARCHAR2(20),
  update_date  DATE,
  updated_by   VARCHAR2(20),
  orderno      NUMBER(10),
  activity     NUMBER(1),
  cpny_id      VARCHAR2(20) not null
)
;
comment on column PA_INS_ITEM.item_no
  is '��Ŀ���';
comment on column PA_INS_ITEM.item_id
  is '��ĿID';
comment on column PA_INS_ITEM.item_name
  is '��Ŀ����';
comment on column PA_INS_ITEM.item_en_name
  is 'Ӣ������';
comment on column PA_INS_ITEM.description
  is '����';
comment on column PA_INS_ITEM.datatype
  is '��������';
comment on column PA_INS_ITEM.calcu_order
  is '����˳��';
comment on column PA_INS_ITEM.precision
  is '����';
comment on column PA_INS_ITEM.carry_bit
  is '��λ';
create index INX_PA_INSURANCE_ITEM on PA_INS_ITEM (ITEM_NO);
alter table PA_INS_ITEM
  add constraint PK_PA_INS_ITEM primary key (ITEM_ID, CPNY_ID);

prompt
prompt Creating table PA_INS_PARAM_ITEM
prompt ================================
prompt
create table PA_INS_PARAM_ITEM
(
  param_no           NUMBER(10) not null,
  param_id           VARCHAR2(20) not null,
  param_name         VARCHAR2(60) not null,
  param_en_name      VARCHAR2(60),
  distinct_field_1st VARCHAR2(20),
  distinct_field_2nd VARCHAR2(20),
  pa_month           VARCHAR2(6) not null,
  datatype           VARCHAR2(20),
  description        VARCHAR2(200),
  param_type_code    VARCHAR2(20),
  default_val        VARCHAR2(20),
  create_date        DATE,
  created_by         VARCHAR2(20),
  update_date        DATE,
  updated_by         VARCHAR2(20),
  order_no           NUMBER(10),
  activity           NUMBER(1),
  cpny_id            VARCHAR2(20)
)
;
create index INX_PA_INS_PARAM_ITEM on PA_INS_PARAM_ITEM (PARAM_NO);
alter table PA_INS_PARAM_ITEM
  add constraint PK_PA_INS_PARAM_ITEM primary key (PARAM_NO);
alter table PA_INS_PARAM_ITEM
  add constraint UK_PA_INS_PARAM_ITEM unique (PARAM_ID, PA_MONTH);

prompt
prompt Creating table PA_INS_PARAM_DATA
prompt ================================
prompt
create table PA_INS_PARAM_DATA
(
  param_data_no   NUMBER(10) not null,
  param_no        NUMBER(10) not null,
  field1_value    VARCHAR2(50),
  field1_en_value VARCHAR2(50),
  return_value    VARCHAR2(200),
  field2_value    VARCHAR2(50),
  field2_en_value VARCHAR2(50),
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  order_no        NUMBER(10),
  activity        NUMBER(1) default 1,
  remark          VARCHAR2(200)
)
;
create index IDX_PA_INS_PARAM_DATA on PA_INS_PARAM_DATA (PARAM_NO, FIELD1_VALUE, FIELD2_VALUE);
alter table PA_INS_PARAM_DATA
  add constraint PK_PA_INS_PARAM_DATA primary key (PARAM_DATA_NO);
alter table PA_INS_PARAM_DATA
  add constraint FK_PA_INS_PARAM_DATA foreign key (PARAM_NO)
  references PA_INS_PARAM_ITEM (PARAM_NO) on delete cascade;

prompt
prompt Creating table PA_INS_PARAM_DATA_T
prompt ==================================
prompt
create table PA_INS_PARAM_DATA_T
(
  param_data_no   NUMBER(10) not null,
  param_no        NUMBER(10) not null,
  field1_value    VARCHAR2(50),
  field1_en_value VARCHAR2(50),
  return_value    VARCHAR2(200),
  field2_value    VARCHAR2(50),
  field2_en_value VARCHAR2(50),
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  order_no        NUMBER(10),
  activity        NUMBER(1) default 1,
  remark          VARCHAR2(200),
  flag            NUMBER(1),
  ud_date         DATE,
  ud_by           VARCHAR2(20)
)
;
comment on column PA_INS_PARAM_DATA_T.flag
  is '1-UPDATE 0-DELETE';
create index IDX_PA_INS_PARAM_DATA_T on PA_INS_PARAM_DATA_T (PARAM_NO, FIELD1_VALUE, FIELD2_VALUE);

prompt
prompt Creating table PA_INS_PARAM_DATA_TEMP
prompt =====================================
prompt
create table PA_INS_PARAM_DATA_TEMP
(
  param_data_no   NUMBER(10) not null,
  param_no        NUMBER(10) not null,
  field1_value    VARCHAR2(50),
  field1_en_value VARCHAR2(50),
  return_value    VARCHAR2(200),
  field2_value    VARCHAR2(50),
  field2_en_value VARCHAR2(50),
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  order_no        NUMBER(10),
  activity        NUMBER(1) default 1,
  remark          VARCHAR2(200)
)
;

prompt
prompt Creating table PA_ITEM
prompt ======================
prompt
create table PA_ITEM
(
  item_no      NUMBER not null,
  item_id      VARCHAR2(50),
  item_name    VARCHAR2(50),
  item_en_name VARCHAR2(50),
  description  VARCHAR2(4000),
  datatype     VARCHAR2(20),
  calcu_order  NUMBER,
  precision    NUMBER,
  carry_bit    NUMBER,
  calc_flag    VARCHAR2(20),
  create_date  DATE,
  created_by   VARCHAR2(20),
  update_date  DATE,
  updated_by   VARCHAR2(20),
  activity     NUMBER(1),
  cpny_id      VARCHAR2(20)
)
;
comment on column PA_ITEM.calc_flag
  is '�Ƿ��뽱���й���';
alter table PA_ITEM
  add constraint PK_PA_ITEM primary key (ITEM_NO);

prompt
prompt Creating table PA_PARAM_ITEM
prompt ============================
prompt
create table PA_PARAM_ITEM
(
  param_no           NUMBER not null,
  param_id           VARCHAR2(50),
  param_name         VARCHAR2(50) not null,
  param_en_name      VARCHAR2(50),
  distinct_field_1st VARCHAR2(50),
  distinct_field_2nd VARCHAR2(50),
  pa_month           VARCHAR2(6),
  datatype           VARCHAR2(50),
  description        VARCHAR2(200),
  param_type_code    VARCHAR2(50),
  default_val        VARCHAR2(50),
  create_date        DATE,
  created_by         VARCHAR2(20),
  update_date        DATE,
  updated_by         VARCHAR2(20),
  order_no           NUMBER,
  activity           NUMBER,
  cpny_id            VARCHAR2(20)
)
;
alter table PA_PARAM_ITEM
  add constraint PK_PA_PARAM_ITEM primary key (PARAM_NO);
alter table PA_PARAM_ITEM
  add constraint UK_PA_PARAM_ITEM unique (PARAM_NAME, PA_MONTH);

prompt
prompt Creating table PA_PARAM_DATA
prompt ============================
prompt
create table PA_PARAM_DATA
(
  param_data_no   NUMBER not null,
  param_no        NUMBER not null,
  field1_value    VARCHAR2(50),
  return_value    VARCHAR2(200),
  field2_value    VARCHAR2(50),
  field1_en_value VARCHAR2(50),
  field2_en_value VARCHAR2(50),
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  order_no        NUMBER,
  activity        NUMBER,
  remark          VARCHAR2(200),
  pa_month        VARCHAR2(20),
  cpny_id         VARCHAR2(20)
)
;
create index IDX_PA_DATA on PA_PARAM_DATA (PARAM_NO, FIELD1_VALUE, FIELD2_VALUE);
create index IDX_PA_PARAM_NO on PA_PARAM_DATA (PARAM_NO);
alter table PA_PARAM_DATA
  add constraint PK_PA_PARAM_DATA primary key (PARAM_DATA_NO);
alter table PA_PARAM_DATA
  add constraint FK_PA_PARAM_DATA foreign key (PARAM_NO)
  references PA_PARAM_ITEM (PARAM_NO) on delete cascade;

prompt
prompt Creating table PA_PARAM_DATA_T
prompt ==============================
prompt
create table PA_PARAM_DATA_T
(
  param_data_no   NUMBER(10) not null,
  param_no        NUMBER(10) not null,
  field1_value    VARCHAR2(50),
  field1_en_value VARCHAR2(50),
  return_value    VARCHAR2(200),
  field2_value    VARCHAR2(50),
  field2_en_value VARCHAR2(50),
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  order_no        NUMBER(10),
  activity        NUMBER(1) default 1,
  remark          VARCHAR2(200),
  flag            NUMBER(1),
  ud_date         DATE,
  ud_by           VARCHAR2(20),
  pa_month        VARCHAR2(20),
  cpny_id         VARCHAR2(20)
)
;
comment on column PA_PARAM_DATA_T.flag
  is '1-UPDATE 0-DELETE';
create index IDX_PA_PARAM_DATA_T on PA_PARAM_DATA_T (PARAM_NO, FIELD1_VALUE, FIELD2_VALUE);

prompt
prompt Creating table PA_PROGRESS
prompt ==========================
prompt
create table PA_PROGRESS
(
  month_str         VARCHAR2(6) not null,
  monthly_lock_flag NUMBER default 0,
  pa_lock_flag      NUMBER default 0,
  pa_open_flag      NUMBER default 0,
  create_date       DATE,
  created_by        VARCHAR2(20),
  update_date       DATE,
  updated_by        VARCHAR2(20),
  ins_lock_flag     NUMBER default 0,
  daily_lock_flag   NUMBER default 0,
  bonus_lock_flag   NUMBER default 0,
  remark            VARCHAR2(200)
)
;
comment on column PA_PROGRESS.monthly_lock_flag
  is '�¿���������־';
comment on column PA_PROGRESS.pa_lock_flag
  is '��������';
comment on column PA_PROGRESS.pa_open_flag
  is '���ʿ���';
comment on column PA_PROGRESS.ins_lock_flag
  is '��������';
comment on column PA_PROGRESS.bonus_lock_flag
  is '��������';
alter table PA_PROGRESS
  add constraint PK_PA_PROGRESS primary key (MONTH_STR);

prompt
prompt Creating table PA_REPORT_TITLE
prompt ==============================
prompt
create table PA_REPORT_TITLE
(
  report_no          NUMBER not null,
  report_name        VARCHAR2(80),
  report_description VARCHAR2(500),
  report_title       VARCHAR2(200),
  header             VARCHAR2(200),
  second_title       VARCHAR2(200),
  active             NUMBER
)
;
alter table PA_REPORT_TITLE
  add constraint PK_PA_REPORT_TITLE primary key (REPORT_NO);

prompt
prompt Creating table PA_REPORT_ITEM
prompt =============================
prompt
create table PA_REPORT_ITEM
(
  report_item_no   NUMBER not null,
  report_no        NUMBER not null,
  item_name        VARCHAR2(50),
  pa_item_no       NUMBER,
  t_p_report_no    NUMBER,
  item_description VARCHAR2(200),
  data_type        VARCHAR2(50),
  active           NUMBER
)
;
alter table PA_REPORT_ITEM
  add constraint PK_PA_REPORT_ITEM primary key (REPORT_ITEM_NO);
alter table PA_REPORT_ITEM
  add constraint FK_PA_REPOR_REPORT_IT_PA_REPOR foreign key (T_P_REPORT_NO)
  references PA_REPORT_TITLE (REPORT_NO);

prompt
prompt Creating table PA_REPORT
prompt ========================
prompt
create table PA_REPORT
(
  report_no      NUMBER not null,
  report_item_no NUMBER not null,
  row_seq        NUMBER,
  value          VARCHAR2(50),
  insert_date    DATE
)
;
alter table PA_REPORT
  add constraint PK_PA_REPORT primary key (REPORT_NO);
alter table PA_REPORT
  add constraint FK_PA_REPOR_REFERENCE_PA_REPOR foreign key (REPORT_ITEM_NO)
  references PA_REPORT_ITEM (REPORT_ITEM_NO);

prompt
prompt Creating table PA_SAP_INTERFACE
prompt ===============================
prompt
create table PA_SAP_INTERFACE
(
  account_code     VARCHAR2(50),
  account_name     VARCHAR2(50),
  on_loan          VARCHAR2(50),
  hrm_account_name VARCHAR2(50),
  hrm_pa_item_id   VARCHAR2(50),
  hrm_deptid       VARCHAR2(50)
)
;

prompt
prompt Creating table PA_TAX_RATE
prompt ==========================
prompt
create table PA_TAX_RATE
(
  tax_no      NUMBER(10) not null,
  tax_type    VARCHAR2(50) not null,
  income_from NUMBER(14,4) not null,
  income_to   NUMBER(14,4) not null,
  tax_rate    NUMBER(14,4) not null,
  deduct      NUMBER(14,4) not null
)
;
alter table PA_TAX_RATE
  add constraint PK primary key (TAX_NO);

prompt
prompt Creating table PLAN_TABLE
prompt =========================
prompt
create table PLAN_TABLE
(
  statement_id      VARCHAR2(30),
  plan_id           NUMBER,
  timestamp         DATE,
  remarks           VARCHAR2(4000),
  operation         VARCHAR2(30),
  options           VARCHAR2(255),
  object_node       VARCHAR2(128),
  object_owner      VARCHAR2(30),
  object_name       VARCHAR2(30),
  object_alias      VARCHAR2(65),
  object_instance   INTEGER,
  object_type       VARCHAR2(30),
  optimizer         VARCHAR2(255),
  search_columns    NUMBER,
  id                INTEGER,
  parent_id         INTEGER,
  depth             INTEGER,
  position          INTEGER,
  cost              INTEGER,
  cardinality       INTEGER,
  bytes             INTEGER,
  other_tag         VARCHAR2(255),
  partition_start   VARCHAR2(255),
  partition_stop    VARCHAR2(255),
  partition_id      INTEGER,
  other             LONG,
  distribution      VARCHAR2(30),
  cpu_cost          INTEGER,
  io_cost           INTEGER,
  temp_space        INTEGER,
  access_predicates VARCHAR2(4000),
  filter_predicates VARCHAR2(4000),
  projection        VARCHAR2(4000),
  time              INTEGER,
  qblock_name       VARCHAR2(30)
)
;

prompt
prompt Creating table PROCESS_AFFIRM
prompt =============================
prompt
create table PROCESS_AFFIRM
(
  process_affirm_no NUMBER not null,
  object_id         VARCHAR2(20) not null,
  affirm_flag       NUMBER,
  object_status_id  VARCHAR2(20),
  affirmor_id       VARCHAR2(20),
  create_date       DATE,
  created_by        VARCHAR2(20),
  update_date       DATE,
  updated_by        VARCHAR2(20),
  activity          NUMBER(1),
  affirm_object     VARCHAR2(20),
  app_remark        VARCHAR2(200),
  cpny_id           VARCHAR2(20),
  object_type_id    VARCHAR2(20)
)
;
comment on table PROCESS_AFFIRM
  is '������������';
comment on column PROCESS_AFFIRM.process_affirm_no
  is '������Ϣ��ţ�ϵͳ�Զ����ɣ�';
comment on column PROCESS_AFFIRM.object_id
  is '����˵�OBJECT';
comment on column PROCESS_AFFIRM.affirm_flag
  is '�Ƿ���ñ��,0Ϊδ����,1Ϊ����ͨ��,2Ϊ����δͨ��';
comment on column PROCESS_AFFIRM.object_status_id
  is '�����״̬';
comment on column PROCESS_AFFIRM.affirmor_id
  is '�����߹���';
comment on column PROCESS_AFFIRM.affirm_object
  is '��BOM/DOC/MAT��';
comment on column PROCESS_AFFIRM.object_type_id
  is '��BOM-XX/DOC-XX/MAT-XX/ORD-XX��';

prompt
prompt Creating table PROCESS_AFFIRM_RELATION
prompt ======================================
prompt
create table PROCESS_AFFIRM_RELATION
(
  cpny_id                    VARCHAR2(20),
  affirmor_id                VARCHAR2(20) not null,
  object_type_id             VARCHAR2(50) not null,
  object_status_id           VARCHAR2(20) not null,
  create_date                DATE,
  created_by                 VARCHAR2(20),
  update_date                DATE,
  updated_by                 VARCHAR2(20),
  activity                   NUMBER,
  orderno                    NUMBER(5),
  process_affirm_relation_no NUMBER
)
;
comment on table PROCESS_AFFIRM_RELATION
  is '������˹�ϵ��';
comment on column PROCESS_AFFIRM_RELATION.affirmor_id
  is '�����';
comment on column PROCESS_AFFIRM_RELATION.object_type_id
  is '����˵�����';
comment on column PROCESS_AFFIRM_RELATION.object_status_id
  is '����˵�״̬';

prompt
prompt Creating table PROCESS_ESS_RELATION
prompt ===================================
prompt
create table PROCESS_ESS_RELATION
(
  process_key VARCHAR2(64) not null,
  table_name  VARCHAR2(64)
)
;
alter table PROCESS_ESS_RELATION
  add constraint PROCESS_PRIMARY_KEY primary key (PROCESS_KEY);

prompt
prompt Creating table PROCESS_ITEM_INFO
prompt ================================
prompt
create table PROCESS_ITEM_INFO
(
  object_type_id   VARCHAR2(20) not null,
  status_id        VARCHAR2(20) not null,
  status_type_code VARCHAR2(20),
  pre_status_id1   VARCHAR2(20),
  pre_status_id2   VARCHAR2(20),
  pre_status_id3   VARCHAR2(20),
  suc_status_id    VARCHAR2(20),
  status_tag1      NUMBER(1),
  status_tag3      NUMBER(1),
  status_tag4      NUMBER(1),
  created_by       VARCHAR2(20),
  create_date      DATE,
  updated_by       VARCHAR2(20),
  update_date      DATE,
  activity         NUMBER(1),
  cpny_id          VARCHAR2(20) not null
)
;
comment on column PROCESS_ITEM_INFO.object_type_id
  is '���ͱ��';
comment on column PROCESS_ITEM_INFO.status_id
  is '״̬���';
comment on column PROCESS_ITEM_INFO.status_type_code
  is '״̬����';
comment on column PROCESS_ITEM_INFO.pre_status_id1
  is 'ǰ��״̬���1';
comment on column PROCESS_ITEM_INFO.pre_status_id2
  is 'ǰ��״̬���2';
comment on column PROCESS_ITEM_INFO.pre_status_id3
  is 'ǰ��״̬���3';
comment on column PROCESS_ITEM_INFO.suc_status_id
  is '���״̬���';
comment on column PROCESS_ITEM_INFO.status_tag1
  is '���λ1';
comment on column PROCESS_ITEM_INFO.status_tag3
  is '���λ3';
comment on column PROCESS_ITEM_INFO.status_tag4
  is '���λ4';
alter table PROCESS_ITEM_INFO
  add constraint PROCESS_KEY primary key (OBJECT_TYPE_ID, STATUS_ID, CPNY_ID);

prompt
prompt Creating table PROCESS_OBJECT_TYPE_INFO
prompt =======================================
prompt
create table PROCESS_OBJECT_TYPE_INFO
(
  object_type_id      VARCHAR2(20) not null,
  object_type_name    VARCHAR2(20) not null,
  description         VARCHAR2(200),
  created_by          VARCHAR2(20),
  create_date         DATE,
  updated_by          VARCHAR2(20),
  update_date         DATE,
  activity            NUMBER(1),
  cpny_id             VARCHAR2(20),
  orderno             NUMBER(10),
  object_type_en_name VARCHAR2(20),
  parent_type_id      VARCHAR2(20),
  depth               NUMBER(1),
  default_status_id   VARCHAR2(20)
)
;
comment on table PROCESS_OBJECT_TYPE_INFO
  is '�ĵ����ͱ�';
comment on column PROCESS_OBJECT_TYPE_INFO.object_type_id
  is '�ĵ����ͱ��';
comment on column PROCESS_OBJECT_TYPE_INFO.object_type_name
  is '�ĵ���������';
comment on column PROCESS_OBJECT_TYPE_INFO.description
  is '�ĵ���������';
comment on column PROCESS_OBJECT_TYPE_INFO.created_by
  is '������';
comment on column PROCESS_OBJECT_TYPE_INFO.create_date
  is '��������';
comment on column PROCESS_OBJECT_TYPE_INFO.updated_by
  is '������';
comment on column PROCESS_OBJECT_TYPE_INFO.update_date
  is '��������';
comment on column PROCESS_OBJECT_TYPE_INFO.activity
  is '�Ƿ����';
comment on column PROCESS_OBJECT_TYPE_INFO.cpny_id
  is '��˾���';
comment on column PROCESS_OBJECT_TYPE_INFO.object_type_en_name
  is '�ĵ�����Ӣ������';
comment on column PROCESS_OBJECT_TYPE_INFO.parent_type_id
  is '��������';
comment on column PROCESS_OBJECT_TYPE_INFO.depth
  is '���';
comment on column PROCESS_OBJECT_TYPE_INFO.default_status_id
  is '��ʼ״̬';
alter table PROCESS_OBJECT_TYPE_INFO
  add constraint PK_PROCESS_OBJECT_TYPE_INFO primary key (OBJECT_TYPE_ID);

prompt
prompt Creating table PROCESS_OBJECT_TYPE_GRANT
prompt ========================================
prompt
create table PROCESS_OBJECT_TYPE_GRANT
(
  object_type_id VARCHAR2(20) not null,
  grant_id       VARCHAR2(20) not null,
  creater        NUMBER,
  selectr        NUMBER,
  updater        NUMBER,
  deleter        NUMBER,
  create_date    DATE,
  created_by     VARCHAR2(20),
  update_date    DATE,
  updated_by     VARCHAR2(20),
  orderno        NUMBER(10),
  activity       NUMBER(1),
  cpny_id        VARCHAR2(20)
)
;
comment on table PROCESS_OBJECT_TYPE_GRANT
  is '�ĵ�����Ȩ�ޱ�';
comment on column PROCESS_OBJECT_TYPE_GRANT.object_type_id
  is '�ĵ�����';
comment on column PROCESS_OBJECT_TYPE_GRANT.grant_id
  is '��ɫ';
comment on column PROCESS_OBJECT_TYPE_GRANT.creater
  is '��������';
comment on column PROCESS_OBJECT_TYPE_GRANT.selectr
  is '�鿴Ȩ��';
comment on column PROCESS_OBJECT_TYPE_GRANT.updater
  is '�޸�Ȩ��';
comment on column PROCESS_OBJECT_TYPE_GRANT.deleter
  is '��������';
alter table PROCESS_OBJECT_TYPE_GRANT
  add constraint PK_PROCESS_OBJECT_TYPE_GRANT primary key (OBJECT_TYPE_ID, GRANT_ID);
alter table PROCESS_OBJECT_TYPE_GRANT
  add constraint FK_PROCESS_OBJECT_TYPE_GRANT foreign key (OBJECT_TYPE_ID)
  references PROCESS_OBJECT_TYPE_INFO (OBJECT_TYPE_ID);

prompt
prompt Creating table PROCESS_STATUS_INFO
prompt ==================================
prompt
create table PROCESS_STATUS_INFO
(
  status_id      VARCHAR2(20),
  status_name    VARCHAR2(20),
  status_en_name VARCHAR2(20),
  description    VARCHAR2(200),
  created_by     VARCHAR2(20),
  create_date    DATE,
  updated_by     VARCHAR2(20),
  update_date    DATE,
  cpny_id        VARCHAR2(20),
  activity       NUMBER(1)
)
;
comment on column PROCESS_STATUS_INFO.status_id
  is '״̬���';
comment on column PROCESS_STATUS_INFO.status_name
  is '״̬����';
comment on column PROCESS_STATUS_INFO.status_en_name
  is '״̬Ӣ������';
comment on column PROCESS_STATUS_INFO.description
  is '����';
comment on column PROCESS_STATUS_INFO.created_by
  is '������';
comment on column PROCESS_STATUS_INFO.create_date
  is '��������';
comment on column PROCESS_STATUS_INFO.updated_by
  is '������';
comment on column PROCESS_STATUS_INFO.update_date
  is '��������';
comment on column PROCESS_STATUS_INFO.cpny_id
  is '��˾��';
comment on column PROCESS_STATUS_INFO.activity
  is '�Ƿ����';

prompt
prompt Creating table PRODUCT_PROPERTY_DETAIL
prompt ======================================
prompt
create table PRODUCT_PROPERTY_DETAIL
(
  product_no  VARCHAR2(20),
  property_id VARCHAR2(20),
  p_value_id  VARCHAR2(20),
  create_date DATE,
  created_by  VARCHAR2(20),
  update_date DATE,
  updated_by  VARCHAR2(20),
  activity    NUMBER(1),
  cpny_id     VARCHAR2(20),
  category_id VARCHAR2(20)
)
;

prompt
prompt Creating table PROSTOR_INSTORAGE_INFO
prompt =====================================
prompt
create table PROSTOR_INSTORAGE_INFO
(
  instorage_no      VARCHAR2(20),
  instorage_id      VARCHAR2(20),
  purchase_order_id VARCHAR2(20),
  supplier_no       VARCHAR2(20),
  prostor_desc      VARCHAR2(500),
  create_date       DATE,
  created_by        VARCHAR2(20),
  update_date       DATE,
  updated_by        VARCHAR2(20),
  activity          NUMBER(1),
  cpny_id           VARCHAR2(20),
  status            NUMBER(1),
  in_date           DATE
)
;
comment on column PROSTOR_INSTORAGE_INFO.status
  is '��ⵥ״̬��2�ݴ棬1���������';
comment on column PROSTOR_INSTORAGE_INFO.in_date
  is '���ʱ��';

prompt
prompt Creating table PROSTOR_INSTORAGE_PRODUCT
prompt ========================================
prompt
create table PROSTOR_INSTORAGE_PRODUCT
(
  instorage_id  VARCHAR2(20),
  product_no    VARCHAR2(20),
  quantity      NUMBER(10),
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  activity      NUMBER(1),
  cpny_id       VARCHAR2(20),
  storage_no    VARCHAR2(20),
  product_name  VARCHAR2(50),
  product_cas   VARCHAR2(50),
  product_num   VARCHAR2(50),
  product_id    VARCHAR2(20),
  specification VARCHAR2(50),
  unit_name     VARCHAR2(20),
  unit_price    NUMBER(10,2),
  storage_name  VARCHAR2(50),
  stor_addr     VARCHAR2(100)
)
;

prompt
prompt Creating table PROSTOR_OUTSTORAGE_INFO
prompt ======================================
prompt
create table PROSTOR_OUTSTORAGE_INFO
(
  outstorage_no  NUMBER,
  outstorage_id  VARCHAR2(20),
  cust_no        VARCHAR2(50),
  create_date    DATE,
  created_by     VARCHAR2(20),
  update_date    DATE,
  updated_by     VARCHAR2(20),
  activity       NUMBER(1) default 1,
  cpny_id        VARCHAR2(20),
  sales_order_id VARCHAR2(50),
  cust_name      VARCHAR2(200),
  operator       VARCHAR2(50),
  phone_num      VARCHAR2(20),
  remarks        VARCHAR2(200),
  out_date       DATE,
  money          NUMBER,
  discount       NUMBER,
  dis_money      NUMBER
)
;
comment on column PROSTOR_OUTSTORAGE_INFO.outstorage_no
  is '����';
comment on column PROSTOR_OUTSTORAGE_INFO.outstorage_id
  is '��ˮ��';
comment on column PROSTOR_OUTSTORAGE_INFO.cust_no
  is '�ͻ�NO';
comment on column PROSTOR_OUTSTORAGE_INFO.sales_order_id
  is '���۵����';
comment on column PROSTOR_OUTSTORAGE_INFO.cust_name
  is '�ͻ�����';
comment on column PROSTOR_OUTSTORAGE_INFO.operator
  is '����Ա';
comment on column PROSTOR_OUTSTORAGE_INFO.phone_num
  is '�ͻ��绰';
comment on column PROSTOR_OUTSTORAGE_INFO.remarks
  is '��ע';
comment on column PROSTOR_OUTSTORAGE_INFO.out_date
  is '����ʱ��';
comment on column PROSTOR_OUTSTORAGE_INFO.money
  is '���';
comment on column PROSTOR_OUTSTORAGE_INFO.discount
  is '�ۿ�';
comment on column PROSTOR_OUTSTORAGE_INFO.dis_money
  is '�ۺ���';

prompt
prompt Creating table PROSTOR_OUTSTORAGE_PRODUCT
prompt =========================================
prompt
create table PROSTOR_OUTSTORAGE_PRODUCT
(
  outstorage_id VARCHAR2(20),
  product_no    VARCHAR2(20),
  quantity      NUMBER,
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  activity      NUMBER(1) default 1,
  cpny_id       VARCHAR2(20),
  storage_no    VARCHAR2(20),
  money         NUMBER,
  product_name  VARCHAR2(50),
  storage_name  VARCHAR2(50),
  product_num   VARCHAR2(50),
  product_cas   VARCHAR2(50),
  stor_addr     VARCHAR2(100),
  product_id    VARCHAR2(30),
  specification VARCHAR2(20),
  unit_name     VARCHAR2(20),
  price         NUMBER,
  dis_money     NUMBER,
  discount      NUMBER
)
;
comment on column PROSTOR_OUTSTORAGE_PRODUCT.outstorage_id
  is '��ˮ��';
comment on column PROSTOR_OUTSTORAGE_PRODUCT.product_no
  is '��ƷNO';
comment on column PROSTOR_OUTSTORAGE_PRODUCT.quantity
  is '������';
comment on column PROSTOR_OUTSTORAGE_PRODUCT.storage_no
  is '�ֿ�NO';
comment on column PROSTOR_OUTSTORAGE_PRODUCT.money
  is '���';
comment on column PROSTOR_OUTSTORAGE_PRODUCT.product_name
  is '��Ʒ����';
comment on column PROSTOR_OUTSTORAGE_PRODUCT.storage_name
  is '�ֿ�����';
comment on column PROSTOR_OUTSTORAGE_PRODUCT.product_num
  is '����';
comment on column PROSTOR_OUTSTORAGE_PRODUCT.product_cas
  is 'CAS�ţ���ѧƷ����ר��';
comment on column PROSTOR_OUTSTORAGE_PRODUCT.stor_addr
  is '��λ';
comment on column PROSTOR_OUTSTORAGE_PRODUCT.product_id
  is '��ƷID';
comment on column PROSTOR_OUTSTORAGE_PRODUCT.specification
  is '���';
comment on column PROSTOR_OUTSTORAGE_PRODUCT.unit_name
  is '��λ';
comment on column PROSTOR_OUTSTORAGE_PRODUCT.price
  is '����';
comment on column PROSTOR_OUTSTORAGE_PRODUCT.dis_money
  is '�ۺ���';
comment on column PROSTOR_OUTSTORAGE_PRODUCT.discount
  is '�ۿ�';

prompt
prompt Creating table PROSTOR_PRODUCT
prompt ==============================
prompt
create table PROSTOR_PRODUCT
(
  product_no          VARCHAR2(20),
  product_id          VARCHAR2(20),
  product_name        VARCHAR2(100),
  product_en_name     VARCHAR2(100),
  unit_price          NUMBER,
  unit_code_id        VARCHAR2(20),
  product_category_id VARCHAR2(20),
  create_date         DATE,
  created_by          VARCHAR2(20),
  update_date         DATE,
  updated_by          VARCHAR2(20),
  activity            NUMBER(1),
  cpny_id             VARCHAR2(20),
  remark              VARCHAR2(1000),
  status              NUMBER(1),
  specification       VARCHAR2(50),
  photopath           VARCHAR2(100),
  product_cas         VARCHAR2(50),
  product_num         VARCHAR2(20)
)
;
comment on column PROSTOR_PRODUCT.product_id
  is '#*��ƷID';
comment on column PROSTOR_PRODUCT.product_name
  is '#*��Ʒ����';
comment on column PROSTOR_PRODUCT.unit_price
  is '#*������';
comment on column PROSTOR_PRODUCT.unit_code_id
  is '#*��λ';
comment on column PROSTOR_PRODUCT.product_category_id
  is '#*��Ʒ���';
comment on column PROSTOR_PRODUCT.remark
  is '#��ע';
comment on column PROSTOR_PRODUCT.specification
  is '#*���';

prompt
prompt Creating table PROSTOR_PRODUCT_SALES_MODEL
prompt ==========================================
prompt
create table PROSTOR_PRODUCT_SALES_MODEL
(
  product_no    VARCHAR2(20),
  sales_mode_no VARCHAR2(20),
  price         NUMBER,
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  activity      NUMBER(1),
  cpny_id       VARCHAR2(20)
)
;

prompt
prompt Creating table PROSTOR_PURCHASE_ORDER
prompt =====================================
prompt
create table PROSTOR_PURCHASE_ORDER
(
  purchase_order_no VARCHAR2(20),
  purchase_order_id VARCHAR2(30),
  empid             VARCHAR2(20),
  purchase_date     DATE,
  payable_amount    NUMBER(10,2),
  payment_mode      VARCHAR2(20),
  status            VARCHAR2(50),
  create_date       DATE,
  created_by        VARCHAR2(20),
  update_date       DATE,
  updated_by        VARCHAR2(20),
  activity          NUMBER(1) default 1,
  cpny_id           VARCHAR2(20),
  transport_mode    VARCHAR2(100),
  remarks           VARCHAR2(100),
  checker_id        VARCHAR2(20),
  affirm_flag       VARCHAR2(10) default 'affirm0',
  processid         VARCHAR2(20)
)
;
comment on column PROSTOR_PURCHASE_ORDER.purchase_order_no
  is '�ɹ�������';
comment on column PROSTOR_PURCHASE_ORDER.purchase_order_id
  is '�ɹ�����ˮ��';
comment on column PROSTOR_PURCHASE_ORDER.empid
  is '�ɹ���';
comment on column PROSTOR_PURCHASE_ORDER.purchase_date
  is '�ɹ�����';
comment on column PROSTOR_PURCHASE_ORDER.payable_amount
  is 'Ӧ�����';
comment on column PROSTOR_PURCHASE_ORDER.payment_mode
  is '���ʽ';
comment on column PROSTOR_PURCHASE_ORDER.status
  is '���״̬��PurchaseOrderState0:δ��ɣ�PurchaseOrderState1:����ɣ�';
comment on column PROSTOR_PURCHASE_ORDER.transport_mode
  is '���䷽ʽ';
comment on column PROSTOR_PURCHASE_ORDER.remarks
  is '��ע';
comment on column PROSTOR_PURCHASE_ORDER.checker_id
  is '�����';
comment on column PROSTOR_PURCHASE_ORDER.affirm_flag
  is '��˱�־��affirm0δ��ˣ�affirm1���ͨ����affirm2���';
comment on column PROSTOR_PURCHASE_ORDER.processid
  is '����ID';

prompt
prompt Creating table PROSTOR_PURCHASE_ORDER_DETAIL
prompt ============================================
prompt
create table PROSTOR_PURCHASE_ORDER_DETAIL
(
  purchase_order_id              VARCHAR2(50),
  product_no                     VARCHAR2(20),
  quantity                       NUMBER(10,2),
  unit_price                     NUMBER(10,2),
  supplier_no                    VARCHAR2(20),
  remarks                        VARCHAR2(200),
  create_date                    DATE,
  created_by                     VARCHAR2(20),
  update_date                    DATE,
  updated_by                     VARCHAR2(20),
  activity                       NUMBER(1),
  cpny_id                        VARCHAR2(20),
  inquantity                     NUMBER(10,2),
  sum_money                      NUMBER(10,2),
  expected_arrival_date          VARCHAR2(50),
  supplier_product_no            VARCHAR2(20),
  purchase_order_detail_no       VARCHAR2(20),
  product_id                     VARCHAR2(20),
  product_name                   VARCHAR2(50),
  product_unit                   VARCHAR2(20),
  product_specification          VARCHAR2(50),
  product_cas                    VARCHAR2(50),
  supplier_name                  VARCHAR2(100),
  supplier_product_id            VARCHAR2(20),
  supplier_product_name          VARCHAR2(50),
  supplier_unit_price            NUMBER(10,2),
  sum_money_add                  NUMBER(10,2),
  supplier_product_specification NVARCHAR2(50)
)
;
comment on column PROSTOR_PURCHASE_ORDER_DETAIL.purchase_order_id
  is '�ɹ���';
comment on column PROSTOR_PURCHASE_ORDER_DETAIL.product_no
  is '����Ʒ��PRODUCT_NO';
comment on column PROSTOR_PURCHASE_ORDER_DETAIL.quantity
  is '����';
comment on column PROSTOR_PURCHASE_ORDER_DETAIL.unit_price
  is '����';
comment on column PROSTOR_PURCHASE_ORDER_DETAIL.supplier_no
  is '����������';
comment on column PROSTOR_PURCHASE_ORDER_DETAIL.inquantity
  is '����������';
comment on column PROSTOR_PURCHASE_ORDER_DETAIL.sum_money
  is '���';
comment on column PROSTOR_PURCHASE_ORDER_DETAIL.expected_arrival_date
  is '������������';
comment on column PROSTOR_PURCHASE_ORDER_DETAIL.supplier_product_no
  is '��Ӧ�����̵���Ʒ';
comment on column PROSTOR_PURCHASE_ORDER_DETAIL.purchase_order_detail_no
  is '�ɹ�������NO';
comment on column PROSTOR_PURCHASE_ORDER_DETAIL.product_id
  is '����˾��Ʒ���';
comment on column PROSTOR_PURCHASE_ORDER_DETAIL.product_name
  is '����˾��ƷƷ��';
comment on column PROSTOR_PURCHASE_ORDER_DETAIL.product_unit
  is '����˾��Ʒ��λ';
comment on column PROSTOR_PURCHASE_ORDER_DETAIL.product_specification
  is '����˾��Ʒ���';
comment on column PROSTOR_PURCHASE_ORDER_DETAIL.product_cas
  is '����˾��ƷCAS';
comment on column PROSTOR_PURCHASE_ORDER_DETAIL.supplier_name
  is '����������';
comment on column PROSTOR_PURCHASE_ORDER_DETAIL.supplier_product_id
  is '�����̻�Ʒ���';
comment on column PROSTOR_PURCHASE_ORDER_DETAIL.supplier_product_name
  is '�����̻�Ʒ����';
comment on column PROSTOR_PURCHASE_ORDER_DETAIL.supplier_unit_price
  is '��������Ʒ����';
comment on column PROSTOR_PURCHASE_ORDER_DETAIL.sum_money_add
  is '������';
comment on column PROSTOR_PURCHASE_ORDER_DETAIL.supplier_product_specification
  is '�����̻�Ʒ���';

prompt
prompt Creating table PROSTOR_SALES_MODEL
prompt ==================================
prompt
create table PROSTOR_SALES_MODEL
(
  sales_mode_no      VARCHAR2(20),
  sales_mode_id      VARCHAR2(20),
  sales_mode_name    VARCHAR2(50),
  sales_mode_en_name VARCHAR2(50),
  remark             VARCHAR2(200),
  create_date        DATE,
  created_by         VARCHAR2(20),
  update_date        DATE,
  updated_by         VARCHAR2(20),
  activity           NUMBER(1),
  cpny_id            VARCHAR2(20),
  status             NUMBER(1),
  mobile_status      NUMBER(1)
)
;

prompt
prompt Creating table PROSTOR_SALES_ORDER
prompt ==================================
prompt
create table PROSTOR_SALES_ORDER
(
  sales_order_no   VARCHAR2(20),
  sales_order_id   VARCHAR2(20),
  cust_no          VARCHAR2(20),
  invoice_title    VARCHAR2(50),
  empid            VARCHAR2(20),
  sales_model_no   VARCHAR2(20),
  original_price   NUMBER(12,2),
  consignee        VARCHAR2(50),
  delivery_address VARCHAR2(200),
  create_date      DATE,
  created_by       VARCHAR2(20),
  update_date      DATE,
  updated_by       VARCHAR2(20),
  activity         NUMBER(1) default 1,
  cpny_id          VARCHAR2(20),
  order_date       DATE,
  discount_price   NUMBER(25,2),
  discount         NUMBER(3,2),
  transport_mode   VARCHAR2(100),
  delivery_date    VARCHAR2(20),
  affirm_flag      VARCHAR2(10) default 'affirm0',
  status           VARCHAR2(30) default 'SaleOrderState0',
  affirmed_by      VARCHAR2(20),
  processid        VARCHAR2(20),
  remarks          VARCHAR2(200),
  tra_status       VARCHAR2(20) default 'outStatus0',
  received_money   NUMBER,
  receiver_mobile  VARCHAR2(50),
  taobao_orderid   VARCHAR2(50),
  invoice_type     varchar2(50),
  invoice_title_type varchar2(50),
  invoice_title_content varchar2(100),
  invoice_content       varchar2(100),
  payment_mode          varchar2(20)
)
;
-- Add comments to the columns 
comment on column PROSTOR_SALES_ORDER.invoice_type
  is '��Ʊ���ͣ���ͨ��Ʊ����ֵ˰��Ʊ��';
comment on column PROSTOR_SALES_ORDER.invoice_title_type
  is '��Ʊ̧ͷ���ͣ����ˣ���˾��';
comment on column PROSTOR_SALES_ORDER.invoice_title_content
  is '��Ʊ̧ͷ����';
comment on column PROSTOR_SALES_ORDER.invoice_content
  is '��Ʊ����';
comment on column PROSTOR_SALES_ORDER.payment_mode
  is '֧����ʽ';
)
;
comment on column PROSTOR_SALES_ORDER.empid
  is '�µ���ID';
comment on column PROSTOR_SALES_ORDER.original_price
  is 'ԭ�ܽ��';
comment on column PROSTOR_SALES_ORDER.activity
  is 'ɾ�����';
comment on column PROSTOR_SALES_ORDER.order_date
  is '�µ�����';
comment on column PROSTOR_SALES_ORDER.discount_price
  is '�ۺ��ܽ��';
comment on column PROSTOR_SALES_ORDER.affirm_flag
  is '��˱�־��affirm0δ��ˣ�affirm1ͨ����affirm2�ܾ�';
comment on column PROSTOR_SALES_ORDER.status
  is '����״̬��δ��ɡ������';
comment on column PROSTOR_SALES_ORDER.processid
  is '����id';
comment on column PROSTOR_SALES_ORDER.tra_status
  is '����״̬';

prompt
prompt Creating table PROSTOR_SALES_ORDER_DETAIL
prompt =========================================
prompt
create table PROSTOR_SALES_ORDER_DETAIL
(
  sales_order_no VARCHAR2(20),
  product_no     VARCHAR2(20),
  quantity       NUMBER,
  price          NUMBER(10,2),
  remarks        VARCHAR2(200),
  create_date    DATE,
  created_by     VARCHAR2(20),
  update_date    DATE,
  updated_by     VARCHAR2(20),
  activity       NUMBER(1) default 1,
  cpny_id        VARCHAR2(20),
  out_quantity   NUMBER default 0,
  discount       NUMBER(3,2),
  discount_money NUMBER(10,2),
  product_name   VARCHAR2(100),
  specification  VARCHAR2(50),
  unit_code_name VARCHAR2(50),
  unit_code_no   VARCHAR2(20),
  sales_order_id VARCHAR2(50),
  product_id     VARCHAR2(20)
)
;
comment on column PROSTOR_SALES_ORDER_DETAIL.quantity
  is 'Ӧ��������';
comment on column PROSTOR_SALES_ORDER_DETAIL.price
  is 'ԭ����';
comment on column PROSTOR_SALES_ORDER_DETAIL.out_quantity
  is '�ѳ�������';
comment on column PROSTOR_SALES_ORDER_DETAIL.discount
  is '�ۿ�';
comment on column PROSTOR_SALES_ORDER_DETAIL.discount_money
  is '�ۺ��ܽ��';
comment on column PROSTOR_SALES_ORDER_DETAIL.sales_order_id
  is '���۵���ˮ��';

prompt
prompt Creating table PROSTOR_STORAGE_INFO
prompt ===================================
prompt
create table PROSTOR_STORAGE_INFO
(
  storage_no         VARCHAR2(20),
  storage_id         VARCHAR2(20),
  storage_name       VARCHAR2(100),
  storage_en_name    VARCHAR2(100),
  place_code         VARCHAR2(20),
  storage_address    VARCHAR2(200),
  storage_remark     VARCHAR2(200),
  manage_empid       VARCHAR2(20),
  storage_begin_date DATE,
  storage_end_date   DATE,
  create_date        DATE,
  created_by         VARCHAR2(20),
  update_date        DATE,
  updated_by         VARCHAR2(20),
  activity           NUMBER(1),
  cpny_id            VARCHAR2(20),
  storage_photopath  VARCHAR2(100)
)
;

prompt
prompt Creating table PROSTOR_STORAGE_PRODUCT
prompt ======================================
prompt
create table PROSTOR_STORAGE_PRODUCT
(
  storage_no         VARCHAR2(20),
  product_no         VARCHAR2(20),
  left_quantity      NUMBER,
  quantity_unit_code VARCHAR2(20),
  create_date        DATE,
  created_by         VARCHAR2(20),
  update_date        DATE,
  updated_by         VARCHAR2(20),
  activity           NUMBER(1),
  cpny_id            VARCHAR2(20)
)
;
alter table PROSTOR_STORAGE_PRODUCT
  add constraint GREATER_THAN_0
  check (LEFT_QUANTITY>=0);

prompt
prompt Creating table PROSTOR_STORAGE_PRODUCT_DETAIL
prompt =============================================
prompt
create table PROSTOR_STORAGE_PRODUCT_DETAIL
(
  storage_no         VARCHAR2(20),
  product_no         VARCHAR2(20),
  left_quantity      NUMBER,
  max_quantity       NUMBER,
  quantity_unit_code VARCHAR2(20),
  create_date        DATE,
  created_by         VARCHAR2(20),
  update_date        DATE,
  updated_by         VARCHAR2(20),
  activity           NUMBER(1),
  cpny_id            VARCHAR2(20)
)
;

prompt
prompt Creating table PROSTOR_STORAGE_PRODUCT_PARAM
prompt ============================================
prompt
create table PROSTOR_STORAGE_PRODUCT_PARAM
(
  storage_no   VARCHAR2(20),
  product_no   VARCHAR2(20),
  max_quantity NUMBER,
  min_quantity NUMBER,
  stor_addr    VARCHAR2(100),
  create_date  DATE,
  created_by   VARCHAR2(20),
  update_date  DATE,
  updated_by   VARCHAR2(20),
  activity     NUMBER(1),
  cpny_id      VARCHAR2(20)
)
;

prompt
prompt Creating table PROSTOR_STORAGE_WARNING
prompt ======================================
prompt
create table PROSTOR_STORAGE_WARNING
(
  warning_no      VARCHAR2(20),
  warning_id      VARCHAR2(20),
  target_id       VARCHAR2(20),
  message_type_id VARCHAR2(20),
  created_by      VARCHAR2(20),
  create_date     DATE,
  updated_by      VARCHAR2(20),
  update_date     DATE,
  activity        NUMBER(1),
  cpny_id         VARCHAR2(20)
)
;

prompt
prompt Creating table PROSTOR_SUPPLIER
prompt ===============================
prompt
create table PROSTOR_SUPPLIER
(
  supplier_no       VARCHAR2(20),
  supplier_id       VARCHAR2(20),
  supplier_name     VARCHAR2(200),
  create_date       DATE,
  created_by        VARCHAR2(20),
  update_date       DATE,
  updated_by        VARCHAR2(20),
  activity          NUMBER(1) default 1,
  cpny_id           VARCHAR2(20),
  supplier_address  VARCHAR2(200),
  supplier_type     VARCHAR2(20),
  supplier_contacts VARCHAR2(20),
  supplier_fax      VARCHAR2(20),
  supplier_email    VARCHAR2(50),
  description       VARCHAR2(500),
  supplier_phone1   VARCHAR2(12),
  supplier_phone2   VARCHAR2(12)
)
;

prompt
prompt Creating table PROSTOR_SUPPLIER_PRODUCT
prompt =======================================
prompt
create table PROSTOR_SUPPLIER_PRODUCT
(
  product_no          VARCHAR2(20),
  supplier_no         VARCHAR2(20),
  product_name        VARCHAR2(50),
  specification       VARCHAR2(50),
  unit_price          NUMBER(10,2),
  unit_code_id        VARCHAR2(20),
  product_category_id VARCHAR2(20),
  create_date         DATE,
  created_by          VARCHAR2(20),
  update_date         DATE,
  updated_by          VARCHAR2(20),
  activity            NUMBER(1),
  cpny_id             VARCHAR2(20),
  product_id          VARCHAR2(20)
)
;
comment on column PROSTOR_SUPPLIER_PRODUCT.product_no
  is '����';
comment on column PROSTOR_SUPPLIER_PRODUCT.supplier_no
  is '����������';
comment on column PROSTOR_SUPPLIER_PRODUCT.product_name
  is 'Ʒ��';
comment on column PROSTOR_SUPPLIER_PRODUCT.specification
  is '���';
comment on column PROSTOR_SUPPLIER_PRODUCT.unit_price
  is '����';
comment on column PROSTOR_SUPPLIER_PRODUCT.unit_code_id
  is '��λ';
comment on column PROSTOR_SUPPLIER_PRODUCT.product_category_id
  is '��Ʒ���';
comment on column PROSTOR_SUPPLIER_PRODUCT.product_id
  is '������������ƷID';

prompt
prompt Creating table PROSTOR_UPDATE_STORAGE_DETAIL
prompt ============================================
prompt
create table PROSTOR_UPDATE_STORAGE_DETAIL
(
  pno         VARCHAR2(20),
  product_no  VARCHAR2(20),
  quantity    NUMBER(10),
  create_date DATE,
  created_by  VARCHAR2(20),
  update_date DATE,
  updated_by  VARCHAR2(20),
  activity    NUMBER(1),
  cpny_id     VARCHAR2(20),
  stor_addr   VARCHAR2(100)
)
;

prompt
prompt Creating table PROSTOR_UPDATE_STORAGE_INFO
prompt ==========================================
prompt
create table PROSTOR_UPDATE_STORAGE_INFO
(
  pno          VARCHAR2(20),
  serial_id    VARCHAR2(20),
  order_id     VARCHAR2(20),
  supplier_no  VARCHAR2(20),
  prostor_desc VARCHAR2(500),
  create_date  DATE,
  created_by   VARCHAR2(20),
  update_date  DATE,
  updated_by   VARCHAR2(20),
  activity     NUMBER(1),
  cpny_id      VARCHAR2(20),
  status       NUMBER(1),
  in_date      DATE,
  transfer_id  VARCHAR2(20)
)
;
comment on column PROSTOR_UPDATE_STORAGE_INFO.serial_id
  is '��ˮ��';
comment on column PROSTOR_UPDATE_STORAGE_INFO.order_id
  is '������';
comment on column PROSTOR_UPDATE_STORAGE_INFO.supplier_no
  is '������';
comment on column PROSTOR_UPDATE_STORAGE_INFO.prostor_desc
  is '����';
comment on column PROSTOR_UPDATE_STORAGE_INFO.status
  is '��ⵥ״̬��2�ݴ棬1���������';
comment on column PROSTOR_UPDATE_STORAGE_INFO.in_date
  is '���ʱ��';
comment on column PROSTOR_UPDATE_STORAGE_INFO.transfer_id
  is '�ƶ�����';

prompt
prompt Creating table PRO_APPENDIX_INFO
prompt ================================
prompt
create table PRO_APPENDIX_INFO
(
  pro_appen_no      NUMBER(10) not null,
  product_id        VARCHAR2(20) not null,
  appendix_name     VARCHAR2(20),
  appendix_format   VARCHAR2(20),
  original_name     VARCHAR2(100),
  store_path        VARCHAR2(100),
  target_group_code VARCHAR2(20),
  orderno           NUMBER(10),
  create_date       DATE,
  created_by        VARCHAR2(20),
  update_date       DATE,
  updated_by        VARCHAR2(20),
  activity          NUMBER(1),
  remark            VARCHAR2(200),
  pro_appen_id      VARCHAR2(20) not null,
  remove_remark     VARCHAR2(200),
  cpny_id           VARCHAR2(20),
  status_code       VARCHAR2(20)
)
;
comment on table PRO_APPENDIX_INFO
  is '��Ʒ������Ϣ��';
comment on column PRO_APPENDIX_INFO.product_id
  is '������Ʒ���';
comment on column PRO_APPENDIX_INFO.appendix_name
  is '��������';
comment on column PRO_APPENDIX_INFO.appendix_format
  is '������ʽ';
comment on column PRO_APPENDIX_INFO.original_name
  is 'ԭ��';
comment on column PRO_APPENDIX_INFO.store_path
  is '�洢·��';
comment on column PRO_APPENDIX_INFO.target_group_code
  is 'Ŀ����Ⱥ��������';
comment on column PRO_APPENDIX_INFO.pro_appen_id
  is '�������';
comment on column PRO_APPENDIX_INFO.remove_remark
  is '�Ƴ���ע';
comment on column PRO_APPENDIX_INFO.status_code
  is '״̬�����ò�����';
alter table PRO_APPENDIX_INFO
  add constraint PK_PRO_APPE primary key (PRO_APPEN_ID);

prompt
prompt Creating table PRO_BASIC_INFO
prompt =============================
prompt
create table PRO_BASIC_INFO
(
  pro_basic_no     NUMBER(10) not null,
  product_id       VARCHAR2(20) not null,
  product_name     VARCHAR2(100),
  begin_date       DATE,
  end_date         DATE,
  appointment_days NUMBER(5),
  pro_description  VARCHAR2(2000),
  shape            VARCHAR2(20),
  weight           VARCHAR2(20),
  orderno          NUMBER(10),
  create_date      DATE,
  created_by       VARCHAR2(20),
  update_date      DATE,
  updated_by       VARCHAR2(20),
  activity         NUMBER(1),
  remark           VARCHAR2(200),
  group_code       VARCHAR2(20),
  pro_place        VARCHAR2(20),
  cpny_id          VARCHAR2(20),
  photopath        VARCHAR2(200),
  specification    VARCHAR2(20)
)
;
comment on column PRO_BASIC_INFO.product_id
  is '��Ʒ���';
comment on column PRO_BASIC_INFO.product_name
  is '��Ʒ����';
comment on column PRO_BASIC_INFO.begin_date
  is '��ʼ���ڣ�������';
comment on column PRO_BASIC_INFO.end_date
  is '�������ڣ�������';
comment on column PRO_BASIC_INFO.appointment_days
  is '��ǰԤԼʱ�䣨������';
comment on column PRO_BASIC_INFO.pro_description
  is '��Ʒ����';
comment on column PRO_BASIC_INFO.shape
  is '��״��Ԥ����';
comment on column PRO_BASIC_INFO.weight
  is '������Ԥ����';
comment on column PRO_BASIC_INFO.group_code
  is '��Ʒ����';
comment on column PRO_BASIC_INFO.pro_place
  is '��Ʒ�ص㣨Ԥ����';
comment on column PRO_BASIC_INFO.photopath
  is 'ͼƬ·��';
comment on column PRO_BASIC_INFO.specification
  is '��Ʒ���';
alter table PRO_BASIC_INFO
  add constraint PK_PRO_BASIC primary key (PRODUCT_ID);
alter table PRO_BASIC_INFO
  add constraint UK_PRO_BASIC2 unique (PRODUCT_NAME);

prompt
prompt Creating table PRO_BUSINESS_INFO
prompt ================================
prompt
create table PRO_BUSINESS_INFO
(
  pro_busi_no       NUMBER(10) not null,
  product_id        VARCHAR2(20) not null,
  pro_cost          NUMBER(10,2),
  cost_unit_code    VARCHAR2(20),
  standard_price    NUMBER(10,2),
  price_unit_code   VARCHAR2(20),
  max_quantity      NUMBER(20),
  orderno           NUMBER(10),
  create_date       DATE,
  created_by        VARCHAR2(20),
  update_date       DATE,
  updated_by        VARCHAR2(20),
  activity          NUMBER(1),
  remark            VARCHAR2(200),
  left_quantity     NUMBER(20),
  remove_remark     VARCHAR2(200),
  cpny_id           VARCHAR2(20),
  sales_area_code   VARCHAR2(20),
  dist_channel_code VARCHAR2(10),
  division_code     VARCHAR2(100),
  busi_date         DATE,
  pro_busi_id       VARCHAR2(20)
)
;
comment on table PRO_BUSINESS_INFO
  is '��Ʒҵ����Ϣ';
comment on column PRO_BUSINESS_INFO.product_id
  is '��Ʒ���';
comment on column PRO_BUSINESS_INFO.pro_cost
  is '�ɱ�';
comment on column PRO_BUSINESS_INFO.cost_unit_code
  is '�ɱ���λ';
comment on column PRO_BUSINESS_INFO.standard_price
  is '��׼��';
comment on column PRO_BUSINESS_INFO.price_unit_code
  is '��׼�۵�λ';
comment on column PRO_BUSINESS_INFO.max_quantity
  is '�������';
comment on column PRO_BUSINESS_INFO.left_quantity
  is 'ʣ������';
comment on column PRO_BUSINESS_INFO.remove_remark
  is '�Ƴ���ע';
comment on column PRO_BUSINESS_INFO.sales_area_code
  is '���۵���';
comment on column PRO_BUSINESS_INFO.dist_channel_code
  is '�ɷ���ʽ';
comment on column PRO_BUSINESS_INFO.division_code
  is '�������ࣨ����Ʒ��';
comment on column PRO_BUSINESS_INFO.busi_date
  is '(Ԥ��)';
comment on column PRO_BUSINESS_INFO.pro_busi_id
  is 'ͬ��Ʒ��ţ�Ԥ����';
alter table PRO_BUSINESS_INFO
  add constraint PK_PRO_BUSINESS primary key (PRODUCT_ID);

prompt
prompt Creating table PRO_QUOTA_INFO
prompt =============================
prompt
create table PRO_QUOTA_INFO
(
  pro_quota_no    NUMBER(10) not null,
  pro_quota_id    VARCHAR2(20) not null,
  channel_id      VARCHAR2(20),
  product_id      VARCHAR2(20),
  quota_price     NUMBER(20),
  price_unit_code VARCHAR2(20),
  max_quantity    NUMBER(20),
  orderno         NUMBER(10),
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  activity        NUMBER(1),
  remark          VARCHAR2(200),
  quota_date      DATE,
  left_quantity   NUMBER(20),
  status_code     VARCHAR2(20),
  status_remark   VARCHAR2(200),
  remove_remark   VARCHAR2(200),
  pro_busi_id     VARCHAR2(20),
  cpny_id         VARCHAR2(20)
)
;
comment on table PRO_QUOTA_INFO
  is '���۵���Ϣ��';
comment on column PRO_QUOTA_INFO.pro_quota_id
  is '���۱��';
comment on column PRO_QUOTA_INFO.channel_id
  is '������';
comment on column PRO_QUOTA_INFO.product_id
  is '��Ʒ';
comment on column PRO_QUOTA_INFO.quota_price
  is '���ۣ����ۣ�';
comment on column PRO_QUOTA_INFO.price_unit_code
  is '�۸�λ';
comment on column PRO_QUOTA_INFO.max_quantity
  is '���������Ԥ����';
comment on column PRO_QUOTA_INFO.quota_date
  is '��������';
comment on column PRO_QUOTA_INFO.left_quantity
  is 'ʣ��������Ԥ����';
comment on column PRO_QUOTA_INFO.status_code
  is '����״̬';
comment on column PRO_QUOTA_INFO.status_remark
  is '״̬��ע';
comment on column PRO_QUOTA_INFO.remove_remark
  is '�Ƴ���ע';
comment on column PRO_QUOTA_INFO.pro_busi_id
  is '��Ʒҵ����';
alter table PRO_QUOTA_INFO
  add constraint PK_PRO_QUOTA primary key (PRO_QUOTA_ID);

prompt
prompt Creating table PRO_STOCK_INFO
prompt =============================
prompt
create table PRO_STOCK_INFO
(
  pro_stock_no       NUMBER(10) not null,
  product_id         VARCHAR2(20),
  pro_storage_id     VARCHAR2(20),
  max_quantity       NUMBER(10),
  left_quantity      NUMBER(10),
  quantity_unit_code VARCHAR2(20),
  create_date        VARCHAR2(20),
  created_by         VARCHAR2(20),
  update_date        VARCHAR2(20),
  updated_by         VARCHAR2(20),
  activity           NUMBER(1),
  orderno            NUMBER(10),
  cpny_id            VARCHAR2(20)
)
;
comment on table PRO_STOCK_INFO
  is '��Ʒ����';
comment on column PRO_STOCK_INFO.product_id
  is '��Ʒ';
comment on column PRO_STOCK_INFO.pro_storage_id
  is '�ֿ�';
comment on column PRO_STOCK_INFO.max_quantity
  is '�������';
comment on column PRO_STOCK_INFO.left_quantity
  is 'ʣ������';
comment on column PRO_STOCK_INFO.quantity_unit_code
  is '������λ��ͳһΪ֧��';
alter table PRO_STOCK_INFO
  add constraint PK_PRO_STOCK primary key (PRO_STOCK_NO);

prompt
prompt Creating table PRO_STOCK_RECORD
prompt ===============================
prompt
create table PRO_STOCK_RECORD
(
  pro_stock_rec_no   NUMBER(10) not null,
  pro_storage_id     VARCHAR2(20),
  product_id         VARCHAR2(20),
  pro_quantity       NUMBER(10),
  type_code          VARCHAR2(20),
  order_id           VARCHAR2(20),
  create_date        DATE,
  created_by         VARCHAR2(20),
  activity           NUMBER(1),
  remark             VARCHAR2(200),
  quantity_unit_code VARCHAR2(20)
)
;
comment on table PRO_STOCK_RECORD
  is '����¼';
comment on column PRO_STOCK_RECORD.pro_stock_rec_no
  is '����';
comment on column PRO_STOCK_RECORD.pro_storage_id
  is '�ֿ���';
comment on column PRO_STOCK_RECORD.product_id
  is '��Ʒ��';
comment on column PRO_STOCK_RECORD.pro_quantity
  is '��Ʒ����';
comment on column PRO_STOCK_RECORD.type_code
  is '���ͣ����⡢��⣩';
comment on column PRO_STOCK_RECORD.order_id
  is '��Ӧ�Ķ�����';
comment on column PRO_STOCK_RECORD.quantity_unit_code
  is '��λ';
alter table PRO_STOCK_RECORD
  add constraint PK_PRO_STOCK_HISTORY primary key (PRO_STOCK_REC_NO);

prompt
prompt Creating table PRO_STORAGE_INFO
prompt ===============================
prompt
create table PRO_STORAGE_INFO
(
  pro_storage_no NUMBER(10) not null,
  pro_storage_id VARCHAR2(20),
  storage_name   VARCHAR2(100),
  place_code     VARCHAR2(20),
  address        VARCHAR2(200),
  remark         VARCHAR2(200),
  create_date    VARCHAR2(20),
  created_by     VARCHAR2(20),
  update_date    DATE,
  updated_by     VARCHAR2(20),
  activity       NUMBER(1),
  orderno        NUMBER(10),
  cpny_id        VARCHAR2(20),
  charger        VARCHAR2(20),
  begin_date     DATE,
  end_date       DATE
)
;
comment on table PRO_STORAGE_INFO
  is '��Ʒ�ֿ��';
comment on column PRO_STORAGE_INFO.pro_storage_no
  is '����������';
comment on column PRO_STORAGE_INFO.pro_storage_id
  is '�ֿ���';
comment on column PRO_STORAGE_INFO.storage_name
  is '�ֿ���';
comment on column PRO_STORAGE_INFO.place_code
  is '�ص㣨ͬ��˾���ţ�';
comment on column PRO_STORAGE_INFO.address
  is '��ϸ��ַ';
comment on column PRO_STORAGE_INFO.remark
  is '��ע';
comment on column PRO_STORAGE_INFO.charger
  is '������';
comment on column PRO_STORAGE_INFO.begin_date
  is '��ʼ����';
comment on column PRO_STORAGE_INFO.end_date
  is '��������';
alter table PRO_STORAGE_INFO
  add constraint PK_PRO_STORAGE primary key (PRO_STORAGE_NO);

prompt
prompt Creating table QUEST_SL_TEMP_EXPLAIN1
prompt =====================================
prompt
create global temporary table QUEST_SL_TEMP_EXPLAIN1
(
  statement_id      VARCHAR2(30),
  timestamp         DATE,
  remarks           VARCHAR2(80),
  operation         VARCHAR2(30),
  options           VARCHAR2(255),
  object_node       VARCHAR2(128),
  object_owner      VARCHAR2(30),
  object_name       VARCHAR2(30),
  object_instance   NUMBER,
  object_type       VARCHAR2(30),
  optimizer         VARCHAR2(255),
  search_columns    NUMBER,
  id                NUMBER,
  parent_id         NUMBER,
  position          NUMBER,
  cost              NUMBER,
  cardinality       NUMBER,
  bytes             NUMBER,
  other_tag         VARCHAR2(255),
  partition_start   VARCHAR2(255),
  partition_stop    VARCHAR2(255),
  partition_id      NUMBER,
  other             LONG,
  distribution      VARCHAR2(30),
  cpu_cost          NUMBER(38),
  io_cost           NUMBER(38),
  temp_space        NUMBER(38),
  access_predicates VARCHAR2(4000),
  filter_predicates VARCHAR2(4000)
)
on commit preserve rows;

prompt
prompt Creating table QUO_LEVEL
prompt ========================
prompt
create table QUO_LEVEL
(
  quo_level_no VARCHAR2(20),
  quo_level_id VARCHAR2(20) not null,
  cha_level    NUMBER(10),
  percentage   NUMBER(8,4),
  orderno      NUMBER(10),
  create_date  DATE,
  created_by   VARCHAR2(20),
  update_date  DATE,
  updated_by   VARCHAR2(20),
  activity     NUMBER(1),
  remark       VARCHAR2(200)
)
;
comment on table QUO_LEVEL
  is '�ȼ����۱�';
comment on column QUO_LEVEL.cha_level
  is '�����̵ȼ�';
comment on column QUO_LEVEL.percentage
  is '�ۿ۱���';
alter table QUO_LEVEL
  add constraint PK_QUO_LEVEL primary key (QUO_LEVEL_ID);

prompt
prompt Creating table RECTEMPLATE
prompt ==========================
prompt
create table RECTEMPLATE
(
  id       NUMBER,
  code     VARCHAR2(20),
  name     VARCHAR2(20),
  fromdate DATE,
  todate   DATE,
  num      NUMBER
)
;

prompt
prompt Creating table REC_DM_TYPE
prompt ==========================
prompt
create table REC_DM_TYPE
(
  dmt_no       INTEGER not null,
  dm_type_name VARCHAR2(50) not null,
  activity     NUMBER(1) default 1,
  create_by    VARCHAR2(20),
  create_date  DATE,
  update_by    VARCHAR2(20),
  update_date  DATE
)
;
comment on table REC_DM_TYPE
  is '����?��';
comment on column REC_DM_TYPE.dmt_no
  is '����?��';
comment on column REC_DM_TYPE.activity
  is 'ACTIVITY';
comment on column REC_DM_TYPE.create_by
  is 'CREATE_BY';
comment on column REC_DM_TYPE.create_date
  is 'CREATE_DATE';
comment on column REC_DM_TYPE.update_by
  is 'UPDATE_BY';
comment on column REC_DM_TYPE.update_date
  is 'UPDATE_DATE';
alter table REC_DM_TYPE
  add constraint PK_REC_DM_TYPE primary key (DMT_NO);

prompt
prompt Creating table REC_AFFIRMOR
prompt ===========================
prompt
create table REC_AFFIRMOR
(
  afr_no      INTEGER not null,
  dmt_no      INTEGER not null,
  afr_level   INTEGER not null,
  emp_id      VARCHAR2(20) not null,
  activity    NUMBER(1) default 1,
  create_by   VARCHAR2(20),
  create_date DATE,
  update_by   VARCHAR2(20),
  update_date DATE
)
;
comment on column REC_AFFIRMOR.dmt_no
  is '����?��';
comment on column REC_AFFIRMOR.afr_level
  is '???����?';
comment on column REC_AFFIRMOR.activity
  is 'ACTIVITY';
comment on column REC_AFFIRMOR.create_by
  is 'CREATE_BY';
comment on column REC_AFFIRMOR.create_date
  is 'CREATE_DATE';
comment on column REC_AFFIRMOR.update_by
  is 'UPDATE_BY';
comment on column REC_AFFIRMOR.update_date
  is 'UPDATE_DATE';
create index REC_AFFIRMOR_FK on REC_AFFIRMOR (DMT_NO);
alter table REC_AFFIRMOR
  add constraint PK_REC_AFFIRMOR primary key (AFR_NO);
alter table REC_AFFIRMOR
  add constraint FK_REC_AFFI_REC_AFFIR_REC_DM_T foreign key (DMT_NO)
  references REC_DM_TYPE (DMT_NO);

prompt
prompt Creating table REC_DEMAND
prompt =========================
prompt
create table REC_DEMAND
(
  dm_no         INTEGER not null,
  dmt_no        INTEGER not null,
  emp_id        VARCHAR2(20) not null,
  dm_date       DATE,
  post_id       VARCHAR2(20),
  post_grade_id VARCHAR2(20),
  rec_comment   VARCHAR2(500),
  flag          NUMBER(1) default 0,
  create_date   DATE,
  create_by     VARCHAR2(20),
  update_date   DATE,
  update_by     VARCHAR2(20),
  activity      NUMBER(1) default 1
)
;
comment on table REC_DEMAND
  is '��������';
comment on column REC_DEMAND.dm_no
  is '����?��';
comment on column REC_DEMAND.dmt_no
  is '����?��';
comment on column REC_DEMAND.dm_date
  is '��������';
comment on column REC_DEMAND.post_id
  is '?��?';
comment on column REC_DEMAND.post_grade_id
  is '��??';
comment on column REC_DEMAND.rec_comment
  is '??��';
comment on column REC_DEMAND.flag
  is '???����(0����???��1��??,2�ģ�??)';
comment on column REC_DEMAND.create_date
  is 'CREATE_DATE';
comment on column REC_DEMAND.create_by
  is 'CREATE_BY';
comment on column REC_DEMAND.update_date
  is 'UPDATE_DATE';
comment on column REC_DEMAND.update_by
  is 'UPDATE_BY';
comment on column REC_DEMAND.activity
  is 'ACTIVITY';
create index REC_DM_TYPE_FK on REC_DEMAND (DMT_NO);
alter table REC_DEMAND
  add constraint PK_REC_DEMAND primary key (DM_NO);
alter table REC_DEMAND
  add constraint FK_REC_DEMA_REC_DM_TY_REC_DM_T foreign key (DMT_NO)
  references REC_DM_TYPE (DMT_NO);

prompt
prompt Creating table REC_AFFIRM_INFO
prompt ==============================
prompt
create table REC_AFFIRM_INFO
(
  afr_no      INTEGER not null,
  afi_no      INTEGER not null,
  dm_no       INTEGER not null,
  flag        NUMBER(1) default 0 not null,
  rec_comment VARCHAR2(500),
  activity    NUMBER(1) default 1,
  create_by   VARCHAR2(20),
  create_date DATE,
  update_by   VARCHAR2(20),
  update_date DATE
)
;
comment on table REC_AFFIRM_INFO
  is '???����';
comment on column REC_AFFIRM_INFO.afi_no
  is '???����';
comment on column REC_AFFIRM_INFO.dm_no
  is '����?��';
comment on column REC_AFFIRM_INFO.flag
  is '???����(0����???��1��??,2�ģ�??)';
comment on column REC_AFFIRM_INFO.rec_comment
  is '??��';
comment on column REC_AFFIRM_INFO.activity
  is 'ACTIVITY';
comment on column REC_AFFIRM_INFO.create_by
  is 'CREATE_BY';
comment on column REC_AFFIRM_INFO.create_date
  is 'CREATE_DATE';
comment on column REC_AFFIRM_INFO.update_by
  is 'UPDATE_BY';
comment on column REC_AFFIRM_INFO.update_date
  is 'UPDATE_DATE';
create index REC_AFFINFO_AFFIRMOR_FK on REC_AFFIRM_INFO (AFR_NO);
create index REC_AFFIRM_INFO_FK on REC_AFFIRM_INFO (DM_NO);
alter table REC_AFFIRM_INFO
  add constraint PK_REC_AFFIRM_INFO primary key (AFR_NO, AFI_NO);
alter table REC_AFFIRM_INFO
  add constraint FK_REC_AFFI_REC_AFFIN_REC_AFFI foreign key (AFR_NO)
  references REC_AFFIRMOR (AFR_NO);
alter table REC_AFFIRM_INFO
  add constraint FK_REC_AFFI_REC_AFFIR_REC_DEMA foreign key (DM_NO)
  references REC_DEMAND (DM_NO);

prompt
prompt Creating table REC_CHANNEL
prompt ==========================
prompt
create table REC_CHANNEL
(
  cha_no      INTEGER not null,
  cha_type_id VARCHAR2(20),
  company     VARCHAR2(100),
  address     VARCHAR2(100),
  url         VARCHAR2(50),
  rec_comment VARCHAR2(500),
  activity    NUMBER(1) default 1,
  create_by   VARCHAR2(20),
  create_date DATE,
  update_by   VARCHAR2(20),
  update_date DATE
)
;
comment on table REC_CHANNEL
  is '������??';
comment on column REC_CHANNEL.cha_no
  is '������??';
comment on column REC_CHANNEL.cha_type_id
  is '��???��';
comment on column REC_CHANNEL.company
  is '??����';
comment on column REC_CHANNEL.address
  is '?��?';
comment on column REC_CHANNEL.url
  is '����';
comment on column REC_CHANNEL.rec_comment
  is '??��';
comment on column REC_CHANNEL.activity
  is 'ACTIVITY';
comment on column REC_CHANNEL.create_by
  is 'CREATE_BY';
comment on column REC_CHANNEL.create_date
  is 'CREATE_DATE';
comment on column REC_CHANNEL.update_by
  is 'UPDATE_BY';
comment on column REC_CHANNEL.update_date
  is 'UPDATE_DATE';
alter table REC_CHANNEL
  add constraint PK_REC_CHANNEL primary key (CHA_NO);

prompt
prompt Creating table REC_CN_PUBLISH
prompt =============================
prompt
create table REC_CN_PUBLISH
(
  cpb_no      INTEGER not null,
  cha_no      INTEGER not null,
  ad_type_id  VARCHAR2(20),
  start_date  DATE,
  end_date    DATE,
  cost        NUMBER,
  favorable   VARCHAR2(500),
  rec_resume  NUMBER,
  a_resume    NUMBER,
  hire_num    NUMBER,
  hire_rate   NUMBER,
  activity    NUMBER(1) default 1,
  create_by   VARCHAR2(20),
  create_date DATE,
  update_by   VARCHAR2(20),
  update_date DATE
)
;
comment on table REC_CN_PUBLISH
  is '��??����????';
comment on column REC_CN_PUBLISH.cpb_no
  is '��??����????';
comment on column REC_CN_PUBLISH.cha_no
  is '������??';
comment on column REC_CN_PUBLISH.ad_type_id
  is '?������';
comment on column REC_CN_PUBLISH.start_date
  is '??������';
comment on column REC_CN_PUBLISH.end_date
  is '?������';
comment on column REC_CN_PUBLISH.rec_resume
  is '��???��?';
comment on column REC_CN_PUBLISH.a_resume
  is '����?��?';
comment on column REC_CN_PUBLISH.hire_num
  is '��������';
comment on column REC_CN_PUBLISH.activity
  is 'ACTIVITY';
comment on column REC_CN_PUBLISH.create_by
  is 'CREATE_BY';
comment on column REC_CN_PUBLISH.create_date
  is 'CREATE_DATE';
comment on column REC_CN_PUBLISH.update_by
  is 'UPDATE_BY';
comment on column REC_CN_PUBLISH.update_date
  is 'UPDATE_DATE';
create index REC_CHANNEL_FK on REC_CN_PUBLISH (CHA_NO);
alter table REC_CN_PUBLISH
  add constraint PK_REC_CN_PUBLISH primary key (CPB_NO);
alter table REC_CN_PUBLISH
  add constraint FK_REC_CN_P_REC_CHANN_REC_CHAN foreign key (CHA_NO)
  references REC_CHANNEL (CHA_NO);

prompt
prompt Creating table REC_INTERVIEW
prompt ============================
prompt
create table REC_INTERVIEW
(
  iv_no       INTEGER not null,
  iv_name     VARCHAR2(50),
  start_date  DATE,
  end_date    DATE,
  rec_comment VARCHAR2(500),
  activity    NUMBER(1) default 1,
  create_by   VARCHAR2(20),
  create_date DATE,
  update_by   VARCHAR2(20),
  update_date DATE
)
;
comment on table REC_INTERVIEW
  is '����??��';
comment on column REC_INTERVIEW.iv_no
  is '����??��';
comment on column REC_INTERVIEW.start_date
  is '??������';
comment on column REC_INTERVIEW.end_date
  is '?������';
comment on column REC_INTERVIEW.rec_comment
  is '??��';
comment on column REC_INTERVIEW.activity
  is 'ACTIVITY';
comment on column REC_INTERVIEW.create_by
  is 'CREATE_BY';
comment on column REC_INTERVIEW.create_date
  is 'CREATE_DATE';
comment on column REC_INTERVIEW.update_by
  is 'UPDATE_BY';
comment on column REC_INTERVIEW.update_date
  is 'UPDATE_DATE';
alter table REC_INTERVIEW
  add constraint PK_REC_INTERVIEW primary key (IV_NO);

prompt
prompt Creating table REC_DEMAND_INTERVIEW
prompt ===================================
prompt
create table REC_DEMAND_INTERVIEW
(
  dm_no INTEGER not null,
  iv_no INTEGER not null
)
;
comment on table REC_DEMAND_INTERVIEW
  is '����??��';
comment on column REC_DEMAND_INTERVIEW.dm_no
  is '����?��';
comment on column REC_DEMAND_INTERVIEW.iv_no
  is '����??��';
create index REC_DEMAND_INTERVIEW2_FK on REC_DEMAND_INTERVIEW (IV_NO);
create index REC_DEMAND_INTERVIEW_FK on REC_DEMAND_INTERVIEW (DM_NO);
alter table REC_DEMAND_INTERVIEW
  add constraint PK_REC_DEMAND_INTERVIEW primary key (DM_NO, IV_NO);
alter table REC_DEMAND_INTERVIEW
  add constraint FK_REC_DEMA_REC_DEMAN_REC_DEMA foreign key (DM_NO)
  references REC_DEMAND (DM_NO);
alter table REC_DEMAND_INTERVIEW
  add constraint FK_REC_DEMA_REC_DEMAN_REC_INTE foreign key (IV_NO)
  references REC_INTERVIEW (IV_NO);

prompt
prompt Creating table REC_DEMAND_PUBLISH
prompt =================================
prompt
create table REC_DEMAND_PUBLISH
(
  dm_no  INTEGER not null,
  cpb_no INTEGER not null
)
;
comment on table REC_DEMAND_PUBLISH
  is '����????';
comment on column REC_DEMAND_PUBLISH.dm_no
  is '����?��';
comment on column REC_DEMAND_PUBLISH.cpb_no
  is '��??����????';
create index REC_DEMAND_PUBLISH2_FK on REC_DEMAND_PUBLISH (CPB_NO);
create index REC_DEMAND_PUBLISH_FK on REC_DEMAND_PUBLISH (DM_NO);
alter table REC_DEMAND_PUBLISH
  add constraint PK_REC_DEMAND_PUBLISH primary key (DM_NO, CPB_NO);
alter table REC_DEMAND_PUBLISH
  add constraint FK_REC_DEMA_REC_DEMAN_REC_CN_P foreign key (CPB_NO)
  references REC_CN_PUBLISH (CPB_NO);

prompt
prompt Creating table REC_DM_QUARTER
prompt =============================
prompt
create table REC_DM_QUARTER
(
  dm_no             INTEGER,
  req_type_id       VARCHAR2(20),
  arrive_date       DATE,
  exigency_grade_id VARCHAR2(20),
  dm_num            INTEGER,
  reason            VARCHAR2(500),
  duty_detail       VARCHAR2(500),
  require           VARCHAR2(500),
  activity          NUMBER(1) default 1,
  create_by         VARCHAR2(20),
  create_date       DATE,
  update_by         VARCHAR2(20),
  update_date       DATE,
  season            INTEGER,
  season_month      INTEGER
)
;
comment on table REC_DM_QUARTER
  is '???����/?��?����';
comment on column REC_DM_QUARTER.dm_no
  is '����?��';
comment on column REC_DM_QUARTER.req_type_id
  is '����?��';
comment on column REC_DM_QUARTER.dm_num
  is '��������';
comment on column REC_DM_QUARTER.reason
  is '��������';
comment on column REC_DM_QUARTER.duty_detail
  is '��������';
comment on column REC_DM_QUARTER.require
  is '����';
comment on column REC_DM_QUARTER.activity
  is 'ACTIVITY';
comment on column REC_DM_QUARTER.create_by
  is 'CREATE_BY';
comment on column REC_DM_QUARTER.create_date
  is 'CREATE_DATE';
comment on column REC_DM_QUARTER.update_by
  is 'UPDATE_BY';
comment on column REC_DM_QUARTER.update_date
  is 'UPDATE_DATE';
comment on column REC_DM_QUARTER.season
  is '����';
comment on column REC_DM_QUARTER.season_month
  is '�����е��·�';
create index REC_QUARTER_PLAN_FK on REC_DM_QUARTER (DM_NO);
alter table REC_DM_QUARTER
  add constraint FK_REC_DM_Q_REC_QUART_REC_DEMA foreign key (DM_NO)
  references REC_DEMAND (DM_NO);

prompt
prompt Creating table REC_DM_YEAR
prompt ==========================
prompt
create table REC_DM_YEAR
(
  dm_no       INTEGER,
  year        INTEGER,
  pre_12      INTEGER,
  pre_11      INTEGER,
  num1        INTEGER,
  num2        INTEGER,
  num3        INTEGER,
  num4        INTEGER,
  num5        INTEGER,
  num6        INTEGER,
  num7        INTEGER,
  num8        INTEGER,
  num9        INTEGER,
  num10       INTEGER,
  num11       INTEGER,
  num12       INTEGER,
  total_12    INTEGER,
  activity    NUMBER(1) default 1,
  create_by   VARCHAR2(20),
  create_date DATE,
  update_by   VARCHAR2(20),
  update_date DATE
)
;
comment on table REC_DM_YEAR
  is '��?����?';
comment on column REC_DM_YEAR.dm_no
  is '����?��';
comment on column REC_DM_YEAR.year
  is '?��?��';
comment on column REC_DM_YEAR.pre_12
  is '11������??';
comment on column REC_DM_YEAR.pre_11
  is '12������??';
comment on column REC_DM_YEAR.num1
  is '1����??';
comment on column REC_DM_YEAR.num2
  is 'NUM2';
comment on column REC_DM_YEAR.num3
  is 'NUM3';
comment on column REC_DM_YEAR.num4
  is 'NUM4';
comment on column REC_DM_YEAR.num5
  is 'NUM5';
comment on column REC_DM_YEAR.num6
  is 'NUM6';
comment on column REC_DM_YEAR.num7
  is 'NUM7';
comment on column REC_DM_YEAR.num8
  is 'NUM8';
comment on column REC_DM_YEAR.num9
  is 'NUM9';
comment on column REC_DM_YEAR.num10
  is 'NUM10';
comment on column REC_DM_YEAR.num11
  is 'NUM11';
comment on column REC_DM_YEAR.num12
  is 'NUM12';
comment on column REC_DM_YEAR.total_12
  is '12������??';
comment on column REC_DM_YEAR.activity
  is 'ACTIVITY';
comment on column REC_DM_YEAR.create_by
  is 'CREATE_BY';
comment on column REC_DM_YEAR.create_date
  is 'CREATE_DATE';
comment on column REC_DM_YEAR.update_by
  is 'UPDATE_BY';
comment on column REC_DM_YEAR.update_date
  is 'UPDATE_DATE';
create index REC_YEAR_PLAN_FK on REC_DM_YEAR (DM_NO);
alter table REC_DM_YEAR
  add constraint FK_REC_DM_Y_REC_YEAR__REC_DEMA foreign key (DM_NO)
  references REC_DEMAND (DM_NO);

prompt
prompt Creating table REC_INTERVIEWER
prompt ==============================
prompt
create table REC_INTERVIEWER
(
  ivr_no      INTEGER not null,
  emp_id      VARCHAR2(20) not null,
  activity    NUMBER(1) default 1,
  create_by   VARCHAR2(20),
  create_date DATE,
  update_by   VARCHAR2(20),
  update_date DATE
)
;
comment on column REC_INTERVIEWER.activity
  is 'ACTIVITY';
comment on column REC_INTERVIEWER.create_by
  is 'CREATE_BY';
comment on column REC_INTERVIEWER.create_date
  is 'CREATE_DATE';
comment on column REC_INTERVIEWER.update_by
  is 'UPDATE_BY';
comment on column REC_INTERVIEWER.update_date
  is 'UPDATE_DATE';
alter table REC_INTERVIEWER
  add constraint PK_REC_INTERVIEWER primary key (IVR_NO);

prompt
prompt Creating table REC_RESUME
prompt =========================
prompt
create table REC_RESUME
(
  res_no              INTEGER not null,
  cpb_no              INTEGER not null,
  ch_name             VARCHAR2(30) not null,
  en_name             VARCHAR2(30),
  ko_name             VARCHAR2(30),
  sex                 VARCHAR2(20),
  work_exp            VARCHAR2(20),
  degree_id           VARCHAR2(20) not null,
  marital_status_code VARCHAR2(20),
  id_card             VARCHAR2(30) not null,
  nationality_code    VARCHAR2(20),
  nation_code         VARCHAR2(20),
  born_place_id       VARCHAR2(20),
  home_address        VARCHAR2(100),
  cell_phone          VARCHAR2(30) not null,
  home_phone          VARCHAR2(30),
  hire_status_id      VARCHAR2(20),
  interview_num       INTEGER,
  rec_comment         VARCHAR2(500),
  re_am1              VARCHAR2(100),
  re_am2              VARCHAR2(100),
  re_am3              VARCHAR2(100),
  activity            NUMBER(1) default 1,
  create_by           VARCHAR2(20),
  create_date         DATE,
  update_by           VARCHAR2(20),
  update_date         DATE
)
;
comment on column REC_RESUME.cpb_no
  is '��??����????';
comment on column REC_RESUME.ch_name
  is '������';
comment on column REC_RESUME.en_name
  is '������';
comment on column REC_RESUME.ko_name
  is '??����';
comment on column REC_RESUME.work_exp
  is '��?��?��??��';
comment on column REC_RESUME.degree_id
  is '��??';
comment on column REC_RESUME.marital_status_code
  is '?����??';
comment on column REC_RESUME.id_card
  is '��?��?';
comment on column REC_RESUME.nationality_code
  is '????';
comment on column REC_RESUME.nation_code
  is '����';
comment on column REC_RESUME.home_address
  is '?��??��?';
comment on column REC_RESUME.cell_phone
  is '��??';
comment on column REC_RESUME.home_phone
  is '����?��';
comment on column REC_RESUME.hire_status_id
  is '��������';
comment on column REC_RESUME.interview_num
  is '����?��?';
comment on column REC_RESUME.rec_comment
  is '??��';
comment on column REC_RESUME.re_am1
  is '?��???';
comment on column REC_RESUME.re_am2
  is 'RE_AM2';
comment on column REC_RESUME.re_am3
  is 'RE_AM3';
comment on column REC_RESUME.activity
  is 'ACTIVITY';
comment on column REC_RESUME.create_by
  is 'CREATE_BY';
comment on column REC_RESUME.create_date
  is 'CREATE_DATE';
comment on column REC_RESUME.update_by
  is 'UPDATE_BY';
comment on column REC_RESUME.update_date
  is 'UPDATE_DATE';
create index REC_RESUME_FK on REC_RESUME (CPB_NO);
alter table REC_RESUME
  add constraint PK_REC_RESUME primary key (RES_NO);
alter table REC_RESUME
  add constraint FK_REC_RESU_REC_RESUM_REC_CN_P foreign key (CPB_NO)
  references REC_CN_PUBLISH (CPB_NO);

prompt
prompt Creating table REC_IV_EMP
prompt =========================
prompt
create table REC_IV_EMP
(
  ive_no      INTEGER not null,
  iv_no       INTEGER not null,
  res_no      INTEGER not null,
  status_id   VARCHAR2(20),
  year_pay    NUMBER,
  rec_comment VARCHAR2(500),
  remark      VARCHAR2(500),
  process_id  VARCHAR2(20),
  activity    NUMBER(1) default 1,
  create_by   VARCHAR2(20),
  create_date DATE,
  update_by   VARCHAR2(20),
  update_date DATE
)
;
comment on table REC_IV_EMP
  is '������';
comment on column REC_IV_EMP.ive_no
  is '������';
comment on column REC_IV_EMP.iv_no
  is '����??��';
comment on column REC_IV_EMP.status_id
  is '��������(?��?����,��?��������..)';
comment on column REC_IV_EMP.year_pay
  is '������??��';
comment on column REC_IV_EMP.rec_comment
  is '??��';
comment on column REC_IV_EMP.remark
  is '��?����';
comment on column REC_IV_EMP.activity
  is 'ACTIVITY';
comment on column REC_IV_EMP.create_by
  is 'CREATE_BY';
comment on column REC_IV_EMP.create_date
  is 'CREATE_DATE';
comment on column REC_IV_EMP.update_by
  is 'UPDATE_BY';
comment on column REC_IV_EMP.update_date
  is 'UPDATE_DATE';
create index REC_INTERVIER_EMP_FK on REC_IV_EMP (RES_NO);
create index REC_IV_EMP_FK on REC_IV_EMP (IV_NO);
alter table REC_IV_EMP
  add constraint PK_REC_IV_EMP primary key (IVE_NO);
alter table REC_IV_EMP
  add constraint FK_REC_IV_E_REC_INTER_REC_RESU foreign key (RES_NO)
  references REC_RESUME (RES_NO);
alter table REC_IV_EMP
  add constraint FK_REC_IV_E_REC_IV_EM_REC_INTE foreign key (IV_NO)
  references REC_INTERVIEW (IV_NO);

prompt
prompt Creating table REC_IV_PROCESS
prompt =============================
prompt
create table REC_IV_PROCESS
(
  ivp_no      INTEGER not null,
  iv_no       INTEGER,
  process_id  VARCHAR2(20) not null,
  start_date  DATE not null,
  end_date    DATE not null,
  place       VARCHAR2(100),
  iv_order    NUMBER(2) not null,
  activity    NUMBER(1) default 1,
  create_by   VARCHAR2(20),
  create_date DATE,
  update_by   VARCHAR2(20),
  update_date DATE
)
;
comment on column REC_IV_PROCESS.iv_no
  is '����??��';
comment on column REC_IV_PROCESS.start_date
  is '??������';
comment on column REC_IV_PROCESS.end_date
  is '?������';
comment on column REC_IV_PROCESS.activity
  is 'ACTIVITY';
comment on column REC_IV_PROCESS.create_by
  is 'CREATE_BY';
comment on column REC_IV_PROCESS.create_date
  is 'CREATE_DATE';
comment on column REC_IV_PROCESS.update_by
  is 'UPDATE_BY';
comment on column REC_IV_PROCESS.update_date
  is 'UPDATE_DATE';
create index REC_VI_PROCESS_FK on REC_IV_PROCESS (IV_NO);
alter table REC_IV_PROCESS
  add constraint PK_REC_IV_PROCESS primary key (IVP_NO);
alter table REC_IV_PROCESS
  add constraint FK_REC_IV_P_REC_VI_PR_REC_INTE foreign key (IV_NO)
  references REC_INTERVIEW (IV_NO);

prompt
prompt Creating table REC_IV_PRO_RESULT
prompt ================================
prompt
create table REC_IV_PRO_RESULT
(
  ivpr_no     INTEGER not null,
  ive_no      INTEGER,
  ivp_no      INTEGER,
  mark        NUMBER,
  grade_id    VARCHAR2(20),
  rp_am2      VARCHAR2(100),
  rp_am3      VARCHAR2(100),
  rp_am1      VARCHAR2(100),
  activity    NUMBER(1) default 1,
  create_by   VARCHAR2(20),
  create_date DATE,
  update_by   VARCHAR2(20),
  update_date DATE
)
;
comment on table REC_IV_PRO_RESULT
  is '����?��';
comment on column REC_IV_PRO_RESULT.ivpr_no
  is '����?��';
comment on column REC_IV_PRO_RESULT.ive_no
  is '������';
comment on column REC_IV_PRO_RESULT.mark
  is '?��?';
comment on column REC_IV_PRO_RESULT.grade_id
  is '?��?';
comment on column REC_IV_PRO_RESULT.rp_am2
  is '����?��????';
comment on column REC_IV_PRO_RESULT.rp_am3
  is '����?��????';
comment on column REC_IV_PRO_RESULT.rp_am1
  is '����?��????';
comment on column REC_IV_PRO_RESULT.activity
  is 'ACTIVITY';
comment on column REC_IV_PRO_RESULT.create_by
  is 'CREATE_BY';
comment on column REC_IV_PRO_RESULT.create_date
  is 'CREATE_DATE';
comment on column REC_IV_PRO_RESULT.update_by
  is 'UPDATE_BY';
comment on column REC_IV_PRO_RESULT.update_date
  is 'UPDATE_DATE';
create index REC_VI_EMP_PRO_RESULT_FK on REC_IV_PRO_RESULT (IVE_NO);
create index REC_VI_PRO_RESULT_FK on REC_IV_PRO_RESULT (IVP_NO);
alter table REC_IV_PRO_RESULT
  add constraint PK_REC_IV_PRO_RESULT primary key (IVPR_NO);
alter table REC_IV_PRO_RESULT
  add constraint FK_REC_IV_P_REC_VI_EM_REC_IV_E foreign key (IVE_NO)
  references REC_IV_EMP (IVE_NO);
alter table REC_IV_PRO_RESULT
  add constraint FK_REC_IV_P_REC_VI_PR_REC_IV_P foreign key (IVP_NO)
  references REC_IV_PROCESS (IVP_NO);

prompt
prompt Creating table REC_IV_RESULT
prompt ============================
prompt
create table REC_IV_RESULT
(
  ivr_no      INTEGER not null,
  ivre_no     INTEGER not null,
  ive_no      INTEGER,
  mark        NUMBER,
  grade_id    VARCHAR2(20),
  rp_am1      VARCHAR2(100),
  rp_am2      VARCHAR2(100),
  rp_am3      VARCHAR2(100),
  activity    NUMBER(1) default 1,
  create_by   VARCHAR2(20),
  create_date DATE,
  update_by   VARCHAR2(20),
  update_date DATE
)
;
comment on table REC_IV_RESULT
  is '����?��';
comment on column REC_IV_RESULT.ivre_no
  is '����?��';
comment on column REC_IV_RESULT.ive_no
  is '������';
comment on column REC_IV_RESULT.mark
  is '?��?';
comment on column REC_IV_RESULT.grade_id
  is '?��?';
comment on column REC_IV_RESULT.rp_am1
  is '����?��????';
comment on column REC_IV_RESULT.rp_am2
  is '����?��????';
comment on column REC_IV_RESULT.rp_am3
  is '����?��????';
comment on column REC_IV_RESULT.activity
  is 'ACTIVITY';
comment on column REC_IV_RESULT.create_by
  is 'CREATE_BY';
comment on column REC_IV_RESULT.create_date
  is 'CREATE_DATE';
comment on column REC_IV_RESULT.update_by
  is 'UPDATE_BY';
comment on column REC_IV_RESULT.update_date
  is 'UPDATE_DATE';
create index REC_INTERVIEWER_RESULT_FK on REC_IV_RESULT (IVR_NO);
create index REC_VI_EMP_RESULT_DETAIL_FK on REC_IV_RESULT (IVE_NO);
alter table REC_IV_RESULT
  add constraint PK_REC_IV_RESULT primary key (IVR_NO, IVRE_NO);
alter table REC_IV_RESULT
  add constraint FK_REC_IV_R_REC_INTER_REC_INTE foreign key (IVR_NO)
  references REC_INTERVIEWER (IVR_NO);
alter table REC_IV_RESULT
  add constraint FK_REC_IV_R_REC_VI_EM_REC_IV_E foreign key (IVE_NO)
  references REC_IV_EMP (IVE_NO);

prompt
prompt Creating table REC_LINKMAN
prompt ==========================
prompt
create table REC_LINKMAN
(
  clm_no       INTEGER not null,
  cha_no       INTEGER not null,
  ch_name      VARCHAR2(30) not null,
  en_name      VARCHAR2(30),
  ko_name      VARCHAR2(30),
  sex          VARCHAR2(20),
  dept         VARCHAR2(50),
  post         VARCHAR2(50),
  post_grade   VARCHAR2(50),
  email        VARCHAR2(30),
  cell_phone   VARCHAR2(30),
  office_phone VARCHAR2(30) not null,
  rec_comment  VARCHAR2(500),
  activity     NUMBER(1) default 1,
  create_by    VARCHAR2(20),
  create_date  DATE,
  update_by    VARCHAR2(20),
  update_date  DATE
)
;
comment on table REC_LINKMAN
  is '��????����';
comment on column REC_LINKMAN.clm_no
  is '??����';
comment on column REC_LINKMAN.cha_no
  is '������??';
comment on column REC_LINKMAN.ch_name
  is '������';
comment on column REC_LINKMAN.en_name
  is '������';
comment on column REC_LINKMAN.ko_name
  is '??����';
comment on column REC_LINKMAN.dept
  is '??��';
comment on column REC_LINKMAN.post
  is '?��?';
comment on column REC_LINKMAN.post_grade
  is '��??';
comment on column REC_LINKMAN.email
  is 'EMAIL';
comment on column REC_LINKMAN.cell_phone
  is '��??';
comment on column REC_LINKMAN.office_phone
  is '?����?��';
comment on column REC_LINKMAN.rec_comment
  is '??��';
comment on column REC_LINKMAN.activity
  is 'ACTIVITY';
comment on column REC_LINKMAN.create_by
  is 'CREATE_BY';
comment on column REC_LINKMAN.create_date
  is 'CREATE_DATE';
comment on column REC_LINKMAN.update_by
  is 'UPDATE_BY';
comment on column REC_LINKMAN.update_date
  is 'UPDATE_DATE';
create index REC_LINKMAN_FK on REC_LINKMAN (CHA_NO);
alter table REC_LINKMAN
  add constraint PK_REC_LINKMAN primary key (CLM_NO);
alter table REC_LINKMAN
  add constraint FK_REC_LINK_REC_LINKM_REC_CHAN foreign key (CHA_NO)
  references REC_CHANNEL (CHA_NO);

prompt
prompt Creating table REC_PROCESS_INTERVIEWER
prompt ======================================
prompt
create table REC_PROCESS_INTERVIEWER
(
  ivp_no INTEGER not null,
  ivr_no INTEGER not null
)
;
comment on table REC_PROCESS_INTERVIEWER
  is 'REC_PROCESS_INTERVIEWER';
create index REC_PROCESS_INTERVIEWER2_FK on REC_PROCESS_INTERVIEWER (IVR_NO);
create index REC_PROCESS_INTERVIEWER_FK on REC_PROCESS_INTERVIEWER (IVP_NO);
alter table REC_PROCESS_INTERVIEWER
  add constraint PK_REC_PROCESS_INTERVIEWER primary key (IVP_NO, IVR_NO);
alter table REC_PROCESS_INTERVIEWER
  add constraint FK_REC_PROC_REC_PROCE_REC_INTE foreign key (IVR_NO)
  references REC_INTERVIEWER (IVR_NO);
alter table REC_PROCESS_INTERVIEWER
  add constraint FK_REC_PROC_REC_PROCE_REC_IV_P foreign key (IVP_NO)
  references REC_IV_PROCESS (IVP_NO);

prompt
prompt Creating table REC_PUBLISH_INNER
prompt ================================
prompt
create table REC_PUBLISH_INNER
(
  pli_no            INTEGER not null,
  dm_no             INTEGER not null,
  req_type_id       VARCHAR2(20),
  post_id           VARCHAR2(20),
  post_grade_id     VARCHAR2(20),
  dm_date           DATE,
  arrive_date       DATE,
  dm_num            INTEGER,
  exigency_grade_id VARCHAR2(20),
  reason            VARCHAR2(500),
  duty_detail       VARCHAR2(500),
  require           VARCHAR2(500),
  pub_flag_id       VARCHAR2(20),
  rec_comment       VARCHAR2(500),
  activity          NUMBER(1) default 1,
  create_by         VARCHAR2(20),
  create_date       DATE,
  update_by         VARCHAR2(20),
  update_date       DATE
)
;
comment on table REC_PUBLISH_INNER
  is '?������?????';
comment on column REC_PUBLISH_INNER.pli_no
  is '?������?????';
comment on column REC_PUBLISH_INNER.dm_no
  is '����?��';
comment on column REC_PUBLISH_INNER.req_type_id
  is '����?��';
comment on column REC_PUBLISH_INNER.post_id
  is '?��?';
comment on column REC_PUBLISH_INNER.post_grade_id
  is '��??';
comment on column REC_PUBLISH_INNER.dm_date
  is '��������';
comment on column REC_PUBLISH_INNER.dm_num
  is '��������';
comment on column REC_PUBLISH_INNER.reason
  is '��������';
comment on column REC_PUBLISH_INNER.duty_detail
  is '��������';
comment on column REC_PUBLISH_INNER.require
  is '����';
comment on column REC_PUBLISH_INNER.rec_comment
  is '??��';
comment on column REC_PUBLISH_INNER.activity
  is 'ACTIVITY';
comment on column REC_PUBLISH_INNER.create_by
  is 'CREATE_BY';
comment on column REC_PUBLISH_INNER.create_date
  is 'CREATE_DATE';
comment on column REC_PUBLISH_INNER.update_by
  is 'UPDATE_BY';
comment on column REC_PUBLISH_INNER.update_date
  is 'UPDATE_DATE';
create index REC_PUBLISH_INNER_FK on REC_PUBLISH_INNER (DM_NO);
alter table REC_PUBLISH_INNER
  add constraint PK_REC_PUBLISH_INNER primary key (PLI_NO);
alter table REC_PUBLISH_INNER
  add constraint FK_REC_PUBL_REC_PUBLI_REC_DEMA foreign key (DM_NO)
  references REC_DEMAND (DM_NO);

prompt
prompt Creating table REC_RE_EDU
prompt =========================
prompt
create table REC_RE_EDU
(
  ree_no           INTEGER not null,
  res_no           INTEGER not null,
  institution_name VARCHAR2(100),
  subject_id       VARCHAR2(100),
  start_date       DATE not null,
  end_date         DATE not null,
  degree_id        VARCHAR2(20) not null,
  degree_type      VARCHAR2(50),
  educ_card_no     VARCHAR2(50),
  school_address   VARCHAR2(100),
  activity         NUMBER(1) default 1,
  create_by        VARCHAR2(20),
  create_date      DATE,
  update_by        VARCHAR2(20),
  update_date      DATE
)
;
comment on table REC_RE_EDU
  is '?����?����';
comment on column REC_RE_EDU.ree_no
  is '?��?';
comment on column REC_RE_EDU.institution_name
  is '������';
comment on column REC_RE_EDU.subject_id
  is '����';
comment on column REC_RE_EDU.start_date
  is '??������';
comment on column REC_RE_EDU.end_date
  is '?������';
comment on column REC_RE_EDU.degree_id
  is '��??';
comment on column REC_RE_EDU.school_address
  is '����?��?';
comment on column REC_RE_EDU.activity
  is 'ACTIVITY';
comment on column REC_RE_EDU.create_by
  is 'CREATE_BY';
comment on column REC_RE_EDU.create_date
  is 'CREATE_DATE';
comment on column REC_RE_EDU.update_by
  is 'UPDATE_BY';
comment on column REC_RE_EDU.update_date
  is 'UPDATE_DATE';
create index REC_RE_EDUCATION_FK on REC_RE_EDU (RES_NO);
alter table REC_RE_EDU
  add constraint PK_REC_RE_EDU primary key (REE_NO);
alter table REC_RE_EDU
  add constraint FK_REC_RE_E_REC_RE_ED_REC_RESU foreign key (RES_NO)
  references REC_RESUME (RES_NO);

prompt
prompt Creating table REC_RE_FAMILY
prompt ============================
prompt
create table REC_RE_FAMILY
(
  ref_no         INTEGER not null,
  res_no         INTEGER not null,
  fam_type_id    VARCHAR2(20),
  ch_name        VARCHAR2(30),
  id_card        VARCHAR2(30),
  cell_phone     VARCHAR2(30),
  fam_occup_code VARCHAR2(20),
  fam_home_addr  VARCHAR2(100),
  activity       NUMBER(1) default 1,
  create_by      VARCHAR2(20),
  create_date    DATE,
  update_by      VARCHAR2(20),
  update_date    DATE
)
;
comment on table REC_RE_FAMILY
  is '?����?����';
comment on column REC_RE_FAMILY.ref_no
  is '?��?';
comment on column REC_RE_FAMILY.fam_type_id
  is '?��?';
comment on column REC_RE_FAMILY.ch_name
  is '������';
comment on column REC_RE_FAMILY.id_card
  is '��?��?';
comment on column REC_RE_FAMILY.cell_phone
  is '��??';
comment on column REC_RE_FAMILY.fam_occup_code
  is '����';
comment on column REC_RE_FAMILY.fam_home_addr
  is '?��??��?';
comment on column REC_RE_FAMILY.activity
  is 'ACTIVITY';
comment on column REC_RE_FAMILY.create_by
  is 'CREATE_BY';
comment on column REC_RE_FAMILY.create_date
  is 'CREATE_DATE';
comment on column REC_RE_FAMILY.update_by
  is 'UPDATE_BY';
comment on column REC_RE_FAMILY.update_date
  is 'UPDATE_DATE';
create index REC_RE_FAMILY_FK on REC_RE_FAMILY (RES_NO);
alter table REC_RE_FAMILY
  add constraint PK_REC_RE_FAMILY primary key (REF_NO);
alter table REC_RE_FAMILY
  add constraint FK_REC_RE_F_REC_RE_FA_REC_RESU foreign key (RES_NO)
  references REC_RESUME (RES_NO);

prompt
prompt Creating table REC_RE_QUAL
prompt ==========================
prompt
create table REC_RE_QUAL
(
  req_no         INTEGER not null,
  res_no         INTEGER not null,
  qual_name_code VARCHAR2(20) not null,
  date_obtained  DATE not null,
  qual_grade     VARCHAR2(20),
  qual_card_no   VARCHAR2(30),
  qual_location  VARCHAR2(100),
  activity       NUMBER(1) default 1,
  create_by      VARCHAR2(20),
  create_date    DATE,
  update_by      VARCHAR2(20),
  update_date    DATE
)
;
comment on table REC_RE_QUAL
  is '��?��?';
comment on column REC_RE_QUAL.qual_name_code
  is '������';
comment on column REC_RE_QUAL.date_obtained
  is '��������';
comment on column REC_RE_QUAL.qual_grade
  is '����?��?';
comment on column REC_RE_QUAL.qual_location
  is '??��??';
comment on column REC_RE_QUAL.activity
  is 'ACTIVITY';
comment on column REC_RE_QUAL.create_by
  is 'CREATE_BY';
comment on column REC_RE_QUAL.create_date
  is 'CREATE_DATE';
comment on column REC_RE_QUAL.update_by
  is 'UPDATE_BY';
comment on column REC_RE_QUAL.update_date
  is 'UPDATE_DATE';
create index REC_RE_QUALIFICATION_FK on REC_RE_QUAL (RES_NO);
alter table REC_RE_QUAL
  add constraint PK_REC_RE_QUAL primary key (REQ_NO);
alter table REC_RE_QUAL
  add constraint FK_REC_RE_Q_REC_RE_QU_REC_RESU foreign key (RES_NO)
  references REC_RESUME (RES_NO);

prompt
prompt Creating table REC_RE_WORKEXP
prompt =============================
prompt
create table REC_RE_WORKEXP
(
  rew_no       INTEGER not null,
  res_no       INTEGER not null,
  cpny_name    VARCHAR2(100),
  start_date   DATE,
  end_date     DATE,
  dept_name    VARCHAR2(50),
  position     VARCHAR2(50),
  leave_reason VARCHAR2(100),
  activity     NUMBER(1) default 1,
  create_by    VARCHAR2(20),
  create_date  DATE,
  update_by    VARCHAR2(20),
  update_date  DATE
)
;
comment on table REC_RE_WORKEXP
  is '??��??��';
comment on column REC_RE_WORKEXP.rew_no
  is '??��??��';
comment on column REC_RE_WORKEXP.cpny_name
  is '??��';
comment on column REC_RE_WORKEXP.start_date
  is '??������';
comment on column REC_RE_WORKEXP.end_date
  is '?������';
comment on column REC_RE_WORKEXP.dept_name
  is '??��';
comment on column REC_RE_WORKEXP.position
  is '����';
comment on column REC_RE_WORKEXP.leave_reason
  is '?������';
comment on column REC_RE_WORKEXP.activity
  is 'ACTIVITY';
comment on column REC_RE_WORKEXP.create_by
  is 'CREATE_BY';
comment on column REC_RE_WORKEXP.create_date
  is 'CREATE_DATE';
comment on column REC_RE_WORKEXP.update_by
  is 'UPDATE_BY';
comment on column REC_RE_WORKEXP.update_date
  is 'UPDATE_DATE';
create index REC_RE_WORK_EXP_FK on REC_RE_WORKEXP (RES_NO);
alter table REC_RE_WORKEXP
  add constraint PK_REC_RE_WORKEXP primary key (REW_NO);
alter table REC_RE_WORKEXP
  add constraint FK_REC_RE_W_REC_RE_WO_REC_RESU foreign key (RES_NO)
  references REC_RESUME (RES_NO);

prompt
prompt Creating table REPORT_HR_HMC_TEMP
prompt =================================
prompt
create table REPORT_HR_HMC_TEMP
(
  rname VARCHAR2(100),
  cnt   NUMBER default 0,
  bl    NUMBER default 0,
  col   NUMBER default 1 not null
)
;

prompt
prompt Creating table REPORT_ITEM
prompt ==========================
prompt
create table REPORT_ITEM
(
  ri_no        NUMBER not null,
  rt_no        NUMBER not null,
  item_no      NUMBER not null,
  item_id      VARCHAR2(30) not null,
  item_name    VARCHAR2(50),
  item_en_name VARCHAR2(50),
  table_name   VARCHAR2(50) not null,
  create_by    VARCHAR2(10),
  create_date  DATE,
  update_by    VARCHAR2(10),
  update_date  DATE,
  orderno      NUMBER
)
;
comment on table REPORT_ITEM
  is 'ҳ�涨�� ��Ŀ����';
comment on column REPORT_ITEM.ri_no
  is 'RI_NO';
comment on column REPORT_ITEM.rt_no
  is 'RT_NO';
comment on column REPORT_ITEM.item_no
  is '����ϵ������ĿNO';
comment on column REPORT_ITEM.item_id
  is 'REF_ITEM_ID';
comment on column REPORT_ITEM.item_name
  is '��Ŀ����';
comment on column REPORT_ITEM.item_en_name
  is '��Ŀ����(Ӣ��)';
comment on column REPORT_ITEM.table_name
  is '����ϵ���ı���';
comment on column REPORT_ITEM.create_by
  is 'CREATE_BY';
comment on column REPORT_ITEM.create_date
  is 'CREATE_DATE';
comment on column REPORT_ITEM.update_by
  is 'UPDATE_BY';
comment on column REPORT_ITEM.update_date
  is 'UPDATE_DATE';
comment on column REPORT_ITEM.orderno
  is 'ORDERNO';
alter table REPORT_ITEM
  add constraint PK_RI_NO primary key (RI_NO);

prompt
prompt Creating table REPORT_TABLE
prompt ===========================
prompt
create table REPORT_TABLE
(
  rt_no         NUMBER not null,
  menu_code     VARCHAR2(7) not null,
  table_name    VARCHAR2(50) not null,
  table_en_name VARCHAR2(50),
  report_type   VARCHAR2(10),
  view_model    VARCHAR2(10),
  create_by     VARCHAR2(10),
  create_date   DATE,
  update_by     VARCHAR2(10),
  update_date   DATE,
  cpny_id       VARCHAR2(20),
  activity      NUMBER(1)
)
;
comment on table REPORT_TABLE
  is 'ҳ�涨�Ʊ����';
comment on column REPORT_TABLE.rt_no
  is 'RT_NO';
comment on column REPORT_TABLE.menu_code
  is 'ҳ�����';
comment on column REPORT_TABLE.table_name
  is 'TABLE_NAME';
comment on column REPORT_TABLE.table_en_name
  is 'TABLE_EN_NAME';
comment on column REPORT_TABLE.report_type
  is 'REPORT_TYPE';
comment on column REPORT_TABLE.view_model
  is 'VIEW_MODEL';
comment on column REPORT_TABLE.create_by
  is 'CREATE_BY';
comment on column REPORT_TABLE.create_date
  is 'CREATE_DATE';
comment on column REPORT_TABLE.update_by
  is 'UPDATE_BY';
comment on column REPORT_TABLE.update_date
  is 'UPDATE_DATE';
alter table REPORT_TABLE
  add constraint PK_RT_NO primary key (RT_NO);

prompt
prompt Creating table SALES_BASIC_INFO
prompt ===============================
prompt
create table SALES_BASIC_INFO
(
  sales_basic_no  NUMBER(10) not null,
  empid           VARCHAR2(20),
  position_code   VARCHAR2(20),
  sales_area_code VARCHAR2(20),
  orderno         NUMBER(10),
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  activity        NUMBER(1),
  cpny_id         VARCHAR2(20)
)
;
comment on column SALES_BASIC_INFO.sales_basic_no
  is '����';
comment on column SALES_BASIC_INFO.empid
  is '������Ա����';
alter table SALES_BASIC_INFO
  add constraint PK_SALES_BASIC primary key (SALES_BASIC_NO);

prompt
prompt Creating table SALES_REPORT_HISTORY
prompt ===================================
prompt
create table SALES_REPORT_HISTORY
(
  emp_id        VARCHAR2(20),
  month         VARCHAR2(20),
  sales_summery NUMBER(10,2),
  new_customer  NUMBER(5),
  action_count  NUMBER(5)
)
;
comment on column SALES_REPORT_HISTORY.emp_id
  is '��Աid';
comment on column SALES_REPORT_HISTORY.month
  is '��';
comment on column SALES_REPORT_HISTORY.sales_summery
  is '���۶�';
comment on column SALES_REPORT_HISTORY.new_customer
  is '�����ͻ�';
comment on column SALES_REPORT_HISTORY.action_count
  is '���';

prompt
prompt Creating table SALES_REPORT_HISTORY_201305
prompt ==========================================
prompt
create table SALES_REPORT_HISTORY_201305
(
  emp_id         VARCHAR2(20),
  chinesename    VARCHAR2(50),
  deptname       VARCHAR2(100),
  month          VARCHAR2(20),
  sales_summery  NUMBER(20,4),
  new_customer   NUMBER(5),
  action_count   NUMBER(5),
  salary_network NUMBER(20,4)
)
;

prompt
prompt Creating table SALES_REPORT_HISTORY_201306
prompt ==========================================
prompt
create table SALES_REPORT_HISTORY_201306
(
  emp_id         VARCHAR2(20),
  chinesename    VARCHAR2(50),
  deptname       VARCHAR2(100),
  month          VARCHAR2(20),
  sales_summery  NUMBER(20,4),
  new_customer   NUMBER(5),
  action_count   NUMBER(5),
  salary_network NUMBER(20,4)
)
;

prompt
prompt Creating table SALES_REPORT_HISTORY_201308
prompt ==========================================
prompt
create table SALES_REPORT_HISTORY_201308
(
  emp_id         VARCHAR2(20),
  chinesename    VARCHAR2(50),
  deptname       VARCHAR2(100),
  month          VARCHAR2(20),
  sales_summery  NUMBER(20,4),
  new_customer   NUMBER(5),
  action_count   NUMBER(5),
  salary_network NUMBER(20,4)
)
;

prompt
prompt Creating table SALES_REPORT_HISTORY_201310
prompt ==========================================
prompt
create table SALES_REPORT_HISTORY_201310
(
  emp_id         VARCHAR2(20),
  chinesename    VARCHAR2(50),
  deptname       VARCHAR2(100),
  month          VARCHAR2(20),
  sales_summery  NUMBER(20,4),
  new_customer   NUMBER(5),
  action_count   NUMBER(5),
  salary_network NUMBER(20,4)
)
;

prompt
prompt Creating table SALES_REPORT_HISTORY_201312
prompt ==========================================
prompt
create table SALES_REPORT_HISTORY_201312
(
  emp_id         VARCHAR2(20),
  chinesename    VARCHAR2(50),
  deptname       VARCHAR2(100),
  month          VARCHAR2(20),
  sales_summery  NUMBER(20,4),
  new_customer   NUMBER(5),
  action_count   NUMBER(5),
  salary_network NUMBER(20,4)
)
;

prompt
prompt Creating table SALES_SALARY_DIRECT
prompt ==================================
prompt
create table SALES_SALARY_DIRECT
(
  direct_sales_salary_id VARCHAR2(20) not null,
  product_id             VARCHAR2(20),
  refer                  VARCHAR2(20),
  percentage             NUMBER(10,5),
  activity               NUMBER(1),
  cpny_id                VARCHAR2(20),
  boundary               NUMBER(10),
  basis                  VARCHAR2(20),
  sales_area_code        VARCHAR2(20),
  refer_column           VARCHAR2(100),
  basis_column           VARCHAR2(100),
  begin_date             DATE,
  end_date               DATE,
  created_by             VARCHAR2(20),
  created_date           DATE,
  updated_by             VARCHAR2(20),
  updated_date           DATE
)
;
comment on table SALES_SALARY_DIRECT
  is 'ҵ����ֱ����ɶ��ձ�';
comment on column SALES_SALARY_DIRECT.direct_sales_salary_id
  is '����';
comment on column SALES_SALARY_DIRECT.product_id
  is '��Ʒ';
comment on column SALES_SALARY_DIRECT.refer
  is '�ο����ԣ�Ӫҵ��or ƿ����';
comment on column SALES_SALARY_DIRECT.percentage
  is '��ɱ���';
comment on column SALES_SALARY_DIRECT.boundary
  is '�ο�ֵ��>=��ֵʱ�ų�����';
comment on column SALES_SALARY_DIRECT.basis
  is '��ɻ�����Ӫҵ��or ƿ����';
comment on column SALES_SALARY_DIRECT.sales_area_code
  is '����������';
comment on column SALES_SALARY_DIRECT.refer_column
  is '�ο����Ե��ֶ���';
comment on column SALES_SALARY_DIRECT.basis_column
  is '��ɻ������ֶ���';
comment on column SALES_SALARY_DIRECT.begin_date
  is '��ʼ����';
comment on column SALES_SALARY_DIRECT.end_date
  is '��������';
alter table SALES_SALARY_DIRECT
  add constraint PK_BP_SALARY_DIRECT_SALES primary key (DIRECT_SALES_SALARY_ID);

prompt
prompt Creating table SALES_SALARY_NETWORK
prompt ===================================
prompt
create table SALES_SALARY_NETWORK
(
  network_sales_salary_id VARCHAR2(20) not null,
  refer                   VARCHAR2(20),
  percentage              NUMBER(10,5),
  activity                NUMBER(1),
  cpny_id                 VARCHAR2(20),
  begin_date              DATE,
  end_date                DATE,
  created_by              VARCHAR2(20),
  created_date            DATE,
  updated_by              VARCHAR2(20),
  updated_date            DATE
)
;
comment on table SALES_SALARY_NETWORK
  is 'ҵ����������ɶ��ձ�';
comment on column SALES_SALARY_NETWORK.network_sales_salary_id
  is '����';
comment on column SALES_SALARY_NETWORK.refer
  is '�ο�����';
comment on column SALES_SALARY_NETWORK.percentage
  is '��ɱ���';
alter table SALES_SALARY_NETWORK
  add constraint PK_BP_SALARY_NETWORK_SALES primary key (NETWORK_SALES_SALARY_ID);

prompt
prompt Creating table SALES_SUPERVISOR
prompt ===============================
prompt
create table SALES_SUPERVISOR
(
  supervisor_no NUMBER,
  supervisor_id VARCHAR2(20),
  activity      NUMBER(1),
  created_by    VARCHAR2(20),
  created_date  DATE,
  updated_by    VARCHAR2(20),
  updated_date  DATE,
  cpny_id       VARCHAR2(20)
)
;
comment on column SALES_SUPERVISOR.supervisor_no
  is 'NO';
comment on column SALES_SUPERVISOR.supervisor_id
  is '�����˵�ID';
comment on column SALES_SUPERVISOR.activity
  is '�Ƿ����';
comment on column SALES_SUPERVISOR.created_by
  is '������';
comment on column SALES_SUPERVISOR.created_date
  is '��������';
comment on column SALES_SUPERVISOR.updated_by
  is '������';
comment on column SALES_SUPERVISOR.updated_date
  is '��������';
comment on column SALES_SUPERVISOR.cpny_id
  is '��˾ID';

prompt
prompt Creating table SALES_SUPERVISOR_INFO
prompt ====================================
prompt
create table SALES_SUPERVISOR_INFO
(
  supervised_deptid VARCHAR2(20),
  supervisor_id     VARCHAR2(20)
)
;

prompt
prompt Creating table SYS_EXPORT_SCHEMA_01
prompt ===================================
prompt
create table SYS_EXPORT_SCHEMA_01
(
  process_order          NUMBER,
  duplicate              NUMBER,
  dump_fileid            NUMBER,
  dump_position          NUMBER,
  dump_length            NUMBER,
  dump_orig_length       NUMBER,
  dump_allocation        NUMBER,
  completed_rows         NUMBER,
  error_count            NUMBER,
  elapsed_time           NUMBER,
  object_type_path       VARCHAR2(200),
  object_path_seqno      NUMBER,
  object_type            VARCHAR2(30),
  in_progress            CHAR(1),
  object_name            VARCHAR2(500),
  object_long_name       VARCHAR2(4000),
  object_schema          VARCHAR2(30),
  original_object_schema VARCHAR2(30),
  original_object_name   VARCHAR2(4000),
  partition_name         VARCHAR2(30),
  subpartition_name      VARCHAR2(30),
  dataobj_num            NUMBER,
  flags                  NUMBER,
  property               NUMBER,
  trigflag               NUMBER,
  creation_level         NUMBER,
  completion_time        DATE,
  object_tablespace      VARCHAR2(30),
  size_estimate          NUMBER,
  object_row             NUMBER,
  processing_state       CHAR(1),
  processing_status      CHAR(1),
  base_process_order     NUMBER,
  base_object_type       VARCHAR2(30),
  base_object_name       VARCHAR2(30),
  base_object_schema     VARCHAR2(30),
  ancestor_process_order NUMBER,
  domain_process_order   NUMBER,
  parallelization        NUMBER,
  unload_method          NUMBER,
  load_method            NUMBER,
  granules               NUMBER,
  scn                    NUMBER,
  grantor                VARCHAR2(30),
  xml_clob               CLOB,
  parent_process_order   NUMBER,
  name                   VARCHAR2(30),
  value_t                VARCHAR2(4000),
  value_n                NUMBER,
  is_default             NUMBER,
  file_type              NUMBER,
  user_directory         VARCHAR2(4000),
  user_file_name         VARCHAR2(4000),
  file_name              VARCHAR2(4000),
  extend_size            NUMBER,
  file_max_size          NUMBER,
  process_name           VARCHAR2(30),
  last_update            DATE,
  work_item              VARCHAR2(30),
  object_number          NUMBER,
  completed_bytes        NUMBER,
  total_bytes            NUMBER,
  metadata_io            NUMBER,
  data_io                NUMBER,
  cumulative_time        NUMBER,
  packet_number          NUMBER,
  instance_id            NUMBER,
  old_value              VARCHAR2(4000),
  seed                   NUMBER,
  last_file              NUMBER,
  user_name              VARCHAR2(30),
  operation              VARCHAR2(30),
  job_mode               VARCHAR2(30),
  queue_tabnum           NUMBER,
  control_queue          VARCHAR2(30),
  status_queue           VARCHAR2(30),
  remote_link            VARCHAR2(4000),
  version                NUMBER,
  job_version            VARCHAR2(30),
  db_version             VARCHAR2(30),
  timezone               VARCHAR2(64),
  state                  VARCHAR2(30),
  phase                  NUMBER,
  guid                   RAW(16),
  start_time             DATE,
  block_size             NUMBER,
  metadata_buffer_size   NUMBER,
  data_buffer_size       NUMBER,
  degree                 NUMBER,
  platform               VARCHAR2(101),
  abort_step             NUMBER,
  instance               VARCHAR2(60),
  cluster_ok             NUMBER,
  service_name           VARCHAR2(100),
  object_int_oid         VARCHAR2(32)
)
;
comment on table SYS_EXPORT_SCHEMA_01
  is 'Data Pump Master Table EXPORT                         SCHEMA                        ';
create index SYS_MTABLE_00001EE72_IND_1 on SYS_EXPORT_SCHEMA_01 (OBJECT_SCHEMA, OBJECT_NAME, OBJECT_TYPE);
create index SYS_MTABLE_00001EE72_IND_2 on SYS_EXPORT_SCHEMA_01 (BASE_PROCESS_ORDER);
alter table SYS_EXPORT_SCHEMA_01
  add unique (PROCESS_ORDER, DUPLICATE);

prompt
prompt Creating table SYS_EXPORT_SCHEMA_02
prompt ===================================
prompt
create table SYS_EXPORT_SCHEMA_02
(
  process_order          NUMBER,
  duplicate              NUMBER,
  dump_fileid            NUMBER,
  dump_position          NUMBER,
  dump_length            NUMBER,
  dump_orig_length       NUMBER,
  dump_allocation        NUMBER,
  completed_rows         NUMBER,
  error_count            NUMBER,
  elapsed_time           NUMBER,
  object_type_path       VARCHAR2(200),
  object_path_seqno      NUMBER,
  object_type            VARCHAR2(30),
  in_progress            CHAR(1),
  object_name            VARCHAR2(500),
  object_long_name       VARCHAR2(4000),
  object_schema          VARCHAR2(30),
  original_object_schema VARCHAR2(30),
  original_object_name   VARCHAR2(4000),
  partition_name         VARCHAR2(30),
  subpartition_name      VARCHAR2(30),
  dataobj_num            NUMBER,
  flags                  NUMBER,
  property               NUMBER,
  trigflag               NUMBER,
  creation_level         NUMBER,
  completion_time        DATE,
  object_tablespace      VARCHAR2(30),
  size_estimate          NUMBER,
  object_row             NUMBER,
  processing_state       CHAR(1),
  processing_status      CHAR(1),
  base_process_order     NUMBER,
  base_object_type       VARCHAR2(30),
  base_object_name       VARCHAR2(30),
  base_object_schema     VARCHAR2(30),
  ancestor_process_order NUMBER,
  domain_process_order   NUMBER,
  parallelization        NUMBER,
  unload_method          NUMBER,
  load_method            NUMBER,
  granules               NUMBER,
  scn                    NUMBER,
  grantor                VARCHAR2(30),
  xml_clob               CLOB,
  parent_process_order   NUMBER,
  name                   VARCHAR2(30),
  value_t                VARCHAR2(4000),
  value_n                NUMBER,
  is_default             NUMBER,
  file_type              NUMBER,
  user_directory         VARCHAR2(4000),
  user_file_name         VARCHAR2(4000),
  file_name              VARCHAR2(4000),
  extend_size            NUMBER,
  file_max_size          NUMBER,
  process_name           VARCHAR2(30),
  last_update            DATE,
  work_item              VARCHAR2(30),
  object_number          NUMBER,
  completed_bytes        NUMBER,
  total_bytes            NUMBER,
  metadata_io            NUMBER,
  data_io                NUMBER,
  cumulative_time        NUMBER,
  packet_number          NUMBER,
  instance_id            NUMBER,
  old_value              VARCHAR2(4000),
  seed                   NUMBER,
  last_file              NUMBER,
  user_name              VARCHAR2(30),
  operation              VARCHAR2(30),
  job_mode               VARCHAR2(30),
  queue_tabnum           NUMBER,
  control_queue          VARCHAR2(30),
  status_queue           VARCHAR2(30),
  remote_link            VARCHAR2(4000),
  version                NUMBER,
  job_version            VARCHAR2(30),
  db_version             VARCHAR2(30),
  timezone               VARCHAR2(64),
  state                  VARCHAR2(30),
  phase                  NUMBER,
  guid                   RAW(16),
  start_time             DATE,
  block_size             NUMBER,
  metadata_buffer_size   NUMBER,
  data_buffer_size       NUMBER,
  degree                 NUMBER,
  platform               VARCHAR2(101),
  abort_step             NUMBER,
  instance               VARCHAR2(60),
  cluster_ok             NUMBER,
  service_name           VARCHAR2(100),
  object_int_oid         VARCHAR2(32)
)
;
comment on table SYS_EXPORT_SCHEMA_02
  is 'Data Pump Master Table EXPORT                         SCHEMA                        ';
create index SYS_MTABLE_000023A8B_IND_1 on SYS_EXPORT_SCHEMA_02 (OBJECT_SCHEMA, OBJECT_NAME, OBJECT_TYPE);
create index SYS_MTABLE_000023A8B_IND_2 on SYS_EXPORT_SCHEMA_02 (BASE_PROCESS_ORDER);
alter table SYS_EXPORT_SCHEMA_02
  add unique (PROCESS_ORDER, DUPLICATE);

prompt
prompt Creating table SY_ADMIN
prompt =======================
prompt
create table SY_ADMIN
(
  adminno         NUMBER(10) not null,
  adminid         VARCHAR2(20) not null,
  adminlevel      NUMBER(1),
  username        VARCHAR2(50) not null,
  password        VARCHAR2(32),
  login_deptid    VARCHAR2(50),
  screen_grant_id VARCHAR2(200),
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  orderno         NUMBER(10),
  activity        NUMBER(1),
  appcnt          NUMBER,
  set_app         VARCHAR2(20),
  cpny_id         VARCHAR2(20),
  account_type    VARCHAR2(10)
)
;
comment on column SY_ADMIN.adminno
  is '����NO';
comment on column SY_ADMIN.adminid
  is 'sys��Ա����ţ��ͻ�NO��������NO';
comment on column SY_ADMIN.adminlevel
  is '���ã�����ȡ��';
comment on column SY_ADMIN.username
  is '�û�������¼����';
comment on column SY_ADMIN.password
  is '���루��¼���룩';
comment on column SY_ADMIN.login_deptid
  is '���ã�����ȡ��';
comment on column SY_ADMIN.screen_grant_id
  is 'Ȩ�����ÿ��Ա���������ڶ��� ���ݸ�ʽ��1,2,3��';
comment on column SY_ADMIN.create_date
  is '���ݴ�������';
comment on column SY_ADMIN.created_by
  is '���ݴ�����';
comment on column SY_ADMIN.update_date
  is '���ݸ�������';
comment on column SY_ADMIN.updated_by
  is '���ݸ�����';
comment on column SY_ADMIN.orderno
  is '�����';
comment on column SY_ADMIN.activity
  is '�˺��Ƿ���ã��Ƿ񼤻';
comment on column SY_ADMIN.appcnt
  is '���ã�����ȡ��';
comment on column SY_ADMIN.set_app
  is '���ã�����ȡ��';
comment on column SY_ADMIN.cpny_id
  is '��˾���';
comment on column SY_ADMIN.account_type
  is 'ϵͳ�û�SY,Ա���˺�EM,�������˺�SU,�ͻ��˺�CU';
alter table SY_ADMIN
  add constraint PK_SY_ADMIN primary key (ADMINID);
alter table SY_ADMIN
  add constraint AK_SY_ADMIN unique (ADMINNO);
alter table SY_ADMIN
  add constraint USERNAME_UNIQUE unique (USERNAME);

prompt
prompt Creating table SY_ADMIN_DEPTID
prompt ==============================
prompt
create table SY_ADMIN_DEPTID
(
  admin_no     NUMBER,
  admin_deptid VARCHAR2(20)
)
;
alter table SY_ADMIN_DEPTID
  add constraint FK_SY_ADMIN_DEPTID foreign key (ADMIN_NO)
  references SY_ADMIN (ADMINNO);

prompt
prompt Creating table SY_AFFIRM_RELATION
prompt =================================
prompt
create table SY_AFFIRM_RELATION
(
  affirm_relation_no NUMBER,
  cpny_id            VARCHAR2(20),
  affirmor_id        VARCHAR2(20) not null,
  affirm_type_id     VARCHAR2(50) not null,
  affirm_level       NUMBER not null,
  affirm_object      VARCHAR2(20) not null,
  affirm_flag        NUMBER,
  create_date        DATE,
  created_by         VARCHAR2(20),
  update_date        DATE,
  updated_by         VARCHAR2(20),
  activity           NUMBER
)
;
create index UK_AFFIRM_OBJECT on SY_AFFIRM_RELATION (AFFIRM_OBJECT);
alter table SY_AFFIRM_RELATION
  add constraint PK_SY_AFFIRM_RELATION primary key (AFFIRM_OBJECT, AFFIRM_LEVEL, AFFIRM_TYPE_ID, AFFIRMOR_ID);
alter table SY_AFFIRM_RELATION
  add constraint UK_SY_AFFIRM_RELATION unique (AFFIRM_RELATION_NO);

prompt
prompt Creating table SY_ANNOUNCEMENT
prompt ==============================
prompt
create table SY_ANNOUNCEMENT
(
  ann_no        NUMBER,
  ann_type_code VARCHAR2(20),
  ann_content   VARCHAR2(200),
  remark        VARCHAR2(200),
  activity      NUMBER(1),
  cpny_id       VARCHAR2(20),
  created_by    VARCHAR2(50),
  created_date  DATE,
  updated_by    VARCHAR2(50),
  updated_date  DATE,
  orderno       NUMBER
)
;
comment on column SY_ANNOUNCEMENT.ann_no
  is 'NO';
comment on column SY_ANNOUNCEMENT.ann_type_code
  is '��������';
comment on column SY_ANNOUNCEMENT.ann_content
  is '��������';
comment on column SY_ANNOUNCEMENT.remark
  is '��ע';
comment on column SY_ANNOUNCEMENT.activity
  is '�Ƿ����';
comment on column SY_ANNOUNCEMENT.cpny_id
  is '��˾id';

prompt
prompt Creating table SY_APPLY_NOTIFY_LIST
prompt ===================================
prompt
create table SY_APPLY_NOTIFY_LIST
(
  apply_type_code   VARCHAR2(20),
  address           VARCHAR2(30),
  address_type_code VARCHAR2(20),
  list_id           NUMBER(10) not null,
  cpny_id           VARCHAR2(20),
  activity          NUMBER(1)
)
;
comment on column SY_APPLY_NOTIFY_LIST.apply_type_code
  is '��������';
comment on column SY_APPLY_NOTIFY_LIST.address
  is '֪ͨ��ַ';
comment on column SY_APPLY_NOTIFY_LIST.address_type_code
  is '֪ͨ��ʽ';
comment on column SY_APPLY_NOTIFY_LIST.list_id
  is 'key';
comment on column SY_APPLY_NOTIFY_LIST.cpny_id
  is '��˾ID';
comment on column SY_APPLY_NOTIFY_LIST.activity
  is '�Ƿ����';

prompt
prompt Creating table SY_CATEGORY
prompt ==========================
prompt
create table SY_CATEGORY
(
  category_no   VARCHAR2(20) not null,
  category_id   VARCHAR2(20),
  category_name VARCHAR2(50) not null,
  remark        VARCHAR2(200),
  parent_id     VARCHAR2(50),
  depth         NUMBER(10),
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  activity      NUMBER(1),
  cpny_id       VARCHAR2(20),
  pre_code      varchar2(20)
)
;
-- Add comments to the columns 
comment on column SY_CATEGORY.pre_code
  is '���ǰ׺';

prompt
prompt Creating table SY_CATEGORY_PROPERTY
prompt ===================================
prompt
create table SY_CATEGORY_PROPERTY
(
  property_no   VARCHAR2(20) not null,
  property_id   VARCHAR2(20),
  property_name VARCHAR2(50) not null,
  remark        VARCHAR2(200),
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  activity      NUMBER(1),
  cpny_id       VARCHAR2(20),
  p_value_type  VARCHAR2(20)
)
;

prompt
prompt Creating table SY_CATEGORY_PROPERTY_DETAIL
prompt ==========================================
prompt
create table SY_CATEGORY_PROPERTY_DETAIL
(
  category_id VARCHAR2(20),
  property_id VARCHAR2(20),
  remark      VARCHAR2(500),
  created_by  VARCHAR2(20),
  create_date DATE,
  updated_by  VARCHAR2(20),
  update_date DATE,
  activity    NUMBER(1),
  cpny_id     VARCHAR2(20)
)
;

prompt
prompt Creating table SY_CHECKTYPE
prompt ===========================
prompt
create table SY_CHECKTYPE
(
  create_date DATE,
  created_by  VARCHAR2(15),
  update_date DATE,
  updated_by  VARCHAR2(15),
  activity    NUMBER(1) default 1,
  cpny_id     VARCHAR2(15),
  type_no     VARCHAR2(15) not null,
  type_id     VARCHAR2(15) not null,
  empid       VARCHAR2(15),
  check_key   NUMBER(1) default 1
)
;
comment on column SY_CHECKTYPE.check_key
  is '��˿��أ�1������0�ر�';
alter table SY_CHECKTYPE
  add primary key (TYPE_NO);
alter table SY_CHECKTYPE
  add constraint TYPE_ID_UNIQUE unique (TYPE_ID);

prompt
prompt Creating table SY_EMAIL_SND
prompt ===========================
prompt
create table SY_EMAIL_SND
(
  email_snd_seq NUMBER not null,
  email_title   VARCHAR2(50),
  email_contnt  VARCHAR2(4000),
  email_tp      VARCHAR2(20),
  to_email_addr VARCHAR2(50),
  snd_stat      NUMBER(1),
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  apply_no      NUMBER(10)
)
;
comment on table SY_EMAIL_SND
  is 'EMAIL_SEND';
comment on column SY_EMAIL_SND.email_snd_seq
  is 'EMAIL_SEND_SEQUENCE';
comment on column SY_EMAIL_SND.email_title
  is 'EMAIL_TITLE';
comment on column SY_EMAIL_SND.email_contnt
  is 'EMAIL_CONTENTS';
comment on column SY_EMAIL_SND.email_tp
  is 'EMAIL_TYPE';
comment on column SY_EMAIL_SND.snd_stat
  is 'SEND_STATUS';
alter table SY_EMAIL_SND
  add primary key (EMAIL_SND_SEQ);

prompt
prompt Creating table SY_EMP_SHORTCUT
prompt ==============================
prompt
create table SY_EMP_SHORTCUT
(
  empid       VARCHAR2(20) not null,
  menu_code   VARCHAR2(20) not null,
  create_date DATE,
  created_by  VARCHAR2(20),
  update_date DATE,
  updated_by  VARCHAR2(20),
  orderno     NUMBER(10),
  activity    NUMBER(1)
)
;
alter table SY_EMP_SHORTCUT
  add constraint PK_SY_EMP_SHORTCUT primary key (EMPID, MENU_CODE);

prompt
prompt Creating table SY_GRANT_EMPLOYEE
prompt ================================
prompt
create table SY_GRANT_EMPLOYEE
(
  grant_emp_no  NUMBER(10) not null,
  empid         VARCHAR2(20),
  dec_type_id   VARCHAR2(10),
  dec_level_id  VARCHAR2(10),
  dec_object_id VARCHAR2(20),
  decflag       NUMBER,
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  orderno       NUMBER(10),
  activity      NUMBER(1)
)
;
alter table SY_GRANT_EMPLOYEE
  add constraint PK_SY_GRANT_EMPLOYEE primary key (GRANT_EMP_NO);

prompt
prompt Creating table SY_HOME_ELEMENT
prompt ==============================
prompt
create table SY_HOME_ELEMENT
(
  mid      VARCHAR2(30) not null,
  mname_zh VARCHAR2(30),
  mname_en VARCHAR2(30),
  mdiv     VARCHAR2(500),
  orderno  NUMBER
)
;
alter table SY_HOME_ELEMENT
  add constraint SY_HOME_ELEMENT_PK primary key (MID);

prompt
prompt Creating table SY_HOME_PURVIEW
prompt ==============================
prompt
create table SY_HOME_PURVIEW
(
  mid             VARCHAR2(30),
  screen_grant_id VARCHAR2(20)
)
;

prompt
prompt Creating table SY_LOGIN_DEPT
prompt ============================
prompt
create table SY_LOGIN_DEPT
(
  login_no      NUMBER(10),
  login_id      VARCHAR2(20) not null,
  login_dept_id VARCHAR2(10) not null,
  create_date   DATE,
  created_by    VARCHAR2(20),
  update_date   DATE,
  updated_by    VARCHAR2(20),
  orderno       NUMBER(10),
  activity      NUMBER(1)
)
;
alter table SY_LOGIN_DEPT
  add constraint PK_SY_LOGIN_DEPT primary key (LOGIN_ID, LOGIN_DEPT_ID);

prompt
prompt Creating table SY_LOGIN_INFO
prompt ============================
prompt
create table SY_LOGIN_INFO
(
  empid       VARCHAR2(200),
  ip          VARCHAR2(200),
  mac         VARCHAR2(200),
  login_date  DATE,
  create_date DATE,
  created_by  VARCHAR2(20),
  update_date DATE,
  updated_by  VARCHAR2(20),
  activity    NUMBER(1),
  contact_id  VARCHAR2(200)
)
;
comment on table SY_LOGIN_INFO
  is '��½��Ϣ��';
comment on column SY_LOGIN_INFO.empid
  is '����';
comment on column SY_LOGIN_INFO.ip
  is 'IP��ַ';
comment on column SY_LOGIN_INFO.mac
  is 'MAC��ַ';
comment on column SY_LOGIN_INFO.login_date
  is '��½ʱ��';
comment on column SY_LOGIN_INFO.create_date
  is '����ʱ��';
comment on column SY_LOGIN_INFO.created_by
  is '������';
comment on column SY_LOGIN_INFO.update_date
  is '����ʱ��/�ǳ�ʱ��';
comment on column SY_LOGIN_INFO.updated_by
  is '������';
comment on column SY_LOGIN_INFO.contact_id
  is '�ͻ����';

prompt
prompt Creating table SY_LOGIN_SCREEN
prompt ==============================
prompt
create table SY_LOGIN_SCREEN
(
  screen_grant_no      NUMBER(10) not null,
  screen_grant_id      VARCHAR2(200),
  screen_grant_name    VARCHAR2(50),
  screen_grant_en_name VARCHAR2(50),
  description          VARCHAR2(200),
  create_date          DATE,
  created_by           VARCHAR2(20),
  update_date          DATE,
  updated_by           VARCHAR2(20),
  orderno              NUMBER(10),
  activity             NUMBER(1),
  cpny_id              VARCHAR2(20),
  supplier_id          VARCHAR2(20)
)
;
alter table SY_LOGIN_SCREEN
  add constraint PK_SY_LOGIN_SCREEN primary key (SCREEN_GRANT_NO);

prompt
prompt Creating table SY_MENU
prompt ======================
prompt
create table SY_MENU
(
  menu_no          NUMBER(10) not null,
  menu_code        VARCHAR2(50) not null,
  menu_intro       VARCHAR2(250) not null,
  menu_en_intro    VARCHAR2(250),
  menu_img         VARCHAR2(200),
  menu_parent_code VARCHAR2(50),
  depth            NUMBER(10),
  build_flag       VARCHAR2(20),
  table_name       VARCHAR2(50),
  menu_url         VARCHAR2(250),
  description      VARCHAR2(200),
  create_date      DATE,
  created_by       VARCHAR2(20),
  update_date      DATE,
  updated_by       VARCHAR2(20),
  orderno          NUMBER(10),
  activity         NUMBER(1),
  cpny_id          VARCHAR2(20)
)
;
alter table SY_MENU
  add constraint PK_SY_MENU primary key (MENU_CODE);
alter table SY_MENU
  add constraint UK_SY_MENU unique (MENU_NO);

prompt
prompt Creating table SY_MESSAGE
prompt =========================
prompt
create table SY_MESSAGE
(
  message_no      VARCHAR2(20),
  message_id      VARCHAR2(20),
  message_title   VARCHAR2(500),
  message_content VARCHAR2(2000),
  message_type    VARCHAR2(20),
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  activity        NUMBER(1),
  cpny_id         VARCHAR2(20)
)
;

prompt
prompt Creating table SY_MESSAGE_EMP_DETAIL
prompt ====================================
prompt
create table SY_MESSAGE_EMP_DETAIL
(
  message_no      VARCHAR2(20),
  empid           VARCHAR2(20),
  is_read         NUMBER(1),
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  activity        NUMBER(1),
  cpny_id         VARCHAR2(20),
  deptid          VARCHAR2(20),
  screen_grant_id VARCHAR2(20),
  message_type    VARCHAR2(20)
)
;

prompt
prompt Creating table SY_MODEL
prompt =======================
prompt
create table SY_MODEL
(
  mtype    VARCHAR2(50) not null,
  mjsp     VARCHAR2(50) not null,
  mname    VARCHAR2(50) not null,
  mcontent VARCHAR2(4000)
)
;
alter table SY_MODEL
  add constraint SY_MODEL_PK primary key (MTYPE, MJSP, MNAME);

prompt
prompt Creating table SY_MYHOME
prompt ========================
prompt
create table SY_MYHOME
(
  empid    VARCHAR2(50) not null,
  mstate   VARCHAR2(50) not null,
  mid      VARCHAR2(50) not null,
  mcontent VARCHAR2(4000),
  page     NUMBER
)
;

prompt
prompt Creating table SY_ORDER
prompt =======================
prompt
create table SY_ORDER
(
  order_no      NUMBER(10),
  order_id      VARCHAR2(20) not null,
  order_name    VARCHAR2(20),
  order_en_name VARCHAR2(20),
  create_by     VARCHAR2(20),
  create_date   DATE,
  updated_by    VARCHAR2(20),
  update_date   DATE,
  activity      NUMBER(1),
  cpny_id       VARCHAR2(20)
)
;
alter table SY_ORDER
  add constraint SY_ORDER_ORDER_ID_PK primary key (ORDER_ID);

prompt
prompt Creating table SY_PARAMETER
prompt ===========================
prompt
create table SY_PARAMETER
(
  parameter_no   NUMBER(10) not null,
  parameter_id   VARCHAR2(200),
  desc_zh        VARCHAR2(200),
  desc_en        VARCHAR2(200),
  content        VARCHAR2(200),
  menu_code      VARCHAR2(20),
  remarks        VARCHAR2(200),
  data_type_code VARCHAR2(20),
  create_date    DATE,
  created_by     VARCHAR2(20),
  update_date    DATE,
  updated_by     VARCHAR2(20),
  orderno        NUMBER(10),
  activity       NUMBER(1),
  cpny_id        VARCHAR2(20)
)
;
comment on table SY_PARAMETER
  is '���²���';
alter table SY_PARAMETER
  add constraint PK_SY_PARAMETER primary key (PARAMETER_NO);
alter table SY_PARAMETER
  add constraint UK_SY_PARAMETER unique (PARAMETER_ID);

prompt
prompt Creating table SY_PROPERTY_VALUE
prompt ================================
prompt
create table SY_PROPERTY_VALUE
(
  p_value_no   VARCHAR2(20),
  p_value_id   VARCHAR2(20),
  p_value      VARCHAR2(50),
  p_value_type VARCHAR2(20),
  created_by   VARCHAR2(20),
  create_date  DATE,
  updated_by   VARCHAR2(20),
  update_date  DATE,
  activity     NUMBER(1),
  cpny_id      VARCHAR2(20),
  remark       VARCHAR2(500)
)
;

prompt
prompt Creating table SY_PROPERTY_VALUE_DETAIL
prompt =======================================
prompt
create table SY_PROPERTY_VALUE_DETAIL
(
  property_id VARCHAR2(20),
  remark      VARCHAR2(500),
  created_by  VARCHAR2(20),
  create_date DATE,
  updated_by  VARCHAR2(20),
  update_date DATE,
  activity    NUMBER(1),
  cpny_id     VARCHAR2(20),
  p_value_id  VARCHAR2(20)
)
;

prompt
prompt Creating table SY_PURVIEW
prompt =========================
prompt
create table SY_PURVIEW
(
  sy_menu VARCHAR2(20),
  url     VARCHAR2(20),
  action  VARCHAR2(20),
  content VARCHAR2(200)
)
;

prompt
prompt Creating table SY_SCREEN_GRANT
prompt ==============================
prompt
create table SY_SCREEN_GRANT
(
  screen_code     VARCHAR2(50) not null,
  screen_grant_id VARCHAR2(20) not null,
  selectr         NUMBER,
  saver           NUMBER,
  insertr         NUMBER,
  updater         NUMBER,
  deleter         NUMBER,
  cancelr         NUMBER,
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  orderno         NUMBER(10),
  activity        NUMBER(1)
)
;
alter table SY_SCREEN_GRANT
  add constraint PK_SY_SCREEN_GRANT primary key (SCREEN_CODE, SCREEN_GRANT_ID);
alter table SY_SCREEN_GRANT
  add constraint FK_SY_SCREEN_GRANT foreign key (SCREEN_CODE)
  references SY_MENU (MENU_CODE) on delete cascade;

prompt
prompt Creating table SY_SERIAL_NUM
prompt ============================
prompt
create table SY_SERIAL_NUM
(
  serial_num_no NUMBER(10),
  order_id      VARCHAR2(20) not null,
  sequence_name VARCHAR2(50),
  prefix        VARCHAR2(20),
  middle_field  VARCHAR2(20),
  num_length    NUMBER(10),
  reset_model   NUMBER(1),
  create_by     VARCHAR2(20),
  create_date   DATE,
  updated_by    VARCHAR2(20),
  update_date   DATE,
  activity      NUMBER(1),
  cpny_id       VARCHAR2(20)
)
;

prompt
prompt Creating table SY_SERIAL_NUM_ALL
prompt ================================
prompt
create table SY_SERIAL_NUM_ALL
(
  serial_num_all_no NUMBER(10),
  order_id          VARCHAR2(20),
  prefix            VARCHAR2(20),
  middle_field      VARCHAR2(30),
  num_length        NUMBER(10),
  reset_model       NUMBER(1),
  effect_date       DATE,
  end_date          DATE,
  create_by         VARCHAR2(20),
  create_date       DATE,
  updated_by        VARCHAR2(20),
  update_date       DATE,
  activity          NUMBER(1),
  cpny_id           VARCHAR2(20)
)
;

prompt
prompt Creating table SY_SUPPLIER_ADMIN
prompt ================================
prompt
create table SY_SUPPLIER_ADMIN
(
  adminno         NUMBER,
  adminid         VARCHAR2(20),
  adminlevel      NUMBER(1),
  username        VARCHAR2(50),
  password        VARCHAR2(32),
  login_deptid    VARCHAR2(200),
  screen_grant_id VARCHAR2(200),
  create_date     DATE,
  created_by      VARCHAR2(20),
  update_date     DATE,
  updated_by      VARCHAR2(20),
  orderno         NUMBER(10),
  activity        NUMBER(1),
  appcnt          NUMBER,
  set_app         VARCHAR2(20),
  cpny_id         VARCHAR2(20)
)
;

prompt
prompt Creating table SY_WORK_SALES_AREA
prompt =================================
prompt
create table SY_WORK_SALES_AREA
(
  code_no         NUMBER(10),
  area_code       VARCHAR2(20),
  sales_area_code VARCHAR2(20),
  activity        NUMBER(1)
)
;
comment on table SY_WORK_SALES_AREA
  is 'HR_DEPARTMENT.AREA_CODE��ORD_ORDER_INFO.SALES_AREA �Ķ�Ӧ';

prompt
prompt Creating table TEST_01
prompt ======================
prompt
create table TEST_01
(
  id VARCHAR2(20)
)
;

prompt
prompt Creating table TEST_02
prompt ======================
prompt
create table TEST_02
(
  id VARCHAR2(20)
)
;

prompt
prompt Creating table TMP_PERSONAL_INFO
prompt ================================
prompt
create table TMP_PERSONAL_INFO
(
  flag               VARCHAR2(20),
  empid              VARCHAR2(40),
  chinesename        VARCHAR2(80),
  emp_type_code      VARCHAR2(40),
  c_email            VARCHAR2(100),
  idcard_no          VARCHAR2(60),
  post_id            VARCHAR2(40),
  join_date          DATE,
  deptid             VARCHAR2(40),
  status_code        VARCHAR2(40),
  end_probation_date DATE,
  p_email            VARCHAR2(100)
)
;

prompt
prompt Creating table TMP_PERSONAL_TITLES
prompt ==================================
prompt
create table TMP_PERSONAL_TITLES
(
  title_code  VARCHAR2(40),
  title_name  VARCHAR2(40),
  datatype    VARCHAR2(40),
  parent_code VARCHAR2(40),
  table_name  VARCHAR2(40),
  column_code VARCHAR2(40),
  column_name VARCHAR2(40),
  order_no    NUMBER(3)
)
;

prompt
prompt Creating table T_AFFIRM_RELATION
prompt ================================
prompt
create table T_AFFIRM_RELATION
(
  affirmor_id    VARCHAR2(20),
  affirm_type_id VARCHAR2(50),
  affirm_level   NUMBER,
  affirm_object  VARCHAR2(20)
)
;

prompt
prompt Creating table T_AR_DETAIL
prompt ==========================
prompt
create table T_AR_DETAIL
(
  empid       VARCHAR2(20) not null,
  ar_date_str VARCHAR2(10) not null,
  from_time   DATE,
  to_time     DATE,
  shift_no    NUMBER(10),
  iweek       NUMBER(10),
  workdayflag NUMBER(10) not null,
  date_type   NUMBER,
  att_d_25    NUMBER,
  att_d_48    NUMBER,
  att_d_16    NUMBER,
  att_d_17    NUMBER,
  att_d_18    NUMBER,
  att_d_22    NUMBER,
  att_d_10    NUMBER,
  att_d_24    NUMBER,
  att_d_15    NUMBER,
  att_d_39    NUMBER,
  att_d_5     NUMBER,
  att_d_20    NUMBER,
  att_d_1     NUMBER,
  att_d_3     NUMBER,
  att_d_4     NUMBER,
  att_d_8     NUMBER,
  att_d_30    NUMBER,
  att_d_9     NUMBER,
  att_d_14    NUMBER
)
;

prompt
prompt Creating table T_AR_DETAIL_IMP
prompt ==============================
prompt
create table T_AR_DETAIL_IMP
(
  empid       VARCHAR2(20) not null,
  ar_item     VARCHAR2(50) not null,
  from_time   VARCHAR2(10),
  to_time     VARCHAR2(10),
  shift       VARCHAR2(50),
  ar_date_str VARCHAR2(10) not null,
  quantity    NUMBER(6,2),
  date_type   VARCHAR2(50),
  unit        VARCHAR2(20)
)
;

prompt
prompt Creating table T_AR_HISTORY
prompt ===========================
prompt
create table T_AR_HISTORY
(
  ar_month CHAR(6) not null,
  empid    VARCHAR2(20) not null
)
;

prompt
prompt Creating table T_AR_RESULT
prompt ==========================
prompt
create table T_AR_RESULT
(
  ar_month      CHAR(6),
  deptname      VARCHAR2(100),
  chinesename   VARCHAR2(40),
  empid         VARCHAR2(20) not null,
  emp_type_name VARCHAR2(50),
  status_code   VARCHAR2(20),
  status_name   VARCHAR2(50),
  post_name     VARCHAR2(50),
  card_no       VARCHAR2(200),
  deptid        VARCHAR2(20),
  join_date     DATE,
  emp_type_code VARCHAR2(20),
  att_m_112     NUMBER,
  att_m_58      NUMBER,
  att_m_114     NUMBER,
  att_m_8       NUMBER,
  att_m_9       NUMBER,
  att_m_7       NUMBER,
  att_m_6       NUMBER,
  att_m_110     NUMBER,
  att_m_119     NUMBER,
  att_m_113     NUMBER,
  att_m_52      NUMBER,
  att_m_115     NUMBER,
  att_m_53      NUMBER,
  att_m_2       NUMBER,
  att_m_118     NUMBER,
  att_m_12      NUMBER,
  att_m_15      NUMBER,
  att_m_39      NUMBER,
  att_m_117     NUMBER,
  att_m_20      NUMBER
)
;

prompt
prompt Creating table T_AR_SCHEDULE
prompt ============================
prompt
create table T_AR_SCHEDULE
(
  pk_no      NUMBER(10) not null,
  id         VARCHAR2(20) not null,
  from_date  DATE not null,
  to_date    DATE not null,
  shift_no   NUMBER(10) not null,
  orderno    NUMBER(28) not null,
  created_by VARCHAR2(20)
)
;

prompt
prompt Creating table T_DAILY_PA_RESULT
prompt ================================
prompt
create table T_DAILY_PA_RESULT
(
  empid_d                     VARCHAR2(20),
  chinesename_d               VARCHAR2(40),
  department_d                VARCHAR2(4000),
  date_str_d                  VARCHAR2(10),
  position_d                  VARCHAR2(4000),
  post_d                      VARCHAR2(4000),
  postgrade_d                 VARCHAR2(4000),
  status_d                    VARCHAR2(4000),
  biz_str_d                   VARCHAR2(500),
  area_d                      VARCHAR2(4000),
  welfare_start_date_d        DATE,
  welfare_end_date_d          DATE,
  apply_start_date_d          DATE,
  apply_end_date_d            DATE,
  post_group_name_d           VARCHAR2(4000),
  end_probation_date_d        DATE,
  date_left_d                 DATE,
  ynlink                      CHAR(1),
  live_emp_special_date_d     VARCHAR2(10),
  housing_emp_special_date_d  VARCHAR2(10),
  shift_name                  VARCHAR2(50),
  work_d                      NUMBER,
  weekday_ot_d                NUMBER,
  weekend_ot_d                NUMBER,
  holiday_ot_d                NUMBER,
  casual_leave_d              NUMBER,
  absenteeism_d               NUMBER,
  without_pay_leave_d         NUMBER,
  intra_edu_d                 NUMBER,
  cpy_intra_edu_d             NUMBER,
  cpy_outer_edu_d             NUMBER,
  maternity_leave_d           NUMBER,
  sick_leave_d                NUMBER,
  annual_vacation_d           NUMBER,
  prenatal_diagnosis_d        NUMBER,
  outer_edu_d                 NUMBER,
  shift                       VARCHAR2(50),
  typeid                      NUMBER,
  date_type                   NUMBER,
  daily_pay                   NUMBER,
  duibi_basic_pay             NUMBER,
  weekday_ot_pay              NUMBER,
  weekend_ot_pay              NUMBER,
  holidy_ot_pay               NUMBER,
  daily_cashier_allow         NUMBER,
  cashier_allow_normal        NUMBER,
  cashier_allow_deduct        NUMBER,
  area_grade                  CHAR(50),
  daily_tenement_allow_normal NUMBER,
  tenement_allow_normal       NUMBER,
  repast_allow                NUMBER,
  traffic_allow               NUMBER,
  wanbanjintie                NUMBER,
  daily_live_allow_normal     NUMBER,
  live_allow_normal           NUMBER,
  live_allow_deduct           NUMBER,
  daily_rm_repast             NUMBER,
  duibi_rm_repast             NUMBER,
  rm_repast_deduct            NUMBER,
  daily_rm_traffic            NUMBER,
  duibi_rm_traffic            NUMBER,
  rm_traffic_deduct           NUMBER,
  casual_leave_deduct         NUMBER,
  absenteeism_deduct          NUMBER,
  no_pay_leave_deduct         NUMBER
)
;
create unique index PK_T_DAILY_PA_RESULT on T_DAILY_PA_RESULT (EMPID_D, DATE_STR_D);

prompt
prompt Creating table T_EVS_NORN
prompt =========================
prompt
create table T_EVS_NORN
(
  a         NUMBER not null,
  b         NUMBER not null,
  c         NUMBER not null,
  d         NUMBER not null,
  cnt       NUMBER not null,
  deptgrade VARCHAR2(50) not null
)
;
alter table T_EVS_NORN
  add constraint PK_T_EVS_NORN primary key (CNT);

prompt
prompt Creating table T_HR_DEPARTMENT
prompt ==============================
prompt
create table T_HR_DEPARTMENT
(
  ����id   VARCHAR2(20),
  ���Ŵ���   VARCHAR2(10),
  ��������   VARCHAR2(100),
  ����Ӣ������ VARCHAR2(100),
  ��˾id   VARCHAR2(10),
  �ϼ�����id VARCHAR2(20),
  ���ż���   NUMBER(1),
  ��ʼʱ��   VARCHAR2(20),
  ����ʱ��   VARCHAR2(20),
  �������   NUMBER(3)
)
;

prompt
prompt Creating table T_HR_EMPLOYEE
prompt ============================
prompt
create table T_HR_EMPLOYEE
(
  ����   NUMBER,
  ����   VARCHAR2(2000),
  ƴ��   VARCHAR2(500),
  ����   VARCHAR2(500),
  ְλ   VARCHAR2(500),
  ְ��   VARCHAR2(500),
  ְ��   VARCHAR2(500),
  ����   VARCHAR2(500),
  ��ְ���� VARCHAR2(500),
  �������� VARCHAR2(500),
  �������� VARCHAR2(500),
  ת������ VARCHAR2(500),
  �������� VARCHAR2(500),
  Ա��״̬ VARCHAR2(500),
  ���Ϲ��� NUMBER,
  Ա������ VARCHAR2(500)
)
;

prompt
prompt Creating table T_HR_EMP_PA_INFO
prompt ===============================
prompt
create table T_HR_EMP_PA_INFO
(
  ����  VARCHAR2(500),
  ������ VARCHAR2(500),
  �ʻ��� VARCHAR2(500),
  ����  VARCHAR2(500),
  �ʺ�  VARCHAR2(500)
)
;

prompt
prompt Creating table T_HR_EXPERIENCE_INSIDE
prompt =====================================
prompt
create table T_HR_EXPERIENCE_INSIDE
(
  ����    VARCHAR2(500),
  ����    VARCHAR2(500),
  ʵʩ����  VARCHAR2(500),
  ���������� VARCHAR2(500),
  ����    VARCHAR2(500),
  ְ��    VARCHAR2(500),
  ְλ    VARCHAR2(500),
  ����    VARCHAR2(500),
  ְ��    VARCHAR2(500),
  �������  VARCHAR2(500),
  ����    VARCHAR2(500),
  Ա��״̬  VARCHAR2(500)
)
;

prompt
prompt Creating table T_HR_FAMILY
prompt ==========================
prompt
create table T_HR_FAMILY
(
  ����     VARCHAR2(500),
  ��ϵ     VARCHAR2(500),
  ����     VARCHAR2(500),
  ��������   VARCHAR2(500),
  ְλ     VARCHAR2(500),
  ���֤    VARCHAR2(500),
  ����ѧ��   VARCHAR2(500),
  ��ϵ�绰   VARCHAR2(500),
  ������λ   VARCHAR2(500),
  һ���ס��� VARCHAR2(500),
  ����     VARCHAR2(500),
  �����ص�   VARCHAR2(500),
  ��������   VARCHAR2(500)
)
;

prompt
prompt Creating table T_HR_HEALTH
prompt ==========================
prompt
create table T_HR_HEALTH
(
  ����      VARCHAR2(500),
  ����      VARCHAR2(500),
  ���      VARCHAR2(500),
  ����      VARCHAR2(500),
  Ѫ��      VARCHAR2(500),
  ��������    VARCHAR2(500),
  ��������    VARCHAR2(500),
  ɫ�����    VARCHAR2(500),
  Ѫѹmax   VARCHAR2(500),
  Ѫѹmin   VARCHAR2(500),
  Ѫ��      VARCHAR2(500),
  ot      VARCHAR2(500),
  pt      VARCHAR2(500),
  hbsag   VARCHAR2(500),
  ��hbs    VARCHAR2(500),
  hbeag   VARCHAR2(500),
  ��hbe    VARCHAR2(500),
  ��hbc    VARCHAR2(500),
  content VARCHAR2(500),
  ������    VARCHAR2(500),
  �����    VARCHAR2(500),
  ��������    VARCHAR2(500)
)
;

prompt
prompt Creating table T_HR_IT_LEVEL
prompt ============================
prompt
create table T_HR_IT_LEVEL
(
  ����    VARCHAR2(500),
  it������ VARCHAR2(500),
  �ȼ�    VARCHAR2(500),
  ����    VARCHAR2(500),
  ȡ������  VARCHAR2(500)
)
;

prompt
prompt Creating table T_HR_LANGUAGE_LEVEL
prompt ==================================
prompt
create table T_HR_LANGUAGE_LEVEL
(
  ����   VARCHAR2(500),
  �������� VARCHAR2(500),
  ������  VARCHAR2(500),
  �ȼ�   VARCHAR2(500),
  ����   VARCHAR2(500),
  ȡ������ VARCHAR2(500),
  ֤������ VARCHAR2(500)
)
;

prompt
prompt Creating table T_HR_MILITARY_SERVICE
prompt ====================================
prompt
create table T_HR_MILITARY_SERVICE
(
  ����  VARCHAR2(500),
  ����  VARCHAR2(500),
  ����  VARCHAR2(500),
  ����  VARCHAR2(500),
  ��ʼ�� VARCHAR2(500),
  ������ VARCHAR2(500)
)
;

prompt
prompt Creating table T_HR_PART_POST_R
prompt ===============================
prompt
create table T_HR_PART_POST_R
(
  part_name VARCHAR2(100) not null,
  post_name VARCHAR2(100) not null
)
;

prompt
prompt Creating table T_HR_PERSONAL_INFO
prompt =================================
prompt
create table T_HR_PERSONAL_INFO
(
  ����    VARCHAR2(500),
  ��˾ǰѧ�� VARCHAR2(500),
  ��˾��ѧ�� VARCHAR2(500),
  �Ա�    VARCHAR2(500),
  ��������  VARCHAR2(500),
  �ڽ�    VARCHAR2(500),
  ����    VARCHAR2(500),
  ����    VARCHAR2(500),
  ����    VARCHAR2(500),
  ������ò  VARCHAR2(500),
  �������  VARCHAR2(500),
  �������  VARCHAR2(500),
  ��ż����  VARCHAR2(500),
  ���֤��  VARCHAR2(500),
  ��סַ   VARCHAR2(500),
  �ʱ�    VARCHAR2(500),
  ����    VARCHAR2(500),
  ����    VARCHAR2(500),
  ��������  VARCHAR2(500),
  �������ڵ� VARCHAR2(500),
  �칫�ҵ绰 VARCHAR2(500),
  ��ͥ�绰  VARCHAR2(500),
  �ֻ�    VARCHAR2(500),
  ����    VARCHAR2(500),
  ������ϵ  VARCHAR2(500),
  ����    VARCHAR2(500),
  �س�    VARCHAR2(500),
  ס����ʽ  VARCHAR2(500)
)
;

prompt
prompt Creating table T_HR_PLURALITY
prompt =============================
prompt
create table T_HR_PLURALITY
(
  ����    VARCHAR2(500),
  ����    VARCHAR2(500),
  ����    VARCHAR2(500),
  ְλ    VARCHAR2(500),
  ְ��    VARCHAR2(500),
  ��Ч����  VARCHAR2(500),
  ���������� VARCHAR2(500),
  ��ְ����  VARCHAR2(500),
  ��ְ����  VARCHAR2(500),
  ��ְְλ  VARCHAR2(500)
)
;

prompt
prompt Creating table T_HR_POST
prompt ========================
prompt
create table T_HR_POST
(
  ְ��id   VARCHAR2(20),
  ְ������   VARCHAR2(50),
  ְ��Ӣ������ VARCHAR2(50),
  ְȺ     VARCHAR2(50)
)
;

prompt
prompt Creating table T_HR_POST_GRADE
prompt ==============================
prompt
create table T_HR_POST_GRADE
(
  ְ��id   VARCHAR2(20),
  ְ������   VARCHAR2(50),
  ְ��Ӣ������ VARCHAR2(50)
)
;

prompt
prompt Creating table T_HR_POST_GRADE_LEVEL
prompt ====================================
prompt
create table T_HR_POST_GRADE_LEVEL
(
  ����id   VARCHAR2(20),
  ��������   VARCHAR2(50),
  ����Ӣ������ VARCHAR2(50)
)
;

prompt
prompt Creating table T_HR_RESIGNATION
prompt ===============================
prompt
create table T_HR_RESIGNATION
(
  ����   VARCHAR2(500),
  ������� VARCHAR2(500),
  ��ְ���� VARCHAR2(500),
  ��ְԭ�� VARCHAR2(500),
  ��ְ���� VARCHAR2(500),
  ��ְ���� VARCHAR2(500),
  ���۹�˾ VARCHAR2(500),
  �������� VARCHAR2(500),
  ��ע   VARCHAR2(500),
  ����   VARCHAR2(100),
  ְλ   VARCHAR2(100),
  ְ��   VARCHAR2(100)
)
;

prompt
prompt Creating table T_PA_BASIC_DATA
prompt ==============================
prompt
create table T_PA_BASIC_DATA
(
  item         VARCHAR2(50),
  field1_value VARCHAR2(50),
  field2_value VARCHAR2(50),
  return_value VARCHAR2(50),
  start_date   VARCHAR2(50),
  end_date     VARCHAR2(50),
  remark       VARCHAR2(500)
)
;

prompt
prompt Creating table T_PA_DAILY_HISTORY
prompt =================================
prompt
create table T_PA_DAILY_HISTORY
(
  pa_date   VARCHAR2(8),
  empid     VARCHAR2(20),
  item_name VARCHAR2(50),
  val       VARCHAR2(100)
)
;

prompt
prompt Creating table T_PA_DAILY_RESULT
prompt ================================
prompt
create table T_PA_DAILY_RESULT
(
  pa_date                   CHAR(10),
  empid                     VARCHAR2(20) not null,
  chinesename               VARCHAR2(40),
  pinyinname                VARCHAR2(40),
  englishname               VARCHAR2(20),
  koreanname                VARCHAR2(40),
  position_code             VARCHAR2(20),
  position                  VARCHAR2(50),
  position_en_name          VARCHAR2(50),
  position_kor_name         VARCHAR2(50),
  duty_code                 VARCHAR2(20),
  duty                      VARCHAR2(50),
  duty_en_name              VARCHAR2(50),
  duty_kor_name             VARCHAR2(50),
  post_code                 VARCHAR2(20),
  post                      VARCHAR2(50),
  post_en_name              VARCHAR2(50),
  post_kor_name             VARCHAR2(50),
  post_group_id             VARCHAR2(10),
  post_group_name           VARCHAR2(50),
  post_group_en_name        VARCHAR2(50),
  post_group_kor_name       VARCHAR2(50),
  post_grade_code           VARCHAR2(20),
  post_grade                VARCHAR2(50),
  post_grade_en_name        VARCHAR2(50),
  post_grade_kor_name       VARCHAR2(50),
  post_coef                 VARCHAR2(20),
  post_grade_level_name     VARCHAR2(50),
  post_grade_level_en_name  VARCHAR2(50),
  post_grade_level_kor_name VARCHAR2(50),
  status_code               VARCHAR2(20),
  status                    VARCHAR2(50),
  status_en_name            VARCHAR2(50),
  status_kor_name           VARCHAR2(50),
  date_started              DATE not null,
  date_left                 DATE,
  end_probation_date        DATE,
  join_type_code            VARCHAR2(20),
  join_type                 VARCHAR2(50),
  join_type_en_name         VARCHAR2(50),
  join_type_kor_name        VARCHAR2(50),
  work_area_id              VARCHAR2(20),
  work_area                 VARCHAR2(50),
  work_area_en_name         VARCHAR2(50),
  work_area_kor_name        VARCHAR2(50),
  cpny_id                   VARCHAR2(10),
  cpny_name                 VARCHAR2(50),
  deptid                    VARCHAR2(20) not null,
  department                VARCHAR2(100),
  dept_en_name              VARCHAR2(100),
  dept_kor_name             VARCHAR2(100),
  deptfullname              VARCHAR2(4000),
  idcard_no                 VARCHAR2(30),
  passport_no               VARCHAR2(40),
  nation_code               VARCHAR2(20),
  nation                    VARCHAR2(50),
  nation_en_name            VARCHAR2(50),
  nation_kor_name           VARCHAR2(50),
  nationality_code          VARCHAR2(20),
  nationality               VARCHAR2(50),
  nationality_en_name       VARCHAR2(50),
  nationality_kor_name      VARCHAR2(50),
  polity_code               VARCHAR2(20),
  polity                    VARCHAR2(50),
  polity_en_name            VARCHAR2(50),
  polity_kor_name           VARCHAR2(50),
  reg_type_code             VARCHAR2(20),
  regtype                   VARCHAR2(50),
  regtype_en_name           VARCHAR2(50),
  regtype_kor_name          VARCHAR2(50),
  bornplace_code            VARCHAR2(20),
  bornplace                 VARCHAR2(50),
  bornplace_en_name         VARCHAR2(50),
  bornplace_kor_name        VARCHAR2(50),
  frequency_duty_d          VARCHAR2(50),
  domestic_biz_trip_d       NUMBER,
  abroad_biz_trip_d         NUMBER,
  weekday_ot_d              NUMBER,
  weekend_ot_d              NUMBER,
  holiday_ot_d              NUMBER,
  absenteeism_d             NUMBER,
  unpaid_leave_d            NUMBER,
  casual_leave_d            NUMBER,
  compassionate_leave_d     NUMBER,
  sick_leave_d              NUMBER,
  card_miss_d               NUMBER,
  tardiness_d               NUMBER,
  truancy_d                 NUMBER,
  insurance_base            NUMBER,
  probation_ration          NUMBER,
  standard_wage             NUMBER,
  post_allowance            NUMBER,
  quality_allowance         NUMBER,
  special_allowance         NUMBER,
  subsidy_allowance         NUMBER,
  variable_pay              NUMBER,
  before_taxable_plus       NUMBER,
  after_taxable_deduct      NUMBER,
  after_taxable_plus        NUMBER,
  before_taxable_deduct     NUMBER,
  base_pay                  NUMBER,
  daily_wages               NUMBER,
  hourly_pay                NUMBER,
  duty_allowance            NUMBER,
  biz_trip_allowance        NUMBER,
  other_allowance           NUMBER,
  holidy_ot_pay             NUMBER,
  weekday_ot_pay            NUMBER,
  weekend_ot_pay            NUMBER,
  ot_pay_totail             NUMBER,
  absenteeism_deduct        NUMBER,
  convert_absent_deduct     NUMBER,
  card_miss_deduct          NUMBER,
  casual_leave_deduct       NUMBER,
  compassionate_deduct      NUMBER,
  unpaid_leave_deduct       NUMBER,
  sick_leave_deduct         NUMBER,
  absent_deduct_total       NUMBER,
  salary_payable            NUMBER
)
;

prompt
prompt Creating table T_PA_INFO_IMP
prompt ============================
prompt
create table T_PA_INFO_IMP
(
  pa_month                CHAR(6),
  area                    VARCHAR2(50),
  empid                   VARCHAR2(20),
  chinesename             VARCHAR2(40),
  pinyinname              VARCHAR2(40),
  englishname             VARCHAR2(20),
  koreanname              VARCHAR2(40),
  deptid                  VARCHAR2(20),
  work_area               VARCHAR2(50),
  cpny_name               VARCHAR2(50),
  department              VARCHAR2(100),
  deptfullname            VARCHAR2(4000),
  part                    VARCHAR2(4000),
  dept_en_name            VARCHAR2(100),
  dept_kor_name           VARCHAR2(100),
  post                    VARCHAR2(50),
  emp_type_name           VARCHAR2(50),
  post_grade              VARCHAR2(50),
  position                VARCHAR2(50),
  status                  VARCHAR2(50),
  biz                     VARCHAR2(4000),
  join_type               VARCHAR2(50),
  date_started            DATE,
  end_probation_date      DATE,
  tenement_month          VARCHAR2(20),
  date_left               DATE,
  nationality             VARCHAR2(50),
  welfare_start_date      DATE,
  tenement_allowance      NUMBER,
  welfare_end_date        DATE,
  dispatch_type           VARCHAR2(50),
  ev_grade_code           VARCHAR2(50),
  scheduled_days          NUMBER,
  vacant_state            NUMBER,
  holiday_days            NUMBER,
  insurance_base          NUMBER,
  medicare_base           NUMBER,
  housing_fund_base       NUMBER,
  cashier_base            NUMBER,
  annual_salary           NUMBER,
  cashier_adjust_range    NUMBER,
  repast_base             NUMBER,
  traffic_base            NUMBER,
  festa_base              NUMBER,
  dollar_rate             NUMBER,
  repast_base2            NUMBER,
  per_retire_ins_deduct   NUMBER,
  praxis_rate             NUMBER,
  probation_rate          NUMBER,
  pending_assign_rate     NUMBER,
  bandh_rate              NUMBER,
  festa_allow_flag        NUMBER,
  bonus_flag              NUMBER,
  bonus_tax_flag          NUMBER,
  biz_trip_allow          NUMBER,
  training_allow          NUMBER,
  instructor_allow        NUMBER,
  congratulate_allow      NUMBER,
  pension                 NUMBER,
  retroactive_pay         NUMBER,
  before_taxable_plus     NUMBER,
  before_taxable_deduct   NUMBER,
  after_taxable_plus      NUMBER,
  after_taxable_deduct    NUMBER,
  evaluate_rate           NUMBER,
  achievement_bonus       NUMBER,
  per_medicare_ins_deduct NUMBER,
  cpy_retire_ins_deduct   NUMBER,
  per_unemp_ins_deduct    NUMBER,
  per_childb_ins_deduct   NUMBER,
  per_accum_fund_deduct   NUMBER,
  cpy_medicare_ins_deduct NUMBER,
  cpy_unemp_ins_deduct    NUMBER,
  cpy_childb_ins_deduct   NUMBER,
  cpy_accum_fund_deduct   NUMBER,
  cpy_integra_ins_deduct  NUMBER,
  eva_bonus_flag          NUMBER,
  base_pay                NUMBER,
  basic_pay               NUMBER,
  cashier_allow           NUMBER,
  daily_pay               NUMBER,
  weekday_ot_pay          NUMBER,
  weekend_ot_pay          NUMBER,
  holidy_ot_pay           NUMBER,
  allow_total             NUMBER,
  monthly_bonus_norm      NUMBER,
  daily_bonus_norm        NUMBER,
  bonus                   NUMBER,
  local_eva_rate          NUMBER,
  eva_bonus               NUMBER,
  bonus_total             NUMBER,
  support_allow           NUMBER,
  tenement_allow          NUMBER,
  repast_allow            NUMBER,
  traffic_allow           NUMBER,
  area_grade              CHAR(50),
  live_allow              NUMBER,
  festa_allow             NUMBER,
  subsidy_total           NUMBER,
  casual_leave_deduct     NUMBER,
  absenteeism_deduct      NUMBER,
  other_allow_total       NUMBER,
  no_pay_leave_deduct     NUMBER,
  att_deduct_total        NUMBER,
  per_retire_ins          NUMBER,
  per_medicare_ins        NUMBER,
  per_unemploy_ins        NUMBER,
  per_childbirth_ins      NUMBER,
  per_accumulation_fund   NUMBER,
  per_ins_total           NUMBER,
  cpy_retire_ins          NUMBER,
  cpy_medicare_ins        NUMBER,
  cpy_unemploy_ins        NUMBER,
  cpy_work_injury_ins     NUMBER,
  cpy_childbirth_ins      NUMBER,
  cpy_accumulation_fund   NUMBER,
  integrative_ins         NUMBER,
  supplement_medicare     NUMBER,
  ins_service_charge      NUMBER,
  cpy_ins_total           NUMBER,
  salary_payable          NUMBER,
  pre_tax_pay             NUMBER,
  tax_benchmark           NUMBER,
  taxable_pay             NUMBER,
  per_bonus               NUMBER,
  avg_bonus               NUMBER,
  tax_ratio               NUMBER,
  bonus_tax_ratio         NUMBER,
  algorithm_meduct        NUMBER,
  bonus_alg_meduct        NUMBER,
  income_tax              NUMBER,
  bonus_tax               NUMBER,
  net_bonus               NUMBER,
  perpaid_allow_deduct    NUMBER,
  other_deduct_total      NUMBER,
  net_pay                 NUMBER
)
;

prompt
prompt Creating table T_PA_INS_RESULT
prompt ==============================
prompt
create table T_PA_INS_RESULT
(
  ins_month          CHAR(6),
  pa_month           CHAR(6),
  ins_formular_month CHAR(6),
  empid              VARCHAR2(20) not null,
  chinesename        VARCHAR2(40),
  englishname        VARCHAR2(20),
  chinese_pinyin     VARCHAR2(40),
  deptname           VARCHAR2(100),
  deptid             VARCHAR2(20) not null,
  hire_date          DATE,
  join_date          DATE,
  end_probation_date DATE,
  left_date          DATE,
  b_item_1           NUMBER,
  b_item_2           NUMBER,
  b_item_3           NUMBER,
  i_ins_13           NUMBER,
  i_ins_14           NUMBER,
  i_ins_15           NUMBER,
  i_ins_16           NUMBER,
  i_ins_17           NUMBER,
  i_ins_18           NUMBER,
  i_ins_19           NUMBER,
  i_ins_20           NUMBER,
  i_ins_21           NUMBER,
  i_ins_22           NUMBER,
  i_ins_1            NUMBER,
  i_ins_2            NUMBER,
  i_ins_3            NUMBER,
  i_ins_4            NUMBER,
  i_ins_5            NUMBER,
  i_ins_6            NUMBER,
  i_ins_7            NUMBER,
  i_ins_8            NUMBER,
  i_ins_9            NUMBER,
  i_ins_10           NUMBER,
  i_ins_11           NUMBER,
  i_ins_12           NUMBER,
  ins_1              NUMBER,
  ins_2              NUMBER,
  ins_4              NUMBER,
  ins_3              NUMBER,
  ins_5              NUMBER,
  ins_6              NUMBER,
  ins_7              NUMBER,
  ins_8              NUMBER,
  ins_9              NUMBER,
  ins_10             NUMBER,
  ins_11             NUMBER,
  ins_12             NUMBER,
  ins_13             NUMBER,
  ins_14             NUMBER,
  ins_15             NUMBER,
  ins_16             NUMBER,
  ins_17             NUMBER,
  ins_18             NUMBER,
  ins_19             NUMBER,
  ins_20             NUMBER,
  ins_50             NUMBER,
  ins_51             NUMBER,
  ins_52             NUMBER,
  ins_53             NUMBER,
  ins_54             NUMBER,
  ins_55             NUMBER,
  ins_56             NUMBER,
  ins_57             NUMBER,
  ins_58             NUMBER,
  ins_59             NUMBER,
  ins_60             NUMBER,
  ins_61             NUMBER
)
;
alter table T_PA_INS_RESULT
  add constraint PK_T_PA_INS_RESULT primary key (EMPID);

prompt
prompt Creating table T_PA_RESULT
prompt ==========================
prompt
create table T_PA_RESULT
(
  pa_month          CHAR(6),
  pa_formular_month CHAR(6),
  empid             VARCHAR2(20) not null,
  chinesename       VARCHAR2(40),
  deptname          VARCHAR2(100),
  status_name       VARCHAR2(50),
  join_date         DATE,
  deptid            VARCHAR2(20),
  status_code       VARCHAR2(20),
  post_name         VARCHAR2(50),
  emp_type_code     VARCHAR2(20),
  emp_type_name     VARCHAR2(50),
  card_no           VARCHAR2(200),
  att_m_112         NUMBER,
  att_m_58          NUMBER,
  att_m_114         NUMBER,
  att_m_8           NUMBER,
  att_m_9           NUMBER,
  att_m_7           NUMBER,
  att_m_6           NUMBER,
  att_m_110         NUMBER,
  att_m_119         NUMBER,
  att_m_113         NUMBER,
  att_m_52          NUMBER,
  att_m_115         NUMBER,
  att_m_53          NUMBER,
  att_m_2           NUMBER,
  att_m_118         NUMBER,
  att_m_12          NUMBER,
  att_m_15          NUMBER,
  att_m_39          NUMBER,
  att_m_117         NUMBER,
  att_m_20          NUMBER,
  i_pa_33           NUMBER,
  i_pa_35           NUMBER,
  i_pa_34           NUMBER,
  i_pa_32           NUMBER,
  i_pa_37           NUMBER,
  i_pa_36           NUMBER,
  pa_151            NUMBER,
  pa_153            NUMBER,
  pa_154            NUMBER,
  pa_155            NUMBER,
  pa_156            NUMBER,
  pa_157            NUMBER,
  pa_158            NUMBER,
  pa_159            NUMBER
)
;
alter table T_PA_RESULT
  add constraint PK_T_PA_RESULT primary key (EMPID);

prompt
prompt Creating table T_SY_CODE
prompt ========================
prompt
create table T_SY_CODE
(
  code_no      NUMBER(10) not null,
  code_id      VARCHAR2(30) not null,
  code_name    VARCHAR2(50) not null,
  code_en_name VARCHAR2(50),
  description  VARCHAR2(200),
  parent_code  VARCHAR2(50),
  depth        NUMBER(10),
  create_date  DATE,
  created_by   VARCHAR2(20),
  update_date  DATE,
  updated_by   VARCHAR2(20),
  orderno      NUMBER(10),
  activity     NUMBER(1),
  cpny_id      VARCHAR2(20)
)
;
comment on table T_SY_CODE
  is 'CODE';
create index T_SY_CODE_PARENT on T_SY_CODE (PARENT_CODE);

prompt
prompt Creating table T_SY_MENU
prompt ========================
prompt
create table T_SY_MENU
(
  menu_no          NUMBER(10) not null,
  menu_code        VARCHAR2(50) not null,
  menu_intro       VARCHAR2(250) not null,
  menu_en_intro    VARCHAR2(250),
  menu_img         VARCHAR2(25),
  menu_parent_code VARCHAR2(50),
  depth            NUMBER(10),
  build_flag       VARCHAR2(20),
  table_name       VARCHAR2(50),
  menu_url         VARCHAR2(250),
  description      VARCHAR2(200),
  create_date      DATE,
  created_by       VARCHAR2(20),
  update_date      DATE,
  updated_by       VARCHAR2(20),
  orderno          NUMBER(10),
  activity         NUMBER(1),
  cpny_id          VARCHAR2(20)
)
;

prompt
prompt Creating table LICENSE
prompt ========================
prompt
create table LICENSE
(
  license_id    NUMBER(10) not null,
  license_key   CHAR(30) not null,
  activate_type NUMBER(1),
  start_date    DATE,
  days          VARCHAR2(100),
  end_date      DATE,
  use_type_id   CHAR(50),
  activity      NUMBER(1),
  status        NUMBER(1),
  cust_id       NUMBER(10)
)
;
comment on column LICENSE.license_id
  is '�ܳ�ID';
comment on column LICENSE.license_key
  is '�ܳ�ID';
comment on column LICENSE.activate_type
  is '�ܳ��������ͣ���0���غ�1���߼��';
comment on column LICENSE.start_date
  is '��Ч����';
comment on column LICENSE.days
  is '��Ч���ڳ���';
comment on column LICENSE.end_date
  is '��������';
comment on column LICENSE.use_type_id
  is 'ʹ�����ͣ������ú���ʽ��';
comment on column LICENSE.cust_id
  is '�ͻ�ID';
  
alter table LICENSE add primary key (LICENSE_ID);

prompt
prompt Creating table WECHAT_MENU
prompt ==========================
prompt
create table WECHAT_MENU
(
  id             NUMBER not null,
  menu_name      VARCHAR2(30),
  menu_type      VARCHAR2(8),
  menu_key       VARCHAR2(50),
  menu_url       VARCHAR2(600),
  parent_menu_id NUMBER,
  created_date   DATE,
  created_by     VARCHAR2(30),
  updated_date   DATE,
  updated_by     VARCHAR2(30),
  reply_text     VARCHAR2(4000)
)
;
comment on column WECHAT_MENU.id
  is '����id';
comment on column WECHAT_MENU.menu_name
  is '�˵�����';
comment on column WECHAT_MENU.menu_type
  is '����';
comment on column WECHAT_MENU.menu_key
  is 'click���͵�keyֵ';
comment on column WECHAT_MENU.menu_url
  is 'view���͵����ӵ�ַ';
comment on column WECHAT_MENU.parent_menu_id
  is '���˵�id';
comment on column WECHAT_MENU.reply_text
  is '�Զ��ظ�����';
alter table WECHAT_MENU
  add constraint WECHAT_MENU_KEY primary key (ID);

prompt
prompt Creating table WECHAT_PARAM
prompt ===========================
prompt
create table WECHAT_PARAM
(
  id           NUMBER not null,
  wechat_id    VARCHAR2(50),
  app_id       VARCHAR2(30),
  app_secret   VARCHAR2(40),
  created_date DATE,
  created_by   VARCHAR2(30),
  updated_date DATE,
  updated_by   VARCHAR2(30)
)
;
comment on column WECHAT_PARAM.id
  is '����id';
comment on column WECHAT_PARAM.wechat_id
  is '��ҵ΢�ź�';
comment on column WECHAT_PARAM.app_id
  is 'appId';
comment on column WECHAT_PARAM.app_secret
  is 'appSecret';
alter table WECHAT_PARAM
  add constraint WECHAT_PARAM_KEY primary key (ID);

spool off
exit;