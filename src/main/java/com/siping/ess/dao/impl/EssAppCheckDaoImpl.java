package com.siping.ess.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.ess.dao.EssAppCheckDao;
import com.siping.ess.dao.InfoAppDao;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.MapUtil;
import com.siping.web.utility.SqlMapClientSupport;
import com.siping.web.utility.StringUtil;
import com.siping.web.utility.dao.UtilityOtherInfoDao;

@Repository
public class EssAppCheckDaoImpl extends SqlMapClientSupport implements EssAppCheckDao {

    @Autowired
    private UtilityOtherInfoDao utilityOtherInfoDao;

    @Autowired
    private InfoAppDao infoAppDao;

    private GregorianCalendar startTime = new GregorianCalendar();

    private GregorianCalendar endTime = new GregorianCalendar();

    @SuppressWarnings("rawtypes")
    private Map returnMap = new LinkedHashMap<Object, Object>();

    @SuppressWarnings("unchecked")
    public EssAppCheckDaoImpl() {
        this.returnMap.clear();
        this.startTime.clear();
        this.endTime.clear();
        this.returnMap.put("errcode", new Integer(0));
    }

    public GregorianCalendar getStartTime() {
        return startTime;
    }

    public void setStartTime(GregorianCalendar startTime) {
        this.startTime = startTime;
    }

    public GregorianCalendar getEndTime() {
        return endTime;
    }

    public void setEndTime(GregorianCalendar endTime) {
        this.endTime = endTime;
    }

    Logger logger = Logger.getLogger(EssAppCheckDaoImpl.class);

    /**
     * 休假检查 (non-Javadoc)
     * @see com.siping.ess.dao.EssAppCheckDao#leaveAppChecker(java.lang.Object)
     */
    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map<Object, Object> leaveAppChecker(Object obj) {
        this.returnMap.clear();
        this.startTime.clear();
        this.endTime.clear();
        this.returnMap.put("errcode", new Integer(0));
        Map paraMap = (Map) obj;
        try {
            this.startTime = DateUtil.ParseGregorianCalendar(paraMap.get("LEAVE_FROM_TIME").toString());
            this.endTime = DateUtil.ParseGregorianCalendar(paraMap.get("LEAVE_TO_TIME").toString());
        } catch (Exception e) {
            this.returnMap.put("errcode", new Integer(1));
            e.printStackTrace();
        }

        // 是否符合公司日历班次,此句注释，leaveCheckValidity XML文件中方法调用函数 AR_GET_SHIFTNO找不到返回值
       // if (((Integer) returnMap.get("errcode")).intValue() == 0) {
            //this.leaveCheckValidity(paraMap);
       // }
        // 开始结束时间检查
        if (((Integer) returnMap.get("errcode")).intValue() == 0 && StringUtil.checkNull(this.utilityOtherInfoDao.getModuleParameter("checkLeaveApplyStartEndTime"), "false").equals("true"))
            this.leaveAppStartEndTimeCheck(paraMap);
        // 休假时间与之前申请加班时间检查
        if (((Integer) returnMap.get("errcode")).intValue() == 0 && StringUtil.checkNull(this.utilityOtherInfoDao.getModuleParameter("checkLeaveApplyOtConflict"), "false").equals("true"))
            this.leaveConflictWithOtApp(paraMap);
        // 休假时间与之前申请休假时间检查
        if (((Integer) returnMap.get("errcode")).intValue() == 0 && StringUtil.checkNull(this.utilityOtherInfoDao.getModuleParameter("checkLeaveApplyLeaveConflict"), "false").equals("true"))
            this.leaveConflictWithLeaveApp(paraMap);
        // 休假时间与之前申请值班时间检查
/*        if (((Integer) returnMap.get("errcode")).intValue() == 0 && StringUtil.checkNull(this.utilityOtherInfoDao.getModuleParameter("checkLeaveApplyMatchConflict"), "false").equals("true"))
            this.leaveConflictWithMatchApp(paraMap);

        try {
            if (((Integer) returnMap.get("errcode")).intValue() == 0 && paraMap.get("LEAVE_TYPE_CODE").equals("LeaveType009")
                && StringUtil.checkNull(this.utilityOtherInfoDao.getModuleParameter("checkAffairLeaveAnnual"), "false").equals("true")) {
                this.checkAffairOrSickLeaveAnnual(paraMap);
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }

        try {
            if (((Integer) returnMap.get("errcode")).intValue() == 0 && paraMap.get("LEAVE_TYPE_CODE").equals("LeaveType009")
                && StringUtil.checkNull(this.utilityOtherInfoDao.getModuleParameter("checkAffairLeave"), "false").equals("true")) {
                this.checkAffairLeave(paraMap);
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }

        try {
            if (((Integer) returnMap.get("errcode")).intValue() == 0 && paraMap.get("LEAVE_TYPE_CODE").equals("LeaveType003")
                && StringUtil.checkNull(this.utilityOtherInfoDao.getModuleParameter("checkSickLeaveAnnual"), "false").equals("true")) {
                this.checkAffairOrSickLeaveAnnual(paraMap);
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }

        try {
            if (((Integer) returnMap.get("errcode")).intValue() == 0 && paraMap.get("LEAVE_TYPE_CODE").equals("LeaveType003")
                && StringUtil.checkNull(this.utilityOtherInfoDao.getModuleParameter("checkSickLeave"), "false").equals("true")) {
                this.checkSickLeave(paraMap);
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }

        try {
            if (((Integer) returnMap.get("errcode")).intValue() == 0 && paraMap.get("LEAVE_TYPE_CODE").equals("LeaveType010")) {
                this.leaveAppCompensationCheck(paraMap);
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }*/

        if (((Integer) returnMap.get("errcode")).intValue() == 0 && StringUtil.checkNull(this.utilityOtherInfoDao.getModuleParameter("checkDetailLock"), "false").equals("true"))
            this.checkDetailLock(paraMap.get("LEAVE_FROM_TIME").toString(), paraMap.get("LEAVE_TO_TIME").toString());
        return returnMap;
    }

