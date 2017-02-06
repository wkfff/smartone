-------------------------------------------
-- Export file for user             --
-- Created by Wzh on 2014/2/27, 12:57:16 --
-------------------------------------------

set define off
spool SEQUENCE.log

prompt
prompt Creating sequence ACTION_INFO_SEQ
prompt =================================
prompt
create sequence ACTION_INFO_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 40
increment by 1
cache 20;

prompt
prompt Creating sequence AR_ANNUAL_SEQ
prompt ===============================
prompt
create sequence AR_ANNUAL_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 3175
increment by 1
nocache;

prompt
prompt Creating sequence AR_APPLY_RESULT_SEQ
prompt =====================================
prompt
create sequence AR_APPLY_RESULT_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1158
increment by 1
nocache;

prompt
prompt Creating sequence AR_CARD_EMP_SEQ
prompt =================================
prompt
create sequence AR_CARD_EMP_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 70
increment by 1
nocache;

prompt
prompt Creating sequence AR_CARD_VISIT_SEQ
prompt ===================================
prompt
create sequence AR_CARD_VISIT_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence AR_CONDITION_SEQ
prompt ==================================
prompt
create sequence AR_CONDITION_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence AR_DETAIL_LOCK_SEQ
prompt ====================================
prompt
create sequence AR_DETAIL_LOCK_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 818
increment by 1
nocache;

prompt
prompt Creating sequence AR_DETAIL_SEQ
prompt ===============================
prompt
create sequence AR_DETAIL_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1842741
increment by 1
nocache;

prompt
prompt Creating sequence AR_DETAIL_TEMP_SEQ
prompt ====================================
prompt
create sequence AR_DETAIL_TEMP_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1844066
increment by 1
nocache;

prompt
prompt Creating sequence AR_DYNAMIC_GROUP_SEQ
prompt ======================================
prompt
create sequence AR_DYNAMIC_GROUP_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 25
increment by 1
nocache;

prompt
prompt Creating sequence AR_EATERY_RECORDS_SEQ
prompt =======================================
prompt
create sequence AR_EATERY_RECORDS_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence AR_EMP_CARD_TEMP_SEQ
prompt ======================================
prompt
create sequence AR_EMP_CARD_TEMP_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence AR_GROUP_CONDITION_SEQ
prompt ========================================
prompt
create sequence AR_GROUP_CONDITION_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 7
increment by 1
nocache;

prompt
prompt Creating sequence AR_GROUP_SEQ
prompt ==============================
prompt
create sequence AR_GROUP_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence AR_ITEM_PARAM_SEQ
prompt ===================================
prompt
create sequence AR_ITEM_PARAM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 441
increment by 1
cache 20;

prompt
prompt Creating sequence AR_ITEM_SEQ
prompt =============================
prompt
create sequence AR_ITEM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 56
increment by 1
nocache;

prompt
prompt Creating sequence AR_MAC_RECORD_SEQ
prompt ===================================
prompt
create sequence AR_MAC_RECORD_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 7202761
increment by 1
nocache;

prompt
prompt Creating sequence AR_RECORDS_SEQ
prompt ================================
prompt
create sequence AR_RECORDS_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 10
increment by 1
nocache;

prompt
prompt Creating sequence AR_SCHEDULE_GROUP_ITEM_SEQ
prompt ============================================
prompt
create sequence AR_SCHEDULE_GROUP_ITEM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence AR_SCHEDULE_GROUP_SEQ
prompt =======================================
prompt
create sequence AR_SCHEDULE_GROUP_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence AR_SCHEDULE_SEQ
prompt =================================
prompt
create sequence AR_SCHEDULE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 2153
increment by 1
nocache;

prompt
prompt Creating sequence AR_SHIFT010_SEQ
prompt =================================
prompt
create sequence AR_SHIFT010_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 39
increment by 1
nocache;

prompt
prompt Creating sequence AR_SHIFT020_SEQ
prompt =================================
prompt
create sequence AR_SHIFT020_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 56
increment by 1
nocache;

prompt
prompt Creating sequence AR_SHIFT_GROUP_EMP_SEQ
prompt ========================================
prompt
create sequence AR_SHIFT_GROUP_EMP_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 38
increment by 1
nocache;

prompt
prompt Creating sequence AR_SHIFT_GROUP_SEQ
prompt ====================================
prompt
create sequence AR_SHIFT_GROUP_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 13
increment by 1
nocache;

prompt
prompt Creating sequence AR_STATISTIC_DATE_SEQ
prompt =======================================
prompt
create sequence AR_STATISTIC_DATE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 31
increment by 1
nocache;

prompt
prompt Creating sequence AR_STA_FORMULAR_SEQ
prompt =====================================
prompt
create sequence AR_STA_FORMULAR_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 146
increment by 1
nocache;

prompt
prompt Creating sequence AR_STA_ITEM_SEQ
prompt =================================
prompt
create sequence AR_STA_ITEM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 121
increment by 1
nocache;

prompt
prompt Creating sequence AR_SUPERVISOR_INFO_SEQ
prompt ========================================
prompt
create sequence AR_SUPERVISOR_INFO_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 4034
increment by 1
nocache;

prompt
prompt Creating sequence AR_SUPERVISOR_SEQ
prompt ===================================
prompt
create sequence AR_SUPERVISOR_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 127
increment by 1
nocache;

prompt
prompt Creating sequence AR_VACATION_MASTER_SEQ
prompt ========================================
prompt
create sequence AR_VACATION_MASTER_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 22
increment by 1
nocache;

prompt
prompt Creating sequence AR_VAC_EMP_SEQ
prompt ================================
prompt
create sequence AR_VAC_EMP_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 5856
increment by 1
nocache;

prompt
prompt Creating sequence ASS_ASSET_INFO_SEQ
prompt ====================================
prompt
create sequence ASS_ASSET_INFO_SEQ
minvalue 0
maxvalue 1000000
start with 183
increment by 1
cache 20;

prompt
prompt Creating sequence BOM_ITEM_SEQ
prompt ==============================
prompt
create sequence BOM_ITEM_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 303
increment by 1
cache 20;

prompt
prompt Creating sequence BOM_SEQ
prompt =========================
prompt
create sequence BOM_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 161
increment by 1
cache 20;

prompt
prompt Creating sequence BP_BASIC_INFO_SEQ
prompt ===================================
prompt
create sequence BP_BASIC_INFO_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 500
increment by 1
nocache;

prompt
prompt Creating sequence CHANGENO_SEQ
prompt ==============================
prompt
create sequence CHANGENO_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 42
increment by 1
cache 20;

