------------------------------------------------------
-- Export file for user WINE                        --
-- Created by Administrator on 2014-01-27, 11:41:46 --
------------------------------------------------------

set define off
spool views.log

prompt
prompt Creating view HR_PERSONAL_INFO_V
prompt ================================
prompt
CREATE OR REPLACE FORCE VIEW HR_PERSONAL_INFO_V AS
SELECT HRE.EMPID,
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
       TO_CHAR(BIRTHDAY, 'YYYY-MM-DD') BIRTHDAY,
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
       C.CODE_NAME AS MEMBERSHIP_NAME,
       C.CODE_EN_NAME AS MEMBERSHIP_EN_NAME,
       HRPI.MARITAL_STATUS_CODE,
       L.CODE_NAME AS MARITAL_STATUS_NAME,
       L.CODE_EN_NAME AS MARITAL_STATUS_EN_NAME,
       TO_CHAR(WEDDING_DATE, 'YYYY-MM-DD') WEDDING_DATE,
       HRPI.IDCARD_NO,
       HRPI.IDCARD_PROVINCE,
       E.CODE_NAME IDCARD_PROVINCE_NAME,
       E.CODE_EN_NAME IDCARD_PROVINCE_EN_NAME,
       HRPI.IDCARD_CITY,
       O.CODE_NAME IDCARD_CITY_NAME,
       O.CODE_EN_NAME IDCARD_CITY_EN_NAME,
       HRPI.IDCARD_AREA,
       P.CODE_NAME IDCARD_AREA_NAME,
       P.CODE_EN_NAME IDCARD_AREA_EN_NAME,
       HRPI.IDCARD_ADDRESS,
       HRPI.HOME_PROVINCE,
       T.CODE_NAME HOME_PROVINCE_NAME,
       T.CODE_EN_NAME HOME_PROVINCE_EN_NAME,
       HRPI.HOME_CITY,
       U.CODE_NAME HOME_CITY_NAME,
       U.CODE_EN_NAME HOME_CITY_EN_NAME,
       HRPI.HOME_AREA,
       V.CODE_NAME HOME_AREA_NAME,
       V.CODE_EN_NAME HOME_AREA_EN_NAME,
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
       B.CODE_EN_NAME AS SUPPLIER_EN_NAME
  FROM HR_EMPLOYEE         HRE,
       HR_PERSONAL_INFO    HRPI,
       HR_EMP_INFO         HREI,
       SY_CODE             A,
       SY_CODE             B,
       SY_CODE             C,
       SY_CODE             D,
       SY_CODE             E,
       SY_CODE             F,
       SY_CODE             G,
       SY_CODE             H,
       SY_CODE             I,
       SY_CODE             J,
       SY_CODE             K,
       SY_CODE             L,
       SY_CODE             M,
       SY_CODE             N,
       SY_CODE             O,
       SY_CODE             P,
       SY_CODE             Q,
       SY_CODE             R,
       SY_CODE             S,
       SY_CODE             T,
       SY_CODE             U,
       SY_CODE             V
 WHERE HRE.EMPID = HRPI.EMPID(+)
   AND HRE.EMPID = HREI.EMPID(+)
   AND HREI.SHIFT_CODE = A.CODE_ID(+)
   AND HREI.SUPPLIER_CODE = B.CODE_ID(+)
   AND HRPI.MEMBERSHIP = C.CODE_ID(+)
   AND HRPI.DEGREE_CODE = D.CODE_ID(+)
   AND HRPI.IDCARD_PROVINCE = E.CODE_ID(+)
   AND HRPI.GENDER_CODE = F.CODE_ID(+)
   AND HRPI.RELIGION_CODE = G.CODE_ID(+)
   AND HRPI.NATION_CODE = H.CODE_ID(+)
   AND HRPI.NATIONALITY_CODE = I.CODE_ID(+)
   AND HRPI.BORNPLACE_CODE = J.CODE_ID(+)
   AND HRPI.POLITY_CODE = K.CODE_ID(+)
   AND HRPI.MARITAL_STATUS_CODE = L.CODE_ID(+)
   AND HRPI.IDCARD_TYPE_CODE = M.CODE_ID(+)
   AND HRPI.FILE_RELATION_CODE = N.CODE_ID(+)
   AND HRPI.IDCARD_CITY = O.CODE_ID(+)
   AND HRPI.IDCARD_AREA = P.CODE_ID(+)
   AND HRPI.IDCARD_TYPE_CODE = Q.CODE_ID(+)
   AND HRPI.EDU_HIS_CODE = R.CODE_ID(+)
   AND HRPI.MAJOR_CODE = S.CODE_ID(+)
   AND HRPI.HOME_PROVINCE = T.CODE_ID(+)
   AND HRPI.HOME_CITY = U.CODE_ID(+)
   AND HRPI.HOME_AREA = V.CODE_ID(+);

prompt
prompt Creating view AR_CALENDER_GROUP_SHIFT_PRO_V
prompt ===========================================
prompt
CREATE OR REPLACE FORCE VIEW AR_CALENDER_GROUP_SHIFT_PRO_V AS
SELECT b.shift_name AS ar_name, a.shift_no,
            TO_DATE (   TO_CHAR (a.ddate, 'yyyymmdd')
                     || SUBSTR (TO_CHAR (c.to_time, 'yyyymmdd  HH24.mi.ss'),
                                9,
                                18
                               ),
                     'yyyy-mm-dd  HH24.mi.ss'
                    )
          + c.end_day_offset AS to_time,
            TO_DATE (   TO_CHAR (a.ddate, 'yyyymmdd')
                     || SUBSTR (TO_CHAR (c.from_time, 'yyyymmdd  HH24.mi.ss'),
                                9,
                                18
                               ),
                     'yyyy-mm-dd  HH24.mi.ss'
                    )
          + c.begin_day_offset AS from_time,
            (  (c.to_time + c.end_day_offset)
             - (c.from_time + c.begin_day_offset)
            )
          * 24 AS hours,
          a.ddate AS ar_date_str,
          DECODE (get_armonth (a.ddate),
                  'NO_DATA_FOUND', TO_CHAR (ddate, 'yyyymm'),
                  get_armonth (a.ddate)
                 ) AS ar_month_str,
          c.ar_item_no, a.workdayflag, a.typeid, a.GROUP_ID AS GROUP_ID
     FROM ar_calender_group a, ar_shift010 b, ar_shift020 c
    WHERE a.shift_no = b.shift_no AND a.shift_no = c.shift_no;

prompt
prompt Creating view AR_CALENDER_GROUP_SHIFT_V
prompt =======================================
prompt
CREATE OR REPLACE FORCE VIEW AR_CALENDER_GROUP_SHIFT_V AS
SELECT b.shift_name AS ar_name, c.to_time AS to_time,
          c.from_time AS from_time,
            (  (c.to_time + c.end_day_offset)
             - (c.from_time + c.begin_day_offset)
            )
          * 24 AS hours,
          a.ddate AS ar_date_str,
          DECODE (get_armonth (a.ddate),
                  'NO_DATA_FOUND', TO_CHAR (ddate, 'yyyymm'),
                  get_armonth (a.ddate)
                 ) AS ar_month_str,
          a.GROUP_ID AS GROUP_ID
     FROM ar_calender_group a, ar_shift010 b, ar_shift020 c
    WHERE a.shift_no = b.shift_no AND a.shift_no = c.shift_no;

prompt
prompt Creating view AR_CALENDER_SHIFT_V
prompt =================================
prompt
CREATE OR REPLACE FORCE VIEW AR_CALENDER_SHIFT_V AS
SELECT b.shift_name AS ar_name,
            (  (c.to_time + c.end_day_offset)
             - (c.from_time + c.begin_day_offset)
            )
          * 24 AS hours,
          TO_CHAR (a.ddate, 'yyyy/mm/dd') AS ar_date_str,
          DECODE (get_armonth (a.ddate),
                  'NO_DATA_FOUND', TO_CHAR (ddate, 'yyyymm'),
                  get_armonth (a.ddate)
                 ) AS ar_month_str,
          'N' AS lock_yn
     FROM ar_calender a, ar_shift010 b, ar_shift020 c
    WHERE a.shift_no = b.shift_no AND a.shift_no = c.shift_no;

prompt
prompt Creating view AR_CALENDER_SHIF_PRO_V
prompt ====================================
prompt
CREATE OR REPLACE FORCE VIEW AR_CALENDER_SHIF_PRO_V AS
SELECT b.shift_name AS ar_name, a.shift_no,
            TO_DATE (   TO_CHAR (a.ddate, 'yyyymmdd')
                     || SUBSTR (TO_CHAR (c.to_time, 'yyyymmdd  HH24.mi.ss'),
                                9,
                                18
                               ),
                     'yyyy-mm-dd  HH24.mi.ss'
                    )
          + c.end_day_offset AS to_time,
            TO_DATE (   TO_CHAR (a.ddate, 'yyyymmdd')
                     || SUBSTR (TO_CHAR (c.from_time, 'yyyymmdd  HH24.mi.ss'),
                                9,
                                18
                               ),
                     'yyyy-mm-dd  HH24.mi.ss'
                    )
          + c.begin_day_offset AS from_time,
            (  (c.to_time + c.end_day_offset)
             - (c.from_time + c.begin_day_offset)
            )
          * 24 AS hours,
          a.ddate AS ar_date_str,
          DECODE (get_armonth (a.ddate),
                  'NO_DATA_FOUND', TO_CHAR (ddate, 'yyyymm'),
                  get_armonth (a.ddate)
                 ) AS ar_month_str,
          c.ar_item_no, a.workdayflag, a.typeid
     FROM ar_calender a, ar_shift010 b, ar_shift020 c
    WHERE a.shift_no = b.shift_no AND a.shift_no = c.shift_no;

prompt
prompt Creating view AR_CONDITION_GROUP_LIST
prompt =====================================
prompt
CREATE OR REPLACE FORCE VIEW AR_CONDITION_GROUP_LIST AS
SELECT acl.condition_no, field_id, acl.field_name, table_name,
          group_condition_no, group_no, relation, value1, value2
     FROM ar_condition_list acl, ar_group_conditions agc
    WHERE acl.condition_no(+) = agc.field_name;

prompt
prompt Creating view AR_DAILY_SCHEDULE_V
prompt =================================
prompt
CREATE OR REPLACE FORCE VIEW AR_DAILY_SCHEDULE_V AS
SELECT   empid, item_name, short_name, MIN (from_time) AS from_time,
            MAX (to_time) AS to_time,
            SUM ((to_time - from_time) * 24) AS hours,
            SUM ((to_time - from_time) * 24 * 60) AS minutes, ar_date_str,
            ar_month_str, lock_yn
       FROM ar_schedule LEFT JOIN ar_item ON ar_schedule.ar_item_no =
                                                               ar_item.item_no
   GROUP BY empid,
            ar_item_no,
            ar_date_str,
            item_name,
            short_name,
            ar_month_str,
            lock_yn;

prompt
prompt Creating view AR_DETAIL_PRV
prompt ===========================
prompt
CREATE OR REPLACE FORCE VIEW AR_DETAIL_PRV AS
SELECT ar_item_no, empid, (SELECT item_name
                                FROM ar_item
                               WHERE item_no = ar_item_no) AS ar_item_name,
          shift_no,
          (SELECT shift_name
             FROM ar_shift010
            WHERE ar_shift010.shift_no = ar_detail.shift_no) AS shift_name,
          TO_DATE (ar_date_str, 'yyyy-mm-dd') AS ar_date_str, ar_month_str,
          quantity,
          DECODE (date_type,
                  1, '平时',
                  2, '周末',
                  3, '法定假日',
                  NULL
                 ) AS date_type
     FROM ar_detail;

prompt
prompt Creating view AR_DYNAMIC_GROUP_V
prompt ================================
prompt
CREATE OR REPLACE FORCE VIEW AR_DYNAMIC_GROUP_V AS
SELECT group_no, group_name, description, create_date,
          get_emp_name (created_by) created_by, update_date,
          get_emp_name (updated_by) updated_by
     FROM ar_dynamic_group;

prompt
prompt Creating view AR_MONTH_STA_V
prompt ============================
prompt
CREATE OR REPLACE FORCE VIEW AR_MONTH_STA_V AS
SELECT   empid, ar_item_no, SUM (quantity) quantity, COUNT (*) times
       FROM ar_detail
   GROUP BY empid, ar_item_no, ar_month_str;

prompt
prompt Creating view AR_SUPERVISOR_V
prompt =============================
prompt
CREATE OR REPLACE FORCE VIEW AR_SUPERVISOR_V AS
SELECT ar_supervisor_no, ar_supervisor_id, e.chinesename,
          supervised_deptid, deptname, a.create_date,
          e2.chinesename AS created_by, a.update_date,
          e3.chinesename AS updated_by, a.orderno, a.activity
     FROM hr_employee e,
          hr_employee e2,
          hr_employee e3,
          ar_supervisor_info a,
          hr_department d
    WHERE ar_supervisor_id = e.empid
      AND supervised_deptid = d.deptid
      AND a.created_by = e2.empid(+)
      AND a.updated_by = e3.empid(+);

prompt
prompt Creating view ESS_AFFIRM_V
prompt ==========================
prompt
CREATE OR REPLACE FORCE VIEW ESS_AFFIRM_V AS
SELECT ess_affirm_no, apply_no, affirm_flag, affirm_level, affirmor_id,
          get_emp_name (affirmor_id) affirmor_name, update_date, activity,
          apply_type
     FROM ess_affirm;

prompt
prompt Creating view ESS_FAMILY_V
prompt ==========================
prompt
CREATE OR REPLACE FORCE VIEW ESS_FAMILY_V AS
SELECT family_no, hre.empid, hre.chinesename, fam_type_code,
       sy1.code_name AS family_type, fam_name, fam_name_pinyin, fam_borndate,
       fam_idcard, fam_educ_code, sy2.code_name AS family_education,
       fam_occup_code, sy3.code_name AS family_occup, fam_nationality_code,
       sy4.code_name AS family_nationality, fam_home_addr, fam_phone,
       hrf.create_date, hrf.created_by, hrf.update_date, hrf.updated_by,
       hrf.orderno, hrf.activity, hrf.fam_company_name,
       hrf.fam_degree AS fam_degree_code,
       get_sys_code (hrf.fam_degree) AS fam_degree
  FROM hr_employee hre,
       ess_family hrf,
       sy_code sy1,
       sy_code sy2,
       sy_code sy3,
       sy_code sy4
 WHERE hre.empid = hrf.empid
   AND sy1.code_id(+) = hrf.fam_type_code
   AND sy2.code_id(+) = hrf.fam_educ_code
   AND sy3.code_id(+) = hrf.fam_occup_code
   AND sy4.code_id(+) = hrf.fam_nationality_code;

prompt
prompt Creating view ESS_SUPERVISOR_GRANT_V
prompt ====================================
prompt
CREATE OR REPLACE FORCE VIEW ESS_SUPERVISOR_GRANT_V AS
SELECT he.empid, he.chinesename, he.deptid, ar_supervisor_id,
          he1.chinesename AS ar_supervisor_name
     FROM hr_employee he, ar_supervisor_info asi, hr_employee he1
    WHERE he.deptid = asi.supervised_deptid(+) AND asi.ar_supervisor_id = he1.empid(+);

prompt
prompt Creating view ETN_COUNT_FACT_GROUP_V
prompt ====================================
prompt
CREATE OR REPLACE FORCE VIEW ETN_COUNT_FACT_GROUP_V AS
SELECT   seq_etn_plan, COUNT (*) AS countgroup
       FROM etn_fact_plan
   GROUP BY seq_etn_plan;

prompt
prompt Creating view ETN_COUNT_PERSON_PLAN_V
prompt =====================================
prompt
CREATE OR REPLACE FORCE VIEW ETN_COUNT_PERSON_PLAN_V AS
SELECT   seq_etn_plan, COUNT (*) AS countperson
       FROM etn_plan_group
   GROUP BY seq_etn_plan;

prompt
prompt Creating view ETN_COUNT_PERSON_V
prompt ================================
prompt
CREATE OR REPLACE FORCE VIEW ETN_COUNT_PERSON_V AS
SELECT   seq_etn_plan, COUNT (*) AS countperson
       FROM etn_fact_plan
   GROUP BY seq_etn_plan;

prompt
prompt Creating view ETN_YEAR_PLAN_V
prompt =============================
prompt
CREATE OR REPLACE FORCE VIEW ETN_YEAR_PLAN_V AS
SELECT seq_year_plan, eyp.plan_edu_remark, eyp.plan_edu_time_danwei,
          eyp.plan_code, eyp.plan_edu_item_code, sy1.code_name AS plan_edu_item_name,
          eyk.plan_class_type_code, eyk.etn_fit_group as plan_fit_group, plan_edu_time,
          plan_perrior_count, plan_start_date, plan_end_date,
          plan_edu_type_code, sy2.code_name AS plan_edu_type_name, plan_color,
          plan_intend_fee, manage_department, promotion_needed,
          sy3.code_name AS promotion_needed_name, type_edu_result,
          sy4.code_name AS type_edu_name,eyp.plan_sort_code,
          sy5.code_name As plan_sort_name,eyp.PLAN_EDU_SORT_CODE,etnFormat,
          sy6.code_name As etnFormat_name,
          (SELECT SUM (te.plan_edu_time)
             FROM etn_year_plan te
             WHERE to_char(te.plan_start_date,'yyyy')=to_char(eyp.plan_start_date,'yyyy')
          ) AS totaltime,
          (SELECT SUM (te.plan_intend_fee)
             FROM etn_year_plan te
             WHERE to_char(te.plan_start_date,'yyyy')=to_char(eyp.plan_start_date,'yyyy')
          ) AS totalfee,
          (SELECT COUNT (te.plan_perrior_count)
             FROM etn_year_plan te
             WHERE to_char(te.plan_start_date,'yyyy')=to_char(eyp.plan_start_date,'yyyy')
          ) AS totalperrior,
          (SELECT max (to_char(te.plan_start_date,'yyyy-mm-dd'))
             FROM etn_year_plan te
             WHERE to_char(te.plan_start_date,'yyyy')=to_char(eyp.plan_start_date,'yyyy')
          ) AS maxdate,
           eyp.class_name,
           eyp.quantity,
           eyp.edu_type,
           sy7.code_name as edu_type_name,
           eyp.plan_man_count,
           eyp.shiyongduixiang,
           eyp.submityn
     FROM etn_year_plan eyp,
          etn_plan_kinds eyk,
          sy_code sy1,
          sy_code sy2,
          sy_code sy3,
          sy_code sy4,
          sy_code sy5,
          sy_code sy6,
          sy_code sy7
    WHERE eyp.plan_edu_item_code = sy1.code_id(+)
      AND eyp.plan_edu_type_code = sy2.code_id(+)
      AND eyp.promotion_needed = sy3.code_id(+)
      AND eyp.type_edu_result = sy4.code_id(+)
      And eyp.plan_sort_code = sy5.code_id(+)
      And eyp.etnformat = sy6.code_id(+)
      and eyp.plan_code = eyk.plan_code
      and eyp.edu_type = sy7.code_id(+);

prompt
prompt Creating view ETN_TEACHER_FEE_V
prompt ===============================
prompt
CREATE OR REPLACE FORCE VIEW ETN_TEACHER_FEE_V AS
SELECT   etn_plan_no,
            SUM (teacher_edu_time * teacher_fee_hour) AS count_teacher_fee
       FROM etn_teacher_fee
   GROUP BY etn_plan_no;

prompt
prompt Creating view ETN_PLAN_FEE_V
prompt ============================
prompt
CREATE OR REPLACE FORCE VIEW ETN_PLAN_FEE_V AS
SELECT ef.etn_plan_no, fee_teach_text, fee_ground, fee_eatting,
          fee_quarter, fee_trrafic, fee_passport, fee_visa, fee_insure,
          fee_living, fee_other, count_teacher_fee,exploitation,
          (  NVL (fee_teach_text, 0)
           + NVL (fee_ground, 0)
           + NVL (fee_eatting, 0)
           + NVL (fee_quarter, 0)
           + NVL (fee_trrafic, 0)
           + NVL (fee_passport, 0)
           + NVL (fee_visa, 0)
           + NVL (fee_insure, 0)
           + NVL (fee_living, 0)
           + NVL (fee_other, 0)
           + NVL (count_teacher_fee, 0)
           + NVL (exploitation ,0)
          ) AS total_fee
     FROM etn_fee ef, etn_teacher_fee_v etfv
    WHERE ef.etn_plan_no = etfv.etn_plan_no(+);

prompt
prompt Creating view ETN_PLAN_V
prompt ========================
prompt
CREATE OR REPLACE FORCE VIEW ETN_PLAN_V AS
SELECT   seq_etn_plan, etn.plan_edu_item_code,
            sc1.code_name AS plan_edu_item_name, etn.plan_class_type_code as plan_class_type,
            ep.plan_edu_type_code, sc2.code_name AS plan_edu_type_name,
            plan_edu_place, ep.plan_start_date, ep.plan_end_date, ep.plan_edu_time,
            plan_appraise_content, ep.plan_code, year_plan_no,
            ep.plan_edu_time_danwei,ep.plan_edu_sort_code,etn.plan_sort_code,
            sc3.code_name As plan_sort_name,etn.etnFormat,sc4.code_name As etnFormat_name,
            etn.seq_year_plan,
            ep.plan_perrior_count,
            (select count(*) from ETN_FACT_PLAN where ETN_FACT_PLAN.Seq_Etn_Plan = ep.seq_etn_plan)*ep.plan_edu_time as etn_man_count,
            etn.edu_type as etn_type,
            sc5.code_name as etn_type_name,
            etn.shiyongduixiang,
            round((select count(*) from etn_fact_plan t where t.seq_etn_plan=ep.seq_etn_plan and t.appraise_result>=60)/(select count(*) 
            from etn_fact_plan t where t.seq_etn_plan=ep.seq_etn_plan),2)*100 rate,
            SUBMITYN         as submityn,
            (select count(*) from etn_fact_plan t where t.seq_etn_plan=ep.seq_etn_plan) as mantotal,
            ep.etn_year_no
       FROM etn_plan ep, sy_code sc1, sy_code sc2,sy_code sc3,sy_code sc4,etn_year_plan etn,sy_code sc5
      WHERE etn.plan_edu_item_code = sc1.code_id(+)
            AND ep.plan_edu_type_code = sc2.code_id(+)
            And etn.Plan_Sort_Code = sc3.code_id(+)
            And etn.etnformat = sc4.code_id(+)
            and ep.plan_code = etn.plan_code(+)
            and ep.etn_year_no = etn.seq_year_plan
            and etn.edu_type = sc5.code_id(+)
   ORDER BY seq_etn_plan DESC;

prompt
prompt Creating view ETN_RESULT_FOR_RE
prompt ===============================
prompt
CREATE OR REPLACE FORCE VIEW ETN_RESULT_FOR_RE AS
SELECT   epv.seq_etn_plan, epv.plan_edu_item_code, epv.plan_edu_item_name,
            epv.plan_class_type, epv.plan_edu_type_code,
            epv.plan_edu_type_name, epv.plan_edu_place, epv.plan_start_date,
            epv.plan_end_date, epv.plan_edu_time, plan_appraise_content,
            epv.plan_code, year_plan_no, fee_teach_text, fee_ground,
            fee_eatting, fee_quarter, fee_trrafic, fee_passport, fee_visa,
            fee_insure, fee_living, fee_other, count_teacher_fee, total_fee,
            countperson, eypv.plan_code AS plan_code_y,
            eypv.plan_edu_item_code AS plan_edu_item_code_y,
            eypv.plan_edu_item_name AS plan_edu_item_name_y,
            eypv.plan_class_type_code AS plan_class_type_code_y,
            eypv.plan_fit_group AS plan_fit_group_y,
            eypv.plan_edu_time AS plan_edu_time_y,
            eypv.plan_perrior_count AS plan_perrior_count_y,
            eypv.plan_start_date AS plan_start_date_y,
            eypv.plan_end_date AS plan_end_date_y,
            eypv.plan_edu_type_code AS plan_edu_type_code_y,
            eypv.plan_edu_type_name AS plan_edu_type_name_y,
            eypv.plan_color AS plan_color_y,
            eypv.plan_intend_fee AS plan_intend_fee_y,
            eypv.manage_department AS manage_department_y,
            eypv.promotion_needed AS promotion_needed_y,
            eypv.promotion_needed_name AS promotion_needed_name_y,
            eypv.totaltime AS totaltime_y, eypv.totalfee AS totalfee_y,
            eypv.totalperrior AS totalperrior_y
       FROM etn_count_person_v ecpv,
            etn_plan_v epv,
            etn_plan_fee_v epfv,
            etn_year_plan_v eypv
      WHERE epv.seq_etn_plan = ecpv.seq_etn_plan(+)
        AND epv.seq_etn_plan = epfv.etn_plan_no(+)
        AND epv.year_plan_no = eypv.seq_year_plan(+)
   ORDER BY epv.plan_start_date DESC;

prompt
prompt Creating view ETN_ITEM_FOR_RE
prompt =============================
prompt
CREATE OR REPLACE FORCE VIEW ETN_ITEM_FOR_RE AS
SELECT   plan_edu_item_code, plan_edu_item_name,
            SUM (countperson) AS countperson_g,
            SUM (plan_edu_time) AS plan_edu_time_g,
            SUM (total_fee) AS total_fee_g,
            SUM (plan_end_date - plan_start_date) AS totaltime,
            round(SUM (total_fee)/SUM (countperson),2) as plan_edu_feeavg,
            round(SUM (plan_edu_time)/SUM (countperson),2) as plan_edu_timeavg
       FROM etn_result_for_re
   GROUP BY plan_edu_item_code, plan_edu_item_name;

prompt
prompt Creating view ETN_NO_EDU_PERSON
prompt ===============================
prompt
CREATE OR REPLACE FORCE VIEW ETN_NO_EDU_PERSON AS
SELECT pg.empid, pg.seq_etn_plan
     FROM etn_plan_group pg
   MINUS
   SELECT fp.empid, fp.seq_etn_plan
     FROM etn_fact_plan fp, etn_plan_group pg
    WHERE pg.empid = fp.empid AND pg.seq_etn_plan = fp.seq_etn_plan;

prompt
prompt Creating view ETN_PLAN_KINDS_V
prompt ==============================
prompt
CREATE OR REPLACE FORCE VIEW ETN_PLAN_KINDS_V AS
SELECT seq_plan_kinds, plan_edu_item_code,
          sc1.code_name AS plan_edu_item_name, plan_class_type_code, plan_code,
          etn_fit_group,
          epk.plan_edu_sort_code,epk.plan_sort_code,sc2.code_name As
          plan_sort_name
     FROM etn_plan_kinds epk, sy_code sc1, sy_code sc2
    WHERE epk.plan_edu_item_code = sc1.code_id(+)
    And epk.plan_sort_code = sc2.code_id(+);

prompt
prompt Creating view ETN_PLAN_TEACHER_V
prompt ================================
prompt
CREATE OR REPLACE FORCE VIEW ETN_PLAN_TEACHER_V AS
SELECT etn_plan_no, teacher_no, teacher_name, out_teacher_fee,
       et.teacher_enable_class
     FROM etn_plan_teacher ept, etn_teacher et
    WHERE ept.teacher_no = et.seq_etn_teacher(+);

prompt
prompt Creating view ETN_PLAN_TERM_FOR_RE
prompt ==================================
prompt
CREATE OR REPLACE FORCE VIEW ETN_PLAN_TERM_FOR_RE AS
SELECT seq_etn_plan, plan_edu_item_code, plan_edu_item_name,
          plan_class_type, plan_edu_type_code, plan_edu_type_name,
          plan_edu_place, plan_start_date, plan_end_date, plan_edu_time,
          plan_appraise_content, plan_code, year_plan_no, fee_teach_text,
          fee_ground, fee_eatting, fee_quarter, fee_trrafic, fee_passport,
          fee_visa, fee_insure, fee_living, fee_other, count_teacher_fee,
          total_fee, countperson, plan_code_y, plan_edu_item_code_y,
          plan_edu_item_name_y, plan_class_type_code_y, plan_fit_group_y,
          plan_edu_time_y, plan_perrior_count_y, plan_start_date_y,
          plan_end_date_y, plan_edu_type_code_y, plan_edu_type_name_y,
          plan_color_y, plan_intend_fee_y, manage_department_y,
          promotion_needed_y, promotion_needed_name_y, totaltime_y,
          totalfee_y, totalperrior_y, whole_satisfaction,
          edu_term_satisfaction, edu_place_satisfaction,
          edu_methord_satisfact, edu_teacher_total_satis,
          edu_class_satisfaction, eligibility_rate, makeup_success_rate,
          count_fell_back, connt_award
     FROM etn_result_for_re erfr,
          etn_whole_satisfaction ews,
          etn_whole_result ewr
    WHERE erfr.seq_etn_plan = ews.etn_plan_no(+) AND erfr.seq_etn_plan = ewr.etn_plan_no(+);