    /**
     * 出差检查 (non-Javadoc)
     * @see com.siping.ess.dao.EssAppCheckDao#btAppChecker(java.lang.Object)
     */
    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map<Object, Object> btAppChecker(Object obj) {
        this.returnMap.clear();
        this.startTime.clear();
        this.endTime.clear();
        this.returnMap.put("errcode", new Integer(0));
        Map paraMap = (Map) obj;
        try {
            this.startTime = DateUtil.ParseGregorianCalendar(paraMap.get("BT_FROM_TIME").toString());
            this.endTime = DateUtil.ParseGregorianCalendar(paraMap.get("BT_TO_TIME").toString());
        } catch (Exception e) {
            this.returnMap.put("errcode", new Integer(1));
            e.printStackTrace();
        }

        // 开始结束时间检查
        if (((Integer) returnMap.get("errcode")).intValue() == 0 && StringUtil.checkNull(this.utilityOtherInfoDao.getModuleParameter("checkBTApplyStartEndTime"), "false").equals("true"))
            this.btAppStartEndTimeCheck(paraMap);

        // 出差与之前申出差时间检查
        if (((Integer) returnMap.get("errcode")).intValue() == 0 && StringUtil.checkNull(this.utilityOtherInfoDao.getModuleParameter("checkBTApplyBTConflict"), "false").equals("true"))
            this.btConflictWithBTApp(paraMap);

        // 出差时间与之前申请休假时间检查
        if (((Integer) returnMap.get("errcode")).intValue() == 0 && StringUtil.checkNull(this.utilityOtherInfoDao.getModuleParameter("checkBTApplyLeaveConflict"), "false").equals("true"))
            this.btConflictWithLeaveApp(paraMap);

        return returnMap;
    }

    /**
     * 费用检查 (non-Javadoc)
     * @see com.siping.ess.dao.EssAppCheckDao#expAppChecker(java.lang.Object)
     */
    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map<Object, Object> expAppChecker(Object obj) {
        this.returnMap.clear();
        this.startTime.clear();
        this.endTime.clear();
        this.returnMap.put("errcode", new Integer(0));
        Map paraMap = (Map) obj;
        if (paraMap.get("EXP_TYPE_CODE").equals("ExpTypeCode001")) {
            if (((Integer) returnMap.get("errcode")).intValue() == 0 && StringUtil.checkNull(this.utilityOtherInfoDao.getModuleParameter("checkExpApplyExpConflict"), "false").equals("true")) {
                this.expConflictWithExpApp(paraMap);
            }
        }
        return returnMap;
    }

    /**
     * 漏卡检查 (non-Javadoc)
     * @see com.siping.ess.dao.EssAppCheckDao#cardAppChecker(java.lang.Object)
     */
    @Override
    @SuppressWarnings({ "unchecked" })
    public Map<Object, Object> cardAppChecker(Object obj) {
        this.returnMap.clear();
        this.startTime.clear();
        this.endTime.clear();
        this.returnMap.put("errcode", new Integer(0));
        Map paraMap = (Map) obj;
        this.cardConflictWithCardApp(paraMap);
        return returnMap;
    }