prompt
prompt Creating sequence CHA_BASIC_INFO_SEQ
prompt ====================================
prompt
create sequence CHA_BASIC_INFO_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 19
increment by 1
nocache;

prompt
prompt Creating sequence CHA_BUSINESS_INFO_SEQ
prompt =======================================
prompt
create sequence CHA_BUSINESS_INFO_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 14
increment by 1
nocache;

prompt
prompt Creating sequence CHA_CONTACT_INFO_SEQ
prompt ======================================
prompt
create sequence CHA_CONTACT_INFO_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 15
increment by 1
nocache;

prompt
prompt Creating sequence CLASS_CODE_ID
prompt ===============================
prompt
create sequence CLASS_CODE_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence CUST_ACTION_SEQ
prompt =================================
prompt
create sequence CUST_ACTION_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 421
increment by 1
cache 20;

prompt
prompt Creating sequence CUST_APPENDIX_INFO_SEQ
prompt ========================================
prompt
create sequence CUST_APPENDIX_INFO_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 50
increment by 1
cache 20;

prompt
prompt Creating sequence CUST_CONTACTS_SEQ
prompt ===================================
prompt
create sequence CUST_CONTACTS_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 241
increment by 1
cache 20;

prompt
prompt Creating sequence CUST_RECEIVER_SEQ
prompt ===================================
prompt
create sequence CUST_RECEIVER_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 281
increment by 1
cache 20;

prompt
prompt Creating sequence CUST_SEQ
prompt ==========================
prompt
create sequence CUST_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1020
increment by 1
cache 20;

prompt
prompt Creating sequence C_RESULT_NO_SEQ
prompt =================================
prompt
create sequence C_RESULT_NO_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence DOC_FILE_SEQ
prompt ==============================
prompt
create sequence DOC_FILE_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 501
increment by 1
cache 20;

prompt
prompt Creating sequence DOC_SEQ
prompt =========================
prompt
create sequence DOC_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 341
increment by 1
cache 20;

prompt
prompt Creating sequence DOC_TYPE_SEQ
prompt ==============================
prompt
create sequence DOC_TYPE_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 170
increment by 1
cache 20;

prompt
prompt Creating sequence EMAIL_SND_SEQ
prompt ===============================
prompt
create sequence EMAIL_SND_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 143
increment by 1
nocache;

prompt
prompt Creating sequence EMP_D_ALLW_NO_SEQ
prompt ===================================
prompt
create sequence EMP_D_ALLW_NO_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence EMP_S_BONUS_NO_SEQ
prompt ====================================
prompt
create sequence EMP_S_BONUS_NO_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence ESS_AFFIRM_SEQ
prompt ================================
prompt
create sequence ESS_AFFIRM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 163
increment by 1
nocache;

prompt
prompt Creating sequence ESS_APPLY_BT_SEQ
prompt ==================================
prompt
create sequence ESS_APPLY_BT_SEQ
minvalue 0
maxvalue 999999999999999999999999
start with 361
increment by 1
cache 20;

prompt
prompt Creating sequence ESS_APPLY_CARD_SEQ
prompt ====================================
prompt
create sequence ESS_APPLY_CARD_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 120
increment by 1
nocache;

prompt
prompt Creating sequence ESS_APPLY_ETN_SEQ
prompt ===================================
prompt
create sequence ESS_APPLY_ETN_SEQ
minvalue 0
maxvalue 999999999999999999999999
start with 20
increment by 1
cache 20;

prompt
prompt Creating sequence ESS_APPLY_EXP_SEQ
prompt ===================================
prompt
create sequence ESS_APPLY_EXP_SEQ
minvalue 0
maxvalue 999999999999999999999999
start with 341
increment by 1
cache 20;

prompt
prompt Creating sequence ESS_APPLY_GROUP_SEQ
prompt =====================================
prompt
create sequence ESS_APPLY_GROUP_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 41134
increment by 1
nocache;

prompt
prompt Creating sequence ESS_APPLY_LEAVE_SEQ
prompt =====================================
prompt
create sequence ESS_APPLY_LEAVE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 392
increment by 1
nocache;

prompt
prompt Creating sequence ESS_APPLY_OT_SEQ
prompt ==================================
prompt
create sequence ESS_APPLY_OT_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 145
increment by 1
nocache;

prompt
prompt Creating sequence ESS_APPLY_TOOL_SEQ
prompt ====================================
prompt
create sequence ESS_APPLY_TOOL_SEQ
minvalue 1
maxvalue 99999999999999999
start with 342
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence ESS_APPLY_WH_SEQ
prompt ==================================
prompt
create sequence ESS_APPLY_WH_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 283
increment by 1
nocache;

prompt
prompt Creating sequence ESS_ASSESSOR_SEQ
prompt ==================================
prompt
create sequence ESS_ASSESSOR_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence ESS_ASSESS_RELATION_SEQ
prompt =========================================
prompt
create sequence ESS_ASSESS_RELATION_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence ESS_CARDAPPLY_SEQ
prompt ===================================
prompt
create sequence ESS_CARDAPPLY_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 27
increment by 1
nocache;

prompt
prompt Creating sequence ESS_CONFIRMOR_SEQ
prompt ===================================
prompt
create sequence ESS_CONFIRMOR_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence ESS_CONFIRM_RELATION_SEQ
prompt ==========================================
prompt
create sequence ESS_CONFIRM_RELATION_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence ESS_FAMILY_SEQ
prompt ================================
prompt
create sequence ESS_FAMILY_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence ESS_HEALTH_SEQ
prompt ================================
prompt
create sequence ESS_HEALTH_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence ESS_LANGVAGE_SEQ
prompt ==================================
prompt
create sequence ESS_LANGVAGE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence ESS_LEAVE_PARAMETER_SEQ
prompt =========================================
prompt
create sequence ESS_LEAVE_PARAMETER_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 201
increment by 1
nocache;

prompt
prompt Creating sequence ESS_LEAVE_SEQ
prompt ===============================
prompt
create sequence ESS_LEAVE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence ESS_MATCHAPPLY_SEQ
prompt ====================================
prompt
create sequence ESS_MATCHAPPLY_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence ESS_MILITARY_SEQ
prompt ==================================
prompt
create sequence ESS_MILITARY_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence ESS_OT_PARAMETER_SEQ
prompt ======================================
prompt
create sequence ESS_OT_PARAMETER_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 203
increment by 1
nocache;

prompt
prompt Creating sequence ESS_PRODUCTION_ORDER_SEQ
prompt ==========================================
prompt
create sequence ESS_PRODUCTION_ORDER_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 121
increment by 1
cache 20;