prompt
prompt Creating view ETN_PLAN_TOTAL_V
prompt ==============================
prompt
CREATE OR REPLACE FORCE VIEW ETN_PLAN_TOTAL_V AS
SELECT DISTINCT epv.seq_etn_plan, epv.plan_edu_item_code,
                   epv.plan_edu_item_name, epv.plan_class_type,
                   epv.plan_edu_type_code, epv.plan_edu_type_name,
                   epv.plan_edu_place, epv.plan_start_date, epv.plan_end_date,
                   epv.plan_edu_time, epv.plan_appraise_content,
                   epv.plan_code, epv.year_plan_no, fee_teach_text,
                   fee_ground, fee_eatting, fee_quarter, fee_trrafic,
                   fee_passport, fee_visa, fee_insure, fee_living, fee_other,
                   count_teacher_fee, total_fee, eyp.plan_perrior_count,
                   eyp.plan_fit_group
              FROM etn_plan_v epv, etn_plan_fee_v epfv, etn_year_plan eyp
             WHERE epv.seq_etn_plan = epfv.etn_plan_no(+)
                   AND epv.year_plan_no = eyp.seq_year_plan(+);

prompt
prompt Creating view ETN_PLAN_V_DETAL
prompt ==============================
prompt
CREATE OR REPLACE FORCE VIEW ETN_PLAN_V_DETAL AS
SELECT      seq_etn_plan,
            sc5.code_name as etn_type_name,
            sc1.code_name AS plan_edu_item_name, etn.plan_class_type_code as plan_class_type,
            ep.plan_edu_type_code, sc2.code_name AS plan_edu_type_name,
            plan_edu_place, ep.plan_start_date, ep.plan_end_date, ep.plan_edu_time,
            plan_appraise_content, ep.plan_code, year_plan_no,
            ep.plan_edu_time_danwei,
            etn.etnFormat,sc4.code_name As etnFormat_name,
            etn.seq_year_plan,
            ep.plan_perrior_count,
            (select count(*) from ETN_FACT_PLAN where ETN_FACT_PLAN.Seq_Etn_Plan = ep.seq_etn_plan) as total_man,
            (select count(*) from ETN_FACT_PLAN where ETN_FACT_PLAN.Seq_Etn_Plan = ep.seq_etn_plan)*ep.plan_edu_time as etn_man_count,
            etn.class_name,
            etn.shiyongduixiang,
            nvl(ev.total_fee,0) totalfee,
            nvl(ev.count_teacher_fee,0)    teacherfee,
            nvl(ev.fee_teach_text,0)   teachertextfee,
            nvl(ev.fee_ground,0)      groundfee,
            nvl(ev.fee_eatting,0)    eattingfee,
            nvl(ev.fee_quarter,0)    quarterfee,
            nvl(ev.fee_trrafic,0)    trraficfee,
            nvl(ev.fee_other,0) otherfee
       FROM etn_plan ep, sy_code sc1, sy_code sc2,sy_code sc4,etn_year_plan etn,sy_code sc5,etn_plan_kinds ek,ETN_PLAN_FEE_V ev
      WHERE etn.plan_edu_item_code = sc1.code_id(+)
            AND ep.plan_edu_type_code = sc2.code_id(+)
            And etn.etnformat = sc4.code_id(+)
            and ep.plan_code = etn.plan_code(+)
            and ep.etn_year_no = etn.seq_year_plan
            and ek.plan_sort_code = sc5.code_id(+)
            and ek.plan_code=ep.plan_code
            and ev.etn_plan_no(+) = seq_etn_plan
   ORDER BY seq_etn_plan DESC;

prompt
prompt Creating view ETN_PROTOCOL_V
prompt ============================
prompt
CREATE OR REPLACE FORCE VIEW ETN_PROTOCOL_V AS
SELECT distinct seq_protocol_etn, protocol_code, protocol_name,
          protocol_personal_name, ep.protocol_start_date, ep.protocol_end_date,
          protocol_term, protocol_content, protocol_empid, yearplan_no,
          fell_back_fee, eyp.plan_class_type_code,
          all_fell_back_fee,protocol_date,
          PROTOCOL_CUT_DATE
     FROM etn_protocol ep,etn_year_plan_v eyp
    WHERE ep.yearplan_no = eyp.plan_code(+);

prompt
prompt Creating view ETN_RESULT_STATISTIC_V
prompt ====================================
prompt
CREATE OR REPLACE FORCE VIEW ETN_RESULT_STATISTIC_V AS
SELECT seq_year_plan, eypv.plan_edu_time, eypv.plan_start_date,
          eypv.plan_end_date, eypv.plan_intend_fee, eypv.type_edu_result,
          eptv.seq_etn_plan, eptv.plan_edu_time AS plan_edu_time_f,
          eptv.plan_start_date AS plan_start_date_f,
          eptv.plan_end_date AS plan_end_date_f,
          eptv.total_fee AS total_fee_f, ecppv.countperson AS p_countperson,
          ecpv.countperson AS f_countperson
     FROM etn_year_plan_v eypv,
          etn_plan_total_v eptv,
          etn_count_person_plan_v ecppv,
          etn_count_person_v ecpv
    WHERE eypv.seq_year_plan = eptv.year_plan_no(+)
      AND eptv.seq_etn_plan = ecppv.seq_etn_plan(+)
      AND eptv.seq_etn_plan = ecpv.seq_etn_plan(+);

prompt
prompt Creating view ETN_TEACHER_SATISFACT_V
prompt =====================================
prompt
CREATE OR REPLACE FORCE VIEW ETN_TEACHER_SATISFACT_V AS
SELECT etn_plan_no, teacher_no, score, teacher_name, class_name_group,
          edu_department
     FROM etn_teacher_satisfact ets, etn_teacher et
    WHERE ets.teacher_no = et.seq_etn_teacher(+);

prompt
prompt Creating view ETN_TEACHER_DOCUMENT
prompt ==================================
prompt
CREATE OR REPLACE FORCE VIEW ETN_TEACHER_DOCUMENT AS
SELECT etsv.etn_plan_no, etsv.teacher_no, score, etsv.teacher_name,
          class_name_group, teacher_edu_time, teacher_fee_hour, seq_etn_plan,
          ep.plan_edu_item_code, ep.plan_class_type, ep.plan_edu_type_code,
          ep.plan_edu_place, ep.plan_start_date, ep.plan_end_date,
          edu_department, ep.plan_edu_time, ep.plan_appraise_content,
          manage_department, promotion_needed, ep.plan_code, ep.year_plan_no
     FROM etn_teacher_satisfact_v etsv,
          etn_teacher_fee etf,
          etn_plan ep,
          etn_year_plan eyp
    WHERE etsv.teacher_no = etf.teacher_no(+)
      AND etsv.etn_plan_no = ep.seq_etn_plan(+)
      AND ep.year_plan_no = eyp.seq_year_plan(+);

prompt
prompt Creating view ETN_TEACHINGMATERIAL_V
prompt ====================================
prompt
CREATE OR REPLACE FORCE VIEW ETN_TEACHINGMATERIAL_V AS
SELECT seq_teachtext_ma, etm.plan_code, class_name, class_edition,
          class_brief, plan_edu_item_code, modify_date, modify_person,
          sc.code_name AS plan_edu_item_name, plan_class_type_code,PLAN_SORT_CODE,
          sc1.code_name as plan_sort_name,etm.book_name as book_name
     FROM etn_teachingmaterial_manage etm, etn_plan_kinds epk, sy_code sc,sy_code sc1
    WHERE etm.plan_code = epk.plan_code(+) AND epk.plan_edu_item_code = sc.code_id(+)
    and epk.plan_sort_code=sc1.code_id(+);

prompt
prompt Creating view ETN_YEARPLAN_FOR_CALENDER_V
prompt =========================================
prompt
CREATE OR REPLACE FORCE VIEW ETN_YEARPLAN_FOR_CALENDER_V AS
SELECT seq_year_plan, eyp.plan_edu_remark, eyp.plan_code,
          eyp.plan_edu_item_code, eyp.plan_class_type_code,
          eyp.plan_fit_group, eyp.plan_edu_time, eyp.plan_perrior_count,
          eyp.plan_start_date, eyp.plan_end_date, eyp.plan_edu_type_code,
          plan_intend_fee, eyp.plan_color, plan_flag,
          CASE
             WHEN NOT ep.year_plan_no IS NULL
                THEN '1'
             ELSE '0'
          END AS flag
     FROM etn_year_plan eyp, etn_plan ep
    WHERE eyp.seq_year_plan = ep.year_plan_no(+);

prompt
prompt Creating view EVA_ACHIEVEMENT_V
prompt ===============================
prompt
CREATE OR REPLACE FORCE VIEW EVA_ACHIEVEMENT_V AS
(SELECT   RESULT.ev_period_id, RESULT.ev_emp_id,
             HR_CONVERT(MAX (DECODE (RESULT.ev_process_id,
                          'EVPROCESS001', RESULT.ev_detail_idea,
                          ''
                         )
                 )) "目标设定",
             SUM (DECODE (RESULT.ev_process_id,
                          'EVPROCESS006', RESULT.ev_detail_mark,
                          0
                         )
                 ) "一次评价分数",
             SUM (DECODE (RESULT.ev_process_id,
                          'EVPROCESS007', RESULT.ev_detail_mark,
                          0
                         )
                 ) "二次评价分数"
        FROM (SELECT a.ev_period_id, l.ev_period_name, a.ev_emp_id,
                     a.ev_emp_name, a.ev_dept_id, a.ev_dept_name,
                     a.ev_type_id, e.code_name ev_type_name,
                     i.ev_process_prop, i.ev_operate_id,
                     h.code_name ev_operate_name, d.ev_process_id,
                     k.code_name ev_process_name, b.ev_item_id,
                     g.code_name ev_item_name, ecd.ev_column_id,
                     ecd.ev_column_detail, d.ev_idea ev_detail_idea,
                     d.ev_mark ev_detail_mark, i.ev_item_prop,
                     b.ev_detail_prop, b.ev_detail_order,
                     a.ev_mark ev_final_mark, a.ev_grade_id,
                     f.code_name ev_final_grade, b.seq_ev_item_detail
                FROM eva_emp a,
                     eva_item_detail b,
                     eva_column_detail ecd,
                     eva_detail_mark d,
                     sy_code e,
                     sy_code f,
                     sy_code g,
                     sy_code h,
                     eva_relation i,
                     sy_code k,
                     eva_period l
               WHERE                       --A.EV_EMP_ID           = '1111111'
                     a.ev_type_id <> 'EVTYPE007'
                 AND a.ev_process_id = 'EVPROCESS010'
                 AND b.ev_item_id = 'EVITEM002'
                 --AND a.EV_PERIOD_ID       ='200705'
                 AND a.ev_period_id = b.ev_period_id
                 AND a.ev_emp_id = b.ev_emp_id
                 AND b.seq_ev_item_detail = d.seq_ev_item_detail
                 AND b.seq_ev_item_detail = ecd.seq_ev_item_detail
                 AND a.ev_type_id = e.code_id
                 AND a.ev_grade_id = f.code_id
                 AND b.ev_item_id = g.code_id
                 AND i.ev_operate_id = h.code_id
                 AND a.ev_period_id = i.ev_period_id
                 AND a.ev_type_id = i.ev_type_id
                 AND d.ev_process_id = i.ev_process_id
                 AND b.ev_item_id = i.ev_item_id
                 AND d.ev_process_id = k.code_id
                 AND a.ev_period_id = l.ev_period_id) RESULT
    GROUP BY (RESULT.ev_period_id, RESULT.ev_emp_id));

prompt
prompt Creating view EVA_MIDMARK_V
prompt ===========================
prompt
create or replace force view eva_midmark_v as
select
       a.empid,a.ev_period_id,
       a.ev_process_id,
       avg(a.ev_mark) av_mark
from
     (select eid.ev_emp_id as empid,eid.ev_period_id ,edm.ev_process_id,edm.ev_mark
              from  eva_detail_mark edm,
                    eva_column_detail ecd,
                    eva_item_detail eid
              where edm.seq_ev_item_detail=ecd.seq_ev_item_detail
                    and eid.seq_ev_item_detail=ecd.seq_ev_item_detail
                    and eid.ev_item_id='EVITEM007'
                    and edm.ev_process_id<>'EVPROCESS001')a
      group by a.empid,a.ev_period_id,a.ev_process_id;

prompt
prompt Creating view EVA_BUSINESS_MARK_V
prompt =================================
prompt
create or replace force view eva_business_mark_v as
select t1.empid,t1.ev_period_id,first_estimation_mark,second_estimation_mark from
     (select emv.empid,emv.ev_period_id,emv.ev_process_id ,emv.av_mark as first_estimation_mark from eva_midmark_v emv where emv.ev_process_id='EVPROCESS006') t1,
     (select emv.empid,emv.ev_period_id,emv.ev_process_id ,emv.av_mark as second_estimation_mark from eva_midmark_v emv where emv.ev_process_id='EVPROCESS007') t2
     where t1.empid=t2.empid
     and t1.ev_period_id=t2.ev_period_id;

prompt
prompt Creating view EVA_BUSINESS_V
prompt ============================
prompt
CREATE OR REPLACE FORCE VIEW EVA_BUSINESS_V AS
SELECT eid.ev_emp_id as empid,eid.ev_period_id,product_name ,estimation_guideline, product_propose,product_factual,achivement_rate , t1.SEQ_EV_ITEM_DETAIL FROM
     ( SELECT ecd.SEQ_EV_ITEM_DETAIL ,ecd.EV_COLUMN_DETAIL AS product_name FROM eva_COLUMN_DETAIL ecd WHERE ecd.EV_COLUMN_ID='EVCOLUMN002')t1,
     ( SELECT ecd.SEQ_EV_ITEM_DETAIL ,ecd.EV_COLUMN_DETAIL AS estimation_guideline FROM eva_COLUMN_DETAIL ecd  WHERE ecd.EV_COLUMN_ID='EVCOLUMN003')t2,
     ( SELECT ecd.SEQ_EV_ITEM_DETAIL ,ecd.EV_COLUMN_DETAIL AS product_propose FROM eva_COLUMN_DETAIL ecd WHERE ecd.EV_COLUMN_ID='EVCOLUMN004')t3,
     ( SELECT ecd.SEQ_EV_ITEM_DETAIL ,ecd.EV_COLUMN_DETAIL AS product_factual FROM eva_COLUMN_DETAIL ecd WHERE ecd.EV_COLUMN_ID='EVCOLUMN005')t4,
     ( SELECT ecd.SEQ_EV_ITEM_DETAIL ,ecd.EV_COLUMN_DETAIL AS achivement_rate FROM eva_COLUMN_DETAIL ecd WHERE ecd.EV_COLUMN_ID='EVCOLUMN006')t5,
        eva_item_detail eid
     WHERE t1.SEQ_EV_ITEM_DETAIL=t2.SEQ_EV_ITEM_DETAIL
           AND t2.SEQ_EV_ITEM_DETAIL=t3.SEQ_EV_ITEM_DETAIL
     AND t3.SEQ_EV_ITEM_DETAIL=t4.SEQ_EV_ITEM_DETAIL
     AND t4.SEQ_EV_ITEM_DETAIL=t5.SEQ_EV_ITEM_DETAIL
          and eid.seq_ev_item_detail=t5.SEQ_EV_ITEM_DETAIL;

prompt
prompt Creating view EVA_CAPABILITY_SECONDEST_COM_V
prompt ============================================
prompt
CREATE OR REPLACE FORCE VIEW EVA_CAPABILITY_SECONDEST_COM_V AS
select a.ev_emp_id,a.ev_period_id,a.ev_type_id,a.ev_process_id,
       avg(a.EV_DETAIL_MARK) SecondEstimationMark
from
      (SELECT A.EV_PERIOD_ID,
               L.EV_PERIOD_NAME,
               A.EV_EMP_ID,
               A.EV_EMP_NAME,
               A.EV_DEPT_ID,
               A.EV_DEPT_NAME,
               A.EV_TYPE_ID,
               E.CODE_NAME      EV_TYPE_NAME,
               D.EV_PROCESS_ID,
               K.CODE_NAME      EV_PROCESS_NAME,
               I.EV_PROCESS_PROP,
               I.EV_OPERATE_ID,
               H.CODE_NAME         EV_OPERATE_NAME,
               B.EV_ITEM_ID,
               G.CODE_NAME   EV_ITEM_NAME,
               I.EV_ITEM_PROP,
               B.EV_DETAIL_PROP,
               B.EV_DETAIL_ORDER,
               D.EV_MARK      EV_DETAIL_MARK,
               D.EV_IDEA      EV_DETAIL_IDEA,
               A.EV_MARK         EV_FINAL_MARK,
               A.EV_GRADE_ID,
               F.CODE_NAME         EV_FINAL_GRADE,
               B.SEQ_EV_ITEM_DETAIL
           FROM eva_EMP A,
             eva_ITEM_DETAIL B,
             eva_DETAIL_MARK D,
             SY_CODE E,
             SY_CODE F,
             SY_CODE G,
             SY_CODE H,
             eva_RELATION I,
             SY_CODE K,
             eva_PERIOD L
           WHERE
             A.EV_TYPE_ID  <> 'EVTYPE007'
                  --and a.ev_emp_id='666888'
                  --and a.ev_period_id='200705'
             AND A.EV_PROCESS_ID  = 'EVPROCESS010'
                  and b.ev_item_id='EVITEM003'
             AND A.EV_PERIOD_ID     = B.EV_PERIOD_ID
             AND A.EV_EMP_ID      = B.EV_EMP_ID
             AND B.SEQ_EV_ITEM_DETAIL = D.SEQ_EV_ITEM_DETAIL
             AND A.EV_TYPE_ID      = E.CODE_ID
             AND A.EV_GRADE_ID     = F.CODE_ID
             AND B.EV_ITEM_ID      = G.CODE_ID
             AND I.EV_OPERATE_ID     = H.CODE_ID
             AND A.EV_PERIOD_ID     = I.EV_PERIOD_ID
             AND A.EV_TYPE_ID      = I.EV_TYPE_ID
             AND D.EV_PROCESS_ID     = I.EV_PROCESS_ID
             AND B.EV_ITEM_ID      = I.EV_ITEM_ID
             AND D.EV_PROCESS_ID     = K.CODE_ID
             AND A.EV_PERIOD_ID    = L.EV_PERIOD_ID
             AND I.EV_OPERATE_ID    = 'EVOPERATE006') a
group by a.ev_emp_id,a.ev_period_id,a.ev_type_id,a.ev_process_id;

prompt
prompt Creating view EVA_CAPABILITY_V
prompt ==============================
prompt
CREATE OR REPLACE FORCE VIEW EVA_CAPABILITY_V AS
SELECT   b.ev_period_id, b.ev_emp_id,
            SUM (DECODE (b.ev_process_id,'EVPROCESS006', b.ev_detail_mark,0)) "一次评价分数",
            SUM (DECODE (b.ev_process_id,'EVPROCESS007', b.ev_detail_mark,0)) "二次评价分数",
            b.ev_item_id, b.ev_detail_prop, b.ev_detail_order,
            b.ev_final_mark, b.ev_final_grade, b.ev_first_column,
            b.ev_second_column
       FROM (SELECT   a.ev_period_id, a.ev_emp_id, a.ev_process_id,
                      a.ev_item_id, a.ev_detail_prop, a.ev_detail_order,
                      a.ev_detail_mark, a.ev_final_mark, a.ev_final_grade,
                      MAX (a.ev_first_column) ev_first_column,
                      MAX (a.ev_second_column) ev_second_column
                 FROM (SELECT a.ev_period_id, l.ev_period_name, a.ev_emp_id,
                              a.ev_emp_name, a.ev_dept_id, a.ev_dept_name,
                              a.ev_type_id, e.code_name ev_type_name,
                              i.ev_process_prop, i.ev_operate_id,
                              h.code_name ev_operate_name, d.ev_process_id,
                              k.code_name ev_process_name, b.ev_item_id,
                              g.code_name ev_item_name, ecd.ev_column_id,
                              ecd.ev_column_detail, d.ev_idea ev_detail_idea,
                              d.ev_mark ev_detail_mark, i.ev_item_prop,
                              b.ev_detail_prop, b.ev_detail_order,
                              a.ev_mark ev_final_mark, a.ev_grade_id,
                              f.code_name ev_final_grade,
                              b.seq_ev_item_detail, ev_first_column,
                              ev_second_column
                         FROM eva_emp a,
                              eva_item_detail b,
                              eva_column_detail ecd,
                              eva_detail_mark d,
                              sy_code e,
                              sy_code f,
                              sy_code g,
                              sy_code h,
                              eva_relation i,
                              sy_code k,
                              eva_period l,
                              (SELECT ecd.seq_ev_item_detail,
                                      ecd.ev_column_detail AS ev_first_column
                                 FROM eva_column_detail ecd
                                WHERE ecd.ev_column_id = 'EVCOLUMN001') t1,
                              (SELECT ecd.seq_ev_item_detail,
                                      ecd.ev_column_detail AS ev_second_column
                                 FROM eva_column_detail ecd
                                WHERE ecd.ev_column_id = 'EVCOLUMN015') t2
                        WHERE
                          a.ev_type_id <> 'EVTYPE007'
                          AND a.ev_process_id = 'EVPROCESS010'
                          AND a.ev_period_id = b.ev_period_id
                          AND a.ev_emp_id = b.ev_emp_id
                          AND b.seq_ev_item_detail = d.seq_ev_item_detail
                          AND b.seq_ev_item_detail = ecd.seq_ev_item_detail
                          AND a.ev_type_id = e.code_id
                          AND a.ev_grade_id = f.code_id
                          AND b.ev_item_id = g.code_id
                          AND i.ev_operate_id = h.code_id
                          AND a.ev_period_id = i.ev_period_id
                          AND a.ev_type_id = i.ev_type_id
                          AND d.ev_process_id = i.ev_process_id
                          AND b.ev_item_id = i.ev_item_id
                          AND d.ev_process_id = k.code_id
                          AND a.ev_period_id = l.ev_period_id
                          AND t1.seq_ev_item_detail = t2.seq_ev_item_detail
                          AND t1.seq_ev_item_detail = b.seq_ev_item_detail
                          AND i.ev_operate_id = 'EVOPERATE006') a
             GROUP BY a.ev_period_id,
                      a.ev_emp_id,
                      a.ev_process_id,
                      a.ev_item_id,
                      a.ev_detail_prop,
                      a.ev_detail_order,
                      a.ev_detail_mark,
                      a.ev_final_mark,
                      a.ev_final_grade
             UNION ALL
             SELECT   a.ev_period_id, a.ev_emp_id, a.ev_process_id,
                      a.ev_item_id, a.ev_detail_prop, a.ev_detail_order,
                      a.ev_detail_mark, a.ev_final_mark, a.ev_final_grade,
                      MAX (a.ev_first_column) ev_first_column,
                      MAX (a.ev_second_column) ev_second_column
                 FROM (SELECT a.ev_period_id, l.ev_period_name, a.ev_emp_id,
                              a.ev_emp_name, a.ev_dept_id, a.ev_dept_name,
                              a.ev_type_id, e.code_name ev_type_name,
                              i.ev_process_prop, i.ev_operate_id,
                              h.code_name ev_operate_name, d.ev_process_id,
                              k.code_name ev_process_name, b.ev_item_id,
                              g.code_name ev_item_name, ecd.ev_column_id,
                              ecd.ev_column_detail, d.ev_idea ev_detail_idea,
                              d.ev_mark ev_detail_mark, i.ev_item_prop,
                              b.ev_detail_prop, b.ev_detail_order,
                              a.ev_mark ev_final_mark, a.ev_grade_id,
                              f.code_name ev_final_grade,
                              b.seq_ev_item_detail, ev_first_column,
                              ev_second_column
                         FROM eva_emp a,
                              eva_item_detail b,
                              eva_column_detail ecd,
                              eva_detail_mark d,
                              sy_code e,
                              sy_code f,
                              sy_code g,
                              sy_code h,
                              eva_relation i,
                              sy_code k,
                              eva_period l,
                              (SELECT ecd.seq_ev_item_detail,
                                      ecd.ev_column_detail AS ev_first_column
                                 FROM eva_column_detail ecd
                                WHERE ecd.ev_column_id = 'EVCOLUMN001') t1,
                              (SELECT ecd.seq_ev_item_detail,
                                      ecd.ev_column_detail AS ev_second_column
                                 FROM eva_column_detail ecd
                                WHERE ecd.ev_column_id = 'EVCOLUMN015') t2
                        WHERE
                          a.ev_type_id <> 'EVTYPE007'
                          AND a.ev_process_id = 'EVPROCESS010'
                          AND a.ev_period_id = b.ev_period_id
                          AND a.ev_emp_id = b.ev_emp_id
                          AND b.seq_ev_item_detail = d.seq_ev_item_detail
                          AND b.seq_ev_item_detail = ecd.seq_ev_item_detail
                          AND a.ev_type_id = e.code_id
                          AND a.ev_grade_id = f.code_id
                          AND b.ev_item_id = g.code_id
                          AND i.ev_operate_id = h.code_id
                          AND a.ev_period_id = i.ev_period_id
                          AND a.ev_type_id = i.ev_type_id
                          AND d.ev_process_id = i.ev_process_id
                          AND b.ev_item_id = i.ev_item_id
                          AND d.ev_process_id = k.code_id
                          AND a.ev_period_id = l.ev_period_id
                          AND t1.seq_ev_item_detail = t2.seq_ev_item_detail
                          AND t1.seq_ev_item_detail = b.seq_ev_item_detail
                          AND i.ev_operate_id <> 'EVOPERATE006') a
             GROUP BY a.ev_period_id,
                      a.ev_emp_id,
                      a.ev_process_id,
                      a.ev_item_id,
                      a.ev_detail_prop,
                      a.ev_detail_order,
                      a.ev_detail_mark,
                      a.ev_final_mark,
                      a.ev_final_grade) b
   GROUP BY b.ev_period_id,
            b.ev_emp_id,
            b.ev_item_id,
            b.ev_detail_prop,
            b.ev_detail_order,
            b.ev_final_mark,
            b.ev_final_grade,
            b.ev_first_column,
            b.ev_second_column;

prompt
prompt Creating view EVA_COLUMN_DETAIL_V
prompt =================================
prompt
CREATE OR REPLACE FORCE VIEW EVA_COLUMN_DETAIL_V AS
SELECT eva_ITEM_DETAIL.SEQ_EV_ITEM_DETAIL,
       eva_ITEM_DETAIL.EV_ITEM_METHOD,
       eva_ITEM_DETAIL.EV_DETAIL_PROP,
       eva_ITEM_DETAIL.EV_DETAIL_ORDER,
       eva_COLUMN_DETAIL.EV_COLUMN_ID,
       SC1.CODE_NAME EV_COLUMN_NAME,
       eva_COLUMN_DETAIL.EV_COLUMN_DETAIL,
       eva_COLUMN_DETAIL.EV_UNIT,
       '' AS EV_COLUMN_DETAIL_PROP,
       '' AS EV_PROCESS_ID
  FROM eva_ITEM_DETAIL
 INNER JOIN eva_COLUMN_DETAIL ON eva_ITEM_DETAIL.SEQ_EV_ITEM_DETAIL =
                                 eva_COLUMN_DETAIL.SEQ_EV_ITEM_DETAIL
 INNER JOIN SY_CODE SC1 ON SC1.CODE_ID = eva_COLUMN_DETAIL.EV_COLUMN_ID
                       AND SC1.PARENT_CODE = 'EVCOLUMN'
UNION
SELECT eva_ITEM_DETAIL.SEQ_EV_ITEM_DETAIL,
       eva_ITEM_DETAIL.EV_ITEM_METHOD,
       eva_ITEM_DETAIL.EV_DETAIL_PROP,
       eva_ITEM_DETAIL.EV_DETAIL_ORDER,
       eva_DETAIL_MARK.EV_PROCESS_ID || 'MARK' EV_COLUMN_ID,
       SC1.CODE_NAME || '分数' EV_COLUMN_NAME,
       TO_CHAR(eva_DETAIL_MARK.EV_MARK) EV_COLUMN_DETAIL,
       '' EV_UNIT,
       eva_DETAIL_MARK.EV_PROP EV_COLUMN_DETAIL_PROP,
       eva_DETAIL_MARK.EV_PROCESS_ID
  FROM eva_ITEM_DETAIL
 INNER JOIN eva_DETAIL_MARK ON eva_ITEM_DETAIL.SEQ_EV_ITEM_DETAIL =
                               eva_DETAIL_MARK.SEQ_EV_ITEM_DETAIL
 INNER JOIN SY_CODE SC1 ON SC1.CODE_ID = eva_DETAIL_MARK.EV_PROCESS_ID
                       AND SC1.PARENT_CODE = 'EVPROCESS'
 INNER JOIN eva_EMP ON eva_EMP.EV_PERIOD_ID = eva_ITEM_DETAIL.EV_PERIOD_ID
                   AND eva_EMP.EV_EMP_ID = eva_ITEM_DETAIL.EV_EMP_ID
 INNER JOIN eva_EMP_ITEM_PROCESS EEIP ON EEIP.EV_EMP_ID = eva_EMP.EV_EMP_ID
                                     AND EEIP.EV_PERIOD_ID = eva_EMP.EV_PERIOD_ID
                                     AND EEIP.EV_ITEM_ID = eva_ITEM_DETAIL.EV_ITEM_ID
 INNER JOIN eva_TYPE_PROCESS ETP1 ON ETP1.EV_PERIOD_ID = eva_ITEM_DETAIL.EV_PERIOD_ID
                                 AND ETP1.EV_TYPE_ID = eva_EMP.EV_TYPE_ID
                                 AND ETP1.EV_PROCESS_ID = EEIP.EV_ITEM_PROCESS_ID
 INNER JOIN eva_TYPE_PROCESS ETP2 ON ETP2.EV_PERIOD_ID = eva_ITEM_DETAIL.EV_PERIOD_ID
                                 AND ETP2.EV_TYPE_ID = eva_EMP.EV_TYPE_ID
                                 AND ETP2.EV_PROCESS_ID = eva_DETAIL_MARK.EV_PROCESS_ID
 WHERE ETP1.EV_PROCESS_ORDER >= ETP2.EV_PROCESS_ORDER
   AND eva_DETAIL_MARK.EV_PROCESS_ID NOT IN
       ('EVPROCESS001', 'EVPROCESS002', 'EVPROCESS003') -- 目标设定和目标确认不显示评价分数