    /**
     * 漏卡申请是否与已有漏卡申请冲突
     * @param paraMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void cardConflictWithCardApp(Map paraMap) {
        try {
            List<LinkedHashMap> returnList = new ArrayList<LinkedHashMap>();
            returnList = this.queryForList("ess.appCheck.cardConflictWithCardApp", paraMap);
            if (returnList.size() > 0) {
                this.returnMap.put("erremp", paraMap.get("EMPID"));
                this.returnMap.put("errcode", new Integer(-1));
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }
    }

    /**
     * 休假申请始末时间是否正常
     * @param paraMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void leaveAppStartEndTimeCheck(Map paraMap) {
        if (startTime.after(endTime) || startTime.equals(endTime))
            this.returnMap.put("errcode", new Integer(2));
    }

    /**
     * 出差申请始末时间是否正常
     * @param paraMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void btAppStartEndTimeCheck(Map paraMap) {
        if (startTime.after(endTime) || startTime.equals(endTime))
            this.returnMap.put("errcode", new Integer(2));
    }

    /**
     * 休假申请是否与已有加班申请冲突
     * @param paraMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void leaveConflictWithOtApp(Map paraMap) {
        try {
            List<LinkedHashMap> returnList = new ArrayList<LinkedHashMap>();
            returnList = this.queryForList("ess.appCheck.leaveConflictWithOtApp", paraMap);

            for (int i = 0; i < returnList.size(); i++) {
                Map paramMap = returnList.get(i);
                GregorianCalendar applyFrom = DateUtil.ParseGregorianCalendar(paramMap.get("OT_FROM_TIME").toString());
                GregorianCalendar applyTo = DateUtil.ParseGregorianCalendar(paramMap.get("OT_TO_TIME").toString());
                if (DateUtil.DateCross(this.startTime, this.endTime, applyFrom, applyTo, "MILLISECOND") > 0) {
                    this.returnMap.put("erremp", paraMap.get("EMPID"));
                    this.returnMap.put("errcode", new Integer(4));
                    return;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }
    }

    /**
     * 出差申请是否与已有休假申请冲突
     * @param paraMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void btConflictWithLeaveApp(Map paraMap) {
        try {
            List<LinkedHashMap> returnList = new ArrayList<LinkedHashMap>();
            returnList = this.queryForList("ess.appCheck.btConflictWithLeaveApp", paraMap);

            for (int i = 0; i < returnList.size(); i++) {
                Map paramMap = returnList.get(i);
                GregorianCalendar applyFrom = DateUtil.ParseGregorianCalendar(paramMap.get("LEAVE_FROM_TIME").toString());
                GregorianCalendar applyTo = DateUtil.ParseGregorianCalendar(paramMap.get("LEAVE_TO_TIME").toString());
                if (DateUtil.DateCross(this.startTime, this.endTime, applyFrom, applyTo, "MILLISECOND") > 0) {
                    this.returnMap.put("erremp", paraMap.get("EMPID"));
                    this.returnMap.put("errcode", new Integer(4));
                    return;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }
    }

    /**
     * 休假申请是否与已有休假申请冲突
     * @param paraMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void leaveConflictWithLeaveApp(Map paraMap) {
        try {
            List<LinkedHashMap> returnList = new ArrayList<LinkedHashMap>();
            returnList = this.queryForList("ess.appCheck.leaveConflictWithLeaveApp", paraMap);

            for (int i = 0; i < returnList.size(); i++) {
                Map paramMap = returnList.get(i);
                GregorianCalendar leaveFrom = DateUtil.ParseGregorianCalendar(paramMap.get("LEAVE_FROM_TIME").toString());
                GregorianCalendar leaveTo = DateUtil.ParseGregorianCalendar(paramMap.get("LEAVE_TO_TIME").toString());

                if (DateUtil.DateCross(this.startTime, this.endTime, leaveFrom, leaveTo) > 0) {
                    this.returnMap.put("erremp", paraMap.get("EMPID"));
                    this.returnMap.put("errcode", new Integer(5));
                    return;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }
    }

    /**
     * 出差申请是否与已有出差申请冲突
     * @param paraMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void btConflictWithBTApp(Map paraMap) {
        try {
            List<LinkedHashMap> returnList = new ArrayList<LinkedHashMap>();
            returnList = this.queryForList("ess.appCheck.btConflictWithBTApp", paraMap);

            for (int i = 0; i < returnList.size(); i++) {
                Map paramMap = returnList.get(i);
                GregorianCalendar btFrom = DateUtil.ParseGregorianCalendar(paramMap.get("BT_FROM_TIME").toString());
                GregorianCalendar btTo = DateUtil.ParseGregorianCalendar(paramMap.get("BT_TO_TIME").toString());

                if (DateUtil.DateCross(this.startTime, this.endTime, btFrom, btTo) > 0) {
                    this.returnMap.put("erremp", paraMap.get("EMPID"));
                    this.returnMap.put("errcode", new Integer(5));
                    return;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }
    }

    /**
     * 出差申请是否与已有出差申请冲突
     * @param paraMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void expConflictWithExpApp(Map paraMap) {
        try {
            List<LinkedHashMap> returnList = new ArrayList<LinkedHashMap>();
            returnList = this.queryForList("ess.appCheck.expConflictWithExpApp", paraMap);

            if (returnList.size() > 0) {
                this.returnMap.put("erremp", paraMap.get("EMPID"));
                this.returnMap.put("errcode", new Integer(5));
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }
    }

    /**
     * 休假申请是否与已有值班申请冲突
     * @param paraMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void leaveConflictWithMatchApp(Map paraMap) {
        try {
            List<LinkedHashMap> returnList = new ArrayList<LinkedHashMap>();
            returnList = this.queryForList("ess.appCheck.leaveConflictWithMatchApp", paraMap);

            for (int i = 0; i < returnList.size(); i++) {
                Map paramMap = returnList.get(i);
                GregorianCalendar matchFrom = DateUtil.ParseGregorianCalendar(paramMap.get("ONDUTY_FROM_TIME").toString());
                GregorianCalendar matchTo = DateUtil.ParseGregorianCalendar(paramMap.get("ONDUTY_TO_TIME").toString());
                if (DateUtil.DateCross(this.startTime, this.endTime, matchFrom, matchTo, "MILLISECOND") > 0) {
                    this.returnMap.put("erremp", paraMap.get("EMPID"));
                    this.returnMap.put("errcode", new Integer(6));
                    return;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }
    }

    /**
     * 检查年假是否超过
     * @param paraMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void leaveAppAnnualCheck(Map paraMap) {
        try {
            Map paraMap10 = new LinkedHashMap();
            paraMap10.put("empID", StringUtil.checkNull(paraMap.get("EMPID")));
            paraMap10.put("arItemNo", "22");
            paraMap10.put("leaveFromTime", StringUtil.checkNull(paraMap.get("LEAVE_FROM_TIME"), DateUtil.getSysdateString("yyyy-MM-dd HH:mm")));
            paraMap10.put("vacTp", "VacType10");
            paraMap10.put("leaveTypeCode", "VacType10");

            double tot_vac_cnt = this.infoAppDao.getEmpVacationRema(paraMap10);
            double tot_vac_not_cnt = this.infoAppDao.getEmpVacationNotConfirm(paraMap10);
            double leaveLength = this.infoAppDao.getLeavelength(paraMap);

            if (leaveLength < 4) {
                this.returnMap.put("errcode", new Integer(21));
                this.returnMap.put("erremp", paraMap.get("EMPID"));
            } else {
                if (tot_vac_cnt < (leaveLength + tot_vac_not_cnt)) {
                    this.returnMap.put("errcode", new Integer(3));
                    this.returnMap.put("erremp", paraMap.get("EMPID"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }
    }

    /**
     * 检查休日加班和节日加班的总时数是否超过倒休假的时数
     * @param paraMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void leaveAppCompensationCheck(Map paraMap) {
        try {

            double totalOTTime = this.infoAppDao.getVocationOTLength(paraMap);
            if (totalOTTime == 0.0) {
                this.returnMap.put("errcode", new Integer(31));
                this.returnMap.put("errmsg", "休日节日加班时数为0，无法申请倒休假");

            } else {
                double thisLeaveLength = this.infoAppDao.getLeavelength(paraMap); // 本次请假长度
                double compensationLeaveLength = 0.0; // 生效的倒休假总长度
                List compensationLeaveList = this.infoAppDao.getActiveCompensationLeave(paraMap);
                if (compensationLeaveList != null) {
                    for (int i = 0; i < compensationLeaveList.size(); i++) {
                        double tmpLeaveLength = this.infoAppDao.getLeavelength(compensationLeaveList.get(i));
                        compensationLeaveLength = compensationLeaveLength + tmpLeaveLength;
                    }
                }
                double leaveLengthLeft = totalOTTime - compensationLeaveLength;
                if (thisLeaveLength > leaveLengthLeft) {
                    this.returnMap.put("errcode", new Integer(32));
                    this.returnMap.put("errmsg", "倒休假的休假额度为" + leaveLengthLeft + "小时, 而本次休假长度为" + thisLeaveLength + "小时");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }
    }

    /**
     * 事假病假申请 验证是否存在年假 如果有年假提示先使用年假
     * @param paraMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void checkAffairOrSickLeaveAnnual(Map paraMap) {
        try {
            Map paraMap10 = new LinkedHashMap();
            paraMap10.put("empID", StringUtil.checkNull(paraMap.get("EMPID")));
            paraMap10.put("arItemNo", "22");
            paraMap10.put("leaveFromTime", StringUtil.checkNull(paraMap.get("LEAVE_FROM_TIME"), DateUtil.getSysdateString("yyyy-MM-dd HH:mm")));
            paraMap10.put("vacTp", "VacType10");
            paraMap10.put("leaveTypeCode", "LeaveType005");
            double tot_vac_cnt = this.infoAppDao.getEmpVacationRema(paraMap10);
            double tot_vac_not_cnt = this.infoAppDao.getEmpVacationNotConfirm(paraMap10);
            if (tot_vac_cnt - tot_vac_not_cnt > 0) {
                this.returnMap.put("errcode", new Integer(15));
                this.returnMap.put("erremp", paraMap.get("EMPID"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }
    }

    /**
     * 事假申请 验证年事假上限
     * @param paraMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void checkAffairLeave(Map paraMap) {
        try {
            Map paraMapxx = new LinkedHashMap();
            paraMapxx.put("empID", StringUtil.checkNull(paraMap.get("EMPID")));
            paraMapxx.put("arItemNo", "20");
            paraMapxx.put("leaveTypeCode", paraMap.get("LEAVE_TYPE_CODE"));
            double tot_vac_used_cnt = this.infoAppDao.getEmpVacationUsed(paraMapxx);
            double tot_vac_not_cnt = this.infoAppDao.getEmpVacationNotConfirm(paraMapxx);

            if ((tot_vac_used_cnt + tot_vac_not_cnt) > Double.parseDouble(this.utilityOtherInfoDao.getModuleParameter("affairLeaveMaxHours"))) {
                this.returnMap.put("errcode", new Integer(23));
                this.returnMap.put("erremp", paraMap.get("EMPID"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }
    }

    /**
     * 病假申请 验证年病假上限
     * @param paraMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void checkSickLeave(Map paraMap) {
        try {
            Map paraMapxx = new LinkedHashMap();
            paraMapxx.put("empID", StringUtil.checkNull(paraMap.get("EMPID")));
            paraMapxx.put("arItemNo", "16");
            paraMapxx.put("leaveTypeCode", paraMap.get("LEAVE_TYPE_CODE"));

            double tot_vac_used_cnt = this.infoAppDao.getEmpVacationUsed(paraMapxx);
            double tot_vac_not_cnt = this.infoAppDao.getEmpVacationNotConfirm(paraMapxx);

            if ((tot_vac_used_cnt + tot_vac_not_cnt) > Double.parseDouble(this.utilityOtherInfoDao.getModuleParameter("sickLeaveMaxHours"))) {
                this.returnMap.put("errcode", new Integer(22));
                this.returnMap.put("erremp", paraMap.get("EMPID"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }
    }

    /**
     * 休假与上班时间检查
     * @param paraMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void leaveCheckValidity(Map paraMap) {
        int returnInt = 1;
        try {
            GregorianCalendar gregorianCalendar = DateUtil.ParseGregorianCalendar(paraMap.get("LEAVE_FROM_TIME").toString());
            String shiftDate = DateUtil.formatDate(gregorianCalendar.getTime(), "yyyy-MM-dd HH:mm");
            paraMap.put("shiftDate", shiftDate);
            returnInt = (Integer) this.queryForObject("ess.appCheck.leaveCheckValidity", paraMap);
            if (returnInt == 0) {
                this.returnMap.put("errcode", new Integer(13));
                this.returnMap.put("erremp", paraMap.get("EMPID"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }
    }

    /**
     * 加班检查 (non-Javadoc)
     * @see com.siping.ess.dao.EssAppCheckDao#otAppChecker(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map<Object, Object> otAppChecker(Object obj) {
        Map paraMap = (Map) obj;
        this.returnMap.clear();
        this.startTime.clear();
        this.endTime.clear();
        this.returnMap.put("errcode", new Integer(0));
        try {
            String start_time = paraMap.get("OT_FROM_TIME").toString();
            String end_time = paraMap.get("OT_TO_TIME").toString();
            paraMap.put("OT_DATE", start_time.substring(0, 10));
            this.setStartTime(DateUtil.ParseGregorianCalendar(start_time));
            this.setEndTime(DateUtil.ParseGregorianCalendar(end_time));
        } catch (Exception e) {
            this.returnMap.put("errcode", new Integer(1));
            e.printStackTrace();
        }
        try {
            if (((Integer) returnMap.get("errcode")).intValue() == 0 && StringUtil.checkNull(this.utilityOtherInfoDao.getModuleParameter("checkOtApplyStartEndTime"), "false").equals("true")) {
                this.otAppStartEndTimeCheck(paraMap);
            }

            if(this.getEndTime().before(new GregorianCalendar())){
                this.returnMap.put("errcode", new Integer(7));
                this.returnMap.put("errmsg", "申请日期不可以当前日期之前");
            }

            // 加班时间与班次时间检查 ,不检测节假日加班申请
            if (((Integer) returnMap.get("errcode")).intValue() == 0 && StringUtil.checkNull(this.utilityOtherInfoDao.getModuleParameter("checkOtApplyShiftConflict"), "false").equals("true")) {
                if (!paraMap.get("OT_TYPE_CODE").equals("WorkingOtType03"))
                    this.otConflictWithArShift(paraMap);
            }

            // 检测申请日期是否小于当前日期
            if (((Integer) returnMap.get("errcode")).intValue() == 0 && (paraMap.get("OT_TYPE_CODE").equals("WorkingOtType03")) && this.getDataType(paraMap) != 3) {
                this.returnMap.put("errcode", new Integer(16));
            }

            // 加班时间与之前申请加班时间检查
            if (((Integer) returnMap.get("errcode")).intValue() == 0 && StringUtil.checkNull(this.utilityOtherInfoDao.getModuleParameter("checkOtApplyOtConflict"), "false").equals("true")) {
                this.otConflictWithOtApp(paraMap);
            }

            // 加班时间与之前申请休假时间检查
            if (((Integer) returnMap.get("errcode")).intValue() == 0 && StringUtil.checkNull(this.utilityOtherInfoDao.getModuleParameter("checkOtApplyLeaveConflict"), "false").equals("true")) {
                this.otConflictWithLeaveApp(paraMap);
            }

            // 加班时间与之前申请出差时间检查
            if (((Integer) returnMap.get("errcode")).intValue() == 0 && StringUtil.checkNull(this.utilityOtherInfoDao.getModuleParameter("checkOtApplyEvectionConflict"), "false").equals("true")) {
                this.otConflictWithEvectionApp(paraMap);
            }
//if语句注释掉
            // 根据班次检查手工输入的加班类型
           // if (((Integer) returnMap.get("errcode")).intValue() == 0 && this.utilityOtherInfoDao.getModuleParameter("otApplyTypeCheckFlag").equals("0")) {
                //this.otCheckOtAppType(paraMap);
          //  }
/*
            // 加班时间与之前申请值班时间检查
            if (((Integer) returnMap.get("errcode")).intValue() == 0 && StringUtil.checkNull(this.utilityOtherInfoDao.getModuleParameter("checkOtApplyMatchConflict"), "false").equals("true")) {
                this.otConflictWithMatchApp(paraMap);
            }

            // 可申请加班的时间区间检查
            if (((Integer) returnMap.get("errcode")).intValue() == 0) {
                this.otCheckOtAppDaysBeforeAfter(paraMap, Integer.parseInt(this.utilityOtherInfoDao.getModuleParameter("otApplyDaysBefore")),
                    Integer.parseInt(this.utilityOtherInfoDao.getModuleParameter("otApplyDaysAfter")));
            }

            // 检查月累计加班上限限制
            if (((Integer) returnMap.get("errcode")).intValue() == 0 && Integer.parseInt(this.utilityOtherInfoDao.getModuleParameter("otApplyMaxHours")) > 0) {
                this.otCheckOtMaxHours(paraMap, Integer.parseInt(this.utilityOtherInfoDao.getModuleParameter("otApplyMaxHours")));
            }

            // 检查是否符合假日特勤加班的条件 注：特勤加班的条件是员工必须是在休息的状态和必须是动态组的员工。
            if (((Integer) returnMap.get("errcode")).intValue() == 0
                && (paraMap.get("OT_TYPE_CODE").equals("HolidayOT1") || paraMap.get("OT_TYPE_CODE").equals("HolidayOT2") || paraMap.get("OT_TYPE_CODE").equals("HolidayOT3"))) {
                this.otCheckHolidayOT(paraMap);
            }*/