prompt
prompt Creating sequence ESS_PROJECT_SEQ
prompt =================================
prompt
create sequence ESS_PROJECT_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1046
increment by 1
nocache;

prompt
prompt Creating sequence ESS_QUALIFICATION_SEQ
prompt =======================================
prompt
create sequence ESS_QUALIFICATION_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence ESS_TOLERENCE_SEQ
prompt ===================================
prompt
create sequence ESS_TOLERENCE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence ETN_CLASS_CODE_ID
prompt ===================================
prompt
create sequence ETN_CLASS_CODE_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 366
increment by 1
nocache;

prompt
prompt Creating sequence ETN_COMPANY_SEQ
prompt =================================
prompt
create sequence ETN_COMPANY_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 14
increment by 1
nocache;

prompt
prompt Creating sequence ETN_LETTER_SEQ
prompt ================================
prompt
create sequence ETN_LETTER_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 26
increment by 1
nocache;

prompt
prompt Creating sequence ETN_PLAN_KINDS_SEQ
prompt ====================================
prompt
create sequence ETN_PLAN_KINDS_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 143
increment by 1
nocache;

prompt
prompt Creating sequence ETN_PLAN_SEQ
prompt ==============================
prompt
create sequence ETN_PLAN_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 331
increment by 1
nocache;

prompt
prompt Creating sequence ETN_PROTOCOL_SEQ
prompt ==================================
prompt
create sequence ETN_PROTOCOL_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 23
increment by 1
nocache;

prompt
prompt Creating sequence ETN_RESULT_SEQ
prompt ================================
prompt
create sequence ETN_RESULT_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1132
increment by 1
nocache;

prompt
prompt Creating sequence ETN_SEQ_STANDARD
prompt ==================================
prompt
create sequence ETN_SEQ_STANDARD
minvalue 1
maxvalue 9999999999999999999
start with 301
increment by 1
cache 20
cycle;

prompt
prompt Creating sequence ETN_TEACHER_SEQ
prompt =================================
prompt
create sequence ETN_TEACHER_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 62
increment by 1
nocache;

prompt
prompt Creating sequence ETN_TEACHINGMATERIAL_SEQ
prompt ==========================================
prompt
create sequence ETN_TEACHINGMATERIAL_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 382
increment by 1
nocache;

prompt
prompt Creating sequence ETN_YEAR_PLAN_SEQ
prompt ===================================
prompt
create sequence ETN_YEAR_PLAN_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 339
increment by 1
nocache;

prompt
prompt Creating sequence EVA_ADD_SUB_SEQ
prompt =================================
prompt
create sequence EVA_ADD_SUB_SEQ
minvalue 0
maxvalue 999999999999999999
start with 169
increment by 1
cache 20;

prompt
prompt Creating sequence EVA_EDU_NORM_SEQ
prompt ==================================
prompt
create sequence EVA_EDU_NORM_SEQ
minvalue 0
maxvalue 9999999999999999999
start with 161
increment by 1
cache 20;

prompt
prompt Creating sequence EVA_EXPERIENCE_NORM_SEQ
prompt =========================================
prompt
create sequence EVA_EXPERIENCE_NORM_SEQ
minvalue 0
maxvalue 99999999999999999999
start with 97
increment by 1
cache 20;

prompt
prompt Creating sequence EVA_FACT_ACHIEVEMENT_SEQ
prompt ==========================================
prompt
create sequence EVA_FACT_ACHIEVEMENT_SEQ
minvalue 1
maxvalue 99999999999999999
start with 1061
increment by 1
cache 20;

prompt
prompt Creating sequence EVA_ITEM_DETAIL_SEQ
prompt =====================================
prompt
create sequence EVA_ITEM_DETAIL_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 37860
increment by 1
nocache;

prompt
prompt Creating sequence EVA_KPI_BEVALIDATER_SEQ
prompt =========================================
prompt
create sequence EVA_KPI_BEVALIDATER_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence EVA_KPI_INFO_SEQ
prompt ==================================
prompt
create sequence EVA_KPI_INFO_SEQ
minvalue 1
maxvalue 99999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence EVA_KPI_ITEM_SEQ
prompt ==================================
prompt
create sequence EVA_KPI_ITEM_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 70
increment by 1
nocache;

prompt
prompt Creating sequence EVA_KPI_SCORE_SEQ
prompt ===================================
prompt
create sequence EVA_KPI_SCORE_SEQ
minvalue 1
maxvalue 99999999999
start with 61
increment by 1
cache 20;

prompt
prompt Creating sequence EVA_KPI_TYPE_SEQ
prompt ==================================
prompt
create sequence EVA_KPI_TYPE_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 20
increment by 1
nocache;

prompt
prompt Creating sequence EVA_PERIOD_SEQ
prompt ================================
prompt
create sequence EVA_PERIOD_SEQ
minvalue 0
maxvalue 999999999999999999
start with 48
increment by 1
cache 20;

prompt
prompt Creating sequence EVA_PERIOD_TYPE_SEQ
prompt =====================================
prompt
create sequence EVA_PERIOD_TYPE_SEQ
minvalue 0
maxvalue 999999999999999999
start with 69
increment by 1
cache 20;

prompt
prompt Creating sequence EVE_EMP_ITEM_SEQ
prompt ==================================
prompt
create sequence EVE_EMP_ITEM_SEQ
minvalue 0
maxvalue 999999999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence EVE_WORK_PLAN_SEQ
prompt ===================================
prompt
create sequence EVE_WORK_PLAN_SEQ
minvalue 0
maxvalue 999999999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence EVJ_ITEM_DETAIL_SEQ
prompt =====================================
prompt
create sequence EVJ_ITEM_DETAIL_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence EV_ACHIVE_ABILITY_NORM_SEQ
prompt ============================================
prompt
create sequence EV_ACHIVE_ABILITY_NORM_SEQ
minvalue 1
maxvalue 99999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence EV_ACHIVE_DEPT_NORM_SEQ
prompt =========================================
prompt
create sequence EV_ACHIVE_DEPT_NORM_SEQ
minvalue 1
maxvalue 999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence EV_ADD_SUBTRACTION_SEQ
prompt ========================================
prompt
create sequence EV_ADD_SUBTRACTION_SEQ
minvalue 0
maxvalue 99999999999999999
start with 401
increment by 1
cache 20;

prompt
prompt Creating sequence EV_PERIOD_ID_SEQ
prompt ==================================
prompt
create sequence EV_PERIOD_ID_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 2
increment by 1
nocache;

prompt
prompt Creating sequence EXP_INSIDE_HISTORY_NO_SEQ
prompt ===========================================
prompt
create sequence EXP_INSIDE_HISTORY_NO_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1334
increment by 1
nocache;