UNION
SELECT eva_ITEM_DETAIL.SEQ_EV_ITEM_DETAIL,
       eva_ITEM_DETAIL.EV_ITEM_METHOD,
       eva_ITEM_DETAIL.EV_DETAIL_PROP,
       eva_ITEM_DETAIL.EV_DETAIL_ORDER,
       eva_DETAIL_MARK.EV_PROCESS_ID || 'IDEA' EV_COLUMN_ID,
       SC1.CODE_NAME || '意见' EV_COLUMN_NAME,
       TO_CHAR(eva_DETAIL_MARK.EV_IDEA) EV_COLUMN_DETAIL,
       '' EV_UNIT,
       eva_DETAIL_MARK.EV_PROP EV_COLUMN_DETAIL_PROP,
       eva_DETAIL_MARK.EV_PROCESS_ID
  FROM eva_ITEM_DETAIL
 INNER JOIN eva_DETAIL_MARK ON eva_ITEM_DETAIL.SEQ_EV_ITEM_DETAIL =
                               eva_DETAIL_MARK.SEQ_EV_ITEM_DETAIL
 INNER JOIN SY_CODE SC1 ON SC1.CODE_ID = eva_DETAIL_MARK.EV_PROCESS_ID
                       AND SC1.PARENT_CODE = 'EVPROCESS'
 INNER JOIN eva_EMP ON eva_EMP.EV_PERIOD_ID = eva_ITEM_DETAIL.EV_PERIOD_ID
                   AND eva_EMP.EV_EMP_ID = eva_ITEM_DETAIL.EV_EMP_ID
 INNER JOIN eva_EMP_ITEM_PROCESS EEIP ON EEIP.EV_EMP_ID = eva_EMP.EV_EMP_ID
                                     AND EEIP.EV_PERIOD_ID = eva_EMP.EV_PERIOD_ID
                                     AND EEIP.EV_ITEM_ID = eva_ITEM_DETAIL.EV_ITEM_ID
 INNER JOIN eva_TYPE_PROCESS ETP1 ON ETP1.EV_PERIOD_ID = eva_ITEM_DETAIL.EV_PERIOD_ID
                                 AND ETP1.EV_TYPE_ID = eva_EMP.EV_TYPE_ID
                                 AND ETP1.EV_PROCESS_ID = EEIP.EV_ITEM_PROCESS_ID
 INNER JOIN eva_TYPE_PROCESS ETP2 ON ETP2.EV_PERIOD_ID = eva_ITEM_DETAIL.EV_PERIOD_ID
                                 AND ETP2.EV_TYPE_ID = eva_EMP.EV_TYPE_ID
                                 AND ETP2.EV_PROCESS_ID = eva_DETAIL_MARK.EV_PROCESS_ID
 WHERE ETP1.EV_PROCESS_ORDER >= ETP2.EV_PROCESS_ORDER
   AND eva_DETAIL_MARK.EV_PROCESS_ID <> 'EVPROCESS001'
   AND eva_DETAIL_MARK.EV_PROCESS_ID <> 'EVPROCESS003';

prompt
prompt Creating view EVA_COLUMN_DETAIL_YEAR_V
prompt ======================================
prompt
CREATE OR REPLACE FORCE VIEW EVA_COLUMN_DETAIL_YEAR_V AS
SELECT eid1.seq_ev_item_detail ev_item_detail_id1,
          eid2.seq_ev_item_detail ev_item_detail_id2,
          ecd1.ev_column_detail evcolumn001,
          ecd2.ev_column_detail evcolumn002, eid1.ev_detail_prop,
          ecd3.ev_column_detail evcolumn003,
          ecd4.ev_column_detail evcolumn004,
          ecd5.ev_column_detail evcolumn005,
          ecd6.ev_column_detail evcolumn006,
          ecd7.ev_column_detail evcolumn007,
          ecd8.ev_column_detail evcolumn008
     FROM eva_item_detail eid1 INNER JOIN eva_item_detail eid2 
     ON SUBSTR (eid1.ev_period_id, 1, 4) = SUBSTR(eid2.ev_period_id, 1, 4)
      AND SUBSTR(eid1.ev_period_id,5, 2) <>SUBSTR(eid2.ev_period_id,5,2)
      AND eid1.ev_detail_order =eid2.ev_detail_order
      INNER JOIN eva_column_detail ecd1 ON ecd1.seq_ev_item_detail =eid1.seq_ev_item_detail
      AND ecd1.ev_column_id ='EVCOLUMN001'
      INNER JOIN eva_column_detail ecd2 ON ecd2.seq_ev_item_detail =eid1.seq_ev_item_detail
      AND ecd2.ev_column_id ='EVCOLUMN002'
      INNER JOIN eva_column_detail ecd3 ON ecd3.seq_ev_item_detail = eid1.seq_ev_item_detail
       AND ecd3.ev_column_id ='EVCOLUMN003'
      INNER JOIN eva_column_detail ecd4 ON ecd4.seq_ev_item_detail =eid2.seq_ev_item_detail
      AND ecd4.ev_column_id ='EVCOLUMN004'
     INNER JOIN eva_column_detail ecd5 ON ecd5.seq_ev_item_detail =eid2.seq_ev_item_detail
      AND ecd5.ev_column_id = 'EVCOLUMN005'
      INNER JOIN eva_column_detail ecd6 ON ecd6.seq_ev_item_detail =eid2.seq_ev_item_detail
     AND ecd6.ev_column_id = 'EVCOLUMN006'
      INNER JOIN eva_column_detail ecd7 ON ecd7.seq_ev_item_detail = eid2.seq_ev_item_detail
     AND ecd7.ev_column_id ='EVCOLUMN007'
      INNER JOIN eva_column_detail ecd8 ON ecd8.seq_ev_item_detail =eid2.seq_ev_item_detail
     AND ecd8.ev_column_id ='EVCOLUMN008';

prompt
prompt Creating view EVA_COMMON_ACHIVEMENT_V
prompt =====================================
prompt
CREATE OR REPLACE FORCE VIEW EVA_COMMON_ACHIVEMENT_V AS
select
    resultset.EV_EMP_ID as empid,
    resultset.EV_PERIOD_ID,
    resultset.EV_PERIOD_NAME,
    resultset.EV_PROCESS_ID,
    resultset.EV_ITEM_ID,
    resultset.EV_ITEM_NAME,
    hr_convert(resultset.EV_DETAIL_IDEA) EV_DETAIL_IDEA
from(SELECT A.EV_PERIOD_ID,
         L.EV_PERIOD_NAME,
         A.EV_EMP_ID,
         A.EV_EMP_NAME,
         A.EV_DEPT_ID,
         A.EV_DEPT_NAME,
         A.EV_TYPE_ID,
         E.CODE_NAME      EV_TYPE_NAME,
         D.EV_PROCESS_ID,
         K.CODE_NAME      EV_PROCESS_NAME,
         I.EV_PROCESS_PROP,
         I.EV_OPERATE_ID,
         H.CODE_NAME         EV_OPERATE_NAME,
         B.EV_ITEM_ID,
         G.CODE_NAME   EV_ITEM_NAME,
         I.EV_ITEM_PROP,
         B.EV_DETAIL_PROP,
         B.EV_DETAIL_ORDER,
         D.EV_MARK      EV_DETAIL_MARK,
         D.EV_IDEA      EV_DETAIL_IDEA,
         A.EV_MARK         EV_FINAL_MARK,
         A.EV_GRADE_ID,
         F.CODE_NAME         EV_FINAL_GRADE,
         B.SEQ_EV_ITEM_DETAIL
     FROM eva_EMP A,
       eva_ITEM_DETAIL B,
       eva_DETAIL_MARK D,
       SY_CODE E,
       SY_CODE F,
       SY_CODE G,
       SY_CODE H,
       eva_RELATION I,
       SY_CODE K,
       eva_PERIOD L
     WHERE
       A.EV_TYPE_ID      <> 'EVTYPE007'
       AND d.EV_PROCESS_ID     = 'EVPROCESS001'
            and b.ev_item_id = 'EVITEM002'
       AND A.EV_PERIOD_ID     = B.EV_PERIOD_ID
       AND A.EV_EMP_ID      = B.EV_EMP_ID
       AND B.SEQ_EV_ITEM_DETAIL = D.SEQ_EV_ITEM_DETAIL
       AND A.EV_TYPE_ID      = E.CODE_ID
       AND A.EV_GRADE_ID     = F.CODE_ID
       AND B.EV_ITEM_ID      = G.CODE_ID
       AND I.EV_OPERATE_ID     = H.CODE_ID
       AND A.EV_PERIOD_ID     = I.EV_PERIOD_ID
       AND A.EV_TYPE_ID      = I.EV_TYPE_ID
       AND D.EV_PROCESS_ID     = I.EV_PROCESS_ID
       AND B.EV_ITEM_ID      = I.EV_ITEM_ID
       AND D.EV_PROCESS_ID     = K.CODE_ID
       AND A.EV_PERIOD_ID    = L.EV_PERIOD_ID)resultset;

prompt
prompt Creating view EVA_COMPOSITIVEMIND_COM_V
prompt =======================================
prompt
CREATE OR REPLACE FORCE VIEW EVA_COMPOSITIVEMIND_COM_V AS
SELECT A.EV_PERIOD_ID,
         L.EV_PERIOD_NAME,
         A.EV_EMP_ID,
         A.EV_EMP_NAME,
         A.EV_DEPT_ID,
         A.EV_DEPT_NAME,
         A.EV_TYPE_ID,
         E.CODE_NAME      EV_TYPE_NAME,
         I.EV_PROCESS_PROP,
         I.EV_OPERATE_ID,
         H.CODE_NAME         EV_OPERATE_NAME,
         D.EV_PROCESS_ID,
         K.CODE_NAME      EV_PROCESS_NAME,
         B.EV_ITEM_ID,
         G.CODE_NAME   EV_ITEM_NAME,
         ECD.EV_COLUMN_DETAIL,
         HR_CONVERT(D.EV_IDEA)      EV_DETAIL_IDEA,
         D.EV_MARK      EV_DETAIL_MARK,
         I.EV_ITEM_PROP,
         B.EV_DETAIL_PROP,
         B.EV_DETAIL_ORDER,
         A.EV_MARK         EV_FINAL_MARK,
         A.EV_GRADE_ID,
         F.CODE_NAME         EV_FINAL_GRADE,
         B.SEQ_EV_ITEM_DETAIL
     FROM eva_EMP A,
       eva_ITEM_DETAIL B,
       eva_COLUMN_DETAIL ECD,
       eva_DETAIL_MARK D,
       SY_CODE E,
       SY_CODE F,
       SY_CODE G,
       SY_CODE H,
       eva_RELATION I,
       SY_CODE K,
       eva_PERIOD L
     WHERE
       A.EV_TYPE_ID      <> 'EVTYPE007'
       AND A.EV_PROCESS_ID     = 'EVPROCESS010'
       AND b.EV_ITEM_ID         ='EVITEM006'
       AND A.EV_PERIOD_ID     = B.EV_PERIOD_ID
       AND A.EV_EMP_ID      = B.EV_EMP_ID
       AND B.SEQ_EV_ITEM_DETAIL = D.SEQ_EV_ITEM_DETAIL
       AND B.SEQ_EV_ITEM_DETAIL = ECD.SEQ_EV_ITEM_DETAIL
       AND A.EV_TYPE_ID      = E.CODE_ID
       AND A.EV_GRADE_ID     = F.CODE_ID
       AND B.EV_ITEM_ID      = G.CODE_ID
       AND I.EV_OPERATE_ID     = H.CODE_ID
       AND A.EV_PERIOD_ID     = I.EV_PERIOD_ID
       AND A.EV_TYPE_ID      = I.EV_TYPE_ID
       AND D.EV_PROCESS_ID     = I.EV_PROCESS_ID
       AND B.EV_ITEM_ID      = I.EV_ITEM_ID
       AND D.EV_PROCESS_ID     = K.CODE_ID
       AND A.EV_PERIOD_ID    = L.EV_PERIOD_ID
       ORDER BY D.ev_process_id;

prompt
prompt Creating view EVA_DEFAULT_MARK_V
prompt ================================
prompt
CREATE OR REPLACE FORCE VIEW EVA_DEFAULT_MARK_V AS
SELECT eva_item_detail.seq_ev_item_detail, eva_relation.ev_marks_value,
          eva_relation.ev_marks_name, eva_relation.ev_marks_default,
          eva_detail_mark.ev_mark, eva_detail_mark.ev_idea
     FROM eva_item_detail INNER JOIN eva_emp ON eva_item_detail.ev_emp_id =
                                                             eva_emp.ev_emp_id
                                           AND eva_item_detail.ev_period_id =
                                                          eva_emp.ev_period_id
          LEFT JOIN eva_relation ON eva_relation.ev_period_id =
                                                  eva_item_detail.ev_period_id
                               AND eva_relation.ev_item_id =
                                                    eva_item_detail.ev_item_id
                               AND eva_relation.ev_type_id =
                                                            eva_emp.ev_type_id
                               AND eva_relation.ev_process_id =
                                                         eva_emp.ev_process_id
          LEFT JOIN eva_detail_mark ON eva_detail_mark.seq_ev_item_detail =
                                            eva_item_detail.seq_ev_item_detail
                                  AND eva_detail_mark.ev_process_id =
                                                         eva_emp.ev_process_id;

prompt
prompt Creating view EVA_DEPT_RADIO_V
prompt ==============================
prompt
CREATE OR REPLACE FORCE VIEW EVA_DEPT_RADIO_V AS
SELECT eva_dept_radio.ev_period_id, eva_dept_radio.ev_dept_id,
          hr_department.deptname, eva_dept_radio.ev_dept_grade_id,
          sc2.code_name AS ev_dept_grade_name, eva_dept_radio.ev_grade_id,
          sc1.code_name AS ev_grade_name, ev_grade_prop, ev_wage_radio
     FROM eva_dept_radio LEFT JOIN sy_code sc1 ON sc1.code_id =
                                                    eva_dept_radio.ev_grade_id
                                             AND sc1.parent_code =
                                                                  'EVEMPGRADE'
          LEFT JOIN hr_department ON hr_department.deptid =
                                                     eva_dept_radio.ev_dept_id
          LEFT JOIN sy_code sc2 ON sc2.code_id =
                                               eva_dept_radio.ev_dept_grade_id
                              AND sc2.parent_code = 'EVDEPTGRADE';

prompt
prompt Creating view EVA_DEPT_V
prompt ========================
prompt
CREATE OR REPLACE FORCE VIEW EVA_DEPT_V AS
SELECT EV_PERIOD_ID,
			 EV_DEPT_ID,
			 EV_DEPT_NAME,
			 EV_DEPT_LEVEL,
			 EV_PARENT_DEPT_ID,
			 EV_DEPT_GRADE_ID,
			 GET_SYS_CODE(EV_DEPT_GRADE_ID) AS EV_DEPT_GRADE_NAME,
			 EV_DEPT_NORM,
			 ACTIVITY
	FROM eva_DEPT
 START WITH EV_DEPT_LEVEL = '1'
CONNECT BY PRIOR EV_DEPT_ID = EV_PARENT_DEPT_ID
			 AND PRIOR EV_PERIOD_ID = EV_PERIOD_ID
 ORDER SIBLINGS BY EV_DEPT_ID;

prompt
prompt Creating view HR_EMPLOYEE_V
prompt ===========================
prompt
CREATE OR REPLACE FORCE VIEW HR_EMPLOYEE_V AS
SELECT HRE.EMPID,
       HRE.CHINESENAME,
       HRE.CHINESE_PINYIN,
       HRE.ENGLISHNAME,
       HRE.DEPTID,
       HRD.DEPTNAME,
       HRD.DEPT_EN_NAME,
       FLOOR(MONTHS_BETWEEN(SYSDATE, HRE.JOIN_DATE)) A_WORKAGE,
       HRPI.WORKAGE B_WORKAGE,
       FLOOR(MONTHS_BETWEEN(SYSDATE, HRE.JOIN_DATE) + HRPI.WORKAGE) WORKAGE,
       HRE.DUTY_CODE,
       E.CODE_NAME AS DUTY_NAME,
       E.CODE_EN_NAME AS DUTY_EN_NAME,
       HRE.POSITION_ID,
       HRPO.POSITION_NAME,
       HRPO.POSITION_EN_NAME,
       HRE.POST_ID,
       HRP.POST_NAME,
       HRP.POST_EN_NAME,
       HRE.POST_GRADE_ID,
       HRPGR.POST_GRADE_NAME,
       HRPGR.POST_GRADE_EN_NAME,
       HRE.POST_COEF,
       HRE.POST_COLUMN_CODE,
       HRPC.POST_COLUMN_NAME,
       HRPC.POST_COLUMN_EN_NAME,
       HRE.POST_GRADE_LEVEL_CODE,
       HRPGRL.POST_GRADE_LEVEL_NAME,
       HRPGRL.POST_GRADE_LEVEL_EN_NAME,
       HRE.POST_GROUP_ID,
       HRPG.POST_GROUP_NAME,
       HRPG.POST_GROUP_EN_NAME,
       HRE.STATUS_CODE,
       O.CODE_NAME AS STATUS_NAME,
       O.CODE_EN_NAME AS STATUS_EN_NAME,
       HRE.JOIN_TYPE_CODE,
       P.CODE_NAME AS JOIN_TYPE_NAME,
       P.CODE_EN_NAME AS JOIN_TYPE_EN_NAME,
       TO_CHAR(HRE.JOIN_DATE,'YYYY-MM-DD') JOIN_DATE,
       TO_CHAR(HRE.HIRE_DATE,'YYYY-MM-DD') HIRE_DATE,
       TO_CHAR(HRE.END_PROBATION_DATE,'YYYY-MM-DD') END_PROBATION_DATE,
       TO_CHAR(HRE.LEFT_DATE,'YYYY-MM-DD') LEFT_DATE,
       HRE.COSTCENTER,
       HRE.EMP_TYPE_CODE,
       C.CODE_NAME AS EMP_TYPE_NAME,
       C.CODE_EN_NAME AS EMP_TYPE_EN_NAME
  FROM HR_EMPLOYEE         HRE,
       HR_PERSONAL_INFO    HRPI,
       HR_DEPARTMENT       HRD,
       HR_EMP_INFO         HREI,
       HR_POSITION         HRPO,
       HR_POST             HRP,
       HR_POST_COLUMN      HRPC,
       HR_POST_GROUP       HRPG,
       HR_POST_GRADE_LEVEL HRPGRL,
       HR_POST_GRADE       HRPGR,
       SY_CODE             E,
       SY_CODE             O,
       SY_CODE             P,
       SY_CODE             C
 WHERE HRE.EMPID = HRPI.EMPID(+)
   AND HRE.EMPID = HREI.EMPID(+)
   AND HRE.DEPTID = HRD.DEPTID(+)
   AND HRE.POST_ID = HRP.POST_ID(+)
   AND HRE.POST_GROUP_ID = HRPG.POST_GROUP_ID(+)
   AND HRE.POSITION_ID = HRPO.POSITION_ID(+)
   AND HRE.POST_GRADE_ID = HRPGR.POST_GRADE_ID(+)
   AND HRE.POST_COLUMN_CODE = HRPC.POST_COLUMN_ID(+)
   AND HRE.POST_GRADE_LEVEL_CODE = HRPGRL.POST_GRADE_LEVEL_ID(+)
   AND HRE.DUTY_CODE = E.CODE_ID(+)
   AND HRE.STATUS_CODE = O.CODE_ID(+)
   AND HRE.JOIN_TYPE_CODE = P.CODE_ID(+)
   AND HRE.EMP_TYPE_CODE = C.CODE_ID(+);

prompt
prompt Creating view EVA_EMPLOYEE_V
prompt ============================
prompt
CREATE OR REPLACE FORCE VIEW EVA_EMPLOYEE_V AS
SELECT hev.CHINESENAME,
             hev.DEPTNAME,
       hev.POST_NAME,
       hev.POSITION_NAME,
       ep.EV_PERIOD_NAME,
       ep.EV_PERIOD_ID,
       hev.EMPID
          FROM hr_employee_v hev,eva_PERIOD ep,eva_EMP ee
             WHERE hev.EMPID=ee.EV_EMP_ID
           AND ee.EV_PERIOD_ID=ep.EV_PERIOD_ID;

prompt
prompt Creating view EVA_EMP_ITEM_V
prompt ============================
prompt
CREATE OR REPLACE FORCE VIEW EVA_EMP_ITEM_V AS
SELECT DISTINCT eva_TYPE_ITEM.EV_ITEM_ID,
       eva_EMP.EV_PERIOD_ID,
			 eva_EMP.EV_EMP_ID,
			 get_sys_code(eva_TYPE_ITEM.EV_ITEM_ID) EV_ITEM_NAME,
			 eva_TYPE_ITEM.EV_ITEM_ORDER
	FROM eva_EMP,eva_TYPE_ITEM,eva_RELATION
	WHERE eva_EMP.EV_PERIOD_ID = eva_TYPE_ITEM.EV_PERIOD_ID
	AND eva_EMP.EV_TYPE_ID = eva_TYPE_ITEM.EV_TYPE_ID
	AND eva_EMP.EV_PERIOD_ID = eva_RELATION.EV_PERIOD_ID
	AND eva_EMP.EV_TYPE_ID = eva_RELATION.EV_TYPE_ID
	AND eva_RELATION.EV_ITEM_ID = eva_TYPE_ITEM.EV_ITEM_ID;

prompt
prompt Creating view EVA_EMP_V
prompt =======================
prompt
CREATE OR REPLACE FORCE VIEW EVA_EMP_V AS
SELECT EEIP.EV_ITEM_ID,
       GET_SYS_CODE(EEIP.EV_ITEM_ID) EV_ITEM_NAME,
       eva_EMP.EV_PERIOD_ID,
       eva_PERIOD.EV_PERIOD_NAME,
       eva_EMP.EV_TYPE_ID,
       GET_SYS_CODE(eva_EMP.EV_TYPE_ID) EV_TYPE_NAME,
       eva_EMP.EV_EMP_ID,
       eva_EMP.EV_EMP_NAME,
       eva_EMP.EV_DEPT_ID,
       eva_EMP.EV_DEPT_NAME,
       eva_EMP.EV_POST_GROUP_ID,
       eva_EMP.EV_POST_GROUP_NAME,
       eva_EMP.EV_POSITION_ID,
       eva_EMP.EV_POSITION_NAME,
       eva_EMP.EV_POST_GRADE_ID,
       eva_EMP.EV_POST_GRADE_NAME,
       EEIP.EV_ITEM_PROCESS_ID EV_PROCESS_ID,
       GET_SYS_CODE(EEIP.EV_ITEM_PROCESS_ID) EV_PROCESS_NAME,
       EEIP.EV_ITEM_MARK EV_MARK,
       EEIP.EV_ITEM_GRADE_ID EV_GRADE_ID,
       GET_SYS_CODE(EEIP.EV_ITEM_GRADE_ID) EV_GRADE_NAME,
       eva_EMP.ACTIVITY
  FROM eva_PERIOD, eva_EMP, eva_EMP_ITEM_PROCESS EEIP
 WHERE eva_PERIOD.EV_PERIOD_ID = eva_EMP.EV_PERIOD_ID
   AND EEIP.EV_PERIOD_ID = eva_EMP.EV_PERIOD_ID
   AND EEIP.EV_EMP_ID = eva_EMP.EV_EMP_ID;

prompt
prompt Creating view EVA_EMP_V2
prompt ========================
prompt
CREATE OR REPLACE FORCE VIEW EVA_EMP_V2 AS
SELECT DISTINCT
       eva_EMP.EV_EMP_ID,
       eva_EMP.EV_EMP_NAME,
       eva_EMP.EV_PERIOD_ID,
       eva_PERIOD.EV_PERIOD_NAME,
       eva_EMP.EV_TYPE_ID,
       GET_SYS_CODE(eva_EMP.EV_TYPE_ID) EV_TYPE_NAME,
       eva_EMP.EV_DEPT_ID,
       eva_EMP.EV_DEPT_NAME,
       eva_EMP.EV_POST_GROUP_ID,
       eva_EMP.EV_POST_GROUP_NAME,
       EEIP.EV_ITEM_MARK EV_MARK,
       EEIP.EV_ITEM_GRADE_ID EV_GRADE_ID,
       GET_SYS_CODE(EEIP.EV_ITEM_GRADE_ID) EV_GRADE_NAME,
       eva_EMP.ACTIVITY
  FROM eva_PERIOD, eva_EMP, eva_EMP_ITEM_PROCESS EEIP
 WHERE eva_PERIOD.EV_PERIOD_ID = eva_EMP.EV_PERIOD_ID
   AND EEIP.EV_PERIOD_ID = eva_EMP.EV_PERIOD_ID
   AND EEIP.EV_EMP_ID = eva_EMP.EV_EMP_ID;

prompt
prompt Creating view EVA_ITEM_MARK_V
prompt =============================
prompt
CREATE OR REPLACE FORCE VIEW EVA_ITEM_MARK_V AS
SELECT   eva_emp.ev_period_id, eva_emp.ev_emp_id, eva_emp.ev_emp_name,
            eva_emp.ev_dept_id, eva_emp.ev_dept_name,
            eva_item_detail.ev_item_id, sc2.code_name ev_item_name,
            SUM (  eva_detail_mark.ev_mark
                 * eva_item_detail.ev_detail_prop
                 * 0.01
                 * eva_relation.ev_process_prop
                ) ev_item_mark
       FROM eva_detail_mark INNER JOIN eva_item_detail ON eva_detail_mark.seq_ev_item_detail =
                                                            eva_item_detail.seq_ev_item_detail
            INNER JOIN eva_emp ON eva_emp.ev_period_id =
                                                  eva_item_detail.ev_period_id
                             AND eva_emp.ev_emp_id = eva_item_detail.ev_emp_id
            INNER JOIN sy_code sc2 ON eva_item_detail.ev_item_id = sc2.code_id
                                 AND sc2.parent_code = 'EVITEM'
            INNER JOIN eva_relation ON eva_relation.ev_period_id =
                                                          eva_emp.ev_period_id
                                  AND eva_relation.ev_type_id =
                                                            eva_emp.ev_type_id
                                  AND eva_relation.ev_process_id =
                                                 eva_detail_mark.ev_process_id
                                  AND eva_relation.ev_item_id =
                                                    eva_item_detail.ev_item_id
   GROUP BY eva_emp.ev_period_id,
            eva_emp.ev_emp_id,
            eva_emp.ev_emp_name,
            eva_emp.ev_dept_id,
            eva_emp.ev_dept_name,
            eva_item_detail.ev_item_id,
            sc2.code_name;

prompt
prompt Creating view EVA_ITEM_PROCESS_MARK_V
prompt =====================================
prompt
CREATE OR REPLACE FORCE VIEW EVA_ITEM_PROCESS_MARK_V AS
SELECT   eva_emp.ev_period_id, eva_emp.ev_emp_id, eva_emp.ev_emp_name,
            eva_emp.ev_dept_id, eva_emp.ev_dept_name,
            eva_item_detail.ev_item_id, sc2.code_name ev_item_name,
            eva_detail_mark.ev_process_id, sc1.code_name ev_process_name,
            SUM (eva_detail_mark.ev_mark * eva_item_detail.ev_detail_prop
                 * 0.01
                ) ev_item_process_mark
       FROM eva_detail_mark INNER JOIN eva_item_detail ON eva_detail_mark.seq_ev_item_detail =
                                                            eva_item_detail.seq_ev_item_detail
            INNER JOIN eva_emp ON eva_emp.ev_period_id =
                                                  eva_item_detail.ev_period_id
                             AND eva_emp.ev_emp_id = eva_item_detail.ev_emp_id
            INNER JOIN sy_code sc1 ON eva_detail_mark.ev_process_id =
                                                                   sc1.code_id
                                 AND sc1.parent_code = 'EVPROCESS'
            INNER JOIN sy_code sc2 ON eva_item_detail.ev_item_id = sc2.code_id
                                 AND sc2.parent_code = 'EVITEM'
   GROUP BY eva_emp.ev_period_id,
            eva_emp.ev_emp_id,
            eva_emp.ev_emp_name,
            eva_emp.ev_dept_id,
            eva_emp.ev_dept_name,
            eva_item_detail.ev_item_id,
            eva_detail_mark.ev_process_id,
            sc1.code_name,
            sc2.code_name;

