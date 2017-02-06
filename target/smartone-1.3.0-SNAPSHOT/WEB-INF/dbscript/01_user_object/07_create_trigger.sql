---------------------------------------------
-- Export file for user WINE               --
-- Created by Yayoi on 2014/1/26, 15:26:06 --
---------------------------------------------

set define off
spool trigger.log

prompt
prompt Creating trigger EVJ_DEL_DEPT
prompt =============================
prompt
CREATE OR REPLACE TRIGGER "EVJ_DEL_DEPT" 
   BEFORE DELETE
   ON evj_dept
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
BEGIN
   DELETE FROM evj_emp
         WHERE ev_period_id = :OLD.ev_period_id
               AND ev_dept_id = :OLD.ev_dept_id;
EXCEPTION
   WHEN OTHERS
   THEN
      RAISE;
END evj_del_dept;
/

prompt
prompt Creating trigger EVJ_DEL_EMP
prompt ============================
prompt
CREATE OR REPLACE TRIGGER "EVJ_DEL_EMP" 
   BEFORE DELETE
   ON evj_emp
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
BEGIN
   DELETE FROM evj_master
         WHERE ev_period_id = :OLD.ev_period_id AND ev_emp_id =
                                                               :OLD.ev_emp_id;
EXCEPTION
   WHEN OTHERS
   THEN
      RAISE;
END evj_del_emp;
/

prompt
prompt Creating trigger EVJ_MASTER_ITEM_DEL
prompt ====================================
prompt
CREATE OR REPLACE TRIGGER "EVJ_MASTER_ITEM_DEL" 
   BEFORE DELETE
   ON evj_type_item
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
BEGIN
   DECLARE
      CURSOR cur_emp
      IS
         SELECT ev_emp_id, ev_period_id, ev_type_id
           FROM evj_emp
          WHERE ev_period_id = :OLD.ev_period_id
            AND ev_type_id = :OLD.ev_type_id;

      emp_c   cur_emp%ROWTYPE;
   BEGIN
      OPEN cur_emp;

      FETCH cur_emp
       INTO emp_c;

      WHILE cur_emp%FOUND
      LOOP
         BEGIN
            DELETE      evj_master
                  WHERE ev_period_id = :OLD.ev_period_id
                    AND ev_emp_id = emp_c.ev_emp_id
                    AND ev_item_id = :OLD.ev_item_id;
         EXCEPTION
            WHEN OTHERS
            THEN
               RAISE;
         END;

         FETCH cur_emp
          INTO emp_c;
      END LOOP;

      CLOSE cur_emp;
   EXCEPTION
      WHEN OTHERS
      THEN
         RAISE;
   END;
EXCEPTION
   WHEN OTHERS
   THEN
      RAISE;
END evj_master_item_del;
/

prompt
prompt Creating trigger EVS_DEL_DEPT
prompt =============================
prompt
CREATE OR REPLACE TRIGGER "EVS_DEL_DEPT" 
   BEFORE DELETE
   ON EVA_DEPT
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
BEGIN
   DELETE FROM evA_emp
         WHERE ev_period_id = :OLD.ev_period_id
               AND ev_dept_id = :OLD.ev_dept_id;
EXCEPTION
   WHEN OTHERS
   THEN
      RAISE;
END evs_del_dept;
/

prompt
prompt Creating trigger EVS_DEL_DETAIL
prompt ===============================
prompt
CREATE OR REPLACE TRIGGER "EVS_DEL_DETAIL" 
   BEFORE DELETE
   ON EVA_ITEM_DETAIL
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
BEGIN
   DELETE FROM evA_column_detail
         WHERE seq_ev_item_detail = :OLD.seq_ev_item_detail;

   DELETE FROM evA_detail_mark
         WHERE seq_ev_item_detail = :OLD.seq_ev_item_detail;
EXCEPTION
   WHEN OTHERS
   THEN
      RAISE;
END evs_del_detail;
/