prompt
prompt Creating sequence FICO_ACCOUNT_SEQ
prompt ==================================
prompt
create sequence FICO_ACCOUNT_SEQ
minvalue 1
maxvalue 999999999
start with 41
increment by 1
cache 20;

prompt
prompt Creating sequence FICO_INCOME_INVOICE_POSI_SEQ
prompt ==============================================
prompt
create sequence FICO_INCOME_INVOICE_POSI_SEQ
minvalue 1
maxvalue 9999999999
start with 61
increment by 1
cache 20;

prompt
prompt Creating sequence FICO_INCOME_INVOICE_SEQ
prompt =========================================
prompt
create sequence FICO_INCOME_INVOICE_SEQ
minvalue 1
maxvalue 9999999999
start with 61
increment by 1
cache 20;

prompt
prompt Creating sequence FICO_INVOICE_POSITION_SEQ
prompt ===========================================
prompt
create sequence FICO_INVOICE_POSITION_SEQ
minvalue 1
maxvalue 9999999999
start with 41
increment by 1
cache 20;

prompt
prompt Creating sequence FICO_INVOICE_SEQ
prompt ==================================
prompt
create sequence FICO_INVOICE_SEQ
minvalue 1
maxvalue 9999999999
start with 81
increment by 1
cache 20;

prompt
prompt Creating sequence HIBERNATE_SEQUENCE
prompt ====================================
prompt
create sequence HIBERNATE_SEQUENCE
minvalue 1
maxvalue 999999999999999999999999999
start with 189
increment by 1
nocache;

prompt
prompt Creating sequence HR_ACT_BUSINESS_SEQ
prompt =====================================
prompt
create sequence HR_ACT_BUSINESS_SEQ
minvalue 1
maxvalue 99999999999999999999
start with 101
increment by 1
cache 20
order;

prompt
prompt Creating sequence HR_ADDITIONAL_SEQ
prompt ===================================
prompt
create sequence HR_ADDITIONAL_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 6
increment by 1
nocache;

prompt
prompt Creating sequence HR_ADIN_SEQ
prompt =============================
prompt
create sequence HR_ADIN_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 45
increment by 1
nocache;

prompt
prompt Creating sequence HR_CNPY_SEQ
prompt =============================
prompt
create sequence HR_CNPY_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence HR_COLUMN_SEQ
prompt ===============================
prompt
create sequence HR_COLUMN_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence HR_CONTRACT_APPENDIX_SEQ
prompt ==========================================
prompt
create sequence HR_CONTRACT_APPENDIX_SEQ
minvalue 1
maxvalue 99999999999999999
start with 61
increment by 1
cache 20
cycle
order;

prompt
prompt Creating sequence HR_CONTRACT_SEQ
prompt =================================
prompt
create sequence HR_CONTRACT_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1528
increment by 1
nocache;

prompt
prompt Creating sequence HR_DEPARTMENT_SEQ
prompt ===================================
prompt
create sequence HR_DEPARTMENT_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 578
increment by 1
nocache;

prompt
prompt Creating sequence HR_DEPT_SEQ
prompt =============================
prompt
create sequence HR_DEPT_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1405
increment by 1
nocache;

prompt
prompt Creating sequence HR_DISPATCH_SEQ
prompt =================================
prompt
create sequence HR_DISPATCH_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 160
increment by 1
nocache;

prompt
prompt Creating sequence HR_DOCUMENT_SEQ
prompt =================================
prompt
create sequence HR_DOCUMENT_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 11
increment by 1
nocache;

prompt
prompt Creating sequence HR_EDUCATION_SEQ
prompt ==================================
prompt
create sequence HR_EDUCATION_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1527
increment by 1
nocache;

prompt
prompt Creating sequence HR_EMP_PA_INFO_SEQ
prompt ====================================
prompt
create sequence HR_EMP_PA_INFO_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 514
increment by 1
cache 20;

prompt
prompt Creating sequence HR_EMP_POSTM_SEQ
prompt ==================================
prompt
create sequence HR_EMP_POSTM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 161
increment by 1
cache 20;

prompt
prompt Creating sequence HR_EMP_STATUS_HISTORY_SEQ
prompt ===========================================
prompt
create sequence HR_EMP_STATUS_HISTORY_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 9484430
increment by 1
cache 20;


prompt
prompt Creating sequence HR_EXPERIENCE_INSIDE_SEQ
prompt ==========================================
prompt
create sequence HR_EXPERIENCE_INSIDE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 3887
increment by 1
nocache
order;

prompt
prompt Creating sequence HR_FAMILY_SEQ
prompt ===============================
prompt
create sequence HR_FAMILY_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 3618
increment by 1
nocache;

prompt
prompt Creating sequence HR_FAM_SEQ
prompt ============================
prompt
create sequence HR_FAM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 3557
increment by 1
nocache;

prompt
prompt Creating sequence HR_FILE_SEQ
prompt =============================
prompt
create sequence HR_FILE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence HR_GRADESTANDARD_SEQ
prompt ======================================
prompt
create sequence HR_GRADESTANDARD_SEQ
minvalue 1
maxvalue 999999999999999999999999
start with 181
increment by 1
cache 20;

prompt
prompt Creating sequence HR_GRADE_LEVEL_SEQ
prompt ====================================
prompt
create sequence HR_GRADE_LEVEL_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence HR_GRADE_SEQ
prompt ==============================
prompt
create sequence HR_GRADE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 122
increment by 1
nocache;

prompt
prompt Creating sequence HR_GROUP_SEQ
prompt ==============================
prompt
create sequence HR_GROUP_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 2
increment by 1
nocache;

prompt
prompt Creating sequence HR_HEALTH_SEQ
prompt ===============================
prompt
create sequence HR_HEALTH_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 803
increment by 1
nocache;

prompt
prompt Creating sequence HR_INTERVIEW_SEQ
prompt ==================================
prompt
create sequence HR_INTERVIEW_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 7
increment by 1
nocache;

prompt
prompt Creating sequence HR_IT_LEVEL_SEQ
prompt =================================
prompt
create sequence HR_IT_LEVEL_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 14
increment by 1
nocache;

prompt
prompt Creating sequence HR_LANGUAGE_LEVEL_SEQ
prompt =======================================
prompt
create sequence HR_LANGUAGE_LEVEL_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 740
increment by 1
nocache;

prompt
prompt Creating sequence HR_MS_SEQ
prompt ===========================
prompt
create sequence HR_MS_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 47
increment by 1
nocache;

prompt
prompt Creating sequence HR_PLURALITY_SEQ
prompt ==================================
prompt
create sequence HR_PLURALITY_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 162
increment by 1
nocache;