prompt
prompt Creating view EVA_ITEM_PROCESS_MARK_V2
prompt ======================================
prompt
CREATE OR REPLACE FORCE VIEW EVA_ITEM_PROCESS_MARK_V2 AS
SELECT eva_emp.ev_period_id, eva_emp.ev_emp_id, eva_emp.ev_emp_name,
       eva_emp.ev_dept_id, eva_emp.ev_dept_name,
       eva_item_process_mark.ev_item_id, sc2.code_name ev_item_name,
       eva_item_process_mark.ev_process_id, sc1.code_name ev_process_name,
       eva_item_process_mark.ev_mark AS ev_item_process_mark
  FROM eva_item_process_mark INNER JOIN eva_emp ON eva_emp.ev_period_id =
                                                     eva_item_process_mark.ev_period_id
                                              AND eva_emp.ev_emp_id =
                                                     eva_item_process_mark.ev_emp_id
       INNER JOIN sy_code sc1 ON eva_item_process_mark.ev_process_id =
                                                                   sc1.code_id
                            AND sc1.parent_code = 'EVPROCESS'
       INNER JOIN sy_code sc2 ON eva_item_process_mark.ev_item_id =
                                                                   sc2.code_id
                            AND sc2.parent_code = 'EVITEM';

prompt
prompt Creating view EVA_MANAGER_ACHIVEMENT_V
prompt ======================================
prompt
CREATE OR REPLACE FORCE VIEW EVA_MANAGER_ACHIVEMENT_V AS
SELECT   a.ev_emp_id as empid, a.ev_period_id, a.ev_process_id,
                      a.ev_item_id, a.ev_detail_prop, a.ev_detail_order,
                      a.ev_detail_mark, a.ev_final_mark, a.ev_final_grade,
                      MAX (a.ev_first_column) ev_first_column,
                      MAX (a.ev_second_column) ev_second_column
                 FROM (SELECT a.ev_period_id, l.ev_period_name, a.ev_emp_id,
                              a.ev_emp_name, a.ev_dept_id, a.ev_dept_name,
                              a.ev_type_id, e.code_name ev_type_name,
                              i.ev_process_prop, i.ev_operate_id,
                              h.code_name ev_operate_name, d.ev_process_id,
                              k.code_name ev_process_name, b.ev_item_id,
                              g.code_name ev_item_name, ecd.ev_column_id,
                              ecd.ev_column_detail, d.ev_idea ev_detail_idea,
                              d.ev_mark ev_detail_mark, i.ev_item_prop,
                              b.ev_detail_prop, b.ev_detail_order,
                              a.ev_mark ev_final_mark, a.ev_grade_id,
                              f.code_name ev_final_grade,
                              b.seq_ev_item_detail, ev_first_column,
                              ev_second_column
                         FROM eva_emp a,
                              eva_item_detail b,
                              eva_column_detail ecd,
                              eva_detail_mark d,
                              sy_code e,
                              sy_code f,
                              sy_code g,
                              sy_code h,
                              eva_relation i,
                              sy_code k,
                              eva_period l,
                              (SELECT ecd.seq_ev_item_detail,
                                      ecd.ev_column_detail AS ev_first_column
                                 FROM eva_column_detail ecd
                                WHERE ecd.ev_column_id = 'EVCOLUMN001') t1,
                              (SELECT ecd.seq_ev_item_detail,
                                      ecd.ev_column_detail
                                                          AS ev_second_column
                                 FROM eva_column_detail ecd
                                WHERE ecd.ev_column_id = 'EVCOLUMN016') t2
                        WHERE
                          a.ev_type_id <> 'EVTYPE007'
                          --AND a.ev_process_id = 'EVPROCESS010'
                          and d.ev_process_id = 'EVPROCESS001'
                          AND a.ev_period_id = b.ev_period_id
                          AND a.ev_emp_id = b.ev_emp_id
                          AND b.seq_ev_item_detail = d.seq_ev_item_detail
                          AND b.seq_ev_item_detail = ecd.seq_ev_item_detail
                          AND a.ev_type_id = e.code_id
                          AND a.ev_grade_id = f.code_id
                          AND b.ev_item_id = g.code_id
                          AND i.ev_operate_id = h.code_id
                          AND a.ev_period_id = i.ev_period_id
                          AND a.ev_type_id = i.ev_type_id
                          AND d.ev_process_id = i.ev_process_id
                          AND b.ev_item_id = i.ev_item_id
                          AND d.ev_process_id = k.code_id
                          AND a.ev_period_id = l.ev_period_id
                          AND t1.seq_ev_item_detail = t2.seq_ev_item_detail
                          AND t1.seq_ev_item_detail = b.seq_ev_item_detail
                       ) a
             GROUP BY a.ev_period_id,
                      a.ev_emp_id,
                      a.ev_process_id,
                      a.ev_item_id,
                      a.ev_detail_prop,
                      a.ev_detail_order,
                      a.ev_detail_mark,
                      a.ev_final_mark,
                      a.ev_final_grade;

prompt
prompt Creating view EVA_MASTER_EMP_V
prompt ==============================
prompt
CREATE OR REPLACE FORCE VIEW EVA_MASTER_EMP_V AS
SELECT EM.EV_PERIOD_ID,
       EEIP.EV_ITEM_ID,
       GET_SYS_CODE(EEIP.EV_ITEM_ID) EV_ITEM_NAME,
       EM.EV_MASTER,
       EE.EV_EMP_ID,
       EE.EV_EMP_NAME,
       EE.EV_DEPT_ID,
       EE.EV_DEPT_NAME,
       EE.EV_TYPE_ID,
       GET_SYS_CODE(EE.EV_TYPE_ID) EV_TYPE_NAME,
       EEIP.EV_ITEM_PROCESS_ID CURRENT_PROCESS_ID,
       GET_SYS_CODE(EEIP.EV_ITEM_PROCESS_ID) CURRENT_PROCESS_NAME,
       EEIP.EV_ITEM_MARK EV_MARK,
       EEIP.EV_ITEM_GRADE_ID EV_GRADE_ID,
       GET_SYS_CODE(EEIP.EV_ITEM_GRADE_ID) EV_GRADE_NAME,
       EE.EV_DEFAULT_GRADE_ID,
       GET_SYS_CODE(EE.EV_DEFAULT_GRADE_ID) EV_DEFAULT_GRADE_NAME,
       EE.EV_POST_GROUP_ID,
       EE.EV_POST_GROUP_NAME,
       EE.EV_ORDER,
       (CASE
         WHEN EM.EV_PROCESS_ID IN
              (SELECT EV_PROCESS_ID
                 FROM eva_MASTER EMa
                WHERE EMa.EV_PERIOD_ID = EM.EV_PERIOD_ID
                  AND EMa.EV_EMP_ID = EM.EV_EMP_ID
                  AND EMa.EV_MASTER = em.EV_MASTER
                  AND EMa.EV_PROCESS_ID <> 'EVPROCESS010') -- 评价完毕：显示不可操作状态
          THEN
          (CASE WHEN (SELECT EV_PROCESS_SDATE
                 FROM eva_TYPE_PROCESS
                WHERE EV_PERIOD_ID = EE.EV_PERIOD_ID
                  AND EV_TYPE_ID = EE.EV_TYPE_ID
                  AND EV_PROCESS_ID = EEIP.EV_ITEM_PROCESS_ID) <= SYSDATE AND
              (SELECT EV_PROCESS_EDATE
                 FROM eva_TYPE_PROCESS
                WHERE EV_PERIOD_ID = EE.EV_PERIOD_ID
                  AND EV_TYPE_ID = EE.EV_TYPE_ID
                  AND EV_PROCESS_ID = EEIP.EV_ITEM_PROCESS_ID) >= SYSDATE THEN
          1
         ELSE
          0
       END) ELSE 0 END) OPERATABLE
  FROM eva_MASTER EM, eva_EMP_ITEM_PROCESS EEIP, eva_EMP EE
 WHERE EE.EV_PERIOD_ID = EEIP.EV_PERIOD_ID
   AND EEIP.EV_ITEM_ID = EM.EV_ITEM_ID
   AND EEIP.EV_ITEM_PROCESS_ID = EM.EV_PROCESS_ID
   AND EEIP.EV_PERIOD_ID = EM.EV_PERIOD_ID
   AND EEIP.EV_EMP_ID = EE.EV_EMP_ID
   AND EEIP.EV_EMP_ID = EM.EV_EMP_ID;

prompt
prompt Creating view EVA_MASTER_V
prompt ==========================
prompt
CREATE OR REPLACE FORCE VIEW EVA_MASTER_V AS
SELECT eva_master.ev_period_id, eva_master.ev_emp_id, eva_emp.ev_emp_name,eva_emp.ev_type_id,
          eva_emp.ev_dept_id, eva_emp.ev_dept_name, eva_master.ev_process_id,
          sc1.code_name ev_process_name, eva_type_process.ev_process_order,
          eva_master.ev_master, hr_employee.chinesename ev_master_name,
          eva_master.ev_appendable, eva_master.ev_append_value,
          eva_master.ev_append_name, eva_master.ev_append_default
     FROM eva_master INNER JOIN sy_code sc1 ON eva_master.ev_process_id =
                                                                   sc1.code_id
                                          AND sc1.parent_code = 'EVPROCESS'
          INNER JOIN eva_emp ON eva_master.ev_emp_id = eva_emp.ev_emp_id
                           AND eva_master.ev_period_id = eva_emp.ev_period_id
          INNER JOIN eva_type_process ON eva_type_process.ev_period_id =
                                                          eva_emp.ev_period_id
                                    AND eva_type_process.ev_type_id =
                                                            eva_emp.ev_type_id
                                    AND eva_type_process.ev_process_id =
                                                      eva_master.ev_process_id
          LEFT JOIN hr_employee ON hr_employee.empid = eva_master.ev_master;

prompt
prompt Creating view EVA_MASTER_MARK_V
prompt ===============================
prompt
CREATE OR REPLACE FORCE VIEW EVA_MASTER_MARK_V AS
SELECT m1."EV_PERIOD_ID",m1."EV_EMP_ID",m1."EV_EMP_NAME",m1."EV_TYPE_ID",m1."EV_DEPT_ID",m1."EV_DEPT_NAME",m1."EV_PROCESS_ID",m1."EV_PROCESS_NAME",m1."EV_PROCESS_ORDER",m1."EV_MASTER",m1."EV_MASTER_NAME",m1."EV_APPENDABLE",m1."EV_APPEND_VALUE",m1."EV_APPEND_NAME",m1."EV_APPEND_DEFAULT", m2.ev_marks
  FROM eva_master_v m1,
       (SELECT   a.ev_period_id, a.ev_emp_id, c.ev_type_id, a.ev_process_id,
                 SUM (a.ev_mark * b.ev_item_prop * ev_process_prop
                     ) AS ev_marks
            FROM eva_item_process_mark a, eva_relation b, eva_emp c
           WHERE c.ev_emp_id = a.ev_emp_id
             AND c.ev_period_id = a.ev_period_id
             AND a.ev_period_id = b.ev_period_id
             AND c.ev_type_id = b.ev_type_id
             AND a.ev_process_id = b.ev_process_id
             AND a.ev_item_id = b.ev_item_id
             AND c.ev_emp_id = c.ev_emp_id
        GROUP BY a.ev_period_id, a.ev_emp_id, a.ev_process_id, c.ev_type_id) m2
 WHERE m1.ev_emp_id = m2.ev_emp_id(+) AND m1.ev_period_id = m2.ev_period_id(+)
       AND m1.ev_process_id = m2.ev_process_id(+);

prompt
prompt Creating view EVA_MBO_ACHIVEMENT_MANAGER_V
prompt ==========================================
prompt
CREATE OR REPLACE FORCE VIEW EVA_MBO_ACHIVEMENT_MANAGER_V AS
select a.ev_emp_id,a.ev_period_id,a.ev_type_id,a.ev_process_id,
       avg(a.EV_DETAIL_MARK) SecondEstimationMark
from
      (SELECT A.EV_PERIOD_ID,
               L.EV_PERIOD_NAME,
               A.EV_EMP_ID,
               A.EV_EMP_NAME,
               A.EV_DEPT_ID,
               A.EV_DEPT_NAME,
               A.EV_TYPE_ID,
               E.CODE_NAME      EV_TYPE_NAME,
               D.EV_PROCESS_ID,
               K.CODE_NAME      EV_PROCESS_NAME,
               I.EV_PROCESS_PROP,
               I.EV_OPERATE_ID,
               H.CODE_NAME         EV_OPERATE_NAME,
               B.EV_ITEM_ID,
               G.CODE_NAME   EV_ITEM_NAME,
               I.EV_ITEM_PROP,
               B.EV_DETAIL_PROP,
               B.EV_DETAIL_ORDER,
               D.EV_MARK      EV_DETAIL_MARK,
               D.EV_IDEA      EV_DETAIL_IDEA,
               A.EV_MARK         EV_FINAL_MARK,
               A.EV_GRADE_ID,
               F.CODE_NAME         EV_FINAL_GRADE,
               B.SEQ_EV_ITEM_DETAIL
           FROM eva_EMP A,
             eva_ITEM_DETAIL B,
             eva_DETAIL_MARK D,
             SY_CODE E,
             SY_CODE F,
             SY_CODE G,
             SY_CODE H,
             eva_RELATION I,
             SY_CODE K,
             eva_PERIOD L
           WHERE
             A.EV_TYPE_ID      <> 'EVTYPE007'
                  --and a.ev_emp_id='666888'
                  --and a.ev_period_id='200705'
             AND A.EV_PROCESS_ID     = 'EVPROCESS010'
                  and b.ev_item_id='EVITEM002'
             AND A.EV_PERIOD_ID     = B.EV_PERIOD_ID
             AND A.EV_EMP_ID      = B.EV_EMP_ID
             AND B.SEQ_EV_ITEM_DETAIL = D.SEQ_EV_ITEM_DETAIL
             AND A.EV_TYPE_ID      = E.CODE_ID
             AND A.EV_GRADE_ID     = F.CODE_ID
             AND B.EV_ITEM_ID      = G.CODE_ID
             AND I.EV_OPERATE_ID     = H.CODE_ID
             AND A.EV_PERIOD_ID     = I.EV_PERIOD_ID
             AND A.EV_TYPE_ID      = I.EV_TYPE_ID
             AND D.EV_PROCESS_ID     = I.EV_PROCESS_ID
             AND B.EV_ITEM_ID      = I.EV_ITEM_ID
             AND D.EV_PROCESS_ID     = K.CODE_ID
             AND A.EV_PERIOD_ID    = L.EV_PERIOD_ID
             AND I.EV_OPERATE_ID    = 'EVOPERATE006') a
group by a.ev_emp_id,a.ev_period_id,a.ev_type_id,a.ev_process_id;

prompt
prompt Creating view EVA_MBO_ACHIVEMENT_V
prompt ==================================
prompt
CREATE OR REPLACE FORCE VIEW EVA_MBO_ACHIVEMENT_V AS
SELECT   b.ev_period_id, b.ev_emp_id,
            sum(decode(b.ev_process_id,
                         'EVPROCESS005',b.ev_detail_mark,0
                         )
                )自我评价分数,
            SUM (DECODE (b.ev_process_id,
                         'EVPROCESS006', b.ev_detail_mark,
                         0
                        )
                ) "一次评价分数",
            SUM (DECODE (b.ev_process_id,
                         'EVPROCESS007', b.ev_detail_mark,
                         0
                        )
                ) "二次评价分数",
            b.ev_item_id, b.ev_detail_prop, b.ev_detail_order,
            b.ev_final_mark, b.ev_final_grade, b.ev_first_column,
            b.ev_second_column
       FROM (SELECT   a.ev_period_id, a.ev_emp_id, a.ev_process_id,
                      a.ev_item_id, a.ev_detail_prop, a.ev_detail_order,
                      a.ev_detail_mark, a.ev_final_mark, a.ev_final_grade,
                      MAX (a.ev_first_column) ev_first_column,
                      MAX (a.ev_second_column) ev_second_column
                 FROM (SELECT a.ev_period_id, l.ev_period_name, a.ev_emp_id,
                              a.ev_emp_name, a.ev_dept_id, a.ev_dept_name,
                              a.ev_type_id, e.code_name ev_type_name,
                              i.ev_process_prop, i.ev_operate_id,
                              h.code_name ev_operate_name, d.ev_process_id,
                              k.code_name ev_process_name, b.ev_item_id,
                              g.code_name ev_item_name, ecd.ev_column_id,
                              ecd.ev_column_detail, d.ev_idea ev_detail_idea,
                              d.ev_mark ev_detail_mark, i.ev_item_prop,
                              b.ev_detail_prop, b.ev_detail_order,
                              a.ev_mark ev_final_mark, a.ev_grade_id,
                              f.code_name ev_final_grade,
                              b.seq_ev_item_detail, ev_first_column,
                              ev_second_column
                         FROM eva_emp a,
                              eva_item_detail b,
                              eva_column_detail ecd,
                              eva_detail_mark d,
                              sy_code e,
                              sy_code f,
                              sy_code g,
                              sy_code h,
                              eva_relation i,
                              sy_code k,
                              eva_period l,
                              (SELECT ecd.seq_ev_item_detail,
                                      ecd.ev_column_detail AS ev_first_column
                                 FROM eva_column_detail ecd
                                WHERE ecd.ev_column_id = 'EVCOLUMN001') t1,
                              (SELECT ecd.seq_ev_item_detail,
                                      ecd.ev_column_detail
                                                          AS ev_second_column
                                 FROM eva_column_detail ecd
                                WHERE ecd.ev_column_id = 'EVCOLUMN016') t2
                        WHERE
                          a.ev_type_id <> 'EVTYPE007'
                          AND a.ev_process_id = 'EVPROCESS010'
                          AND a.ev_period_id = b.ev_period_id
                          AND a.ev_emp_id = b.ev_emp_id
                          AND b.seq_ev_item_detail = d.seq_ev_item_detail
                          AND b.seq_ev_item_detail = ecd.seq_ev_item_detail
                          AND a.ev_type_id = e.code_id
                          AND a.ev_grade_id = f.code_id
                          AND b.ev_item_id = g.code_id
                          AND i.ev_operate_id = h.code_id
                          AND a.ev_period_id = i.ev_period_id
                          AND a.ev_type_id = i.ev_type_id
                          AND d.ev_process_id = i.ev_process_id
                          AND b.ev_item_id = i.ev_item_id
                          AND d.ev_process_id = k.code_id
                          AND a.ev_period_id = l.ev_period_id
                          AND t1.seq_ev_item_detail = t2.seq_ev_item_detail
                          AND t1.seq_ev_item_detail = b.seq_ev_item_detail
                          AND i.ev_operate_id = 'EVOPERATE006') a
             GROUP BY a.ev_period_id,
                      a.ev_emp_id,
                      a.ev_process_id,
                      a.ev_item_id,
                      a.ev_detail_prop,
                      a.ev_detail_order,
                      a.ev_detail_mark,
                      a.ev_final_mark,
                      a.ev_final_grade
             UNION ALL
             SELECT   a.ev_period_id, a.ev_emp_id, a.ev_process_id,
                      a.ev_item_id, a.ev_detail_prop, a.ev_detail_order,
                      a.ev_detail_mark, a.ev_final_mark, a.ev_final_grade,
                      MAX (a.ev_first_column) ev_first_column,
                      MAX (a.ev_second_column) ev_second_column
                 FROM (SELECT a.ev_period_id, l.ev_period_name, a.ev_emp_id,
                              a.ev_emp_name, a.ev_dept_id, a.ev_dept_name,
                              a.ev_type_id, e.code_name ev_type_name,
                              i.ev_process_prop, i.ev_operate_id,
                              h.code_name ev_operate_name, d.ev_process_id,
                              k.code_name ev_process_name, b.ev_item_id,
                              g.code_name ev_item_name, ecd.ev_column_id,
                              ecd.ev_column_detail, d.ev_idea ev_detail_idea,
                              d.ev_mark ev_detail_mark, i.ev_item_prop,
                              b.ev_detail_prop, b.ev_detail_order,
                              a.ev_mark ev_final_mark, a.ev_grade_id,
                              f.code_name ev_final_grade,
                              b.seq_ev_item_detail, ev_first_column,
                              ev_second_column
                         FROM eva_emp a,
                              eva_item_detail b,
                              eva_column_detail ecd,
                              eva_detail_mark d,
                              sy_code e,
                              sy_code f,
                              sy_code g,
                              sy_code h,
                              eva_relation i,
                              sy_code k,
                              eva_period l,
                              (SELECT ecd.seq_ev_item_detail,
                                      ecd.ev_column_detail AS ev_first_column
                                 FROM eva_column_detail ecd
                                WHERE ecd.ev_column_id = 'EVCOLUMN001') t1,
                              (SELECT ecd.seq_ev_item_detail,
                                      ecd.ev_column_detail
                                                          AS ev_second_column
                                 FROM eva_column_detail ecd
                                WHERE ecd.ev_column_id = 'EVCOLUMN016') t2
                        WHERE
                          a.ev_type_id <> 'EVTYPE007'
                          AND a.ev_process_id = 'EVPROCESS010'
                          AND a.ev_period_id = b.ev_period_id
                          AND a.ev_emp_id = b.ev_emp_id
                          AND b.seq_ev_item_detail = d.seq_ev_item_detail
                          AND b.seq_ev_item_detail = ecd.seq_ev_item_detail
                          AND a.ev_type_id = e.code_id
                          AND a.ev_grade_id = f.code_id
                          AND b.ev_item_id = g.code_id
                          AND i.ev_operate_id = h.code_id
                          AND a.ev_period_id = i.ev_period_id
                          AND a.ev_type_id = i.ev_type_id
                          AND d.ev_process_id = i.ev_process_id
                          AND b.ev_item_id = i.ev_item_id
                          AND d.ev_process_id = k.code_id
                          AND a.ev_period_id = l.ev_period_id
                          AND t1.seq_ev_item_detail = t2.seq_ev_item_detail
                          AND t1.seq_ev_item_detail = b.seq_ev_item_detail
                          AND i.ev_operate_id <> 'EVOPERATE006') a
             GROUP BY a.ev_period_id,
                      a.ev_emp_id,
                      a.ev_process_id,
                      a.ev_item_id,
                      a.ev_detail_prop,
                      a.ev_detail_order,
                      a.ev_detail_mark,
                      a.ev_final_mark,
                      a.ev_final_grade) b
   GROUP BY b.ev_period_id,
            b.ev_emp_id,
            b.ev_item_id,
            b.ev_detail_prop,
            b.ev_detail_order,
            b.ev_final_mark,
            b.ev_final_grade,
            b.ev_first_column,
            b.ev_second_column;

prompt
prompt Creating view EVA_MIDPROCESS_FORTRAIN_V
prompt =======================================
prompt
CREATE OR REPLACE FORCE VIEW EVA_MIDPROCESS_FORTRAIN_V AS
SELECT result.ev_period_id,
       result.EV_PERIOD_NAME,
    result.ev_emp_id,
    result.EV_EMP_NAME,
    result.EV_DEPT_ID,
    result.EV_DEPT_NAME,
    result.EV_TYPE_ID,
    result.EV_TYPE_NAME,
    result.ev_process_id,
    result.EV_PROCESS_NAME,
    result.EV_ITEM_ID,
    result.EV_ITEM_NAME,
       result.ev_column_detail,
       result.ev_detail_idea,
    result.SEQ_EV_ITEM_DETAIL
FROM (SELECT A.EV_PERIOD_ID,
           L.EV_PERIOD_NAME,
           A.EV_EMP_ID,
           A.EV_EMP_NAME,
           A.EV_DEPT_ID,
           A.EV_DEPT_NAME,
           A.EV_TYPE_ID,
           E.CODE_NAME      EV_TYPE_NAME,
           I.EV_OPERATE_ID,
           H.CODE_NAME         EV_OPERATE_NAME,
           D.EV_PROCESS_ID,
           K.CODE_NAME      EV_PROCESS_NAME,
           B.EV_ITEM_ID,
           G.CODE_NAME   EV_ITEM_NAME,
           ecd.EV_COLUMN_ID,
           ECD.EV_COLUMN_DETAIL,
           D.EV_IDEA      EV_DETAIL_IDEA,
           B.EV_DETAIL_ORDER,
           B.SEQ_EV_ITEM_DETAIL
       FROM eva_EMP A,
         eva_ITEM_DETAIL B,
         eva_COLUMN_DETAIL ECD,
         eva_DETAIL_MARK D,
         SY_CODE E,
         SY_CODE F,
         SY_CODE G,
         SY_CODE H,
         eva_RELATION I,
         SY_CODE K,
         eva_PERIOD L
       WHERE --A.EV_EMP_ID         = '666888'
         A.EV_TYPE_ID      <> 'EVTYPE007'
         --AND A.EV_PERIOD_ID       ='200705'
         AND B.EV_ITEM_ID         ='EVITEM004'
         AND A.EV_PERIOD_ID     = B.EV_PERIOD_ID
         AND A.EV_EMP_ID      = B.EV_EMP_ID
         AND B.SEQ_EV_ITEM_DETAIL = D.SEQ_EV_ITEM_DETAIL
         AND B.SEQ_EV_ITEM_DETAIL = ECD.SEQ_EV_ITEM_DETAIL
         AND A.EV_TYPE_ID      = E.CODE_ID
         AND A.EV_GRADE_ID     = F.CODE_ID
         AND B.EV_ITEM_ID      = G.CODE_ID
         AND I.EV_OPERATE_ID     = H.CODE_ID
         AND A.EV_PERIOD_ID     = I.EV_PERIOD_ID
         AND A.EV_TYPE_ID      = I.EV_TYPE_ID
         AND D.EV_PROCESS_ID     = I.EV_PROCESS_ID
         AND B.EV_ITEM_ID      = I.EV_ITEM_ID
         AND D.EV_PROCESS_ID     = K.CODE_ID
         AND A.EV_PERIOD_ID    = L.EV_PERIOD_ID) result;

prompt
prompt Creating view EVA_MIDPROCESS_V
prompt ==============================
prompt
CREATE OR REPLACE FORCE VIEW EVA_MIDPROCESS_V AS
SELECT                 A.EV_PERIOD_ID,
           L.EV_PERIOD_NAME,
           A.EV_EMP_ID,
           A.EV_EMP_NAME,
           A.EV_DEPT_ID,
           A.EV_DEPT_NAME,
           A.EV_TYPE_ID,
           E.CODE_NAME      EV_TYPE_NAME,
           I.EV_OPERATE_ID,
           H.CODE_NAME         EV_OPERATE_NAME,
           D.EV_PROCESS_ID,
           K.CODE_NAME      EV_PROCESS_NAME,
           B.EV_ITEM_ID,
           G.CODE_NAME   EV_ITEM_NAME,
           ecd.EV_COLUMN_ID,
           ECD.EV_COLUMN_DETAIL,
           D.EV_IDEA      EV_DETAIL_IDEA,
           B.EV_DETAIL_ORDER,
           B.SEQ_EV_ITEM_DETAIL
       FROM eva_EMP A,
         eva_ITEM_DETAIL B,
         eva_COLUMN_DETAIL ECD,
         eva_DETAIL_MARK D,
         SY_CODE E,
         SY_CODE F,
         SY_CODE G,
         SY_CODE H,
         eva_RELATION I,
         SY_CODE K,
         eva_PERIOD L
       WHERE --A.EV_EMP_ID         = '666888'
          A.EV_TYPE_ID      <> 'EVTYPE007'
         --AND A.EV_PERIOD_ID       ='200705'
         AND ECD.EV_COLUMN_ID     ='EVCOLUMN014'
         AND D.EV_PROCESS_ID      ='EVPROCESS001'
         AND A.EV_PERIOD_ID     = B.EV_PERIOD_ID
         AND A.EV_EMP_ID      = B.EV_EMP_ID
         AND B.SEQ_EV_ITEM_DETAIL = D.SEQ_EV_ITEM_DETAIL
         AND B.SEQ_EV_ITEM_DETAIL = ECD.SEQ_EV_ITEM_DETAIL
         AND A.EV_TYPE_ID      = E.CODE_ID
         AND A.EV_GRADE_ID     = F.CODE_ID
         AND B.EV_ITEM_ID      = G.CODE_ID
         AND I.EV_OPERATE_ID     = H.CODE_ID
         AND A.EV_PERIOD_ID     = I.EV_PERIOD_ID
         AND A.EV_TYPE_ID      = I.EV_TYPE_ID
         AND D.EV_PROCESS_ID     = I.EV_PROCESS_ID
         AND B.EV_ITEM_ID      = I.EV_ITEM_ID
         AND D.EV_PROCESS_ID     = K.CODE_ID
         AND A.EV_PERIOD_ID    = L.EV_PERIOD_ID;

prompt
prompt Creating view EVA_NATURE_MIDMARK_V
prompt ==================================
prompt
create or replace force view eva_nature_midmark_v as
select a.empid,a.ev_period_id,
       a.ev_item_id,
       a.ev_process_id,
       avg(a.ev_mark) av_mark
from (select eid.ev_emp_id as empid,eid.ev_period_id ,eid.ev_item_id,edm.ev_process_id,edm.ev_mark
              from  eva_detail_mark edm,
                    eva_column_detail ecd,
                    eva_item_detail eid
              where edm.seq_ev_item_detail=ecd.seq_ev_item_detail
                    and eid.seq_ev_item_detail=ecd.seq_ev_item_detail
                    and eid.ev_item_id='EVITEM008'
                    and edm.ev_process_id<>'EVPROCESS001')a
      group by a.empid,a.ev_period_id, a.ev_item_id,a.ev_process_id;