            // 考勤锁定
            //数据库函数AR_GET_DATETYPE执行错误报错FUNCTION AR_GET_DATETYPE1 ended without RETURN
            //if (((Integer) returnMap.get("errcode")).intValue() == 0 && StringUtil.checkNull(this.utilityOtherInfoDao.getModuleParameter("checkDetailLock"), "false").equals("true")) {
               // this.checkDetailLock(paraMap.get("OT_FROM_TIME").toString(), paraMap.get("OT_TO_TIME").toString());
            //}
        } catch (Exception e) {
            e.printStackTrace();
            returnMap.put("errcode", new Integer(-1));
            returnMap.put("errmsg", e.toString());
        }
        return returnMap;
    }

    /**
     * 信息检查 (non-Javadoc)
     * @see com.siping.ess.dao.EssAppCheckDao#perAppChecker(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map<Object, Object> perAppChecker(Object obj) {
        this.returnMap.clear();
        this.startTime.clear();
        this.endTime.clear();
        this.returnMap.put("errcode", new Integer(0));
        Map paraMap = (Map) obj;
        try {
            // 身份证号码检查
            if (((Integer) returnMap.get("errcode")).intValue() == 0) {
                this.perAppIdCardNoCheck(paraMap);
            }
            // 信息检查
            if (((Integer) returnMap.get("errcode")).intValue() == 0) {
                this.perAppInfoCheck(paraMap);
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnMap.put("errcode", new Integer(-1));
            returnMap.put("errmsg", e.toString());
        }
        return returnMap;
    }

    /**
     * 信息检查 (non-Javadoc)
     * @see com.siping.ess.dao.EssAppCheckDao#whAppChecker(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map<Object, Object> whAppChecker(Object obj) {
        this.returnMap.clear();
        this.startTime.clear();
        this.endTime.clear();
        this.returnMap.put("errcode", new Integer(0));
        Map paraMap = (Map) obj;
        try {
            // 报工时数检查
            if (((Integer) returnMap.get("errcode")).intValue() == 0) {
                this.whAppHoursCheck(paraMap);
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnMap.put("errcode", new Integer(-1));
            returnMap.put("errmsg", e.toString());
        }
        return returnMap;
    }

    /**
     * 加班申请开始结束时间检查
     * @param paraMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void otAppStartEndTimeCheck(Map paraMap) {
        if (startTime.after(endTime) || startTime.equals(endTime))
            returnMap.put("errcode", new Integer(2));
    }

    /**
     * 加班申请是否与班次冲突
     * @param paraMap
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    private void otConflictWithArShift(Map paraMap) {

        try {
            List<LinkedHashMap> returnList = new ArrayList<LinkedHashMap>();
            returnList = this.queryForList("ess.appCheck.otConflictWithArShift", paraMap);
            for (int i = 0; i < returnList.size(); i++) {
                Map paramMap = returnList.get(i);
                GregorianCalendar shiftFrom = DateUtil.ParseGregorianCalendar(paramMap.get("FROM_TIME").toString());
                GregorianCalendar shiftTo = DateUtil.ParseGregorianCalendar(paramMap.get("TO_TIME").toString());
                if (DateUtil.DateCross(this.startTime, this.endTime, shiftFrom, shiftTo, "MILLISECOND") > 0) {
                    this.returnMap.put("erremp", paraMap.get("EMPID"));
                    this.returnMap.put("errcode", new Integer(3));
                    return;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }
    }

    /**
     * 日历类型:1平时,2周末,3节假日
     * @param paraMap
     * @return
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private int getDataType(Map paraMap) {
        int returnInt = 0;
        try {
            returnInt = (Integer) this.queryForObject("ess.appCheck.getDataType", paraMap);
        } catch (Exception e) {
            e.printStackTrace();
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }
        return returnInt;
    }

    /**
     * 加班申请是否与已有加班申请冲突
     * @param paraMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void otConflictWithOtApp(Map paraMap) {
        try {
            List<LinkedHashMap> returnList = new ArrayList<LinkedHashMap>();
            returnList = this.queryForList("ess.appCheck.otConflictWithOtApp", paraMap);
            for (int i = 0; i < returnList.size(); i++) {
                Map paramMap = returnList.get(i);
                GregorianCalendar applyFrom = DateUtil.ParseGregorianCalendar(paramMap.get("OT_FROM_TIME").toString());
                GregorianCalendar applyTo = DateUtil.ParseGregorianCalendar(paramMap.get("OT_TO_TIME").toString());
                if (DateUtil.DateCross(this.startTime, this.endTime, applyFrom, applyTo, "MILLISECOND") > 0) {
                    this.returnMap.put("erremp", paraMap.get("EMPID"));
                    this.returnMap.put("errcode", new Integer(4));
                    return;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }
    }

    /**
     * 加班申请是否与已有休假申请冲突
     * @param paraMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void otConflictWithLeaveApp(Map paraMap) {
        try {
            List<LinkedHashMap> returnList = new ArrayList<LinkedHashMap>();
            returnList = this.queryForList("ess.appCheck.otConflictWithLeaveApp", paraMap);
            for (int i = 0; i < returnList.size(); i++) {
                Map paramMap = returnList.get(i);
                GregorianCalendar leaveFrom = DateUtil.ParseGregorianCalendar(paramMap.get("LEAVE_FROM_TIME").toString());
                GregorianCalendar leaveTo = DateUtil.ParseGregorianCalendar(paramMap.get("LEAVE_TO_TIME").toString());
                if (DateUtil.DateCross(this.startTime, this.endTime, leaveFrom, leaveTo, "MILLISECOND") > 0) {
                    this.returnMap.put("erremp", paraMap.get("EMPID"));
                    this.returnMap.put("errcode", new Integer(5));
                    return;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }
    }

    /**
     * 加班申请是否与已有出差申请冲突
     * @param paraMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void otConflictWithEvectionApp(Map paraMap) {
        try {
            List<LinkedHashMap> returnList = new ArrayList<LinkedHashMap>();
            returnList = this.queryForList("ess.appCheck.otConflictWithEvectionApp", paraMap);
            for (int i = 0; i < returnList.size(); i++) {
                Map paramMap = returnList.get(i);
                GregorianCalendar leaveFrom = DateUtil.ParseGregorianCalendar(paramMap.get("LEAVE_FROM_TIME").toString());
                GregorianCalendar leaveTo = DateUtil.ParseGregorianCalendar(paramMap.get("LEAVE_TO_TIME").toString());
                if (DateUtil.DateCross(this.startTime, this.endTime, leaveFrom, leaveTo, "MILLISECOND") > 0) {
                    this.returnMap.put("erremp", paraMap.get("EMPID"));
                    this.returnMap.put("errcode", new Integer(21));
                    return;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }
    }

    /**
     * 加班申请是否与已有休假申请冲突
     * @param paraMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void otConflictWithMatchApp(Map paraMap) {
        try {
            List<LinkedHashMap> returnList = new ArrayList<LinkedHashMap>();
            returnList = this.queryForList("ess.appCheck.otConflictWithEvectionApp", paraMap);
            for (int i = 0; i < returnList.size(); i++) {
                Map paramMap = returnList.get(i);
                GregorianCalendar matchFrom = DateUtil.ParseGregorianCalendar(paramMap.get("MATCH_FROM_TIME").toString());
                GregorianCalendar matchTo = DateUtil.ParseGregorianCalendar(paramMap.get("MATCH_TO_TIME").toString());
                if (DateUtil.DateCross(this.startTime, this.endTime, matchFrom, matchTo, "MILLISECOND") > 0) {
                    this.returnMap.put("erremp", paraMap.get("EMPID"));
                    this.returnMap.put("errcode", new Integer(6));
                    return;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }
    }

    /**
     * 加班申请是否在可以申请日期范围内
     * @param paraMap
     * @param otAppDaysBefore 可申请日期范围上限
     * @param otAppDaysAfter 可申请日期范围下限
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void otCheckOtAppDaysBeforeAfter(Map paraMap, int otAppDaysBefore, int otAppDaysAfter) {
        try {
            GregorianCalendar otDate = DateUtil.ParseGregorianCalendar(paraMap.get("OT_FROM_TIME").toString().substring(0, 10));

            if (otAppDaysBefore > 0) {
                GregorianCalendar createDate = DateUtil.ParseGregorianCalendar(DateUtil.getSysdateString("yyyy-MM-dd"));
                GregorianCalendar dayStart = DateUtil.dateAdd(createDate, "DAY", -1 * otAppDaysBefore);
                if (otDate.before(dayStart)) {
                    this.returnMap.put("errcode", new Integer(7));
                    this.returnMap.put("appDaysBefore", String.valueOf(otAppDaysBefore));
                }
            }
            if (otAppDaysAfter > 0) {
                GregorianCalendar createDate = DateUtil.ParseGregorianCalendar(DateUtil.getSysdateString("yyyy-MM-dd"));
                GregorianCalendar dayEnd = DateUtil.dateAdd(createDate, "DAY", otAppDaysAfter);
                Logger.getLogger(getClass()).debug(dayEnd);
                if (otDate.after(dayEnd)) {
                    this.returnMap.put("errcode", new Integer(8));
                    this.returnMap.put("appDaysAfter", String.valueOf(otAppDaysAfter));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }
    }

    /**
     * 检查手工选择的加班类型与员工班次对应的加班类型是否一致
     * @param paraMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void otCheckOtAppType(Map paraMap) {

        String manualType = paraMap.get("OT_TYPE_CODE").toString();

        String autoType = "";
        int dateType = 0;

        try {
            dateType = getDataType(paraMap);

            if (dateType == 1) {
                autoType = "WorkingOtType01";
            } else if (dateType == 2) {
                autoType = "WorkingOtType02";
            } else if (dateType == 3) {
                autoType = "WorkingOtType03";
            }
            if (!manualType.equals(autoType)) {
            
                this.returnMap.put("errcode", new Integer(9));
                this.returnMap.put("erremp", paraMap.get("EMPID"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            Logger.getLogger(getClass()).debug(e.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }
    }

    /**
     * @param paraMap
     * @param maxHours
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void otCheckOtMaxHours(Map paraMap, double maxHours) {
        double otHours = 0.0;
        try {
            otHours = (Double) this.queryForObject("ess.appCheck.otMonthlyDetailTotalOTHours", paraMap);

            otHours += (Double) this.queryForObject("ess.appCheck.otMonthlyAppingTotalOTHours", paraMap);

            otHours += DateUtil.DateDiff(this.startTime, this.endTime, "HOUR") - Double.parseDouble(paraMap.get("OT_DEDUCTION").toString());

            if (otHours >= maxHours) {
                this.returnMap.put("errcode", new Integer(11));
                this.returnMap.put("erremp", paraMap.get("EMPID"));
                this.returnMap.put("maxothour", String.valueOf(maxHours));
            }
        } catch (Exception e) {
            e.printStackTrace();
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", e.toString());
        }
    }

    /**
     * 检查员工申请假日特勤加班是否是满足在 休息日加班和在动态组的员工的条件
     * @param paraMap
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void otCheckHolidayOT(Map paraMap) {
        int holidayOTCode = 0;
        try {
            holidayOTCode = (Integer) this.queryForObject("ess.appCheck.otCheckHolidayOT", paraMap);
            if (holidayOTCode == 0) {
                this.returnMap.put("errcode", new Integer(14));
                this.returnMap.put("erremp", paraMap.get("EMPID"));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            Logger.getLogger(getClass()).debug(ex.toString());
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", ex.toString());
        }
    }

    /**
     * 验证当天考勤是否已锁定
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void checkDetailLock(String fromTime, String toTime) {
        String errDate = "";
        try {
            Map paraMap = new LinkedHashMap<Object, Object>();
            paraMap.put("fromTime", fromTime);
            paraMap.put("toTime", toTime);
            errDate = (String) this.queryForObject("ess.appCheck.checkDetailLock", paraMap);

            if (errDate != null) {
                this.returnMap.put("errcode", new Integer(90));
                this.returnMap.put("errDate", errDate);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", ex.toString());
        }
    }

    /**
     * 验证身份证号码是否已经存在
     */
    @SuppressWarnings({ "unchecked" })
    private void perAppIdCardNoCheck(Object object) {
        int returnInt = 1;
        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("ess.appCheck.perAppIdCardNoCheck", object)), Integer.class);
            if (returnInt == 1) {
                this.returnMap.put("errcode", new Integer(3));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", ex.toString());
        }
    }

    /**
     * 报工时数检查
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void whAppHoursCheck(Object object) {
        Map paraMap = (Map) object;
        try {
            List<Map> dataList = (List) paraMap.get("dataList");
            this.insertForList("ess.appCheck.saveWorkingHoursInfo", dataList);

            List<Map> whList = this.queryForList("ess.appCheck.getWhInfo", paraMap);
            for (Map para : whList) {
                double totalApp = Double.parseDouble(para.get("WORK_HOUR").toString());
                double returnBe = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("ess.appCheck.whAppHoursCheck01", para)), Double.class);
                double returnUsed = 0.0;
                if (paraMap.get("flag").equals("update")) {
                    para.put("dataList", dataList);
                    returnUsed = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("ess.appCheck.whAppHoursCheck02", para)), Double.class);
                    para.remove("dataList");
                } else {
                    returnUsed = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("ess.appCheck.whAppHoursCheck02", para)), Double.class);
                }
                if (totalApp + returnUsed > returnBe) {
                    this.returnMap.put("errcode", new Integer(5));
                    this.returnMap.put("errmsg", para.get("PRO_NO").toString());
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", ex.toString());
        } finally {
            try {
                this.delete("ess.appCheck.delWhInfo", paraMap);
            } catch (SQLException e) {
                e.printStackTrace();
                this.returnMap.put("errcode", new Integer(-1));
                this.returnMap.put("errmsg", e.toString());
            }
        }
    }

    /**
     * 借用时间检查
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private void toolAppCheck(Object object) {
        Map paraMap = (Map) object;
        try {
            int cnt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("ess.appCheck.toolAppDateCheck01", paraMap)), Integer.class);
            if (cnt > 0) {
                this.returnMap.put("errcode", new Integer(1));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", ex.toString());
        }
    }

    /**
     * 验证身份证号码是否已经存在
     */
    @SuppressWarnings({ "unchecked" })
    private void perAppInfoCheck(Object object) {
        try {
            Object returnNewObject = object;
            Object returnOldObject = this.queryForObject("ess.viewApp.getOldPersonalInfo", object);

            if (MapUtil.perAppInfoCheck(returnNewObject, returnOldObject)) {
                this.returnMap.put("errcode", new Integer(4));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            this.returnMap.put("errcode", new Integer(-1));
            this.returnMap.put("errmsg", ex.toString());
        }
    }

    /**
     * 借用物品检查
     * @see com.siping.ess.dao.EssAppCheckDao#objectAppChecker(java.lang.Object)
     */
    @SuppressWarnings({ "unchecked" })
    @Override
    public Map<Object, Object> toolAppChecker(Object obj) {
        this.returnMap.clear();
        this.startTime.clear();
        this.endTime.clear();
        this.returnMap.put("errcode", new Integer(0));
        // Map paraMap = (Map) obj;
        // try {
        // // 借用物品检查
        // if (((Integer) returnMap.get("errcode")).intValue() == 0) {
        // this.toolAppCheck(paraMap);
        // }
        // } catch (Exception e) {
        // e.printStackTrace();
        // returnMap.put("errcode", new Integer(-1));
        // returnMap.put("errmsg", e.toString());
        // }
        return returnMap;
    }
}