prompt
prompt Creating sequence HR_POSITION_SEQ
prompt =================================
prompt
create sequence HR_POSITION_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 119
increment by 1
nocache;

prompt
prompt Creating sequence HR_POST_COLUMN_SEQ
prompt ====================================
prompt
create sequence HR_POST_COLUMN_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 5
increment by 1
nocache;

prompt
prompt Creating sequence HR_POST_GRADE_SEQ
prompt ===================================
prompt
create sequence HR_POST_GRADE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 27
increment by 1
nocache;

prompt
prompt Creating sequence HR_POST_GROUP_SEQ
prompt ===================================
prompt
create sequence HR_POST_GROUP_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 129
increment by 1
nocache;

prompt
prompt Creating sequence HR_POST_LEVEL_SEQ
prompt ===================================
prompt
create sequence HR_POST_LEVEL_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 14
increment by 1
nocache;

prompt
prompt Creating sequence HR_POST_RECORDS_SEQ
prompt =====================================
prompt
create sequence HR_POST_RECORDS_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 183
increment by 1
nocache;

prompt
prompt Creating sequence HR_POST_SEQ
prompt =============================
prompt
create sequence HR_POST_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 101
increment by 1
nocache;

prompt
prompt Creating sequence HR_PUNISHMENT_SEQ
prompt ===================================
prompt
create sequence HR_PUNISHMENT_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 79
increment by 1
nocache;

prompt
prompt Creating sequence HR_QUALIFICATION_SEQ
prompt ======================================
prompt
create sequence HR_QUALIFICATION_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1278
increment by 1
nocache;

prompt
prompt Creating sequence HR_RESIGN_SEQ
prompt ===============================
prompt
create sequence HR_RESIGN_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 277
increment by 1
nocache;

prompt
prompt Creating sequence HR_REWARD_SEQ
prompt ===============================
prompt
create sequence HR_REWARD_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 165
increment by 1
nocache;

prompt
prompt Creating sequence HR_STATISTIC_SEQ
prompt ==================================
prompt
create sequence HR_STATISTIC_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence HR_STUDY_SEQ
prompt ==============================
prompt
create sequence HR_STUDY_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 7
increment by 1
nocache;

prompt
prompt Creating sequence HR_SUSPENSION_SEQ
prompt ===================================
prompt
create sequence HR_SUSPENSION_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 39
increment by 1
nocache;

prompt
prompt Creating sequence HR_TRAIN_IN_SEQ
prompt =================================
prompt
create sequence HR_TRAIN_IN_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 8
increment by 1
nocache;

prompt
prompt Creating sequence HR_TRAIN_OUT_SEQ
prompt ==================================
prompt
create sequence HR_TRAIN_OUT_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 118
increment by 1
nocache;

prompt
prompt Creating sequence HR_TRANS_NO_SEQ
prompt =================================
prompt
create sequence HR_TRANS_NO_SEQ
minvalue 1
maxvalue 999999999999999999999
start with 16672
increment by 1
cache 20
order;

prompt
prompt Creating sequence HR_WORK_EXPERIENCE_SEQ
prompt ========================================
prompt
create sequence HR_WORK_EXPERIENCE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 565
increment by 1
nocache;

prompt
prompt Creating sequence INFO_FIELD_SEQ
prompt ================================
prompt
create sequence INFO_FIELD_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence INFO_TABLE_SEQ
prompt ================================
prompt
create sequence INFO_TABLE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence INFO_TYPE_SEQ
prompt ===============================
prompt
create sequence INFO_TYPE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence I_AR_ANNUAL_SEQ
prompt =================================
prompt
create sequence I_AR_ANNUAL_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence MAT_INFO_SEQ
prompt ==============================
prompt
create sequence MAT_INFO_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 380
increment by 1
cache 20;

prompt
prompt Creating sequence MAT_STOCK_INFO_SEQ
prompt ====================================
prompt
create sequence MAT_STOCK_INFO_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 200
increment by 1
cache 20;

prompt
prompt Creating sequence MAT_STOCK_RECORD_SEQ
prompt ======================================
prompt
create sequence MAT_STOCK_RECORD_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 200
increment by 1
cache 20;

prompt
prompt Creating sequence MAT_STORAGE_INFO_SEQ
prompt ======================================
prompt
create sequence MAT_STORAGE_INFO_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 240
increment by 1
cache 20;

prompt
prompt Creating sequence MOBILE_ADV_SEQ
prompt ================================
prompt
create sequence MOBILE_ADV_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 25
increment by 1
nocache;

prompt
prompt Creating sequence MOBILE_AREA_SEQ
prompt =================================
prompt
create sequence MOBILE_AREA_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 12
increment by 1
nocache;

prompt
prompt Creating sequence MOBILE_INVITATION_SEQ
prompt =======================================
prompt
create sequence MOBILE_INVITATION_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 31
increment by 1
nocache;

prompt
prompt Creating sequence ORDID_SEQ
prompt ===========================
prompt
create sequence ORDID_SEQ
minvalue 1
maxvalue 999999999
start with 166
increment by 1
nocache;

prompt
prompt Creating sequence ORD_ORDER_INFO_SEQ
prompt ====================================
prompt
create sequence ORD_ORDER_INFO_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 10
increment by 1
nocache;

prompt
prompt Creating sequence PA_ALLOWANCE_SEQ
prompt ==================================
prompt
create sequence PA_ALLOWANCE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence PA_BASIC_DATA_SEQ
prompt ===================================
prompt
create sequence PA_BASIC_DATA_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 23
increment by 1
cache 20;

prompt
prompt Creating sequence PA_BASIC_ITEM_SEQ
prompt ===================================
prompt
create sequence PA_BASIC_ITEM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 8
increment by 1
nocache;

prompt
prompt Creating sequence PA_BONUS_EMP_SEQ
prompt ==================================
prompt
create sequence PA_BONUS_EMP_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 23
increment by 1
nocache;

prompt
prompt Creating sequence PA_BONUS_FORMULAR_SEQ
prompt =======================================
prompt
create sequence PA_BONUS_FORMULAR_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 19
increment by 1
nocache;

prompt
prompt Creating sequence PA_BONUS_ITEM_SEQ
prompt ===================================
prompt
create sequence PA_BONUS_ITEM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 6
increment by 1
nocache;

prompt
prompt Creating sequence PA_BONUS_PARAM_DATA_SEQ
prompt =========================================
prompt
create sequence PA_BONUS_PARAM_DATA_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 6
increment by 1
nocache;

prompt
prompt Creating sequence PA_BONUS_PARAM_ITEM_SEQ
prompt =========================================
prompt
create sequence PA_BONUS_PARAM_ITEM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 7
increment by 1
nocache;