prompt
prompt Creating view EVA_NATURE_MARK_V
prompt ===============================
prompt
create or replace force view eva_nature_mark_v as
select t1.empid,t1.ev_period_id,first_estimation_mark,second_estimation_mark from
     (select emv.empid,emv.ev_period_id,emv.ev_process_id ,emv.av_mark as first_estimation_mark from eva_nature_midmark_v emv where emv.ev_process_id='EVPROCESS006') t1,
     (select emv.empid,emv.ev_period_id,emv.ev_process_id ,emv.av_mark as second_estimation_mark from eva_nature_midmark_v emv where emv.ev_process_id='EVPROCESS007') t2
     where t1.empid=t2.empid
     and t1.ev_period_id=t2.ev_period_id;

prompt
prompt Creating view EVA_OPERATE_V
prompt ===========================
prompt
CREATE OR REPLACE FORCE VIEW EVA_OPERATE_V AS
SELECT DISTINCT eva_emp.ev_period_id, eva_emp.ev_emp_id,
                   eva_master.ev_master, eva_relation.ev_operate_id
              FROM eva_emp INNER JOIN eva_master ON eva_emp.ev_period_id =
                                                       eva_master.ev_period_id
                                               AND eva_emp.ev_emp_id =
                                                          eva_master.ev_emp_id
                                               AND eva_emp.ev_process_id =
                                                      eva_master.ev_process_id
                   INNER JOIN eva_relation ON eva_relation.ev_period_id =
                                                          eva_emp.ev_period_id
                                         AND eva_relation.ev_type_id =
                                                            eva_emp.ev_type_id
                                         AND eva_relation.ev_process_id =
                                                         eva_emp.ev_process_id
                   INNER JOIN eva_type_process ON eva_type_process.ev_period_id =
                                                          eva_emp.ev_period_id
                                             AND eva_type_process.ev_type_id =
                                                            eva_emp.ev_type_id
                                             AND TO_DATE (TO_CHAR (SYSDATE,
                                                                   'yyyymmdd'
                                                                  ),
                                                          'yyyymmdd'
                                                         )
                                                    BETWEEN eva_type_process.ev_process_sdate
                                                        AND eva_type_process.ev_process_edate;

prompt
prompt Creating view EVA_OPERATION_V
prompt =============================
prompt
CREATE OR REPLACE FORCE VIEW EVA_OPERATION_V AS
SELECT t1.ev_period_id, t1.ev_emp_id as empid, column_operation, HR_CONVERT(content_operation) content_operation,
          column_target, HR_CONVERT(content_target) content_target
     FROM (SELECT emv.ev_period_id, emv.seq_ev_item_detail, emv.ev_emp_id,
                  emv.ev_column_detail AS column_operation,
                  emv.ev_detail_idea AS content_operation
             FROM eva_midprocess_v emv
            WHERE emv.ev_column_detail = '担当业务') t1,
          (SELECT emv.ev_period_id, emv.seq_ev_item_detail, emv.ev_emp_id,
                  emv.ev_column_detail AS column_target,
                  emv.ev_detail_idea AS content_target
             FROM eva_midprocess_v emv
            WHERE emv.ev_column_detail = '业务目标') t2
    WHERE t1.ev_period_id = t2.ev_period_id AND t1.ev_emp_id = t2.ev_emp_id;

prompt
prompt Creating view EVA_PERIOD_TYPE_V
prompt ===============================
prompt
CREATE OR REPLACE FORCE VIEW EVA_PERIOD_TYPE_V AS
SELECT eva_period.ev_year, eva_period.ev_period_id,
          eva_period.ev_period_name, eva_period_type.ev_type_id,
          sy_code.code_name ev_type_name
     FROM eva_period INNER JOIN eva_period_type ON eva_period.ev_period_id =
                                                     eva_period_type.ev_period_id
          INNER JOIN sy_code ON eva_period_type.ev_type_id = sy_code.code_id
                           AND sy_code.parent_code = 'EVTYPE'
													 ORDER BY sy_code.orderno;

prompt
prompt Creating view EVA_PERIOD_V
prompt ==========================
prompt
CREATE OR REPLACE FORCE VIEW EVA_PERIOD_V AS
SELECT   eva_period.ev_year, eva_period.ev_period_id,
            eva_period.ev_period_name,
            MIN (eva_type_process.ev_process_sdate) ev_period_sdate,
            MAX (eva_type_process.ev_process_edate) ev_period_edate
       FROM eva_period INNER JOIN eva_type_process ON eva_period.ev_period_id =
                                                        eva_type_process.ev_period_id
   GROUP BY eva_period.ev_year,
            eva_period.ev_period_id,
            eva_period.ev_period_name;

prompt
prompt Creating view EVA_QUANTITY_MIDMARK_V
prompt ====================================
prompt
create or replace force view eva_quantity_midmark_v as
select
       a.empid,a.ev_period_id,
       a.ev_item_id,
       a.ev_process_id,
       avg(a.ev_mark) av_mark
from (select eid.ev_emp_id as empid,eid.ev_period_id ,eid.ev_item_id,edm.ev_process_id,edm.ev_mark
              from  eva_detail_mark edm,
                    eva_column_detail ecd,
                    eva_item_detail eid
              where edm.seq_ev_item_detail=ecd.seq_ev_item_detail
                    and eid.seq_ev_item_detail=ecd.seq_ev_item_detail
                    and eid.ev_item_id='EVITEM007'
                    and edm.ev_process_id<>'EVPROCESS001') a
      group by a.empid,a.ev_period_id, a.ev_item_id,a.ev_process_id;

prompt
prompt Creating view EVA_QUANTITY_MARK_V
prompt =================================
prompt
create or replace force view eva_quantity_mark_v as
select t1.empid,t1.ev_period_id,first_estimation_mark,second_estimation_mark from
     (select emv.empid,emv.ev_period_id,emv.ev_process_id ,emv.av_mark as first_estimation_mark from eva_quantity_midmark_v emv where emv.ev_process_id='EVPROCESS006') t1,
     (select emv.empid,emv.ev_period_id,emv.ev_process_id ,emv.av_mark as second_estimation_mark from eva_quantity_midmark_v emv where emv.ev_process_id='EVPROCESS007') t2
     where t1.empid=t2.empid
     and t1.ev_period_id=t2.ev_period_id;

prompt
prompt Creating view EVA_QUATER_ESTIMATION_V
prompt =====================================
prompt
CREATE OR REPLACE FORCE VIEW EVA_QUATER_ESTIMATION_V AS
SELECT A.EV_EMP_ID,
       A.EV_PERIOD_ID,
       A.EV_PROCESS_ID,
       A.EV_TYPE_ID,
       A.EV_COLUMN_DETAIL,
       HR_CONVERT(A.EV_DETAIL_IDEA) AS EV_DETAIL_IDEA
  FROM (SELECT A.EV_PERIOD_ID,
               L.EV_PERIOD_NAME,
               A.EV_EMP_ID,
               A.EV_EMP_NAME,
               A.EV_DEPT_ID,
               A.EV_DEPT_NAME,
               A.EV_TYPE_ID,
               E.CODE_NAME          EV_TYPE_NAME,
               D.EV_PROCESS_ID,
               K.CODE_NAME          EV_PROCESS_NAME,
               I.EV_PROCESS_PROP,
               I.EV_OPERATE_ID,
               H.CODE_NAME          EV_OPERATE_NAME,
               B.EV_ITEM_ID,
               G.CODE_NAME          EV_ITEM_NAME,
               I.EV_ITEM_PROP,
               B.EV_DETAIL_PROP,
               B.EV_DETAIL_ORDER,
               D.EV_MARK            EV_DETAIL_MARK,
               C.EV_COLUMN_DETAIL,
               D.EV_IDEA            EV_DETAIL_IDEA,
               A.EV_MARK            EV_FINAL_MARK,
               A.EV_GRADE_ID,
               F.CODE_NAME          EV_FINAL_GRADE,
               B.SEQ_EV_ITEM_DETAIL
          FROM EVA_EMP           A,
               EVA_ITEM_DETAIL   B,
               EVA_COLUMN_DETAIL C,
               EVA_DETAIL_MARK   D,
               SY_CODE           E,
               SY_CODE           F,
               SY_CODE           G,
               SY_CODE           H,
               EVA_RELATION      I,
               SY_CODE           K,
               EVA_PERIOD        L
         WHERE A.EV_TYPE_ID = 'EVTYPE007'
           AND A.EV_PROCESS_ID = 'EVPROCESS010'
           AND A.EV_PERIOD_ID = B.EV_PERIOD_ID
           AND A.EV_EMP_ID = B.EV_EMP_ID
           AND B.SEQ_EV_ITEM_DETAIL = D.SEQ_EV_ITEM_DETAIL
           AND A.EV_TYPE_ID = E.CODE_ID(+)
           AND A.EV_GRADE_ID = F.CODE_ID(+)
           AND B.EV_ITEM_ID = G.CODE_ID(+)
           AND I.EV_OPERATE_ID = H.CODE_ID(+)
           AND A.EV_PERIOD_ID = I.EV_PERIOD_ID
           AND A.EV_TYPE_ID = I.EV_TYPE_ID
           AND D.EV_PROCESS_ID = I.EV_PROCESS_ID
           AND B.EV_ITEM_ID = I.EV_ITEM_ID
           AND D.EV_PROCESS_ID = K.CODE_ID(+)
           AND A.EV_PERIOD_ID = L.EV_PERIOD_ID
           AND B.SEQ_EV_ITEM_DETAIL = C.SEQ_EV_ITEM_DETAIL) A;

prompt
prompt Creating view EVA_TRAIN_SINGLE_V
prompt ================================
prompt
CREATE OR REPLACE FORCE VIEW EVA_TRAIN_SINGLE_V AS
SELECT result.ev_period_id,
       result.EV_PERIOD_NAME,
    result.ev_emp_id,
    result.EV_EMP_NAME,
    result.EV_TYPE_ID,
    result.EV_TYPE_NAME,
    result.ev_process_id,
    result.EV_PROCESS_NAME,
    result.EV_ITEM_ID,
    result.EV_ITEM_NAME,
       result.ev_column_detail,
       hr_convert(result.ev_detail_idea) as ev_detail_idea,
    result.SEQ_EV_ITEM_DETAIL
FROM(SELECT A.EV_PERIOD_ID,
           L.EV_PERIOD_NAME,
           A.EV_EMP_ID,
           A.EV_EMP_NAME,
           A.EV_DEPT_ID,
           A.EV_DEPT_NAME,
           A.EV_TYPE_ID,
           E.CODE_NAME      EV_TYPE_NAME,
           I.EV_OPERATE_ID,
           H.CODE_NAME         EV_OPERATE_NAME,
           D.EV_PROCESS_ID,
           K.CODE_NAME      EV_PROCESS_NAME,
           B.EV_ITEM_ID,
           G.CODE_NAME   EV_ITEM_NAME,
           ecd.EV_COLUMN_ID,
           ECD.EV_COLUMN_DETAIL,
           D.EV_IDEA      EV_DETAIL_IDEA,
           B.EV_DETAIL_ORDER,
           B.SEQ_EV_ITEM_DETAIL
       FROM eva_EMP A,
         eva_ITEM_DETAIL B,
         eva_COLUMN_DETAIL ECD,
         eva_DETAIL_MARK D,
         SY_CODE E,
         SY_CODE F,
         SY_CODE G,
         SY_CODE H,
         eva_RELATION I,
         SY_CODE K,
         eva_PERIOD L
       WHERE --A.EV_EMP_ID         = '666888'
         A.EV_TYPE_ID      <> 'EVTYPE007'
         --AND A.EV_PERIOD_ID       ='200705'
         AND B.EV_ITEM_ID         ='EVITEM004'
         AND A.EV_PERIOD_ID     = B.EV_PERIOD_ID
         AND A.EV_EMP_ID      = B.EV_EMP_ID
         AND B.SEQ_EV_ITEM_DETAIL = D.SEQ_EV_ITEM_DETAIL
         AND B.SEQ_EV_ITEM_DETAIL = ECD.SEQ_EV_ITEM_DETAIL
         AND A.EV_TYPE_ID      = E.CODE_ID
         AND A.EV_GRADE_ID     = F.CODE_ID
         AND B.EV_ITEM_ID      = G.CODE_ID
         AND I.EV_OPERATE_ID     = H.CODE_ID
         AND A.EV_PERIOD_ID     = I.EV_PERIOD_ID
         AND A.EV_TYPE_ID      = I.EV_TYPE_ID
         AND D.EV_PROCESS_ID     = I.EV_PROCESS_ID
         AND B.EV_ITEM_ID      = I.EV_ITEM_ID
         AND D.EV_PROCESS_ID     = K.CODE_ID
         AND A.EV_PERIOD_ID    = L.EV_PERIOD_ID) result;

prompt
prompt Creating view EVA_TRAIN_V
prompt =========================
prompt
CREATE OR REPLACE FORCE VIEW EVA_TRAIN_V AS
SELECT t1.ev_period_id, t1.ev_emp_id, estimation_process_first,hr_convert(idea_training_first) AS idea_training_first,
          estimation_process_second, hr_convert(idea_training_second) AS idea_training_second
     FROM (SELECT emfv.ev_period_id, emfv.seq_ev_item_detail, emfv.ev_emp_id,
                  emfv.ev_process_name AS estimation_process_first,
                  emfv.ev_detail_idea AS idea_training_first
             FROM eva_MIDPROCESS_fortrain_V emfv
            WHERE emfv.EV_PROCESS_ID = 'EVPROCESS006') t1,
          (SELECT emfv.ev_period_id, emfv.seq_ev_item_detail, emfv.ev_emp_id,
                  emfv.ev_process_name AS estimation_process_second,
                  emfv.ev_detail_idea AS idea_training_second
             FROM eva_MIDPROCESS_fortrain_V emfv
            WHERE emfv.EV_PROCESS_ID = 'EVPROCESS007') t2
    WHERE t1.ev_period_id = t2.ev_period_id AND t1.ev_emp_id = t2.ev_emp_id;

prompt
prompt Creating view EVA_TYPE_ITEM_V
prompt =============================
prompt
CREATE OR REPLACE FORCE VIEW EVA_TYPE_ITEM_V AS
SELECT eva_period.ev_year, eva_period.ev_period_id,
          eva_period.ev_period_name, eva_period_type.ev_type_id,
          sc1.code_name ev_type_name, eva_type_item.ev_item_id,
          eva_type_item.ev_item_order, sc2.code_name ev_item_name
     FROM eva_period INNER JOIN eva_period_type ON eva_period.ev_period_id =
                                                     eva_period_type.ev_period_id
          INNER JOIN sy_code sc1 ON eva_period_type.ev_type_id = sc1.code_id
                               AND sc1.parent_code = 'EVTYPE'
          INNER JOIN eva_type_item ON eva_period_type.ev_period_id =
                                                    eva_type_item.ev_period_id
                                 AND eva_period_type.ev_type_id =
                                                      eva_type_item.ev_type_id
          INNER JOIN sy_code sc2 ON eva_type_item.ev_item_id = sc2.code_id
                               AND sc2.parent_code = 'EVITEM';

prompt
prompt Creating view EVA_TYPE_PROCESS_V
prompt ================================
prompt
CREATE OR REPLACE FORCE VIEW EVA_TYPE_PROCESS_V AS
SELECT eva_period.ev_year, eva_period.ev_period_id,
          eva_period.ev_period_name, eva_period_type.ev_type_id,
          sc1.code_name ev_type_name, eva_type_process.ev_process_id,
          sc2.code_name ev_process_name, eva_type_process.ev_process_order,
          eva_type_process.ev_process_sdate,
          eva_type_process.ev_process_edate
     FROM eva_period INNER JOIN eva_period_type ON eva_period.ev_period_id =
                                                     eva_period_type.ev_period_id
          INNER JOIN sy_code sc1 ON eva_period_type.ev_type_id = sc1.code_id
                               AND sc1.parent_code = 'EVTYPE'
          INNER JOIN eva_type_process ON eva_period_type.ev_period_id =
                                                 eva_type_process.ev_period_id
                                    AND eva_period_type.ev_type_id =
                                                   eva_type_process.ev_type_id
          INNER JOIN sy_code sc2 ON eva_type_process.ev_process_id =
                                                                   sc2.code_id
                               AND sc2.parent_code = 'EVPROCESS';

prompt
prompt Creating view EVJ_DEPT_RADIO_V
prompt ==============================
prompt
CREATE OR REPLACE FORCE VIEW EVJ_DEPT_RADIO_V AS
SELECT evj_dept_radio.ev_period_id, evj_dept_radio.ev_dept_id,
          hr_department.deptname AS ev_dept_name,
          evj_dept_radio.ev_dept_grade_id,
          sc2.code_name AS ev_dept_grade_name, evj_dept_radio.ev_grade_id,
          sc1.code_name AS ev_grade_name, ev_grade_prop, ev_wage_radio
     FROM evj_dept_radio LEFT JOIN sy_code sc1 ON sc1.code_id =
                                                    evj_dept_radio.ev_grade_id
                                             AND sc1.parent_code =
                                                                  'EVEMPGRADE'
          LEFT JOIN hr_department ON hr_department.deptid =
                                                     evj_dept_radio.ev_dept_id
          LEFT JOIN sy_code sc2 ON sc2.code_id =
                                               evj_dept_radio.ev_dept_grade_id
                              AND sc2.parent_code = 'EVDEPTGRADE';

prompt
prompt Creating view EVJ_DEPT_V
prompt ========================
prompt
CREATE OR REPLACE FORCE VIEW EVJ_DEPT_V AS
SELECT     ev_period_id, ev_dept_id, ev_dept_name, ev_dept_level,
              ev_parent_dept_id, ev_dept_grade_id,
              get_sys_code (ev_dept_grade_id) AS ev_dept_grade_name,
              ev_dept_norm, activity
         FROM evj_dept
   START WITH ev_parent_dept_id IN (SELECT cpny_id
                                      FROM hr_company)
   CONNECT BY PRIOR ev_dept_id = ev_parent_dept_id
          AND PRIOR ev_period_id = ev_period_id
     ORDER SIBLINGS BY ev_dept_id;

prompt
prompt Creating view EVJ_EMP_ITEM_V
prompt ============================
prompt
CREATE OR REPLACE FORCE VIEW EVJ_EMP_ITEM_V AS
SELECT evj_emp.ev_period_id, evj_emp.ev_emp_id, evj_type_item.ev_item_id,
          sy_code.code_name ev_item_name, evj_type_item.ev_item_order
     FROM evj_emp INNER JOIN evj_type_item ON evj_emp.ev_type_id =
                                                      evj_type_item.ev_type_id
                                         AND evj_emp.ev_period_id =
                                                    evj_type_item.ev_period_id
          INNER JOIN sy_code ON evj_type_item.ev_item_id = sy_code.code_id
                           AND sy_code.parent_code = 'EVITEM';

prompt
prompt Creating view EVJ_EMP_V
prompt =======================
prompt
CREATE OR REPLACE FORCE VIEW EVJ_EMP_V AS
SELECT evj_emp.ev_period_id, evj_emp.ev_emp_id, evj_emp.ev_emp_name,
          evj_emp.ev_dept_id, evj_emp.ev_dept_name, evj_emp.ev_post_group_id,
          evj_emp.ev_post_group_name, evj_emp.ev_type_id,
          sc1.code_name ev_type_name, evj_emp.ev_process_id,
          sc2.code_name ev_process_name, evj_emp.ev_mark, evj_emp.ev_grade_id,
          sc3.code_name ev_grade_name, evj_emp.activity
     FROM evj_emp INNER JOIN sy_code sc1 ON sc1.code_id = evj_emp.ev_type_id
                                       AND sc1.parent_code = 'EVTYPE'
          LEFT JOIN sy_code sc2 ON sc2.code_id = evj_emp.ev_process_id
                              AND sc2.parent_code = 'EVPROCESS'
          LEFT JOIN sy_code sc3 ON sc3.code_id = evj_emp.ev_grade_id
                              AND sc3.parent_code = 'EVEMPGRADE';

prompt
prompt Creating view EVJ_ITEM_PROCESS_MARK_V
prompt =====================================
prompt
CREATE OR REPLACE FORCE VIEW EVJ_ITEM_PROCESS_MARK_V AS
SELECT evj_emp.ev_period_id, evj_emp.ev_emp_id, evj_emp.ev_emp_name,
          evj_emp.ev_dept_id, evj_emp.ev_dept_name, evj_master.ev_item_id,
          sc2.code_name ev_item_name, evj_master.ev_process_id,
          sc1.code_name ev_process_name,
          evj_master.ev_mark AS ev_item_process_mark
     FROM evj_emp INNER JOIN evj_master ON evj_emp.ev_period_id =
                                                       evj_master.ev_period_id
                                      AND evj_emp.ev_emp_id =
                                                          evj_master.ev_emp_id
          INNER JOIN sy_code sc1 ON evj_master.ev_process_id = sc1.code_id
                               AND sc1.parent_code = 'EVPROCESS'
          INNER JOIN sy_code sc2 ON evj_master.ev_item_id = sc2.code_id
                               AND sc2.parent_code = 'EVITEM';

prompt
prompt Creating view EVJ_MARKS_RESULT_V
prompt ================================
prompt
CREATE OR REPLACE FORCE VIEW EVJ_MARKS_RESULT_V AS
SELECT evj_emp.ev_period_id, evj_period.ev_parent_period_id,
          evj_period.ev_parent_period_flag, evj_emp.ev_emp_id,
          evj_emp.ev_emp_name, evj_emp.ev_type_id, evj_emp.ev_dept_id,
          evj_emp.ev_dept_name, evj_master.ev_item_id, evj_master.ev_mark,
          evj_master.ev_submitted
     FROM evj_emp LEFT JOIN evj_period ON (evj_emp.ev_period_id =
                                                       evj_period.ev_period_id
                                          )
          , evj_master, evj_relation
    WHERE (    (evj_emp.ev_period_id = evj_master.ev_period_id)
           AND (evj_emp.ev_emp_id = evj_master.ev_emp_id)
           AND (evj_emp.ev_type_id = evj_relation.ev_type_id)
           AND (evj_master.ev_period_id = evj_relation.ev_period_id)
           AND (evj_master.ev_process_id = evj_relation.ev_process_id)
           AND (evj_master.ev_item_id = evj_relation.ev_item_id)
           AND evj_relation.ev_operate_id = 'EVOPERATE003'
          );

prompt
prompt Creating view EVJ_MARKS_V
prompt =========================
prompt
CREATE OR REPLACE FORCE VIEW EVJ_MARKS_V AS
SELECT evj_master.ev_period_id, evj_master.ev_master,
          evj_master.ev_process_id, sc1.code_name ev_process_name,
          evj_emp.ev_type_id, evj_master.ev_emp_id, evj_emp.ev_emp_name,
          evj_emp.ev_dept_id,
          hr_get_full_deptname (evj_emp.ev_dept_id) ev_dept_name,
          evj_emp.ev_process_id current_process_id, evj_master.ev_item_id,
          sc2.code_name ev_item_name, evj_relation.ev_marks_value,
          evj_relation.ev_marks_default, evj_relation.ev_marks_name,
          evj_master.ev_mark, evj_master.ev_submitted
     FROM evj_master INNER JOIN evj_emp ON evj_master.ev_period_id =
                                                          evj_emp.ev_period_id
                                      AND evj_master.ev_emp_id =
                                                             evj_emp.ev_emp_id
          INNER JOIN evj_relation ON evj_master.ev_period_id =
                                                     evj_relation.ev_period_id
                                AND evj_emp.ev_type_id =
                                                       evj_relation.ev_type_id
                                AND evj_master.ev_process_id =
                                                    evj_relation.ev_process_id
                                AND evj_master.ev_item_id =
                                                       evj_relation.ev_item_id
          INNER JOIN sy_code sc1 ON evj_master.ev_process_id = sc1.code_id
                               AND sc1.parent_code = 'EVPROCESS'
          INNER JOIN sy_code sc2 ON evj_master.ev_item_id = sc2.code_id
                               AND sc2.parent_code = 'EVITEM';

prompt
prompt Creating view EVJ_MASTER_EMP_V
prompt ==============================
prompt
CREATE OR REPLACE FORCE VIEW EVJ_MASTER_EMP_V AS
SELECT DISTINCT evj_master.ev_period_id, evj_master.ev_master,
                   evj_emp.ev_emp_id, evj_emp.ev_emp_name, evj_emp.ev_dept_id,
                   evj_emp.ev_dept_name, evj_emp.ev_type_id,
                   sc2.code_name ev_type_name,
                   evj_emp.ev_process_id current_process_id,
                   sc1.code_name current_process_name,
                   evj_relation.ev_operate_id current_operate_id,
                   evj_emp.ev_mark, evj_emp.ev_grade_id,
                   sc3.code_name AS ev_grade_name,
                   (CASE
                       WHEN evj_emp.ev_process_id IN (
                              SELECT ev_process_id
                                FROM evj_master em
                               WHERE em.ev_period_id = evj_emp.ev_period_id
                                 AND em.ev_emp_id = evj_emp.ev_emp_id
                                 AND em.ev_master = evj_master.ev_master)
                          THEN (CASE
                                   WHEN (SELECT ev_process_sdate
                                           FROM evj_type_process
                                          WHERE ev_period_id =
                                                          evj_emp.ev_period_id
                                            AND ev_type_id =
                                                            evj_emp.ev_type_id
                                            AND ev_process_id =
                                                         evj_emp.ev_process_id) <=
                                                                       SYSDATE
                                   AND (SELECT ev_process_edate
                                          FROM evj_type_process
                                         WHERE ev_period_id =
                                                          evj_emp.ev_period_id
                                           AND ev_type_id = evj_emp.ev_type_id
                                           AND ev_process_id =
                                                         evj_emp.ev_process_id) >=
                                                                       SYSDATE
                                      THEN 1
                                   ELSE 0
                                END
                               )
                       ELSE 0
                    END
                   ) operatable
              FROM evj_master INNER JOIN evj_emp ON evj_master.ev_period_id =
                                                          evj_emp.ev_period_id
                                               AND evj_master.ev_emp_id =
                                                             evj_emp.ev_emp_id
                                               AND evj_master.ev_master <>
                                                             evj_emp.ev_emp_id
                   INNER JOIN sy_code sc1 ON sc1.code_id =
                                                         evj_emp.ev_process_id
                                        AND sc1.parent_code = 'EVPROCESS'
                   LEFT JOIN sy_code sc3 ON sc3.code_id = evj_emp.ev_grade_id
                                       AND sc3.parent_code = 'EVEMPGRADE'
                   LEFT JOIN sy_code sc2 ON sc2.code_id = evj_emp.ev_type_id
                                       AND sc2.parent_code = 'EVTYPE'
                   INNER JOIN evj_relation ON evj_relation.ev_type_id =
                                                            evj_emp.ev_type_id
                                         AND evj_relation.ev_period_id =
                                                          evj_emp.ev_period_id
                                         AND evj_relation.ev_process_id =
                                                         evj_emp.ev_process_id;

prompt
prompt Creating view EVJ_MASTER_EMP_V2
prompt ===============================
prompt
CREATE OR REPLACE FORCE VIEW EVJ_MASTER_EMP_V2 AS
SELECT DISTINCT evj_master.ev_period_id, evj_master.ev_master,
                   evj_emp.ev_emp_id, evj_emp.ev_emp_name, evj_emp.ev_dept_id,
                   evj_emp.ev_dept_name, evj_emp.ev_type_id,
                   sc2.code_name ev_type_name,
                   evj_emp.ev_process_id current_process_id,
                   sc1.code_name current_process_name,
                   evj_relation.ev_operate_id current_operate_id,
                   evj_emp.ev_mark, evj_emp.ev_grade_id,
                   sc3.code_name AS ev_grade_name,
                   (CASE
                       WHEN evj_emp.ev_process_id IN (
                              SELECT ev_process_id
                                FROM evj_master em
                               WHERE em.ev_period_id = evj_emp.ev_period_id
                                 AND em.ev_emp_id = evj_emp.ev_emp_id
                                 AND em.ev_master = evj_master.ev_master)
                          THEN (CASE
                                   WHEN (SELECT ev_process_sdate
                                           FROM evj_type_process
                                          WHERE ev_period_id =
                                                          evj_emp.ev_period_id
                                            AND ev_type_id =
                                                            evj_emp.ev_type_id
                                            AND ev_process_id =
                                                         evj_emp.ev_process_id) <=
                                                                       SYSDATE
                                   AND (SELECT ev_process_edate
                                          FROM evj_type_process
                                         WHERE ev_period_id =
                                                          evj_emp.ev_period_id
                                           AND ev_type_id = evj_emp.ev_type_id
                                           AND ev_process_id =
                                                         evj_emp.ev_process_id) >=
                                                                       SYSDATE
                                      THEN 1
                                   ELSE 0
                                END
                               )
                       ELSE 0
                    END
                   ) operatable
              FROM evj_master INNER JOIN evj_emp ON evj_master.ev_period_id =
                                                          evj_emp.ev_period_id
                                               AND evj_master.ev_emp_id =
                                                             evj_emp.ev_emp_id
                   INNER JOIN sy_code sc1 ON sc1.code_id =
                                                         evj_emp.ev_process_id
                                        AND sc1.parent_code = 'EVPROCESS'
                   LEFT JOIN sy_code sc3 ON sc3.code_id = evj_emp.ev_grade_id
                                       AND sc3.parent_code = 'EVEMPGRADE'
                   LEFT JOIN sy_code sc2 ON sc2.code_id = evj_emp.ev_type_id
                                       AND sc2.parent_code = 'EVTYPE'
                   INNER JOIN evj_relation ON evj_relation.ev_type_id =
                                                            evj_emp.ev_type_id
                                         AND evj_relation.ev_period_id =
                                                          evj_emp.ev_period_id
                                         AND evj_relation.ev_process_id =
                                                         evj_emp.ev_process_id;

