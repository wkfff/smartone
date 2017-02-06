---------------------------------------------
-- Export file for user WINE               --
-- Created by Yayoi on 2014/1/27, 11:32:10 --
---------------------------------------------

set define off
spool function.log

prompt
prompt Creating function AR_ABSENCE_DAYS
prompt =================================
prompt
CREATE OR REPLACE FUNCTION Ar_Absence_Days (in_empid VARCHAR2)
   RETURN NUMBER
IS
   var_days   NUMBER;
BEGIN
   BEGIN
   SELECT NVL(SUM (T.QUANTITY), 0) / 8
	 INTO var_days
	 FROM AR_DETAIL T,
	 	  HR_EMPLOYEE E 
	WHERE T.AR_ITEM_NO IN (20,14,8) 
	  AND T.EMPID = in_empid
	  AND T.EMPID = E.EMPID
    AND TO_DATE(T.AR_DATE_STR,'YYYY-MM-DD') >= TO_DATE('2009-06-16','YYYY-MM-DD')
    AND TO_DATE(T.AR_DATE_STR,'YYYY-MM-DD') <= TO_DATE('2009-12-15','YYYY-MM-DD')
	--  AND T.AR_MONTH_STR >= '200806' AND T.AR_MONTH_STR < '200901'
     ;
	   --AND TO_DATE(T.AR_DATE_STR,'YYYY-MM-DD') < ADD_MONTHS(E.DATE_STARTED,12); 
    /* 实习转正的人 . 从转正日期起 往前的缺勤天数*/ 
    
 /* SELECT NVL(SUM (T.QUANTITY), 0) / 8
   INTO var_days
	 FROM ar_detail T,
	 	  HR_EMPLOYEE E,
      hr_experience_inside HEI
	WHERE T.AR_ITEM_NO IN (8, 14, 20) 
	  AND T.EMPID = in_empid
	  AND T.EMPID = E.EMPID
    AND E.EMPID = HEI.EMPID
	  AND TO_DATE(T.AR_DATE_STR, 'YYYY-MM-DD') < HEI.START_DATE  AND HEI.trans_code = 'TurnType0020';
*/
   EXCEPTION
      WHEN OTHERS
      THEN
         var_days := 0;
   END;
   var_days := nvl(trunc(var_days),0);
   RETURN var_days;
END Ar_Absence_Days;
/

prompt
prompt Creating function AR_ABSENCE_DAYS1
prompt ==================================
prompt
CREATE OR REPLACE FUNCTION Ar_Absence_Days1(in_empid VARCHAR2)
   RETURN NUMBER
 IS
  VAR_DAYS      NUMBER;
  VAR_CYEAR     VARCHAR2(10);
  VAR_CMONTH    VARCHAR2(10);
  VAR_STARTDATE DATE;
  VAR_ENDDATE   DATE;
  VAR_DATELEFT_DAYS      NUMBER  := 0;
BEGIN
  BEGIN
    VAR_CYEAR  := TO_CHAR(SYSDATE, 'YYYY');
    VAR_CMONTH := TO_CHAR(SYSDATE, 'MM');
     --0906月 zengaiwu 奖金/成果奖计算时间段  上半年 12-16 至 6-15 , 下半年 6-16 至 12-15
    -- 8 ,14 , 20 旷工, 缺勤 , 无薪假   10年１月　加上病假 16
    IF VAR_CMONTH <= 6 THEN
      VAR_STARTDATE := TO_DATE(VAR_CYEAR - 1 || '/07/01', 'YYYY/MM/DD');
      VAR_ENDDATE   := TO_DATE(VAR_CYEAR - 1 || '/12/31', 'YYYY/MM/DD');
    ELSIF VAR_CMONTH > 6 THEN
      VAR_STARTDATE := TO_DATE(VAR_CYEAR || '/01/01', 'YYYY/MM/DD');
      VAR_ENDDATE   := TO_DATE(VAR_CYEAR || '/06/30', 'YYYY/MM/DD');
    END IF;
/*  原   SELECT NVL(SUM (T.QUANTITY), 0) / 8
   INTO var_days
   FROM AR_DETAIL T,
       HR_EMPLOYEE E
  WHERE T.AR_ITEM_NO IN (20,14,8 )
    AND T.EMPID = in_empid
    AND T.EMPID = E.EMPID
    AND TO_DATE(T.AR_DATE_STR,'YYYY-MM-DD') >= TO_DATE('2009-07-01','YYYY-MM-DD')
    AND TO_DATE(T.AR_DATE_STR,'YYYY-MM-DD') <= TO_DATE('2009-12-31','YYYY-MM-DD');
*/
    SELECT NVL(SUM(T.QUANTITY), 0) / 8
      INTO VAR_DAYS
      FROM AR_DETAIL T, HR_EMPLOYEE E
     WHERE T.AR_ITEM_NO IN (20,14,8,16)
       AND T.EMPID = IN_EMPID
       AND T.EMPID = E.EMPID
       AND T.DATE_TYPE <> 2
       AND T.AR_DATE_STR BETWEEN TO_char(VAR_STARTDATE, 'YYYY/MM/DD') AND TO_char(VAR_ENDDATE, 'YYYY/MM/DD');
       --AND TO_DATE(T.AR_DATE_STR,'YYYY/MM/DD') BETWEEN VAR_STARTDATE AND VAR_ENDDATE;
       
   EXCEPTION
      WHEN OTHERS
      THEN
         var_days := 0;
   END;

   var_days := trunc(var_days);

   RETURN var_days;

END Ar_Absence_Days1;
/

prompt
prompt Creating function AR_ALL_ABSENCE_DAYS
prompt =====================================
prompt
CREATE OR REPLACE FUNCTION Ar_All_Absence_Days (in_empid VARCHAR2)
   RETURN NUMBER
IS
   var_days   NUMBER;
BEGIN
   BEGIN
     SELECT NVL(SUM (T.QUANTITY), 0) / 8
	 INTO var_days
	 FROM AR_DETAIL T,
	 	  HR_EMPLOYEE E 
	WHERE T.AR_ITEM_NO IN (8, 14, 20) 
	  AND T.EMPID = in_empid
	  AND T.EMPID = E.EMPID;
   EXCEPTION
      WHEN OTHERS
      THEN
         var_days := 0;
   END;

   var_days := trunc(var_days);
   
   RETURN var_days;
   
END Ar_All_Absence_Days;
/

prompt
prompt Creating function AR_END_DAY
prompt ============================
prompt
CREATE OR REPLACE FUNCTION Ar_End_Day (monthstr VARCHAR2)
   RETURN NUMBER
IS
   enddate   NUMBER;
BEGIN
   BEGIN
      SELECT end_date
        INTO enddate
        FROM AR_STATISTIC_DATE
       WHERE valid_date_from <= TO_DATE (monthstr || '01', 'yyyy-mm-dd')
         AND valid_date_to >= TO_DATE (monthstr || '01', 'yyyy-mm-dd');
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         enddate :=
            EXTRACT (DAY FROM   TO_DATE (   TO_CHAR (TO_NUMBER (monthstr) + 1)
                                         || '01',
                                         'yyyy-mm-dd'
                                        )
                              - 1
                    );
      WHEN OTHERS
      THEN
         -- Consider logging the error and then re-raise
         RAISE;
   END;

   RETURN enddate;
END Ar_End_Day;
/

prompt
prompt Creating function AR_END_MONTH
prompt ==============================
prompt
CREATE OR REPLACE FUNCTION ar_end_month (monthstr VARCHAR2)
   RETURN DATE
IS
   tmpvar    NUMBER;
   enddate   DATE;
BEGIN
   BEGIN
      SELECT TO_DATE (monthstr || end_date, 'yyyy-mm-dd')
        INTO enddate
        FROM ar_statistic_date
       WHERE valid_date_from <= TO_DATE (monthstr || '01', 'yyyy-mm-dd')
         AND valid_date_to >= TO_DATE (monthstr || '01', 'yyyy-mm-dd');
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         enddate :=
              TO_DATE (TO_CHAR (TO_NUMBER (monthstr) + 1) || '01',
                       'yyyy-mm-dd')
            - 1;
      WHEN OTHERS
      THEN
         -- Consider logging the error and then re-raise
         RAISE;
   END;

   RETURN enddate;
END ar_end_month;
/

prompt
prompt Creating function AR_GET_COMPENSATE_OVERTIME
prompt ============================================
prompt
CREATE OR REPLACE FUNCTION ar_get_compensate_overtime (rest_days1 NUMBER, rest_days2 NUMBER, ar_month_str VARCHAR2, empid VARCHAR2)
   RETURN NUMBER
IS
   last_rest_days    NUMBER;
   curren_rest_days  NUMBER;
BEGIN

   -- 当月补偿加班次数
   curren_rest_days := rest_days1 - rest_days2;

   --BEGIN
      -- 上月补偿加班次数
      --SELECT 补偿加班次数
      --  INTO last_rest_days
      --  FROM AR_HISTORY
    --WHERE 考勤月 = TO_CHAR(TO_DATE(ar_month_str,'YYYYMM') - 1,'YYYYMM')
    --  AND 工号   = empid;
   --EXCEPTION
   --   WHEN OTHERS
   --   THEN
   --      last_rest_days := 0;
   --END;

   --当前月补偿加班次数为正数，上月补偿加班次数为负数，返回当月和上月的补偿加班次数的和
   IF curren_rest_days > 0 AND last_rest_days < 0
   THEN
       RETURN curren_rest_days + last_rest_days;
   END IF;

   RETURN curren_rest_days;

END ar_get_compensate_overtime;
/

prompt
prompt Creating function AR_GET_CONDITION_FIELD_ID_FN
prompt ==============================================
prompt
CREATE OR REPLACE FUNCTION ar_get_condition_field_id_fn (
   in_condition_no   IN   NUMBER
)
   RETURN VARCHAR2
IS
   v_field_id   VARCHAR2 (40);
BEGIN
   BEGIN
      SELECT field_id
        INTO v_field_id
        FROM ar_condition_list
       WHERE condition_no = in_condition_no;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_field_id := 'no_data_found';
   END;

   RETURN v_field_id;
END ar_get_condition_field_id_fn;
/

prompt
prompt Creating function AR_GET_CONDITION_FIELD_NAME_FN
prompt ================================================
prompt
CREATE OR REPLACE FUNCTION ar_get_condition_field_name_fn (
   in_field_id   IN   VARCHAR2
)
   RETURN VARCHAR2
IS
   v_field_name   VARCHAR2 (40);
BEGIN
   BEGIN
      SELECT field_name
        INTO v_field_name
        FROM ar_condition_list
       WHERE field_id = in_field_id;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_field_name := 'no_data_found';
   END;

   RETURN v_field_name;
END ar_get_condition_field_name_fn;
/

prompt
prompt Creating function AR_GET_CROSSTIME
prompt ==================================
prompt
CREATE OR REPLACE FUNCTION Ar_Get_Crosstime (
    IN_FROMTIME1   DATE,
    IN_TOTIME1     DATE,
    IN_FROMTIME2   DATE,
    IN_TOTIME2     DATE
)
    RETURN NUMBER IS
    VAR_FROMTIME   DATE;
    VAR_TOTIME     DATE;
    VAR_LENGTH     NUMBER := 0;
/******************************************************************************
   NAME:       AR_GET_CROSS_HOUR
   PURPOSE:    取两个时间段的交叉时间, 结果单位为"天"

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        04/21/2006   Pennix       1. Created this function.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     AR_GET_CROSS_HOUR
      Sysdate:         04/21/2006
      Date and Time:   04/21/2006, 18:52:53, and 04/21/2006 18:52:53
      Username:        Pennix (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
    IF IN_FROMTIME1 IS NOT NULL AND IN_TOTIME1 IS NOT NULL THEN
      /*取最大的开始时间*/
        IF IN_FROMTIME1 > IN_FROMTIME2 THEN
            VAR_FROMTIME := IN_FROMTIME1;
        ELSE
            VAR_FROMTIME := IN_FROMTIME2;
        END IF;

     /*取最小的结束时间*/
        IF IN_TOTIME1 < IN_TOTIME2 THEN
            VAR_TOTIME := IN_TOTIME1;
        ELSE
            VAR_TOTIME := IN_TOTIME2;
        END IF;

     /*得到交叉集合*/
        VAR_LENGTH := VAR_TOTIME - VAR_FROMTIME;

        IF VAR_LENGTH < 0 THEN
            VAR_LENGTH := 0;
        END IF;

        RETURN VAR_LENGTH;
    ELSE
        RETURN 0;
    END IF;
END Ar_Get_Crosstime;
/

prompt
prompt Creating function GET_CPNY_ID
prompt =============================
prompt
CREATE OR REPLACE FUNCTION GET_CPNY_ID(IN_EMPID IN VARCHAR2) RETURN VARCHAR2 IS
  V_CPNY_ID VARCHAR2(50);
BEGIN
  SELECT HRD.CPNY_ID
    INTO V_CPNY_ID
    FROM HR_EMPLOYEE HRE,HR_DEPARTMENT HRD
   WHERE HRE.DEPTID = HRD.DEPTID
   AND   HRE.EMPID = IN_EMPID;

  RETURN V_CPNY_ID;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    V_CPNY_ID := '';
    RETURN V_CPNY_ID;
END GET_CPNY_ID;
/

prompt
prompt Creating function AR_GET_DATETYPE
prompt =================================
prompt
CREATE OR REPLACE FUNCTION AR_GET_DATETYPE(IN_EMPID       VARCHAR2,
                                           IN_AR_DATE_STR VARCHAR2)
  RETURN NUMBER IS
  VAR_DATETYPE          NUMBER;
  VAR_TYPENAME          VARCHAR(50);
  VAR_DATETYPE_CALENDAR NUMBER;
  VAR_TYPENAME_CALENDAR VARCHAR(50);
  COUNTEMP              NUMBER;
  /******************************************************************************
     NAME:       AR_GET_DATETYPE
     PURPOSE:    鏍规嵁鏃ユ湡涓庡憳宸ュ彿鍙栧嚭鍛樺伐璇ュぉ鐨勬棩鏈熺被鍨
  ******************************************************************************/
BEGIN
  BEGIN
    -- 取排班表中的数据类型
    SELECT AR_SHIFT010.DATE_TYPE_ID, AR_CALENDER_TYPE.TYPE_NAME
      INTO VAR_DATETYPE, VAR_TYPENAME
      FROM AR_SHIFT010, AR_SCHEDULE, AR_CALENDER_TYPE
     WHERE AR_SHIFT010.SHIFT_NO = AR_SCHEDULE.SHIFT_NO
       AND AR_SHIFT010.CPNY_ID = GET_CPNY_ID(IN_EMPID)
       AND AR_SCHEDULE.EMPID = IN_EMPID
       AND AR_SHIFT010.DATE_TYPE_ID = AR_CALENDER_TYPE.TYPE_ID
       AND AR_SCHEDULE.AR_DATE_STR =
           TO_CHAR(TO_DATE(IN_AR_DATE_STR, 'YYYY-MM-DD'), 'YYYY/MM/DD');
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      VAR_DATETYPE := NULL;
  END;

  BEGIN
    -- 取公司日历表中的数据类型
    SELECT AR_CALENDER.TYPEID, AR_CALENDER_TYPE.TYPE_NAME
      INTO VAR_DATETYPE_CALENDAR, VAR_TYPENAME_CALENDAR
      FROM AR_CALENDER, AR_CALENDER_TYPE
     WHERE DDATE = TO_DATE(IN_AR_DATE_STR, 'YYYY-MM-DD')
       AND AR_CALENDER.TYPEID = AR_CALENDER_TYPE.TYPE_ID;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      VAR_DATETYPE_CALENDAR := NULL;
  END;

  BEGIN
    -- SELECT count(*) INTO countemp FROM hr_employee h WHERE h.empid=IN_EMPID
    --  AND h.date_started > TO_DATE(IN_AR_DATE_STR,'YYYY-MM-DD');
    SELECT COUNT(*)
      INTO COUNTEMP
      FROM HR_EXPERIENCE_INSIDE H
     WHERE EMPID = IN_EMPID
       AND TRANS_CODE = 'TransCode_100'
       AND H.START_DATE > TO_DATE(IN_AR_DATE_STR, 'YYYY-MM-DD');
  END;
  --入社日期小于节假日 不应计算
  IF COUNTEMP >= 1 THEN
    VAR_DATETYPE_CALENDAR := 0;
    VAR_DATETYPE          := NULL;
  END IF;

  -- 如果为节假日更新数据类型为法定假加班
  IF VAR_DATETYPE_CALENDAR = 3 OR VAR_DATETYPE IS NULL THEN
    VAR_DATETYPE := VAR_DATETYPE_CALENDAR;
  END IF;

  IF VAR_DATETYPE IS NULL THEN
    RETURN 0;
  ELSE
    RETURN VAR_DATETYPE;
  END IF;
END AR_GET_DATETYPE;
/

prompt
prompt Creating function AR_GET_DATETYPENAME
prompt =====================================
prompt
CREATE OR REPLACE FUNCTION AR_GET_DATETYPENAME(IN_TYPE_ID VARCHAR2)
  RETURN VARCHAR2 IS

  VAR_DATE_TYPE_NAME VARCHAR2(20);
  /******************************************************************************
     NAME:       AR_GET_DATETYPE
     PURPOSE:    鏍规嵁鏃ユ湡涓庡憳宸ュ彿鍙栧嚭鍛樺伐璇ュぉ鐨勬棩鏈熺被鍨
  ******************************************************************************/
BEGIN
  BEGIN
    SELECT T.TYPE_NAME
      INTO VAR_DATE_TYPE_NAME
      FROM AR_CALENDER_TYPE T
     WHERE T.TYPE_ID = IN_TYPE_ID;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      VAR_DATE_TYPE_NAME := NULL;
  END;
  RETURN VAR_DATE_TYPE_NAME;
END AR_GET_DATETYPENAME;
/

prompt
prompt Creating function REPLACE_STRING
prompt ================================
prompt
CREATE OR REPLACE FUNCTION replace_string (v_str VARCHAR2)
   RETURN VARCHAR2
IS
   v_return   VARCHAR2 (5000);
BEGIN
   SELECT '''' || REPLACE (v_str, ',', '''' || ',' || '''') || ''''
     INTO v_return
     FROM DUAL;

   RETURN v_return;
END;
/

prompt
prompt Creating function AR_GET_DY_EMP
prompt ===============================
prompt
CREATE OR REPLACE FUNCTION ar_get_dy_emp (in_group_id VARCHAR2)
   RETURN VARCHAR2
IS
   v_where            VARCHAR2 (2000) := 'where';
   v_temp_condition   VARCHAR2 (200);
   sql_str            VARCHAR2 (2000);
   empidnot           VARCHAR2 (2000);
BEGIN
   DECLARE
      CURSOR condition_cur
      IS
         SELECT *
           FROM ar_group_conditions
          WHERE group_no = in_group_id;

      v_condition   condition_cur%ROWTYPE;
   BEGIN
      OPEN condition_cur;

      LOOP
         FETCH condition_cur
          INTO v_condition;

         EXIT WHEN condition_cur%NOTFOUND;

         IF v_condition.relation = 'in'
         THEN
            v_temp_condition :=
                  v_condition.field_name
               || ' '
               || v_condition.relation
               || '( '
               || ''
               || replace_string (v_condition.value1)
               || ''
               || ')';
         ELSE
            v_temp_condition :=
                  v_condition.field_name
               || ' '
               || v_condition.relation
               || ' '''
               || v_condition.value1
               || '''';
         END IF;

         IF v_condition.relation = 'between'
         THEN
            v_temp_condition :=
                  v_temp_condition || ' and ''' || v_condition.value2 || '''';
         END IF;

         IF v_where = 'where'
         THEN
            v_where := v_where || ' ' || v_temp_condition;
         ELSIF v_temp_condition IS NOT NULL
         THEN
            v_where := v_where || ' and ' || v_temp_condition;
         END IF;

         v_temp_condition := NULL;
      END LOOP;

      CLOSE condition_cur;
   END;

   --DBMS_OUTPUT.put_line (v_where);
   IF v_where = 'where'
   THEN
      sql_str :=
         'select empid,chinesename,FULL_DEPTNAME,deptid from ar_emp_info_v  where empid ='''' and ';
   ELSE
      sql_str :=
            'select empid,chinesename,FULL_DEPTNAME,deptid from ar_emp_info_v '
         || v_where
         || ' and ';
   END IF;

   RETURN sql_str;
END ar_get_dy_emp;
/

prompt
prompt Creating function AR_GET_ENDDATE
prompt ================================
prompt
CREATE OR REPLACE FUNCTION ar_get_enddate (in_ar_month_str VARCHAR2)
   RETURN DATE
IS
   var_endday   DATE;
/******************************************************************************
   NAME:       AR_GET_ENDDATE
   PURPOSE:    取得考勤月的最后一天

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        03/04/2006   Pennix       1. Created this function.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     AR_GET_ENDDATE
      Sysdate:         03/04/2006
      Date and Time:   03/04/2006, 17:02:50, and 03/04/2006 17:02:50
      Username:        Pennix (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   BEGIN
      SELECT TO_DATE (in_ar_month_str || TO_CHAR (end_date, '09'), 'YYYYMMDD')
        INTO var_endday
        FROM ar_statistic_date
       WHERE TO_DATE (in_ar_month_str || TO_CHAR (end_date, '09'), 'YYYYMMDD')
                BETWEEN valid_date_from
                    AND valid_date_to
         AND ROWNUM = 1;
   EXCEPTION
      WHEN OTHERS
      THEN
         var_endday :=
             ADD_MONTHS (TO_DATE (in_ar_month_str || '01', 'YYYYMMDD'), 1)
             - 1;
   END;

   RETURN var_endday;
END ar_get_enddate;
/

prompt
prompt Creating function GET_TYPEID
prompt ============================
prompt
CREATE OR REPLACE FUNCTION GET_typeID(IN_EMPID VARCHAR2)
  RETURN VARCHAR2 IS
  VAR_typeID VARCHAR2(30) :=1;
BEGIN
  BEGIN
      SELECT HR_EMPLOYEE.Emp_Type_Code
        INTO VAR_typeID
        FROM HR_EMPLOYEE
       WHERE HR_EMPLOYEE.EMPID = IN_EMPID        ;
   EXCEPTION
      WHEN OTHERS
      THEN
         VAR_typeID := IN_EMPID;
   END;

   RETURN VAR_typeID;

END GET_typeID;
/

prompt
prompt Creating function AR_GET_ENDDATE_EMPID
prompt ======================================
prompt
CREATE OR REPLACE FUNCTION ar_get_enddate_empid(in_ar_month_str VARCHAR2,
                                                in_empid        VARCHAR2)
  RETURN DATE IS
  var_endday DATE;
  i_typeid VARCHAR2(20)  :=get_typeid(in_empid);
  

  /******************************************************************************
     NAME:       AR_GET_ENDDATE
     PURPOSE:    取得考勤月的最后一天

     REVISIONS:
     Ver        Date        Author           Description
     ---------  ----------  ---------------  ------------------------------------
     1.0        03/04/2006   Pennix       1. Created this function.

     NOTES:

     Automatically available Auto Replace Keywords:
        Object Name:     AR_GET_ENDDATE
        Sysdate:         03/04/2006
        Date and Time:   03/04/2006, 17:02:50, and 03/04/2006 17:02:50
        Username:        Pennix (set in TOAD Options, Procedure Editor)
        Table Name:       (set in the "New PL/SQL Object" dialog)

  ******************************************************************************/
BEGIN
  BEGIN
    SELECT to_date(in_ar_month_str || to_char(end_date, '09'), 'YYYYMMDD')
      INTO var_endday
      FROM ar_statistic_date
     WHERE to_date(in_ar_month_str || to_char(end_date, '09'), 'YYYYMMDD') BETWEEN
           valid_date_from AND valid_date_to ;

     
  EXCEPTION
    WHEN OTHERS THEN
      var_endday := add_months(to_date(in_ar_month_str || '01', 'YYYYMMDD'),
                               1) - 1;
  END;

  RETURN var_endday;
END ar_get_enddate_empid;
/

prompt
prompt Creating function AR_GET_GROUP_MEMBERS2
prompt =======================================
prompt
CREATE OR REPLACE FUNCTION ar_get_group_members2 (in_group_id IN NUMBER)
   RETURN sys_refcursor
IS
   TYPE ar_employee_type IS RECORD (
      empid    VARCHAR2 (20),
      deptid   VARCHAR2 (20)
   );

   v_members          sys_refcursor;
   v_employee         ar_employee_type;
   condition_cur      sys_refcursor;
   v_condition        ar_group_conditions%ROWTYPE;
   v_where            VARCHAR2 (2000)               := 'where';
   v_temp_condition   VARCHAR2 (200);
   sql_str            VARCHAR2 (2000);