prompt
prompt Creating sequence PA_BONUS_TYPE_SEQ
prompt ===================================
prompt
create sequence PA_BONUS_TYPE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 6
increment by 1
nocache;

prompt
prompt Creating sequence PA_DAILY_FORMULAR_SEQ
prompt =======================================
prompt
create sequence PA_DAILY_FORMULAR_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence PA_DAILY_ITEM_SEQ
prompt ===================================
prompt
create sequence PA_DAILY_ITEM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence PA_EXPENSE_SEQ
prompt ================================
prompt
create sequence PA_EXPENSE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 14
increment by 1
nocache;

prompt
prompt Creating sequence PA_FORMULAR_SEQ
prompt =================================
prompt
create sequence PA_FORMULAR_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 949
increment by 1
nocache;

prompt
prompt Creating sequence PA_GIFT_BONUS_SEQ
prompt ===================================
prompt
create sequence PA_GIFT_BONUS_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence PA_INS_EMP_SEQ
prompt ================================
prompt
create sequence PA_INS_EMP_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 85
increment by 1
nocache;

prompt
prompt Creating sequence PA_INS_FORMULAR_SEQ
prompt =====================================
prompt
create sequence PA_INS_FORMULAR_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 63
increment by 1
nocache;

prompt
prompt Creating sequence PA_INS_ITEM_SEQ
prompt =================================
prompt
create sequence PA_INS_ITEM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 62
increment by 1
nocache;

prompt
prompt Creating sequence PA_INS_PARAM_DATA_SEQ
prompt =======================================
prompt
create sequence PA_INS_PARAM_DATA_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 80
increment by 1
cache 20;

prompt
prompt Creating sequence PA_INS_PARAM_ITEM_SEQ
prompt =======================================
prompt
create sequence PA_INS_PARAM_ITEM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 23
increment by 1
nocache;

prompt
prompt Creating sequence PA_ITEM_SEQ
prompt =============================
prompt
create sequence PA_ITEM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 160
increment by 1
nocache;

prompt
prompt Creating sequence PA_LOWEST_SALARY_SEQ
prompt ======================================
prompt
create sequence PA_LOWEST_SALARY_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence PA_PARAM_DATA_SEQ
prompt ===================================
prompt
create sequence PA_PARAM_DATA_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 353
increment by 1
nocache;

prompt
prompt Creating sequence PA_PARAM_ITEM_SEQ
prompt ===================================
prompt
create sequence PA_PARAM_ITEM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 38
increment by 1
nocache;

prompt
prompt Creating sequence PA_PARAM_SEQ
prompt ==============================
prompt
create sequence PA_PARAM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence PA_PA_ITEM_SEQ
prompt ================================
prompt
create sequence PA_PA_ITEM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence PA_QUAL_ALLOWANCE_SEQ
prompt =======================================
prompt
create sequence PA_QUAL_ALLOWANCE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence PA_Q_ALLW_TYPE_V
prompt ==================================
prompt
create sequence PA_Q_ALLW_TYPE_V
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence PA_REPORT_ITEM_SEQ
prompt ====================================
prompt
create sequence PA_REPORT_ITEM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence PA_REPORT_SEQ
prompt ===============================
prompt
create sequence PA_REPORT_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence PA_REPORT_TITLE_SEQ
prompt =====================================
prompt
create sequence PA_REPORT_TITLE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence PA_SALARY_NO_SEQ
prompt ==================================
prompt
create sequence PA_SALARY_NO_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence PA_SALARY_PROPORTION_SEQ
prompt ==========================================
prompt
create sequence PA_SALARY_PROPORTION_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence PA_TAX_SEQ
prompt ============================
prompt
create sequence PA_TAX_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence PA_TEN_ALLOW_SEQ
prompt ==================================
prompt
create sequence PA_TEN_ALLOW_SEQ
minvalue 1
maxvalue 999999999999999999999
start with 7279
increment by 1
cache 20
cycle;

prompt
prompt Creating sequence PROBATION_NO_SEQ
prompt ==================================
prompt
create sequence PROBATION_NO_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence PROCESS_AFFIRM_REL_SEQ
prompt ========================================
prompt
create sequence PROCESS_AFFIRM_REL_SEQ
minvalue 1
maxvalue 9999999999999999999999999
start with 121
increment by 1
cache 20;

prompt
prompt Creating sequence PROCESS_AFFIRM_SEQ
prompt ====================================
prompt
create sequence PROCESS_AFFIRM_SEQ
minvalue 1
maxvalue 9999999999999999999999999
start with 300
increment by 1
cache 20;

prompt
prompt Creating sequence PROCESS_OBJECT_TYPE_SEQ
prompt =========================================
prompt
create sequence PROCESS_OBJECT_TYPE_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 221
increment by 1
cache 20;

prompt
prompt Creating sequence PROCESS_STATUS_SEQ
prompt ====================================
prompt
create sequence PROCESS_STATUS_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 101
increment by 1
cache 20;

prompt
prompt Creating sequence PROSTOR_INSTORAGE_INFO_SEQ
prompt ============================================
prompt
create sequence PROSTOR_INSTORAGE_INFO_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 162
increment by 1
nocache;

prompt
prompt Creating sequence PROSTOR_OUTSTORAGE_INFO_SEQ
prompt =============================================
prompt
create sequence PROSTOR_OUTSTORAGE_INFO_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 561
increment by 1
cache 20;

prompt
prompt Creating sequence PROSTOR_OUTSTORAGE_PRODUCT_SEQ
prompt ================================================
prompt
create sequence PROSTOR_OUTSTORAGE_PRODUCT_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence PROSTOR_PRODUCT_SEQ
prompt =====================================
prompt
create sequence PROSTOR_PRODUCT_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 99
increment by 1
nocache;

prompt
prompt Creating sequence PROSTOR_PURCHASE_ORDER_SEQ
prompt ============================================
prompt
create sequence PROSTOR_PURCHASE_ORDER_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 301
increment by 1
cache 20;

prompt
prompt Creating sequence PROSTOR_SALES_MODEL_SEQ
prompt =========================================
prompt
create sequence PROSTOR_SALES_MODEL_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 42
increment by 1
nocache;

prompt
prompt Creating sequence PROSTOR_SALES_ORDER_SEQ
prompt =========================================
prompt
create sequence PROSTOR_SALES_ORDER_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 581
increment by 1
cache 20;

prompt
prompt Creating sequence PROSTOR_STORAGE_INFO_SEQ
prompt ==========================================
prompt
create sequence PROSTOR_STORAGE_INFO_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 79
increment by 1
nocache;