prompt
prompt Creating view EVJ_MASTER_V
prompt ==========================
prompt
CREATE OR REPLACE FORCE VIEW EVJ_MASTER_V AS
SELECT evj_master.ev_period_id, evj_master.ev_emp_id, evj_emp.ev_emp_name,
          evj_emp.ev_dept_id, evj_emp.ev_dept_name, evj_master.ev_process_id,
          sc1.code_name ev_process_name, evj_master.ev_item_id,
          evj_master.ev_mark, sc2.code_name ev_item_name,
          evj_type_process.ev_process_order, evj_master.ev_master,
          hr_employee.chinesename ev_master_name, evj_master.ev_appendable,
          evj_master.ev_append_value, evj_master.ev_append_name,
          evj_master.ev_append_default
     FROM evj_master INNER JOIN sy_code sc1 ON evj_master.ev_process_id =
                                                                   sc1.code_id
                                          AND sc1.parent_code = 'EVPROCESS'
          INNER JOIN sy_code sc2 ON evj_master.ev_item_id = sc2.code_id
                               AND sc2.parent_code = 'EVITEM'
          INNER JOIN evj_emp ON evj_master.ev_emp_id = evj_emp.ev_emp_id
                           AND evj_master.ev_period_id = evj_emp.ev_period_id
          INNER JOIN evj_type_process ON evj_type_process.ev_period_id =
                                                          evj_emp.ev_period_id
                                    AND evj_type_process.ev_type_id =
                                                            evj_emp.ev_type_id
                                    AND evj_type_process.ev_process_id =
                                                      evj_master.ev_process_id
          LEFT JOIN hr_employee ON hr_employee.empid = evj_master.ev_master;

prompt
prompt Creating view EVJ_OPERATE_V
prompt ===========================
prompt
CREATE OR REPLACE FORCE VIEW EVJ_OPERATE_V AS
SELECT DISTINCT evj_emp.ev_period_id, evj_emp.ev_emp_id,
                   evj_master.ev_master, evj_relation.ev_operate_id
              FROM evj_emp INNER JOIN evj_master ON evj_emp.ev_period_id =
                                                       evj_master.ev_period_id
                                               AND evj_emp.ev_emp_id =
                                                          evj_master.ev_emp_id
                                               AND evj_emp.ev_process_id =
                                                      evj_master.ev_process_id
                   INNER JOIN evj_relation ON evj_relation.ev_period_id =
                                                          evj_emp.ev_period_id
                                         AND evj_relation.ev_type_id =
                                                            evj_emp.ev_type_id
                                         AND evj_relation.ev_process_id =
                                                         evj_emp.ev_process_id
                   INNER JOIN evj_type_process ON evj_type_process.ev_period_id =
                                                          evj_emp.ev_period_id
                                             AND evj_type_process.ev_type_id =
                                                            evj_emp.ev_type_id
                                             AND SYSDATE
                                                    BETWEEN evj_type_process.ev_process_sdate
                                                        AND evj_type_process.ev_process_edate;

prompt
prompt Creating view EVJ_PERIOD_TYPE_V
prompt ===============================
prompt
CREATE OR REPLACE FORCE VIEW EVJ_PERIOD_TYPE_V AS
SELECT evj_period.ev_year, evj_period.ev_period_id,
          evj_period.ev_period_name, evj_period_type.ev_type_id,
          sy_code.code_name ev_type_name
     FROM evj_period INNER JOIN evj_period_type ON evj_period.ev_period_id =
                                                     evj_period_type.ev_period_id
          INNER JOIN sy_code ON evj_period_type.ev_type_id = sy_code.code_id
                           AND sy_code.parent_code = 'EVTYPE';

prompt
prompt Creating view EVJ_PERIOD_V
prompt ==========================
prompt
CREATE OR REPLACE FORCE VIEW EVJ_PERIOD_V AS
SELECT   evj_period.ev_year, evj_period.ev_period_id,
            evj_period.ev_period_name,
            MIN (evj_type_process.ev_process_sdate) ev_period_sdate,
            MAX (evj_type_process.ev_process_edate) ev_period_edate
       FROM evj_period INNER JOIN evj_type_process ON evj_period.ev_period_id =
                                                        evj_type_process.ev_period_id
   GROUP BY evj_period.ev_year,
            evj_period.ev_period_id,
            evj_period.ev_period_name;

prompt
prompt Creating view EVJ_TYPE_ITEM_V
prompt =============================
prompt
CREATE OR REPLACE FORCE VIEW EVJ_TYPE_ITEM_V AS
SELECT evj_period.ev_year, evj_period.ev_period_id,
          evj_period.ev_period_name, evj_period_type.ev_type_id,
          sc1.code_name ev_type_name, evj_type_item.ev_item_id,
          evj_type_item.ev_item_order, sc2.code_name ev_item_name
     FROM evj_period INNER JOIN evj_period_type ON evj_period.ev_period_id =
                                                     evj_period_type.ev_period_id
          INNER JOIN sy_code sc1 ON evj_period_type.ev_type_id = sc1.code_id
                               AND sc1.parent_code = 'EVTYPE'
          INNER JOIN evj_type_item ON evj_period_type.ev_period_id =
                                                    evj_type_item.ev_period_id
                                 AND evj_period_type.ev_type_id =
                                                      evj_type_item.ev_type_id
          INNER JOIN sy_code sc2 ON evj_type_item.ev_item_id = sc2.code_id
                               AND sc2.parent_code = 'EVITEM';

prompt
prompt Creating view EVJ_TYPE_PROCESS_V
prompt ================================
prompt
CREATE OR REPLACE FORCE VIEW EVJ_TYPE_PROCESS_V AS
SELECT evj_period.ev_year, evj_period.ev_period_id,
          evj_period.ev_period_name, evj_period_type.ev_type_id,
          sc1.code_name ev_type_name, evj_type_process.ev_process_id,
          sc2.code_name ev_process_name, evj_type_process.ev_process_order,
          evj_type_process.ev_process_sdate,
          evj_type_process.ev_process_edate
     FROM evj_period INNER JOIN evj_period_type ON evj_period.ev_period_id =
                                                     evj_period_type.ev_period_id
          INNER JOIN sy_code sc1 ON evj_period_type.ev_type_id = sc1.code_id
                               AND sc1.parent_code = 'EVTYPE'
          INNER JOIN evj_type_process ON evj_period_type.ev_period_id =
                                                 evj_type_process.ev_period_id
                                    AND evj_period_type.ev_type_id =
                                                   evj_type_process.ev_type_id
          INNER JOIN sy_code sc2 ON evj_type_process.ev_process_id =
                                                                   sc2.code_id
                               AND sc2.parent_code = 'EVPROCESS';

prompt
prompt Creating view EV_DETAIL_VIEW
prompt ============================
prompt
CREATE OR REPLACE FORCE VIEW EV_DETAIL_VIEW AS
SELECT
      ee.ev_emp_id,
      ee.ev_emp_name,
      ee.ev_dept_id,
      ee.ev_dept_name,
      ee.ev_period_id,
      ee.ev_type_id,
      get_sys_code(ee.ev_type_id) ev_type_name,
      eeip.ev_item_id,
      get_sys_code(eeip.ev_item_id) ev_item_name,
      decode(eeip.ev_item_mark,0,ee.ev_mark,'',ee.ev_mark,eeip.ev_item_mark) ev_item_mark,
      eeip.ev_item_grade_id,
      get_sys_code(eeip.ev_item_grade_id) ev_item_grade_name,
      eeip.ev_item_process_id  ev_item_process_id
FROM EVA_EMP_ITEM_PROCESS eeip,evA_emp ee
WHERE eeip.EV_EMP_ID = ee.ev_emp_id
AND eeip.ev_period_id = ee.ev_period_id
UNION ALL
SELECT
    ee.ev_emp_id,
    ee.ev_emp_name,
    ee.ev_dept_id,
    ee.ev_dept_name,
    ee.ev_period_id,
    ee.ev_type_id,
    get_sys_code(ee.ev_type_id) ev_type_name,
    eei.ev_extra_item_id,
    get_sys_code(eei.ev_extra_item_id) ev_extra_item_name,
    eei.ev_extra_item_mark,
    '',
    '',
    ''
FROM ev_extra_item eei,evA_emp ee
WHERE eei.ev_empid = ee.ev_emp_id
AND eei.ev_period_id = ee.ev_period_id;

prompt
prompt Creating view HR_ACT_BUSINESS_V
prompt ===============================
prompt
CREATE OR REPLACE FORCE VIEW HR_ACT_BUSINESS_V AS
SELECT HRE.EMPID,
       T.TRANS_CODE                         AS BIZ_TRANS_CODE,
       B.CODE_NAME                          AS BIZ_TRANS_NAME,
       B.CODE_EN_NAME                       AS BIZ_TRANS_EN_NAME,
       T.BIZ_CODE                           AS BIZ_CODE,
       A.CODE_NAME                          AS BIZ_NAME,
       A.CODE_EN_NAME                       AS BIZ_EN_NAME,
       TO_CHAR(T.START_DATE, 'YYYY-MM-DD')  AS BIZ_START_DATE,
       TO_CHAR(T.END_DATE, 'YYYY-MM-DD')    AS BIZ_END_DATE,
       T.REMARK                             AS REMARK
  FROM HR_ACT_BUSINESS T,
       HR_EMPLOYEE     HRE,
       SY_CODE         A,
       SY_CODE         B
 WHERE T.EMPID = HRE.EMPID
   AND T.BIZ_CODE = A.CODE_ID(+)
   AND T.TRANS_CODE = B.CODE_ID(+);

prompt
prompt Creating view HR_ADDITIONAL_INFO_V
prompt ==================================
prompt
CREATE OR REPLACE FORCE VIEW HR_ADDITIONAL_INFO_V AS
SELECT HAI.EMPID,
        EVENT_DATE,
        INFO_TYPE_CODE,
        DETAILS,
        REGISTER_ID,
        (SELECT  CHINESENAME FROM hr_employee WHERE empid= hai.REGISTER_ID) REGISTER_NAME,
        HAI.CREATE_DATE,
        HAI.ACTIVITY
    FROM HR_ADDITIONAL_INFO HAI;

prompt
prompt Creating view HR_ALL_PART_LIST
prompt ==============================
prompt
create or replace force view hr_all_part_list as
select
       get_dept_name(hr_get_parent_deptid(t.deptid))  parentDeptName,
       t.parent_dept_id                               parentDeptID,
       t.deptid                                       deptID,
       t.deptid                                       partID,
       t.deptname                                     partName,
       hr_get_full_part_name(t.deptid)                fullPartName,
       t.deptname                                     deptName,
       t.dept_level                                   deptLevel
from hr_department t start with t.dept_level=5  connect by prior t.deptid=t.parent_dept_id;

prompt
prompt Creating view HR_ALL_PART_LIST_V
prompt ================================
prompt
create or replace force view hr_all_part_list_v as
select
       get_dept_name(hr_get_parent_deptid(t.deptid))  parentDeptName,
       t.parent_dept_id                               parentDeptID,
       t.deptid                                       deptID,
       t.deptid                                       partID,
       t.deptname                                     partName,
       hr_get_full_part_name(t.deptid)                fullPartName,
       t.deptname                                     deptName,
       t.dept_level                                   deptLevel,
       t.date_ended                                   date_ended
from hr_department t;

prompt
prompt Creating view HR_CONTRACT_INFO_V
prompt ================================
prompt
CREATE OR REPLACE FORCE VIEW HR_CONTRACT_INFO_V AS
SELECT A.EMPID,
       A.TOTAL_PERIOD AS CONTRACT_TOTAL_PERIOD,
       A.CONTRACT_TYPE_CODE,
       D.CODE_NAME        AS CONTRACT_TYPE_NAME,
       D.CODE_EN_NAME     AS CONTRACT_TYPE_EN_NAME,
       A.CONTRACT_CONT_CODE,
       E.CODE_NAME        AS CONTRACT_CONT_NAME,
       E.CODE_EN_NAME     AS CONTRACT_CONT_EN_NAME,
       A.CONTRACT_KIND_CODE,
       F.CODE_NAME        AS CONTRACT_KIND_NAME,
       F.CODE_EN_NAME     AS CONTRACT_KIND_EN_NAME,
       TO_CHAR(A.START_CONTRACT_DATE, 'YYYY-MM-DD') CONTRACT_START_DATE,
       TO_CHAR(A.END_CONTRACT_DATE, 'YYYY-MM-DD') CONTRACT_END_DATE,
       A.REMARK           AS CONTRACT_REMARK,
       A.RENEWABLE        AS CONTRACT_RENEWABLE
  FROM HR_CONTRACT   A,
       HR_EMPLOYEE   HRE,
       SY_CODE       D,
       SY_CODE       E,
       SY_CODE       F
 WHERE A.EMPID = HRE.EMPID(+)
   AND A.CONTRACT_TYPE_CODE = D.CODE_ID(+)
   AND A.CONTRACT_CONT_CODE = E.CODE_ID(+)
   AND A.CONTRACT_KIND_CODE = F.CODE_ID(+);

prompt
prompt Creating view HR_CURRENT_CONTRACT_INFO_V
prompt ========================================
prompt
CREATE OR REPLACE FORCE VIEW HR_CURRENT_CONTRACT_INFO_V AS
SELECT A.EMPID,
       A.CONTRACT_TYPE_CODE                AS CUR_CONTRACT_TYPE_CODE,
       D.CODE_NAME                         AS CUR_CONTRACT_TYPE_NAME,
       D.CODE_EN_NAME                      AS CUR_CONTRACT_TYPE_EN_NAME,
       A.CONTRACT_CONT_CODE,
       E.CODE_NAME                         AS CUR_CONTRACT_CONT_NAME,
       E.CODE_EN_NAME                      AS CUR_CONTRACT_CONT_EN_NAME,
       A.CONTRACT_KIND_CODE,
       F.CODE_NAME                         AS CUR_CONTRACT_KIND_NAME,
       F.CODE_EN_NAME                      AS CUR_CONTRACT_KIND_EN_NAME,
       TO_CHAR(A.START_CONTRACT_DATE, 'YYYY-MM-DD') AS CUR_CONTRACT_START_DATE,
       TO_CHAR(A.END_CONTRACT_DATE, 'YYYY-MM-DD')   AS CUR_CONTRACT_END_DATE,
       A.REMARK                                     AS CUR_CONTRACT_REMARK,
       A.RENEWABLE                                  AS CUR_CONTRACT_RENEWABLE
  FROM (SELECT P.*
          FROM (SELECT O.*,ROW_NUMBER() OVER(PARTITION BY O.EMPID ORDER BY O.END_CONTRACT_DATE DESC) ROW_NUMBER
                  FROM HR_CONTRACT O) P
         WHERE P.ROW_NUMBER = 1) A,
       HR_EMPLOYEE HRE,
       SY_CODE D,
       SY_CODE E,
       SY_CODE F
 WHERE A.EMPID = HRE.EMPID(+)
   AND A.CONTRACT_TYPE_CODE = D.CODE_ID(+)
   AND A.CONTRACT_CONT_CODE = E.CODE_ID(+)
   AND A.CONTRACT_KIND_CODE = F.CODE_ID(+);

prompt
prompt Creating view HR_DEPARTMENT_SY_TREE_V
prompt =====================================
prompt
CREATE OR REPLACE FORCE VIEW HR_DEPARTMENT_SY_TREE_V AS
SELECT     deptno, deptid, deptname, cpny_id, date_created, parent_dept_id,
              dept_level, create_date, created_by, update_date, updated_by,
              activity, orderno, date_ended
         FROM hr_department
   START WITH parent_dept_id IN (SELECT cpny_id
                                   FROM hr_company)
   CONNECT BY PRIOR deptid = parent_dept_id
     ORDER SIBLINGS BY deptid;

prompt
prompt Creating view HR_DEPT_TREE_V
prompt ============================
prompt
CREATE OR REPLACE FORCE VIEW HR_DEPT_TREE_V AS
SELECT D.DEPTID,
       D.DEPTNAME       AS DEPTNAME,
       DEPT_LEVEL,
       D.DEPT_EN_NAME,
       MANAGER_EMP_ID   AS MANAGER_ID,
       HRE.CHINESENAME  AS MANAGER_NAME,
       D.PARENT_DEPT_ID,
       D.CPNY_ID,
       D.ORDERNO,
       ROWNUM           AS DEPTORDER,
       D.DATE_ENDED
  FROM HR_DEPARTMENT D, HR_EMPLOYEE HRE
 WHERE MANAGER_EMP_ID = HRE.EMPID(+)
 START WITH PARENT_DEPT_ID IN (SELECT CPNY_ID FROM HR_COMPANY)
CONNECT BY PRIOR D.DEPTID = PARENT_DEPT_ID
 ORDER SIBLINGS BY D.ORDERNO, D.DEPT_LEVEL DESC, D.DEPTID;

prompt
prompt Creating view HR_DISPATCH_V
prompt ===========================
prompt
CREATE OR REPLACE FORCE VIEW HR_DISPATCH_V AS
SELECT HRE.EMPID,
       HRDI.TRANS_CODE           AS DIS_TRANS_CODE,
       A.CODE_NAME               AS DIS_TRANS_NAME,
       A.CODE_EN_NAME            AS DIS_TRANS_EN_NAME,
       HRDI.DIS_TYPE_CODE        AS DIS_TYPE_CODE,
       B.CODE_NAME               AS DIS_TYPE_NAME,
       B.CODE_EN_NAME            AS DIS_TYPE_EN_NAME,
       HRDI.REMARK                            AS DIS_REMARK,
       HRDI.CANCEL_REMARK                     AS DIS_CANCEL_REMARK,
       HRDI.CONTENTS                          AS DIS_CONTENTS,
       HRDI.DIS_TARGET                        AS DIS_TARGET,
       TO_CHAR(HRDI.START_DATE, 'YYYY-MM-DD') AS DIS_START_DATE,
       TO_CHAR(HRDI.END_DATE, 'YYYY-MM-DD')   AS DIS_END_DATE
  FROM HR_DISPATCH         HRDI,
       HR_EMPLOYEE         HRE,
       SY_CODE             A,
       SY_CODE             B
 WHERE HRDI.EMPID = HRE.EMPID(+)
   AND HRDI.TRANS_CODE = A.CODE_ID(+)
   AND HRDI.DIS_TYPE_CODE = B.CODE_ID(+);

prompt
prompt Creating view HR_DOC_INFO_V
prompt ===========================
prompt
CREATE OR REPLACE FORCE VIEW HR_DOC_INFO_V AS
SELECT A.EMPID,
       A.DOC_TYPE_CODE AS DOC_TYPE_CODE,
       B.CODE_NAME     AS DOC_TYPE_NAME,
       B.CODE_EN_NAME  AS DOC_TYPE_EN_NAME,
       A.DOC_ID    AS DOC_ID,
       A.SIGN_DEPT AS DOC_SIGN_DEPT,
       A.CONTENT   AS DOC_CONTENT,
       A.ADDRESS   AS DOC_ADDRESS,
       A.GRADE     AS DOC_GRADE,
       TO_CHAR(A.OBTAINED_DATE, 'YYYY-MM-DD') AS DOC_OBTAINED_DATE,
       TO_CHAR(A.START_DATE, 'YYYY-MM-DD')    AS DOC_START_DATE,
       TO_CHAR(A.END_DATE, 'YYYY-MM-DD')      AS DOC_END_DATE,
       A.REMARK    AS DOC_REMARK
  FROM HR_DOCUMENT A,SY_CODE B
 WHERE A.DOC_TYPE_CODE = B.CODE_ID(+);

prompt
prompt Creating view HR_EDUCATION_V
prompt ============================
prompt
CREATE OR REPLACE FORCE VIEW HR_EDUCATION_V AS
SELECT HRE.EMPID,
       A.MAJOR_CODE    AS EDU_MAJOR_CODE,
       B.CODE_NAME     AS EDU_MAJOR_NAME,
       B.CODE_EN_NAME  AS EDU_MAJOR_EN_NAME,
       A.DEGREE_CODE   AS EDU_DEGREE_CODE,
       C.CODE_NAME     AS EDU_DEGREE_NAME,
       C.CODE_EN_NAME  AS EDU_DEGREE_EN_NAME,
       A.EDU_HIS_CODE  AS EDU_EDU_HIS_CODE,
       D.CODE_NAME     AS EDU_EDU_HIS_NAME,
       D.CODE_EN_NAME  AS EDU_EDU_HIS_EN_NAME,
       A.INSTITUTION_NAME AS EDU_INSTITUTION_NAME,
       A.CONTENT          AS EDU_CONTENT,
       A.ADDRESS          AS EDU_ADDRESS,
       A.GRADE            AS EDU_GRADE,
       TO_CHAR(A.START_DATE, 'YYYY-MM-DD') AS EDU_START_DATE,
       TO_CHAR(A.END_DATE, 'YYYY-MM-DD')   AS EDU_END_DATE,
       A.REMARK                            AS EDU_REMARK
  FROM HR_EDUCATION A, HR_EMPLOYEE HRE, SY_CODE B, SY_CODE C, SY_CODE D
 WHERE A.EMPID = HRE.EMPID(+)
   AND A.MAJOR_CODE = B.CODE_ID(+)
   AND A.DEGREE_CODE = C.CODE_ID(+)
   AND A.EDU_HIS_CODE = D.CODE_ID(+);

prompt
prompt Creating view HR_EMPLOYEE_TREE_V
prompt ================================
prompt
CREATE OR REPLACE FORCE VIEW HR_EMPLOYEE_TREE_V AS
SELECT DISTINCT hre.empid, hre.chinesename, dept.deptname, dept.cpny_id,
                dept.dept_level, dept.deptid, parent_dept_id,ENGLISHNAME,DEPT_EN_NAME
FROM hr_employee hre, hr_department dept
WHERE hre.deptid(+) = dept.deptid
               AND (hre.status_code <> 'EmpStatus3' OR hre.status_code IS NULL
                   )
        START WITH dept_level = 1
        CONNECT BY PRIOR dept.deptid = parent_dept_id
          ORDER  BY dept.deptid;

prompt
prompt Creating view HR_EMP_PA_INFO_V
prompt ==============================
prompt
CREATE OR REPLACE FORCE VIEW HR_EMP_PA_INFO_V AS
SELECT HREPI.EMPID,
       HREPI.COST_CENTER,
       HREPI.VENDER_CODE,
       D.CODE_NAME VENDER_NAME,
       D.CODE_EN_NAME VENDER_EN_NAME,
       HREPI.BANK_CODE,
       A.CODE_NAME BANK_NAME,
       A.CODE_EN_NAME BANK_EN_NAME,
       HREPI.BANK_AREA_CODE,
       B.CODE_NAME BANK_AREA_NAME,
       B.CODE_EN_NAME BANK_AREA_EN_NAME,
       HREPI.BANK_CITY_CODE,
       C.CODE_NAME BANK_CITY_NAME,
       C.CODE_EN_NAME BANK_CITY_EN_NAME,
       HREPI.CARD_NO,
       HREPI.CARD_NAME,
       HREPI.CALC_FLAG,
       DECODE(CALC_FLAG, 'Y', '是', '否') AS CALC_FLAG_NAME,
       DECODE(CALC_FLAG, 'Y', 'Yes', 'No') AS CALC_FLAG_EN_NAME
  FROM HR_EMPLOYEE    HRE,
       HR_EMP_PA_INFO HREPI,
       SY_CODE        A,
       SY_CODE        B,
       SY_CODE        C,
       SY_CODE        D
 WHERE HRE.EMPID = HREPI.EMPID(+)
   AND HREPI.BANK_CODE = A.CODE_ID(+)
   AND HREPI.BANK_AREA_CODE = B.CODE_ID(+)
   AND HREPI.BANK_CITY_CODE = C.CODE_ID(+)
   AND HREPI.VENDER_CODE = D.CODE_ID(+);

prompt
prompt Creating view HR_ENDCONTRACT_V
prompt ==============================
prompt
CREATE OR REPLACE FORCE VIEW HR_ENDCONTRACT_V AS
SELECT HC.EMPID,CHINESENAME,HD.DEPTNAME,START_CONTRACT_DATE,END_CONTRACT_DATE FROM HR_CONTRACT HC,HR_EMPLOYEE HE,HR_DEPARTMENT HD WHERE 
HC.EMPID = HE.EMPID AND HE.DEPTID = HD.DEPTID;

prompt
prompt Creating view HR_FAMILY_V
prompt =========================
prompt
CREATE OR REPLACE FORCE VIEW HR_FAMILY_V AS
SELECT HRF.EMPID,
       HRF.FAM_TYPE_CODE,
       C.CODE_NAME FAM_TYPE_NAME,
       C.CODE_EN_NAME FAM_TYPE_EN_NAME,
       HRF.FAM_NAME,
       TO_CHAR(HRF.FAM_BORNDATE,'YYYY-MM-DD') FAM_BORNDATE,
       HRF.FAM_IDCARD,
       HRF.FAM_EDU_HIS_CODE AS FAM_EDU_HIS_CODE,
       D.CODE_EN_NAME       AS FAM_EDU_HIS_EN_NAME,
       D.CODE_NAME          AS FAM_EDU_HIS_NAME,
       HRF.FAM_OCCUP_CODE,
       E.CODE_EN_NAME AS FAM_OCCUP_EN_NAME,
       E.CODE_NAME    AS FAM_OCCUP_NAME,
       HRF.FAM_NATIONALITY_CODE,
       F.CODE_EN_NAME FAM_NATIONALITY_EN_NAME,
       F.CODE_NAME FAM_NATIONALITY_NAME,
       HRF.FAM_HOME_ADDR,
       HRF.FAM_PHONE,
       HRF.FAM_COMPANY_NAME,
       HRF.FAM_POSITION,
       HRF.REMARK,
       HRF.LIVE_YN YN_ID,
       G.CODE_EN_NAME YN_EN_NAME,
       G.CODE_NAME YN_NAME
  FROM HR_FAMILY   HRF,
       HR_EMPLOYEE HRE,
       SY_CODE     C,
       SY_CODE     D,
       SY_CODE     E,
       SY_CODE     F,
       SY_CODE     G
 WHERE HRF.EMPID = HRE.EMPID(+)
   AND HRF.FAM_TYPE_CODE = C.CODE_ID(+)
   AND HRF.FAM_EDU_HIS_CODE = D.CODE_ID(+)
   AND HRF.FAM_OCCUP_CODE = E.CODE_ID(+)
   AND HRF.FAM_NATIONALITY_CODE = F.CODE_ID(+)
   AND HRF.LIVE_YN = G.CODE_ID(+)
	 AND C.PARENT_CODE = 'RelationalTypeCode';

prompt
prompt Creating view HR_HEALTH_V
prompt =========================
prompt
CREATE OR REPLACE FORCE VIEW HR_HEALTH_V AS
SELECT HRE.EMPID,
       HRH.PMH,
       HRH.CHECK_YN_CODE AS HEALTH_CHECK_YN_CODE,
       A.CODE_NAME AS HEALTH_CHECK_YN_NAME,
       A.CODE_EN_NAME AS HEALTH_CHECK_YN_EN_NAME,
       HRH.CHECK_RESULT_CODE AS HEALTH_CHECK_RESULT_CODE,
       B.CODE_NAME AS HEALTH_CHECK_RESULT_NAME,
       B.CODE_EN_NAME AS HEALTH_CHECK_RESULT_EN_NAME,
       HRH.DESCRIPTION AS HEALTH_DESCRIPTION,
       TO_CHAR(HRH.PHYSICAL_DATE, 'YYYY-MM-DD') AS HEALTH_PHYSICAL_DATE,
       HRH.HEIGHT,
       HRH.WEIGHT,
       HRH.SHOULDER_BREADTH,
       HRH.SLEEVE_LENGTH,
       HRH.COAT_LENGTH,
       HRH.BUST,
       HRH.WAIST,
       HRH.HIP,
       HRH.TROUSERS_LENGTH,
       HRH.SKIRT_LENGTH,
       HRH.SHOE_SIZE,
       HRH.L_EYE_UCVA,
       HRH.L_EYE_CVA,
       HRH.L_EYE_DISEASE,
       HRH.R_EYE_UCVA,
       HRH.R_EYE_CVA,
       HRH.R_EYE_DISEASE,
       HRH.COLOR_VISION_CODE,
       D.CODE_NAME AS COLOR_VISION_NAME,
       D.CODE_EN_NAME AS COLOR_VISION_EN_NAME,
       HRH.L_EAR_AUDIBILITY,
       HRH.L_EAR_DISEASE,
       HRH.R_EAR_AUDIBILITY,
       HRH.R_EAR_DISEASE,
       HRH.L_NOSE,
       HRH.R_NOSE,
       HRH.OLFACTORY_CODE,
       F.CODE_NAME AS OLFACTORY_NAME,
       F.CODE_EN_NAME AS OLFACTORY_EN_NAME,
       HRH.BREATH,
       HRH.SPHYGMUS,
       HRH.BLOOD_PRESSURE_MIX,
       HRH.BLOOD_PRESSURE_MAX,
       HRH.CBC,
       HRH.BLOOD_TYPE_CODE,
       C.CODE_NAME AS BLOOD_TYPE_NAME,
       C.CODE_EN_NAME AS BLOOD_TYPE_EN_NAME,
       HRH.RH RH_TYPE_CODE,
       E.CODE_NAME AS RH_TYPE_NAME,
       E.CODE_EN_NAME AS RH_TYPE_EN_NAME,
       HRH.GROWTH_AND_NUTRITION,
       HRH.BLOOD_SUGAR,
       HRH.OT,
       HRH.PT,
       HRH.HBSAG,
       HRH.HBS,
       HRH.HBEAG,
       HRH.HBE,
       HRH.HBC,
       HRH.ABDOMINAL_CHECK,
       HRH.REMARK AS HEALTH_REMARK
  FROM HR_HEALTH   HRH,
       HR_EMPLOYEE HRE,
       SY_CODE     A,
       SY_CODE     B,
       SY_CODE     C,
       SY_CODE     D,
       SY_CODE     E,
       SY_CODE     F
 WHERE HRH.EMPID = HRE.EMPID(+)
   AND HRH.CHECK_YN_CODE = A.CODE_ID(+)
   AND HRH.CHECK_RESULT_CODE = B.CODE_ID(+)
   AND HRH.BLOOD_TYPE_CODE = C.CODE_ID(+)
   AND HRH.COLOR_VISION_CODE = D.CODE_ID(+)
   AND HRH.RH = E.CODE_ID(+)
   AND HRH.OLFACTORY_CODE = F.CODE_ID(+);