BEGIN
   OPEN condition_cur FOR
      SELECT *
        FROM ar_group_conditions
       WHERE group_no = in_group_id;

   LOOP
      FETCH condition_cur
       INTO v_condition;

      EXIT WHEN condition_cur%NOTFOUND;
      v_temp_condition :=
            v_condition.field_name
         || ' '
         || v_condition.relation
         || ' '''
         || v_condition.value1
         || '''';

      IF v_condition.relation = 'between'
      THEN
         v_temp_condition :=
                  v_temp_condition || ' and ''' || v_condition.value2 || '''';
      END IF;

      IF v_where = 'where'
      THEN
         v_where := v_where || ' ' || v_temp_condition;
      ELSIF v_temp_condition IS NOT NULL
      THEN
         v_where := v_where || ' and ' || v_temp_condition;
      END IF;

      v_temp_condition := NULL;
   END LOOP;

   DBMS_OUTPUT.put_line (v_where);
   sql_str := 'select empid,deptid from ar_emp_info_v ' || v_where;

   OPEN v_members FOR sql_str;

   LOOP
      FETCH v_members
       INTO v_employee;

      EXIT WHEN v_members%NOTFOUND;
      DBMS_OUTPUT.put_line (v_employee.empid);
   END LOOP;

   RETURN v_members;
END ar_get_group_members2;
/

prompt
prompt Creating function AR_GET_HOLIDY_OVERTIME
prompt ========================================
prompt
CREATE OR REPLACE FUNCTION Ar_Get_Holidy_Overtime (ar_month VARCHAR2,emp_id VARCHAR2)
   RETURN NUMBER
IS
   month_holidy   NUMBER := 0;
   month_overtime NUMBER := 0;
   total_overtime NUMBER := 0;

   CURSOR cus_detail
   IS
      SELECT *
     FROM AR_DETAIL
    WHERE EMPID = emp_id
      AND AR_MONTH_STR = ar_month
      AND AR_ITEM_NO = 31
 ORDER BY AR_DATE_STR;

BEGIN

   SELECT NVL(SUM(QUANTITY),0) INTO total_overtime
     FROM AR_DETAIL
    WHERE EMPID = emp_id
      AND AR_MONTH_STR = ar_month
      AND AR_ITEM_NO = 31
 ORDER BY AR_DATE_STR;
 
   -- 加班累计超过16小时部分算加班费
   IF total_overtime >= 16
   THEN 
     RETURN 16;
   END IF;
   
   FOR detail_row IN cus_detail
   LOOP
       DBMS_OUTPUT.put_line (detail_row.PK_NO);
  -- 倒休时间为两天时，退出循环
     EXIT WHEN month_holidy >= 16;

  IF detail_row.QUANTITY <= 4
  THEN
   month_holidy := month_holidy + 4;
   month_overtime := month_overtime + detail_row.QUANTITY;
  END IF;

  IF detail_row.QUANTITY > 4 AND detail_row.QUANTITY <= 8
  THEN
   month_holidy := month_holidy + 8;
   month_overtime := month_overtime + detail_row.QUANTITY;
  END IF;

  IF detail_row.QUANTITY > 8
  THEN
   month_holidy := month_holidy + 8;
   month_overtime := month_overtime + 8;
  END IF;

   END LOOP;

   RETURN month_overtime;

   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN 0;
      WHEN OTHERS
      THEN
         RETURN 0;

END Ar_Get_Holidy_Overtime;
/

prompt
prompt Creating function AR_GET_ITEMCOUNT
prompt ==================================
prompt
CREATE OR REPLACE FUNCTION AR_GET_ITEMCOUNT(
IN_EMPID VARCHAR2,IN_ITEM_NO NUMBER,IN_MONTH VARCHAR2
) RETURN NUMBER AS

V_FLAG NUMBER:=0;
BEGIN
  SELECT NVL(COUNT(0),0) INTO V_FLAG FROM AR_DETAIL WHERE EMPID=IN_EMPID AND AR_ITEM_NO=IN_ITEM_NO AND AR_MONTH_STR=IN_MONTH;
  RETURN V_FLAG;
END AR_GET_ITEMCOUNT;
/

prompt
prompt Creating function AR_GET_LATE_HOURS
prompt ===================================
prompt
CREATE OR REPLACE FUNCTION ar_get_late_hours (
   in_current_date   IN   DATE,
   in_on_duty_time   IN   DATE,
   in_shift_start    IN   DATE,
   in_shift_end      IN   DATE
)
   RETURN NUMBER
IS
   late_minutes   NUMBER (8, 2);
   v_st_time      DATE;
   v_ed_time      DATE;
BEGIN
   v_st_time :=
      TO_DATE (   TO_CHAR (in_current_date, 'YYYY-MM-DD')
               || TO_CHAR (in_shift_start, 'hh24:mi:ss'),
               'yyyy-mm-dd hh24:mi:ss'
              );
   v_ed_time :=
      TO_DATE (   TO_CHAR (in_current_date, 'YYYY-MM-DD')
               || TO_CHAR (in_shift_end, 'hh24:mi:ss'),
               'yyyy-mm-dd hh24:mi:ss'
              );
   late_minutes := TO_NUMBER ((in_on_duty_time - in_shift_start) * 24 * 60);
   DBMS_OUTPUT.put_line ('late: ' || late_minutes);
   RETURN late_minutes;
END ar_get_late_hours;
/

prompt
prompt Creating function AR_GET_LATE_MINUTES
prompt =====================================
prompt
CREATE OR REPLACE FUNCTION ar_get_late_minutes (
   in_current_date   IN   DATE,
   in_on_duty_time   IN   DATE,
   in_shift_start    IN   DATE,
   in_shift_end      IN   DATE
)
   RETURN NUMBER
IS
   late_minutes   NUMBER (8, 2);
   v_st_time      DATE;
   v_ed_time      DATE;
BEGIN
   v_st_time :=
      TO_DATE (   TO_CHAR (in_current_date, 'YYYY-MM-DD')
               || TO_CHAR (in_shift_start, 'hh24:mi:ss'),
               'yyyy-mm-dd hh24:mi:ss'
              );
   v_ed_time :=
      TO_DATE (   TO_CHAR (in_current_date, 'YYYY-MM-DD')
               || TO_CHAR (in_shift_end, 'hh24:mi:ss'),
               'yyyy-mm-dd hh24:mi:ss'
              );

   IF in_on_duty_time > v_st_time
   THEN
      late_minutes := TO_NUMBER ((in_on_duty_time - v_st_time) * 24 * 60);
   ELSE
      late_minutes := 0;
   END IF;

   RETURN late_minutes;
END ar_get_late_minutes;
/

prompt
prompt Creating function AR_GET_LEAVE_EARLY_MINUTES
prompt ============================================
prompt
CREATE OR REPLACE FUNCTION ar_get_leave_early_minutes (
   in_current_date    IN   DATE,
   in_off_duty_time   IN   DATE,
   in_shift_start     IN   DATE,
   in_shift_end       IN   DATE
)
   RETURN NUMBER
IS
   leave_early_minutes   NUMBER (8, 2);
   v_st_time             DATE;
   v_ed_time             DATE;
BEGIN
   v_st_time :=
      TO_DATE (   TO_CHAR (in_current_date, 'YYYY-MM-DD')
               || TO_CHAR (in_shift_start, 'hh24:mi:ss'),
               'yyyy-mm-dd hh24:mi:ss'
              );
   v_ed_time :=
      TO_DATE (   TO_CHAR (in_current_date, 'YYYY-MM-DD')
               || TO_CHAR (in_shift_end, 'hh24:mi:ss'),
               'yyyy-mm-dd hh24:mi:ss'
              );

   IF v_ed_time > in_off_duty_time
   THEN
      leave_early_minutes :=
                         TO_NUMBER ((v_ed_time - in_off_duty_time) * 24 * 60);
   ELSE
      leave_early_minutes := 0;
   END IF;

   RETURN leave_early_minutes;
END ar_get_leave_early_minutes;
/

prompt
prompt Creating function AR_GET_MONTHSTR
prompt =================================
prompt
CREATE OR REPLACE FUNCTION AR_GET_MONTHSTR(IN_AR_DATE_STR VARCHAR2 --'YYYY/MM/DD'
                                           ) RETURN VARCHAR2 IS
  VAR_MONTHSTR    VARCHAR2(6);
  VAR_END         VARCHAR2(6);
  VAR_START         VARCHAR2(6);
  VAR_FLAG         VARCHAR2(20);
  VAR_CUR_M         VARCHAR2(20);
  VAR_CUR_MB         VARCHAR2(20);
  VAR_CUR_MA         VARCHAR2(20);
  VAR_AR_DATE_STR VARCHAR2(30);
  /******************************************************************************
     NAME:       AR_GET_MONTHSTR
     PURPOSE:    根据传入的日期字符串(YYYY/MM/DD),返回该日期所在的月份字符(YYYYMM)
  
     REVISIONS:
     Ver        Date        Author           Description
     ---------  ----------  ---------------  ------------------------------------
     1.0        03/03/2006   Pennix       1. Created this function.
  
     NOTES:
  
     Automatically available Auto Replace Keywords:
        Object Name:     AR_GET_MONTHSTR
        Sysdate:         03/03/2006
        Date and Time:   03/03/2006, 22:33:42, and 03/03/2006 22:33:42
        Username:        Pennix (set in TOAD Options, Procedure Editor)
        Table Name:       (set in the "New PL/SQL Object" dialog)
  
  ******************************************************************************/
BEGIN

  SELECT CASE
           WHEN INSTR(IN_AR_DATE_STR, '-') > 0 THEN
            REPLACE(IN_AR_DATE_STR, '-', '/')
           ELSE
            IN_AR_DATE_STR
         END
    INTO VAR_AR_DATE_STR
    FROM DUAL;

  BEGIN
    SELECT TO_CHAR(START_DATE),TO_CHAR(END_DATE),CYCLE_TYPE_CODE
      INTO VAR_START,VAR_END,VAR_FLAG
      FROM AR_STATISTIC_DATE
     WHERE TO_DATE(VAR_AR_DATE_STR, 'YYYY/MM/DD') BETWEEN VALID_DATE_FROM AND
           VALID_DATE_TO;
  EXCEPTION
    WHEN OTHERS THEN
      VAR_MONTHSTR := TO_CHAR(TO_DATE(VAR_AR_DATE_STR, 'YYYY/MM/DD'),
                              'YYYYMM');
      RETURN VAR_MONTHSTR;
  END;
  
  IF VAR_FLAG = 'systemMonth' THEN
    VAR_MONTHSTR := TO_CHAR(TO_DATE(VAR_AR_DATE_STR, 'YYYY/MM/DD'),
                            'YYYYMM');
  ELSE
    VAR_CUR_M := TO_CHAR(TO_DATE(VAR_AR_DATE_STR, 'YYYY/MM/DD'),
                              'YYYY-MM');
    VAR_CUR_MA  := TO_CHAR(ADD_MONTHS(TO_DATE(VAR_AR_DATE_STR,
                                               'YYYY/MM/DD'),
                                       1),
                            'YYYY-MM');
    VAR_CUR_MB  := TO_CHAR(ADD_MONTHS(TO_DATE(VAR_AR_DATE_STR,
                                               'YYYY/MM/DD'),
                                       -1),
                            'YYYY-MM');
  
   BEGIN
    SELECT TO_CHAR(TO_DATE(VAR_AR_DATE_STR, 'YYYY/MM/DD'),'YYYYMM')
      INTO VAR_MONTHSTR
      FROM DUAL
     WHERE TO_DATE(VAR_AR_DATE_STR, 'YYYY/MM/DD') BETWEEN TO_DATE(VAR_CUR_MB|| '-'||VAR_START,'YYYY-MM-DD') AND
           TO_DATE(VAR_CUR_M|| '-'||VAR_END,'YYYY-MM-DD');
  EXCEPTION
    WHEN OTHERS THEN
    SELECT TO_CHAR(ADD_MONTHS(TO_DATE(VAR_AR_DATE_STR,'YYYY/MM/DD'),1),'YYYYMM')
      INTO VAR_MONTHSTR
      FROM DUAL
     WHERE TO_DATE(VAR_AR_DATE_STR, 'YYYY/MM/DD') BETWEEN TO_DATE(VAR_CUR_M|| '-'||VAR_START,'YYYY-MM-DD') AND
           TO_DATE(VAR_CUR_MA|| '-'||VAR_END,'YYYY-MM-DD');
      RETURN VAR_MONTHSTR;
  END;
    
  END IF;

  RETURN VAR_MONTHSTR;
END AR_GET_MONTHSTR;
/

prompt
prompt Creating function AR_GET_OT_HOURS
prompt =================================
prompt
CREATE OR REPLACE FUNCTION ar_get_ot_hours (
   in_current_date    IN   DATE,
   in_off_duty_time   IN   DATE,
   in_shift_start     IN   DATE,
   in_shift_end       IN   DATE
)
   RETURN NUMBER
IS
   ot_hours    NUMBER (8, 2);
   v_st_time   DATE;
   v_ed_time   DATE;
BEGIN
   v_st_time :=
      TO_DATE (   TO_CHAR (in_current_date, 'YYYY-MM-DD')
               || TO_CHAR (in_shift_start, 'hh24:mi:ss'),
               'yyyy-mm-dd hh24:mi:ss'
              );
   v_ed_time :=
      TO_DATE (   TO_CHAR (in_current_date, 'YYYY-MM-DD')
               || TO_CHAR (in_shift_end, 'hh24:mi:ss'),
               'yyyy-mm-dd hh24:mi:ss'
              );

   IF in_off_duty_time > v_ed_time
   THEN
      ot_hours := TO_NUMBER ((in_off_duty_time - v_ed_time) * 24);
   ELSE
      ot_hours := 0;
   END IF;

   RETURN ot_hours;
END ar_get_ot_hours;
/

prompt
prompt Creating function AR_GET_SHIFTNO
prompt ================================
prompt
CREATE OR REPLACE FUNCTION AR_GET_SHIFTNO(IN_EMPID       VARCHAR2,
                                          IN_AR_DATE_STR VARCHAR2)
  RETURN NUMBER IS
  VAR_SHIFTNO     NUMBER;
  VAR_SHIFTNOC    NUMBER;
  VAR_ITEMNO      NUMBER;
  VAR_GROUPNO     NUMBER;
  VAR_AR_DATE_STR VARCHAR2(30);
  VAR_COUNT       NUMBER;
  
  /******************************************************************************
     NAME:       AR_GET_SHIFTNO
     PURPOSE:    根据员工号和日期返回该员工在该日的考勤班次号
  
     REVISIONS:
     Ver        Date        Author           Description
     ---------  ----------  ---------------  ------------------------------------
     1.0        02/16/2006   Pennix       1. Created this function.
  
     NOTES:
  
     Automatically available Auto Replace Keywords:
        Object Name:     AR_GET_SHIFTNO
        Sysdate:         02/16/2006
        Date and Time:   02/16/2006, 15:03:40, and 02/16/2006 15:03:40
        Username:        Pennix (set in TOAD Options, Procedure Editor)
        Table Name:       (set in the "New PL/SQL Object" dialog)
  
  ******************************************************************************/
BEGIN
  VAR_COUNT := 0;
  SELECT CASE
           WHEN INSTR(IN_AR_DATE_STR, '-') > 0 THEN
            REPLACE(IN_AR_DATE_STR, '-', '/')
           ELSE
            IN_AR_DATE_STR
         END
    INTO VAR_AR_DATE_STR
    FROM DUAL;

  --  因友利没有 刷卡，没有动太组 所以以下查询 注释掉
  BEGIN
    -- 取排班表中的班次信息
    SELECT SHIFT_NO
      INTO VAR_SHIFTNO
      FROM AR_SCHEDULE
     WHERE EMPID = IN_EMPID
       AND AR_DATE_STR = VAR_AR_DATE_STR
       AND ROWNUM = 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      VAR_SHIFTNO := NULL;
  END;

  IF VAR_SHIFTNO IS NULL THEN
    BEGIN
      -- 取该员工隶属的动态组
      SELECT GROUP_NO
        INTO VAR_GROUPNO
        FROM AR_DYNAMIC_GROUP_EMP
       WHERE EMPID = IN_EMPID;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        VAR_GROUPNO := NULL;
    END;
  
    IF VAR_GROUPNO IS NOT NULL THEN
      BEGIN
        -- 取该员工的动态组日历对应的班次信息
        SELECT SHIFT_NO
          INTO VAR_SHIFTNO
          FROM AR_CALENDER_GROUP
         WHERE GROUP_ID = VAR_GROUPNO
           AND TO_CHAR(DDATE, 'YYYY/MM/DD') = VAR_AR_DATE_STR;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          VAR_SHIFTNO := NULL;
      END;
    END IF;
  END IF;
  
  IF VAR_SHIFTNO IS NULL THEN
    BEGIN
      -- 取公司日历表中班次信息
      SELECT SHIFT_NO
        INTO VAR_SHIFTNOC
        FROM AR_CALENDER
       WHERE TO_CHAR(DDATE, 'YYYY/MM/DD') = TO_CHAR((TO_DATE(in_ar_date_str,'YYYY/MM/DD')),'YYYY/MM/DD');
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        VAR_SHIFTNOC := -1;
    END;
    /*
    BEGIN
      SELECT AR_ITEM_NO INTO VAR_ITEMNO
      FROM AR_SHIFT020
      WHERE SHIFT_NO = VAR_SHIFTNOC
      AND ROWNUM=1;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        VAR_ITEMNO := -1;
    END;
    IF VAR_ITEMNO = 15 THEN
      SELECT COUNT(*) INTO VAR_COUNT FROM(
             SELECT ASG.SHIFT_NO
             FROM AR_SHIFT_GROUP ASG,AR_SHIFT_GROUP_EMP ASGE
             WHERE ASG.GROUP_NO = ASGE.GROUP_NO
             AND ASGE.EMPID = IN_EMPID
             AND TO_DATE(VAR_AR_DATE_STR,'YYYY/MM/DD HH24:MI:SS') >= ASGE.S_DATE
             AND TO_DATE(VAR_AR_DATE_STR,'YYYY/MM/DD HH24:MI:SS') <= (ASGE.E_DATE+1));
      IF VAR_COUNT>0 THEN
    */
    BEGIN
      SELECT ASG.SHIFT_NO INTO VAR_SHIFTNO
      FROM AR_SHIFT_GROUP ASG,AR_SHIFT_GROUP_EMP ASGE
      WHERE ASG.GROUP_NO = ASGE.GROUP_NO
      AND ASGE.EMPID = IN_EMPID
      AND TO_DATE(VAR_AR_DATE_STR,'YYYY/MM/DD HH24:MI:SS') >= ASGE.S_DATE
      AND TO_DATE(VAR_AR_DATE_STR,'YYYY/MM/DD HH24:MI:SS') <= (ASGE.E_DATE+1)
      AND ROWNUM=1;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        VAR_SHIFTNO := NULL;
    END;
    /*
      END IF; 
    END IF;
    */
    IF VAR_SHIFTNO IS NULL THEN
      VAR_SHIFTNO := VAR_SHIFTNOC;
    END IF;
  END IF;

  /*
      BEGIN
         -- 取公司日历表中班次信息
           SELECT shift_no
             INTO var_shiftno
             FROM AR_CALENDER
            WHERE TO_CHAR (ddate, 'YYYY/MM/DD') = TO_CHAR((TO_DATE(in_ar_date_str,'YYYY/MM/DD')),'YYYY/MM/DD');
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN
              var_shiftno := -1;
        END;
  */
  RETURN VAR_SHIFTNO;
END AR_GET_SHIFTNO;
/

prompt
prompt Creating function AR_GET_STARTDATE
prompt ==================================
prompt
CREATE OR REPLACE FUNCTION AR_GET_STARTDATE(IN_AR_MONTH_STR VARCHAR2)
  RETURN DATE IS
  VAR_STARTDAY DATE;
  /******************************************************************************
     NAME:       AR_GET_ENDDATE
     PURPOSE:    取得考勤月的第一天
  
     REVISIONS:
     Ver        Date        Author           Description
     ---------  ----------  ---------------  ------------------------------------
     1.0        03/04/2006   Pennix       1. Created this function.
  
     NOTES:
  
     Automatically available Auto Replace Keywords:
        Object Name:     AR_GET_ENDDATE
        Sysdate:         03/04/2006
        Date and Time:   03/04/2006, 17:02:50, and 03/04/2006 17:02:50
        Username:        Pennix (set in TOAD Options, Procedure Editor)
        Table Name:       (set in the "New PL/SQL Object" dialog)
  
  ******************************************************************************/
BEGIN
  BEGIN
    --只适用于跨月的考勤区间
    SELECT ADD_MONTHS(TO_DATE(IN_AR_MONTH_STR || TO_CHAR(START_DATE, '09'),
                              'YYYYMMDD'),
                      -1)
      INTO VAR_STARTDAY
      FROM AR_STATISTIC_DATE
     WHERE ADD_MONTHS(TO_DATE(IN_AR_MONTH_STR || TO_CHAR(START_DATE, '09'),
                              'YYYYMMDD'),
                      -1) BETWEEN VALID_DATE_FROM AND VALID_DATE_TO
       AND CYCLE_TYPE_CODE = 'crossMonth'
       AND ROWNUM = 1;
  EXCEPTION
    WHEN OTHERS THEN
      IF IN_AR_MONTH_STR IS NULL THEN
        VAR_STARTDAY := TO_DATE(TO_CHAR(SYSDATE, 'yyyymm') || '01',
                                'YYYYMMDD');
      ELSE
        VAR_STARTDAY := TO_DATE(IN_AR_MONTH_STR || '01', 'YYYYMMDD');
      END IF;
  END;

  RETURN VAR_STARTDAY;
END AR_GET_STARTDATE;
/

prompt
prompt Creating function AR_GET_STARTDATE_EMPID
prompt ========================================
prompt
CREATE OR REPLACE FUNCTION AR_GET_STARTDATE_EMPID(IN_AR_MONTH_STR VARCHAR2,
                                                  IN_EMPID        VARCHAR2)
  RETURN DATE IS
  VAR_STARTDAY DATE;
  /******************************************************************************
     NAME:       AR_GET_ENDDATE
     PURPOSE:    取得考勤月的第一天
  
     REVISIONS:
     Ver        Date        Author           Description
     ---------  ----------  ---------------  ------------------------------------
     1.0        03/04/2006   Pennix       1. Created this function.
  
     NOTES:
  
     Automatically available Auto Replace Keywords:
        Object Name:     AR_GET_ENDDATE
        Sysdate:         03/04/2006
        Date and Time:   03/04/2006, 17:02:50, and 03/04/2006 17:02:50
        Username:        Pennix (set in TOAD Options, Procedure Editor)
        Table Name:       (set in the "New PL/SQL Object" dialog)
  
  ******************************************************************************/
BEGIN

  BEGIN
    --只适用于跨月的考勤区间
    SELECT ADD_MONTHS(TO_DATE(IN_AR_MONTH_STR || TO_CHAR(START_DATE, '09'),
                              'YYYYMMDD'),
                      -1)
      INTO VAR_STARTDAY
      FROM AR_STATISTIC_DATE
     WHERE ADD_MONTHS(TO_DATE(IN_AR_MONTH_STR || TO_CHAR(START_DATE, '09'),
                              'YYYYMMDD'),
                      -1) BETWEEN VALID_DATE_FROM AND VALID_DATE_TO
       AND START_DATE <> 1;
  
  EXCEPTION
    WHEN OTHERS THEN
      VAR_STARTDAY := TO_DATE(IN_AR_MONTH_STR || '01', 'YYYYMMDD');
  END;

  RETURN VAR_STARTDAY;
END AR_GET_STARTDATE_EMPID;
/

prompt
prompt Creating function AR_GET_STA_ITEM_VAL
prompt =====================================
prompt
CREATE OR REPLACE FUNCTION ar_get_sta_item_val (
   empid         VARCHAR2,
   monthstr      VARCHAR2,
   sta_item_id   VARCHAR2
)
   RETURN VARCHAR2
IS
   var_item_val   VARCHAR2 (500);
   var_sql        VARCHAR2 (500);
BEGIN
   var_sql :=
         'SELECT '
      || sta_item_id
      || ' FROM AR_HISTORY WHERE AR_MONTH = '''
      || monthstr
      || ''' AND EMPID = '''
      || empid
   || '''';

   BEGIN
      EXECUTE IMMEDIATE var_sql
                   INTO var_item_val;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         var_item_val := 0;
      WHEN OTHERS
      THEN
     RAISE;
   END;

   RETURN var_item_val;
END ar_get_sta_item_val;
/

prompt
prompt Creating function AR_GET_WORK_ENDDATE
prompt =====================================
prompt
CREATE OR REPLACE FUNCTION Ar_Get_Work_Enddate (in_ar_month_str VARCHAR2)
   RETURN DATE
IS
   var_endday   DATE;

BEGIN
   BEGIN                          
		SELECT MAX(DDATE)
		  INTO var_endday
		  FROM AR_CALENDER A
		 WHERE A.DDATE BETWEEN AR_GET_STARTDATE(in_ar_month_str) AND AR_GET_ENDDATE(in_ar_month_str)
		   AND A.TYPEID = 1;
   EXCEPTION
      WHEN OTHERS
      THEN
      	  var_endday := LAST_DAY(TO_DATE(in_ar_month_str,'YYYYMM'));
   END;

   RETURN var_endday;
END Ar_Get_Work_Enddate;
/

prompt
prompt Creating function AR_GET_WORK_MINSTARTDATE
prompt ==========================================
prompt
CREATE OR REPLACE FUNCTION Ar_Get_Work_minStartdate (in_ar_month_str VARCHAR2)
   RETURN DATE
IS
   var_startday   DATE;

BEGIN
   BEGIN
          SELECT MIN(DDATE)
            INTO var_startday
           FROM AR_CALENDER
            WHERE ddate  BETWEEN Ar_Get_Startdate(in_ar_month_str) AND Ar_Get_ENDdate(in_ar_month_str)
            AND ar_calender.typeid= 3 ;
   EXCEPTION
      WHEN OTHERS
      THEN
          var_startday := null;
   END;

   RETURN var_startday;
END Ar_Get_Work_minStartdate;
/

prompt
prompt Creating function AR_GET_WORK_STARTDATE
prompt =======================================
prompt
CREATE OR REPLACE FUNCTION Ar_Get_Work_Startdate (in_ar_month_str VARCHAR2)
   RETURN DATE
IS
   var_startday   DATE;
   var_day_s DATE := AR_GET_STARTDATE(in_ar_month_str) ;
   var_day_e DATE := AR_GET_ENDDATE(in_ar_month_str) ;
BEGIN
   BEGIN                          
    SELECT MIN(DDATE)
      INTO var_startday
      FROM AR_CALENDER A
     WHERE A.DDATE BETWEEN var_day_s AND var_day_e
       AND A.TYPEID = 1;
   EXCEPTION
      WHEN OTHERS
      THEN
          var_startday := TO_DATE(in_ar_month_str || '01','YYYY-MM-DD');
   END;

   RETURN var_startday;
END Ar_Get_Work_Startdate;
/

prompt
prompt Creating function AR_START_DAY
prompt ==============================
prompt
CREATE OR REPLACE FUNCTION ar_start_day (monthstr VARCHAR2)
   RETURN NUMBER
IS
   startdate   NUMBER;
BEGIN
   BEGIN
      SELECT start_date
        INTO startdate
        FROM ar_statistic_date
       WHERE valid_date_from <= TO_DATE (monthstr || '01', 'yyyy-mm-dd')
         AND valid_date_to >= TO_DATE (monthstr || '01', 'yyyy-mm-dd');
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         startdate := 01;
      WHEN OTHERS
      THEN
         -- Consider logging the error and then re-raise
         RAISE;
   END;

   RETURN startdate;
END ar_start_day;
/

prompt
prompt Creating function AR_START_MONTH
prompt ================================
prompt
CREATE OR REPLACE FUNCTION ar_start_month (monthstr VARCHAR2)
   RETURN DATE
IS
   tmpvar      NUMBER;
   startdate   DATE;
BEGIN
   SELECT start_date
     INTO tmpvar
     FROM ar_statistic_date
    WHERE valid_date_from <= TO_DATE (monthstr || '01', 'yyyy-mm-dd')
      AND valid_date_to >= TO_DATE (monthstr || '01', 'yyyy-mm-dd');

   IF tmpvar = 1
   THEN
      startdate :=
              TO_DATE (TO_CHAR (TO_NUMBER (monthstr)) || tmpvar,
                       'yyyy-mm-dd');
   ELSE
      startdate :=
           TO_DATE (TO_CHAR (TO_NUMBER (monthstr) - 1) || tmpvar,
                    'yyyy-mm-dd');
   END IF;

   RETURN startdate;
END ar_start_month;
/

prompt
prompt Creating function AR_UNIT
prompt =========================
prompt
CREATE OR REPLACE FUNCTION ar_unit (days NUMBER, unit VARCHAR2)
   RETURN NUMBER
IS
   v_rtl   NUMBER;
BEGIN
   v_rtl :=
      CASE unit
         WHEN 'HOUR'
            THEN days * 24
         WHEN 'DAY'
            THEN days
         WHEN 'MINUTE'
            THEN days * 24 * 60
         ELSE -1
      END;
   RETURN v_rtl;
END;
/

prompt
prompt Creating function ATT_GET_LEAVE_LENGTHEVE
prompt =========================================
prompt
CREATE OR REPLACE FUNCTION ATT_GET_LEAVE_LENGTHeve
(
 IN_EMPID        VARCHAR2,
 LEAVE_FROM_TIME VARCHAR2,
 LEAVE_TO_TIME   VARCHAR2,
  REMOVE_SHIFT_NO NUMBER,
  leave_type_code VARCHAR2

) RETURN varchar IS
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
BEGIN
 VAR_APPLY_LENGTH := 0;
 --leave apply start date
 VAR_LEAVE_FROM_TIME := TO_DATE(LEAVE_FROM_TIME, 'YYYY/MM/DD HH24:MI:SS');
 --leave apply end date
 VAR_LEAVE_TO_TIME := TO_DATE(LEAVE_TO_TIME, 'YYYY/MM/DD HH24:MI:SS');

 IF VAR_LOG_FLAG > 0 THEN
  DBMS_OUTPUT.PUT_LINE('LEAVE_FROM_TIME:' ||
             TO_CHAR(VAR_LEAVE_FROM_TIME, 'YYYY/MM/DD HH24:mi:ss'));
  DBMS_OUTPUT.PUT_LINE('LEAVE_TO_TIME:' || TO_CHAR(VAR_LEAVE_TO_TIME, 'YYYY/MM/DD HH24:mi:ss'));
 END IF;

 VAR_IN_DATE := VAR_LEAVE_FROM_TIME;

 --请假日期时间段循环
 WHILE VAR_LEAVE_TO_TIME >= VAR_IN_DATE
 LOOP

  VAR_SHIFT_NO := AR_GET_SHIFTNO(IN_EMPID, TO_CHAR(VAR_IN_DATE, 'YYYY/MM/DD'));

  VAR_INT_DATE_STR := TO_CHAR(VAR_IN_DATE, 'YYYY/MM/DD');
  IF VAR_LOG_FLAG > 0 THEN
   DBMS_OUTPUT.PUT_LINE('IN_DATE:' || TO_CHAR(VAR_IN_DATE, 'YYYY/MM/DD HH24:mi:ss'));
   DBMS_OUTPUT.PUT_LINE('VAR_INT_DATE_STR:' || VAR_INT_DATE_STR);
  END IF;

    DECLARE
        CURSOR CUR_SHIFT_TIME IS
        SELECT AR_ITEM_NO,
          BEGIN_DAY_OFFSET -- 开始时间与考勤日的位移：当日，次日，三日
          + TO_DATE(VAR_INT_DATE_STR || ' ' || TO_CHAR(FROM_TIME, 'HH24:mi:ss'),
               'YYYY/MM/DD HH24:mi:ss') FROM_TIME,
          END_DAY_OFFSET -- 结束时间与考勤日的位移：当日，次日，三日
          + TO_DATE(VAR_INT_DATE_STR || ' ' || TO_CHAR(TO_TIME, 'HH24:mi:ss'),
               'YYYY/MM/DD HH24:mi:ss') TO_TIME
       FROM AR_SHIFT020
       WHERE SHIFT_NO = VAR_SHIFT_NO
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
                  TO_CHAR(VAR_SHIFT_FROM_TIME, 'YYYY/MM/DD HH24:mi:ss'));
       DBMS_OUTPUT.PUT_LINE('SHIFT_TO_TIME:' ||
                  TO_CHAR(VAR_SHIFT_TO_TIME, 'YYYY/MM/DD HH24:mi:ss'));

       DBMS_OUTPUT.PUT_LINE('LEAVE_FROM_TIME:    ' ||
                  TO_CHAR(VAR_LEAVE_FROM_TIME, 'YYYY/MM/DD HH24:mi:ss'));
       DBMS_OUTPUT.PUT_LINE('LEAVE_TO_TIME:      ' ||
                  TO_CHAR(VAR_LEAVE_TO_TIME, 'YYYY/MM/DD HH24:mi:ss'));

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

       DBMS_OUTPUT.PUT_LINE('FROM_TIME:' || TO_CHAR(VAR_TO_DATE, 'YYYY/MM/DD HH24:mi:ss'));
       DBMS_OUTPUT.PUT_LINE('TO_TIME:' || TO_CHAR(VAR_FROM_DATE, 'YYYY/MM/DD HH24:mi:ss'));
      END IF;
      IF (VAR_TO_DATE - VAR_FROM_DATE) > 0  THEN
              -- 判断，是否刨去休息日
              IF VAR_SHIFT_NO = REMOVE_SHIFT_NO AND leave_type_code <> 'EvectionTypeCode' THEN
                 VAR_APPLY_LENGTH := VAR_APPLY_LENGTH ;
              ELSE
                 VAR_APPLY_LENGTH := VAR_APPLY_LENGTH + (VAR_TO_DATE - VAR_FROM_DATE) * 24;
              END IF ;
      END IF;
     END LOOP;

     CLOSE CUR_SHIFT_TIME;
    END;
  VAR_IN_DATE := VAR_IN_DATE + 1;
 END LOOP;

 IF leave_type_code = 'EvectionTypeCode' AND REMOVE_SHIFT_NO=2 THEN
     RETURN trunc(VAR_APPLY_LENGTH/8)||'天';
 END IF;

 IF mod(VAR_APPLY_LENGTH,8)=0 THEN
  RETURN trunc(VAR_APPLY_LENGTH/8)||'天';
 ELSE
 RETURN trunc(VAR_APPLY_LENGTH/8)||'天'||mod(VAR_APPLY_LENGTH,8)||'小时';
 END IF;

EXCEPTION
 WHEN NO_DATA_FOUND THEN
  VAR_APPLY_LENGTH := 0;
 WHEN OTHERS THEN
  -- CONSIDER LOGGING THE ERROR AND THEN RE-RAISE
  RAISE;
END ATT_GET_LEAVE_LENGTHeve;
/

prompt
prompt Creating function ATT_GET_LEAVE_LENGTH_NEW
prompt ==========================================
prompt
CREATE OR REPLACE FUNCTION ATT_GET_LEAVE_LENGTH_NEW
(
 IN_EMPID        VARCHAR2,
 LEAVE_FROM_TIME VARCHAR2,
 LEAVE_TO_TIME   VARCHAR2,
  REMOVE_SHIFT_NO NUMBER

) RETURN NUMBER IS
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
 VAR_LOG_FLAG        INT := 1;
BEGIN
 VAR_APPLY_LENGTH := 0;
 --leave apply start date
 VAR_LEAVE_FROM_TIME := TO_DATE(LEAVE_FROM_TIME, 'YYYY/MM/DD HH24:MI:SS');
 --leave apply end date
 VAR_LEAVE_TO_TIME := TO_DATE(LEAVE_TO_TIME, 'YYYY/MM/DD HH24:MI:SS');

 IF VAR_LOG_FLAG > 0 THEN
  DBMS_OUTPUT.PUT_LINE('LEAVE_FROM_TIME:' ||
             TO_CHAR(VAR_LEAVE_FROM_TIME, 'YYYY/MM/DD HH24:mi:ss'));
  DBMS_OUTPUT.PUT_LINE('LEAVE_TO_TIME:' || TO_CHAR(VAR_LEAVE_TO_TIME, 'YYYY/MM/DD HH24:mi:ss'));
 END IF;

 VAR_IN_DATE := VAR_LEAVE_FROM_TIME;

 --请假日期时间段循环
 WHILE VAR_LEAVE_TO_TIME >= VAR_IN_DATE
 LOOP

 VAR_SHIFT_NO := AR_GET_SHIFTNO(IN_EMPID, TO_CHAR(VAR_IN_DATE, 'YYYY/MM/DD'));

  VAR_INT_DATE_STR := TO_CHAR(VAR_IN_DATE, 'YYYY/MM/DD');
  IF VAR_LOG_FLAG > 0 THEN
   DBMS_OUTPUT.PUT_LINE('IN_DATE:' || TO_CHAR(VAR_IN_DATE, 'YYYY/MM/DD HH24:mi:ss'));
   DBMS_OUTPUT.PUT_LINE('VAR_INT_DATE_STR:' || VAR_INT_DATE_STR);
  END IF;

    DECLARE
        CURSOR CUR_SHIFT_TIME IS
        SELECT AR_ITEM_NO,
          BEGIN_DAY_OFFSET -- 开始时间与考勤日的位移：当日，次日，三日
          + TO_DATE(VAR_INT_DATE_STR || ' ' || TO_CHAR(FROM_TIME, 'HH24:mi:ss'),
               'YYYY/MM/DD HH24:mi:ss') FROM_TIME,
          END_DAY_OFFSET -- 结束时间与考勤日的位移：当日，次日，三日
          + TO_DATE(VAR_INT_DATE_STR || ' ' || TO_CHAR(TO_TIME, 'HH24:mi:ss'),
               'YYYY/MM/DD HH24:mi:ss') TO_TIME
       FROM AR_SHIFT020
       WHERE SHIFT_NO = VAR_SHIFT_NO
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
                  TO_CHAR(VAR_SHIFT_FROM_TIME, 'YYYY/MM/DD HH24:mi:ss'));
       DBMS_OUTPUT.PUT_LINE('SHIFT_TO_TIME:' ||
                  TO_CHAR(VAR_SHIFT_TO_TIME, 'YYYY/MM/DD HH24:mi:ss'));

       DBMS_OUTPUT.PUT_LINE('LEAVE_FROM_TIME:    ' ||
                  TO_CHAR(VAR_LEAVE_FROM_TIME, 'YYYY/MM/DD HH24:mi:ss'));
       DBMS_OUTPUT.PUT_LINE('LEAVE_TO_TIME:      ' ||
                  TO_CHAR(VAR_LEAVE_TO_TIME, 'YYYY/MM/DD HH24:mi:ss'));

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

       DBMS_OUTPUT.PUT_LINE('FROM_TIME:' || TO_CHAR(VAR_TO_DATE, 'YYYY/MM/DD HH24:mi:ss'));
       DBMS_OUTPUT.PUT_LINE('TO_TIME:' || TO_CHAR(VAR_FROM_DATE, 'YYYY/MM/DD HH24:mi:ss'));
      END IF;
      IF (VAR_TO_DATE - VAR_FROM_DATE) > 0 THEN
              -- 判断，是否刨去休息日
              IF VAR_SHIFT_NO in(REMOVE_SHIFT_NO) THEN
            VAR_APPLY_LENGTH := VAR_APPLY_LENGTH ;
              ELSE
                 VAR_APPLY_LENGTH := VAR_APPLY_LENGTH + (VAR_TO_DATE - VAR_FROM_DATE) * 24;
              END IF ;
      END IF;
     END LOOP;

     CLOSE CUR_SHIFT_TIME;
    END;
  VAR_IN_DATE := VAR_IN_DATE + 1;
  END LOOP;
    RETURN VAR_APPLY_LENGTH;
EXCEPTION
 WHEN NO_DATA_FOUND THEN
  VAR_APPLY_LENGTH := 0;
 WHEN OTHERS THEN
  -- CONSIDER LOGGING THE ERROR AND THEN RE-RAISE
  RAISE;
END ATT_GET_LEAVE_LENGTH_NEW;
/

prompt
prompt Creating function ATT_GET_LEAVE_LENGTH_PEIXUN
prompt =============================================
prompt
CREATE OR REPLACE FUNCTION ATT_GET_LEAVE_LENGTH_PEIXUN
(
 IN_EMPID        VARCHAR2,
 LEAVE_FROM_TIME VARCHAR2,
 LEAVE_TO_TIME   VARCHAR2,
  REMOVE_SHIFT_NO NUMBER

) RETURN varchar IS
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
BEGIN
 VAR_APPLY_LENGTH := 0;
 --leave apply start date
 VAR_LEAVE_FROM_TIME := TO_DATE(LEAVE_FROM_TIME, 'YYYY/MM/DD HH24:MI:SS');
 --leave apply end date
 VAR_LEAVE_TO_TIME := TO_DATE(LEAVE_TO_TIME, 'YYYY/MM/DD HH24:MI:SS');

 IF VAR_LOG_FLAG > 0 THEN
  DBMS_OUTPUT.PUT_LINE('LEAVE_FROM_TIME:' ||
             TO_CHAR(VAR_LEAVE_FROM_TIME, 'YYYY/MM/DD HH24:mi:ss'));
  DBMS_OUTPUT.PUT_LINE('LEAVE_TO_TIME:' || TO_CHAR(VAR_LEAVE_TO_TIME, 'YYYY/MM/DD HH24:mi:ss'));
 END IF;

 VAR_IN_DATE := VAR_LEAVE_FROM_TIME;

 --请假日期时间段循环
 WHILE VAR_LEAVE_TO_TIME >= VAR_IN_DATE
 LOOP

  VAR_SHIFT_NO := AR_GET_SHIFTNO(IN_EMPID, TO_CHAR(VAR_IN_DATE, 'YYYY/MM/DD'));

  VAR_INT_DATE_STR := TO_CHAR(VAR_IN_DATE, 'YYYY/MM/DD');
  IF VAR_LOG_FLAG > 0 THEN
   DBMS_OUTPUT.PUT_LINE('IN_DATE:' || TO_CHAR(VAR_IN_DATE, 'YYYY/MM/DD HH24:mi:ss'));
   DBMS_OUTPUT.PUT_LINE('VAR_INT_DATE_STR:' || VAR_INT_DATE_STR);
  END IF;

    DECLARE
        CURSOR CUR_SHIFT_TIME IS
        SELECT AR_ITEM_NO,
          BEGIN_DAY_OFFSET -- 开始时间与考勤日的位移：当日，次日，三日
          + TO_DATE(VAR_INT_DATE_STR || ' ' || TO_CHAR(FROM_TIME, 'HH24:mi:ss'),
               'YYYY/MM/DD HH24:mi:ss') FROM_TIME,
          END_DAY_OFFSET -- 结束时间与考勤日的位移：当日，次日，三日
          + TO_DATE(VAR_INT_DATE_STR || ' ' || TO_CHAR(TO_TIME, 'HH24:mi:ss'),
               'YYYY/MM/DD HH24:mi:ss') TO_TIME
       FROM AR_SHIFT020
       WHERE SHIFT_NO = VAR_SHIFT_NO
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
                  TO_CHAR(VAR_SHIFT_FROM_TIME, 'YYYY/MM/DD HH24:mi:ss'));
       DBMS_OUTPUT.PUT_LINE('SHIFT_TO_TIME:' ||
                  TO_CHAR(VAR_SHIFT_TO_TIME, 'YYYY/MM/DD HH24:mi:ss'));

       DBMS_OUTPUT.PUT_LINE('LEAVE_FROM_TIME:    ' ||
                  TO_CHAR(VAR_LEAVE_FROM_TIME, 'YYYY/MM/DD HH24:mi:ss'));
       DBMS_OUTPUT.PUT_LINE('LEAVE_TO_TIME:      ' ||
                  TO_CHAR(VAR_LEAVE_TO_TIME, 'YYYY/MM/DD HH24:mi:ss'));

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

       DBMS_OUTPUT.PUT_LINE('FROM_TIME:' || TO_CHAR(VAR_TO_DATE, 'YYYY/MM/DD HH24:mi:ss'));
       DBMS_OUTPUT.PUT_LINE('TO_TIME:' || TO_CHAR(VAR_FROM_DATE, 'YYYY/MM/DD HH24:mi:ss'));
      END IF;
      IF (VAR_TO_DATE - VAR_FROM_DATE) > 0 THEN
              -- 判断，是否刨去休息日
              IF VAR_SHIFT_NO = REMOVE_SHIFT_NO THEN
                VAR_APPLY_LENGTH := VAR_APPLY_LENGTH + (VAR_TO_DATE - VAR_FROM_DATE) * 24 - 1 ;
              ELSE
                 VAR_APPLY_LENGTH := VAR_APPLY_LENGTH + (VAR_TO_DATE - VAR_FROM_DATE) * 24;
              END IF ;
      END IF;
     END LOOP;

     CLOSE CUR_SHIFT_TIME;
    END;
  VAR_IN_DATE := VAR_IN_DATE + 1;
 END LOOP;
 IF mod(VAR_APPLY_LENGTH,8)=0 THEN
  RETURN trunc(VAR_APPLY_LENGTH/8)||'天';
 ELSE
 RETURN trunc(VAR_APPLY_LENGTH/8)||'天'||mod(VAR_APPLY_LENGTH,8)||'小时';
 END IF;

EXCEPTION
 WHEN NO_DATA_FOUND THEN
  VAR_APPLY_LENGTH := 0;
 WHEN OTHERS THEN
  -- CONSIDER LOGGING THE ERROR AND THEN RE-RAISE
  RAISE;
END ATT_GET_LEAVE_LENGTH_PEIXUN;
/

prompt
prompt Creating function ATT_GET_LEAVE_LENGTH_T
prompt ========================================
prompt
CREATE OR REPLACE FUNCTION ATT_GET_LEAVE_LENGTH_T(IN_EMPID        VARCHAR2,
                                                  LEAVE_FROM_TIME VARCHAR2,
                                                  LEAVE_TO_TIME   VARCHAR2,
                                                  REMOVE_SHIFT_NO NUMBER

                                                  ) RETURN VARCHAR IS
  VAR_APPLY_LENGTH    NUMBER;
  VAR_SHIFT_FROM_TIME DATE;
  VAR_SHIFT_TO_TIME   DATE;
  VAR_FROM_DATE       DATE;
  VAR_TO_DATE         DATE;
  VAR_LEAVE_FROM_TIME DATE;
  VAR_LEAVE_TO_TIME   DATE;
  CNT_LEAVE_FROM_TIME NUMBER;
  CNT_LEAVE_TO_TIME   NUMBER;
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
  SELECT LENGTH(LEAVE_FROM_TIME) INTO CNT_LEAVE_FROM_TIME FROM DUAL;
  SELECT LENGTH(LEAVE_TO_TIME) INTO CNT_LEAVE_TO_TIME FROM DUAL;

  IF CNT_LEAVE_FROM_TIME = 16 THEN

    VAR_LEAVE_FROM_TIME := TO_DATE(LEAVE_FROM_TIME || ':00',
                                   'YYYY/MM/DD HH24:MI:SS');

  END IF;

  IF CNT_LEAVE_TO_TIME = 16 THEN
    VAR_LEAVE_TO_TIME := TO_DATE(LEAVE_TO_TIME || ':00',
                                 'YYYY/MM/DD HH24:MI:SS');
  END IF;

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
            VAR_APPLY_LENGTH := VAR_APPLY_LENGTH;

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
  RETURN VAR_APPLY_LENGTH;
  --IF MOD(VAR_APPLY_LENGTH, 8) = 0 THEN
  --RETURN TRUNC(VAR_APPLY_LENGTH);
  -- ELSE
  --RETURN TRUNC(VAR_APPLY_LENGTH) || '天' || MOD(VAR_APPLY_LENGTH, 8) || '小时';
  --END IF;
  RETURN VAR_APPLY_LENGTH;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    VAR_APPLY_LENGTH := 0;
    RETURN VAR_APPLY_LENGTH;
  WHEN OTHERS THEN
    -- CONSIDER LOGGING THE ERROR AND THEN RE-RAISE
    RAISE;
END ATT_GET_LEAVE_LENGTH_T;
/

prompt
prompt Creating function BOM_IS_ITEM_EXTEND
prompt ====================================
prompt
create or replace function BOM_IS_ITEM_EXTEND(IN_MAT_V_ID VARCHAR2,IN_CPNY_ID VARCHAR2) return NUMBER is
  Result NUMBER(1);
begin
  SELECT COUNT(0) INTO Result
  FROM BOM_HEADER_INFO BHI
  WHERE BHI.MAT_V_ID = IN_MAT_V_ID
  AND   BHI.CPNY_ID = IN_CPNY_ID
  AND   BHI.ACTIVITY = 1;
  
  return(Result);
end BOM_IS_ITEM_EXTEND;
/

prompt
prompt Creating function CHECK_CUST_CREDIT
prompt ===================================
prompt
CREATE OR REPLACE FUNCTION CHECK_CUST_CREDIT(VAR_CUST_ID VARCHAR2)
RETURN BOOLEAN
IS
VAR_CREDIT_AMOUNT NUMBER(20,4);
VAR_CREDIT_USED NUMBER(20,4);
BEGIN
  SELECT SUM(ORI.MONEY_TOTAL) INTO VAR_CREDIT_USED FROM ORD_ORDER_INFO ORI WHERE ORI.CUST_ID = VAR_CUST_ID AND ORI.STATUS_CODE = 'OrderState05'AND ORI.ACTIVITY = 1;
  SELECT CBI.CREDIT_AMOUNT INTO VAR_CREDIT_AMOUNT FROM CUST_BASIC_INFO CBI WHERE CBI.CUST_ID = VAR_CUST_ID;
  RETURN NVL(VAR_CREDIT_USED,0)>NVL(VAR_CREDIT_AMOUNT,0);
END;
/

prompt
prompt Creating function CHECK_HR_EXP_TRUN
prompt ===================================
prompt
CREATE OR REPLACE FUNCTION CHECK_HR_EXP_TRUN (V_DATE IN VARCHAR,IN_EMPID IN VARCHAR)
   RETURN NUMBER
IS
   var_count   NUMBER;
   vpamonth   varchar2(20);
   
BEGIN
   BEGIN
      SELECT substr(to_char(to_date(v_date,'yyyy-mm-dd'),'yyyymmdd'),1,6)
        INTO vpamonth
         FROM dual;
     SELECT COUNT(*) INTO   var_count
     FROM HR_EXPERIENCE_INSIDE
      WHERE EMPID = IN_EMPID
        AND START_DATE BETWEEN ar_get_startdate(vpamonth) AND (SELECT max(ddate)
        FROM AR_CALENDER
       WHERE ddate BETWEEN ar_get_startdate(vpamonth) AND ar_get_enddate(vpamonth)
       AND (typeid = 1 OR typeid = 3))
        AND TRANS_CODE IN ('TurnType0010','TurnType0020');

   EXCEPTION
      WHEN OTHERS
      THEN
         var_count := 0;
   END;

   RETURN var_count;

END CHECK_HR_EXP_TRUN;
/

prompt
prompt Creating function CHECK_HR_EXP_TRUN_COUNT
prompt =========================================
prompt
CREATE OR REPLACE FUNCTION CHECK_HR_EXP_TRUN_COUNT (V_DATE IN VARCHAR,IN_EMPID IN VARCHAR)
   RETURN NUMBER
IS
   var_count   NUMBER;
   vpamonth   varchar2(20);
BEGIN
   BEGIN
      SELECT substr(to_char(to_date(v_date,'yyyy-mm-dd'),'yyyymmdd'),1,6)
        INTO vpamonth
         FROM dual;
     SELECT COUNT(*) INTO var_count
      FROM HR_EMP_STATUS_HISTORY WHERE
          EMPID= IN_EMPID
         AND STATUS_CODE IN ('EmpStatus1','EmpStatus2')
         AND DATE_STR IN
     ( SELECT TO_CHAR(ddate,'YYYY-MM-DD')
        FROM AR_CALENDER
       WHERE ddate BETWEEN ar_get_startdate(vpamonth) AND ar_get_enddate(vpamonth)
       AND (typeid = 1 OR typeid = 3));

   EXCEPTION
      WHEN OTHERS
      THEN
         var_count := 0;
   END;

   RETURN var_count;

END CHECK_HR_EXP_TRUN_COUNT;
/

prompt
prompt Creating function CHECK_HR_EXP_TRUN_DATE
prompt ========================================
prompt
CREATE OR REPLACE FUNCTION CHECK_HR_EXP_TRUN_DATE (V_DATE IN VARCHAR,IN_EMPID IN VARCHAR)
   RETURN NUMBER
IS
   var_count   NUMBER;
   vpamonth   varchar2(20);
   v_ddate    varchar2(50) ;

BEGIN
   BEGIN
      SELECT substr(to_char(to_date(v_date,'yyyy-mm-dd'),'yyyymmdd'),1,6)
        INTO vpamonth
         FROM dual;
     SELECT TO_CHAR(MAX(START_DATE),'YYYY-MM-DD') INTO  v_ddate
     FROM HR_EXPERIENCE_INSIDE
      WHERE EMPID = IN_EMPID
        AND START_DATE BETWEEN ar_get_startdate(vpamonth) AND (SELECT max(ddate)
        FROM AR_CALENDER
       WHERE ddate BETWEEN ar_get_startdate(vpamonth) AND ar_get_enddate(vpamonth)
       AND (typeid = 1 OR typeid = 3))
        AND TRANS_CODE IN ('TurnType0010','TurnType0020','TurnType0030');
      IF v_ddate < TO_CHAR(TO_DATE(vpamonth ||'21','YYYY-MM-DD'),'YYYY-MM-DD') THEN
          var_count :=1;
     ELSIF  v_ddate >=  TO_CHAR(TO_DATE(vpamonth ||'21','YYYY-MM-DD'),'YYYY-MM-DD') THEN
         var_count :=2;
     ELSIF  v_ddate IS NULL THEN 
        var_count :=0;
     END IF ;

   EXCEPTION
      WHEN OTHERS
      THEN
         var_count := 0;
   END;

   RETURN var_count;

END CHECK_HR_EXP_TRUN_DATE;
/

prompt
prompt Creating function COUNTIF
prompt =========================
prompt
CREATE OR REPLACE FUNCTION countif (
   v_table_name    VARCHAR2,
   v_column_name   VARCHAR2,
   v_condition     VARCHAR2
)
   RETURN NUMBER
IS
   v_str          VARCHAR2 (10000);
   v_return_num   NUMBER;
BEGIN
   v_str := 'SELECT COUNT(' || v_column_name || ') FROM ' || v_table_name;

   IF TRIM (v_condition) IS NOT NULL
   THEN
      v_str := v_str || ' WHERE ' || v_condition;
   END IF;

   EXECUTE IMMEDIATE v_str
                INTO v_return_num;

   RETURN v_return_num;
END;
/

prompt
prompt Creating function ECM_IS_MAT_EDITABLE
prompt =====================================
prompt
CREATE OR REPLACE FUNCTION ECM_IS_MAT_EDITABLE(   IN_OBJECT_ID      VARCHAR2,
                                                  IN_OBJECT_TYPE_ID VARCHAR2,
                                                  IN_CHANGE_NO      VARCHAR2,
                                                  IN_CPNY_ID        VARCHAR2)
   RETURN BOOLEAN
IS
   V_COUNT NUMBER(1);
BEGIN
   IF IN_CHANGE_NO IS NULL THEN
     RETURN TRUE;
   END IF;
   SELECT COUNT(0) INTO V_COUNT
   FROM ECM_CHANGE_OBJECT_INFO ECOI
   WHERE ECOI.CHANGE_NO = IN_CHANGE_NO
   AND ECOI.OBJECT_ID = IN_OBJECT_ID
   AND ECOI.ACTIVITY = 1
   AND ECOI.CPNY_ID = IN_CPNY_ID;

   IF V_COUNT <>     0 THEN
     RETURN TRUE;
   ELSE
     RETURN FALSE;
   END IF;
END;
/

prompt
prompt Creating function HR_GET_PARENT_DEPTID
prompt ======================================
prompt
CREATE OR REPLACE FUNCTION HR_GET_PARENT_DEPTID(IN_DEPTID IN VARCHAR2)
  RETURN VARCHAR2 IS 
  V_DEPTID   VARCHAR2(20);
BEGIN
  BEGIN
    SELECT T.PARENT_DEPT_ID
      INTO V_DEPTID
      FROM HR_DEPARTMENT T
     WHERE T.DEPTID = IN_DEPTID;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_DEPTID := NULL;
  END;

  RETURN V_DEPTID;
END HR_GET_PARENT_DEPTID;
/

prompt
prompt Creating function ESS_GET_AFFIRMER_BY_POST
prompt ==========================================
prompt
CREATE OR REPLACE FUNCTION ESS_GET_AFFIRMER_BY_POST(IN_EMPID     VARCHAR2,
                                                    IN_POST_CODE VARCHAR2)
  RETURN VARCHAR2 IS
  V_AFFIRMER_EMPID VARCHAR2(20);
  V_TEMP_DEPTID    VARCHAR2(20);

  V_APP_EMP_DEPTID VARCHAR2(20);
BEGIN
  --取得申请者自己的部门ID
  BEGIN
    SELECT HE.DEPTID
      INTO V_APP_EMP_DEPTID
      FROM HR_EMPLOYEE HE, HR_DEPARTMENT HD
     WHERE HE.DEPTID = HD.DEPTID
       AND EMPID = IN_EMPID;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_APP_EMP_DEPTID := '';
    WHEN OTHERS THEN
      -- Consider logging the error and then re-raise
      RAISE;
  END;

  --先取申请者本部门的，相应职务的人
  BEGIN
    SELECT HR.EMPID
      INTO V_AFFIRMER_EMPID
      FROM HR_EMPLOYEE HR
     WHERE HR.DEPTID = V_APP_EMP_DEPTID
       AND HR.POST_ID = IN_POST_CODE
       AND HR.STATUS_CODE <> 'EmpStatus3'
       AND ROWNUM = 1;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_AFFIRMER_EMPID := '';
    WHEN OTHERS THEN
      -- Consider logging the error and then re-raise
      RAISE;
  END;

  --如果沒找到，那麼去申請者上一級部門去找，相應职务的人
  IF V_AFFIRMER_EMPID IS NULL THEN
    V_TEMP_DEPTID := V_APP_EMP_DEPTID;
    WHILE (V_TEMP_DEPTID <> 'wooribank') LOOP
      V_TEMP_DEPTID := HR_GET_PARENT_DEPTID(V_TEMP_DEPTID);
    
      BEGIN
        SELECT HR.EMPID
          INTO V_AFFIRMER_EMPID
          FROM HR_EMPLOYEE HR
         WHERE HR.DEPTID = V_TEMP_DEPTID
           AND HR.POST_ID = IN_POST_CODE
           AND HR.STATUS_CODE <> 'EmpStatus3';
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          V_AFFIRMER_EMPID := '';
        WHEN OTHERS THEN
          -- Consider logging the error and then re-raise
          RAISE;
      END;
    
      IF V_AFFIRMER_EMPID IS NOT NULL THEN
        EXIT;
      END IF;
    
    END LOOP;
  END IF;

  IF V_AFFIRMER_EMPID = IN_EMPID THEN
    V_AFFIRMER_EMPID := '';
  END IF;

  RETURN V_AFFIRMER_EMPID;
END ESS_GET_AFFIRMER_BY_POST;
/

prompt
prompt Creating function ESS_GET_AFFIRM_ITEMS
prompt ======================================
prompt
CREATE OR REPLACE FUNCTION ess_get_affirm_items (
   in_affirmor_id   IN   VARCHAR2,
   in_affirm_type   IN   VARCHAR2
)
   RETURN VARCHAR2
IS
   v_affirm_row   ess_affirm%ROWTYPE;
   out_items      VARCHAR2 (100);

   CURSOR affirm_cur
   IS
      SELECT *
        FROM ess_affirm eo                                 --outer ess affirm
       WHERE affirmor_id = in_affirmor_id
         AND apply_type = in_affirm_type
         AND affirm_flag = 0
         AND NOT EXISTS (
                SELECT *
                  FROM ess_affirm ei                       -- inner ess affirm
                 WHERE ei.apply_no = eo.apply_no
                   AND ei.affirm_level < eo.affirm_level
                   AND ei.affirm_flag = 0);
      -- 根据输入的决裁者编号，和决裁类型，返回所有此决裁者有权限决裁的申请项目的申请号。
BEGIN
   OPEN affirm_cur;

   LOOP
      FETCH affirm_cur
       INTO v_affirm_row;

      EXIT WHEN affirm_cur%NOTFOUND;

      IF (out_items IS NULL)
      THEN
         out_items := v_affirm_row.apply_no;
      ELSIF out_items IS NOT NULL
      THEN
         out_items := out_items || ',' || v_affirm_row.apply_no;
      END IF;
   END LOOP;

   CLOSE affirm_cur;

   RETURN out_items;
END ess_get_affirm_items;
/

prompt
prompt Creating function GET_ARMONTH
prompt =============================
prompt
CREATE OR REPLACE FUNCTION Get_Armonth (v_ddate DATE)
   RETURN VARCHAR2
IS
   v_start_date   NUMBER;
   v_end_date     NUMBER;
   v_date         DATE;
   v_month_str    VARCHAR2 (6);
BEGIN
   BEGIN
      SELECT start_date,end_date
        INTO v_start_date,v_end_date
        FROM AR_STATISTIC_DATE
       WHERE v_ddate BETWEEN valid_date_from AND valid_date_to
         AND start_date <> 1;
   EXCEPTION
      WHEN TOO_MANY_ROWS       -- 如果该日期隶属多个考勤区间，取第一个考勤区间
      THEN
         SELECT start_date,end_date
           INTO v_start_date,v_end_date
           FROM (SELECT   start_date,end_date
                     FROM AR_STATISTIC_DATE
                    WHERE v_ddate BETWEEN valid_date_from AND valid_date_to
                      AND start_date <> 1
                 ORDER BY valid_date_from DESC)
          WHERE ROWNUM = 1;
      WHEN OTHERS               -- 如果该日期没有对应的考勤区间，取该日期隶属的月份
      THEN
         v_month_str := TO_CHAR (v_ddate, 'yyyymm');
         RETURN v_month_str;
   END;

   IF TO_NUMBER (TO_CHAR (v_ddate, 'DD')) >= v_start_date
   THEN
      v_date := ADD_MONTHS (v_ddate, 1);
   ELSE
      v_date := v_ddate;
   END IF;

   v_month_str := TO_CHAR (v_date, 'yyyymm');
   RETURN v_month_str;
END;
/

prompt
prompt Creating function ESS_GET_TURN_HOLIDY
prompt =====================================
prompt
CREATE OR REPLACE FUNCTION Ess_Get_Turn_Holidy(in_ddate DATE,in_emp_id VARCHAR2)
 RETURN NUMBER
IS
   v_month_overtime        NUMBER := 0 ;       -- 上月加班
   v_tiaoxiu               NUMBER := 0 ;       -- 本月调休

   v_return_value          number := 0 ;

   v_ar_month VARCHAR2(6) := Get_Armonth(in_ddate);


BEGIN
     -- 上月累计平日加班小时数和公休日加班小时数
     begin
          SELECT nvl(sum(QUANTITY),0) into v_month_overtime
               FROM AR_DETAIL
              WHERE EMPID = in_emp_id
                AND AR_MONTH_STR = TO_CHAR(ADD_MONTHS(TO_DATE(v_ar_month,'yyyymm'),-1),'yyyymm')
                AND AR_ITEM_NO in (30) ;
         exception when no_data_found
                   then
                       v_month_overtime := 0;
     end ;
  --DBMS_OUTPUT.PUT_LINE ('v_last_month_overtime=' || v_last_month_overtime);

    -- 本月已用调休小时数
    begin
          SELECT nvl(sum(QUANTITY),0) into v_tiaoxiu
               FROM AR_DETAIL
              WHERE EMPID = in_emp_id
                AND AR_MONTH_STR = v_ar_month
                AND AR_ITEM_NO = 38 ;
         exception when no_data_found
                   then
                       v_tiaoxiu := 0;
    end ;
   --DBMS_OUTPUT.PUT_LINE ('v__month_overtime=' || v_month_overtime);


    if v_month_overtime > v_tiaoxiu then
        v_return_value := v_month_overtime - v_tiaoxiu ;
    else
        v_return_value := v_month_overtime ;
    end if ;

    return v_return_value/8 ;

END Ess_Get_Turn_Holidy;
/

prompt
prompt Creating function FN_CHECKIDCARD
prompt ================================
prompt
create or replace function fn_checkidcard(p_id_card in varchar2)
  return varchar2 is
  v_id_card   varchar2(30);
  v_sum       number;
  v_mod       number;
  v_checkcode char(11) := '10X98765432';
  v_checkbit  char(1);
  v_checkbit1 char(1);
  v_areacode  varchar2(2000) := '11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91';
begin

  if p_id_card is null then
    v_id_card := '';
    return v_id_card;
  end if;

  v_id_card := p_id_card;

  --判断位数
  if length(p_id_card) <> 15 and length(p_id_card) <> 18 then
    v_id_card := '';
    --dbms_output.put_line('位数错误！');
    return v_id_card;
  end if;

  --判断地区代码
  if instr(v_areacode, substr(p_id_card, 1, 2)) = 0 then
    v_id_card := '';
    --dbms_output.put_line('地区代码错误!');
    return v_id_card;
  end if;

  --如果是15位
  if length(p_id_card) = 15 then
    --判断第三位－第八位
    for i in 3 .. 8 loop
      if substr(p_id_card, i, 1) not between '0' and '9' then
        v_id_card := '';
        --dbms_output.put_line('第' || i || '位数字错误!');
        return v_id_card;
      end if;
    end loop;

    --判断月份和日期
    if substr(p_id_card, 9, 2) not in ('01',
                                       '02',
                                       '03',
                                       '04',
                                       '05',
                                       '06',
                                       '07',
                                       '08',
                                       '09',
                                       '10',
                                       '11',
                                       '12') then
      v_id_card := '';
      --dbms_output.put_line('月份错误!');
      return v_id_card;
    end if;

    --判断闰月
    if substr(p_id_card, 9, 2) in
       ('01', '03', '05', '07', '08', '10', '12') then
      if substr(p_id_card, 11, 1) not between '0' and '3' then
        v_id_card := '';
        --dbms_output.put_line('闰月日期第一位错误!');
        return v_id_card;
      end if;
      if substr(p_id_card, 12, 1) not between '0' and '9' then
        v_id_card := '';
        --dbms_output.put_line('闰月日期第二位错误!');
        return v_id_card;
      end if;
      if to_number(substr(p_id_card, 11, 2)) not between 1 and 31 then
        v_id_card := '';
        --dbms_output.put_line('闰月日期错误!');
        return v_id_card;
      end if;
    end if;
    --判断非闰月
    if substr(p_id_card, 9, 2) in ('04', '06', '09', '11') then
      if substr(p_id_card, 11, 1) not between '0' and '3' then
        v_id_card := '';
        --dbms_output.put_line('非闰月日期第一位错误!');
        return v_id_card;
      end if;
      if substr(p_id_card, 12, 1) not between '0' and '9' then
        v_id_card := '';
        --dbms_output.put_line('非闰月日期第二位错误!');
        return v_id_card;
      end if;
      if to_number(substr(p_id_card, 11, 2)) not between 1 and 30 then
        v_id_card := '';
        --dbms_output.put_line('非闰月日期错误!');
        return v_id_card;
      end if;
    end if;
    --判断2月
    if substr(p_id_card, 9, 2) = '02' then
      if substr(p_id_card, 11, 1) not between '0' and '2' then
        v_id_card := '';
        --dbms_output.put_line('二月日期第一位错误!');
        return v_id_card;
      end if;
      if substr(p_id_card, 12, 1) not between '0' and '9' then
        v_id_card := '';
        --dbms_output.put_line('二月日期第二位错误!');
        return v_id_card;
      end if;

      if mod(to_number(substr(p_id_card, 7, 2)) + 1900, 400) = 0 or
         (mod(to_number(substr(p_id_card, 7, 2)) + 1900, 100) <> 0 and
          mod(to_number(substr(p_id_card, 7, 2)) + 1900, 4) = 0) then
        -- 闰年
        if to_number(substr(p_id_card, 11, 2)) not between 1 and 29 then
          v_id_card := '';
          --dbms_output.put_line('闰年2月份日期错误!');
          return v_id_card;
        end if;
      else
        if to_number(substr(p_id_card, 11, 2)) not between 1 and 28 then
          v_id_card := '';
          --dbms_output.put_line('非闰年2月份日期错误！');
          return v_id_card;
        end if;
      end if;
    end if;

    --判断13－15位
    for i in 13 .. 15 loop
      if substr(p_id_card, i, 1) not between '0' and '9' then
        v_id_card := '';
        --dbms_output.put_line('第' || i || '位错误!');
        return v_id_card;
      end if;
    end loop;
  end if;

  --如果是18位
  if length(p_id_card) = 18 then
    --判断第二位－第六位
    for i in 3 .. 6 loop
      if substr(p_id_card, i, 1) not between '0' and '9' then
        v_id_card := '';
        --dbms_output.put_line('第' || i || '位数字错误!');
        return v_id_card;
      end if;
    end loop;

    --判断年份
    if substr(p_id_card, 7, 2) not in ('19', '20') then
      v_id_card := '';
      --dbms_output.put_line('年份错误!');
      return v_id_card;
    end if;

    --判断9－10位
    for i in 9 .. 10 loop
      if substr(p_id_card, i, 1) not between '0' and '9' then
        v_id_card := '';
        --dbms_output.put_line('第' || i || '位数字错误!');
        return v_id_card;
      end if;
    end loop;

    --判断月份和日期
    if substr(p_id_card, 11, 2) not in
       ('01',
        '02',
        '03',
        '04',
        '05',
        '06',
        '07',
        '08',
        '09',
        '10',
        '11',
        '12') then
      v_id_card := '';
      --dbms_output.put_line('月份错误!');
      return v_id_card;
    end if;

    --判断闰月
    if substr(p_id_card, 11, 2) in
       ('01', '03', '05', '07', '08', '10', '12') then
      if substr(p_id_card, 13, 1) not between '0' and '3' then
        v_id_card := '';
        --dbms_output.put_line('闰月日期第一位错误!');
        return v_id_card;
      end if;
      if substr(p_id_card, 14, 1) not between '0' and '9' then
        v_id_card := '';
        --dbms_output.put_line('闰月日期第二位错误!');
        return v_id_card;
      end if;
      if to_number(substr(p_id_card, 13, 2)) not between 1 and 31 then
        v_id_card := '';
        --dbms_output.put_line('闰月日期错误!');
        return v_id_card;
      end if;
    end if;
    --判断非闰月
    if substr(p_id_card, 11, 2) in ('04', '06', '09', '11') then
      if substr(p_id_card, 13, 1) not between '0' and '3' then
        v_id_card := '';
        --dbms_output.put_line('非闰月日期第一位错误!');
        return v_id_card;
      end if;
      if substr(p_id_card, 14, 1) not between '0' and '9' then
        v_id_card := '';
        --dbms_output.put_line('非闰月日期第二位错误!');
        return v_id_card;
      end if;
      if to_number(substr(p_id_card, 13, 1)) not between 1 and 30 then
        v_id_card := '';
        --dbms_output.put_line('非闰月日期错误!');
        return v_id_card;
      end if;
    end if;
    --判断2月
    if substr(p_id_card, 11, 2) = '02' then
      if substr(p_id_card, 13, 1) not between '0' and '2' then
        v_id_card := '';
        --dbms_output.put_line('二月日期第一位错误!');
        return v_id_card;
      end if;
      if substr(p_id_card, 14, 1) not between '0' and '9' then
        v_id_card := '';
        --dbms_output.put_line('二月日期第二位错误!');
        return v_id_card;
      end if;

      if mod(to_number(substr(p_id_card, 7, 4)), 400) = 0 or
         (mod(to_number(substr(p_id_card, 7, 4)), 100) <> 0 and
          mod(to_number(substr(p_id_card, 7, 4)), 4) = 0) then
        -- 闰年
        if to_number(substr(p_id_card, 13, 2)) not between 1 and 29 then
          v_id_card := '';
          --dbms_output.put_line('闰年2月份日期错误!');
          return v_id_card;
        end if;
      else
        if to_number(substr(p_id_card, 13, 2)) not between 1 and 28 then
          v_id_card := '';
          --dbms_output.put_line('非闰年2月份日期错误！');
          return v_id_card;
        end if;
      end if;
    end if;

    --判断15－17位
    for i in 15 .. 17 loop
      if substr(p_id_card, i, 1) not between '0' and '9' then
        v_id_card := '';
        --dbms_output.put_line('第' || i || '位错误!');
        return v_id_card;
      end if;
    end loop;

    --判断18位
    if substr(p_id_card, 18, 1) not between '0' and '9' and
       substr(p_id_card, 18, 1) not in ('x', 'X') then
      v_id_card := '';
      --dbms_output.put_line('第十八位错误!');
      return v_id_card;
    end if;

    v_sum      := (to_number(substr(p_id_card, 1, 1)) +
                  to_number(substr(p_id_card, 11, 1))) * 7 +
                  (to_number(substr(p_id_card, 2, 1)) +
                  to_number(substr(p_id_card, 12, 1))) * 9 +
                  (to_number(substr(p_id_card, 3, 1)) +
                  to_number(substr(p_id_card, 13, 1))) * 10 +
                  (to_number(substr(p_id_card, 4, 1)) +
                  to_number(substr(p_id_card, 14, 1))) * 5 +
                  (to_number(substr(p_id_card, 5, 1)) +
                  to_number(substr(p_id_card, 15, 1))) * 8 +
                  (to_number(substr(p_id_card, 6, 1)) +
                  to_number(substr(p_id_card, 16, 1))) * 4 +
                  (to_number(substr(p_id_card, 7, 1)) +
                  to_number(substr(p_id_card, 17, 1))) * 2 +
                  to_number(substr(p_id_card, 8, 1)) * 1 +
                  to_number(substr(p_id_card, 9, 1)) * 6 +
                  to_number(substr(p_id_card, 10, 1)) * 3;
    v_mod      := mod(v_sum, 11);
    v_checkbit := substr(v_checkcode, v_mod + 1, 1);

    if v_checkbit = 'X' then
      v_checkbit1 := 'x';
    else
      v_checkbit1 := v_checkbit;
    end if;

    if v_checkbit <> substr(p_id_card, 18, 1) and
       v_checkbit1 <> substr(p_id_card, 18, 1) then
      v_id_card := '';
      --dbms_output.put_line('校验位错误!');
      return v_id_card;
    end if;
  end if;

  return v_id_card;

EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line(sqlerrm);
    return '1';
END fn_checkidcard;
/

prompt
prompt Creating function FN_SY_INSTORAGE_SERIAL_NUM
prompt ============================================
prompt
CREATE OR REPLACE FUNCTION FN_SY_INSTORAGE_SERIAL_NUM
  RETURN varchar2
IS
  LSHID VARCHAR2(100);
  inPrefix VARCHAR2(10);
  inDateFormat VARCHAR2(20);
  inOrderNumber NUMBER(10);
BEGIN
  select PREFIX,MIDDLE_FIELD,NUM_LENGTH into inPrefix,inDateFormat,inOrderNumber from SY_SERIAL_NUM
    where ORDER_ID = 'INSTORAGE_ID';
  select inPrefix || to_char(sysdate, inDateFormat) || lpad(SY_INSTORAGE_SERIAL_SEQ.NEXTVAL, inOrderNumber, 0) into LSHID from dual;

  RETURN LSHID;
END FN_SY_INSTORAGE_SERIAL_NUM;
/

prompt
prompt Creating function FN_SY_OUTSTORAGE_SERIAL_NUM
prompt =============================================
prompt
CREATE OR REPLACE FUNCTION FN_SY_OUTSTORAGE_SERIAL_NUM
  RETURN varchar2
IS
  LSHID VARCHAR2(100);
  inPrefix VARCHAR2(10);
  inDateFormat VARCHAR2(20);
  inOrderNumber NUMBER(10);
BEGIN
  select PREFIX,MIDDLE_FIELD,NUM_LENGTH into inPrefix,inDateFormat,inOrderNumber from SY_SERIAL_NUM
    where ORDER_ID = 'OUTSTORAGE_ID';
  select inPrefix || to_char(sysdate, inDateFormat) || lpad(SY_OUTSTORAGE_SERIAL_SEQ.NEXTVAL, inOrderNumber, 0) into LSHID from dual;

  RETURN LSHID;
END FN_SY_OUTSTORAGE_SERIAL_NUM;
/

prompt
prompt Creating function FN_SY_PRODUCT_SERIAL_NUM
prompt ==========================================
prompt
CREATE OR REPLACE FUNCTION FN_SY_PRODUCT_SERIAL_NUM
  RETURN varchar2
IS
  LSHID VARCHAR2(100);
  inPrefix VARCHAR2(10);
  inDateFormat VARCHAR2(20);
  inOrderNumber NUMBER(10);
BEGIN
  select PREFIX,MIDDLE_FIELD,NUM_LENGTH into inPrefix,inDateFormat,inOrderNumber from SY_SERIAL_NUM
    where ORDER_ID = 'PRODUCT_ID';
  select inPrefix || to_char(sysdate, inDateFormat) || lpad(SY_PRODUCT_SERIAL_SEQ.NEXTVAL, inOrderNumber, 0) into LSHID from dual;

  RETURN LSHID;
END FN_SY_PRODUCT_SERIAL_NUM;
/

prompt
prompt Creating function FN_SY_PURCHASE_SERIAL_NUM
prompt ===========================================
prompt
CREATE OR REPLACE FUNCTION FN_SY_PURCHASE_SERIAL_NUM
  RETURN varchar2
IS
  LSHID VARCHAR2(100);
  inPrefix VARCHAR2(20);
  inDateFormat VARCHAR2(20);
  inOrderNumber NUMBER(10);
BEGIN
  select PREFIX,MIDDLE_FIELD,NUM_LENGTH into inPrefix,inDateFormat,inOrderNumber from SY_SERIAL_NUM
    where ORDER_ID = 'PURCHASE_ID';
  select inPrefix || to_char(sysdate, inDateFormat) || lpad(SY_PURCHASE_SERIAL_SEQ.NEXTVAL, inOrderNumber, 0) into LSHID from dual;

  RETURN LSHID;
END FN_SY_PURCHASE_SERIAL_NUM;
/

prompt
prompt Creating function FN_SY_SALES_SERIAL_NUM
prompt ========================================
prompt
CREATE OR REPLACE FUNCTION FN_SY_SALES_SERIAL_NUM
  RETURN varchar2
IS
  LSHID VARCHAR2(100);
  inPrefix VARCHAR2(10);
  inDateFormat VARCHAR2(20);
  inOrderNumber NUMBER(10);
BEGIN
  select PREFIX,MIDDLE_FIELD,NUM_LENGTH into inPrefix,inDateFormat,inOrderNumber from SY_SERIAL_NUM
    where ORDER_ID = 'SALES_ID';
  select inPrefix || to_char(sysdate, inDateFormat) || lpad(SY_SALES_SERIAL_SEQ.NEXTVAL, inOrderNumber, 0) into LSHID from dual;

  RETURN LSHID;
END FN_SY_SALES_SERIAL_NUM;
/

prompt
prompt Creating function GET_ACCOUNT_NO
prompt ================================
prompt
CREATE OR REPLACE FUNCTION get_account_no (in_empid IN VARCHAR2)
   RETURN VARCHAR2
IS
   out_deptid   VARCHAR2 (400);
BEGIN
   BEGIN
      SELECT card_no
        INTO out_deptid
        FROM hr_emp_pa_info
       WHERE empid = in_empid;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         out_deptid := 'have not found this department!';
   END;

   RETURN out_deptid;
END get_account_no;
/

prompt
prompt Creating function GET_AR_BDAYS
prompt ==============================
prompt
CREATE OR REPLACE FUNCTION get_ar_bdays (V_DATE IN VARCHAR)
   RETURN NUMBER
IS
   var_days   NUMBER;
   vpamonth   varchar2(20);
BEGIN
   BEGIN
       SELECT substr(to_char(to_date(v_date,'yyyy-mm-dd'),'yyyymmdd'),1,6)
        INTO vpamonth
         FROM dual;

        SELECT COUNT(*) INTO var_days
        FROM AR_CALENDER
       WHERE ddate BETWEEN ar_get_startdate(vpamonth) AND to_DATE(V_DATE,'YYYY-MM-DD')
      -- AND typeid = 1;
      AND (typeid = 1 OR typeid = 3);
   EXCEPTION
      WHEN OTHERS
      THEN
         var_days := 0;
   END;

   RETURN var_days;

END get_ar_bdays;
/

prompt
prompt Creating function GET_AR_BDAYS_LESS
prompt ===================================
prompt
CREATE OR REPLACE FUNCTION get_ar_bdays_LESS (V_DATE IN VARCHAR)
   RETURN NUMBER
IS
   var_days   NUMBER;
   vpamonth   varchar2(20);
   VAR_MAXDDATE DATE;
BEGIN
   BEGIN
       SELECT substr(to_char(to_date(v_date,'yyyy-mm-dd'),'yyyymmdd'),1,6)
        INTO vpamonth
         FROM dual;

        SELECT MAX(DDATE) INTO VAR_MAXDDATE
        FROM AR_CALENDER
       WHERE ddate BETWEEN ar_get_startdate(vpamonth) AND ar_get_enddate(vpamonth)
      -- AND typeid = 1;
      AND (typeid = 1 OR typeid = 3);


   EXCEPTION
      WHEN OTHERS
      THEN
         var_days := 0;
   END;
   IF V_DATE = TO_CHAR(VAR_MAXDDATE,'YYYY-MM-DD') THEN
       var_days :=1;
   ELSE
      var_days :=0;
   END IF;
   RETURN var_days;

END get_ar_bdays_LESS;
/

prompt
prompt Creating function GET_AR_DAY1A3
prompt ===============================
prompt
CREATE OR REPLACE FUNCTION get_ar_day1a3 (V_DATE IN VARCHAR)
   RETURN NUMBER
IS
   var_days   NUMBER;
   vpamonth   varchar2(20);
BEGIN
   BEGIN
       SELECT substr(to_char(to_date(v_date,'yyyy-mm-dd'),'yyyymmdd'),1,6)
        INTO vpamonth
         FROM dual;
         SELECT COUNT(*) INTO var_days
        FROM AR_CALENDER
       WHERE ddate BETWEEN ar_get_startdate(vpamonth) AND ar_get_enddate(vpamonth)
       AND (typeid = 1 OR typeid = 3);
   EXCEPTION
      WHEN OTHERS
      THEN
         var_days := 0;
   END;

   RETURN var_days;

END get_ar_day1a3;
/

prompt
prompt Creating function GET_AR_DAY2A3
prompt ===============================
prompt
CREATE OR REPLACE FUNCTION get_ar_day2a3 (vpamonth IN VARCHAR)
   RETURN NUMBER
IS
   var_days   NUMBER;
BEGIN
   BEGIN
         SELECT COUNT(*) INTO var_days
        FROM AR_CALENDER
       WHERE ddate BETWEEN ar_get_startdate(vpamonth) AND ar_get_enddate(vpamonth)
       AND (overtypeid = 2 AND typeid = 3);
   EXCEPTION
      WHEN OTHERS
      THEN
         var_days := 0;
   END;

   RETURN var_days;

END get_ar_day2a3;
/

prompt
prompt Creating function GET_AR_LDAYS
prompt ==============================
prompt
CREATE OR REPLACE FUNCTION get_ar_ldays (v_date IN VARCHAR)
   RETURN NUMBER
IS
   var_days   NUMBER;
   vpamonth   varchar2(20);
BEGIN
   BEGIN
       SELECT substr(to_char(to_date(v_date,'yyyy-mm-dd'),'yyyymmdd'),1,6)
        INTO vpamonth
         FROM dual;

        SELECT COUNT(*)-21 INTO var_days
        FROM AR_CALENDER
       WHERE ddate BETWEEN ar_get_startdate(vpamonth) AND ar_get_enddate(vpamonth)
       AND (typeid = 1 OR typeid = 3);
   EXCEPTION
      WHEN OTHERS
      THEN
         var_days := 0;
   END;

   RETURN var_days;

END get_ar_ldays;
/

prompt
prompt Creating function GET_AR_MONTH_DAYS
prompt ===================================
prompt
CREATE OR REPLACE FUNCTION GET_AR_MONTH_DAYS (monthstr VARCHAR2)
   RETURN NUMBER
IS
   result   NUMBER;
BEGIN
      SELECT COUNT(*)
        INTO result
        FROM AR_CALENDER
       WHERE DDATE BETWEEN Ar_Get_Startdate(monthstr) AND Ar_Get_Enddate(monthstr);

   RETURN result;
END GET_AR_MONTH_DAYS;
/

prompt
prompt Creating function GET_AR_MONTH_NIGHTDAYS
prompt ========================================
prompt
CREATE OR REPLACE FUNCTION GET_AR_MONTH_NIGHTDAYS (monthstr VARCHAR2,empid VARCHAR2)
   RETURN NUMBER
IS
   RESULT_DAYS   NUMBER;
BEGIN
      SELECT COUNT(*)
        INTO     RESULT_DAYS
        FROM     AR_SCHEDULE
        WHERE    EMPID=empid
        AND      SHIFT_NO = 20
        AND      TO_CHAR(TO_DATE(AR_DATE_STR,'YYYY/MM/DD'),'YYYYMM') = monthstr;

   RETURN RESULT_DAYS*8*60;
END GET_AR_MONTH_NIGHTDAYS;
/

prompt
prompt Creating function GET_AR_MONTH_SCHEDULED_DAYS
prompt =============================================
prompt
CREATE OR REPLACE FUNCTION GET_AR_MONTH_SCHEDULED_DAYS (monthstr VARCHAR2)
   RETURN NUMBER
IS
   result   NUMBER;
BEGIN
      SELECT COUNT(*)
        INTO result
        FROM AR_CALENDER
       WHERE DDATE BETWEEN Ar_Get_Startdate(monthstr) AND Ar_Get_Enddate(monthstr)
           AND TYPEID IN (1,3);

   RETURN result;
END GET_AR_MONTH_SCHEDULED_DAYS;
/

prompt
prompt Creating function GET_AR_MONTH_WEEKENDS
prompt =======================================
prompt
CREATE OR REPLACE FUNCTION GET_AR_MONTH_WEEKENDS (monthstr VARCHAR2)
   RETURN NUMBER
IS
   result   NUMBER;
BEGIN
      SELECT COUNT(*)
        INTO result
        FROM AR_CALENDER
       WHERE IWEEK = 0
       AND DDATE BETWEEN Ar_Get_Startdate(monthstr) AND Ar_Get_Enddate(monthstr);

   RETURN result*8*60;
END GET_AR_MONTH_WEEKENDS;
/

prompt
prompt Creating function GET_BASE_ITEM_NAME
prompt ====================================
prompt
CREATE OR REPLACE FUNCTION get_base_item_name (v_code_id IN VARCHAR2)
   RETURN VARCHAR2
IS
   v_name   VARCHAR2 (50);
BEGIN
   BEGIN
      SELECT t.item_name
        INTO v_name
        FROM pa_basic_item t
       WHERE t.item_no = v_code_id;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_name := '';
      WHEN OTHERS
      THEN
         RAISE;
   END;

   RETURN v_name;
END get_base_item_name;
/

prompt
prompt Creating function GET_BASIC_SALARY
prompt ==================================
prompt
CREATE OR REPLACE FUNCTION GET_BASIC_SALARY(IN_EMPID       VARCHAR2,
                                          IN_PAMONTH VARCHAR2)
  RETURN NUMBER IS
  VAR_POST_ID VARCHAR2(20);
  VAR_POST_LEVEL_ID VARCHAR2(20);
  VAR_BASIC_SALARY NUMBER(10,2);
BEGIN
  /*获取员工当月最后一天职位ID与职位等级ID*/
  BEGIN
      SELECT
            POST_ID,POST_LEVEL_ID INTO VAR_POST_ID,VAR_POST_LEVEL_ID
      FROM HR_POST_RECORDS
      WHERE NO=( /*取职位开始日期小于等于当前计算月数据的最新一条，即最近职位记录的编号*/
            SELECT MAX(HPR.NO)
            FROM HR_POST_RECORDS HPR
            WHERE HPR.EMPID = IN_EMPID
            AND TO_DATE(TO_CHAR(HPR.START_DATE,'YYYYMM'),'YYYYMM') <= TO_DATE(IN_PAMONTH,'YYYYMM')
      );
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      VAR_POST_ID := NULL;
      VAR_POST_LEVEL_ID := NULL;
  END;

  BEGIN
      SELECT
            HPI.BASIC_SALARY INTO VAR_BASIC_SALARY
      FROM HR_POST_ID_LEVEL HPI
      WHERE HPI.POST_ID = VAR_POST_ID
      AND   HPI.POST_GRADE_ID = VAR_POST_LEVEL_ID;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      VAR_BASIC_SALARY := 0;
  END;
  RETURN VAR_BASIC_SALARY;
END GET_BASIC_SALARY;
/

prompt
prompt Creating function GET_CODE_EN_NAME
prompt ==================================
prompt
CREATE OR REPLACE FUNCTION get_code_en_name (v_code_id IN VARCHAR2)
   RETURN VARCHAR2
IS
   v_en_name   VARCHAR2 (50);
BEGIN
   BEGIN
      SELECT code_en_name
        INTO v_en_name
        FROM sy_code
       WHERE code_id = v_code_id;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_en_name := '';
      WHEN OTHERS
      THEN
         RAISE;
   END;

   RETURN v_en_name;
END get_code_en_name;
/

prompt
prompt Creating function GET_CODE_ID
prompt =============================
prompt
CREATE OR REPLACE FUNCTION Get_Code_Id (
   vcode           IN   VARCHAR2,
   v_parent_code        VARCHAR2
)
   RETURN VARCHAR2
IS
   v_code_id   VARCHAR2 (50);
BEGIN
   SELECT code_id
     INTO v_code_id
     FROM SY_CODE
    WHERE code_name = vcode AND v_parent_code = parent_code;

   RETURN v_code_id;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      v_code_id := '';
      RETURN v_code_id;
   WHEN OTHERS
   THEN
      v_code_id := '';
      RETURN v_code_id;
END Get_Code_Id;
/

prompt
prompt Creating function GET_CODE_NAME
prompt ===============================
prompt
CREATE OR REPLACE FUNCTION get_code_name (v_code_id IN VARCHAR2)
   RETURN VARCHAR2
IS
   v_name   VARCHAR2 (50);
BEGIN
   BEGIN
      SELECT code_name
        INTO v_name
        FROM sy_code
       WHERE code_id = v_code_id;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_name := '';
      WHEN OTHERS
      THEN
         RAISE;
   END;

   RETURN v_name;
END get_code_name;
/

prompt
prompt Creating function GET_CUST_MONTH_TOTAL
prompt ======================================
prompt
CREATE OR REPLACE FUNCTION GET_CUST_MONTH_TOTAL (in_cust_no VARCHAR2,
                                                 in_month VARCHAR2,
                                                 in_year  VARCHAR2 )
   RETURN NUMBER
IS
   var_sum  NUMBER := 0;
BEGIN
  SELECT NVL(TEMP.TOTAL_PRICE,0) INTO var_sum
  FROM (
    SELECT PSO.CUST_NO,
           TO_CHAR(PSO.ORDER_DATE, 'MON','NLS_DATE_LANGUAGE=AMERICAN') AS SALE_MONTH,
           NVL(SUM(PSO.DISCOUNT_PRICE),0) TOTAL_PRICE
    FROM PROSTOR_SALES_ORDER PSO
    WHERE PSO.ACTIVITY = 1
    AND PSO.AFFIRM_FLAG = 'affirm1'
    AND TO_CHAR(PSO.ORDER_DATE, 'YYYY') = in_year
    GROUP BY PSO.CUST_NO,TO_CHAR(PSO.ORDER_DATE, 'MON','NLS_DATE_LANGUAGE=AMERICAN')
) TEMP
  WHERE TEMP.CUST_NO = in_cust_no
  AND   TEMP.SALE_MONTH = in_month;

  RETURN var_sum;
EXCEPTION
  WHEN OTHERS THEN
     RETURN 0;

END GET_CUST_MONTH_TOTAL;
/

prompt
prompt Creating function GET_CUST_YEAR_TOTAL
prompt =====================================
prompt
CREATE OR REPLACE FUNCTION GET_CUST_YEAR_TOTAL (in_cust_no VARCHAR2,
                                                 in_year  INT )
   RETURN NUMBER
IS
   var_sum  NUMBER := 0;
BEGIN
  SELECT NVL(TEMP.TOTAL_PRICE,0) INTO var_sum
  FROM (
    SELECT PSO.CUST_NO,
           TO_CHAR(PSO.ORDER_DATE, 'YYYY') AS SALE_YEAR,
           NVL(SUM(PSO.DISCOUNT_PRICE),0) TOTAL_PRICE
    FROM PROSTOR_SALES_ORDER PSO
    WHERE PSO.ACTIVITY = 1
    AND PSO.AFFIRM_FLAG = 'affirm1'
    AND TO_CHAR(PSO.ORDER_DATE, 'YYYY') = in_year
    GROUP BY PSO.CUST_NO,TO_CHAR(PSO.ORDER_DATE, 'YYYY')
) TEMP
  WHERE TEMP.CUST_NO = in_cust_no
  AND   TEMP.SALE_YEAR = to_char(in_year);

  RETURN var_sum;
EXCEPTION
  WHEN OTHERS THEN
     RETURN 0;

END GET_CUST_YEAR_TOTAL;
/

prompt
prompt Creating function GET_DAILY_STATUS
prompt ==================================
prompt
CREATE OR REPLACE FUNCTION get_daily_status (monthstr VARCHAR2)
   RETURN NUMBER
IS
   status         NUMBER;
   ar_month_str   VARCHAR2 (6);
BEGIN
   BEGIN
      SELECT Get_Armonth (TO_DATE (monthstr, 'YYYY-MM-DD'))
        INTO ar_month_str
        FROM DUAL;
   EXCEPTION
      WHEN OTHERS
      THEN
         ar_month_str := TO_CHAR (TO_DATE (monthstr, 'YYYY-MM-DD'), 'YYYYMM');
   END;

   BEGIN
      SELECT MONTHLY_LOCK_FLAG
        INTO status
        FROM PA_PROGRESS
       WHERE MONTH_STR = ar_month_str;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         status := 0;
      WHEN OTHERS
      THEN
         status := 0;
   END;

   RETURN status;
END get_daily_status;
/

prompt
prompt Creating function HR_GET_FULL_DEPTNAME
prompt ======================================
prompt
CREATE OR REPLACE FUNCTION hr_get_full_deptname (v_deptid IN VARCHAR2)
   RETURN Varchar2
Is 
  v_deptname Varchar2(40);   

Begin 
  Begin
  Select deptname 
    Into v_deptname
    From hr_department
    Where deptid=v_deptid;
    
    Exception 
    When no_data_found
    Then 
        v_deptname :=Null;
        End;
        
        Return v_deptname;
End hr_get_full_deptname;
    



/*
CREATE OR REPLACE FUNCTION hr_get_full_deptname (v_deptid IN VARCHAR2)
   RETURN VARCHAR2
IS
   v_full_deptname   VARCHAR2 (100);
   v_parent          hr_department%ROWTYPE;
   v_deptname        hr_department.deptname%TYPE;
   v_deptcode        hr_department.deptid%TYPE;
   in_deptid        hr_department.deptid%TYPE;
BEGIN
  in_deptid :=hr_get_level_deptid(v_deptid,3);
   BEGIN
      SELECT deptname
        INTO v_deptname
        FROM hr_department
       WHERE deptid = in_deptid;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_deptname := NULL;
   END;

   v_full_deptname := v_deptname;

   BEGIN
      SELECT *
        INTO v_parent
        FROM hr_department
       WHERE deptid = (SELECT parent_dept_id
                         FROM hr_department
                        WHERE deptid = in_deptid);
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_parent := NULL;
   END;

   IF v_parent.dept_level <>0
   THEN
      v_full_deptname :=
            hr_get_full_deptname (v_parent.deptid) || '   '
            || v_full_deptname;
   ELSE
      v_full_deptname := v_full_deptname;
   END IF;

   RETURN v_full_deptname;
END hr_get_full_deptname;
*/
/

prompt
prompt Creating function GET_DEPTNAME_BY_EMPID
prompt =======================================
prompt
CREATE OR REPLACE FUNCTION get_deptname_by_empid (in_empid IN VARCHAR2)
   RETURN VARCHAR2
IS
   v_deptname   VARCHAR2 (200) := '';
   v_deptid     VARCHAR2 (40);
BEGIN
   BEGIN
      SELECT deptid
        INTO v_deptid
        FROM hr_employee
       WHERE empid = in_empid;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_deptid := NULL;
   END;

   IF v_deptid IS NOT NULL
   THEN
      v_deptname := hr_get_full_deptname (v_deptid);
   END IF;

   RETURN v_deptname;
END get_deptname_by_empid;
/

prompt
prompt Creating function GET_DEPT_ID
prompt =============================
prompt
CREATE OR REPLACE FUNCTION get_dept_id (in_empid IN VARCHAR2)
   RETURN VARCHAR2
IS
   out_deptid   VARCHAR2 (400);
BEGIN
   BEGIN
      SELECT deptid
        INTO out_deptid
        FROM hr_employee
       WHERE empid = in_empid;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         out_deptid := 'have not found this department!';
   END;

   RETURN out_deptid;
END get_dept_id;
/

prompt
prompt Creating function GET_DEPT_ID_BY_NAME
prompt =====================================
prompt
CREATE OR REPLACE FUNCTION Get_Dept_Id_By_Name (in_deptname IN VARCHAR2)
   RETURN VARCHAR2
IS
   out_department   VARCHAR2 (40);
BEGIN
   BEGIN
      SELECT deptid
        INTO out_department
        FROM HR_DEPARTMENT
       WHERE deptname = in_deptname;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
	     
         out_department := null;
   END;

   RETURN out_department;
END Get_Dept_Id_By_Name;
/

prompt
prompt Creating function GET_DEPT_NAME
prompt ===============================
prompt
CREATE OR REPLACE FUNCTION GET_DEPT_NAME(IN_DEPTID IN VARCHAR2)
  RETURN VARCHAR2 IS
  OUT_DEPARTMENT VARCHAR2(80);
BEGIN
  BEGIN
    SELECT DEPTNAME
      INTO OUT_DEPARTMENT
      FROM HR_DEPARTMENT
     WHERE DEPTID = IN_DEPTID;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      OUT_DEPARTMENT := 'have not found this department!';
  END;

  RETURN OUT_DEPARTMENT;
END GET_DEPT_NAME;
/

prompt
prompt Creating function GET_DEPT_NAME1
prompt ================================
prompt
CREATE OR REPLACE FUNCTION GET_DEPT_NAME1(IN_EMPID   VARCHAR2,
                                          IN_TRANSNO VARCHAR2)
  RETURN VARCHAR2 AS
  --   v_deptname Varchar2(40);
  V_DEPTNAME VARCHAR2(40);
  V_DEPTID   VARCHAR2(40);
  V_LEVEL    NUMBER;
BEGIN
  SELECT HR.DEPTNAME, HR.DEPT_LEVEL, HR.DEPTID
    INTO V_DEPTNAME, V_LEVEL, V_DEPTID
    FROM (SELECT DEPTID
            FROM HR_EXPERIENCE_INSIDE A
           WHERE A.START_DATE <
                 (SELECT MAX(START_DATE)
                    FROM HR_EXPERIENCE_INSIDE B
                   WHERE EMPID = IN_EMPID
                     AND B.DEPTID <> A.DEPTID
                     AND TRANS_NO = IN_TRANSNO)
             AND EMPID = IN_EMPID
           ORDER BY A.START_DATE DESC) AA,
         HR_DEPARTMENT HR
   WHERE AA. DEPTID = HR.DEPTID
     AND ROWNUM = 1;
  BEGIN
    IF V_LEVEL > 4 THEN
      SELECT DEPTNAME
        INTO V_DEPTNAME
        FROM HR_DEPARTMENT
       WHERE DEPTID = (SELECT PARENT_DEPT_ID
                         FROM HR_DEPARTMENT
                        WHERE DEPTID = V_DEPTID);
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_DEPTNAME := NULL;
  END;
  RETURN V_DEPTNAME;
END GET_DEPT_NAME1;
/

prompt
prompt Creating function GET_EMP_EN_NAME
prompt =================================
prompt
CREATE OR REPLACE FUNCTION get_emp_en_name (vempid IN VARCHAR2)
   RETURN VARCHAR2
IS
   venname   VARCHAR2 (50);
BEGIN
   SELECT chinese_pinyin
     INTO venname
     FROM hr_employee
    WHERE vempid = empid;

   RETURN venname;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      venname := '';
      RETURN venname;
END get_emp_en_name;
/

prompt
prompt Creating function GET_EMP_ID
prompt ============================
prompt
CREATE OR REPLACE FUNCTION GET_EMP_ID(VEMPNAME IN VARCHAR2) RETURN VARCHAR2 IS
  VNAME VARCHAR2(50);
BEGIN
  SELECT EMPID
    INTO VNAME
    FROM HR_EMPLOYEE
   WHERE VEMPNAME = HR_EMPLOYEE.CHINESENAME;

  RETURN VNAME;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    VNAME := '';
    RETURN VNAME;
END GET_EMP_ID;
/

prompt
prompt Creating function GET_EMP_NAME
prompt ==============================
prompt
CREATE OR REPLACE FUNCTION get_emp_name (vempid IN VARCHAR2)
   RETURN VARCHAR2
IS
   vname   VARCHAR2 (50);
BEGIN
   SELECT chinesename
     INTO vname
     FROM hr_employee
    WHERE vempid = empid;

   RETURN vname;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      vname := '';
      RETURN vname;
END get_emp_name;
/

prompt
prompt Creating function GET_EMP_TYPE_NAME
prompt ===================================
prompt
CREATE OR REPLACE FUNCTION get_emp_type_name (vempid IN VARCHAR2)
   RETURN VARCHAR2
IS
   vname   VARCHAR2 (50);
BEGIN
   SELECT get_code_name(hr_employee.emp_type_code)
     INTO vname
     FROM hr_employee
    WHERE vempid = empid;

   RETURN vname;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      vname := '';
      RETURN vname;
END get_emp_type_name;
/

prompt
prompt Creating function GET_EVJ_EMP_DEPT_ID
prompt =====================================
prompt
CREATE OR REPLACE FUNCTION get_evj_emp_dept_id (
   ev_emp_id_i      VARCHAR2,
   ev_period_id_i   VARCHAR2
)
   RETURN VARCHAR2
IS
   ev_dept_id_o   evj_emp.ev_dept_id%TYPE;
BEGIN
   BEGIN
      SELECT ev_dept_id
        INTO ev_dept_id_o
        FROM evj_emp
       WHERE ev_period_id = ev_period_id_i AND ev_emp_id = ev_emp_id_i;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ev_dept_id_o := '';
      WHEN OTHERS
      THEN
         ev_dept_id_o := '';
   END;

   RETURN ev_dept_id_o;
END get_evj_emp_dept_id;
/

prompt
prompt Creating function GET_EVJ_EMP_DEPT_NAME
prompt =======================================
prompt
CREATE OR REPLACE FUNCTION get_evj_emp_dept_name (
   ev_emp_id_i      VARCHAR2,
   ev_period_id_i   VARCHAR2
)
   RETURN VARCHAR2
IS
   ev_dept_name_o   evj_emp.ev_dept_name%TYPE;
BEGIN
   BEGIN
      SELECT ev_dept_name
        INTO ev_dept_name_o
        FROM evj_emp
       WHERE ev_period_id = ev_period_id_i AND ev_emp_id = ev_emp_id_i;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ev_dept_name_o := '';
      WHEN OTHERS
      THEN
         ev_dept_name_o := '';
   END;

   RETURN ev_dept_name_o;
END get_evj_emp_dept_name;
/

prompt
prompt Creating function GET_EVJ_EMP_NAME
prompt ==================================
prompt
CREATE OR REPLACE FUNCTION get_evj_emp_name (
   ev_emp_id_i      VARCHAR2,
   ev_period_id_i   VARCHAR2
)
   RETURN VARCHAR2
IS
   ev_emp_name_o   evj_emp.ev_emp_name%TYPE;
BEGIN
   BEGIN
      SELECT ev_emp_name
        INTO ev_emp_name_o
        FROM evj_emp
       WHERE ev_period_id = ev_period_id_i AND ev_emp_id = ev_emp_id_i;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ev_emp_name_o := '';
      WHEN OTHERS
      THEN
         ev_emp_name_o := '';
   END;

   RETURN ev_emp_name_o;
END get_evj_emp_name;
/

prompt
prompt Creating function GET_EVJ_EMP_OPERATABLE
prompt ========================================
prompt
CREATE OR REPLACE FUNCTION get_evj_emp_operatable (
   ev_emp_id_i      VARCHAR2,
   ev_period_id_i   VARCHAR2,
   ev_type_id_i     VARCHAR2,
   ev_master_id_i   VARCHAR2
)
   RETURN NUMBER
IS
   operatable_o       NUMBER;
   ev_type_id_p       evj_emp.ev_type_id%TYPE;
   ev_process_id_p    evj_emp.ev_process_id%TYPE;
   ev_emp_id_temp_p   evj_master.ev_emp_id%TYPE;
   temp_p             VARCHAR2 (10);
BEGIN
   operatable_o := 1;

   /******  取得员工评价类型*******/
   IF ev_type_id_i IS NULL
   THEN
      BEGIN
         SELECT ev_type_id
           INTO ev_type_id_p
           FROM evj_emp
          WHERE ev_emp_id = ev_emp_id_i AND ev_period_id = ev_period_id_i;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            ev_type_id_p := NULL;
         WHEN OTHERS
         THEN
            ev_type_id_p := NULL;
      END;
   ELSE
      ev_type_id_p := ev_type_id_i;
   END IF;

   /***员工当前流程****/
   BEGIN
      SELECT ev_process_id
        INTO ev_process_id_p
        FROM evj_emp
       WHERE ev_emp_id = ev_emp_id_i
         AND ev_period_id = ev_period_id_i
         AND ev_type_id = ev_type_id_p;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ev_process_id_p := NULL;
      WHEN OTHERS
      THEN
         ev_process_id_p := NULL;
   END;

   /***评价者是否可以对员工当前流程的操作权限***/
   BEGIN
      SELECT DISTINCT ev_emp_id
                 INTO ev_emp_id_temp_p
                 FROM evj_master
                WHERE ev_period_id = ev_period_id_i
                  AND ev_emp_id = ev_emp_id_i
                  AND ev_master = ev_master_id_i
                  AND ev_process_id = ev_process_id_p;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         operatable_o := 0;
         RETURN operatable_o;
      WHEN OTHERS
      THEN
         operatable_o := 0;
         RETURN operatable_o;
   END;

   /*
   操作期间是否在评价设置的时间区间内
   */
   BEGIN
      IF operatable_o = 1
      THEN
         BEGIN
            SELECT dummy
              INTO temp_p
              FROM DUAL
             WHERE SYSDATE BETWEEN (SELECT ev_process_sdate
                                      FROM evj_type_process
                                     WHERE ev_period_id = ev_period_id_i
                                       AND ev_type_id = ev_type_id_p
                                       AND ev_process_id = ev_process_id_p)
                               AND (SELECT ev_process_edate
                                      FROM evj_type_process
                                     WHERE ev_period_id = ev_period_id_i
                                       AND ev_type_id = ev_type_id_p
                                       AND ev_process_id = ev_process_id_p);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               operatable_o := 0;
               RETURN operatable_o;
            WHEN OTHERS
            THEN
               operatable_o := 0;
               RETURN operatable_o;
         END;
      END IF;
   END;

   RETURN operatable_o;
END get_evj_emp_operatable;
/

prompt
prompt Creating function GET_EVJ_EMP_SEASON_GRADE
prompt ==========================================
prompt
CREATE OR REPLACE FUNCTION get_evj_emp_season_grade (
   ev_emp_id_i      VARCHAR2,
   ev_period_id_i   VARCHAR2
)
   RETURN VARCHAR2
IS
   ev_emp_grade_id_o      evj_emp.ev_grade_id%TYPE;
   ev_sumup_period_id_f   evj_period.ev_period_id%TYPE;
BEGIN
   BEGIN
      SELECT ev_period_id
        INTO ev_sumup_period_id_f
        FROM evj_period
       WHERE ev_year = (SELECT ev_year
                          FROM evj_period
                         WHERE ev_period_id = ev_period_id_i AND ROWNUM = 1)
         AND ev_parent_period_id =
                         (SELECT ev_parent_period_id
                            FROM evj_period
                           WHERE ev_period_id = ev_period_id_i AND ROWNUM = 1)
         AND ev_parent_period_flag = 1;
   EXCEPTION
      WHEN OTHERS
      THEN
         ev_sumup_period_id_f := NULL;
   END;

   IF ev_sumup_period_id_f IS NOT NULL
   THEN
      BEGIN
         SELECT ev_grade_id
           INTO ev_emp_grade_id_o
           FROM evj_emp
          WHERE ev_period_id = ev_sumup_period_id_f
                AND ev_emp_id = ev_emp_id_i;
      EXCEPTION
         WHEN OTHERS
         THEN
            ev_emp_grade_id_o := '';
      END;

      IF ev_emp_grade_id_o IS NULL
      THEN
         ev_emp_grade_id_o := '';
      END IF;
   END IF;

   RETURN ev_emp_grade_id_o;
END get_evj_emp_season_grade;
/

prompt
prompt Creating function GET_EVJ_EMP_SEASON_MARK
prompt =========================================
prompt
CREATE OR REPLACE FUNCTION get_evj_emp_season_mark (
   ev_emp_id_i      VARCHAR2,
   ev_period_id_i   VARCHAR2
)
   RETURN NUMBER
IS
   ev_mark_o               NUMBER;
   ev_season_mark_p        NUMBER;
   ev_append_mark_p        NUMBER;
   ev_year_p               evj_period.ev_year%TYPE;
   ev_parent_period_id_p   evj_period.ev_parent_period_id%TYPE;
   ev_type_id_p            evj_emp.ev_type_id%TYPE;
BEGIN
   ev_mark_o := 0;
   ev_season_mark_p := 0;
   ev_append_mark_p := 0;

   BEGIN
      SELECT ev_year
        INTO ev_year_p
        FROM evj_period
       WHERE ev_period_id = ev_period_id_i;

      SELECT ev_parent_period_id
        INTO ev_parent_period_id_p
        FROM evj_period
       WHERE ev_period_id = ev_period_id_i;

      SELECT ev_type_id
        INTO ev_type_id_p
        FROM evj_emp
       WHERE ev_emp_id = ev_emp_id_i AND ev_period_id = ev_period_id_i;
   EXCEPTION
      WHEN OTHERS
      THEN
         ev_year_p := NULL;
         ev_parent_period_id_p := NULL;
         ev_type_id_p := NULL;
   END;

   BEGIN
      IF ev_year_p IS NOT NULL AND ev_parent_period_id_p IS NOT NULL
      THEN
         BEGIN
            --根据员工的当前年份及季度对所有流程所有项目进行合计
            SELECT SUM (ev_season_process_item_mark)
              INTO ev_season_mark_p
              FROM (
--根据员工的当前年份及季度对各项目各流程进行分数平均
---------------------------开始------------------------------------
                    SELECT   ev_emp_id, ev_process_id, ev_item_id,
                             ROUND
                                (AVG (ev_marks),
                                 2
                                ) AS ev_season_process_item_mark
                        FROM (
--把员工各流程与项目分数进行项目与流程百分比进行计算，取得实际得分
-------------------------开始------------------------------------
                              SELECT evj_period.ev_year,
                                     evj_period.ev_parent_period_id,
                                     evj_emp.ev_type_id,
                                     evj_master.ev_period_id,
                                     evj_relation.ev_item_prop,
                                     evj_relation.ev_process_prop,
                                     evj_period.ev_parent_period_flag,
                                     evj_master.ev_emp_id,
                                     evj_master.ev_process_id,
                                     evj_master.ev_item_id,
                                     evj_master.ev_mark,
                                       evj_master.ev_mark
                                     * evj_relation.ev_item_prop
                                     * evj_relation.ev_process_prop
                                                                  AS ev_marks,
                                     evj_master.ev_submitted
                                FROM evj_master INNER JOIN evj_emp ON evj_emp.ev_period_id =
                                                                        evj_master.ev_period_id
                                                                 AND evj_emp.ev_emp_id =
                                                                        evj_master.ev_emp_id
                                     INNER JOIN evj_period ON evj_period.ev_period_id =
                                                                evj_master.ev_period_id
                                     INNER JOIN evj_relation ON evj_relation.ev_period_id =
                                                                  evj_master.ev_period_id
                                                           AND evj_relation.ev_type_id =
                                                                  evj_emp.ev_type_id
                                                           AND evj_relation.ev_process_id =
                                                                  evj_master.ev_process_id
                                                           AND evj_relation.ev_item_id =
                                                                  evj_master.ev_item_id
                               --只记入当前员工当前年与当前季度下的数据
                              WHERE  EXISTS (
                                        SELECT evj_period.ev_period_id
                                          FROM evj_period
                                         WHERE evj_period.ev_year = ev_year_p
                                           AND evj_period.ev_parent_period_id =
                                                         ev_parent_period_id_p
                                           AND evj_period.ev_period_id =
                                                       evj_master.ev_period_id)
                                  --总结期间标识
                                 -- AND EVJ_PERIOD.ev_parent_period_flag =0
                                  --只记入当前员工所在评价期间评价类型所应有的评价项目
                                 AND EXISTS (
                                        SELECT evj_type_item.ev_item_id
                                          FROM evj_type_item
                                         WHERE evj_type_item.ev_type_id =
                                                                  ev_type_id_p
                                           AND evj_type_item.ev_item_id =
                                                         evj_master.ev_item_id
                                           AND evj_type_item.ev_period_id IN (
                                                  SELECT evj_period.ev_period_id
                                                    FROM evj_period
                                                   WHERE evj_period.ev_year =
                                                                     ev_year_p
                                                     AND evj_period.ev_parent_period_id =
                                                            ev_parent_period_id_p))
                                 AND evj_master.ev_emp_id = ev_emp_id_i
--把员工各流程与项目分数进行项目与流程百分比进行计算，取得实际得分
-------------------------结束------------------------------------
                             )
                    GROUP BY ev_emp_id, ev_process_id, ev_item_id);
--根据员工的当前年份及季度对各项目各流程进行分数平均
---------------------------结束------------------------------------
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               ev_season_mark_p := 0;
            WHEN OTHERS
            THEN
               ev_season_mark_p := 0;
         END;
      END IF;
   END;

   RETURN ev_season_mark_p;
END get_evj_emp_season_mark;
/

prompt
prompt Creating function GET_HR_ID_CARD
prompt ================================
prompt
CREATE OR REPLACE FUNCTION get_hr_id_card (in_empid IN VARCHAR2)
   RETURN VARCHAR2
IS
   out_deptid   VARCHAR2 (400);
BEGIN
   BEGIN
      SELECT idcard_no
        INTO out_deptid
        FROM hr_personal_info_v
       WHERE empid = in_empid;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         out_deptid := 'have not found this department!';
   END;

   RETURN out_deptid;
END get_hr_id_card;
/

prompt
prompt Creating function GET_KPI_SALARY
prompt ================================
prompt
CREATE OR REPLACE FUNCTION GET_KPI_SALARY(IN_EMPID       VARCHAR2,
                                          IN_PAMONTH VARCHAR2)
  RETURN NUMBER IS
  VAR_POST_ID VARCHAR2(20);
  VAR_POST_LEVEL_ID VARCHAR2(20);
  VAR_KPI_SALARY NUMBER(10,2);
BEGIN
  /*获取员工当月最后一天职位ID与职位等级ID*/
  BEGIN
      SELECT 
            POST_ID,POST_LEVEL_ID INTO VAR_POST_ID,VAR_POST_LEVEL_ID
      FROM HR_POST_RECORDS
      WHERE NO=( /*取职位开始日期小于当前计算月数据的最新一条，即最近职位记录的编号*/
            SELECT MAX(HPR.NO) 
            FROM HR_POST_RECORDS HPR
            WHERE HPR.EMPID = IN_EMPID
            AND TO_DATE(TO_CHAR(HPR.START_DATE,'YYYYMM'),'YYYYMM') <= TO_DATE(IN_PAMONTH,'YYYYMM')
      );
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      VAR_POST_ID := NULL;
      VAR_POST_LEVEL_ID := NULL;
  END;
  
  BEGIN
      SELECT 
            HPI.KPI_SALARY INTO VAR_KPI_SALARY 
      FROM HR_POST_ID_LEVEL HPI
      WHERE HPI.POST_ID = VAR_POST_ID
      AND   HPI.POST_GRADE_ID = VAR_POST_LEVEL_ID;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      VAR_KPI_SALARY := 0;
  END;
  RETURN VAR_KPI_SALARY;
END GET_KPI_SALARY;
/

prompt
prompt Creating function GET_LASTDAY_MONTH
prompt ===================================
prompt
CREATE OR REPLACE FUNCTION get_lastday_month (month_var VARCHAR)
   RETURN DATE
IS
   var_month     VARCHAR (8);
   month_var_v   VARCHAR (6);
   return_date   DATE;
BEGIN
   month_var_v := month_var;
   var_month := TO_CHAR (TO_NUMBER (month_var_v) + 1) || '01';

   SELECT TO_DATE (var_month, 'yyyymmdd') - 1
     INTO return_date
     FROM DUAL;

   DBMS_OUTPUT.put_line (   '  RETURN_date: '
                         || TO_CHAR (return_date, 'yyyy-mm-dd')
                        );
   RETURN return_date;
END get_lastday_month;
/

prompt
prompt Creating function GET_LEGAL_HOLIDAYS
prompt ====================================
prompt
CREATE OR REPLACE FUNCTION GET_LEGAL_HOLIDAYS (monthstr VARCHAR2)
   RETURN NUMBER
IS
   result   NUMBER;
BEGIN
      SELECT COUNT(*)
        INTO result
        FROM AR_CALENDER
       WHERE TYPEID = 3
       AND DDATE BETWEEN Ar_Get_Startdate(monthstr) AND Ar_Get_Enddate(monthstr);

   RETURN result*8*60;
END GET_LEGAL_HOLIDAYS;
/

prompt
prompt Creating function GET_LOCK_STATUS
prompt =================================
prompt
CREATE OR REPLACE FUNCTION get_lock_status (date_str VARCHAR2)
   RETURN NUMBER
IS
   status         NUMBER;
   ar_month_str   VARCHAR2 (6);
BEGIN

   BEGIN
      SELECT DECODE(STATUS,'LockStatus020',0,1)
        INTO status
        FROM AR_DETAIL_LOCK
       WHERE AR_DATE_STR = TO_CHAR(TO_DATE(date_str,'YYYY-MM-DD'),'YYYY-MM-DD');
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         status := 0;
      WHEN OTHERS
      THEN
         status := 0;
   END;
   
   RETURN status;
END get_lock_status;
/

prompt
prompt Creating function GET_LVL_DEPTNAME
prompt ==================================
prompt
CREATE OR REPLACE FUNCTION get_lvl_deptname (
   in_deptid   IN   VARCHAR2,
   in_level         NUMBER
)
   RETURN VARCHAR2
IS
   out_department   VARCHAR2 (40);
   v_deptid         VARCHAR2 (50);
   v_level          NUMBER;
BEGIN
   BEGIN
      v_deptid := in_deptid;

-- DBMS_OUTPUT.Put_Line(parent_deptid);
      WHILE out_department IS NULL
      LOOP
         BEGIN
            SELECT deptname
              INTO out_department
              FROM hr_department
             WHERE deptid = v_deptid AND dept_level = in_level;
         --DBMS_OUTPUT.Put_Line(noworkday);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               out_department := NULL;

               SELECT parent_dept_id
                 INTO v_deptid
                 FROM hr_department
                WHERE deptid = v_deptid;
--    DBMS_OUTPUT.Put_Line(parent_deptid);
         END;
      END LOOP;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         out_department := '';
   END;

   RETURN out_department;
END get_lvl_deptname;
/

prompt
prompt Creating function GET_MAX_NUM
prompt =============================
prompt
CREATE OR REPLACE FUNCTION get_max_num (
       in_num1 IN number,
       in_num2 IN number)
   RETURN number
IS
   out_num   number;
BEGIN
   if in_num1>in_num2
      then out_num := in_num1;
   elsif in_num1<in_num2
      then out_num := in_num2;
   else
      out_num :=1;
   end if;
   if out_num =0
      then out_num :=1;
   end if;

   RETURN out_num;
END get_max_num;
/

prompt
prompt Creating function GET_MD5
prompt =========================
prompt
CREATE OR REPLACE FUNCTION GET_MD5
( v_str in varchar2)
RETURN varchar2 IS
BEGIN
  IF v_str IS NOT NULL THEN
    RETURN Utl_Raw.Cast_To_Raw(DBMS_OBFUSCATION_TOOLKIT.MD5(input_string => Upper(v_str)));
  ELSE
    RETURN '';
  END IF;
END;
/

prompt
prompt Creating function GET_ORDER_DIRECT_PERCENTAGE
prompt =============================================
prompt
CREATE OR REPLACE FUNCTION GET_ORDER_DIRECT_PERCENTAGE(IN_ORDER_ID IN VARCHAR2) RETURN NUMBER IS
  ORDER_INFO ORD_ORDER_INFO%ROWTYPE;
  SALARY_INFO SALES_SALARY_DIRECT%ROWTYPE;
  --SY_CODE_INFO SY_CODE%ROWTYPE;
  VAR_RETURN NUMBER(10,2);
  --FLAG NUMBER(1);
  TYPE CURSOR_TYPE IS REF CURSOR;
  SALARY_CURSOR CURSOR_TYPE;
  QUERY_STR VARCHAR2(1000);
BEGIN
  SELECT * INTO ORDER_INFO FROM ORD_ORDER_INFO WHERE ORDER_ID = IN_ORDER_ID;

  /*在特定城市提成*/
  QUERY_STR := 'SELECT T.* FROM SALES_SALARY_DIRECT T, HR_EMPLOYEE HRE, HR_DEPARTMENT HRD WHERE T.PRODUCT_ID = '''||ORDER_INFO.PRODUCT_ID
             ||''' AND T.SALES_AREA_CODE = HRD.AREA_CODE AND HRE.DEPTID = HRD.DEPTID AND HRE.EMPID = '''||ORDER_INFO.EMPID
             ||''' AND TO_DATE('''||ORDER_INFO.Created_Date||''') >= T.BEGIN_DATE AND TO_DATE('''||ORDER_INFO.Created_Date||''')<= NVL(T.END_DATE,TO_DATE('''||ORDER_INFO.Created_Date||''')+1) ORDER BY T.BOUNDARY DESC';
  OPEN SALARY_CURSOR FOR QUERY_STR;
  DBMS_OUTPUT.PUT_LINE('OPEN CURSOR FOR '||QUERY_STR);
  LOOP
    FETCH SALARY_CURSOR INTO SALARY_INFO;
    EXIT WHEN SALARY_CURSOR%NOTFOUND;
    IF SALARY_INFO.REFER = 'SalaryReference003' THEN  --比较价格
      IF SALARY_INFO.BOUNDARY <= ORDER_INFO.PRICE THEN  --符合条件
        IF SALARY_INFO.BASIS = 'SalaryReference001' THEN -- 提成基准值为销售量
          VAR_RETURN := ORDER_INFO.MONEY_TOTAL * SALARY_INFO.PERCENTAGE;
        END IF;
        IF SALARY_INFO.BASIS = 'SalaryReference002' THEN -- 提成基准值为支数
          VAR_RETURN := ORDER_INFO.PRO_QUANTITY * SALARY_INFO.PERCENTAGE;
        END IF;
        RETURN VAR_RETURN;
      END IF;
    END IF;
  END LOOP;

/*在特定省的提成*/ 
/*  QUERY_STR := 'SELECT T.* FROM SALES_SALARY_DIRECT T, SY_CODE A WHERE T.SALES_AREA_CODE = A.CODE_ID AND T.PRODUCT_ID = '''
             ||ORDER_INFO.PRODUCT_ID||''' AND A.PARENT_CODE = '''||ORDER_INFO.SALES_AREA_CODE||''' ORDER BY T.BOUNDARY DESC';
  OPEN SALARY_CURSOR FOR QUERY_STR;
  DBMS_OUTPUT.PUT_LINE('OPEN CURSOR FOR '||QUERY_STR);
  LOOP
    FETCH SALARY_CURSOR INTO SALARY_INFO;
    EXIT WHEN SALARY_CURSOR%NOTFOUND;
    IF SALARY_INFO.REFER = 'SalaryReference003' THEN  --比较价格
      IF SALARY_INFO.BOUNDARY <= ORDER_INFO.PRICE THEN  --符合条件
        IF SALARY_INFO.BASIS = 'SalaryReference001' THEN -- 提成基准值为销售量
          VAR_RETURN := ORDER_INFO.MONEY_TOTAL * SALARY_INFO.PERCENTAGE;
        END IF;
        IF SALARY_INFO.BASIS = 'SalaryReference002' THEN -- 提成基准值为支数
          VAR_RETURN := ORDER_INFO.PRO_QUANTITY * SALARY_INFO.PERCENTAGE;
        END IF;
        RETURN VAR_RETURN;
      END IF;
    END IF;
  END LOOP;  */

  /*默认地点提成*/
  QUERY_STR := 'SELECT T.* FROM SALES_SALARY_DIRECT T WHERE T.PRODUCT_ID = '''||ORDER_INFO.PRODUCT_ID
             ||''' AND T.SALES_AREA_CODE = ''WorkArea000'' AND TO_DATE('''||ORDER_INFO.Created_Date||''') >= T.BEGIN_DATE AND TO_DATE('''||ORDER_INFO.Created_Date||''')<= NVL(T.END_DATE,TO_DATE('''||ORDER_INFO.Created_Date||''')+1) ORDER BY T.BOUNDARY DESC';
  OPEN SALARY_CURSOR FOR QUERY_STR;
  DBMS_OUTPUT.PUT_LINE('OPEN CURSOR FOR '||QUERY_STR);
  LOOP
    FETCH SALARY_CURSOR INTO SALARY_INFO;
    EXIT WHEN SALARY_CURSOR%NOTFOUND;
    IF SALARY_INFO.REFER = 'SalaryReference003' THEN  --比较价格
      IF SALARY_INFO.BOUNDARY <= ORDER_INFO.PRICE THEN  --符合条件
        IF SALARY_INFO.BASIS = 'SalaryReference001' THEN -- 提成基准值为销售量
          VAR_RETURN := ORDER_INFO.MONEY_TOTAL * SALARY_INFO.PERCENTAGE;
        END IF;
        IF SALARY_INFO.BASIS = 'SalaryReference002' THEN -- 提成基准值为支数
          VAR_RETURN := ORDER_INFO.PRO_QUANTITY * SALARY_INFO.PERCENTAGE;
        END IF;
        RETURN VAR_RETURN;
      END IF;
    END IF;
  END LOOP;

  RETURN 0;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    VAR_RETURN := 0;
    RETURN VAR_RETURN;
END GET_ORDER_DIRECT_PERCENTAGE;
/

prompt
prompt Creating function GET_OT_TIME_TYPES
prompt ===================================
prompt
CREATE OR REPLACE FUNCTION get_ot_time_types (
   in_time    IN   varchar,
   from_time  in   varchar,
   types      in   number
)
   RETURN NUMBER
IS
   times   NUMBER;
  
BEGIN
   times :=0;
   if types=0   ---当日
   then
     if to_date(from_time,'HH24:mi:ss')<to_date('12:30','HH24:mi:ss')
        then
           if to_date(in_time,'HH24:mi:ss')>=to_date('12:30','HH24:mi:ss') and  to_date(in_time,'HH24:mi:ss')<to_date('13:00','HH24:mi:ss')
              then times :=0.5;
           elsif to_date(in_time,'HH24:mi:ss') >=to_date('13:00','HH24:mi:ss') and to_date(in_time,'HH24:mi:ss')<to_date('18:30','HH24:mi:ss')
              then times :=1;
           elsif to_date(in_time,'HH24:mi:ss')>=to_date('18:30','HH24:mi:ss') 
                  and to_date(in_time,'HH24:mi:ss')<to_date('19:00','HH24:mi:ss')
              then times :=1.5;
           elsif to_date(in_time,'HH24:mi:ss')>to_date('19:00','HH24:mi:ss') 
              then times :=2;
           end if;
     end if;
     if to_date(from_time,'HH24:mi:ss')<to_date('13:00','HH24:mi:ss') and to_date(from_time,'HH24:mi:ss')>=to_date('12:30','HH24:mi:ss')
        then
           if to_date(in_time,'HH24:mi:ss')>=to_date('12:30','HH24:mi:ss') and  to_date(in_time,'HH24:mi:ss')<to_date('13:00','HH24:mi:ss')
              then times :=0.5;
           elsif to_date(in_time,'HH24:mi:ss') >=to_date('13:00','HH24:mi:ss') and to_date(in_time,'HH24:mi:ss')<=to_date('18:30','HH24:mi:ss')
              then times :=1;
           else  times :=1.5;
           end if;
     end if;   
     if to_date(from_time,'HH24:mi:ss')>=to_date('13:00','HH24:mi:ss')
        then
         if to_date(in_time,'HH24:mi:ss')>=to_date('18:30','HH24:mi:ss') and to_date(in_time,'HH24:mi:ss')<to_date('19:00','HH24:mi:ss')
            then times :=0.5;
         elsif to_date(in_time,'HH24:mi:ss')>=to_date('19:00','HH24:mi:ss')
            then times :=1;
         end if;
     end if;
   
   elsif types=1   --次日
   then
      if to_date(from_time,'HH24:mi:ss')<to_date('12:30','HH24:mi:ss')
        then
           if to_date(in_time,'HH24:mi:ss')>=to_date('12:30','HH24:mi:ss') and  to_date(in_time,'HH24:mi:ss')<to_date('13:00','HH24:mi:ss')
              then times :=2.5;
           elsif to_date(in_time,'HH24:mi:ss') >=to_date('13:00','HH24:mi:ss') and to_date(in_time,'HH24:mi:ss')<to_date('18:30','HH24:mi:ss')
              then times :=3;
           elsif to_date(in_time,'HH24:mi:ss')>=to_date('18:30','HH24:mi:ss') 
                  and to_date(in_time,'HH24:mi:ss')<to_date('19:00','HH24:mi:ss')
              then times :=3.5;
           elsif to_date(in_time,'HH24:mi:ss')>to_date('19:00','HH24:mi:ss') 
              then times :=4;
           else
              times:=2;
           end if;
     end if;
     if to_date(from_time,'HH24:mi:ss')<to_date('13:00','HH24:mi:ss') and to_date(from_time,'HH24:mi:ss')>=to_date('12:30','HH24:mi:ss')
        then
           if to_date(in_time,'HH24:mi:ss')>=to_date('12:30','HH24:mi:ss') and  to_date(in_time,'HH24:mi:ss')<to_date('13:00','HH24:mi:ss')
              then times :=2.5;
           elsif to_date(in_time,'HH24:mi:ss') >=to_date('13:00','HH24:mi:ss') and to_date(in_time,'HH24:mi:ss')<=to_date('18:30','HH24:mi:ss')
              then times :=3;
           else  times :=4.5;
           end if;
     end if;   
     if to_date(from_time,'HH24:mi:ss')>=to_date('13:00','HH24:mi:ss')
        then
         if to_date(in_time,'HH24:mi:ss')>=to_date('18:30','HH24:mi:ss') and to_date(in_time,'HH24:mi:ss')<to_date('19:00','HH24:mi:ss')
            then times :=2.5;
         elsif to_date(in_time,'HH24:mi:ss')>=to_date('19:00','HH24:mi:ss')
            then times :=3;
         end if;
     end if;
     
   elsif types=2   --第三日
   then
      if to_date(from_time,'HH24:mi:ss')<to_date('12:30','HH24:mi:ss')
        then
           if to_date(in_time,'HH24:mi:ss')>=to_date('12:30','HH24:mi:ss') and  to_date(in_time,'HH24:mi:ss')<to_date('13:00','HH24:mi:ss')
              then times :=4.5;
           elsif to_date(in_time,'HH24:mi:ss') >=to_date('13:00','HH24:mi:ss') and to_date(in_time,'HH24:mi:ss')<to_date('18:30','HH24:mi:ss')
              then times :=5;
           elsif to_date(in_time,'HH24:mi:ss')>=to_date('18:30','HH24:mi:ss') 
                  and to_date(in_time,'HH24:mi:ss')<to_date('19:00','HH24:mi:ss')
              then times :=5.5;
           elsif to_date(in_time,'HH24:mi:ss')>to_date('19:00','HH24:mi:ss') 
              then times :=6;
           else
              times:=4;
           end if;
     end if;
     if to_date(from_time,'HH24:mi:ss')<to_date('13:00','HH24:mi:ss') and to_date(from_time,'HH24:mi:ss')>=to_date('12:30','HH24:mi:ss')
        then
           if to_date(in_time,'HH24:mi:ss')>=to_date('12:30','HH24:mi:ss') and  to_date(in_time,'HH24:mi:ss')<to_date('13:00','HH24:mi:ss')
              then times :=4.5;
           elsif to_date(in_time,'HH24:mi:ss') >=to_date('13:00','HH24:mi:ss') and to_date(in_time,'HH24:mi:ss')<=to_date('18:30','HH24:mi:ss')
              then times :=5;
           else  times :=6.5;
           end if;
     end if;   
     if to_date(from_time,'HH24:mi:ss')>=to_date('13:00','HH24:mi:ss')
        then
         if to_date(in_time,'HH24:mi:ss')>=to_date('18:30','HH24:mi:ss') and to_date(in_time,'HH24:mi:ss')<to_date('19:00','HH24:mi:ss')
            then times :=4.5;
         elsif to_date(in_time,'HH24:mi:ss')>=to_date('19:00','HH24:mi:ss')
            then times :=5;
         end if;
     end if;
   end if;
   RETURN times;
END get_ot_time_types;
/

prompt
prompt Creating function GET_PARENT_CODE
prompt =================================
prompt
CREATE OR REPLACE FUNCTION Get_Parent_Code (
   in_code_id           IN   VARCHAR2
)
   RETURN VARCHAR2
IS
   v_parent_code   VARCHAR2 (50);
BEGIN
   SELECT parent_code
     INTO v_parent_code
     FROM SY_CODE
    WHERE code_id = in_code_id;

   RETURN v_parent_code;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      v_parent_code := '';
      RETURN v_parent_code;
   WHEN OTHERS
   THEN
   	  v_parent_code := '';
      RETURN v_parent_code;
END Get_Parent_Code;
/

prompt
prompt Creating function GET_POSITION_NAME
prompt ===================================
prompt
CREATE OR REPLACE FUNCTION get_position_name (v_code_id IN VARCHAR2)
   RETURN VARCHAR2
IS
   v_name   VARCHAR2 (50);
BEGIN
   BEGIN
      SELECT t.code_name
        INTO v_name
        FROM sy_code t
       WHERE t.code_id = v_code_id;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_name := '';
      WHEN OTHERS
      THEN
         RAISE;
   END;

   RETURN v_name;
END get_position_name;
/

prompt
prompt Creating function GET_POST_GRADE_NAME
prompt =====================================
prompt
CREATE OR REPLACE FUNCTION get_post_grade_name (v_code_id IN VARCHAR2)
   RETURN VARCHAR2
IS
   v_name   VARCHAR2 (50);
BEGIN
   BEGIN
      SELECT t.post_grade_name
        INTO v_name
        FROM hr_post_grade t
       WHERE t.post_grade_id = v_code_id;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_name := '';
      WHEN OTHERS
      THEN
         RAISE;
   END;

   RETURN v_name;
END get_post_grade_name;
/

prompt
prompt Creating function GET_POST_GROUP_NAME
prompt =====================================
prompt
CREATE OR REPLACE FUNCTION get_post_group_name (v_code_id IN VARCHAR2)
   RETURN VARCHAR2
IS
   v_name   VARCHAR2 (50);
BEGIN
   BEGIN
        SELECT POST_GROUP_NAME
        INTO v_name
          FROM HR_POST_GROUP HPG, HR_POST HP
         WHERE HP.POST_GROUP_ID = HPG.POST_group_id
         AND hp.post_id = v_code_id;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_name := '';
      WHEN OTHERS
      THEN
         RAISE;
   END;

   RETURN v_name;
END get_post_group_name;
/

prompt
prompt Creating function GET_POST_NAME
prompt ===============================
prompt
CREATE OR REPLACE FUNCTION get_post_name (v_code_id IN VARCHAR2)
   RETURN VARCHAR2
IS
   v_name   VARCHAR2 (50);
BEGIN
   BEGIN
      SELECT post_name
        INTO v_name
        FROM hr_post
       WHERE post_id = v_code_id;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_name := '';
      WHEN OTHERS
      THEN
         RAISE;
   END;

   RETURN v_name;
END get_post_name;
/

prompt
prompt Creating function GET_PREVMONTH_LASTDAY
prompt =======================================
prompt
CREATE OR REPLACE FUNCTION get_prevMonth_lastDay (v_ddate varchar2)
   RETURN DATE
IS
   v_date         DATE;
   v_month_str    VARCHAR2 (10);
   v_day          varchar2(10);
BEGIN
   v_date:=to_date(v_ddate,'YYYY-MM-DD');
   v_day:=to_char(v_date,'DD');
   if TO_NUMBER(v_day)<=21
      then v_date:=last_day(add_months(v_date,-1));
   end if;
   RETURN v_date;
END;
/

prompt
prompt Creating function GET_PREVMONTH_LASTDAY44
prompt =========================================
prompt
CREATE OR REPLACE FUNCTION get_prevMonth_lastDay44 (v_ddate varchar2)
   RETURN DATE
IS
   v_date         DATE;
   v_month_str    VARCHAR2 (10);
   v_day          varchar2(10);
 -- v_count        INT;
BEGIN
/*  SELECT COUNT(*) INTO v_count 
      FROM hr_personal_info_v
       WHERE empid = vempid AND work_area LIKE '北京%';
  

   v_date:=to_date(v_ddate,'YYYY-MM-DD');
   v_day:=to_char(v_date,'DD');
   
   IF TO_NUMBER(v_day)>=21 --AND v_count > 0
      THEN v_date:=last_day(add_months(v_date,1));
   ELSIF TO_NUMBER(v_day)< 21 --AND v_count > 0
      THEN v_date:= v_date;
   ELSE 
      v_date:=last_day(v_date);
   END IF;
   
   RETURN v_date ;
  */  
 
BEGIN
   v_date:=to_date(v_ddate,'YYYY-MM-DD');
   v_day:=to_char(v_date,'DD');
   if TO_NUMBER(v_day)<=21
      then v_date:=last_day(add_months(v_date,-1));
   end if;
   RETURN v_date;
END;
END;
/

prompt
prompt Creating function GET_PROCESS_AFFIRMORS
prompt =======================================
prompt
CREATE OR REPLACE FUNCTION get_PROCESS_AFFIRMORS (IN_OBJECT_TYPE_ID VARCHAR2,
                                                  IN_STATUS_ID      VARCHAR2,
                                                  IN_CPNY_ID        VARCHAR2)
   RETURN VARCHAR2
IS
  AFFIRMORS  VARCHAR2(400);

  CURSOR CUS_AFFIRMOR_NAME IS
    SELECT DISTINCT HE.CHINESENAME
    FROM PROCESS_AFFIRM_RELATION PAR,
         HR_EMPLOYEE             HE
    WHERE   PAR.OBJECT_TYPE_ID = IN_OBJECT_TYPE_ID
      AND   PAR.CPNY_ID = IN_CPNY_ID
      AND   PAR.ACTIVITY = 1
      AND   PAR.OBJECT_STATUS_ID = IN_STATUS_ID
      AND   PAR.AFFIRMOR_ID = HE.EMPID(+);

    CUS_AFFIRMOR_NAME_ROW CUS_AFFIRMOR_NAME%ROWTYPE;
BEGIN
   AFFIRMORS := '';
  OPEN CUS_AFFIRMOR_NAME;
   LOOP
     

        FETCH CUS_AFFIRMOR_NAME
          INTO CUS_AFFIRMOR_NAME_ROW;

        EXIT WHEN CUS_AFFIRMOR_NAME%NOTFOUND;
          AFFIRMORS:=AFFIRMORS||' '||CUS_AFFIRMOR_NAME_ROW.CHINESENAME;
   END LOOP;

   RETURN AFFIRMORS;
END;
/

prompt
prompt Creating function GET_PROCESS_DEF_STATUS
prompt ========================================
prompt
CREATE OR REPLACE FUNCTION GET_PROCESS_DEF_STATUS (IN_OBJECT_TYPE_ID VARCHAR2,
                                                  IN_CPNY_ID        VARCHAR2)
   RETURN VARCHAR2
IS
  OUT_STATUS_ID  VARCHAR2(400);
BEGIN
   SELECT T.DEFAULT_STATUS_ID INTO OUT_STATUS_ID FROM PROCESS_OBJECT_TYPE_INFO T WHERE T.OBJECT_TYPE_ID = IN_OBJECT_TYPE_ID AND T.CPNY_ID = IN_CPNY_ID;
   RETURN OUT_STATUS_ID;
END;
/

prompt
prompt Creating function GET_PRODUCT_MONTH_TOTAL
prompt =========================================
prompt
CREATE OR REPLACE FUNCTION GET_PRODUCT_MONTH_TOTAL (in_product_no VARCHAR2,
                                                 in_month VARCHAR2,
                                                 in_year  VARCHAR2 )
   RETURN NUMBER
IS
   var_sum  NUMBER := 0;
BEGIN
  SELECT NVL(TEMP.TOTAL_PRICE,0) INTO var_sum
  FROM (
    SELECT PSOD.Product_No,
           TO_CHAR(PSO.ORDER_DATE, 'MON','NLS_DATE_LANGUAGE=AMERICAN') AS SALE_MONTH,
           NVL(SUM(PSOD.DISCOUNT_MONEY),0) TOTAL_PRICE
    FROM PROSTOR_SALES_ORDER PSO,
         PROSTOR_SALES_ORDER_DETAIL PSOD
    WHERE PSO.SALES_ORDER_NO = PSOD.SALES_ORDER_NO(+)
    AND PSO.ACTIVITY = 1
    AND TO_CHAR(PSO.ORDER_DATE, 'YYYY') = in_year
    AND PSO.AFFIRM_FLAG = 'affirm1'
    GROUP BY PSOD.Product_No,TO_CHAR(PSO.ORDER_DATE, 'MON','NLS_DATE_LANGUAGE=AMERICAN')
) TEMP
  WHERE TEMP.Product_No = in_product_no
  AND   TEMP.SALE_MONTH = in_month;

  RETURN var_sum;
EXCEPTION
  WHEN OTHERS THEN
     RETURN 0;

END GET_PRODUCT_MONTH_TOTAL;
/

prompt
prompt Creating function GET_PRODUCT_YEAR_TOTAL
prompt ========================================
prompt
CREATE OR REPLACE FUNCTION GET_PRODUCT_YEAR_TOTAL (in_product_no VARCHAR2,
                                                 in_year  INT )
   RETURN NUMBER
IS
   var_sum  NUMBER := 0;
BEGIN
  SELECT NVL(TEMP.TOTAL_PRICE,0) INTO var_sum
  FROM (
    SELECT PSOD.Product_No,
           TO_CHAR(PSO.ORDER_DATE, 'YYYY') AS SALE_YEAR,
           NVL(SUM(PSOD.DISCOUNT_MONEY),0) TOTAL_PRICE
    FROM PROSTOR_SALES_ORDER PSO,
         PROSTOR_SALES_ORDER_DETAIL PSOD
    WHERE PSO.SALES_ORDER_NO = PSOD.SALES_ORDER_NO(+)
    AND PSO.ACTIVITY = 1
    AND AFFIRM_FLAG = 'affirm1'
    AND TO_CHAR(PSO.ORDER_DATE, 'YYYY') = in_year
    GROUP BY PSOD.Product_No,TO_CHAR(PSO.ORDER_DATE, 'YYYY')
) TEMP
  WHERE TEMP.Product_No = in_product_no
  AND   TEMP.SALE_YEAR = to_char(in_year);

  RETURN var_sum;
EXCEPTION
  WHEN OTHERS THEN
     RETURN 0;

END GET_PRODUCT_YEAR_TOTAL;
/

prompt
prompt Creating function GET_PUN_SUM
prompt =============================
prompt
CREATE OR REPLACE FUNCTION GET_PUN_SUM(IN_EMPID       VARCHAR2,
                                          IN_PAMONTH VARCHAR2)
  RETURN NUMBER IS
  VAR_PUN_SUM NUMBER(10,2);
BEGIN
  SELECT NVL(SUM(T.PUN_AMOUNT),0) INTO VAR_PUN_SUM
  FROM HR_PUNISHMENT T
  WHERE T.EMPID = IN_EMPID
      AND ACTIVITY = 1
      AND T.PUNISHED_DATE <= AR_GET_ENDDATE(IN_PAMONTH)
      AND T.PUNISHED_DATE >= AR_GET_STARTDATE(IN_PAMONTH);

  RETURN VAR_PUN_SUM;
END GET_PUN_SUM;
/

prompt
prompt Creating function GET_REWARD_SUM
prompt ================================
prompt
CREATE OR REPLACE FUNCTION GET_REWARD_SUM(IN_EMPID       VARCHAR2,
                                          IN_PAMONTH VARCHAR2)
  RETURN NUMBER IS
  VAR_PUN_SUM NUMBER(10,2);
BEGIN
  SELECT NVL(SUM(T.REWARD_AMOUNT),0) INTO VAR_PUN_SUM
  FROM HR_REWARD T
  WHERE T.EMPID = IN_EMPID
      AND ACTIVITY = 1
      AND T.REWARD_DATE <= AR_GET_ENDDATE(IN_PAMONTH)
      AND T.REWARD_DATE >= AR_GET_STARTDATE(IN_PAMONTH);

  RETURN VAR_PUN_SUM;
END GET_REWARD_SUM;
/

prompt
prompt Creating function GET_SALER_ACTION_QUANTITY
prompt ===========================================
prompt
CREATE OR REPLACE FUNCTION GET_SALER_ACTION_QUANTITY(IN_EMPID IN VARCHAR2,IN_MONTH IN VARCHAR2) RETURN NUMBER IS
  SDATE DATE;
  EDATE DATE;
  VAR_RESULT NUMBER;
BEGIN
  SDATE := ar_get_startdate(IN_MONTH);
  EDATE := ar_get_enddate(IN_MONTH);
  --SELECT SUM(OROI.MONEY_TOTAL) INTO VAR_RESULT FROM ORD_ORDER_INFO OROI WHERE OROI.EMPID = IN_EMPID AND OROI.VERIFIED_DATE>= SDATE AND OROI.VERIFIED_DATE<= EDATE;
  SELECT COUNT(0) INTO VAR_RESULT FROM CUST_ACTION_INFO CUAI
                                  WHERE CUAI.EMP_ID = IN_EMPID
                                    AND CUAI.CUST_ACTION_TIME >= SDATE
                                    AND CUAI.CUST_ACTION_TIME <= EDATE;
  RETURN VAR_RESULT;
END GET_SALER_ACTION_QUANTITY;
/

prompt
prompt Creating function GET_SALER_MONTH_QUANTITY
prompt ==========================================
prompt
CREATE OR REPLACE FUNCTION GET_SALER_MONTH_QUANTITY(IN_EMPID IN VARCHAR2,IN_MONTH IN VARCHAR2) RETURN NUMBER IS
  SDATE DATE;
  EDATE DATE;
  VAR_RESULT NUMBER;
BEGIN
  SDATE := ar_get_startdate(IN_MONTH);
  EDATE := ar_get_enddate(IN_MONTH);
  SELECT SUM(OROI.PRO_QUANTITY) INTO VAR_RESULT FROM ORD_ORDER_INFO OROI WHERE OROI.EMPID = IN_EMPID AND OROI.VERIFIED_DATE>= SDATE AND OROI.VERIFIED_DATE<= EDATE;
  RETURN VAR_RESULT;
END GET_SALER_MONTH_QUANTITY;
/

prompt
prompt Creating function GET_SALER_MONTH_VOLUME
prompt ========================================
prompt
CREATE OR REPLACE FUNCTION GET_SALER_MONTH_VOLUME(IN_EMPID IN VARCHAR2,IN_MONTH IN VARCHAR2) RETURN NUMBER IS
  SDATE DATE;
  EDATE DATE;
  VAR_RESULT NUMBER;
BEGIN
  SDATE := ar_get_startdate(IN_MONTH);
  EDATE := ar_get_enddate(IN_MONTH);
  SELECT SUM(OROI.MONEY_TOTAL) INTO VAR_RESULT FROM ORD_ORDER_INFO OROI WHERE OROI.EMPID = IN_EMPID AND OROI.VERIFIED_DATE>= SDATE AND OROI.VERIFIED_DATE<= EDATE;
  RETURN VAR_RESULT;
END GET_SALER_MONTH_VOLUME;
/

prompt
prompt Creating function GET_SHIXIDATE
prompt ===============================
prompt
CREATE OR REPLACE FUNCTION get_shixidate (in_empid IN VARCHAR2)
   RETURN VARCHAR2
IS
   dates    varchar2(10);
   years    varchar2(10);
   returnvalue    varchar2(10);
BEGIN
   BEGIN
                dates :=in_empid;
                years := substr(dates,0,4);
                dbms_output.put_line(years);
                if to_date(in_empid,'yyyy-mm-dd')<=to_date(years||'-06-30','yyyy-mm-dd')
                   then 
                          select to_char(to_date(years||'-06-30','yyyy-mm-dd'),'yyyy-mm-dd') into returnvalue from dual;
                else
                  select to_char(add_months(to_date(years||'-06-30','yyyy-mm-dd'),12),'yyyy-mm-dd') into returnvalue from dual;
                end if;
   
  
     
   END;

   RETURN returnvalue;
END get_shixidate;
/

prompt
prompt Creating function GET_SYS_CODE
prompt ==============================
prompt
CREATE OR REPLACE FUNCTION get_sys_code (vcode IN VARCHAR2)
   RETURN VARCHAR2
IS
   vname    VARCHAR2 (50);
   vcount   INT;
BEGIN
   SELECT COUNT (*)
     INTO vcount
     FROM sy_code
    WHERE code_id = vcode;

   IF vcount = 0
   THEN
      vname := '';
      RETURN vname;
   ELSE
      SELECT code_name
        INTO vname
        FROM sy_code
       WHERE code_id = vcode;

      RETURN vname;
      --EXCEPTION
        --  WHEN NO_DATA_FOUND THEN
          -- vNAME:= '' ;
      RETURN vname;
   END IF;
END get_sys_code;
/

prompt
prompt Creating function GET_SYS_CODE_BY_PARENT_NAME
prompt =============================================
prompt
CREATE OR REPLACE FUNCTION get_sys_code_BY_PARENT_NAME(vname IN VARCHAR2,parentID IN VARCHAR2 )
   RETURN VARCHAR2
IS
   vcodeid    VARCHAR2(50);
   vcount   INT;
BEGIN
   SELECT COUNT (*)
     INTO vcount
     FROM sy_code
    WHERE PARENT_CODE = parentID
    AND code_name = vname;

   IF vcount = 0
   THEN
      vcodeid := 'AdjustType001';
      RETURN vcodeid;
   ELSE
      SELECT code_id
        INTO vcodeid
        FROM sy_code
       WHERE PARENT_CODE = parentID
       AND code_name = vname;

      RETURN vcodeid;

   END IF;
END get_sys_code_BY_PARENT_NAME;
/

prompt
prompt Creating function GET_SY_SCREEN_FLAG
prompt ====================================
prompt
CREATE OR REPLACE FUNCTION GET_SY_SCREEN_FLAG(IN_SCREEN_GRANT_ID   IN VARCHAR2,
                                                IN_SCREEN_GRANT_TYPE IN VARCHAR2,
                                                IN_MENU_CODE         IN VARCHAR2)
  RETURN INT IS
  V_FLAG INT;
BEGIN
  V_FLAG := 0;
  SELECT DECODE(IN_SCREEN_GRANT_TYPE,
                'S',
                A.SELECTR,
                'B',
                A.SAVER,
                'I',
                A.INSERTR,
                'D',
                A.DELETER,
                'C',
                A.CANCELR,
                'U',
                A.UPDATER,
                0)
    INTO V_FLAG
    FROM SY_SCREEN_GRANT A
   WHERE A.SCREEN_CODE = IN_MENU_CODE
     AND A.ACTIVITY = 1
     AND A.SCREEN_GRANT_ID = IN_SCREEN_GRANT_ID;
  RETURN V_FLAG;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_FLAG := '0';
  RETURN V_FLAG;

END GET_SY_SCREEN_FLAG;
/

prompt
prompt Creating function GET_TIP_DEPT
prompt ==============================
prompt
CREATE OR REPLACE FUNCTION GET_TIP_DEPT(DEPT VARCHAR2)
   RETURN VARCHAR
   IS
      TIPDEPT VARCHAR2 (60);
   BEGIN
   BEGIN
     		SELECT DECODE(SUBSTR(DEPT, 1, 1),
									0,
									'总行',
									get_dept_name(SUBSTR(DEPT,1,2)||'040000')
							 ) DEPTNAME
			INTO TIPDEPT
			FROM DUAL;
       END;
       RETURN TIPDEPT;
   END GET_TIP_DEPT;
/

prompt
prompt Creating function HR_GET_LEVEL_DEPTID
prompt =====================================
prompt
CREATE OR REPLACE FUNCTION HR_GET_LEVEL_DEPTID(IN_DEPTID IN VARCHAR2,
                                               IN_LEVEL  IN NUMBER)
  RETURN VARCHAR2 IS
  V_PARENT        HR_DEPARTMENT%ROWTYPE;
  OUT_DEPARTMENT  VARCHAR2(40);
  V_PARENT_DEPTID VARCHAR2(40);
  V_DEPT_LEVEL    HR_DEPARTMENT.DEPT_LEVEL%TYPE;
BEGIN
  -- 找到当前部门的部门等级
  BEGIN
    SELECT DEPT_LEVEL, PARENT_DEPT_ID
      INTO V_DEPT_LEVEL, V_PARENT_DEPTID
      FROM HR_DEPARTMENT
     WHERE DEPTID = IN_DEPTID;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_DEPT_LEVEL := NULL;
  END;

  -- 如果当前部门的等级是一级,或者小于 in_level,就直接返回当前部门的deptid
  IF V_DEPT_LEVEL <= IN_LEVEL THEN
    OUT_DEPARTMENT := IN_DEPTID;
    RETURN OUT_DEPARTMENT;
    --如果部门的等级大于1,就继续查找其上级部门的名字
  ELSIF V_DEPT_LEVEL > IN_LEVEL THEN
    BEGIN
      SELECT *
        INTO V_PARENT
        FROM HR_DEPARTMENT
       WHERE DEPTID = (SELECT PARENT_DEPT_ID
                         FROM HR_DEPARTMENT
                        WHERE DEPTID = IN_DEPTID);
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        V_PARENT := NULL;
    END;
  
    RETURN HR_GET_LEVEL_DEPTID(V_PARENT.DEPTID, IN_LEVEL);
  ELSE
    RETURN NULL;
  END IF;
END HR_GET_LEVEL_DEPTID;
/

prompt
prompt Creating function HR_GET_LEVEL_DEPTNAME
prompt =======================================
prompt
CREATE OR REPLACE FUNCTION hr_get_level_deptname (
   in_deptid   IN   VARCHAR2,
   in_level    IN   NUMBER
)
   RETURN VARCHAR2
IS
   v_parent         hr_department%ROWTYPE;
   out_department   VARCHAR2 (40);
   v_dept_level     hr_department.dept_level%TYPE;
BEGIN
-- 找到当前部门的部门等级
   BEGIN
      SELECT dept_level
        INTO v_dept_level
        FROM hr_department
       WHERE deptid = in_deptid;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_dept_level := NULL;
   END;

-- 如果当前部门的等级是一级,或者小于 in_level,就直接返回当前部门的deptid
   IF v_dept_level <= in_level
   THEN
      out_department := get_dept_name (in_deptid);
      RETURN out_department;
   --如果部门的等级大于1,就继续查找其上级部门的名字
   ELSIF v_dept_level > in_level
   THEN
      BEGIN
         SELECT *
           INTO v_parent
           FROM hr_department
          WHERE deptid = (SELECT parent_dept_id
                            FROM hr_department
                           WHERE deptid = in_deptid);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            v_parent := NULL;
      END;

      RETURN get_dept_name (hr_get_level_deptid (v_parent.deptid, in_level));
   ELSE
      RETURN NULL;
   END IF;
END hr_get_level_deptname;
/

prompt
prompt Creating function GET_TIP_DEPT_VR
prompt =================================
prompt
CREATE OR REPLACE FUNCTION GET_TIP_DEPT_VR(DEPT VARCHAR2) RETURN VARCHAR IS
	TIPDEPT VARCHAR2(200);
	ISPART VARCHAR2(20);
	AREA   VARCHAR2(20);
	CURRENTDEPTNAME VARCHAR2(200);
BEGIN

	BEGIN
		SELECT DECODE(SUBSTR(DEPT, 1, 1),
									0,
									'',
									get_dept_name(SUBSTR(DEPT,1,2)||'040000')
							 ) DEPTNAME
			INTO TIPDEPT
			FROM DUAL;
	
	  --判断是否是支行，5支行
		--deptid第四位
		BEGIN
		SELECT DEPTNAME ,AREA INTO ISPART, AREA FROM (
    SELECT DECODE(SUBSTR(DEPTID, 4, 1),
									5,
									'Y',
									'N') DEPTNAME,
			   GET_CODE_NAME(AREA)		 AREA
			FROM HR_DEPARTMENT
		 WHERE DEPTID = DEPT
		   AND HR_DEPARTMENT.DEPTNAME like '%支行%'
      union  
      SELECT DECODE(SUBSTR(DEPTID, 4, 1),
                  5,
                  'Y',
                  'N') DEPTNAME,
         GET_CODE_NAME(AREA)     AREA 				 
			FROM HR_DEPARTMENT
		 WHERE DEPTID = (select parent_dept_id from hr_department where deptid = DEPT)
		   AND HR_DEPARTMENT.DEPTNAME like '%支行%');
		EXCEPTION
		WHEN NO_DATA_FOUND
		THEN
		 	RETURN TIPDEPT;
		END;
		 
		 IF
		     ISPART = 'Y' THEN
				 
				BEGIN 
				SELECT SUBSTR(hr_get_level_deptname(DEPT,4),LENGTH(AREA)+1)
					INTO CURRENTDEPTNAME
					FROM DUAL;	 
					 
					TIPDEPT := TIPDEPT || CURRENTDEPTNAME; 
				EXCEPTION
				WHEN NO_DATA_FOUND
				THEN
				     TIPDEPT := TIPDEPT;
				END;
					 
		 END IF;
		 
	END;
	
	RETURN TIPDEPT;
END GET_TIP_DEPT_VR;
/

prompt
prompt Creating function HR_CONVERT
prompt ============================
prompt
CREATE OR REPLACE FUNCTION HR_CONVERT(str VARCHAR2) RETURN NVARCHAR2 IS
  processingVar Nvarchar2(4000);
  tmpVar        NVARCHAR2(4000);
  tmpVar2       NVARCHAR2(4000);
  uni_num       int;
BEGIN
  processingVar := str;
  while instr(processingVar, '&' || '#') > 0 loop
    tmpVar := substr(processingVar, instr(processingVar, '&' || '#'), 8);
    -- begin
    uni_num := to_number(replace(replace(tmpVar, ';'), '&' || '#'));
    tmpVar2 := chr(uni_num USING NCHAR_CS);
    --exception
    --  when others then
    --    tmpVar2 := replace(replace(tmpVar, ';'), '&' || '#');
    --end;
    processingVar := replace(processingVar, tmpVar, tmpVar2);
  end loop;
  RETURN processingVar;
EXCEPTION
  WHEN OTHERS THEN
    RAISE;
END HR_CONVERT;
/

prompt
prompt Creating function HR_EMPLOYEEID
prompt ===============================
prompt
CREATE OR REPLACE FUNCTION HR_EMPLOYEEID RETURN VARCHAR IS
  VAR_STR VARCHAR(50);

  VAR_COUNT NUMBER;
  VAR_TSTR  VARCHAR2(5000);
BEGIN

  SELECT COUNT(T.EMPLOYEEID)
    INTO VAR_COUNT
    FROM (SELECT SUBSTR(EMPID, 6, 3) EMPLOYEEID
            FROM HR_EMPLOYEE
           WHERE SUBSTR(EMPID, 2, 2) = TO_CHAR(SYSDATE, 'yy')
             AND LENGTH(EMPID) >= 8
                --111与112为手动录的工号有，特殊处理不在按111与112往后加1 2011-4-25 BY LIUZHENGYANG
             AND SUBSTR(EMPID, 6, 3) <> '111'
             AND SUBSTR(EMPID, 6, 3) <> '112'
           ORDER BY EMPID DESC) T
   WHERE ROWNUM = 1;
  IF VAR_COUNT > 0 THEN
    SELECT T.EMPLOYEEID
      INTO VAR_TSTR
      FROM (SELECT EMPLOYEEID
              FROM (SELECT SUBSTR(EMPID, 6, 3) EMPLOYEEID
                      FROM HR_EMPLOYEE
                     WHERE SUBSTR(EMPID, 2, 2) = TO_CHAR(SYSDATE, 'yy')
                       AND LENGTH(EMPID) >= 8
                       AND SUBSTR(EMPID, 6, 3) <> '111'
                       AND SUBSTR(EMPID, 6, 3) <> '112')
             ORDER BY EMPLOYEEID DESC
            
            ) T
     WHERE ROWNUM = 1;
  ELSE
    VAR_TSTR := '000';
  END IF;

  VAR_STR := TO_NUMBER(VAR_TSTR) + 1;
  IF LENGTH(VAR_STR) = 1 THEN
    VAR_STR := '00' || VAR_STR;
  END IF;
  IF LENGTH(VAR_STR) = 2 THEN
    VAR_STR := '0' || VAR_STR;
  END IF;

  -- select to_char((to_number(var_tstr)+1),'009') into var_str from dual;
  RETURN VAR_STR;
END;
/

prompt
prompt Creating function HR_GETBUSINESS
prompt ================================
prompt
CREATE OR REPLACE FUNCTION HR_GETBUSINESS(INEMPID VARCHAR2) RETURN VARCHAR2 IS
  BUSINESS VARCHAR2(500);
  STR_TEMP VARCHAR2(50);

  CURSOR CUS_HR IS
  SELECT SY.CODE_NAME AS BUSINESS_NAME 
    FROM HR_EMP_BUSINESS T, SY_CODE SY
   WHERE T.BIZ_CODE = SY.CODE_ID
     AND T.EMPID = INEMPID;

  ROW_CUS CUS_HR%ROWTYPE;
BEGIN
  BUSINESS := '';
  BEGIN
  OPEN CUS_HR;
  LOOP
    FETCH CUS_HR
    INTO ROW_CUS;
    EXIT WHEN CUS_HR%NOTFOUND;
    BUSINESS := BUSINESS || ',' || ROW_CUS.BUSINESS_NAME;
  END LOOP;
  CLOSE CUS_HR;
  
  END;
  BUSINESS := SUBSTR(BUSINESS, 2, LENGTH(BUSINESS));
  RETURN BUSINESS;
END HR_GETBUSINESS;
/

prompt
prompt Creating function HR_GETCURRDEPTDATE
prompt ====================================
prompt
CREATE OR REPLACE FUNCTION HR_GETCURRDEPTDATE(INEMPID VARCHAR2) RETURN DATE IS
  RETURNDATE DATE;
BEGIN

  BEGIN
    SELECT MAX(T.START_DATE)
      INTO RETURNDATE
      FROM HR_EXPERIENCE_INSIDE T
     WHERE (T.TRANS_CODE = 'TransRemove02' OR
           T.TRANS_CODE = 'TransRemove01' OR
           T.TRANS_CODE = 'TransRemove03')
       AND T.EMPID = INEMPID;
  
    IF RETURNDATE IS NULL THEN
      SELECT EMP.JOIN_DATE
        INTO RETURNDATE
        FROM HR_EMPLOYEE EMP
       WHERE EMP.EMPID = INEMPID;
    END IF;
  
  END;

  RETURN RETURNDATE;
END HR_GETCURRDEPTDATE;
/

prompt
prompt Creating function HR_GETDEPTFULLNAME
prompt ====================================
prompt
CREATE OR REPLACE FUNCTION hr_getDeptFullname (in_deptid IN VARCHAR2)
   RETURN Varchar2
Is
  v_deptname Varchar2(40);
  v_level    number;
  v_deptid   varchar2(20);
Begin
  Begin
  Select t.deptname,t.dept_level,t.parent_dept_id
    Into v_deptname,v_level,v_deptid
    From hr_department t
    Where t.deptid=in_deptid;

    if v_level>4 or v_deptid = '00134000'
       then v_deptname:=get_dept_name(v_deptid)||' '||v_deptname;
       dbms_output.put_line(v_deptid);
    end if;
    Exception
    When no_data_found
    Then
        v_deptname :=Null;


  End;

        Return v_deptname;
End hr_getDeptFullname;
/

prompt
prompt Creating function HR_GETDEPTQUOTAREALNUMBER
prompt ===========================================
prompt
CREATE OR REPLACE FUNCTION hr_getDeptQuotaRealNumber (incpnyId varchar2, indeptId varchar2, inpostId VARCHAR2)
  RETURN number
IS
  realNumber number;
BEGIN
  select count(*) into realNumber
  from hr_employee he
  where he.cpny_id = incpnyid
  and he.deptid = indeptId
  and he.post_id = inpostId
  and (he.left_date is not null or he.status_code<>'EmpStatus3')
  and he.activity = 1;

  RETURN realNumber;
END hr_getDeptQuotaRealNumber;
/

prompt
prompt Creating function HR_GETEMPLOYENDPROBATIONFLAG
prompt ==============================================
prompt
CREATE OR REPLACE FUNCTION hr_getEmployEndprobationFlag (inempid VARCHAR2)
  RETURN varchar
IS
   flag   varchar(20);
   amount   int;
BEGIN
 BEGIN
  select
  count(*) into amount
  from hr_employee  
  where empid=inempid
  and status_code in ('EmpStatus1','EmpStatus2');
  if amount=1 THEN
   flag:='1';
  else
   flag:='0';
   end if;
  END;
  RETURN flag;
END hr_getEmployEndprobationFlag;
/

prompt
prompt Creating function HR_GETPROMOTEDATE
prompt ===================================
prompt
CREATE OR REPLACE FUNCTION hr_getPromoteDate (inempid VARCHAR2)
   RETURN date
IS
   lastdate   date;
   ishave     number;
BEGIN
      select max(t.start_date) into lastdate
       from hr_experience_inside t
       where t.empid=inempid and t.activity=1;

   RETURN lastdate;
END hr_getPromoteDate;
/

prompt
prompt Creating function HR_GETQUALIFICATIONNUMBER
prompt ===========================================
prompt
CREATE OR REPLACE FUNCTION hr_getQualificationNumber (inempId VARCHAR2)
  RETURN number
IS
  qualificationNumber number;
BEGIN
  select count(*) into qualificationNumber
  from hr_qualification hrq
  where hrq.empid = inempId
  and hrq.activity = 1;

  RETURN qualificationNumber;
END hr_getQualificationNumber;
/

prompt
prompt Creating function HR_GET_BUSINESS
prompt =================================
prompt
CREATE OR REPLACE FUNCTION HR_GET_BUSINESS(IN_EMPID VARCHAR2)
  RETURN VARCHAR2 IS
  BUSINESS VARCHAR2(500); 

  CURSOR CUS_HR IS
    SELECT A.CODE_NAME BUSINESS_NAME
      FROM HR_ACT_BUSINESS T,SY_CODE A
     WHERE T.EMPID = IN_EMPID
       AND T.BIZ_CODE = A.CODE_ID(+);
  ROW_CUS CUS_HR%ROWTYPE;
  
BEGIN
  BUSINESS := '';
  BEGIN
    OPEN CUS_HR;
    LOOP
      FETCH CUS_HR
        INTO ROW_CUS;
      EXIT WHEN CUS_HR%NOTFOUND;
      BUSINESS := BUSINESS || ',' || ROW_CUS.BUSINESS_NAME;
    END LOOP;
    CLOSE CUS_HR;
  
  END;
  BUSINESS := SUBSTR(BUSINESS, 2, LENGTH(BUSINESS));
  RETURN BUSINESS;
END HR_GET_BUSINESS;
/

prompt
prompt Creating function HR_GET_CLASS
prompt ==============================
prompt
CREATE OR REPLACE FUNCTION hr_get_class (in_deptid IN VARCHAR2)
   RETURN VARCHAR2
IS
   v_parent       hr_department%ROWTYPE;
   out_class      VARCHAR2 (40);
   v_dept_level   hr_department.dept_level%TYPE;
BEGIN
-- 找到当前部门的部门等级
   BEGIN
      SELECT dept_level
        INTO v_dept_level
        FROM hr_department
       WHERE deptid = in_deptid;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_dept_level := NULL;
   END;

-- 如果当前部门的等级是5级,或者小于 5 ,就直接返回当前部门的名字
   IF v_dept_level = 5
   THEN
      BEGIN
         SELECT deptname
           INTO out_class
           FROM hr_department
          WHERE deptid = in_deptid;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            out_class := NULL;
      END;

      RETURN out_class;
   --如果部门的等级大于5,就继续查找其上级部门的名字
   ELSIF v_dept_level > 5
   THEN
      BEGIN
         SELECT *
           INTO v_parent
           FROM hr_department
          WHERE deptid = (SELECT parent_dept_id
                            FROM hr_department
                           WHERE deptid = in_deptid);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            v_parent := NULL;
      END;

      RETURN hr_get_class (v_parent.deptid);
   ELSE
      RETURN NULL;
   END IF;
END hr_get_class;
/

prompt
prompt Creating function HR_GET_COMPANY_ID
prompt ===================================
prompt
CREATE OR REPLACE FUNCTION hr_get_company_id (in_deptid IN VARCHAR2)
   RETURN VARCHAR2
IS
   v_company_id   VARCHAR2 (20);
BEGIN
   BEGIN
      SELECT cpny_id
        INTO v_company_id
        FROM hr_department
       WHERE deptid = in_deptid;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_company_id := 'lgnbm';
   END;

   RETURN v_company_id;
END hr_get_company_id;
/

prompt
prompt Creating function HR_GET_DEPTID
prompt ===============================
prompt
CREATE OR REPLACE FUNCTION hr_get_deptid (in_empid IN VARCHAR2)
   RETURN VARCHAR2
IS
   v_dept_id   VARCHAR2 (20);
BEGIN
   BEGIN
      SELECT deptid
        INTO v_dept_id
        FROM hr_employee
       WHERE empid = in_empid;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_dept_id := '100000000';
   END;

   RETURN v_dept_id;
END hr_get_deptid;
/

prompt
prompt Creating function HR_GET_COMPANY_NAMEBYEMPID
prompt ============================================
prompt
CREATE OR REPLACE FUNCTION hr_get_company_namebyempid (in_empid IN VARCHAR2)
   RETURN VARCHAR2
IS
   v_company_id     VARCHAR2 (20);
   v_company_name   VARCHAR2 (100);
BEGIN
   v_company_id := hr_get_company_id (hr_get_deptid (in_empid));

   BEGIN
      SELECT cpny_name
        INTO v_company_name
        FROM hr_company
       WHERE cpny_id = v_company_id;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_company_name := NULL;
   END;

   RETURN v_company_name;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      NULL;
   WHEN OTHERS
   THEN
      -- Consider logging the error and then re-raise
      RAISE;
END hr_get_company_namebyempid;
/

prompt
prompt Creating function HR_GET_DEPARTMENT
prompt ===================================
prompt
CREATE OR REPLACE FUNCTION hr_get_department (in_deptid IN VARCHAR2)
   RETURN VARCHAR2
IS
   v_parent         hr_department%ROWTYPE;
   out_department   VARCHAR2 (40);
   v_dept_level     hr_department.dept_level%TYPE;
BEGIN
-- 找到当前部门的部门等级
   BEGIN
      SELECT dept_level
        INTO v_dept_level
        FROM hr_department
       WHERE deptid = in_deptid;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_dept_level := NULL;
   END;

-- 如果当前部门的等级是一级,或者小于 1 ,就直接返回当前部门的名字
   IF v_dept_level <= 1
   THEN
      BEGIN
         SELECT deptname
           INTO out_department
           FROM hr_department
          WHERE deptid = in_deptid;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            out_department := NULL;
      END;

      RETURN out_department;
   --如果部门的等级大于1,就继续查找其上级部门的名字
   ELSIF v_dept_level > 1
   THEN
      BEGIN
         SELECT *
           INTO v_parent
           FROM hr_department
          WHERE deptid = (SELECT parent_dept_id
                            FROM hr_department
                           WHERE deptid = in_deptid);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            v_parent := NULL;
      END;

      RETURN hr_get_department (v_parent.deptid);
   END IF;
END hr_get_department;
/

prompt
prompt Creating function HR_GET_DEPT_BYEMP
prompt ===================================
prompt
CREATE OR REPLACE FUNCTION hr_get_dept_byemp (in_empid IN VARCHAR2, in_deptlevel IN INT)
   RETURN VARCHAR2
IS
   out_deptname       hr_department.deptname%TYPE;
   var_deptname_old   hr_department.deptname%TYPE;
   v_deptlevel        hr_department.dept_level%TYPE;
   v_deptid           hr_department.deptid%TYPE;
/******************************************************************************
   NAME:       hr_get_dept_byemp
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        02/15/2006   Pennix       1. Created this function.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     hr_get_dept_byemp
      Sysdate:         02/15/2006
      Date and Time:   02/15/2006, 16:20:00, and 02/15/2006 16:20:00
      Username:        Pennix (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
-- 找到当前部门的部门号与部门名称
   BEGIN
      SELECT deptid
        INTO v_deptid
        FROM hr_employee
       WHERE empid = in_empid;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         out_deptname := NULL;
         v_deptid := NULL;
   END;

-- 找到当前部门的部门等级与名称
   IF v_deptid IS NOT NULL
   THEN
      BEGIN
         SELECT dept_level, deptname
           INTO v_deptlevel, out_deptname
           FROM hr_department
          WHERE deptid = v_deptid;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            out_deptname := NULL;
            v_deptlevel := NULL;
      END;
   END IF;

--如果部门的等级大于请求部门等级,向上查找
   WHILE (v_deptlevel > in_deptlevel)
   LOOP
      var_deptname_old := out_deptname;

      SELECT deptname, dept_level, deptid
        INTO out_deptname, v_deptlevel, v_deptid
        FROM hr_department
       WHERE deptid = (SELECT hd.parent_dept_id
                         FROM hr_department hd
                        WHERE hd.deptid = v_deptid);
   END LOOP;

--如果当前等级小于请求部门等级,将结果还原为下级部门;
   IF (v_deptlevel < in_deptlevel)
   THEN
      out_deptname := var_deptname_old;
   END IF;

   RETURN out_deptname;
END hr_get_dept_byemp;
/

prompt
prompt Creating function HR_GET_FLEVEL_DEPTID
prompt ======================================
prompt
CREATE OR REPLACE FUNCTION hr_get_FLevel_deptid (in_deptid IN VARCHAR2)
   RETURN Varchar2
Is
  v_deptid Varchar2(40);
  v_level    number;
Begin
  Begin
    Select t.dept_level,deptid
      Into v_level,v_deptid
      From hr_department t
      Where t.deptid=in_deptid;
    if v_level>4 then
    select
    deptid into v_deptid
    from hr_department
    where deptid=(
    select parent_dept_id from hr_department where deptid=in_deptid);
    end if;
    Exception
    When no_data_found
    Then
        v_deptid :=Null;


  End;

        Return v_deptid;
End hr_get_FLevel_deptid;
/

prompt
prompt Creating function HR_GET_FLEVEL_DEPTNAME
prompt ========================================
prompt
CREATE OR REPLACE FUNCTION HR_GET_FLEVEL_DEPTNAME(IN_DEPTID IN VARCHAR2)
  RETURN VARCHAR2 IS
  V_DEPTNAME VARCHAR2(40);
  V_LEVEL    NUMBER;
  V_PARENTID VARCHAR2(40);
BEGIN
  BEGIN
    SELECT T.DEPT_LEVEL, DEPTNAME, PARENT_DEPT_ID
      INTO V_LEVEL, V_DEPTNAME, V_PARENTID
      FROM HR_DEPARTMENT T
     WHERE T.DEPTID = IN_DEPTID;
    IF V_LEVEL > 4 OR V_PARENTID = '00134000' THEN
      SELECT DEPTNAME
        INTO V_DEPTNAME
        FROM HR_DEPARTMENT
       WHERE DEPTID = (SELECT PARENT_DEPT_ID
                         FROM HR_DEPARTMENT
                        WHERE DEPTID = IN_DEPTID);
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      V_DEPTNAME := NULL;
    
  END;

  RETURN V_DEPTNAME;
END HR_GET_FLEVEL_DEPTNAME;
/

prompt
prompt Creating function HR_GET_FULL_DEPTNAME2
prompt =======================================
prompt
CREATE OR REPLACE FUNCTION hr_get_full_deptname2 (v_deptid IN VARCHAR2)
   RETURN VARCHAR2
IS
   v_full_deptname   VARCHAR2 (300);
   v_parent          hr_department%ROWTYPE;
   v_deptname        hr_department.deptname%TYPE;
   v_deptcode        hr_department.deptid%TYPE;
   in_deptid        hr_department.deptid%TYPE;
BEGIN
  in_deptid :=hr_get_level_deptid(v_deptid,8);
   BEGIN
      SELECT deptname
        INTO v_deptname
        FROM hr_department
       WHERE deptid = in_deptid;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_deptname := NULL;
   END;

   v_full_deptname := v_deptname;

   BEGIN
      SELECT *
        INTO v_parent
        FROM hr_department
       WHERE deptid = (SELECT parent_dept_id
                         FROM hr_department
                        WHERE deptid = in_deptid);
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_parent := NULL;
   END;

   IF v_parent.dept_level >1
  -- IF v_parent.dept_level >2
   THEN
      v_full_deptname :=
            hr_get_full_deptname2 (v_parent.deptid) || '   '
            || v_full_deptname;
   ELSE
      v_full_deptname := v_full_deptname;
   END IF;

   RETURN v_full_deptname;
END hr_get_full_deptname2;
/

prompt
prompt Creating function HR_GET_FULL_PART_NAME
prompt =======================================
prompt
CREATE OR REPLACE FUNCTION hr_get_full_part_name (in_deptid IN VARCHAR2)
   RETURN Varchar2
Is
  v_deptname Varchar2(100);
  v_dept_sort_name Varchar2(100);
  v_level    number;
  v_deptid   varchar2(20);
Begin
  Begin
  Select get_dept_name(t.parent_dept_id)/*||' > '||t.deptname*/,t.deptname,t.dept_level,t.parent_dept_id
    Into v_deptname,v_dept_sort_name,v_level,v_deptid
    From hr_department t
    Where t.deptid=''|| in_deptid||'';

    if v_level<=4
       then v_deptname:=v_dept_sort_name;
    end if;
    Exception
    When no_data_found
    Then
        v_deptname :=Null;
  End;

        Return v_deptname;
End hr_get_full_part_name;
/

prompt
prompt Creating function HR_GET_FULL_PART_NAME_TWO
prompt ===========================================
prompt
CREATE OR REPLACE FUNCTION hr_get_full_part_name_two (in_deptid IN VARCHAR2)
   RETURN Varchar2
Is
  v_deptname Varchar2(100);
	v_dept_sort_name Varchar2(100);
  v_level    number;
  v_deptid   varchar2(20);
Begin
  Begin
  Select get_dept_name(t.parent_dept_id)||' '||t.deptname,t.deptname,t.dept_level,t.parent_dept_id
    Into v_deptname,v_dept_sort_name,v_level,v_deptid
    From hr_department t
    Where t.deptid=in_deptid;

    if v_level<=4
       then v_deptname:=v_dept_sort_name;
    end if;
    Exception
    When no_data_found
    Then
        v_deptname :=Null;
  End;

        Return v_deptname;
End hr_get_full_part_name_two;
/

prompt
prompt Creating function HR_GET_MONTH_END
prompt ==================================
prompt
CREATE OR REPLACE FUNCTION hr_get_month_end (in_month IN VARCHAR2)
   RETURN DATE
IS
   v_stat_end_date   ar_statistic_date.end_date%TYPE;
BEGIN
   BEGIN
      SELECT TO_CHAR (TO_DATE (end_date, 'DD'), 'DD')
        INTO v_stat_end_date
        FROM ar_statistic_date
       WHERE ROWNUM = 1;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_stat_end_date := 20;
   END;

   RETURN TO_DATE (in_month || v_stat_end_date, 'YYYY-MM-DD');
END hr_get_month_end;
/

prompt
prompt Creating function HR_GET_MONTH_START
prompt ====================================
prompt
CREATE OR REPLACE FUNCTION hr_get_month_start (in_month IN VARCHAR2)
   RETURN DATE
IS
   v_stat_start_date   ar_statistic_date.end_date%TYPE;
BEGIN
   BEGIN
      SELECT TO_CHAR (TO_DATE (start_date, 'DD'), 'DD')
        INTO v_stat_start_date
        FROM ar_statistic_date
       WHERE ROWNUM = 1;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_stat_start_date := 21;
   END;

   RETURN ADD_MONTHS (TO_DATE (in_month || v_stat_start_date, 'YYYY-MM-DD'),
                      -1
                     );
END hr_get_month_start;
/

prompt
prompt Creating function HR_GET_NAME
prompt =============================
prompt
CREATE OR REPLACE FUNCTION hr_get_name (in_empid IN VARCHAR2)
   RETURN VARCHAR2
IS
   emp_name   VARCHAR2 (40);
BEGIN
   BEGIN
      SELECT chinesename
        INTO emp_name
        FROM hr_employee
       WHERE empid = in_empid;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         emp_name := NULL;
   END;

   RETURN emp_name;
END hr_get_name;
/

prompt
prompt Creating function HR_GET_PART
prompt =============================
prompt
CREATE OR REPLACE FUNCTION hr_get_part (in_deptid IN VARCHAR2)
   RETURN VARCHAR2
IS
   v_parent       hr_department%ROWTYPE;
   out_part       VARCHAR2 (40);
   v_dept_level   hr_department.dept_level%TYPE;
BEGIN
-- 找到当前部门的部门等级
   BEGIN
      SELECT dept_level
        INTO v_dept_level
        FROM hr_department
       WHERE deptid = in_deptid;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_dept_level := NULL;
   END;

-- 如果当前部门的等级是3级,或者小于 3,就直接返回当前部门的名字
   IF v_dept_level = 4
   THEN
      BEGIN
         SELECT deptname
           INTO out_part
           FROM hr_department
          WHERE deptid = in_deptid;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            out_part := NULL;
      END;

      RETURN out_part;
   --如果部门的等级大于3,就继续查找其上级部门的名字
   ELSIF v_dept_level > 4
   THEN
      BEGIN
         SELECT *
           INTO v_parent
           FROM hr_department
          WHERE deptid = (SELECT parent_dept_id
                            FROM hr_department
                           WHERE deptid = in_deptid);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            v_parent := NULL;
      END;

      RETURN hr_get_part (v_parent.deptid);
   ELSE
      RETURN NULL;
   END IF;
END hr_get_part;
/

prompt
prompt Creating function HR_GET_PART_NAME
prompt ==================================
prompt
CREATE OR REPLACE FUNCTION hr_get_part_name (in_deptid IN VARCHAR2)
   RETURN Varchar2
Is
  v_deptname Varchar2(40);
  v_level    number;
  v_deptid   varchar2(20);
Begin
  Begin
  Select t.deptname,t.dept_level,t.parent_dept_id
    Into v_deptname,v_level,v_deptid
    From hr_department t
    Where t.deptid=in_deptid;

    if v_level<=4
       then v_deptname:='无';
    end if;
    Exception
    When no_data_found
    Then
        v_deptname :=Null;

    
  End;

        Return v_deptname;
End hr_get_part_name;
/

prompt
prompt Creating function HR_GET_TEAM
prompt =============================
prompt
CREATE OR REPLACE FUNCTION hr_get_team (in_deptid IN VARCHAR2)
   RETURN VARCHAR2
IS
   v_parent       hr_department%ROWTYPE;
   out_team       VARCHAR2 (40);
   v_dept_level   hr_department.dept_level%TYPE;
BEGIN
-- 找到当前部门的部门等级
   BEGIN
      SELECT dept_level
        INTO v_dept_level
        FROM hr_department
       WHERE deptid = in_deptid;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_dept_level := NULL;
   END;

-- 如果当前部门的等级是 2 级,或者小于 2 ,就直接返回当前部门的名字
   IF v_dept_level = 2
   THEN
      BEGIN
         SELECT deptname
           INTO out_team
           FROM hr_department
          WHERE deptid = in_deptid;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            out_team := NULL;
      END;

      RETURN out_team;
   --如果部门的等级大于2,就继续查找其上级部门的名字
   ELSIF v_dept_level > 2
   THEN
      BEGIN
         SELECT *
           INTO v_parent
           FROM hr_department
          WHERE deptid = (SELECT parent_dept_id
                            FROM hr_department
                           WHERE deptid = in_deptid);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            v_parent := NULL;
      END;

      RETURN hr_get_team (v_parent.deptid);
   ELSE
      RETURN NULL;
   END IF;
END hr_get_team;
/

prompt
prompt Creating function HR_GET_ROOM
prompt =============================
prompt
CREATE OR REPLACE FUNCTION hr_get_room (in_deptid IN VARCHAR2)
   RETURN VARCHAR2
IS
   v_parent       hr_department%ROWTYPE;
   out_room       VARCHAR2 (40);
   v_dept_level   hr_department.dept_level%TYPE;
BEGIN
-- 找到当前部门的部门等级
   BEGIN
      SELECT dept_level
        INTO v_dept_level
        FROM hr_department
       WHERE deptid = in_deptid;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_dept_level := NULL;
   END;

-- 如果当前部门的等级是4级,或者小于 4 ,就直接返回当前部门的名字
   IF v_dept_level = 4
   THEN
      BEGIN
         SELECT deptname
           INTO out_room
           FROM hr_department
          WHERE deptid = in_deptid;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            out_room := NULL;
      END;

      RETURN out_room;
   --如果部门的等级大于4,就继续查找其上级部门的名字
   ELSIF v_dept_level > 4
   THEN
      BEGIN
         SELECT *
           INTO v_parent
           FROM hr_department
          WHERE deptid = (SELECT parent_dept_id
                            FROM hr_department
                           WHERE deptid = in_deptid);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            v_parent := NULL;
      END;

      RETURN hr_get_room (v_parent.deptid);
   ELSE
      RETURN hr_get_team(in_deptid);
   END IF;
END hr_get_room;
/

prompt
prompt Creating function HR_GET_ROOMID
prompt ===============================
prompt
CREATE OR REPLACE FUNCTION hr_get_roomid(in_deptid IN VARCHAR2)
   RETURN VARCHAR2
IS
   v_parent       hr_department%ROWTYPE;
   out_room       VARCHAR2 (40);
    out_id       VARCHAR2 (40);
   v_dept_level   hr_department.dept_level%TYPE;
BEGIN
-- 找到当前部门的部门等级
   BEGIN
      SELECT dept_level
        INTO v_dept_level
        FROM hr_department
       WHERE deptid = in_deptid;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_dept_level := NULL;
   END;

-- 如果当前部门的等级是4级,或者小于 4 ,就直接返回当前部门的名字
   IF v_dept_level = 4
   THEN
      BEGIN
         SELECT deptname
           INTO out_room
           FROM hr_department
          WHERE deptid = in_deptid;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            out_room := NULL;
      END;


    
   IF out_room LIKE '北京%'
      THEN out_id := '11' || out_room;
   ELSIF out_room LIKE '上海%'
      THEN out_id := '22' || out_room;
   ELSIF out_room LIKE '深圳%'
      THEN out_id := '33' || out_room;
   ELSIF out_room LIKE '苏州%'
      THEN out_id := '44' || out_room;
   ELSIF out_room LIKE '天津%'
      THEN out_id := '55' || out_room;
   END IF;

      RETURN out_id;
   --如果部门的等级大于4,就继续查找其上级部门的名字
   ELSIF v_dept_level > 4
   THEN
      BEGIN
         SELECT *
           INTO v_parent
           FROM hr_department
          WHERE deptid = (SELECT parent_dept_id
                            FROM hr_department
                           WHERE deptid = in_deptid);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            v_parent := NULL;
      END;

      RETURN hr_get_roomid(v_parent.deptid);
   ELSE
      RETURN NULL;
   END IF;
END hr_get_roomid;
/

prompt
prompt Creating function HR_PARENT_DEPTIDEX
prompt ====================================
prompt
CREATE OR REPLACE FUNCTION hr_parent_deptidex(in_deptid VARCHAR2)
   RETURN NUMBER
IS
   v_deptid    NUMBER;
BEGIN
    -- v_deptid := in_deptid;
   BEGIN
      SELECT COUNT(*) INTO V_DEPTID
                 FROM hr_department
      START WITH deptid = in_deptid
      CONNECT BY PRIOR deptid = parent_dept_id;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         V_DEPTID := 1;
   END;

   RETURN V_DEPTID;
END hr_parent_deptidex;
/

prompt
prompt Creating function HR_PUT_DEPT_SPACE
prompt ===================================
prompt
CREATE OR REPLACE FUNCTION hr_put_dept_space (in_deptid IN VARCHAR2)
   RETURN VARCHAR2
IS
   spaces         VARCHAR2 (20);
   v_dept_level   hr_department.dept_level%TYPE;
BEGIN
   BEGIN
      SELECT dept_level
        INTO v_dept_level
        FROM hr_department
       WHERE deptid = in_deptid;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_dept_level := 0;
   END;

   FOR i IN 1 .. v_dept_level
   LOOP
      spaces := spaces || '   ';
   END LOOP;

   RETURN spaces;
END hr_put_dept_space;
/

prompt
prompt Creating function HR_TRIM_DEPTID
prompt ================================
prompt
CREATE OR REPLACE FUNCTION hr_trim_deptid (
   in_deptid   IN   VARCHAR2,
   trimed      IN   CHAR
)
   RETURN VARCHAR2
IS
   v_deptid   VARCHAR2 (20);
BEGIN
   v_deptid := in_deptid;

   IF (SUBSTR (v_deptid, LENGTH (v_deptid), 1) = trimed)
   THEN
      v_deptid := SUBSTR (v_deptid, 0, LENGTH (v_deptid) - 1);
      RETURN hr_trim_deptid (v_deptid, trimed);
   ELSE
      RETURN v_deptid;
   END IF;
END hr_trim_deptid;
/

prompt
prompt Creating function HR_UPDATE_EXP_INSIDE
prompt ======================================
prompt
CREATE OR REPLACE FUNCTION hr_update_exp_inside (
   POSITION   VARCHAR2,
   inempid    VARCHAR2
)
   RETURN NUMBER
IS
   tmpvar            NUMBER;
   v_position_code   VARCHAR2 (50) := NULL;
BEGIN
/* 先查询社内经历的初始状态中的岗位是否为空
activity=5 的社内经历为入社状态(社内经历的初始状态)*/
   BEGIN
      SELECT position_ID
        INTO v_position_code
        FROM hr_experience_inside
       WHERE empid = inempid AND activity = 5;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         v_position_code := NULL;
   END;

   IF v_position_code IS NULL
   THEN
      UPDATE hr_experience_inside
         SET position_ID = POSITION
       WHERE activity = 5 AND empid = inempid;

      RETURN 1;
      COMMIT;
   ELSE
      RETURN 0;
   END IF;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      NULL;
   WHEN OTHERS
   THEN
      -- Consider logging the error and then re-raise
      RAISE;
END hr_update_exp_inside;
/

prompt
prompt Creating function ISNUMBER
prompt ==========================
prompt
CREATE OR REPLACE FUNCTION isnumber (ch VARCHAR2)
   RETURN INTEGER
IS
   flag    INTEGER;
   v_num   NUMBER;
BEGIN
   flag := 1;

   BEGIN
      SELECT TO_NUMBER (ch)
        INTO v_num
        FROM DUAL;
   EXCEPTION
      WHEN OTHERS
      THEN
         flag := 0;
   END;

   RETURN flag;
END;
/

prompt
prompt Creating function LOTTE_GET_D2LEAVE_LENGTH
prompt ==========================================
prompt
CREATE OR REPLACE FUNCTION LOTTE_GET_D2LEAVE_LENGTH
(
 IN_EMPID        VARCHAR2,
 LEAVE_FROM_TIME VARCHAR2,
 LEAVE_TO_TIME   VARCHAR2

)RETURN NUMBER IS
 VAR_APPLY_LENGTH    NUMBER;
  VAR_SHIFT_NO        NUMBER;
  VAR_IN_DATE         DATE;
  VAR_LEAVE_FROM_TIME DATE;
 VAR_LEAVE_TO_TIME   DATE;
  BEGIN
 VAR_APPLY_LENGTH := 0;
 --leave apply start date
 VAR_LEAVE_FROM_TIME := TO_DATE(LEAVE_FROM_TIME, 'YYYY/MM/DD HH24:MI:SS');
 --leave apply end date
 VAR_LEAVE_TO_TIME := TO_DATE(LEAVE_TO_TIME, 'YYYY/MM/DD HH24:MI:SS');

 VAR_IN_DATE := VAR_LEAVE_FROM_TIME;
  
 --请假日期时间段循环
 WHILE VAR_LEAVE_TO_TIME >= VAR_IN_DATE
   LOOP
  VAR_SHIFT_NO := AR_GET_SHIFTNO(IN_EMPID, TO_CHAR(VAR_IN_DATE, 'YYYY/MM/DD'));
    
      IF VAR_SHIFT_NO <> 26 THEN
      
       VAR_APPLY_LENGTH := VAR_APPLY_LENGTH+1;
       
      END IF;
       VAR_IN_DATE := VAR_IN_DATE + 1; 
       
    END LOOP;
    
     RETURN VAR_APPLY_LENGTH;
      
  EXCEPTION
  
 WHEN NO_DATA_FOUND THEN
  
 VAR_APPLY_LENGTH := 0;
  
 WHEN OTHERS THEN
  RAISE;

 END LOTTE_GET_D2LEAVE_LENGTH;
/

prompt
prompt Creating function MERGETIME
prompt ===========================
prompt
CREATE OR REPLACE FUNCTION mergetime (v_date DATE, v_time DATE)
   RETURN DATE
IS
   v_new_datetime   DATE;
BEGIN
   v_new_datetime :=
      TO_DATE (   TO_CHAR (v_date, 'YYYY/MM/DD')
               || ' '
               || TO_CHAR (v_time, 'HH24:MI:SS'),
               'YYYY/MM/DD HH24:MI:SS'
              );
   RETURN v_new_datetime;
END;
/

prompt
prompt Creating function NEXT_PAMONTH
prompt ==============================
prompt
CREATE OR REPLACE FUNCTION next_pamonth (pa_month_str VARCHAR2)
   RETURN VARCHAR2
IS
   RESULT   VARCHAR2 (6);
   v_mon    VARCHAR2 (2);
   v_year   VARCHAR2 (4);
BEGIN
   v_mon := SUBSTR (pa_month_str, 5, 2);
   v_year := SUBSTR (pa_month_str, 1, 4);

   IF v_mon < 12
   THEN
      v_mon := v_mon + 1;
   ELSE
      v_year := v_year + 1;
      v_mon := '01';
   END IF;

   IF LENGTH (v_mon) = 1
   THEN
      v_mon := '0' || v_mon;
   END IF;

   RESULT := v_year || v_mon;
   RETURN (RESULT);
END next_pamonth;
/

prompt
prompt Creating function PA_FORMAT_VAL
prompt ===============================
prompt
CREATE OR REPLACE FUNCTION PA_FORMAT_VAL (in_val NUMBER)
   RETURN VARCHAR2
IS
   v_result		    VARCHAR2(100);
BEGIN
   
   BEGIN

   SELECT DECODE(in_val,0,'0.00',trim(to_char(in_val,'999,999,999,999,999,999,999,999.99')))
     INTO v_result
     FROM DUAL;
   EXCEPTION
        WHEN OTHERS
        THEN
		   RETURN in_val;
   END;
   
   RETURN v_result;
	   
END PA_FORMAT_VAL;
/

prompt
prompt Creating function PA_GET_BASIC_ITEM_VAL
prompt =======================================
prompt
CREATE OR REPLACE FUNCTION PA_GET_BASIC_ITEM_VAL (in_empid VARCHAR2, in_item_id VARCHAR2, in_date VARCHAR2)
   RETURN NUMBER
IS
   v_item_no  	    INT;
   v_result		    NUMBER;
BEGIN
   
   BEGIN
   /*取得项目No*/
   SELECT ITEM_NO
     INTO v_item_no
     FROM PA_BASIC_ITEM
	WHERE ITEM_ID = in_item_id;
   EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
		   RETURN 0;
   END;
   
  /*如果不存在该员工基础项目数据，返回0*/
  SELECT COUNT(*)
    INTO v_result
    FROM PA_BASIC_DATA A
   WHERE A.FIELD1_VALUE = in_empid
	 AND A.ITEM_NO 		= v_item_no;
  
  IF v_result = 0
  THEN 
  	   RETURN 0;
  END IF;
	  
  BEGIN
   /*取得该员工基础项目数据*/
  SELECT RETURN_VALUE
    INTO v_result
    FROM PA_BASIC_DATA A
   WHERE A.FIELD1_VALUE = in_empid
     AND TO_DATE(in_date, 'YYYY-MM-DD') BETWEEN A.START_DATE AND NVL(A.END_DATE, TO_DATE('9999-12-31','YYYY-MM-DD'))
	 AND A.ITEM_NO = v_item_no;
   EXCEPTION
        WHEN NO_DATA_FOUND
        THEN
		   RETURN 0;
   END;
   
   RETURN v_result;
	   
END PA_GET_BASIC_ITEM_VAL;
/

prompt
prompt Creating function PA_GET_PAY_MONTH
prompt ==================================
prompt
CREATE OR REPLACE FUNCTION pa_get_pay_month(pa_month IN VARCHAR2,pa_empid IN VARCHAR)
   RETURN Varchar2
Is
  v_month_pay Varchar2(40);
Begin
  Begin
     SELECT PAY_MONTH INTO v_month_pay
     FROM (SELECT * FROM PAY_TENEMENT_ALLOWANCE ORDER BY EMPID, PAY_MONTH DESC)
     WHERE EMPID = pa_empid
     AND pay_month = pa_month;

    Exception
    When no_data_found
    Then
        v_month_pay :=Null;
        End;

        Return v_month_pay;
End pa_get_pay_month;
/

prompt
prompt Creating function PA_GET_PRE_TAX
prompt ================================
prompt
CREATE OR REPLACE FUNCTION Pa_Get_Pre_Tax (IN_EMPID VARCHAR2, IN_AR_MONTH VARCHAR2)
    RETURN NUMBER
IS
    Tax            NUMBER;

BEGIN

-- SELECT "实际计算个税" INTO Tax
--   FROM PA_HISTORY
--  WHERE "工资月" = TO_CHAR(TO_DATE(IN_AR_MONTH,'YYYYMM')-1,'YYYYMM')
--    AND "工号" = IN_EMPID;

 RETURN Tax;
     
   EXCEPTION
       WHEN NO_DATA_FOUND THEN
           RETURN 0;
    WHEN OTHERS THEN
           RETURN 0;

END Pa_Get_Pre_Tax;
/

prompt
prompt Creating function PA_PROMOTION_CHANGE
prompt =====================================
prompt
CREATE OR REPLACE FUNCTION PA_Promotion_Change(in_empid VARCHAR2,in_evs_bl number)
   RETURN number
IS
  -- v_trans_code    VARCHAR2(20)  := 'TransCode_130'; -- 晋升
   v_start_date       date;    --晋升日期
   v_Sdate            date;    --区间开始日期
   v_Edate            date;    --区间结束日期
   v_return_value_ago number;  --晋升前年薪
   v_result_ago        number;  --晋升前工资
   v_pro_month        number;  --晋升前整月分
   v_pro_day        number;       --晋升不是整月时，的上班天数
   v_result_deduct_ago   number; --晋升前缺勤天数
   v_return_value_after  number;  --晋升后年薪
   v_result_deduct_after   number; --晋升后缺勤天数
   v_result_after        number;  --晋升后工资
   v_result         NUMBER := 0;
   v_last_year     VARCHAR2(10):=TO_CHAR(SYSDATE,'yyyy')-1;
   v_this_year     VARCHAR2(10):=TO_CHAR(SYSDATE,'yyyy');
   v_month         VARCHAR2(10):=TO_CHAR(SYSDATE,'MM');
   v_flag         number;--1表示有晋升后没有调薪
   v_diaoxin_flag       number;--1表示有晋升后有调薪
   v_diaoxin_flag2       number;--1表示有调薪
   -- 2010 年 3 月 Zengaiwu
BEGIN
 BEGIN
     IF v_month<=6 THEN
       v_Sdate := TO_DATE(v_last_year||'-07-01','YYYY-MM-DD');
       v_Edate := TO_DATE(v_last_year||'-12-31','YYYY-MM-DD');
   ELSIF v_month>6 THEN
       v_Sdate := TO_DATE(v_this_year||'-01-01','YYYY-MM-DD');
       v_Edate := TO_DATE(v_this_year||'-06-30','YYYY-MM-DD');
     END IF ;
     ---判断晋升后有没有调薪， v_flag ：1表示有晋升后没有调薪，0表示晋升后有调薪
     BEGIN

     select count(pa.start_date)
        into v_flag
     from pa_basic_data pa,HR_EXPERIENCE_INSIDE hei
    where pa.field1_value = hei.empid
      and pa.field1_value = in_empid
      and item_no = '42'
      and hei.TRANS_CODE = 'TransCode_130'
      and hei.start_date = pa.start_date
      --and pa.end_date is null
      and pa.start_date between v_Sdate and v_Edate ;

    select count(pa.start_date)
        into v_diaoxin_flag
     from pa_basic_data pa,HR_EXPERIENCE_INSIDE hei
    where pa.field1_value = hei.empid
      and pa.field1_value = in_empid
      and item_no = '42'
      and hei.TRANS_CODE = 'TransCode_130'
      and hei.start_date < pa.start_date
      --and pa.end_date is null
      and pa.start_date between v_Sdate and v_Edate;
     
       select count(pa.start_date)
        into v_diaoxin_flag2
     from pa_basic_data pa
    where pa.field1_value = in_empid
      and item_no = '42'
      --and pa.end_date is null
      and pa.start_date between v_Sdate and v_Edate;


     END;
  IF  v_flag >0  THEN 
  /*验证在该区间内 的 晋升前年薪 */
   --没有调薪,直接取晋升前年薪
      IF v_flag>0 and v_diaoxin_flag=0 THEN
      select nvl(return_value,0) into v_return_value_ago from (select pa.return_value,pa.start_date,pa.end_date from pa_basic_data pa,HR_EXPERIENCE_INSIDE hei
    where pa.field1_value = hei.empid
      and pa.field1_value = in_empid
      and item_no = '42'
      and hei.TRANS_CODE = 'TransCode_130'
      and pa.start_date< hei.start_date
      and pa.end_date between v_Sdate and v_Edate
      order by pa.end_date desc) where rownum = 1 ;
      BEGIN
      IF v_return_value_ago IS NULL THEN
           select nvl(return_value,0) into v_return_value_ago from (select pa.return_value,pa.start_date,pa.end_date from pa_basic_data pa,HR_EXPERIENCE_INSIDE hei
    where pa.field1_value = hei.empid
      and pa.field1_value = in_empid
      and item_no = '42'
      and hei.TRANS_CODE = 'TransCode_130'
      and pa.start_date<=hei.start_date
      and pa.end_date between v_Sdate and v_Edate
      order by pa.end_date desc) where rownum = 1 ;
      END IF ;
      END;
   --有调薪，取晋升前一条年薪
    ELSIF v_flag>0 and v_diaoxin_flag>0 THEN
   select nvl(return_value,0) into v_return_value_ago from (select pa.return_value,pa.start_date,pa.end_date from pa_basic_data pa,HR_EXPERIENCE_INSIDE hei
    where pa.field1_value = hei.empid
      and pa.field1_value = in_empid
      and item_no = '42'
      and hei.TRANS_CODE = 'TransCode_130'
      and pa.end_date is not null
      and hei.start_date > pa.start_date
      and pa.end_date between v_Sdate-1 and v_Edate
      order by pa.end_date desc) where rownum = 1 ;
     BEGIN
      IF v_return_value_ago IS NULL THEN
           select nvl(return_value,0) into v_return_value_ago from (select pa.return_value,pa.start_date,pa.end_date from pa_basic_data pa,HR_EXPERIENCE_INSIDE hei
    where pa.field1_value = hei.empid
      and pa.field1_value = in_empid
      and item_no = '42'
      and hei.TRANS_CODE = 'TransCode_130'
      and pa.start_date<=hei.start_date
      and pa.end_date between v_Sdate-1 and v_Edate
      order by pa.end_date desc) where rownum = 1 ;
      END IF ;
      END;
    END IF ;
    -----晋升前年薪结束

  /*验证在该区间内 的 晋升后年薪,晋升日期*/
   BEGIN
   IF  v_flag>0 and v_diaoxin_flag=0 THEN
  /*晋升后无调薪的情况:直接取晋升后的工资，晋升的生效日期*/
  select return_value,pa.start_date into v_return_value_after,v_start_date from pa_basic_data pa,HR_EXPERIENCE_INSIDE hei
    where pa.field1_value = hei.empid
      and pa.field1_value = in_empid
      and item_no = '42'
      and hei.TRANS_CODE = 'TransCode_130'
      and hei.start_date = pa.start_date
      --and pa.end_date is null
      and pa.start_date between v_Sdate and v_Edate;
  ELSIF  v_flag>0 and v_diaoxin_flag>0 THEN
  /*晋升后有调薪的情况:上面的SELECT肯定为NULL,直接取调薪后的工资，晋升的生效日期*/
    BEGIN
      --- 取晋升的生效日期
  select start_date into v_start_date from(select pa.start_date from pa_basic_data pa,HR_EXPERIENCE_INSIDE hei
    where pa.field1_value = hei.empid
      and pa.field1_value = in_empid
      and item_no = '42'
      and hei.TRANS_CODE = 'TransCode_130'
      and hei.start_date = pa.start_date
     -- and pa.end_date is not null
      and pa.start_date between v_Sdate and v_Edate
      order by pa.end_date desc) where rownum = 1;
      --取调薪后的年薪
      
  select max(return_value) into v_return_value_after from pa_basic_data pa,HR_EXPERIENCE_INSIDE hei
    where pa.field1_value = hei.empid
      and pa.field1_value = in_empid
      and item_no = '42'
      and hei.TRANS_CODE = 'TransCode_130'
      and hei.start_date < pa.start_date
      --and pa.end_date is null
      and pa.start_date between v_Sdate and v_Edate;
    END;
   END IF;
  END ;

  /* 取晋升前的天数
   晋升日期 到 区间开始日期相差的月份 取整 晋升日期是1号的 正好*/
  select trunc(MONTHS_BETWEEN(pa.start_date,v_Sdate),0) into v_pro_month  from pa_basic_data pa,HR_EXPERIENCE_INSIDE hei
    where pa.field1_value = hei.empid
      and pa.field1_value = in_empid
      and item_no = '42'
      and hei.TRANS_CODE = 'TransCode_130'
      and hei.start_date = pa.start_date
      and pa.start_date between v_Sdate and v_Edate;

  /*如果晋升日期不是1号 ，则加上 晋升日期当月的天数 */
 select count(typeid)
      into v_pro_day
      from ar_calender
      where ddate between add_months(last_day(v_start_date),-1)+1 and
       v_start_date-1  and typeid <> 2;

  /*晋升前缺勤天数*/
   SELECT NVL(SUM (T.QUANTITY), 0) / 8
   INTO v_result_deduct_ago
   FROM AR_DETAIL T,
       HR_EMPLOYEE E
  WHERE T.AR_ITEM_NO IN (8, 14, 20,16)
    AND T.EMPID = in_empid
    AND T.EMPID = E.EMPID
    AND T.SHIFT_NO<>2
    AND TO_DATE(AR_DATE_STR,'YYYY-MM-DD') between v_Sdate and v_start_date;

     /*晋升后缺勤天数*/
   SELECT NVL(SUM (T.QUANTITY), 0) / 8
   INTO v_result_deduct_after
   FROM AR_DETAIL T,
       HR_EMPLOYEE E
  WHERE T.AR_ITEM_NO IN (14,20,8,16)
    AND T.EMPID = in_empid
    AND T.EMPID = E.EMPID
    AND T.SHIFT_NO<>2
    AND TO_DATE(AR_DATE_STR,'YYYY-MM-DD') between v_start_date and v_Edate;

 /*晋升前工资 = 晋升前年薪/12/130.5 * 晋升前工作天数 * 考核比率 - 晋升前年薪/12/130.5*晋升前缺勤天数 * 考核比率
   晋升前工作天数+晋升前未满整月天数 - 缺勤天数*/
  --  v_result_ago := trunc(trunc(v_return_value_ago/12,2)/130.5 ,2) * (v_pro_month * 21.75+v_pro_day-v_result_deduct_ago) ;-- * in_evs_bl;
    v_result_ago := trunc(trunc(trunc(trunc(trunc(v_return_value_ago/12,2)/130.5 ,2) * (v_pro_month * 21.75+v_pro_day),2) * in_evs_bl,2) -trunc(trunc(trunc(trunc(v_return_value_ago/12,2)/130.5 ,2)* v_result_deduct_ago,2)*in_evs_bl,2),2) ;-- * in_evs_bl;
  /*晋升后工资*/
    v_result_after :=trunc(trunc(trunc(trunc(trunc(v_return_value_after/12,2)/130.5 ,2) * (130.5-v_pro_month * 21.75-v_pro_day),2)* in_evs_bl,2)-trunc(trunc(trunc(trunc(v_return_value_after/12,2)/130.5 ,2)* v_result_deduct_after,2)* in_evs_bl,2),2) ;-- * in_evs_bl;

    v_result := trunc((v_result_ago + v_result_after ),2);

    return  v_result;
 ELSIF v_flag =0 AND v_diaoxin_flag2 > 0 THEN
      --没有晋升有调薪,直接取调薪前年薪
        select nvl(return_value,0) into v_return_value_ago from (select pa.return_value,pa.start_date,pa.end_date from pa_basic_data pa,pa_basic_data hei
    where pa.field1_value = hei.field1_value
      and pa.field1_value = in_empid
      and pa.item_no = hei.item_no
      and pa.item_no = '42'
      and pa.start_date< hei.start_date
      and hei.start_date between v_Sdate and v_Edate
      order by pa.end_date desc) where rownum = 1 ;
       -----调薪前年薪结束
       /*调薪的情况:直接取调薪后的工资，调薪的生效日期*/
         select return_value,pa.start_date into v_return_value_after,v_start_date from pa_basic_data pa
    where  pa.field1_value = in_empid
      and item_no = '42'
      --and pa.end_date is null
      and pa.start_date between v_Sdate and v_Edate;
       --取调薪后的年薪结束
       
         /* 取调薪前的天数
   调薪日期 到 区间开始日期相差的月份 取整 晋升日期是1号的 正好*/
  select trunc(MONTHS_BETWEEN(pa.start_date,v_Sdate),0) into v_pro_month  from pa_basic_data pa
    where  pa.field1_value = in_empid
      and item_no = '42'
      and pa.start_date between v_Sdate and v_Edate;
        /*如果调薪日期不是1号 ，则加上 晋升日期当月的天数 */
    select count(typeid)
      into v_pro_day
      from ar_calender
      where ddate between add_months(last_day(v_start_date),-1)+1 and
       v_start_date-1  and typeid <> 2;
     
  /*调薪前缺勤天数*/
   SELECT NVL(SUM (T.QUANTITY), 0) / 8
   INTO v_result_deduct_ago
   FROM AR_DETAIL T,
       HR_EMPLOYEE E
  WHERE T.AR_ITEM_NO IN (8, 14, 20,16)
    AND T.EMPID = in_empid
    AND T.EMPID = E.EMPID
    AND T.SHIFT_NO<>2
    AND TO_DATE(AR_DATE_STR,'YYYY-MM-DD') between v_Sdate and v_start_date;

     /*调薪后缺勤天数*/
   SELECT NVL(SUM (T.QUANTITY), 0) / 8
   INTO v_result_deduct_after
   FROM AR_DETAIL T,
       HR_EMPLOYEE E
  WHERE T.AR_ITEM_NO IN (14,20,8,16)
    AND T.EMPID = in_empid
    AND T.EMPID = E.EMPID
    AND T.SHIFT_NO<>2
    AND TO_DATE(AR_DATE_STR,'YYYY-MM-DD') between v_start_date and v_Edate;
    /*调薪前工资 = 调薪前年薪/12/130.5 * 调薪前工作天数 * 考核比率 - 调薪前年薪/12/130.5*调薪前缺勤天数 * 考核比率
   调薪前工作天数+调薪前未满整月天数 - 缺勤天数*/
  --  v_result_ago := trunc(trunc(v_return_value_ago/12,2)/130.5 ,2) * (v_pro_month * 21.75+v_pro_day-v_result_deduct_ago) ;-- * in_evs_bl;
    v_result_ago := trunc(trunc(trunc(trunc(trunc(v_return_value_ago/12,2)/130.5 ,2) * (v_pro_month * 21.75+v_pro_day),2) * in_evs_bl,2) -trunc(trunc(trunc(trunc(v_return_value_ago/12,2)/130.5 ,2)* v_result_deduct_ago,2)*in_evs_bl,2),2) ;-- * in_evs_bl;
  /*调薪后工资*/
    v_result_after :=trunc(trunc(trunc(trunc(trunc(v_return_value_after/12,2)/130.5 ,2) * (130.5-v_pro_month * 21.75-v_pro_day),2)* in_evs_bl,2)-trunc(trunc(trunc(trunc(v_return_value_after/12,2)/130.5 ,2)* v_result_deduct_after,2)* in_evs_bl,2),2) ;-- * in_evs_bl;

    v_result := trunc((v_result_ago + v_result_after ),2);

    return  v_result;
 ELSE 
    return  v_result;      
 END IF;

  EXCEPTION
     WHEN OTHERS
     THEN
     return 0;
        
  END;
 
END PA_Promotion_change;
/

prompt
prompt Creating function PA_PROMOTION_CHANGE2
prompt ======================================
prompt
CREATE OR REPLACE FUNCTION PA_Promotion_Change2(in_empid VARCHAR2)
   RETURN number
IS

   v_result        number :=0;
   v_last_year     VARCHAR2(10):=TO_CHAR(SYSDATE,'yyyy')-1;
   v_this_year     VARCHAR2(10):=TO_CHAR(SYSDATE,'yyyy');
   v_month         VARCHAR2(10):=TO_CHAR(SYSDATE,'MM');
   v_Edate         DATE;

BEGIN
     IF v_month<=6 THEN 
     select RETURN_VALUE 
     INTO v_result  
     from pa_basic_data 
      where  field1_value = in_empid
      and item_no = '42'
      AND start_date = (SELECT MAX(start_date) FROM (select RETURN_VALUE,start_date    
     from pa_basic_data 
      where  field1_value = in_empid
      and item_no = '42'
      and start_date <= TO_DATE(v_last_year||'-12-31','YYYY-MM-DD'))
            )
      ;
   ELSIF v_month>6 THEN
       v_Edate := TO_DATE(v_this_year||'-06-30','YYYY-MM-DD');
       select RETURN_VALUE 
     INTO v_result  
     from pa_basic_data 
      where  field1_value = in_empid
      and item_no = '42'
      AND start_date = (SELECT MAX(start_date) FROM (select RETURN_VALUE,start_date    
     from pa_basic_data 
      where  field1_value = in_empid
      and item_no = '42'
      and start_date <= v_Edate)
            )
      ;
     END IF ;


    return  v_result;

END PA_Promotion_change2;
/

prompt
prompt Creating function PA_PROMOTION_CHANGE_AQING
prompt ===========================================
prompt
CREATE OR REPLACE FUNCTION PA_PROMOTION_CHANGE_AQING
(
  IN_EMPID  VARCHAR2,
  IN_EVS_BL NUMBER
) RETURN NUMBER IS
  -- v_trans_code    VARCHAR2(20)  := 'TransCode_130'; -- 晋升
  V_START_DATE          DATE; --晋升日期
  V_SDATE               DATE; --区间开始日期
  V_EDATE               DATE; --区间结束日期
  V_RETURN_VALUE_AGO    NUMBER; --晋升前年薪
  V_RESULT_AGO          NUMBER; --晋升前工资
  V_PRO_MONTH           NUMBER; --晋升前整月分
  V_PRO_DAY             NUMBER; --晋升不是整月时，的上班天数
  V_RESULT_DEDUCT_AGO   NUMBER; --晋升前缺勤天数
  V_RETURN_VALUE_AFTER  NUMBER; --晋升后年薪
  V_RESULT_DEDUCT_AFTER NUMBER; --晋升后缺勤天数
  V_RESULT_AFTER        NUMBER; --晋升后工资
  V_RESULT              NUMBER;
  V_LAST_YEAR           VARCHAR2(10) := TO_CHAR(SYSDATE, 'yyyy') - 1;
  V_THIS_YEAR           VARCHAR2(10) := TO_CHAR(SYSDATE, 'yyyy');
  V_MONTH               VARCHAR2(10) := TO_CHAR(SYSDATE, 'MM');
  V_FLAG                NUMBER; --1表示有晋升后没有调薪
  V_DIAOXIN_FLAG        NUMBER; --1表示有晋升后有调薪
  V_DIAOXIN_FLAG2       NUMBER; --1表示有调薪
  -- 2010 年 3 月 Zengaiwu
BEGIN
  --BEGIN
	IF V_MONTH <= 6
	THEN
	  V_SDATE := TO_DATE(V_LAST_YEAR || '-07-01', 'YYYY-MM-DD');
	  V_EDATE := TO_DATE(V_LAST_YEAR || '-12-31', 'YYYY-MM-DD');
	ELSIF V_MONTH > 6
	THEN
	  V_SDATE := TO_DATE(V_THIS_YEAR || '-01-01', 'YYYY-MM-DD');
	  V_EDATE := TO_DATE(V_THIS_YEAR || '-06-30', 'YYYY-MM-DD');
	END IF;
	---判断晋升后有没有调薪， v_flag ：1表示有晋升后没有调薪，0表示晋升后有调薪
	BEGIN
	
	  SELECT COUNT(PA.START_DATE)
		INTO V_FLAG
		FROM PA_BASIC_DATA        PA,
			 HR_EXPERIENCE_INSIDE HEI
	   WHERE PA.FIELD1_VALUE = HEI.EMPID
		 AND PA.FIELD1_VALUE = IN_EMPID
		 AND ITEM_NO = '42'
		 AND HEI.TRANS_CODE = 'TransCode_130'
		 AND HEI.START_DATE = PA.START_DATE
			--and pa.end_date is null
		 AND PA.START_DATE BETWEEN V_SDATE AND V_EDATE;
	
	  SELECT COUNT(PA.START_DATE)
		INTO V_DIAOXIN_FLAG
		FROM PA_BASIC_DATA        PA,
			 HR_EXPERIENCE_INSIDE HEI
	   WHERE PA.FIELD1_VALUE = HEI.EMPID
		 AND PA.FIELD1_VALUE = IN_EMPID
		 AND ITEM_NO = '42'
		 AND HEI.TRANS_CODE = 'TransCode_130'
		 AND HEI.START_DATE < PA.START_DATE
			--and pa.end_date is null
		 AND PA.START_DATE BETWEEN V_SDATE AND V_EDATE;
	
	  SELECT COUNT(PA.START_DATE)
		INTO V_DIAOXIN_FLAG2
		FROM PA_BASIC_DATA PA
	   WHERE PA.FIELD1_VALUE = IN_EMPID
		 AND ITEM_NO = '42'
			--and pa.end_date is null
		 AND PA.START_DATE BETWEEN V_SDATE AND V_EDATE;
	
	END;
	IF V_FLAG > 0
	THEN
	  /*验证在该区间内 的 晋升前年薪 */
	  --没有调薪,直接取晋升前年薪
	  IF V_FLAG > 0
		 AND V_DIAOXIN_FLAG = 0
	  THEN
		SELECT NVL(RETURN_VALUE, 0)
		  INTO V_RETURN_VALUE_AGO
		  FROM (SELECT PA.RETURN_VALUE,
					   PA.START_DATE,
					   PA.END_DATE
				  FROM PA_BASIC_DATA        PA,
					   HR_EXPERIENCE_INSIDE HEI
				 WHERE PA.FIELD1_VALUE = HEI.EMPID
				   AND PA.FIELD1_VALUE = IN_EMPID
				   AND ITEM_NO = '42'
				   AND HEI.TRANS_CODE = 'TransCode_130'
				   AND PA.START_DATE < HEI.START_DATE
				   AND PA.END_DATE BETWEEN V_SDATE AND V_EDATE
				 ORDER BY PA.END_DATE DESC)
		 WHERE ROWNUM = 1;
		BEGIN
		  IF V_RETURN_VALUE_AGO IS NULL
		  THEN
			SELECT NVL(RETURN_VALUE, 0)
			  INTO V_RETURN_VALUE_AGO
			  FROM (SELECT PA.RETURN_VALUE,
						   PA.START_DATE,
						   PA.END_DATE
					  FROM PA_BASIC_DATA        PA,
						   HR_EXPERIENCE_INSIDE HEI
					 WHERE PA.FIELD1_VALUE = HEI.EMPID
					   AND PA.FIELD1_VALUE = IN_EMPID
					   AND ITEM_NO = '42'
					   AND HEI.TRANS_CODE = 'TransCode_130'
					   AND PA.START_DATE <= HEI.START_DATE
					   AND PA.END_DATE BETWEEN V_SDATE AND V_EDATE
					 ORDER BY PA.END_DATE DESC)
			 WHERE ROWNUM = 1;
		  END IF;
		END;
		--有调薪，取晋升前一条年薪
	  ELSIF V_FLAG > 0
			AND V_DIAOXIN_FLAG > 0
	  THEN
		SELECT NVL(RETURN_VALUE, 0)
		  INTO V_RETURN_VALUE_AGO
		  FROM (SELECT PA.RETURN_VALUE,
					   PA.START_DATE,
					   PA.END_DATE
				  FROM PA_BASIC_DATA        PA,
					   HR_EXPERIENCE_INSIDE HEI
				 WHERE PA.FIELD1_VALUE = HEI.EMPID
				   AND PA.FIELD1_VALUE = IN_EMPID
				   AND ITEM_NO = '42'
				   AND HEI.TRANS_CODE = 'TransCode_130'
				   AND PA.END_DATE IS NOT NULL
				   AND HEI.START_DATE > PA.START_DATE
				   AND PA.END_DATE BETWEEN V_SDATE - 1 AND V_EDATE
				 ORDER BY PA.END_DATE DESC)
		 WHERE ROWNUM = 1;
		BEGIN
		  IF V_RETURN_VALUE_AGO IS NULL
		  THEN
			SELECT NVL(RETURN_VALUE, 0)
			  INTO V_RETURN_VALUE_AGO
			  FROM (SELECT PA.RETURN_VALUE,
						   PA.START_DATE,
						   PA.END_DATE
					  FROM PA_BASIC_DATA        PA,
						   HR_EXPERIENCE_INSIDE HEI
					 WHERE PA.FIELD1_VALUE = HEI.EMPID
					   AND PA.FIELD1_VALUE = IN_EMPID
					   AND ITEM_NO = '42'
					   AND HEI.TRANS_CODE = 'TransCode_130'
					   AND PA.START_DATE <= HEI.START_DATE
					   AND PA.END_DATE BETWEEN V_SDATE - 1 AND V_EDATE
					 ORDER BY PA.END_DATE DESC)
			 WHERE ROWNUM = 1;
		  END IF;
		END;
	  END IF;
	  -----晋升前年薪结束
	
	  /*验证在该区间内 的 晋升后年薪,晋升日期*/
	  BEGIN
		IF V_FLAG > 0
		   AND V_DIAOXIN_FLAG = 0
		THEN
		  /*晋升后无调薪的情况:直接取晋升后的工资，晋升的生效日期*/
		  SELECT RETURN_VALUE,
				 PA.START_DATE
			INTO V_RETURN_VALUE_AFTER,
				 V_START_DATE
			FROM PA_BASIC_DATA        PA,
				 HR_EXPERIENCE_INSIDE HEI
		   WHERE PA.FIELD1_VALUE = HEI.EMPID
			 AND PA.FIELD1_VALUE = IN_EMPID
			 AND ITEM_NO = '42'
			 AND HEI.TRANS_CODE = 'TransCode_130'
			 AND HEI.START_DATE = PA.START_DATE
				--and pa.end_date is null
			 AND PA.START_DATE BETWEEN V_SDATE AND V_EDATE;
		ELSIF V_FLAG > 0
			  AND V_DIAOXIN_FLAG > 0
		THEN
		  /*晋升后有调薪的情况:上面的SELECT肯定为NULL,直接取调薪后的工资，晋升的生效日期*/
		  BEGIN
			--- 取晋升的生效日期
			SELECT START_DATE
			  INTO V_START_DATE
			  FROM (SELECT PA.START_DATE
					  FROM PA_BASIC_DATA        PA,
						   HR_EXPERIENCE_INSIDE HEI
					 WHERE PA.FIELD1_VALUE = HEI.EMPID
					   AND PA.FIELD1_VALUE = IN_EMPID
					   AND ITEM_NO = '42'
					   AND HEI.TRANS_CODE = 'TransCode_130'
					   AND HEI.START_DATE = PA.START_DATE
						  -- and pa.end_date is not null
					   AND PA.START_DATE BETWEEN V_SDATE AND V_EDATE
					 ORDER BY PA.END_DATE DESC)
			 WHERE ROWNUM = 1;
			--取调薪后的年薪
		  
			SELECT MAX(RETURN_VALUE)
			  INTO V_RETURN_VALUE_AFTER
			  FROM PA_BASIC_DATA        PA,
				   HR_EXPERIENCE_INSIDE HEI
			 WHERE PA.FIELD1_VALUE = HEI.EMPID
			   AND PA.FIELD1_VALUE = IN_EMPID
			   AND ITEM_NO = '42'
			   AND HEI.TRANS_CODE = 'TransCode_130'
			   AND HEI.START_DATE < PA.START_DATE
				  --and pa.end_date is null
			   AND PA.START_DATE BETWEEN V_SDATE AND V_EDATE;
		  END;
		END IF;
	  END;
	
	  /* 取晋升前的天数
      晋升日期 到 区间开始日期相差的月份 取整 晋升日期是1号的 正好*/
	  SELECT TRUNC(MONTHS_BETWEEN(PA.START_DATE, V_SDATE), 0)
		INTO V_PRO_MONTH
		FROM PA_BASIC_DATA        PA,
			 HR_EXPERIENCE_INSIDE HEI
	   WHERE PA.FIELD1_VALUE = HEI.EMPID
		 AND PA.FIELD1_VALUE = IN_EMPID
		 AND ITEM_NO = '42'
		 AND HEI.TRANS_CODE = 'TransCode_130'
		 AND HEI.START_DATE = PA.START_DATE
		 AND PA.START_DATE BETWEEN V_SDATE AND V_EDATE;
	
	  /*如果晋升日期不是1号 ，则加上 晋升日期当月的天数 */
	  SELECT COUNT(TYPEID)
		INTO V_PRO_DAY
		FROM AR_CALENDER
	   WHERE DDATE BETWEEN ADD_MONTHS(LAST_DAY(V_START_DATE), -1) + 1 AND V_START_DATE - 1
		 AND TYPEID <> 2;
	
	  /*晋升前缺勤天数*/
	  SELECT NVL(SUM(T.QUANTITY), 0) / 8
		INTO V_RESULT_DEDUCT_AGO
		FROM AR_DETAIL   T,
			 HR_EMPLOYEE E
	   WHERE T.AR_ITEM_NO IN (8, 14, 20, 16)
		 AND T.EMPID = IN_EMPID
		 AND T.EMPID = E.EMPID
		 AND T.SHIFT_NO <> 2
		 AND TO_DATE(AR_DATE_STR, 'YYYY-MM-DD') BETWEEN V_SDATE AND V_START_DATE;
	
	  /*晋升后缺勤天数*/
	  SELECT NVL(SUM(T.QUANTITY), 0) / 8
		INTO V_RESULT_DEDUCT_AFTER
		FROM AR_DETAIL   T,
			 HR_EMPLOYEE E
	   WHERE T.AR_ITEM_NO IN (14, 20, 8, 16)
		 AND T.EMPID = IN_EMPID
		 AND T.EMPID = E.EMPID
		 AND T.SHIFT_NO <> 2
		 AND TO_DATE(AR_DATE_STR, 'YYYY-MM-DD') BETWEEN V_START_DATE AND V_EDATE;
	
	  /*晋升前工资 = 晋升前年薪/12/130.5 * 晋升前工作天数 * 考核比率 - 晋升前年薪/12/130.5*晋升前缺勤天数 * 考核比率
      晋升前工作天数+晋升前未满整月天数 - 缺勤天数*/
	  --  v_result_ago := trunc(trunc(v_return_value_ago/12,2)/130.5 ,2) * (v_pro_month * 21.75+v_pro_day-v_result_deduct_ago) ;-- * in_evs_bl;
	  V_RESULT_AGO := TRUNC(TRUNC(TRUNC(TRUNC(TRUNC(V_RETURN_VALUE_AGO / 12, 2) / 130.5, 2) *
										(V_PRO_MONTH * 21.75 + V_PRO_DAY),
										2) * IN_EVS_BL,
								  2) -
							TRUNC(TRUNC(TRUNC(TRUNC(V_RETURN_VALUE_AGO / 12, 2) / 130.5, 2) * V_RESULT_DEDUCT_AGO, 2) *
								  IN_EVS_BL,
								  2),
							2); -- * in_evs_bl;
	  /*晋升后工资*/
	  V_RESULT_AFTER := TRUNC(TRUNC(TRUNC(TRUNC(TRUNC(V_RETURN_VALUE_AFTER / 12, 2) / 130.5, 2) *
										  (130.5 - V_PRO_MONTH * 21.75 - V_PRO_DAY),
										  2) * IN_EVS_BL,
									2) -
							  TRUNC(TRUNC(TRUNC(TRUNC(V_RETURN_VALUE_AFTER / 12, 2) / 130.5, 2) * V_RESULT_DEDUCT_AFTER,
										  2) * IN_EVS_BL,
									2),
							  2); -- * in_evs_bl;
	
	  V_RESULT := TRUNC((V_RESULT_AGO + V_RESULT_AFTER), 2);
	
	  RETURN V_RESULT;
	ELSIF V_FLAG = 0
		  AND V_DIAOXIN_FLAG2 > 0
	THEN
	  --没有晋升有调薪,直接取调薪前年薪
	  SELECT NVL(RETURN_VALUE, 0)
		INTO V_RETURN_VALUE_AGO
		FROM (SELECT PA.RETURN_VALUE,
					 PA.START_DATE,
					 PA.END_DATE
				FROM PA_BASIC_DATA PA,
					 PA_BASIC_DATA HEI
			   WHERE PA.FIELD1_VALUE = HEI.FIELD1_VALUE
				 AND PA.FIELD1_VALUE = IN_EMPID
				 AND PA.ITEM_NO = HEI.ITEM_NO
				 AND PA.ITEM_NO = '42'
				 AND PA.START_DATE < HEI.START_DATE
				 AND HEI.START_DATE BETWEEN V_SDATE AND V_EDATE
			   ORDER BY PA.END_DATE DESC)
	   WHERE ROWNUM = 1;
	  -----调薪前年薪结束
	  /*调薪的情况:直接取调薪后的工资，调薪的生效日期*/
	  SELECT RETURN_VALUE,
			 PA.START_DATE
		INTO V_RETURN_VALUE_AFTER,
			 V_START_DATE
		FROM PA_BASIC_DATA PA
	   WHERE PA.FIELD1_VALUE = IN_EMPID
		 AND ITEM_NO = '42'
			--and pa.end_date is null
		 AND PA.START_DATE BETWEEN V_SDATE AND V_EDATE;
	  --取调薪后的年薪结束
	
	  /* 取调薪前的天数
      调薪日期 到 区间开始日期相差的月份 取整 晋升日期是1号的 正好*/
	  SELECT TRUNC(MONTHS_BETWEEN(PA.START_DATE, V_SDATE), 0)
		INTO V_PRO_MONTH
		FROM PA_BASIC_DATA PA
	   WHERE PA.FIELD1_VALUE = IN_EMPID
		 AND ITEM_NO = '42'
		 AND PA.START_DATE BETWEEN V_SDATE AND V_EDATE;
	  /*如果调薪日期不是1号 ，则加上 晋升日期当月的天数 */
	  SELECT COUNT(TYPEID)
		INTO V_PRO_DAY
		FROM AR_CALENDER
	   WHERE DDATE BETWEEN ADD_MONTHS(LAST_DAY(V_START_DATE), -1) + 1 AND V_START_DATE - 1
		 AND TYPEID <> 2;
	
	  /*调薪前缺勤天数*/
	  SELECT NVL(SUM(T.QUANTITY), 0) / 8
		INTO V_RESULT_DEDUCT_AGO
		FROM AR_DETAIL   T,
			 HR_EMPLOYEE E
	   WHERE T.AR_ITEM_NO IN (8, 14, 20, 16)
		 AND T.EMPID = IN_EMPID
		 AND T.EMPID = E.EMPID
		 AND T.SHIFT_NO <> 2
		 AND TO_DATE(AR_DATE_STR, 'YYYY-MM-DD') BETWEEN V_SDATE AND V_START_DATE;
	
	  /*调薪后缺勤天数*/
	  SELECT NVL(SUM(T.QUANTITY), 0) / 8
		INTO V_RESULT_DEDUCT_AFTER
		FROM AR_DETAIL   T,
			 HR_EMPLOYEE E
	   WHERE T.AR_ITEM_NO IN (14, 20, 8, 16)
		 AND T.EMPID = IN_EMPID
		 AND T.EMPID = E.EMPID
		 AND T.SHIFT_NO <> 2
		 AND TO_DATE(AR_DATE_STR, 'YYYY-MM-DD') BETWEEN V_START_DATE AND V_EDATE;
	  /*调薪前工资 = 调薪前年薪/12/130.5 * 调薪前工作天数 * 考核比率 - 调薪前年薪/12/130.5*调薪前缺勤天数 * 考核比率
      调薪前工作天数+调薪前未满整月天数 - 缺勤天数*/
	  --  v_result_ago := trunc(trunc(v_return_value_ago/12,2)/130.5 ,2) * (v_pro_month * 21.75+v_pro_day-v_result_deduct_ago) ;-- * in_evs_bl;
	  V_RESULT_AGO := TRUNC(TRUNC(TRUNC(TRUNC(TRUNC(V_RETURN_VALUE_AGO / 12, 2) / 130.5, 2) *
										(V_PRO_MONTH * 21.75 + V_PRO_DAY),
										2) * IN_EVS_BL,
								  2) -
							TRUNC(TRUNC(TRUNC(TRUNC(V_RETURN_VALUE_AGO / 12, 2) / 130.5, 2) * V_RESULT_DEDUCT_AGO, 2) *
								  IN_EVS_BL,
								  2),
							2); -- * in_evs_bl;
	  /*调薪后工资*/
	  V_RESULT_AFTER := TRUNC(TRUNC(TRUNC(TRUNC(TRUNC(V_RETURN_VALUE_AFTER / 12, 2) / 130.5, 2) *
										  (130.5 - V_PRO_MONTH * 21.75 - V_PRO_DAY),
										  2) * IN_EVS_BL,
									2) -
							  TRUNC(TRUNC(TRUNC(TRUNC(V_RETURN_VALUE_AFTER / 12, 2) / 130.5, 2) * V_RESULT_DEDUCT_AFTER,
										  2) * IN_EVS_BL,
									2),
							  2); -- * in_evs_bl;
	
	  V_RESULT := TRUNC((V_RESULT_AGO + V_RESULT_AFTER), 2);
	
	END IF;
  
  /*EXCEPTION
	WHEN OTHERS THEN
	  V_RESULT :=9999999999;
	
  END;*/
  RETURN V_RESULT;
END PA_PROMOTION_CHANGE_AQING;
/

prompt
prompt Creating function PA_PROMOTION_CHANGE_BACKUP
prompt ============================================
prompt
CREATE OR REPLACE FUNCTION PA_Promotion_Change_backup(in_empid VARCHAR2,in_evs_bl number)
   RETURN number
IS
  -- v_trans_code    VARCHAR2(20)  := 'TransCode_130'; -- 晋升
   v_start_date       date;    --晋升日期
   v_Sdate            date;    --区间开始日期
   v_Edate            date;    --区间结束日期
   v_return_value_ago number;  --晋升前年薪
   v_result_ago		    number;  --晋升前工资
   v_pro_month        number;  --晋升前整月分
   v_pro_day        number;       --晋升不是整月时，的上班天数
   v_result_deduct_ago	 number; --晋升前缺勤天数
   v_return_value_after  number;  --晋升后年薪
   v_result_deduct_after	 number; --晋升后缺勤天数
   v_result_after		    number;  --晋升后工资
   v_result 		    number;
   -- 2010 年 3 月 Zengaiwu
BEGIN

    v_Sdate := TO_DATE('2009-07-01','YYYY-MM-DD');
    v_Edate := TO_DATE('2009-12-31','YYYY-MM-DD');

  /*验证在该区间内 的 晋升前年薪 */
      select return_value into v_return_value_ago from (select pa.return_value,pa.start_date,pa.end_date from pa_basic_data pa,HR_EXPERIENCE_INSIDE hei
    where pa.field1_value = hei.empid
      and pa.field1_value = in_empid
      and item_no = '42'
      and hei.TRANS_CODE = 'TransCode_130'
      and pa.end_date is not null
      and pa.end_date between v_Sdate-1 and v_Edate
      order by pa.end_date desc) where rownum = 1 ;

  /*验证在该区间内 的 晋升后年薪,晋升日期*/
       select return_value,pa.start_date into v_return_value_after,v_start_date from pa_basic_data pa,HR_EXPERIENCE_INSIDE hei
    where pa.field1_value = hei.empid
      and pa.field1_value = in_empid
      and item_no = '42'
      and hei.TRANS_CODE = 'TransCode_130'
      and hei.start_date = pa.start_date
      and pa.end_date is null
      and pa.start_date between v_Sdate and v_Edate;


  /* 取晋升前的天数
   晋升日期 到 区间开始日期相差的月份 取整 晋升日期是1号的 正好*/
      select trunc(MONTHS_BETWEEN(pa.start_date,to_date('2009-07-01','YYYY-MM-DD')),0) into v_pro_month  from pa_basic_data pa,HR_EXPERIENCE_INSIDE hei
    where pa.field1_value = hei.empid
      and pa.field1_value = in_empid
      and item_no = '42'
      and hei.TRANS_CODE = 'TransCode_130'
      and hei.start_date = pa.start_date
      and pa.end_date is null
      and pa.start_date between v_Sdate and v_Edate;

  /*如果晋升日期不是1号 ，则加上 晋升日期当月的天数 */
 select count(typeid)
      into v_pro_day
      from ar_calender
      where ddate between add_months(last_day(v_start_date),-1)+1 and
       v_start_date-1  and typeid <> 2;

  /*晋升前缺勤天数*/
   SELECT NVL(SUM (T.QUANTITY), 0) / 8
	 INTO v_result_deduct_ago
	 FROM AR_DETAIL T,
	 	  HR_EMPLOYEE E
	WHERE T.AR_ITEM_NO IN (8, 14, 20)
	  AND T.EMPID = in_empid
	  AND T.EMPID = E.EMPID
    AND TO_DATE(AR_DATE_STR,'YYYY-MM-DD') between v_Sdate and v_start_date;

     /*晋升后缺勤天数*/
   SELECT NVL(SUM (T.QUANTITY), 0) / 8
	 INTO v_result_deduct_after
	 FROM AR_DETAIL T,
	 	  HR_EMPLOYEE E
	WHERE T.AR_ITEM_NO IN (14,20,8)
	  AND T.EMPID = in_empid
	  AND T.EMPID = E.EMPID
    AND TO_DATE(AR_DATE_STR,'YYYY-MM-DD') between v_start_date and v_Edate;

 /*晋升前工资 = 晋升前年薪/12/130.5 * 晋升前工作天数 * 考核比率 - 晋升前年薪/12/130.5*晋升前缺勤天数 * 考核比率
   晋升前工作天数+晋升前未满整月天数 - 缺勤天数*/
    v_result_ago := round(v_return_value_ago/12/130.5 ,2) * (v_pro_month * 21.75+v_pro_day-v_result_deduct_ago) ;-- * in_evs_bl;

  /*晋升后工资*/
    v_result_after :=  round(v_return_value_after/12/130.5 ,2) * (130.5-v_pro_month * 21.75-v_pro_day-v_result_deduct_after) ;-- * in_evs_bl;

    v_result := round( (v_result_ago + v_result_after ) * in_evs_bl,2);

    return  v_result;

END PA_Promotion_Change_backup;
/

prompt
prompt Creating function PA_RESIGNATION_FLAG
prompt =====================================
prompt
CREATE OR REPLACE FUNCTION PA_RESIGNATION_flag (in_empid VARCHAR2)
   RETURN INT
IS
   v_trans_code    VARCHAR2(20)  := 'TransCode_200'; -- 离职
   --v_start_date     VARCHAR2(10);
   --v_end_date      VARCHAR2(10);
   v_result        INT;
BEGIN

   /*根据项目取得验证的开始结束日期*/
   /*SELECT DECODE(A.START_MONTH, 'PreviousMonth', TO_CHAR(ADD_MONTHS(TO_DATE(in_pamonth,'YYYYMM'),-1),'YYYY-MM') || '-' || A.START_DAY,
                       'NextMonth', TO_CHAR(ADD_MONTHS(TO_DATE(in_pamonth,'YYYYMM'),1),'YYYY-MM') || '-' || A.START_DAY,
                  TO_CHAR(TO_DATE(in_pamonth,'YYYYMM'),'YYYY-MM') || '-' || A.START_DAY) AS START_DATE,
      DECODE(A.END_MONTH, 'PreviousMonth', NVL(TO_CHAR(A.END_DAY),TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(in_pamonth,'YYYYMM'),-1)), 'YYYY-MM-DD')),
                     'NextMonth', NVL(TO_CHAR(A.END_DAY),TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(in_pamonth,'YYYYMM'),1)), 'YYYY-MM-DD')),
                TO_CHAR(TO_DATE(in_pamonth,'YYYYMM'),'YYYY-MM') || '-' || NVL(TO_CHAR(A.END_DAY),TO_CHAR(LAST_DAY(TO_DATE(in_pamonth,'YYYYMM')), 'DD'))) AS END_DATE
   INTO v_start_date,
       v_end_date
     FROM PA_ITEM A
  WHERE A.ITEM_ID = in_item_id;
   */
   /*验证在该区间内是否存在离职数据*/
    SELECT COUNT(*)
    INTO v_result
    FROM HR_RESIGNATION A
   WHERE A.TRANS_CODE = v_trans_code
     AND EMPID = in_empid
     AND A.ACTIVITY <2;
     --AND A.RESIGN_DATE BETWEEN TO_DATE(v_start_date, 'YYYY-MM-DD') AND TO_DATE(v_end_date, 'YYYY-MM-DD');
     --AND A.RESIGN_DATE BETWEEN in_work_startday AND in_work_endday;

   RETURN v_result;

END PA_RESIGNATION_flag;
/

prompt
prompt Creating function PA_VALIDATE_BANDH
prompt ===================================
prompt
CREATE OR REPLACE FUNCTION PA_VALIDATE_BANDH (in_empid VARCHAR2, in_item_id VARCHAR2, in_pamonth VARCHAR2,in_work_startday DATE, in_work_endday DATE)
   RETURN INT
IS
   v_trans_code1  	VARCHAR2(20)  := 'BandhType0010'; -- 停职
   v_trans_code2 	VARCHAR2(20)  := 'BandhType0030'; -- 待分配
   --v_start_date     VARCHAR2(10);
   --v_end_date      VARCHAR2(10);
   v_result        INT;
BEGIN
   
   /*根据项目取得验证的开始结束日期*/
   /*
   SELECT DECODE(A.START_MONTH, 'PreviousMonth', TO_CHAR(ADD_MONTHS(TO_DATE(in_pamonth,'YYYYMM'),-1),'YYYY-MM') || '-' || A.START_DAY,
                       'NextMonth', TO_CHAR(ADD_MONTHS(TO_DATE(in_pamonth,'YYYYMM'),1),'YYYY-MM') || '-' || A.START_DAY,
                  TO_CHAR(TO_DATE(in_pamonth,'YYYYMM'),'YYYY-MM') || '-' || A.START_DAY) AS START_DATE,
      DECODE(A.END_MONTH, 'PreviousMonth', NVL(TO_CHAR(A.END_DAY),TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(in_pamonth,'YYYYMM'),-1)), 'YYYY-MM-DD')),
                     'NextMonth', NVL(TO_CHAR(A.END_DAY),TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(in_pamonth,'YYYYMM'),1)), 'YYYY-MM-DD')),
                TO_CHAR(TO_DATE(in_pamonth,'YYYYMM'),'YYYY-MM') || '-' || NVL(TO_CHAR(A.END_DAY),TO_CHAR(LAST_DAY(TO_DATE(in_pamonth,'YYYYMM')), 'DD'))) AS END_DATE
   INTO v_start_date,
       v_end_date
     FROM PA_ITEM A
  WHERE A.ITEM_ID = in_item_id;
   */
   /*验证在该区间内是否存在停职待分配数据*/
    SELECT COUNT(*)
      INTO v_result
    FROM HR_EXPERIENCE_INSIDE A
   WHERE (A.TRANS_CODE = v_trans_code1 OR A.TRANS_CODE = v_trans_code2)
     AND EMPID = in_empid
     --AND A.START_DATE BETWEEN TO_DATE(v_start_date, 'YYYY-MM-DD')+1 AND TO_DATE(v_end_date, 'YYYY-MM-DD');
      AND A.START_DATE BETWEEN in_work_startday AND in_work_endday ;
  RETURN v_result;
     
END PA_VALIDATE_BANDH;
/

prompt
prompt Creating function PA_VALIDATE_JOIN
prompt ==================================
prompt
CREATE OR REPLACE FUNCTION PA_VALIDATE_JOIN (in_empid VARCHAR2, in_item_id VARCHAR2, in_pamonth VARCHAR2,in_work_startday DATE, in_work_endday DATE)
   RETURN INT
IS
   v_trans_code    VARCHAR2(20)  := 'TransCode_100'; -- 入职
   --v_start_date     VARCHAR2(10);
   --v_end_date      VARCHAR2(10);
   v_result        INT;
BEGIN

   /*根据项目取得验证的开始结束日期*/
 /*  SELECT DECODE(A.START_MONTH, 'PreviousMonth', TO_CHAR(ADD_MONTHS(TO_DATE(in_pamonth,'YYYYMM'),-1),'YYYY-MM') || '-' || A.START_DAY,
                       'NextMonth', TO_CHAR(ADD_MONTHS(TO_DATE(in_pamonth,'YYYYMM'),1),'YYYY-MM') || '-' || A.START_DAY,
                  TO_CHAR(TO_DATE(in_pamonth,'YYYYMM'),'YYYY-MM') || '-' || A.START_DAY) AS START_DATE,
      DECODE(A.END_MONTH, 'PreviousMonth', NVL(TO_CHAR(A.END_DAY),TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(in_pamonth,'YYYYMM'),-1)), 'YYYY-MM-DD')),
                     'NextMonth', NVL(TO_CHAR(A.END_DAY),TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(in_pamonth,'YYYYMM'),1)), 'YYYY-MM-DD')),
                TO_CHAR(TO_DATE(in_pamonth,'YYYYMM'),'YYYY-MM') || '-' || NVL(TO_CHAR(A.END_DAY),TO_CHAR(LAST_DAY(TO_DATE(in_pamonth,'YYYYMM')), 'DD'))) AS END_DATE
   INTO v_start_date,
       v_end_date
     FROM PA_ITEM A
  WHERE A.ITEM_ID = in_item_id;
 */
   /*验证在该区间内是否存在离职数据*/
    SELECT COUNT(*)
    INTO v_result
    FROM HR_EXPERIENCE_INSIDE A
   WHERE A.TRANS_CODE = v_trans_code
     AND EMPID = in_empid
     AND A.ACTIVITY =1
     --AND A.START_DATE BETWEEN TO_DATE(v_start_date, 'YYYY-MM-DD') AND TO_DATE(v_end_date, 'YYYY-MM-DD');
     AND A.START_DATE BETWEEN in_work_startday AND in_work_endday ;

   RETURN v_result;

END PA_VALIDATE_JOIN;
/

prompt
prompt Creating function PA_VALIDATE_PRACTICE
prompt ======================================
prompt
CREATE OR REPLACE FUNCTION PA_VALIDATE_PRACTICE (in_empid VARCHAR2, in_item_id VARCHAR2, in_pamonth VARCHAR2,in_work_startday DATE, in_work_endday DATE)
   RETURN INT
IS
   v_trans_code1  	VARCHAR2(20)  := 'TurnType0020'; -- 实习转正
   v_trans_code2  	VARCHAR2(20)  := 'TurnType0030'; -- 实习转试用
   --v_start_date     VARCHAR2(10);
   --v_end_date	    VARCHAR2(10);
   v_result		    INT;
BEGIN
   
   /*根据项目取得验证的开始结束日期*/
   /*
   SELECT DECODE(A.START_MONTH, 'PreviousMonth', TO_CHAR(ADD_MONTHS(TO_DATE(in_pamonth,'YYYYMM'),-1),'YYYY-MM') || '-' || A.START_DAY,
   		  					    'NextMonth', TO_CHAR(ADD_MONTHS(TO_DATE(in_pamonth,'YYYYMM'),1),'YYYY-MM') || '-' || A.START_DAY,
							    TO_CHAR(TO_DATE(in_pamonth,'YYYYMM'),'YYYY-MM') || '-' || A.START_DAY) AS START_DATE,
		  DECODE(A.END_MONTH, 'PreviousMonth', NVL(TO_CHAR(A.END_DAY),TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(in_pamonth,'YYYYMM'),-1)), 'YYYY-MM-DD')),
   		  					  'NextMonth', NVL(TO_CHAR(A.END_DAY),TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(in_pamonth,'YYYYMM'),1)), 'YYYY-MM-DD')),
							  TO_CHAR(TO_DATE(in_pamonth,'YYYYMM'),'YYYY-MM') || '-' || NVL(TO_CHAR(A.END_DAY),TO_CHAR(LAST_DAY(TO_DATE(in_pamonth,'YYYYMM')), 'DD'))) AS END_DATE
	 INTO v_start_date,
	 	  v_end_date
     FROM PA_ITEM A
	WHERE A.ITEM_ID = in_item_id;
  */
   /*验证在该区间内是否存在实习转正、实习转试用数据*/
    SELECT COUNT(*)
	  INTO v_result
	  FROM HR_EXPERIENCE_INSIDE A
	 WHERE (A.TRANS_CODE = v_trans_code1 OR A.TRANS_CODE = v_trans_code2)
	   AND EMPID = in_empid
	   --AND A.START_DATE BETWEEN TO_DATE(v_start_date, 'YYYY-MM-DD')+1 AND TO_DATE(v_end_date, 'YYYY-MM-DD')-1;
      AND A.START_DATE BETWEEN in_work_startday AND in_work_endday ;
   RETURN v_result;
     
END PA_VALIDATE_PRACTICE;
/

prompt
prompt Creating function PA_VALIDATE_PROMOTE1
prompt ======================================
prompt
CREATE OR REPLACE FUNCTION PA_VALIDATE_PROMOTE1(in_empid VARCHAR2)
   RETURN INT
IS
   v_trans_code    VARCHAR2(20)  := 'TransCode_130'; -- 晋升
  -- v_trans_code2    VARCHAR2(20)  := 'TransCode_100'; -- 入职
    v_result        INT :=0;
    v_month         VARCHAR2(10):=TO_CHAR(SYSDATE,'MM');
    v_last_year     VARCHAR2(10):=TO_CHAR(SYSDATE,'yyyy')-1;
    v_this_year     VARCHAR2(10):=TO_CHAR(SYSDATE,'yyyy');
    v_Sdate            date;    --区间开始日期
    v_Edate            date;    --区间结束日期
    v_diaoxin_flag       number;--1表示有晋升后有调薪
BEGIN
  
   IF v_month<=6 THEN
       v_Sdate := TO_DATE(v_last_year||'-07-02','YYYY-MM-DD');
       v_Edate := TO_DATE(v_last_year||'-12-31','YYYY-MM-DD');
   ELSIF v_month>6 THEN
       v_Sdate := TO_DATE(v_this_year||'-01-02','YYYY-MM-DD');
       v_Edate := TO_DATE(v_this_year||'-06-30','YYYY-MM-DD');
   END IF ;
  /*验证在该区间内是否存在晋升数据*/
   SELECT COUNT(EMPID)
     INTO v_result
     FROM HR_EXPERIENCE_INSIDE A
   WHERE A.TRANS_CODE =v_trans_code
       AND EMPID = in_empid
      AND A.START_DATE BETWEEN v_Sdate AND v_Edate;
   select count(pa.start_date)
        into v_diaoxin_flag
     from pa_basic_data pa
    where pa.field1_value = in_empid
      and item_no = '42'
      --and pa.end_date is null
      and pa.start_date between v_Sdate and v_Edate;
  IF v_diaoxin_flag >0 OR v_result >0 THEN
       v_result := 1;
  ELSIF v_diaoxin_flag = 0 AND v_result = 0  THEN
        v_result := 0;
  END IF ;
    IF v_result = 0
         THEN
             RETURN v_result;
         ELSE
               RETURN 1;
         END IF;

END PA_VALIDATE_PROMOTE1;
/

prompt
prompt Creating function PA_VALIDATE_PROMOTE1_BACKUP
prompt =============================================
prompt
CREATE OR REPLACE FUNCTION PA_VALIDATE_PROMOTE1_backup(in_empid VARCHAR2)
   RETURN INT
IS
   v_trans_code    VARCHAR2(20)  := 'TransCode_130'; -- 晋升
    v_result		    INT;
BEGIN
  /*验证在该区间内是否存在晋升数据*/
   SELECT COUNT(EMPID)
     INTO v_result
     FROM HR_EXPERIENCE_INSIDE A
   WHERE A.TRANS_CODE = v_trans_code
       AND EMPID = in_empid
      AND A.START_DATE BETWEEN TO_DATE('2009-07-01', 'YYYY-MM-DD') AND TO_DATE('2009-12-31', 'YYYY-MM-DD');

    IF v_result = 0
         THEN
             RETURN v_result;
         ELSE
               RETURN 1;
         END IF;

END PA_VALIDATE_PROMOTE1_backup;
/

prompt
prompt Creating function PA_VALIDATE_PROMOTE2
prompt ======================================
prompt
CREATE OR REPLACE FUNCTION PA_VALIDATE_PROMOTE2(in_empid VARCHAR2,in_flagOrpa varchar2)
   RETURN INT
IS
   v_trans_code    VARCHAR2(20)  := 'TransCode_130'; -- 晋升
   v_return_value_ago number;
   v_resultflag		    INT:=0;
   v_resultpa		    number:=0;
BEGIN
  /*验证在1月1号 以后晋升的 要取晋升前的 薪资做为标准  flag取标记，pa 取晋升前的工资   */
  IF in_flagOrpa = 'flag' then
   select count(EMPID) into v_resultflag  from pa_basic_data pa,HR_EXPERIENCE_INSIDE hei
    where pa.field1_value = hei.empid 
     and pa.field1_value = in_empid
    and hei.start_date = pa.start_date
      and item_no = '42'  
      and hei.TRANS_CODE = 'TransCode_130'
      and pa.end_date is null
      and pa.start_date >=to_date('2010-1-1','YYYY-MM-DD'); 
  end if ;
  
  IF in_flagOrpa = 'pa' then
     select return_value into v_resultpa from (select pa.return_value,pa.start_date,pa.end_date from pa_basic_data pa,HR_EXPERIENCE_INSIDE hei
    where pa.field1_value = hei.empid
      and pa.field1_value = in_empid
      and item_no = '42'
      and hei.TRANS_CODE = 'TransCode_130'
      and pa.end_date is not null
      and pa.end_date >= to_date('2010-1-1','YYYY-MM-DD')-1 
      order by pa.end_date desc) where rownum = 1 ;    
   END IF;
   
   
    IF in_flagOrpa = 'flag' 
     THEN
          RETURN v_resultflag;
     ELSE
           RETURN v_resultpa;
     END IF;

END PA_VALIDATE_PROMOTE2;
/

prompt
prompt Creating function PA_VALIDATE_RESIGNATION
prompt =========================================
prompt
CREATE OR REPLACE FUNCTION PA_VALIDATE_RESIGNATION (in_empid VARCHAR2, in_item_id VARCHAR2, in_pamonth VARCHAR2,in_work_startday DATE, in_work_endday DATE)
   RETURN INT
IS
   v_trans_code  	VARCHAR2(20)  := 'TransCode_200'; -- 离职
   --v_start_date     VARCHAR2(10);
   --v_end_date	    VARCHAR2(10);
   v_result		    INT;
BEGIN
   
   /*根据项目取得验证的开始结束日期*/
   /*SELECT DECODE(A.START_MONTH, 'PreviousMonth', TO_CHAR(ADD_MONTHS(TO_DATE(in_pamonth,'YYYYMM'),-1),'YYYY-MM') || '-' || A.START_DAY,
   		  					    'NextMonth', TO_CHAR(ADD_MONTHS(TO_DATE(in_pamonth,'YYYYMM'),1),'YYYY-MM') || '-' || A.START_DAY,
							    TO_CHAR(TO_DATE(in_pamonth,'YYYYMM'),'YYYY-MM') || '-' || A.START_DAY) AS START_DATE,
		  DECODE(A.END_MONTH, 'PreviousMonth', NVL(TO_CHAR(A.END_DAY),TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(in_pamonth,'YYYYMM'),-1)), 'YYYY-MM-DD')),
   		  					  'NextMonth', NVL(TO_CHAR(A.END_DAY),TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(in_pamonth,'YYYYMM'),1)), 'YYYY-MM-DD')),
							  TO_CHAR(TO_DATE(in_pamonth,'YYYYMM'),'YYYY-MM') || '-' || NVL(TO_CHAR(A.END_DAY),TO_CHAR(LAST_DAY(TO_DATE(in_pamonth,'YYYYMM')), 'DD'))) AS END_DATE
	 INTO v_start_date,
	 	  v_end_date
     FROM PA_ITEM A
	WHERE A.ITEM_ID = in_item_id;
   */
   /*验证在该区间内是否存在离职数据*/
    SELECT COUNT(*)
	  INTO v_result
	  FROM HR_RESIGNATION A
	 WHERE A.TRANS_CODE = v_trans_code
	   AND EMPID = in_empid
     --AND A.ACTIVITY =1
     --AND A.RESIGN_DATE BETWEEN TO_DATE(v_start_date, 'YYYY-MM-DD') AND TO_DATE(v_end_date, 'YYYY-MM-DD');
	   AND A.RESIGN_DATE BETWEEN in_work_startday AND in_work_endday;

   RETURN v_result;
	   
END PA_VALIDATE_RESIGNATION;
/

prompt
prompt Creating function PA_VALIDATE_SALARY_DATE
prompt =========================================
prompt
CREATE OR REPLACE FUNCTION PA_VALIDATE_SALARY_DATE (PA_MONTH IN VARCHAR,IN_EMPID IN VARCHAR)
   RETURN varchar
IS
   SALARY_DATE   varchar2(20);

BEGIN
   BEGIN

  SELECT TO_CHAR(MAX(START_DATE),'YYYY-MM-DD')
    INTO SALARY_DATE
    FROM PA_BASIC_DATA A
   WHERE A.FIELD1_VALUE = in_empid
	  AND A.ITEM_NO= '42'
    AND START_DATE >= ar_get_startdate(PA_MONTH)
    AND (END_DATE IS NULL OR END_DATE <=ar_get_enddate(PA_MONTH));

  IF SALARY_DATE IS NULL OR SALARY_DATE='' THEN
       SELECT TO_CHAR(MAX(START_DATE),'YYYY-MM-DD')
    INTO SALARY_DATE
    FROM PA_BASIC_DATA A
   WHERE A.FIELD1_VALUE = in_empid
	  AND A.ITEM_NO= '42'
    AND START_DATE < ar_get_startdate(PA_MONTH);

   END IF;

   END;

   RETURN SALARY_DATE;

END PA_VALIDATE_SALARY_DATE;
/

prompt
prompt Creating function PA_VALIDATE_SALARY_DATE_DAYS
prompt ==============================================
prompt
CREATE OR REPLACE FUNCTION PA_VALIDATE_SALARY_DATE_DAYS (PA_MONTH IN VARCHAR,IN_EMPID IN VARCHAR)
   RETURN NUMBER
IS
   SALARY_DATE   DATE;
   VDAYS         NUMBER;

BEGIN
   BEGIN

  SELECT MAX(START_DATE)
    INTO SALARY_DATE
    FROM PA_BASIC_DATA A
   WHERE A.FIELD1_VALUE = in_empid
	  AND A.ITEM_NO= '42'
    AND START_DATE >= ar_get_startdate(PA_MONTH)
    AND (END_DATE IS NULL OR END_DATE <=ar_get_enddate(PA_MONTH));

  IF SALARY_DATE IS NULL OR SALARY_DATE='' THEN
       SELECT MAX(START_DATE)
    INTO SALARY_DATE
    FROM PA_BASIC_DATA A
   WHERE A.FIELD1_VALUE = in_empid
	  AND A.ITEM_NO= '42'
    AND START_DATE < ar_get_startdate(PA_MONTH);

   END IF;

     SELECT COUNT(*) INTO VDAYS
      FROM HR_EMP_STATUS_HISTORY WHERE
          EMPID= IN_EMPID
         AND DATE_STR IN
     ( SELECT TO_CHAR(ddate,'YYYY-MM-DD')
        FROM AR_CALENDER
       WHERE ddate  < SALARY_DATE AND ddate >=ar_get_startdate(PA_MONTH)
       AND (typeid = 1 OR typeid = 3));


   END;

   RETURN VDAYS;

END PA_VALIDATE_SALARY_DATE_DAYS;
/

prompt
prompt Creating function PRIOR_PAMONTH
prompt ===============================
prompt
CREATE OR REPLACE FUNCTION prior_pamonth (pa_month_str VARCHAR2)
   RETURN VARCHAR2
IS
   RESULT   VARCHAR2 (6);
   v_mon    VARCHAR2 (2);
   v_year   VARCHAR2 (4);
BEGIN
   v_mon := SUBSTR (pa_month_str, 5, 2);
   v_year := SUBSTR (pa_month_str, 1, 4);

   IF v_mon > 1
   THEN
      v_mon := v_mon - 1;
   ELSE
      v_year := v_year - 1;
      v_mon := '12';
   END IF;

   IF LENGTH (v_mon) = 1
   THEN
      v_mon := '0' || v_mon;
   END IF;

   RESULT := v_year || v_mon;
   RETURN (RESULT);
END prior_pamonth;
/

prompt
prompt Creating function PROCESS_GET_DEF_STATUS
prompt ========================================
prompt
CREATE OR REPLACE FUNCTION PROCESS_GET_DEF_STATUS (IN_OBJECT_TYPE_ID VARCHAR2,
                                                  IN_CPNY_ID        VARCHAR2)
   RETURN VARCHAR2
IS
  OUT_STATUS_ID  VARCHAR2(400);
BEGIN
   SELECT T.DEFAULT_STATUS_ID INTO OUT_STATUS_ID FROM PROCESS_OBJECT_TYPE_INFO T WHERE T.OBJECT_TYPE_ID = IN_OBJECT_TYPE_ID AND T.CPNY_ID = IN_CPNY_ID;
   RETURN OUT_STATUS_ID;
END;
/

prompt
prompt Creating function PROCESS_GET_PROCESS_RESULT
prompt ============================================
prompt
CREATE OR REPLACE FUNCTION PROCESS_GET_PROCESS_RESULT(IN_PROCESS_NO IN VARCHAR2,
                                       IN_CPNY_ID              IN VARCHAR2)
                                       RETURN NUMBER
--返回0代表未审核结束
--返回1代表全部审核通过
--返回-1代表审核未通过
--返回null则表示没有此审核NO
IS
      OUT_PROCESS_RESULT   NUMBER(1,0);
BEGIN
  IF IN_PROCESS_NO IS NULL THEN
    RETURN NULL;
  ELSE
    DECLARE
        CURSOR CUS_AFFIRMOR_RESULT IS
        SELECT DISTINCT PA.AFFIRM_FLAG
        FROM PROCESS_AFFIRM PA
        WHERE PA.PROCESS_AFFIRM_NO = IN_PROCESS_NO
          AND PA.ACTIVITY = 1
          AND   PA.CPNY_ID = IN_CPNY_ID;
        AFFIRMOR_RESULT_ROW CUS_AFFIRMOR_RESULT%ROWTYPE;
    BEGIN
         OUT_PROCESS_RESULT := 1;
         OPEN CUS_AFFIRMOR_RESULT;
         LOOP
            FETCH CUS_AFFIRMOR_RESULT INTO AFFIRMOR_RESULT_ROW;
         EXIT WHEN CUS_AFFIRMOR_RESULT%NOTFOUND;
             IF AFFIRMOR_RESULT_ROW.AFFIRM_FLAG = 2 THEN
               RETURN -1;
             END IF;
             OUT_PROCESS_RESULT := TO_NUMBER(OUT_PROCESS_RESULT) * AFFIRMOR_RESULT_ROW.AFFIRM_FLAG;
         END LOOP;
         RETURN OUT_PROCESS_RESULT;
    END;
  END IF;
END;
/

prompt
prompt Creating function SPLIT
prompt =======================
prompt
create or replace function split(
   p_list varchar2,
   p_sep varchar2 := ','
)  return type_split pipelined
 is
   l_idx  pls_integer;
   v_list  varchar2(500) := p_list;
begin
   loop
      l_idx := instr(v_list,p_sep);
      if l_idx > 0 then
          pipe row(substr(v_list,1,l_idx-1));
          v_list := substr(v_list,l_idx+length(p_sep));
      else
          pipe row(v_list);
          exit;
      end if;
   end loop;
   return;
end split;
/

prompt
prompt Creating function STR2NUM
prompt =========================
prompt
CREATE OR REPLACE FUNCTION str2num (str VARCHAR2)
   RETURN NUMBER
IS
   v_num   NUMBER;
   i       NUMBER;
BEGIN
   i := -LENGTH (str);

   WHILE isnumber (SUBSTR (str, i)) = 0 AND i < 0
   LOOP
      i := i + 1;
   END LOOP;

   IF i = 0
   THEN
      v_num := 0;
   ELSE
      v_num := TO_NUMBER (SUBSTR (str, i));
   END IF;

   RETURN v_num;
END;
/

prompt
prompt Creating function SUMIF
prompt =======================
prompt
CREATE OR REPLACE FUNCTION sumif (
   v_table_name    VARCHAR2,
   v_column_name   VARCHAR2,
   v_condition     VARCHAR2
)
   RETURN NUMBER
IS
   v_str          VARCHAR2 (10000);
   v_return_num   NUMBER;
BEGIN
   v_str := 'SELECT SUM(' || v_column_name || ') FROM ' || v_table_name;

   IF TRIM (v_condition) IS NOT NULL
   THEN
      v_str := v_str || ' WHERE ' || v_condition;
   END IF;

   EXECUTE IMMEDIATE v_str
                INTO v_return_num;

   RETURN v_return_num;
END;
/

prompt
prompt Creating function SYS_GET_SCREEN_EN_NAME
prompt ========================================
prompt
CREATE OR REPLACE FUNCTION sys_get_screen_en_name (i_empid IN VARCHAR2)
   RETURN VARCHAR2
   IS
   v_name   VARCHAR2 (1000) := '';
/******************************************************************************
   NAME:       SYS_GET_SCREEN_NAME
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2006-6-26          1. Created this function.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     SYS_GET_SCREEN_NAME
      Sysdate:         2006-6-26
      Date and Time:   2006-6-26, ?? 03:24:17, and 2006-6-26 ?? 03:24:17
      Username:         (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   DECLARE
      CURSOR cur_screen
      IS
         SELECT *
           FROM (SELECT screen_grant_en_name, screen_grant_no,
                        CASE
                           WHEN INSTR ((SELECT ',' || screen_grant_no || ','
                                          FROM sy_admin
                                         WHERE adminid = i_empid),
                                       ',' || screen_grant_no||','
                                      ) > 0
                              THEN 1
                           ELSE 0
                        END AS a
                   FROM sy_login_screen)
          WHERE a = 1;

      cur_row   cur_screen%ROWTYPE;
   BEGIN
      OPEN cur_screen;

      LOOP
         FETCH cur_screen
          INTO cur_row;

         EXIT WHEN cur_screen%NOTFOUND;
         v_name := v_name || '|' || cur_row.screen_grant_en_name;
      END LOOP;

      CLOSE cur_screen;
   EXCEPTION
      WHEN OTHERS
      THEN
         v_name := '';
   END;

   v_name := SUBSTR (v_name, 2, LENGTH (v_name));
   RETURN v_name;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      NULL;
   WHEN OTHERS
   THEN
      -- Consider logging the error and then re-raise
      RAISE;
END sys_get_screen_en_name;
/

prompt
prompt Creating function SYS_GET_SCREEN_NAME
prompt =====================================
prompt
CREATE OR REPLACE FUNCTION sys_get_screen_name(i_empid IN VARCHAR2)
  RETURN VARCHAR2 IS
  v_name VARCHAR2(1000) := '';
  /******************************************************************************
     NAME:       SYS_GET_SCREEN_NAME
     PURPOSE:
  
     REVISIONS:
     Ver        Date        Author           Description
     ---------  ----------  ---------------  ------------------------------------
     1.0        2006-6-26          1. Created this function.
  
     NOTES:
  
     Automatically available Auto Replace Keywords:
        Object Name:     SYS_GET_SCREEN_NAME
        Sysdate:         2006-6-26
        Date and Time:   2006-6-26, ?? 03:24:17, and 2006-6-26 ?? 03:24:17
        Username:         (set in TOAD Options, Procedure Editor)
        Table Name:       (set in the "New PL/SQL Object" dialog)
  
  ******************************************************************************/
BEGIN
  DECLARE
    CURSOR cur_screen IS
      SELECT *
        FROM (SELECT screen_grant_name,
                     screen_grant_id,
                     CASE
                       WHEN INSTR((SELECT ',' || screen_grant_id || ','
                                    FROM sy_admin
                                   WHERE adminid = i_empid),
                                  ',' || screen_grant_no || ',') > 0 THEN
                        1
                       ELSE
                        0
                     END AS a
                FROM sy_login_screen)
       WHERE a = 1;
  
    cur_row cur_screen%ROWTYPE;
  BEGIN
    OPEN cur_screen;
  
    LOOP
      FETCH cur_screen
        INTO cur_row;
    
      EXIT WHEN cur_screen%NOTFOUND;
      v_name := v_name || ' | ' || cur_row.screen_grant_name;
    END LOOP;
  
    CLOSE cur_screen;
  EXCEPTION
    WHEN OTHERS THEN
      v_name := '';
  END;

  v_name := SUBSTR(v_name, 2, LENGTH(v_name));
  RETURN v_name;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    NULL;
  WHEN OTHERS THEN
    -- Consider logging the error and then re-raise
    RAISE;
END sys_get_screen_name;
/

prompt
prompt Creating function SY_GET_AFFIRM_OBJECT_NAME
prompt ===========================================
prompt
CREATE OR REPLACE FUNCTION sy_get_affirm_object_name (in_object_id IN VARCHAR2)
   RETURN VARCHAR2
IS
   v_object_name   VARCHAR2 (100) := '';
BEGIN
   v_object_name := get_emp_name (in_object_id);

   IF (v_object_name IS NULL)
   THEN
      v_object_name := get_dept_name (in_object_id);
   END IF;

   RETURN v_object_name;
END sy_get_affirm_object_name;
/

prompt
prompt Creating function SY_GET_PURVIEW
prompt ================================
prompt
CREATE OR REPLACE FUNCTION SY_GET_PURVIEW (IN_URL IN VARCHAR2,IN_EMPID VARCHAR2)
   RETURN NUMBER
IS
   FLAG  NUMBER := 0;
   FLAG2  NUMBER := 0;
   VAR_ACTION VARCHAR2(20);
   VAR_MENU VARCHAR2(20);
   RENUMBER NUMBER:=1;
BEGIN
  SELECT COUNT(0) INTO FLAG FROM SY_PURVIEW WHERE URL = IN_URL;
  IF FLAG > 0 THEN
  
    SELECT SY_MENU,ACTION INTO VAR_MENU,VAR_ACTION  FROM SY_PURVIEW WHERE URL = IN_URL;
    
      SELECT COUNT(0) INTO FLAG2 FROM SY_SCREEN_GRANT
          where SCREEN_GRANT_ID in (
           select TO_NUMBER(column_value) SCREEN_GRANT_ID from (
            select * from table (cast (split (( select SCREEN_GRANT_ID 
            from SY_ADMIN where ADMINID=IN_EMPID), ',') as TYPE_SPLIT) )

            )
          )
          AND SCREEN_CODE = VAR_MENU;
        
      IF FLAG2 = 0 THEN 
        RENUMBER:=0;
      ELSE    
       EXECUTE IMMEDIATE 'SELECT MAX('||VAR_ACTION||'R) ACTION FROM SY_SCREEN_GRANT '
        ||' where SCREEN_GRANT_ID in ('
        ||'    select TO_NUMBER(column_value) SCREEN_GRANT_ID from ('
        ||'        select * from table (cast (split (( select SCREEN_GRANT_ID '
        ||'         from SY_ADMIN where ADMINID='''||IN_EMPID||'''), '','') as TYPE_SPLIT) )'
        ||'      )'
        ||'     )'
        ||'   AND SCREEN_CODE = '''||VAR_MENU||''''
        ||'   group by SCREEN_CODE' INTO RENUMBER;
      END IF;  
  END IF;
  
  RETURN RENUMBER;
   
END SY_GET_PURVIEW;
/

prompt
prompt Creating function TAX
prompt =====================
prompt
CREATE OR REPLACE FUNCTION tax (v_income NUMBER, v_tax_type VARCHAR2)
   RETURN NUMBER
IS
   RESULT       NUMBER (14, 4);
   v_tax_rate   NUMBER (14, 4);
   v_deduct     NUMBER (14, 4);
BEGIN
   v_tax_rate := 0;
   v_deduct := 0;

   BEGIN
      SELECT tax_rate, deduct
        INTO v_tax_rate, v_deduct
        FROM pa_tax_rate
       WHERE v_tax_type = tax_type
         AND v_income BETWEEN income_from AND income_to;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RESULT := 0;
      WHEN OTHERS
      THEN
         RESULT := 0;
   END;

   RESULT := v_income * v_tax_rate - v_deduct;
   RETURN (RESULT);
END tax;
/

prompt
prompt Creating function TEMP
prompt ======================
prompt
CREATE OR REPLACE FUNCTION TEMP RETURN NUMBER IS
tmpVar NUMBER;
/******************************************************************************
   NAME:       TEMP
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2007-2-8          1. Created this function.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     TEMP
      Sysdate:         2007-2-8
      Date and Time:   2007-2-8, 18:11:56, and 2007-2-8 18:11:56
      Username:         (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   tmpVar := 0;
   RETURN tmpVar;
   EXCEPTION
     WHEN NO_DATA_FOUND THEN
       NULL;
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END TEMP;
/

prompt
prompt Creating function GET_EMP_SALES
prompt =====================
prompt
create or replace function GET_EMP_SALES(
    VAR_EMPID VARCHAR2,
    VAR_MONTH VARCHAR2
) return NUMBER 
is
    TOTAL_PRICE NUMBER;
begin
    SELECT NVL(SUM(PSO.DISCOUNT_PRICE),0) INTO TOTAL_PRICE FROM PROSTOR_SALES_ORDER PSO
    WHERE PSO.AFFIRM_FLAG = 'affirm1'
    AND PSO.ACTIVITY = 1
    AND PSO.EMPID = VAR_EMPID
    AND TO_CHAR(PSO.ORDER_DATE,'YYYYMM') = VAR_MONTH;
    RETURN TOTAL_PRICE;
end GET_EMP_SALES;
/

spool off
exit;