prompt
prompt Creating sequence PROSTOR_STORAGE_WARNING_SEQ
prompt =============================================
prompt
create sequence PROSTOR_STORAGE_WARNING_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 4
increment by 1
nocache;

prompt
prompt Creating sequence PROSTOR_SUPPLIER_PRODUCT_SEQ
prompt ==============================================
prompt
create sequence PROSTOR_SUPPLIER_PRODUCT_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 114
increment by 1
nocache;

prompt
prompt Creating sequence PROSTOR_SUPPLIER_SEQ
prompt ======================================
prompt
create sequence PROSTOR_SUPPLIER_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 147
increment by 1
nocache;

prompt
prompt Creating sequence PROSTOR_UPDATE_STORAGE_SEQ
prompt ============================================
prompt
create sequence PROSTOR_UPDATE_STORAGE_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence PRO_APPENDIX_INFO_SEQ
prompt =======================================
prompt
create sequence PRO_APPENDIX_INFO_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 24
increment by 1
nocache;

prompt
prompt Creating sequence PRO_BASIC_INFO_SEQ
prompt ====================================
prompt
create sequence PRO_BASIC_INFO_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 52
increment by 1
nocache;

prompt
prompt Creating sequence PRO_BUSINESS_INFO_SEQ
prompt =======================================
prompt
create sequence PRO_BUSINESS_INFO_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 126
increment by 1
nocache;

prompt
prompt Creating sequence PRO_QUOTA_INFO_SEQ
prompt ====================================
prompt
create sequence PRO_QUOTA_INFO_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 160
increment by 1
nocache;

prompt
prompt Creating sequence PRO_STOCK_INFO_SEQ
prompt ====================================
prompt
create sequence PRO_STOCK_INFO_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 510
increment by 1
nocache;

prompt
prompt Creating sequence PRO_STOCK_RECORD_SEQ
prompt ======================================
prompt
create sequence PRO_STOCK_RECORD_SEQ
minvalue 1
maxvalue 9999999999999999999999
start with 620
increment by 1
cache 20;

prompt
prompt Creating sequence PRO_STORAGE_INFO_SEQ
prompt ======================================
prompt
create sequence PRO_STORAGE_INFO_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 512
increment by 1
nocache;

prompt
prompt Creating sequence PURCHASE_ORDER_DETAIL_SEQ
prompt ===========================================
prompt
create sequence PURCHASE_ORDER_DETAIL_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 321
increment by 1
cache 20;

prompt
prompt Creating sequence REC_AFI_SEQ
prompt =============================
prompt
create sequence REC_AFI_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence REC_AFR_SEQ
prompt =============================
prompt
create sequence REC_AFR_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence REC_CHA_SEQ
prompt =============================
prompt
create sequence REC_CHA_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence REC_CLM_SEQ
prompt =============================
prompt
create sequence REC_CLM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence REC_CPB_SEQ
prompt =============================
prompt
create sequence REC_CPB_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence REC_DMT_SEQ
prompt =============================
prompt
create sequence REC_DMT_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence REC_DM_SEQ
prompt ============================
prompt
create sequence REC_DM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 26
increment by 1
nocache;

prompt
prompt Creating sequence REC_IVE_SEQ
prompt =============================
prompt
create sequence REC_IVE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence REC_IVP_SEQ
prompt =============================
prompt
create sequence REC_IVP_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence REC_IVRE_SEQ
prompt ==============================
prompt
create sequence REC_IVRE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence REC_IVR_SEQ
prompt =============================
prompt
create sequence REC_IVR_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence REC_IV_SEQ
prompt ============================
prompt
create sequence REC_IV_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence REC_PLI_SEQ
prompt =============================
prompt
create sequence REC_PLI_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence REC_REE_SEQ
prompt =============================
prompt
create sequence REC_REE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 7
increment by 1
nocache;

prompt
prompt Creating sequence REC_REF_SEQ
prompt =============================
prompt
create sequence REC_REF_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 4
increment by 1
nocache;

prompt
prompt Creating sequence REC_REQ_SEQ
prompt =============================
prompt
create sequence REC_REQ_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 4
increment by 1
nocache;

prompt
prompt Creating sequence REC_RES_SEQ
prompt =============================
prompt
create sequence REC_RES_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 26
increment by 1
nocache;

prompt
prompt Creating sequence REC_REW_SEQ
prompt =============================
prompt
create sequence REC_REW_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 3
increment by 1
nocache;

prompt
prompt Creating sequence REC_TEMPLATE_SEQ
prompt ==================================
prompt
create sequence REC_TEMPLATE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 10
increment by 1
nocache;

prompt
prompt Creating sequence REPORT_ITEM_SEQ
prompt =================================
prompt
create sequence REPORT_ITEM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 123
increment by 1
nocache;

prompt
prompt Creating sequence REPORT_TABLE_SEQ
prompt ==================================
prompt
create sequence REPORT_TABLE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 335
increment by 1
nocache;

prompt
prompt Creating sequence SALES_DIRECT_SALES_SEQ
prompt ========================================
prompt
create sequence SALES_DIRECT_SALES_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 50
increment by 1
cache 20;

prompt
prompt Creating sequence SALES_SUPERVISOR_SEQ
prompt ======================================
prompt
create sequence SALES_SUPERVISOR_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 281
increment by 1
cache 20;

prompt
prompt Creating sequence SEQUENCE
prompt ==========================
prompt
create sequence SEQUENCE
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_ETN_PERSON_RESULT
prompt =======================================
prompt
create sequence SEQ_ETN_PERSON_RESULT
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_ETN_SATISFACT_RESULT
prompt ==========================================
prompt
create sequence SEQ_ETN_SATISFACT_RESULT
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_EVS_EXPERIENCE_NORM
prompt =========================================
prompt
create sequence SEQ_EVS_EXPERIENCE_NORM
minvalue 0
maxvalue 999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_EVS_FACT
prompt ==============================
prompt
create sequence SEQ_EVS_FACT
minvalue 0
maxvalue 9999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_EVS_GROUP
prompt ===============================
prompt
create sequence SEQ_EVS_GROUP
minvalue 0
maxvalue 99999999999999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_EVS_NORM
prompt ==============================
prompt
create sequence SEQ_EVS_NORM
minvalue 1
maxvalue 999999999999999999999999999
start with 63
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_EV_COMMON_ITEM_DETAIL
prompt ===========================================
prompt
create sequence SEQ_EV_COMMON_ITEM_DETAIL
minvalue 1
maxvalue 999999999999999999999999999
start with 1016
increment by 1
nocache;