prompt
prompt Creating view HR_LANGUAGE_LEVEL_V
prompt =================================
prompt
CREATE OR REPLACE FORCE VIEW HR_LANGUAGE_LEVEL_V AS
SELECT A.EMPID,
       A.LANGUAGE_TYPE_CODE,
       C.CODE_NAME     AS LANGUAGE_TYPE_NAME,
       C.CODE_EN_NAME  AS LANGUAGE_TYPE_EN_NAME,
       A.EXAM_TYPE_CODE,
       D.CODE_NAME    AS LANGUAGE_EXAM_TYPE_NAME,
       D.CODE_EN_NAME AS LANGUAGE_EXAM_TYPE_EN_NAME,
       A.LANGUAGE_LEVEL_CODE,
       E.CODE_NAME    AS LANGUAGE_LEVEL_NAME,
       E.CODE_EN_NAME AS LANGUAGE_LEVEL_EN_NAME,
       A.MARK AS LANGUAGE_MARK,
       TO_CHAR(A.DATE_OBTAINED, 'YYYY-MM-DD') AS LANGUAGE_OPEN_DATE,
       A.LANGUAGE_LOCATION,
       A.LANGUAGE_CARD_NO,
       A.LAN_INSTITUTE AS LANGUAGE_INSTITUTE,
       A.DESCRIPTION   AS LANGUAGE_DESCRIPTION,
       A.REMARK        AS LANGUAGE_REMARK
  FROM HR_LANGUAGE_LEVEL A,
       HR_EMPLOYEE       HRE,
       SY_CODE           C,
       SY_CODE           D,
       SY_CODE           E
 WHERE A.EMPID = HRE.EMPID(+)
   AND A.LANGUAGE_TYPE_CODE = C.CODE_ID(+)
   AND A.EXAM_TYPE_CODE = D.CODE_ID(+)
   AND A.LANGUAGE_LEVEL_CODE = E.CODE_ID(+);

prompt
prompt Creating view HR_OTHERRELATION_V
prompt ================================
prompt
CREATE OR REPLACE FORCE VIEW HR_OTHERRELATION_V AS
SELECT HRF.EMPID,
       HRF.FAM_TYPE_CODE AS O_FAM_TYPE_CODE,
       C.CODE_NAME       AS O_FAM_TYPE_NAME,
       C.CODE_EN_NAME    AS O_FAM_TYPE_EN_NAME,
       HRF.FAM_NAME      AS O_FAM_NAME,
       HRF.FAM_PHONE     AS O_FAM_PHONE,
       HRF.REMARK        AS O_REMARK
  FROM HR_EMPLOYEE HRE,
       HR_FAMILY   HRF,
       SY_CODE     C
 WHERE HRE.EMPID = HRF.EMPID(+)
   AND HRF.FAM_TYPE_CODE = C.CODE_ID(+)
   AND C.PARENT_CODE = 'OtherRelation';


prompt
prompt Creating view HR_QUALIFICATION_V
prompt ================================
prompt
CREATE OR REPLACE FORCE VIEW HR_QUALIFICATION_V AS
SELECT HRE.EMPID,
       A.QUAL_TYPE_CODE AS QUAL_TYPE_CODE,
       C.CODE_NAME      AS QUAL_TYPE_NAME,
       C.CODE_EN_NAME   AS QUAL_TYPE_EN_NAME,
       A.QUAL_GRADE_CODE AS QUAL_GRADE_CODE,
       D.CODE_NAME       AS QUAL_GRADE_NAME,
       D.CODE_EN_NAME    AS QUAL_GRADE_EN_NAME,
       A.MARK            AS QUAL_MARK,
       A.QUAL_CARD_NO    AS QUAL_CARD_NO,
       A.QUAL_LOCATION   AS QUAL_LOCATION,
       TO_CHAR(A.DATE_OBTAINED, 'YYYY-MM-DD')   AS QUAL_OPEN_DATE,
       TO_CHAR(A.START_QUAL_DATE, 'YYYY-MM-DD') AS QUAL_START_DATE,
       TO_CHAR(A.END_QUAL_DATE, 'YYYY-MM-DD')   AS QUAL_END_DATE,
       A.QUAL_INSTITUTE AS QUAL_INSTITUTE,
       A.DESCRIPTION    AS QUAL_DESCRIPTION,
       A.REMARK         AS QUAL_REMARK
  FROM HR_QUALIFICATION A, HR_EMPLOYEE HRE, SY_CODE C, SY_CODE D
 WHERE A.EMPID = HRE.EMPID(+)
   AND A.QUAL_TYPE_CODE = C.CODE_ID(+)
   AND A.QUAL_GRADE_CODE = D.CODE_ID(+);

prompt
prompt Creating view HR_RESIGNATION_V
prompt ==============================
prompt
CREATE OR REPLACE FORCE VIEW HR_RESIGNATION_V AS
SELECT HRE.EMPID,
       HRR.TRANS_CODE  AS RESIGN_TRANS_CODE,
       A.CODE_NAME     AS RESIGN_TRANS_NAME,
       A.CODE_EN_NAME  AS RESIGN_TRANS_EN_NAME,
       HRR.REMARK           AS RESIGN_REMARK,
       HRR.CANCEL_REMARK    AS RESIGN_CANCEL_REMARK,
       HRR.RESIGN_FINE      AS RESIGN_FINE,
       HRR.RESIGN_REASON    AS RESIGN_REASON,
       HRR.RESIGN_TYPE_CODE AS RESIGN_TYPE_CODE,
       B.CODE_NAME          AS RESIGN_TYPE_NAME,
       B.CODE_EN_NAME       AS RESIGN_TYPE_EN_NAME,
       TO_CHAR(HRR.RESIGN_DATE, 'YYYY-MM-DD') AS RESIGN_DATE
  FROM HR_RESIGNATION     HRR,
       HR_EMPLOYEE         HRE,
       SY_CODE             A,
       SY_CODE             B
 WHERE HRR.EMPID = HRE.EMPID(+)
   AND HRR.TRANS_CODE = A.CODE_ID(+)
   AND HRR.RESIGN_TYPE_CODE = B.CODE_ID(+);

prompt
prompt Creating view HR_REWARD_V
prompt =========================
prompt
CREATE OR REPLACE FORCE VIEW HR_REWARD_V AS
SELECT HRE.EMPID,
       HRR.TRANS_CODE              AS REWARD_TRANS_CODE,
       A.CODE_NAME                 AS REWARD_TRANS_NAME,
       A.CODE_EN_NAME              AS REWARD_TRANS_EN_NAME,
       HRR.REMARK                  AS REWARD_REMARK,
       HRR.CANCEL_REMARK           AS REWARD_CANCEL_REMARK,
       HRR.REWARD_CONTENTS         AS REWARD_CONTENTS,
       HRR.REWARD_TYPE_CODE        AS REWARD_TYPE_CODE,
       B.CODE_NAME                 AS REWARD_TYPE_NAME,
       B.CODE_EN_NAME              AS REWARD_TYPE_EN_NAME,
       HRR.REWARD_SORT_CODE        AS REWARD_SORT_CODE,
       C.CODE_NAME                 AS REWARD_SORT_NAME,
       C.CODE_EN_NAME              AS REWARD_SORT_EN_NAME,
       HRR.ACHIEVEMENT_TYPE_CODE   AS REWARD_ACH_TYPE_CODE,
       D.CODE_NAME                 AS REWARD_ACH_TYPE_NAME,
       D.CODE_EN_NAME              AS REWARD_ACH_TYPE_EN_NAME,
       HRR.REWARD_GRADE_CODE       AS REWARD_GRADE_CODE,
       E.CODE_NAME                 AS REWARD_GRADE_NAME,
       E.CODE_EN_NAME              AS REWARD_GRADE_EN_NAME,
       HRR.REWARD_AMOUNT           AS REWARD_AMOUNT,
       HRR.REWARD_BONUS            AS REWARD_BONUS,
       TO_CHAR(HRR.REWARD_DATE, 'YYYY-MM-DD') AS REWARD_DATE
  FROM HR_REWARD   HRR,
       HR_EMPLOYEE HRE,
       SY_CODE     A,
       SY_CODE     B,
       SY_CODE     C,
       SY_CODE     D,
       SY_CODE     E
 WHERE HRR.EMPID = HRE.EMPID(+)
   AND HRR.TRANS_CODE = A.CODE_ID(+)
   AND HRR.REWARD_TYPE_CODE = B.CODE_ID(+)
   AND HRR.REWARD_SORT_CODE = C.CODE_ID(+)
   AND HRR.ACHIEVEMENT_TYPE_CODE = D.CODE_ID(+)
   AND HRR.REWARD_GRADE_CODE = E.CODE_ID(+);

prompt
prompt Creating view HR_STUDYING_V
prompt ===========================
prompt
CREATE OR REPLACE FORCE VIEW HR_STUDYING_V
(seq_study_no, trans_id, studying_type_code, studyname, research_type_code, researchtype, transsortno, transfer_sort, transfertypeno, transfer_type, empid, subject_code, subject_name, country_code, country_name, degree_code, degree_name, institutionname, expense, startdate, enddate, period, studycontents, createdate, creatorid, modifydate, modifierid, activity)
AS
SELECT   hs.study_no, hs.trans_no AS trans_no, hs.studying_type_code,
            scstudy.code_name AS studyname, hs.research_type_code,
            scrsch.code_name AS researchtype, scsort.code_id,
            scsort.code_name AS transfer_sort, hs.trans_code,
            sctype.code_name AS transfer_type, hs.empid, hs.subject,
            scsub.code_name AS subject_name, hs.country,
            sccon.code_name AS country_name, hs.degree_code,
            scdeg.code_name AS degree_name, hs.institution_name, hs.expense,
            hs.start_date, hs.end_date, hs.period AS period,
            hs.study_contents, hs.create_date, hs.created_by, hs.update_date,
            hs.updated_by, hs.activity
       FROM HR_STUDYING hs,
            SY_CODE scrsch,
            SY_CODE scstudy,
            SY_CODE scsort,
            SY_CODE scsub,
            SY_CODE sccon,
            SY_CODE scdeg,
            SY_CODE sctype
      WHERE hs.trans_code = sctype.code_id
        AND sctype.parent_code = scsort.code_id(+)
        AND hs.studying_type_code = scstudy.code_id(+)
        AND hs.research_type_code = scrsch.code_id(+)
        AND hs.subject = scsub.code_id(+)
        AND hs.country = sccon.code_id(+)
        AND hs.degree_code = scdeg.code_id(+)
   ORDER BY hs.start_date DESC;

prompt
prompt Creating view HR_STUDYING_VR
prompt ============================
prompt
CREATE OR REPLACE FORCE VIEW HR_STUDYING_VR AS
SELECT SEQ_STUDY_NO,TRANS_ID,STUDYNAME,RESEARCHTYPE,TRANSSORTNO,TRANSFER_SORT,TRANSFERTYPENO,TRANSFER_TYPE,EMPID,
SUBJECT_NAME,COUNTRY_NAME,DEGREE_NAME,INSTITUTIONNAME,EXPENSE,STARTDATE,ENDDATE,PERIOD,STUDYCONTENTS,CREATEDATE,CREATORID,MODIFYDATE,MODIFIERID,ACTIVITY ,
NVL(STARTDATE,TO_DATE('00010101','yyyymmdd')) ORDTEMP,
NVL(STUDYNAME,RESEARCHTYPE) Study_NAME
FROM HR_STUDYING_V a WHERE seq_study_no IN ( SELECT seq_study_no FROM (SELECT seq_study_no,STARTDATE,empid ,
NVL(STARTDATE,TO_DATE('00010101','yyyymmdd')) ORDTEMP FROM
HR_STUDYING_V  ORDER BY ORDTEMP DESC) b WHERE ROWNUM<4 AND a.empid=b.empid) ORDER BY ORDTEMP DESC;

prompt
prompt Creating view HR_SUSPENSION_V
prompt =============================
prompt
CREATE OR REPLACE FORCE VIEW HR_SUSPENSION_V
(suspend_no, trans_no, sort_code, sort_name, trans_code, trans_name, suspend_type_code, suspend_type, empid, chinesename, start_date, end_date, suspend_reason, create_date, created_by, update_date, updated_by, orderno, activity)
AS
SELECT HS.suspend_no,
       HS.TRANS_NO,
    scsort.code_id,
       scsort.code_name AS transfer_sort,
    hs.trans_code,
       sctype.code_name AS transfer_type,
    HS.suspend_type_code,
      sy1.code_name AS suspend_type,
       hre.empid,
     hre.chinesename,
  TO_CHAR(HS.start_date,'YYYY-MM-DD')start_date,
  TO_CHAR(HS.end_date,'YYYY-MM-DD')end_date,
  HS.suspend_reason,
       TO_CHAR(HS.create_date,'YYYY-MM-DD')create_date,
    HS.created_by,
    TO_CHAR(HS.update_date,'YYYY-MM-DD')update_date,
    HS.updated_by,
    HS.orderno,
       HS.activity
  FROM HR_EMPLOYEE hre, HR_SUSPENSION HS, SY_CODE sy1,SY_CODE scsort,SY_CODE sctype
 WHERE hre.empid = HS.empid
     AND sy1.code_id(+) = HS.suspend_type_code
    AND HS.TRANS_CODE(+)=sctype.CODE_ID
    AND sctype.PARENT_CODE(+)=scsort.CODE_ID;

prompt
prompt Creating view HR_SUSPENSION_POST_VR
prompt ===================================
prompt
CREATE OR REPLACE FORCE VIEW HR_SUSPENSION_POST_VR
(seq_susp_no, trans_id, transsortno, transfer_sort, transfertypeno, transfer_type, empid, suspendedtype, suspendedstartdate, suspendedenddate, suspendedreason, createdate, creatorid, modifydate, modifierid, activity)
AS
SELECT SUSPEND_NO,TRANS_NO,SORT_CODE,SORT_NAME,TRANS_CODE,TRANS_NAME,EMPID,SUSPEND_TYPE,
START_DATE,END_DATE,SUSPEND_REASON,CREATE_DATE,CREATED_BY,UPDATE_DATE,UPDATED_BY,ACTIVITY
FROM hr_suspension_v a WHERE SUSPEND_NO IN (SELECT SUSPEND_NO FROM (SELECT SUSPEND_NO,empid,START_DATE FROM
HR_SUSPENSION ORDER BY START_DATE DESC) b WHERE ROWNUM<3 AND a.empid=b.empid)  ORDER BY START_DATE DESC;

prompt
prompt Creating view HR_SUSPENSION_VR
prompt ==============================
prompt
CREATE OR REPLACE FORCE VIEW HR_SUSPENSION_VR
(seq_susp_no, trans_id, transsortno, transfer_sort, transfertypeno, transfer_type, empid, suspendedtype, suspendedstartdate, suspendedenddate, suspendedreason, createdate, creatorid, modifydate, modifierid, activity)
AS
SELECT SUSPEND_NO,TRANS_NO,SORT_CODE,SORT_NAME,TRANS_CODE,TRANS_NAME,EMPID,SUSPEND_TYPE,
START_DATE,END_DATE,SUSPEND_REASON,CREATE_DATE,CREATED_BY,UPDATE_DATE,UPDATED_BY,ACTIVITY 
FROM hr_suspension_v a WHERE SUSPEND_NO IN (SELECT SUSPEND_NO FROM (SELECT SUSPEND_NO,empid,START_DATE FROM
HR_SUSPENSION ORDER BY START_DATE DESC) b WHERE ROWNUM<4 AND a.empid=b.empid)  ORDER BY START_DATE DESC;

prompt
prompt Creating view HR_TRAINING_OUTSIDE_V
prompt ===================================
prompt
CREATE OR REPLACE FORCE VIEW HR_TRAINING_OUTSIDE_V AS
SELECT HRTO.EMPID,
       HRTO.COURSE_NAME AS HR_T_OUTSIDE_COURSE_NAME,
       TO_CHAR(HRTO.START_DATE, 'YYYY-MM-DD') AS HR_T_OUTSIDE_START_DATE,
       TO_CHAR(HRTO.END_DATE, 'YYYY-MM-DD')   AS HR_T_OUTSIDE_END_DATE,
       HRTO.DESCRIPTION AS HR_T_OUTSIDE_DESCRIPTION,
       HRTO.REMARK AS HR_T_OUTSIDE_REMARK
  FROM HR_TRAINING_OUTSIDE HRTO
 WHERE 1 = 1;

prompt
prompt Creating view HR_UPGRADE_V
prompt ==========================
prompt
CREATE OR REPLACE FORCE VIEW HR_UPGRADE_V AS
SELECT u.upgrade_type_id, ui.upgrade_type AS upgrade_type, hre.empid,
          hre.chinesename, u.prev_grade_code, sy1.code_name AS prev_grade,
          u.current_grade_code, sy2.code_name AS current_grade,
          u.available_from_date, u.available_to_date, u.create_date,
          u.created_by, u.update_date, u.updated_by, u.orderno, u.activity
     FROM hr_employee hre,
          hr_upgrade_history u,
          hr_upgrade_info ui,
          sy_code sy1,
          sy_code sy2
    WHERE hre.empid = u.empid
      AND u.upgrade_type_id = ui.upgrade_type_id
      AND sy1.code_id(+) = u.prev_grade_code
      AND sy2.code_id(+) = u.current_grade_code;

prompt
prompt Creating view HR_WORK_EXPERIENCE_V
prompt ==================================
prompt
CREATE OR REPLACE FORCE VIEW HR_WORK_EXPERIENCE_V AS
SELECT EMPID,
       CPNY_NAME  AS WORK_EXPER_CPNY_NAME,
       DEPT_NAME  AS WORK_EXPER_DEPT_NAME,
       POSITION   AS WORK_EXPER_POSITION,
       LEAVE_REASON AS WORK_EXPER_LEAVE_REASON,
       WORK_CONTENT AS WORK_EXPER_WORK_CONTENT,
       POST         AS WORK_EXPER_POST,
       GRADE        AS WORK_EXPER_GRADE,
       TO_CHAR(START_DATE, 'YYYY-MM-DD') AS WORK_EXPER_START_DATE,
       TO_CHAR(END_DATE, 'YYYY-MM-DD')   AS WORK_EXPER_END_DATE
  FROM HR_WORK_EXPERIENCE A
 WHERE 1 = 1;

prompt
prompt Creating view HR_WORK_HISTORY_VR
prompt ================================
prompt
CREATE OR REPLACE FORCE VIEW HR_WORK_HISTORY_VR
(seq_work_exper_no, empid, company, prevdept, prevposition, prevpost, prevgrade, startdate, leavereason, enddate, createdate, creatorid, ordtemp, work_content, modifydate, modifierid, activity)
AS
SELECT   work_exper_no, empid, CPNY_NAME,dept_name, POSITION, POST, grade,
            TO_CHAR(start_date,'YYYY-MM-DD')start_date,
            LEAVE_REASON ,TO_CHAR(end_date,'YYYY-MM-DD')end_date, TO_CHAR(create_date,'YYYY-MM-DD')create_date, created_by,
            NVL (start_date, TO_DATE ('00010101', 'yyyymmdd')) ordtemp,work_content,
            TO_CHAR(update_date,'YYYY-MM-DD')update_date, updated_by, activity
       FROM HR_WORK_EXPERIENCE hwe
      WHERE work_exper_no IN (
               SELECT work_exper_no
                 FROM (SELECT   work_exper_no, empid, start_date,
                                NVL (start_date,
                                     TO_DATE ('00010101', 'yyyymmdd')
                                    ) ordtemp
                           FROM HR_WORK_EXPERIENCE
                       ORDER BY ordtemp DESC) b
                WHERE hwe.empid = b.empid AND ROWNUM < 4)
   ORDER BY ordtemp DESC;

prompt
prompt Creating view INFO_RESULT_VIEW
prompt ==============================
prompt
CREATE OR REPLACE FORCE VIEW INFO_RESULT_VIEW AS
SELECT empid, 'aa' aa
     FROM hr_employee;

prompt
prompt Creating view SY_ADMIN_V
prompt ========================
prompt
CREATE OR REPLACE FORCE VIEW SY_ADMIN_V AS
SELECT A.ADMINID,
       E.DEPTID,
       D.DEPTNAME,
       D.DEPT_EN_NAME,
       E.CHINESENAME,
       E.CHINESE_PINYIN,
       E.ENGLISHNAME,
       P.GENDER_CODE,
       A.ADMINLEVEL,
       A.USERNAME,
       A.PASSWORD,
       '0' AS LOGIN_TYPE,
       A.LOGIN_DEPTID,
       D.DEPTNAME AS LOGIN_DEPARTMENT,
       A.SCREEN_GRANT_ID,
       A.CREATE_DATE,
       A.CREATED_BY,
       A.UPDATE_DATE,
       A.UPDATED_BY,
       A.ORDERNO,
       A.ACTIVITY,
       A.CPNY_ID,
       A.ACCOUNT_TYPE,
       HC.CPNY_NAME COMPANY_NAME,
       E.STATUS_CODE STATUS_CODE,
       '' AS CHANNEL_ID,
       '' AS Contact_Name,
       '' AS CHANNEL_NAME
  FROM HR_EMPLOYEE E, SY_ADMIN A, HR_DEPARTMENT D, HR_PERSONAL_INFO P,HR_COMPANY HC
 WHERE A.ADMINID = E.EMPID(+)
   AND A.CPNY_ID = E.CPNY_ID(+)
   AND A.CPNY_ID = HC.CPNY_ID(+)
   AND E.DEPTID = D.DEPTID(+)
   AND E.CPNY_ID = D.CPNY_ID(+)
   AND E.EMPID = P.EMPID(+)
   AND E.CPNY_ID = P.CPNY_ID(+);

prompt
prompt Creating view ORDER_INFO_REPORT_V
prompt =================================
prompt
CREATE OR REPLACE FORCE VIEW ORDER_INFO_REPORT_V AS
SELECT   OROI.ORDER_ID                                                  ORDER_ID,
               PROBI.PRODUCT_NAME                                             PRODUCT_NAME,
               OROI.ORD_TYPE_CODE                                             ORD_TYPE_CODE,
               E.CODE_NAME                                                    ORDER_TYPE,
               E.CODE_EN_NAME                                                 ORDER_EN_TYPE,
               OROI.MONEY_PAID                                                MONEY_PAID,
               OROI.MONEY_TOTAL                                               MONEY_TOTAL,
               OROI.PRO_QUANTITY                                              PRO_QUANTITY,
               OROI.BUSI_DATE                                                 ORDER_DATE,
               OROI.STATUS_CODE                                               STATUS_CODE,
               A.CODE_NAME                                                    ORDER_STATE,
               A.CODE_EN_NAME                                                 ORDER_EN_STATE,
               SAVA.CHINESENAME                                               CREATED_BY,
               SAVA.ENGLISHNAME                                               CREATED_EN_BY,
               OROI.CREATED_DATE                                              CREATED_DATE,
               HREA.CHINESENAME                                               VERIFIED_BY,
               HREA.ENGLISHNAME                                               VERIFIED_EN_BY,
               OROI.VERIFIED_DATE                                             VERIFIED_DATE,
               SAVB.CHINESENAME                                               UPDATED_BY,
               SAVB.ENGLISHNAME                                               UPDATED_EN_BY,
               OROI.UPDATED_DATE                                              UPDATED_DATE,
               OROI.ORDERNO                                                   ORDERNO,
               OROI.ACTIVITY                                                  ACTIVITY,
               G.CODE_NAME
		           ||H.CODE_NAME
               ||I.CODE_NAME
               ||OROI.ADDRESS                                                   ADDRESS,
               DECODE(OROI.ORD_TYPE_CODE,'OrderType001',(SELECT CUBA.CUST_NAME FROM CUST_BASIC_INFO CUBA WHERE CUBA.CUST_ID = OROI.CUST_ID),
                                             'OrderType002',(SELECT CHBA.CHANNEL_NAME FROM CHA_BASIC_INFO CHBA WHERE CHBA.CHANNEL_ID = OROI.CHANNEL_ID),
                                             'OrderType003',(SELECT HRC.CPNY_NAME FROM HR_COMPANY HRC WHERE HRC.CPNY_ID = OROI.CPNY_ID),
                                             '')                                  PURCHASE_OBJECT,
               DECODE(OROI.ORD_TYPE_CODE,'OrderType001',(SELECT CUBAB.CUST_ID FROM CUST_BASIC_INFO CUBAB WHERE CUBAB.CUST_ID = OROI.CUST_ID),
                                             'OrderType002',(SELECT CHBAB.CHANNEL_ID FROM CHA_BASIC_INFO CHBAB WHERE CHBAB.CHANNEL_ID = OROI.CHANNEL_ID),
                                             'OrderType003',(SELECT HRCB.CPNY_ID FROM HR_COMPANY HRCB WHERE HRCB.CPNY_ID = OROI.CPNY_ID),
                                             '')                                  OBJECT_ID,
               OROI.APP_REMARK                                                APP_REMARK,
               OROI.DEL_REMARK                                                DEL_REMARK,
               OROI.REMARK                                                    REMARK,
               OROI.EMPID                                                     EMPID,
               OROI.CPNY_ID                                                   CPNY_ID
      FROM   ORD_ORDER_INFO   OROI,
           PRO_BASIC_INFO   PROBI,
           PRO_BUSINESS_INFO   PROBU,
               HR_EMPLOYEE      HREA,
           SY_CODE          A,
           SY_CODE          B,
           SY_CODE          C,
                   SY_CODE          D,
                   SY_CODE          E,
                   SY_CODE          G,
                   SY_CODE          H,
                   SY_CODE          I,
               SY_ADMIN_V      SAVA,
               SY_ADMIN_V      SAVB
      WHERE OROI.VERIFIED_BY = HREA.EMPID(+)
           AND OROI.PRODUCT_ID = PROBI.PRODUCT_ID(+)
           AND OROI.STATUS_CODE = A.CODE_ID(+)
           AND OROI.MONEY_PAID_UNIT_CODE = B.CODE_ID(+)
           AND OROI.MONEY_TOTAL_UNIT_CODE = C.CODE_ID(+)
                   AND OROI.PRICE_UNIT_CODE = D.CODE_ID(+)
                   AND OROI.ORD_TYPE_CODE = E.CODE_ID(+)
           AND OROI.ACTIVITY = 1
           AND PROBU.PRODUCT_ID = PROBI.PRODUCT_ID
           AND OROI.CREATED_BY = SAVA.ADMINID(+)
           AND OROI.UPDATED_BY = SAVB.ADMINID(+)
                 AND OROI.PROVINCE = G.CODE_ID(+)
           		   AND OROI.CITY = H.CODE_ID(+)
           		   AND OROI.AREA = I.CODE_ID(+);

prompt
prompt Creating view PAY_TENEMENT_ALLOWANCE_V
prompt ======================================
prompt
CREATE OR REPLACE FORCE VIEW PAY_TENEMENT_ALLOWANCE_V AS
SELECT "ALLOWANCE_NO","EMPID","DEPTID","POSITION_CODE","POST_GRADE_CODE","CONTRACT_START_DATE","CONTRACT_END_DATE","APPLY_START_DATE","APPLY_END_DATE","HOUSE_OWNER","IDCARD_NO","OFFICE_PHONE","RESIDE_NUMBER","PAY_ACCOUNT","CHUMMAGE_PAY_DATE","RENT","PAY_PERIOD","TENEMENT_ALLOWANCE","NUMERICAL_CEILING","WELFARE_START_DATE","WELFARE_END_DATE","APPLY_TIMES","PAY_MONTH","ADDRESS","REMARK","CREATE_DATE","CREATED_BY","UPDATE_DATE","UPDATED_BY","ACTIVITY","REMITTANCE" FROM  PAY_TENEMENT_ALLOWANCE;