prompt
prompt Creating trigger EVS_DEL_EMP
prompt ============================
prompt
CREATE OR REPLACE TRIGGER "EVS_DEL_EMP" 
BEFORE DELETE
ON EVA_EMP
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
   DELETE FROM EVA_MASTER
         WHERE ev_period_id = :OLD.ev_period_id AND ev_emp_id =
                                                               :OLD.ev_emp_id;

   DELETE FROM EVA_ITEM_DETAIL
         WHERE ev_emp_id = :OLD.ev_emp_id AND ev_period_id =
                                                             :OLD.ev_period_id;
    DELETE FROM EVA_ITEM_PROCESS_MARK
         WHERE ev_emp_id = :OLD.ev_emp_id AND ev_period_id =
                                                             :OLD.ev_period_id;
EXCEPTION
   WHEN OTHERS
   THEN
      RAISE;
END evs_del_emp;
/

prompt
prompt Creating trigger HR_EMPLOYEE_DELETE
prompt ===================================
prompt
CREATE OR REPLACE TRIGGER "HR_EMPLOYEE_DELETE" 
	BEFORE DELETE ON HR_EMPLOYEE
	REFERENCING NEW AS NEW OLD AS OLD
  FOR EACH ROW
DECLARE
BEGIN 
  
  --人事信息
  DELETE FROM HR_ADDITIONAL_INFO WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_CONTRACT WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_EMP_INFO WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_EDUCATION WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_EMP_BINARY_PHOTO WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_LANGUAGE_LEVEL WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_EMP_PA_INFO WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_EXPERIENCE_INSIDE WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_EXPERIENCE_INSIDE_HISTORY WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_FAMILY WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_FILE WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_HEALTH WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_LANGUAGE_LEVEL WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_TRAINING_INSIDE WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_TRAINING_OUTSIDE WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_MILITARY_SERVICE WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_PERSONAL_INFO WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_PROBATION WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_PUNISHMENT WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_QUALIFICATION WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_RESIGNATION WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_STUDYING WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_SUSPENSION WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_UPGRADE_HISTORY WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_WORK_EXPERIENCE WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_DISPATCH WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_EMP_PA_INFO WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_IT_LEVEL WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_PLURALITY WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_REWARD WHERE EMPID = :OLD.EMPID;
  --考勤信息
  DELETE FROM AR_EMP_CARD WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM AR_MAC_RECORD WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM AR_DETAIL WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM AR_ANNUAL_HOLIDAY WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM AR_VAC_EMP WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM AR_APPLY_RESULT WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM AR_SCHEDULE WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM AR_SUPERVISOR_INFO WHERE AR_SUPERVISOR_ID = :OLD.EMPID;
  
  DELETE FROM AR_SUPERVISOR WHERE SUPERVISOR_ID = :OLD.EMPID;
  
  DELETE FROM AR_HISTORY WHERE "EMPID" = :OLD.EMPID;
  
 --ESS基本信息
  DELETE FROM ESS_PERSONAL_INFO WHERE EMPID = :OLD.EMPID;
   
  DELETE FROM ESS_APPLY_BT WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM ESS_APPLY_CARD WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM ESS_APPLY_ETN WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM ESS_APPLY_EXP WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM ESS_APPLY_LEAVE WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM ESS_APPLY_ONDUTY WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM ESS_APPLY_OT WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM ESS_APPLY_WH WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM SY_AFFIRM_RELATION WHERE AFFIRMOR_ID = :OLD.EMPID;
  
  DELETE FROM SY_ADMIN WHERE ADMINID = :OLD.EMPID;
  --评价信息
  DELETE FROM EVA_EMP WHERE EV_EMP_ID = :OLD.EMPID;
  
  --工资信息
  DELETE FROM PA_PARAM_DATA WHERE FIELD1_VALUE = :OLD.EMPID;
  
  DELETE FROM PA_HISTORY WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM PA_INFO_HISTORY WHERE EMPID = :OLD.EMPID;
  
  DELETE FROM HR_EMP_BUSINESS WHERE EMPID = :OLD.EMPID;
  DELETE FROM PA_ANNUAL_SALARY_HISTORY WHERE EMPID = :OLD.EMPID;
  DELETE FROM HR_EMP_STATUS_HISTORY WHERE EMPID = :OLD.EMPID;
  DELETE FROM PA_INFO_HISTORY WHERE EMPID = :OLD.EMPID;
  DELETE FROM HR_EMP_STATUS_HISTORY WHERE EMPID = :OLD.EMPID;
 