prompt
prompt Creating sequence SEQ_GROUP_PERSON
prompt ==================================
prompt
create sequence SEQ_GROUP_PERSON
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence SY_ADMIN_NO
prompt =============================
prompt
create sequence SY_ADMIN_NO
minvalue 1
maxvalue 999999999999999999999999999
start with 2001
increment by 1
nocache;

prompt
prompt Creating sequence SY_AFFIRM_RELATION_SEQ
prompt ========================================
prompt
create sequence SY_AFFIRM_RELATION_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 13573
increment by 1
nocache;

prompt
prompt Creating sequence SY_ANN_SEQ
prompt ============================
prompt
create sequence SY_ANN_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 140
increment by 1
cache 20;

prompt
prompt Creating sequence SY_CATEGORY_PROPERTY_SEQ
prompt ==========================================
prompt
create sequence SY_CATEGORY_PROPERTY_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 22
increment by 1
nocache;

prompt
prompt Creating sequence SY_CATEGORY_SEQ
prompt =================================
prompt
create sequence SY_CATEGORY_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 61
increment by 1
nocache;

prompt
prompt Creating sequence SY_CHECKTYPE_SEQ
prompt ==================================
prompt
create sequence SY_CHECKTYPE_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 51
increment by 1
cache 10;

prompt
prompt Creating sequence SY_CODE_SEQ
prompt =============================
prompt
create sequence SY_CODE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 21017
increment by 1
nocache;

prompt
prompt Creating sequence SY_DEPT_ID_SEQ
prompt ================================
prompt
create sequence SY_DEPT_ID_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 9
increment by 1
cache 20;

prompt
prompt Creating sequence SY_INSTORAGE_SERIAL_SEQ
prompt =========================================
prompt
create sequence SY_INSTORAGE_SERIAL_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence SY_LOGIN_SCREEN_SEQ
prompt =====================================
prompt
create sequence SY_LOGIN_SCREEN_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1004
increment by 1
nocache;

prompt
prompt Creating sequence SY_MENU_SEQ
prompt =============================
prompt
create sequence SY_MENU_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 8710
increment by 1
nocache;

prompt
prompt Creating sequence SY_MESSAGE_SEQ
prompt ================================
prompt
create sequence SY_MESSAGE_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 82
increment by 1
nocache;

prompt
prompt Creating sequence SY_ORDER_SEQ
prompt ==============================
prompt
create sequence SY_ORDER_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 100
increment by 1
cache 20;

prompt
prompt Creating sequence SY_OUTSTORAGE_SERIAL_SEQ
prompt ==========================================
prompt
create sequence SY_OUTSTORAGE_SERIAL_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence SY_PARAMETER_SEQ
prompt ==================================
prompt
create sequence SY_PARAMETER_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 202
increment by 1
nocache;

prompt
prompt Creating sequence SY_PRODUCT_SERIAL_SEQ
prompt =======================================
prompt
create sequence SY_PRODUCT_SERIAL_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 21
increment by 1
cache 20;

prompt
prompt Creating sequence SY_PROPERTY_VALUE_SEQ
prompt =======================================
prompt
create sequence SY_PROPERTY_VALUE_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 35
increment by 1
nocache;

prompt
prompt Creating sequence SY_PURCHASE_SERIAL_SEQ
prompt ========================================
prompt
create sequence SY_PURCHASE_SERIAL_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SY_SALES_SERIAL_SEQ
prompt =====================================
prompt
create sequence SY_SALES_SERIAL_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 41
increment by 1
cache 20;

prompt
prompt Creating sequence SY_SCREENGRANTNAME_SEQ
prompt ========================================
prompt
create sequence SY_SCREENGRANTNAME_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 5
increment by 1
nocache;

prompt
prompt Creating sequence SY_SERIAL_NUM_ALL_SEQ
prompt =======================================
prompt
create sequence SY_SERIAL_NUM_ALL_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 260
increment by 1
cache 20;

prompt
prompt Creating sequence SY_SERIAL_NUM_SEQ
prompt ===================================
prompt
create sequence SY_SERIAL_NUM_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 100
increment by 1
cache 20;

prompt
prompt Creating sequence SY_SUPPLIER_ADMIN_SEQ
prompt =======================================
prompt
create sequence SY_SUPPLIER_ADMIN_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 101
increment by 1
cache 10;

prompt
prompt Creating sequence T_AR_SCHEDULE_SEQ
prompt ===================================
prompt
create sequence T_AR_SCHEDULE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 296
increment by 1
nocache;

prompt
prompt Creating sequence T_ORDERNO_SEQ
prompt ===============================
prompt
create sequence T_ORDERNO_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1711
increment by 15
nocache;

prompt
prompt Creating sequence AR_DYNAMIC_GROUP_SEQ
prompt ======================================
prompt
drop sequence AR_DYNAMIC_GROUP_SEQ;
create sequence AR_DYNAMIC_GROUP_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 22
increment by 1
nocache;

prompt
prompt Creating sequence AR_ITEM_PARAM_SEQ
prompt ===================================
prompt
drop sequence AR_ITEM_PARAM_SEQ;
create sequence AR_ITEM_PARAM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 421
increment by 1
cache 20;

prompt
prompt Creating sequence AR_ITEM_SEQ
prompt =============================
prompt
drop sequence AR_ITEM_SEQ;
create sequence AR_ITEM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 56
increment by 1
nocache;

prompt
prompt Creating sequence AR_STA_FORMULAR_SEQ
prompt =====================================
prompt
drop sequence AR_STA_FORMULAR_SEQ;
create sequence AR_STA_FORMULAR_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 146
increment by 1
nocache;

prompt
prompt Creating sequence AR_STA_ITEM_SEQ
prompt =================================
prompt
drop sequence AR_STA_ITEM_SEQ;
create sequence AR_STA_ITEM_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 121
increment by 1
nocache;

prompt
prompt Creating sequence HR_POSITION_SEQ
prompt =================================
prompt
drop sequence HR_POSITION_SEQ;
create sequence HR_POSITION_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 118
increment by 1
nocache;

prompt
prompt Creating sequence LICENSE_SEQ
prompt =============================
prompt
create sequence LICENSE_SEQ
minvalue 1
maxvalue 999999999999999999999999999
start with 1
increment by 1
nocache;

prompt
prompt Creating sequence WECHAT_MENU_SEQ
prompt =================================
prompt
create sequence WECHAT_MENU_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 55
increment by 1
nocache;

prompt
prompt Creating sequence WECHAT_PARAM_SEQ
prompt ==================================
prompt
create sequence WECHAT_PARAM_SEQ
minvalue 1
maxvalue 9999999999999999999999999999
start with 4
increment by 1
nocache;

spool off
exit;