prompt
prompt Creating view PA_BASIC_DATA_V
prompt =============================
prompt
CREATE OR REPLACE FORCE VIEW PA_BASIC_DATA_V AS
SELECT A.FIELD1_VALUE EMPID,
	   SUM(DECODE(A.ITEM_NO,42,A.RETURN_VALUE,0)) ANNUAL_SALARY,
	   SUM(DECODE(A.ITEM_NO,43,A.RETURN_VALUE,0)) INSURANCE_BASE,
	   SUM(DECODE(A.ITEM_NO,44,A.RETURN_VALUE,0)) MEDICARE_BASE,
	   SUM(DECODE(A.ITEM_NO,45,A.RETURN_VALUE,0)) HOUSING_FUND_BASE,
	   SUM(DECODE(A.ITEM_NO,121,A.RETURN_VALUE,0)) WORK_INJURY_BASE
  FROM PA_BASIC_DATA A
 WHERE A.ACTIVITY = 1
   AND A.ITEM_NO IN (42,43,44,45,121)
 GROUP BY A.FIELD1_VALUE;

prompt
prompt Creating view PA_BONUS_V
prompt ========================
prompt
CREATE OR REPLACE FORCE VIEW PA_BONUS_V AS
SELECT PBI.ITEM_NO,
       PBI.ITEM_ID,
       PBI.ITEM_NAME,
       PBI.ITEM_EN_NAME,
       PBI.CPNY_ID,
       '' PA_MONTH
  FROM PA_BONUS_ITEM PBI
 WHERE PBI.ACTIVITY = 1
 UNION
 SELECT PBPI.PARAM_NO      AS ITEM_NO,
        PBPI.PARAM_ID      AS ITEM_ID,
        PBPI.PARAM_NAME    AS ITEM_NAME,
        PBPI.PARAM_EN_NAME AS ITEM_EN_NAME,
        PBPI.CPNY_ID,
        PBPI.PA_MONTH
   FROM PA_BONUS_PARAM_ITEM PBPI
  WHERE PBPI.ACTIVITY = 1
 UNION
SELECT T.ID             AS ITEM_NO,
       T.DISTINCT_FIELD AS ITEM_ID,
       T.FIELD_NAME     AS ITEM_NAME,
       T.FIELD_EN_NAME  AS ITEM_EN_NAME,
       T.CPNY_ID,
       '' PA_MONTH
  FROM PA_DISTINCT_LIST T
 WHERE T.ACTIVITY = 1
   AND T.TABLE_NAME = 'PA_HR_V'
 UNION
SELECT PBI.ITEM_NO,
       PBI.ITEM_ID,
       PBI.ITEM_NAME,
       PBI.ITEM_EN_NAME,
       PBI.CPNY_ID,
       '' PA_MONTH
  FROM PA_BASIC_ITEM PBI
 WHERE PBI.ACTIVITY = 1
 UNION
SELECT PI.ITEM_NO,
       PI.ITEM_ID,
       PI.ITEM_NAME,
       PI.ITEM_EN_NAME,
       PI.CPNY_ID,
       '' PA_MONTH
  FROM PA_ITEM PI
 WHERE PI.ACTIVITY = 1
   AND PI.CALC_FLAG = 'Y'
 UNION
 SELECT 0 ITEM_NO,
        'BONUS_MONTH' ITEM_ID,
        '奖金月份' ITEM_NAME,
        'Bonus Month' ITEM_EN_NAME,
        'wooribank' CPNY_ID,
        '' PA_MONTH
  FROM dual
 UNION
 SELECT 0 ITEM_NO,
        'BONUS_FORMULAR_MONTH' ITEM_ID,
        '公式月份' ITEM_NAME,
        'Formula Month' ITEM_EN_NAME,
        'wooribank' CPNY_ID,
        '' PA_MONTH
  FROM dual
 UNION
 SELECT 0 ITEM_NO,
        'PA_MONTH' ITEM_ID,
        '工资月份' ITEM_NAME,
        'Wage Month' ITEM_EN_NAME,
        'wooribank' CPNY_ID,
        '' PA_MONTH
  FROM dual;

prompt
prompt Creating view PA_HR_V
prompt =====================
prompt
CREATE OR REPLACE FORCE VIEW PA_HR_V AS
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
       TO_CHAR(BIRTHDAY, 'YYYY-MM-DD') BIRTHDAY,
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
       TO_CHAR(WEDDING_DATE, 'YYYY-MM-DD') WEDDING_DATE,
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
              AND CALC_FLAG = 'Y'
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
            AND TO_DATE(TO_CHAR(HPR1.START_DATE,'YYYYMM'),'YYYYMM') <= TO_DATE(201401,'YYYYMM'))
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
   AND ( HRE.LEFT_DATE >= AR_GET_STARTDATE(201401)
   OR  HRE.LEFT_DATE IS NULL )
   AND HRE.JOIN_DATE <= AR_GET_ENDDATE(201401);

prompt
prompt Creating view PA_INS_V
prompt ======================
prompt
CREATE OR REPLACE FORCE VIEW PA_INS_V AS
SELECT PII.ITEM_NO,
       PII.ITEM_ID,
       PII.ITEM_NAME,
       PII.ITEM_EN_NAME,
       PII.CPNY_ID,
       '' PA_MONTH
  FROM PA_INS_ITEM PII
 WHERE PII.ACTIVITY = 1
 UNION
 SELECT PIPI.PARAM_NO      AS ITEM_NO,
        PIPI.PARAM_ID      AS ITEM_ID,
        PIPI.PARAM_NAME    AS ITEM_NAME,
        PIPI.PARAM_EN_NAME AS ITEM_EN_NAME,
        PIPI.CPNY_ID,
        PIPI.PA_MONTH
   FROM PA_INS_PARAM_ITEM PIPI
  WHERE PIPI.ACTIVITY = 1
 UNION
SELECT T.ID             AS ITEM_NO,
       T.DISTINCT_FIELD AS ITEM_ID,
       T.FIELD_NAME     AS ITEM_NAME,
       T.FIELD_EN_NAME  AS ITEM_EN_NAME,
       T.CPNY_ID,
       '' PA_MONTH
  FROM PA_DISTINCT_LIST T
 WHERE T.ACTIVITY = 1
   AND T.TABLE_NAME = 'PA_HR_V'
 UNION
 SELECT 0 ITEM_NO,
        'INS_MONTH' ITEM_ID,
        '保险月份' ITEM_NAME,
        'Bonus Month' ITEM_EN_NAME,
        'wooribank' CPNY_ID,
        '' PA_MONTH
  FROM dual
 UNION
 SELECT 0 ITEM_NO,
        'INS_FORMULAR_MONTH' ITEM_ID,
        '公式月份' ITEM_NAME,
        'Formula Month' ITEM_EN_NAME,
        'wooribank' CPNY_ID,
        '' PA_MONTH
  FROM dual
 UNION
 SELECT 0 ITEM_NO,
        'PA_MONTH' ITEM_ID,
        '工资月份' ITEM_NAME,
        'Wage Month' ITEM_EN_NAME,
        'wooribank' CPNY_ID,
        '' PA_MONTH
  FROM dual;

prompt
prompt Creating view PA_ITEM_INTO_V
prompt ============================
prompt
create or replace force view pa_item_into_v as
select t.item_name,t.item_id,'PA_HISTORY' names from pa_item t union
select t.item_name,t.item_id,'PA_HISTORY' names from pa_basic_item t union
select t.param_name,t.param_id,'PA_HISTORY' names from pa_param_item t;

prompt
prompt Creating view PA_UTIL_MAP
prompt =========================
prompt
create or replace force view pa_util_map as
select pi.item_id as ID,pi.item_name as name from pa_item pi
union
select distinct ppi.param_id ,ppi.param_name from pa_param_item ppi
union
select pdl.distinct_field ,pdl.field_name from pa_distinct_list pdl;

prompt
prompt Creating view PA_V
prompt ==================
prompt
CREATE OR REPLACE FORCE VIEW PA_V AS
SELECT PI.ITEM_NO,
       PI.ITEM_ID,
       PI.ITEM_NAME,
       PI.ITEM_EN_NAME,
       PI.CPNY_ID,
       '' PA_MONTH
  FROM PA_ITEM PI
 WHERE PI.ACTIVITY = 1
 UNION
 SELECT PPI.PARAM_NO      AS ITEM_NO,
        PPI.PARAM_ID      AS ITEM_ID,
        PPI.PARAM_NAME    AS ITEM_NAME,
        PPI.PARAM_EN_NAME AS ITEM_EN_NAME,
        PPI.CPNY_ID,
        PPI.PA_MONTH
   FROM PA_PARAM_ITEM PPI
  WHERE PPI.ACTIVITY = 1
 UNION
SELECT T.ID             AS ITEM_NO,
       T.DISTINCT_FIELD AS ITEM_ID,
       T.FIELD_NAME     AS ITEM_NAME,
       T.FIELD_EN_NAME  AS ITEM_EN_NAME,
       T.CPNY_ID,
       '' PA_MONTH
  FROM PA_DISTINCT_LIST T
 WHERE T.ACTIVITY = 1
   AND T.TABLE_NAME = 'PA_HR_V'
 UNION
SELECT T.ID             AS ITEM_NO,
       T.DISTINCT_FIELD AS ITEM_ID,
       T.FIELD_NAME     AS ITEM_NAME,
       T.FIELD_EN_NAME  AS ITEM_EN_NAME,
       T.CPNY_ID,
       '' PA_MONTH
  FROM PA_DISTINCT_LIST T
 WHERE T.ACTIVITY = 1
   AND T.TABLE_NAME = 'PA_AR_V'
 UNION
 SELECT PII.ITEM_NO,
       PII.ITEM_ID,
       PII.ITEM_NAME,
       PII.ITEM_EN_NAME,
       PII.CPNY_ID,
       '' PA_MONTH
  FROM PA_INS_ITEM PII
 WHERE PII.ACTIVITY = 1
 UNION
 SELECT PBI.ITEM_NO,
       PBI.ITEM_ID,
       PBI.ITEM_NAME,
       PBI.ITEM_EN_NAME,
       PBI.CPNY_ID,
       '' PA_MONTH
  FROM PA_BONUS_ITEM PBI
 WHERE PBI.ACTIVITY = 1
 UNION
 SELECT 0 ITEM_NO,
        'PA_MONTH' ITEM_ID,
        '工资月份' ITEM_NAME,
        'Bonus Month' ITEM_EN_NAME,
        'wooribank' CPNY_ID,
        '' PA_MONTH
  FROM dual
 UNION
 SELECT 0 ITEM_NO,
        'PA_FORMULAR_MONTH' ITEM_ID,
        '公式月份' ITEM_NAME,
        'Formula Month' ITEM_EN_NAME,
        'wooribank' CPNY_ID,
        '' PA_MONTH
  FROM dual;

prompt
prompt Creating view REPORT_ITEM_REFERENCE
prompt ===================================
prompt
CREATE OR REPLACE FORCE VIEW REPORT_ITEM_REFERENCE AS
SELECT DISTINCT T."TYPE_ID",
                T."TABLE_NAME",
                T."ORDER_NO",
                T."ITEM_NAME",
                T."ITEM_EN_NAME",
                T."ITEM_ID",
                T."DATA_TYPE"
FROM (
SELECT 'AR' AS TYPE_ID,
       'AR_HISTORY' AS TABLE_NAME,
       UTC.COLUMN_ID AS ORDER_NO,
       PDL.FIELD_NAME AS ITEM_NAME,
       PDL.FIELD_EN_NAME AS ITEM_EN_NAME,
       PDL.DISTINCT_FIELD AS ITEM_ID,
       UTC.DATA_TYPE
  FROM USER_TAB_COLUMNS UTC, PA_DISTINCT_LIST PDL
 WHERE UTC.COLUMN_NAME(+) = PDL.DISTINCT_FIELD
   AND UTC.TABLE_NAME = 'AR_HISTORY'
UNION
SELECT 'AR' AS TYPE_ID,
       'AR_HISTORY' AS TABLE_NAME,
       UTC.COLUMN_ID AS ORDER_NO,
       SUBSTR(ASI.ITEM_NAME,0,29) ITEM_NAME,
       SUBSTR(ASI.ITEM_EN_NAME,0,29) AS ITEM_EN_NAME,
       ASI.ITEM_ID AS ITEM_ID,
       UTC.DATA_TYPE
  FROM USER_TAB_COLUMNS UTC, AR_STA_ITEM ASI
 WHERE UTC.COLUMN_NAME(+) = ASI.ITEM_ID
   AND UTC.TABLE_NAME = 'AR_HISTORY'
UNION
 SELECT 'PA' AS TYPE_ID,
       'PA_HISTORY' AS TABLE_NAME,
       UTC.COLUMN_ID AS ORDER_NO,
       PPI.PARAM_NAME ITEM_NAME,
       PPI.PARAM_EN_NAME ITEM_EN_NAME,
       PPI.PARAM_ID AS ITEM_ID,
       UTC.DATA_TYPE
  FROM USER_TAB_COLUMNS UTC,  PA_PARAM_ITEM PPI
 WHERE UTC.COLUMN_NAME(+) = PPI.PARAM_ID
   AND UTC.TABLE_NAME = 'PA_HISTORY'
 UNION
SELECT 'PA' AS TYPE_ID,
       'PA_HISTORY' AS TABLE_NAME,
       UTC.COLUMN_ID AS ORDER_NO,
       SUBSTR( PBI.ITEM_NAME,0,29) ITEM_NAME,
       SUBSTR( PBI.ITEM_EN_NAME,0,29) ITEM_EN_NAME,
       PBI.ITEM_ID AS ITEM_ID,
       UTC.DATA_TYPE
  FROM USER_TAB_COLUMNS UTC, PA_BASIC_ITEM PBI
 WHERE UTC.COLUMN_NAME(+) = PBI.ITEM_ID
   AND UTC.TABLE_NAME = 'PA_HISTORY'
 UNION
SELECT 'PA' AS TYPE_ID,
       'PA_HISTORY' AS TABLE_NAME,
       UTC.COLUMN_ID AS ORDER_NO,
       SUBSTR( PI.ITEM_NAME,0,29) ITEM_NAME,
       SUBSTR( PI.ITEM_EN_NAME,0,29) ITEM_EN_NAME,
       PI.ITEM_ID,
       UTC.DATA_TYPE
  FROM USER_TAB_COLUMNS UTC, PA_ITEM PI
 WHERE UTC.COLUMN_NAME(+) = PI.ITEM_ID
   AND UTC.TABLE_NAME = 'PA_HISTORY'
 UNION
 SELECT 'PA' AS TYPE_ID,
        'PA_HISTORY' AS TABLE_NAME,
        0 AS ORDER_NO,
        '工资月' AS ITEM_NAME,
        'Salary Month' AS ITEM_EN_NAME,
        'PA_MONTH' AS ITEM_ID,
        'VARCHAR2' DATA_TYPE
       FROM DUAL
 UNION
 SELECT 'AR' AS TYPE_ID,
        'AR_HISTORY' AS TABLE_NAME,
        1 AS ORDER_NO,
        '考勤月' AS ITEM_NAME,
        'Attendance Month' AS ITEM_EN_NAME,
        'AR_MONTH' AS ITEM_ID,
        'VARCHAR2' DATA_TYPE
       FROM DUAL) T;

prompt
prompt Creating view SY_ADMIN_AS_CLIENT_V
prompt ==================================
prompt
CREATE OR REPLACE FORCE VIEW SY_ADMIN_AS_CLIENT_V AS
SELECT SYA.ADMINID ,
       CHCO.CHANNEL_ID,
       CHCO.CHA_CONTACT_ID,
       CHCO.CONTACT_NAME,
       CHCO.CONTACT_NAME AS CHINESENAME,
       CHCO.CONTACT_EN_NAME AS ENGLISHNAME,
       CHCO.GENDER_CODE,
       CHBA.CHANNEL_NAME,
       CHBA.LEFT_CREDIT,
       SYA.ADMINLEVEL,
       SYA.USERNAME,
       SYA.PASSWORD,
       SYA.SCREEN_GRANT_ID,
       SYA.CREATE_DATE,
       SYA.CREATED_BY,
       SYA.UPDATE_DATE,
       SYA.UPDATED_BY,
       SYA.ORDERNO,
       CHCO.ACTIVITY,
       CHCO.CPNY_ID,
       BPBU.BP_ID,
       HR_GET_COMPANY_NAMEBYEMPID(CHCO.CPNY_ID) COMPANY_NAME
  FROM CHA_BASIC_INFO CHBA, CHA_CONTACT_INFO CHCO, SY_ADMIN SYA, BP_BUSIPART_INFO BPBU
 WHERE SYA.ADMINID = CHCO.CHA_CONTACT_ID
   AND CHCO.CHANNEL_ID = CHBA.CHANNEL_ID
   AND CHBA.CHANNEL_ID = BPBU.BP_PARTNER_ID
   AND BPBU.ACTIVITY = 1
   AND CHCO.ACTIVITY = 1;

prompt
prompt Creating view SY_ADMIN_DEPTID_V
prompt ===============================
prompt
CREATE OR REPLACE FORCE VIEW SY_ADMIN_DEPTID_V AS
SELECT   s.admin_no, s.admin_deptid
       FROM sy_admin_deptid s, hr_department d
      WHERE d.deptid = s.admin_deptid
   ORDER BY s.admin_no;

prompt
prompt Creating view SY_ADMIN_DEPT_V
prompt =============================
prompt
CREATE OR REPLACE FORCE VIEW SY_ADMIN_DEPT_V AS
SELECT   sa.adminid, sad.admin_deptid AS deptid, deptname, dept_level
       FROM hr_dept_tree_v hdtv, sy_admin_deptid_v sad, sy_admin sa
      WHERE sad.admin_deptid = hdtv.deptid AND sad.admin_no = sa.adminno
   ORDER BY sad.admin_deptid;

prompt
prompt Creating view T_HR_EMPLOYEE_V
prompt =============================
prompt
CREATE OR REPLACE FORCE VIEW T_HR_EMPLOYEE_V AS
SELECT 工号, 姓名, 拼音, 部门,
    (SELECT DEPTID
       FROM HR_DEPARTMENT
   WHERE DEPTNAME = TRIM(部门) AND ROWNUM=1) AS deptid,
    员工状态,
    get_code_id (TRIM (员工状态), 'EmpStatus') status_code,
    入职类型,
    get_code_id (TRIM (入职类型), 'TransEnter') join_type_code,
    保险类型,
    get_code_id (TRIM (保险类型), 'InsuranceTpye') work_area,
    职位, 
    get_code_id (TRIM (职位), 'PositionCode') position_code,
       职务,
       (SELECT post_id
          FROM HR_POST
         WHERE post_name = TRIM (职务) AND ROWNUM = 1) AS post_code, 
    职级,
         (SELECT post_grade_id
             FROM HR_POST_GRADE
            WHERE post_grade_name = TRIM (职级)
              AND ROWNUM = 1) AS post_grade_id, 
    级号,
     (SELECT post_grade_level_id
             FROM HR_POST_GRADE_LEVEL
            WHERE post_grade_level_name = TRIM (级号)
              AND ROWNUM = 1) AS post_grade_level_id,
       TO_DATE (入社日期, 'YYYY-MM-DD') 入社日期, 
       TO_DATE (转正日期, 'YYYY-MM-DD') 转正日期,
       TO_DATE (退社日期, 'YYYY-MM-DD') 退社日期,
	   承认工龄,
	   员工区分,
	   get_code_id (TRIM (员工区分), 'EmpDivision') emp_type_code
  FROM T_HR_EMPLOYEE;

prompt
prompt Creating view T_HR_EMP_PA_INFO_V
prompt ================================
prompt
CREATE OR REPLACE FORCE VIEW T_HR_EMP_PA_INFO_V AS
SELECT
城市,get_code_id (TRIM (城市), 'BANKAREA') BANKAREA,
开户行,get_code_id (TRIM (开户行), 'BankNameCode') BankNameCode,
帐户名,
工号,
帐号　
FROM  T_HR_EMP_PA_INFO;

prompt
prompt Creating view T_HR_EXPERIENCE_INSIDE_V
prompt ======================================
prompt
CREATE OR REPLACE FORCE VIEW T_HR_EXPERIENCE_INSIDE_V
(姓名, 工号, 实施日期, 人事令类型, trans_type_code, 部门, 职务, post_code, 级号, post_grade_level_id, 职级, post_grade_id, 职位, position_code, 人事令号, 内容, dept_id, status_code, 员工状态)
AS
SELECT 姓名, 工号, TO_DATE (实施日期, 'yyyy-mm-dd'), 人事令类型,
          NVL(get_code_id(TRIM(人事令类型), 'TurnType'),
		  	  NVL(get_code_id(TRIM(人事令类型), 'TransRemove'),
			  	  NVL(get_code_id(TRIM(人事令类型), 'BandhType'),
				      get_code_id(TRIM(人事令类型), 'TransCode')
					  )
				  )
			  ) trans_type_code,
          部门, 职务,
          (SELECT post_id
             FROM HR_POST
            WHERE post_name = TRIM (职务) AND ROWNUM = 1) AS post_code, 级号,
          (SELECT post_grade_level_id
             FROM HR_POST_GRADE_LEVEL
            WHERE post_grade_level_name = TRIM (级号)
              AND ROWNUM = 1) AS post_grade_level_id,
          职级,
          (SELECT post_grade_id
             FROM HR_POST_GRADE
            WHERE post_grade_name = TRIM (职级)
              AND ROWNUM = 1) AS post_grade_id,
          职位, get_code_id (TRIM (职位), 'PositionCode') AS position_code,
          人事令号, 内容, get_dept_id_by_name (部门) dept_id,
		  get_code_id(TRIM(员工状态),'EmpStatus') statsu_code, 员工状态
     FROM T_HR_EXPERIENCE_INSIDE;

prompt
prompt Creating view T_HR_FAMILY_V
prompt ===========================
prompt
CREATE OR REPLACE FORCE VIEW T_HR_FAMILY_V AS
SELECT
工号,
关系,NVL(get_code_id (TRIM (关系), 'RelationalTypeCode'),'OtherRelation01') RelationalTypeCode,
姓名,
出生日期,
--职业,get_code_id (TRIM (职业), 'OccupCode') OccupCode,
职位,
身份证,
最终学历,get_code_id (TRIM (最终学历), 'DegreeCode') DegreeCode,
联系电话,工作单位,部门,工作地点,其他事项,
get_code_id(TRIM(一起居住与否), 'LiveTogetherFlag') 一起居住与否
FROM   T_HR_FAMILY;

prompt
prompt Creating view T_HR_HEALTH_V
prompt ===========================
prompt
CREATE OR REPLACE FORCE VIEW T_HR_HEALTH_V AS
SELECT
工号,区分,身高,体重,血型,get_code_id (TRIM (血型), 'BloodTypeCode') BLOODTYPECODE,
  左眼视力,右眼视力,色视情况,血压MAX,血压MIN,
  get_code_id (TRIM (血糖), 'CheckResult') "血糖",
  get_code_id (TRIM (OT), 'CheckResult') OT,
  get_code_id (TRIM (PT), 'CheckResult') PT,
  get_code_id (TRIM (HBSAG), 'CheckResult') HBSAG,
  get_code_id (TRIM (抗HBS), 'CheckResult') "抗HBS",
  get_code_id (TRIM (HBEAG), 'CheckResult') "HBEAG",
  get_code_id (TRIM (抗HBE), 'CheckResult') "抗HBE",
  get_code_id (TRIM (抗HBC), 'CheckResult') "抗HBC",
  get_code_id (TRIM (检查与否), 'CheckWhether') "检查与否",
  get_code_id (TRIM (检查结果), 'CheckResult') "检查结果",
  特殊事项
FROM   T_HR_HEALTH;

prompt
prompt Creating view T_HR_IT_LEVEL_V
prompt =============================
prompt
CREATE OR REPLACE FORCE VIEW T_HR_IT_LEVEL_V AS
SELECT
工号,
IT考试名,get_code_id (TRIM (IT考试名), 'ITExamCode') ITExamCode,
等级,get_code_id (TRIM (等级), 'ITLevelCode') ITLevelCode,
分数,to_date(取得日期,'yyyy-mm-dd') 取得日期
FROM   T_HR_IT_LEVEL;

prompt
prompt Creating view T_HR_LANGUAGE_LEVEL_V
prompt ===================================
prompt
CREATE OR REPLACE FORCE VIEW T_HR_LANGUAGE_LEVEL_V AS
SELECT
工号,
语言类型,get_code_id (TRIM (语言类型), 'LanguageTypeCode') LanguageTypeCode,
考试名,get_code_id (TRIM (考试名), 'LanguageExamCode') LanguageExamCode,
等级,get_code_id (TRIM (等级), 'LanguageLevelCode') LanguageLevelCode,
分数,to_date(取得日期,'yyyy-mm-dd') 取得日期, 证书名称
FROM   T_HR_LANGUAGE_LEVEL;

prompt
prompt Creating view T_HR_MILITARY_SERVICE_V
prompt =====================================
prompt
CREATE OR REPLACE FORCE VIEW T_HR_MILITARY_SERVICE_V AS
SELECT
工号,
军别,get_code_id (TRIM (军别), 'MilitaryTypeCode') MilitaryTypeCode,
军级,get_code_id (TRIM (军级), 'MilitaryLevelCode') MilitaryLevelCode,
军区,get_code_id (TRIM (军区), 'MilitaryAreaCode') MilitaryAreaCode,
to_date(开始日,'yyyy-mm-dd') 开始日,to_date(结束日,'yyyy-mm-dd')  结束日
FROM   T_HR_MILITARY_SERVICE;

prompt
prompt Creating view T_HR_PERSONAL_INFO_V
prompt ==================================
prompt
CREATE OR REPLACE FORCE VIEW T_HR_PERSONAL_INFO_V AS
SELECT 工号, 入司前学历, get_code_id (TRIM(入司前学历),'DegreeCode') AS degreecode1,
       入司后学历, get_code_id (TRIM(入司后学历), 'DegreeCode') AS degreecode2,
       性别, get_code_id (TRIM(性别), 'SexCode') AS sexcode,
       TO_DATE (出生日期, 'yyyy-mm-dd') 出生日期, 宗教,
       get_code_id (TRIM(宗教), 'ReligionCode') AS religioncode, 民族,
       get_code_id (TRIM(民族), 'NationCode') AS nationcode, 国籍,
       get_code_id (TRIM(国籍), 'NationalityCode') AS nationalitycode, 籍贯,
	   get_code_id (TRIM(籍贯), 'BornPlaceCode') AS bornplacecode,
	   政治面貌,
       get_code_id (TRIM(政治面貌), 'PolityCode') AS politycode, 婚姻情况,
       get_code_id (TRIM (婚姻情况), 'MaritalStatusCode') mstatuscode,
       结婚日期, 配偶工号, 身份证号, 现住址, 邮编, 邮箱, 姓名, 户口性质,
       get_code_id (TRIM(户口性质), 'RegTypeCode') AS regtypecode, 户口所在地,
       办公室电话, 家庭电话, 手机, 传真, 档案关系,爱好, 特长,
       get_code_id (TRIM(档案关系), 'FileRelation') AS fileRelationCode,
	   住房形式,
	   get_code_id (TRIM(住房形式), 'HousingState') AS HOUSING_STATE_CODE
  FROM T_HR_PERSONAL_INFO;

prompt
prompt Creating view T_HR_PLURALITY_V
prompt ==============================
prompt
CREATE OR REPLACE FORCE VIEW T_HR_PLURALITY_V AS
SELECT 工号,
  	   生效日期,
  	   get_code_id(TRIM(人事令类型),'TransCode_150') TRANS_CODE,
  	   get_dept_id_by_name(TRIM(部门)) DEPTID,
  	   get_code_id(TRIM(职位), 'PositionCode') AS POSITION_CODE,
  	   (SELECT post_grade_id
          FROM HR_POST_GRADE
         WHERE post_grade_name = TRIM(职级)
           AND ROWNUM = 1) AS POST_GRADE_ID,
	   get_dept_id_by_name(TRIM(兼职部门)) PLURA_DEPTID,
	   get_code_id(TRIM(兼职职位), 'PositionCode') AS PLURA_POSITION_CODE,
	   兼职事由
  FROM T_HR_PLURALITY;

prompt
prompt Creating view T_HR_RESIGNATION_V
prompt ================================
prompt
CREATE OR REPLACE FORCE VIEW T_HR_RESIGNATION_V
(工号, 人事令号, 离职类型, resign_type_code, 离职原因, resign_reason_code, 离职日期, 离职事由, 跳槽公司, 发令类型, trans_type_code, 备注, deptid, position_code, post_grade_id)
AS
SELECT 工号,人事令号,离职类型,
Get_Code_Id (TRIM (离职类型), 'ResignTypeCode') resign_type_code,
离职原因,
Get_Code_Id (TRIM (离职原因), 'ResignReasonCode') resign_reason_code,
TO_DATE(离职日期,'yyyy-mm-dd'),离职事由,跳槽公司,
发令类型,Get_Code_Id (TRIM (发令类型), 'TransResign') trans_type_code,
备注,
get_dept_id_by_name(TRIM(部门)) DEPTID,
get_code_id(TRIM(职位), 'PositionCode') AS POSITION_CODE,
(SELECT post_grade_id
    FROM HR_POST_GRADE
   WHERE post_grade_name = TRIM(职级)
     AND ROWNUM = 1) AS POST_GRADE_ID
  FROM  T_HR_RESIGNATION;


spool off
exit;