EXCEPTION
  WHEN OTHERS THEN
    RAISE;
END HR_EMPLOYEE_DELETE;
/

prompt
prompt Creating trigger ORD_ORDID_TRIG
prompt ===============================
prompt
CREATE OR REPLACE TRIGGER "ORD_ORDID_TRIG" 
BEFORE INSERT ON ORD_ORDER_INFO
REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
DECLARE
BEGIN
  SELECT ORDID_SEQ.CURRVAL INTO :NEW.ORDER_NO FROM DUAL;
  SELECT ORDID_SEQ.CURRVAL INTO :NEW.ORDERNO FROM DUAL;
END;
/

prompt
prompt Creating trigger SY_ADMIN_DELETE
prompt ================================
prompt
CREATE OR REPLACE TRIGGER "SY_ADMIN_DELETE" 
   BEFORE DELETE
   ON sy_admin
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW
DECLARE
BEGIN
   DELETE FROM sy_admin_deptid
         WHERE admin_no = :OLD.adminno;
EXCEPTION
   WHEN OTHERS
   THEN
      RAISE;
END sy_admin_delete;
/

prompt
prompt Creating trigger SY_CODE_INSERT
prompt ===============================
prompt
CREATE OR REPLACE TRIGGER "SY_CODE_INSERT" 
  AFTER INSERT ON SY_CODE
  FOR EACH ROW
BEGIN
  INSERT INTO T_SY_CODE
    (CODE_NO,
     CODE_ID,
     CODE_NAME,
     CODE_EN_NAME,
     DESCRIPTION,
     PARENT_CODE,
     DEPTH,
     CREATE_DATE,
     CREATED_BY,
     UPDATE_DATE,
     UPDATED_BY,
     ORDERNO,
     ACTIVITY,
     CPNY_ID)
  VALUES
    (:NEW.CODE_NO,
     :NEW.CODE_ID,
     :NEW.CODE_NAME,
     :NEW.CODE_EN_NAME,
     :NEW.DESCRIPTION,
     :NEW.PARENT_CODE,
     :NEW.DEPTH,
     :NEW.CREATE_DATE,
     :NEW.CREATED_BY,
     :NEW.UPDATE_DATE,
     :NEW.UPDATED_BY,
     :NEW.ORDERNO,
     :NEW.ACTIVITY,
     :NEW.CPNY_ID);
EXCEPTION
   WHEN OTHERS
   THEN
      RAISE;
END;
/

prompt
prompt Creating trigger SY_MENU_INSERT
prompt ===============================
prompt
CREATE OR REPLACE TRIGGER "SY_MENU_INSERT" 
  AFTER INSERT ON SY_MENU
  FOR EACH ROW
BEGIN
  INSERT INTO T_SY_MENU
    (MENU_NO,
     MENU_CODE,
     MENU_INTRO,
     MENU_EN_INTRO,
     MENU_IMG,
     MENU_PARENT_CODE,
     DEPTH,
     BUILD_FLAG,
     TABLE_NAME,
     MENU_URL,
     DESCRIPTION,
     CREATE_DATE,
     CREATED_BY,
     UPDATE_DATE,
     UPDATED_BY,
     ORDERNO,
     ACTIVITY,
     CPNY_ID)
  VALUES
    (:NEW.MENU_NO,
     :NEW.MENU_CODE,
     :NEW.MENU_INTRO,
     :NEW.MENU_EN_INTRO,
     :NEW.MENU_IMG,
     :NEW.MENU_PARENT_CODE,
     :NEW.DEPTH,
     :NEW.BUILD_FLAG,
     :NEW.TABLE_NAME,
     :NEW.MENU_URL,
     :NEW.DESCRIPTION,
     :NEW.CREATE_DATE,
     :NEW.CREATED_BY,
     :NEW.UPDATE_DATE,
     :NEW.UPDATED_BY,
     :NEW.ORDERNO,
     :NEW.ACTIVITY,
     :NEW.CPNY_ID);
EXCEPTION
   WHEN OTHERS
   THEN
      RAISE;
END;
/

spool off
exit;