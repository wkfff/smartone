---------------------------------------------
-- Export file for user WINE               --
-- Created by Yayoi on 2014/1/26, 15:26:06 --
---------------------------------------------

set define off
spool procedure.log

prompt
prompt Creating procedure ADD_DATE_TO_CA
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE Add_Date_To_Ca (
   from_dates   DATE,
   to_dates     DATE,
   work_shift   NUMBER,
   rest_shift   NUMBER
)
IS
   tmpvar              NUMBER;
   temp_date           DATE;
   variyear            NUMBER (10);
   varimonth           NUMBER (10);
   variday             NUMBER (10);
   variweek            NUMBER (10);
   varworkdayflag      NUMBER (10);
   vartypeid           NUMBER (10);
   varovertypeid       NUMBER (10);
   vartypeid_default   NUMBER (10);
BEGIN
   DELETE      AR_CALENDER
         WHERE ddate >= from_dates AND ddate <= to_dates;

   temp_date := from_dates;

   WHILE temp_date <= to_dates
   LOOP
      variyear := EXTRACT (YEAR FROM temp_date);
      varimonth := EXTRACT (MONTH FROM temp_date);
      variday := EXTRACT (DAY FROM temp_date);
      variweek := TO_CHAR (temp_date, 'D');

      IF variweek = 7 OR variweek = 1        -- 如果是周末工作状态为“不工作”
      THEN
         varworkdayflag := 0;
         vartypeid := 2;
         varovertypeid := 2;
         vartypeid_default := 2;
      ELSE                  -- 如果不是是周末工作状态为“工作”  
         varworkdayflag := 1;
         vartypeid := 1;
         varovertypeid := 1;
         vartypeid_default := 1;
      END IF;

      IF    (    (varimonth = 5 OR varimonth = 10)      -- 针对法定假日的设置
             AND (variday = 1 OR variday = 2 OR variday = 3)
            )
         OR (varimonth = 1 AND variday = 1)
      THEN
         varworkdayflag := 0;
         vartypeid := 3;
         varovertypeid := 3;
         vartypeid_default := 3;
      END IF;

      --IF variweek = 7
      --THEN
         --variweek := 0;
      --END IF;
      variweek:=variweek-1;
      --insert into

      --dBMS_OUTPUT.put_line (' ----------------------');
      --dBMS_OUTPUT.put_line (' date:'|| temp_date);
      --dBMS_OUTPUT.put_line (' YEAR:'|| varIYEAR );
      --dBMS_OUTPUT.put_line (' DAY:'|| varIDAY  );
      --dBMS_OUTPUT.put_line (' WEEK:'|| varIWEEK  );
      --temp_date:=temp_date+1;
      INSERT INTO AR_CALENDER
                  (ddate, iyear, imonth, iday, iweek,
                   workdayflag, typeid, overtypeid, typeid_default, DDATE_STR
                  )
           VALUES (temp_date, variyear, varimonth, variday, variweek,
                   varworkdayflag, vartypeid, varovertypeid, vartypeid_default, TO_CHAR(temp_date,'YYYY-MM-DD')
                  );

      temp_date := temp_date + 1;
   END LOOP;

   tmpvar := to_dates - from_dates;

   UPDATE AR_CALENDER   -- 工作状态的班次设置
      SET shift_no = work_shift
    WHERE typeid = 1 AND ddate >= from_dates AND ddate <= to_dates;

   UPDATE AR_CALENDER    -- 不工作状态的班次设置
      SET shift_no = rest_shift
    WHERE (typeid = 2 or typeid= 3) AND ddate >= from_dates AND ddate <= to_dates;
--dBMS_OUTPUT.put_line (' talo:'|| tmpVar );
END Add_Date_To_Ca;
/

prompt
prompt Creating procedure AR_ADD_GROUP_CONDITION_PR
prompt ============================================
prompt
CREATE OR REPLACE PROCEDURE ar_add_group_condition_pr (
   in_group_no   IN   NUMBER,                 -- the group number to be setted
   in_field_no   IN   NUMBER,                     -- the field to be qualified
   in_relation   IN   VARCHAR2,         -- the relation for the selected field
   in_value1     IN   VARCHAR2,                         -- the condition value
   in_value2     IN   VARCHAR2      -- when relation is between, 2 values used
)
IS
   check_field     VARCHAR2 (400);
   v_field_id      VARCHAR2 (400);
   var_empid_str   VARCHAR2 (4000);
/******************************************************************************
   NAME:       ar_add_group_condition_pr
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2005-5-16                    1. Created this procedure.
   2.0        2006-3-3    Pennix           1. 调用 AR_GROUP_MEMBERS, 将所有分组条件直接对应出人员,按人记录进 AR_EMP_GROUP 表中
   2.1        2006-3-11   Pennix       1. 取消调用 AR_GROUP_MEMBERS

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     ar_add_group_condition_pr
      Sysdate:         2005-5-16
      Date and Time:   2005-5-16, 18:57:43, and 2005-5-16 18:57:43
      Username:         (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   v_field_id := ar_get_condition_field_id_fn (in_field_no);

   -- to check whether the insert operation violate the unique constraints
   BEGIN
      SELECT field_name
        INTO check_field
        FROM ar_group_conditions
       WHERE group_no = in_group_no AND field_name = v_field_id;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         check_field := NULL;
   END;

   IF check_field IS NULL
   THEN
      INSERT INTO ar_group_conditions
                  (group_condition_no, group_no, field_name,
                   relation, value1, value2
                  )
           VALUES (ar_group_condition_seq.NEXTVAL, in_group_no, v_field_id,
                   in_relation, in_value1, in_value2
                  );
   END IF;

   IF check_field IS NOT NULL
   THEN
      UPDATE ar_group_conditions
         SET relation = in_relation,
             value1 = in_value1,
             value2 = in_value2
       WHERE group_no = in_group_no AND field_name = v_field_id;
   END IF;

/*
   ar_group_members (in_group_no,
                     v_field_id,
                     in_relation,
                     in_value1,
                     in_value2,
                     'ADD'
                    );
*/
   COMMIT;
END ar_add_group_condition_pr;
/

prompt
prompt Creating procedure AR_ADD_MAC_RECORD
prompt ====================================
prompt
create or replace procedure AR_ADD_MAC_RECORD(IN_EMPID VARCHAR2,
                                              IN_R_TIME VARCHAR2,
                                              IN_ATT_DATE VARCHAR2,
                                              IN_CREATED_BY VARCHAR2) 
is
begin
  --插入当天该员工打卡信息    
  INSERT INTO AR_MAC_RECORD
					( RECORD_NO,
					  EMPID,
					  R_TIME,
					  ATT_DATE,
					  ACTIVITY,
					  IN_FLAG,
					  CREATED_BY,
					  CREATE_DATE)
			    VALUES (  AR_MAC_RECORD_SEQ.NEXTVAL,
				   		IN_EMPID,
				 		  TO_DATE(IN_R_TIME,'YYYY-MM-DD HH24:MI:SS'),
				 		  TO_DATE(IN_ATT_DATE,'YYYY-MM-DD'),
						  1,
						  'M',
						  IN_CREATED_BY,
						  SYSDATE);
         
end AR_ADD_MAC_RECORD;
/

prompt
prompt Creating procedure AR_ADD_SUPERVISOR
prompt ====================================
prompt
CREATE OR REPLACE PROCEDURE ar_add_supervisor (
   in_supervisor_id   IN   VARCHAR2,
   in_created_by      IN   VARCHAR2
)
IS
   tmpvar             NUMBER;
   check_supervisor   VARCHAR2 (20);
/******************************************************************************
   NAME:       ar_add_supervisor
   PURPOSE:    添加考勤员

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2005-5-20    chengwei      1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     ar_add_supervisor
      Sysdate:         2005-5-20
      Date and Time:   2005-5-20, 11:28:21, and 2005-5-20 11:28:21
      Username:         (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   BEGIN
      SELECT supervisor_id
        INTO check_supervisor
        FROM ar_supervisor
       WHERE supervisor_id = in_supervisor_id;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         check_supervisor := NULL;
   END;

   IF check_supervisor IS NULL
   THEN
      INSERT INTO ar_supervisor
                  (supervisor_no, supervisor_id, create_date,
                   created_by
                  )
           VALUES (ar_supervisor_seq.NEXTVAL, in_supervisor_id, SYSDATE,
                   in_created_by
                  );

      COMMIT;
   END IF;
END ar_add_supervisor;
/

prompt
prompt Creating procedure AR_CREATE_VACATIONEMP
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE AR_CREATE_VACATIONEMP IS
  V_INSERT_FLAG NUMBER := 1; -- 年假生成标记
  V_STRT_MONTH  NUMBER; -- 开始月份
  V_END_MONTH   NUMBER; -- 结束月份
  V_VAC_DAY_CNT NUMBER; -- 年假天数
  V_VAC_FLAG1   NUMBER; -- 标记1
  V_VAC_FLAG2   NUMBER; -- 标记2
  V_STRT_DATE   DATE; -- 开始日期
  V_END_DATE    DATE; -- 结束日期
  V_VAC_ID      VARCHAR2(20) := TO_CHAR(SYSDATE, 'YYYY'); -- 年份ID
  --人员游标
  CURSOR CUR_EMP IS
    SELECT H.EMPID,
           MIN(H.JOIN_DATE) JOIN_DATE,
           TO_CHAR(MIN(H.JOIN_DATE), 'MM') JOIN_MONTH_CNT,
           TO_CHAR(MIN(H.JOIN_DATE), 'MM-DD') JOIN_MM_DD,
           TRUNC((SYSDATE - H.JOIN_DATE) / 30 / 12, 0)*12 AS AGE_YEAR,
           MOD(TRUNC((SYSDATE - H.JOIN_DATE) / 30), 12) AS AGE_MONTHS,
           COUNT(V.EMPID) VAC_FLAG
      FROM HR_EMPLOYEE H, AR_VAC_EMP V
     WHERE H.EMPID = V.EMPID(+)
       AND (H.STATUS_CODE <> 'Status03' OR H.LEFT_DATE IS NULL)
     GROUP BY H.EMPID, H.JOIN_DATE
     ORDER BY H.JOIN_DATE;

  CURSOR CUR_VAC_TYPE IS
    SELECT T.CODE_ID
      FROM SY_CODE T
     WHERE T.PARENT_CODE = 'VacationType'
       AND T.ACTIVITY = 1; -- 年假ID

BEGIN
  DECLARE
    CUR_EMP_ROW  CUR_EMP%ROWTYPE;
    CUR_TYPE_ROW CUR_VAC_TYPE%ROWTYPE;

  BEGIN
    OPEN CUR_VAC_TYPE;

    /*循环限额休假类型*/
    LOOP
      FETCH CUR_VAC_TYPE
        INTO CUR_TYPE_ROW;

      EXIT WHEN CUR_VAC_TYPE%NOTFOUND;

      OPEN CUR_EMP;

      LOOP
        FETCH CUR_EMP
          INTO CUR_EMP_ROW;
        EXIT WHEN CUR_EMP%NOTFOUND;

        BEGIN

          IF CUR_EMP_ROW.AGE_YEAR >= 12 THEN
            BEGIN
              SELECT T.VAC_DAY_CNT,
                     T.STRT_MONTH,
                     T.END_MONTH
                INTO V_VAC_DAY_CNT, V_STRT_MONTH, V_END_MONTH
                FROM AR_VAC_MASTER T
               WHERE CUR_EMP_ROW.AGE_YEAR >= T.STRT_MONTH 
                 AND CUR_EMP_ROW.AGE_YEAR < T.END_MONTH
                AND T.VAC_TP = CUR_TYPE_ROW.CODE_ID;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                V_STRT_MONTH  := NULL;
                V_END_MONTH   := NULL;
                V_VAC_DAY_CNT := 0;
            END;
          END IF;

          IF V_STRT_MONTH IS NOT NULL AND V_END_MONTH IS NOT NULL THEN
            IF CUR_EMP_ROW.AGE_YEAR = 12 AND CUR_EMP_ROW.AGE_MONTHS = 0  THEN
              V_STRT_DATE := TO_DATE(TO_CHAR(SYSDATE, 'YYYY')||CUR_EMP_ROW.JOIN_MM_DD,'YYYY-MM-DD');
              V_END_DATE  := TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-12-31',
                                     'YYYY-MM-DD');
            BEGIN
              SELECT T.VAC_DAY_CNT
                INTO V_VAC_DAY_CNT
                FROM AR_VAC_MASTER T
               WHERE T.STRT_MONTH = CUR_EMP_ROW.JOIN_MONTH_CNT
                 AND T.END_MONTH = CUR_EMP_ROW.JOIN_MONTH_CNT
                 AND T.VAC_TP = CUR_TYPE_ROW.CODE_ID;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                V_VAC_DAY_CNT := 0;
            END;
            END IF;
            IF CUR_EMP_ROW.AGE_YEAR = 12 AND CUR_EMP_ROW.AGE_MONTHS > 0 THEN
              V_STRT_DATE := TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-01',
                                     'YYYY-MM-DD');
              V_END_DATE  := TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-12-31',
                                     'YYYY-MM-DD');
            END IF;
            IF CUR_EMP_ROW.AGE_YEAR >= 24 THEN
              V_STRT_DATE := TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-01-01',
                                     'YYYY-MM-DD');
              V_END_DATE  := TO_DATE(TO_CHAR(SYSDATE, 'YYYY') || '-12-31',
                                     'YYYY-MM-DD');
            END IF;

            BEGIN
              SELECT COUNT(1)
                INTO V_INSERT_FLAG
                FROM AR_VAC_EMP T
               WHERE T.EMPID = CUR_EMP_ROW.EMPID
                 AND T.VAC_TP = CUR_TYPE_ROW.CODE_ID
                 AND T.VAC_ID = V_VAC_ID
                 AND SYSDATE BETWEEN T.STRT_DATE AND T.END_DATE;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                V_VAC_DAY_CNT := 0;
            END;

            BEGIN
              SELECT COUNT(1)
                INTO V_VAC_FLAG1
                FROM AR_VAC_EMP T
               WHERE V_STRT_DATE BETWEEN T.STRT_DATE AND T.END_DATE
                 AND T.EMPID = CUR_EMP_ROW.EMPID;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                V_VAC_FLAG1 := 0;
            END;

            BEGIN
              SELECT COUNT(1)
                INTO V_VAC_FLAG2
                FROM AR_VAC_EMP T
               WHERE V_END_DATE BETWEEN T.STRT_DATE AND T.END_DATE
                 AND T.EMPID = CUR_EMP_ROW.EMPID;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                V_VAC_FLAG2 := 0;
            END;

            IF V_INSERT_FLAG IS NOT NULL AND V_INSERT_FLAG = 0 AND
               V_VAC_FLAG1 = 0 AND V_VAC_FLAG2 = 0 AND
               SYSDATE >= V_STRT_DATE THEN
              INSERT INTO AR_VAC_EMP
                (AR_VAC_EMP.VACATION_NO,
                 EMPID,
                 VAC_TP,
                 VAC_ID,
                 STRT_DATE,
                 END_DATE,
                 TOT_VAC_CNT,
                 CREATE_DATE,
                 ACTIVITY)
              VALUES
                (AR_VAC_EMP_SEQ.NEXTVAL,
                 CUR_EMP_ROW.EMPID,
                 CUR_TYPE_ROW.CODE_ID,
                 V_VAC_ID,
                 V_STRT_DATE,
                 V_END_DATE,
                 V_VAC_DAY_CNT,
                 SYSDATE,
                 1);
            END IF;
          END IF;

          V_STRT_MONTH  := NULL;
          V_END_MONTH   := NULL;
          V_VAC_DAY_CNT := 0;
          V_VAC_FLAG2   := 0;
          V_VAC_FLAG1   := 0;

        END;
      END LOOP;

      CLOSE CUR_EMP;
    END LOOP;
    CLOSE CUR_VAC_TYPE;
  END;
  COMMIT;
END AR_CREATE_VACATIONEMP;
/

prompt
prompt Creating procedure AR_DELETE_GROUP_CONDITION_PR
prompt ===============================================
prompt
CREATE OR REPLACE PROCEDURE ar_delete_group_condition_pr (
   in_group_condition_no   IN   NUMBER
)
IS
/******************************************************************************
   NAME:       ar_delete_group_condition_pr
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2005-5-16          1. Created this function.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     ar_delete_group_condition_pr
      Sysdate:         2005-5-16
      Date and Time:   2005-5-16, 22:30:16, and 2005-5-16 22:30:16
      Username:         (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   DELETE      ar_group_conditions
         WHERE group_condition_no = in_group_condition_no;

   COMMIT;
END ar_delete_group_condition_pr;
/

prompt
prompt Creating procedure AR_DELETE_GROUP_PR
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE ar_delete_group_pr (in_group_no IN NUMBER)
IS
/******************************************************************************
   NAME:       ar_delete_group_pr
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2005-5-17          1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     ar_delete_group_pr
      Sysdate:         2005-5-17
      Date and Time:   2005-5-17, 10:59:18, and 2005-5-17 10:59:18
      Username:         (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   DELETE      ar_group_conditions
         WHERE group_no = in_group_no;

   DELETE      ar_dynamic_group
         WHERE group_no = in_group_no;

   COMMIT;
END ar_delete_group_pr;
/

prompt
prompt Creating procedure AR_DELETE_SUPERVISORINFO
prompt ===========================================
prompt
CREATE OR REPLACE PROCEDURE ar_delete_supervisorinfo (
   in_supervisor_id       IN   VARCHAR2,
   in_supervised_deptid   IN   VARCHAR2
)
IS
/******************************************************************************
   NAME:       ar_delete_supervisorInfo
   PURPOSE:    删除考勤员与被考勤部门的关系

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2005-5-20   chengwei       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     ar_add_supervisorInfo
      Sysdate:         2005-5-20
      Date and Time:   2005-5-20, 12:04:05, and 2005-5-20 12:04:05
      Username:         (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   DELETE      ar_supervisor_info
         WHERE ar_supervisor_id = in_supervisor_id
           AND supervised_deptid = in_supervised_deptid;

   COMMIT;
END ar_delete_supervisorinfo;
/

prompt
prompt Creating procedure AR_DETAIL_CALCULATE
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE AR_DETAIL_CALCULATE(IN_EMPID       VARCHAR2,
                                                IN_AR_DATE_STR VARCHAR2,
                                                OUT_STR        OUT VARCHAR2)
  AUTHID CURRENT_USER IS
  VAR_COUNT                  INT; --记数
  VAR_DATETYPE               AR_CALENDER.TYPEID%TYPE; --当日日期类型
  VAR_SHIFTNO                AR_SHIFT010.SHIFT_NO%TYPE; --员工当日班次号
  VAR_PREVIOUS_SHIFTNO       AR_SHIFT010.SHIFT_NO%TYPE; --员工前日班次号
  VAR_NEXT_SHIFTNO           AR_SHIFT010.SHIFT_NO%TYPE; --员工次日班次号
  VAR_GROUPNO                VARCHAR2(10); --员工组号,如未分组则值为'constant'
  VAR_DATESTARTED            DATE; --员工入社日期
  VAR_DATELEFT               DATE; --员工退社日期
  VAR_ITEM_UNIT              AR_ITEM_PARAM.UNIT%TYPE; --考勤项目单位
  VAR_ITEM_UNITVALUE         AR_ITEM_PARAM.UNIT_VALUE%TYPE; --考勤项目最小单位值
  VAR_ITEM_MINVALUE          AR_ITEM_PARAM.MIN_VALUE%TYPE; --项目最小值
  VAR_ITEM_MAXVALUE          AR_ITEM_PARAM.MAX_VALUE%TYPE; --项目最大值
  VAR_ITEM_DEPENDITEM        AR_ITEM_PARAM.DEPEND_ITEM%TYPE; --依赖项目
  VAR_ITEM_REPLACEITEM       AR_ITEM_PARAM.REPLACE_ITEM%TYPE; --替换项目
  VAR_ITEM_CARDFLAG          AR_ITEM_PARAM.CARD_FLAG%TYPE; --是否参考打卡
  VAR_ITEM_CARDFROMFLAG      AR_ITEM_PARAM.CARD_FROM_FLAG%TYPE; --是否参考进厂卡
  VAR_ITEM_CARDFROMOFFSET    AR_ITEM_PARAM.CARD_FROM_OFFSET%TYPE; --与进厂卡差异值
  VAR_ITEM_CARDFROMRELATION  AR_ITEM_PARAM.CARD_FROM_RELATION%TYPE; --与进厂卡关系
  VAR_ITEM_CARDTOFLAG        AR_ITEM_PARAM.CARD_TO_FLAG%TYPE; --是否参考出厂卡
  VAR_ITEM_CARDTOOFFSET      AR_ITEM_PARAM.CARD_TO_OFFSET%TYPE; --与出厂卡差异值
  VAR_ITEM_CARDTORELATION    AR_ITEM_PARAM.CARD_TO_RELATION%TYPE; --与出厂卡关系
  VAR_ITEM_APPLYFLAG         AR_ITEM_PARAM.APPLY_FLAG%TYPE; --是否参考申请
  VAR_ITEM_APPLYTYPE         AR_ITEM_PARAM.APPLY_TYPE%TYPE; --参考申请类型
  VAR_ITEM_APPLYFULLDAYVALUE AR_ITEM_PARAM.APPLY_FULLDAY_VALUE%TYPE; --申请满一日数值
  VAR_ITEM_APPLYCARDPRIORITY AR_ITEM_PARAM.APPLY_CARD_PRIORITY%TYPE; --刷卡与申请优先级
  VAR_ITEM_DATETYPE          AR_ITEM_PARAM.DATE_TYPE%TYPE; --项目有效日期类型
  VAR_INTIME                 AR_MAC_RECORD.R_TIME%TYPE; --入厂刷卡时间
  VAR_OUTTIME                AR_MAC_RECORD.R_TIME%TYPE; --出厂刷卡时间
  VAR_INTIME_OT              AR_MAC_RECORD.R_TIME%TYPE; --入厂刷卡时间
  VAR_OUTTIME_OT             AR_MAC_RECORD.R_TIME%TYPE; --出厂刷卡时间
  VAR_INTIME_OT_SHOW         AR_MAC_RECORD.R_TIME%TYPE; --入厂刷卡时间
  VAR_OUTTIME_OT_SHOW        AR_MAC_RECORD.R_TIME%TYPE; --出厂刷卡时间
  VAR_INTIME_TEMP            DATE;
  VAR_OUTTIME_TEMP           DATE;
  VAR_FROMTIME_ALLOWED       DATE; --允许入厂时间
  VAR_TOTIME_ALLOWED         DATE; --允许出厂时间
  VAR_QUANTITY               AR_DETAIL.QUANTITY%TYPE; --考勤项目数值
  VAR_SHIFTFROMTIME          DATE; --当天应工作开始时间
  VAR_SHIFTTOTIME            DATE; --当天应工作结束时间
  VAR_PERVIOUS_SHIFTFROMTIME DATE; --前日班次开始时间
  VAR_PREVIOUS_SHIFTTOTIME   DATE; --前日班次结束时间
  VAR_NEXT_SHIFTFROMTIME     DATE; --次日班次开始时间
  VAR_NEXT_SHIFTTOTIME       DATE; --次日班次结束时间
  VAR_SHIFTHOUR              AR_DETAIL.QUANTITY%TYPE; --当天应出勤小时数
  VAR_QUANTITY_HOUR          NUMBER(6,2);--当天实际工作时间
  VAR_ABSENT_START           DATE;--旷工开始时间
  VAR_ABSENT_END             DATE;--旷工结束时间
  VAR_TODAY_START            DATE;
  VAR_TODAY_END              DATE;
  VAR_I                      NUMBER;
  VAR_NEXT_ITEM_NO           NUMBER;
  VAR_LOG_LEVEL              INT := 1;
  VAR_FINAL_ITEM_NORMAL      INT := 15; -- 常量，"正常出勤"的考勤项目号15
  VAR_FINAL_ITEM_ABSENT      INT := 8; -- 常量，"旷工"的考勤项目号8
  VAR_FINAL_ITEM_HOLIDAY     INT := 30; -- 常量，"休息"的考勤项目号30
  VAR_FINAL_ITEM_TARDINESS   INT := 1; -- 常量，"迟到"的考勤项目号1
  VAR_FINAL_ITEM_TRUANCY     INT := 39; -- 常量，"早退"的考勤项目号2  
  VAR_OT_FROM_TIME           DATE;
  VAR_OT_TO_TIME             DATE; 
  /******************************************************************************
     NAME:       AR_DETAIL_CALCULATE
     PURPOSE:    计算考勤明细
  
     NOTES:
       1.清除 AR_DETAIL 表中未锁定记录
       2.处理班次项目:基于不同的班次项目生成记录
       3.处理申请项目:基于不同的休假项目生成记录
       4.处理班次项目数据和申请项目数据的时间，保留真实的班次和休假的开始结束时间
       5.如果有迟到早退情况，添加迟到早退项目
       6.汇总 AR_DETAIL_TEMP 表中记录,写进 AR_DETAIL, 并对数值进行格式化
       7.删除 AR_DETAIL 表中数值不符合上下限的记录
     
     MARK：
       1.ESS验证中，加班与加班不能重叠申请
       2.ESS验证中，加班与休假不能重叠申请
       3.ESS验证中，加班申请必须符合当日班次信息
  ******************************************************************************/
BEGIN
  
  DBMS_OUTPUT.ENABLE(5000000);

  /*取得该员工在某天的班次和数据类型，数据类型：平时，周末，法定假*/
  VAR_SHIFTNO          := AR_GET_SHIFTNO(IN_EMPID, IN_AR_DATE_STR);
  dbms_output.put_line('当日班次号：'||VAR_SHIFTNO);
  VAR_PREVIOUS_SHIFTNO := AR_GET_SHIFTNO(IN_EMPID,
                                         TO_CHAR(TO_DATE(IN_AR_DATE_STR,
                                                         'YYYY-MM-DD') - 1,
                                                 'YYYY/MM/DD'));
  dbms_output.put_line('前日班次号：'||VAR_PREVIOUS_SHIFTNO);
  VAR_NEXT_SHIFTNO     := AR_GET_SHIFTNO(IN_EMPID,
                                         TO_CHAR(TO_DATE(IN_AR_DATE_STR,
                                                         'YYYY-MM-DD') + 1,
                                                 'YYYY/MM/DD'));
  dbms_output.put_line('次日班次号：'||VAR_NEXT_SHIFTNO);
  VAR_DATETYPE         := AR_GET_DATETYPE(IN_EMPID, IN_AR_DATE_STR);
  /*获取次日是否是假期，用于跨日班次判断*/
  SELECT AR_ITEM_NO INTO VAR_NEXT_ITEM_NO FROM AR_SHIFT020 WHERE SHIFT_NO = VAR_NEXT_SHIFTNO AND ROWNUM = 1;

  /*如果 AR_DETAIL 表中已有当日锁定记录,则跳出计算*/
  SELECT COUNT(*)
    INTO VAR_COUNT
    FROM AR_DETAIL
   WHERE EMPID = IN_EMPID
     AND AR_DATE_STR = IN_AR_DATE_STR
     AND LOCK_YN = 'Y';
  IF VAR_COUNT > 0 THEN
    OUT_STR := '当天记录已锁定';
  
    --IF VAR_LOG_LEVEL > 0
    --THEN
    --DBMS_OUTPUT.PUT_LINE (OUT_STR);
    --END IF;
  
    RETURN;
  END IF;
  /*清除 AR_DETAIL 表中未上锁记录*/
  DELETE FROM AR_DETAIL
   WHERE EMPID = IN_EMPID
     AND AR_DATE_STR = IN_AR_DATE_STR
     AND (LOCK_YN <> 'Y' OR LOCK_YN IS NULL);

COMMIT;

  BEGIN
    /*取员工入退社日期*/
    SELECT JOIN_DATE, LEFT_DATE
      INTO VAR_DATESTARTED, VAR_DATELEFT
      FROM HR_EMPLOYEE
     WHERE EMPID = IN_EMPID;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      OUT_STR := '员工不存在';
    
      --IF VAR_LOG_LEVEL > 0
      --THEN
      --DBMS_OUTPUT.PUT_LINE (OUT_STR);
      --END IF;
    
      RETURN;
  END;
  /*判断员工是否入社*/
  IF VAR_DATESTARTED > TO_DATE(IN_AR_DATE_STR, 'YYYY/MM/DD') THEN
    OUT_STR := '员工尚未入社';
  
    --IF VAR_LOG_LEVEL > 0
    --THEN
    --DBMS_OUTPUT.PUT_LINE (OUT_STR);
    --END IF;
  
    RETURN;
  END IF;
  /*判断员工是否退社*/
  IF VAR_DATELEFT < TO_DATE(IN_AR_DATE_STR, 'YYYY/MM/DD') THEN
    OUT_STR := '员工已退社';
  
    --IF VAR_LOG_LEVEL > 0
    --THEN
    --DBMS_OUTPUT.PUT_LINE (OUT_STR);
    --END IF;
  
    RETURN;
  END IF;

  BEGIN
    /*取员工所在组号,若无组信息则为'constant'*/
    SELECT GROUP_NO
      INTO VAR_GROUPNO
      FROM AR_DYNAMIC_GROUP_EMP
     WHERE EMPID = IN_EMPID;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      VAR_GROUPNO := 'constant';
    WHEN OTHERS THEN
      OUT_STR := '取员工分组信息错误,请检查设置';
    
      --IF VAR_LOG_LEVEL > 0
      --THEN
      --DBMS_OUTPUT.PUT_LINE (OUT_STR);
      --END IF;
    
      RETURN;
  END;

  BEGIN
    /*取出前日班次标准开始、结束时间*/
    SELECT /*+ALL_ROWS*/
     MIN(BEGIN_DAY_OFFSET +
         TO_DATE(IN_AR_DATE_STR || ' ' || TO_CHAR(FROM_TIME, 'HH24:mi:ss'),
                 'YYYY/MM/DD HH24:mi:ss') - 1),
     MAX(END_DAY_OFFSET +
         TO_DATE(IN_AR_DATE_STR || ' ' || TO_CHAR(TO_TIME, 'HH24:mi:ss'),
                 'YYYY/MM/DD HH24:mi:ss') - 1)
      INTO VAR_PERVIOUS_SHIFTFROMTIME, VAR_PREVIOUS_SHIFTTOTIME
      FROM AR_SHIFT020
     WHERE SHIFT_NO = VAR_PREVIOUS_SHIFTNO;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      VAR_PREVIOUS_SHIFTTOTIME := TO_DATE(IN_AR_DATE_STR || ' 00:00:00',
                                          'YYYY/MM/DD HH24:MI:SS') - 1;
  END;
  dbms_output.put_line('前日班次开始时间：'||TO_CHAR(VAR_PERVIOUS_SHIFTFROMTIME,'yyyy/mm/dd hh24:mi:ss'));
  dbms_output.put_line('前日班次结束时间：'||TO_CHAR(VAR_PREVIOUS_SHIFTTOTIME,'yyyy/mm/dd hh24:mi:ss'));
  BEGIN
    /*取出次日班次标准开始、结束时间*/
    SELECT /*+ALL_ROWS*/
     MIN(BEGIN_DAY_OFFSET +
         TO_DATE(IN_AR_DATE_STR || ' ' || TO_CHAR(FROM_TIME, 'HH24:mi:ss'),
                 'YYYY/MM/DD HH24:mi:ss') + 1),
     MAX(END_DAY_OFFSET +
         TO_DATE(IN_AR_DATE_STR || ' ' || TO_CHAR(TO_TIME, 'HH24:mi:ss'),
                 'YYYY/MM/DD HH24:mi:ss') + 1)
      INTO VAR_NEXT_SHIFTFROMTIME, VAR_NEXT_SHIFTTOTIME
      FROM AR_SHIFT020
     WHERE SHIFT_NO = VAR_NEXT_SHIFTNO;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      VAR_NEXT_SHIFTFROMTIME := TO_DATE(IN_AR_DATE_STR || ' 23:59:00',
                                        'YYYY/MM/DD HH24:MI:SS') + 1;
  END;
  dbms_output.put_line('次日班次开始时间：'||TO_CHAR(VAR_NEXT_SHIFTFROMTIME,'yyyy/mm/dd hh24:mi:ss'));
  dbms_output.put_line('次日班次结束时间：'||TO_CHAR(VAR_NEXT_SHIFTTOTIME,'yyyy/mm/dd hh24:mi:ss'));

  
  
  BEGIN
    /*取出当天标准上下班时间以及应工作时间*/
    SELECT /*+ALL_ROWS*/
     MIN(BEGIN_DAY_OFFSET -- 对于“常白班”等班次可能存在多条班次信息
         + TO_DATE(IN_AR_DATE_STR || ' ' ||
                   TO_CHAR(FROM_TIME, 'HH24:mi:ss'),
                   'YYYY/MM/DD HH24:mi:ss')),
     MAX(END_DAY_OFFSET +
         TO_DATE(IN_AR_DATE_STR || ' ' || TO_CHAR(TO_TIME, 'HH24:mi:ss'),
                 'YYYY/MM/DD HH24:mi:ss')),
     SUM(((END_DAY_OFFSET +
         TO_DATE(IN_AR_DATE_STR || ' ' || TO_CHAR(TO_TIME, 'HH24:mi:ss'),
                   'YYYY/MM/DD HH24:mi:ss')) -
         (BEGIN_DAY_OFFSET +
         TO_DATE(IN_AR_DATE_STR || ' ' ||
                   TO_CHAR(FROM_TIME, 'HH24:mi:ss'),
                   'YYYY/MM/DD HH24:mi:ss'))) * 24)
      INTO VAR_SHIFTFROMTIME, VAR_SHIFTTOTIME, VAR_SHIFTHOUR
      FROM AR_SHIFT020
     WHERE SHIFT_NO = VAR_SHIFTNO
       AND AR_ITEM_NO =
           DECODE(VAR_DATETYPE, 1, VAR_FINAL_ITEM_NORMAL, AR_ITEM_NO);
    -- 对于数据类型为"平时"，需要加上考勤项目为"正常出勤"的条件,班次有可能对应其他的考勤项目，
    --  例如：有默认加班时，会对应考勤项目"平时加班"，计算应工作时间不应该包含这部分时间
    -- 查询加班信息表和请假信息表，并插入ESS_APPLY_RESULT中
    VAR_TODAY_START := VAR_SHIFTFROMTIME;
    VAR_TODAY_END := VAR_SHIFTTOTIME;
    
    VAR_ABSENT_END := NULL;
    dbms_output.put_line('当日班次开始时间：'||TO_CHAR(VAR_SHIFTFROMTIME,'yyyy/mm/dd hh24:mi:ss'));
    dbms_output.put_line('当日班次结束时间：'||TO_CHAR(VAR_SHIFTTOTIME,'yyyy/mm/dd hh24:mi:ss'));
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      /*如果取不出当天应工作时间(休息的班次),则取一整天做为始末时间, 取0作为当日应出勤小时*/
      VAR_SHIFTFROMTIME := TO_DATE(IN_AR_DATE_STR || ' 00:00:00',
                                   'YYYY/MM/DD HH24:MI:SS');
      VAR_SHIFTTOTIME   := VAR_SHIFTFROMTIME + 1;
      VAR_SHIFTHOUR     := 0;
  END;
  /*如果应工作时间段始末相等,则取一整天做为始末时间*/
  IF VAR_SHIFTFROMTIME = VAR_SHIFTTOTIME THEN
    VAR_SHIFTFROMTIME := TO_DATE(IN_AR_DATE_STR || ' 00:00:00',
                                 'YYYY/MM/DD HH24:MI:SS');
    VAR_SHIFTTOTIME   := VAR_SHIFTFROMTIME + 1;
  END IF;

  --IF VAR_LOG_LEVEL > 0
  --THEN
  --DBMS_OUTPUT.PUT_LINE ('var_shiftno:' || TO_CHAR (VAR_SHIFTNO));
  --DBMS_OUTPUT.PUT_LINE ('var_groupno:' || TO_CHAR (VAR_GROUPNO));
  --DBMS_OUTPUT.PUT_LINE ('var_datetype:' || TO_CHAR (VAR_DATETYPE));
  --END IF;

  /***************************************班次项目循环开始************************************/
  DECLARE
  
    /*针对不同的项目取出当天标准开始结束时间*/
    CURSOR CUR_AR_SHIFT IS
      SELECT /*+ALL_ROWS*/
       MIN(BEGIN_DAY_OFFSET -- 班次可能存在多条班次信息
           + TO_DATE(IN_AR_DATE_STR || ' ' ||
                     TO_CHAR(FROM_TIME, 'HH24:mi:ss'),
                     'YYYY/MM/DD HH24:mi:ss')) FROM_TIME,
       MAX(END_DAY_OFFSET +
           TO_DATE(IN_AR_DATE_STR || ' ' || TO_CHAR(TO_TIME, 'HH24:mi:ss'),
                   'YYYY/MM/DD HH24:mi:ss')) TO_TIME,
       AR_ITEM_NO
        FROM AR_SHIFT020
       WHERE SHIFT_NO = VAR_SHIFTNO
       GROUP BY AR_ITEM_NO;
  
    AR_SHIFT_ROW CUR_AR_SHIFT%ROWTYPE;
  BEGIN
    OPEN CUR_AR_SHIFT;
  
    /*循环班次CURSOR*/
    LOOP
      FETCH CUR_AR_SHIFT
        INTO AR_SHIFT_ROW;
    
      EXIT WHEN CUR_AR_SHIFT%NOTFOUND;
    
      IF VAR_COUNT < 1 THEN
        /*日志输出：班次对应的项目，开始结束时间*/
        IF VAR_LOG_LEVEL > 0 THEN
          DBMS_OUTPUT.PUT_LINE('=====班次项目=====' ||
                               TO_CHAR(AR_SHIFT_ROW.AR_ITEM_NO));
          DBMS_OUTPUT.PUT_LINE('from_time');
          DBMS_OUTPUT.PUT_LINE(TO_CHAR(AR_SHIFT_ROW.FROM_TIME,
                                       'YYYY-MM-DD HH24:MI:SS'));
          DBMS_OUTPUT.PUT_LINE('to_time');
          DBMS_OUTPUT.PUT_LINE(TO_CHAR(AR_SHIFT_ROW.TO_TIME,
                                       'YYYY-MM-DD HH24:MI:SS'));
        END IF;
      
        BEGIN
          /*取当前班次对应的考勤项目的参数*/
          SELECT /*+ALL_ROWS*/
           UNIT,
           UNIT_VALUE,
           MIN_VALUE,
           MAX_VALUE,
           DEPEND_ITEM,
           REPLACE_ITEM,
           CARD_FLAG,
           CARD_FROM_FLAG,
           CARD_FROM_OFFSET,
           CARD_FROM_RELATION,
           CARD_TO_FLAG,
           CARD_TO_OFFSET,
           CARD_TO_RELATION,
           APPLY_FLAG,
           APPLY_TYPE,
           APPLY_FULLDAY_VALUE,
           APPLY_CARD_PRIORITY,
           DATE_TYPE
            INTO VAR_ITEM_UNIT,
                 VAR_ITEM_UNITVALUE,
                 VAR_ITEM_MINVALUE,
                 VAR_ITEM_MAXVALUE,
                 VAR_ITEM_DEPENDITEM,
                 VAR_ITEM_REPLACEITEM,
                 VAR_ITEM_CARDFLAG,
                 VAR_ITEM_CARDFROMFLAG,
                 VAR_ITEM_CARDFROMOFFSET,
                 VAR_ITEM_CARDFROMRELATION,
                 VAR_ITEM_CARDTOFLAG,
                 VAR_ITEM_CARDTOOFFSET,
                 VAR_ITEM_CARDTORELATION,
                 VAR_ITEM_APPLYFLAG,
                 VAR_ITEM_APPLYTYPE,
                 VAR_ITEM_APPLYFULLDAYVALUE,
                 VAR_ITEM_APPLYCARDPRIORITY,
                 VAR_ITEM_DATETYPE
            FROM AR_ITEM_PARAM
           WHERE AR_ITEM_NO = AR_SHIFT_ROW.AR_ITEM_NO
             AND AR_GROUP_NO = -- 如果该员工隶属动态组，并且该组对应某项目有设置，优先取动态组对应项目
                 CASE (SELECT COUNT(*)
                     FROM AR_ITEM_PARAM AIP
                    WHERE AIP.AR_ITEM_NO = AR_SHIFT_ROW.AR_ITEM_NO
                      AND AIP.AR_GROUP_NO = VAR_GROUPNO)
                   WHEN 1 THEN
                    VAR_GROUPNO
                   ELSE
                    'constant'
                 END;
        EXCEPTION
          WHEN NO_DATA_FOUND -- 考勤项目没有对应的参数，退出procedure
           THEN
            OUT_STR := '考勤项目 (' || TO_CHAR(AR_SHIFT_ROW.AR_ITEM_NO) ||
                       ') 设置错误,请检查设置';
          
            IF VAR_LOG_LEVEL > 0 THEN
              --DBMS_OUTPUT.PUT_LINE (OUT_STR);
              RETURN;
            END IF;
        END;
      
        /********************************判断是否参考打卡********************************/
      
        /*参考打卡*/
        IF VAR_ITEM_CARDFLAG = 1 THEN
        
          -- 根据考勤项目单位，统一将打卡的开始和结束位移时间换算成“天”的单位
          CASE VAR_ITEM_UNIT
            WHEN 'MINUTE' THEN
              BEGIN
                VAR_ITEM_CARDFROMOFFSET := VAR_ITEM_CARDFROMOFFSET / 24 / 60;
                VAR_ITEM_CARDTOOFFSET   := VAR_ITEM_CARDTOOFFSET / 24 / 60;
              END;
            WHEN 'HOUR' THEN
              BEGIN
                VAR_ITEM_CARDFROMOFFSET := VAR_ITEM_CARDFROMOFFSET / 24;
                VAR_ITEM_CARDTOOFFSET   := VAR_ITEM_CARDTOOFFSET / 24;
              END;
            WHEN 'DAY' THEN
              BEGIN
                VAR_ITEM_CARDFROMOFFSET := VAR_ITEM_CARDFROMOFFSET;
                VAR_ITEM_CARDTOOFFSET   := VAR_ITEM_CARDTOOFFSET;
              END;
            ELSE
              BEGIN
                OUT_STR := '考勤项目 (' || TO_CHAR(AR_SHIFT_ROW.AR_ITEM_NO) ||
                           ') 单位设置错误,请检查设置';
              
                --IF VAR_LOG_LEVEL > 0
                --THEN
                --DBMS_OUTPUT.PUT_LINE (OUT_STR);
                --END IF;
              
                RETURN;
              END;
          END CASE;
        
          /*根据考勤项目的打卡开始时间的偏移方向，取得最终入厂的允许时间*/
          CASE VAR_ITEM_CARDFROMRELATION
            WHEN '＞' THEN
              VAR_FROMTIME_ALLOWED := AR_SHIFT_ROW.FROM_TIME +
                                      VAR_ITEM_CARDFROMOFFSET;
            WHEN '＜' THEN
              VAR_FROMTIME_ALLOWED := AR_SHIFT_ROW.FROM_TIME -
                                      VAR_ITEM_CARDFROMOFFSET;
            ELSE
              VAR_FROMTIME_ALLOWED := AR_SHIFT_ROW.FROM_TIME;
          END CASE;
        
          /*根据考勤项目的打卡结束时间的偏移方向，取得最终出厂的允许时间*/
          CASE VAR_ITEM_CARDTORELATION
            WHEN '＞' THEN
              VAR_TOTIME_ALLOWED := AR_SHIFT_ROW.TO_TIME +
                                    VAR_ITEM_CARDTOOFFSET;
            WHEN '＜' THEN
              VAR_TOTIME_ALLOWED := AR_SHIFT_ROW.TO_TIME -
                                    VAR_ITEM_CARDTOOFFSET;
            ELSE
              VAR_TOTIME_ALLOWED := AR_SHIFT_ROW.TO_TIME;
          END CASE;
          
          DBMS_OUTPUT.PUT_LINE('允许入场时间：'||TO_CHAR(VAR_FROMTIME_ALLOWED,'YYYY/MM/DD HH24:MI:SS'));
          DBMS_OUTPUT.PUT_LINE('允许出场时间：'||TO_CHAR(VAR_TOTIME_ALLOWED,'YYYY/MM/DD HH24:MI:SS'));
          
          /*判断是否参考入厂打卡数据*/
        
          /*参考入厂打卡数据*/
          IF VAR_ITEM_CARDFROMFLAG = 1 THEN
            BEGIN
              /*取前日下班后，当日上班前间隙后半段最晚时间作为入门时间*/  
              SELECT 
                  MAX(A.R_TIME) INTO VAR_INTIME
                  FROM AR_MAC_RECORD A
                  WHERE A.EMPID = IN_EMPID
                  AND A.ACTIVITY = 1
                  AND A.R_TIME <= VAR_FROMTIME_ALLOWED
                  AND A.R_TIME >= CASE
                      WHEN (VAR_PREVIOUS_SHIFTTOTIME >= VAR_FROMTIME_ALLOWED) -- 如果前日下班时间大于当日上班时间
                      THEN
                           VAR_PERVIOUS_SHIFTFROMTIME
                      ELSE
                           VAR_FROMTIME_ALLOWED-1/12                          -- 必须取上班时间前两个小时内打卡时间方可作为入门打卡时间
                      END;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                VAR_INTIME := TO_DATE(NULL);
            END;
          
            /*如果进门时间没有取到，取标准上班时间之后，标准下班时间之前的第一次入厂卡*/
            IF VAR_INTIME IS NULL THEN
              BEGIN
                SELECT
                     MIN(A.R_TIME) INTO VAR_INTIME
                     FROM AR_MAC_RECORD A
                     WHERE A.EMPID = IN_EMPID
                     AND A.ACTIVITY = 1
                     AND A.R_TIME > VAR_FROMTIME_ALLOWED
                     AND A.R_TIME < AR_SHIFT_ROW.TO_TIME;
              EXCEPTION
                WHEN NO_DATA_FOUND THEN
                  VAR_INTIME := TO_DATE(NULL);
              END;
            END IF;
    
          
            /*不参考入厂打卡数据*/
          ELSE
            /*如果不参考入厂卡,则取班次开始时间为入厂时间*/
            VAR_INTIME := AR_SHIFT_ROW.FROM_TIME;
          END IF;
        
          IF VAR_LOG_LEVEL > 0 THEN
            DBMS_OUTPUT.PUT_LINE('入厂时间: ' ||
                                 TO_CHAR(VAR_INTIME,
                                         'YYYY-MM-DD HH24:MI:SS'));
          END IF;
        
          /*参考出厂打卡数据*/
          IF VAR_ITEM_CARDTOFLAG = 1 THEN
            /*取标准下班时间之后三个小时以内第一个出厂卡*/
            BEGIN
              SELECT 
                  MIN(A.R_TIME) INTO VAR_OUTTIME
              FROM AR_MAC_RECORD A
              WHERE A.EMPID = IN_EMPID
              AND A.ACTIVITY= 1
              AND A.R_TIME >= VAR_TOTIME_ALLOWED
              AND A.R_TIME < CASE
                  WHEN (VAR_TOTIME_ALLOWED >= VAR_NEXT_SHIFTFROMTIME) -- 如果当日下班时间大于等于次日下班时间
                  THEN
                       VAR_NEXT_SHIFTTOTIME
                  ELSE
                       VAR_TOTIME_ALLOWED+3/24
                  END;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                VAR_OUTTIME := TO_DATE(NULL);
            END;
          
            /*如果出门时间没有取到，取标准上班时间之后，标准下班时间之前的最后一个出厂卡*/
            IF VAR_OUTTIME IS NULL THEN
              BEGIN
                  SELECT
                      MAX(A.R_TIME) INTO VAR_OUTTIME
                  FROM AR_MAC_RECORD A
                  WHERE A.EMPID = IN_EMPID
                  AND A.ACTIVITY = 1
                  AND A.R_TIME > VAR_FROMTIME_ALLOWED
                  AND A.R_TIME < VAR_TOTIME_ALLOWED;
              EXCEPTION
                WHEN NO_DATA_FOUND THEN
                  VAR_OUTTIME := TO_DATE(NULL);
              END;
            END IF;
          
          
          
            /*不参考出厂打卡数据*/
          ELSE
            /*如果不参考出厂卡,则取班次结束时间为出厂时间*/
            VAR_OUTTIME := AR_SHIFT_ROW.TO_TIME;
          END IF;
        
          IF VAR_LOG_LEVEL > 0 THEN
            DBMS_OUTPUT.PUT_LINE('出厂时间' ||
                                 TO_CHAR(VAR_OUTTIME,
                                         'YYYY-MM-DD HH24:MI:SS'));
          END IF;
        
          /*不参考打卡*/
        ELSE
          /*如果不参考打卡,则取班次始末时间为入出厂时间*/
          VAR_INTIME  := AR_SHIFT_ROW.FROM_TIME;
          VAR_OUTTIME := AR_SHIFT_ROW.TO_TIME;
        END IF;
        /*******************************判断是否参考打卡结束*************************************/
         
        dbms_output.put_line('当日进门时间2：'||TO_CHAR(VAR_INTIME,'yyyy/mm/dd hh24:mi:ss'));
        dbms_output.put_line('当日出门时间2：'||TO_CHAR(VAR_OUTTIME,'yyyy/mm/dd hh24:mi:ss'));
        /******************************************************************************************/
        
        /*当前项目记录置于临时表中*/
        INSERT INTO /*+APPEND*/
        AR_DETAIL_TEMP
          (NO,
           EMPID,
           AR_ITEM_NO,
           FROM_TIME,
           TO_TIME,
           SHIFT_NO,
           AR_DATE_STR,
           AR_MONTH_STR,
           QUANTITY,
           LOCK_YN,
           DATE_TYPE,
           UNIT,
           ITEM_TYPE)
        VALUES
          (AR_DETAIL_TEMP_SEQ.NEXTVAL,
           IN_EMPID,
           AR_SHIFT_ROW.AR_ITEM_NO,
           VAR_INTIME,
           VAR_OUTTIME,
           VAR_SHIFTNO,
           IN_AR_DATE_STR,
           TO_CHAR(TO_DATE(IN_AR_DATE_STR, 'YYYY/MM/DD'), 'yyyymm'),
           0,
           'N',
           VAR_DATETYPE,
           VAR_ITEM_UNIT,
           3);
      
      END IF;
    
    END LOOP;
  
    CLOSE CUR_AR_SHIFT;
  END;

  /***************************************班次项目循环结束************************************/

  /***************************************申请项目循环开始************************************/
  BEGIN
    /*取出当天标准上下班时间以及应工作时间*/
    SELECT /*+ALL_ROWS*/
     MIN(BEGIN_DAY_OFFSET -- 对于“常白班”等班次可能存在多条班次信息
         + TO_DATE(IN_AR_DATE_STR || ' ' ||
                   TO_CHAR(FROM_TIME, 'HH24:mi:ss'),
                   'YYYY/MM/DD HH24:mi:ss')),
     MAX(END_DAY_OFFSET +
         TO_DATE(IN_AR_DATE_STR || ' ' || TO_CHAR(TO_TIME, 'HH24:mi:ss'),
                 'YYYY/MM/DD HH24:mi:ss')),
     SUM(((END_DAY_OFFSET +
         TO_DATE(IN_AR_DATE_STR || ' ' || TO_CHAR(TO_TIME, 'HH24:mi:ss'),
                   'YYYY/MM/DD HH24:mi:ss')) -
         (BEGIN_DAY_OFFSET +
         TO_DATE(IN_AR_DATE_STR || ' ' ||
                   TO_CHAR(FROM_TIME, 'HH24:mi:ss'),
                   'YYYY/MM/DD HH24:mi:ss'))) * 24)
      INTO VAR_SHIFTFROMTIME, VAR_SHIFTTOTIME, VAR_SHIFTHOUR
      FROM AR_SHIFT020
     WHERE SHIFT_NO = VAR_SHIFTNO
       AND AR_ITEM_NO =
           DECODE(VAR_DATETYPE, 1, VAR_FINAL_ITEM_NORMAL, AR_ITEM_NO);
    -- 对于数据类型为"平时"，需要加上考勤项目为"正常出勤"的条件,班次有可能对应其他的考勤项目，
    --  例如：有默认加班时，会对应考勤项目"平时加班"，计算应工作时间不应该包含这部分时间
    -- 查询加班信息表和请假信息表，并插入ESS_APPLY_RESULT中
    VAR_TODAY_START := VAR_SHIFTFROMTIME;
    VAR_TODAY_END := VAR_SHIFTTOTIME;
    
    VAR_ABSENT_END := NULL;
    dbms_output.put_line('当日班次开始时间：'||TO_CHAR(VAR_SHIFTFROMTIME,'yyyy/mm/dd hh24:mi:ss'));
    dbms_output.put_line('当日班次结束时间：'||TO_CHAR(VAR_SHIFTTOTIME,'yyyy/mm/dd hh24:mi:ss'));
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      /*如果取不出当天应工作时间(休息的班次),则取一整天做为始末时间, 取0作为当日应出勤小时*/
      VAR_SHIFTFROMTIME := TO_DATE(IN_AR_DATE_STR || ' 00:00:00',
                                   'YYYY/MM/DD HH24:MI:SS');
      VAR_SHIFTTOTIME   := VAR_SHIFTFROMTIME + 1;
      VAR_SHIFTHOUR     := 0;
  END;
  /*如果应工作时间段始末相等,则取一整天做为始末时间*/
  IF VAR_SHIFTFROMTIME = VAR_SHIFTTOTIME THEN
    VAR_SHIFTFROMTIME := TO_DATE(IN_AR_DATE_STR || ' 00:00:00',
                                 'YYYY/MM/DD HH24:MI:SS');
    VAR_SHIFTTOTIME   := VAR_SHIFTFROMTIME + 1;
  END IF;
    dbms_output.put_line('当日进门时间3：'||TO_CHAR(VAR_INTIME,'yyyy/mm/dd hh24:mi:ss'));
    dbms_output.put_line('当日出门时间3：'||TO_CHAR(VAR_OUTTIME,'yyyy/mm/dd hh24:mi:ss'));
  IF VAR_LOG_LEVEL > 0 THEN
    DBMS_OUTPUT.PUT_LINE('申请项目循环开始');
    DBMS_OUTPUT.PUT_LINE('应工作开始时间: ' ||
                         TO_CHAR(VAR_SHIFTFROMTIME,
                                 'YYYY-MM-DD HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('应工作结束时间: ' ||
                         TO_CHAR(VAR_SHIFTTOTIME, 'YYYY-MM-DD HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('应工作小时数: ' || TO_CHAR(VAR_SHIFTHOUR));
  END IF;
  
  /*申请项目条件:1.申请标志, 2.活跃性, 3.组号(有组号时取组号项,无组号时取constant项)*/

  /*取得所有的考勤项目以及项目对应的申请类型，条件："有效日期类型"包含员工当天对应的数据类型*/
  DECLARE
    CURSOR CUR_AR_APPLY IS
      SELECT /*+INDEX(AR_ITEM PK_AR_ITEM)*/
       AR_ITEM.ITEM_NO, AR_ITEM_PARAM.APPLY_TYPE, AR_ITEM.ITEM_GROUP_CODE
        FROM AR_ITEM, AR_ITEM_PARAM
       WHERE AR_ITEM.ITEM_NO = AR_ITEM_PARAM.AR_ITEM_NO
         AND AR_ITEM.ACTIVITY = 1
         AND AR_ITEM_PARAM.APPLY_FLAG = 1 -- 参考申请标志为"是"
         AND AR_ITEM_PARAM.ACTIVITY = 1
            --WooriBank休息日也要计算出平日加班怪异的明细特注。其它项目应保留-updated by LIUZHENGYANG AT 2011-2-15
         AND INSTR (AR_ITEM_PARAM.DATE_TYPE, VAR_DATETYPE) <> 0     -- 该考勤项目的有效日期类型里是否包含员工当天的数据类型
         AND AR_ITEM_PARAM.AR_GROUP_NO =
             CASE (SELECT COUNT(*)
                 FROM AR_ITEM_PARAM AIP
                WHERE AIP.AR_ITEM_NO = AR_ITEM.ITEM_NO
                  AND AIP.AR_GROUP_NO = VAR_GROUPNO)
               WHEN 1 THEN
                VAR_GROUPNO
               ELSE
                'constant'
             END;
  
    AR_APPLY_ROW CUR_AR_APPLY%ROWTYPE;
  BEGIN
    --插入加班信息到表中,加班信息中有扣除时数信息
    INSERT INTO AR_APPLY_RESULT(
           APPLY_NO,
           EMPID,
           APPLY_TYPE,
           APPLY_DATE,
           FROM_TIME,
           TO_TIME,
           APPLY_DEDUCT)
    SELECT AR_APPLY_RESULT_SEQ.NEXTVAL,
           EMPID,
           OT_TYPE_CODE,
           TO_CHAR(TO_DATE(OT_FROM_TIME,'yyyy-mm-dd hh24:mi:ss'),'yyyy/mm/dd'),
           TO_DATE(OT_FROM_TIME,'yyyy-mm-dd hh24:mi:ss'),
           TO_DATE(OT_TO_TIME,'yyyy-mm-dd hh24:mi:ss'),
           OT_DEDUCTION*60
    FROM   ESS_APPLY_OT
    WHERE  EMPID = IN_EMPID
    AND    AFFIRM_FLAG = 1
    AND    ACTIVITY = 1
    AND    TO_DATE(IN_AR_DATE_STR,'YYYY/MM/DD') BETWEEN TO_DATE(SUBSTR(OT_FROM_TIME,0,10),'yyyy-mm-dd')
    AND    TO_DATE(SUBSTR(OT_TO_TIME,0,10),'yyyy-mm-dd')+1;
  
    --插入请假信息，请假信息无扣除时数
    INSERT INTO AR_APPLY_RESULT(
           APPLY_NO,
           EMPID,
           APPLY_TYPE,
           APPLY_DATE,
           FROM_TIME,
           TO_TIME,
           APPLY_DEDUCT)
    SELECT AR_APPLY_RESULT_SEQ.NEXTVAL,
           EMPID,
           LEAVE_TYPE_CODE,
           TO_CHAR(LEAVE_FROM_TIME,'yyyy/mm/dd'),
           LEAVE_FROM_TIME,
           LEAVE_TO_TIME,
           0
    FROM   ESS_APPLY_LEAVE
    WHERE  EMPID = IN_EMPID
    AND    AFFIRM_FLAG = 1
    AND    ACTIVITY = 1
    AND    TO_DATE(IN_AR_DATE_STR,'YYYY/MM/DD') BETWEEN TO_DATE(TO_CHAR(LEAVE_FROM_TIME,'yyyy/mm/dd'),'YYYY/MM/DD')
    AND    TO_DATE(TO_CHAR(LEAVE_TO_TIME,'yyyy/mm/dd'),'YYYY/MM/DD')+1;
    
    --插入出差信息，出差信息无扣除时数
    INSERT INTO AR_APPLY_RESULT(
           APPLY_NO,
           EMPID,
           APPLY_TYPE,
           APPLY_DATE,
           FROM_TIME,
           TO_TIME,
           APPLY_DEDUCT)
    SELECT AR_APPLY_RESULT_SEQ.NEXTVAL,
           EMPID,
           DECODE(BT_TYPE_CODE, 'BT2', 'WT2', 'WT1'),
           TO_CHAR(BT_FROM_TIME,'YYYY/MM/DD'),
           BT_FROM_TIME,
           BT_TO_TIME,
           0
    FROM   ESS_APPLY_BT
    WHERE  EMPID = IN_EMPID
    AND    AFFIRM_FLAG = 1
    AND    ACTIVITY = 1
    AND    TO_DATE(IN_AR_DATE_STR,'YYYY/MM/DD') BETWEEN TO_DATE(TO_CHAR(BT_FROM_TIME,'yyyy/mm/dd'),'YYYY/MM/DD')
    AND    TO_DATE(TO_CHAR(BT_TO_TIME,'yyyy/mm/dd'),'YYYY/MM/DD')+1;
           
  
  
    OPEN CUR_AR_APPLY;
    
    LOOP
      FETCH CUR_AR_APPLY
        INTO AR_APPLY_ROW;
    
      EXIT WHEN CUR_AR_APPLY%NOTFOUND;
    
      /*如果 AR_DETAIL 表中已有该项目锁定记录,则跳过该循环*/
      SELECT COUNT(*)
        INTO VAR_COUNT
        FROM AR_DETAIL
       WHERE EMPID = IN_EMPID
         AND AR_DATE_STR = IN_AR_DATE_STR
         AND AR_ITEM_NO = AR_APPLY_ROW.ITEM_NO
         AND LOCK_YN = 'Y';
    
      IF VAR_COUNT < 1 THEN
        BEGIN
          /*取项目参数*/
          SELECT /*+ALL_ROWS*/
           UNIT,
           UNIT_VALUE,
           MIN_VALUE,
           MAX_VALUE,
           DEPEND_ITEM,
           REPLACE_ITEM,
           CARD_FLAG,
           CARD_FROM_FLAG,
           CARD_FROM_OFFSET,
           CARD_FROM_RELATION,
           CARD_TO_FLAG,
           CARD_TO_OFFSET,
           CARD_TO_RELATION,
           APPLY_FLAG,
           APPLY_TYPE,
           APPLY_FULLDAY_VALUE,
           APPLY_CARD_PRIORITY,
           DATE_TYPE
            INTO VAR_ITEM_UNIT,
                 VAR_ITEM_UNITVALUE,
                 VAR_ITEM_MINVALUE,
                 VAR_ITEM_MAXVALUE,
                 VAR_ITEM_DEPENDITEM,
                 VAR_ITEM_REPLACEITEM,
                 VAR_ITEM_CARDFLAG,
                 VAR_ITEM_CARDFROMFLAG,
                 VAR_ITEM_CARDFROMOFFSET,
                 VAR_ITEM_CARDFROMRELATION,
                 VAR_ITEM_CARDTOFLAG,
                 VAR_ITEM_CARDTOOFFSET,
                 VAR_ITEM_CARDTORELATION,
                 VAR_ITEM_APPLYFLAG,
                 VAR_ITEM_APPLYTYPE,
                 VAR_ITEM_APPLYFULLDAYVALUE,
                 VAR_ITEM_APPLYCARDPRIORITY,
                 VAR_ITEM_DATETYPE
            FROM AR_ITEM_PARAM
           WHERE AR_ITEM_NO = AR_APPLY_ROW.ITEM_NO
             AND AR_GROUP_NO =
                 CASE (SELECT COUNT(*)
                     FROM AR_ITEM_PARAM AIP
                    WHERE AIP.AR_ITEM_NO = AR_APPLY_ROW.ITEM_NO
                      AND AIP.AR_GROUP_NO = VAR_GROUPNO)
                   WHEN 1 THEN
                    VAR_GROUPNO
                   ELSE
                    'constant'
                 END;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            OUT_STR := '考勤项目 (' || TO_CHAR(AR_APPLY_ROW.ITEM_NO) ||
                       ') 设置错误,请检查设置';
          
            --IF VAR_LOG_LEVEL > 0
            --THEN
            --DBMS_OUTPUT.PUT_LINE (OUT_STR);
            --END IF;
          
            RETURN;
            
            
        END;
      
        /*循环 AR_APPLY_RESULT 表中记录*/
        DECLARE
               
          CURSOR CUR_ES_APPLY IS
          /*(开始时间或结束时间在当天应工作区间内)或(始于工作区间前且终于工作区间后) --休假APPLY_DATE为NULL，APPLY_DATE 是当天 --加班*/
            SELECT /*+(AR_APPLY_RESULT PK_AR_APPLY_RESULT)*/
             APPLY_DATE, FROM_TIME, TO_TIME, APPLY_DEDUCT
              FROM AR_APPLY_RESULT
             WHERE EMPID = IN_EMPID
               AND APPLY_TYPE = AR_APPLY_ROW.APPLY_TYPE
               AND (APPLY_DATE = IN_AR_DATE_STR OR
                   ((FROM_TIME >= VAR_SHIFTFROMTIME AND
                   FROM_TIME < VAR_SHIFTTOTIME OR
                   TO_TIME > VAR_SHIFTFROMTIME AND
                   TO_TIME <= VAR_SHIFTTOTIME OR
                   FROM_TIME <= VAR_SHIFTFROMTIME AND
                   TO_TIME >= VAR_SHIFTTOTIME) OR APPLY_DATE IS NULL));
        
          ES_APPLY_ROW CUR_ES_APPLY%ROWTYPE;
        BEGIN
          OPEN CUR_ES_APPLY;
          /***********************************循环适用于当天的考勤申请数据******************************/
          LOOP
            FETCH CUR_ES_APPLY INTO ES_APPLY_ROW;
          
            EXIT WHEN CUR_ES_APPLY%NOTFOUND;

            IF VAR_LOG_LEVEL > 0 THEN
              DBMS_OUTPUT.PUT_LINE('=====申请项目=====' ||
                                   TO_CHAR(AR_APPLY_ROW.ITEM_NO));
            END IF;
          
            /* 直接取申请始末时间作为进出门时间 */
            VAR_INTIME  := ES_APPLY_ROW.FROM_TIME;
            VAR_OUTTIME := ES_APPLY_ROW.TO_TIME;
            DBMS_OUTPUT.PUT_LINE('申请初始时间：'||VAR_INTIME);
            IF VAR_LOG_LEVEL > 0 THEN
              DBMS_OUTPUT.PUT_LINE('申请项目开始时间' ||
                                   TO_CHAR(VAR_INTIME,
                                           'YYYY-MM-DD HH24:MI:SS'));
              DBMS_OUTPUT.PUT_LINE('申请项目结束时间' ||
                                   TO_CHAR(VAR_OUTTIME,
                                           'YYYY-MM-DD HH24:MI:SS'));
            END IF;
          
            /*申请日期为空(休假申请).-----休假申请:取申请的时间与班次时间的交集; 加班申请:取申请的进出门时间*/
            IF ES_APPLY_ROW.APPLY_DATE IS NULL THEN
              IF VAR_INTIME < VAR_SHIFTFROMTIME THEN
                VAR_INTIME := VAR_SHIFTFROMTIME;
              END IF;
            
              IF VAR_OUTTIME > VAR_SHIFTTOTIME THEN
                VAR_OUTTIME := VAR_SHIFTTOTIME;
              END IF;
            END IF;
          
            DBMS_OUTPUT.PUT_LINE('实际申请开始时间：' ||
                                 TO_CHAR(VAR_INTIME, 'YYYY-MM-DD HH24:MI') ||
                                 '实际申请结束时间：' ||
                                 TO_CHAR(VAR_OUTTIME, 'YYYY-MM-DD HH24:MI'));
            --休息班次年假不用计算
            IF VAR_SHIFTNO = 2 AND AR_APPLY_ROW.ITEM_NO = '22' THEN
              DBMS_OUTPUT.PUT_LINE('休息班次年假不用计算: ');
            ELSE
              /*当前项目记录置于临时表中*/
              INSERT INTO AR_DETAIL_TEMP
                (NO,
                 EMPID,
                 AR_ITEM_NO,
                 FROM_TIME,
                 TO_TIME,
                 SHIFT_NO,
                 AR_DATE_STR,
                 AR_MONTH_STR,
                 QUANTITY,
                 LOCK_YN,
                 DATE_TYPE,
                 UNIT,
                 ITEM_TYPE)
              VALUES
                (AR_DETAIL_TEMP_SEQ.NEXTVAL,
                 IN_EMPID,
                 AR_APPLY_ROW.ITEM_NO,
                 VAR_INTIME,
                 VAR_OUTTIME,
                 VAR_SHIFTNO,
                 IN_AR_DATE_STR,
                 TO_CHAR(TO_DATE(IN_AR_DATE_STR, 'YYYY/MM/DD'), 'yyyymm'),
                 ES_APPLY_ROW.APPLY_DEDUCT,
                 'N',
                 VAR_DATETYPE,
                 VAR_ITEM_UNIT,
                 1);
                 
               IF VAR_ABSENT_END IS NULL AND AR_APPLY_ROW.ITEM_GROUP_CODE = 'SpecialGroup' 
                 OR VAR_ABSENT_END IS NULL AND AR_APPLY_ROW.ITEM_GROUP_CODE = 'LeavelGroup' THEN
                 VAR_ABSENT_END := VAR_INTIME;
               END IF;
            END IF;
            /********************************循环适用于当天的考勤申请数据**************************/
          END LOOP;
        
          CLOSE CUR_ES_APPLY;
        END;
      END IF;
    END LOOP;
  
    CLOSE CUR_AR_APPLY;
    
  END;

  /***************************************申请项目循环结束************************************/

  /***************************************处理临时表中记录开始****************************/

  /*取得当前员工在记录处理前临时表中的记录数*/
  SELECT COUNT(*)
    INTO VAR_COUNT
    FROM AR_DETAIL_TEMP
   WHERE EMPID = IN_EMPID
     AND AR_DATE_STR = IN_AR_DATE_STR;

  IF VAR_LOG_LEVEL > 0 THEN
    DBMS_OUTPUT.PUT_LINE('处理前临时记录数: ' || TO_CHAR(VAR_COUNT));
  END IF;

  /*分别取出不同类型组的数据*/
  DECLARE
  
      cursor CUR_DETAIL_TEMP
      IS SELECT * FROM AR_DETAIL_TEMP;
      DETAIL_ROW CUR_DETAIL_TEMP%ROWTYPE;
  
    VAR_TEMP_INTIME   DATE; --进门时间
    VAR_TEMP_OUTTIME  DATE; --出门时间
    VAR_TEMP_QUANTITY AR_DETAIL.QUANTITY%TYPE; --考勤项目数值
  
    CURSOR CUR_AR_TEMP_NORMAL IS
    /*取得临时表中的考勤项目为常规项目组的记录*/
      SELECT /*+ALL_ROWS*/
       A.NO,
       A.AR_ITEM_NO,
       A.FROM_TIME,
       A.TO_TIME,
       A.SHIFT_NO,
       A.AR_DATE_STR,
       A.DATE_TYPE,
       C.CARD_FLAG,
       C.CARD_FROM_FLAG,
       C.CARD_TO_FLAG,
       C.APPLY_FLAG,
       C.APPLY_TYPE,
       C.APPLY_FULLDAY_VALUE,
       C.APPLY_CARD_PRIORITY,
       C.UNIT,
       C.UNIT_VALUE,
       B.ITEM_GROUP_CODE
        FROM AR_DETAIL_TEMP A, AR_ITEM B, AR_ITEM_PARAM C
       WHERE A.AR_ITEM_NO = B.ITEM_NO
         AND B.ITEM_NO = C.AR_ITEM_NO
         AND B.ITEM_GROUP_CODE = 'NormalGroup'
         AND C.AR_GROUP_NO = CASE (SELECT COUNT(*)
                 FROM AR_ITEM_PARAM AIP
                WHERE AIP.AR_ITEM_NO = B.ITEM_NO
                  AND AIP.AR_GROUP_NO = VAR_GROUPNO)
               WHEN 1 THEN
                VAR_GROUPNO
               ELSE
                'constant'
             END;
  
    AR_TEMP_NORMAL_ROW CUR_AR_TEMP_NORMAL%ROWTYPE;
  
    CURSOR CUR_AR_TEMP_OT IS
    /*取得临时表中的考勤项目为加班项目组的记录*/
      SELECT /*+ALL_ROWS*/
       A.NO,
       A.AR_ITEM_NO,
       A.FROM_TIME,
       A.TO_TIME,
       A.SHIFT_NO,
       A.AR_DATE_STR,
       A.DATE_TYPE,
       A.QUANTITY,
       C.CARD_FLAG,
       C.CARD_FROM_FLAG,
       C.CARD_TO_FLAG,
       C.APPLY_FLAG,
       C.APPLY_TYPE,
       C.APPLY_FULLDAY_VALUE,
       C.APPLY_CARD_PRIORITY,
       C.UNIT,
       C.UNIT_VALUE,
       B.ITEM_GROUP_CODE
        FROM AR_DETAIL_TEMP A, AR_ITEM B, AR_ITEM_PARAM C
       WHERE A.AR_ITEM_NO = B.ITEM_NO
         AND B.ITEM_GROUP_CODE = 'OverTimeGroup'
         AND B.ITEM_NO = C.AR_ITEM_NO
         AND C.AR_GROUP_NO = CASE (SELECT COUNT(*)
                 FROM AR_ITEM_PARAM AIP
                WHERE AIP.AR_ITEM_NO = B.ITEM_NO
                  AND AIP.AR_GROUP_NO = VAR_GROUPNO)
               WHEN 1 THEN
                VAR_GROUPNO
               ELSE
                'constant'
             END;
  
    AR_TEMP_OT_ROW CUR_AR_TEMP_OT%ROWTYPE;
  
    CURSOR CUR_AR_TEMP_LEAVEL IS
    /*取得临时表中的考勤项目为休假项目组、特殊项目组的记录*/
      SELECT /*+ALL_ROWS*/
       A.NO,
       A.AR_ITEM_NO,
       A.FROM_TIME,
       A.TO_TIME,
       A.SHIFT_NO,
       A.AR_DATE_STR,
       A.DATE_TYPE,
       A.QUANTITY,
       C.CARD_FLAG,
       C.CARD_FROM_FLAG,
       C.CARD_TO_FLAG,
       C.APPLY_FLAG,
       C.APPLY_TYPE,
       C.APPLY_FULLDAY_VALUE,
       C.APPLY_CARD_PRIORITY,
       C.UNIT,
       C.UNIT_VALUE,
       B.ITEM_GROUP_CODE
        FROM AR_DETAIL_TEMP A, AR_ITEM B, AR_ITEM_PARAM C
       WHERE A.AR_ITEM_NO = B.ITEM_NO
         AND B.ITEM_NO = C.AR_ITEM_NO
         AND B.ITEM_GROUP_CODE IN ('LeavelGroup', 'SpecialGroup')
         AND C.AR_GROUP_NO = CASE (SELECT COUNT(*)
                 FROM AR_ITEM_PARAM AIP
                WHERE AIP.AR_ITEM_NO = B.ITEM_NO
                  AND AIP.AR_GROUP_NO = VAR_GROUPNO)
               WHEN 1 THEN
                VAR_GROUPNO
               ELSE
                'constant'
             END;
  
    AR_TEMP_LEAVEL_ROW CUR_AR_TEMP_LEAVEL%ROWTYPE;
  
    CURSOR CUR_SHIFTNORMAL IS
    /*取出当天对应的班次信息(多个时间段，不包含固定加班时间段)*/
      SELECT BEGIN_DAY_OFFSET +
             TO_DATE(IN_AR_DATE_STR || ' ' ||
                     TO_CHAR(FROM_TIME, 'HH24:mi:ss'),
                     'YYYY/MM/DD HH24:mi:ss') SHIFT_START,
             END_DAY_OFFSET +
             TO_DATE(IN_AR_DATE_STR || ' ' ||
                     TO_CHAR(TO_TIME, 'HH24:mi:ss'),
                     'YYYY/MM/DD HH24:mi:ss') SHIFT_END
        FROM AR_SHIFT020
       WHERE SHIFT_NO = VAR_SHIFTNO
         AND AR_ITEM_NO =
             DECODE(VAR_DATETYPE, 1, VAR_FINAL_ITEM_NORMAL, AR_ITEM_NO);
  
    SHIFTNORMAL_ROW CUR_SHIFTNORMAL%ROWTYPE;
    
    
    
  BEGIN
    OPEN CUR_AR_TEMP_NORMAL;
  
    /*循环项目为常规组的数据*/
    LOOP
      FETCH CUR_AR_TEMP_NORMAL
        INTO AR_TEMP_NORMAL_ROW;
    
      EXIT WHEN CUR_AR_TEMP_NORMAL%NOTFOUND;
      --dbms_output.put_line('正常');
      /*取得真实的进出门时间(打卡时间)*/
      VAR_INTIME        := AR_TEMP_NORMAL_ROW.FROM_TIME;
      VAR_OUTTIME       := AR_TEMP_NORMAL_ROW.TO_TIME;
      VAR_TEMP_QUANTITY := 0;
    
      /***************************************循环项目为加班组的数据********************************/
      OPEN CUR_AR_TEMP_OT;
      LOOP
        FETCH CUR_AR_TEMP_OT
          INTO AR_TEMP_OT_ROW;
      
        EXIT WHEN CUR_AR_TEMP_OT%NOTFOUND;
        dbms_output.put_line('有加班');
        /*取加班组项目的开始结束时间*/
        VAR_TEMP_INTIME  := AR_TEMP_OT_ROW.FROM_TIME;
        VAR_TEMP_OUTTIME := AR_TEMP_OT_ROW.TO_TIME;
        VAR_QUANTITY     := 0;
        
        
        /*针对新的循环，重新取得真实的进出门时间(打卡时间)*/
        
        VAR_INTIME  := TO_DATE(TO_CHAR(AR_TEMP_NORMAL_ROW.FROM_TIME,
                                       'YYYY-MM-DD HH24:MI:SS'),
                               'YYYY-MM-DD HH24:MI:SS');
        VAR_OUTTIME := TO_DATE(TO_CHAR(AR_TEMP_NORMAL_ROW.TO_TIME,
                                       'YYYY-MM-DD HH24:MI:SS'),
                               'YYYY-MM-DD HH24:MI:SS');                       
        
        IF VAR_INTIME IS NULL THEN
          VAR_INTIME := VAR_TEMP_INTIME;
          VAR_OUTTIME := VAR_TEMP_OUTTIME;
        END IF;
        VAR_INTIME_OT_SHOW := VAR_TEMP_INTIME;
        VAR_OUTTIME_OT_SHOW := VAR_TEMP_OUTTIME; 
        --VAR_INTIME := VAR_TEMP_INTIME;
        --VAR_OUTTIME := VAR_TEMP_OUTTIME;
        dbms_output.put_line('进时间:'||TO_CHAR(VAR_TEMP_INTIME,
                                       'YYYY-MM-DD HH24:MI:SS'));
        dbms_output.put_line('出时间：'||TO_CHAR(VAR_TEMP_OUTTIME,
                                       'YYYY-MM-DD HH24:MI:SS'));
        dbms_output.put_line('重新取得打卡时间:'||TO_CHAR(VAR_INTIME,
                                       'YYYY-MM-DD HH24:MI:SS'));
        dbms_output.put_line('重新取得出卡时间：'||TO_CHAR(VAR_OUTTIME,
                                       'YYYY-MM-DD HH24:MI:SS'));
        VAR_INTIME_OT := VAR_INTIME;
        VAR_OUTTIME_OT := VAR_OUTTIME;
        /**********************************加班组的项目参考打卡******************************/
        IF AR_TEMP_OT_ROW.CARD_FLAG = 1 THEN
          /*如果实际的进出门时间都不存在，或者非平时加班缺少进出门时间，加班时间无效*/
          IF (VAR_INTIME IS NULL AND VAR_OUTTIME IS NULL) OR
             (AR_TEMP_OT_ROW.DATE_TYPE > 1 AND
             (VAR_INTIME IS NULL OR VAR_OUTTIME IS NULL)) THEN
          
            VAR_QUANTITY := 0;
          ELSE
            /**********************打卡优先**********************/
            IF AR_TEMP_OT_ROW.APPLY_CARD_PRIORITY = 0 THEN
              /*平日类型*/
              IF AR_TEMP_OT_ROW.DATE_TYPE = 1 THEN
                /*如果是平日类型加班的话，在此重新读取出入厂时间*/
                SELECT 
                  MIN(A.R_TIME) INTO VAR_INTIME_OT
                FROM AR_MAC_RECORD A
                WHERE A.EMPID = IN_EMPID
                AND A.ACTIVITY= 1
                AND A.R_TIME <= VAR_TEMP_OUTTIME
                AND A.R_TIME > VAR_TEMP_INTIME-1/24;
                
                SELECT 
                  MAX(A.R_TIME) INTO VAR_OUTTIME_OT
                FROM AR_MAC_RECORD A
                WHERE A.EMPID = IN_EMPID
                AND A.ACTIVITY= 1
                AND A.R_TIME >= VAR_TEMP_INTIME
                AND A.R_TIME < VAR_TEMP_OUTTIME+3/24;
                
                /*标准上班时间前的加班*/
                IF VAR_TEMP_INTIME < VAR_SHIFTFROMTIME AND
                   VAR_TEMP_OUTTIME < VAR_SHIFTFROMTIME THEN
                  /*无进门时间或者实际打卡时间大于申请的结束时间，加班时间无效*/
                  IF VAR_INTIME_OT IS NULL OR VAR_INTIME_OT > VAR_TEMP_OUTTIME THEN
                    VAR_QUANTITY := 0;
                  ELSE
                    VAR_INTIME := VAR_INTIME_OT;
                    VAR_QUANTITY := (VAR_TEMP_OUTTIME - VAR_INTIME_OT) * 24 * 60;
                  END IF;
                
                  /*标准下班时间后的加班*/
                ELSE
                  /*无出门时间或者实际打卡时间小于申请的开始时间，加班时间无效*/
                  IF VAR_OUTTIME_OT IS NULL OR VAR_OUTTIME_OT < VAR_TEMP_INTIME THEN
                    VAR_QUANTITY := 0;
                  ELSE
                    VAR_OUTTIME := VAR_OUTTIME_OT;
                    VAR_QUANTITY := (VAR_OUTTIME_OT - VAR_TEMP_INTIME) * 24 * 60;
                  END IF;
                
                END IF;
              
                /*非平日类型*/
              ELSE
                
                SELECT 
                  MIN(A.R_TIME) INTO VAR_INTIME
                FROM AR_MAC_RECORD A
                WHERE A.EMPID = IN_EMPID
                AND A.ACTIVITY= 1
                AND A.R_TIME <= VAR_TEMP_OUTTIME
                AND A.R_TIME > VAR_TEMP_INTIME-1/24;
                
                SELECT 
                  MAX(A.R_TIME) INTO VAR_OUTTIME
                FROM AR_MAC_RECORD A
                WHERE A.EMPID = IN_EMPID
                AND A.ACTIVITY= 1
                AND A.R_TIME >= VAR_TEMP_INTIME
                AND A.R_TIME < VAR_TEMP_OUTTIME+3/24;
                
                VAR_INTIME_OT_SHOW := VAR_INTIME;
                VAR_OUTTIME_OT_SHOW := VAR_OUTTIME;
                /*如果缺失进出门时间，加班时间无效*/
                IF VAR_INTIME IS NULL OR VAR_OUTTIME IS NULL THEN
                
                  VAR_QUANTITY := 0;
                ELSE
                
                  OPEN CUR_SHIFTNORMAL;
                  LOOP
                    FETCH CUR_SHIFTNORMAL
                      INTO SHIFTNORMAL_ROW;
                  
                    EXIT WHEN CUR_SHIFTNORMAL%NOTFOUND;
                  
                    /*取得加班时间与标准上下班时间的交集*/
                    VAR_QUANTITY := VAR_QUANTITY +
                                    AR_GET_CROSSTIME(VAR_INTIME,
                                                     VAR_OUTTIME,
                                                     SHIFTNORMAL_ROW.SHIFT_START,
                                                     SHIFTNORMAL_ROW.SHIFT_END) * 24 * 60;
                  END LOOP;
                  CLOSE CUR_SHIFTNORMAL;
                
                  /*如果加班开始时间小于标准上班时间*/
                  IF VAR_INTIME < VAR_SHIFTFROMTIME THEN
                    VAR_QUANTITY := VAR_QUANTITY +
                                    (CASE
                                      WHEN VAR_SHIFTFROMTIME > VAR_OUTTIME THEN
                                       VAR_OUTTIME
                                      ELSE
                                       VAR_SHIFTFROMTIME
                                    END - VAR_INTIME) * 24 * 60;
                  END IF;
                
                  /*如果加班结束时间大于标准下班时间*/
                  IF VAR_OUTTIME > VAR_SHIFTTOTIME THEN
                    VAR_QUANTITY := VAR_QUANTITY + (VAR_OUTTIME - CASE
                                      WHEN VAR_SHIFTTOTIME < VAR_INTIME THEN
                                       VAR_INTIME
                                      ELSE
                                       VAR_SHIFTTOTIME
                                    END) * 24 * 60;
                  END IF;
                
                END IF;
              END IF;
            
            END IF;
          
            /*****************************申请优先**********************/
            IF AR_TEMP_OT_ROW.APPLY_CARD_PRIORITY = 1 THEN
              /*平日类型*/
              IF AR_TEMP_OT_ROW.DATE_TYPE = 1 THEN
                /*标准上班时间前的加班*/
                IF VAR_TEMP_INTIME < VAR_SHIFTFROMTIME AND
                   VAR_TEMP_OUTTIME < VAR_SHIFTFROMTIME THEN
                  /*无进门时间，加班时间无效*/
                  IF VAR_INTIME IS NULL THEN
                    VAR_QUANTITY := 0;
                  ELSE
                    VAR_QUANTITY := (VAR_TEMP_OUTTIME - VAR_TEMP_INTIME) * 24 * 60;
                  END IF;
                
                  /*标准下班时间后的加班*/
                ELSE
                  /*无出门时间，加班时间无效*/
                  IF VAR_OUTTIME IS NULL THEN
                    VAR_QUANTITY := 0;
                  ELSE
                    VAR_QUANTITY := (VAR_TEMP_OUTTIME - VAR_TEMP_INTIME) * 24 * 60;
                  END IF;
                
                END IF;
              
                /*非平日类型*/
              ELSE
                /*如果缺式进出门时间，加班时间无效*/
                IF VAR_INTIME IS NULL OR VAR_OUTTIME IS NULL THEN
                
                  VAR_QUANTITY := 0;
                ELSE
                
                  OPEN CUR_SHIFTNORMAL;
                  LOOP
                    FETCH CUR_SHIFTNORMAL
                      INTO SHIFTNORMAL_ROW;
                  
                    EXIT WHEN CUR_SHIFTNORMAL%NOTFOUND;
                  
                    /*取得加班时间与标准上下班时间的交集*/
                    VAR_QUANTITY := VAR_QUANTITY +
                                    AR_GET_CROSSTIME(VAR_TEMP_INTIME,
                                                     VAR_TEMP_OUTTIME,
                                                     SHIFTNORMAL_ROW.SHIFT_START,
                                                     SHIFTNORMAL_ROW.SHIFT_END) * 24 * 60;
                  END LOOP;
                  CLOSE CUR_SHIFTNORMAL;
                
                  /*如果加班开始时间小于标准上班时间*/
                  IF VAR_TEMP_INTIME < VAR_SHIFTFROMTIME THEN
                    VAR_QUANTITY := VAR_QUANTITY +
                                    (CASE
                                      WHEN VAR_SHIFTFROMTIME > VAR_TEMP_OUTTIME THEN
                                       VAR_TEMP_OUTTIME
                                      ELSE
                                       VAR_SHIFTFROMTIME
                                    END - VAR_TEMP_INTIME) * 24 * 60;
                  END IF;
                
                  /*如果加班结束时间大于标准下班时间*/
                  IF VAR_TEMP_OUTTIME > VAR_SHIFTTOTIME THEN
                    VAR_QUANTITY := VAR_QUANTITY + (VAR_TEMP_OUTTIME - CASE
                                      WHEN VAR_SHIFTTOTIME < VAR_TEMP_INTIME THEN
                                       VAR_TEMP_INTIME
                                      ELSE
                                       VAR_SHIFTTOTIME
                                    END) * 24 * 60;
                  END IF;
                
                END IF;
              
              END IF;
            END IF;
          
            /***************************取打卡与申请的交集************************/
            IF AR_TEMP_OT_ROW.APPLY_CARD_PRIORITY = 2 THEN
              dbms_output.put_line('打卡与申请交集');
              /*平日类型*/
              IF AR_TEMP_OT_ROW.DATE_TYPE = 1 THEN
                SELECT 
                  MIN(A.R_TIME) INTO VAR_INTIME_OT
                FROM AR_MAC_RECORD A
                WHERE A.EMPID = IN_EMPID
                AND A.ACTIVITY= 1
                AND A.R_TIME <= VAR_TEMP_OUTTIME
                AND A.R_TIME > VAR_TEMP_INTIME-1/24;
                
                SELECT 
                  MAX(A.R_TIME) INTO VAR_OUTTIME_OT
                FROM AR_MAC_RECORD A
                WHERE A.EMPID = IN_EMPID
                AND A.ACTIVITY= 1
                AND A.R_TIME >= VAR_TEMP_INTIME
                AND A.R_TIME < VAR_TEMP_OUTTIME+3/24;
               
                /*标准上班时间前的加班*/
                IF VAR_TEMP_INTIME < VAR_SHIFTFROMTIME AND
                   VAR_TEMP_OUTTIME < VAR_SHIFTFROMTIME THEN
                  /*无进门时间或者实际打卡时间大于申请的结束时间，加班时间无效*/
                  IF VAR_INTIME_OT IS NULL OR VAR_INTIME_OT > VAR_TEMP_OUTTIME THEN
                    VAR_QUANTITY := 0;
                  ELSE
                    VAR_INTIME := VAR_INTIME_OT;
                    VAR_INTIME_OT_SHOW := VAR_INTIME;
                    VAR_QUANTITY := (VAR_TEMP_OUTTIME - CASE
                                      WHEN VAR_INTIME_OT < VAR_TEMP_INTIME THEN
                                       VAR_TEMP_INTIME
                                      ELSE
                                       VAR_INTIME_OT
                                    END) * 24 * 60;
                  END IF;
                
                  /*标准下班时间后的加班*/
                ELSE
                  /*无出门时间或者实际打卡时间小于申请的开始时间，加班时间无效*/
                  IF VAR_OUTTIME_OT IS NULL OR VAR_OUTTIME_OT < VAR_TEMP_INTIME THEN
                    VAR_QUANTITY := 0;
                  ELSE
                    VAR_OUTTIME := VAR_OUTTIME_OT;
                    VAR_OUTTIME_OT_SHOW := VAR_OUTTIME;
                    VAR_QUANTITY := (CASE
                                      WHEN VAR_OUTTIME > VAR_TEMP_OUTTIME THEN
                                       VAR_TEMP_OUTTIME
                                      ELSE
                                       VAR_OUTTIME
                                    END - VAR_TEMP_INTIME) * 24 * 60;
                  END IF;             
                END IF;
              
                /*非平日类型*/
              ELSE
                
                SELECT 
                  MIN(A.R_TIME) INTO VAR_INTIME
                FROM AR_MAC_RECORD A
                WHERE A.EMPID = IN_EMPID
                AND A.ACTIVITY= 1
                AND A.R_TIME <= VAR_TEMP_OUTTIME
                AND A.R_TIME > VAR_TEMP_INTIME-1/24;
                
                SELECT 
                  MAX(A.R_TIME) INTO VAR_OUTTIME
                FROM AR_MAC_RECORD A
                WHERE A.EMPID = IN_EMPID
                AND A.ACTIVITY= 1
                AND A.R_TIME >= VAR_TEMP_INTIME
                AND A.R_TIME < VAR_TEMP_OUTTIME+3/24;
                
                VAR_INTIME_OT_SHOW := VAR_INTIME;
                VAR_OUTTIME_OT_SHOW := VAR_OUTTIME;
                
                dbms_output.put_line('周末加班入门时间:'||TO_CHAR(VAR_TEMP_INTIME,
                                       'YYYY-MM-DD HH24:MI:SS'));
                dbms_output.put_line('周末加班出门时间：'||TO_CHAR(VAR_TEMP_OUTTIME,
                                       'YYYY-MM-DD HH24:MI:SS'));
              
                dbms_output.put_line('周末加班打卡入门时间:'||TO_CHAR(VAR_INTIME,
                                       'YYYY-MM-DD HH24:MI:SS'));
                dbms_output.put_line('周末加班出卡出门时间：'||TO_CHAR(VAR_OUTTIME,
                                       'YYYY-MM-DD HH24:MI:SS'));
                dbms_output.put_line(AR_GET_CROSSTIME(VAR_INTIME,
                                    VAR_OUTTIME,
                                    VAR_TEMP_INTIME,
                                    VAR_TEMP_OUTTIME));
                /*如果打卡时间与申请时间存在交集*/
                IF AR_GET_CROSSTIME(VAR_INTIME,
                                    VAR_OUTTIME,
                                    VAR_TEMP_INTIME,
                                    VAR_TEMP_OUTTIME) > 0 THEN
                  /*取最大的开始时间*/
                  IF VAR_INTIME < VAR_TEMP_INTIME THEN
                    VAR_INTIME := VAR_TEMP_INTIME;
                  END IF;
                  /*取最小的结束时间*/
                  IF VAR_OUTTIME > VAR_TEMP_OUTTIME THEN
                    VAR_OUTTIME := VAR_TEMP_OUTTIME;
                  END IF;
                  
                 
                  
                  OPEN CUR_SHIFTNORMAL;
                  LOOP
                    FETCH CUR_SHIFTNORMAL
                      INTO SHIFTNORMAL_ROW;
                  
                    EXIT WHEN CUR_SHIFTNORMAL%NOTFOUND;
                  
                    /*取得加班时间与标准上下班时间的交集*/
                    VAR_QUANTITY := VAR_QUANTITY +
                                    AR_GET_CROSSTIME(VAR_INTIME,
                                                     VAR_OUTTIME,
                                                     SHIFTNORMAL_ROW.SHIFT_START,
                                                     SHIFTNORMAL_ROW.SHIFT_END) * 24 * 60;
                  END LOOP;
                  CLOSE CUR_SHIFTNORMAL;
                  /*如果加班开始时间小于标准上班时间*/
                  IF VAR_INTIME < VAR_SHIFTFROMTIME THEN
                    VAR_QUANTITY := VAR_QUANTITY +
                                    (CASE
                                      WHEN VAR_SHIFTFROMTIME > VAR_OUTTIME THEN
                                       VAR_OUTTIME
                                      ELSE
                                       VAR_SHIFTFROMTIME
                                    END - VAR_INTIME) * 24 * 60;
                  END IF;
                
                  /*如果加班结束时间大于标准下班时间*/
                  IF VAR_OUTTIME > VAR_SHIFTTOTIME THEN
                    VAR_QUANTITY := VAR_QUANTITY + (VAR_OUTTIME - CASE
                                      WHEN VAR_SHIFTTOTIME < VAR_INTIME THEN
                                       VAR_INTIME
                                      ELSE
                                       VAR_SHIFTTOTIME
                                    END) * 24 * 60;
                  END IF;
                ELSE
                  VAR_QUANTITY := 0;
                END IF;
              END IF;
            
            END IF;
          
          END IF;
        
        /***************************************加班组的项目不参考打卡************************************/
        ELSE
          /*平日类型*/
          DBMS_OUTPUT.put_line('加班组项目不参与打卡');
          
          IF AR_TEMP_OT_ROW.DATE_TYPE = 1 THEN
            VAR_QUANTITY := (VAR_TEMP_OUTTIME - VAR_TEMP_INTIME) * 24 * 60;
          
            /*非平日类型*/
          ELSE
            OPEN CUR_SHIFTNORMAL;
            LOOP
              FETCH CUR_SHIFTNORMAL
                INTO SHIFTNORMAL_ROW;
            
              EXIT WHEN CUR_SHIFTNORMAL%NOTFOUND;
            
              /*取得加班时间与标准上下班时间的交集*/
              VAR_QUANTITY := VAR_QUANTITY +
                              AR_GET_CROSSTIME(VAR_TEMP_INTIME,
                                               VAR_TEMP_OUTTIME,
                                               SHIFTNORMAL_ROW.SHIFT_START,
                                               SHIFTNORMAL_ROW.SHIFT_END) * 24 * 60;
            END LOOP;
            CLOSE CUR_SHIFTNORMAL;
          
            /*如果加班开始时间小于标准上班时间*/
            IF VAR_TEMP_INTIME < VAR_SHIFTFROMTIME THEN
              VAR_QUANTITY := VAR_QUANTITY +
                              (CASE
                                WHEN VAR_SHIFTFROMTIME > VAR_TEMP_OUTTIME THEN
                                 VAR_TEMP_OUTTIME
                                ELSE
                                 VAR_SHIFTFROMTIME
                              END - VAR_TEMP_INTIME) * 24 * 60;
            END IF;
          
            /*如果加班结束时间大于标准下班时间*/
            IF VAR_TEMP_OUTTIME > VAR_SHIFTTOTIME THEN
              VAR_QUANTITY := VAR_QUANTITY + (VAR_TEMP_OUTTIME - CASE
                                WHEN VAR_SHIFTTOTIME < VAR_TEMP_INTIME THEN
                                 VAR_TEMP_INTIME
                                ELSE
                                 VAR_SHIFTTOTIME
                              END) * 24 * 60;
            END IF;
          END IF;
        
        END IF;
        
        /*更新加班组项目的加班时间(保留真实的申请开始结束时间)；同时扣除"申请扣除时间"*/
        DBMS_OUTPUT.put_line('更新加班组项目时间为:'||TO_CHAR(VAR_INTIME,'YYYY/MM/DD HH24:MI:SS'));
        DBMS_OUTPUT.put_line('更新加班组项目时间为:'||TO_CHAR(VAR_OUTTIME,'YYYY/MM/DD HH24:MI:SS'));
        UPDATE AR_DETAIL_TEMP
           SET FROM_TIME=VAR_INTIME_OT_SHOW,
           TO_TIME=VAR_OUTTIME_OT_SHOW,
           QUANTITY = DECODE(SIGN(VAR_QUANTITY - QUANTITY),
                                 1,
                                 VAR_QUANTITY - QUANTITY,
                                 0)
         WHERE NO = AR_TEMP_OT_ROW.NO;
      
      END LOOP;
    
      /*加班项目组数据循环结束*/
      CLOSE CUR_AR_TEMP_OT;
    
      /* 加班项目循环结束后，清零*/
      VAR_QUANTITY := 0;
    
      /*******************************************循环项目为休假组的数据***************************************/
      OPEN CUR_AR_TEMP_LEAVEL;
      LOOP
        FETCH CUR_AR_TEMP_LEAVEL
          INTO AR_TEMP_LEAVEL_ROW;
      
        EXIT WHEN CUR_AR_TEMP_LEAVEL%NOTFOUND;
        DBMS_OUTPUT.put_line('休假'||AR_TEMP_LEAVEL_ROW.AR_ITEM_NO);
        /*取休假组项目的开始结束时间*/
        VAR_TEMP_INTIME  := AR_TEMP_LEAVEL_ROW.FROM_TIME;
        VAR_TEMP_OUTTIME := AR_TEMP_LEAVEL_ROW.TO_TIME;
        VAR_QUANTITY     := 0;
        dbms_output.put_line('进时间:'||TO_CHAR(VAR_TEMP_INTIME,
                                       'YYYY-MM-DD HH24:MI'));
        dbms_output.put_line('出时间：'||TO_CHAR(VAR_TEMP_OUTTIME,
                                       'YYYY-MM-DD HH24:MI'));
        dbms_output.put_line('重新取得打卡时间:'||TO_CHAR(VAR_INTIME,
                                       'YYYY-MM-DD HH24:MI'));
        dbms_output.put_line('重新取得出卡时间：'||TO_CHAR(VAR_OUTTIME,
                                       'YYYY-MM-DD HH24:MI'));
        OPEN CUR_SHIFTNORMAL;
        LOOP
          FETCH CUR_SHIFTNORMAL
            INTO SHIFTNORMAL_ROW;
        
          EXIT WHEN CUR_SHIFTNORMAL%NOTFOUND;
          IF VAR_OUTTIME IS NOT NULL AND VAR_OUTTIME > VAR_TEMP_INTIME THEN
            VAR_QUANTITY := VAR_QUANTITY +
                          AR_GET_CROSSTIME(VAR_OUTTIME,
                                           VAR_TEMP_OUTTIME,
                                           SHIFTNORMAL_ROW.SHIFT_START,
                                           SHIFTNORMAL_ROW.SHIFT_END) * 24 * 60;
          ELSE
            /*取得休假组项目的时间*/
            VAR_QUANTITY := VAR_QUANTITY +
                          AR_GET_CROSSTIME(VAR_TEMP_INTIME,
                                           VAR_TEMP_OUTTIME,
                                           SHIFTNORMAL_ROW.SHIFT_START,
                                           SHIFTNORMAL_ROW.SHIFT_END) * 24 * 60;
          END IF;
          
        END LOOP;
      
        /*标准班次时间循环结束*/
        CLOSE CUR_SHIFTNORMAL;
      
        /*休假组的项目参考打卡*/
        IF AR_TEMP_LEAVEL_ROW.CARD_FLAG = 1 THEN
          /*打卡优先*/
          IF AR_TEMP_LEAVEL_ROW.APPLY_CARD_PRIORITY = 0 THEN
          
            /*进门时间或者出门时间不为空时*/
            IF VAR_INTIME IS NOT NULL AND VAR_OUTTIME IS NOT NULL THEN
            
              /*如果申请与打卡存在交集*/
              IF AR_GET_CROSSTIME(VAR_TEMP_INTIME,
                                  VAR_TEMP_OUTTIME,
                                  NVL(VAR_INTIME, VAR_SHIFTFROMTIME),
                                  NVL(VAR_OUTTIME, VAR_SHIFTTOTIME)) > 0 THEN
              
                /*取最大的开始时间*/
                IF VAR_TEMP_INTIME < NVL(VAR_INTIME, VAR_SHIFTFROMTIME) THEN
                  VAR_TEMP_INTIME := NVL(VAR_INTIME, VAR_SHIFTFROMTIME);
                END IF;
              
                /*取最小的结束时间*/
                IF VAR_TEMP_OUTTIME > NVL(VAR_OUTTIME, VAR_SHIFTTOTIME) THEN
                  VAR_TEMP_OUTTIME := NVL(VAR_OUTTIME, VAR_SHIFTTOTIME);
                END IF;
              
                OPEN CUR_SHIFTNORMAL;
                LOOP
                  FETCH CUR_SHIFTNORMAL
                    INTO SHIFTNORMAL_ROW;
                
                  EXIT WHEN CUR_SHIFTNORMAL%NOTFOUND;
                
                  /*取得休假时间：标准申请休假时间-申请时间与实际打卡时间的交集(扣除休息时间)*/
                  VAR_QUANTITY := VAR_QUANTITY -
                                  AR_GET_CROSSTIME(VAR_TEMP_INTIME,
                                                   VAR_TEMP_OUTTIME,
                                                   SHIFTNORMAL_ROW.SHIFT_START,
                                                   SHIFTNORMAL_ROW.SHIFT_END) * 24 * 60;
                END LOOP;
                CLOSE CUR_SHIFTNORMAL;
              
              END IF;
            
              /*取得休假时间：标准申请休假时间-申请时间与实际打卡时间的交集*/
              --                 VAR_QUANTITY := VAR_QUANTITY - Ar_Get_Crosstime(VAR_TEMP_INTIME,VAR_TEMP_OUTTIME,
              --                                                  NVL(VAR_INTIME,VAR_SHIFTFROMTIME),
              --                                                  NVL(VAR_OUTTIME,VAR_SHIFTTOTIME)
              --                                              )*24*60;
            
            END IF;
          
          END IF;
        
        END IF;
      
        /*更新休假组项目的休假时间(保留真实的申请开始结束时间)*/
        UPDATE AR_DETAIL_TEMP
           SET QUANTITY = VAR_QUANTITY
         WHERE NO = AR_TEMP_LEAVEL_ROW.NO;
        /*休假累积时间*/
        VAR_TEMP_QUANTITY := VAR_TEMP_QUANTITY + VAR_QUANTITY;
      
      END LOOP;
    
      /*休假项目组数据循环结束*/
      CLOSE CUR_AR_TEMP_LEAVEL;
    
      /*更新外层循环中的常规组项目的时间段(保留常规项目的真实开始结束时间)*/
      
      UPDATE AR_DETAIL_TEMP
         SET FROM_TIME=VAR_INTIME,
             TO_TIME=VAR_OUTTIME,
             QUANTITY = VAR_SHIFTHOUR * 60 - VAR_TEMP_QUANTITY --  应工作时间 - 休假累计时间
       WHERE NO = AR_TEMP_NORMAL_ROW.NO
       AND   AR_ITEM_NO = VAR_FINAL_ITEM_NORMAL;
    
    END LOOP;
  
    /*常规项目组循环结束*/
    CLOSE CUR_AR_TEMP_NORMAL;
    --循环班次信息一，用来获取当日上班时间，晕，这个相当乱
    
    VAR_QUANTITY_HOUR := 0.00;
    OPEN CUR_SHIFTNORMAL;
    LOOP
      FETCH CUR_SHIFTNORMAL
        INTO SHIFTNORMAL_ROW;
        EXIT WHEN CUR_SHIFTNORMAL%NOTFOUND;
      VAR_QUANTITY_HOUR := VAR_QUANTITY_HOUR + AR_GET_CROSSTIME(SHIFTNORMAL_ROW.SHIFT_START,
                                  SHIFTNORMAL_ROW.SHIFT_END,
                                  VAR_INTIME,
                                  VAR_OUTTIME);
    END LOOP;
    CLOSE CUR_SHIFTNORMAL;

    UPDATE AR_DETAIL_TEMP
         SET QUANTITY = VAR_QUANTITY_HOUR*24*60
         WHERE AR_ITEM_NO = VAR_FINAL_ITEM_NORMAL; --  应工作时间 - 休假累计时间
    
    VAR_ABSENT_START := VAR_TODAY_START;
    
    IF VAR_ABSENT_END IS NULL THEN
      VAR_ABSENT_END := VAR_TODAY_END;
    END IF;
    DBMS_OUTPUT.put_line('旷工ID______________号为：');
    --只打一次卡，算为旷工
    IF VAR_OUTTIME IS NULL THEN
      UPDATE AR_DETAIL_TEMP
       SET AR_ITEM_NO = VAR_FINAL_ITEM_ABSENT,
           FROM_TIME  = VAR_ABSENT_START,
           TO_TIME    = VAR_ABSENT_END,
           QUANTITY = (VAR_ABSENT_END - VAR_ABSENT_START)*24*60
     WHERE AR_ITEM_NO = VAR_FINAL_ITEM_NORMAL;
    END IF;
    /*更新所有开始结束时间为空的,并且为正常出勤的考勤项目为"旷工"*/
    UPDATE AR_DETAIL_TEMP
       SET AR_ITEM_NO = VAR_FINAL_ITEM_ABSENT,
           FROM_TIME  = VAR_ABSENT_START,
           TO_TIME    = VAR_ABSENT_END,
           QUANTITY   = (VAR_ABSENT_END - VAR_ABSENT_START)*24*60
     WHERE AR_ITEM_NO = VAR_FINAL_ITEM_NORMAL
       AND (FROM_TIME IS NULL
       OR TO_TIME IS NULL OR FROM_TIME=TO_TIME);

  
    /*删除旷工时间为0的记录*/
    DELETE FROM AR_DETAIL_TEMP
     WHERE AR_ITEM_NO = VAR_FINAL_ITEM_ABSENT
       AND QUANTITY <= 0;
    /*删除为旷工，但当天请假时间为八小时的旷工记录*/
    /*
    DELETE FROM AR_DETAIL_TEMP AR1
     WHERE AR1.AR_ITEM_NO = VAR_FINAL_ITEM_ABSENT
       AND (SELECT SUM(AR2.QUANTITY) FROM AR_DETAIL_TEMP AR2 
           WHERE AR2.AR_DATE_STR=AR1.AR_DATE_STR 
           AND AR2.EMPID = AR1.EMPID
           AND (SELECT ITEM_GROUP_CODE FROM AR_ITEM
               WHERE AR_ITEM.ITEM_NO = AR2.AR_ITEM_NO)
           IN('OverTimeGroup','LeavelGroup','SpecialGroup'))>=8*60;
     */
    /*更新所有开始结束时间为空的"休息"项目时间*/
    /*
    UPDATE AR_DETAIL_TEMP
    --SET FROM_TIME  = VAR_SHIFTFROMTIME,
    --  TO_TIME  = VAR_SHIFTTOTIME
       SET FROM_TIME = TO_DATE(VAR_SHIFTFROMTIME),
           TO_TIME   = TO_DATE(VAR_SHIFTFROMTIME)
     WHERE AR_ITEM_NO = VAR_FINAL_ITEM_HOLIDAY
       AND FROM_TIME IS NULL
       AND TO_TIME IS NULL;
    */
    --将班次为节假休日的开始时间和结束时间通通设为null
    UPDATE AR_DETAIL_TEMP
    --SET FROM_TIME  = VAR_SHIFTFROMTIME,
    --  TO_TIME  = VAR_SHIFTTOTIME
       SET FROM_TIME = NULL,
           TO_TIME   = NULL
     WHERE AR_ITEM_NO = VAR_FINAL_ITEM_HOLIDAY;
    
    /*删除周末为周末加班或者节日加班的白班休息信息*/
    DELETE FROM AR_DETAIL_TEMP AR1
      WHERE  AR1.AR_ITEM_NO = VAR_FINAL_ITEM_HOLIDAY
      AND    (SELECT COUNT(*) FROM AR_DETAIL_TEMP AR2 
              WHERE AR2.AR_DATE_STR = AR1.AR_DATE_STR
              AND   (AR2.AR_ITEM_NO = 4 
                     OR AR2.AR_ITEM_NO = 5))>0;
     
    /******************************************************取得迟到、早退时间************************************/
  
    /*取得当前员工在临时表中的休假记录数*/
    SELECT /*+ALL_ROWS*/
     COUNT(*), MIN(FROM_TIME), MAX(TO_TIME), SUM(QUANTITY)
      INTO VAR_COUNT, VAR_TEMP_INTIME, VAR_TEMP_OUTTIME, VAR_TEMP_QUANTITY
      FROM AR_DETAIL_TEMP A, AR_ITEM B
     WHERE A.EMPID = IN_EMPID
       AND A.AR_DATE_STR = IN_AR_DATE_STR
       AND A.AR_ITEM_NO = B.ITEM_NO
       AND B.ITEM_GROUP_CODE IN ('LeavelGroup', 'SpecialGroup');
  
    IF VAR_LOG_LEVEL > 0 THEN
      DBMS_OUTPUT.PUT_LINE('临时表中休假记录数: ' || TO_CHAR(VAR_COUNT));
    END IF;
  
    /*循环班次时间段 计算每段时间的迟到早退*/
    OPEN CUR_SHIFTNORMAL;
    LOOP
      FETCH CUR_SHIFTNORMAL
        INTO SHIFTNORMAL_ROW;
    
      EXIT WHEN CUR_SHIFTNORMAL%NOTFOUND;
      /*存在休假记录*/
      IF VAR_COUNT > 0 THEN
      
        /*取得迟到记录置于临时表中*/
        INSERT INTO AR_DETAIL_TEMP
          (NO,
           EMPID,
           AR_ITEM_NO,
           FROM_TIME,
           TO_TIME,
           SHIFT_NO,
           AR_DATE_STR,
           AR_MONTH_STR,
           QUANTITY,
           LOCK_YN,
           DATE_TYPE,
           UNIT,
           ITEM_TYPE)
          SELECT AR_DETAIL_TEMP_SEQ.NEXTVAL,
                 A.EMPID,
                 VAR_FINAL_ITEM_TARDINESS,
                 VAR_SHIFTFROMTIME,
                 A.FROM_TIME,
                 A.SHIFT_NO,
                 A.AR_DATE_STR,
                 A.AR_MONTH_STR,
                 AR_GET_CROSSTIME(SHIFTNORMAL_ROW.SHIFT_START,
                                  SHIFTNORMAL_ROW.SHIFT_END,
                                  VAR_SHIFTFROMTIME,
                                  A.FROM_TIME) * 24 * 60,
                 'N',
                 A.DATE_TYPE,
                 (SELECT MAX(UNIT)
                    FROM AR_ITEM_PARAM
                   WHERE AR_ITEM_NO = VAR_FINAL_ITEM_TARDINESS) AS UNIT,
                 3
            FROM AR_DETAIL_TEMP A, AR_ITEM_PARAM B
           WHERE A.AR_ITEM_NO = VAR_FINAL_ITEM_NORMAL
             AND TO_DATE(TO_CHAR(A.FROM_TIME, 'YYYY-MM-DD HH24:MI'),
                         'YYYY-MM-DD HH24:MI') >
                 TO_DATE(TO_CHAR(VAR_SHIFTFROMTIME, 'YYYY-MM-DD HH24:MI'),
                         'YYYY-MM-DD HH24:MI')
             AND A.AR_ITEM_NO = B.AR_ITEM_NO
             AND B.AR_GROUP_NO = CASE (SELECT COUNT(*)
                     FROM AR_ITEM_PARAM AIP
                    WHERE AIP.AR_ITEM_NO = A.AR_ITEM_NO
                      AND AIP.AR_GROUP_NO = VAR_GROUPNO)
                   WHEN 1 THEN
                    VAR_GROUPNO
                   ELSE
                    'constant'
                 END
             AND (VAR_TEMP_INTIME > VAR_SHIFTFROMTIME /*休假开始时间大于标准上班时间*/
                 OR (VAR_TEMP_INTIME = VAR_SHIFTFROMTIME AND
                 VAR_TEMP_QUANTITY < CASE (B.UNIT)
                   WHEN 'DAY' THEN
                    B.UNIT_VALUE * 24 * 60
                   WHEN 'HOUR' THEN
                    B.UNIT_VALUE * 60
                   ELSE
                    B.UNIT_VALUE
                 END / 2) /*休假开始时间等于标准上班时间并且休假时间小于休假项目的最小单位的一半*/
                 );
      
        /*取得早退记录置于临时表中*/
        INSERT INTO AR_DETAIL_TEMP
          (NO,
           EMPID,
           AR_ITEM_NO,
           FROM_TIME,
           TO_TIME,
           SHIFT_NO,
           AR_DATE_STR,
           AR_MONTH_STR,
           QUANTITY,
           LOCK_YN,
           DATE_TYPE,
           UNIT,
           ITEM_TYPE)
          SELECT AR_DETAIL_TEMP_SEQ.NEXTVAL,
                 A.EMPID,
                 VAR_FINAL_ITEM_TRUANCY,
                 A.TO_TIME,
                 VAR_SHIFTTOTIME,
                 A.SHIFT_NO,
                 A.AR_DATE_STR,
                 A.AR_MONTH_STR,
                 AR_GET_CROSSTIME(SHIFTNORMAL_ROW.SHIFT_START,
                                  SHIFTNORMAL_ROW.SHIFT_END,
                                  A.TO_TIME,
                                  VAR_SHIFTTOTIME) * 24 * 60,
                 'N',
                 A.DATE_TYPE,
                 (SELECT MAX(UNIT)
                    FROM AR_ITEM_PARAM
                   WHERE AR_ITEM_NO = VAR_FINAL_ITEM_TRUANCY) AS UNIT,
                 3
            FROM AR_DETAIL_TEMP A, AR_ITEM_PARAM B
           WHERE A.AR_ITEM_NO = VAR_FINAL_ITEM_NORMAL
             AND TO_DATE(TO_CHAR(A.TO_TIME, 'YYYY-MM-DD HH24:MI'),
                         'YYYY-MM-DD HH24:MI') <
                 TO_DATE(TO_CHAR(VAR_SHIFTTOTIME, 'YYYY-MM-DD HH24:MI'),
                         'YYYY-MM-DD HH24:MI')
             AND A.AR_ITEM_NO = B.AR_ITEM_NO
             AND B.AR_GROUP_NO = CASE (SELECT COUNT(*)
                     FROM AR_ITEM_PARAM AIP
                    WHERE AIP.AR_ITEM_NO = A.AR_ITEM_NO
                      AND AIP.AR_GROUP_NO = VAR_GROUPNO)
                   WHEN 1 THEN
                    VAR_GROUPNO
                   ELSE
                    'constant'
                 END
             AND (VAR_TEMP_OUTTIME < VAR_SHIFTTOTIME /*休假结束时间小于标准下班班时间*/
                 OR (VAR_TEMP_OUTTIME = VAR_SHIFTTOTIME AND
                 VAR_TEMP_QUANTITY < CASE (B.UNIT)
                   WHEN 'DAY' THEN
                    B.UNIT_VALUE * 24 * 60
                   WHEN 'HOUR' THEN
                    B.UNIT_VALUE * 60
                   ELSE
                    B.UNIT_VALUE
                 END / 2) /*休假结束时间等于标准下班时间并且休假时间小于休假项目的最小单位的一半*/
                 );
      
        /*无休假记录*/
      ELSE
      
        /*取得迟到记录置于临时表中*/
        INSERT INTO AR_DETAIL_TEMP
          (NO,
           EMPID,
           AR_ITEM_NO,
           FROM_TIME,
           TO_TIME,
           SHIFT_NO,
           AR_DATE_STR,
           AR_MONTH_STR,
           QUANTITY,
           LOCK_YN,
           DATE_TYPE,
           UNIT,
           ITEM_TYPE)
          SELECT AR_DETAIL_TEMP_SEQ.NEXTVAL,
                 A.EMPID,
                 VAR_FINAL_ITEM_TARDINESS,
                 VAR_SHIFTFROMTIME,
                 A.FROM_TIME,
                 A.SHIFT_NO,
                 A.AR_DATE_STR,
                 A.AR_MONTH_STR,
                 AR_GET_CROSSTIME(SHIFTNORMAL_ROW.SHIFT_START,
                                  SHIFTNORMAL_ROW.SHIFT_END,
                                  VAR_SHIFTFROMTIME,
                                  A.FROM_TIME) * 24 * 60,
                 'N',
                 A.DATE_TYPE,
                 (SELECT MAX(UNIT)
                    FROM AR_ITEM_PARAM
                   WHERE AR_ITEM_NO = VAR_FINAL_ITEM_TARDINESS) AS UNIT,
                 3
            FROM AR_DETAIL_TEMP A
           WHERE A.AR_ITEM_NO = VAR_FINAL_ITEM_NORMAL
             AND TO_DATE(TO_CHAR(A.FROM_TIME, 'YYYY-MM-DD HH24:MI'),
                         'YYYY-MM-DD HH24:MI') >
                 TO_DATE(TO_CHAR(VAR_SHIFTFROMTIME, 'YYYY-MM-DD HH24:MI'),
                         'YYYY-MM-DD HH24:MI');
      
        /*取得早退记录置于临时表中*/
        INSERT INTO AR_DETAIL_TEMP
          (NO,
           EMPID,
           AR_ITEM_NO,
           FROM_TIME,
           TO_TIME,
           SHIFT_NO,
           AR_DATE_STR,
           AR_MONTH_STR,
           QUANTITY,
           LOCK_YN,
           DATE_TYPE,
           UNIT,
           ITEM_TYPE)
          SELECT AR_DETAIL_TEMP_SEQ.NEXTVAL,
                 A.EMPID,
                 VAR_FINAL_ITEM_TRUANCY,
                 A.TO_TIME,
                 VAR_SHIFTTOTIME,
                 A.SHIFT_NO,
                 A.AR_DATE_STR,
                 A.AR_MONTH_STR,
                 AR_GET_CROSSTIME(SHIFTNORMAL_ROW.SHIFT_START,
                                  SHIFTNORMAL_ROW.SHIFT_END,
                                  A.TO_TIME,
                                  VAR_SHIFTTOTIME) * 24 * 60,
                 'N',
                 A.DATE_TYPE,
                 (SELECT MAX(UNIT)
                    FROM AR_ITEM_PARAM
                   WHERE AR_ITEM_NO = VAR_FINAL_ITEM_TRUANCY) AS UNIT,
                 3
            FROM AR_DETAIL_TEMP A
           WHERE A.AR_ITEM_NO = VAR_FINAL_ITEM_NORMAL
             AND TO_DATE(TO_CHAR(A.TO_TIME, 'YYYY-MM-DD HH24:MI'),
                         'YYYY-MM-DD HH24:MI') <
                 TO_DATE(TO_CHAR(VAR_SHIFTTOTIME, 'YYYY-MM-DD HH24:MI'),
                         'YYYY-MM-DD HH24:MI');
      
      END IF;
    
    END LOOP;
    CLOSE CUR_SHIFTNORMAL;
  
    OPEN CUR_DETAIL_TEMP;
  LOOP
      FETCH CUR_DETAIL_TEMP
        INTO DETAIL_ROW;
    
      EXIT WHEN CUR_DETAIL_TEMP%NOTFOUND;
  END LOOP;
  CLOSE CUR_DETAIL_TEMP;
  END;

  /*取得当前员工在记录处理后临时表中的记录数*/
  SELECT COUNT(*)
    INTO VAR_COUNT
    FROM AR_DETAIL_TEMP
   WHERE EMPID = IN_EMPID
     AND AR_DATE_STR = IN_AR_DATE_STR;

  IF VAR_LOG_LEVEL > 0 THEN
    DBMS_OUTPUT.PUT_LINE('处理后临时记录数: ' || TO_CHAR(VAR_COUNT));
  END IF;

  /**************************************处理临时表中记录结束****************************************/

  /***************************************汇总临时表中信息开始***************************************/

  /*汇总临时表数据插入日考勤明晰表*/
  INSERT INTO AR_DETAIL
    (PK_NO,
     EMPID,
     AR_ITEM_NO,
     FROM_TIME,
     TO_TIME,
     SHIFT_NO,
     AR_DATE_STR,
     AR_MONTH_STR,
     QUANTITY,
     LOCK_YN,
     DATE_TYPE,
     UNIT)
    SELECT AR_DETAIL_SEQ.NEXTVAL,
           EMPID,
           AR_ITEM_NO,
           FROM_TIME,
           TO_TIME,
           SHIFT_NO,
           AR_DATE_STR,
           AR_MONTH_STR,
           QUANTITY,
           LOCK_YN,
           DATE_TYPE,
           UNIT
      FROM (SELECT EMPID,
                   AR_ITEM_NO,
                   MIN(FROM_TIME) FROM_TIME,
                   MAX(TO_TIME) TO_TIME,
                   SHIFT_NO,
                   AR_DATE_STR,
                   AR_MONTH_STR,
                   SUM(QUANTITY) QUANTITY,
                   LOCK_YN,
                   DATE_TYPE,
                   UNIT
              FROM AR_DETAIL_TEMP
             GROUP BY EMPID,
                      AR_ITEM_NO,
                      SHIFT_NO,
                      AR_DATE_STR,
                      AR_MONTH_STR,
                      LOCK_YN,
                      DATE_TYPE,
                      UNIT);

  /*清除临时表的数据*/
  --EXECUTE IMMEDIATE 'TRUNCATE TABLE AR_DETAIL_TEMP'; 
COMMIT;
  EXECUTE IMMEDIATE 'TRUNCATE TABLE AR_APPLY_RESULT';
/*********TEST**************************/
/**
select ar_detail.quantity into VAR_QUANTITY FROM ar_detail WHERE EMPID = IN_EMPID
     AND AR_DATE_STR = IN_AR_DATE_STR
     AND (LOCK_YN <> 'Y' OR LOCK_YN IS NULL)
     and ar_item_no = '15';
DBMS_OUTPUT.put_line(VAR_QUANTITY);     
select ar_detail.quantity into VAR_QUANTITY FROM ar_detail WHERE EMPID = IN_EMPID
     AND AR_DATE_STR = IN_AR_DATE_STR
     AND (LOCK_YN <> 'Y' OR LOCK_YN IS NULL)
     and ar_item_no = '20';
DBMS_OUTPUT.put_line(VAR_QUANTITY);  
**/
/***********************************/
  /*根据考勤项目的最小单位，数量值格式化*/
  UPDATE AR_DETAIL
     SET AR_DETAIL.QUANTITY = NVL((SELECT TRUNC(DECODE(AR_ITEM_PARAM.UNIT,
                                                      'DAY',
                                                      AR_DETAIL.QUANTITY / 8 / 60,
                                                      'HOUR',
                                                      AR_DETAIL.QUANTITY / 60,
                                                      'MINUTE',
                                                      AR_DETAIL.QUANTITY) -- 非加班项目四舍五入，加班项目取整
                                               / AR_ITEM_PARAM.UNIT_VALUE +
                                               DECODE(AR_ITEM.ITEM_GROUP_CODE,
                                                      'OverTimeGroup',
                                                      0,
                                                      0.01)) *
                                         AR_ITEM_PARAM.UNIT_VALUE
                                    FROM AR_ITEM_PARAM, AR_ITEM
                                   WHERE AR_DETAIL.AR_ITEM_NO =
                                         AR_ITEM_PARAM.AR_ITEM_NO
                                     AND AR_ITEM.ITEM_NO =
                                         AR_ITEM_PARAM.AR_ITEM_NO
                                     AND AR_ITEM_PARAM.UNIT_VALUE IS NOT NULL
                                     AND AR_ITEM_PARAM.UNIT_VALUE <> 0
                                     AND AR_ITEM_PARAM.AR_GROUP_NO =
                                         CASE (SELECT COUNT(*)
                                             FROM AR_ITEM_PARAM AIP
                                            WHERE AIP.AR_ITEM_NO =
                                                  AR_DETAIL.AR_ITEM_NO
                                              AND AIP.AR_GROUP_NO =
                                                  VAR_GROUPNO)
                                           WHEN 1 THEN
                                            VAR_GROUPNO
                                           ELSE
                                            'constant'
                                         END),
                                  0.01*(round((AR_DETAIL.QUANTITY/60)/0.01)))
   WHERE AR_DETAIL.EMPID = IN_EMPID
     AND AR_DETAIL.AR_DATE_STR = IN_AR_DATE_STR
     AND AR_DETAIL.LOCK_YN <> 'Y';

/*********TEST**************************/
/**
select ar_detail.quantity into VAR_QUANTITY FROM ar_detail WHERE EMPID = IN_EMPID
     AND AR_DATE_STR = IN_AR_DATE_STR
     AND (LOCK_YN <> 'Y' OR LOCK_YN IS NULL)
     and ar_item_no = '15';
DBMS_OUTPUT.put_line(VAR_QUANTITY);     
select ar_detail.quantity into VAR_QUANTITY FROM ar_detail WHERE EMPID = IN_EMPID
     AND AR_DATE_STR = IN_AR_DATE_STR
     AND (LOCK_YN <> 'Y' OR LOCK_YN IS NULL)
     and ar_item_no = '20';
DBMS_OUTPUT.put_line(VAR_QUANTITY);  
**/
/***********************************/
  /*清除小于考勤项目的最小值参数的记录*/
  UPDATE AR_DETAIL
     SET AR_DETAIL.QUANTITY = 0
   WHERE AR_DETAIL.QUANTITY <
         (SELECT AR_ITEM_PARAM.MIN_VALUE
            FROM AR_ITEM_PARAM
           WHERE AR_DETAIL.AR_ITEM_NO = AR_ITEM_PARAM.AR_ITEM_NO
             AND AR_ITEM_PARAM.AR_GROUP_NO =
                 CASE (SELECT COUNT(*)
                     FROM AR_ITEM_PARAM AIP
                    WHERE AIP.AR_ITEM_NO = AR_DETAIL.AR_ITEM_NO
                      AND AIP.AR_GROUP_NO = VAR_GROUPNO)
                   WHEN 1 THEN
                    VAR_GROUPNO
                   ELSE
                    'constant'
                 END)
     AND AR_DATE_STR = IN_AR_DATE_STR
     AND EMPID = IN_EMPID
     AND AR_DETAIL.LOCK_YN <> 'Y';
  /*删除不需要显示的“0值”记录*/
  DELETE FROM AR_DETAIL
   WHERE QUANTITY = 0
     AND AR_ITEM_NO IN (VAR_FINAL_ITEM_TARDINESS, VAR_FINAL_ITEM_TRUANCY)
     AND EMPID = IN_EMPID
     AND AR_DATE_STR = IN_AR_DATE_STR;

  /*更新大于考勤项目的最大值参数的记录*/
  UPDATE AR_DETAIL
     SET AR_DETAIL.QUANTITY =
         (SELECT AR_ITEM_PARAM.MAX_VALUE
            FROM AR_ITEM_PARAM
           WHERE AR_DETAIL.AR_ITEM_NO = AR_ITEM_PARAM.AR_ITEM_NO
             AND AR_ITEM_PARAM.AR_GROUP_NO =
                 CASE (SELECT COUNT(*)
                     FROM AR_ITEM_PARAM AIP
                    WHERE AIP.AR_ITEM_NO = AR_DETAIL.AR_ITEM_NO
                      AND AIP.AR_GROUP_NO = VAR_GROUPNO)
                   WHEN 1 THEN
                    VAR_GROUPNO
                   ELSE
                    'constant'
                 END)
   WHERE AR_DETAIL.QUANTITY >
         (SELECT AR_ITEM_PARAM.MAX_VALUE
            FROM AR_ITEM_PARAM
           WHERE AR_DETAIL.AR_ITEM_NO = AR_ITEM_PARAM.AR_ITEM_NO
             AND AR_ITEM_PARAM.AR_GROUP_NO =
                 CASE (SELECT COUNT(*)
                     FROM AR_ITEM_PARAM AIP
                    WHERE AIP.AR_ITEM_NO = AR_DETAIL.AR_ITEM_NO
                      AND AIP.AR_GROUP_NO = VAR_GROUPNO)
                   WHEN 1 THEN
                    VAR_GROUPNO
                   ELSE
                    'constant'
                 END)
     AND AR_DETAIL.AR_DATE_STR = IN_AR_DATE_STR
     AND AR_DETAIL.EMPID = IN_EMPID
     AND AR_DETAIL.LOCK_YN <> 'Y';

    COMMIT;
  /***************************************汇总临时表中信息结束********************************/
  OUT_STR := '员工 ' || IN_EMPID || ' 在 ' || IN_AR_DATE_STR || ' 日考勤计算成功';

  --IF VAR_LOG_LEVEL > 0
  --THEN
  --DBMS_OUTPUT.PUT_LINE (OUT_STR);
  --END IF;
  
  
END AR_DETAIL_CALCULATE;
/

prompt
prompt Creating procedure AR_DETAIL_CAL
prompt ================================
prompt
CREATE OR REPLACE PROCEDURE Ar_Detail_Cal (
   in_sdate                   VARCHAR2,
   in_edate                   VARCHAR2,
   in_caltype                 VARCHAR2,                            --      'supervisor'/'dept'/'emp'
   in_deptid                  VARCHAR2,
   inout_empid       IN OUT   VARCHAR2
)
AUTHID CURRENT_USER
IS
   var_date_count   INT            := 0;
   var_fail_count   INT            := 0;
   var_emp_count    INT            := 0;
   var_outstr       VARCHAR2 (100) := NULL;
   var_time         DATE           := SYSDATE;
   NO_PERMIT         EXCEPTION;


/******************************************************************************
   NAME:       AR_DETAIL_CAL
   PURPOSE:    按 考勤员别/部门别/员工别 计算员工指定时间段内的考勤明细

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        04/03/2006   Pennix       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     AR_DETAIL_CAL
      Sysdate:         04/03/2006
      Date and Time:   04/03/2006, 13:12:02, and 04/03/2006 13:12:02
      Username:        Pennix (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/

 -- 定义开始日期到结束日期间的日期游标
   CURSOR cur_date
   IS
      SELECT   TO_CHAR (ddate, 'YYYY/MM/DD') ar_date_str
          FROM AR_CALENDER
         WHERE ddate BETWEEN TO_DATE (in_sdate, 'YYYY-MM-DD') AND TO_DATE (in_edate, 'YYYY-MM-DD')
      ORDER BY ddate;

   --定义该部门下包含的人员的游标，参数1：部门ID，参数2：考勤日期
   CURSOR cur_emp_dept (cur_in_deptid VARCHAR2, cur_in_ar_date_str VARCHAR2)
   IS
        SELECT HR_EMPLOYEE.empid, HR_EMPLOYEE.chinesename
          FROM HR_EMPLOYEE
         WHERE HR_EMPLOYEE.deptid in ( select deptid from hr_department start with deptid = cur_in_deptid connect by prior deptid = parent_dept_id)
           AND (
                     HR_EMPLOYEE.LEFT_DATE IS NULL
                   OR HR_EMPLOYEE.LEFT_DATE >= TO_DATE (cur_in_ar_date_str, 'YYYY/MM/DD')
               )
      ORDER BY HR_EMPLOYEE.empid;
BEGIN
   CASE UPPER (in_caltype)
      WHEN 'DEPT'       -- 部门别日考勤明晰计算
      THEN
         FOR date_row IN cur_date
         LOOP
   BEGIN
     IF GET_DAILY_STATUS(date_row.ar_date_str) = 1 THEN -- 验证该天日考勤是否已经锁定
       RAISE NO_PERMIT;
    END IF;

             var_emp_count := 0;

             FOR emp_row IN cur_emp_dept (in_deptid, date_row.ar_date_str)
             LOOP
                BEGIN
                   Ar_Detail_Calculate (emp_row.empid, date_row.ar_date_str, var_outstr);
                EXCEPTION
                   WHEN OTHERS
                   THEN
                      RAISE_APPLICATION_ERROR (-20101,
                                               '员工 [' || emp_row.chinesename || '] 计算发生异常',
                                               TRUE
                                              );
                END;

                var_emp_count := var_emp_count + 1;
             END LOOP;

             var_date_count := var_date_count + 1;

   EXCEPTION
     WHEN NO_PERMIT -- 如果当天考勤已经锁定不做任何处理
     THEN
      var_fail_count := var_fail_count + 1;
   END;
         END LOOP;

         inout_empid :=
               TO_CHAR (var_emp_count)
            || ' 位员工 '
            || TO_CHAR (var_date_count)
            || ' 天考勤计算完成, 用时 '
            || TRUNC ((SYSDATE - var_time) * 24 * 60 * 60 + 0.005, 2)
            || ' 秒. ';
   IF var_fail_count <> 0 THEN
    inout_empid := inout_empid || '<font color="Red">由于部分日考勤已经锁定，' || TO_CHAR (var_fail_count) || '天考勤未能进行计算.</font>';
   END IF;

      WHEN 'EMP'        -- 员工别日考勤明晰计算
      THEN
         FOR date_row IN cur_date
         LOOP
   BEGIN
     IF GET_DAILY_STATUS(date_row.ar_date_str) = 1 THEN -- 验证该天日考勤是否已经锁定
       RAISE NO_PERMIT;
    END IF;

             BEGIN
                Ar_Detail_Calculate (inout_empid, date_row.ar_date_str, var_outstr);
             EXCEPTION
                WHEN OTHERS
                THEN
                   RAISE_APPLICATION_ERROR (-20101, '员工计算发生异常', TRUE);
             END;

             var_date_count := var_date_count + 1;

   EXCEPTION
     WHEN NO_PERMIT -- 如果当天考勤已经锁定不做任何处理
     THEN
      var_fail_count := var_fail_count + 1;
   END;
         END LOOP;

         inout_empid :=
               TO_CHAR (var_date_count)
            || ' 天考勤计算完成, 用时 '
            || TRUNC ((SYSDATE - var_time) * 24 * 60 * 60 + 0.005, 2)
            || ' 秒. ';
  IF var_fail_count <> 0 THEN
    inout_empid := inout_empid || '<font color="Red">由于部分日考勤已经锁定，' || TO_CHAR (var_fail_count) || '天考勤未能进行计算.</font>';
   END IF;

   END CASE;
EXCEPTION
   WHEN case_not_found
   THEN
      RAISE_APPLICATION_ERROR (-20101, '无效计算类型,计算失败');
   WHEN OTHERS
   THEN
      RAISE_APPLICATION_ERROR (-20101, '未指定的错误', TRUE);
END Ar_Detail_Cal;
/

prompt
prompt Creating procedure AR_DETAIL_CALALL
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE ar_detail_calall
AUTHID CURRENT_USER
IS
   var_status   VARCHAR2 (50);
/******************************************************************************
   NAME:       AR_DETAIL_CALALL
   PURPOSE:    遍历所有员工, 循环调用 AR_DETAIL_CALCULATE, 计算昨日的考勤明细

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        03/04/2006   Pennix       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     AR_DETAIL_CALALL
      Sysdate:         03/04/2006
      Date and Time:   03/04/2006, 12:10:34, and 03/04/2006 12:10:34
      Username:        Pennix (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   DECLARE
      CURSOR cur_emp
      IS
         /*计算对象为所有在职员工及在计算日期之后退社的员工*/
         SELECT empid
           FROM hr_employee
          WHERE status_code <> 'Status03' OR SYSDATE - 1 < LEFT_DATE;

      emp_cur   cur_emp%ROWTYPE;
   BEGIN
      OPEN cur_emp;

      LOOP
         FETCH cur_emp
          INTO emp_cur;

         EXIT WHEN cur_emp%NOTFOUND;

         BEGIN
            ar_detail_calculate (emp_cur.empid, TO_CHAR (SYSDATE - 1, 'YYYY/MM/DD'), var_status);
         EXCEPTION
            WHEN OTHERS
            THEN
               NULL;
         END;
      END LOOP;

      CLOSE cur_emp;
   END;
END ar_detail_calall;
/

prompt
prompt Creating procedure AR_DETAIL_CALALL_BY_DATE
prompt ===========================================
prompt
CREATE OR REPLACE PROCEDURE ar_detail_calall_by_date (in_ar_date_str VARCHAR2)
AUTHID CURRENT_USER
IS
   var_status   VARCHAR2 (50);
/******************************************************************************
   NAME:       AR_DETAIL_CALALL
   PURPOSE:    遍历所有员工, 循环调用 AR_DETAIL_CALCULATE, 计算某日期的考勤明细

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        03/04/2006   Pennix       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     AR_DETAIL_CALALL
      Sysdate:         03/04/2006
      Date and Time:   03/04/2006, 12:10:34, and 03/04/2006 12:10:34
      Username:        Pennix (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   DECLARE
      CURSOR cur_emp
      IS
         /*计算对象为所有在职员工及在计算日期之后退社的员工*/
         SELECT empid
           FROM hr_employee
          WHERE status_code <> 'Status03' OR TO_DATE(in_ar_date_str, 'YYYY/MM/DD') < left_date;

      emp_cur   cur_emp%ROWTYPE;
   BEGIN
      OPEN cur_emp;

      LOOP
         FETCH cur_emp
          INTO emp_cur;

         EXIT WHEN cur_emp%NOTFOUND;
         ar_detail_calculate (emp_cur.empid, in_ar_date_str, var_status);
      END LOOP;

      CLOSE cur_emp;
   END;
END ar_detail_calall_by_date;
/

prompt
prompt Creating procedure AR_DETAIL_CAL_DAILY
prompt ======================================
prompt
create or replace procedure AR_DETAIL_CAL_DAILY(
   in_sdate                   VARCHAR2
) 
AUTHID CURRENT_USER
is

   var_alert_str    VARCHAR2 (20000)    := '' ;
   var_create_str   VARCHAR2 (20000)    := '' ;
   NO_PERMIT        EXCEPTION                 ;
   var_count        NUMBER                    ;
   VAR_ALERT_FLAG   NUMBER                    ;
   v_date           varchar2(20);

    -- 考勤明细项目游标
   CURSOR cus_item_detail
   IS
      SELECT A.item_no, A.item_id || '_D' AS item_id, A.item_name
        FROM AR_ITEM A
       ORDER BY A.ITEM_ID ;

     
BEGIN
   
     DBMS_OUTPUT.ENABLE (5000000);
   -- 检查表是否存在

    SELECT COUNT(TABLE_NAME) INTO VAR_ALERT_FLAG
           FROM USER_ALL_TABLES
          WHERE TABLE_NAME = 'AR_DETAIL_SUMMARY' ;

    IF VAR_ALERT_FLAG = 0 THEN
        BEGIN
            EXECUTE IMMEDIATE 'create table AR_DETAIL_SUMMARY(AR_DATE  CHAR(10))';
        EXCEPTION
            WHEN OTHERS
            THEN
               RAISE_APPLICATION_ERROR (-20101,'create table Error:' || SQLERRM);
        END ;
    END IF ;

   -- 检查 字段 AR_DATE
   SELECT COUNT(COLUMN_NAME) INTO VAR_ALERT_FLAG
          FROM USER_TAB_COLS
          WHERE TABLE_NAME = 'AR_DETAIL_SUMMARY' AND COLUMN_NAME = 'AR_DATE' ;

    IF VAR_ALERT_FLAG = 0 THEN
        BEGIN
            EXECUTE IMMEDIATE 'alter table AR_DETAIL_SUMMARY add AR_DATE CHAR(10) ';
        EXCEPTION
            WHEN OTHERS
            THEN
               RAISE_APPLICATION_ERROR (-20101,'alter table add AR_DATE Error:' || SQLERRM);
        END ;
    END IF ;

    -- 检查 字段 EMPID
    SELECT COUNT(COLUMN_NAME) INTO VAR_ALERT_FLAG
          FROM USER_TAB_COLS
          WHERE TABLE_NAME = 'AR_DETAIL_SUMMARY' AND COLUMN_NAME = 'EMPID' ;

    IF VAR_ALERT_FLAG = 0 THEN
        BEGIN
            EXECUTE IMMEDIATE 'alter table AR_DETAIL_SUMMARY add EMPID VARCHAR(10) ';
        EXCEPTION
            WHEN OTHERS
            THEN
               RAISE_APPLICATION_ERROR (-20101,'alter table add EMPID Error:' || SQLERRM);
        END ;
    END IF ;
    
        -- 检查 字段 SHIFT
    SELECT COUNT(COLUMN_NAME) INTO VAR_ALERT_FLAG
          FROM USER_TAB_COLS
          WHERE TABLE_NAME = 'AR_DETAIL_SUMMARY' AND COLUMN_NAME = 'SHIFT' ;

    IF VAR_ALERT_FLAG = 0 THEN
        BEGIN
            EXECUTE IMMEDIATE 'alter table AR_DETAIL_SUMMARY add SHIFT VARCHAR(50) ';
        EXCEPTION
            WHEN OTHERS
            THEN
               RAISE_APPLICATION_ERROR (-20101,'alter table add SHIFT Error:' || SQLERRM);
        END ;
    END IF ;
    
        -- 检查 字段 TYPEID
    SELECT COUNT(COLUMN_NAME) INTO VAR_ALERT_FLAG
          FROM USER_TAB_COLS
          WHERE TABLE_NAME = 'AR_DETAIL_SUMMARY' AND COLUMN_NAME = 'TYPEID' ;

    IF VAR_ALERT_FLAG = 0 THEN
        BEGIN
            EXECUTE IMMEDIATE 'alter table AR_DETAIL_SUMMARY add TYPEID NUMBER ';
        EXCEPTION
            WHEN OTHERS
            THEN
               RAISE_APPLICATION_ERROR (-20101,'alter table add TYPEID Error:' || SQLERRM);
        END ;
    END IF ;

    -- 检查 字段 SHIFT_NAME
    SELECT COUNT(COLUMN_NAME) INTO VAR_ALERT_FLAG
          FROM USER_TAB_COLS
          WHERE TABLE_NAME = 'AR_DETAIL_SUMMARY' AND COLUMN_NAME = 'SHIFT_NAME' ;

    IF VAR_ALERT_FLAG = 0 THEN
        BEGIN
            EXECUTE IMMEDIATE 'alter table AR_DETAIL_SUMMARY add SHIFT_NAME VARCHAR(50) ';
        EXCEPTION
            WHEN OTHERS
            THEN
               RAISE_APPLICATION_ERROR (-20101,'alter table add SHIFT_NAME Error:' || SQLERRM);
        END ;
    END IF ;
    
        -- 检查 字段 DATE_TYPE
    SELECT COUNT(COLUMN_NAME) INTO VAR_ALERT_FLAG
          FROM USER_TAB_COLS
          WHERE TABLE_NAME = 'AR_DETAIL_SUMMARY' AND COLUMN_NAME = 'DATE_TYPE' ;

    IF VAR_ALERT_FLAG = 0 THEN
        BEGIN
            EXECUTE IMMEDIATE 'alter table AR_DETAIL_SUMMARY add DATE_TYPE NUMBER ';
        EXCEPTION
            WHEN OTHERS
            THEN
               RAISE_APPLICATION_ERROR (-20101,'alter table add DATE_TYPE Error:' || SQLERRM);
        END ;
    END IF ;


   -- 添加缺少的字段
   DECLARE
       -- 查找，AR_DETAIL_SUMMARY 中，不存在的字段
       CURSOR cur_field
       IS
          SELECT AI.ITEM_ID || '_D' AS ITEM_ID FROM AR_ITEM AI WHERE NOT EXISTS (
                 SELECT * FROM USER_TAB_COLS UTC WHERE UTC.TABLE_NAME = 'AR_DETAIL_SUMMARY' AND UTC.COLUMN_NAME = (AI.ITEM_ID || '_D'))
          and ai.item_no <> '36' ORDER BY AI.ITEM_ID ;

      FIELD_ROW   CUR_FIELD%ROWTYPE;
   BEGIN
      OPEN CUR_FIELD;
      LOOP
         FETCH CUR_FIELD
          INTO FIELD_ROW;
         EXIT WHEN CUR_FIELD%NOTFOUND ;
         --DBMS_OUTPUT.put_line ('var_alert_str=' || var_alert_str);
         var_alert_str := ' alter table AR_DETAIL_SUMMARY add ' || FIELD_ROW.ITEM_ID || ' NUMBER ' ;
          /*修改 AR_DETAIL_SUMMARY 表*/
         BEGIN
            EXECUTE IMMEDIATE var_alert_str;
         EXCEPTION
            WHEN OTHERS
            THEN
               RAISE_APPLICATION_ERROR (-20101, var_alert_str || 'Error:' || SQLERRM);
          END;

       END LOOP ;
       CLOSE  CUR_FIELD ;
    END ;
   
   -- 循环考勤项目, 将 AR_DETAIL 行转列, 同时加入日历信息, 插入 AR_DETAIL_SUMMARY*/
   var_create_str := 'INSERT INTO AR_DETAIL_SUMMARY (AR_DATE,EMPID,SHIFT,TYPEID,SHIFT_NAME,DATE_TYPE' ;

   FOR detail_item_row IN cus_item_detail
   LOOP
      var_create_str := var_create_str || ',' || detail_item_row.item_id ;
   END LOOP;

   var_create_str :=
         var_create_str || ' ) SELECT TO_CHAR(TO_DATE(AD.AR_DATE_STR,''YYYY-MM-DD''),''YYYY-MM-DD''),AD.EMPID,AST.SHIFT_NAME SHIFT,AC.TYPEID,ASH.SHIFT_NAME,AD.DATE_TYPE';

   FOR detail_item_row IN cus_item_detail
   LOOP
      /*将日考勤的项目列转行*/
      var_create_str :=
            var_create_str
         || ',SUM(CASE AD.AR_ITEM_NO WHEN '
         || TO_CHAR (detail_item_row.item_no)
         || ' THEN AD.QUANTITY ELSE 0 END) AS "'
         || detail_item_row.item_id || '"';
   END LOOP;

   var_create_str := var_create_str
      || ' FROM AR_DETAIL AD,AR_SHIFT010 ASH ,AR_CALENDER AC,AR_SHIFT010 AST'
      || ' WHERE AC.SHIFT_NO = AST.SHIFT_NO AND AD.AR_DATE_STR = TO_CHAR(AC.DDATE,''YYYY/MM/DD'')'
      || ' AND  AD.SHIFT_NO = ASH.SHIFT_NO AND AD.AR_DATE_STR = '''
      || TO_CHAR(TO_DATE(in_sdate,'YYYY-MM-DD'),'YYYY/MM/DD') || '''' ;

   var_create_str := var_create_str
      || ' GROUP BY AD.EMPID,AD.AR_DATE_STR,AST.SHIFT_NAME,AC.TYPEID,ASH.SHIFT_NAME,AD.DATE_TYPE'
      || ' ORDER BY AD.EMPID,AD.AR_DATE_STR ';
      
     --var_count := 0;
   -- DBMS_OUTPUT.put_line ('插入 TABLE AR_DETAIL_SUMMARY 的SQL：');
     --DBMS_OUTPUT.put_line (var_create_str);
     /* WHILE var_count * 120 <= LENGTH (var_create_str)
       LOOP
         DBMS_OUTPUT.put_line (SUBSTR (var_create_str, var_count * 120 + 1, 120));
          var_count := var_count + 1;
       END LOOP;
    */
     -- 插入数据
     BEGIN
        EXECUTE IMMEDIATE var_create_str;
     EXCEPTION
        WHEN OTHERS
        THEN
           RAISE_APPLICATION_ERROR (-20101,'INSERT INTO  AR_DETAIL_SUMMARY Error: ' || SQLERRM);
      END;
    
    COMMIT;
END AR_DETAIL_CAL_DAILY;
/

prompt
prompt Creating procedure AR_DETAIL_CAL_DAILY_2011323
prompt ==============================================
prompt
create or replace procedure AR_DETAIL_CAL_DAILY_2011323(
   in_sdate                   VARCHAR2
)
AUTHID CURRENT_USER
is

   var_alert_str    VARCHAR2 (20000)    := '' ;
   var_create_str   VARCHAR2 (20000)    := '' ;
   NO_PERMIT        EXCEPTION                 ;
   var_count        NUMBER                    ;
   VAR_ALERT_FLAG   NUMBER                    ;
   v_date           varchar2(20);

    -- 考勤明细项目游标
   CURSOR cus_item_detail
   IS
      SELECT A.item_no, A.item_id || '_D' AS item_id, A.item_name
        FROM AR_ITEM A
       ORDER BY A.ITEM_ID ;


BEGIN

     DBMS_OUTPUT.ENABLE (5000000);
   -- 检查表是否存在

    SELECT COUNT(TABLE_NAME) INTO VAR_ALERT_FLAG
           FROM USER_ALL_TABLES
          WHERE TABLE_NAME = 'AR_DETAIL_SUMMARY' ;

    IF VAR_ALERT_FLAG = 0 THEN
        BEGIN
            EXECUTE IMMEDIATE 'create table AR_DETAIL_SUMMARY(AR_DATE  CHAR(10))';
        EXCEPTION
            WHEN OTHERS
            THEN
               RAISE_APPLICATION_ERROR (-20101,'create table Error:' || SQLERRM);
        END ;
    END IF ;

   -- 检查 字段 AR_DATE
   SELECT COUNT(COLUMN_NAME) INTO VAR_ALERT_FLAG
          FROM USER_TAB_COLS
          WHERE TABLE_NAME = 'AR_DETAIL_SUMMARY' AND COLUMN_NAME = 'AR_DATE' ;

    IF VAR_ALERT_FLAG = 0 THEN
        BEGIN
            EXECUTE IMMEDIATE 'alter table AR_DETAIL_SUMMARY add AR_DATE CHAR(10) ';
        EXCEPTION
            WHEN OTHERS
            THEN
               RAISE_APPLICATION_ERROR (-20101,'alter table add AR_DATE Error:' || SQLERRM);
        END ;
    END IF ;

    -- 检查 字段 EMPID
    SELECT COUNT(COLUMN_NAME) INTO VAR_ALERT_FLAG
          FROM USER_TAB_COLS
          WHERE TABLE_NAME = 'AR_DETAIL_SUMMARY' AND COLUMN_NAME = 'EMPID' ;

    IF VAR_ALERT_FLAG = 0 THEN
        BEGIN
            EXECUTE IMMEDIATE 'alter table AR_DETAIL_SUMMARY add EMPID VARCHAR(10) ';
        EXCEPTION
            WHEN OTHERS
            THEN
               RAISE_APPLICATION_ERROR (-20101,'alter table add EMPID Error:' || SQLERRM);
        END ;
    END IF ;

    -- 检查 字段 SHIFT_NAME
    SELECT COUNT(COLUMN_NAME) INTO VAR_ALERT_FLAG
          FROM USER_TAB_COLS
          WHERE TABLE_NAME = 'AR_DETAIL_SUMMARY' AND COLUMN_NAME = 'SHIFT_NAME' ;

    IF VAR_ALERT_FLAG = 0 THEN
        BEGIN
            EXECUTE IMMEDIATE 'alter table AR_DETAIL_SUMMARY add SHIFT_NAME VARCHAR(50) ';
        EXCEPTION
            WHEN OTHERS
            THEN
               RAISE_APPLICATION_ERROR (-20101,'alter table add SHIFT_NAME Error:' || SQLERRM);
        END ;
    END IF ;


   -- 添加缺少的字段
   DECLARE
       -- 查找，AR_DETAIL_SUMMARY 中，不存在的字段
       CURSOR cur_field
       IS
          SELECT AI.ITEM_ID || '_D' AS ITEM_ID FROM AR_ITEM AI WHERE NOT EXISTS (
                 SELECT * FROM USER_TAB_COLS UTC WHERE UTC.TABLE_NAME = 'AR_DETAIL_SUMMARY' AND UTC.COLUMN_NAME = (AI.ITEM_ID || '_D'))
          and ai.item_no <> '36' ORDER BY AI.ITEM_ID ;

      FIELD_ROW   CUR_FIELD%ROWTYPE;
   BEGIN
      OPEN CUR_FIELD;
      LOOP
         FETCH CUR_FIELD
          INTO FIELD_ROW;
         EXIT WHEN CUR_FIELD%NOTFOUND ;
         --DBMS_OUTPUT.put_line ('var_alert_str=' || var_alert_str);
         var_alert_str := ' alter table AR_DETAIL_SUMMARY add ' || FIELD_ROW.ITEM_ID || ' NUMBER ' ;
          /*修改 AR_DETAIL_SUMMARY 表*/
         BEGIN
            EXECUTE IMMEDIATE var_alert_str;
         EXCEPTION
            WHEN OTHERS
            THEN
               RAISE_APPLICATION_ERROR (-20101, var_alert_str || 'Error:' || SQLERRM);
          END;

       END LOOP ;
       CLOSE  CUR_FIELD ;
    END ;

   -- 循环考勤项目, 将 AR_DETAIL 行转列, 同时加入日历信息, 插入 AR_DETAIL_SUMMARY*/
   var_create_str := 'INSERT INTO AR_DETAIL_SUMMARY (AR_DATE,EMPID,SHIFT_NAME' ;

   FOR detail_item_row IN cus_item_detail
   LOOP
      var_create_str := var_create_str || ',' || detail_item_row.item_id ;
   END LOOP;

   var_create_str :=
         var_create_str || ' ) SELECT TO_CHAR(TO_DATE(AD.AR_DATE_STR,''YYYY-MM-DD''),''YYYY-MM-DD''),AD.EMPID,ASH.SHIFT_NAME';

   FOR detail_item_row IN cus_item_detail
   LOOP
      /*将日考勤的项目列转行*/
      var_create_str :=
            var_create_str
         || ',SUM(CASE AD.AR_ITEM_NO WHEN '
         || TO_CHAR (detail_item_row.item_no)
         || ' THEN AD.QUANTITY ELSE 0 END) AS "'
         || detail_item_row.item_id || '"';
   END LOOP;

   var_create_str := var_create_str
      || ' FROM AR_DETAIL AD,AR_SHIFT010 ASH '
      || ' WHERE AD.SHIFT_NO = ASH.SHIFT_NO AND AD.AR_DATE_STR = '''
      || TO_CHAR(TO_DATE(in_sdate,'YYYY-MM-DD'),'YYYY/MM/DD') || '''' ;

   var_create_str := var_create_str
      || ' GROUP BY AD.EMPID,AD.AR_DATE_STR,ASH.SHIFT_NAME '
      || ' ORDER BY AD.EMPID,AD.AR_DATE_STR ';

--     var_count := 0;
--     DBMS_OUTPUT.put_line ('插入 TABLE AR_DETAIL_SUMMARY 的SQL：');
--       WHILE var_count * 120 <= LENGTH (var_create_str)
--       LOOP
--          DBMS_OUTPUT.put_line (SUBSTR (var_create_str, var_count * 120 + 1, 120));
--          var_count := var_count + 1;
--       END LOOP;

     -- 插入数据
     BEGIN
        EXECUTE IMMEDIATE var_create_str;
     EXCEPTION
        WHEN OTHERS
        THEN
           RAISE_APPLICATION_ERROR (-20101,'INSERT INTO  AR_DETAIL_SUMMARY Error: ' || SQLERRM);
      END;

    COMMIT;
END AR_DETAIL_CAL_DAILY_2011323;
/

prompt
prompt Creating procedure AR_DETAIL_NO_CARD
prompt ====================================
prompt
CREATE OR REPLACE PROCEDURE ar_detail_no_card (in_varempid VARCHAR2)
IS
   tmpvar   NUMBER;
/******************************************************************************


******************************************************************************/
BEGIN
   tmpvar := 0;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      NULL;
   WHEN OTHERS
   THEN
      -- Consider logging the error and then re-raise
      RAISE;
END ar_detail_no_card;
/

prompt
prompt Creating procedure AR_DYNAMIC_GROUP_STR
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE ar_dynamic_group_str (group_id_s VARCHAR)
IS
   tmpvar           NUMBER;
   group_id_where   VARCHAR (2000);
--select FIELD_NAME|| '' ||   RELATION ||'' ||  ''''||   VALUE1 ||''''   into  group_id_where  from AR_GROUP_CONDITIONS where GROUP_NO  = group_id_s ;
BEGIN
   DECLARE
      CURSOR dynamic_group_cursor
      IS
         SELECT    field_name
                || ''
                || relation
                || ''
                || ''''
                || value1
                || '''' AS dynamic_group_str
           FROM ar_group_conditions
          WHERE group_no = group_id_s;

      dynamic_group   dynamic_group_cursor%ROWTYPE;
   BEGIN
      OPEN dynamic_group_cursor;

      LOOP
         FETCH dynamic_group_cursor
          INTO dynamic_group;

         EXIT WHEN dynamic_group_cursor%NOTFOUND;

/************************************/
         BEGIN
            SELECT field_name || '' || relation || '' || '''' || value1
                   || ''''
              INTO group_id_where
              FROM ar_group_conditions
             WHERE group_no = group_id_s;
         END;
/************************************/
      END LOOP;

      CLOSE dynamic_group_cursor;
   END;
END ar_dynamic_group_str;
/

prompt
prompt Creating procedure AR_GROUP_MEMBERS
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE Ar_Group_Members (
   in_conditionno    IN       INT,   -- AR_GROUP_CONDITIONS.GROUP_CONDITION_NO
   inout_operation   IN OUT   VARCHAR2                     --'ADD' OR 'DELETE'
)
IS
   var_count        INT;                                             --计数器
   var_empid_str    VARCHAR2 (4000);                    -- EMPID serial devid
   var_group_no     INT;                     -- the group number to be setted
   var_field_name   VARCHAR2 (40);               -- the field to be qualified
   var_relation     VARCHAR2 (10);     -- the relation for the selected field
   var_value1       VARCHAR2 (4000);                   -- the condition value
   var_value2       VARCHAR2 (4000);
                                             -- used when relation is 'between'
/******************************************************************************
   NAME:       ar_group_members
   PURPOSE:    将所有分组条件直接对应出人员,按人记录进 AR_EMP_GROUP 表中

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2006-3-3    Pennix           1. Created this procedure.
   2.0        2006-3-11   Pennix       2. Altered input parameters

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     ar_add_group_condition_pr
      Sysdate:         2005-5-16
      Date and Time:   2005-5-16, 18:57:43, and 2005-5-16 18:57:43
      Username:         (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   BEGIN
      SELECT group_no, field_name, relation, value1,
             value2
        INTO var_group_no, var_field_name, var_relation, var_value1,
             var_value2
        FROM AR_GROUP_CONDITIONS
       WHERE group_condition_no = in_conditionno;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         inout_operation := '分组条件不存在';
         RETURN;
   END;

   var_empid_str := 'SELECT EMPID FROM AR_EMP_INFO_V WHERE ' || var_field_name;

   CASE UPPER (var_relation)
      WHEN 'NOT IN'
      THEN
         var_empid_str :=
               var_empid_str
            || ' NOT IN ('''
            || REPLACE (var_value1, ',', ''', ''')
            || ''')';
      WHEN 'IN'
      THEN
         var_empid_str :=
               var_empid_str
            || ' IN ('''
            || REPLACE (var_value1, ',', ''', ''')
            || ''')';
      WHEN 'BETWEEN'
      THEN
         var_empid_str :=
               var_empid_str
            || ' BETWEEN ('''
            || var_value1
            || ''' AND '''
            || var_value2
            || ''')';
      ELSE
         var_empid_str :=
            var_empid_str || ' ' || var_relation || '''' || var_value1
            || '''';
   END CASE;

   IF UPPER (inout_operation) = 'DELETE'
   THEN
      SELECT COUNT (*)
        INTO var_count
        FROM AR_DYNAMIC_GROUP_EMP
       WHERE INSTR (var_empid_str, empid) > 0;

      --inout_operation := TO_CHAR (var_count) || '名员工取消了分组';
   inout_operation := '以下员工取消了分组';

      EXECUTE IMMEDIATE    'DELETE FROM AR_EMP_GROUP WHERE EMPID IN ('
                        || var_empid_str
                        || ')';
   ELSIF UPPER (inout_operation) = 'ADD'
   THEN
      EXECUTE IMMEDIATE    'DELETE FROM AR_EMP_GROUP WHERE EMPID IN ('
                        || var_empid_str
                        || ')';

      SELECT COUNT (*)
        INTO var_count
        FROM HR_EMPLOYEE
       WHERE INSTR (var_empid_str, empid) > 0 ;

      --inout_operation := TO_CHAR (var_count) || '名员工进行了分组';
   inout_operation := '以下员工进行了分组';

      EXECUTE IMMEDIATE    'INSERT INTO AR_EMP_GROUP (EMPID, GROUP_NO) '
                        || 'SELECT EMPID, '
                        || var_group_no
                        || ' FROM HR_EMPLOYEE WHERE EMPID IN ('
                        || var_empid_str
                        || ') -- AND STATUS_CODE <> ''Status03''';
   ELSE
      inout_operation := '参数错误';
   END IF;
END Ar_Group_Members;
/

prompt
prompt Creating procedure AR_JOB_ADD
prompt =============================
prompt
CREATE OR REPLACE PROCEDURE ar_job_add (
   in_time    IN       VARCHAR2
)
AUTHID CURRENT_USER
IS
   exetime  DATE;
   jobno      NUMBER;
BEGIN
  exetime:=to_date(to_char(sysdate,'yyyy-mm-dd ')||in_time,'yyyy-mm-dd hh24:mi:ss');
   DBMS_JOB.SUBMIT(jobno, 'ar_detail_calall();', exetime,'SYSDATE +1');
   commit;
END ;
/

prompt
prompt Creating procedure AR_JOB_DEL
prompt =============================
prompt
CREATE OR REPLACE PROCEDURE ar_job_del
AUTHID CURRENT_USER
IS
  jobno      NUMBER;
BEGIN
   BEGIN
        select job into jobno from user_jobs where rownum=1 and what ='ar_detail_calall();';
   EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            jobno:=null;
   END;
   if jobno is not null then
      dbms_job.remove(jobno);
      commit;
   end if;
END ;
/

prompt
prompt Creating procedure AR_JOB_UPDATE
prompt ================================
prompt
CREATE OR REPLACE PROCEDURE ar_job_update (
   in_time    IN       VARCHAR2
)
AUTHID CURRENT_USER
IS
   exetime  DATE;
   jobno      NUMBER;
BEGIN
  exetime:=to_date(to_char(sysdate,'yyyy-mm-dd ')||in_time,'yyyy-mm-dd hh24:mi:ss');
   BEGIN
        select job into jobno from user_jobs where rownum=1 and what ='ar_detail_calall();';
   EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
            jobno:=null;
   END;
   IF jobno is not null THEN
      DBMS_JOB.CHANGE(jobno, 'ar_detail_calall();', exetime,'SYSDATE +1');
      commit;
   END IF;

END ;
/

prompt
prompt Creating procedure AR_MAKE_SCHEDULE
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE Ar_Make_Schedule (
   in_shift_type      VARCHAR2,                          --排班类型('EMPLOYEE'/'GROUP'/'DEPARTMENT')
   in_shift_id        VARCHAR2,                                                 --员工号/组号/部门号
   in_begin_date      DATE,                                                               --开始日期
   in_end_date        DATE,                                                               --结束日期
   in_shift_no        VARCHAR2,                                                           --班次序列
   in_supervisor_id   VARCHAR2                                                          --考勤员工号
)
IS
   i                INT;
   var_empids       VARCHAR2 (500);                                       --取得员工号序列的SQL语句
   var_shift_left   VARCHAR2 (500);                                                  --剩余班次序列
   var_shift_no     INT;
                          --当前班次号
/******************************************************************************
   NAME:       AR_MAKE_SCHEDULE
   PURPOSE:    按员工号/动态组/部门号生成人员的班次,存入 AR_SCHEDULE 表中

   REVISIONS:
   VER        DATE        AUTHOR           DESCRIPTION
   ---------  ----------  ---------------  ------------------------------------
   1.0        03/03/2006   PENNIX       1. CREATED THIS PROCEDURE.

   NOTES:

   AUTOMATICALLY AVAILABLE AUTO REPLACE KEYWORDS:
      OBJECT NAME:     AR_MAKE_SCHEDULE
      SYSDATE:         03/03/2006
      DATE AND TIME:   03/03/2006, 19:35:47, AND 03/03/2006 19:35:47
      USERNAME:        PENNIX (SET IN TOAD OPTIONS, PROCEDURE EDITOR)
      TABLE NAME:       (SET IN THE "New PL/SQL Object" DIALOG)

******************************************************************************/
BEGIN
   var_shift_left := in_shift_no;

   DECLARE
      CURSOR cur_date
      IS
         SELECT ddate
           FROM AR_CALENDER
          WHERE ddate BETWEEN in_begin_date AND in_end_date;

      date_cur   cur_date%ROWTYPE;
   BEGIN
      OPEN cur_date;

      LOOP
         FETCH cur_date
          INTO date_cur;

         EXIT WHEN cur_date%NOTFOUND;

         IF INSTR (var_shift_left, ',') > 0  --包含两个以上班次
         THEN
            var_shift_no := TO_NUMBER (SUBSTR (var_shift_left, 1, INSTR (var_shift_left, ',') - 1));  --取得当前班次
            var_shift_left :=
                   SUBSTR (var_shift_left, INSTR (var_shift_left, ',') + 1,            --取得剩余班次
                           LENGTH (var_shift_left));
         ELSE               -- 只有一个班次
            var_shift_no := TO_NUMBER (var_shift_left);

            IF INSTR (in_shift_no, ',') > 0         -- 如果到最后一个班次，并且班次列表包含两个以上班次，从新遍例班次列表
            THEN
               var_shift_left := in_shift_no;
            END IF;
         END IF;

         CASE UPPER (in_shift_type)  --根据不同的类型处理不同的排班逻辑
            WHEN 'EMPLOYEE'
            THEN
               SELECT COUNT (*)
                 INTO i
                 FROM AR_SCHEDULE
                WHERE empid = in_shift_id
                  AND ar_date_str = TO_CHAR (date_cur.ddate, 'YYYY/MM/DD')
                  AND lock_yn = 'Y';

               IF i = 0     -- 判断循环的当前日期是否已经存在排班数据
               THEN
                  DELETE FROM AR_SCHEDULE
                        WHERE empid = in_shift_id
                          AND ar_date_str = TO_CHAR (date_cur.ddate, 'YYYY/MM/DD');

                  INSERT INTO AR_SCHEDULE
                              (pk_no, empid, shift_no,
                               ar_date_str, lock_yn
                              )
                       VALUES (ar_schedule_seq.NEXTVAL, in_shift_id, var_shift_no,
                               TO_CHAR (date_cur.ddate, 'YYYY/MM/DD'), 'N'
                              );
               END IF;
            WHEN 'GROUP'
            THEN
              -- 删除登陆者有管理权限的人员的当前日期的排班信息
               DELETE FROM AR_SCHEDULE   
                     WHERE EMPID IN (
                              SELECT A.EMPID
                                FROM AR_DYNAMIC_GROUP_EMP A, HR_EMPLOYEE, AR_SUPERVISOR_INFO
                               WHERE A.GROUP_NO = TO_NUMBER (in_shift_id)
                                 AND A.EMPID = HR_EMPLOYEE.EMPID
                                 AND HR_EMPLOYEE.deptid = AR_SUPERVISOR_INFO.supervised_deptid
                                 AND AR_SUPERVISOR_INFO.ar_supervisor_id = in_supervisor_id)
                       AND ar_date_str = TO_CHAR (date_cur.ddate, 'YYYY/MM/DD')
                       AND lock_yn <> 'Y';

               INSERT INTO AR_SCHEDULE   
                           (pk_no, empid, shift_no, ar_date_str, lock_yn)
                  SELECT ar_schedule_seq.NEXTVAL, AR_DYNAMIC_GROUP_EMP.empid, var_shift_no,
                         TO_CHAR (date_cur.ddate, 'YYYY/MM/DD'), 'N'
                    FROM AR_DYNAMIC_GROUP_EMP, HR_EMPLOYEE
                   WHERE AR_DYNAMIC_GROUP_EMP.empid = HR_EMPLOYEE.empid
--                      AND (   HR_EMPLOYEE.status_code <> 'Status03'      QPSS没有'Status03'状态
--                           OR HR_EMPLOYEE.date_left > date_cur.ddate
--                          )
      AND (HR_EMPLOYEE.left_date > date_cur.ddate    -- 判断退社
         OR HR_EMPLOYEE.left_date IS NULL
        )
                     AND group_no = TO_NUMBER (in_shift_id)
                     AND AR_DYNAMIC_GROUP_EMP.empid NOT IN (             -- 过滤掉没有被删除的排班信息
                                          SELECT empid
                                            FROM AR_SCHEDULE
                                           WHERE ar_date_str =
                                                              TO_CHAR (date_cur.ddate, 'YYYY/MM/DD'));
            WHEN 'DEPARTMENT'
            THEN
               DELETE FROM AR_SCHEDULE
                     WHERE empid IN (SELECT empid
                                       FROM HR_EMPLOYEE
                                      WHERE deptid = in_shift_id)
                       AND ar_date_str = TO_CHAR (date_cur.ddate, 'YYYY/MM/DD')
                       AND lock_yn <> 'Y';

               INSERT INTO AR_SCHEDULE
                           (pk_no, empid, shift_no, ar_date_str, lock_yn)
                  SELECT ar_schedule_seq.NEXTVAL, empid, var_shift_no,
                         TO_CHAR (date_cur.ddate, 'YYYY/MM/DD'), 'N'
                    FROM HR_EMPLOYEE
                   WHERE deptid = in_shift_id
                     AND empid NOT IN (SELECT empid
                                         FROM AR_SCHEDULE
                                        WHERE ar_date_str = TO_CHAR (date_cur.ddate, 'YYYY/MM/DD'));
         END CASE;
      END LOOP;

      CLOSE cur_date;
   END;
END Ar_Make_Schedule;
/

prompt
prompt Creating procedure AR_MONTH_CAL
prompt ===============================
prompt
CREATE OR REPLACE PROCEDURE AR_MONTH_CAL(IN_AR_MONTH_STR IN VARCHAR2, --考勤月 ('YYYYMM')
                                         INOUT_EMPID     IN OUT VARCHAR2 --考勤员工号, 为 'ALL' 时计算所有人
                                         ) AUTHID CURRENT_USER IS
  VAR_COUNT              INT := 0; --计数器
  VAR_STIME              DATE := SYSDATE; --计算开始时间
  VAR_CREATE_STR         VARCHAR2(10000); --建表表达式
  VAR_UPDATE_STR         VARCHAR2(10000); --计算表达式
  VAR_SDATE              DATE; --考勤月开始时间
  VAR_EDATE              DATE; --考勤月结束时间
  VAR_CONDITION          VARCHAR2(1000); --公式条件
  VAR_FORMULAR           VARCHAR2(1000); --公式表达式
  VAR_SUPERVISED_DEPTIDS VARCHAR2(3000); --考勤员负责部门列表
  VAR_T_STR              VARCHAR2(5000);
  VAR_P_STR              VARCHAR2(5000);
  VAR_TEMP_STR           VARCHAR2(6);

  -- 人事相关字段条件游标
  CURSOR CUS_HR IS
    SELECT DISTINCT_FIELD FIELD_ID, FIELD_NAME
      FROM PA_DISTINCT_LIST
     WHERE TABLE_NAME = 'PA_HR_V';

  -- 考勤汇总项目游标
  CURSOR CUS_STA_ITEM IS
    SELECT ITEM_NO,
           ITEM_ID,
           ITEM_NAME,
           UNIT,
           MIN_UNIT,
           CALCU_ORDER,
           FROM_DATE,
           TO_DATE,
           DATATYPE
      FROM AR_STA_ITEM
      WHERE ACTIVITY = 1
     ORDER BY CALCU_ORDER;

  -- 考勤明细项目游标
  CURSOR CUS_ITEM_DETAIL IS
    SELECT DISTINCT A.ITEM_NO, A.ITEM_ID, A.ITEM_NAME, B.UNIT
      FROM AR_ITEM A, AR_ITEM_PARAM B
     WHERE A.ITEM_NO = B.AR_ITEM_NO;

  -- 考勤公式游标(以汇总项目为条件)
  CURSOR CUS_FORMULAR(IN_ITEM_NO NUMBER) IS
    SELECT FORMULAR_NO,
           ITEM_NO,
           CONDITION,
           FORMULAR,
           CONDITION_VAR,
           FORMULAR_VAR,
           TABLE_NAME,
           COLUMN_TYPE,
           AR_TYPE_NO
      FROM AR_STA_FORMULAR
     WHERE ITEM_NO = IN_ITEM_NO;
  /******************************************************************************
     NAME:       AR_MONTH_CAL
     PURPOSE:    汇总月考勤数据

     REVISIONS:
     Ver        Date        Author           Description
     ---------  ----------  ---------------  ------------------------------------
     1.0        03/04/2006   Pennix       1. Created this procedure.

     NOTES:

     Automatically available Auto Replace Keywords:
        Object Name:     PR_ARCAL
        Sysdate:         03/04/2006
        Date and Time:   03/04/2006, 15:56:56, and 03/04/2006 15:56:56
        Username:        Pennix (set in TOAD Options, Procedure Editor)
        Table Name:       (set in the "New PL/SQL Object" dialog)

  ******************************************************************************/
BEGIN

---------------------------------------更新PA_HR_V为计算月符合的人------------------
BEGIN

execute immediate 'CREATE OR REPLACE VIEW PA_HR_V AS
SELECT HRE.EMPID,
       HRE.CHINESENAME,
       HRE.CHINESE_PINYIN,
       HRE.ENGLISHNAME,
       HPR.DEPTID,
       HRD.DEPTNAME,
       HRD.DEPT_EN_NAME,
       HRPI.DEGREE_CODE,
       D.CODE_NAME AS DEGREE_NAME,
       D.CODE_EN_NAME AS DEGREE_EN_NAME,
       HRPI.EDU_HIS_CODE,
       R.CODE_NAME AS EDU_HIS_NAME,
       R.CODE_EN_NAME AS EDU_HIS_EN_NAME,
       HRPI.MAJOR_CODE,
       S.CODE_NAME AS MAJOR_NAME,
       S.CODE_EN_NAME AS MAJOR_EN_NAME,
       HRPI.GENDER_CODE,
       F.CODE_NAME AS GENDER_NAME,
       F.CODE_EN_NAME AS GENDER_EN_NAME,
       TO_CHAR(BIRTHDAY, ''YYYY-MM-DD'') BIRTHDAY,
       HRPI.RELIGION_CODE,
       G.CODE_NAME AS RELIGION_NAME,
       G.CODE_EN_NAME AS RELIGION_EN_NAME,
       HRPI.NATION_CODE,
       H.CODE_NAME AS NATION_NAME,
       H.CODE_EN_NAME AS NATION_EN_NAME,
       HRPI.NATIONALITY_CODE,
       I.CODE_NAME AS NATIONALITY_NAME,
       I.CODE_EN_NAME AS NATIONALITY_EN_NAME,
       HRPI.BORNPLACE_CODE,
       J.CODE_NAME AS BORNPLACE_NAME,
       J.CODE_EN_NAME AS BORNPLACE_EN_NAME,
       HRPI.POLITY_CODE,
       K.CODE_NAME AS POLITY_NAME,
       K.CODE_EN_NAME AS POLITY_EN_NAME,
       HRPI.MEMBERSHIP,
       HRPI.MEMBERSHIP AS MEMBERSHIP_NAME,
       HRPI.MEMBERSHIP AS MEMBERSHIP_EN_NAME,
       HRPI.MARITAL_STATUS_CODE,
       L.CODE_NAME AS MARITAL_STATUS_NAME,
       L.CODE_EN_NAME AS MARITAL_STATUS_EN_NAME,
       TO_CHAR(WEDDING_DATE, ''YYYY-MM-DD'') WEDDING_DATE,
       HRPI.IDCARD_NO,
       HRPI.IDCARD_PROVINCE,
       HRPI.IDCARD_CITY,
       HRPI.IDCARD_AREA,
       HRPI.IDCARD_ADDRESS,
       HRPI.HOME_PROVINCE,
       HRPI.HOME_CITY,
       HRPI.HOME_AREA,
       HRPI.HOME_ADDRESS,
       HRPI.IDCARD_POSTALCODE,
       HRPI.HOME_POSTALCODE,
       HRPI.P_EMAIL,
       HRPI.C_EMAIL,
       HRPI.OFFICE_PHONE,
       HRPI.HOME_PHONE,
       HRPI.CELLPHONE,
       HRPI.FAX,
       FLOOR(MONTHS_BETWEEN(SYSDATE, HRPI.BIRTHDAY) / 12) AGE,
       FLOOR(MONTHS_BETWEEN(SYSDATE, HRE.JOIN_DATE)) A_WORKAGE,
       HRPI.WORKAGE B_WORKAGE,
       FLOOR(MONTHS_BETWEEN(SYSDATE, HRE.JOIN_DATE) + HRPI.WORKAGE) WORKAGE,
       HRPI.IDCARD_TYPE_CODE,
       Q.CODE_NAME AS IDCARD_TYPE_NAME,
       Q.CODE_EN_NAME AS IDCARD_TYPE_EN_NAME,
       HRPI.FILE_RELATION_CODE,
       N.CODE_EN_NAME AS FILE_RELATION_EN_NAME,
       N.CODE_NAME AS FILE_RELATION_NAME,
       HRPI.FILE_RELATION_ADDRESS,
       HREI.SSN,
       HREI.HAFN,
       HREI.SHIFT_CODE,
       A.CODE_NAME AS SHIFT_NAME,
       A.CODE_EN_NAME AS SHIFT_EN_NAME,
       HREI.SUPPLIER_CODE,
       B.CODE_NAME AS SUPPLIER_NAME,
       B.CODE_EN_NAME AS SUPPLIER_EN_NAME,
       HRE.DUTY_CODE,
       E.CODE_NAME AS DUTY_NAME,
       E.CODE_EN_NAME AS DUTY_EN_NAME,
       HRE.POSITION_ID,
       HRPO.POSITION_NAME,
       HRPO.POSITION_EN_NAME,
       HPR.POST_ID,
       HRP.POST_NAME,
       HRP.POST_EN_NAME,
       HRE.POST_GRADE_ID,
       HRPGR.POST_GRADE_NAME,
       HRPGR.POST_GRADE_EN_NAME,
       HRE.POST_COEF,
       HRE.POST_GROUP_ID,
       HRPG.POST_GROUP_NAME,
       HRPG.POST_GROUP_EN_NAME,
       HPR.STATUS_CODE,
       O.CODE_NAME AS STATUS_NAME,
       O.CODE_EN_NAME AS STATUS_EN_NAME,
       HRE.JOIN_TYPE_CODE,
       P.CODE_NAME AS JOIN_TYPE_NAME,
       P.CODE_EN_NAME AS JOIN_TYPE_EN_NAME,
       HRE.JOIN_DATE,
       HRE.HIRE_DATE,
       HRE.END_PROBATION_DATE,
       HRE.LEFT_DATE,
       HRE.COSTCENTER,
       HRE.EMP_TYPE_CODE,
       C.CODE_NAME AS EMP_TYPE_NAME,
       C.CODE_EN_NAME AS EMP_TYPE_EN_NAME,
       (
          SELECT HREPI.CARD_NO FROM HR_EMP_PA_INFO HREPI
          WHERE HREPI.EMPID = HRE.EMPID
              AND CALC_FLAG = ''Y''
              AND ROWNUM = 1
       )   AS CARD_NO
  FROM HR_EMPLOYEE         HRE,
       HR_PERSONAL_INFO    HRPI,
       HR_POST_RECORDS     HPR,
       HR_DEPARTMENT       HRD,
       HR_EMP_INFO         HREI,
       HR_POSITION         HRPO,
       HR_POST             HRP,
       HR_POST_GROUP       HRPG,
       HR_POST_GRADE       HRPGR,
       SY_CODE             A,
       SY_CODE             B,
       SY_CODE             D,
       SY_CODE             F,
       SY_CODE             G,
       SY_CODE             H,
       SY_CODE             I,
       SY_CODE             J,
       SY_CODE             K,
       SY_CODE             L,
       SY_CODE             M,
       SY_CODE             N,
       SY_CODE             Q,
       SY_CODE             R,
       SY_CODE             S,
       SY_CODE             E,
       SY_CODE             O,
       SY_CODE             P,
       SY_CODE             C
 WHERE HRE.EMPID = HRPI.EMPID(+)
   AND HRE.EMPID = HREI.EMPID(+)
   AND HPR.DEPTID = HRD.DEPTID(+)
   AND HPR.NO = (
            SELECT MAX(HPR1.NO)
            FROM HR_POST_RECORDS HPR1
            WHERE HPR1.EMPID = HRE.EMPID
            AND TO_DATE(TO_CHAR(HPR1.START_DATE,''YYYYMM''),''YYYYMM'') <= TO_DATE('||IN_AR_MONTH_STR||',''YYYYMM''))
   AND HPR.POST_ID = HRP.POST_ID(+)
   AND HRP.POST_GROUP_ID = HRPG.POST_GROUP_ID(+)
   AND HRP.POSITION_ID = HRPO.POSITION_ID(+)
   AND HRPO.POST_GRADE_ID = HRPGR.POST_GRADE_ID(+)
   AND HREI.SHIFT_CODE = A.CODE_ID(+)
   AND HREI.SUPPLIER_CODE = B.CODE_ID(+)
   AND HRPI.DEGREE_CODE = D.CODE_ID(+)
   AND HRPI.GENDER_CODE = F.CODE_ID(+)
   AND HRPI.RELIGION_CODE = G.CODE_ID(+)
   AND HRPI.NATION_CODE = H.CODE_ID(+)
   AND HRPI.NATIONALITY_CODE = I.CODE_ID(+)
   AND HRPI.BORNPLACE_CODE = J.CODE_ID(+)
   AND HRPI.POLITY_CODE = K.CODE_ID(+)
   AND HRPI.MARITAL_STATUS_CODE = L.CODE_ID(+)
   AND HRPI.IDCARD_TYPE_CODE = M.CODE_ID(+)
   AND HRPI.FILE_RELATION_CODE = N.CODE_ID(+)
   AND HRPI.IDCARD_TYPE_CODE = Q.CODE_ID(+)
   AND HRPI.EDU_HIS_CODE = R.CODE_ID(+)
   AND HRPI.MAJOR_CODE = S.CODE_ID(+)
   AND HRE.DUTY_CODE = E.CODE_ID(+)
   AND HPR.STATUS_CODE = O.CODE_ID(+)
   AND HRE.JOIN_TYPE_CODE = P.CODE_ID(+)
   AND HRE.EMP_TYPE_CODE = C.CODE_ID(+)
   AND ( HRE.LEFT_DATE >= AR_GET_STARTDATE('||IN_AR_MONTH_STR||')
   OR  HRE.LEFT_DATE IS NULL )
   AND HRE.JOIN_DATE <= AR_GET_ENDDATE('||IN_AR_MONTH_STR||')';

   COMMIT;
 END;
---------------------------------------



  DBMS_OUTPUT.ENABLE(5000000);
  /*取得考勤月开始、结束时间*/
  VAR_SDATE := AR_GET_STARTDATE(IN_AR_MONTH_STR);
  VAR_EDATE := AR_GET_ENDDATE(IN_AR_MONTH_STR);

  /*如果不是计算所有人的月考勤数据*/
  /*
  IF UPPER(INOUT_EMPID) <> 'ALL' THEN */
    /*取得该考勤员管理的部门，将部门列表存放在var_supervised_deptids*/

    /******************************************************************************
    DECLARE
      CURSOR CUS_SDEPTIDS IS
        SELECT SUPERVISED_DEPTID
          FROM AR_SUPERVISOR_INFO
         WHERE AR_SUPERVISOR_ID = INOUT_EMPID;

      SDEPTIDS_ROW CUS_SDEPTIDS%ROWTYPE;
    BEGIN
      OPEN CUS_SDEPTIDS;

      LOOP
        FETCH CUS_SDEPTIDS
          INTO SDEPTIDS_ROW;

        EXIT WHEN CUS_SDEPTIDS%NOTFOUND;
        VAR_SUPERVISED_DEPTIDS := '''' || VAR_SUPERVISED_DEPTIDS ||
                                  SDEPTIDS_ROW.SUPERVISED_DEPTID || ''', ';
      END LOOP;

      CLOSE CUS_SDEPTIDS;

      VAR_SUPERVISED_DEPTIDS := SUBSTR(VAR_SUPERVISED_DEPTIDS,
                                       1,
                                       LENGTH(VAR_SUPERVISED_DEPTIDS) - 2);
    END;
  END IF;
 ******************************************************************************/
  /*
   -- 创建 PA T_DAILY_PA_RESULT 生成员工 日工资 所需数据
    BEGIN
       Pr_createTable_daily(in_ar_month_str);
    EXCEPTION
       WHEN OTHERS
       THEN
          RAISE_APPLICATION_ERROR (-20101,
                                      '创建日计算结果表失败.',
                                   TRUE
                                  );
    END;

  */

  /*定义建表"T_AR_RESULT"语句*/
  VAR_CREATE_STR := 'CREATE TABLE T_AR_RESULT AS SELECT ''' ||
                    IN_AR_MONTH_STR || ''' "AR_MONTH", ';

  /*循环人事表数据, 创建建表语句*/
  FOR HR_ROW IN CUS_HR LOOP
    VAR_CREATE_STR := VAR_CREATE_STR || HR_ROW.FIELD_ID || ' "' ||
                      HR_ROW.FIELD_ID || '", ';
  END LOOP;

  /*循环考勤汇总项目, 创建建表语句*/
  FOR STA_ITEM_ROW IN CUS_STA_ITEM LOOP
    VAR_CREATE_STR := VAR_CREATE_STR ||
                      CASE (SUBSTR(UPPER(STA_ITEM_ROW.DATATYPE), 1, 4))
                        WHEN 'NUMB' THEN
                         '0'
                        WHEN 'DATE' THEN
                         'SYSDATE'
                        ELSE
                         '''                                                  '''
                      END || ' "' || STA_ITEM_ROW.ITEM_ID || '", ';
  END LOOP;

  /*去掉末尾逗号,加入搜索条件*/
  VAR_CREATE_STR := SUBSTR(VAR_CREATE_STR, 1, LENGTH(VAR_CREATE_STR) - 2) ||
                    ' FROM PA_HR_V';
  --    || ' FROM PA_HR_V WHERE HISTORY_JOIN_DATE < TO_DATE('''
  --    || TO_CHAR (var_edate, 'YYYY-MM-DD')
  --    || ''', ''YYYY-MM-DD'') AND (DATE_LEFT IS NULL OR DATE_LEFT > TO_DATE('''
  --       || TO_CHAR (var_sdate, 'YYYY-MM-DD')
  --       || ''', ''YYYY-MM-DD'') )';

  VAR_COUNT := 0;
  DBMS_OUTPUT.PUT_LINE('创建TABLE T_AR_RESULT的SQL：');
  WHILE VAR_COUNT * 120 <= LENGTH(VAR_CREATE_STR) LOOP
    DBMS_OUTPUT.PUT_LINE(SUBSTR(VAR_CREATE_STR, VAR_COUNT * 120 + 1, 120));
    VAR_COUNT := VAR_COUNT + 1;
  END LOOP;

  /*联合考勤员权限
  IF UPPER (inout_empid) <> 'ALL'
  THEN
     var_create_str := var_create_str || ' AND DEPTID IN (' || var_supervised_deptids || ')';
  END IF;*/

  /*
     DBMS_OUTPUT.put_line
        ('-----------------------------SQL STATEMENT TO CREATE T_AR_RESULT-------------------------'
        );
     var_count := 0;

     WHILE var_count * 120 <= LENGTH (var_create_str)
     LOOP
        DBMS_OUTPUT.put_line (SUBSTR (var_create_str, var_count * 120 + 1, 120));
        var_count := var_count + 1;
     END LOOP;
  */

  /*验证表T_AR_RESULT是否存在*/
  SELECT COUNT(*)
    INTO VAR_COUNT
    FROM USER_TABLES
   WHERE TABLE_NAME = 'T_AR_RESULT';

  /*删除已经存在的T_AR_RESULT表*/
  IF VAR_COUNT > 0 THEN
    EXECUTE IMMEDIATE 'DROP TABLE T_AR_RESULT';
  END IF;

  /*创建T_AR_RESULT表*/
  BEGIN
    EXECUTE IMMEDIATE VAR_CREATE_STR;
  EXCEPTION
    WHEN OTHERS THEN
      /*出错时重建T_AR_RESULT表,避免存储过程不可用*/
      EXECUTE IMMEDIATE 'CREATE TABLE T_AR_RESULT (EMPID  CHAR(1))';

      RAISE_APPLICATION_ERROR(-20101,
                              'Create T_AR_RESULT Error: [' ||
                              VAR_CREATE_STR || ']');
  END;

  /*------------------------------------------------------------------------------------------------------------

  循环考勤项目, 将 AR_DETAIL 行转列, 同时加入日历信息, 生成 T_AR_DETAIL*/
  VAR_CREATE_STR := 'CREATE TABLE T_AR_DETAIL AS SELECT AR_DETAIL.EMPID'||
                    ',AR_DETAIL.AR_DATE_STR'||
                    ',MIN(AR_DETAIL.FROM_TIME) AS FROM_TIME'||
                    ',MAX(AR_DETAIL.TO_TIME) AS TO_TIME'||
                    ',AR_DETAIL.SHIFT_NO'||
                    ',AR_CALENDER.IWEEK'||
                    ',AR_CALENDER.WORKDAYFLAG' ||
                    ',AR_DETAIL.DATE_TYPE';

  FOR DETAIL_ITEM_ROW IN CUS_ITEM_DETAIL LOOP
    /*将日考勤的项目值统一换算成分钟*/
    VAR_CREATE_STR := VAR_CREATE_STR ||
                      ', SUM(CASE AR_DETAIL.AR_ITEM_NO WHEN ' ||
                      TO_CHAR(DETAIL_ITEM_ROW.ITEM_NO) || ' THEN DECODE(''' ||
                      DETAIL_ITEM_ROW.UNIT ||
                      '_UNIT'',''DAY_UNIT'',AR_DETAIL.QUANTITY*8*60,''HOUR_UNIT'',AR_DETAIL.QUANTITY*60,AR_DETAIL.QUANTITY) ELSE 0 END) AS "' ||
                      DETAIL_ITEM_ROW.ITEM_ID || '"';
  END LOOP;

  VAR_CREATE_STR := VAR_CREATE_STR ||
                    ' FROM AR_DETAIL, AR_CALENDER WHERE AR_DETAIL.AR_DATE_STR = TO_CHAR(AR_CALENDER.DDATE, ''YYYY/MM/DD'') AND AR_DETAIL.AR_MONTH_STR = ''' ||
                    IN_AR_MONTH_STR || '''';
  /*联合考勤员权限
  IF UPPER (inout_empid) <> 'ALL'
  THEN
     var_create_str :=
           var_create_str
        || ' AND EMPID IN (SELECT EMPID FROM HR_EMPLOYEE WHERE DEPTID IN ('
        || var_supervised_deptids
        || '))';
  END IF;*/
  VAR_CREATE_STR := VAR_CREATE_STR ||
                    ' GROUP BY AR_DETAIL.EMPID, AR_DETAIL.AR_DATE_STR, AR_DETAIL.SHIFT_NO, AR_CALENDER.IWEEK, AR_CALENDER.WORKDAYFLAG,AR_DETAIL.DATE_TYPE';

  VAR_COUNT := 0;

  DBMS_OUTPUT.PUT_LINE('创建TABLE T_AR_DETAIL的SQL：');
  WHILE VAR_COUNT * 120 <= LENGTH(VAR_CREATE_STR) LOOP
    DBMS_OUTPUT.PUT_LINE(SUBSTR(VAR_CREATE_STR, VAR_COUNT * 120 + 1, 120));
    VAR_COUNT := VAR_COUNT + 1;
  END LOOP;
  /*
     DBMS_OUTPUT.put_line
        ('-----------------------------SQL STATEMENT TO CREATE T_AR_DETAIL-------------------------'
        );
     var_count := 0;

     WHILE var_count * 120 <= LENGTH (var_create_str)
     LOOP
        DBMS_OUTPUT.put_line (SUBSTR (var_create_str, var_count * 120 + 1, 120));
        var_count := var_count + 1;
     END LOOP;
  */
  /*验证表T_AR_DETAIL是否存在*/
  SELECT COUNT(*)
    INTO VAR_COUNT
    FROM USER_TABLES
   WHERE TABLE_NAME = 'T_AR_DETAIL';

  /*删除已经存在的T_AR_DETAIL表*/
  IF VAR_COUNT > 0 THEN
    EXECUTE IMMEDIATE 'DROP TABLE T_AR_DETAIL';
  END IF;

  /*创建T_AR_DETAIL表*/
  BEGIN
    EXECUTE IMMEDIATE VAR_CREATE_STR;
  EXCEPTION
    WHEN OTHERS THEN
      /*出错时重建 T_AR_DETAIL 表,避免存储过程不可用*/
      EXECUTE IMMEDIATE 'CREATE TABLE T_AR_DETAIL (EMPID  CHAR(1))';

      RAISE_APPLICATION_ERROR(-20101,
                              'Create T_AR_DETAIL Error: [' ||
                              VAR_CREATE_STR || ']');
  END;

  SELECT COUNT(*) INTO VAR_COUNT FROM T_AR_DETAIL;

  /********************************* 循环汇总项目, 生成计算用SQL***********************************/
  FOR STA_ITEM_ROW IN CUS_STA_ITEM LOOP
    /*取得汇总公式数*/
    SELECT COUNT(*)
      INTO VAR_COUNT
      FROM AR_STA_FORMULAR
     WHERE ITEM_NO = STA_ITEM_ROW.ITEM_NO;

    /*无公式*/
    IF VAR_COUNT = 0 THEN
      VAR_UPDATE_STR := 'UPDATE T_AR_RESULT SET "' ||
                        STA_ITEM_ROW.ITEM_ID || '" = 0';

      /*单一公式*/
    ELSIF VAR_COUNT = 1 THEN

      /*取得唯一的汇总公式*/
      SELECT CONDITION, FORMULAR
        INTO VAR_CONDITION, VAR_FORMULAR
        FROM AR_STA_FORMULAR
       WHERE ITEM_NO = STA_ITEM_ROW.ITEM_NO;

      /*联合T_AR_RESULT和T_AR_DETAIL表，将汇总计算SQL加上汇总公式(将项目值按照汇总单位换算)
        说明：如果这个考勤汇总项目 公式中 出现 COUNT(班次) MAX(考勤日期)
             班次与考勤日期不会在 第209行进行时间单位转换
             所以这个考勤汇总项目单位必须用"次"做单位
      */
      VAR_UPDATE_STR := 'UPDATE T_AR_RESULT SET "' ||
                        STA_ITEM_ROW.ITEM_ID ||
                        '" = NVL(TRUNC((SELECT DISTINCT DECODE(''' ||
                        STA_ITEM_ROW.UNIT || ''',''DAY'',NVL(' ||
                        VAR_FORMULAR || ', 0)/8/60,''HOUR'',NVL(' ||
                        VAR_FORMULAR || ', 0)/60,NVL(' || VAR_FORMULAR ||
                        ',0) ) FROM T_AR_RESULT STA_ITEM, T_AR_DETAIL ATT_ITEM' ||
                        ' WHERE STA_ITEM.EMPID = ATT_ITEM.EMPID' ||
                        '   AND STA_ITEM.EMPID = T_AR_RESULT.EMPID';

      /*如果存在汇总公式的条件，将条件追加到汇总计算SQL*/
      IF VAR_CONDITION IS NOT NULL THEN
        VAR_UPDATE_STR := VAR_UPDATE_STR || ' AND ' || VAR_CONDITION;
      END IF;

      /*如果汇总公式包含汇总项目,并且不包含count()、max()*/
      IF INSTR(VAR_FORMULAR, 'STA_ITEM') > 0 AND
         INSTR(UPPER(VAR_FORMULAR), 'COUNT') = 0 AND
         INSTR(UPPER(VAR_FORMULAR), 'MAX') = 0 THEN
        VAR_UPDATE_STR := VAR_UPDATE_STR;
      END IF;

      /*对汇总项目的值四舍五入*/
      VAR_UPDATE_STR := VAR_UPDATE_STR || ')/' ||
                        TO_CHAR(STA_ITEM_ROW.MIN_UNIT) || ' + 0.49) * ' ||
                        TO_CHAR(STA_ITEM_ROW.MIN_UNIT) || ', 0)';

      /*多公式*/
    ELSIF VAR_COUNT > 1 THEN
      VAR_UPDATE_STR := 'UPDATE T_AR_RESULT SET "' ||
                        STA_ITEM_ROW.ITEM_ID || '" = NVL(TRUNC((';

      /*循环汇总公式CURSOR*/
      FOR FORMULAR_ROW IN CUS_FORMULAR(STA_ITEM_ROW.ITEM_NO) LOOP
        VAR_UPDATE_STR := VAR_UPDATE_STR || '((SELECT DISTINCT DECODE(''' ||
                          STA_ITEM_ROW.UNIT || ''',''DAY'',NVL(' ||
                          FORMULAR_ROW.FORMULAR ||
                          ', 0)/8/60,''HOUR'',NVL(' ||
                          FORMULAR_ROW.FORMULAR || ', 0)/60,NVL(' ||
                          FORMULAR_ROW.FORMULAR ||
                          ',0) ) FROM T_AR_RESULT STA_ITEM, T_AR_DETAIL ATT_ITEM' ||
                          ' WHERE STA_ITEM.EMPID = ATT_ITEM.EMPID' ||
                          ' AND STA_ITEM.EMPID = T_AR_RESULT.EMPID';

        /*如果存在汇总公式的条件，将条件追加到汇总计算SQL*/
        IF FORMULAR_ROW.CONDITION IS NOT NULL THEN
          VAR_UPDATE_STR := VAR_UPDATE_STR || ' AND ' ||
                            FORMULAR_ROW.CONDITION;
        END IF;

        /*如果汇总公式包含汇总项目,并且不包含count()、max()*/
        IF INSTR(VAR_FORMULAR, 'STA_ITEM') > 0 AND
           INSTR(UPPER(VAR_FORMULAR), 'COUNT') = 0 AND
           INSTR(UPPER(VAR_FORMULAR), 'MAX') = 0 THEN
          VAR_UPDATE_STR := VAR_UPDATE_STR || ' AND ROWNUM = 1';
        END IF;

        VAR_UPDATE_STR := VAR_UPDATE_STR || ')) + ';
      END LOOP;

      VAR_UPDATE_STR := SUBSTR(VAR_UPDATE_STR,
                               1,
                               LENGTH(VAR_UPDATE_STR) - 3);

      /*对汇总项目的值四舍五入*/
      VAR_UPDATE_STR := VAR_UPDATE_STR || ')/' ||
                        TO_CHAR(STA_ITEM_ROW.MIN_UNIT) || ' + 0.49) * ' ||
                        TO_CHAR(STA_ITEM_ROW.MIN_UNIT) || ', 0)';
    END IF;

    VAR_COUNT := 0;

    WHILE VAR_COUNT * 120 <= LENGTH(VAR_UPDATE_STR) LOOP
      DBMS_OUTPUT.PUT_LINE(SUBSTR(VAR_UPDATE_STR, VAR_COUNT * 120 + 1, 120));
      VAR_COUNT := VAR_COUNT + 1;
    END LOOP;

    BEGIN
      EXECUTE IMMEDIATE VAR_UPDATE_STR;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20101, VAR_UPDATE_STR);
    END;
  END LOOP;

  ----------------------------------------------操作 AR_HISTORY 开始----------------------------------

  /********************删除已经存在该月的备份数据*******************************/

  /*检验是否存在以"AR_HISTORY_"开头，以传进的考勤月减一为结尾的TABLE*/
  SELECT COUNT(*)
    INTO VAR_COUNT
    FROM USER_TABLES
   WHERE TABLE_NAME = 'AR_HISTORY_' || IN_AR_MONTH_STR;

  /*如果存在该备份表，删除该表*/
  IF VAR_COUNT > 0 THEN
    EXECUTE IMMEDIATE 'DROP TABLE AR_HISTORY_' || IN_AR_MONTH_STR;
  END IF;

  /*将AR_HISTORY改名为新的备份表*/
  EXECUTE IMMEDIATE 'ALTER TABLE AR_HISTORY RENAME TO AR_HISTORY_' ||
                    IN_AR_MONTH_STR;

  /*删除备份表里的该月备份数据*/
  EXECUTE IMMEDIATE 'DELETE FROM AR_HISTORY_' || IN_AR_MONTH_STR ||
                    ' WHERE AR_MONTH = ' || IN_AR_MONTH_STR;

  /*删除所有备份表里的该月备份数据*/
  --    var_temp_str := Prior_Pamonth (in_ar_month_str);
  --    LOOP
  --        var_count := 0;
  --
  --        SELECT COUNT(*)
  --       INTO var_count
  --    FROM user_tables
  --   WHERE TABLE_NAME = 'AR_HISTORY_' || var_temp_str;
  --
  --        EXIT WHEN var_count = 0;
  --        EXECUTE IMMEDIATE 'DELETE FROM AR_HISTORY_' ||  var_temp_str
  --             ||  ' WHERE 考勤月 = ' || in_ar_month_str;
  --        var_temp_str := TO_CHAR(ADD_MONTHS(TO_DATE(var_temp_str,'YYYYMM'),1),'YYYYMM');
  --    END LOOP;

  /**********************************删除备份数据结束*******************************/

  DECLARE
    /*定义T_AR_RESULT表包含的列的CURSOR*/
    CURSOR CUR_COLUMN_NAME IS
      SELECT COLUMN_NAME,
             MAX(DATA_TYPE) DATA_TYPE,
             MAX(DATA_LENGTH) DATA_LENGTH
        FROM USER_TAB_COLUMNS
       WHERE TABLE_NAME = 'T_AR_RESULT'
          OR TABLE_NAME = 'AR_HISTORY_' || IN_AR_MONTH_STR
       GROUP BY COLUMN_NAME
       ORDER BY MIN(COLUMN_ID);

    COLUMN_NAME_CUR CUR_COLUMN_NAME%ROWTYPE;
  BEGIN
    /*取得创建AR_HISTORY表的SQL*/
    VAR_CREATE_STR := 'CREATE TABLE AR_HISTORY ( ';

    OPEN CUR_COLUMN_NAME;

    LOOP
      FETCH CUR_COLUMN_NAME
        INTO COLUMN_NAME_CUR;

      EXIT WHEN CUR_COLUMN_NAME%NOTFOUND;
      VAR_CREATE_STR := VAR_CREATE_STR || '"' ||
                        COLUMN_NAME_CUR.COLUMN_NAME || '" ' ||
                        COLUMN_NAME_CUR.DATA_TYPE ||
                        CASE COLUMN_NAME_CUR.DATA_TYPE
                          WHEN 'VARCHAR2' THEN
                           '(' || TO_CHAR(COLUMN_NAME_CUR.DATA_LENGTH) || ')'
                          WHEN 'CHAR' THEN
                           '(' || TO_CHAR(COLUMN_NAME_CUR.DATA_LENGTH) || ')'
                          ELSE
                           ''
                        END || ', ';
    END LOOP;

    CLOSE CUR_COLUMN_NAME;

    VAR_CREATE_STR := SUBSTR(VAR_CREATE_STR, 1, LENGTH(VAR_CREATE_STR) - 2) || ' )';

    VAR_COUNT := 0;
    DBMS_OUTPUT.PUT_LINE('创建TABLE AR_HISTORY 的SQL：');

    WHILE VAR_COUNT * 120 <= LENGTH(VAR_CREATE_STR) LOOP
      DBMS_OUTPUT.PUT_LINE(SUBSTR(VAR_CREATE_STR, VAR_COUNT * 120 + 1, 120));
      VAR_COUNT := VAR_COUNT + 1;
    END LOOP;

  END;

  /*定义T_AR_RESULT表包含的列的CURSOR*/
  DECLARE
    CURSOR CUR_COLUMN_NAME IS
      SELECT COLUMN_NAME
        FROM USER_TAB_COLUMNS
       WHERE TABLE_NAME = 'T_AR_RESULT'
       GROUP BY COLUMN_NAME
       ORDER BY MIN(COLUMN_ID);

    COLUMN_NAME_CUR CUR_COLUMN_NAME%ROWTYPE;

    /*取得T_AR_RESULT表的列名的字符串*/
  BEGIN
    OPEN CUR_COLUMN_NAME;

    LOOP
      FETCH CUR_COLUMN_NAME
        INTO COLUMN_NAME_CUR;

      EXIT WHEN CUR_COLUMN_NAME%NOTFOUND;
      VAR_T_STR := VAR_T_STR || '"' || COLUMN_NAME_CUR.COLUMN_NAME || '", ';
    END LOOP;

    CLOSE CUR_COLUMN_NAME;

    VAR_T_STR := SUBSTR(VAR_T_STR, 1, LENGTH(VAR_T_STR) - 2);
  END;

  /*定义以"AR_HISTORY_"开头，以传进的考勤月为结尾的备份表包含的列的CURSOR*/
  DECLARE
    CURSOR CUR_COLUMN_NAME IS
      SELECT COLUMN_NAME
        FROM USER_TAB_COLUMNS
       WHERE TABLE_NAME = 'AR_HISTORY_' || IN_AR_MONTH_STR
       GROUP BY COLUMN_NAME
       ORDER BY MIN(COLUMN_ID);

    COLUMN_NAME_CUR CUR_COLUMN_NAME%ROWTYPE;

    /*取得以"AR_HISTORY_"开头，以传进的考勤月为结尾的备份表的列名的字符串*/
  BEGIN
    OPEN CUR_COLUMN_NAME;

    LOOP
      FETCH CUR_COLUMN_NAME
        INTO COLUMN_NAME_CUR;

      EXIT WHEN CUR_COLUMN_NAME%NOTFOUND;
      VAR_P_STR := VAR_P_STR || '"' || COLUMN_NAME_CUR.COLUMN_NAME || '", ';
    END LOOP;

    CLOSE CUR_COLUMN_NAME;

    VAR_P_STR := SUBSTR(VAR_P_STR, 1, LENGTH(VAR_P_STR) - 2);
  END;

  /*创建AR_HISTORY表*/
  BEGIN
    EXECUTE IMMEDIATE VAR_CREATE_STR;
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20101,
                              'Create AR_HISTORY Error: ' || VAR_CREATE_STR);
  END;

  /*将T_AR_RESULT表里的数据插入到AR_HISTORY表*/
  EXECUTE IMMEDIATE 'INSERT INTO AR_HISTORY (' || VAR_T_STR || ') SELECT ' ||
                    VAR_T_STR || ' FROM T_AR_RESULT';

  /*将备份表里的数据插入到AR_HISTORY表*/
  EXECUTE IMMEDIATE 'INSERT INTO AR_HISTORY (' || VAR_P_STR || ') SELECT ' ||
                    VAR_P_STR || ' FROM AR_HISTORY_' || IN_AR_MONTH_STR;

  /***********************备份当月数据*********************/

  /*删除备份表*/
  EXECUTE IMMEDIATE 'DROP TABLE AR_HISTORY_' || IN_AR_MONTH_STR;

  /*按照新的表结构创建备份表，添加该月新计算的汇总数据到备份表*/
  EXECUTE IMMEDIATE 'CREATE TABLE AR_HISTORY_' || IN_AR_MONTH_STR ||
                    ' AS SELECT * FROM AR_HISTORY';

  /*删除其他月的数据*/
  EXECUTE IMMEDIATE 'DELETE FROM AR_HISTORY_' || IN_AR_MONTH_STR ||
                    ' WHERE TO_DATE(AR_MONTH,''YYYYMM'') <> TO_DATE(' ||
                    IN_AR_MONTH_STR || ',''YYYYMM'')';

  /**********************备份结束*************************/

  --     /*添加该月新计算的汇总数据到所有备份表*/
  --    var_temp_str := Prior_Pamonth (in_ar_month_str);
  --    LOOP
  --        var_count := 0;
  --
  --        SELECT COUNT(*)
  --       INTO var_count
  --    FROM user_tables
  --   WHERE TABLE_NAME = 'AR_HISTORY_' || var_temp_str;
  --
  --        EXIT WHEN var_count = 0;
  --        EXECUTE IMMEDIATE 'INSERT INTO AR_HISTORY_' || var_temp_str || ' ('
  --                        || var_t_str
  --                        || ') SELECT '
  --                        || var_t_str
  --                        || ' FROM T_AR_RESULT';
  --        var_temp_str := TO_CHAR(ADD_MONTHS(TO_DATE(var_temp_str,'YYYYMM'),1),'YYYYMM');
  --    END LOOP;
  --
  --    /*在以计算的考勤月的上一个月为命名的备份表中，删除多余的备份数据*/
  --    EXECUTE IMMEDIATE 'DELETE FROM AR_HISTORY_' ||  Prior_Pamonth (in_ar_month_str)
  --             ||  ' WHERE TO_DATE(考勤月,''YYYYMM'') > TO_DATE(' || in_ar_month_str || ',''YYYYMM'')';
  COMMIT;
  SELECT COUNT(*) INTO VAR_COUNT FROM T_AR_RESULT;
  INOUT_EMPID := TO_CHAR(VAR_COUNT) || ' 位员工计算完毕, 用时 ' ||
                 TRUNC((SYSDATE - VAR_STIME) * 24 * 60 * 60 + 0.005, 2) ||
                 ' 秒. ';
  DBMS_OUTPUT.PUT_LINE(INOUT_EMPID);
END AR_MONTH_CAL;
/

prompt
prompt Creating procedure AR_SUMMARY_MONTH
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE ar_summary_month (
   ar_month    VARCHAR,
   var_empid   VARCHAR,
   att_empid   VARCHAR
)
AUTHID CURRENT_USER
IS
   tmpvar   NUMBER;
/******************************************************************************

   AR_DETAIL
   AR_STA_ITEM
   AR_STA_FORMULAR
   AR_EMP_INFO_V


/******************************************************************************
  AR_HISTORY_MONTH

/******************************************************************************


/******************************************************************************/

/******************************************************************************/
BEGIN
   tmpvar := 0;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      NULL;
   WHEN OTHERS
   THEN
      -- Consider logging the error and then re-raise
      RAISE;
END ar_summary_month;
/

prompt
prompt Creating procedure AR_SYS_EMP
prompt =============================
prompt
CREATE OR REPLACE PROCEDURE ar_sys_emp (
   returnempids   OUT   VARCHAR2,
   returntype     OUT   VARCHAR2
)
IS
   tmpvar             NUMBER;
/******************************************************************************
select* from AR_SPECIAL_EMP
select * from  AR_SPECIAL_EMP_CONDITIONS


CARD_INTO  为 timecard1 : 考勤系统不管理的人员
CARD_INTO  为 timecard2   全部刷卡
CARD_INTO  为 timecard3   全部不刷卡
CARD_INTO  为 timecard4:  不刷卡的人
CARD_INTO  为 timecard5   刷卡的人
******************************************************************************/
   varcard_into       VARCHAR2 (10)   := NULL;
   varempids          VARCHAR2 (1000) := NULL;
   vartimecard1       VARCHAR2 (1000) := NULL;
   vartimecard        VARCHAR2 (1000) := NULL;
   vartimecard1_sql   VARCHAR2 (1000) := NULL;
   vartimecard_sql    VARCHAR2 (1000) := NULL;
BEGIN
   BEGIN
      SELECT DECODE (card_into,
                     'timecard2', '2',
                     'timecard3', '3',
                     'timecard4', '4',
                     'timecard5', '5',
                     'NO'
                    )
        INTO varcard_into
        FROM ar_special_emp
       WHERE card_into IN
                         ('timecard2', 'timecard3', 'timecard4', 'timecard5');
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         varcard_into := 'NO';
      WHEN OTHERS
      THEN
         varcard_into := 'NO';
   END;

   IF varcard_into = 'NO'
   THEN
      returnempids := 'NOONE';
   -- return returnEmpids ;
   ELSE
      CASE varcard_into
         WHEN '2'
         THEN
            BEGIN
               BEGIN
                  SELECT special_no
                    INTO vartimecard1
                    FROM ar_special_emp
                   WHERE card_into = 'timecard1';
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     vartimecard1 := 'NOONE';
               END;

               IF vartimecard1 <> 'NOONE'
               THEN
                  vartimecard1_sql := ar_get_dy_emp (vartimecard1);
               END IF;

               returnempids := vartimecard1_sql;
               returntype := 'timecard2';
            END;
         WHEN '3'
         THEN
            BEGIN
               BEGIN
                  SELECT special_no
                    INTO vartimecard1
                    FROM ar_special_emp
                   WHERE card_into = 'timecard1';
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     vartimecard1 := 'NOONE';
               END;

               IF vartimecard1 <> 'NOONE'
               THEN
                  vartimecard1_sql := ar_get_dy_emp (vartimecard1);
               END IF;

               returnempids := vartimecard_sql;
               returntype := 'timecard3';
            END;
         WHEN '4'
         THEN
            BEGIN
               BEGIN
                  SELECT special_no
                    INTO vartimecard
                    FROM ar_special_emp
                   WHERE card_into = 'timecard4';
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     vartimecard := 'NOONE';
               END;

               IF vartimecard <> 'NOONE'
               THEN
                  vartimecard_sql := ar_get_dy_emp (vartimecard);
               END IF;

               BEGIN
                  SELECT special_no
                    INTO vartimecard1
                    FROM ar_special_emp
                   WHERE card_into = 'timecard1';
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     vartimecard1 := 'NOONE';
               END;

               IF vartimecard1 <> 'NOONE'
               THEN
                  vartimecard1_sql := ar_get_dy_emp (vartimecard1);

                  IF vartimecard_sql <> 'NOONE'
                  THEN
                     vartimecard_sql :=
                           vartimecard_sql
                        || 'empid not  in ( '
                        || vartimecard1_sql
                        || ')';
                  END IF;
               END IF;

               returnempids := vartimecard_sql;
               returntype := 'timecard4';
            END;
         WHEN '5'
         THEN
            BEGIN
               BEGIN
                  SELECT special_no
                    INTO vartimecard
                    FROM ar_special_emp
                   WHERE card_into = 'timecard5';
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     vartimecard := 'NOONE';
               END;

               IF vartimecard <> 'NOONE'
               THEN
                  vartimecard_sql := ar_get_dy_emp (vartimecard);
               END IF;

               BEGIN
                  SELECT special_no
                    INTO vartimecard1
                    FROM ar_special_emp
                   WHERE card_into = 'timecard1';
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     vartimecard1 := 'NOONE';
               END;

               IF vartimecard1 <> 'NOONE'
               THEN
                  vartimecard1_sql := ar_get_dy_emp (vartimecard1);
                  vartimecard_sql :=
                        vartimecard_sql
                     || 'empid not  in ( '
                     || vartimecard1_sql
                     || ')';
               END IF;

               returnempids := vartimecard_sql;
               returntype := 'timecard5';
            END;
      END CASE;
   END IF;
--    tmpVar := 0;
--    EXCEPTION
--      WHEN NO_DATA_FOUND THEN
--        NULL;
--      WHEN OTHERS THEN
        -- Consider logging the error and then re-raise
 --       RAISE;
END ar_sys_emp;
/

prompt
prompt Creating procedure ATT_GET_LEAVE_LENGTH
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE ATT_GET_LEAVE_LENGTH(IN_EMPID        VARCHAR2,
                                                 LEAVE_FROM_TIME VARCHAR2,
                                                 LEAVE_TO_TIME   VARCHAR2,
                                                 REMOVE_SHIFT_NO NUMBER,
                                                 IN_AR_ITEM_NO   NUMBER,
                                                 SS              OUT VARCHAR2

                                                 ) IS
  VAR_APPLY_LENGTH    NUMBER;
  VAR_SHIFT_FROM_TIME DATE;
  VAR_SHIFT_TO_TIME   DATE;
  VAR_FROM_DATE       DATE;
  VAR_TO_DATE         DATE;
  VAR_LEAVE_FROM_TIME DATE;
  VAR_LEAVE_TO_TIME   DATE;
  VAR_SHIFT_NO        NUMBER;
  VAR_IN_DATE         DATE;
  VAR_INT_DATE_STR    VARCHAR2(30);
  VAR_LOG_FLAG        INT := 0;
  V_DATETYPE          VARCHAR2(20);
  VAR_GROUPNO         VARCHAR2(20);
  V_FLAG              NUMBER := 0;
BEGIN
  VAR_APPLY_LENGTH := 0;
  --leave apply start date
  VAR_LEAVE_FROM_TIME := TO_DATE(LEAVE_FROM_TIME, 'YYYY/MM/DD HH24:MI:SS');
  --leave apply end date
  VAR_LEAVE_TO_TIME := TO_DATE(LEAVE_TO_TIME, 'YYYY/MM/DD HH24:MI:SS');

  BEGIN
    /*取员工所在组号,若无组信息则为'constant'*/
    SELECT GROUP_NO
      INTO VAR_GROUPNO
      FROM AR_DYNAMIC_GROUP_EMP
     WHERE EMPID = IN_EMPID;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      VAR_GROUPNO := 'constant';
  END;
  SELECT AIP.DATE_TYPE
    INTO V_DATETYPE
    FROM AR_ITEM_PARAM AIP
   WHERE AIP.AR_ITEM_NO = IN_AR_ITEM_NO
     AND AIP.AR_GROUP_NO = VAR_GROUPNO;

  IF SUBSTR(V_DATETYPE, 1, 1) = '2' OR SUBSTR(V_DATETYPE, 3, 1) = '2' OR
     SUBSTR(V_DATETYPE, 5, 1) = '2' THEN
    V_FLAG := 1;
  END IF;
  DBMS_OUTPUT.PUT_LINE(V_FLAG);

  IF VAR_LOG_FLAG > 0 THEN
    DBMS_OUTPUT.PUT_LINE('LEAVE_FROM_TIME:' ||
                         TO_CHAR(VAR_LEAVE_FROM_TIME,
                                 'YYYY/MM/DD HH24:mi:ss'));
    DBMS_OUTPUT.PUT_LINE('LEAVE_TO_TIME:' ||
                         TO_CHAR(VAR_LEAVE_TO_TIME,
                                 'YYYY/MM/DD HH24:mi:ss'));
  END IF;

  VAR_IN_DATE := VAR_LEAVE_FROM_TIME;

  --请假日期时间段循环
  WHILE VAR_LEAVE_TO_TIME >= VAR_IN_DATE LOOP

    VAR_SHIFT_NO := AR_GET_SHIFTNO(IN_EMPID,
                                   TO_CHAR(VAR_IN_DATE, 'YYYY/MM/DD'));

    VAR_INT_DATE_STR := TO_CHAR(VAR_IN_DATE, 'YYYY/MM/DD');
    IF VAR_LOG_FLAG > 0 THEN
      DBMS_OUTPUT.PUT_LINE('IN_DATE:' ||
                           TO_CHAR(VAR_IN_DATE, 'YYYY/MM/DD HH24:mi:ss'));
      DBMS_OUTPUT.PUT_LINE('VAR_INT_DATE_STR:' || VAR_INT_DATE_STR);
    END IF;

    DECLARE
      CURSOR CUR_SHIFT_TIME IS
        SELECT AR_ITEM_NO,
               BEGIN_DAY_OFFSET -- 开始时间与考勤日的位移：当日，次日，三日
               + TO_DATE(VAR_INT_DATE_STR || ' ' ||
                         TO_CHAR(FROM_TIME, 'HH24:mi:ss'),
                         'YYYY/MM/DD HH24:mi:ss') FROM_TIME,
               END_DAY_OFFSET -- 结束时间与考勤日的位移：当日，次日，三日
               + TO_DATE(VAR_INT_DATE_STR || ' ' ||
                         TO_CHAR(TO_TIME, 'HH24:mi:ss'),
                         'YYYY/MM/DD HH24:mi:ss') TO_TIME
          FROM AR_SHIFT020
         WHERE SHIFT_NO = VAR_SHIFT_NO
           AND TO_CHAR(FROM_TIME, 'HH24:mi:ss') <> '19:00:00'
         ORDER BY BEGIN_DAY_OFFSET, FROM_TIME;

      SHIFT_TIME_ROW CUR_SHIFT_TIME%ROWTYPE;
    BEGIN
      /*班次循环 请假时间与班次时间对比*/
      OPEN CUR_SHIFT_TIME;

      LOOP
        FETCH CUR_SHIFT_TIME
          INTO SHIFT_TIME_ROW;

        EXIT WHEN CUR_SHIFT_TIME%NOTFOUND;

        VAR_SHIFT_FROM_TIME := SHIFT_TIME_ROW.FROM_TIME;
        VAR_SHIFT_TO_TIME   := SHIFT_TIME_ROW.TO_TIME;

        IF VAR_LOG_FLAG > 0 THEN
          DBMS_OUTPUT.PUT_LINE('SHIFT_FROM_TIME:' ||
                               TO_CHAR(VAR_SHIFT_FROM_TIME,
                                       'YYYY/MM/DD HH24:mi:ss'));
          DBMS_OUTPUT.PUT_LINE('SHIFT_TO_TIME:' ||
                               TO_CHAR(VAR_SHIFT_TO_TIME,
                                       'YYYY/MM/DD HH24:mi:ss'));

          DBMS_OUTPUT.PUT_LINE('LEAVE_FROM_TIME:    ' ||
                               TO_CHAR(VAR_LEAVE_FROM_TIME,
                                       'YYYY/MM/DD HH24:mi:ss'));
          DBMS_OUTPUT.PUT_LINE('LEAVE_TO_TIME:      ' ||
                               TO_CHAR(VAR_LEAVE_TO_TIME,
                                       'YYYY/MM/DD HH24:mi:ss'));

        END IF;

        IF VAR_SHIFT_FROM_TIME > VAR_LEAVE_FROM_TIME THEN
          VAR_FROM_DATE := VAR_SHIFT_FROM_TIME;
        ELSE
          VAR_FROM_DATE := VAR_LEAVE_FROM_TIME;
        END IF;

        IF VAR_SHIFT_TO_TIME < VAR_LEAVE_TO_TIME THEN
          VAR_TO_DATE := VAR_SHIFT_TO_TIME;
        ELSE
          VAR_TO_DATE := VAR_LEAVE_TO_TIME;
        END IF;

        IF VAR_LOG_FLAG > 0 THEN

          DBMS_OUTPUT.PUT_LINE('FROM_TIME:' ||
                               TO_CHAR(VAR_TO_DATE,
                                       'YYYY/MM/DD HH24:mi:ss'));
          DBMS_OUTPUT.PUT_LINE('TO_TIME:' ||
                               TO_CHAR(VAR_FROM_DATE,
                                       'YYYY/MM/DD HH24:mi:ss'));
        END IF;
        IF (VAR_TO_DATE - VAR_FROM_DATE) > 0 THEN
          -- 判断，是否刨去休息日
          IF VAR_SHIFT_NO = REMOVE_SHIFT_NO THEN
            IF V_FLAG = 0 THEN
              VAR_APPLY_LENGTH := VAR_APPLY_LENGTH;
            ELSE
              VAR_APPLY_LENGTH := VAR_APPLY_LENGTH +
                                  (VAR_TO_DATE - VAR_FROM_DATE) * 24;
            END IF;
          ELSE
            VAR_APPLY_LENGTH := VAR_APPLY_LENGTH +
                                (VAR_TO_DATE - VAR_FROM_DATE) * 24;
          END IF;
        END IF;
      END LOOP;

      CLOSE CUR_SHIFT_TIME;
    END;
    VAR_IN_DATE := VAR_IN_DATE + 1;
  END LOOP;
   SS := VAR_APPLY_LENGTH;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    VAR_APPLY_LENGTH := 0;
  WHEN OTHERS THEN
    -- CONSIDER LOGGING THE ERROR AND THEN RE-RAISE
    RAISE;
END ATT_GET_LEAVE_LENGTH;
/

prompt
prompt Creating procedure ATT_GET_LEAVE_LENGTH_WD
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE ATT_GET_LEAVE_LENGTH_WD(IN_EMPID        VARCHAR2,
                                                    LEAVE_FROM_TIME VARCHAR2,
                                                    LEAVE_TO_TIME   VARCHAR2,
                                                    REMOVE_SHIFT_NO NUMBER,
                                                    IN_AR_ITEM_NO   NUMBER,
                                                    SS              OUT VARCHAR2
                                                    
                                                    ) IS
  VAR_APPLY_LENGTH    NUMBER;
  VAR_SHIFT_FROM_TIME DATE;
  VAR_SHIFT_TO_TIME   DATE;
  VAR_FROM_DATE       DATE;
  VAR_TO_DATE         DATE;
  VAR_LEAVE_FROM_TIME DATE;
  VAR_LEAVE_TO_TIME   DATE;
  VAR_SHIFT_NO        NUMBER;
  VAR_IN_DATE         DATE;
  VAR_INT_DATE_STR    VARCHAR2(30);
  VAR_LOG_FLAG        INT := 0;
  V_DATETYPE          VARCHAR2(20);
  VAR_GROUPNO         VARCHAR2(20);
  V_FLAG              NUMBER := 0;
BEGIN
  DBMS_OUTPUT.ENABLE(5000000);
  VAR_APPLY_LENGTH := 0;
  --leave apply start date
  VAR_LEAVE_FROM_TIME := TO_DATE(LEAVE_FROM_TIME, 'YYYY/MM/DD HH24:MI:SS');
  --leave apply end date
  VAR_LEAVE_TO_TIME := TO_DATE(LEAVE_TO_TIME, 'YYYY/MM/DD HH24:MI:SS');

  BEGIN
    /*取员工所在组号,若无组信息则为'constant'*/
    SELECT GROUP_NO
      INTO VAR_GROUPNO
      FROM AR_DYNAMIC_GROUP_EMP
     WHERE EMPID = IN_EMPID;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      VAR_GROUPNO := 'constant';
  END;

  SELECT AIP.DATE_TYPE
    INTO V_DATETYPE
    FROM AR_ITEM_PARAM AIP
   WHERE AIP.AR_ITEM_NO = IN_AR_ITEM_NO
     AND AIP.AR_GROUP_NO = VAR_GROUPNO;

  IF SUBSTR(V_DATETYPE, 1, 1) = '2' OR SUBSTR(V_DATETYPE, 3, 1) = '2' OR
     SUBSTR(V_DATETYPE, 5, 1) = '2' THEN
    V_FLAG := 1;
  END IF;
  DBMS_OUTPUT.PUT_LINE(V_FLAG);

  IF VAR_LOG_FLAG > 0 THEN
    DBMS_OUTPUT.PUT_LINE('LEAVE_FROM_TIME:' ||
                         TO_CHAR(VAR_LEAVE_FROM_TIME,
                                 'YYYY/MM/DD HH24:mi:ss'));
    DBMS_OUTPUT.PUT_LINE('LEAVE_TO_TIME:' ||
                         TO_CHAR(VAR_LEAVE_TO_TIME,
                                 'YYYY/MM/DD HH24:mi:ss'));
  END IF;

  VAR_IN_DATE := VAR_LEAVE_FROM_TIME;

  --请假日期时间段循环
  WHILE VAR_LEAVE_TO_TIME >= VAR_IN_DATE LOOP
  
    VAR_SHIFT_NO := AR_GET_SHIFTNO(IN_EMPID,
                                   TO_CHAR(VAR_IN_DATE, 'YYYY/MM/DD'));
  
    VAR_INT_DATE_STR := TO_CHAR(VAR_IN_DATE, 'YYYY/MM/DD');
    IF VAR_LOG_FLAG > 0 THEN
      DBMS_OUTPUT.PUT_LINE('IN_DATE:' ||
                           TO_CHAR(VAR_IN_DATE, 'YYYY/MM/DD HH24:mi:ss'));
      DBMS_OUTPUT.PUT_LINE('VAR_INT_DATE_STR:' || VAR_INT_DATE_STR);
    END IF;
  
    DECLARE
      CURSOR CUR_SHIFT_TIME IS
        SELECT AR_ITEM_NO,
               BEGIN_DAY_OFFSET -- 开始时间与考勤日的位移：当日，次日，三日
               + TO_DATE(VAR_INT_DATE_STR || ' ' ||
                         TO_CHAR(FROM_TIME, 'HH24:mi:ss'),
                         'YYYY/MM/DD HH24:mi:ss') FROM_TIME,
               END_DAY_OFFSET -- 结束时间与考勤日的位移：当日，次日，三日
               + TO_DATE(VAR_INT_DATE_STR || ' ' ||
                         TO_CHAR(TO_TIME, 'HH24:mi:ss'),
                         'YYYY/MM/DD HH24:mi:ss') TO_TIME
          FROM AR_SHIFT020
         WHERE SHIFT_NO = VAR_SHIFT_NO
           AND TO_CHAR(FROM_TIME, 'HH24:mi:ss') <> '19:00:00'
         ORDER BY BEGIN_DAY_OFFSET, FROM_TIME;
    
      SHIFT_TIME_ROW CUR_SHIFT_TIME%ROWTYPE;
    BEGIN
      /*班次循环 请假时间与班次时间对比*/
      OPEN CUR_SHIFT_TIME;
    
      LOOP
        FETCH CUR_SHIFT_TIME
          INTO SHIFT_TIME_ROW;
      
        EXIT WHEN CUR_SHIFT_TIME%NOTFOUND;
      
        VAR_SHIFT_FROM_TIME := SHIFT_TIME_ROW.FROM_TIME;
        VAR_SHIFT_TO_TIME   := SHIFT_TIME_ROW.TO_TIME;
      
        IF VAR_LOG_FLAG > 0 THEN
          DBMS_OUTPUT.PUT_LINE('SHIFT_FROM_TIME:' ||
                               TO_CHAR(VAR_SHIFT_FROM_TIME,
                                       'YYYY/MM/DD HH24:mi:ss'));
          DBMS_OUTPUT.PUT_LINE('SHIFT_TO_TIME:' ||
                               TO_CHAR(VAR_SHIFT_TO_TIME,
                                       'YYYY/MM/DD HH24:mi:ss'));
        
          DBMS_OUTPUT.PUT_LINE('LEAVE_FROM_TIME:    ' ||
                               TO_CHAR(VAR_LEAVE_FROM_TIME,
                                       'YYYY/MM/DD HH24:mi:ss'));
          DBMS_OUTPUT.PUT_LINE('LEAVE_TO_TIME:      ' ||
                               TO_CHAR(VAR_LEAVE_TO_TIME,
                                       'YYYY/MM/DD HH24:mi:ss'));
        
        END IF;
      
        IF VAR_SHIFT_FROM_TIME > VAR_LEAVE_FROM_TIME THEN
          VAR_FROM_DATE := VAR_SHIFT_FROM_TIME;
        ELSE
          VAR_FROM_DATE := VAR_LEAVE_FROM_TIME;
        END IF;
      
        IF VAR_SHIFT_TO_TIME < VAR_LEAVE_TO_TIME THEN
          VAR_TO_DATE := VAR_SHIFT_TO_TIME;
        ELSE
          VAR_TO_DATE := VAR_LEAVE_TO_TIME;
        END IF;
      
        --  IF VAR_LOG_FLAG > 0 THEN
      
        DBMS_OUTPUT.PUT_LINE('FROM_TIME:' ||
                             TO_CHAR(VAR_TO_DATE, 'YYYY/MM/DD HH24:mi:ss'));
        DBMS_OUTPUT.PUT_LINE('TO_TIME:' ||
                             TO_CHAR(VAR_FROM_DATE,
                                     'YYYY/MM/DD HH24:mi:ss'));
        DBMS_OUTPUT.PUT_LINE('--:' || (VAR_TO_DATE - VAR_FROM_DATE) * 24);
        --  END IF;
        IF (VAR_TO_DATE - VAR_FROM_DATE) > 0 THEN
          -- 判断，是否刨去休息日
          IF VAR_SHIFT_NO = REMOVE_SHIFT_NO THEN
            IF V_FLAG = 0 THEN
              VAR_APPLY_LENGTH := VAR_APPLY_LENGTH;
            ELSE
              VAR_APPLY_LENGTH := VAR_APPLY_LENGTH +
                                  (VAR_TO_DATE - VAR_FROM_DATE) * 24 - 1;
            END IF;
          ELSE
            VAR_APPLY_LENGTH := VAR_APPLY_LENGTH +
                                (VAR_TO_DATE - VAR_FROM_DATE) * 24;
          END IF;
        END IF;
      END LOOP;
    
      CLOSE CUR_SHIFT_TIME;
    END;
    VAR_IN_DATE := VAR_IN_DATE + 1;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('LONG_TIME:' || VAR_APPLY_LENGTH);
  IF MOD(VAR_APPLY_LENGTH, 8) = 0 THEN
    SS := TRUNC(VAR_APPLY_LENGTH / 8) || '天';
  ELSE
    SS := TRUNC(VAR_APPLY_LENGTH / 8) || '天';
  END IF;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    VAR_APPLY_LENGTH := 0;
  WHEN OTHERS THEN
    -- CONSIDER LOGGING THE ERROR AND THEN RE-RAISE
    RAISE;
END ATT_GET_LEAVE_LENGTH_WD;
/

prompt
prompt Creating procedure ATT_GET_LEAVE_LENGTH_WW
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE ATT_GET_LEAVE_LENGTH_WW(IN_EMPID        VARCHAR2,
                                                    LEAVE_FROM_TIME VARCHAR2,
                                                    LEAVE_TO_TIME   VARCHAR2,
                                                    REMOVE_SHIFT_NO NUMBER,
                                                    IN_AR_ITEM_NO   NUMBER,
                                                    SS              OUT VARCHAR2
                                                    
                                                    ) IS
  VAR_APPLY_LENGTH    NUMBER;
  VAR_SHIFT_FROM_TIME DATE;
  VAR_SHIFT_TO_TIME   DATE;
  VAR_FROM_DATE       DATE;
  VAR_TO_DATE         DATE;
  VAR_LEAVE_FROM_TIME DATE;
  VAR_LEAVE_TO_TIME   DATE;
  VAR_SHIFT_NO        NUMBER;
  VAR_IN_DATE         DATE;
  VAR_INT_DATE_STR    VARCHAR2(30);
  VAR_LOG_FLAG        INT := 0;
  V_DATETYPE          VARCHAR2(20);
  VAR_GROUPNO         VARCHAR2(20);
  V_FLAG              NUMBER := 0;
BEGIN
  VAR_APPLY_LENGTH := 0;
  --leave apply start date
  VAR_LEAVE_FROM_TIME := TO_DATE(LEAVE_FROM_TIME, 'YYYY/MM/DD HH24:MI:SS');
  --leave apply end date
  VAR_LEAVE_TO_TIME := TO_DATE(LEAVE_TO_TIME, 'YYYY/MM/DD HH24:MI:SS');

  BEGIN
    /*取员工所在组号,若无组信息则为'constant'*/
    SELECT GROUP_NO
      INTO VAR_GROUPNO
      FROM AR_DYNAMIC_GROUP_EMP
     WHERE EMPID = IN_EMPID;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      VAR_GROUPNO := 'constant';
  END;
  SELECT AIP.DATE_TYPE
    INTO V_DATETYPE
    FROM AR_ITEM_PARAM AIP
   WHERE AIP.AR_ITEM_NO = IN_AR_ITEM_NO
     AND AIP.AR_GROUP_NO = VAR_GROUPNO;

  IF SUBSTR(V_DATETYPE, 1, 1) = '2' OR SUBSTR(V_DATETYPE, 3, 1) = '2' OR
     SUBSTR(V_DATETYPE, 5, 1) = '2' THEN
    V_FLAG := 1;
  END IF;
  DBMS_OUTPUT.PUT_LINE(V_FLAG);

  IF VAR_LOG_FLAG > 0 THEN
    DBMS_OUTPUT.PUT_LINE('LEAVE_FROM_TIME:' ||
                         TO_CHAR(VAR_LEAVE_FROM_TIME,
                                 'YYYY/MM/DD HH24:mi:ss'));
    DBMS_OUTPUT.PUT_LINE('LEAVE_TO_TIME:' ||
                         TO_CHAR(VAR_LEAVE_TO_TIME,
                                 'YYYY/MM/DD HH24:mi:ss'));
  END IF;

  VAR_IN_DATE := VAR_LEAVE_FROM_TIME;

  --请假日期时间段循环
  WHILE VAR_LEAVE_TO_TIME >= VAR_IN_DATE LOOP
  
    VAR_SHIFT_NO := AR_GET_SHIFTNO(IN_EMPID,
                                   TO_CHAR(VAR_IN_DATE, 'YYYY/MM/DD'));
  
    VAR_INT_DATE_STR := TO_CHAR(VAR_IN_DATE, 'YYYY/MM/DD');
    IF VAR_LOG_FLAG > 0 THEN
      DBMS_OUTPUT.PUT_LINE('IN_DATE:' ||
                           TO_CHAR(VAR_IN_DATE, 'YYYY/MM/DD HH24:mi:ss'));
      DBMS_OUTPUT.PUT_LINE('VAR_INT_DATE_STR:' || VAR_INT_DATE_STR);
    END IF;
  
    DECLARE
      CURSOR CUR_SHIFT_TIME IS
        SELECT AR_ITEM_NO,
               BEGIN_DAY_OFFSET -- 开始时间与考勤日的位移：当日，次日，三日
               + TO_DATE(VAR_INT_DATE_STR || ' ' ||
                         TO_CHAR(FROM_TIME, 'HH24:mi:ss'),
                         'YYYY/MM/DD HH24:mi:ss') FROM_TIME,
               END_DAY_OFFSET -- 结束时间与考勤日的位移：当日，次日，三日
               + TO_DATE(VAR_INT_DATE_STR || ' ' ||
                         TO_CHAR(TO_TIME, 'HH24:mi:ss'),
                         'YYYY/MM/DD HH24:mi:ss') TO_TIME
          FROM AR_SHIFT020
         WHERE SHIFT_NO = VAR_SHIFT_NO
           AND TO_CHAR(FROM_TIME, 'HH24:mi:ss') <> '19:00:00'
         ORDER BY BEGIN_DAY_OFFSET, FROM_TIME;
    
      SHIFT_TIME_ROW CUR_SHIFT_TIME%ROWTYPE;
    BEGIN
      /*班次循环 请假时间与班次时间对比*/
      OPEN CUR_SHIFT_TIME;
    
      LOOP
        FETCH CUR_SHIFT_TIME
          INTO SHIFT_TIME_ROW;
      
        EXIT WHEN CUR_SHIFT_TIME%NOTFOUND;
      
        VAR_SHIFT_FROM_TIME := SHIFT_TIME_ROW.FROM_TIME;
        VAR_SHIFT_TO_TIME   := SHIFT_TIME_ROW.TO_TIME;
      
        IF VAR_LOG_FLAG > 0 THEN
          DBMS_OUTPUT.PUT_LINE('SHIFT_FROM_TIME:' ||
                               TO_CHAR(VAR_SHIFT_FROM_TIME,
                                       'YYYY/MM/DD HH24:mi:ss'));
          DBMS_OUTPUT.PUT_LINE('SHIFT_TO_TIME:' ||
                               TO_CHAR(VAR_SHIFT_TO_TIME,
                                       'YYYY/MM/DD HH24:mi:ss'));
        
          DBMS_OUTPUT.PUT_LINE('LEAVE_FROM_TIME:    ' ||
                               TO_CHAR(VAR_LEAVE_FROM_TIME,
                                       'YYYY/MM/DD HH24:mi:ss'));
          DBMS_OUTPUT.PUT_LINE('LEAVE_TO_TIME:      ' ||
                               TO_CHAR(VAR_LEAVE_TO_TIME,
                                       'YYYY/MM/DD HH24:mi:ss'));
        
        END IF;
      
        IF VAR_SHIFT_FROM_TIME > VAR_LEAVE_FROM_TIME THEN
          VAR_FROM_DATE := VAR_SHIFT_FROM_TIME;
        ELSE
          VAR_FROM_DATE := VAR_LEAVE_FROM_TIME;
        END IF;
      
        IF VAR_SHIFT_TO_TIME < VAR_LEAVE_TO_TIME THEN
          VAR_TO_DATE := VAR_SHIFT_TO_TIME;
        ELSE
          VAR_TO_DATE := VAR_LEAVE_TO_TIME;
        END IF;
      
        IF VAR_LOG_FLAG > 0 THEN
        
          DBMS_OUTPUT.PUT_LINE('FROM_TIME:' ||
                               TO_CHAR(VAR_TO_DATE,
                                       'YYYY/MM/DD HH24:mi:ss'));
          DBMS_OUTPUT.PUT_LINE('TO_TIME:' ||
                               TO_CHAR(VAR_FROM_DATE,
                                       'YYYY/MM/DD HH24:mi:ss'));
        END IF;
        IF (VAR_TO_DATE - VAR_FROM_DATE) > 0 THEN
          -- 判断，是否刨去休息日
          IF VAR_SHIFT_NO = REMOVE_SHIFT_NO THEN
            IF V_FLAG = 0 THEN
              VAR_APPLY_LENGTH := VAR_APPLY_LENGTH;
            ELSE
              VAR_APPLY_LENGTH := VAR_APPLY_LENGTH +
                                  (VAR_TO_DATE - VAR_FROM_DATE) * 24;
            END IF;
          ELSE
            VAR_APPLY_LENGTH := VAR_APPLY_LENGTH +
                                (VAR_TO_DATE - VAR_FROM_DATE) * 24;
          END IF;
        END IF;
      END LOOP;
    
      CLOSE CUR_SHIFT_TIME;
    END;
    VAR_IN_DATE := VAR_IN_DATE + 1;
  END LOOP;
  IF MOD(VAR_APPLY_LENGTH, 8) = 0 THEN
    SS := TRUNC(VAR_APPLY_LENGTH / 8) || '天';
  ELSE
    SS := TRUNC(VAR_APPLY_LENGTH / 8) || '天' || MOD(VAR_APPLY_LENGTH, 8) || '小时';
  END IF;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    VAR_APPLY_LENGTH := 0;
  WHEN OTHERS THEN
    -- CONSIDER LOGGING THE ERROR AND THEN RE-RAISE
    RAISE;
END ATT_GET_LEAVE_LENGTH_WW;
/

prompt
prompt Creating procedure BOM_BOMITEM_DELETE
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE BOM_BOMITEM_DELETE(IN_BOM_ID        IN VARCHAR2,
                                       IN_BOM_ITEM_ID           IN VARCHAR2,
                                       IN_T_CHANGE_NO           IN VARCHAR2,
                                       IN_CHANGE_NO             IN VARCHAR2,
                                       IN_UPDATED_BY            IN VARCHAR2,
                                       IN_CPNY_ID               IN VARCHAR2)
IS
      V_S_DATE  DATE;
      V_E_DATE  DATE;
      V_OBJECT_ID VARCHAR(20);
BEGIN
      --如果是在变更号下执行变更
      IF (IN_CHANGE_NO IS NOT NULL ) AND ( IN_T_CHANGE_NO IS NULL OR IN_CHANGE_NO <> IN_T_CHANGE_NO)  THEN
        SELECT ECNI.S_DATE INTO V_S_DATE FROM ECM_CHANGE_NO_INFO ECNI WHERE ECNI.CHANGE_NO = IN_CHANGE_NO AND ECNI.CPNY_ID = IN_CPNY_ID;
        SELECT ECNI.E_DATE INTO V_E_DATE FROM ECM_CHANGE_NO_INFO ECNI WHERE ECNI.CHANGE_NO = IN_CHANGE_NO AND ECNI.CPNY_ID = IN_CPNY_ID;
        SELECT BII.MAT_V_ID INTO V_OBJECT_ID FROM BOM_ITEM_INFO BII WHERE BII.BOM_ITEM_ID = IN_BOM_ITEM_ID AND BII.CPNY_ID = IN_CPNY_ID;
        
        IF ECM_IS_MAT_EDITABLE(V_OBJECT_ID,'',IN_CHANGE_NO,IN_CPNY_ID) THEN
          --修改BOMITEM截止日期为变更号前一天
          UPDATE BOM_ITEM_INFO SET E_DATE = DECODE(E_DATE,NULL,V_S_DATE-1,E_DATE),
            UPDATED_BY = IN_UPDATED_BY, UPDATE_DATE = SYSDATE
          WHERE BOM_ITEM_ID = IN_BOM_ITEM_ID
          AND  CPNY_ID = IN_CPNY_ID;
          
          --如果变更号结束日期不为空(临时变更)
          IF V_E_DATE IS NOT NULL THEN
            INSERT INTO BOM_ITEM_INFO(BOM_ITEM_ID,BOM_ID,S_DATE,E_DATE,CHANGE_NO,MAT_V_ID,AMOUNT,AMOUNT_UNIT_CODE,BOM_CATEGORY_CODE,LOSS_RATE,DESCRIPTION,ACTIVITY,CPNY_ID)
            SELECT BOM_ITEM_SEQ.NEXTVAL,BII2.BOM_ID,V_E_DATE+1,NULL,BII2.CHANGE_NO,BII2.MAT_V_ID,BII2.AMOUNT,BII2.AMOUNT_UNIT_CODE,BII2.BOM_CATEGORY_CODE,BII2.LOSS_RATE,BII2.DESCRIPTION,BII2.ACTIVITY,BII2.CPNY_ID 
            FROM BOM_ITEM_INFO BII2 WHERE BII2.BOM_ITEM_ID = IN_BOM_ITEM_ID;
          END IF;
          --结束临时变更处理
        ELSE
          RAISE_APPLICATION_ERROR(-20002,'此变更号无法修改该物料');
        END IF;
      ELSE

      --如果不是在变更号下执行删除
        UPDATE BOM_ITEM_INFO SET ACTIVITY = 0,
          UPDATED_BY=IN_UPDATED_BY, UPDATE_DATE=SYSDATE
        WHERE BOM_ITEM_ID = IN_BOM_ITEM_ID
        AND  CPNY_ID = IN_CPNY_ID;
      END IF;
      
END;
/

prompt
prompt Creating procedure BOM_BOMITEM_UPDATE
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE BOM_BOMITEM_UPDATE(IN_BOM_ID        IN VARCHAR2,
                                       IN_BOM_ITEM_ID          IN VARCHAR2,
                                       IN_MAT_V_ID              IN VARCHAR2,
                                       IN_BOM_CATEGORY_CODE     IN VARCHAR2,
                                       IN_AMOUNT                IN VARCHAR2,
                                       IN_AMOUNT_UNIT_CODE      IN VARCHAR2,
                                       IN_LOSS_RATE      IN VARCHAR2,
                                       IN_DESCRIPTION    IN VARCHAR2,
                                       IN_T_CHANGE_NO    IN VARCHAR2,
                                       IN_CHANGE_NO      IN VARCHAR2,
                                       IN_UPDATED_BY     IN VARCHAR2,
                                       IN_CPNY_ID        IN VARCHAR2)
IS
      V_S_DATE  DATE;
      V_E_DATE  DATE;
      V_OBJECT_ID VARCHAR(20);
BEGIN
      --如果是在变更号与之前不同的情况下
      IF (IN_CHANGE_NO IS NOT NULL ) AND ( IN_T_CHANGE_NO IS NULL OR IN_CHANGE_NO != IN_T_CHANGE_NO)  THEN
        SELECT ECNI.S_DATE INTO V_S_DATE FROM ECM_CHANGE_NO_INFO ECNI WHERE ECNI.CHANGE_NO = IN_CHANGE_NO AND ECNI.CPNY_ID = IN_CPNY_ID;
        SELECT ECNI.E_DATE INTO V_E_DATE FROM ECM_CHANGE_NO_INFO ECNI WHERE ECNI.CHANGE_NO = IN_CHANGE_NO AND ECNI.CPNY_ID = IN_CPNY_ID;
        SELECT BII.MAT_V_ID INTO V_OBJECT_ID FROM BOM_ITEM_INFO BII WHERE BII.BOM_ITEM_ID = IN_BOM_ITEM_ID AND BII.CPNY_ID = IN_CPNY_ID;
       
      
        IF ECM_IS_MAT_EDITABLE(V_OBJECT_ID,'',IN_CHANGE_NO,IN_CPNY_ID) THEN
          UPDATE BOM_ITEM_INFO SET E_DATE = DECODE(E_DATE,NULL,V_S_DATE-1,E_DATE),
            UPDATED_BY=IN_UPDATED_BY, UPDATE_DATE=SYSDATE
          WHERE BOM_ITEM_ID = IN_BOM_ITEM_ID
          AND  CPNY_ID = IN_CPNY_ID;

          INSERT INTO BOM_ITEM_INFO (BOM_ITEM_ID,MAT_V_ID,BOM_ID,BOM_CATEGORY_CODE,AMOUNT,AMOUNT_UNIT_CODE,
              CHANGE_NO,S_DATE,E_DATE,LOSS_RATE,DESCRIPTION,
              CREATED_BY,CREATE_DATE,ACTIVITY,CPNY_ID)
          VALUES(BOM_ITEM_SEQ.NEXTVAL,V_OBJECT_ID,IN_BOM_ID,IN_BOM_CATEGORY_CODE,TO_NUMBER(IN_AMOUNT),IN_AMOUNT_UNIT_CODE,
              IN_CHANGE_NO,V_S_DATE,V_E_DATE,IN_LOSS_RATE,IN_DESCRIPTION,
              IN_UPDATED_BY,SYSDATE,1,IN_CPNY_ID);

          --如果变更号结束日期不为空(临时变更)
          IF V_E_DATE IS NOT NULL THEN
            INSERT INTO BOM_ITEM_INFO(BOM_ITEM_ID,BOM_ID,S_DATE,E_DATE,CHANGE_NO,MAT_V_ID,AMOUNT,AMOUNT_UNIT_CODE,BOM_CATEGORY_CODE,LOSS_RATE,DESCRIPTION,ACTIVITY,CPNY_ID)
            SELECT BOM_ITEM_SEQ.NEXTVAL,BII2.BOM_ID,V_E_DATE+1,NULL,BII2.CHANGE_NO,BII2.MAT_V_ID,BII2.AMOUNT,BII2.AMOUNT_UNIT_CODE,BII2.BOM_CATEGORY_CODE,BII2.LOSS_RATE,BII2.DESCRIPTION,BII2.ACTIVITY,BII2.CPNY_ID 
            FROM BOM_ITEM_INFO BII2 WHERE BII2.BOM_ITEM_ID = IN_BOM_ITEM_ID;

          END IF;
         ELSE
           RAISE_APPLICATION_ERROR(-20002,'此变更号无法修改该物料');
         END IF;
            
        ELSE
          --如果变更号和之前相同
          UPDATE BOM_ITEM_INFO SET BOM_CATEGORY_CODE = IN_BOM_CATEGORY_CODE, AMOUNT = IN_AMOUNT ,AMOUNT_UNIT_CODE = IN_AMOUNT_UNIT_CODE,LOSS_RATE = IN_LOSS_RATE,
            UPDATED_BY=IN_UPDATED_BY, UPDATE_DATE=SYSDATE,DESCRIPTION = IN_DESCRIPTION
          WHERE BOM_ITEM_ID = IN_BOM_ITEM_ID
          AND  CPNY_ID = IN_CPNY_ID;
      END IF;
END;
/

prompt
prompt Creating procedure BOM_CREATE
prompt =============================
prompt
CREATE OR REPLACE PROCEDURE BOM_CREATE(IN_MAT_V_ID   IN VARCHAR2,
                                       IN_BOM_TYPE_ID IN VARCHAR2,
                                       IN_FAOCOTY_ID     IN VARCHAR2,
                                       IN_LOSS_RATE     IN VARCHAR2,
                                       IN_DESCRIPTION     IN VARCHAR2,
                                       IN_CREATED_BY      IN VARCHAR2,
                                       IN_CPNY_ID         IN VARCHAR2,
                                       IN_CHANGE_NO       IN VARCHAR2,
                                       IN_S_DATE          IN VARCHAR2,
                                       OUT_BOM_ID         OUT VARCHAR2)
IS
BEGIN
      INSERT INTO BOM_HEADER_INFO(BOM_ID,MAT_V_ID,BOM_STATUS_ID,BOM_TYPE_ID,FACTORY_ID,DESCRIPTION,LOSS_RATE,
          CREATED_BY,CREATE_DATE,ACTIVITY,CPNY_ID,CHANGE_NO,S_DATE)
      VALUES(BOM_SEQ.NEXTVAL,IN_MAT_V_ID,PROCESS_GET_DEF_STATUS( IN_BOM_TYPE_ID,IN_CPNY_ID),IN_BOM_TYPE_ID,IN_FAOCOTY_ID,IN_DESCRIPTION,IN_LOSS_RATE,
          IN_CREATED_BY,SYSDATE,1,IN_CPNY_ID,IN_CHANGE_NO,TO_DATE(IN_S_DATE,'YYYY-MM-DD'));

      OUT_BOM_ID:=BOM_SEQ.CURRVAL;
END;
/

prompt
prompt Creating procedure CHANG_STATUS_CODE
prompt ====================================
prompt
create or replace procedure CHANG_STATUS_CODE IS
begin
  
  IF TO_CHAR(SYSDATE,'YYYYMMDD') >= to_char(sysdate,'yyyyMM')||'15' THEN

  UPDATE HR_EMPLOYEE a
   SET a.STATUS_CODE =
       (SELECT b.STATUS_CODE
          FROM HR_EXPERIENCE_INSIDE b
         WHERE b.TRANS_CODE IN
               ('TurnType0010', 'TurnType0020', 'TurnType0030')
           AND b.ACTIVITY = 0
           and b.empid = a.empid
           and b.start_date between TO_DATE(to_char(sysdate,'yyyy-MM')||'-20','YYYY-MM-DD') AND LAST_DAY(sysdate)
           )
 WHERE a.EMPID IN (SELECT EMPID
                     FROM HR_EXPERIENCE_INSIDE
                    WHERE TRANS_CODE IN
                          ('TurnType0010', 'TurnType0020', 'TurnType0030')
                      AND ACTIVITY = 0
                   and start_date between TO_DATE(to_char(sysdate,'yyyy-MM')||'-20','YYYY-MM-DD') AND LAST_DAY(sysdate)
                     );

  END IF;
  
     commit ;

end CHANG_STATUS_CODE;
/

prompt
prompt Creating procedure DEBUG_PRINT
prompt ==============================
prompt
CREATE OR REPLACE PROCEDURE debug_print(p_text IN VARCHAR2)
IS
l_count NUMBER :=length(p_text)/255;
BEGIN
FOR i IN 0..l_count LOOP
  dbms_output.put_line(substr(p_text,i*255+1,255));
END LOOP;
END debug_print;
/

prompt
prompt Creating procedure DELETEETNPLAN
prompt ================================
prompt
CREATE OR REPLACE PROCEDURE deleteEtnPlan (
   v_etn_plan       numeric
)
is
BEGIN
   delete etn_plan t where t.seq_etn_plan=v_etn_plan;
   delete ETN_TEACHER_SATISFACT t where t.etn_plan_no=v_etn_plan;
   delete etn_whole_satisfaction t where t.etn_plan_no=v_etn_plan; 
   delete etn_teacher_satisfact t where t.etn_plan_no=v_etn_plan;
   delete etn_plan_group t where t.seq_etn_plan=v_etn_plan;
   delete etn_fact_plan t where t.seq_etn_plan=v_etn_plan;
   delete etn_fee t where t.etn_plan_no=v_etn_plan;
   delete etn_standard t where t.etn_plan_no=v_etn_plan;
   delete etn_teacher_fee t where t.etn_plan_no=v_etn_plan;
END deleteEtnPlan;
/

prompt
prompt Creating procedure DELETE_STORAGE
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE delete_storage(
var_storage_no VARCHAR2,
var_company_id VARCHAR2,
var_updated_by VARCHAR2,
result_message OUT VARCHAR2
)
IS
      product_in_storage  NUMBER; 
BEGIN
    SELECT NVL(SUM(LEFT_QUANTITY),0) INTO product_in_storage
    FROM PROSTOR_STORAGE_PRODUCT
    WHERE STORAGE_NO = var_storage_no;
  IF product_in_storage = 0 THEN
      UPDATE PROSTOR_STORAGE_INFO
      SET ACTIVITY = 0,
          UPDATED_BY = var_updated_by,
          UPDATE_DATE = SYSDATE,
          CPNY_ID = var_company_id
      WHERE STORAGE_NO = var_storage_no;
      
      DELETE FROM PROSTOR_STORAGE_PRODUCT PSP
      WHERE PSP.STORAGE_NO = var_storage_no;
    result_message := 'Y';
  ELSE
    result_message := 'N';
  END IF;
END delete_storage;
/

prompt
prompt Creating procedure DOC_CREATE
prompt =============================
prompt
CREATE OR REPLACE PROCEDURE DOC_CREATE(IN_DOC_T_ID IN VARCHAR2,
                                       IN_ID_TYPE  IN VARCHAR2,
                                       IN_DOC_NAME IN VARCHAR2,
                                       IN_DOC_TYPE_ID IN VARCHAR2,
                                       IN_DOC_VERSION     IN VARCHAR2,
                                       IN_DOC_PART        IN VARCHAR2,
                                       IN_DESCRIPTION     IN VARCHAR2,
                                       IN_CREATED_BY      IN VARCHAR2,
                                       IN_CPNY_ID         IN VARCHAR2,
                                       OUT_DOC_ID         OUT VARCHAR2)
IS
      EXISTCOUNT INT:=0;
BEGIN  
       SELECT COUNT(*) INTO EXISTCOUNT
      FROM DOC_INFO DI
      WHERE DI.DOC_NAME = IN_DOC_NAME
      AND   DI.DOC_PART = IN_DOC_PART
      AND   DI.DOC_VERSION = IN_DOC_VERSION
      AND   DI.DOC_TYPE_ID = IN_DOC_TYPE_ID
      AND   DI.CPNY_ID     = IN_CPNY_ID;
            
      IF EXISTCOUNT!=0 THEN
         RAISE_APPLICATION_ERROR(-20003, 'Duplicated record', TRUE);
      END IF;
      
      IF IN_ID_TYPE='I'THEN
          OUT_DOC_ID := DOC_SEQ.NEXTVAL;
        END IF;
      IF IN_ID_TYPE = 'O' THEN
           OUT_DOC_ID := IN_DOC_T_ID;
        END IF;
      IF IN_ID_TYPE='M'THEN
          OUT_DOC_ID :=IN_DOC_T_ID||'-'||DOC_SEQ.NEXTVAL;
        END IF;

  		INSERT INTO DOC_INFO(DOC_ID,DOC_NAME,DOC_TYPE_ID,DOC_STATUS_ID,DOC_VERSION,DOC_PART,DESCRIPTION,
					CREATED_BY,CREATE_DATE,ACTIVITY,CPNY_ID,ORI_ID)
			VALUES(OUT_DOC_ID,IN_DOC_NAME,IN_DOC_TYPE_ID,PROCESS_GET_DEF_STATUS(IN_DOC_TYPE_ID,IN_CPNY_ID),IN_DOC_VERSION,IN_DOC_PART,IN_DESCRIPTION,
					IN_CREATED_BY,SYSDATE,1,IN_CPNY_ID,OUT_DOC_ID);

END;
/

prompt
prompt Creating procedure ECM_CREATE
prompt =============================
prompt
CREATE OR REPLACE PROCEDURE ECM_CREATE(IN_CHANGE_NO   IN VARCHAR2,
                                       IN_ID_TYPE     IN VARCHAR2,
                                       IN_CHANGE_TYPE_ID IN VARCHAR2,
                                       IN_DESCRIPTION     IN VARCHAR2,
                                       IN_REASON          IN VARCHAR2,
                                       IN_CPNY_ID         IN VARCHAR2,
                                       IN_S_DATE          IN VARCHAR2,
                                       IN_E_DATE          IN VARCHAR2,
                                       IN_ORDERNO          IN VARCHAR2,
                                       IN_CREATED_BY      IN VARCHAR)
IS
      CHANGE_NO  VARCHAR2(20) :='';
BEGIN
      IF IN_ID_TYPE='I'THEN
          CHANGE_NO := CHANGENO_SEQ.NEXTVAL;
        END IF;
      IF IN_ID_TYPE = 'O' THEN
           CHANGE_NO := IN_CHANGE_NO;
        END IF;
      IF IN_ID_TYPE='M'THEN
          CHANGE_NO :=IN_CHANGE_NO||'-'||CHANGENO_SEQ.NEXTVAL;
        END IF;

			INSERT INTO ECM_CHANGE_NO_INFO(CHANGE_NO,CHANGE_TYPE_ID,CHANGE_STATUS_ID,
			                           DESCRIPTION,REASON,CPNY_ID,S_DATE,E_DATE,
			                           ORDERNO,CREATE_DATE,CREATED_BY,ACTIVITY)
			       VALUES(CHANGE_NO,IN_CHANGE_TYPE_ID,PROCESS_GET_DEF_STATUS(IN_CHANGE_TYPE_ID,IN_CPNY_ID),
			              IN_DESCRIPTION,IN_REASON,IN_CPNY_ID,TO_DATE(IN_S_DATE,'YYYY-MM-DD'),TO_DATE(IN_E_DATE,'YYYY-MM-DD'),
			                           IN_ORDERNO,SYSDATE,IN_CREATED_BY,1);
END;
/

prompt
prompt Creating procedure ESS_CHECKCODE_UPDATE
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE ESS_CHECKCODE_UPDATE (
   IN_USERNAME    VARCHAR2,
   IN_C_MAIL      VARCHAR2,
   IN_CHECK_CODE  VARCHAR2,
   IN_END_DATE    DATE
)
IS
   NUMBER_ROW   NUMBER(3);
BEGIN
   SELECT COUNT(USERNAME) INTO NUMBER_ROW FROM ESS_CHECK_CODE WHERE USERNAME = IN_USERNAME;
   IF NUMBER_ROW <1 THEN
    INSERT INTO ESS_CHECK_CODE (USERNAME,C_MAIL,CHECK_CODE,END_DATE) VALUES (IN_USERNAME,IN_C_MAIL,IN_CHECK_CODE,IN_END_DATE);
   ELSE
    UPDATE ESS_CHECK_CODE SET CHECK_CODE = IN_CHECK_CODE,END_DATE = IN_END_DATE,ACTIVITY = 1 WHERE USERNAME = IN_USERNAME;
   END IF;
END;
/

prompt
prompt Creating procedure ESS_PROCESS_AFFIRM_AGREE
prompt ===========================================
prompt
create or replace procedure ESS_PROCESS_AFFIRM_AGREE(
       processKey in varchar2,
       processInstanceId in varchar2)
       -- Author  : fei.liu  @sipingsoft
       -- Created : 2013/9/27 10:33:52
       -- Purpose : 更改审核标志
is
       V_TABLE_NAME       VARCHAR2(100);
       SQLSTAT            VARCHAR2(500);
begin 
       SELECT A.TABLE_NAME INTO V_TABLE_NAME FROM PROCESS_ESS_RELATION A 
              WHERE A.PROCESS_KEY = processKey;
       SQLSTAT := 'UPDATE ' ||V_TABLE_NAME|| ' SET AFFIRM_FLAG = 1 WHERE PROCESSID =' || processInstanceId;
       execute immediate SQLSTAT;
       COMMIT;
       EXCEPTION
         WHEN NO_DATA_FOUND THEN
           ROLLBACK;
         WHEN TOO_MANY_ROWS THEN
           ROLLBACK;
end ESS_PROCESS_AFFIRM_AGREE;
/

prompt
prompt Creating procedure ESS_PROCESS_AFFIRM_VETO
prompt ==========================================
prompt
create or replace procedure ESS_PROCESS_AFFIRM_VETO(
       processKey in varchar2,
       processInstanceId in varchar2)
       -- Author  : fei.liu  @sipingsoft
       -- Created : 2013/9/27 10:33:52
       -- Purpose : 更改审核标志
is
       V_TABLE_NAME       VARCHAR2(100);
       SQLSTAT            VARCHAR2(500);
begin
       SELECT A.TABLE_NAME INTO V_TABLE_NAME FROM PROCESS_ESS_RELATION A 
              WHERE A.PROCESS_KEY = processKey;
       SQLSTAT := 'UPDATE ' ||V_TABLE_NAME|| ' SET AFFIRM_FLAG = 2 WHERE PROCESSID =' || processInstanceId;
       execute immediate SQLSTAT;
       COMMIT;
       EXCEPTION
         WHEN NO_DATA_FOUND THEN
           ROLLBACK;
         WHEN TOO_MANY_ROWS THEN
           ROLLBACK;
end ESS_PROCESS_AFFIRM_VETO;
/

prompt
prompt Creating procedure ESS_UPDATE_MILITARY
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE ess_update_military (
   in_military_no   IN   NUMBER,
   in_flag          IN   NUMBER
)
IS
/******************************************************************************
   NAME:       ess_update_military
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2005-7-4          1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     ess_update_military
      Sysdate:         2005-7-4
      Date and Time:   2005-7-4, PM 1:20:01, and 2005-7-4 PM 1:20:01
      Username:         (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
   ess_row       ess_military_service%ROWTYPE;
   check_empid   VARCHAR2 (20);
BEGIN
   IF in_flag = 1
   THEN
      BEGIN
         SELECT *
           INTO ess_row
           FROM ess_military_service
          WHERE military_no = in_military_no;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            ess_row := NULL;
      END;

      BEGIN
         SELECT empid
           INTO check_empid
           FROM hr_military_service
          WHERE empid = ess_row.empid AND start_date = ess_row.start_date;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            check_empid := NULL;
         WHEN OTHERS
         THEN
            check_empid := 'FOUND';
      END;

      IF ess_row.empid IS NOT NULL AND check_empid IS NULL
      THEN
         INSERT INTO hr_military_service
                     (military_no, empid, military_status,
                      military_type_code, military_level_code,
                      military_area_code, start_date, end_date, create_date,
                      created_by, update_date, updated_by, orderno, activity)
            SELECT hr_ms_seq.NEXTVAL, empid, military_status,
                   military_type_code, military_level_code,
                   military_area_code, start_date, end_date, create_date,
                   created_by, update_date, updated_by, orderno, activity
              FROM ess_military_service
             WHERE military_no = ess_row.military_no;

         COMMIT;
      END IF;
   END IF;
END ess_update_military;
/

prompt
prompt Creating procedure ETN_SATISFACTION_FOR_WHOLE
prompt =============================================
prompt
CREATE OR REPLACE PROCEDURE etn_satisfaction_for_whole (in_etn_no IN NUMBER)
IS
/******************************************************************************
   NAME:       ETN_WHOLE_SATISFACTION
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2005-3-6          1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     ETN_WHOLE_SATISFACTION
      Sysdate:         2005-3-6
      Date and Time:   2005-3-6, 18:10:40, and 2005-3-6 18:10:40
      Username:         (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
   whole_count          NUMBER                  := 0;
   sum_whole_score      NUMBER                  := 0;
   v_out_score          NUMBER (5, 1)           := 0;
   v_whole_satis_type   etn_fact_plan%ROWTYPE;

   CURSOR wholesatisfy_cur
   IS
      SELECT   *
          FROM etn_fact_plan
         WHERE seq_etn_plan = in_etn_no
      ORDER BY seq_etn_plan;
BEGIN
   DELETE      etn_whole_satisfaction
         WHERE etn_plan_no = in_etn_no;

   COMMIT;

   OPEN wholesatisfy_cur;

   LOOP
      FETCH wholesatisfy_cur
       INTO v_whole_satis_type;

      IF wholesatisfy_cur%NOTFOUND
      THEN
         v_out_score := sum_whole_score / whole_count;

         INSERT INTO etn_whole_satisfaction
                     (etn_plan_no, whole_satisfaction
                     )
              VALUES (in_etn_no, v_out_score
                     );

         COMMIT;
         EXIT;
      END IF;

      sum_whole_score :=
                  sum_whole_score + NVL (v_whole_satis_type.satisfact_rate, 0);
      whole_count := whole_count + 1;
   END LOOP;

   CLOSE wholesatisfy_cur;
END etn_satisfaction_for_whole;
/

prompt
prompt Creating procedure ETN_SCORE_STATISTIC
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE etn_score_statistic (in_etn_no IN NUMBER)
IS
/******************************************************************************
   NAME:       ETN_SCORE_STATISTIC
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2005-3-6          1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     ETN_SCORE_STATISTIC
      Sysdate:         2005-3-6
      Date and Time:   2005-3-6, 19:40:53, and 2005-3-6 19:40:53
      Username:         (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
   count_award_flag      NUMBER                  := 0;
   v_out_award_count     NUMBER                  := 0;
   count_appraise_flag   NUMBER                  := 0;
   count_makeup_flag     NUMBER                  := 0;
   count_fellback_flag   NUMBER                  := 0;
   count_total           NUMBER                  := 0;
   v_out_d               NUMBER (5, 1)           := 0;
   v_out_makeup          NUMBER (5, 1)           := 0;
   v_out_fellback        NUMBER (5, 1)           := 0;
   v_fact_group_c        etn_fact_plan%ROWTYPE;

   CURSOR personalscore_cur
   IS
      SELECT   *
          FROM etn_fact_plan
         WHERE seq_etn_plan = in_etn_no
      ORDER BY seq_etn_plan;
BEGIN
   DELETE      etn_whole_result
         WHERE etn_plan_no = in_etn_no;

   COMMIT;

   OPEN personalscore_cur;

   LOOP
      FETCH personalscore_cur
       INTO v_fact_group_c;

      IF personalscore_cur%NOTFOUND              --当分数算完之后保存
      THEN
         v_out_d := (1 - count_appraise_flag / count_total) * 100;

         IF count_appraise_flag <> 0
         THEN
            v_out_makeup := (count_makeup_flag / count_appraise_flag) * 100;
         END IF;

         v_out_fellback := count_fellback_flag;
         DBMS_OUTPUT.put_line (   'voutd: '
                               || v_out_d
                               || ' makeup: '
                               || v_out_makeup
                               || ' fellback: '
                               || v_out_fellback
                              );

         INSERT INTO etn_whole_result
                     (etn_plan_no, eligibility_rate, makeup_success_rate,
                      count_fell_back, connt_award
                     )
              VALUES (in_etn_no, v_out_d, v_out_makeup,
                      v_out_fellback, v_out_award_count
                     );

         EXIT;
      END IF;

      IF v_fact_group_c.appraise_result = 'D'
      THEN
         count_appraise_flag := count_appraise_flag + 1;
      END IF;

      IF v_fact_group_c.content = 'makeupegibility'
      THEN
         count_makeup_flag := count_makeup_flag + 1;
      END IF;

      IF v_fact_group_c.content = 'fellback'
      THEN
         count_fellback_flag := count_fellback_flag + 1;
      END IF;

      IF    v_fact_group_c.content = 'firstGradefor'
         OR v_fact_group_c.content = 'secondGradefor'
         OR v_fact_group_c.content = 'thirdGradefor'
      THEN
         v_out_award_count := v_out_award_count + 1;
      END IF;

      count_total := count_total + 1;
   END LOOP;

   CLOSE personalscore_cur;
END etn_score_statistic;
/

prompt
prompt Creating procedure ETN_TEACHER_SATISFACT_TOTAL
prompt ==============================================
prompt
CREATE OR REPLACE PROCEDURE etn_teacher_satisfact_total (in_etn_no IN NUMBER)
IS
/******************************************************************************
   NAME:       ETN_TEACHER_SATISFACT_TOTAL
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2003-3-23          1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     ETN_TEACHER_SATISFACT_TOTAL
      Sysdate:         2003-3-23
      Date and Time:   2003-3-23, 19:28:29, and 2003-3-23 19:28:29
      Username:         (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
   out_teacher_end_score     NUMBER                          := 0;
   count_person              NUMBER                          := 0;
   in_teacher_score          NUMBER                          := 0;
   v_etn_teacher_satisfact   etn_teacher_satisfact%ROWTYPE;

   CURSOR etn_cur
   IS
      SELECT   *
          FROM etn_teacher_satisfact
         WHERE etn_plan_no = in_etn_no
      ORDER BY etn_plan_no, teacher_no;
BEGIN
   OPEN etn_cur;

   LOOP
      FETCH etn_cur
       INTO v_etn_teacher_satisfact;

      EXIT WHEN etn_cur%NOTFOUND;
      count_person := count_person + 1;
      in_teacher_score :=
                    in_teacher_score + NVL (v_etn_teacher_satisfact.score, 0);
   END LOOP;

   IF count_person <> 0
   THEN
      out_teacher_end_score := in_teacher_score / count_person;

      UPDATE etn_whole_satisfaction
         SET edu_teacher_total_satis = out_teacher_end_score
       WHERE etn_plan_no = in_etn_no;

      COMMIT;
   END IF;

   CLOSE etn_cur;
END etn_teacher_satisfact_total;
/

prompt
prompt Creating procedure ETN_YEARPLAN_PRO
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE etn_yearplan_pro
IS
/******************************************************************************
   NAME:       ETN_YEARPLAN_PRO
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2003-5-18          1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     ETN_YEARPLAN_PRO
      Sysdate:         2003-5-18
      Date and Time:   2003-5-18, 13:20:05, and 2003-5-18 13:20:05
      Username:         (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
   v_etn_year_plan       etn_year_plan%ROWTYPE;
   o_total_edu_time      NUMBER                  := 0;
   o_total_edu_perrior   NUMBER                  := 0;
   o_total_edu_fee       NUMBER                  := 0;
   o_year_time           DATE;

   CURSOR yearplan_cur
   IS
      SELECT   *
          FROM etn_year_plan
      ORDER BY plan_start_date;
BEGIN
   DELETE      etn_year_plan_statistic;

   COMMIT;

   OPEN yearplan_cur;

   o_year_time := TO_DATE ('2001-01-01', 'YYYY-MM-DD');

   LOOP
      FETCH yearplan_cur
       INTO v_etn_year_plan;

      EXIT WHEN yearplan_cur%NOTFOUND;

      IF SUBSTR (TO_CHAR (o_year_time, 'YYYY-MM-DD'), 1, 4) <>
            SUBSTR (TO_CHAR (v_etn_year_plan.plan_start_date, 'YYYY-MM-DD'),
                    1,
                    4
                   )
      THEN
         INSERT INTO etn_year_plan_statistic
                     (year_plan_year, total_edu_time, total_edu_perrior,
                      total_edu_fee
                     )
              VALUES (o_year_time, o_total_edu_time, o_total_edu_perrior,
                      o_total_edu_fee
                     );

         COMMIT;
         o_year_time := v_etn_year_plan.plan_start_date;
         o_total_edu_time := 0;
         o_total_edu_perrior := 0;
         o_total_edu_fee := 0;
      END IF;

      --danwei  shi  tian
      IF v_etn_year_plan.plan_edu_time_danwei = 0
      THEN
         o_total_edu_time := o_total_edu_time + v_etn_year_plan.plan_edu_time;
      ELSE
         o_total_edu_time :=
                         o_total_edu_time + v_etn_year_plan.plan_edu_time * 8;
      END IF;

      o_total_edu_perrior := o_total_edu_perrior + 1;
      o_total_edu_fee := o_total_edu_fee + v_etn_year_plan.plan_intend_fee;
   END LOOP;

   INSERT INTO etn_year_plan_statistic
               (year_plan_year, total_edu_time, total_edu_perrior,
                total_edu_fee
               )
        VALUES (o_year_time, o_total_edu_time, o_total_edu_perrior,
                o_total_edu_fee
               );

   COMMIT;

   CLOSE yearplan_cur;
END etn_yearplan_pro;
/

prompt
prompt Creating procedure EVA_COLUMN_MOD_P
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE eva_column_mod_p (
   ev_item_detail_id1_i         NUMBER,
   evcolumn001_i                VARCHAR2,
   evcolumn002_i                VARCHAR2,
   ev_detail_prop_i             VARCHAR2,
   evcolumn003_i                VARCHAR2,
   evcolumn004_i                VARCHAR2,
   evcolumn005_i                VARCHAR2,
   evcolumn006_i                VARCHAR2,
   evcolumn007_i                VARCHAR2,
   evcolumn008_i                VARCHAR2,
   status_o               OUT   NUMBER
)
IS
   ev_item_detail_id2_p   NUMBER;
   ev_detail_prop_p       FLOAT;
/******************************************************************************
   NAME:       eva_COLUMN_MOD_P
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        7/10/2005   Pennix       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     eva_COLUMN_MOD_P
      Sysdate:         7/10/2005
      Date and Time:   7/10/2005, 5:06:11 PM, and 7/10/2005 5:06:11 PM
      Username:        Pennix (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   status_o := 1;
   ev_detail_prop_p := TO_NUMBER (ev_detail_prop_i);

   SELECT seq_ev_item_detail
     INTO ev_item_detail_id2_p
     FROM eva_item_detail
    WHERE ev_detail_order = ev_item_detail_id1_i
      AND seq_ev_item_detail <> ev_item_detail_id1_i;

   UPDATE eva_item_detail
      SET ev_detail_prop = ev_detail_prop_p
    WHERE seq_ev_item_detail = ev_item_detail_id1_i;

   UPDATE eva_item_detail
      SET ev_detail_prop = ev_detail_prop_p
    WHERE seq_ev_item_detail = ev_item_detail_id2_p;

   UPDATE eva_column_detail
      SET ev_column_detail = evcolumn001_i
    WHERE seq_ev_item_detail = ev_item_detail_id1_i
      AND ev_column_id = 'EVCOLUMN001';

   UPDATE eva_column_detail
      SET ev_column_detail = evcolumn002_i
    WHERE seq_ev_item_detail = ev_item_detail_id1_i
      AND ev_column_id = 'EVCOLUMN002';

   UPDATE eva_column_detail
      SET ev_column_detail = evcolumn003_i
    WHERE seq_ev_item_detail = ev_item_detail_id1_i
      AND ev_column_id = 'EVCOLUMN003';

   UPDATE eva_column_detail
      SET ev_column_detail = evcolumn004_i
    WHERE seq_ev_item_detail = ev_item_detail_id1_i
      AND ev_column_id = 'EVCOLUMN004';

   UPDATE eva_column_detail
      SET ev_column_detail = evcolumn001_i
    WHERE seq_ev_item_detail = ev_item_detail_id2_p
      AND ev_column_id = 'EVCOLUMN001';

   UPDATE eva_column_detail
      SET ev_column_detail = evcolumn002_i
    WHERE seq_ev_item_detail = ev_item_detail_id2_p
      AND ev_column_id = 'EVCOLUMN002';

   UPDATE eva_column_detail
      SET ev_column_detail = evcolumn004_i
    WHERE seq_ev_item_detail = ev_item_detail_id2_p
      AND ev_column_id = 'EVCOLUMN004';

   UPDATE eva_column_detail
      SET ev_column_detail = evcolumn005_i
    WHERE seq_ev_item_detail = ev_item_detail_id2_p
      AND ev_column_id = 'EVCOLUMN005';

   UPDATE eva_column_detail
      SET ev_column_detail = evcolumn006_i
    WHERE seq_ev_item_detail = ev_item_detail_id2_p
      AND ev_column_id = 'EVCOLUMN006';

   UPDATE eva_column_detail
      SET ev_column_detail = evcolumn007_i
    WHERE seq_ev_item_detail = ev_item_detail_id2_p
      AND ev_column_id = 'EVCOLUMN007';

   UPDATE eva_column_detail
      SET ev_column_detail = evcolumn008_i
    WHERE seq_ev_item_detail = ev_item_detail_id2_p
      AND ev_column_id = 'EVCOLUMN008';
EXCEPTION
   WHEN OTHERS
   THEN
      status_o := 0;
END eva_column_mod_p;
/

prompt
prompt Creating procedure EVA_COMMON_ITEM_ADD_P
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE eva_common_item_add_p (
   evtype     VARCHAR2,
   evtype01   VARCHAR2,
   period     VARCHAR2
)
IS
   commonitemseq   NUMBER;
/******************************************************************************
   NAME:       eva_COMMON_ITEM_ADD_P
   PURPOSE:

   REVISIONS:
   VER        DATE        AUTHOR           DESCRIPTION
   ---------  ----------  ---------------  ------------------------------------
   1.0        2005-09-21          1. CREATED THIS PROCEDURE.

   NOTES:

   AUTOMATICALLY AVAILABLE AUTO REPLACE KEYWORDS:
      OBJECT NAME:     eva_COMMON_ITEM_ADD_P
      SYSDATE:         2005-09-21
      DATE AND TIME:   2005-09-21, 16:40:35, AND 2005-09-21 16:40:35
      USERNAME:         (SET IN TOAD OPTIONS, PROCEDURE EDITOR)
      TABLE NAME:       (SET IN THE "New PL/SQL Object" DIALOG)

******************************************************************************/
BEGIN
   commonitemseq := 0;

   DECLARE
      CURSOR common_item_cur
      IS
         SELECT seq_ev_common_item_detail, ev_period_id, ev_item_id,
                ev_detail_prop, ev_detail_order, ev_type_id
           FROM eva_common_item_detail
          WHERE ev_period_id = period AND ev_type_id = evtype01;

      c_item   common_item_cur%ROWTYPE;
   BEGIN
      OPEN common_item_cur;

      LOOP
         FETCH common_item_cur
          INTO c_item;

         EXIT WHEN common_item_cur%NOTFOUND;

         INSERT INTO eva_common_item_detail
                     (seq_ev_common_item_detail,
                      ev_period_id, ev_item_id,
                      ev_detail_prop,
                      ev_detail_order, ev_type_id
                     )
              VALUES (seq_ev_common_item_detail.NEXTVAL,
                      c_item.ev_period_id, c_item.ev_item_id,
                      c_item.ev_detail_prop,
                      seq_ev_common_item_detail.NEXTVAL, evtype
                     );

         SELECT seq_ev_common_item_detail.CURRVAL
           INTO commonitemseq
           FROM DUAL;

         DECLARE
            CURSOR common_column_cur
            IS
               SELECT seq_ev_common_item_detail, ev_column_detail,
                      ev_column_id
                 FROM eva_common_column_detail
                WHERE seq_ev_common_item_detail =
                                             c_item.seq_ev_common_item_detail;

            c_column   common_column_cur%ROWTYPE;
         BEGIN
            OPEN common_column_cur;

            LOOP
               FETCH common_column_cur
                INTO c_column;

               EXIT WHEN common_column_cur%NOTFOUND;

               INSERT INTO eva_common_column_detail
                           (seq_ev_common_item_detail, ev_column_detail,
                            ev_column_id
                           )
                    VALUES (commonitemseq, c_column.ev_column_detail,
                            c_column.ev_column_id
                           );
            END LOOP;

            CLOSE common_column_cur;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
            WHEN OTHERS
            THEN
               -- CONSIDER LOGGING THE ERROR AND THEN RE-RAISE
               RAISE;
         END;
      END LOOP;

      CLOSE common_item_cur;
   END;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      NULL;
   WHEN OTHERS
   THEN
      -- CONSIDER LOGGING THE ERROR AND THEN RE-RAISE
      RAISE;
END eva_common_item_add_p;
/

prompt
prompt Creating procedure EVA_DELETE_KPIITEM
prompt =====================================
prompt
create or replace procedure EVA_DELETE_KPIITEM(
       IN_EVA_KPI_NO VARCHAR2,
       IN_EVA_KPI_ID VARCHAR2,
       IN_UPDATED_BY VARCHAR2) 
is
begin
       UPDATE EVA_KPI_ITEM
			 SET    ACTIVITY = 0,
					    UPDATED_BY = IN_UPDATED_BY,
					    UPDATE_DATE = SYSDATE
			 WHERE   EVA_KPI_NO = IN_EVA_KPI_NO;
       
       UPDATE EVA_KPI_VALIDATER
			 SET    ACTIVITY = 0,
					    UPDATED_BY = IN_UPDATED_BY,
					    UPDATE_DATE = SYSDATE
			 WHERE  EVA_KPI_ID = IN_EVA_KPI_ID;
end EVA_DELETE_KPIITEM;
/

prompt
prompt Creating procedure EVA_DEPT_FILL_P
prompt ==================================
prompt
CREATE OR REPLACE PROCEDURE eva_dept_fill_p (
   ev_period_id_i         VARCHAR2,
   status_o         OUT   NUMBER
)
IS
   ev_period_id_p      NUMBER;
   ev_period_edate_p   DATE;
/******************************************************************************
   NAME:       eva_DEPT_FILL_P
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        7/11/2005   Pennix       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     eva_DEPT_FILL_P
      Sysdate:         7/11/2005
      Date and Time:   7/11/2005, 2:33:50 PM, and 7/11/2005 2:33:50 PM
      Username:        Pennix (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   status_o := 1;
   SELECT ev_period_id
     INTO ev_period_id_p
     FROM eva_period
    WHERE ev_period_id = ev_period_id_i;
   SELECT ev_period_edate
     INTO ev_period_edate_p
     FROM eva_period_v
    WHERE ev_period_id = ev_period_id_p;
   IF ev_period_edate_p > SYSDATE
   THEN
      BEGIN
         DELETE FROM eva_dept
               WHERE ev_dept_id NOT IN (SELECT deptid
                                          FROM hr_department)
                 AND ev_period_id = ev_period_id_p;
         UPDATE eva_dept
            SET ev_dept_name = (SELECT deptname
                                  FROM hr_department
                                 WHERE deptid = eva_dept.ev_dept_id)
          WHERE ev_period_id = ev_period_id_p;
         UPDATE eva_dept
            SET ev_dept_level = (SELECT dept_level
                                   FROM hr_department
                                  WHERE deptid = eva_dept.ev_dept_id)
          WHERE ev_period_id = ev_period_id_p;
         UPDATE eva_dept
            SET ev_parent_dept_id = (SELECT parent_dept_id
                                       FROM hr_department
                                      WHERE deptid = eva_dept.ev_dept_id)
          WHERE ev_period_id = ev_period_id_p;
         INSERT INTO eva_dept
                     (ev_period_id, ev_dept_id, ev_dept_name, ev_dept_level,
                      ev_parent_dept_id)
            SELECT ev_period_id_p, deptid, deptname, dept_level,
                   parent_dept_id
              FROM hr_department
             WHERE hr_department.dept_level <= 5
						   AND (DATE_CREATED IS NULL OR DATE_CREATED < SYSDATE)
	             AND (DATE_ENDED IS NULL OR DATE_ENDED > SYSDATE)
							 AND deptid NOT IN (SELECT ev_dept_id
																			FROM eva_dept
																		 WHERE ev_period_id = ev_period_id_p);
         UPDATE eva_dept ed1
            SET ed1.ev_dept_norm =
                   (SELECT ed2.ev_dept_norm
                      FROM eva_dept ed2
                     WHERE ed2.ev_dept_id = ed1.ev_dept_id
                       AND TO_NUMBER (SUBSTR (ed2.ev_period_id, 1, 4)) =
                                TO_NUMBER (SUBSTR (ed1.ev_period_id, 1, 4))
                                - 1
                       AND SUBSTR (ed2.ev_period_id, 5, 2) =
                                               SUBSTR (ed1.ev_period_id, 5, 2))
          WHERE ev_period_id = ev_period_id_p;
         UPDATE eva_dept
            SET ev_dept_norm = 0
          WHERE ev_dept_norm IS NULL AND ev_period_id = ev_period_id_p;
         UPDATE eva_dept ed1
            SET ed1.activity =
                   (SELECT ed2.activity
                      FROM eva_dept ed2
                     WHERE ed2.ev_dept_id = ed1.ev_dept_id
                       AND TO_NUMBER (SUBSTR (ed2.ev_period_id, 1, 4)) =
                                TO_NUMBER (SUBSTR (ed1.ev_period_id, 1, 4)) - 1
                       AND SUBSTR (ed2.ev_period_id, 5, 2) = SUBSTR (ed1.ev_period_id, 5, 2))
          WHERE ev_period_id = ev_period_id_p;
         UPDATE eva_dept
            SET activity = 1
          WHERE activity IS NULL AND ev_period_id = ev_period_id_p;
      END;
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      status_o := 0;
END eva_dept_fill_p;
/

prompt
prompt Creating procedure EVA_DETAIL_DEL_P
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE eva_detail_del_p (
   seq_ev_item_detail_i         NUMBER,
   status_o               OUT   NUMBER
)
IS
/******************************************************************************
   NAME:       eva_DETAIL_DEL_P
   PURPOSE:    年初設定時，删除目標書細則

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        7/8/2005   Pennix       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     eva_DETAIL_DEL_P
      Sysdate:         7/8/2005
      Date and Time:   7/8/2005, 1:19:02 PM, and 7/8/2005 1:19:02 PM
      Username:        Pennix (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   status_o := 1;

   DELETE FROM eva_item_detail
         WHERE seq_ev_item_detail = seq_ev_item_detail_i;
EXCEPTION
   WHEN OTHERS
   THEN
      status_o := 0;
END eva_detail_del_p;
/

prompt
prompt Creating procedure EVA_DETAIL_DEL_YEAR_P
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE eva_detail_del_year_p (
   seq_ev_item_detail_i         NUMBER,
   status_o               OUT   NUMBER
)
IS
   seq_ev_item_detail_p   NUMBER;
/******************************************************************************
   NAME:       eva_DETAIL_DEL_P
   PURPOSE:    年初設定時，删除目標書細則

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        7/8/2005   Pennix       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     eva_DETAIL_DEL_P
      Sysdate:         7/8/2005
      Date and Time:   7/8/2005, 1:19:02 PM, and 7/8/2005 1:19:02 PM
      Username:        Pennix (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   SELECT seq_ev_item_detail
     INTO seq_ev_item_detail_p
     FROM eva_item_detail
    WHERE ev_detail_order = seq_ev_item_detail_i
      AND seq_ev_item_detail <> seq_ev_item_detail_i;

   DELETE FROM eva_item_detail
         WHERE seq_ev_item_detail = seq_ev_item_detail_i;

   DELETE FROM eva_item_detail
         WHERE seq_ev_item_detail = seq_ev_item_detail_p;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      status_o := 0;
   WHEN OTHERS
   THEN
      status_o := 1;
END eva_detail_del_year_p;
/

prompt
prompt Creating procedure EVA_DETAIL_MARK_P
prompt ====================================
prompt
CREATE OR REPLACE PROCEDURE eva_detail_mark_p (
   seq_ev_item_detail_i         NUMBER,
   ev_process_id_i              VARCHAR2,
   ev_mark_i                    NUMBER,
   ev_idea_i                    VARCHAR2,
   ev_prop_i                    VARCHAR2,
   status_o               OUT   NUMBER
)
IS
/******************************************************************************
   NAME:       eva_DETAIL_MARK_P
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        7/11/2005   Pennix       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     eva_DETAIL_MARK_P
      Sysdate:         7/11/2005
      Date and Time:   7/11/2005, 9:28:25 PM, and 7/11/2005 9:28:25 PM
      Username:        Pennix (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   status_o := 1;

   DELETE FROM eva_detail_mark
         WHERE seq_ev_item_detail = seq_ev_item_detail_i
           AND ev_process_id = ev_process_id_i;

   INSERT INTO eva_detail_mark
               (seq_ev_item_detail, ev_process_id, ev_mark, ev_idea,ev_prop
               )
        VALUES (seq_ev_item_detail_i, ev_process_id_i, round(ev_mark_i,2), ev_idea_i,ev_prop_i
               );
EXCEPTION
   WHEN OTHERS
   THEN
      status_o := 0;
END eva_detail_mark_p;
/

prompt
prompt Creating procedure EVA_DETAIL_MOD_P
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE eva_detail_mod_p (
   ev_detail_prop_i             FLOAT,
   seq_ev_item_detail_o   OUT   NUMBER,
   status_o               OUT   NUMBER
)
IS
/******************************************************************************
   NAME:       eva_DETAIL_MOD_P
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        7/8/2005   Pennix       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     eva_DETAIL_MOD_P
      Sysdate:         7/8/2005
      Date and Time:   7/8/2005, 2:50:02 PM, and 7/8/2005 2:50:02 PM
      Username:        Pennix (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   status_o := 1;

   UPDATE eva_item_detail
      SET ev_detail_prop = ev_detail_prop_i
    WHERE seq_ev_item_detail = seq_ev_item_detail_o;
EXCEPTION
   WHEN OTHERS
   THEN
      status_o := 0;
END eva_detail_mod_p;
/

prompt
prompt Creating procedure EVA_ENDOW_COMMON_ITEM_P
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE eva_endow_common_item_p(period_i  VARCHAR2,
                                                    flag_i    VARCHAR2,
                                                    emp_id_i  VARCHAR2,
                                                    item_id_i VARCHAR2,
                                                    type_id_i VARCHAR2,
                                                    status_o  OUT NUMBER) IS
  empid_param           eva_emp.ev_emp_id%TYPE;
  evtype          eva_emp.ev_type_id%TYPE;
  itemid          eva_item_detail.ev_item_id%TYPE;
  item_detail_seq NUMBER := 0;
  deptid VARCHAR2(30);

  /******************************************************************************
     NAME:       eva_ADD_COMMON_ITEM
     PURPOSE:

     REVISIONS:
     VER        DATE        AUTHOR           DESCRIPTION
     ---------  ----------  ---------------  ------------------------------------
     1.0        2005-08-23          1. CREATED THIS PROCEDURE.

     NOTES:

     AUTOMATICALLY AVAILABLE AUTO REPLACE KEYWORDS:
        OBJECT NAME:     eva_ADD_COMMON_ITEM
        SYSDATE:         2005-08-23
        DATE AND TIME:   2005-08-23, 12:34:18, AND 2005-08-23 12:34:18
        USERNAME:         (SET IN TOAD OPTIONS, PROCEDURE EDITOR)
        TABLE NAME:       (SET IN THE "New PL/SQL Object" DIALOG)

  ******************************************************************************/
  CURSOR cus_all_emp IS
    SELECT ev_emp_id, ev_type_id
      FROM eva_emp
     WHERE ev_period_id = period_i
       AND ev_type_id = type_id_i;

  CURSOR cus_emp IS
    SELECT ev_emp_id, ev_type_id
      FROM eva_emp
     WHERE ev_period_id = period_i
       AND ev_emp_id = emp_id_i;
BEGIN
  IF item_id_i = '' OR item_id_i IS NULL THEN
    itemid := '%%';
  ELSE
    itemid := item_id_i;
  END IF;

  IF flag_i = 'E' THEN
    OPEN cus_emp;
  ELSE
    OPEN cus_all_emp;
  END IF;

  status_o := 1;

  LOOP
    empid_param  := '';
    evtype := type_id_i;

    IF flag_i = 'E' THEN
      FETCH cus_emp
        INTO empid_param, evtype;

      EXIT WHEN cus_emp%NOTFOUND;
    ELSE
      FETCH cus_all_emp
        INTO empid_param, evtype;

      EXIT WHEN cus_all_emp%NOTFOUND;
    END IF;

    BEGIN
      SELECT hr_employee.deptid INTO deptid
      FROM hr_employee
      WHERE empid = empid_param;

      IF flag_i = 'E' THEN

        DELETE eva_column_detail
         WHERE EXISTS (SELECT *
                  FROM eva_item_detail
                 WHERE eva_item_detail.seq_ev_item_detail = eva_column_detail.seq_ev_item_detail
                   AND eva_item_detail.ev_period_id = period_i
                   AND eva_item_detail.ev_emp_id = empid_param
                   AND eva_item_detail.ev_item_id = item_id_i);

        DELETE eva_item_detail
         WHERE eva_item_detail.ev_item_id = item_id_i
           AND eva_item_detail.ev_period_id = period_i
           AND eva_item_detail.ev_emp_id = empid_param;
      ELSE
        DELETE eva_column_detail
         WHERE EXISTS
         (SELECT *
                  FROM eva_item_detail
                 WHERE eva_item_detail.seq_ev_item_detail = eva_column_detail.seq_ev_item_detail
                   AND eva_item_detail.ev_period_id = period_i
                   AND eva_item_detail.ev_emp_id = empid_param
                   AND eva_item_detail.ev_item_id IN
                       (SELECT ev_item_id
                          FROM eva_common_item_detail
                         WHERE eva_common_item_detail.ev_type_id = evtype
                           AND eva_common_item_detail.ev_period_id = period_i));

        DELETE eva_item_detail
         WHERE EXISTS (SELECT *
                  FROM eva_common_item_detail
                 WHERE eva_item_detail.ev_item_id = eva_common_item_detail.ev_item_id
                   AND eva_common_item_detail.ev_type_id = evtype
                   AND eva_common_item_detail.ev_period_id = period_i)
           AND eva_item_detail.ev_period_id = period_i
           AND eva_item_detail.ev_emp_id = empid_param;
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        status_o := 0;
    END;

    DECLARE
      CURSOR cus_item_detail IS
        SELECT seq_ev_common_item_detail,
               ev_item_id,
               ev_detail_prop,
               ev_item_type,
               ev_item_method,
               ev_item_range,
               ev_item_mark_value,
               ev_item_mark_name,
               ev_item_mark_range
          FROM eva_common_item_detail
         WHERE ev_period_id = period_i
           AND ev_type_id = evtype
           AND ev_item_id LIKE itemid
           AND ev_item_type = 'EVITEMTYPE001'
           AND (EV_ITEM_RANGE = 'all' OR EV_ITEM_RANGE LIKE '%'||deptid||'%');

      cus_item_detail_c cus_item_detail%ROWTYPE;
    BEGIN
      OPEN cus_item_detail;

      FETCH cus_item_detail
        INTO cus_item_detail_c;

      WHILE cus_item_detail%FOUND LOOP
        /*     DELETE eva_COLUMN_DETAIL WHERE EXISTS
          (SELECT * FROM eva_ITEM_DETAIL WHERE eva_ITEM_DETAIL.SEQ_EV_ITEM_DETAIL=eva_COLUMN_DETAIL.SEQ_EV_ITEM_DETAIL
          AND  eva_ITEM_DETAIL.EV_ITEM_ID=CUS_ITEM_DETAIL_C.EV_ITEM_ID
          AND eva_ITEM_DETAIL.EV_PERIOD_ID=PERIOD_I
          AND eva_ITEM_DETAIL.EV_EMP_ID= EMPID
          )
        */
        BEGIN
          INSERT INTO eva_item_detail
            (seq_ev_item_detail,
             ev_period_id,
             ev_emp_id,
             ev_item_id,
             ev_detail_prop,
             ev_detail_order,
             EV_ITEM_TYPE,
             EV_ITEM_METHOD,
             EV_ITEM_RANGE,
             EV_ITEM_MARK_VALUE,
             EV_ITEM_MARK_NAME,
             EV_MARK_RANGE,
             SEQ_EV_COMMON_ITEM_DETAIL
             )
          VALUES
            (eva_item_detail_seq.NEXTVAL,
             period_i,
             empid_param,
             cus_item_detail_c.ev_item_id,
             cus_item_detail_c.ev_detail_prop,
             eva_item_detail_seq.NEXTVAL,
             cus_item_detail_c.ev_item_type,
             cus_item_detail_c.ev_item_method,
             cus_item_detail_c.ev_item_range,
             cus_item_detail_c.ev_item_mark_value,
             cus_item_detail_c.ev_item_mark_name,
             cus_item_detail_c.ev_item_mark_range,
             cus_item_detail_c.SEQ_EV_COMMON_ITEM_DETAIL
             );
        EXCEPTION
          WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(' INSERT ' || period_i || empid_param ||
                                 cus_item_detail_c.ev_item_id ||
                                 ' eva_ITEM_DETAIL ERROR ');
        END;
        BEGIN
          SELECT eva_item_detail_seq.CURRVAL
            INTO item_detail_seq
            FROM DUAL;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            item_detail_seq := 0;
          WHEN OTHERS THEN
            item_detail_seq := 0;
        END;

        IF item_detail_seq <> 0 THEN
          INSERT INTO eva_column_detail
            (seq_ev_item_detail, ev_column_detail, ev_column_id)
            SELECT item_detail_seq, ev_column_detail, ev_column_id
              FROM eva_common_column_detail
             WHERE seq_ev_common_item_detail =
                   cus_item_detail_c.seq_ev_common_item_detail;

        END IF;
        FETCH cus_item_detail
          INTO cus_item_detail_c;
      END LOOP;

      CLOSE cus_item_detail;
    END;
  END LOOP;

  IF flag_i = 'E' THEN
    CLOSE cus_emp;
  ELSE
    CLOSE cus_all_emp;
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    status_o := 0;
END eva_endow_common_item_p;
/

prompt
prompt Creating procedure EVA_KPI_ADD_KPISCORE
prompt =======================================
prompt
create or replace procedure EVA_KPI_ADD_KPISCORE(
       IN_EMPID VARCHAR2,
       IN_EVA_KPI_ID VARCHAR2,
       IN_PA_MONTH VARCHAR2,
       IN_SCORE VARCHAR2,
       IN_CREATED_BY VARCHAR2,
       IN_CPNY_ID VARCHAR2,
       IN_DESCRIPTION VARCHAR2,
       IN_VALIDATER_ID VARCHAR2) 
is
       VAR_COUNT number;
begin
       SELECT COUNT(*) INTO VAR_COUNT
       FROM   EVA_KPI_SCORE
       WHERE  EMPID = IN_EMPID
       AND    EVA_KPI_ID = IN_EVA_KPI_ID
       AND    PA_MONTH = IN_PA_MONTH;
       IF VAR_COUNT > 0 THEN
          UPDATE EVA_KPI_SCORE
                 SET SCORE = IN_SCORE,
                     UPDATED_BY = IN_CREATED_BY,
                     UPDATE_DATE = SYSDATE,
                     DESCRIPTION = IN_DESCRIPTION,
                     VALIDATER_ID = IN_VALIDATER_ID
          WHERE EMPID = IN_EMPID
          AND   EVA_KPI_ID = IN_EVA_KPI_ID
          AND   PA_MONTH = IN_PA_MONTH;
       ELSE
           INSERT INTO EVA_KPI_SCORE(
                  NO,
                  EMPID,
                  EVA_KPI_ID,
                  PA_MONTH,
                  SCORE,
                  ACTIVITY,
                  CREATED_BY,
                  CREATE_DATE,
                  CPNY_ID,
                  DESCRIPTION,
                  VALIDATER_ID)
           VALUES(
                  EVA_KPI_SCORE_SEQ.NEXTVAL,
                  IN_EMPID,
                  IN_EVA_KPI_ID,
                  IN_PA_MONTH,
                  IN_SCORE,
                  1,
                  IN_CREATED_BY,
                  SYSDATE,
                  IN_CPNY_ID,
                  IN_DESCRIPTION,
                  IN_VALIDATER_ID
           );
        END IF;
end EVA_KPI_ADD_KPISCORE;
/

prompt
prompt Creating procedure EVA_REJECT_P
prompt ===============================
prompt
CREATE OR REPLACE PROCEDURE eva_reject_p (
   ev_period_id_i         VARCHAR2,
   ev_emp_id_i            VARCHAR2,
   ev_item_id_i            VARCHAR2,
   ev_emp_type_id         VARCHAR2,
   status_o         OUT   NUMBER
)
IS
   ev_process_id_p   VARCHAR2(50);
   ev_process_id_order NUMBER;
   ev_marks_p        FLOAT;
/******************************************************************************
   NAME:       eva_REJECT_P
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        7/11/2005   Pennix       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     eva_REJECT_P
      Sysdate:         7/11/2005
      Date and Time:   7/11/2005, 10:28:57 PM, and 7/11/2005 10:28:57 PM
      Username:        Pennix (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   status_o := 1;

    SELECT EV_ITEM_PROCESS_ID
      INTO ev_process_id_p
      FROM eva_EMP_ITEM_PROCESS
     WHERE EV_ITEM_ID = ev_item_id_i
       AND EV_EMP_ID = ev_emp_id_i
       AND EV_PERIOD_ID = ev_period_id_i;

   UPDATE eva_MASTER
      SET ev_submitted = NULL
    WHERE ev_period_id = ev_period_id_i
      AND ev_emp_id = ev_emp_id_i
      AND ev_process_id = ev_process_id_p
      AND EV_ITEM_ID = ev_item_id;

  SELECT B.EV_PROCESS_ORDER
    INTO ev_process_id_order
    FROM eva_RELATION A, eva_TYPE_PROCESS B
   WHERE A.EV_PERIOD_ID = B.EV_PERIOD_ID
     AND A.EV_TYPE_ID = B.EV_TYPE_ID
     AND A.EV_PROCESS_ID = B.EV_PROCESS_ID
     AND A.EV_PERIOD_ID = ev_period_id_i
     AND A.EV_TYPE_ID = ev_emp_type_id
     AND a.ev_item_id = ev_item_id_i
     AND B.EV_PROCESS_ID = ev_process_id_p;

  SELECT
         A.EV_PROCESS_ID
    INTO ev_process_id_p
    FROM eva_RELATION A, eva_TYPE_PROCESS B
   WHERE A.EV_PERIOD_ID = B.EV_PERIOD_ID
     AND A.EV_TYPE_ID = B.EV_TYPE_ID
     AND A.EV_PROCESS_ID = B.EV_PROCESS_ID
     AND A.EV_PERIOD_ID = ev_period_id_i
     AND A.EV_TYPE_ID = ev_emp_type_id
     AND a.ev_item_id = ev_item_id_i
     AND B.EV_PROCESS_ORDER =
     (
  SELECT MAX(B.EV_PROCESS_ORDER)
    FROM eva_RELATION A, eva_TYPE_PROCESS B
   WHERE A.EV_PERIOD_ID = B.EV_PERIOD_ID
     AND A.EV_TYPE_ID = B.EV_TYPE_ID
     AND A.EV_PROCESS_ID = B.EV_PROCESS_ID
     AND A.EV_PERIOD_ID = ev_period_id_i
     AND A.EV_TYPE_ID = ev_emp_type_id
     AND a.ev_item_id = ev_item_id_i
     AND B.EV_PROCESS_ORDER < ev_process_id_order
     );

   UPDATE eva_EMP_ITEM_PROCESS
      SET eva_EMP_ITEM_PROCESS.EV_ITEM_PROCESS_ID = ev_process_id_p--,
         -- eva_EMP_ITEM_PROCESS.EV_ITEM_MARK = ev_marks_p
    WHERE eva_EMP_ITEM_PROCESS.EV_PERIOD_ID = ev_period_id_i
      AND eva_EMP_ITEM_PROCESS.EV_EMP_ID = ev_emp_id_i
      AND eva_EMP_ITEM_PROCESS.EV_ITEM_ID = ev_item_id_i;

EXCEPTION
   WHEN OTHERS
   THEN
      status_o := 0;
END eva_reject_p;
/

prompt
prompt Creating procedure EVA_SAVE_P
prompt =============================
prompt
CREATE OR REPLACE PROCEDURE eva_Save_P
(
 EV_PERIOD_ID_I    VARCHAR2,
 EV_EMP_ID_I     VARCHAR2,
 STATUS_O     OUT NUMBER
)
IS
 EV_PROCESS_ID_P    eva_EMP.EV_PROCESS_ID%TYPE;
 EV_TYPE_ID_P    eva_PERIOD_TYPE.EV_TYPE_ID%TYPE;
 EV_MARKS_P      eva_EMP.EV_MARK%TYPE;
 EV_APPEND_P     eva_MASTER.EV_APPEND%TYPE;
 EV_ITEM_PROP_P    eva_RELATION.EV_ITEM_PROP%TYPE;
/******************************************************************************
   NAME:       eva_SUBMIT_P
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        7/11/2005   Pennix       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     eva_SUBMIT_P
      Sysdate:         7/11/2005
      Date and Time:   7/11/2005, 10:28:57 PM, and 7/11/2005 10:28:57 PM
      Username:        Pennix (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
 EV_ITEM_PROP_P:=1; 
 STATUS_O := 1;
 SELECT EV_PROCESS_ID, EV_TYPE_ID INTO EV_PROCESS_ID_P, EV_TYPE_ID_P FROM eva_EMP
  WHERE EV_PERIOD_ID = EV_PERIOD_ID_I AND EV_EMP_ID = EV_EMP_ID_I;
 
 BEGIN
 SELECT ROUND(SUM(EV_ITEM_MARK),2) INTO EV_MARKS_P FROM (
  -- 非“项目分数”的操作方式：针对项目明细进行打分
  SELECT 
     eva_DETAIL_MARK.EV_MARK * eva_ITEM_DETAIL.EV_DETAIL_PROP *0.01* eva_RELATION.EV_PROCESS_PROP*eva_RELATION.EV_ITEM_PROP EV_ITEM_MARK
  FROM eva_DETAIL_MARK
  INNER JOIN eva_ITEM_DETAIL
     ON eva_DETAIL_MARK.SEQ_EV_ITEM_DETAIL = eva_ITEM_DETAIL.SEQ_EV_ITEM_DETAIL
  INNER JOIN eva_EMP
     ON eva_EMP.EV_PERIOD_ID = eva_ITEM_DETAIL.EV_PERIOD_ID
     AND eva_EMP.EV_EMP_ID = eva_ITEM_DETAIL.EV_EMP_ID
  INNER JOIN eva_RELATION
     ON eva_RELATION.EV_PERIOD_ID = eva_EMP.EV_PERIOD_ID
     AND eva_RELATION.EV_TYPE_ID = eva_EMP.EV_TYPE_ID
     AND eva_RELATION.EV_PROCESS_ID = eva_DETAIL_MARK.EV_PROCESS_ID
     AND eva_RELATION.EV_ITEM_ID = eva_ITEM_DETAIL.EV_ITEM_ID
  WHERE eva_EMP.EV_EMP_ID=EV_EMP_ID_I AND eva_EMP.EV_PERIOD_ID=EV_PERIOD_ID_I
    AND eva_RELATION.EV_OPERATE_ID <> 'EVOPERATE006'
 UNION ALL
 -- “项目分数”的操作方式：针对项目进行打分
  SELECT      
     MAX (eva_DETAIL_MARK.EV_MARK * eva_RELATION.EV_PROCESS_PROP*eva_RELATION.EV_ITEM_PROP) EV_ITEM_MARK
  FROM eva_DETAIL_MARK
  INNER JOIN eva_ITEM_DETAIL
     ON eva_DETAIL_MARK.SEQ_EV_ITEM_DETAIL = eva_ITEM_DETAIL.SEQ_EV_ITEM_DETAIL
  INNER JOIN eva_EMP
     ON eva_EMP.EV_PERIOD_ID = eva_ITEM_DETAIL.EV_PERIOD_ID
     AND eva_EMP.EV_EMP_ID = eva_ITEM_DETAIL.EV_EMP_ID
  INNER JOIN eva_RELATION
     ON eva_RELATION.EV_PERIOD_ID = eva_EMP.EV_PERIOD_ID
     AND eva_RELATION.EV_TYPE_ID = eva_EMP.EV_TYPE_ID
     AND eva_RELATION.EV_PROCESS_ID = eva_DETAIL_MARK.EV_PROCESS_ID
     AND eva_RELATION.EV_ITEM_ID = eva_ITEM_DETAIL.EV_ITEM_ID
  WHERE eva_EMP.EV_EMP_ID=EV_EMP_ID_I AND eva_EMP.EV_PERIOD_ID=EV_PERIOD_ID_I
    AND eva_RELATION.EV_OPERATE_ID = 'EVOPERATE006'
GROUP BY eva_ITEM_DETAIL.EV_ITEM_ID, eva_RELATION.EV_PROCESS_ID
     );
   
 --SELECT SUM(EV_ITEM_MARK) INTO EV_MARKS_P FROM eva_item_mark_v
  --   WHERE EV_PERIOD_ID= EV_PERIOD_ID_I  AND EV_EMP_ID= EV_EMP_ID_I
 --    GROUP BY EV_PERIOD_ID,EV_EMP_ID;
   EXCEPTION
       WHEN NO_DATA_FOUND THEN
          EV_MARKS_P:=0;
  WHEN  OTHERS THEN
    EV_MARKS_P:=0;
   END;
   BEGIN
     SELECT EV_ITEM_PROP INTO EV_ITEM_PROP_P FROM
       (
     SELECT * FROM eva_RELATION 
        WHERE EV_PERIOD_ID=EV_PERIOD_ID_I
     AND EV_TYPE_ID=EV_TYPE_ID_P
     AND EV_ITEM_ID='EVITEM001'
     ORDER BY EV_ITEM_PROP DESC
    )
    WHERE ROWNUM=1;
 EXCEPTION
       WHEN NO_DATA_FOUND THEN
          EV_ITEM_PROP_P:=1;
    WHEN  OTHERS THEN
    EV_ITEM_PROP_P:=1;           
   END;
   BEGIN
   SELECT SUM(EV_APPEND)*EV_ITEM_PROP_P INTO EV_APPEND_P FROM eva_MASTER
      WHERE EV_PERIOD_ID= EV_PERIOD_ID_I  AND EV_EMP_ID= EV_EMP_ID_I
     GROUP BY EV_PERIOD_ID,EV_EMP_ID;
   IF EV_APPEND_P IS NULL THEN
      EV_APPEND_P:=0;
   END IF;             
   EXCEPTION
       WHEN NO_DATA_FOUND THEN
          EV_APPEND_P:=0;
  WHEN  OTHERS THEN
    EV_APPEND_P:=0;
   END;

   EV_MARKS_P:=EV_MARKS_P+EV_APPEND_P;

 UPDATE eva_EMP SET  EV_MARK=EV_MARKS_P
  WHERE EV_PERIOD_ID = EV_PERIOD_ID_I
   AND EV_EMP_ID = EV_EMP_ID_I;
 EXCEPTION
  WHEN OTHERS THEN
   STATUS_O := 0;
END eva_Save_P;
/

prompt
prompt Creating procedure EVA_STATUS_P
prompt ===============================
prompt
CREATE OR REPLACE PROCEDURE eva_status_p (
   ev_period_id_i          VARCHAR2,
   ev_emp_id_i             VARCHAR2,
   ev_item_id_i             VARCHAR2,
   ev_process_id_i         VARCHAR2,
   status_o          OUT   NUMBER
)
IS
   ev_marks_p        FLOAT;
   ev_type_id_p         eva_emp.ev_type_id%TYPE;
   ev_process_order_p   eva_type_process.ev_process_order%TYPE;
   ev_process_id_p      eva_type_process.ev_process_id%TYPE;
/******************************************************************************
   NAME:       eva_STATUS_P
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        7/12/2005   Pennix       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     eva_STATUS_P
      Sysdate:         7/12/2005
      Date and Time:   7/12/2005, 5:12:43 PM, and 7/12/2005 5:12:43 PM
      Username:        Pennix (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   status_o := 1;

   SELECT ev_type_id, ev_process_id
     INTO ev_type_id_p, ev_process_id_p
     FROM eva_emp
    WHERE ev_period_id = ev_period_id_i AND ev_emp_id = ev_emp_id_i;

   SELECT ev_process_order
     INTO ev_process_order_p
     FROM eva_type_process
    WHERE ev_period_id = ev_period_id_i
      AND ev_type_id = ev_type_id_p
      AND ev_process_id = ev_process_id_i;

   UPDATE eva_master
      SET ev_submitted = NULL
    WHERE ev_period_id = ev_period_id_i
      AND ev_emp_id = ev_emp_id_i
      AND ev_item_id = ev_item_id_i
      AND ev_process_id IN (
             SELECT ev_process_id
               FROM eva_type_process
              WHERE ev_period_id = ev_period_id_i
                AND ev_type_id = ev_type_id_p
                AND ev_process_order >= ev_process_order_p);

   --DELETE eva_ITEM_PROCESS_MARK
   --WHERE ev_period_id = ev_period_id_i AND ev_emp_id = ev_emp_id_i
  -- AND ev_process_id IN (
   ---          SELECT ev_process_id
   --            FROM eva_type_process
    --          WHERE ev_period_id = ev_period_id_i
    --            AND ev_type_id = ev_type_id_p
    --            AND ev_process_order >= ev_process_order_p);
               
--   UPDATE eva_emp
--      SET ev_process_id = ev_process_id_i
--    WHERE ev_period_id = ev_period_id_i
--      AND ev_emp_id = ev_emp_id_i;
BEGIN
     IF ev_item_id_i = 'EVITEM002' THEN
        SELECT ROUND(SUM(EV_ITEM_MARK),2)
          INTO ev_marks_p
          FROM (
            --业绩项目分数
            SELECT (eva_DETAIL_MARK.EV_MARK * eva_RELATION.EV_PROCESS_PROP*eva_RELATION.EV_ITEM_PROP) EV_ITEM_MARK
              FROM eva_DETAIL_MARK
             INNER JOIN eva_ITEM_DETAIL ON eva_DETAIL_MARK.SEQ_EV_ITEM_DETAIL =
                                           eva_ITEM_DETAIL.SEQ_EV_ITEM_DETAIL
             INNER JOIN eva_EMP ON eva_EMP.EV_PERIOD_ID =
                                   eva_ITEM_DETAIL.EV_PERIOD_ID
                               AND eva_EMP.EV_EMP_ID =
                                   eva_ITEM_DETAIL.EV_EMP_ID
             INNER JOIN eva_RELATION ON eva_RELATION.EV_PERIOD_ID =
                                        eva_EMP.EV_PERIOD_ID
                                    AND eva_RELATION.EV_TYPE_ID =
                                        eva_EMP.EV_TYPE_ID
                                    AND eva_RELATION.EV_PROCESS_ID =
                                        eva_DETAIL_MARK.EV_PROCESS_ID
                                    AND eva_RELATION.EV_ITEM_ID =
                                        eva_ITEM_DETAIL.EV_ITEM_ID
             WHERE eva_EMP.EV_EMP_ID = ev_emp_id_i
               AND eva_EMP.EV_PERIOD_ID = ev_period_id_i
               AND eva_ITEM_DETAIL.EV_ITEM_ID = 'EVITEM002'
               AND eva_RELATION.EV_OPERATE_ID <> 'EVOPERATE006'
               AND eva_DETAIL_MARK.Ev_Process_Id = ev_process_id_i

            UNION ALL

            SELECT (eva_ADD_SUBTRACTION.EV_ITEM_ADD_SUBTRACTION * eva_RELATION.EV_PROCESS_PROP*eva_RELATION.EV_ITEM_PROP) EV_ITEM_MARK
              FROM eva_ADD_SUBTRACTION, eva_RELATION, eva_EMP
             WHERE eva_ADD_SUBTRACTION.EV_ITEM_ID = eva_RELATION.EV_ITEM_ID
               AND eva_ADD_SUBTRACTION.EV_ITEM_PROCESS_ID =
                   eva_RELATION.EV_PROCESS_ID
               AND eva_ADD_SUBTRACTION.EV_PERIOD_ID =
                   eva_RELATION.EV_PERIOD_ID
               AND eva_ADD_SUBTRACTION.EV_EMP_ID = eva_EMP.EV_EMP_ID
               AND eva_ADD_SUBTRACTION.EV_PERIOD_ID = eva_EMP.EV_PERIOD_ID
               AND eva_EMP.EV_EMP_ID = ev_emp_id_i
               AND eva_EMP.EV_PERIOD_ID = ev_period_id_i
               AND eva_ADD_SUBTRACTION.EV_ITEM_ID = 'EVITEM002'
        );

     ELSE
        SELECT ROUND(SUM(EV_ITEM_MARK),2)
          INTO ev_marks_p
          FROM (
          --能力评价分数
           SELECT (
                  eva_DETAIL_MARK.EV_MARK
                  * eva_ITEM_DETAIL.EV_DETAIL_PROP
                  * 0.01
                  * eva_RELATION.EV_PROCESS_PROP
                  * eva_RELATION.EV_ITEM_PROP
                  ) EV_ITEM_MARK
             FROM eva_DETAIL_MARK
            INNER JOIN eva_ITEM_DETAIL ON eva_DETAIL_MARK.SEQ_EV_ITEM_DETAIL = eva_ITEM_DETAIL.SEQ_EV_ITEM_DETAIL
            INNER JOIN eva_EMP ON eva_EMP.EV_PERIOD_ID = eva_ITEM_DETAIL.EV_PERIOD_ID
                              AND eva_EMP.EV_EMP_ID = eva_ITEM_DETAIL.EV_EMP_ID
            INNER JOIN eva_RELATION ON eva_RELATION.EV_PERIOD_ID = eva_EMP.EV_PERIOD_ID
                                   AND eva_RELATION.EV_TYPE_ID = eva_EMP.EV_TYPE_ID
                                   AND eva_RELATION.EV_PROCESS_ID = eva_DETAIL_MARK.EV_PROCESS_ID
                                   AND eva_RELATION.EV_ITEM_ID = eva_ITEM_DETAIL.EV_ITEM_ID
            WHERE eva_EMP.EV_EMP_ID = ev_emp_id_i
              AND eva_EMP.EV_PERIOD_ID = ev_period_id_i
              AND eva_ITEM_DETAIL.EV_ITEM_ID = 'EVITEM003'
              AND eva_RELATION.EV_OPERATE_ID <> 'EVOPERATE006'
              AND eva_DETAIL_MARK.Ev_Process_Id = ev_process_id_i
        );
     END IF;

   --SELECT SUM(EV_ITEM_MARK) INTO EV_MARKS_P FROM eva_item_mark_v
   --   WHERE EV_PERIOD_ID= EV_PERIOD_ID_I  AND EV_EMP_ID= EV_EMP_ID_I
   --    GROUP BY EV_PERIOD_ID,EV_EMP_ID;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ev_marks_p := 0;
      WHEN OTHERS
      THEN
         ev_marks_p := 0;
   END;
   
   ev_marks_p := ROUND(ev_marks_p,2);
   



   UPDATE eva_emp_item_process
      SET eva_emp_item_process.ev_item_process_id = ev_process_id_i--,
          --eva_emp_item_process.ev_item_mark = ev_marks_p
    WHERE eva_emp_item_process.ev_period_id = ev_period_id_i
      AND eva_emp_item_process.ev_emp_id = ev_emp_id_i
      AND eva_emp_item_process.ev_item_id = ev_item_id_i;
      

EXCEPTION
   WHEN OTHERS
   THEN
      status_o := 0;
END eva_status_p;
/

prompt
prompt Creating procedure EVA_SUBMIT_P
prompt ===============================
prompt
CREATE OR REPLACE PROCEDURE eva_Submit_P (
   ev_period_id_i         VARCHAR2,
   ev_emp_id_i            VARCHAR2,
   status_o         OUT   NUMBER
)
IS
   ev_process_id_p   eva_EMP.ev_process_id%TYPE;
   ev_type_id_p      eva_PERIOD_TYPE.ev_type_id%TYPE;
   ev_marks_p        eva_EMP.ev_mark%TYPE;
   ev_append_p       eva_MASTER.ev_append%TYPE;
   ev_item_prop_p    eva_RELATION.ev_item_prop%TYPE;
/******************************************************************************
   NAME:       eva_SUBMIT_P
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        7/11/2005   Pennix       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     eva_SUBMIT_P
      Sysdate:         7/11/2005
      Date and Time:   7/11/2005, 10:28:57 PM, and 7/11/2005 10:28:57 PM
      Username:        Pennix (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   ev_item_prop_p := 1;
   status_o := 1;

   SELECT ev_process_id, ev_type_id
     INTO ev_process_id_p, ev_type_id_p
     FROM eva_EMP
    WHERE ev_period_id = ev_period_id_i AND ev_emp_id = ev_emp_id_i;

   UPDATE eva_MASTER
      SET ev_submitted = 1
    WHERE ev_period_id = ev_period_id_i
      AND ev_emp_id = ev_emp_id_i
      AND ev_process_id = ev_process_id_p;

   SELECT ev_process_id
     INTO ev_process_id_p
     FROM eva_TYPE_PROCESS
    WHERE ev_period_id = ev_period_id_i
      AND ev_type_id = ev_type_id_p
      AND ev_process_order =
               (SELECT ev_process_order
                  FROM eva_TYPE_PROCESS
                 WHERE ev_period_id = ev_period_id_i
                   AND ev_type_id = ev_type_id_p
                   AND ev_process_id = ev_process_id_p)
             + 1;

   BEGIN
      SELECT ROUND(SUM(EV_ITEM_MARK),2)
        INTO ev_marks_p
        FROM (
    -- 非"项目分数"操作方式：针对项目明细打分
     SELECT   eva_DETAIL_MARK.ev_mark
                     * eva_ITEM_DETAIL.ev_detail_prop
                     * 0.01
                     * eva_RELATION.ev_process_prop
                     * eva_RELATION.ev_item_prop ev_item_mark
                FROM eva_DETAIL_MARK INNER JOIN eva_ITEM_DETAIL ON eva_DETAIL_MARK.seq_ev_item_detail =
                                                                     eva_ITEM_DETAIL.seq_ev_item_detail
                     INNER JOIN eva_EMP ON eva_EMP.ev_period_id =
                                                  eva_ITEM_DETAIL.ev_period_id
                                      AND eva_EMP.ev_emp_id =
                                                     eva_ITEM_DETAIL.ev_emp_id
                     INNER JOIN eva_RELATION ON eva_RELATION.ev_period_id =
                                                          eva_EMP.ev_period_id
                                           AND eva_RELATION.ev_type_id =
                                                            eva_EMP.ev_type_id
                                           AND eva_RELATION.ev_process_id =
                                                  eva_DETAIL_MARK.ev_process_id
                                           AND eva_RELATION.ev_item_id =
                                                    eva_ITEM_DETAIL.ev_item_id
               WHERE eva_EMP.ev_emp_id = ev_emp_id_i
                 AND eva_EMP.ev_period_id = ev_period_id_i
     AND eva_RELATION.EV_OPERATE_ID <> 'EVOPERATE006'
   UNION ALL 
     -- "项目分数"操作方式：针对项目打分
     SELECT MAX(eva_DETAIL_MARK.ev_mark
                     * eva_RELATION.ev_process_prop
                     * eva_RELATION.ev_item_prop) ev_item_mark
                FROM eva_DETAIL_MARK INNER JOIN eva_ITEM_DETAIL ON eva_DETAIL_MARK.seq_ev_item_detail =
                                                                     eva_ITEM_DETAIL.seq_ev_item_detail
                     INNER JOIN eva_EMP ON eva_EMP.ev_period_id =
                                                  eva_ITEM_DETAIL.ev_period_id
                                      AND eva_EMP.ev_emp_id =
                                                     eva_ITEM_DETAIL.ev_emp_id
                     INNER JOIN eva_RELATION ON eva_RELATION.ev_period_id =
                                                          eva_EMP.ev_period_id
                                           AND eva_RELATION.ev_type_id =
                                                            eva_EMP.ev_type_id
                                           AND eva_RELATION.ev_process_id =
                                                  eva_DETAIL_MARK.ev_process_id
                                           AND eva_RELATION.ev_item_id =
                                                    eva_ITEM_DETAIL.ev_item_id
               WHERE eva_EMP.ev_emp_id = ev_emp_id_i
                 AND eva_EMP.ev_period_id = ev_period_id_i
     AND eva_RELATION.EV_OPERATE_ID = 'EVOPERATE006'
   GROUP BY eva_ITEM_DETAIL.ev_item_id, eva_RELATION.ev_process_id 
   );
   --SELECT SUM(EV_ITEM_MARK) INTO EV_MARKS_P FROM eva_item_mark_v
   --   WHERE EV_PERIOD_ID= EV_PERIOD_ID_I  AND EV_EMP_ID= EV_EMP_ID_I
   --    GROUP BY EV_PERIOD_ID,EV_EMP_ID;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ev_marks_p := 0;
      WHEN OTHERS
      THEN
         ev_marks_p := 0;
   END;

   BEGIN
      SELECT ev_item_prop
        INTO ev_item_prop_p
        FROM (SELECT   *
                  FROM eva_RELATION
                 WHERE ev_period_id = ev_period_id_i
                   AND ev_type_id = ev_type_id_p
                   AND ev_item_id = 'EVITEM001'
              ORDER BY ev_item_prop DESC)
       WHERE ROWNUM = 1;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ev_item_prop_p := 1;
      WHEN OTHERS
      THEN
         ev_item_prop_p := 1;
   END;

   BEGIN
      SELECT   SUM (ev_append) * ev_item_prop_p
          INTO ev_append_p
          FROM eva_MASTER
         WHERE ev_period_id = ev_period_id_i AND ev_emp_id = ev_emp_id_i
      GROUP BY ev_period_id, ev_emp_id;

      IF ev_append_p IS NULL
      THEN
         ev_append_p := 0;
      END IF;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ev_append_p := 0;
      WHEN OTHERS
      THEN
         ev_append_p := 0;
   END;

   ev_marks_p := ROUND(ev_marks_p + ev_append_p,2);

   UPDATE eva_EMP
      SET ev_process_id = ev_process_id_p,
          ev_mark = ev_marks_p
    WHERE ev_period_id = ev_period_id_i AND ev_emp_id = ev_emp_id_i;
EXCEPTION
   WHEN OTHERS
   THEN
      status_o := 0;
END eva_Submit_P;
/

prompt
prompt Creating procedure EVA_SUBMIT_P_WOORI
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE eva_Submit_P_woori (
   ev_period_id_i         VARCHAR2,
   ev_emp_id_i            VARCHAR2,
   ev_item_id_i            VARCHAR2,
   ev_emp_type_id         VARCHAR2,
   status_o         OUT   NUMBER
)
IS
   ev_process_id_p   VARCHAR2(50);
   ev_process_id_p6  VARCHAR2(50);
   ev_process_id_order NUMBER;
   ev_marks_p        FLOAT;
	 ev_current_operate_id   VARCHAR2(30);
/******************************************************************************
   NAME:       eva_SUBMIT_P
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        7/11/2005   Pennix       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     eva_SUBMIT_P
      Sysdate:         7/11/2005
      Date and Time:   7/11/2005, 10:28:57 PM, and 7/11/2005 10:28:57 PM
      Username:        Pennix (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   status_o := 1;

    SELECT EV_ITEM_PROCESS_ID,EV_ITEM_PROCESS_ID
      INTO ev_process_id_p,ev_process_id_p6
      FROM eva_EMP_ITEM_PROCESS
     WHERE EV_ITEM_ID = ev_item_id_i
       AND EV_EMP_ID = ev_emp_id_i
       AND EV_PERIOD_ID = ev_period_id_i;

   UPDATE eva_MASTER
      SET ev_submitted = 1
    WHERE ev_period_id = ev_period_id_i
      AND ev_emp_id = ev_emp_id_i
      AND ev_process_id = ev_process_id_p
      AND EV_ITEM_ID = ev_item_id_i;

  SELECT B.EV_PROCESS_ORDER
    INTO ev_process_id_order
    FROM eva_RELATION A, eva_TYPE_PROCESS B
   WHERE A.EV_PERIOD_ID = B.EV_PERIOD_ID
     AND A.EV_TYPE_ID = B.EV_TYPE_ID
     AND A.EV_PROCESS_ID = B.EV_PROCESS_ID
     AND A.EV_PERIOD_ID = ev_period_id_i
     AND A.EV_TYPE_ID = ev_emp_type_id
     AND a.ev_item_id = ev_item_id_i
     AND B.EV_PROCESS_ID = ev_process_id_p;

  SELECT
         A.EV_PROCESS_ID
    INTO ev_process_id_p
    FROM eva_RELATION A, eva_TYPE_PROCESS B
   WHERE A.EV_PERIOD_ID = B.EV_PERIOD_ID
     AND A.EV_TYPE_ID = B.EV_TYPE_ID
     AND A.EV_PROCESS_ID = B.EV_PROCESS_ID
     AND A.EV_PERIOD_ID = ev_period_id_i
     AND A.EV_TYPE_ID = ev_emp_type_id
     AND a.ev_item_id = ev_item_id_i
     AND B.EV_PROCESS_ORDER =
     (
  SELECT MIN(B.EV_PROCESS_ORDER)
    FROM eva_RELATION A, eva_TYPE_PROCESS B
   WHERE A.EV_PERIOD_ID = B.EV_PERIOD_ID
     AND A.EV_TYPE_ID = B.EV_TYPE_ID
     AND A.EV_PROCESS_ID = B.EV_PROCESS_ID
     AND A.EV_PERIOD_ID = ev_period_id_i
     AND A.EV_TYPE_ID = ev_emp_type_id
     AND a.ev_item_id = ev_item_id_i
     AND B.EV_PROCESS_ORDER > ev_process_id_order
     );

   BEGIN
     IF ev_item_id_i = 'EVITEM002' THEN
        SELECT ROUND(SUM(EV_ITEM_MARK),2)
          INTO ev_marks_p
          FROM (
            --业绩项目分数
            SELECT (eva_DETAIL_MARK.EV_MARK * eva_RELATION.EV_PROCESS_PROP*eva_RELATION.EV_ITEM_PROP) EV_ITEM_MARK
              FROM eva_DETAIL_MARK
             INNER JOIN eva_ITEM_DETAIL ON eva_DETAIL_MARK.SEQ_EV_ITEM_DETAIL =
                                           eva_ITEM_DETAIL.SEQ_EV_ITEM_DETAIL
             INNER JOIN eva_EMP ON eva_EMP.EV_PERIOD_ID =
                                   eva_ITEM_DETAIL.EV_PERIOD_ID
                               AND eva_EMP.EV_EMP_ID =
                                   eva_ITEM_DETAIL.EV_EMP_ID
             INNER JOIN eva_RELATION ON eva_RELATION.EV_PERIOD_ID =
                                        eva_EMP.EV_PERIOD_ID
                                    AND eva_RELATION.EV_TYPE_ID =
                                        eva_EMP.EV_TYPE_ID
                                    AND eva_RELATION.EV_PROCESS_ID =
                                        eva_DETAIL_MARK.EV_PROCESS_ID
                                    AND eva_RELATION.EV_ITEM_ID =
                                        eva_ITEM_DETAIL.EV_ITEM_ID
             WHERE eva_EMP.EV_EMP_ID = ev_emp_id_i
               AND eva_EMP.EV_PERIOD_ID = ev_period_id_i
               AND eva_ITEM_DETAIL.EV_ITEM_ID = 'EVITEM002'
               AND eva_RELATION.EV_OPERATE_ID <> 'EVOPERATE006'

            UNION ALL

            SELECT (eva_ADD_SUBTRACTION.EV_ITEM_ADD_SUBTRACTION * eva_RELATION.EV_PROCESS_PROP*eva_RELATION.EV_ITEM_PROP) EV_ITEM_MARK
              FROM eva_ADD_SUBTRACTION, eva_RELATION, eva_EMP
             WHERE eva_ADD_SUBTRACTION.EV_ITEM_ID = eva_RELATION.EV_ITEM_ID
               AND eva_ADD_SUBTRACTION.EV_ITEM_PROCESS_ID =
                   eva_RELATION.EV_PROCESS_ID
               AND eva_ADD_SUBTRACTION.EV_PERIOD_ID =
                   eva_RELATION.EV_PERIOD_ID
               AND eva_ADD_SUBTRACTION.EV_EMP_ID = eva_EMP.EV_EMP_ID
               AND eva_ADD_SUBTRACTION.EV_PERIOD_ID = eva_EMP.EV_PERIOD_ID
               AND eva_EMP.EV_EMP_ID = ev_emp_id_i
               AND eva_EMP.EV_PERIOD_ID = ev_period_id_i
               AND eva_ADD_SUBTRACTION.EV_ITEM_ID = 'EVITEM002'
        );

     ELSE
     --20090731 zengaiwu 明细查看 分数 一次评价结束后只要统计一次评价的分数
        IF  ev_process_id_p6  = 'EVPROCESS006' THEN 
                SELECT ROUND(SUM(EV_ITEM_MARK),2)
                  INTO ev_marks_p
                  FROM (
                  --能力评价分数
                   SELECT (
                          eva_DETAIL_MARK.EV_MARK
                          * eva_ITEM_DETAIL.EV_DETAIL_PROP
                          * 0.01
                          * eva_RELATION.EV_PROCESS_PROP
                          * eva_RELATION.EV_ITEM_PROP
                          ) EV_ITEM_MARK
                     FROM eva_DETAIL_MARK
                    INNER JOIN eva_ITEM_DETAIL ON eva_DETAIL_MARK.SEQ_EV_ITEM_DETAIL = eva_ITEM_DETAIL.SEQ_EV_ITEM_DETAIL
                    INNER JOIN eva_EMP ON eva_EMP.EV_PERIOD_ID = eva_ITEM_DETAIL.EV_PERIOD_ID
                                      AND eva_EMP.EV_EMP_ID = eva_ITEM_DETAIL.EV_EMP_ID
                    INNER JOIN eva_RELATION ON eva_RELATION.EV_PERIOD_ID = eva_EMP.EV_PERIOD_ID
                                           AND eva_RELATION.EV_TYPE_ID = eva_EMP.EV_TYPE_ID
                                           AND eva_RELATION.EV_PROCESS_ID = eva_DETAIL_MARK.EV_PROCESS_ID
                                           AND eva_RELATION.EV_ITEM_ID = eva_ITEM_DETAIL.EV_ITEM_ID
                    WHERE eva_EMP.EV_EMP_ID = ev_emp_id_i
                      AND eva_EMP.EV_PERIOD_ID = ev_period_id_i
                      AND eva_ITEM_DETAIL.EV_ITEM_ID = 'EVITEM003'
                      AND eva_DETAIL_MARK.EV_PROCESS_ID = 'EVPROCESS006'
                );
         else
              SELECT ROUND(SUM(EV_ITEM_MARK),2)
                  INTO ev_marks_p
                  FROM (
                  --能力评价分数
                   SELECT (
                          eva_DETAIL_MARK.EV_MARK
                          * eva_ITEM_DETAIL.EV_DETAIL_PROP
                          * 0.01
                          * eva_RELATION.EV_PROCESS_PROP
                          * eva_RELATION.EV_ITEM_PROP
                          ) EV_ITEM_MARK
                     FROM eva_DETAIL_MARK
                    INNER JOIN eva_ITEM_DETAIL ON eva_DETAIL_MARK.SEQ_EV_ITEM_DETAIL = eva_ITEM_DETAIL.SEQ_EV_ITEM_DETAIL
                    INNER JOIN eva_EMP ON eva_EMP.EV_PERIOD_ID = eva_ITEM_DETAIL.EV_PERIOD_ID
                                      AND eva_EMP.EV_EMP_ID = eva_ITEM_DETAIL.EV_EMP_ID
                    INNER JOIN eva_RELATION ON eva_RELATION.EV_PERIOD_ID = eva_EMP.EV_PERIOD_ID
                                           AND eva_RELATION.EV_TYPE_ID = eva_EMP.EV_TYPE_ID
                                           AND eva_RELATION.EV_PROCESS_ID = eva_DETAIL_MARK.EV_PROCESS_ID
                                           AND eva_RELATION.EV_ITEM_ID = eva_ITEM_DETAIL.EV_ITEM_ID
                    WHERE eva_EMP.EV_EMP_ID = ev_emp_id_i
                      AND eva_EMP.EV_PERIOD_ID = ev_period_id_i
                      AND eva_ITEM_DETAIL.EV_ITEM_ID = 'EVITEM003'
                      AND eva_RELATION.EV_OPERATE_ID <> 'EVOPERATE006'
                );
         end if ;
     END IF;

   --SELECT SUM(EV_ITEM_MARK) INTO EV_MARKS_P FROM eva_item_mark_v
   --   WHERE EV_PERIOD_ID= EV_PERIOD_ID_I  AND EV_EMP_ID= EV_EMP_ID_I
   --    GROUP BY EV_PERIOD_ID,EV_EMP_ID;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ev_marks_p := 0;
      WHEN OTHERS
      THEN
         ev_marks_p := 0;
   END;

   ev_marks_p := ROUND(ev_marks_p,2);
	 
	
SELECT eva_RELATION.EV_OPERATE_ID
  INTO ev_current_operate_id
	FROM eva_RELATION
 WHERE eva_RELATION.EV_PERIOD_ID = ev_period_id_i
	 AND eva_RELATION.EV_ITEM_ID = ev_item_id_i
	 AND eva_RELATION.EV_TYPE_ID =
			 (SELECT EE.EV_TYPE_ID
					FROM eva_EMP EE
				 WHERE EE.EV_PERIOD_ID = ev_period_id_i
					 AND EE.EV_EMP_ID = ev_emp_id_i)
	 AND eva_RELATION.EV_PROCESS_ID =
			 (SELECT EV_ITEM_PROCESS_ID
					FROM eva_EMP_ITEM_PROCESS
				 WHERE EV_ITEM_ID = ev_item_id_i
					 AND EV_EMP_ID = ev_emp_id_i
					 AND EV_PERIOD_ID = ev_period_id_i);
		 
IF ev_current_operate_id = 'EVOPERATE009' THEN
   UPDATE eva_EMP_ITEM_PROCESS
      SET eva_EMP_ITEM_PROCESS.EV_ITEM_PROCESS_ID = ev_process_id_p,
          eva_EMP_ITEM_PROCESS.EV_ITEM_MARK = ev_marks_p
    WHERE eva_EMP_ITEM_PROCESS.EV_PERIOD_ID = ev_period_id_i
      AND eva_EMP_ITEM_PROCESS.EV_EMP_ID = ev_emp_id_i
      AND eva_EMP_ITEM_PROCESS.EV_ITEM_ID = ev_item_id_i;
ELSE 
   UPDATE eva_EMP_ITEM_PROCESS
	    SET eva_EMP_ITEM_PROCESS.EV_ITEM_PROCESS_ID = ev_process_id_p
    WHERE eva_EMP_ITEM_PROCESS.EV_PERIOD_ID = ev_period_id_i
      AND eva_EMP_ITEM_PROCESS.EV_EMP_ID = ev_emp_id_i
      AND eva_EMP_ITEM_PROCESS.EV_ITEM_ID = ev_item_id_i;     
END IF;

EXCEPTION
   WHEN OTHERS
   THEN
      status_o := 0;
END eva_Submit_P_woori;
/

prompt
prompt Creating procedure EVJ_DEPT_FILL_P
prompt ==================================
prompt
CREATE OR REPLACE PROCEDURE evj_dept_fill_p (
   ev_period_id_i         VARCHAR2,
   status_o         OUT   NUMBER
)
IS
   ev_period_id_p      NUMBER;
   ev_period_edate_p   DATE;
/******************************************************************************
   NAME:       EVJ_DEPT_FILL_P
   PURPOSE:
   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        7/11/2005   Pennix       1. Created this procedure.
   NOTES:
   Automatically available Auto Replace Keywords:
      Object Name:     EVJ_DEPT_FILL_P
      Sysdate:         7/11/2005
      Date and Time:   7/11/2005, 2:33:50 PM, and 7/11/2005 2:33:50 PM
      Username:        Pennix (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   status_o := 1;
   SELECT ev_period_id
     INTO ev_period_id_p
     FROM evj_period
    WHERE ev_period_id = ev_period_id_i;
   SELECT ev_period_edate
     INTO ev_period_edate_p
     FROM evj_period_v
    WHERE ev_period_id = ev_period_id_p;
   IF ev_period_edate_p > SYSDATE
   THEN
      BEGIN
         BEGIN
            DELETE FROM evj_dept
                  WHERE ev_dept_id NOT IN (SELECT deptid
                                             FROM hr_department)
                    AND ev_period_id = ev_period_id_p;
         EXCEPTION
            WHEN OTHERS
            THEN
               status_o := 0;
         END;
         UPDATE evj_dept
            SET ev_dept_name = (SELECT deptname
                                  FROM hr_department
                                 WHERE deptid = evj_dept.ev_dept_id)
          WHERE ev_period_id = ev_period_id_p;
         UPDATE evj_dept
            SET ev_dept_level = (SELECT dept_level
                                   FROM hr_department
                                  WHERE deptid = evj_dept.ev_dept_id)
          WHERE ev_period_id = ev_period_id_p;
         UPDATE evj_dept
            SET ev_parent_dept_id = (SELECT parent_dept_id
                                       FROM hr_department
                                      WHERE deptid = evj_dept.ev_dept_id)
          WHERE ev_period_id = ev_period_id_p;
         INSERT INTO evj_dept
                     (ev_period_id, ev_dept_id, ev_dept_name, ev_dept_level,
                      ev_parent_dept_id)
            SELECT ev_period_id_p, deptid, deptname, dept_level,
                   parent_dept_id
              FROM hr_department
             WHERE deptid NOT IN (SELECT ev_dept_id
                                    FROM evj_dept
                                   WHERE ev_period_id = ev_period_id_p);
         UPDATE evj_dept ed1
            SET ed1.ev_dept_norm =
                   (SELECT ed2.ev_dept_norm
                      FROM evj_dept ed2
                     WHERE ed2.ev_dept_id = ed1.ev_dept_id
                       AND TO_NUMBER (SUBSTR (ed2.ev_period_id, 1, 4)) =
                                TO_NUMBER (SUBSTR (ed1.ev_period_id, 1, 4))- 1
                       AND SUBSTR (ed2.ev_period_id, 5, 2) = SUBSTR (ed1.ev_period_id, 5, 2))
          WHERE ev_period_id = ev_period_id_p;
         UPDATE evj_dept
            SET ev_dept_norm = 0
          WHERE ev_dept_norm IS NULL AND ev_period_id = ev_period_id_p;
         UPDATE evj_dept ed1
            SET ed1.activity =
                   (SELECT ed2.activity
                      FROM evj_dept ed2
                     WHERE ed2.ev_dept_id = ed1.ev_dept_id
                       AND TO_NUMBER (SUBSTR (ed2.ev_period_id, 1, 4)) =
                                TO_NUMBER (SUBSTR (ed1.ev_period_id, 1, 4))
                                - 1
                       AND SUBSTR (ed2.ev_period_id, 5, 2) =
                                               SUBSTR (ed1.ev_period_id, 5, 2))
          WHERE ev_period_id = ev_period_id_p;
         UPDATE evj_dept
            SET activity = 1
          WHERE activity IS NULL AND ev_period_id = ev_period_id_p;
      END;
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      status_o := 0;
END evj_dept_fill_p;
/

prompt
prompt Creating procedure EVJ_PROCESS_SUBMIT_P
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE evj_process_submit_p (
   ev_period_id_i         VARCHAR2,
   ev_emp_id_i            VARCHAR2,
   status_o         OUT   NUMBER
)
IS
   ev_process_id_p   evj_emp.ev_process_id%TYPE;
   ev_type_id_p      evj_period_type.ev_type_id%TYPE;
/******************************************************************************
   NAME:       EVS_SUBMIT_P
   PURPOSE:

   Automatically available Auto Replace Keywords:
      Object Name:     EVS_SUBMIT_P
      Sysdate:         7/11/2005
      Date and Time:   7/11/2005, 10:28:57 PM, and 7/11/2005 10:28:57 PM
      Username:        Pennix (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   status_o := 1;

   SELECT ev_process_id, ev_type_id
     INTO ev_process_id_p, ev_type_id_p
     FROM evj_emp
    WHERE ev_period_id = ev_period_id_i AND ev_emp_id = ev_emp_id_i;

   UPDATE evj_master
      SET ev_submitted = 1
    WHERE ev_period_id = ev_period_id_i
      AND ev_emp_id = ev_emp_id_i
      AND ev_process_id = ev_process_id_p;

   SELECT ev_process_id
     INTO ev_process_id_p
     FROM evj_type_process
    WHERE ev_period_id = ev_period_id_i
      AND ev_type_id = ev_type_id_p
      AND ev_process_order =
               (SELECT ev_process_order
                  FROM evj_type_process
                 WHERE ev_period_id = ev_period_id_i
                   AND ev_type_id = ev_type_id_p
                   AND ev_process_id = ev_process_id_p)
             + 1;

   UPDATE evj_emp
      SET ev_process_id = ev_process_id_p
    WHERE ev_period_id = ev_period_id_i AND ev_emp_id = ev_emp_id_i;
EXCEPTION
   WHEN OTHERS
   THEN
      status_o := 0;
END evj_process_submit_p;
/

prompt
prompt Creating procedure EVJ_STATUS_P
prompt ===============================
prompt
CREATE OR REPLACE PROCEDURE evj_status_p (
   ev_period_id_i          VARCHAR2,
   ev_emp_id_i             VARCHAR2,
   ev_process_id_i         VARCHAR2,
   status_o          OUT   NUMBER
)
IS
   ev_type_id_p         evj_emp.ev_type_id%TYPE;
   ev_process_order_p   evj_type_process.ev_process_order%TYPE;
   ev_process_id_p      evj_type_process.ev_process_id%TYPE;
/******************************************************************************
   NAME:       EVj_STATUS_P
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        7/12/2005   Pennix       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     EVS_STATUS_P
      Sysdate:         7/12/2005
      Date and Time:   7/12/2005, 5:12:43 PM, and 7/12/2005 5:12:43 PM
      Username:        Pennix (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   status_o := 1;

   SELECT ev_type_id, ev_process_id
     INTO ev_type_id_p, ev_process_id_p
     FROM evj_emp
    WHERE ev_period_id = ev_period_id_i AND ev_emp_id = ev_emp_id_i;

   SELECT ev_process_order
     INTO ev_process_order_p
     FROM evj_type_process
    WHERE ev_period_id = ev_period_id_i
      AND ev_type_id = ev_type_id_p
      AND ev_process_id = ev_process_id_i;

   UPDATE evj_master
      SET ev_submitted = NULL
    WHERE ev_period_id = ev_period_id_i
      AND ev_emp_id = ev_emp_id_i
      AND ev_process_id IN (
             SELECT ev_process_id
               FROM evj_type_process
              WHERE ev_period_id = ev_period_id_i
                AND ev_type_id = ev_type_id_p
                AND ev_process_order >= ev_process_order_p);

   UPDATE evj_emp
      SET ev_process_id = ev_process_id_i
    WHERE ev_period_id = ev_period_id_i AND ev_emp_id = ev_emp_id_i;
EXCEPTION
   WHEN OTHERS
   THEN
      status_o := 0;
END evj_status_p;
/

prompt
prompt Creating procedure EVJ_SUBMIT_P
prompt ===============================
prompt
CREATE OR REPLACE PROCEDURE evj_submit_p (
   ev_period_id_i          VARCHAR2,
   ev_dept_id_i            VARCHAR2,
   ev_master_i             VARCHAR2,
   ev_type_id_i            VARCHAR2,
   ev_process_id_i         VARCHAR2,
   submitted_o       OUT   NUMBER,
   unsubmitted_o     OUT   NUMBER,
   status_o          OUT   NUMBER
)
IS
   cnt           NUMBER;
   ev_emp_id_p   evj_emp.ev_emp_id%TYPE;
   ev_mark_p     FLOAT;

/******************************************************************************
   NAME:       EVJ_SUBMIT_P
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        8/23/2005   Pennix       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     EVJ_SUBMIT_P
      Sysdate:         8/23/2005
      Date and Time:   8/23/2005, 9:24:03 AM, and 8/23/2005 9:24:03 AM
      Username:        Pennix (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
   CURSOR cur_emp
   IS
      SELECT DISTINCT evj_master.ev_emp_id
                 FROM evj_master, evj_emp
                WHERE evj_master.ev_period_id = ev_period_id_i
                  AND evj_master.ev_master = ev_master_i
                  AND evj_master.ev_process_id = ev_process_id_i
                  AND evj_master.ev_period_id = evj_emp.ev_period_id
                  AND evj_master.ev_emp_id = evj_emp.ev_emp_id
                  AND evj_emp.ev_type_id = ev_type_id_i;

   CURSOR cur_dept
   IS
      SELECT DISTINCT evj_master.ev_emp_id
                 FROM evj_master, hr_employee, evj_emp
                WHERE evj_master.ev_period_id = ev_period_id_i
                  AND evj_master.ev_master = ev_master_i
                  AND evj_master.ev_process_id = ev_process_id_i
                  AND evj_master.ev_period_id = evj_emp.ev_period_id
                  AND evj_master.ev_emp_id = evj_emp.ev_emp_id
                  AND evj_emp.ev_type_id = ev_type_id_i
                  AND evj_master.ev_emp_id = hr_employee.empid
                  AND hr_employee.deptid IN (
                                        SELECT     deptid
                                              FROM hr_department
                                        START WITH deptid = ev_dept_id_i
                                        CONNECT BY PRIOR deptid =
                                                                parent_dept_id);
BEGIN
   submitted_o := 0;
   unsubmitted_o := 0;
   status_o := 1;
   cnt := 0;

   IF ev_dept_id_i IS NULL
   THEN
      OPEN cur_emp;
   ELSE
      OPEN cur_dept;
   END IF;

   LOOP
      IF ev_dept_id_i IS NULL
      THEN
         BEGIN
            FETCH cur_emp
             INTO ev_emp_id_p;

            EXIT WHEN cur_emp%NOTFOUND;
         END;
      ELSE
         BEGIN
            FETCH cur_dept
             INTO ev_emp_id_p;

            EXIT WHEN cur_dept%NOTFOUND;
         END;
      END IF;

      --DBMS_OUTPUT.PUT_LINE('EV_EMP_ID_P:' || EV_EMP_ID_P);
      SELECT COUNT (0)
        INTO cnt
        FROM evj_master
       WHERE ev_period_id = ev_period_id_i
         AND ev_master = ev_master_i
         AND ev_process_id = ev_process_id_i
         AND ev_emp_id = ev_emp_id_p
         AND ev_mark IS NULL;

      IF cnt = 0
      THEN
         BEGIN
            submitted_o := submitted_o + 1;

            UPDATE evj_master
               SET ev_submitted = 1
             WHERE ev_period_id = ev_period_id_i
               AND ev_master = ev_master_i
               AND ev_process_id = ev_process_id_i
               AND ev_emp_id = ev_emp_id_p;

            SELECT NVL (SUM (  evj_relation.ev_process_prop
                             * evj_relation.ev_item_prop
                             * evj_master.ev_mark
                            ),
                        0
                       )
              INTO ev_mark_p
              FROM evj_master, evj_relation, evj_emp
             WHERE evj_master.ev_emp_id = evj_emp.ev_emp_id
               AND evj_master.ev_period_id = evj_emp.ev_period_id
               AND evj_master.ev_process_id = evj_relation.ev_process_id
               AND evj_master.ev_item_id = evj_relation.ev_item_id
               AND evj_emp.ev_type_id = evj_relation.ev_type_id
               AND evj_master.ev_submitted = 1
               AND evj_master.ev_mark IS NOT NULL
               AND evj_master.ev_period_id = ev_period_id_i
               AND evj_master.ev_emp_id = ev_emp_id_p;

            UPDATE evj_emp
               SET ev_mark = ev_mark_p
             WHERE ev_period_id = ev_period_id_i AND ev_emp_id = ev_emp_id_p;

            COMMIT;
            cnt := 0;

            SELECT COUNT (0)
              INTO cnt
              FROM evj_master
             WHERE ev_period_id = ev_period_id_i
               AND ev_process_id = ev_process_id_i
               AND ev_emp_id = ev_emp_id_p
               AND NVL (ev_submitted, 0) <> 1;

            IF cnt = 0
            THEN
               UPDATE evj_emp
                  SET ev_process_id =
                         (SELECT ev_process_id
                            FROM evj_type_process
                           WHERE ev_period_id = ev_period_id_i
                             AND ev_type_id = evj_emp.ev_type_id
                             AND ev_process_order =
                                      (SELECT ev_process_order
                                         FROM evj_type_process etp
                                        WHERE etp.ev_period_id =
                                                                ev_period_id_i
                                          AND etp.ev_process_id =
                                                         evj_emp.ev_process_id
                                          AND etp.ev_type_id =
                                                            evj_emp.ev_type_id)
                                    + 1)
                WHERE ev_period_id = ev_period_id_i
                      AND ev_emp_id = ev_emp_id_p;
            END IF;
         END;
      ELSE
         BEGIN
            status_o := 2;                             --有被評價者分數未保存
            --DBMS_OUTPUT.PUT_LINE('STATUS_O:' || STATUS_O);
            unsubmitted_o := unsubmitted_o + 1;
         END;
      END IF;
   END LOOP;

   IF ev_dept_id_i IS NULL
   THEN
      CLOSE cur_emp;
   ELSE
      CLOSE cur_dept;
   END IF;
EXCEPTION
   WHEN OTHERS
   THEN
      status_o := 0;
END evj_submit_p;
/

prompt
prompt Creating procedure GET_INSTORAGE_SERIAL_NUM
prompt ===========================================
prompt
CREATE OR REPLACE PROCEDURE GET_INSTORAGE_SERIAL_NUM (
  LSHID OUT VARCHAR2
)
AUTHID CURRENT_USER
IS
  inPrefix VARCHAR2(10);
  inDateFormat VARCHAR2(20);
  inOrderNumber NUMBER(10);
BEGIN
  select PREFIX,MIDDLE_FIELD,NUM_LENGTH into inPrefix,inDateFormat,inOrderNumber from SY_SERIAL_NUM
  where ORDER_ID = 'INSTORAGE_ID';
  
  select inPrefix||to_char(sysdate, inDateFormat)||lpad(SY_INSTORAGE_SERIAL_SEQ.NEXTVAL, inOrderNumber, 0) into LSHID from dual;
END GET_INSTORAGE_SERIAL_NUM;
/

prompt
prompt Creating procedure GET_PURCHASE_SERIAL_NUM
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE GET_PURCHASE_SERIAL_NUM (
  LSHID OUT VARCHAR2
)
AUTHID CURRENT_USER
IS
  inPrefix VARCHAR2(10);
  inDateFormat VARCHAR2(20);
  inOrderNumber NUMBER(10);
BEGIN
  select PREFIX,MIDDLE_FIELD,NUM_LENGTH into inPrefix,inDateFormat,inOrderNumber from SY_SERIAL_NUM
    where ORDER_ID = 'PURCHASE_ID';
  select inPrefix || to_char(sysdate, inDateFormat) || lpad(SY_PURCHASE_SERIAL_SEQ.NEXTVAL, inOrderNumber, 0) into LSHID from dual;
END GET_PURCHASE_SERIAL_NUM;
/

prompt
prompt Creating procedure GET_SALE_SERIAL_NUM
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE GET_SALE_SERIAL_NUM (
  LSHID OUT VARCHAR2
)
AUTHID CURRENT_USER
IS
  inPrefix VARCHAR2(10);
  inDateFormat VARCHAR2(20);
  inOrderNumber NUMBER(10);
BEGIN
  select PREFIX,MIDDLE_FIELD,NUM_LENGTH into inPrefix,inDateFormat,inOrderNumber from SY_SERIAL_NUM
    where ORDER_ID = 'SALES_ID';
  select inPrefix || to_char(sysdate, inDateFormat) || lpad(SY_SALES_SERIAL_SEQ.NEXTVAL, inOrderNumber, 0) into LSHID from dual;
END GET_SALE_SERIAL_NUM;
/

prompt
prompt Creating procedure HR_DELETE_EMPLOYEE
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE hr_delete_employee (inempid VARCHAR2)
IS
   tmpvar   NUMBER;
/******************************************************************************
   NAME:       HR_DELETE_EMPLOYEE
   PURPOSE:    删除测试数据。

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2005-1-23    chengwei      1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     HR_DELETE_EMPLOYEE
      Sysdate:         2005-1-23
      Date and Time:   2005-1-23, 15:28:41, and 2005-1-23 15:28:41
      Username:         (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   tmpvar := 0;

   DELETE      sy_admin
         WHERE adminid = inempid;

--    DELETE PA_EMP_SPECIAL_BONUS WHERE EMPID = INEMPID;
--    DELETE PA_EMP_SIGN_BONUS WHERE EMPID = INEMPID;
--    DELETE PA_EMP_SALARY WHERE EMPID = INEMPID;
--
--    DELETE PA_EMP_QUAL_ALLW WHERE EMPID = INEMPID;
--    DELETE PA_EMP_OT_ALLW WHERE EMPID = INEMPID;
--    DELETE PA_EMP_OTHER_INCOME WHERE EMPID = INEMPID;
--    DELETE PA_EMP_INSR_PRSNL WHERE EMPID = INEMPID;
--
--    DELETE PA_EMP_INSR_CNPY WHERE EMPID = INEMPID;
--    DELETE PA_EMP_DUTY_ALLW WHERE EMPID = INEMPID;
--    DELETE PA_EMP_AWARD WHERE EMPID = INEMPID;
--    DELETE PA_DEDUCTION WHERE EMPID = INEMPID;
   DELETE      hr_work_experience
         WHERE empid = inempid;

   DELETE      hr_upgrade_history
         WHERE empid = inempid;

   DELETE      hr_suspension
         WHERE empid = inempid;

   DELETE      hr_reward
         WHERE empid = inempid;

   DELETE      hr_resignation
         WHERE empid = inempid;

   DELETE      hr_qualification
         WHERE empid = inempid;

   DELETE      hr_punishment
         WHERE empid = inempid;

   DELETE      hr_probation
         WHERE empid = inempid;

   DELETE      hr_personal_info
         WHERE empid = inempid;

   DELETE      hr_military_service
         WHERE empid = inempid;

   DELETE      hr_language_level
         WHERE empid = inempid;

   DELETE      hr_health
         WHERE empid = inempid;

   DELETE      hr_file
         WHERE empid = inempid;

   DELETE      hr_family
         WHERE empid = inempid;

   DELETE      hr_experience_inside
         WHERE empid = inempid;

   --DELETE      hr_emp_binary_photo
    --     WHERE empid = inempid;

   DELETE      hr_education
         WHERE empid = inempid;

   DELETE      hr_contract
         WHERE empid = inempid;

   DELETE      ar_supervisor_info
         WHERE ar_supervisor_id = inempid;

--    DELETE AR_EMP_SHIFT WHERE EMPID = INEMPID;
--
--    DELETE AR_EMP_OT WHERE EMPID = INEMPID;
--    DELETE AR_EMP_LEAVE_EARLY WHERE EMPID = INEMPID;
--    DELETE AR_EMP_LEAVE WHERE EMPID = INEMPID;
--    DELETE AR_EMP_LATE WHERE EMPID = INEMPID;
--    DELETE AR_CARD_INFO WHERE EMPID = INEMPID;
--    DELETE AR_ANNUAL_HOLIDAY WHERE EMPID = INEMPID;
--    DELETE AR_ABSENCE WHERE EMPID = INEMPID;
   DELETE      hr_employee
         WHERE empid = inempid;

   COMMIT;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      NULL;
   WHEN OTHERS
   THEN
      -- Consider logging the error and then re-raise
      RAISE;
END hr_delete_employee;
/

prompt
prompt Creating procedure HR_PROBATION_FINISH
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE hr_probation_finish
IS
/******************************************************************************
   NAME:       HR_PROBATION_FINISH
   PURPOSE:    将预转正日期为当天的员工作转正处理

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        04/02/2006   Pennix       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     HR_PROBATION_FINISH
      Sysdate:         04/02/2006
      Date and Time:   04/02/2006, 16:58:30, and 04/02/2006 16:58:30
      Username:        Pennix (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   UPDATE hr_employee
      SET status_code = 'Status01'
    WHERE empid IN (SELECT empid
                      FROM hr_probation
                     WHERE schedule_probation_date <= SYSDATE AND activity = 0);

   UPDATE hr_probation
      SET probation_date = schedule_probation_date,
          activity = 1
    WHERE schedule_probation_date <= SYSDATE AND activity = 0;
EXCEPTION
   WHEN OTHERS
   THEN
      NULL;
END hr_probation_finish;
/

prompt
prompt Creating procedure HR_UPDATE_AUTO
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE HR_UPDATE_AUTO AS
  /*
   更新即将生效发令，JOB每日执行一次
  */

  /********CC所改的部分********/
       STATUS_CODE_PRE    VARCHAR2(20);   --员工原来的状态
       STATUS_CODE_NOW    VARCHAR2(20);   --调令申请审核通过后的状态
       POST_ID_PRE        VARCHAR2(20);   --员工原来的职位ID
       DEPTID_PRE         VARCHAR2(20);   --员工原来的部门编号
       DEPTID_NOW         VARCHAR2(20);   --调令的部门编号
       POST_ID_NOW        VARCHAR2(20);   --员工申请审核通过后的职位ID
       POST_LEVEL_ID_PRE  VARCHAR2(20);   --员工原来的职位等级ID
       POST_LEVEL_ID_NOW  VARCHAR2(20);   --员工申请审核通过后的职位等级ID
       EMPID_NOW          VARCHAR2(20);   --员工ID
       TO_TIME            DATE;           --结束时间
  /********CC所改的部分********/

BEGIN
  -- |  调动  | 转正  | 晋升  |  转职  |  停职  |  再入职
  FOR SETEMP IN (SELECT T.*
                   FROM HR_EXPERIENCE_INSIDE T
                  WHERE T.START_DATE <= SYSDATE
                    AND T.ACTIVITY = 1
                    AND T.AFFIRM_FLAG = 1
                    AND T.EXECUTED = 0
                  ORDER BY T.EMPID, T.START_DATE, T.EXP_INSIDE_NO) LOOP

  /********CC所改的部分********/
   /*获取员工原来的职位、状态*/
    SELECT HE.STATUS_CODE,  HE.POST_ID,  POST_LEVEL_ID,HE.DEPTID
           INTO STATUS_CODE_PRE, POST_ID_PRE, POST_LEVEL_ID_PRE, DEPTID_PRE
         FROM HR_EMPLOYEE HE
         WHERE HE.EMPID = SETEMP.EMPID;
  /********CC所改的部分********/

    --解决发令冲突问题
    UPDATE HR_EMPLOYEE H
       SET H.DEPTID          = DECODE(SETEMP.DEPTID,
                                      SETEMP.DEPTID,
                                      SETEMP.DEPTID,
                                      H.DEPTID),
           H.POST_ID       = DECODE(SETEMP.POST_ID,
                                      SETEMP.POST_ID,
                                      SETEMP.POST_ID,
                                      H.POST_ID),
           H.STATUS_CODE     = DECODE(SETEMP.STATUS_CODE,
                                      SETEMP.STATUS_CODE,
                                      SETEMP.STATUS_CODE,
                                      H.STATUS_CODE),
           H.UPDATE_DATE     = SYSDATE,
           H.LEFT_DATE      = NULL,
           H.POST_LEVEL_ID  = DECODE(SETEMP.POST_LEVEL_ID,
                                      SETEMP.POST_LEVEL_ID,
                                      SETEMP.POST_LEVEL_ID,
                                      H.POST_LEVEL_ID)
     WHERE H.EMPID = SETEMP.EMPID;

    UPDATE HR_EXPERIENCE_INSIDE
       SET EXECUTED = 1, UPDATE_DATE = SYSDATE
    WHERE EXP_INSIDE_NO = SETEMP.EXP_INSIDE_NO
       AND EMPID = SETEMP.EMPID;

      /* *******CC所改的部分******* */
      /*获取员工ID，现在所改的状态、职位信息、时间*/
         /*
         SELECT EMPID,     STATUS_CODE,     POST_ID,     START_DATE, POST_LEVEL_ID
           INTO EMPID_NOW, STATUS_CODE_NOW, POST_ID_NOW, TO_TIME,    POST_LEVEL_ID_NOW
         FROM hr_experience_inside
         WHERE PROCESSID = processInstanceId;
         */
      EMPID_NOW := SETEMP.EMPID;

      STATUS_CODE_NOW := SETEMP.STATUS_CODE;
      DEPTID_NOW := SETEMP.DEPTID;
      POST_ID_NOW := SETEMP.POST_ID;
      TO_TIME :=SETEMP.START_DATE;
      POST_LEVEL_ID_NOW := SETEMP.POST_LEVEL_ID;

      IF SETEMP.TRANS_CODE <> 'TransCode_100' THEN

         DBMS_OUTPUT.put_line('状态值：'||STATUS_CODE_PRE||'----'||STATUS_CODE_NOW);
         DBMS_OUTPUT.put_line('职位值：'||POST_ID_NOW||'----'||POST_ID_PRE);

         IF POST_ID_PRE <> POST_ID_NOW OR POST_LEVEL_ID_PRE <> POST_LEVEL_ID_NOW OR STATUS_CODE_PRE <> STATUS_CODE_NOW OR DEPTID_PRE<>DEPTID_NOW THEN

            /*更新原来的职位记录，可能有重复职位职级状态记录，所以取最新的更新*/
            UPDATE HR_POST_RECORDS SET
            END_DATE = TO_TIME,
            UPDATE_DATE = SYSDATE
            WHERE NO=(
                SELECT MAX(NO)
                FROM HR_POST_RECORDS
                WHERE EMPID = EMPID_NOW
                    AND POST_ID = POST_ID_PRE
                    AND POST_LEVEL_ID = POST_LEVEL_ID_PRE
                    AND STATUS_CODE = STATUS_CODE_PRE
                    AND DEPTID = DEPTID_PRE
            );
            /*插入新的职位状态记录*/
            INSERT INTO HR_POST_RECORDS(
                   NO,
                   EMPID,
                   START_DATE,
                   POST_ID,
                   POST_LEVEL_ID,
                   STATUS_CODE,
                   CREATE_DATE,
                   DEPTID,
                   ACTIVITY)
            VALUES(
                   HR_POST_RECORDS_SEQ.NEXTVAL,
                   EMPID_NOW,
                   TO_TIME,
                   POST_ID_NOW,
                   POST_LEVEL_ID_NOW,
                   STATUS_CODE_NOW,
                   SYSDATE,
                   DEPTID_NOW,
                   1
            );
         END IF;
      ELSE
        INSERT INTO HR_POST_RECORDS(
            NO,
            EMPID,
            START_DATE,
            POST_ID,
            STATUS_CODE,
            DEPTID,
            ACTIVITY,
            CREATE_DATE,
            POST_LEVEL_ID)
          VALUES(
            HR_POST_RECORDS_SEQ.NEXTVAL,
            EMPID_NOW,
            TO_TIME,
            POST_ID_NOW,
            STATUS_CODE_NOW,
            DEPTID_NOW,
            1,
            SYSDATE,
            POST_LEVEL_ID_NOW
          );
      END IF;
       /* *******CC所改的部分******* */
  END LOOP;

  --派遣
    UPDATE HR_DISPATCH
       SET EXECUTED = 1,
       UPDATE_DATE = SYSDATE
     WHERE ACTIVITY = 1
       AND START_DATE < SYSDATE;
 -- dbms_output.put_line('派遣');
  --奖励
  UPDATE HR_REWARD T
     SET T.EXECUTED = 1
   WHERE T.ACTIVITY = 1
     AND T.REWARD_DATE <= SYSDATE;

  --惩罚
  UPDATE HR_PUNISHMENT T
     SET T.EXECUTED = 1
   WHERE T.ACTIVITY = 1
     AND T.PUNISHED_DATE <= SYSDATE;

  --兼任
  UPDATE HR_PLURALITY T
     SET T.EXECUTED = 1
   WHERE T.ACTIVITY = 1
     AND T.START_DATE <= SYSDATE;

      --AND T.END_DATE IS NULL OR
      --(T.END_DATE IS NOT NULL AND T.END_DATE <= SYSDATE)
      --);

  --离职
  FOR SETEMP IN (SELECT *
                   FROM HR_RESIGNATION G
                  WHERE G.RESIGN_DATE < SYSDATE
                    AND G.EXECUTED = 0
                    AND G.ACTIVITY = 1
                    AND G.AFFIRM_FLAG = 1
                  ORDER BY G.EMPID, G.RESIGN_DATE, G.RESIGN_NO) LOOP

    /* *******CC所改的部分******* */
    /*获取员工原来的职位、状态*/
    SELECT HE.STATUS_CODE,  HE.POST_ID,  POST_LEVEL_ID
           INTO STATUS_CODE_PRE, POST_ID_PRE, POST_LEVEL_ID_PRE
         FROM HR_EMPLOYEE HE
         WHERE HE.EMPID = SETEMP.EMPID;
    /* *******CC所改的部分******* */

    UPDATE HR_EMPLOYEE
       SET STATUS_CODE = 'EmpStatus3',
           LEFT_DATE   = SETEMP.RESIGN_DATE,
           UPDATE_DATE = SYSDATE
     WHERE EMPID = SETEMP.EMPID;

    UPDATE HR_RESIGNATION
       SET EXECUTED = 1,
       UPDATE_DATE = SYSDATE
     WHERE RESIGN_NO = SETEMP.RESIGN_NO
       AND EMPID = SETEMP.EMPID;

    /*CC所改部分*/
    EMPID_NOW := SETEMP.EMPID;
    TO_TIME :=SETEMP.RESIGN_DATE;

    UPDATE HR_POST_RECORDS SET
           END_DATE = TO_TIME,
           UPDATE_DATE = SYSDATE
    WHERE NO=(
           SELECT MAX(NO)
           FROM HR_POST_RECORDS
           WHERE EMPID = EMPID_NOW
           AND POST_ID = POST_ID_PRE
           AND POST_LEVEL_ID = POST_LEVEL_ID_PRE
           AND STATUS_CODE = STATUS_CODE_PRE
    );
    /*CC所改部分*/

  END LOOP;

  --担当业务变更
  DELETE FROM HR_EMP_BUSINESS
   WHERE EMPID IN (SELECT HA.EMPID
                     FROM HR_ACT_BUSINESS HA
                    WHERE HA.START_DATE < SYSDATE
                      AND HA.ACTIVITY = 0);

  INSERT INTO HR_EMP_BUSINESS
    (EMPID, BIZ_CODE, START_DATE)
    SELECT HA.EMPID,HA.BIZ_CODE,HA.START_DATE
      FROM HR_ACT_BUSINESS HA
     WHERE HA.START_DATE <= SYSDATE
       AND HA.ACTIVITY = 0;

  UPDATE HR_ACT_BUSINESS HA
     SET HA.ACTIVITY = 1
   WHERE HA.START_DATE <= SYSDATE
     AND HA.ACTIVITY = 0;
COMMIT;
END HR_UPDATE_AUTO;
/

prompt
prompt Creating procedure IMP_EMP_IMAGE
prompt ================================
prompt
CREATE OR REPLACE PROCEDURE imp_emp_image (p_photo VARCHAR2)
AUTHID CURRENT_USER
IS
   f_photo   BFILE;
   b_photo   BLOB;
   flag      VARCHAR2 (20);

   CURSOR c_emp
   IS
      SELECT empid
        FROM hr_employee;
BEGIN
   FOR r_emp IN c_emp
   LOOP
      flag := 0;

      BEGIN
         --   find   where   the   photo's   pointer   is   located.
         f_photo := BFILENAME ('HR_IMAGE_PATH', r_emp.empid || '.jpg');
         --   open   the   photo   as   read-only   option.
         DBMS_LOB.fileopen (f_photo, DBMS_LOB.file_readonly);
      --   close   the   photo's   pointer.
      EXCEPTION
         WHEN OTHERS
         THEN
            flag := 1;
            DBMS_OUTPUT.put_line (r_emp.empid || ' no have photo');
      END;

      IF flag = 0
      THEN
      
         DELETE      hr_emp_binary_photo
               WHERE empid = r_emp.empid;

         --   Update   the   employee   photo
         INSERT INTO hr_emp_binary_photo
                     (empid, binary_photo
                     )
              VALUES (r_emp.empid, EMPTY_BLOB ()
                     )
              RETURN binary_photo
                INTO b_photo;
                
         --   load   the   photo   into   column   photo.
         DBMS_LOB.loadfromfile (b_photo, f_photo,
                                DBMS_LOB.getlength (f_photo));
         DBMS_LOB.fileclose (f_photo);
      END IF;
   END LOOP;
END;
/

prompt
prompt Creating procedure MAT_CREATE
prompt =============================
prompt
CREATE OR REPLACE PROCEDURE MAT_CREATE(IN_MAT_T_ID IN VARCHAR2,
                                       IN_ID_TYPE  IN VARCHAR2,
                                       IN_MAT_NAME IN VARCHAR2,
                                       IN_OLD_NAME IN VARCHAR2,
                                       IN_BP_NAME IN VARCHAR2,
                                       IN_MAT_TYPE_ID IN VARCHAR2,
                                       IN_MAT_UNIT_CODE IN VARCHAR2,
                                       IN_WEIGHT_UNIT_CODE IN VARCHAR2,
                                       IN_LENGTH_UNIT_CODE IN VARCHAR2,
                                       IN_MAT_DESCRIPTION IN VARCHAR2,
                                       IN_LENGTH IN VARCHAR2,
                                       IN_WIDTH IN VARCHAR2,
                                       IN_HEIGHT IN VARCHAR2,
                                       IN_NET_WEIGHT  IN VARCHAR2,
                                       IN_ROUGH_WEIGHT IN VARCHAR2,
                                       IN_REMARK IN VARCHAR2,
                                       IN_PHOTOPATH IN VARCHAR2,
                                       IN_CPNY_ID IN VARCHAR2,
                                       IN_ISSEPARATED IN VARCHAR2,
                                       IN_ORDER_NUMBER IN VARCHAR2,
                                       IN_CREATED_BY  IN VARCHAR2)
IS
     IN_MAT_ID   VARCHAR2(20):='';
BEGIN
      IF IN_ID_TYPE='I'THEN
          IN_MAT_ID := MAT_INFO_SEQ.NEXTVAL;
        END IF;
      IF IN_ID_TYPE = 'O' THEN
           IN_MAT_ID := IN_MAT_T_ID;
        END IF;
      IF IN_ID_TYPE='M'THEN
          IN_MAT_ID :=IN_MAT_T_ID||'-'||MAT_INFO_SEQ.NEXTVAL;
        END IF;

			INSERT INTO MAT_INFO(MAT_NO,MAT_ID,MAT_NAME,MAT_TYPE_ID,MAT_STATUS_ID,MAT_UNIT_CODE,
			                           WEIGHT_UNIT_CODE,LENGTH_UNIT_CODE,MAT_DESCRIPTION,LENGTH,WIDTH,HEIGHT,NET_WEIGHT,
			                           ROUGH_WEIGHT,REMARK,PHOTOPATH,CPNY_ID,IS_SEPARATED,OLD_NAME,BP_NAME,
			                           ORDERNO,CREATE_DATE,CREATED_BY,ACTIVITY)
			    VALUES(MAT_INFO_SEQ.NEXTVAL,IN_MAT_ID,IN_MAT_NAME,IN_MAT_TYPE_ID,PROCESS_GET_DEF_STATUS(IN_MAT_TYPE_ID,IN_CPNY_ID),IN_MAT_UNIT_CODE,
			                           IN_WEIGHT_UNIT_CODE,IN_LENGTH_UNIT_CODE,IN_MAT_DESCRIPTION,IN_LENGTH,IN_WIDTH,IN_HEIGHT,IN_NET_WEIGHT,
			                           IN_ROUGH_WEIGHT,IN_REMARK,IN_PHOTOPATH,IN_CPNY_ID,TO_NUMBER(IN_ISSEPARATED),IN_OLD_NAME,IN_BP_NAME,
			                           IN_ORDER_NUMBER,SYSDATE,IN_CREATED_BY,1);

END;
/

prompt
prompt Creating procedure ORD_UPDATE_SALARY
prompt ====================================
prompt
CREATE OR REPLACE PROCEDURE ORD_UPDATE_SALARY(V_ORDER_ID IN VARCHAR2) AS
  /*
   更新订单提成
  */
VAR_SALARY NUMBER(10,2);
BEGIN
  VAR_SALARY := get_order_direct_percentage(V_ORDER_ID);
  UPDATE ORD_ORDER_INFO SET SALARY = VAR_SALARY WHERE ORDER_ID = V_ORDER_ID;
END ORD_UPDATE_SALARY;
/

prompt
prompt Creating procedure PA_ATTENDANCE_M_INSERT
prompt =========================================
prompt
create or replace procedure PA_ATTENDANCE_M_INSERT
       -- Author  : fei.liu  @sipingsoft
       -- Created : 2013/9/26 10:33:52
       -- Purpose : 自动扫描漏卡申请记录，并插入到考勤表
is
       -- 取得考勤表中审核通过的申请数据
   CURSOR cus_att_pass
   IS
      SELECT *
        FROM ESS_APPLY_CARD
       WHERE ACTIVITY = 1 AND AFFIRM_FLAG = 1 AND ATTENDANCE_FLAG = 0;
       --参数
   V_CARD_NO            VARCHAR2(20);
   V_EMPID              VARCHAR2(20);
   V_CARD_DOOR_TYPE     VARCHAR2(10);
   V_ATT_DATE           DATE;
   V_CREATED_BY         VARCHAR2(20);
   V_R_TIME             DATE;
   V_NUM                NUMBER;
begin
  FOR ROW_DATA IN cus_att_pass
   LOOP
     V_CARD_NO := ROW_DATA.CARD_NO;
     V_EMPID := ROW_DATA.EMPID;
     V_CARD_DOOR_TYPE := ROW_DATA.CARD_DOOR_TYPE;
     V_ATT_DATE := ROW_DATA.ATT_DATE;
     V_CREATED_BY := ROW_DATA.CREATED_BY;
     V_R_TIME := ROW_DATA.R_TIME;
     --查看考勤表中是否有该员工当天次的考勤记录，如果有则更新，否则插入
     SELECT COUNT(*) INTO V_NUM FROM AR_MAC_RECORD AMR
            WHERE AMR.EMPID = V_EMPID 
            AND AMR.CARD_DOOR_TYPE = V_CARD_DOOR_TYPE
            AND AMR.ATT_DATE = V_ATT_DATE;
     IF(V_NUM > 0) THEN
       UPDATE AR_MAC_RECORD 
              SET R_TIME = V_R_TIME,IN_FLAG = 'H',REMARK = '员工漏卡记录'
              WHERE CARD_DOOR_TYPE = V_CARD_DOOR_TYPE
              AND ATT_DATE = V_ATT_DATE
              AND EMPID = V_EMPID;
     ELSE
       INSERT INTO AR_MAC_RECORD
            (RECORD_NO,
            EMPID,
            R_TIME,
            ATT_DATE,
            CARD_DOOR_TYPE,
            IN_FLAG,
            REMARK,
            ACTIVITY,
            CREATE_DATE,
            CREATED_BY)
       VALUES
            (AR_MAC_RECORD_SEQ.NEXTVAL,
            V_EMPID,
            V_R_TIME,
            V_ATT_DATE,
            V_CARD_DOOR_TYPE,
            'H',
            '员工漏卡记录',
            1,
            SYSDATE,
            V_CREATED_BY);
    END IF;
    UPDATE ESS_APPLY_CARD
           SET ATTENDANCE_FLAG = 1
           WHERE CARD_NO = V_CARD_NO;
   END LOOP;
   COMMIT;
   EXCEPTION
     WHEN OTHERS THEN
       ROLLBACK;
end PA_ATTENDANCE_M_INSERT;
/

prompt
prompt Creating procedure PA_BONUS_CONFIRM
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE PA_BONUS_CONFIRM(OUT_RETURN_STR OUT VARCHAR2)
  AUTHID CURRENT_USER IS
  I                        INT := 0;
  VAR_PAMONTH              VARCHAR2(6);      
  VAR_PRIOR_PAMONTH        VARCHAR2(6);
  VAR_LOG_FLAG             NUMBER := 1;
  VAR_COUNT                INT;
  VAR_T_STR                VARCHAR2(30000);
  VAR_ALERT_STR            VARCHAR2(30000);

  /******************************************************************************
     NAME:       PA_CONFIRM
     PURPOSE:    备份旧工资表,生成新工资表

     REVISIONS:
     Ver        Date        Author           Description
     ---------  ----------  ---------------  ------------------------------------
     1.0        03/04/2006   Pennix       1. Created this procedure.

     NOTES:

     Automatically available Auto Replace Keywords:
        Object Name:     PA_CONFIRM_T
        Sysdate:         03/04/2006
        Date and Time:   03/04/2006, 01:14:11, and 03/04/2006 01:14:11
        Username:        Pennix (set in TOAD Options, Procedure Editor)
        Table Name:       (set in the "New PL/SQL Object" dialog)

  ******************************************************************************/
BEGIN
  /*确定已有新工资计算结果*/
  BEGIN
    EXECUTE IMMEDIATE ' SELECT PA_MONTH FROM T_PA_BONUS_RESULT WHERE ROWNUM = 1 '
      INTO VAR_PAMONTH ;

    VAR_PRIOR_PAMONTH := PRIOR_PAMONTH(VAR_PAMONTH);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      OUT_RETURN_STR := '没有奖金数据(T_PA_BONUS_RESULT表中没有数据)';
      RETURN;
  END;

  SELECT NVL(MAX(BONUS_LOCK_FLAG),0)
    INTO VAR_COUNT
    FROM PA_PROGRESS
   WHERE MONTH_STR = VAR_PAMONTH ;

  -- 验证当月是否存已锁定
  IF VAR_COUNT = 1 THEN
    BEGIN
      OUT_RETURN_STR := '错误: 当月奖金已锁定,不能再进行奖金结算.';
      RETURN;
    END;
  END IF;

  /*是否已备份过上月工资表,如果没有,备份上月工资表*/
  BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PA_BONUS_HISTORY_' ||
                      VAR_PRIOR_PAMONTH;

    EXECUTE IMMEDIATE 'CREATE TABLE PA_BONUS_HISTORY_' ||
                      VAR_PRIOR_PAMONTH ||
                      ' AS SELECT * FROM PA_BONUS_HISTORY WHERE PA_MONTH = ''' ||
                      VAR_PRIOR_PAMONTH || '''';
  EXCEPTION
    WHEN OTHERS THEN
      EXECUTE IMMEDIATE 'CREATE TABLE PA_BONUS_HISTORY_' ||
                        VAR_PRIOR_PAMONTH ||
                        ' AS SELECT * FROM PA_BONUS_HISTORY WHERE PA_MONTH = ''' ||
                        VAR_PRIOR_PAMONTH || '''';
  END;

  EXECUTE IMMEDIATE 'DELETE PA_BONUS_HISTORY WHERE PA_MONTH = ''' 
          || VAR_PAMONTH || ''''  ;
  COMMIT;


  -- 提取列信息
  DECLARE
    CURSOR CUR_COLUMN_NAME IS
      SELECT COLUMN_NAME,
             MAX(DATA_TYPE) DATA_TYPE,
             MAX(DATA_LENGTH) DATA_LENGTH
        FROM USER_TAB_COLUMNS PA
       WHERE TABLE_NAME = 'T_PA_BONUS_RESULT'
         /*AND (EXISTS(
                SELECT * FROM PA_DISTINCT_LIST T
                 WHERE T.TABLE_NAME = 'PA_HR_V'
                   AND T.DISTINCT_FIELD = PA.COLUMN_NAME
             )
         OR EXISTS(
                SELECT * FROM PA_BONUS_ITEM T
                 WHERE T.ITEM_ID = PA.COLUMN_NAME
             )
         OR EXISTS(
                SELECT * FROM PA_BASIC_ITEM T
                 WHERE T.ITEM_ID = PA.COLUMN_NAME
             )
         OR EXISTS(
                SELECT * FROM PA_BONUS_ITEM T
                 WHERE T.ITEM_ID = PA.COLUMN_NAME 
             )
         OR EXISTS(
                SELECT * FROM PA_ITEM T
                 WHERE T.ITEM_ID = PA.COLUMN_NAME
                 AND T.CALC_FLAG = 'Y'
             ))*/
         AND NOT EXISTS (SELECT T.COLUMN_NAME
                FROM USER_TAB_COLUMNS T
               WHERE T.TABLE_NAME = 'PA_BONUS_HISTORY'
                 AND T.COLUMN_NAME = PA.COLUMN_NAME)
       GROUP BY COLUMN_NAME
       ORDER BY MIN(COLUMN_ID);

    COLUMN_NAME_CUR CUR_COLUMN_NAME%ROWTYPE;
  BEGIN
    OPEN CUR_COLUMN_NAME;

    LOOP
      FETCH CUR_COLUMN_NAME
        INTO COLUMN_NAME_CUR;
      EXIT WHEN CUR_COLUMN_NAME%NOTFOUND;  
      --DBMS_OUTPUT.put_line ('var_alert_str=' || var_alert_str);
      VAR_ALERT_STR := ' alter table PA_BONUS_HISTORY add ' ||
                       COLUMN_NAME_CUR.COLUMN_NAME || ' ' ||
                       COLUMN_NAME_CUR.DATA_TYPE ||
                       CASE COLUMN_NAME_CUR.DATA_TYPE
                         WHEN 'VARCHAR2' THEN
                          ' (' || TO_CHAR(COLUMN_NAME_CUR.DATA_LENGTH) || ') '
                         WHEN 'CHAR' THEN
                          ' (' || TO_CHAR(COLUMN_NAME_CUR.DATA_LENGTH) || ') '
                         ELSE
                          ''
                       END;
       
      /*修改 T_PA_RESULT 表*/
      BEGIN
        IF VAR_LOG_FLAG > 0 THEN
          DBMS_OUTPUT.PUT_LINE(VAR_ALERT_STR);
          --DBMS_OUTPUT.PUT_LINE(VAR_UPDATE_STR);
        END IF;

        EXECUTE IMMEDIATE VAR_ALERT_STR;
        --EXECUTE IMMEDIATE VAR_UPDATE_STR;
      END;
    END LOOP;

    CLOSE CUR_COLUMN_NAME;
  END;

  DECLARE
    CURSOR CUR_COLUMN_NAME IS
      SELECT COLUMN_NAME
        FROM USER_TAB_COLUMNS PA
       WHERE TABLE_NAME = 'T_PA_BONUS_RESULT' 
       /*AND (EXISTS(
                SELECT * FROM PA_DISTINCT_LIST T
                 WHERE T.TABLE_NAME = 'PA_HR_V'
                   AND T.DISTINCT_FIELD = PA.COLUMN_NAME
             )
         OR EXISTS(
                SELECT * FROM PA_BONUS_ITEM T
                 WHERE T.ITEM_ID = PA.COLUMN_NAME
             )
         OR EXISTS(
                SELECT * FROM PA_BASIC_ITEM T
                 WHERE T.ITEM_ID = PA.COLUMN_NAME
             )
         OR EXISTS(
                SELECT * FROM PA_BONUS_ITEM T
                 WHERE T.ITEM_ID = PA.COLUMN_NAME 
             )
         OR EXISTS(
                SELECT * FROM PA_ITEM T
                 WHERE T.ITEM_ID = PA.COLUMN_NAME
                 AND T.CALC_FLAG = 'Y'
             ))*/
       GROUP BY COLUMN_NAME
       ORDER BY MIN(COLUMN_ID);

    COLUMN_NAME_CUR CUR_COLUMN_NAME%ROWTYPE;
  BEGIN
    OPEN CUR_COLUMN_NAME;

    LOOP
      FETCH CUR_COLUMN_NAME
        INTO COLUMN_NAME_CUR; 
      EXIT WHEN CUR_COLUMN_NAME%NOTFOUND;
      VAR_T_STR := VAR_T_STR || COLUMN_NAME_CUR.COLUMN_NAME || ', ';
    END LOOP;

    CLOSE CUR_COLUMN_NAME;

    VAR_T_STR := SUBSTR(VAR_T_STR, 1, LENGTH(VAR_T_STR) - 2);
    VAR_T_STR := 'INSERT INTO PA_BONUS_HISTORY (' || VAR_T_STR || ') SELECT ' ||
                    VAR_T_STR || ' FROM T_PA_BONUS_RESULT' ;
  END;

  IF VAR_LOG_FLAG > 0 THEN
    i := 0;
    WHILE i * 150 <= LENGTH(VAR_T_STR) LOOP
      DBMS_OUTPUT.PUT_LINE(SUBSTR(VAR_T_STR, i * 150, 150));
      i := i + 1;
    END LOOP;
  END IF;


  EXECUTE IMMEDIATE VAR_T_STR ;

  COMMIT;
  OUT_RETURN_STR := '[' || VAR_PAMONTH || ']月奖金结算成功。' || OUT_RETURN_STR;
END PA_BONUS_CONFIRM;
/

prompt
prompt Creating procedure PA_CONFIRM
prompt =============================
prompt
CREATE OR REPLACE PROCEDURE PA_CONFIRM(OUT_RETURN_STR OUT VARCHAR2) AUTHID CURRENT_USER IS
  I                 INT := 0;
  VAR_PAMONTH       VARCHAR2(6);
  VAR_ALERT_STR     VARCHAR2(30000);
  VAR_T_STR         VARCHAR2(30000);
  VAR_PRIOR_PAMONTH VARCHAR2(20);
  VAR_LOG_FLAG      NUMBER := 0;
  /******************************************************************************
     NAME:       PA_CONFIRM
     PURPOSE:    备份旧工资表,生成新工资表
  
     REVISIONS:
     Ver        Date        Author           Description
     ---------  ----------  ---------------  ------------------------------------
     1.0        03/04/2006   Pennix       1. Created this procedure.
  
     NOTES:
  
     Automatically available Auto Replace Keywords:
        Object Name:     PA_CONFIRM_T
        Sysdate:         03/04/2006
        Date and Time:   03/04/2006, 01:14:11, and 03/04/2006 01:14:11
        Username:        Pennix (set in TOAD Options, Procedure Editor)
        Table Name:       (set in the "New PL/SQL Object" dialog)
  
  ******************************************************************************/
BEGIN
  /*确定已有新工资计算结果*/
  BEGIN
    EXECUTE IMMEDIATE 'SELECT PA_MONTH FROM T_PA_RESULT WHERE ROWNUM = 1 '
      INTO VAR_PAMONTH;
  
    VAR_PRIOR_PAMONTH := PRIOR_PAMONTH(VAR_PAMONTH);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      OUT_RETURN_STR := '没有工资数据(T_PA_RESULT表中没有数据)';
      RETURN;
  END;

  DELETE PA_HISTORY WHERE PA_MONTH = VAR_PAMONTH;
  COMMIT;

  /*是否已备份过上月工资表,如果没有,备份上月工资表*/
  BEGIN
  
    EXECUTE IMMEDIATE 'DROP TABLE PA_HISTORY_' || VAR_PRIOR_PAMONTH;
  
    EXECUTE IMMEDIATE 'CREATE TABLE PA_HISTORY_' || VAR_PRIOR_PAMONTH ||
                      ' AS SELECT * FROM PA_HISTORY WHERE PA_MONTH = ''' ||
                      VAR_PRIOR_PAMONTH || '''';
  EXCEPTION
    WHEN OTHERS THEN
      EXECUTE IMMEDIATE 'CREATE TABLE PA_HISTORY_' || VAR_PRIOR_PAMONTH ||
                        ' AS SELECT * FROM PA_HISTORY WHERE PA_MONTH = ''' ||
                        VAR_PRIOR_PAMONTH || '''';
  END;

  -- 提取列信息
  DECLARE
    CURSOR CUR_COLUMN_NAME IS
      SELECT COLUMN_NAME,
             MAX(DATA_TYPE) DATA_TYPE,
             MAX(DATA_LENGTH) DATA_LENGTH
        FROM USER_TAB_COLUMNS PA
       WHERE TABLE_NAME = 'T_PA_RESULT'
         AND NOT EXISTS (SELECT T.COLUMN_NAME
                FROM USER_TAB_COLUMNS T
               WHERE T.TABLE_NAME = 'PA_HISTORY'
                 AND T.COLUMN_NAME = PA.COLUMN_NAME)
       GROUP BY COLUMN_NAME
       ORDER BY MIN(COLUMN_ID);
  
    COLUMN_NAME_CUR CUR_COLUMN_NAME%ROWTYPE;
  BEGIN
  
    OPEN CUR_COLUMN_NAME;
  
    LOOP
      FETCH CUR_COLUMN_NAME
        INTO COLUMN_NAME_CUR;
    
      EXIT WHEN CUR_COLUMN_NAME%NOTFOUND;
    
      --DBMS_OUTPUT.put_line ('var_alert_str=' || var_alert_str);
      VAR_ALERT_STR := ' alter table PA_HISTORY add ' ||
                       COLUMN_NAME_CUR.COLUMN_NAME || ' ' ||
                       COLUMN_NAME_CUR.DATA_TYPE ||
                       CASE COLUMN_NAME_CUR.DATA_TYPE
                         WHEN 'VARCHAR2' THEN
                          ' (' || TO_CHAR(COLUMN_NAME_CUR.DATA_LENGTH) || ') '
                         WHEN 'CHAR' THEN
                          ' (' || TO_CHAR(COLUMN_NAME_CUR.DATA_LENGTH) || ') '
                         ELSE
                          ''
                       END;
      
      /*修改 T_PA_RESULT 表*/
      BEGIN
        IF VAR_LOG_FLAG > 0 THEN
          DBMS_OUTPUT.PUT_LINE(VAR_ALERT_STR);
          --DBMS_OUTPUT.PUT_LINE(VAR_UPDATE_STR);
        END IF;
      
        EXECUTE IMMEDIATE VAR_ALERT_STR;
        --EXECUTE IMMEDIATE VAR_UPDATE_STR;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20101,
                                  VAR_ALERT_STR || '; Error: ' || SQLERRM);
      END;
    
    END LOOP;
  
    CLOSE CUR_COLUMN_NAME;
  
  END;

  DECLARE
    CURSOR CUR_COLUMN_NAME IS
      SELECT COLUMN_NAME
        FROM USER_TAB_COLUMNS PA
       WHERE TABLE_NAME = 'T_PA_RESULT' 
       GROUP BY COLUMN_NAME
       ORDER BY MIN(COLUMN_ID);
  
    COLUMN_NAME_CUR CUR_COLUMN_NAME%ROWTYPE;
  BEGIN
    OPEN CUR_COLUMN_NAME;
  
    LOOP
      FETCH CUR_COLUMN_NAME
        INTO COLUMN_NAME_CUR;
    
      EXIT WHEN CUR_COLUMN_NAME%NOTFOUND;
      VAR_T_STR := VAR_T_STR || COLUMN_NAME_CUR.COLUMN_NAME || ', ';
    END LOOP;
  
    CLOSE CUR_COLUMN_NAME;
  
    VAR_T_STR := SUBSTR(VAR_T_STR, 1, LENGTH(VAR_T_STR) - 2);
    VAR_T_STR := 'INSERT INTO PA_HISTORY (' || VAR_T_STR || ') SELECT ' ||
                 VAR_T_STR || ' FROM T_PA_RESULT';
  END;

  IF VAR_LOG_FLAG > 0 THEN
    I := 0;
    WHILE I * 150 <= LENGTH(VAR_T_STR) LOOP
      DBMS_OUTPUT.PUT_LINE(SUBSTR(VAR_T_STR, I * 150, 150));
      I := I + 1;
    END LOOP;
  END IF;

  EXECUTE IMMEDIATE VAR_T_STR;

  COMMIT;

  OUT_RETURN_STR := VAR_PAMONTH || '月工资结算成功. ' || OUT_RETURN_STR;
END PA_CONFIRM;
/

prompt
prompt Creating procedure PA_CONFIRM_DAILY
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE PA_CONFIRM_DAILY (
   in_sdate               VARCHAR2
)
AUTHID CURRENT_USER
IS
   i                     Integer   := 0  ;
   var_pa_date           VARCHAR2 (10);
   var_alert_str         VARCHAR2 (1000);
   var_t_str             VARCHAR2 (5000);

/******************************************************************************
   NAME:       PA_CONFIRM_DAILY
   PURPOSE:    生成新工资表

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        03/04/2006   Pennix       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     PA_CONFIRM_T
      Sysdate:         03/04/2006
      Date and Time:   03/04/2006, 01:14:11, and 03/04/2006 01:14:11
      Username:        Pennix (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN

   /*确定已有PA_DIALY_HISTORY*/
   BEGIN
      SELECT 'YES'
        INTO var_pa_date
        FROM USER_ALL_TABLES
       WHERE TABLE_NAME = 'PA_DAILY_HISTORY'
         AND ROWNUM = 1;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         EXECUTE IMMEDIATE    'CREATE TABLE PA_DAILY_HISTORY( PA_DATE CHAR(10) )';
   END;


  -- 添加缺少的字段
   DECLARE
       -- 查找，PA_DIALY_HISTORY 中，不存在的字段
       CURSOR cur_field
       IS
          SELECT COLUMN_NAME,DATA_TYPE,DATA_LENGTH FROM USER_TAB_COLS T1 WHERE TABLE_NAME = 'T_PA_DAILY_RESULT' AND NOT EXISTS (
                SELECT * FROM USER_TAB_COLS T2 WHERE T2.TABLE_NAME = 'PA_DAILY_HISTORY' AND T1.COLUMN_NAME = T2.COLUMN_NAME )
          ORDER BY T1.COLUMN_ID ;

      FIELD_ROW   CUR_FIELD%ROWTYPE;
   BEGIN
      OPEN CUR_FIELD;
      LOOP
         FETCH CUR_FIELD
          INTO FIELD_ROW;
         EXIT WHEN CUR_FIELD%NOTFOUND ;
         --DBMS_OUTPUT.put_line ('var_alert_str=' || var_alert_str);
         var_alert_str := ' alter table PA_DAILY_HISTORY add "'
                       || FIELD_ROW.COLUMN_NAME || '" ' || FIELD_ROW.DATA_TYPE
                       || CASE FIELD_ROW.DATA_TYPE
                          WHEN 'VARCHAR2'
                             THEN '(' || TO_CHAR (FIELD_ROW.data_length) || ')'
                          WHEN 'CHAR'
                             THEN '(' || TO_CHAR (FIELD_ROW.data_length) || ')'
                          ELSE ''
                       END ;
          /*修改 PA_DAILY_HISTORY 表*/
         BEGIN
            EXECUTE IMMEDIATE var_alert_str;
         EXCEPTION
            WHEN OTHERS
            THEN
               RAISE_APPLICATION_ERROR (-20101,'alter PA_DAILY_HISTORY Error: ' || SQLERRM );
          END;

       END LOOP ;
       CLOSE  CUR_FIELD ;
    END ;

   -- 删除已存在的数据
     BEGIN
        EXECUTE IMMEDIATE ' DELETE PA_DAILY_HISTORY WHERE PA_DATE =''' || in_sdate || '''';
     EXCEPTION
        WHEN OTHERS
        THEN
           RAISE_APPLICATION_ERROR (-20101,'DELTE PA_DAILY_HISTORY DATA Error:' || SQLERRM);
      END;

   -- 插入数据
   DECLARE
      CURSOR cur_column_name
      IS
         SELECT   column_name
             FROM user_tab_columns
            WHERE table_name = 'T_PA_DAILY_RESULT'
         GROUP BY column_name
         ORDER BY MIN (column_id);

       column_name_cur   cur_column_name%ROWTYPE;
   BEGIN
      OPEN cur_column_name;

      LOOP
         FETCH cur_column_name
          INTO column_name_cur;

         EXIT WHEN cur_column_name%NOTFOUND;
         var_t_str := var_t_str || '"' || column_name_cur.column_name || '", ' ;
      END LOOP;
      var_t_str := SUBSTR (var_t_str, 1, LENGTH (var_t_str) - 2);
      CLOSE cur_column_name;

   END;

   var_t_str := 'INSERT INTO PA_DAILY_HISTORY ('
               || var_t_str
               || ') SELECT '
               || var_t_str
               || ' FROM T_PA_DAILY_RESULT';

   WHILE i * 150 <= LENGTH (var_t_str)
   LOOP
      DBMS_OUTPUT.put_line (SUBSTR (var_t_str, i * 150, 150));
      i := i + 1;
   END LOOP;

   -- 插入日工资数据
     BEGIN
        EXECUTE IMMEDIATE var_t_str;
     EXCEPTION
        WHEN OTHERS
        THEN
           RAISE_APPLICATION_ERROR (-20101,'INSERT INTO PA_DAILY_HISTORY DATA Error:' || SQLERRM);
      END;

END PA_CONFIRM_DAILY;
/

prompt
prompt Creating procedure PA_INSURANCE_CONFIRM
prompt =======================================
prompt
CREATE OR REPLACE PROCEDURE PA_INSURANCE_CONFIRM(OUT_RETURN_STR OUT VARCHAR2)
  AUTHID CURRENT_USER IS
  I                 INT := 0;
  VAR_PAMONTH       VARCHAR2(6);
  VAR_PRIOR_PAMONTH VARCHAR2(6);
  VAR_LOG_FLAG      NUMBER := 1;
  VAR_COUNT         INT;
  VAR_T_STR         VARCHAR2(30000);
  VAR_ALERT_STR     VARCHAR2(30000);

  /******************************************************************************
     NAME:       PA_CONFIRM
     PURPOSE:    备份旧工资表,生成新工资表

     REVISIONS:
     Ver        Date        Author           Description
     ---------  ----------  ---------------  ------------------------------------
     1.0        03/04/2006   Pennix       1. Created this procedure.

     NOTES:

     Automatically available Auto Replace Keywords:
        Object Name:     PA_CONFIRM_T
        Sysdate:         03/04/2006
        Date and Time:   03/04/2006, 01:14:11, and 03/04/2006 01:14:11
        Username:        Pennix (set in TOAD Options, Procedure Editor)
        Table Name:       (set in the "New PL/SQL Object" dialog)

  ******************************************************************************/
BEGIN
  /*确定已有新保险计算结果*/
  BEGIN
    EXECUTE IMMEDIATE ' SELECT PA_MONTH FROM T_PA_INS_RESULT WHERE ROWNUM = 1 '
      INTO VAR_PAMONTH;

    VAR_PRIOR_PAMONTH := PRIOR_PAMONTH(VAR_PAMONTH);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      OUT_RETURN_STR := '没有保险数据(T_PA_INS_RESULT表中没有数据)';
      RETURN;
  END;

  SELECT NVL(MAX(INS_LOCK_FLAG),0)
    INTO VAR_COUNT
    FROM PA_PROGRESS
   WHERE MONTH_STR = VAR_PAMONTH ;

  -- 验证当月是否存已锁定
  IF VAR_COUNT = 1 THEN
    BEGIN
      OUT_RETURN_STR := '错误: 当月保险已锁定,不能再进行保险结算.';
      RETURN;
    END;
  END IF;

  /*是否已备份过上月工资表,如果没有,备份上月工资表*/
  BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PA_INS_HISTORY_' ||
                      VAR_PRIOR_PAMONTH;

    EXECUTE IMMEDIATE 'CREATE TABLE PA_INS_HISTORY_' ||
                      VAR_PRIOR_PAMONTH ||
                      ' AS SELECT * FROM PA_INS_HISTORY WHERE PA_MONTH = ''' ||
                      VAR_PRIOR_PAMONTH || '''';
  EXCEPTION
    WHEN OTHERS THEN
      EXECUTE IMMEDIATE 'CREATE TABLE PA_INS_HISTORY_' ||
                        VAR_PRIOR_PAMONTH ||
                        ' AS SELECT * FROM PA_INS_HISTORY WHERE PA_MONTH = ''' ||
                        VAR_PRIOR_PAMONTH || '''';
  END;

  EXECUTE IMMEDIATE 'DELETE PA_INS_HISTORY WHERE PA_MONTH = ' ||
                    VAR_PAMONTH;
  COMMIT;

  -- 提取列信息
  DECLARE
    CURSOR CUR_COLUMN_NAME IS
      SELECT COLUMN_NAME,
             MAX(DATA_TYPE) DATA_TYPE,
             MAX(DATA_LENGTH) DATA_LENGTH
        FROM USER_TAB_COLUMNS PA
       WHERE TABLE_NAME = 'T_PA_INS_RESULT'
         /*
         AND EXISTS(
                SELECT * FROM PA_DISTINCT_LIST T
                 WHERE T.TABLE_NAME = 'PA_HR_V'
                   AND T.DISTINCT_FIELD = PA.COLUMN_NAME
             )
         AND EXISTS(
                SELECT * FROM PA_INS_ITEM T
                 WHERE T.ITEM_ID = PA.COLUMN_NAME
             )
         AND EXISTS(
                SELECT * FROM PA_BASIC_ITEM T
                 WHERE T.ITEM_ID = PA.COLUMN_NAME
             )
         */
         AND NOT EXISTS (SELECT T.COLUMN_NAME
                FROM USER_TAB_COLUMNS T
               WHERE T.TABLE_NAME = 'PA_INS_HISTORY'
                 AND T.COLUMN_NAME = PA.COLUMN_NAME)
       GROUP BY COLUMN_NAME
       ORDER BY MIN(COLUMN_ID);

    COLUMN_NAME_CUR CUR_COLUMN_NAME%ROWTYPE;
  BEGIN
    OPEN CUR_COLUMN_NAME;

    LOOP
      FETCH CUR_COLUMN_NAME
        INTO COLUMN_NAME_CUR;
      EXIT WHEN CUR_COLUMN_NAME%NOTFOUND; 
      --DBMS_OUTPUT.put_line ('var_alert_str=' || var_alert_str);
      VAR_ALERT_STR := ' alter table PA_INS_HISTORY add ' ||
                       COLUMN_NAME_CUR.COLUMN_NAME || ' ' ||
                       COLUMN_NAME_CUR.DATA_TYPE ||
                       CASE COLUMN_NAME_CUR.DATA_TYPE
                         WHEN 'VARCHAR2' THEN
                          ' (' || TO_CHAR(COLUMN_NAME_CUR.DATA_LENGTH) || ') '
                         WHEN 'CHAR' THEN
                          ' (' || TO_CHAR(COLUMN_NAME_CUR.DATA_LENGTH) || ') '
                         ELSE
                          ''
                       END;
                       
      /*修改 T_PA_RESULT 表*/
      BEGIN
        IF VAR_LOG_FLAG > 0 THEN
          DBMS_OUTPUT.PUT_LINE(VAR_ALERT_STR);
        END IF;

        EXECUTE IMMEDIATE VAR_ALERT_STR;
        
      END;
    END LOOP;

    CLOSE CUR_COLUMN_NAME;
    
  END;

  DECLARE
    CURSOR CUR_COLUMN_NAME IS
      SELECT COLUMN_NAME
        FROM USER_TAB_COLUMNS PA
       WHERE TABLE_NAME = 'T_PA_INS_RESULT' 
       GROUP BY COLUMN_NAME
       ORDER BY MIN(COLUMN_ID);

    COLUMN_NAME_CUR CUR_COLUMN_NAME%ROWTYPE;
  BEGIN
    OPEN CUR_COLUMN_NAME;

    LOOP
      FETCH CUR_COLUMN_NAME
        INTO COLUMN_NAME_CUR;

      EXIT WHEN CUR_COLUMN_NAME%NOTFOUND;
      VAR_T_STR := VAR_T_STR || COLUMN_NAME_CUR.COLUMN_NAME || ', ';
    END LOOP;

    CLOSE CUR_COLUMN_NAME;

    VAR_T_STR := SUBSTR(VAR_T_STR, 1, LENGTH(VAR_T_STR) - 2);
    VAR_T_STR := 'INSERT INTO PA_INS_HISTORY (' || VAR_T_STR || ') SELECT ' ||
                    VAR_T_STR || ' FROM T_PA_INS_RESULT' ;
  END;

  IF VAR_LOG_FLAG > 0 THEN
    i := 0;
    WHILE i * 150 <= LENGTH(VAR_T_STR) LOOP
      DBMS_OUTPUT.PUT_LINE(SUBSTR(VAR_T_STR, i * 150, 150));
      i := i + 1;
    END LOOP;
  END IF;


  EXECUTE IMMEDIATE VAR_T_STR ;

  COMMIT;
  OUT_RETURN_STR := '[' || VAR_PAMONTH || ']月保险结算成功。' || OUT_RETURN_STR;
END PA_INSURANCE_CONFIRM;
/

prompt
prompt Creating procedure PA_PACAL
prompt ===========================
prompt
CREATE OR REPLACE PROCEDURE PA_PACAL(V_PA_MONTH          VARCHAR2,
                                     V_PA_FORMULAR_MONTH VARCHAR2,
                                     V_CPNY_ID           VARCHAR2,
                                     V_EXEC_MODE         VARCHAR2,
                                     V_OUTPUT_TYPE       VARCHAR2,
                                     V_OUTPUT_STR        OUT VARCHAR2)
  AUTHID CURRENT_USER IS
  /* V_EXEC_MODE :
                 NORMAL 正常计算
                 TEST  只生成脚本不执行计算
                 ONLY_CREATE_TABLE 只建表 不计算
     V_OUTPUT_TYPE     输出模式
                 ALL 全部输出
                 PARAM   参数部分 CUIJINHUA ZHU ZHENGQI
                 PAITEM 工资项目部分
                 NONE   不输出

  */
  I                      INTEGER;
  V_STR                  VARCHAR2(20000); -- 创建T_PA_RESULT表的SQL
  V_BSTR                 VARCHAR2(20000); -- 更新T_PA_RESULT表的基础项目值的SQL
  V_CASTR                VARCHAR2(20000); -- 更新T_PA_RESULT表的工资项目值的SQL
  V_PSTR                 VARCHAR2(20000); -- 更新T_PA_RESULT表的输入项目值的SQL
  V_CONDITION_COUNT      INT; -- 工资项目空条件数量
  V_FOMULAR_COUNT        INT; -- 工资项目公式数量
  R_COUNT                INT;
  V_PARAM_ID             VARCHAR2(50);
  V_TIME                 DATE := SYSDATE;
  V_EMP_COUNT            VARCHAR2(6);
  V_ITEM_ID              VARCHAR2(50);
  V_BASIC_ITEM_ID        VARCHAR2(50);
  V_FORMULAR_NOCONDITION VARCHAR2(2000);

  -- 人事表游标
  CURSOR CUS_HR IS
    SELECT FIELD_NAME,
           DISTINCT_FIELD,
           TABLE_NAME,
           FIELD_EN_NAME,
           FIELD_KOR_NAME
      FROM PA_DISTINCT_LIST
     WHERE TABLE_NAME = 'PA_HR_V'
       AND CPNY_ID = V_CPNY_ID
       AND ACTIVITY = 1
     ORDER BY ID;

  -- 输入项目游标
  CURSOR CUS_PARAM IS
    SELECT PARAM_NO,
           PARAM_NAME,
           DISTINCT_FIELD_1ST,
           DISTINCT_FIELD_2ND,
           DATATYPE,
           DEFAULT_VAL,
           PARAM_EN_NAME,
           PARAM_ID
      FROM PA_PARAM_ITEM
     WHERE ACTIVITY = 1
       AND CPNY_ID = V_CPNY_ID;

  -- 工资项目游标
  CURSOR CUS_ITEM IS
    SELECT ITEM_NO,
           DATATYPE,
           ITEM_NAME,
           PRECISION,
           CARRY_BIT,
           ITEM_EN_NAME,
           ITEM_ID
      FROM PA_ITEM
     WHERE ACTIVITY = 1
       AND CPNY_ID = V_CPNY_ID
     ORDER BY CALCU_ORDER;

  -- 工资公式游标
  CURSOR CUS_FORMULAR(PA_ITEM_NO_IN NUMBER) IS
    SELECT *
      FROM PA_FORMULAR
     WHERE ITEM_NO = PA_ITEM_NO_IN
     AND   ACTIVITY = 1
     ORDER BY ORDERNO DESC;

BEGIN

---------------------------------------更新PA_HR_V为计算月符合的人------------------
BEGIN

execute immediate 'CREATE OR REPLACE VIEW PA_HR_V AS
SELECT HRE.EMPID,
       HRE.CHINESENAME,
       HRE.CHINESE_PINYIN,
       HRE.ENGLISHNAME,
       HPR.DEPTID,
       HRD.DEPTNAME,
       HRD.DEPT_EN_NAME,
       HRPI.DEGREE_CODE,
       D.CODE_NAME AS DEGREE_NAME,
       D.CODE_EN_NAME AS DEGREE_EN_NAME,
       HRPI.EDU_HIS_CODE,
       R.CODE_NAME AS EDU_HIS_NAME,
       R.CODE_EN_NAME AS EDU_HIS_EN_NAME,
       HRPI.MAJOR_CODE,
       S.CODE_NAME AS MAJOR_NAME,
       S.CODE_EN_NAME AS MAJOR_EN_NAME,
       HRPI.GENDER_CODE,
       F.CODE_NAME AS GENDER_NAME,
       F.CODE_EN_NAME AS GENDER_EN_NAME,
       TO_CHAR(BIRTHDAY, ''YYYY-MM-DD'') BIRTHDAY,
       HRPI.RELIGION_CODE,
       G.CODE_NAME AS RELIGION_NAME,
       G.CODE_EN_NAME AS RELIGION_EN_NAME,
       HRPI.NATION_CODE,
       H.CODE_NAME AS NATION_NAME,
       H.CODE_EN_NAME AS NATION_EN_NAME,
       HRPI.NATIONALITY_CODE,
       I.CODE_NAME AS NATIONALITY_NAME,
       I.CODE_EN_NAME AS NATIONALITY_EN_NAME,
       HRPI.BORNPLACE_CODE,
       J.CODE_NAME AS BORNPLACE_NAME,
       J.CODE_EN_NAME AS BORNPLACE_EN_NAME,
       HRPI.POLITY_CODE,
       K.CODE_NAME AS POLITY_NAME,
       K.CODE_EN_NAME AS POLITY_EN_NAME,
       HRPI.MEMBERSHIP,
       HRPI.MEMBERSHIP AS MEMBERSHIP_NAME,
       HRPI.MEMBERSHIP AS MEMBERSHIP_EN_NAME,
       HRPI.MARITAL_STATUS_CODE,
       L.CODE_NAME AS MARITAL_STATUS_NAME,
       L.CODE_EN_NAME AS MARITAL_STATUS_EN_NAME,
       TO_CHAR(WEDDING_DATE, ''YYYY-MM-DD'') WEDDING_DATE,
       HRPI.IDCARD_NO,
       HRPI.IDCARD_PROVINCE,
       HRPI.IDCARD_CITY,
       HRPI.IDCARD_AREA,
       HRPI.IDCARD_ADDRESS,
       HRPI.HOME_PROVINCE,
       HRPI.HOME_CITY,
       HRPI.HOME_AREA,
       HRPI.HOME_ADDRESS,
       HRPI.IDCARD_POSTALCODE,
       HRPI.HOME_POSTALCODE,
       HRPI.P_EMAIL,
       HRPI.C_EMAIL,
       HRPI.OFFICE_PHONE,
       HRPI.HOME_PHONE,
       HRPI.CELLPHONE,
       HRPI.FAX,
       FLOOR(MONTHS_BETWEEN(SYSDATE, HRPI.BIRTHDAY) / 12) AGE,
       FLOOR(MONTHS_BETWEEN(SYSDATE, HRE.JOIN_DATE)) A_WORKAGE,
       HRPI.WORKAGE B_WORKAGE,
       FLOOR(MONTHS_BETWEEN(SYSDATE, HRE.JOIN_DATE) + HRPI.WORKAGE) WORKAGE,
       HRPI.IDCARD_TYPE_CODE,
       Q.CODE_NAME AS IDCARD_TYPE_NAME,
       Q.CODE_EN_NAME AS IDCARD_TYPE_EN_NAME,
       HRPI.FILE_RELATION_CODE,
       N.CODE_EN_NAME AS FILE_RELATION_EN_NAME,
       N.CODE_NAME AS FILE_RELATION_NAME,
       HRPI.FILE_RELATION_ADDRESS,
       HREI.SSN,
       HREI.HAFN,
       HREI.SHIFT_CODE,
       A.CODE_NAME AS SHIFT_NAME,
       A.CODE_EN_NAME AS SHIFT_EN_NAME,
       HREI.SUPPLIER_CODE,
       B.CODE_NAME AS SUPPLIER_NAME,
       B.CODE_EN_NAME AS SUPPLIER_EN_NAME,
       HRE.DUTY_CODE,
       E.CODE_NAME AS DUTY_NAME,
       E.CODE_EN_NAME AS DUTY_EN_NAME,
       HRE.POSITION_ID,
       HRPO.POSITION_NAME,
       HRPO.POSITION_EN_NAME,
       HPR.POST_ID,
       HRP.POST_NAME,
       HRP.POST_EN_NAME,
       HRE.POST_GRADE_ID,
       HRPGR.POST_GRADE_NAME,
       HRPGR.POST_GRADE_EN_NAME,
       HRE.POST_COEF,
       HRE.POST_GROUP_ID,
       HRPG.POST_GROUP_NAME,
       HRPG.POST_GROUP_EN_NAME,
       HPR.STATUS_CODE,
       O.CODE_NAME AS STATUS_NAME,
       O.CODE_EN_NAME AS STATUS_EN_NAME,
       HRE.JOIN_TYPE_CODE,
       P.CODE_NAME AS JOIN_TYPE_NAME,
       P.CODE_EN_NAME AS JOIN_TYPE_EN_NAME,
       HRE.JOIN_DATE,
       HRE.HIRE_DATE,
       HRE.END_PROBATION_DATE,
       HRE.LEFT_DATE,
       HRE.COSTCENTER,
       HRE.EMP_TYPE_CODE,
       C.CODE_NAME AS EMP_TYPE_NAME,
       C.CODE_EN_NAME AS EMP_TYPE_EN_NAME,
       (
          SELECT HREPI.CARD_NO FROM HR_EMP_PA_INFO HREPI
          WHERE HREPI.EMPID = HRE.EMPID
              AND CALC_FLAG = ''Y''
              AND ROWNUM = 1
       )   AS CARD_NO
  FROM HR_EMPLOYEE         HRE,
       HR_PERSONAL_INFO    HRPI,
       HR_POST_RECORDS     HPR,
       HR_DEPARTMENT       HRD,
       HR_EMP_INFO         HREI,
       HR_POSITION         HRPO,
       HR_POST             HRP,
       HR_POST_GROUP       HRPG,
       HR_POST_GRADE       HRPGR,
       SY_CODE             A,
       SY_CODE             B,
       SY_CODE             D,
       SY_CODE             F,
       SY_CODE             G,
       SY_CODE             H,
       SY_CODE             I,
       SY_CODE             J,
       SY_CODE             K,
       SY_CODE             L,
       SY_CODE             M,
       SY_CODE             N,
       SY_CODE             Q,
       SY_CODE             R,
       SY_CODE             S,
       SY_CODE             E,
       SY_CODE             O,
       SY_CODE             P,
       SY_CODE             C
 WHERE HRE.EMPID = HRPI.EMPID(+)
   AND HRE.EMPID = HREI.EMPID(+)
   AND HPR.DEPTID = HRD.DEPTID(+)
   AND HPR.NO = (
            SELECT MAX(HPR1.NO)
            FROM HR_POST_RECORDS HPR1
            WHERE HPR1.EMPID = HRE.EMPID
            AND TO_DATE(TO_CHAR(HPR1.START_DATE,''YYYYMM''),''YYYYMM'') <= TO_DATE('||V_PA_MONTH||',''YYYYMM''))
   AND HPR.POST_ID = HRP.POST_ID(+)
   AND HRP.POST_GROUP_ID = HRPG.POST_GROUP_ID(+)
   AND HRP.POSITION_ID = HRPO.POSITION_ID(+)
   AND HRPO.POST_GRADE_ID = HRPGR.POST_GRADE_ID(+)
   AND HREI.SHIFT_CODE = A.CODE_ID(+)
   AND HREI.SUPPLIER_CODE = B.CODE_ID(+)
   AND HRPI.DEGREE_CODE = D.CODE_ID(+)
   AND HRPI.GENDER_CODE = F.CODE_ID(+)
   AND HRPI.RELIGION_CODE = G.CODE_ID(+)
   AND HRPI.NATION_CODE = H.CODE_ID(+)
   AND HRPI.NATIONALITY_CODE = I.CODE_ID(+)
   AND HRPI.BORNPLACE_CODE = J.CODE_ID(+)
   AND HRPI.POLITY_CODE = K.CODE_ID(+)
   AND HRPI.MARITAL_STATUS_CODE = L.CODE_ID(+)
   AND HRPI.IDCARD_TYPE_CODE = M.CODE_ID(+)
   AND HRPI.FILE_RELATION_CODE = N.CODE_ID(+)
   AND HRPI.IDCARD_TYPE_CODE = Q.CODE_ID(+)
   AND HRPI.EDU_HIS_CODE = R.CODE_ID(+)
   AND HRPI.MAJOR_CODE = S.CODE_ID(+)
   AND HRE.DUTY_CODE = E.CODE_ID(+)
   AND HPR.STATUS_CODE = O.CODE_ID(+)
   AND HRE.JOIN_TYPE_CODE = P.CODE_ID(+)
   AND HRE.EMP_TYPE_CODE = C.CODE_ID(+)
   AND ( HRE.LEFT_DATE >= AR_GET_STARTDATE('||V_PA_MONTH||')
   OR  HRE.LEFT_DATE IS NULL )
   AND HRE.JOIN_DATE <= AR_GET_ENDDATE('||V_PA_MONTH||')';

   COMMIT;
 END;
---------------------------------------
  SELECT COUNT(*)
    INTO R_COUNT
    FROM PA_PARAM_ITEM
   WHERE ACTIVITY = 1
   AND   CPNY_ID  = V_CPNY_ID;

  -- 验证当月是否存在输入项目
  IF R_COUNT = 0 THEN
    BEGIN
      V_OUTPUT_STR := '错误: 当月工资无输入项目，请初始化输入项目.';
      RETURN;
    END;
  END IF;

  UPDATE PA_PARAM_DATA
     SET RETURN_VALUE = NULL
   WHERE LOWER(RETURN_VALUE) = 'null';

  COMMIT;

  -- 设置输出缓冲区大小
  -- SET OUTPUT ON SIZE 50000;
  DBMS_OUTPUT.ENABLE(5000000);
  -- EXECUTE IMMEDIATE 'SET LINESIZE = 5000';

  -- 删除已存在数据
  BEGIN
    EXECUTE IMMEDIATE 'DELETE PA_HISTORY WHERE PA_MONTH = ''' ||
                      V_PA_MONTH || '''';

  EXCEPTION
    WHEN OTHERS THEN
      V_OUTPUT_STR := '错误: 删除重复数据有误.';
      RETURN;

      COMMIT;
  END;

  -- 建表字符串，表的列由参数名称 || 工资项目名称组成。工资项目名称按计算顺序排列。
  V_STR := 'CREATE TABLE T_PA_RESULT AS SELECT  ''' || V_PA_MONTH ||
           ''' AS PA_MONTH,''' || V_PA_FORMULAR_MONTH ||
           ''' AS PA_FORMULAR_MONTH,';

  -- 验证计算项目名称是否重复
  BEGIN
    SELECT ITEM_ID
      INTO V_ITEM_ID
      FROM (SELECT ITEM_ID, COUNT(ITEM_ID) AS NUM
              FROM PA_ITEM
              WHERE ACTIVITY = 1
             GROUP BY ITEM_ID) P
     WHERE P.NUM > 1
       AND ROWNUM = 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_ITEM_ID := NULL;
  END;

  -- 如果计算项目名称重复提示错误
  IF V_ITEM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误: 工资项目ID"' || V_ITEM_ID || '"出现重复,请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 验证输入项目名称是否重复
  BEGIN
    SELECT PARAM_ID
      INTO V_ITEM_ID
      FROM (SELECT PARAM_ID, COUNT(PARAM_ID) AS NUM
              FROM PA_PARAM_ITEM
             WHERE ACTIVITY = 1
             GROUP BY PARAM_ID)
     WHERE NUM > 1
     AND ROWNUM = 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_ITEM_ID := NULL;
  END;

  -- 如果输入项目名称重复提示错误
  IF V_ITEM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误: 输入项目ID"' || V_ITEM_ID || '"出现重复,请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 验证输入项目名称是否与接口表的字段名称重复
  BEGIN
    SELECT DISTINCT_FIELD
      INTO V_ITEM_ID
      FROM PA_DISTINCT_LIST
     WHERE DISTINCT_FIELD IN
           (SELECT PARAM_ID FROM PA_PARAM_ITEM WHERE ACTIVITY = 1 AND CPNY_ID = V_CPNY_ID);

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_ITEM_ID := NULL;
  END;

  -- 如果输入项目名称与接口表的字段名称重复提示错误
  IF V_ITEM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误：工资输入项目ID“' || V_ITEM_ID || '”和人事项目ID“' ||
                      V_ITEM_ID || '”出现重复。请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 验证计算项目名称是否与接口表的字段名称重复
  BEGIN
    SELECT DISTINCT_FIELD
      INTO V_ITEM_ID
      FROM PA_DISTINCT_LIST
     WHERE DISTINCT_FIELD IN (SELECT ITEM_ID FROM PA_ITEM)
     AND ROWNUM = 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_ITEM_ID := NULL;
  END;

  -- 如果计算项目名称与接口表的字段名称重复提示错误
  IF V_ITEM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误： 工资计算项目ID“' || V_ITEM_ID || '”和人事项目ID“' ||
                      V_ITEM_ID || '”出现重复。请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 验证计算项目名称是否与输入项目名称重复
  BEGIN
    SELECT PA_PARAM_ITEM.PARAM_ID
      INTO V_PARAM_ID
      FROM PA_PARAM_ITEM, PA_ITEM
     WHERE PA_PARAM_ITEM.PARAM_ID = PA_ITEM.ITEM_ID
       AND ROWNUM = 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_PARAM_ID := NULL;
  END;

  -- 如果计算项目名称与输入项目名称重复提示错误
  IF V_PARAM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误： 输入ID“' || V_PARAM_ID || '”和工资项目ID“' ||
                      V_PARAM_ID || '”出现重复。请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 拼接人事数据列
  FOR HR_ROW IN CUS_HR LOOP
    -- 拼接创建表T_PA_RESULT的SQL字符串
    V_STR := V_STR || HR_ROW.TABLE_NAME || '.' || HR_ROW.DISTINCT_FIELD ||
             ' AS ' || HR_ROW.DISTINCT_FIELD || ',' || CHR(13);
  END LOOP;

  -- 拼接工资输入项目列
  FOR PAR_ROW IN CUS_PARAM LOOP
    BEGIN
      V_STR := V_STR || (CASE UPPER(SUBSTR(PAR_ROW.DATATYPE, 1, 4))
                 WHEN 'NUMB' THEN
                  '0'
                 WHEN 'VARC' THEN
                  '''                                                                                                                                                                                                            '''
                 WHEN 'CHAR' THEN
                  ''''
                 WHEN 'DATE' THEN
                  'SYSDATE'
               --此处留50空格确定此列长宽度
               END) || ' AS "' || PAR_ROW.PARAM_ID || '" ,' || CHR(13);
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20101,'工资参数数据类型错误: [' || PAR_ROW.PARAM_ID || ']');
    END;
  END LOOP;

  -- 拼接工资项目列
  FOR PA_ROW IN CUS_ITEM LOOP
    V_STR := V_STR || (CASE PA_ROW.DATATYPE
               WHEN 'NUMBER(14,4)' THEN
                '0'
               WHEN 'NUMBER' THEN
                '0'
               WHEN 'VARCHAR2' THEN
                '''                                                  '''
               WHEN 'VARCHAR2(50)' THEN
                '''                                                  '''
               WHEN 'VARCHAR2(200)' THEN
                '''                                                                                                                                                      '''
             --此处留50空格确定此列长宽度
               ELSE
                ''' '''
             END) || ' AS "' || PA_ROW.ITEM_ID || '" ,' || CHR(13);
  END LOOP;

  --去 掉最后逗号
  V_STR              := SUBSTR(V_STR, 0, LENGTH(V_STR) - 2);

  ---创建 计算结果表 并插入人事及数据
  V_STR := V_STR ||
           ' FROM PA_HR_V '||
           ' WHERE 1=1' ;

  DBMS_OUTPUT.PUT_LINE('THIS IS CREATE TABLE STRING');

  -- 日志输出
  IF V_OUTPUT_TYPE IN ('ALL') THEN
    I := 0;
    WHILE I * 150 <= LENGTH(V_STR) LOOP
      DBMS_OUTPUT.PUT_LINE(SUBSTR(V_STR, I * 150, 150));
      I := I + 1;
    END LOOP;
  END IF;

  -- 楠岃瘉T_PA_RESULT鏄惁瀛樺湪锛屽鏋滃瓨鍦ㄥ垹闄よ琛
  SELECT COUNT(*)
    INTO R_COUNT
    FROM USER_TAB_COLUMNS
   WHERE TABLE_NAME = 'T_PA_RESULT';

  IF R_COUNT > 0 THEN
    BEGIN
      EXECUTE IMMEDIATE 'DROP TABLE T_PA_RESULT';
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20101, '删除 T_PA_RESULT 失败', TRUE);
    END;
  END IF;

  -- 执行创建表T_PA_RESULT的SQL
  IF V_EXEC_MODE IN ('NORMAL', 'ONLY_CREATE_TABLE', 'PARAM', 'PAITEM') THEN
    BEGIN
      dbms_output.PUT_LINE(V_STR);
      EXECUTE IMMEDIATE V_STR;
      DBMS_OUTPUT.put_line(V_STR);
      EXECUTE IMMEDIATE 'ALTER TABLE T_PA_RESULT ADD CONSTRAINT PK_T_PA_RESULT PRIMARY KEY (EMPID) ';

      COMMIT;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20101, '创建计算结果表失败: [' ||SUBSTR(V_STR, LENGTH(V_STR) - 300, LENGTH(V_STR)) || ']',
                                TRUE);
    END;
  END IF;
  ----------------------------------------------------------  输入项目计算 ---------------------------------------------------------
  DBMS_OUTPUT.PUT_LINE(CHR(13) || ' ----------    THIS IS THE CALCULATE PARAM DATA STRING ----------');

  FOR PAR_VAL IN CUS_PARAM LOOP
    -- 创建更新T_PA_RESULT输入项目的SQL
    V_PSTR := 'UPDATE T_PA_RESULT SET "' || PAR_VAL.PARAM_ID || '" =NVL(' ||
              ' (SELECT p.return_value FROM  PA_PARAM_DATA  P WHERE '||
                ' P.PA_MONTH = '||V_PA_MONTH ||' AND P.ACTIVITY = 1 AND '||
                  PAR_VAL.DISTINCT_FIELD_1ST || '  = P.FIELD1_VALUE ' || CASE
                WHEN TRIM(PAR_VAL.DISTINCT_FIELD_2ND) IS NOT NULL THEN
                 ' AND ' || PAR_VAL.DISTINCT_FIELD_2ND || ' = P.FIELD2_VALUE '
              END || ' AND P.PARAM_NO=' || TO_CHAR(PAR_VAL.PARAM_NO) ||
              ' ),''' || PAR_VAL.DEFAULT_VAL || ''')';

    IF V_OUTPUT_TYPE IN ('ALL', 'PARAM') THEN
      I := 0;
      WHILE I * 150 <= LENGTH(V_PSTR) LOOP
        DBMS_OUTPUT.PUT_LINE(SUBSTR(V_PSTR, I * 150, 150));
        I := I + 1;
      END LOOP;
    END IF;

    -- 更新T_PA_RESULT输入项目的SQL
    IF V_EXEC_MODE IN ('NORMAL', 'PARAM') THEN
      BEGIN
        EXECUTE IMMEDIATE V_PSTR;
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20101,'参数计算失败: [' || V_PSTR || ']');
      END;
    END IF;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('----------CALCULATE PARAM DATA STRING FINISHED-----------');

  ---------------------------------------------------   工资项目计算   -------------------------------------------------------------
  DBMS_OUTPUT.PUT_LINE(CHR(13) || '  -------------------  THIS IS THE CALCU PA ITEMS STRING ---------');
  BEGIN

    FOR PAITEM_VAL IN CUS_ITEM LOOP

      -- 字符类型工资项目
      IF PAITEM_VAL.DATATYPE = 'VARCHAR2' THEN
        V_CASTR := CHR(13) || 'UPDATE T_PA_RESULT set "' ||
                   PAITEM_VAL.ITEM_ID || '" = ';
        -- 数值类型工资项目
      ELSE
        V_CASTR := CHR(13) || 'UPDATE T_PA_RESULT set "' ||
                   PAITEM_VAL.ITEM_ID || '" = TRUNC((' ||
                   PAITEM_VAL.CARRY_BIT || ' + ';
      END IF;

      /************************************************计算所有工资项目**************************************
         鍏紡浜旂鎯呭喌锛
         1.    无公式                  0
         2.    鍗曚竴鍏紡鏃犳潯浠?         鐩存帴鍒楀叕寮
         3.    单一公式有条件          CASE WHEN 条件 THEN 公式 ELSE 0 END
         4.    多公式均有条件          CASE 循环(WHEN 条件 THEN 公式) ELSE 0 END
         5.    多公式，其中一条无条件  CASE 循环(WHEN 条件 THEN 公式) ELSE 公式 END
      *******************************************************************************************************/

      SELECT COUNT(*)
        INTO V_FOMULAR_COUNT
        FROM PA_FORMULAR
       WHERE ITEM_NO = PAITEM_VAL.ITEM_NO
         AND ACTIVITY = 1;

      -- 取得当前工资项目的空公式条件数量
      SELECT COUNT(*)
        INTO V_CONDITION_COUNT
        FROM PA_FORMULAR
       WHERE ITEM_NO = PAITEM_VAL.ITEM_NO
         AND ACTIVITY = 1
         AND (REPLACE(REPLACE(RTRIM(LTRIM(CONDITION)), CHR(9), ''), ' ', '') = '' OR
             CONDITION IS NULL);

      IF V_FOMULAR_COUNT = 0 THEN
        V_CASTR := V_CASTR || '0';
      ELSIF V_FOMULAR_COUNT = 1 AND V_CONDITION_COUNT = 1 THEN
        SELECT V_CASTR || FORMULAR
          INTO V_CASTR
          FROM PA_FORMULAR
         WHERE ITEM_NO = PAITEM_VAL.ITEM_NO
           AND ACTIVITY = 1;
      ELSE
        V_CASTR := V_CASTR || ' CASE ';

        FOR FORMULAR_ROW IN CUS_FORMULAR(PAITEM_VAL.ITEM_NO) LOOP
          IF REPLACE(REPLACE(RTRIM(LTRIM(FORMULAR_ROW.CONDITION)),
                             CHR(9),
                             ''),
                     ' ',
                     '') = '' OR FORMULAR_ROW.CONDITION IS NULL THEN
            V_FORMULAR_NOCONDITION := FORMULAR_ROW.FORMULAR;
          ELSE
            V_CASTR := V_CASTR || ' WHEN ' || FORMULAR_ROW.CONDITION ||
                       ' THEN ' || FORMULAR_ROW.FORMULAR;
          END IF;
        END LOOP;

        IF V_CONDITION_COUNT = 0 THEN
          -- 字符类型工资项目
          IF PAITEM_VAL.DATATYPE = 'VARCHAR2' THEN
            V_CASTR := V_CASTR || ' ELSE '''' END ';
          ELSE
            V_CASTR := V_CASTR || ' ELSE 0 END ';
          END IF;
        ELSE
          V_CASTR := V_CASTR || ' ELSE ' || V_FORMULAR_NOCONDITION ||
                     ' END ';
        END IF;
      END IF;

      -- 数值类型工资项目
      IF PAITEM_VAL.DATATYPE <> 'VARCHAR2' THEN
        V_CASTR := V_CASTR || '),' || PAITEM_VAL.PRECISION || ')';
      END IF;

      IF V_OUTPUT_TYPE IN ('ALL', 'PAITEM') THEN
        I := 0;
        WHILE I * 150 <= LENGTH(V_CASTR) LOOP
          DBMS_OUTPUT.PUT_LINE(SUBSTR(V_CASTR, I * 150, 150));
          I := I + 1;
        END LOOP;
      END IF;

      IF V_EXEC_MODE IN ('NORMAL', 'PAITEM') THEN
        BEGIN
          --DBMS_OUTPUT.PUT_LINE(V_CASTR);
          EXECUTE IMMEDIATE V_CASTR;
          COMMIT;
        EXCEPTION
          WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20101, '计算项目计算失败: [' || V_CASTR || ']',TRUE);
        END;
      END IF;

    END LOOP;

  END;

  COMMIT;

  PA_CONFIRM(V_OUTPUT_STR);

  EXECUTE IMMEDIATE ' SELECT COUNT(EMPID) FROM T_PA_RESULT '
    INTO V_EMP_COUNT;

  V_OUTPUT_STR := V_EMP_COUNT || '   人工资计算成功完成. 用时 ' ||
                  TRUNC((SYSDATE - V_TIME) * 24 * 60 * 60 + 0.005, 2) || ' 秒';

END;
/

prompt
prompt Creating procedure PA_PARAM_INITIAL
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE PA_Param_Initial (v_pamonth VARCHAR2)
IS
   -- 取得上个月的输入项目列表
   CURSOR cus_prm
   IS
      SELECT *
        FROM PA_PARAM_ITEM
       WHERE ACTIVITY = 1;

   v_old_param_no         NUMBER;
   v_param_name           VARCHAR2 (100);
   v_new_param_no         NUMBER;
   v_param_type_code   VARCHAR2 (50);
   v_distinct_field       VARCHAR2 (50);
   v_return_str           VARCHAR2 (5000);
BEGIN

   -- 循环上月的所有输入项目
   FOR row_paitem IN cus_prm
   LOOP
      v_param_name := row_paitem.param_name;
      v_old_param_no := row_paitem.param_no;
      v_param_type_code := row_paitem.param_type_code;
      v_distinct_field := row_paitem.Distinct_Field_1st;

      CASE
	     -- 如果第一个区分项目为“工号”

         WHEN v_distinct_field = 'EMPID'
         THEN

			  -- 复制上月输入项目值的值到本月
            IF v_param_type_code = 'CLEAN'           -- 参数类型：清除全部数据
            THEN
               BEGIN
                  --- COPY DATA FROM PRIOR MONTH
                  INSERT INTO PA_PARAM_DATA
                              (param_data_no, param_no, return_value,FIELD1_EN_VALUE,
                            FIELD1_VALUE,FIELD2_EN_VALUE,FIELD2_VALUE,CPNY_ID,PA_MONTH,activity)
                     SELECT pa_param_data_seq.NEXTVAL, v_old_param_no,row_paitem.default_val,FIELD1_EN_VALUE,
                            FIELD1_VALUE,FIELD2_EN_VALUE,FIELD2_VALUE,CPNY_ID,v_pamonth,activity
                       FROM PA_PARAM_DATA
                      WHERE param_no = v_old_param_no
                        AND pa_month = Prior_Pamonth (v_pamonth)
                        AND ACTIVITY = 1
                        AND (SELECT COUNT(*) FROM PA_PARAM_DATA WHERE PA_MONTH = V_PAMONTH AND ACTIVITY = 1 AND PARAM_NO = v_old_param_no)=0;
                        
               END;
            ELSIF v_param_type_code = 'CLONE'         -- 参数类型：原样复制
            THEN
               INSERT INTO PA_PARAM_DATA
                           (param_data_no, param_no,return_value,FIELD1_EN_VALUE,
                            FIELD1_VALUE,FIELD2_EN_VALUE,FIELD2_VALUE,CPNY_ID,PA_MONTH,activity)
                  SELECT pa_param_data_seq.NEXTVAL, v_old_param_no, return_value,FIELD1_EN_VALUE,
                            FIELD1_VALUE,FIELD2_EN_VALUE,FIELD2_VALUE,CPNY_ID,v_pamonth,activity
                    FROM PA_PARAM_DATA
                   WHERE param_no = v_old_param_no
                        AND pa_month = Prior_Pamonth (v_pamonth)
                        AND ACTIVITY = 1
                       AND (SELECT COUNT(*) FROM PA_PARAM_DATA WHERE PA_MONTH = V_PAMONTH AND ACTIVITY = 1 AND PARAM_NO = v_old_param_no)=0;
                        
            ELSIF v_param_type_code = 'ALL_ZERO'      -- 参数类型：清零并补缺
            THEN
               BEGIN
                  --Pr_Param_List (v_new_param_no);

                  INSERT INTO PA_PARAM_DATA
                              (param_data_no, param_no, return_value,FIELD1_EN_VALUE,
                            FIELD1_VALUE,FIELD2_EN_VALUE,FIELD2_VALUE,CPNY_ID,PA_MONTH,activity)
                     SELECT pa_param_data_seq.NEXTVAL, v_old_param_no,0,FIELD1_EN_VALUE,
                             FIELD1_VALUE, FIELD2_EN_VALUE, FIELD2_VALUE,CPNY_ID,V_PAMONTH,activity
                       FROM PA_PARAM_DATA
                      WHERE FIELD1_VALUE IN (SELECT empid
                                               FROM HR_EMP_PA_INFO
                                              WHERE CALC_FLAG = 'Y');
               END;
            ELSE   							  		  -- 参数类型：清除全部数据
               v_return_str :=
                     v_return_str
                  || v_param_name
                  || '   '
                  || v_param_type_code
                  || CHR (13);
            END IF;

		 -- 如果第一个区分项目不为“工号”
         ELSE

			-- 复制上月输入项目值的值到本月
            IF v_distinct_field IN ('(CONST)', '(CONST)')
            THEN
               INSERT INTO PA_PARAM_DATA
                           (param_data_no, param_no, return_value,FIELD1_EN_VALUE,
                            FIELD1_VALUE,FIELD2_EN_VALUE,FIELD2_VALUE)
                  SELECT pa_param_data_seq.NEXTVAL, v_old_param_no, return_value,FIELD1_EN_VALUE,
                            FIELD1_VALUE,FIELD2_EN_VALUE,FIELD2_VALUE
                    FROM PA_PARAM_DATA
                   WHERE param_no = v_old_param_no;
            ELSIF v_param_type_code = 'ALL'	   	 		-- 参数类型：复制并补缺
            THEN
               BEGIN
                  --- COPY DATA FROM PRIOR MONTH
                  INSERT INTO PA_PARAM_DATA
                              (param_data_no, param_no, return_value,FIELD1_EN_VALUE,
                            FIELD1_VALUE,FIELD2_EN_VALUE,FIELD2_VALUE)
                     SELECT pa_param_data_seq.NEXTVAL, v_old_param_no, return_value,FIELD1_EN_VALUE,
                            FIELD1_VALUE,FIELD2_EN_VALUE,FIELD2_VALUE
                       FROM PA_PARAM_DATA
                      WHERE param_no = v_old_param_no
                        AND NOT (   return_value IS NULL
                                 OR LENGTH (return_value) = 0
                                 OR return_value = 'NULL'
                                );

                  --  INSERT LOSED DATA INTO PA_PARAM_DATA THE DEFAULT VALUE SET AS 0
                  --Pr_Param_List (v_new_param_no);

                  INSERT INTO PA_PARAM_DATA
                              (param_data_no, param_no,return_value,FIELD1_EN_VALUE,
                            FIELD1_VALUE,FIELD2_EN_VALUE,FIELD2_VALUE)
                     SELECT pa_param_data_seq.NEXTVAL, v_old_param_no,
                            0,FIELD1_EN_VALUE,FIELD1_VALUE,FIELD2_EN_VALUE,FIELD2_VALUE
                       FROM PA_PARAM_DATA;
               END;
            ELSIF v_param_type_code = 'CLONE'	   		 -- 参数类型：原样复制
            THEN
               INSERT INTO PA_PARAM_DATA
                           (param_data_no, param_no, return_value,FIELD1_EN_VALUE,
                            FIELD1_VALUE,FIELD2_EN_VALUE,FIELD2_VALUE)
                  SELECT pa_param_data_seq.NEXTVAL, v_old_param_no, return_value,FIELD1_EN_VALUE,
                            FIELD1_VALUE,FIELD2_EN_VALUE,FIELD2_VALUE
                    FROM PA_PARAM_DATA
                   WHERE param_no = v_old_param_no
                     AND NOT (   return_value IS NULL
                              OR LENGTH (return_value) = 0
                              OR return_value = 'NULL'
                             );
            ELSIF v_param_type_code = 'ALL_ZERO'	       -- 参数类型：清零并补缺
            THEN
               BEGIN
                  --Pr_Param_List (v_new_param_no);
                  -------------------------------------------------------------------
                  INSERT INTO PA_PARAM_DATA
                              (param_data_no, param_no,return_value,FIELD1_EN_VALUE,
                            FIELD1_VALUE,FIELD2_EN_VALUE,FIELD2_VALUE)
                     SELECT pa_param_data_seq.NEXTVAL, v_old_param_no, 0, FIELD1_EN_VALUE,FIELD1_VALUE,FIELD2_EN_VALUE,FIELD2_VALUE
                       FROM PA_PARAM_DATA;
               END;
            ELSE   	   						   		     -- 参数类型：清除全部数据
               v_return_str :=
                     v_return_str
                  || v_param_name
                  || '   '
                  || v_param_type_code
                  || CHR (13);
            END IF;
         END CASE;

   END LOOP;
   COMMIT;
END;
/

prompt
prompt Creating procedure PROCESS_GET_PROCESSNO
prompt ========================================
prompt
CREATE OR REPLACE PROCEDURE PROCESS_GET_PROCESSNO(IN_OBJECT_ID IN VARCHAR2,
                                       IN_OBJECT_TYPE_ID       IN VARCHAR2,
                                       IN_OBJECT_STATUS_ID     IN VARCHAR2,
                                       IN_CPNY_ID              IN VARCHAR2,
                                       OUT_PROCESSNO           OUT VARCHAR2)
IS
      AFFIRMORCOUNT INT:=0;
BEGIN
  DECLARE
      CURSOR CUS_AFFIRMOR IS
      SELECT PAR.AFFIRMOR_ID
      FROM PROCESS_AFFIRM_RELATION PAR
      WHERE PAR.OBJECT_TYPE_ID = IN_OBJECT_TYPE_ID
        AND   PAR.OBJECT_STATUS_ID = IN_OBJECT_STATUS_ID
        AND   PAR.ACTIVITY = 1
        AND   PAR.CPNY_ID = IN_CPNY_ID;
      AFFIRMOR_ROW CUS_AFFIRMOR%ROWTYPE;
  BEGIN
      SELECT COUNT(0) INTO AFFIRMORCOUNT
      FROM PROCESS_AFFIRM_RELATION PAR
      WHERE PAR.OBJECT_TYPE_ID = IN_OBJECT_TYPE_ID
        AND   PAR.OBJECT_STATUS_ID = IN_OBJECT_STATUS_ID
        AND   PAR.ACTIVITY = 1
        AND   PAR.CPNY_ID = IN_CPNY_ID;

      IF AFFIRMORCOUNT = 0 THEN
         OUT_PROCESSNO := NULL;
      END IF;
      
      IF AFFIRMORCOUNT != 0 THEN
         OUT_PROCESSNO := PROCESS_AFFIRM_SEQ.NEXTVAL;
         
         OPEN CUS_AFFIRMOR;
         LOOP
            FETCH CUS_AFFIRMOR INTO AFFIRMOR_ROW;
         EXIT WHEN CUS_AFFIRMOR%NOTFOUND;
             INSERT INTO PROCESS_AFFIRM(PROCESS_AFFIRM_NO,OBJECT_ID,OBJECT_TYPE_ID,OBJECT_STATUS_ID,
                 CREATE_DATE,ACTIVITY,CPNY_ID,AFFIRMOR_ID,AFFIRM_FLAG)
             VALUES(OUT_PROCESSNO,IN_OBJECT_ID,IN_OBJECT_TYPE_ID,IN_OBJECT_STATUS_ID,
                 SYSDATE,1,IN_CPNY_ID,AFFIRMOR_ROW.AFFIRMOR_ID,0);
         END LOOP;
         COMMIT;
      END IF;
  END;
END;
/

prompt
prompt Creating procedure PRO_OUTSTORAGE_CHECK
prompt =======================================
prompt
create or replace procedure PRO_OUTSTORAGE_CHECK(
  STOR_NO VARCHAR2,
  PRO_NO VARCHAR2,
  CP_ID VARCHAR2,
  CRE_BY VARCHAR2
)
is
  VAR_MINQUANTITY NUMBER;
  VAR_QUANTITY NUMBER;
  VAR_PRO_NAME VARCHAR2(500);
  VAR_STOR_NAME VARCHAR2(200);
  VAR_WARNING_ROW PROSTOR_STORAGE_WARNING%ROWTYPE;
  CURSOR STORAGE_WARNING
  IS
      SELECT *
      FROM PROSTOR_STORAGE_WARNING
      WHERE ACTIVITY = 1
      AND CPNY_ID = CP_ID;
BEGIN
  BEGIN
    SELECT NVL(PSPP.MIN_QUANTITY,0),NVL(PSP.LEFT_QUANTITY,0),PP.PRODUCT_NAME,PSI.STORAGE_NAME INTO
           VAR_MINQUANTITY,VAR_QUANTITY,VAR_PRO_NAME,VAR_STOR_NAME
    FROM PROSTOR_STORAGE_PRODUCT PSP,
    (SELECT PRODUCT_NO,MIN_QUANTITY
          FROM PROSTOR_STORAGE_PRODUCT_PARAM
          WHERE ACTIVITY = 1
          AND CPNY_ID = CP_ID
          AND STORAGE_NO = STOR_NO
          AND PRODUCT_NO = PRO_NO) PSPP,
        PROSTOR_PRODUCT PP,
        PROSTOR_STORAGE_INFO PSI
    WHERE PSP.PRODUCT_NO = PSPP.PRODUCT_NO(+)
    AND PSP.PRODUCT_NO = PP.PRODUCT_NO(+)
    AND PSP.STORAGE_NO = PSI.STORAGE_NO(+)
    AND PSP.ACTIVITY = 1
    AND PSP.CPNY_ID = CP_ID
    AND PSP.STORAGE_NO = STOR_NO
    AND PSP.PRODUCT_NO = PRO_NO;
  EXCEPTION
      WHEN NO_DATA_FOUND THEN
        VAR_MINQUANTITY := 0;
        VAR_QUANTITY := 0;
  END;

  IF VAR_MINQUANTITY > 0 AND VAR_QUANTITY < VAR_MINQUANTITY THEN
    OPEN STORAGE_WARNING;
    LOOP
      FETCH STORAGE_WARNING INTO VAR_WARNING_ROW;
      EXIT WHEN STORAGE_WARNING%NOTFOUND;

        INSERT INTO SY_MESSAGE(MESSAGE_NO,MESSAGE_ID,MESSAGE_TITLE,MESSAGE_CONTENT,MESSAGE_TYPE,CREATE_DATE,CREATED_BY,ACTIVITY,CPNY_ID)
        VALUES(SY_MESSAGE_SEQ.NEXTVAL,'Message'||SY_MESSAGE_SEQ.CURRVAL,VAR_STOR_NAME||'-'||VAR_PRO_NAME||'-库存预警',
        VAR_STOR_NAME||'，'||VAR_PRO_NAME||'商品，于'||TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS')||'，库存量('||VAR_QUANTITY||')小于最小库存量('||VAR_MINQUANTITY||')'
        ||',请及时补充采购。',
        VAR_WARNING_ROW.MESSAGE_TYPE_ID,SYSDATE,'system',1,CP_ID);

        IF VAR_WARNING_ROW.MESSAGE_TYPE_ID = 'EMPID' THEN
          INSERT INTO SY_MESSAGE_EMP_DETAIL(MESSAGE_NO,EMPID,IS_READ,CREATE_DATE,CREATED_BY,ACTIVITY,CPNY_ID,MESSAGE_TYPE)
          VALUES(SY_MESSAGE_SEQ.CURRVAL,VAR_WARNING_ROW.TARGET_ID,2,SYSDATE,CRE_BY,1,CP_ID,VAR_WARNING_ROW.MESSAGE_TYPE_ID);
        ELSE
          MESSAGE_ADD_EMP(SY_MESSAGE_SEQ.CURRVAL,CRE_BY,CP_ID,VAR_WARNING_ROW.TARGET_ID,VAR_WARNING_ROW.TARGET_ID,VAR_WARNING_ROW.MESSAGE_TYPE_ID);
        END IF;

    END LOOP;
  END IF;


end PRO_OUTSTORAGE_CHECK;
/

prompt
prompt Creating procedure PRO_DOOUTOFSTORAGE
prompt =====================================
prompt
create or replace procedure PRO_DOOUTOFSTORAGE(
  STOR_NO IN VARCHAR2,
  STOR_NAME IN VARCHAR2,
  PRO_NO IN VARCHAR2,
  PRO_NAME IN VARCHAR2,
  PRO_PRICE IN VARCHAR2,
  CURR_OUT_NUM IN VARCHAR2,
  SAL_ORD_NO IN VARCHAR2,
  UPDA_BY IN VARCHAR2,
  COMP_ID IN VARCHAR2,
  SERIALNUM IN VARCHAR2,
  PRO_ID IN VARCHAR2,
  PRO_NUM IN VARCHAR2,
  PRO_CAS IN VARCHAR2,
  SPECIFICATION IN VARCHAR2,
  UNIT_NAME IN VARCHAR2,
  DISCOUNT IN VARCHAR2,
  returnMsg IN OUT VARCHAR)
is
  VAR_LEFT_QUANTITY NUMBER;
  VAR_OUT_QUANTITY NUMBER;
  VAR_NUM1 NUMBER;
  VAR_NUM2 NUMBER;
  VAR_STOR_ADDR VARCHAR2(100);
begin
  SELECT NVL(PSP.LEFT_QUANTITY,0) INTO VAR_LEFT_QUANTITY
         FROM PROSTOR_STORAGE_PRODUCT PSP
         WHERE PSP.STORAGE_NO = STOR_NO
         AND PSP.PRODUCT_NO = PRO_NO
         AND PSP.CPNY_ID = COMP_ID;
  UPDATE PROSTOR_STORAGE_PRODUCT PSP
         SET PSP.LEFT_QUANTITY = VAR_LEFT_QUANTITY-TO_NUMBER(CURR_OUT_NUM),
             PSP.UPDATED_BY = UPDA_BY,
             PSP.UPDATE_DATE = SYSDATE
         WHERE PSP.STORAGE_NO = STOR_NO
          AND PSP.PRODUCT_NO = PRO_NO;
  SELECT NVL(PSOD.OUT_QUANTITY,0) INTO VAR_OUT_QUANTITY
         FROM PROSTOR_SALES_ORDER_DETAIL PSOD
         WHERE PSOD.SALES_ORDER_NO = SAL_ORD_NO
         AND PSOD.PRODUCT_NO = PRO_NO
         AND PSOD.CPNY_ID = COMP_ID;
  UPDATE PROSTOR_SALES_ORDER_DETAIL PSOD
         SET PSOD.OUT_QUANTITY = VAR_OUT_QUANTITY+TO_NUMBER(CURR_OUT_NUM),
             PSOD.UPDATE_DATE = SYSDATE,
             PSOD.UPDATED_BY = UPDA_BY
         WHERE PSOD.SALES_ORDER_NO = SAL_ORD_NO
         AND PSOD.PRODUCT_NO = PRO_NO
         AND PSOD.CPNY_ID = COMP_ID;
  UPDATE PROSTOR_SALES_ORDER PSO
         SET PSO.STATUS = 'outStatus2',
             PSO.UPDATE_DATE = SYSDATE,
             PSO.UPDATED_BY = UPDA_BY
         WHERE PSO.SALES_ORDER_NO = SAL_ORD_NO
         AND PSO.CPNY_ID = COMP_ID;
  SELECT COUNT(0) INTO VAR_NUM1
         FROM PROSTOR_SALES_ORDER_DETAIL B
         WHERE B.ACTIVITY = 1
         AND B.CPNY_ID = COMP_ID
         AND B.QUANTITY=B.OUT_QUANTITY
         AND B.SALES_ORDER_NO = SAL_ORD_NO;
  SELECT COUNT(0) INTO VAR_NUM2
         FROM PROSTOR_SALES_ORDER_DETAIL A
         WHERE A.ACTIVITY = 1
         AND A.CPNY_ID = COMP_ID
         AND A.SALES_ORDER_NO = SAL_ORD_NO;
  IF VAR_NUM1=VAR_NUM2 THEN
    UPDATE PROSTOR_SALES_ORDER PSO
         SET PSO.STATUS = 'outStatus1',
             PSO.UPDATE_DATE = SYSDATE,
             PSO.UPDATED_BY = UPDA_BY
         WHERE PSO.SALES_ORDER_NO = SAL_ORD_NO
         AND PSO.CPNY_ID = COMP_ID;
  END IF;
  SELECT NVL((SELECT PSPP.STOR_ADDR FROM PROSTOR_STORAGE_PRODUCT_PARAM PSPP
         WHERE PSPP.STORAGE_NO = STOR_NO
               AND PSPP.PRODUCT_NO = PRO_NO
               AND PSPP.ACTIVITY = 1
               AND PSPP.CPNY_ID = COMP_ID),'') INTO VAR_STOR_ADDR FROM DUAL;
  INSERT INTO PROSTOR_OUTSTORAGE_PRODUCT(
         OUTSTORAGE_ID,
         PRODUCT_NO,
         PRODUCT_ID,
         PRODUCT_NAME,
         STORAGE_NO,
         STORAGE_NAME,
         PRICE,
         QUANTITY,
         DISCOUNT,
         DIS_MONEY,
         MONEY,
         PRODUCT_NUM,
         PRODUCT_CAS,
         STOR_ADDR,
         SPECIFICATION,
         UNIT_NAME,
         CREATE_DATE,
         CREATED_BY,
         CPNY_ID
  )VALUES(
         SERIALNUM,
         PRO_NO,
         PRO_ID,
         PRO_NAME,
         STOR_NO,
         STOR_NAME,
         PRO_PRICE,
         CURR_OUT_NUM,
         DISCOUNT,
         TO_NUMBER(PRO_PRICE)*TO_NUMBER(CURR_OUT_NUM)*TO_NUMBER(DISCOUNT),
         TO_NUMBER(PRO_PRICE)*TO_NUMBER(CURR_OUT_NUM),
         NVL(PRO_NUM,''),
         NVL(PRO_CAS,''),
         VAR_STOR_ADDR,
         SPECIFICATION,
         UNIT_NAME,
         SYSDATE,
         UPDA_BY,
         COMP_ID
  );

  PRO_OUTSTORAGE_CHECK(STOR_NO,PRO_NO,COMP_ID,UPDA_BY);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      returnMsg := '未发现数据';
      ROLLBACK;
    WHEN TOO_MANY_ROWS THEN
      returnMsg := '符合要求的数据太多';
      ROLLBACK;
    WHEN OTHERS THEN
      returnMsg := '未知错误';
      ROLLBACK;
end PRO_DOOUTOFSTORAGE;
/

prompt
prompt Creating procedure PRO_INSTORAGE
prompt ================================
prompt
CREATE OR REPLACE PROCEDURE PRO_INSTORAGE(
       IN_STORAGE_NO VARCHAR2,
       IN_PRODUCT_NO VARCHAR2,
       IN_QUANTITY NUMBER,
       IN_QUANTITY_UNIT_CODE VARCHAR2,
       IN_EMPID VARCHAR2,
       IN_CPNY_ID VARCHAR2,
       IN_INSTORAGE_ID VARCHAR2,
       IN_PARCHASE_ORDER_ID VARCHAR2,
       IN_SUPPLIER_NO VARCHAR2,
       IN_UNIT_PRICE NUMBER
       )
IS
       VAR_COUNT NUMBER(10);
       VAR_SUM NUMBER;                              --
       VAR_PRE_PRICE NUMBER;                        --之前价格
       VAR_NEXT_PRICE NUMBER;                       --新价格
       VAR_QUANTITY NUMBER;
       VAR_IN_QUANTITY NUMBER;
       VAR_PRODUCT PROSTOR_PRODUCT%ROWTYPE;
       VAR_CODE_NAME VARCHAR2(20);
       VAR_STORAGE_NAME VARCHAR2(50);
       VAR_STOR_ADDR VARCHAR2(100);
BEGIN

       SELECT NVL(SUM(PSP.LEFT_QUANTITY),0) INTO VAR_SUM
       FROM PROSTOR_STORAGE_PRODUCT PSP
       WHERE PSP.PRODUCT_NO = IN_PRODUCT_NO
       AND   PSP.ACTIVITY = 1
       AND   PSP.CPNY_ID = IN_CPNY_ID;
       SELECT NVL(PP.UNIT_PRICE,0) INTO VAR_PRE_PRICE
       FROM PROSTOR_PRODUCT PP
       WHERE PP.PRODUCT_NO = IN_PRODUCT_NO
       AND   PP.ACTIVITY = 1
       AND   PP.CPNY_ID = IN_CPNY_ID
       AND   ROWNUM=1;





       SELECT COUNT(*) INTO VAR_COUNT
       FROM   PROSTOR_STORAGE_PRODUCT PSP
       WHERE  PSP.STORAGE_NO = IN_STORAGE_NO
       AND    PSP.PRODUCT_NO = IN_PRODUCT_NO
       AND    PSP.ACTIVITY = 1
       AND    PSP.CPNY_ID = IN_CPNY_ID;

       IF VAR_COUNT > 0 THEN
         UPDATE PROSTOR_STORAGE_PRODUCT
         SET LEFT_QUANTITY = NVL(LEFT_QUANTITY,0)+IN_QUANTITY,
             UPDATED_BY = IN_EMPID,
             UPDATE_DATE = SYSDATE
         WHERE STORAGE_NO = IN_STORAGE_NO
         AND PRODUCT_NO = IN_PRODUCT_NO
         AND ACTIVITY = 1
         AND CPNY_ID = IN_CPNY_ID;
       ELSE
         INSERT INTO PROSTOR_STORAGE_PRODUCT(STORAGE_NO,PRODUCT_NO,LEFT_QUANTITY,QUANTITY_UNIT_CODE,CREATE_DATE,CREATED_BY,ACTIVITY,CPNY_ID)
         VALUES(IN_STORAGE_NO,IN_PRODUCT_NO,IN_QUANTITY,IN_QUANTITY_UNIT_CODE,SYSDATE,IN_EMPID,1,IN_CPNY_ID);
       END IF;

       VAR_COUNT := 0;
       SELECT COUNT(*) INTO VAR_COUNT
       FROM PROSTOR_INSTORAGE_PRODUCT
       WHERE INSTORAGE_ID = IN_INSTORAGE_ID
       AND   PRODUCT_NO = IN_PRODUCT_NO
       AND   ACTIVITY = 1
       AND   CPNY_ID = IN_CPNY_ID
       AND   STORAGE_NO = IN_STORAGE_NO;
       IF VAR_COUNT > 0 THEN
         UPDATE PROSTOR_INSTORAGE_PRODUCT
         SET    QUANTITY = NVL(QUANTITY,0) + IN_QUANTITY,
                UPDATED_BY = IN_EMPID,
                UPDATE_DATE = SYSDATE
         WHERE  INSTORAGE_ID = IN_INSTORAGE_ID
         AND    PRODUCT_NO = IN_PRODUCT_NO
         AND    ACTIVITY = 1
         AND    CPNY_ID = IN_CPNY_ID
         AND    STORAGE_NO = IN_STORAGE_NO;
       ELSE
         SELECT * INTO VAR_PRODUCT FROM PROSTOR_PRODUCT WHERE PRODUCT_NO = IN_PRODUCT_NO;
         BEGIN
            SELECT S.CODE_NAME INTO VAR_CODE_NAME FROM SY_CODE S WHERE S.CODE_ID = IN_QUANTITY_UNIT_CODE;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
               VAR_CODE_NAME := '';
         END;
         

         SELECT PSI.STORAGE_NAME INTO VAR_STORAGE_NAME
         FROM PROSTOR_STORAGE_INFO PSI WHERE PSI.STORAGE_NO = IN_STORAGE_NO;

         BEGIN
             SELECT PSPP.STOR_ADDR INTO VAR_STOR_ADDR
             FROM PROSTOR_STORAGE_PRODUCT_PARAM PSPP
             WHERE PSPP.STORAGE_NO = IN_STORAGE_NO
             AND PSPP.PRODUCT_NO = IN_PRODUCT_NO;
         EXCEPTION
             WHEN NO_DATA_FOUND THEN
                VAR_STOR_ADDR := '';
         END;


         INSERT INTO PROSTOR_INSTORAGE_PRODUCT(
                INSTORAGE_ID,
                PRODUCT_NO,
                QUANTITY,
                CREATE_DATE,
                CREATED_BY,
                ACTIVITY,
                CPNY_ID,
                PRODUCT_NAME,
                PRODUCT_CAS,
                PRODUCT_NUM,
                PRODUCT_ID,
                SPECIFICATION,
                UNIT_NAME,
                UNIT_PRICE,
                STORAGE_NO,
                STORAGE_NAME,
                STOR_ADDR
         )
         VALUES(
                IN_INSTORAGE_ID,
                IN_PRODUCT_NO,
                IN_QUANTITY,
                SYSDATE,
                IN_EMPID,
                1,
                IN_CPNY_ID,
                VAR_PRODUCT.PRODUCT_NAME,
                VAR_PRODUCT.PRODUCT_CAS,
                VAR_PRODUCT.PRODUCT_NUM,
                VAR_PRODUCT.PRODUCT_ID,
                VAR_PRODUCT.SPECIFICATION,
                VAR_CODE_NAME,
                IN_UNIT_PRICE,
                IN_STORAGE_NO,
                VAR_STORAGE_NAME,
                VAR_STOR_ADDR
         );
       END IF;
       UPDATE PROSTOR_PURCHASE_ORDER_DETAIL PPOD
       SET      PPOD.INQUANTITY = NVL(PPOD.INQUANTITY,0) + IN_QUANTITY,
                PPOD.UPDATE_DATE = SYSDATE,
                PPOD.UPDATED_BY = IN_EMPID
       WHERE    PPOD.PURCHASE_ORDER_ID = IN_PARCHASE_ORDER_ID
       AND      PPOD.PRODUCT_NO = IN_PRODUCT_NO
       AND      PPOD.ACTIVITY = 1
       AND      PPOD.CPNY_ID = IN_CPNY_ID
       AND      PPOD.SUPPLIER_NO = IN_SUPPLIER_NO
       AND      NVL(PPOD.INQUANTITY,0) < NVL(PPOD.QUANTITY,0)
       AND      ROWNUM=1;

       IF VAR_PRE_PRICE = 0 THEN
           VAR_NEXT_PRICE := IN_UNIT_PRICE;
       ELSE
           VAR_NEXT_PRICE := (VAR_PRE_PRICE*VAR_SUM+IN_QUANTITY*IN_UNIT_PRICE)/(VAR_SUM+IN_QUANTITY);
       END IF;
       
       UPDATE PROSTOR_PRODUCT
       SET UNIT_PRICE = VAR_NEXT_PRICE
       WHERE PRODUCT_NO = IN_PRODUCT_NO
       AND   ACTIVITY = 1
       AND   CPNY_ID = IN_CPNY_ID;

       IF IN_PARCHASE_ORDER_ID IS NOT NULL THEN
           SELECT
              SUM(PPOD.QUANTITY) INTO VAR_QUANTITY
           FROM PROSTOR_PURCHASE_ORDER_DETAIL PPOD
           WHERE PPOD.ACTIVITY = 1
           AND   PPOD.CPNY_ID = IN_CPNY_ID
           GROUP BY PPOD.PURCHASE_ORDER_ID
           HAVING   PPOD.PURCHASE_ORDER_ID = IN_PARCHASE_ORDER_ID;

           SELECT
              SUM(NVL(PPOD.INQUANTITY,0)) INTO VAR_IN_QUANTITY
           FROM PROSTOR_PURCHASE_ORDER_DETAIL PPOD
           WHERE PPOD.ACTIVITY = 1
           AND   PPOD.CPNY_ID = IN_CPNY_ID
           GROUP BY PPOD.PURCHASE_ORDER_ID
           HAVING   PPOD.PURCHASE_ORDER_ID = IN_PARCHASE_ORDER_ID;

           IF VAR_QUANTITY = VAR_IN_QUANTITY THEN
               UPDATE PROSTOR_PURCHASE_ORDER PPO
               SET PPO.STATUS = 'PurchaseOrderState1'
               WHERE PPO.ACTIVITY = 1
               AND PPO.CPNY_ID = IN_CPNY_ID
               AND PPO.PURCHASE_ORDER_ID = IN_PARCHASE_ORDER_ID;
           END IF;
       END IF;

COMMIT;
END PRO_INSTORAGE;
/

prompt
prompt Creating procedure PR_BASEPARAM_LIST
prompt ====================================
prompt
CREATE OR REPLACE PROCEDURE Pr_baseParam_List (v_param_no IN VARCHAR2)
AUTHID CURRENT_USER
IS
   v_distinct_field   VARCHAR2 (50);
   v_str              VARCHAR2 (5000);
   v_field_name1      VARCHAR2 (50);
   v_field_en_name1   VARCHAR2 (50);
   v_field_kor_name1  VARCHAR2 (50);
   v_field_name2      VARCHAR2 (50);
   v_field_en_name2   VARCHAR2 (50);
   v_field_kor_name2  VARCHAR2 (50);
   v_field_table1     VARCHAR2 (50);
   v_field_table2     VARCHAR2 (50);
   v_field1           VARCHAR2 (50);
   v_field2           VARCHAR2 (50);
   r_count            NUMBER;
BEGIN
   BEGIN
      -- 取得基础项目的区“分项目字段”
      SELECT distinct_field_1st, distinct_field_2nd
        INTO v_field1, v_field2
        FROM PA_BASIC_ITEM
       WHERE ITEM_NO = v_param_no;

      IF v_field1 = 'EMPID'
      THEN
         v_field2 := 'CHINESENAME';
      END IF;

   -- 取得第一个区分项目对应的表名和字段
      SELECT distinct_field, table_name
        INTO v_field_name1, v_field_table1
        FROM PA_DISTINCT_LIST
       WHERE distinct_field = v_field1;

    --英文字段、韩文字段判断  第一个区分项目
      IF v_field_name1 = 'EMPID' OR  v_field_name1 = 'CPNY_NAME' OR v_field_name1 = 'DEPTID'
      THEN
          v_field_en_name1 := v_field_name1;
      ELSIF v_field_name1 = 'DATE_STARTED' OR v_field_name1 = 'DATE_LEFT' OR v_field_name1 = 'END_PROBATION_DATE'
      THEN
          v_field_en_name1 := 'to_char('||v_field_name1||',''yyyy-mm-dd'')';
      ELSIF v_field_name1 = 'CHINESENAME'
      THEN
          v_field_en_name1 := 'PINYINNAME';
      ELSIF v_field_name1 = 'DEPARTMENT'
      THEN
          v_field_en_name1 := 'DEPT_EN_NAME';
      ELSIF v_field_name1 = 'POST_GROUP_NAME'
      THEN
          v_field_en_name1 := 'POST_GROUP_EN_NAME';
      ELSIF v_field_name1 = 'POST_GRADE_LEVEL_NAME'
      THEN
          v_field_en_name1 := 'POST_GRADE_LEVEL_EN_NAME';
      ELSE
          v_field_en_name1 := v_field_name1 || '_EN_NAME';
      END IF;

   -- 取得第二个区分项目对应的表名和字段
      SELECT distinct_field, table_name
        INTO v_field_name2, v_field_table2
        FROM PA_DISTINCT_LIST
       WHERE distinct_field = v_field2;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_field_name2 := NULL;
   END;

   --英文字段、韩文字段判断  第二个区分项目
      IF v_field_name2 = 'EMPID' OR   v_field_name2 = 'CPNY_NAME' OR v_field_name2 = 'DEPTID'
      THEN
          v_field_en_name2 := v_field_name2;
      ELSIF v_field_name2 = 'DATE_STARTED' OR v_field_name2 = 'DATE_LEFT' OR v_field_name2 = 'END_PROBATION_DATE'
      THEN
          v_field_en_name2 := 'to_char('||v_field_name2||',''yyyy-mm-dd'')';
      ELSIF v_field_name2 = 'CHINESENAME'
      THEN
          v_field_en_name2 := 'PINYINNAME';
      ELSIF v_field_name2 = 'DEPARTMENT'
      THEN
          v_field_en_name2 := 'DEPT_EN_NAME';
      ELSIF v_field_name2 = 'POST_GROUP_NAME'
      THEN
          v_field_en_name2 := 'POST_GROUP_EN_NAME';
      ELSIF v_field_name2 = 'POST_GRADE_LEVEL_NAME'
      THEN
          v_field_en_name2 := 'POST_GRADE_LEVEL_EN_NAME';
      ELSE
          v_field_en_name2 := v_field_name2 || '_EN_NAME';
      END IF;

   -- 如果没有第二个区分项目
   IF v_field_name2 IS NULL
   THEN
      IF v_field_name1 IN ('(CONST)', '(CONST)')
      THEN
         v_str := 'DELETE PA_BASIC_DATA_LIST ';
      ELSE
         v_str :=
               'INSERT INTO PA_BASIC_DATA_LIST (FIELD1_VALUE,FIELD1_EN_VALUE,FIELD1_KOR_VALUE,FIELD2_VALUE,FIELD2_EN_VALUE,FIELD2_KOR_VALUE) SELECT  DISTINCT '
            || v_field_name1
            || ' AS FIELD1,'
            || v_field_en_name1
            || ' AS FIELD1_EN,'
            || v_field_kor_name1
            || ' AS FIELD1_KOR,'
            || ''''''
            || ' AS FIELD2,'
            || ''''''
            || ' AS FIELD2_EN,'
            || ''''''
            || ' AS FIELD2_KOR'
            || ' FROM '
            || v_field_table1
            || ' WHERE '
            || v_field_name1
            || ' NOT IN'
            || '(SELECT FIELD1_VALUE FROM PA_BASIC_DATA WHERE ACTIVITY=1 AND FIELD1_VALUE IS NOT NULL AND  ITEM_NO = '
            || v_param_no
            || ')';
      END IF;
   -- 如果第一个区分项目为工号
   ELSIF v_field1 = 'EMPID'
   THEN
      v_str :=
            'INSERT INTO PA_BASIC_DATA_LIST (FIELD1_VALUE,FIELD1_EN_VALUE,FIELD1_KOR_VALUE,FIELD2_VALUE,FIELD2_EN_VALUE,FIELD2_KOR_VALUE) SELECT  DISTINCT '
         || v_field_name1
         || ' AS FIELD1,'
         || v_field_en_name1
         || ' AS FIELD1_EN,'
         || v_field_kor_name1
         || ' AS FIELD1_KOR,'
         || v_field_name2
         || ' AS FIELD2,'
         || v_field_en_name2
         || ' AS FIELD2_EN,'
         || v_field_kor_name2
         || ' AS FIELD2_KOR'
         || ' FROM '
         || v_field_table1
         || ' WHERE '
         || v_field_name1
         || ' NOT IN'
         || '(SELECT FIELD1_VALUE FROM PA_BASIC_DATA WHERE ACTIVITY=1 AND ITEM_NO = '
         || v_param_no
         || ')';
   ELSE
      v_str :=
            'INSERT INTO PA_BASIC_DATA_LIST (FIELD1_VALUE,FIELD1_EN_VALUE,FIELD1_KOR_VALUE,FIELD2_VALUE,FIELD2_EN_VALUE,FIELD2_KOR_VALUE) SELECT  DISTINCT '
         || v_field_name1
         || ' AS FIELD1,'
         || v_field_en_name1
         || ' AS FIELD1_EN,'
         || v_field_kor_name1
         || ' AS FIELD1_KOR,'
         || v_field_name2
         || ' AS FIELD2,'
         || v_field_en_name2
         || ' AS FIELD2_EN,'
         || v_field_kor_name2
         || ' AS FIELD2_KOR'
         || ' FROM '
         || v_field_table1
         || ' WHERE '
         || v_field_name1
         || '||'
         || v_field_name2
         || ' NOT IN '
         || '(SELECT FIELD1_VALUE||FIELD2_VALUE FROM PA_BASIC_DATA WHERE ACTIVITY=1 AND  ITEM_NO = '
         || v_param_no
         || ')';
   END IF;

   SELECT COUNT (*)
     INTO r_count
     FROM user_tab_columns
    WHERE table_name = 'PA_BASIC_DATA_LIST';

   IF r_count > 0
   THEN
      EXECUTE IMMEDIATE 'DELETE  PA_BASIC_DATA_LIST';
      COMMIT ;
   END IF;


   EXECUTE IMMEDIATE v_str;
   commit;
END Pr_baseParam_List;
/

prompt
prompt Creating procedure PR_BONUS_FORMULA_INITIAL
prompt ===========================================
prompt
CREATE OR REPLACE PROCEDURE PR_BONUS_FORMULA_INITIAL(V_PAMONTH VARCHAR2) IS
  -- 取得上个月的输入项目列表
  V_PRIOR_PA_MONTH VARCHAR(10) := PRIOR_PAMONTH(V_PAMONTH) ;
BEGIN

    DELETE PA_BONUS_FORMULAR WHERE PA_MONTH = V_PAMONTH;

    -- 复制上月的输入项目为本月的输入项目
    INSERT INTO PA_BONUS_FORMULAR
           (FORMULAR_NO,
            ITEM_NO,
            CONDITION,
            FORMULAR,
            ORDERNO,
            DESCRIPTION,
            PA_MONTH,
            CREATE_DATE,
            CREATED_BY,
            ACTIVITY)
      SELECT PA_BONUS_FORMULAR_SEQ.NEXTVAL,
             ITEM_NO,
             CONDITION,
             FORMULAR,
             ORDERNO,
             DESCRIPTION,
             V_PAMONTH,
             CREATE_DATE,
             CREATED_BY,
             ACTIVITY
        FROM PA_BONUS_FORMULAR
       WHERE PA_MONTH = V_PRIOR_PA_MONTH ;

   COMMIT ;
END;
/

prompt
prompt Creating procedure PR_BONUS_PACAL
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE PR_BONUS_PACAL(
       V_PA_MONTH VARCHAR2,--工资月基础
       V_BONUS_MONTH VARCHAR2,--奖金月   
       V_EXEC_MODE    VARCHAR2,
       V_OUTPUT_TYPE  VARCHAR2,
       V_OUTPUT_STR   OUT VARCHAR2)
  AUTHID CURRENT_USER IS
  /* V_EXEC_MODE :
                 NORMAL              正常计算
                 TEST               只生成脚本不执行计算
                 ONLY_CREATE_TABLE 只建表 不计算
     V_OUTPUT_TYPE     输出模式
                 ALL               全部输出
                 PARAM             参数部分 CUIJINHUA ZHU ZHENGQI
                 PAITEM            工资项目部分
                 NONE              不输出
  */
  I                      INTEGER;
  V_STR                  VARCHAR2(20000); -- 创建T_PA_RESULT表的SQL
  V_BSTR                 VARCHAR2(20000); -- 更新T_PA_RESULT表的基础项目值的SQL
  V_CASTR                VARCHAR2(20000); -- 更新T_PA_RESULT表的工资项目值的SQL
  V_PSTR                 VARCHAR2(20000); -- 更新T_PA_RESULT表的输入项目值的SQL
  V_INDEX_STR            VARCHAR2(20000); -- 创建T_PA_RESULT索引SQL
  V_CONDITION_COUNT      INT; -- 工资项目空条件数量
  V_FOMULAR_COUNT        INT; -- 工资项目公式数量
  R_COUNT                INT;
  V_PARAM_ID             VARCHAR2(50);
  V_TIME                 DATE := SYSDATE;
  V_EMP_COUNT            VARCHAR2(6);
  V_ITEM_ID              VARCHAR2(50);
  V_BASIC_ITEM_ID        VARCHAR2(50);
  V_FORMULAR_NOCONDITION VARCHAR2(2000) ; 
    
  -- 人事表游标
  CURSOR CUS_HR IS
    SELECT FIELD_NAME,
           DISTINCT_FIELD,
           TABLE_NAME,
           FIELD_EN_NAME
      FROM PA_DISTINCT_LIST
     WHERE TABLE_NAME = 'PA_HR_V'
     ORDER BY ID;

  --考勤游标
  CURSOR CUS_AR IS
    SELECT FIELD_NAME,
           DISTINCT_FIELD,
           TABLE_NAME,
           FIELD_EN_NAME
      FROM PA_DISTINCT_LIST
     WHERE TABLE_NAME = 'PA_AR_V'
     ORDER BY ID;

  -- 基础项目游标
  CURSOR CUS_BASIC_ITEM IS
    SELECT ITEM_NO,
           ITEM_ID,
           ITEM_NAME,
           ITEM_EN_NAME, 
           DISTINCT_FIELD_1ST,
           DISTINCT_FIELD_2ND,
           DATATYPE,
           DEFAULT_VAL
      FROM PA_BASIC_ITEM
     WHERE ACTIVITY = 1;

  -- 输入项目游标
  CURSOR CUS_PARAM IS
    SELECT PARAM_NO,
           PARAM_ID,
           PARAM_NAME,
           PARAM_EN_NAME,
           DISTINCT_FIELD_1ST,
           DISTINCT_FIELD_2ND,
           DATATYPE,
           DEFAULT_VAL
      FROM PA_BONUS_PARAM_ITEM
     WHERE PA_MONTH = V_BONUS_MONTH;

  -- 奖金项目游标
  CURSOR CUS_ITEM IS
    SELECT ITEM_NO, 
           ITEM_ID,
           ITEM_NAME,
           ITEM_EN_NAME,
           DATATYPE,
           PRECISION,
           CARRY_BIT,
           PA_BONUS_TYPE.TYPE_ID,
           PA_BONUS_TYPE.TYPE_NAME,
           PA_BONUS_TYPE.TYPE_EN_NAME
      FROM PA_BONUS_ITEM,PA_BONUS_TYPE
     WHERE PA_BONUS_ITEM.TYPE_ID = PA_BONUS_TYPE.TYPE_ID
     ORDER BY CALCU_ORDER;

  -- 奖金公式游标
  CURSOR CUS_FORMULAR(ITEM_NO_IN NUMBER) IS
    SELECT *
      FROM PA_BONUS_FORMULAR
     WHERE ITEM_NO = ITEM_NO_IN
       AND PA_MONTH = V_BONUS_MONTH
     ORDER BY ORDERNO DESC;
   
   -- 工资项目与奖金项目有关系的项目游标
   CURSOR CUS_PA_ITEM
   IS
      SELECT T.ITEM_ID, 
             T.ITEM_NAME, 
             T.ITEM_EN_NAME, 
             DATATYPE
        FROM PA_ITEM T 
       WHERE T.CALC_FLAG = 'Y' ;  
  
BEGIN

  SELECT NVL(MAX(BONUS_LOCK_FLAG),0)
    INTO R_COUNT
    FROM PA_PROGRESS
   WHERE MONTH_STR = V_BONUS_MONTH;

  -- 验证当月是否存已锁定
  IF R_COUNT = 1 THEN
    BEGIN
      V_OUTPUT_STR := '错误: 当月奖金已锁定,不能再进行奖金计算.';
      RETURN;
    END;
  END IF;
 
  SELECT COUNT(*)
    INTO R_COUNT
    FROM PA_BONUS_PARAM_ITEM
   WHERE PA_MONTH = V_BONUS_MONTH;

  -- 验证当月是否存在奖金输入项目
  IF R_COUNT = 0 THEN
    BEGIN
      V_OUTPUT_STR := '错误: 当月奖金无输入项目，请初始化输入项目.';
      RETURN;
    END;
  END IF;

  -- 更新有问题的输入项目数据
  UPDATE PA_BONUS_PARAM_DATA
     SET RETURN_VALUE = NULL
   WHERE LOWER(RETURN_VALUE) = 'null'
     AND EXISTS(
         SELECT * FROM PA_BONUS_PARAM_ITEM T
          WHERE T.PARAM_NO = PA_BONUS_PARAM_DATA.PARAM_NO
            AND T.PA_MONTH = V_BONUS_MONTH
     );

  COMMIT;
  -- 设置输出缓冲区大小
  -- SET OUTPUT ON SIZE 50000;
  DBMS_OUTPUT.ENABLE(5000000);
  -- EXECUTE IMMEDIATE 'SET LINESIZE = 5000';
  
  -- 建表字符串，表的列由参数名称 || 奖金项目名称组成。奖金项目名称按计算顺序排列。
  V_STR         := 'CREATE TABLE T_PA_BONUS_RESULT AS SELECT  ''' ||
                   V_BONUS_MONTH || ''' AS BONUS_MONTH, ''' || 
                   V_PA_MONTH || ''' AS PA_MONTH, ''' ||
                   V_BONUS_MONTH || ''' AS BONUS_FORMULAR_MONTH,' ;
  
  -- 验证计算项目名称是否重复
  BEGIN
    SELECT ITEM_ID
      INTO V_ITEM_ID
      FROM (SELECT ITEM_ID, COUNT(ITEM_ID) AS NUM
              FROM PA_BONUS_ITEM
             GROUP BY ITEM_ID) P
     WHERE P.NUM > 1
       AND ROWNUM = 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_ITEM_ID := NULL;
  END;

  -- 如果计算项目名称重复提示错误
  IF V_ITEM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误: 奖金计算项目ID"' || V_ITEM_ID || '"出现重复,请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 验证输入项目名称是否重复
  BEGIN
    SELECT PARAM_ID
      INTO V_ITEM_ID
      FROM (SELECT PARAM_ID, COUNT(PARAM_ID) AS NUM
              FROM PA_BONUS_PARAM_ITEM
             WHERE PA_MONTH = V_BONUS_MONTH
             GROUP BY PARAM_ID)
     WHERE NUM > 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_ITEM_ID := NULL;
  END;

  -- 如果输入项目名称重复提示错误
  IF V_ITEM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误: 奖金输入项目ID"' || V_ITEM_ID || '"出现重复,请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 验证基础项目名称是否与接口表的字段名称重复
  BEGIN
    SELECT DISTINCT_FIELD
      INTO V_ITEM_ID
      FROM PA_DISTINCT_LIST
     WHERE DISTINCT_FIELD IN
           (SELECT ITEM_ID FROM PA_BASIC_ITEM WHERE ACTIVITY = 1);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_ITEM_ID := NULL;
  END;

  -- 如果基础项目名称与接口表的字段名称重复提示错误
  IF V_ITEM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误：奖金基础项目ID“' || V_ITEM_ID || '”和人事项目ID“' ||
                      V_ITEM_ID || '”出现重复。请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 验证输入项目名称是否与接口表的字段名称重复
  BEGIN
    SELECT DISTINCT_FIELD
      INTO V_ITEM_ID
      FROM PA_DISTINCT_LIST
     WHERE DISTINCT_FIELD IN
           (SELECT PARAM_ID
              FROM PA_BONUS_PARAM_ITEM
             WHERE PA_MONTH = V_BONUS_MONTH);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_ITEM_ID := NULL;
  END;

  -- 如果输入项目名称与接口表的字段名称重复提示错误
  IF V_ITEM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误：奖金输入项目ID“' || V_ITEM_ID || '”和人事项目ID“' ||
                      V_ITEM_ID || '”出现重复。请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 验证计算项目名称是否与接口表的字段名称重复
  BEGIN
    SELECT DISTINCT_FIELD
      INTO V_ITEM_ID
      FROM PA_DISTINCT_LIST
     WHERE DISTINCT_FIELD IN (SELECT ITEM_ID FROM PA_BONUS_ITEM);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_ITEM_ID := NULL;
  END;

  -- 如果计算项目名称与接口表的字段名称重复提示错误
  IF V_ITEM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误: 奖金计算项目ID“' || V_ITEM_ID || '”和人事项目ID“' ||
                      V_ITEM_ID || '”出现重复。请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 验证计算项目名称是否与基础项目名称重复
  BEGIN
    SELECT PA_BASIC_ITEM.ITEM_ID
      INTO V_BASIC_ITEM_ID
      FROM PA_BASIC_ITEM, PA_BONUS_ITEM
     WHERE PA_BASIC_ITEM.ITEM_ID = PA_BONUS_ITEM.ITEM_ID
       AND PA_BASIC_ITEM.ACTIVITY = 1
       AND ROWNUM = 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_BASIC_ITEM_ID := NULL;
  END;

  -- 如果计算项目名称与基础项目名称重复提示错误
  IF V_BASIC_ITEM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误： 参数名称ID“' || V_BASIC_ITEM_ID || '”和奖金项目ID“' ||
                      V_BASIC_ITEM_ID || '”出现重复。请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 验证计算项目名称是否与输入项目名称重复
  BEGIN
    SELECT PA_BONUS_PARAM_ITEM.PARAM_ID
      INTO V_PARAM_ID
      FROM PA_BONUS_PARAM_ITEM, PA_BONUS_ITEM
     WHERE PA_BONUS_PARAM_ITEM.PARAM_ID = PA_BONUS_ITEM.ITEM_ID
       AND PA_BONUS_PARAM_ITEM.PA_MONTH = V_BONUS_MONTH
       AND ROWNUM = 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_PARAM_ID := NULL;
  END;

  -- 如果计算项目名称与输入项目名称重复提示错误
  IF V_PARAM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误： 参数名称ID“' || V_PARAM_ID || '”和奖金项目ID“' ||
                      V_PARAM_ID || '”出现重复。请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 拼接人事数据列
  FOR HR_ROW IN CUS_HR LOOP
    -- 拼接创建表T_PA_RESULT的SQL字符串
    V_STR := V_STR || HR_ROW.TABLE_NAME || '.' || HR_ROW.DISTINCT_FIELD ||
             ' AS "' || HR_ROW.DISTINCT_FIELD || '",' || CHR(13);

  END LOOP;

  -- 拼接考勤数据列
  FOR AR_ROW IN CUS_AR LOOP
    V_STR := V_STR || AR_ROW.TABLE_NAME || '.' || AR_ROW.DISTINCT_FIELD || ' AS "' ||
             AR_ROW.DISTINCT_FIELD || '",' || CHR(13);
  END LOOP;

  -- 拼接基础项目列
  FOR BASIC_ROW IN CUS_BASIC_ITEM LOOP
    BEGIN
      V_STR := V_STR || (CASE UPPER(SUBSTR(BASIC_ROW.DATATYPE, 1, 4))
                 WHEN 'NUMB' THEN
                  '0'
                 WHEN 'VARC' THEN
                  '''                                                                                                    '''
                 WHEN 'DATE' THEN
                  'SYSDATE'
               --此处留100空格确定此列长宽度
               END) || ' AS "' || BASIC_ROW.ITEM_ID || '" ,' || CHR(13);
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20101,
                                '基础项目数据类型错误: [' || BASIC_ROW.ITEM_ID || ']');
    END;

  END LOOP;

  -- 拼接输入项目列
  FOR PAR_ROW IN CUS_PARAM LOOP
    BEGIN
      V_STR := V_STR || (CASE UPPER(SUBSTR(PAR_ROW.DATATYPE, 1, 4))
                 WHEN 'NUMB' THEN
                  '0'
                 WHEN 'VARC' THEN
                  '''                                                                                                    '''
                 WHEN 'DATE' THEN
                  'SYSDATE'
               --此处留100空格确定此列长宽度
               END) || ' AS "' || PAR_ROW.PARAM_ID || '" ,' || CHR(13);
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20101,
                                '工资参数数据类型错误: [' || PAR_ROW.PARAM_ID || ']');
    END;

  END LOOP;

  -- 拼接奖金计算项目列
  FOR PA_ROW IN CUS_ITEM LOOP
    V_STR := V_STR || (CASE UPPER(SUBSTR(PA_ROW.DATATYPE, 1, 4))
               WHEN 'NUMB' THEN
                '0'
               WHEN 'VARC' THEN
                '''                                                                                                    '''
             --此处留100空格确定此列长宽度
               ELSE
                ''' '''
             END) || ' AS "' || PA_ROW.ITEM_ID || '" ,' || CHR(13);
  END LOOP ;
 
   -- 拼接工资项目与保险项目有关系的项目列 
   FOR pa_row IN cus_pa_item
   LOOP
      V_STR := V_STR || (CASE UPPER(SUBSTR(PA_ROW.DATATYPE, 1, 4))
               WHEN 'NUMB' THEN
                PA_ROW.ITEM_ID
               WHEN 'VARC' THEN
                '''                                                                                                    '''
             --此处留100空格确定此列长宽度
               ELSE
                ''' '''
             END) || ' AS "' || PA_ROW.ITEM_ID || '" ,' || CHR(13);
            
   END LOOP ;
  
  --去 掉最后逗号
  V_STR := SUBSTR(V_STR, 0, LENGTH(V_STR) - 2);
    
  ---创建 计算结果表 并插入人事及数据
  V_STR := V_STR || ' FROM PA_HR_V, PA_AR_V, HR_EMP_PA_INFO, PA_HISTORY' ||
           ' WHERE PA_HR_V.EMPID = HR_EMP_PA_INFO.EMPID(+)' ||
           ' AND PA_HR_V.EMPID = PA_AR_V.EMPID(+)' ||  
           ' AND PA_HR_V.EMPID = PA_HISTORY.EMPID(+)' ||
           ' AND HR_EMP_PA_INFO.CALC_FLAG=''Y''' ||
           ' AND PA_AR_V.AR_MONTH = ''' || V_PA_MONTH || '''' || 
           ' AND PA_AR_V.AR_MONTH = ''' || V_BONUS_MONTH || '''' ||  
           ' AND EXISTS(SELECT * FROM PA_BONUS_EMP T WHERE PA_HR_V.EMPID = T.EMPID AND T.PA_MONTH = ''' || V_BONUS_MONTH || ''')';

  DBMS_OUTPUT.PUT_LINE('THIS IS CREATE TABLE STRING');
                
  I := 0 ;
  -- 日志输出
  IF V_OUTPUT_TYPE IN ('ALL') THEN
    WHILE I * 150 <= LENGTH(V_STR) LOOP
      DBMS_OUTPUT.PUT_LINE(SUBSTR(V_STR, I * 150, 150));
      I := I + 1;
    END LOOP; 
  END IF;

  SELECT COUNT(*)
    INTO R_COUNT
    FROM USER_TAB_COLUMNS
   WHERE TABLE_NAME = 'T_PA_BONUS_RESULT';

  IF R_COUNT > 0 THEN
    BEGIN
      EXECUTE IMMEDIATE 'DROP TABLE T_PA_BONUS_RESULT';
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20101, '删除 T_PA_BONUS_RESULT 失败', TRUE);
    END;
  END IF;
  
  V_INDEX_STR := 'alter table T_PA_BONUS_RESULT add constraint PK_T_PA_BONUS_RESULT primary key (EMPID) ' ;
  
  -- 执行创建表T_PA_RESULT的SQL
  IF V_EXEC_MODE IN ('NORMAL', 'ONLY_CREATE_TABLE', 'PARAM', 'PAITEM') THEN
    BEGIN
      EXECUTE IMMEDIATE V_STR;
      EXECUTE IMMEDIATE V_INDEX_STR;

      COMMIT;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20101,
                                '创建计算结果表失败: [' ||
                                SUBSTR(V_STR, LENGTH(V_STR) - 1000, 1000) || ']',
                                TRUE);
    END;
  END IF ;
  ---------------------------------------------------------- 基础项目计算 ----------------------------------------------------------
  DBMS_OUTPUT.PUT_LINE(CHR(13) ||
                       ' ----------    THIS IS THE CALCULATE BASIC DATA STRING ----------');
  -- 验证所传入的基础月,是否存在历史数据
  SELECT COUNT(*)
    INTO R_COUNT
    FROM PA_HISTORY
   WHERE PA_MONTH = V_PA_MONTH
     AND ROWNUM = 1;

  FOR BASIC_VAL IN CUS_BASIC_ITEM LOOP
    -- 创建更新T_PA_RESULT基本项目的SQL
    IF R_COUNT > 0 THEN
       V_BSTR := 'UPDATE T_PA_BONUS_RESULT T SET "' || BASIC_VAL.ITEM_ID || '" = NVL('
       || '(SELECT "' || BASIC_VAL.ITEM_ID || '" FROM PA_HISTORY PA WHERE PA.EMPID = T.EMPID AND PA.PA_MONTH = ''' || V_PA_MONTH || ''' )'
       || ',0)' ;
    ELSE

      V_BSTR := 'UPDATE T_PA_BONUS_RESULT SET "' || BASIC_VAL.ITEM_ID || '" = NVL(' ||

                  ' (SELECT P.RETURN_VALUE FROM  PA_BASIC_DATA  P WHERE ' ||
                  BASIC_VAL.DISTINCT_FIELD_1ST || '  = P.FIELD1_VALUE ' || CASE
                    WHEN TRIM(BASIC_VAL.DISTINCT_FIELD_2ND) IS NOT NULL THEN
                     ' AND ' || BASIC_VAL.DISTINCT_FIELD_2ND ||
                     ' = P.FIELD2_VALUE '
                  END

                  || ' AND P.ITEM_NO=' ||
                  TO_CHAR(BASIC_VAL.ITEM_NO) || ' AND P.ACTIVITY = 1 ),''' || BASIC_VAL.DEFAULT_VAL ||
                  ''')';
    END IF ;

    IF V_OUTPUT_TYPE IN ('ALL', 'BASIC') THEN
      I := 0;
      WHILE I * 150 <= LENGTH(V_BSTR) LOOP

          DBMS_OUTPUT.PUT_LINE(SUBSTR(V_BSTR, I * 150, 150));
          I := I + 1;

      END LOOP;
    END IF;
    IF V_EXEC_MODE IN ('NORMAL', 'BASIC') THEN
      BEGIN
        EXECUTE IMMEDIATE V_BSTR;
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20101,
                                  '参数计算失败: [' || V_BSTR || ']');
      END;
    END IF;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('----------CALCULATE BASIC DATA STRING FINISHED-----------');

  ----------------------------------------------------------  输入项目计算 ---------------------------------------------------------
  DBMS_OUTPUT.PUT_LINE(CHR(13) ||
                       ' ----------    THIS IS THE CALCULATE PARAM DATA STRING ----------');

  FOR PAR_VAL IN CUS_PARAM LOOP
    -- 创建更新T_PA_BONUS_RESULT输入项目的SQL
    V_PSTR := 'UPDATE T_PA_BONUS_RESULT SET "' || PAR_VAL.PARAM_ID || '" = NVL('
           || ' (SELECT P.RETURN_VALUE FROM  PA_BONUS_PARAM_DATA  P WHERE '
           || PAR_VAL.DISTINCT_FIELD_1ST || '  = P.FIELD1_VALUE '
           || CASE WHEN TRIM(PAR_VAL.DISTINCT_FIELD_2ND) IS NOT NULL THEN
                   ' AND ' || PAR_VAL.DISTINCT_FIELD_2ND || ' = P.FIELD2_VALUE '
                END || ' AND P.PARAM_NO=' || TO_CHAR(PAR_VAL.PARAM_NO) ||
                ' ),''' || PAR_VAL.DEFAULT_VAL || ''')';

    IF V_OUTPUT_TYPE IN ('ALL', 'PARAM') THEN
      I := 0;
      WHILE I * 150 <= LENGTH(V_PSTR) LOOP

          DBMS_OUTPUT.PUT_LINE(SUBSTR(V_PSTR, I * 150, 150));
          I := I + 1;

      END LOOP;
    END IF;

    IF V_EXEC_MODE IN ('NORMAL', 'PARAM') THEN
      BEGIN
        EXECUTE IMMEDIATE V_PSTR;
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20101,
                                  '参数计算失败: [' || V_PSTR || ']');
      END;
    END IF;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('----------CALCULATE PARAM DATA STRING FINISHED-----------');

  ---------------------------------------------------   工资项目计算   -------------------------------------------------------------
  DBMS_OUTPUT.PUT_LINE(CHR(13) ||
                       '  -------------------  THIS IS THE CALCU PA ITEMS STRING ---------');

    FOR PAITEM_VAL IN CUS_ITEM LOOP

      -- 字符类型工资项目
      IF Instr(PAITEM_VAL.DATATYPE, 'VARCHAR') > 0 THEN
        V_CASTR := CHR(13) || 'UPDATE T_PA_BONUS_RESULT set "' ||
                   PAITEM_VAL.ITEM_ID || '" = ';
        -- 数值类型工资项目
      ELSE
        V_CASTR := CHR(13) || 'UPDATE T_PA_BONUS_RESULT set "' ||
                   PAITEM_VAL.ITEM_ID || '" = TRUNC((' ||
                   PAITEM_VAL.CARRY_BIT || ' + ';
      END IF;

      /************************************************计算所有工资项目**************************************
         鍏紡浜旂鎯呭喌锛
         1.    无公式                  0
         2.    鍗曚竴鍏紡鏃犳潯浠?         鐩存帴鍒楀叕寮
         3.    单一公式有条件          CASE WHEN 条件 THEN 公式 ELSE 0 END
         4.    多公式均有条件          CASE 循环(WHEN 条件 THEN 公式) ELSE 0 END
         5.    多公式，其中一条无条件  CASE 循环(WHEN 条件 THEN 公式) ELSE 公式 END
      *******************************************************************************************************/

      -- 鍙栧緱褰撳墠宸ヨ祫椤圭洰鐨勫叕寮忔暟閲
      SELECT COUNT(*)
        INTO V_FOMULAR_COUNT
        FROM PA_BONUS_FORMULAR
       WHERE ITEM_NO = PAITEM_VAL.ITEM_NO
         AND PA_MONTH = V_BONUS_MONTH ;

      -- 取得当前工资项目的空公式条件数量
      SELECT COUNT(*)
        INTO V_CONDITION_COUNT
        FROM PA_BONUS_FORMULAR
       WHERE ITEM_NO = PAITEM_VAL.ITEM_NO
         AND PA_MONTH = V_BONUS_MONTH
         AND (REPLACE(REPLACE(RTRIM(LTRIM(CONDITION)), CHR(9), ''), ' ', '') = '' OR
             CONDITION IS NULL);

      IF V_FOMULAR_COUNT = 0 THEN
        V_CASTR := V_CASTR || '0';
      ELSIF V_FOMULAR_COUNT = 1 AND V_CONDITION_COUNT = 1 THEN
        SELECT V_CASTR || FORMULAR
          INTO V_CASTR
          FROM PA_BONUS_FORMULAR
         WHERE ITEM_NO = PAITEM_VAL.ITEM_NO
           AND PA_MONTH = V_BONUS_MONTH ;
      ELSE
        V_CASTR := V_CASTR || ' CASE ';

        FOR FORMULAR_ROW IN CUS_FORMULAR(PAITEM_VAL.ITEM_NO)
          LOOP
          IF REPLACE(REPLACE(RTRIM(LTRIM(FORMULAR_ROW.CONDITION)),
                             CHR(9),
                             ''),
                     ' ',
                     '') = '' OR FORMULAR_ROW.CONDITION IS NULL THEN
            V_FORMULAR_NOCONDITION := FORMULAR_ROW.FORMULAR;
          ELSE
            V_CASTR := V_CASTR || ' WHEN ' || FORMULAR_ROW.CONDITION ||
                       ' THEN ' || FORMULAR_ROW.FORMULAR;
          END IF;
        END LOOP;

        IF V_CONDITION_COUNT = 0 THEN

          -- 字符类型工资项目
          IF Instr(PAITEM_VAL.DATATYPE, 'VARCHAR') > 0 THEN
            V_CASTR := V_CASTR || ' ELSE '''' END ';
          ELSE
            V_CASTR := V_CASTR || ' ELSE 0 END ';
          END IF;
        ELSE
          V_CASTR := V_CASTR || ' ELSE ' || V_FORMULAR_NOCONDITION ||
                     ' END ';
        END IF;
      END IF;

      -- 数值类型工资项目
      IF Instr(PAITEM_VAL.DATATYPE, 'NUMBER') > 0 THEN
        V_CASTR := V_CASTR || '),' || PAITEM_VAL.PRECISION || ')';
      END IF;

      IF V_OUTPUT_TYPE IN ('ALL', 'PAITEM') THEN
        I := 0;
        WHILE I * 150 <= LENGTH(V_CASTR) LOOP

            DBMS_OUTPUT.PUT_LINE(SUBSTR(V_CASTR, I * 150, 150));
            I := I + 1;

        END LOOP;
      END IF;

      IF V_EXEC_MODE IN ('NORMAL', 'PAITEM') THEN
        BEGIN
          EXECUTE IMMEDIATE V_CASTR;
          COMMIT;
        EXCEPTION
          WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20101,
                                    '计算项目计算失败: [' || V_CASTR || ']',
                                    TRUE);
        END;
      END IF;

    END LOOP;
    
  COMMIT ;

  --PA_BONUS_CONFIRM(V_OUTPUT_STR) ;

  EXECUTE IMMEDIATE ' SELECT COUNT(EMPID) FROM T_PA_BONUS_RESULT ' INTO V_EMP_COUNT ;

  V_OUTPUT_STR := V_EMP_COUNT || '   人奖金计算成功完成! 用时 ' ||
                  TRUNC((SYSDATE - V_TIME) * 24 * 60 * 60 + 0.005, 2) || ' 秒';

  COMMIT;

END;
/*
-- Create table
create table PA_BONUS_HISTORY
(
  PA_MONTH             VARCHAR2(6) not null,
  EMPID                VARCHAR2(20) not null,
  PA_BONUS_TYPE        VARCHAR2(100),
  PA_BONUS_TYPE_ID     VARCHAR2(20) not null,
  PA_CALCULATE_TYPE    VARCHAR2(100),
  PA_CALCULATE_TYPE_ID VARCHAR2(20),
  PA_FORMULAR_MONTH    VARCHAR2(6),
  PA_BASIS_MONTH       VARCHAR2(6)
) ;
-- Add comments to the columns 
comment on column PA_BONUS_HISTORY.PA_MONTH
  is '工资月';
comment on column PA_BONUS_HISTORY.EMPID
  is '工号';
comment on column PA_BONUS_HISTORY.PA_BONUS_TYPE
  is '奖金类型';
comment on column PA_BONUS_HISTORY.PA_BONUS_TYPE_ID
  is '奖金类型ID';
comment on column PA_BONUS_HISTORY.PA_CALCULATE_TYPE
  is '计税类型';
comment on column PA_BONUS_HISTORY.PA_CALCULATE_TYPE_ID
  is '计税类型ID';
comment on column PA_BONUS_HISTORY.PA_FORMULAR_MONTH
  is '公式月';
comment on column PA_BONUS_HISTORY.PA_BASIS_MONTH
  is '工资基础月';
-- Create/Recreate primary, unique and foreign key constraints 
alter table PA_BONUS_HISTORY
  add constraint PK_PA_BONUS_HISTORY primary key (PA_MONTH, EMPID, PA_BONUS_TYPE_ID) ;

*/
/

prompt
prompt Creating procedure PR_BONUS_PARAM_LIST
prompt ======================================
prompt
CREATE OR REPLACE PROCEDURE PR_BONUS_PARAM_LIST(V_PARAM_NO IN VARCHAR2) AUTHID CURRENT_USER IS
  --V_DISTINCT_FIELD  VARCHAR2(50);
  V_STR             VARCHAR2(5000);
  V_FIELD_NAME1     VARCHAR2(50);
  V_FIELD_EN_NAME1  VARCHAR2(50);
  V_FIELD_NAME2     VARCHAR2(50);
  V_FIELD_EN_NAME2  VARCHAR2(50);
  V_FIELD_TABLE1    VARCHAR2(50);
  V_FIELD_TABLE2    VARCHAR2(50);
  V_FIELD1          VARCHAR2(50);
  V_FIELD2          VARCHAR2(50);
  R_COUNT           NUMBER;
  I                 INTEGER;
BEGIN
  DBMS_OUTPUT.ENABLE(5000000);
  BEGIN
    -- 取得输入项目的区“分项目字段”
    SELECT DISTINCT_FIELD_1ST, DISTINCT_FIELD_2ND
      INTO V_FIELD1, V_FIELD2
      FROM PA_BONUS_PARAM_ITEM
     WHERE PARAM_NO = V_PARAM_NO;

    IF V_FIELD1 = 'EMPID' THEN
      V_FIELD2 := 'CHINESENAME';
    END IF;

    -- 取得第一个区分项目对应的表名和字段
    SELECT DISTINCT_FIELD, TABLE_NAME
      INTO V_FIELD_NAME1, V_FIELD_TABLE1
      FROM PA_DISTINCT_LIST
     WHERE DISTINCT_FIELD = V_FIELD1;

    --英文字段、韩文字段判断  第一个区分项目
    IF V_FIELD_NAME1 = 'EMPID' OR V_FIELD_NAME1 = 'CPNY_NAME' THEN
      V_FIELD_EN_NAME1  := V_FIELD_NAME1; 
    ELSIF V_FIELD_NAME1 = 'DATE_STARTED' OR V_FIELD_NAME1 = 'DATE_LEFT' OR
          V_FIELD_NAME1 = 'END_PROBATION_DATE' THEN
      V_FIELD_EN_NAME1  := 'to_char(' || V_FIELD_NAME1 ||
                           ',''yyyy-mm-dd'')'; 
    ELSIF V_FIELD_NAME1 = 'CHINESENAME' THEN
      V_FIELD_EN_NAME1  := 'PINYINNAME'; 
    ELSIF V_FIELD_NAME1 = 'DEPARTMENT' THEN
      V_FIELD_EN_NAME1  := 'DEPT_EN_NAME'; 
    ELSIF V_FIELD_NAME1 = 'POST_GROUP_NAME' THEN
      V_FIELD_EN_NAME1  := 'POST_GROUP_EN_NAME'; 
    ELSIF V_FIELD_NAME1 = 'POST_GRADE_LEVEL_NAME' THEN
      V_FIELD_EN_NAME1  := 'POST_GRADE_LEVEL_EN_NAME'; 
    ELSE
      V_FIELD_EN_NAME1  := V_FIELD_NAME1 || '_EN_NAME'; 
    END IF;

    -- 取得第二个区分项目对应的表名和字段
    SELECT DISTINCT_FIELD, TABLE_NAME
      INTO V_FIELD_NAME2, V_FIELD_TABLE2
      FROM PA_DISTINCT_LIST
     WHERE DISTINCT_FIELD = V_FIELD2;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_FIELD_NAME2 := NULL;
  END;

  --英文字段、韩文字段判断  第二个区分项目
  IF V_FIELD_NAME2 = 'EMPID' OR V_FIELD_NAME2 = 'CPNY_NAME' THEN
    V_FIELD_EN_NAME2  := V_FIELD_NAME2; 
  ELSIF V_FIELD_NAME2 = 'DATE_STARTED' OR V_FIELD_NAME2 = 'DATE_LEFT' OR
        V_FIELD_NAME2 = 'END_PROBATION_DATE' THEN
    V_FIELD_EN_NAME2  := 'to_char(' || V_FIELD_NAME2 || ',''yyyy-mm-dd'')'; 
  ELSIF V_FIELD_NAME2 = 'CHINESENAME' THEN
    V_FIELD_EN_NAME2  := 'PINYINNAME'; 
  ELSIF V_FIELD_NAME2 = 'DEPARTMENT' THEN
    V_FIELD_EN_NAME2  := 'DEPT_EN_NAME'; 
  ELSIF V_FIELD_NAME2 = 'POST_GROUP_NAME' THEN
    V_FIELD_EN_NAME2  := 'POST_GROUP_EN_NAME'; 
  ELSIF V_FIELD_NAME2 = 'POST_GRADE_LEVEL_NAME' THEN
    V_FIELD_EN_NAME2  := 'POST_GRADE_LEVEL_EN_NAME'; 
  ELSE
    V_FIELD_EN_NAME2  := V_FIELD_NAME2 || '_EN_NAME'; 
  END IF;

  --DBMS_OUTPUT.PUT_LINE(V_FIELD_EN_NAME2);

  -- 如果没有第二个区分项目
  IF V_FIELD_NAME2 IS NULL THEN
    IF V_FIELD_NAME1 IN ('(CONST)', '(CONST)') THEN
      V_STR := 'DELETE PA_BONUS_PARAM_DATA_TEMP ';
    ELSE
      V_STR := 'INSERT INTO PA_BONUS_PARAM_DATA_TEMP (FIELD1_VALUE,FIELD1_EN_VALUE,FIELD1_KOR_VALUE,FIELD2_VALUE,FIELD2_EN_VALUE,FIELD2_KOR_VALUE) SELECT  DISTINCT ' ||
               V_FIELD_NAME1 || ' AS FIELD1,' || V_FIELD_EN_NAME1 ||
               ' AS FIELD1_EN,'  ||
               '''''' || ' AS FIELD2,' || '''''' || ' AS FIELD2_EN,' ||
               '''''' || ' AS FIELD2_KOR' || ' FROM ' || V_FIELD_TABLE1 ||
               ' WHERE ' || V_FIELD_NAME1 || ' NOT IN' ||
               '(SELECT FIELD1_VALUE FROM PA_BONUS_PARAM_DATA WHERE FIELD1_VALUE IS NOT NULL AND  PARAM_NO = ' ||
               V_PARAM_NO || ')';
    END IF;
    -- 如果第一个区分项目为工号
  ELSIF V_FIELD1 = 'EMPID' THEN
    V_STR := 'INSERT INTO  PA_BONUS_PARAM_DATA_TEMP (FIELD1_VALUE,FIELD1_EN_VALUE,FIELD1_KOR_VALUE,FIELD2_VALUE,FIELD2_EN_VALUE,FIELD2_KOR_VALUE) SELECT  DISTINCT ' ||
             V_FIELD_NAME1 || ' AS FIELD1,' || V_FIELD_EN_NAME1 ||
             ' AS FIELD1_EN,' ||
             V_FIELD_NAME2 || ' AS FIELD2,' || V_FIELD_EN_NAME2 ||
             ' AS FIELD2_EN,' ||
             ' FROM ' || V_FIELD_TABLE1 || ' WHERE ' || V_FIELD_NAME1 ||
             ' NOT IN' ||
             '(SELECT FIELD1_VALUE FROM PA_BONUS_PARAM_DATA WHERE PARAM_NO = ' ||
             V_PARAM_NO || ')';
  ELSE
    V_STR := 'INSERT INTO  PA_BONUS_PARAM_DATA_TEMP (FIELD1_VALUE,FIELD1_EN_VALUE,FIELD1_KOR_VALUE,FIELD2_VALUE,FIELD2_EN_VALUE,FIELD2_KOR_VALUE) SELECT  DISTINCT ' ||
             V_FIELD_NAME1 || ' AS FIELD1,' || V_FIELD_EN_NAME1 ||
             ' AS FIELD1_EN,' ||
             V_FIELD_NAME2 || ' AS FIELD2,' || V_FIELD_EN_NAME2 ||
             ' AS FIELD2_EN,' ||
             ' FROM ' || V_FIELD_TABLE1 || ' WHERE ' || V_FIELD_NAME1 || '||' ||
             V_FIELD_NAME2 || ' NOT IN ' ||
             '(SELECT FIELD1_VALUE||FIELD2_VALUE FROM PA_BONUS_PARAM_DATA WHERE PARAM_NO = ' ||
             V_PARAM_NO || ')';
  END IF;

  SELECT COUNT(*)
    INTO R_COUNT
    FROM USER_TAB_COLUMNS
   WHERE TABLE_NAME = 'PA_BONUS_PARAM_DATA_TEMP';

  IF R_COUNT > 0 THEN
    EXECUTE IMMEDIATE 'DELETE  PA_BONUS_PARAM_DATA_TEMP';
  END IF;

  /*
  I := 0;
  WHILE I * 150 <= LENGTH(V_STR) LOOP
    DBMS_OUTPUT.PUT_LINE(SUBSTR(V_STR, I * 150, 150));
    I := I + 1;
  END LOOP;
  */

  EXECUTE IMMEDIATE V_STR;

END PR_BONUS_PARAM_LIST;
/

prompt
prompt Creating procedure PR_BONUS_PARAM_INITIAL
prompt =========================================
prompt
CREATE OR REPLACE PROCEDURE PR_BONUS_PARAM_INITIAL(V_PAMONTH VARCHAR2) IS
  -- 取得上个月的输入项目列表
  CURSOR CUS_PRM IS
    SELECT *
      FROM PA_BONUS_PARAM_ITEM
     WHERE PA_MONTH = PRIOR_PAMONTH(V_PAMONTH);

  V_OLD_PARAM_NO       NUMBER;
  V_PARAM_NAME         VARCHAR2(100);
  V_NEW_PARAM_NO       NUMBER;
  V_PARAM_TYPE_CODE    VARCHAR2(50);
  V_DISTINCT_FIELD     VARCHAR2(50);
  V_RETURN_STR         VARCHAR2(5000);
BEGIN

  DELETE PA_BONUS_PARAM_DATA
   WHERE PARAM_NO IN
         (SELECT PARAM_NO FROM PA_BONUS_PARAM_ITEM WHERE PA_MONTH = V_PAMONTH);

  DELETE PA_BONUS_PARAM_ITEM WHERE PA_MONTH = V_PAMONTH;

  -- 循环上月的所有输入项目
  FOR ROW_PAITEM IN CUS_PRM LOOP
    V_PARAM_NAME         := ROW_PAITEM.PARAM_NAME;
    V_OLD_PARAM_NO       := ROW_PAITEM.PARAM_NO;
    V_PARAM_TYPE_CODE    := ROW_PAITEM.PARAM_TYPE_CODE;
    V_DISTINCT_FIELD     := ROW_PAITEM.DISTINCT_FIELD_1ST;

    -- 复制上月的输入项目为本月的输入项目
    INSERT INTO PA_BONUS_PARAM_ITEM
      (PARAM_NO,
       PARAM_NAME,
       DISTINCT_FIELD_1ST,
       DISTINCT_FIELD_2ND,
       PA_MONTH,
       DATATYPE,
       DESCRIPTION,
       PARAM_TYPE_CODE,
       ORDER_NO,
       DEFAULT_VAL,
       PARAM_EN_NAME, 
       PARAM_ID)
      SELECT PA_BONUS_PARAM_ITEM_SEQ.NEXTVAL,
             PARAM_NAME,
             DISTINCT_FIELD_1ST,
             DISTINCT_FIELD_2ND,
             V_PAMONTH,
             DATATYPE,
             DESCRIPTION,
             PARAM_TYPE_CODE,
             ORDER_NO,
             DEFAULT_VAL,
             PARAM_EN_NAME, 
             PARAM_ID
        FROM PA_BONUS_PARAM_ITEM
       WHERE PARAM_NO = V_OLD_PARAM_NO;

    CASE
    -- 如果第一个区分项目为“工号”

      WHEN V_DISTINCT_FIELD = 'EMPID' THEN
        -- 取得新输入项目号
        SELECT PA_BONUS_PARAM_ITEM_SEQ.CURRVAL INTO V_NEW_PARAM_NO FROM DUAL;

        -- 复制上月输入项目值的值到本月
        IF V_DISTINCT_FIELD IN ('(CONST)', '(CONST)') THEN
          INSERT INTO PA_BONUS_PARAM_DATA
            (PARAM_DATA_NO,
             PARAM_NO,
             FIELD1_VALUE,
             FIELD2_VALUE,
             RETURN_VALUE,
             FIELD1_EN_VALUE,
             FIELD2_EN_VALUE)
            SELECT PA_BONUS_PARAM_DATA_SEQ.NEXTVAL,
                   V_NEW_PARAM_NO,
                   FIELD1_VALUE,
                   FIELD2_VALUE,
                   RETURN_VALUE,
                   FIELD1_EN_VALUE,
                   FIELD2_EN_VALUE
              FROM PA_BONUS_PARAM_DATA
             WHERE PARAM_NO = V_OLD_PARAM_NO;
        ELSIF V_PARAM_TYPE_CODE = 'ALL' -- 参数类型：复制并补缺
         THEN
          BEGIN
            --- COPY DATA FROM PRIOR MONTH
            INSERT INTO PA_BONUS_PARAM_DATA
              (PARAM_DATA_NO,
               PARAM_NO,
               FIELD1_VALUE,
               FIELD2_VALUE,
               RETURN_VALUE,
               FIELD1_EN_VALUE,
               FIELD2_EN_VALUE)
              SELECT PA_BONUS_PARAM_DATA_SEQ.NEXTVAL,
                     V_NEW_PARAM_NO,
                     FIELD1_VALUE,
                     FIELD2_VALUE,
                     RETURN_VALUE,
                     FIELD1_EN_VALUE,
                     FIELD2_EN_VALUE
                FROM PA_BONUS_PARAM_DATA
               WHERE PARAM_NO = V_OLD_PARAM_NO
                 AND FIELD1_VALUE IN
                     (SELECT EMPID FROM HR_EMP_PA_INFO WHERE CALC_FLAG = 'Y')
                 AND NOT (RETURN_VALUE IS NULL OR LENGTH(RETURN_VALUE) = 0 OR
                      RETURN_VALUE = 'NULL');

            --  INSERT LOSED DATA INTO PA_BONUS_PARAM_DATA THE DEFAULT VALUE SET AS 0
            PR_BONUS_PARAM_LIST(V_NEW_PARAM_NO);

            INSERT INTO PA_BONUS_PARAM_DATA
              (PARAM_DATA_NO,
               PARAM_NO,
               FIELD1_VALUE,
               FIELD2_VALUE,
               RETURN_VALUE,
               FIELD1_EN_VALUE,
               FIELD2_EN_VALUE)
              SELECT PA_BONUS_PARAM_DATA_SEQ.NEXTVAL,
                     V_NEW_PARAM_NO,
                     FIELD1_VALUE,
                     FIELD2_VALUE,
                     0,
                     FIELD1_EN_VALUE,
                     FIELD2_EN_VALUE
                FROM PA_BONUS_PARAM_DATA_TEMP;
          END;
        ELSIF V_PARAM_TYPE_CODE = 'CLONE' -- 参数类型：原样复制
         THEN
          INSERT INTO PA_BONUS_PARAM_DATA
            (PARAM_DATA_NO,
             PARAM_NO,
             FIELD1_VALUE,
             FIELD2_VALUE,
             RETURN_VALUE,
             FIELD1_EN_VALUE,
             FIELD2_EN_VALUE)
            SELECT PA_BONUS_PARAM_DATA_SEQ.NEXTVAL,
                   V_NEW_PARAM_NO,
                   FIELD1_VALUE,
                   FIELD2_VALUE,
                   RETURN_VALUE,
                   FIELD1_EN_VALUE,
                   FIELD2_EN_VALUE
              FROM PA_BONUS_PARAM_DATA
             WHERE PARAM_NO = V_OLD_PARAM_NO
               AND FIELD1_VALUE IN
                   (SELECT EMPID FROM HR_EMP_PA_INFO WHERE CALC_FLAG = 'Y')
               AND NOT (RETURN_VALUE IS NULL OR LENGTH(RETURN_VALUE) = 0 OR
                    RETURN_VALUE = 'NULL');
        ELSIF V_PARAM_TYPE_CODE = 'ALL_ZERO' -- 参数类型：清零并补缺
         THEN
          BEGIN
            PR_BONUS_PARAM_LIST(V_NEW_PARAM_NO);

            INSERT INTO PA_BONUS_PARAM_DATA
              (PARAM_DATA_NO,
               PARAM_NO,
               FIELD1_VALUE,
               FIELD2_VALUE,
               RETURN_VALUE,
               FIELD1_EN_VALUE,
               FIELD2_EN_VALUE)
              SELECT PA_BONUS_PARAM_DATA_SEQ.NEXTVAL,
                     V_NEW_PARAM_NO,
                     FIELD1_VALUE,
                     FIELD2_VALUE,
                     0,
                     FIELD1_EN_VALUE,
                     FIELD2_EN_VALUE
                FROM PA_BONUS_PARAM_DATA_TEMP
               WHERE FIELD1_VALUE IN
                     (SELECT EMPID FROM HR_EMP_PA_INFO WHERE CALC_FLAG = 'Y');
          END;
        ELSE
          -- 参数类型：清除全部数据
          V_RETURN_STR := V_RETURN_STR || V_PARAM_NAME || '   ' ||
                          V_PARAM_TYPE_CODE || CHR(13);
        END IF;

    -- 如果第一个区分项目不为“工号”
      ELSE
        SELECT PA_BONUS_PARAM_ITEM_SEQ.CURRVAL INTO V_NEW_PARAM_NO FROM DUAL;

        -- 复制上月输入项目值的值到本月
        IF V_DISTINCT_FIELD IN ('(CONST)', '(CONST)') THEN
          INSERT INTO PA_BONUS_PARAM_DATA
            (PARAM_DATA_NO,
             PARAM_NO,
             FIELD1_VALUE,
             FIELD2_VALUE,
             RETURN_VALUE,
             FIELD1_EN_VALUE,
             FIELD2_EN_VALUE)
            SELECT PA_BONUS_PARAM_DATA_SEQ.NEXTVAL,
                   V_NEW_PARAM_NO,
                   FIELD1_VALUE,
                   FIELD2_VALUE,
                   RETURN_VALUE,
                   FIELD1_EN_VALUE,
                   FIELD2_EN_VALUE
              FROM PA_BONUS_PARAM_DATA
             WHERE PARAM_NO = V_OLD_PARAM_NO;
        ELSIF V_PARAM_TYPE_CODE = 'ALL' -- 参数类型：复制并补缺
         THEN
          BEGIN
            --- COPY DATA FROM PRIOR MONTH
            INSERT INTO PA_BONUS_PARAM_DATA
              (PARAM_DATA_NO,
               PARAM_NO,
               FIELD1_VALUE,
               FIELD2_VALUE,
               RETURN_VALUE,
               FIELD1_EN_VALUE,
               FIELD2_EN_VALUE)
              SELECT PA_BONUS_PARAM_DATA_SEQ.NEXTVAL,
                     V_NEW_PARAM_NO,
                     FIELD1_VALUE,
                     FIELD2_VALUE,
                     RETURN_VALUE,
                     FIELD1_EN_VALUE,
                     FIELD2_EN_VALUE
                FROM PA_BONUS_PARAM_DATA
               WHERE PARAM_NO = V_OLD_PARAM_NO
                 AND NOT (RETURN_VALUE IS NULL OR LENGTH(RETURN_VALUE) = 0 OR
                      RETURN_VALUE = 'NULL');

            --  INSERT LOSED DATA INTO PA_BONUS_PARAM_DATA THE DEFAULT VALUE SET AS 0
            PR_BONUS_PARAM_LIST(V_NEW_PARAM_NO);

            INSERT INTO PA_BONUS_PARAM_DATA
              (PARAM_DATA_NO,
               PARAM_NO,
               FIELD1_VALUE,
               FIELD2_VALUE,
               RETURN_VALUE,
               FIELD1_EN_VALUE,
               FIELD2_EN_VALUE)
              SELECT PA_BONUS_PARAM_DATA_SEQ.NEXTVAL,
                     V_NEW_PARAM_NO,
                     FIELD1_VALUE,
                     FIELD2_VALUE,
                     0,
                     FIELD1_EN_VALUE,
                     FIELD2_EN_VALUE
                FROM PA_BONUS_PARAM_DATA_TEMP;
          END;
        ELSIF V_PARAM_TYPE_CODE = 'CLONE' -- 参数类型：原样复制
         THEN
          INSERT INTO PA_BONUS_PARAM_DATA
            (PARAM_DATA_NO,
             PARAM_NO,
             FIELD1_VALUE,
             FIELD2_VALUE,
             RETURN_VALUE,
             FIELD1_EN_VALUE,
             FIELD2_EN_VALUE)
            SELECT PA_BONUS_PARAM_DATA_SEQ.NEXTVAL,
                   V_NEW_PARAM_NO,
                   FIELD1_VALUE,
                   FIELD2_VALUE,
                   RETURN_VALUE,
                   FIELD1_EN_VALUE,
                   FIELD2_EN_VALUE
              FROM PA_BONUS_PARAM_DATA
             WHERE PARAM_NO = V_OLD_PARAM_NO
               AND NOT (RETURN_VALUE IS NULL OR LENGTH(RETURN_VALUE) = 0 OR
                    RETURN_VALUE = 'NULL');
        ELSIF V_PARAM_TYPE_CODE = 'ALL_ZERO' -- 参数类型：清零并补缺
         THEN
          BEGIN
            PR_BONUS_PARAM_LIST(V_NEW_PARAM_NO);
            -------------------------------------------------------------------
            INSERT INTO PA_BONUS_PARAM_DATA
              (PARAM_DATA_NO,
               PARAM_NO,
               FIELD1_VALUE,
               FIELD2_VALUE,
               RETURN_VALUE,
               FIELD1_EN_VALUE,
               FIELD2_EN_VALUE)
              SELECT PA_BONUS_PARAM_DATA_SEQ.NEXTVAL,
                     V_NEW_PARAM_NO,
                     FIELD1_VALUE,
                     FIELD2_VALUE,
                     0,
                     FIELD1_EN_VALUE,
                     FIELD2_EN_VALUE
                     FIELD2_KOR_VALUE
                FROM PA_BONUS_PARAM_DATA_TEMP;
          END;
        ELSE
          -- 参数类型：清除全部数据
          V_RETURN_STR := V_RETURN_STR || V_PARAM_NAME || '   ' ||
                          V_PARAM_TYPE_CODE || CHR(13);
        END IF;
    END CASE;

  END LOOP;
END;
/

prompt
prompt Creating procedure PR_FORMULA_INITIAL
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE PR_FORMULA_INITIAL(V_PAMONTH VARCHAR2) IS
  -- 取得上个月的输入项目列表
  V_PRIOR_PA_MONTH VARCHAR(10) := PRIOR_PAMONTH(V_PAMONTH) ;
BEGIN

    DELETE PA_FORMULAR WHERE PA_MONTH = V_PAMONTH;

    -- 复制上月的输入项目为本月的输入项目
    INSERT INTO PA_FORMULAR
           (FORMULAR_NO,
            ITEM_NO,
            CONDITION,
            FORMULAR,
            ORDERNO,
            DESCRIPTION,
            PA_MONTH,
            CREATE_DATE,
            CREATED_BY,
            ACTIVITY)
      SELECT PA_FORMULAR_SEQ.NEXTVAL,
             ITEM_NO,
             CONDITION,
             FORMULAR,
             ORDERNO,
             DESCRIPTION,
             V_PAMONTH,
             CREATE_DATE,
             CREATED_BY,
             ACTIVITY
        FROM PA_FORMULAR
       WHERE PA_MONTH = V_PRIOR_PA_MONTH ;

   COMMIT ;
END;
/

prompt
prompt Creating procedure PR_INSURANCE_FORMULA_INITIAL
prompt ===============================================
prompt
CREATE OR REPLACE PROCEDURE PR_INSURANCE_FORMULA_INITIAL(V_PAMONTH VARCHAR2) IS
  -- 取得上个月的输入项目列表
  V_PRIOR_PA_MONTH VARCHAR(10) := PRIOR_PAMONTH(V_PAMONTH) ;
BEGIN

    DELETE PA_INS_FORMULAR WHERE PA_MONTH = V_PAMONTH;

    -- 复制上月的输入项目为本月的输入项目
    INSERT INTO PA_BONUS_FORMULAR
           (FORMULAR_NO,
            ITEM_NO,
            CONDITION,
            FORMULAR,
            ORDERNO,
            DESCRIPTION,
            PA_MONTH,
            CREATE_DATE,
            CREATED_BY,
            ACTIVITY)
      SELECT PA_INS_FORMULAR_SEQ.NEXTVAL,
             ITEM_NO,
             CONDITION,
             FORMULAR,
             ORDERNO,
             DESCRIPTION,
             V_PAMONTH,
             CREATE_DATE,
             CREATED_BY,
             ACTIVITY
        FROM PA_INS_FORMULAR
       WHERE PA_MONTH = V_PRIOR_PA_MONTH ;

   COMMIT ;
END;
/

prompt
prompt Creating procedure PR_INSURANCE_PACAL
prompt =====================================
prompt
CREATE OR REPLACE PROCEDURE PR_INSURANCE_PACAL(V_PA_MONTH_STR VARCHAR2,
                                               V_INS_MONTH_STR VARCHAR2,
                                               V_PA_FORMULAR_MONTH_STR VARCHAR2,
                                               V_EXEC_MODE    VARCHAR2,
                                               V_OUTPUT_TYPE  VARCHAR2,
                                               V_OUTPUT_STR   OUT VARCHAR2)
  AUTHID CURRENT_USER IS
  /* V_EXEC_MODE :
                 NORMAL            正常计算
                 TEST              只生成脚本不执行计算
                 ONLY_CREATE_TABLE 只建表 不计算
     V_OUTPUT_TYPE       输出模式
                 ALL     全部输出
                 PARAM   参数部分 CUIJINHUA ZHU ZHENGQI
                 PAITEM  工资项目部分
                 NONE    不输出

  */
  I                      INTEGER;
  V_STR                  VARCHAR2(20000); -- 创建T_PA_RESULT表的SQL
  V_BSTR                 VARCHAR2(20000); -- 更新T_PA_RESULT表的基础项目值的SQL
  V_CASTR                VARCHAR2(20000); -- 更新T_PA_RESULT表的工资项目值的SQL
  V_PSTR                 VARCHAR2(20000); -- 更新T_PA_RESULT表的输入项目值的SQL
  V_INDEX_STR            VARCHAR2(20000); -- 创建T_PA_RESULT索引SQL
  V_CONDITION_COUNT      INT; -- 工资项目空条件数量
  V_FOMULAR_COUNT        INT; -- 工资项目公式数量
  R_COUNT                INT;
  V_PARAM_ID             VARCHAR2(50);
  V_TIME                 DATE := SYSDATE;
  V_EMP_COUNT            VARCHAR2(6);
  V_ITEM_ID              VARCHAR2(50);
  V_BASIC_ITEM_ID        VARCHAR2(50);
  V_FORMULAR_NOCONDITION VARCHAR2(2000) ;

  -- 人事表游标
  CURSOR CUS_HR IS
    SELECT FIELD_NAME,
           DISTINCT_FIELD,
           TABLE_NAME,
           FIELD_EN_NAME,
           FIELD_KOR_NAME
      FROM PA_DISTINCT_LIST
     WHERE TABLE_NAME = 'PA_HR_V'
     ORDER BY ID;
 
  -- 基础项目游标
  CURSOR CUS_BASIC_ITEM IS
    SELECT ITEM_NO,
           ITEM_ID,
           ITEM_NAME,
           ITEM_EN_NAME, 
           DISTINCT_FIELD_1ST,
           DISTINCT_FIELD_2ND,
           DATATYPE,
           DEFAULT_VAL
      FROM PA_BASIC_ITEM
     WHERE ACTIVITY = 1;

  -- 保险输入项目游标
  CURSOR CUS_PARAM IS
    SELECT PARAM_NO, 
           PARAM_ID,
           PARAM_NAME,
           PARAM_EN_NAME,
           DISTINCT_FIELD_1ST,
           DISTINCT_FIELD_2ND,
           DATATYPE,
           DEFAULT_VAL
      FROM PA_INS_PARAM_ITEM
     WHERE PA_MONTH = V_INS_MONTH_STR;

  -- 保险计算项目游标
  CURSOR CUS_ITEM IS
    SELECT ITEM_NO,
           ITEM_ID,
           ITEM_NAME,
           ITEM_EN_NAME, 
           DATATYPE,
           PRECISION,
           CARRY_BIT
      FROM PA_INS_ITEM
     ORDER BY CALCU_ORDER;

  -- 保险公式游标
  CURSOR CUS_FORMULAR(ITEM_NO_IN NUMBER) IS
    SELECT *
      FROM PA_INS_FORMULAR
     WHERE ITEM_NO = ITEM_NO_IN
       AND PA_MONTH = V_PA_FORMULAR_MONTH_STR
     ORDER BY ORDERNO DESC;

BEGIN

  SELECT NVL(MAX(INS_LOCK_FLAG),0)
    INTO R_COUNT
    FROM PA_PROGRESS
   WHERE MONTH_STR = V_INS_MONTH_STR;

  -- 验证当月是否存已锁定
  IF R_COUNT = 1 THEN
    BEGIN
      V_OUTPUT_STR := '错误: 当月保险已锁定,不能再进行计算.';
      RETURN;
    END;
  END IF;

  SELECT COUNT(*)
    INTO R_COUNT
    FROM PA_INS_PARAM_ITEM
   WHERE PA_MONTH = V_INS_MONTH_STR;

  -- 验证当月是否存在输入项目
  IF R_COUNT = 0 THEN
    BEGIN
      V_OUTPUT_STR := '错误: 当月保险无输入项目，请初始化输入项目.';
      RETURN;
    END;
  END IF;

  -- 更新有问题的输入项目数据
  UPDATE PA_INS_PARAM_DATA
     SET RETURN_VALUE = NULL
   WHERE LOWER(RETURN_VALUE) = 'null'
     AND EXISTS(
         SELECT * FROM PA_INS_PARAM_ITEM T
          WHERE T.PARAM_NO = PA_INS_PARAM_DATA.PARAM_NO
            AND T.PA_MONTH = V_INS_MONTH_STR
     );

  COMMIT;
  -- 设置输出缓冲区大小
  -- SET OUTPUT ON SIZE 50000;
  DBMS_OUTPUT.ENABLE(5000000);
  -- EXECUTE IMMEDIATE 'SET LINESIZE = 5000';
  -- 建表字符串，表的列由参数名称 || 保险项目名称组成。工资项目名称按计算顺序排列。
  V_STR         := 'CREATE TABLE T_PA_INS_RESULT AS SELECT  ''' 
               || V_INS_MONTH_STR || ''' AS INS_MONTH,' 
               || '''' || V_PA_MONTH_STR || ''' AS PA_MONTH,'
               || '''' || V_PA_FORMULAR_MONTH_STR || ''' AS INS_FORMULAR_MONTH,' ;

  -- 验证计算项目名称是否重复
  BEGIN
    SELECT ITEM_ID
      INTO V_ITEM_ID
      FROM (SELECT ITEM_ID, COUNT(ITEM_ID) AS NUM
              FROM PA_INS_ITEM
             GROUP BY ITEM_ID) P
     WHERE P.NUM > 1
       AND ROWNUM = 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_ITEM_ID := NULL;
  END;

  -- 如果计算项目名称重复提示错误
  IF V_ITEM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误: 保险项目ID"' || V_ITEM_ID || '"出现重复,请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 验证输入项目名称是否重复
  BEGIN
    SELECT PARAM_ID
      INTO V_ITEM_ID
      FROM (SELECT PARAM_ID, COUNT(PARAM_ID) AS NUM
              FROM PA_INS_PARAM_ITEM
             WHERE PA_MONTH = V_INS_MONTH_STR
             GROUP BY PARAM_ID)
     WHERE NUM > 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_ITEM_ID := NULL;
  END;

  -- 如果输入项目名称重复提示错误
  IF V_ITEM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误: 输入项目ID"' || V_ITEM_ID || '"出现重复,请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 验证基础项目名称是否与接口表的字段名称重复
  BEGIN
    SELECT DISTINCT_FIELD
      INTO V_ITEM_ID
      FROM PA_DISTINCT_LIST
     WHERE DISTINCT_FIELD IN
           (SELECT ITEM_ID FROM PA_BASIC_ITEM WHERE ACTIVITY = 1);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_ITEM_ID := NULL;
  END;

  -- 如果基础项目名称与接口表的字段名称重复提示错误
  IF V_ITEM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误：保险基础项目ID“' || V_ITEM_ID || '”和人事项目ID“' ||
                      V_ITEM_ID || '”出现重复。请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 验证输入项目名称是否与接口表的字段名称重复
  BEGIN
    SELECT DISTINCT_FIELD
      INTO V_ITEM_ID
      FROM PA_DISTINCT_LIST
     WHERE DISTINCT_FIELD IN
           (SELECT PARAM_ID
              FROM PA_INS_PARAM_ITEM
             WHERE PA_MONTH = V_INS_MONTH_STR);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_ITEM_ID := NULL;
  END;

  -- 如果输入项目名称与接口表的字段名称重复提示错误
  IF V_ITEM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误：保险输入项目ID“' || V_ITEM_ID || '”和人事项目ID“' ||
                      V_ITEM_ID || '”出现重复。请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 验证计算项目名称是否与接口表的字段名称重复
  BEGIN
    SELECT DISTINCT_FIELD
      INTO V_ITEM_ID
      FROM PA_DISTINCT_LIST
     WHERE DISTINCT_FIELD IN (SELECT ITEM_ID FROM PA_INS_ITEM);
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_ITEM_ID := NULL;
  END;

  -- 如果计算项目名称与接口表的字段名称重复提示错误
  IF V_ITEM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误： 保险计算项目ID“' || V_ITEM_ID || '”和人事项目ID“' ||
                      V_ITEM_ID || '”出现重复。请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 验证计算项目名称是否与基础项目名称重复
  BEGIN
    SELECT PA_BASIC_ITEM.ITEM_ID
      INTO V_BASIC_ITEM_ID
      FROM PA_BASIC_ITEM, PA_INS_ITEM
     WHERE PA_BASIC_ITEM.ITEM_ID = PA_INS_ITEM.ITEM_ID
       AND PA_BASIC_ITEM.ACTIVITY = 1
       AND ROWNUM = 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_BASIC_ITEM_ID := NULL;
  END;

  -- 如果计算项目名称与基础项目名称重复提示错误
  IF V_BASIC_ITEM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误： 参数名称ID“' || V_BASIC_ITEM_ID || '”和保险项目ID“' ||
                      V_BASIC_ITEM_ID || '”出现重复。请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 验证计算项目名称是否与输入项目名称重复
  BEGIN
    SELECT PA_INS_PARAM_ITEM.PARAM_ID
      INTO V_PARAM_ID
      FROM PA_INS_PARAM_ITEM, PA_INS_ITEM
     WHERE PA_INS_PARAM_ITEM.PARAM_ID = PA_INS_ITEM.ITEM_ID
       AND PA_INS_PARAM_ITEM.PA_MONTH = V_INS_MONTH_STR
       AND ROWNUM = 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_PARAM_ID := NULL;
  END;

  -- 如果计算项目名称与输入项目名称重复提示错误
  IF V_PARAM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误： 参数名称ID“' || V_PARAM_ID || '”和保险项目ID“' ||
                      V_PARAM_ID || '”出现重复。请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 拼接人事数据列
  FOR HR_ROW IN CUS_HR LOOP
    -- 拼接创建表T_PA_INS_RESULT的SQL字符串
    V_STR := V_STR || HR_ROW.TABLE_NAME || '.' || HR_ROW.DISTINCT_FIELD ||
             ' AS "' || HR_ROW.DISTINCT_FIELD || '",' || CHR(13);

  END LOOP;
  
  -- 拼接基础项目列
  FOR BASIC_ROW IN CUS_BASIC_ITEM LOOP
    BEGIN
      V_STR := V_STR || (CASE UPPER(SUBSTR(BASIC_ROW.DATATYPE, 1, 4))
                 WHEN 'NUMB' THEN
                  '0'
                 WHEN 'VARC' THEN
                  '''                                                                                                    '''
                 WHEN 'DATE' THEN
                  'SYSDATE'
               --此处留100空格确定此列长宽度
               END) || ' AS "' || BASIC_ROW.ITEM_ID || '" ,' || CHR(13);
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20101,
                                '基础项目数据类型错误: [' || BASIC_ROW.ITEM_ID || ']');
    END;

  END LOOP;

  -- 拼接输入项目列
  FOR PAR_ROW IN CUS_PARAM LOOP
    BEGIN
      V_STR := V_STR || (CASE UPPER(SUBSTR(PAR_ROW.DATATYPE, 1, 4))
                 WHEN 'NUMB' THEN
                  '0'
                 WHEN 'VARC' THEN
                  '''                                                                                                    '''
                 WHEN 'DATE' THEN
                  'SYSDATE'
               --此处留100空格确定此列长宽度
               END) || ' AS "' || PAR_ROW.PARAM_ID || '" ,' || CHR(13);
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20101,
                                '保险参数数据类型错误: [' || PAR_ROW.PARAM_ID || ']');
    END;

  END LOOP;

  -- 拼接保险计算项目列
  FOR PA_ROW IN CUS_ITEM LOOP
    V_STR := V_STR || (CASE UPPER(SUBSTR(PA_ROW.DATATYPE, 1, 4))
               WHEN 'NUMB' THEN
                '0'
               WHEN 'VARC' THEN
                '''                                                                                                    '''
             --此处留100空格确定此列长宽度
               ELSE
                ''' '''
             END) || ' AS "' || PA_ROW.ITEM_ID || '" ,' || CHR(13);
  END LOOP ;
  --去 掉最后逗号
  V_STR := SUBSTR(V_STR, 0, LENGTH(V_STR) - 2);
  ---创建 计算结果表 并插入人事及数据
  V_STR := V_STR || ' FROM PA_HR_V, HR_EMP_PA_INFO' ||
           ' WHERE PA_HR_V.EMPID = HR_EMP_PA_INFO.EMPID(+)' ||
           ' AND HR_EMP_PA_INFO.CALC_FLAG=''Y''' ||
           ' AND EXISTS(SELECT * FROM PA_INS_EMP T WHERE PA_HR_V.EMPID = T.EMPID AND T.PA_MONTH = ''' || V_INS_MONTH_STR || ''')';

  DBMS_OUTPUT.PUT_LINE('THIS IS CREATE TABLE STRING');
  I := 0;

  -- 日志输出
  IF V_OUTPUT_TYPE IN ('ALL') THEN
    WHILE I * 150 <= LENGTH(V_STR) LOOP
      DBMS_OUTPUT.PUT_LINE(SUBSTR(V_STR, I * 150, 150));
      I := I + 1;
    END LOOP;
  END IF;

  SELECT COUNT(*)
    INTO R_COUNT
    FROM USER_TAB_COLUMNS
   WHERE TABLE_NAME = 'T_PA_INS_RESULT';

  IF R_COUNT > 0 THEN
    BEGIN
      EXECUTE IMMEDIATE 'DROP TABLE T_PA_INS_RESULT';
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20101, '删除 T_PA_INS_RESULT 失败', TRUE);
    END;
  END IF;

  V_INDEX_STR := 'alter table T_PA_INS_RESULT add constraint PK_T_PA_INS_RESULT primary key (EMPID) ' ;

  -- 执行创建表T_PA_RESULT的SQL
  IF V_EXEC_MODE IN ('NORMAL', 'ONLY_CREATE_TABLE', 'PARAM', 'PAITEM') THEN
    BEGIN
      EXECUTE IMMEDIATE V_STR;
      EXECUTE IMMEDIATE V_INDEX_STR;

      COMMIT;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20101,
                                '创建计算结果表失败: [' ||
                                SUBSTR(V_STR, LENGTH(V_STR) - 1000, 1000) || ']',
                                TRUE);
    END;
  END IF ;
  ---------------------------------------------------------- 基础项目计算 ----------------------------------------------------------
  DBMS_OUTPUT.PUT_LINE(CHR(13) ||
                       ' ----------    THIS IS THE CALCULATE BASIC DATA STRING ----------');
  -- 验证所传入的基础月,是否存在历史数据
  SELECT COUNT(*)
    INTO R_COUNT
    FROM PA_HISTORY
   WHERE PA_MONTH = V_PA_MONTH_STR
     AND ROWNUM = 1;

  FOR BASIC_VAL IN CUS_BASIC_ITEM LOOP
    -- 创建更新T_PA_RESULT基本项目的SQL
    IF R_COUNT > 0 THEN
       V_BSTR := 'UPDATE T_PA_INS_RESULT T SET "' || BASIC_VAL.ITEM_ID || '" = NVL('
       || '(SELECT "' || BASIC_VAL.ITEM_ID || '" FROM PA_HISTORY PA WHERE PA.EMPID = T.EMPID AND PA.PA_MONTH = ''' || V_PA_MONTH_STR || ''' )'
       || ',0)' ;
    ELSE

      V_BSTR := 'UPDATE T_PA_INS_RESULT SET "' || BASIC_VAL.ITEM_ID || '" = NVL(' ||

                  ' (SELECT P.RETURN_VALUE FROM  PA_BASIC_DATA  P WHERE ' ||
                  BASIC_VAL.DISTINCT_FIELD_1ST || '  = P.FIELD1_VALUE ' || CASE
                    WHEN TRIM(BASIC_VAL.DISTINCT_FIELD_2ND) IS NOT NULL THEN
                     ' AND ' || BASIC_VAL.DISTINCT_FIELD_2ND ||
                     ' = P.FIELD2_VALUE '
                  END

                  || ' AND P.ITEM_NO=' ||
                  TO_CHAR(BASIC_VAL.ITEM_NO) || ' AND P.ACTIVITY = 1 ),''' || BASIC_VAL.DEFAULT_VAL ||
                  ''')';
    END IF ;

    IF V_OUTPUT_TYPE IN ('ALL', 'BASIC') THEN
      I := 0;
      WHILE I * 150 <= LENGTH(V_BSTR) LOOP

          DBMS_OUTPUT.PUT_LINE(SUBSTR(V_BSTR, I * 150, 150));
          I := I + 1;

      END LOOP;
    END IF;
    IF V_EXEC_MODE IN ('NORMAL', 'BASIC') THEN
      BEGIN
        EXECUTE IMMEDIATE V_BSTR;
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20101,
                                  '参数计算失败: [' || V_BSTR || ']');
      END;
    END IF;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('----------CALCULATE BASIC DATA STRING FINISHED-----------');

  ----------------------------------------------------------  输入项目计算 ---------------------------------------------------------
  DBMS_OUTPUT.PUT_LINE(CHR(13) ||
                       ' ----------    THIS IS THE CALCULATE PARAM DATA STRING ----------');

  FOR PAR_VAL IN CUS_PARAM LOOP
    -- 创建更新T_PA_INS_RESULT输入项目的SQL
    V_PSTR := 'UPDATE T_PA_INS_RESULT SET "' || PAR_VAL.PARAM_ID || '" = NVL('
           || ' (SELECT P.RETURN_VALUE FROM  PA_INS_PARAM_DATA  P WHERE '
           || PAR_VAL.DISTINCT_FIELD_1ST || '  = P.FIELD1_VALUE '
           || CASE WHEN TRIM(PAR_VAL.DISTINCT_FIELD_2ND) IS NOT NULL THEN
                   ' AND ' || PAR_VAL.DISTINCT_FIELD_2ND || ' = P.FIELD2_VALUE '
                END || ' AND P.PARAM_NO=' || TO_CHAR(PAR_VAL.PARAM_NO) ||
                ' ),''' || PAR_VAL.DEFAULT_VAL || ''')';

    IF V_OUTPUT_TYPE IN ('ALL', 'PARAM') THEN
      I := 0;
      WHILE I * 150 <= LENGTH(V_PSTR) LOOP

          DBMS_OUTPUT.PUT_LINE(SUBSTR(V_PSTR, I * 150, 150));
          I := I + 1;

      END LOOP;
    END IF;

    IF V_EXEC_MODE IN ('NORMAL', 'PARAM') THEN
      BEGIN
        EXECUTE IMMEDIATE V_PSTR;
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20101,
                                  '参数计算失败: [' || V_PSTR || ']');
      END;
    END IF;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('----------CALCULATE PARAM DATA STRING FINISHED-----------');

  ---------------------------------------------------   工资项目计算   -------------------------------------------------------------
  DBMS_OUTPUT.PUT_LINE(CHR(13) ||
                       '  -------------------  THIS IS THE CALCU PA ITEMS STRING ---------');

    FOR PAITEM_VAL IN CUS_ITEM LOOP

      -- 字符类型工资项目
      IF Instr(PAITEM_VAL.DATATYPE, 'VARCHAR') > 0 THEN
        V_CASTR := CHR(13) || 'UPDATE T_PA_INS_RESULT set "' ||
                   PAITEM_VAL.ITEM_ID || '" = ';
        -- 数值类型工资项目
      ELSE
        V_CASTR := CHR(13) || 'UPDATE T_PA_INS_RESULT set "' ||
                   PAITEM_VAL.ITEM_ID || '" = TRUNC((' ||
                   PAITEM_VAL.CARRY_BIT || ' + ';
      END IF;

      /************************************************计算所有工资项目**************************************
         鍏紡浜旂鎯呭喌锛
         1.    无公式                  0
         2.    鍗曚竴鍏紡鏃犳潯浠?         鐩存帴鍒楀叕寮
         3.    单一公式有条件          CASE WHEN 条件 THEN 公式 ELSE 0 END
         4.    多公式均有条件          CASE 循环(WHEN 条件 THEN 公式) ELSE 0 END
         5.    多公式，其中一条无条件  CASE 循环(WHEN 条件 THEN 公式) ELSE 公式 END
      *******************************************************************************************************/

      SELECT COUNT(*)
        INTO V_FOMULAR_COUNT
        FROM PA_INS_FORMULAR
       WHERE ITEM_NO = PAITEM_VAL.ITEM_NO
         AND PA_MONTH = V_PA_FORMULAR_MONTH_STR ;

      -- 取得当前工资项目的空公式条件数量
      SELECT COUNT(*)
        INTO V_CONDITION_COUNT
        FROM PA_INS_FORMULAR
         WHERE ITEM_NO = PAITEM_VAL.ITEM_NO
         AND PA_MONTH = V_PA_FORMULAR_MONTH_STR 
         AND (REPLACE(REPLACE(RTRIM(LTRIM(CONDITION)), CHR(9), ''), ' ', '') = '' OR
             CONDITION IS NULL);

      IF V_FOMULAR_COUNT = 0 THEN
        V_CASTR := V_CASTR || '0';
      ELSIF V_FOMULAR_COUNT = 1 AND V_CONDITION_COUNT = 1 THEN
        SELECT V_CASTR || FORMULAR
          INTO V_CASTR
          FROM PA_INS_FORMULAR
         WHERE ITEM_NO = PAITEM_VAL.ITEM_NO
         AND PA_MONTH = V_PA_FORMULAR_MONTH_STR ;
      ELSE
        V_CASTR := V_CASTR || ' CASE ';

        FOR FORMULAR_ROW IN CUS_FORMULAR(PAITEM_VAL.ITEM_NO)
          LOOP
          IF REPLACE(REPLACE(RTRIM(LTRIM(FORMULAR_ROW.CONDITION)),
                             CHR(9),
                             ''),
                     ' ',
                     '') = '' OR FORMULAR_ROW.CONDITION IS NULL THEN
            V_FORMULAR_NOCONDITION := FORMULAR_ROW.FORMULAR;
          ELSE
            V_CASTR := V_CASTR || ' WHEN ' || FORMULAR_ROW.CONDITION ||
                       ' THEN ' || FORMULAR_ROW.FORMULAR;
          END IF;
        END LOOP;

        IF V_CONDITION_COUNT = 0 THEN

          -- 字符类型工资项目
          IF Instr(PAITEM_VAL.DATATYPE, 'VARCHAR') > 0 THEN
            V_CASTR := V_CASTR || ' ELSE '''' END ';
          ELSE
            V_CASTR := V_CASTR || ' ELSE 0 END ';
          END IF;
        ELSE
          V_CASTR := V_CASTR || ' ELSE ' || V_FORMULAR_NOCONDITION ||
                     ' END ';
        END IF;
      END IF;

      -- 数值类型工资项目
      IF Instr(PAITEM_VAL.DATATYPE, 'NUMBER') > 0 THEN
        V_CASTR := V_CASTR || '),' || PAITEM_VAL.PRECISION || ')';
      END IF;

      IF V_OUTPUT_TYPE IN ('ALL', 'PAITEM') THEN
        I := 0;
        WHILE I * 150 <= LENGTH(V_CASTR) LOOP

            DBMS_OUTPUT.PUT_LINE(SUBSTR(V_CASTR, I * 150, 150));
            I := I + 1;

        END LOOP;
      END IF;

      IF V_EXEC_MODE IN ('NORMAL', 'PAITEM') THEN
        BEGIN
          EXECUTE IMMEDIATE V_CASTR;
          COMMIT;
        EXCEPTION
          WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20101,
                                    '计算项目计算失败: [' || V_CASTR || ']',
                                    TRUE);
        END;
      END IF;

    END LOOP;


  EXECUTE IMMEDIATE ' SELECT COUNT(EMPID) FROM T_PA_INS_RESULT ' INTO V_EMP_COUNT ;

  V_OUTPUT_STR := V_EMP_COUNT || '   人保险计算成功完成! 用时 ' ||
                  TRUNC((SYSDATE - V_TIME) * 24 * 60 * 60 + 0.005, 2) || ' 秒';

  COMMIT;

END;
/*
-- Create table
create table PA_INSURANCE_HISTORY
(
  PA_MONTH          VARCHAR2(10) not null,
  EMPID             VARCHAR2(20) not null,
  PA_FORMULAR_MONTH VARCHAR2(6),
  PA_BASIS_MONTH    VARCHAR2(6)
);

-- Add comments to the columns 
comment on column PA_INSURANCE_HISTORY.PA_FORMULAR_MONTH
  is '公式月';
comment on column PA_INSURANCE_HISTORY.PA_BASIS_MONTH
  is '工资基础月';
-- Create/Recreate primary, unique and foreign key constraints 
alter table PA_INSURANCE_HISTORY
  add constraint PK_PA_INSURANCE_HISTORY primary key (PA_MONTH, EMPID);

*/
/

prompt
prompt Creating procedure PR_INSURANCE_PARAM_LIST
prompt ==========================================
prompt
CREATE OR REPLACE PROCEDURE PR_INSURANCE_PARAM_LIST(V_PARAM_NO IN VARCHAR2) AUTHID CURRENT_USER IS
  --V_DISTINCT_FIELD  VARCHAR2(50);
  V_STR             VARCHAR2(5000);
  V_FIELD_NAME1     VARCHAR2(50);
  V_FIELD_EN_NAME1  VARCHAR2(50);
  V_FIELD_NAME2     VARCHAR2(50);
  V_FIELD_EN_NAME2  VARCHAR2(50);
  V_FIELD_TABLE1    VARCHAR2(50);
  V_FIELD_TABLE2    VARCHAR2(50);
  V_FIELD1          VARCHAR2(50);
  V_FIELD2          VARCHAR2(50);
  R_COUNT           NUMBER;
  I                 INTEGER;
BEGIN
  DBMS_OUTPUT.ENABLE(5000000);
  BEGIN
    -- 取得输入项目的区“分项目字段”
    SELECT DISTINCT_FIELD_1ST, DISTINCT_FIELD_2ND
      INTO V_FIELD1, V_FIELD2
      FROM PA_INS_PARAM_ITEM
     WHERE PARAM_NO = V_PARAM_NO;

    IF V_FIELD1 = 'EMPID' THEN
      V_FIELD2 := 'CHINESENAME';
    END IF;

    -- 取得第一个区分项目对应的表名和字段
    SELECT DISTINCT_FIELD, TABLE_NAME
      INTO V_FIELD_NAME1, V_FIELD_TABLE1
      FROM PA_DISTINCT_LIST
     WHERE DISTINCT_FIELD = V_FIELD1;

    --英文字段、韩文字段判断  第一个区分项目
    IF V_FIELD_NAME1 = 'EMPID' OR V_FIELD_NAME1 = 'CPNY_NAME' THEN
      V_FIELD_EN_NAME1  := V_FIELD_NAME1;
    ELSIF V_FIELD_NAME1 = 'DATE_STARTED' OR V_FIELD_NAME1 = 'DATE_LEFT' OR
          V_FIELD_NAME1 = 'END_PROBATION_DATE' THEN
      V_FIELD_EN_NAME1  := 'to_char(' || V_FIELD_NAME1 ||
                           ',''yyyy-mm-dd'')';
    ELSIF V_FIELD_NAME1 = 'CHINESENAME' THEN
      V_FIELD_EN_NAME1  := 'PINYINNAME';
    ELSIF V_FIELD_NAME1 = 'DEPARTMENT' THEN
      V_FIELD_EN_NAME1  := 'DEPT_EN_NAME';
    ELSIF V_FIELD_NAME1 = 'POST_GROUP_NAME' THEN
      V_FIELD_EN_NAME1  := 'POST_GROUP_EN_NAME';
    ELSIF V_FIELD_NAME1 = 'POST_GRADE_LEVEL_NAME' THEN
      V_FIELD_EN_NAME1  := 'POST_GRADE_LEVEL_EN_NAME';
    ELSE
      V_FIELD_EN_NAME1  := V_FIELD_NAME1 || '_EN_NAME';
    END IF;

    -- 取得第二个区分项目对应的表名和字段
    SELECT DISTINCT_FIELD, TABLE_NAME
      INTO V_FIELD_NAME2, V_FIELD_TABLE2
      FROM PA_DISTINCT_LIST
     WHERE DISTINCT_FIELD = V_FIELD2;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_FIELD_NAME2 := NULL;
  END;

  --英文字段、韩文字段判断  第二个区分项目
  IF V_FIELD_NAME2 = 'EMPID' OR V_FIELD_NAME2 = 'CPNY_NAME' THEN
    V_FIELD_EN_NAME2  := V_FIELD_NAME2;
  ELSIF V_FIELD_NAME2 = 'DATE_STARTED' OR V_FIELD_NAME2 = 'DATE_LEFT' OR
        V_FIELD_NAME2 = 'END_PROBATION_DATE' THEN
    V_FIELD_EN_NAME2  := 'to_char(' || V_FIELD_NAME2 || ',''yyyy-mm-dd'')';
  ELSIF V_FIELD_NAME2 = 'CHINESENAME' THEN
    V_FIELD_EN_NAME2  := 'PINYINNAME';
  ELSIF V_FIELD_NAME2 = 'DEPARTMENT' THEN
    V_FIELD_EN_NAME2  := 'DEPT_EN_NAME';
  ELSIF V_FIELD_NAME2 = 'POST_GROUP_NAME' THEN
    V_FIELD_EN_NAME2  := 'POST_GROUP_EN_NAME';
  ELSIF V_FIELD_NAME2 = 'POST_GRADE_LEVEL_NAME' THEN
    V_FIELD_EN_NAME2  := 'POST_GRADE_LEVEL_EN_NAME';
  ELSE
    V_FIELD_EN_NAME2  := V_FIELD_NAME2 || '_EN_NAME';
  END IF;

  --DBMS_OUTPUT.PUT_LINE(V_FIELD_EN_NAME2);

  -- 如果没有第二个区分项目
  IF V_FIELD_NAME2 IS NULL THEN
    IF V_FIELD_NAME1 IN ('(CONST)', '(CONST)') THEN
      V_STR := 'DELETE PA_INS_PARAM_DATA_TEMP ';
    ELSE                                                  
      V_STR := 'INSERT INTO PA_INS_PARAM_DATA_TEMP (FIELD1_VALUE,FIELD1_EN_VALUE,FIELD1_KOR_VALUE,FIELD2_VALUE,FIELD2_EN_VALUE,FIELD2_KOR_VALUE) SELECT  DISTINCT ' ||
               V_FIELD_NAME1 || ' AS FIELD1,' || V_FIELD_EN_NAME1 ||
               ' AS FIELD1_EN,' ||
               '''''' || ' AS FIELD2,' || '''''' || ' AS FIELD2_EN,' ||
               '''''' || ' AS FIELD2_KOR' || ' FROM ' || V_FIELD_TABLE1 ||
               ' WHERE ' || V_FIELD_NAME1 || ' NOT IN' ||
               '(SELECT FIELD1_VALUE FROM PA_INSURANCE_PARAM_DATA WHERE FIELD1_VALUE IS NOT NULL AND  PARAM_NO = ' ||
               V_PARAM_NO || ')';
    END IF;
    -- 如果第一个区分项目为工号
  ELSIF V_FIELD1 = 'EMPID' THEN
    V_STR := 'INSERT INTO  PA_INS_PARAM_DATA_TEMP (FIELD1_VALUE,FIELD1_EN_VALUE,FIELD1_KOR_VALUE,FIELD2_VALUE,FIELD2_EN_VALUE,FIELD2_KOR_VALUE) SELECT  DISTINCT ' ||
             V_FIELD_NAME1 || ' AS FIELD1,' || V_FIELD_EN_NAME1 ||
             ' AS FIELD1_EN,' || 
             V_FIELD_NAME2 || ' AS FIELD2,' || V_FIELD_EN_NAME2 ||
             ' AS FIELD2_EN,' || 
             ' FROM ' || V_FIELD_TABLE1 || ' WHERE ' || V_FIELD_NAME1 ||
             ' NOT IN' ||
             '(SELECT FIELD1_VALUE FROM PA_INSURANCE_PARAM_DATA WHERE PARAM_NO = ' ||
             V_PARAM_NO || ')';
  ELSE
    V_STR := 'INSERT INTO  PA_INS_PARAM_DATA_TEMP (FIELD1_VALUE,FIELD1_EN_VALUE,FIELD1_KOR_VALUE,FIELD2_VALUE,FIELD2_EN_VALUE,FIELD2_KOR_VALUE) SELECT  DISTINCT ' ||
             V_FIELD_NAME1 || ' AS FIELD1,' || V_FIELD_EN_NAME1 ||
             ' AS FIELD1_EN,' || 
             V_FIELD_NAME2 || ' AS FIELD2,' || V_FIELD_EN_NAME2 ||
             ' AS FIELD2_EN,' || 
             ' FROM ' || V_FIELD_TABLE1 || ' WHERE ' || V_FIELD_NAME1 || '||' ||
             V_FIELD_NAME2 || ' NOT IN ' ||
             '(SELECT FIELD1_VALUE||FIELD2_VALUE FROM PA_INSURANCE_PARAM_DATA WHERE PARAM_NO = ' ||
             V_PARAM_NO || ')';
  END IF;

  SELECT COUNT(*)
    INTO R_COUNT
    FROM USER_TAB_COLUMNS
   WHERE TABLE_NAME = 'PA_INS_PARAM_DATA_TEMP';

  IF R_COUNT > 0 THEN
    EXECUTE IMMEDIATE 'DELETE  PA_INS_PARAM_DATA_TEMP';
  END IF;

  /*
  I := 0;
  WHILE I * 150 <= LENGTH(V_STR) LOOP
    DBMS_OUTPUT.PUT_LINE(SUBSTR(V_STR, I * 150, 150));
    I := I + 1;
  END LOOP;
  */
  
  EXECUTE IMMEDIATE V_STR;
  
END PR_INSURANCE_PARAM_LIST;
/

prompt
prompt Creating procedure PR_INSURANCE_PARAM_INITIAL
prompt =============================================
prompt
CREATE OR REPLACE PROCEDURE PR_INSURANCE_PARAM_INITIAL(V_PAMONTH VARCHAR2) IS
  -- 取得上个月的输入项目列表
  CURSOR CUS_PRM IS
    SELECT *
      FROM PA_INS_PARAM_ITEM
     WHERE PA_MONTH = PRIOR_PAMONTH(V_PAMONTH);

  V_OLD_PARAM_NO       NUMBER;
  V_PARAM_NAME         VARCHAR2(100);
  V_NEW_PARAM_NO       NUMBER;
  V_PARAM_TYPE_CODE    VARCHAR2(50);
  V_DISTINCT_FIELD     VARCHAR2(50);
  V_RETURN_STR         VARCHAR2(5000);
BEGIN

  DELETE PA_INS_PARAM_DATA
   WHERE PARAM_NO IN
         (SELECT PARAM_NO FROM PA_INS_PARAM_ITEM WHERE PA_MONTH = V_PAMONTH);

  DELETE PA_INS_PARAM_ITEM WHERE PA_MONTH = V_PAMONTH;

  -- 循环上月的所有输入项目
  FOR ROW_PAITEM IN CUS_PRM LOOP
    V_PARAM_NAME         := ROW_PAITEM.PARAM_NAME;
    V_OLD_PARAM_NO       := ROW_PAITEM.PARAM_NO;
    V_PARAM_TYPE_CODE    := ROW_PAITEM.PARAM_TYPE_CODE;
    V_DISTINCT_FIELD     := ROW_PAITEM.DISTINCT_FIELD_1ST;

    -- 复制上月的输入项目为本月的输入项目
    INSERT INTO PA_INS_PARAM_ITEM
      (PARAM_NO,
       PARAM_NAME,
       DISTINCT_FIELD_1ST,
       DISTINCT_FIELD_2ND,
       PA_MONTH,
       DATATYPE,
       DESCRIPTION,
       PARAM_TYPE_CODE,
       ORDER_NO,
       DEFAULT_VAL,
       PARAM_EN_NAME,
       PARAM_ID)
      SELECT PA_INS_PARAM_ITEM_SEQ.NEXTVAL,
             PARAM_NAME,
             DISTINCT_FIELD_1ST,
             DISTINCT_FIELD_2ND,
             V_PAMONTH,
             DATATYPE,
             DESCRIPTION,
             PARAM_TYPE_CODE,
             ORDER_NO,
             DEFAULT_VAL,
             PARAM_EN_NAME,
             PARAM_ID
        FROM PA_INS_PARAM_ITEM
       WHERE PARAM_NO = V_OLD_PARAM_NO;

    CASE
    -- 如果第一个区分项目为“工号”

      WHEN V_DISTINCT_FIELD = 'EMPID' THEN
        -- 取得新输入项目号
        SELECT PA_INS_PARAM_ITEM_SEQ.CURRVAL INTO V_NEW_PARAM_NO FROM DUAL;

        -- 复制上月输入项目值的值到本月
        IF V_DISTINCT_FIELD IN ('(CONST)', '(CONST)') THEN
          INSERT INTO PA_INS_PARAM_DATA
            (PARAM_DATA_NO,
             PARAM_NO,
             FIELD1_VALUE,
             FIELD2_VALUE,
             RETURN_VALUE,
             FIELD1_EN_VALUE,
             FIELD2_EN_VALUE)
            SELECT PA_INS_PARAM_DATA_SEQ.NEXTVAL,
                   V_NEW_PARAM_NO,
                   FIELD1_VALUE,
                   FIELD2_VALUE,
                   RETURN_VALUE,
                   FIELD1_EN_VALUE,
                   FIELD2_EN_VALUE
              FROM PA_INS_PARAM_DATA
             WHERE PARAM_NO = V_OLD_PARAM_NO;
        ELSIF V_PARAM_TYPE_CODE = 'ALL' -- 参数类型：复制并补缺
         THEN
          BEGIN
            --- COPY DATA FROM PRIOR MONTH
            INSERT INTO PA_INS_PARAM_DATA
              (PARAM_DATA_NO,
               PARAM_NO,
               FIELD1_VALUE,
               FIELD2_VALUE,
               RETURN_VALUE,
               FIELD1_EN_VALUE,
               FIELD2_EN_VALUE)
              SELECT PA_INS_PARAM_DATA_SEQ.NEXTVAL,
                     V_NEW_PARAM_NO,
                     FIELD1_VALUE,
                     FIELD2_VALUE,
                     RETURN_VALUE,
                     FIELD1_EN_VALUE,
                     FIELD2_EN_VALUE
                FROM PA_INS_PARAM_DATA
               WHERE PARAM_NO = V_OLD_PARAM_NO
                 AND FIELD1_VALUE IN
                     (SELECT EMPID FROM HR_EMP_PA_INFO WHERE CALC_FLAG = 'Y')
                 AND NOT (RETURN_VALUE IS NULL OR LENGTH(RETURN_VALUE) = 0 OR
                      RETURN_VALUE = 'NULL');

            --  INSERT LOSED DATA INTO PA_INSURANCE_PARAM_DATA THE DEFAULT VALUE SET AS 0
            PR_INSURANCE_PARAM_LIST(V_NEW_PARAM_NO);

            INSERT INTO PA_INS_PARAM_DATA
              (PARAM_DATA_NO,
               PARAM_NO,
               FIELD1_VALUE,
               FIELD2_VALUE,
               RETURN_VALUE,
               FIELD1_EN_VALUE,
               FIELD2_EN_VALUE)
              SELECT PA_INS_PARAM_DATA_SEQ.NEXTVAL,
                     V_NEW_PARAM_NO,
                     FIELD1_VALUE,
                     FIELD2_VALUE,
                     0,
                     FIELD1_EN_VALUE,
                     FIELD2_EN_VALUE
                FROM PA_INS_PARAM_DATA_TEMP;
          END;
        ELSIF V_PARAM_TYPE_CODE = 'CLONE' -- 参数类型：原样复制
         THEN
          INSERT INTO PA_INS_PARAM_DATA
            (PARAM_DATA_NO,
             PARAM_NO,
             FIELD1_VALUE,
             FIELD2_VALUE,
             RETURN_VALUE,
             FIELD1_EN_VALUE,
             FIELD2_EN_VALUE)
            SELECT PA_INS_PARAM_DATA_SEQ.NEXTVAL,
                   V_NEW_PARAM_NO,
                   FIELD1_VALUE,
                   FIELD2_VALUE,
                   RETURN_VALUE,
                   FIELD1_EN_VALUE,
                   FIELD2_EN_VALUE
              FROM PA_INS_PARAM_DATA
             WHERE PARAM_NO = V_OLD_PARAM_NO
               AND FIELD1_VALUE IN
                   (SELECT EMPID FROM HR_EMP_PA_INFO WHERE CALC_FLAG = 'Y')
               AND NOT (RETURN_VALUE IS NULL OR LENGTH(RETURN_VALUE) = 0 OR
                    RETURN_VALUE = 'NULL');
        ELSIF V_PARAM_TYPE_CODE = 'ALL_ZERO' -- 参数类型：清零并补缺
         THEN
          BEGIN
            PR_INSURANCE_PARAM_LIST(V_NEW_PARAM_NO);

            INSERT INTO PA_INS_PARAM_DATA
              (PARAM_DATA_NO,
               PARAM_NO,
               FIELD1_VALUE,
               FIELD2_VALUE,
               RETURN_VALUE,
               FIELD1_EN_VALUE,
               FIELD2_EN_VALUE)
              SELECT PA_INS_PARAM_DATA_SEQ.NEXTVAL,
                     V_NEW_PARAM_NO,
                     FIELD1_VALUE,
                     FIELD2_VALUE,
                     0,
                     FIELD1_EN_VALUE,
                     FIELD2_EN_VALUE
                FROM PA_INS_PARAM_DATA_TEMP
               WHERE FIELD1_VALUE IN
                     (SELECT EMPID FROM HR_EMP_PA_INFO WHERE CALC_FLAG = 'Y');
          END;
        ELSE
          -- 参数类型：清除全部数据
          V_RETURN_STR := V_RETURN_STR || V_PARAM_NAME || '   ' ||
                          V_PARAM_TYPE_CODE || CHR(13);
        END IF;

    -- 如果第一个区分项目不为“工号”
      ELSE
        SELECT PA_INS_PARAM_ITEM_SEQ.CURRVAL INTO V_NEW_PARAM_NO FROM DUAL;

        -- 复制上月输入项目值的值到本月
        IF V_DISTINCT_FIELD IN ('(CONST)', '(CONST)') THEN
          INSERT INTO PA_INS_PARAM_DATA
            (PARAM_DATA_NO,
             PARAM_NO,
             FIELD1_VALUE,
             FIELD2_VALUE,
             RETURN_VALUE,
             FIELD1_EN_VALUE,
             FIELD2_EN_VALUE)
            SELECT PA_INS_PARAM_DATA_SEQ.NEXTVAL,
                   V_NEW_PARAM_NO,
                   FIELD1_VALUE,
                   FIELD2_VALUE,
                   RETURN_VALUE,
                   FIELD1_EN_VALUE,
                   FIELD2_EN_VALUE
              FROM PA_INS_PARAM_DATA
             WHERE PARAM_NO = V_OLD_PARAM_NO;
        ELSIF V_PARAM_TYPE_CODE = 'ALL' -- 参数类型：复制并补缺
         THEN
          BEGIN
            --- COPY DATA FROM PRIOR MONTH
            INSERT INTO PA_INS_PARAM_DATA
              (PARAM_DATA_NO,
               PARAM_NO,
               FIELD1_VALUE,
               FIELD2_VALUE,
               RETURN_VALUE,
               FIELD1_EN_VALUE,
               FIELD2_EN_VALUE)
              SELECT PA_INS_PARAM_DATA_SEQ.NEXTVAL,
                     V_NEW_PARAM_NO,
                     FIELD1_VALUE,
                     FIELD2_VALUE,
                     RETURN_VALUE,
                     FIELD1_EN_VALUE,
                     FIELD2_EN_VALUE
                FROM PA_INS_PARAM_DATA
               WHERE PARAM_NO = V_OLD_PARAM_NO
                 AND NOT (RETURN_VALUE IS NULL OR LENGTH(RETURN_VALUE) = 0 OR
                      RETURN_VALUE = 'NULL');

            --  INSERT LOSED DATA INTO PA_INS_PARAM_DATA THE DEFAULT VALUE SET AS 0
            PR_INSURANCE_PARAM_LIST(V_NEW_PARAM_NO);

            INSERT INTO PA_INS_PARAM_DATA
              (PARAM_DATA_NO,
               PARAM_NO,
               FIELD1_VALUE,
               FIELD2_VALUE,
               RETURN_VALUE,
               FIELD1_EN_VALUE,
               FIELD2_EN_VALUE)
              SELECT PA_INS_PARAM_DATA_SEQ.NEXTVAL,
                     V_NEW_PARAM_NO,
                     FIELD1_VALUE,
                     FIELD2_VALUE,
                     0,
                     FIELD1_EN_VALUE,
                     FIELD2_EN_VALUE
                FROM PA_INS_PARAM_DATA_TEMP;
          END;
        ELSIF V_PARAM_TYPE_CODE = 'CLONE' -- 参数类型：原样复制
         THEN
          INSERT INTO PA_INS_PARAM_DATA
            (PARAM_DATA_NO,
             PARAM_NO,
             FIELD1_VALUE,
             FIELD2_VALUE,
             RETURN_VALUE,
             FIELD1_EN_VALUE,
             FIELD2_EN_VALUE)
            SELECT PA_INS_PARAM_DATA_SEQ.NEXTVAL,
                   V_NEW_PARAM_NO,
                   FIELD1_VALUE,
                   FIELD2_VALUE,
                   RETURN_VALUE,
                   FIELD1_EN_VALUE,
                   FIELD2_EN_VALUE
              FROM PA_INS_PARAM_DATA
             WHERE PARAM_NO = V_OLD_PARAM_NO
               AND NOT (RETURN_VALUE IS NULL OR LENGTH(RETURN_VALUE) = 0 OR
                    RETURN_VALUE = 'NULL');
        ELSIF V_PARAM_TYPE_CODE = 'ALL_ZERO' -- 参数类型：清零并补缺
         THEN
          BEGIN
            PR_INSURANCE_PARAM_LIST(V_NEW_PARAM_NO);
            -------------------------------------------------------------------
            INSERT INTO PA_INS_PARAM_DATA
              (PARAM_DATA_NO,
               PARAM_NO,
               FIELD1_VALUE,
               FIELD2_VALUE,
               RETURN_VALUE,
               FIELD1_EN_VALUE,
               FIELD2_EN_VALUE)
              SELECT PA_INS_PARAM_DATA_SEQ.NEXTVAL,
                     V_NEW_PARAM_NO,
                     FIELD1_VALUE,
                     FIELD2_VALUE,
                     0,
                     FIELD1_EN_VALUE,
                     FIELD2_EN_VALUE
                FROM PA_INS_PARAM_DATA_TEMP;
          END;
        ELSE
          -- 参数类型：清除全部数据
          V_RETURN_STR := V_RETURN_STR || V_PARAM_NAME || '   ' ||
                          V_PARAM_TYPE_CODE || CHR(13);
        END IF;
    END CASE;

  END LOOP;
END;
/

prompt
prompt Creating procedure PR_MAKESCHEDULE
prompt ==================================
prompt
CREATE OR REPLACE PROCEDURE pr_makeschedule (
   v_empid      VARCHAR2,
   v_curdate    DATE,
   v_shift_no   INT
)
IS
BEGIN
   INSERT INTO ar_schedule
               (pk_no, empid, ar_item_no, from_time, to_time, shift_no,
                ar_date_str, ar_month_str, lock_yn)
      SELECT ar_schedule_seq.NEXTVAL, v_empid, ar_item_no,
             mergetime (begin_day_offset + v_curdate, from_time),
             mergetime (end_day_offset + v_curdate, to_time), shift_no,
             TO_CHAR (v_curdate, 'YYYY/MM/DD'), get_armonth (v_curdate), 'N'
        FROM ar_shift020
       WHERE v_shift_no = shift_no;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      RAISE;
END;
/

prompt
prompt Creating procedure PR_MERGE_TABLE
prompt =================================
prompt
CREATE OR REPLACE PROCEDURE pr_merge_table (
   v_tb1      VARCHAR2,
   v_tb2      VARCHAR2,
   v_tb_bak   VARCHAR2
)
AUTHID CURRENT_USER
IS
/*
V_TB1 表1
V_TB2 表2
V_TB_BAK 备份表名称 TB1将备份到指定的表名。
此存储过程功能：  将TB1 TB2合并为TB1 并把原TB1备份到V_TB_BAK指定的表名中。
    */
   i                  INTEGER;
   v_str              VARCHAR (10000);
   pos                INTEGER;
   v_seq              VARCHAR2 (9);
   v_test_str         VARCHAR2 (50);
   v_bak_table_name   VARCHAR2 (50);

   CURSOR cus_t
   IS
      SELECT ',T.' || column_name AS column_name
        FROM user_tab_columns
       WHERE table_name = v_tb2
         AND column_name NOT IN (SELECT column_name
                                   FROM user_tab_columns
                                  WHERE table_name = v_tb1);

   CURSOR cus_p
   IS
      SELECT ',P.' || column_name AS column_name
        FROM user_tab_columns
       WHERE table_name = v_tb1
         AND column_name NOT IN (SELECT column_name
                                   FROM user_tab_columns
                                  WHERE table_name = v_tb2);

   CURSOR cus_c
   IS
      SELECT   column_name || ',' AS column_name
          FROM (SELECT   MIN (column_id) AS column_id, column_name
                    FROM user_tab_columns
                   WHERE table_name IN (v_tb2, v_tb1)
                GROUP BY column_name)
      ORDER BY column_id;
BEGIN
   DBMS_OUTPUT.ENABLE (50000);
   v_str := v_str || 'CREATE TABLE T_TEMP_TABLE AS SELECT ';

   --DBMS_OUTPUT.put_line('FIRST:'||V_STR);
   FOR row_c IN cus_c
   LOOP
      v_str := v_str || row_c.column_name || CHR (13);
   END LOOP;

   v_str := SUBSTR (v_str, 1, LENGTH (v_str) - 2);              --去掉尾部逗号
   v_str := v_str || CHR (13) || ' FROM (SELECT p.*';

   FOR row_t IN cus_t
   LOOP
      v_str := v_str || row_t.column_name || CHR (13);
   END LOOP;

   v_str :=
         v_str
      || 'FROM '
      || v_tb1
      || ' P,'
      || v_tb2
      || '  T WHERE T.ROWID(+)=P.ROWID)'
      || CHR (13)
      || 'UNION'
      || CHR (13);
   v_str := v_str || 'SELECT ';

   FOR row_c IN cus_c
   LOOP
      v_str := v_str || row_c.column_name || CHR (13);
   END LOOP;

   v_str := SUBSTR (v_str, 1, LENGTH (v_str) - 2);              --去掉尾部逗号
   v_str := v_str || CHR (13) || ' FROM (SELECT T.*';

   FOR row_p IN cus_p
   LOOP
      v_str := v_str || row_p.column_name || CHR (13);
   END LOOP;

   v_str :=
         v_str
      || ' FROM  '
      || v_tb1
      || ' P,'
      || v_tb2
      || ' T WHERE T.ROWID=P.ROWID(+))'
      || CHR (13);
   pos := 0;

   WHILE INSTR (v_str, CHR (13), pos + 1) > 0
   LOOP
      DBMS_OUTPUT.put_line (SUBSTR (v_str,
                                    pos + 1,
                                    INSTR (v_str, CHR (13), pos + 1) - pos - 1
                                   )
                           );
      pos := INSTR (v_str, CHR (13), pos + 1);
   END LOOP;

   /*
   I:=0;
         WHILE I*150 <= LENGTH(V_STR)
             LOOP
             DBMS_OUTPUT.PUT_line( substr(v_str,i*150,150));

               i:=i+1;
             END LOOP;
   */
   BEGIN
      SELECT table_name
        INTO v_test_str
        FROM user_tables
       WHERE table_name = 'T_TEMP_TABLE';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_test_str := NULL;
   END;

   IF v_test_str IS NOT NULL
   THEN
      EXECUTE IMMEDIATE 'DROP TABLE T_TEMP_TABLE';        -- 删除T_TEMP_TABLE
   END IF;

   EXECUTE IMMEDIATE v_str;               -- 将TB1和TB2合并后存入 T_TEMP_TABLE

   BEGIN
      SELECT tname
        INTO v_bak_table_name
        FROM tab
       WHERE tname = v_tb_bak;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_bak_table_name := NULL;
   END;

   IF v_bak_table_name IS NULL
   THEN
      v_bak_table_name := v_tb_bak;
   ELSE
      --  V_BAK_TABLE_NAME := V_TB_BAK || '_'||to_NchAr(SYSDATE,'MMDDHHMI');
        -- V_SEQ := TO_CHAR(MERGE_TABLE_SEQ.NEXTVAL);
      v_bak_table_name := v_tb_bak || '_' || TO_CHAR (SYSDATE, 'yyyymmdd');
   END IF;

   --EXECUTE IMMEDIATE 'CREATE TABLE '|| V_BAK_TABLE_NAME || ' AS SELECT * FROM '|| V_TB1; -- 将TB1备份到TB_BAK指定的标中
   EXECUTE IMMEDIATE 'DROP TABLE ' || v_tb1;                        -- 删掉TB1

   EXECUTE IMMEDIATE    'CREATE TABLE '
                     || v_tb1
                     || ' AS SELECT * FROM T_TEMP_TABLE';

   -- 将T_TEMP_TABLE复制到TB1
   EXECUTE IMMEDIATE 'DROP TABLE T_TEMP_TABLE';            -- 删除T_TEMP_TABLE
END;
/

prompt
prompt Creating procedure PR_PACAL
prompt ===========================
prompt
CREATE OR REPLACE PROCEDURE PR_PACAL(V_PA_MONTH          VARCHAR2,
                                     V_PA_FORMULAR_MONTH VARCHAR2,
                                     V_CPNY_ID           VARCHAR2,
                                     V_EXEC_MODE         VARCHAR2,
                                     V_OUTPUT_TYPE       VARCHAR2,
                                     V_OUTPUT_STR        OUT VARCHAR2)
  AUTHID CURRENT_USER IS
  /* V_EXEC_MODE :
                 NORMAL 正常计算
                 TEST  只生成脚本不执行计算
                 ONLY_CREATE_TABLE 只建表 不计算
     V_OUTPUT_TYPE     输出模式
                 ALL 全部输出
                 PARAM   参数部分 CUIJINHUA ZHU ZHENGQI
                 PAITEM 工资项目部分
                 NONE   不输出
  
  */
  I                      INTEGER;
  V_STR                  VARCHAR2(20000); -- 创建T_PA_RESULT表的SQL
  V_BSTR                 VARCHAR2(20000); -- 更新T_PA_RESULT表的基础项目值的SQL
  V_CASTR                VARCHAR2(20000); -- 更新T_PA_RESULT表的工资项目值的SQL
  V_PSTR                 VARCHAR2(20000); -- 更新T_PA_RESULT表的输入项目值的SQL 
  V_CONDITION_COUNT      INT; -- 工资项目空条件数量
  V_FOMULAR_COUNT        INT; -- 工资项目公式数量
  R_COUNT                INT;
  V_PARAM_ID             VARCHAR2(50);
  V_TIME                 DATE := SYSDATE;
  V_EMP_COUNT            VARCHAR2(6);
  V_ITEM_ID              VARCHAR2(50);
  V_BASIC_ITEM_ID        VARCHAR2(50);
  V_FORMULAR_NOCONDITION VARCHAR2(2000);

  -- 人事表游标
  CURSOR CUS_HR IS
    SELECT FIELD_NAME,
           DISTINCT_FIELD,
           TABLE_NAME,
           FIELD_EN_NAME,
           FIELD_KOR_NAME
      FROM PA_DISTINCT_LIST
     WHERE TABLE_NAME = 'PA_HR_V'
       AND CPNY_ID = V_CPNY_ID
       AND ACTIVITY = 1
     ORDER BY ID;

  --考勤游标
  CURSOR CUS_AR IS
    SELECT ITEM_NAME             AS FIELD_NAME,
       ITEM_ID                    AS DISTINCT_FIELD,
       'AR_HISTORY_'||V_PA_MONTH AS TABLE_NAME,
       ITEM_NAME                 AS FIELD_EN_NAME
      FROM AR_STA_ITEM
     WHERE CPNY_ID = V_CPNY_ID
       AND ACTIVITY = 1
     ORDER BY CALCU_ORDER;

  -- 输入项目游标
  CURSOR CUS_PARAM IS
    SELECT PARAM_NO,
           PARAM_NAME,
           DISTINCT_FIELD_1ST,
           DISTINCT_FIELD_2ND,
           DATATYPE,
           DEFAULT_VAL,
           PARAM_EN_NAME,
           PARAM_ID
      FROM PA_PARAM_ITEM
     WHERE ACTIVITY = 1
       AND CPNY_ID = V_CPNY_ID;

  -- 工资项目游标
  CURSOR CUS_ITEM IS
    SELECT ITEM_NO,
           DATATYPE,
           ITEM_NAME,
           PRECISION,
           CARRY_BIT,
           ITEM_EN_NAME,
           ITEM_ID
      FROM PA_ITEM
     WHERE ACTIVITY = 1
       AND CPNY_ID = V_CPNY_ID
     ORDER BY CALCU_ORDER;

  -- 工资公式游标
  CURSOR CUS_FORMULAR(PA_ITEM_NO_IN NUMBER) IS
    SELECT *
      FROM PA_FORMULAR
     WHERE ITEM_NO = PA_ITEM_NO_IN
     AND   ACTIVITY = 1
     ORDER BY ORDERNO DESC;

BEGIN

  SELECT COUNT(*)
    INTO R_COUNT
    FROM PA_PARAM_ITEM
   WHERE ACTIVITY = 1
   AND   CPNY_ID  = V_CPNY_ID;

  -- 验证当月是否存在输入项目
  IF R_COUNT = 0 THEN
    BEGIN
      V_OUTPUT_STR := '错误: 当月工资无输入项目，请初始化输入项目.';
      RETURN;
    END;
  END IF;

  UPDATE PA_PARAM_DATA
     SET RETURN_VALUE = NULL
   WHERE LOWER(RETURN_VALUE) = 'null';

  COMMIT;
  
  -- 设置输出缓冲区大小
  -- SET OUTPUT ON SIZE 50000;
  DBMS_OUTPUT.ENABLE(5000000);
  -- EXECUTE IMMEDIATE 'SET LINESIZE = 5000';

  -- 删除已存在数据
  BEGIN
    EXECUTE IMMEDIATE 'DELETE PA_HISTORY WHERE PA_MONTH = ''' ||
                      V_PA_MONTH || '''';
  
  EXCEPTION
    WHEN OTHERS THEN
      V_OUTPUT_STR := '错误: 删除重复数据有误.';
      RETURN;
    
      COMMIT;
  END;

  -- 建表字符串，表的列由参数名称 || 工资项目名称组成。工资项目名称按计算顺序排列。
  V_STR := 'CREATE TABLE T_PA_RESULT AS SELECT  ''' || V_PA_MONTH ||
           ''' AS PA_MONTH,''' || V_PA_FORMULAR_MONTH ||
           ''' AS PA_FORMULAR_MONTH,';
 
  -- 验证计算项目名称是否重复
  BEGIN
    SELECT ITEM_ID
      INTO V_ITEM_ID
      FROM (SELECT ITEM_ID, COUNT(ITEM_ID) AS NUM
              FROM PA_ITEM
              WHERE ACTIVITY = 1
             GROUP BY ITEM_ID) P
     WHERE P.NUM > 1
       AND ROWNUM = 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_ITEM_ID := NULL;
  END;

  -- 如果计算项目名称重复提示错误
  IF V_ITEM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误: 工资项目ID"' || V_ITEM_ID || '"出现重复,请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 验证输入项目名称是否重复
  BEGIN
    SELECT PARAM_ID
      INTO V_ITEM_ID
      FROM (SELECT PARAM_ID, COUNT(PARAM_ID) AS NUM
              FROM PA_PARAM_ITEM
             WHERE ACTIVITY = 1
             GROUP BY PARAM_ID)
     WHERE NUM > 1
     AND ROWNUM = 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_ITEM_ID := NULL;
  END;

  -- 如果输入项目名称重复提示错误
  IF V_ITEM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误: 输入项目ID"' || V_ITEM_ID || '"出现重复,请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 验证输入项目名称是否与接口表的字段名称重复
  BEGIN
    SELECT DISTINCT_FIELD
      INTO V_ITEM_ID
      FROM PA_DISTINCT_LIST
     WHERE DISTINCT_FIELD IN
           (SELECT PARAM_ID FROM PA_PARAM_ITEM WHERE ACTIVITY = 1 AND CPNY_ID = V_CPNY_ID);
           
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_ITEM_ID := NULL;
  END;

  -- 如果输入项目名称与接口表的字段名称重复提示错误
  IF V_ITEM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误：工资输入项目ID“' || V_ITEM_ID || '”和人事项目ID“' ||
                      V_ITEM_ID || '”出现重复。请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 验证计算项目名称是否与接口表的字段名称重复
  BEGIN
    SELECT DISTINCT_FIELD
      INTO V_ITEM_ID
      FROM PA_DISTINCT_LIST
     WHERE DISTINCT_FIELD IN (SELECT ITEM_ID FROM PA_ITEM)
     AND ROWNUM = 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_ITEM_ID := NULL;
  END;

  -- 如果计算项目名称与接口表的字段名称重复提示错误
  IF V_ITEM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误： 工资计算项目ID“' || V_ITEM_ID || '”和人事项目ID“' ||
                      V_ITEM_ID || '”出现重复。请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 验证计算项目名称是否与输入项目名称重复
  BEGIN
    SELECT PA_PARAM_ITEM.PARAM_ID
      INTO V_PARAM_ID
      FROM PA_PARAM_ITEM, PA_ITEM
     WHERE PA_PARAM_ITEM.PARAM_ID = PA_ITEM.ITEM_ID
       AND ROWNUM = 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_PARAM_ID := NULL;
  END;

  -- 如果计算项目名称与输入项目名称重复提示错误
  IF V_PARAM_ID IS NOT NULL THEN
    BEGIN
      V_OUTPUT_STR := '错误： 输入ID“' || V_PARAM_ID || '”和工资项目ID“' ||
                      V_PARAM_ID || '”出现重复。请修改后再次计算！';
      RETURN;
    END;
  END IF;

  -- 拼接人事数据列
  FOR HR_ROW IN CUS_HR LOOP
    -- 拼接创建表T_PA_RESULT的SQL字符串
    V_STR := V_STR || HR_ROW.TABLE_NAME || '.' || HR_ROW.DISTINCT_FIELD ||
             ' AS ' || HR_ROW.DISTINCT_FIELD || ',' || CHR(13);
  END LOOP;

  -- 拼接考勤数据列
  FOR AR_ROW IN CUS_AR LOOP
    V_STR := V_STR || AR_ROW.TABLE_NAME || '.' || AR_ROW.DISTINCT_FIELD ||
             ' AS ' ||  AR_ROW.DISTINCT_FIELD || ',' || CHR(13);
  END LOOP;

  -- 拼接工资输入项目列
  FOR PAR_ROW IN CUS_PARAM LOOP
    BEGIN
      V_STR := V_STR || (CASE UPPER(SUBSTR(PAR_ROW.DATATYPE, 1, 4))
                 WHEN 'NUMB' THEN
                  '0'
                 WHEN 'VARC' THEN
                  '''                                                                                                                                                                                                            '''
                 WHEN 'CHAR' THEN
                  ''''
                 WHEN 'DATE' THEN
                  'SYSDATE'
               --此处留50空格确定此列长宽度
               END) || ' AS "' || PAR_ROW.PARAM_ID || '" ,' || CHR(13);
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20101,'工资参数数据类型错误: [' || PAR_ROW.PARAM_ID || ']');
    END;
  END LOOP;

  -- 拼接工资项目列
  FOR PA_ROW IN CUS_ITEM LOOP
    V_STR := V_STR || (CASE PA_ROW.DATATYPE
               WHEN 'NUMBER(14,4)' THEN
                '0'
               WHEN 'NUMBER' THEN
                '0'
               WHEN 'VARCHAR2' THEN
                '''                                                  '''
               WHEN 'VARCHAR2(50)' THEN
                '''                                                  '''
               WHEN 'VARCHAR2(200)' THEN
                '''                                                                                                                                                      '''
             --此处留50空格确定此列长宽度
               ELSE
                ''' '''
             END) || ' AS "' || PA_ROW.ITEM_ID || '" ,' || CHR(13);
  END LOOP;

  --去 掉最后逗号
  V_STR              := SUBSTR(V_STR, 0, LENGTH(V_STR) - 2); 

  ---创建 计算结果表 并插入人事及数据
  V_STR := V_STR ||
           ' FROM PA_HR_V, AR_HISTORY_'||V_PA_MONTH||
           ' WHERE PA_HR_V.EMPID = AR_HISTORY_'||V_PA_MONTH||'.EMPID(+)' ||
           ' AND AR_HISTORY_'||V_PA_MONTH||'.AR_MONTH = ''' || V_PA_MONTH || '''';

  DBMS_OUTPUT.PUT_LINE('THIS IS CREATE TABLE STRING');

  -- 日志输出
  IF V_OUTPUT_TYPE IN ('ALL') THEN
    I := 0;
    WHILE I * 150 <= LENGTH(V_STR) LOOP
      DBMS_OUTPUT.PUT_LINE(SUBSTR(V_STR, I * 150, 150));
      I := I + 1;
    END LOOP;
  END IF;

  -- 楠岃瘉T_PA_RESULT鏄惁瀛樺湪锛屽鏋滃瓨鍦ㄥ垹闄よ琛
  SELECT COUNT(*)
    INTO R_COUNT
    FROM USER_TAB_COLUMNS
   WHERE TABLE_NAME = 'T_PA_RESULT';

  IF R_COUNT > 0 THEN
    BEGIN
      EXECUTE IMMEDIATE 'DROP TABLE T_PA_RESULT';
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20101, '删除 T_PA_RESULT 失败', TRUE);
    END;
  END IF;

  -- 执行创建表T_PA_RESULT的SQL
  IF V_EXEC_MODE IN ('NORMAL', 'ONLY_CREATE_TABLE', 'PARAM', 'PAITEM') THEN
    BEGIN
      dbms_output.PUT_LINE(V_STR);
      EXECUTE IMMEDIATE V_STR;
      DBMS_OUTPUT.put_line(V_STR);
      EXECUTE IMMEDIATE 'ALTER TABLE T_PA_RESULT ADD CONSTRAINT PK_T_PA_RESULT PRIMARY KEY (EMPID) ';
    
      COMMIT;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20101, '创建计算结果表失败: [' ||SUBSTR(V_STR, LENGTH(V_STR) - 300, LENGTH(V_STR)) || ']',
                                TRUE);
    END;
  END IF;
  ----------------------------------------------------------  输入项目计算 ---------------------------------------------------------
  DBMS_OUTPUT.PUT_LINE(CHR(13) || ' ----------    THIS IS THE CALCULATE PARAM DATA STRING ----------');

  FOR PAR_VAL IN CUS_PARAM LOOP
    -- 创建更新T_PA_RESULT输入项目的SQL
    V_PSTR := 'UPDATE T_PA_RESULT SET "' || PAR_VAL.PARAM_ID || '" =NVL(' ||
              ' (SELECT p.return_value FROM  PA_PARAM_DATA  P WHERE '||
                ' P.PA_MONTH = '||V_PA_MONTH ||'AND P.ACTIVITY = 1 AND '||
                  PAR_VAL.DISTINCT_FIELD_1ST || '  = P.FIELD1_VALUE ' || CASE
                WHEN TRIM(PAR_VAL.DISTINCT_FIELD_2ND) IS NOT NULL THEN
                 ' AND ' || PAR_VAL.DISTINCT_FIELD_2ND || ' = P.FIELD2_VALUE '
              END || ' AND P.PARAM_NO=' || TO_CHAR(PAR_VAL.PARAM_NO) ||
              ' ),''' || PAR_VAL.DEFAULT_VAL || ''')';
  
    IF V_OUTPUT_TYPE IN ('ALL', 'PARAM') THEN
      I := 0;
      WHILE I * 150 <= LENGTH(V_PSTR) LOOP
        DBMS_OUTPUT.PUT_LINE(SUBSTR(V_PSTR, I * 150, 150));
        I := I + 1;
      END LOOP;
    END IF;
  
    -- 更新T_PA_RESULT输入项目的SQL
    IF V_EXEC_MODE IN ('NORMAL', 'PARAM') THEN
      BEGIN
        EXECUTE IMMEDIATE V_PSTR;
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20101,'参数计算失败: [' || V_PSTR || ']');
      END;
    END IF;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('----------CALCULATE PARAM DATA STRING FINISHED-----------');

  ---------------------------------------------------   工资项目计算   -------------------------------------------------------------
  DBMS_OUTPUT.PUT_LINE(CHR(13) || '  -------------------  THIS IS THE CALCU PA ITEMS STRING ---------');
  BEGIN
  
    FOR PAITEM_VAL IN CUS_ITEM LOOP
    
      -- 字符类型工资项目
      IF PAITEM_VAL.DATATYPE = 'VARCHAR2' THEN
        V_CASTR := CHR(13) || 'UPDATE T_PA_RESULT set "' ||
                   PAITEM_VAL.ITEM_ID || '" = ';
        -- 数值类型工资项目
      ELSE
        V_CASTR := CHR(13) || 'UPDATE T_PA_RESULT set "' ||
                   PAITEM_VAL.ITEM_ID || '" = TRUNC((' ||
                   PAITEM_VAL.CARRY_BIT || ' + ';
      END IF;
    
      /************************************************计算所有工资项目**************************************
         鍏紡浜旂鎯呭喌锛
         1.    无公式                  0
         2.    鍗曚竴鍏紡鏃犳潯浠?         鐩存帴鍒楀叕寮
         3.    单一公式有条件          CASE WHEN 条件 THEN 公式 ELSE 0 END
         4.    多公式均有条件          CASE 循环(WHEN 条件 THEN 公式) ELSE 0 END
         5.    多公式，其中一条无条件  CASE 循环(WHEN 条件 THEN 公式) ELSE 公式 END
      *******************************************************************************************************/
    
      SELECT COUNT(*)
        INTO V_FOMULAR_COUNT
        FROM PA_FORMULAR
       WHERE ITEM_NO = PAITEM_VAL.ITEM_NO
         AND ACTIVITY = 1;
    
      -- 取得当前工资项目的空公式条件数量
      SELECT COUNT(*)
        INTO V_CONDITION_COUNT
        FROM PA_FORMULAR
       WHERE ITEM_NO = PAITEM_VAL.ITEM_NO
         AND ACTIVITY = 1
         AND (REPLACE(REPLACE(RTRIM(LTRIM(CONDITION)), CHR(9), ''), ' ', '') = '' OR
             CONDITION IS NULL);
    
      IF V_FOMULAR_COUNT = 0 THEN
        V_CASTR := V_CASTR || '0';
      ELSIF V_FOMULAR_COUNT = 1 AND V_CONDITION_COUNT = 1 THEN
        SELECT V_CASTR || FORMULAR
          INTO V_CASTR
          FROM PA_FORMULAR
         WHERE ITEM_NO = PAITEM_VAL.ITEM_NO
           AND ACTIVITY = 1;
      ELSE
        V_CASTR := V_CASTR || ' CASE ';
      
        FOR FORMULAR_ROW IN CUS_FORMULAR(PAITEM_VAL.ITEM_NO) LOOP
          IF REPLACE(REPLACE(RTRIM(LTRIM(FORMULAR_ROW.CONDITION)),
                             CHR(9),
                             ''),
                     ' ',
                     '') = '' OR FORMULAR_ROW.CONDITION IS NULL THEN
            V_FORMULAR_NOCONDITION := FORMULAR_ROW.FORMULAR;
          ELSE
            V_CASTR := V_CASTR || ' WHEN ' || FORMULAR_ROW.CONDITION ||
                       ' THEN ' || FORMULAR_ROW.FORMULAR;
          END IF;
        END LOOP;
      
        IF V_CONDITION_COUNT = 0 THEN
          -- 字符类型工资项目
          IF PAITEM_VAL.DATATYPE = 'VARCHAR2' THEN
            V_CASTR := V_CASTR || ' ELSE '''' END ';
          ELSE
            V_CASTR := V_CASTR || ' ELSE 0 END ';
          END IF;
        ELSE
          V_CASTR := V_CASTR || ' ELSE ' || V_FORMULAR_NOCONDITION ||
                     ' END ';
        END IF;
      END IF;
    
      -- 数值类型工资项目
      IF PAITEM_VAL.DATATYPE <> 'VARCHAR2' THEN
        V_CASTR := V_CASTR || '),' || PAITEM_VAL.PRECISION || ')';
      END IF;
    
      IF V_OUTPUT_TYPE IN ('ALL', 'PAITEM') THEN
        I := 0;
        WHILE I * 150 <= LENGTH(V_CASTR) LOOP
          DBMS_OUTPUT.PUT_LINE(SUBSTR(V_CASTR, I * 150, 150));
          I := I + 1;
        END LOOP;
      END IF;
    
      IF V_EXEC_MODE IN ('NORMAL', 'PAITEM') THEN
        BEGIN
          EXECUTE IMMEDIATE V_CASTR;
          DBMS_OUTPUT.put_line(V_CASTR);
          COMMIT;
        EXCEPTION
          WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20101, '计算项目计算失败: [' || V_CASTR || ']',TRUE);
        END;
      END IF;
    
    END LOOP;
  
  END;

  COMMIT;

  PA_CONFIRM(V_OUTPUT_STR);

  EXECUTE IMMEDIATE ' SELECT COUNT(EMPID) FROM T_PA_RESULT '
    INTO V_EMP_COUNT;

  V_OUTPUT_STR := V_EMP_COUNT || '   人工资计算成功完成. 用时 ' ||
                  TRUNC((SYSDATE - V_TIME) * 24 * 60 * 60 + 0.005, 2) || ' 秒';

END;
/

prompt
prompt Creating procedure PURCHASE_PROCESS_AFFIRM_AGREE
prompt ================================================
prompt
create or replace procedure PURCHASE_PROCESS_AFFIRM_AGREE(
       processKey in varchar2,
       processInstanceId in varchar2)
       -- Author  : fei.liu  @sipingsoft
       -- Created : 2013/12/23 10:33:52
       -- Purpose : 更改审核标志
is
       V_TABLE_NAME       VARCHAR2(100);
       SQLSTAT            VARCHAR2(500);
       VAR_AFFIRM_FLAG    VARCHAR2(10);
begin
       VAR_AFFIRM_FLAG := 'affirm1';
       SELECT A.TABLE_NAME INTO V_TABLE_NAME FROM PROCESS_ESS_RELATION A 
              WHERE A.PROCESS_KEY = processKey;
       SQLSTAT := 'UPDATE ' ||V_TABLE_NAME|| ' SET AFFIRM_FLAG = ''' ||VAR_AFFIRM_FLAG|| ''' WHERE PROCESSID =' || processInstanceId;
       execute immediate SQLSTAT;
       COMMIT;
       EXCEPTION
         WHEN NO_DATA_FOUND THEN
           ROLLBACK;
         WHEN TOO_MANY_ROWS THEN
           ROLLBACK;
end PURCHASE_PROCESS_AFFIRM_AGREE;
/

prompt
prompt Creating procedure PURCHASE_PROCESS_AFFIRM_VETO
prompt ===============================================
prompt
create or replace procedure PURCHASE_PROCESS_AFFIRM_VETO(
       processKey in varchar2,
       processInstanceId in varchar2)
       -- Author  : fei.liu  @sipingsoft
       -- Created : 2013/12/23 10:33:52
       -- Purpose : 更改审核标志
is
       V_TABLE_NAME       VARCHAR2(100);
       SQLSTAT            VARCHAR2(500);
       VAR_AFFIRM_FLAG   VARCHAR2(10);
begin
       VAR_AFFIRM_FLAG := 'affirm2';
       SELECT A.TABLE_NAME INTO V_TABLE_NAME FROM PROCESS_ESS_RELATION A 
              WHERE A.PROCESS_KEY = processKey;
       SQLSTAT := 'UPDATE ' ||V_TABLE_NAME|| ' SET AFFIRM_FLAG = ''' ||VAR_AFFIRM_FLAG|| ''' WHERE PROCESSID =' || processInstanceId;
       execute immediate SQLSTAT;
       COMMIT;
       EXCEPTION
         WHEN NO_DATA_FOUND THEN
           ROLLBACK;
         WHEN TOO_MANY_ROWS THEN
           ROLLBACK;
end PURCHASE_PROCESS_AFFIRM_VETO;
/

prompt
prompt Creating procedure SALES_PROCESS_AFFIRM_AGREE
prompt =============================================
prompt
create or replace procedure SALES_PROCESS_AFFIRM_AGREE(
       processKey in varchar2,
       processInstanceId in varchar2)
       -- Author  : fei.liu  @sipingsoft
       -- Created : 2013/12/27 10:33:52
       -- Purpose : 更改审核标志
is
       V_TABLE_NAME       VARCHAR2(100);
       SQLSTAT            VARCHAR2(500);
       VAR_AFFIRM_FLAG   VARCHAR2(10);
begin
       VAR_AFFIRM_FLAG := 'affirm1';
       SELECT A.TABLE_NAME INTO V_TABLE_NAME FROM PROCESS_ESS_RELATION A 
              WHERE A.PROCESS_KEY = processKey;
       SQLSTAT := 'UPDATE ' ||V_TABLE_NAME|| ' SET AFFIRM_FLAG = ''' ||VAR_AFFIRM_FLAG|| ''' WHERE PROCESSID =' || processInstanceId;
       execute immediate SQLSTAT;
       COMMIT;
       EXCEPTION
         WHEN NO_DATA_FOUND THEN
           ROLLBACK;
         WHEN TOO_MANY_ROWS THEN
           ROLLBACK;
end SALES_PROCESS_AFFIRM_AGREE;
/

prompt
prompt Creating procedure SALES_PROCESS_AFFIRM_VETO
prompt ============================================
prompt
create or replace procedure SALES_PROCESS_AFFIRM_VETO(
       processKey in varchar2,
       processInstanceId in varchar2)
       -- Author  : fei.liu  @sipingsoft
       -- Created : 2013/12/27 10:33:52
       -- Purpose : 更改审核标志
is
       V_TABLE_NAME       VARCHAR2(100);
       SQLSTAT            VARCHAR2(500);
       VAR_AFFIRM_FLAG   VARCHAR2(10);
begin
       VAR_AFFIRM_FLAG := 'affirm2';
       SELECT A.TABLE_NAME INTO V_TABLE_NAME FROM PROCESS_ESS_RELATION A 
              WHERE A.PROCESS_KEY = processKey;
       SQLSTAT := 'UPDATE ' ||V_TABLE_NAME|| ' SET AFFIRM_FLAG = ''' ||VAR_AFFIRM_FLAG|| ''' WHERE PROCESSID =' || processInstanceId;
       execute immediate SQLSTAT;
       COMMIT;
       EXCEPTION
         WHEN NO_DATA_FOUND THEN
           ROLLBACK;
         WHEN TOO_MANY_ROWS THEN
           ROLLBACK;
end SALES_PROCESS_AFFIRM_VETO;
/

prompt
prompt Creating procedure SALES_REPORT_CAL
prompt ===================================
prompt
CREATE OR REPLACE PROCEDURE SALES_REPORT_CAL(IN_AR_MONTH_STR IN VARCHAR2, --考勤月 ('YYYYMM')
                                         INOUT_EMPID     IN OUT VARCHAR2 --考勤员工号, 为 'ALL' 时计算所有人
                                         ) AUTHID CURRENT_USER IS
  
  VAR_STIME              DATE := SYSDATE; --计算开始时间
  VAR_COUNT              INT := 0; --计数器
  VAR_CREATE_STR         VARCHAR2(10000); --建表表达式
  VAR_UPDATE_STR         VARCHAR2(10000); --计算表达式
  VAR_SDATE              DATE; --考勤月开始时间
  VAR_EDATE              DATE; --考勤月结束时间

/*报表中使用的数据*/
  VAR_SALES_SUMMERY                    NUMBER(20,4);--销售额
  VAR_NEW_CUSTOMER                     NUMBER(5);--新增客户
  VAR_ACTION_COUNT                     NUMBER(5);--活动量
  VAR_SALARY_NETWORK                   NUMBER(20,4);--网销额
  VAR_SALARY_NETWORK_PERSENTAGE        NUMBER(4,4);--网销提成比例

  -- 所有人员的游标
  CURSOR CUS_EMP IS
  SELECT HE.EMPID EMPID, HE.CHINESENAME EMPNAME, HD.DEPTNAME DEPTNAME
  FROM HR_EMPLOYEE HE, HR_DEPARTMENT HD
  WHERE HE.STATUS_CODE != 'EmpStatus3'
  AND HE.STATUS_CODE != 'EmpStatus5'
  AND HE.DEPTID = HD.DEPTID(+);
  /*AND (EXISTS (
        SELECT HR_DEPARTMENT.DEPTNO FROM HR_DEPARTMENT
        WHERE HR_DEPARTMENT.DEPTID = HD.DEPTID
        START WITH HR_DEPARTMENT.DEPTID = '00180000'
        CONNECT BY PRIOR HR_DEPARTMENT.DEPTID = HR_DEPARTMENT.PARENT_DEPT_ID))*/
  --AND HE.POST_GROUP_CODE = 'PG0050';
  /******************************************************************************
     NAME:       SALES_REPORT_CAL
     PURPOSE:    月销售业绩汇总

     REVISIONS:
     Ver        Date        Author           Description
     ---------  ----------  ---------------  ------------------------------------
     1.0        01/29/2013   chenmx       1. Created this procedure.
  ******************************************************************************/
BEGIN
  DBMS_OUTPUT.ENABLE(5000000);
  /*取得考勤月开始、结束时间*/
  VAR_SDATE := AR_GET_STARTDATE(IN_AR_MONTH_STR);
  VAR_EDATE := AR_GET_ENDDATE(IN_AR_MONTH_STR);

  /*如果不是计算所有人的月考勤数据*/
  IF UPPER(INOUT_EMPID) <> 'ALL' THEN
    /*正对非全部人员的计算*/
  DBMS_OUTPUT.PUT_LINE('NOT EVERYONE, PLEASE WAIT OUR NEW VERSION');
  END IF;

  VAR_COUNT := 0;
  /*定义建表"SALES_REPORT_HISTORY"语句*/
  VAR_CREATE_STR := 'CREATE TABLE SALES_REPORT_HISTORY_'||IN_AR_MONTH_STR || ' 
  (EMP_ID VARCHAR2(20),CHINESENAME VARCHAR2(50),DEPTNAME VARCHAR2(100),MONTH VARCHAR2(20),
  SALES_SUMMERY NUMBER(20,4),NEW_CUSTOMER NUMBER(5),ACTION_COUNT  NUMBER(5),SALARY_NETWORK NUMBER(20,4))';
  
  /*验证表SALES_REPORT_HISTORY_xxx是否存在*/
  SELECT COUNT(*)
    INTO VAR_COUNT
    FROM USER_TABLES
   WHERE TABLE_NAME = 'SALES_REPORT_HISTORY_'||IN_AR_MONTH_STR;
   
  /*删除已经存在的SALES_REPORT_HISTORY_xxx表*/
  IF VAR_COUNT > 0 THEN
    EXECUTE IMMEDIATE 'DROP TABLE SALES_REPORT_HISTORY_'||IN_AR_MONTH_STR;
  END IF;

  VAR_COUNT := 0;
  DBMS_OUTPUT.PUT_LINE('创建表 SALES_REPORT_HISTORY_xxx 语句 ');
  WHILE VAR_COUNT * 120 <= LENGTH(VAR_CREATE_STR) LOOP
    DBMS_OUTPUT.PUT_LINE(SUBSTR(VAR_CREATE_STR, VAR_COUNT * 120 + 1, 120));
    VAR_COUNT := VAR_COUNT + 1;
  END LOOP;

  /*创建SALES_REPORT_HISTORY_xxx*/
  EXECUTE IMMEDIATE VAR_CREATE_STR;
  COMMIT;
  
  /*获得网销提成比例*/
  SELECT SSN.PERCENTAGE INTO VAR_SALARY_NETWORK_PERSENTAGE FROM SALES_SALARY_NETWORK SSN;
  
  /*插入SALES_REPORT_HISTORY_xxx数据*/
  FOR ROW_EMP IN CUS_EMP LOOP

  /*计算销售额*/
  SELECT NVL(SUM(T.MONEY_TOTAL),0) INTO VAR_SALES_SUMMERY FROM ORD_ORDER_INFO T
  WHERE T.EMPID = ROW_EMP.EMPID
  AND   T.ACTIVITY = 1
  AND   T.ORD_TYPE_CODE = 'OrderType001'
  AND   T.STATUS_CODE = 'OrderState06'
  AND   T.VERIFIED_DATE <= VAR_EDATE+1
  AND   T.VERIFIED_DATE >= VAR_SDATE;

  /*计算客户量*/
  SELECT COUNT(0) INTO VAR_NEW_CUSTOMER FROM CUST_BASIC_INFO T
  WHERE  T.OWNER_ID = ROW_EMP.EMPID
  AND    T.ACTIVITY = 1
  AND   T.CREATED_DATE <= VAR_EDATE
  AND   T.CREATED_DATE >= VAR_SDATE;

  /*计算活动量*/
  SELECT COUNT(0) INTO VAR_ACTION_COUNT FROM CUST_ACTION_INFO T
  WHERE  T.EMP_ID = ROW_EMP.EMPID
  AND    T.ACTIVITY = 1
  AND    T.CUST_ACTION_STATE_CODE = 'CustActionState005'
  AND   T.CUST_ACTION_TIME <= VAR_EDATE
  AND   T.CUST_ACTION_TIME >= VAR_SDATE;
  
  /*计算下级销售总额*/
  VAR_COUNT := 0;
  VAR_SALARY_NETWORK := 0;
  SELECT COUNT(0) INTO VAR_COUNT FROM HR_DEPARTMENT T
  WHERE T.MANAGER_EMP_ID = ROW_EMP.EMPID;
  IF VAR_COUNT = 0 THEN
    VAR_SALARY_NETWORK :=0;
  ELSE
    SELECT NVL(SUM(ORI.MONEY_TOTAL),0) INTO VAR_SALARY_NETWORK FROM ORD_ORDER_INFO ORI
    WHERE ORI.ACTIVITY = 1
    AND   ORI.ORD_TYPE_CODE = 'OrderType001'
    AND   ORI.STATUS_CODE = 'OrderState06'
    AND   ORI.VERIFIED_DATE <= VAR_EDATE+1
    AND   ORI.VERIFIED_DATE >=VAR_SDATE
    AND   ORI.EMPID IN
    (SELECT HE.EMPID FROM HR_EMPLOYEE HE,HR_DEPARTMENT HRDA
     WHERE HRDA.MANAGER_EMP_ID = ROW_EMP.EMPID
     AND   HE.DEPTID = HRDA.DEPTID
     AND   HE.EMPID <> ROW_EMP.EMPID
     UNION ALL
     SELECT HRDC.MANAGER_EMP_ID FROM HR_DEPARTMENT HRDB,HR_DEPARTMENT HRDC
     WHERE HRDB.MANAGER_EMP_ID = ROW_EMP.EMPID
     AND   HRDC.PARENT_DEPT_ID = HRDB.DEPTID
    );
  END IF;

  VAR_UPDATE_STR := 'INSERT INTO SALES_REPORT_HISTORY_'||IN_AR_MONTH_STR||' 
  (EMP_ID,MONTH,SALES_SUMMERY,NEW_CUSTOMER,ACTION_COUNT,SALARY_NETWORK,CHINESENAME,DEPTNAME)
   VALUES('''
  ||ROW_EMP.EMPID||''','''||IN_AR_MONTH_STR||''','||VAR_SALES_SUMMERY||','||VAR_NEW_CUSTOMER||','||VAR_ACTION_COUNT||','||VAR_SALARY_NETWORK*NVL(VAR_SALARY_NETWORK_PERSENTAGE,0)||','''
  ||ROW_EMP.EMPNAME||''','''||ROW_EMP.DEPTNAME
  ||''')';

  VAR_COUNT := 0;
  WHILE VAR_COUNT * 120 <= LENGTH(VAR_UPDATE_STR) LOOP
    DBMS_OUTPUT.PUT_LINE(SUBSTR(VAR_UPDATE_STR, VAR_COUNT * 120 + 1, 120));
    VAR_COUNT := VAR_COUNT + 1;
  END LOOP;

  /*执行插入*/
  EXECUTE IMMEDIATE VAR_UPDATE_STR;
  END LOOP;
  /*提交结果*/
  COMMIT;
  
  INOUT_EMPID := '员工销售汇总计算完毕, 用时 ' ||
               TRUNC((SYSDATE - VAR_STIME) * 24 * 60 * 60 + 0.005, 2) ||
               ' 秒. ';
END;
/

prompt
prompt Creating procedure MESSAGE_ADD_EMP
prompt ==================================
prompt
create or replace procedure MESSAGE_ADD_EMP(
  VAR_MESSAGE_NO VARCHAR2,
  VAR_CREATED_BY VARCHAR2,
  VAR_CPNY_ID VARCHAR2,
  VAR_DEPTID VARCHAR2,
  VAR_SCREEN_GRANT_ID VARCHAR2,
  VAR_MESSAGE_TYPE VARCHAR2
) is
  VAR_EMPID VARCHAR2(20);
begin
  --如果是部门消息，则将该部门下所有员工均插入消息关联
  IF VAR_MESSAGE_TYPE = 'DEPTID' THEN
    DECLARE
      --循环为该部门的员工
      CURSOR EMP_ID_LIST
      IS
         SELECT HE.EMPID FROM HR_EMPLOYEE HE
         WHERE HE.DEPTID = VAR_DEPTID
         AND HE.ACTIVITY = 1
         AND HE.CPNY_ID = VAR_CPNY_ID;
    BEGIN
      OPEN EMP_ID_LIST;
        LOOP
          FETCH EMP_ID_LIST INTO VAR_EMPID;
          EXIT WHEN EMP_ID_LIST%NOTFOUND;
          --将消息插入明细表
          INSERT INTO SY_MESSAGE_EMP_DETAIL(
            MESSAGE_NO,
            EMPID,
            IS_READ,
            CREATE_DATE,
            CREATED_BY,
            ACTIVITY,
            CPNY_ID,
            DEPTID,
            SCREEN_GRANT_ID,
            MESSAGE_TYPE
          )VALUES(
            VAR_MESSAGE_NO,
            VAR_EMPID,
            2,
            SYSDATE,
            VAR_CREATED_BY,
            1,
            VAR_CPNY_ID,
            VAR_DEPTID,
            VAR_SCREEN_GRANT_ID,
            VAR_MESSAGE_TYPE
          );
          
        END LOOP;
      CLOSE EMP_ID_LIST;
    END;
  ELSIF VAR_MESSAGE_TYPE = 'SCREEN_GRANT_ID' THEN
    DECLARE
      --循环有此权限的员工ID
      CURSOR EMP_ID_LIST
      IS
        SELECT S.ADMINID 
          FROM SY_ADMIN S
          WHERE S.ACTIVITY = 1
          AND S.CPNY_ID = VAR_CPNY_ID
          AND VAR_SCREEN_GRANT_ID IN(
            SELECT COLUMN_VALUE AS SID 
            FROM TABLE(SPLIT(S.SCREEN_GRANT_ID,','))
          );
         
    BEGIN
      OPEN EMP_ID_LIST;
        LOOP
          FETCH EMP_ID_LIST INTO VAR_EMPID;
          EXIT WHEN EMP_ID_LIST%NOTFOUND;
          --将消息插入明细表
          INSERT INTO SY_MESSAGE_EMP_DETAIL(
            MESSAGE_NO,
            EMPID,
            IS_READ,
            CREATE_DATE,
            CREATED_BY,
            ACTIVITY,
            CPNY_ID,
            DEPTID,
            SCREEN_GRANT_ID,
            MESSAGE_TYPE
          )VALUES(
            VAR_MESSAGE_NO,
            VAR_EMPID,
            2,
            SYSDATE,
            VAR_CREATED_BY,
            1,
            VAR_CPNY_ID,
            VAR_DEPTID,
            VAR_SCREEN_GRANT_ID,
            VAR_MESSAGE_TYPE
          );
          
        END LOOP;
      CLOSE EMP_ID_LIST;
    END;
    
  END IF; 
end MESSAGE_ADD_EMP;
/

spool off
exit;