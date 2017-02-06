package com.siping.ess.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.runtime.Execution;
import org.activiti.engine.runtime.ProcessInstance;
import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;
import org.springframework.web.multipart.MultipartFile;

import com.siping.att.dao.CompanyCalendarDao;
import com.siping.ess.dao.EssAppCheckDao;
import com.siping.ess.dao.InfoAppDao;
import com.siping.ess.service.InfoAppSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.StringUtil;
import com.siping.web.utility.dao.UtilityOtherInfoDao;

@Service
public class InfoAppSerImpl implements InfoAppSer {

    private static final String BUSINESS_DATA_READY = "businessDataReady";

    Logger logger = Logger.getLogger(InfoAppSerImpl.class);

    @Autowired
    private InfoAppDao infoAppDao;

    @Autowired
    private UtilityOtherInfoDao utilityOtherInfoDao;

    @Autowired
    private EssAppCheckDao essAppCheckDao;

    @Autowired
    private CompanyCalendarDao companyCalendarDao;

    @Autowired
    private RuntimeService runtimeService;

    /**
     * 个人信息申请 (non-Javadoc)
     * @see com.siping.ess.service.InfoAppSer#addPersonalInfoApp(javax.servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map addPersonalInfoApp(HttpServletRequest request) {

        Map returnMap = new LinkedHashMap<Object, Object>();

        try {
            AdminBean admin = SessionUtil.getLoginUserFromSession(request);
            Map param = ObjectBindUtil.getRequestParamData(request);
            param.put("CREATED_BY", admin.getAdminID());
            returnMap = this.essAppCheckDao.perAppChecker(param);
            if (((Integer) returnMap.get("errcode")).intValue() == 0) {
                this.infoAppDao.addPersonalInfoApp(param);
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnMap.put("errcode", new Integer(1));
            returnMap.put("errmsg", e.toString());
        }
        return returnMap;
    }

    /**
     * 获取审核者 (non-Javadoc)
     * @see com.siping.ess.service.InfoAppSer#getAffirmorList(javax.servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getAffirmorList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map param = ObjectBindUtil.getRequestParamData(request);
        param.put("language", Messages.getLanguage(request));
        param.put("containsOwner", this.utilityOtherInfoDao.getModuleParameter("containsOwner"));
        param.put("isAddLastAffirmor", this.utilityOtherInfoDao.getModuleParameter("isAddLastAffirmor"));
        param.put("transLastAffirmor", StringUtil.checkNull(this.utilityOtherInfoDao.getModuleParameter("transLastAffirmor"), ""));
        if (param.get("EMPID") == null || param.get("EMPID").equals("")) {
            param.put("EMPID", admin.getAdminID());
        }
        return this.infoAppDao.getAffirmorList(param);
    }

    /**
     * 获取审核者 (non-Javadoc)
     * @see com.siping.ess.service.InfoAppSer#getAffirmorList(javax.servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List getAffirmorList(HttpServletRequest request, Map paraMap) {
        Map param = ObjectBindUtil.getRequestParamData(request);
        param.put("language", Messages.getLanguage(request));
        param.put("containsOwner", this.utilityOtherInfoDao.getModuleParameter("containsOwner"));
        param.put("isAddLastAffirmor", this.utilityOtherInfoDao.getModuleParameter("isAddLastAffirmor"));
        param.put("transLastAffirmor", StringUtil.checkNull(this.utilityOtherInfoDao.getModuleParameter("transLastAffirmor"), ""));
        param.put("EMPID", paraMap.get("EMPID").toString());
        param.put("appType", paraMap.get("appType").toString());

        return this.infoAppDao.getAffirmorList(param);
    }

    /**
     * 班次信息 (non-Javadoc)
     * @see com.siping.ess.service.InfoAppSer#getEmpShift(javax.servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getEmpShift(HttpServletRequest request) {
        Map param = ObjectBindUtil.getRequestParamData(request);
        param.put("language", Messages.getLanguage(request));
        return this.infoAppDao.getEmpShift(param);
    }

    /**
     * 加班申请 (non-Javadoc)
     * @see com.siping.ess.service.InfoAppSer#addOvertimeApp(javax.servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map addOvertimeApp(HttpServletRequest request) {
        Map returnMap = new LinkedHashMap<Object, Object>();
        try {
            AdminBean admin = SessionUtil.getLoginUserFromSession(request);
            Map param = ObjectBindUtil.getRequestParamData(request);
            param.put("CREATED_BY", admin.getAdminID());
            returnMap = this.essAppCheckDao.otAppChecker(param);

            if (((Integer) returnMap.get("errcode")).intValue() == 0) {
	            Map processParam = new LinkedHashMap<String, Object>();
	            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	            Date s_date = format.parse(param.get("OT_FROM_TIME").toString());
	            Date e_date = format.parse(param.get("OT_TO_TIME").toString());
	            long times = e_date.getTime() - s_date.getTime();
	            long hours = (long) Math.round(times / 1000 / 3600);
	            String chineseName = this.infoAppDao.getChineseNameById(param.get("EMPID"));
	            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	            String currentTime = formatter.format(new Date());
	            processParam.put("application_time", currentTime);
	            processParam.put("s_hours", hours);
	            processParam.put("start_time", param.get("OT_FROM_TIME"));
	            processParam.put("end_time", param.get("OT_TO_TIME"));
	            processParam.put("empid", param.get("EMPID"));
	            processParam.put("applicant", chineseName);
                ProcessInstance processInstance = runtimeService.startProcessInstanceByKey("OvertimeProcess", processParam);
                String processID = processInstance.getProcessInstanceId();
                param.put("PROCESSID", processID);
                returnMap = this.infoAppDao.addOvertimeApp(param);
                if (((Integer) returnMap.get("errcode")).intValue() != 0) {
                    runtimeService.deleteProcessInstance(processID, "发生异常，申请取消");
                }
                Execution execution = runtimeService.createExecutionQuery().processInstanceId(processInstance.getProcessInstanceId())
                    .activityId(BUSINESS_DATA_READY).singleResult();
                if(execution!=null){
                    runtimeService.signal(execution.getId());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnMap.put("errcode", new Integer(1));
            returnMap.put("errmsg", e.toString());
        }
        return returnMap;
    }

    /**
     * 出差申请 (non-Javadoc)
     * @see com.siping.ess.service.InfoAppSer#addBTApp(javax.servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map addBTApp(HttpServletRequest request) {
        Map returnMap = new LinkedHashMap<Object, Object>();
        try {
            AdminBean admin = SessionUtil.getLoginUserFromSession(request);
            Map param = ObjectBindUtil.getRequestParamData(request);
            param.put("CREATED_BY", admin.getAdminID());
            returnMap = this.essAppCheckDao.btAppChecker(param);
            Map processParam = new LinkedHashMap<String, Object>();
            SimpleDateFormat format = new SimpleDateFormat("yyyy-M-dd HH:mm");
            Date s_date = format.parse(param.get("BT_FROM_TIME").toString());
            Date e_date = format.parse(param.get("BT_TO_TIME").toString());
            long times = e_date.getTime() - s_date.getTime();
            long days = (long) Math.round(times / 1000 / 3600 / 24);
//            String deptLeaderId = this.infoAppDao.getDeptLeaderId(param.get("EMPID"));
//            String upperDeptLeaderId = this.infoAppDao.getUpperDeptLeaderId(param.get("EMPID"));
            String chineseName = this.infoAppDao.getChineseNameById(param.get("EMPID"));
            String destination = this.infoAppDao.getBusiTripDestination(param.get("BT_CITY"));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String currentTime = formatter.format(new Date());
            processParam.put("days", days);
            processParam.put("destination", destination);
            processParam.put("empid", param.get("EMPID"));
            processParam.put("s_time", param.get("BT_FROM_TIME"));
            processParam.put("e_time", param.get("BT_TO_TIME"));
            processParam.put("applicant", chineseName);
            processParam.put("application_time", currentTime);
//            processParam.put("leader", deptLeaderId);
//            processParam.put("leader_lv2", upperDeptLeaderId);
            processParam.put("do_what", param.get("BT_CONTENT"));
            if (((Integer) returnMap.get("errcode")).intValue() == 0) {
                ProcessInstance processInstance = runtimeService.startProcessInstanceByKey("BusiTripProcess", processParam);
                String processID = processInstance.getProcessInstanceId();
                param.put("PROCESSID", processID);
                returnMap = this.infoAppDao.addBTApp(param);
                if (((Integer) returnMap.get("errcode")).intValue() != 0) {
                    runtimeService.deleteProcessInstance(processID, "发生异常，申请取消");
                }
                Execution execution = runtimeService.createExecutionQuery().processInstanceId(processInstance.getProcessInstanceId())
                    .activityId(BUSINESS_DATA_READY).singleResult();
                if(execution!=null){
                    runtimeService.signal(execution.getId());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnMap.put("errcode", new Integer(1));
            returnMap.put("errmsg", e.toString());
        }
        return returnMap;
    }

    /**
     * 漏卡申请 (non-Javadoc)
     * @see com.siping.ess.service.InfoAppSer#addCardtimeApp(javax.servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map addCardtimeApp(HttpServletRequest request) {
        Map returnMap = new LinkedHashMap<Object, Object>();
        try {
            AdminBean admin = SessionUtil.getLoginUserFromSession(request);
            Map param = ObjectBindUtil.getRequestParamData(request);
            param.put("CREATED_BY", admin.getAdminID());
            String attendanceDate = param.get("ATTENDANCETIME").toString().substring(0, 10);
            param.put("ATTENDANCEDATE", attendanceDate);
            returnMap = this.essAppCheckDao.cardAppChecker(param);
            Map processParam = new LinkedHashMap<String, Object>();
//            String deptLeaderId = this.infoAppDao.getDeptLeaderId(param.get("EMPID"));
//            String upperDeptLeaderId = this.infoAppDao.getUpperDeptLeaderId(param.get("EMPID"));
            String chineseName = this.infoAppDao.getChineseNameById(param.get("EMPID"));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String currentTime = formatter.format(new Date());
            processParam.put("application_time", currentTime);
            processParam.put("inOrOutMarking", "");
            processParam.put("attendanceDate", attendanceDate);
            processParam.put("empid", param.get("EMPID"));
            processParam.put("applicant", chineseName);
            processParam.put("applyReason", param.get("APPLYREASON"));
//            processParam.put("lv01_leader", deptLeaderId);
//            processParam.put("lv02_leader", upperDeptLeaderId);
            if (((Integer) returnMap.get("errcode")).intValue() == 0) {
                ProcessInstance processInstance = runtimeService.startProcessInstanceByKey("CardtimeProcess", processParam);
                String processID = processInstance.getProcessInstanceId();
                param.put("PROCESSID", processID);
                returnMap = this.infoAppDao.addCardtimeApp(param);
                if (((Integer) returnMap.get("errcode")).intValue() != 0) {
                    runtimeService.deleteProcessInstance(processID, "发生异常，申请取消");
                }
                Execution execution = runtimeService.createExecutionQuery().processInstanceId(processInstance.getProcessInstanceId())
                    .activityId(BUSINESS_DATA_READY).singleResult();
                if(execution!=null){
                    runtimeService.signal(execution.getId());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnMap.put("errcode", new Integer(1));
            returnMap.put("errmsg", e.toString());
        }
        return returnMap;
    }

    /**
     * 费用申请 (non-Javadoc)
     * @see com.siping.ess.service.InfoAppSer#addExpApp(javax.servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map addExpApp(HttpServletRequest request) {
        Map returnMap = new LinkedHashMap<Object, Object>();
        try {
            AdminBean admin = SessionUtil.getLoginUserFromSession(request);
            Map param = ObjectBindUtil.getRequestParamData(request);
            param.put("CREATED_BY", admin.getAdminID());
            LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
            appendMap.put("CREATED_BY", admin.getAdminID());
            // String jsonString = request.getParameter("jsonData");
            // List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
            // .getRequestJsonData(jsonString, appendMap);
            returnMap = this.essAppCheckDao.expAppChecker(param);
            Map processParam = new LinkedHashMap<String, Object>();
//            String deptLeaderId = this.infoAppDao.getDeptLeaderId(param.get("EMPID"));
//            String upperDeptLeaderId = this.infoAppDao.getUpperDeptLeaderId(param.get("EMPID"));
            String chineseName = this.infoAppDao.getChineseNameById(param.get("EMPID"));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String currentTime = formatter.format(new Date());
            processParam.put("application_time", currentTime);
            processParam.put("feesAmount", param.get("moneyamount"));
            processParam.put("purpose", param.get("EXP_REMARK"));
            processParam.put("empid", param.get("EMPID"));
            processParam.put("applicant", chineseName);
//            processParam.put("lv01_leader", deptLeaderId);
//            processParam.put("lv02_leader", upperDeptLeaderId);
            if (((Integer) returnMap.get("errcode")).intValue() == 0) {
                ProcessInstance processInstance = runtimeService.startProcessInstanceByKey("FeesProcess", processParam);
                String processID = processInstance.getProcessInstanceId();
                param.put("PROCESSID", processID);
                returnMap = this.infoAppDao.addExpApp(param);
                if (((Integer) returnMap.get("errcode")).intValue() != 0) {
                    runtimeService.deleteProcessInstance(processID, "发生异常，申请取消");
                }
                Execution execution = runtimeService.createExecutionQuery().processInstanceId(processInstance.getProcessInstanceId())
                    .activityId(BUSINESS_DATA_READY).singleResult();
                if(execution!=null){
                    runtimeService.signal(execution.getId());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnMap.put("errcode", new Integer(1));
            returnMap.put("errmsg", e.toString());
        }
        return returnMap;
    }

    /**
     * 休假申请 (non-Javadoc)
     * @see com.siping.ess.service.InfoAppSer#addLeaveApp(javax.servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map addLeaveApp(HttpServletRequest request) {
        Map returnMap = new LinkedHashMap<Object, Object>();
        try {
            AdminBean admin = SessionUtil.getLoginUserFromSession(request);
            Map param = ObjectBindUtil.getRequestParamData(request);
            param.put("CREATED_BY", admin.getAdminID());
            returnMap = this.essAppCheckDao.leaveAppChecker(param);

            if (((Integer) returnMap.get("errcode")).intValue() == 0) {
                Map processParam = new LinkedHashMap<String, Object>();
                SimpleDateFormat format = new SimpleDateFormat("yyyy-M-dd HH:mm");
                Date s_date = format.parse(param.get("LEAVE_FROM_TIME").toString());
                Date e_date = format.parse(param.get("LEAVE_TO_TIME").toString());
                long times = e_date.getTime() - s_date.getTime();
                long days = (long) Math.round(times / 1000 / 3600 / 24);

                String chineseName = this.infoAppDao.getChineseNameById(param.get("EMPID"));
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                String currentTime = formatter.format(new Date());
                processParam.put("application_time", currentTime);
                processParam.put("S_DATE", param.get("LEAVE_FROM_TIME"));
                processParam.put("E_DATE", param.get("LEAVE_TO_TIME"));
                processParam.put("EMPID", param.get("EMPID"));
                processParam.put("DAYS", days);
                processParam.put("reason", param.get("LEAVE_REASON"));
                processParam.put("applicant", chineseName);

                ProcessInstance processInstance = runtimeService.startProcessInstanceByKey("LeaveProcess", processParam);
                String processID = processInstance.getProcessInstanceId();
                param.put("PROCESSID", processID);
                returnMap = this.infoAppDao.addLeaveApp(param, true);
                if (((Integer) returnMap.get("errcode")).intValue() != 0) {
                    runtimeService.deleteProcessInstance(processID, "发生异常，申请取消");
                }
                Execution execution = runtimeService.createExecutionQuery().processInstanceId(processInstance.getProcessInstanceId())
                    .activityId(BUSINESS_DATA_READY).singleResult();
                if(execution!=null){
                    runtimeService.signal(execution.getId());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnMap.put("errcode", new Integer(1));
            returnMap.put("errmsg", e.toString());
        }
        return returnMap;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public double getEmpVacationRema10(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        String empID = request.getParameter("empID");
        Map obj = new LinkedHashMap();
        obj.put("empID", StringUtil.checkNull(empID, admin.getAdminID()));
        obj.put("arItemNo", "22");
        obj.put("leaveFromTime", DateUtil.getSysdateString("yyyy-MM-dd HH:mm"));
        obj.put("vacTp", "VacType10");
        return this.infoAppDao.getEmpVacationRema(obj);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public double getEmpVacationRema30(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        String empID = request.getParameter("empID");
        Map obj = new LinkedHashMap();
        obj.put("empID", StringUtil.checkNull(empID, admin.getAdminID()));

        obj.put("leaveFromTime", DateUtil.getSysdateString("yyyy-MM-dd HH:mm"));
        obj.put("arItemNo", "37");
        obj.put("vacTp", "VacType30");
        return this.infoAppDao.getEmpVacationRema(obj);
    }

    /**
     * 培训申请 (non-Javadoc)
     * @see com.siping.ess.service.InfoAppSer#addTrainingApp(javax.servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public boolean addTrainingApp(HttpServletRequest request) {
        Map param = ObjectBindUtil.getRequestParamData(request);
        // if(vladate(param))//验证
        try {
            this.infoAppDao.addTrainingApp(param);
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    /**
     * 项目信息 (non-Javadoc)
     * @see com.siping.ess.service.InfoAppSer#updateProInfo(javax.servlet.http.HttpServletRequest)
     */
    @Override
    public String updateProInfo(HttpServletRequest request) {
        String returnString = "Y";
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("UPDATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());

        String jsonString = request.getParameter("jsonData");

        List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, appendMap);
        try {
            checkUpdateProDate(updateList);
        } catch (Exception e) {
            e.printStackTrace();
            return e.getMessage();
        }
        returnString = this.infoAppDao.updateProInfo(updateList);

        return returnString;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    private void checkUpdateProDate(List<LinkedHashMap<String, Object>> updateList) throws Exception {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        for(int i=0;i<updateList.size();i++){
            Map param = new LinkedHashMap<Object, Object>();
            param.put("PRO_NO",updateList.get(i).get("PRO_NO"));
            List<LinkedHashMap<String, String>> expectDate = this.infoAppDao.getStartAndEndDate(param);
            Date proMinStartDate = df.parse(expectDate.get(0).get("START_DATE"));
            Date proMaxEndDate = df.parse(expectDate.get(0).get("END_DATE"));
            if(proMinStartDate.getTime()<df.parse((String)updateList.get(i).get("START_DATE")).getTime()||proMaxEndDate.getTime()>df.parse((String)updateList.get(i).get("END_DATE")).getTime()){
                throw new Exception("项目修改日期不应超过人员日期!");
            }
        }
        
    }
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String addProInfo(HttpServletRequest request) {
        String returnString = "Y";
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paraMap = ObjectBindUtil.getRequestParamData(request);
        paraMap.remove("jsonData");
        paraMap.put("CREATED_BY", admin.getAdminID());
        paraMap.put("CPNY_ID", admin.getCpnyId());

        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("CREATED_BY", admin.getAdminID());

        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> proMemberList = ObjectBindUtil.getRequestJsonData(jsonString, appendMap);
        paraMap.put("proMemberList", proMemberList);
        try {
            CheckAddProDate(paraMap,proMemberList);
        } catch (Exception e) {
            e.printStackTrace();
            return e.getMessage();
        }
        returnString = this.infoAppDao.addProInfo(paraMap);
        return returnString;
    }

    @SuppressWarnings("rawtypes")
    private void CheckAddProDate(Map paraMap,List<LinkedHashMap<String, Object>> proMemberList) throws Exception{
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            Date proStartDate = df.parse((String)paraMap.get("START_DATE"));
            Date proEndDate = df.parse((String)paraMap.get("END_DATE"));
        for(int i=0;i<proMemberList.size();i++){
            if(proStartDate.getTime()> df.parse((String)proMemberList.get(i).get("START_DATE")).getTime()||proEndDate.getTime()<df.parse((String)proMemberList.get(i).get("END_DATE")).getTime()){
                throw new Exception("人员日期不应超过项目日期!");
            }
        }
    }
    
    @Override
    public String addProMemberInfo(HttpServletRequest request) {
        String returnString = "Y";
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("CREATED_BY", admin.getAdminID());
        appendMap.put("UPDATED_BY", admin.getAdminID());

        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> proMemberAddList = ObjectBindUtil.getRequestJsonData(jsonString, "add", appendMap);
        List<LinkedHashMap<String, Object>> proMemberUpdateList = ObjectBindUtil.getRequestJsonData(jsonString, "update", appendMap);
        if (proMemberAddList.size() > 0) {
            returnString = this.infoAppDao.addProMemberInfo(proMemberAddList);
        }
        if(!returnString.equals("Y")) return returnString;//此前逻辑存在错误，添加上这一行，在后面抛异常的时候终止程序运行;
        if (proMemberUpdateList.size() > 0) {
            returnString = this.infoAppDao.updateProMemberInfo(proMemberUpdateList);
        }
        return returnString;
    }

    /**
     * 工时申请 (non-Javadoc)
     * @see com.siping.ess.service.InfoAppSer#saveWorkingHoursInfo(javax.servlet.http.HttpServletRequest)
     */
    @SuppressWarnings("rawtypes")
    @Override
    public Map saveWorkingHoursInfo(HttpServletRequest request) {
        Map returnMap = new LinkedHashMap<Object, Object>();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("CREATED_BY", admin.getAdminID());
        appendMap.put("UPDATED_BY", admin.getAdminID());
        appendMap.put("EMPID", admin.getAdminID());

        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil.getRequestJsonData(jsonString, "add", appendMap);
        List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, "update", appendMap);
        LinkedHashMap<String, Object> paraMap = new LinkedHashMap<String, Object>();
        paraMap.put("EMPID", admin.getAdminID());
        if (insertList.size() > 0) {
            paraMap.put("flag", "add");
            paraMap.put("dataList", insertList);
            returnMap = this.essAppCheckDao.whAppChecker(paraMap);
            if (((Integer) returnMap.get("errcode")).intValue() == 0) {
                returnMap = this.infoAppDao.saveWorkingHoursInfo(insertList);
            }
        }
        if (updateList.size() > 0) {
            paraMap.put("flag", "update");
            paraMap.put("dataList", updateList);
            returnMap = this.essAppCheckDao.whAppChecker(paraMap);
            if (((Integer) returnMap.get("errcode")).intValue() == 0) {
                returnMap = this.infoAppDao.updateWorkingHoursInfo(updateList);
            }
        }

        return returnMap;
    }

    /**
     * 工时申请 (non-Javadoc)
     * @see com.siping.ess.service.InfoAppSer#updateWorkingHoursInfo(javax.servlet.http.HttpServletRequest)
     */
    @SuppressWarnings("rawtypes")
    @Override
    public Map updateWorkingHoursInfo(HttpServletRequest request) {
        Map returnMap = new LinkedHashMap<Object, Object>();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("UPDATED_BY", admin.getAdminID());

        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, appendMap);

        LinkedHashMap<String, Object> paraMap = new LinkedHashMap<String, Object>();
        if (updateList.size() > 0) {
            paraMap.put("flag", "update");
            paraMap.put("EMPID", updateList.get(0).get("EMPID"));
            paraMap.put("dataList", updateList);
            returnMap = this.essAppCheckDao.whAppChecker(paraMap);
            if (((Integer) returnMap.get("errcode")).intValue() == 0) {
                returnMap = this.infoAppDao.updateWorkingHoursInfo(updateList);
            }
        }
        return returnMap;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public boolean isWhManager(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("ADMINID", admin.getAdminID());
        paramMap.put("SCREEN_GRANT_ID", "18");

        return this.infoAppDao.isWhManager(paramMap);
    }

    @SuppressWarnings({ "rawtypes" })
    public String getWhCalendarInfoHtml(HttpServletRequest request) {
        String frist = "";
        String Default = "";

        String actionType = ObjectUtils.toString(request.getParameter("actionType"));

        List calendarList = this.getCompanyCalendarInfo(request);
        if (calendarList.size() > 0) {
            String temp = this.getFrist(calendarList, actionType, request);
            int out = Integer.parseInt(temp.substring(temp.lastIndexOf("*") + 1, temp.length()));
            frist = temp.substring(0, temp.lastIndexOf("*"));
            Default = this.getDefault(out, calendarList, actionType, request);
        }

        return frist + Default;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List getCompanyCalendarInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();

        String arMonth = "";
        String year = ObjectUtils.toString(request.getParameter("year"));
        String month = ObjectUtils.toString(request.getParameter("month"));

        if (year == null || year.length() == 0) {
            year = DateUtil.getSysdateString("yyyy");
            month = DateUtil.getSysdateString("MM");
        }
        arMonth = year + month;

        LinkedHashMap paramMap = new LinkedHashMap();

        paramMap.put("AR_MONTH", arMonth);
        paramMap.put("language", Messages.getLanguage(request));

        retrunList = this.companyCalendarDao.getCompanyCalendarInfo(paramMap);

        return retrunList;
    }

    @SuppressWarnings({ "rawtypes" })
    private String getFrist(List calendarList, String actionType, HttpServletRequest request) {

        String frist = "";
        int out = 0;

        // 得到第1天是星期几
        LinkedHashMap calendarMap0 = (LinkedHashMap) calendarList.get(0);
        out = 7 - NumberUtils.parseNumber(calendarMap0.get("IWEEK").toString(), Integer.class);

        for (int i = 0; i < 7 - out; ++i) {
            frist += "<td>&nbsp;</td>";
        }

        for (int i = 0; i < out; i++) {
            LinkedHashMap calendarMap = (LinkedHashMap) calendarList.get(i);

            frist += this.createCalendarHtml(calendarMap, actionType, request);
        }

        return "<tr>" + frist + "</tr>*" + out;
    }

    @SuppressWarnings({ "rawtypes" })
    private String getDefault(int out, List calendarList, String actionType, HttpServletRequest request) {

        int r = 0;
        int rows = 0;
        if ((calendarList.size() - out) % 7 != 0) {// 算出 剩余的有几行
            rows = (calendarList.size() - out) / 7 + 1;
        } else {
            rows = (calendarList.size() - out) / 7;
        }
        rows = rows * 7;// 总共多少格子
        rows = rows - (calendarList.size() - out);// 到最后一行剩余几格子
        String Default = "";
        for (int i = out; i < calendarList.size(); i++) {
            LinkedHashMap calendarMap = (LinkedHashMap) calendarList.get(i);
            if (r == 0 || r == 7 || r == 14 || r == 21 || r == 28) {// 加换行
                Default += "<tr>";
            }

            Default += this.createCalendarHtml(calendarMap, actionType, request);

            if (r == 6 || r == 13 || r == 20 || r == 27 || r == 34) {// 加换行
                Default += "</tr>";
            }
            r += 1;
        }
        // 补空格
        if (rows > 0) {
            String temp = "";
            for (int i = 0; i < rows; i++) {
                temp += "<td>&nbsp;</td>";
            }
            Default += temp + "</tr>";
        }
        return Default;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    private String createCalendarHtml(LinkedHashMap calendarMap, String actionType, HttpServletRequest request) {
        String calendarHtml = "";
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paraMap = ObjectBindUtil.getRequestParamData(request);
        if (paraMap != null && paraMap.get("EMPID") != null && paraMap.get("EMPID").toString() != null && (!paraMap.get("EMPID").toString().equals(""))) {
            calendarMap.put("EMPID", paraMap.get("EMPID").toString());
        } else {
            calendarMap.put("EMPID", admin.getAdminID());
        }

        calendarHtml += "<td height='25px;' width='14%' valign='middle' >";
        calendarHtml += "<table width='98.8%' border='0' cellspacing='0' cellpadding='0' onclick='spf_showDetailData(\"" + calendarMap.get("EMPID") + "\",\"" + calendarMap.get("DDATE_STR")
            + "\")' style=\"cursor: pointer;\">";

        String whItem = "";
        if (true) {
            double whTotal = 0.0;
            // double whTotal = this.infoAppDao.getEmpWhTotalInfo(calendarMap);
            List<Map> whinfo = this.infoAppDao.getEmpWhItemInfo(calendarMap);
            if (whinfo != null) {
                if (whinfo.size() > 0) {
                    whItem = "[";
                    for (Map whMap : whinfo) {
                        whTotal += Double.parseDouble(whMap.get("WH_CNT").toString());
                        whItem += whMap.get("WH_ITEM").toString();
                    }
                    whItem = whItem + "]";
                }
            } else {
                whItem = "[无]";
            }
            double leavlTotal = this.infoAppDao.getEmpLeavlTotalInfo(calendarMap);
            calendarHtml += "<tr><td height=\"4\"></td></tr>";
            if (whTotal >= 8) {
                calendarHtml += "<tr><td align=\"center\" colspan=\"2\" style=\"font-size: 12px;color: green;\">" + "" + whTotal + "(H)" + "</td></tr>";
            } else if (whTotal > 0 && whTotal < 8) {
                if (leavlTotal > 0 && leavlTotal <= 8) {
                    calendarHtml += "<tr><td align=\"center\" colspan=\"2\" style=\"font-size: 12px;color: purple;font-weight: bold;\">" + "" + whTotal + "(H)"
                        + "&nbsp;&nbsp;&nbsp;<font style=\"font-size: 12px;color: green;font-weight: bold;\">" + leavlTotal + "(L)</font>" + "</td></tr>";
                } else if (leavlTotal > 8) {
                    calendarHtml += "<tr><td align=\"center\" colspan=\"2\" style=\"font-size: 12px;color: purple;font-weight: bold;\">" + "" + whTotal + "(H)"
                        + "&nbsp;&nbsp;&nbsp;<font style=\"font-size: 12px;color: green;font-weight: bold;\">" + leavlTotal + "(L)</font>" + "</td></tr>";
                } else {
                    calendarHtml += "<tr><td align=\"center\" colspan=\"2\" style=\"font-size: 12px;color: purple;font-weight: bold;\">" + "" + whTotal + "(H)" + "&nbsp;&nbsp;&nbsp;" + leavlTotal
                        + "(L)" + "</td></tr>";
                }
            } else {
                if (leavlTotal > 0 && leavlTotal <= 8) {
                    calendarHtml += "<tr><td align=\"center\" colspan=\"2\" style=\"font-size: 12px;color: red;\">" + "" + whTotal + "(H)"
                        + "&nbsp;&nbsp;&nbsp;<font style=\"font-size: 12px;color: purple;font-weight: bold;\">" + leavlTotal + "(L)</font>" + "</td></tr>";
                } else if (leavlTotal > 8) {
                    calendarHtml += "<tr><td align=\"center\" colspan=\"2\" style=\"font-size: 12px;color: red;\">" + "" + whTotal + "(H)"
                        + "&nbsp;&nbsp;&nbsp;<font style=\"font-size: 12px;color: green;font-weight: bold;\">" + leavlTotal + "(L)</font>" + "</td></tr>";
                } else {
                    calendarHtml += "<tr><td align=\"center\" colspan=\"2\" style=\"font-size: 12px;color: red;\">" + "" + whTotal + "(H)" + "&nbsp;&nbsp;&nbsp;" + leavlTotal + "(L)" + "</td></tr>";
                }
            }
        }

        calendarHtml += "<tr><td style=\"font-size: 12px;\">"
            + this.getDayColor(NumberUtils.parseNumber(calendarMap.get("IDAY").toString(), Integer.class), NumberUtils.parseNumber(calendarMap.get("IWEEK").toString(), Integer.class)) + "</td>";
        calendarHtml += "<td height='6' style=\"font-size: 12px;\">";
        calendarHtml += calendarMap.get("TYPE_NAME").toString() + "</td></tr>";
        calendarHtml += "<tr><td height=\"6\" align=\"center\" colspan=\"2\" style=\"font-size: 12px;\">";
        calendarHtml += whItem + "</td>";
        calendarHtml += "</tr><tr><td height=\"4\"></td></tr>";
        calendarHtml += "</table></td>";

        // calendarHtml += "<tr><td style=\"font-size: 12px;\">"
        // + this.getDayColor(NumberUtils.parseNumber(
        // calendarMap.get("IDAY").toString(), Integer.class),
        // NumberUtils.parseNumber(calendarMap.get("IWEEK")
        // .toString(), Integer.class)) + "</td>";
        // calendarHtml += "<td height='6' style=\"font-size: 12px;\">";
        // calendarHtml += this.getWorkName(NumberUtils.parseNumber(calendarMap
        // .get("WORKDAYFLAG").toString(), Integer.class),
        // Messages.getLanguage(request))
        // + "</td></tr>";
        // calendarHtml += "<tr><td height=\"6\" style=\"font-size: 12px;\">";
        // calendarHtml += calendarMap.get("TYPE_NAME").toString()
        // + "</td><td height=\"6\" style=\"font-size: 12px;\">";
        // calendarHtml += calendarMap.get("SHIFT_NAME").toString() +
        // "</td></tr><tr><td height=\"4\"></td></tr>";
        // calendarHtml += "</table></td>";

        return calendarHtml;
    }

    @SuppressWarnings({ "rawtypes", "unchecked", "unused" })
    private String createCalendarHtmlB(LinkedHashMap calendarMap, String actionType, HttpServletRequest request) {
        String calendarHtml = "";
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paraMap = ObjectBindUtil.getRequestParamData(request);
        if (paraMap != null && paraMap.get("EMPID") != null && paraMap.get("EMPID").toString() != null && (!paraMap.get("EMPID").toString().equals(""))) {
            calendarMap.put("EMPID", paraMap.get("EMPID").toString());
        } else {
            calendarMap.put("EMPID", admin.getAdminID());
        }

        calendarHtml += "<td height='25px;' width='14%' valign='middle' >";
        calendarHtml += "<table width='98.8%' border='0' cellspacing='0' cellpadding='0' onclick='spf_showDetailData(\"" + calendarMap.get("EMPID") + "\",\"" + calendarMap.get("DDATE_STR")
            + "\")' style=\"cursor: pointer;\">";

        String whItem = "";
        if (true) {
            double whTotal = 0.0;
            // double whTotal = this.infoAppDao.getEmpWhTotalInfo(calendarMap);
            List<Map> whinfo = this.infoAppDao.getEmpWhItemInfo(calendarMap);
            if (whinfo != null) {
                if (whinfo.size() > 0) {
                    whItem = "[";
                    for (Map whMap : whinfo) {
                        whTotal += Double.parseDouble(whMap.get("WH_CNT").toString());
                        whItem += whMap.get("WH_ITEM").toString();
                    }
                    whItem = whItem + "]";
                }
            } else {
                whItem = "[无]";
            }
            double leavlTotal = this.infoAppDao.getEmpLeavlTotalInfo(calendarMap);
            calendarHtml += "<tr><td height=\"4\"></td></tr>";
            if (whTotal >= 8) {
                calendarHtml += "<tr><td align=\"center\" colspan=\"2\" style=\"font-size: 12px;color: green;\">" + "" + whTotal + "(H)" + "</td></tr>";
            } else if (whTotal > 0 && whTotal < 8) {
                if (leavlTotal > 0 && leavlTotal <= 8) {
                    calendarHtml += "<tr><td align=\"center\" colspan=\"2\" style=\"font-size: 12px;color: purple;font-weight: bold;\">" + "" + whTotal + "(H)"
                        + "&nbsp;&nbsp;&nbsp;<font style=\"font-size: 12px;color: green;font-weight: bold;\">" + leavlTotal + "(L)</font>" + "</td></tr>";
                } else if (leavlTotal > 8) {
                    calendarHtml += "<tr><td align=\"center\" colspan=\"2\" style=\"font-size: 12px;color: purple;font-weight: bold;\">" + "" + whTotal + "(H)"
                        + "&nbsp;&nbsp;&nbsp;<font style=\"font-size: 12px;color: green;font-weight: bold;\">" + leavlTotal + "(L)</font>" + "</td></tr>";
                } else {
                    calendarHtml += "<tr><td align=\"center\" colspan=\"2\" style=\"font-size: 12px;color: purple;font-weight: bold;\">" + "" + whTotal + "(H)" + "&nbsp;&nbsp;&nbsp;" + leavlTotal
                        + "(L)" + "</td></tr>";
                }
            } else {
                if (leavlTotal > 0 && leavlTotal <= 8) {
                    calendarHtml += "<tr><td align=\"center\" colspan=\"2\" style=\"font-size: 12px;color: red;\">" + "" + whTotal + "(H)"
                        + "&nbsp;&nbsp;&nbsp;<font style=\"font-size: 12px;color: purple;font-weight: bold;\">" + leavlTotal + "(L)</font>" + "</td></tr>";
                } else if (leavlTotal > 8) {
                    calendarHtml += "<tr><td align=\"center\" colspan=\"2\" style=\"font-size: 12px;color: red;\">" + "" + whTotal + "(H)"
                        + "&nbsp;&nbsp;&nbsp;<font style=\"font-size: 12px;color: green;font-weight: bold;\">" + leavlTotal + "(L)</font>" + "</td></tr>";
                } else {
                    calendarHtml += "<tr><td align=\"center\" colspan=\"2\" style=\"font-size: 12px;color: red;\">" + "" + whTotal + "(H)" + "&nbsp;&nbsp;&nbsp;" + leavlTotal + "(L)" + "</td></tr>";
                }
            }
        }

        calendarHtml += "<tr><td style=\"font-size: 12px;\">"
            + this.getDayColor(NumberUtils.parseNumber(calendarMap.get("IDAY").toString(), Integer.class), NumberUtils.parseNumber(calendarMap.get("IWEEK").toString(), Integer.class)) + "</td>";
        calendarHtml += "<td height='6' style=\"font-size: 12px;\">";
        calendarHtml += calendarMap.get("TYPE_NAME").toString() + "</td></tr>";
        calendarHtml += "<tr><td height=\"6\" align=\"center\" colspan=\"2\" style=\"font-size: 12px;\">";
        calendarHtml += whItem + "</td>";
        calendarHtml += "</tr><tr><td height=\"4\"></td></tr>";
        calendarHtml += "</table></td>";

        // calendarHtml += "<tr><td style=\"font-size: 12px;\">"
        // + this.getDayColor(NumberUtils.parseNumber(
        // calendarMap.get("IDAY").toString(), Integer.class),
        // NumberUtils.parseNumber(calendarMap.get("IWEEK")
        // .toString(), Integer.class)) + "</td>";
        // calendarHtml += "<td height='6' style=\"font-size: 12px;\">";
        // calendarHtml += this.getWorkName(NumberUtils.parseNumber(calendarMap
        // .get("WORKDAYFLAG").toString(), Integer.class),
        // Messages.getLanguage(request))
        // + "</td></tr>";
        // calendarHtml += "<tr><td height=\"6\" style=\"font-size: 12px;\">";
        // calendarHtml += calendarMap.get("TYPE_NAME").toString()
        // + "</td><td height=\"6\" style=\"font-size: 12px;\">";
        // calendarHtml += calendarMap.get("SHIFT_NAME").toString() +
        // "</td></tr><tr><td height=\"4\"></td></tr>";
        // calendarHtml += "</table></td>";

        return calendarHtml;
    }

    @SuppressWarnings("unused")
    private String getweekName(int i, String language) {
        String weekName = null;
        switch (i) {
            case 0:
                weekName = "<font color=\"red\" style=\"font-size: 12px;\">日</font>";
                break;
            case 1:
                weekName = "一";
                break;
            case 2:
                weekName = "二";
                break;
            case 3:
                weekName = "三";
                break;
            case 4:
                weekName = "四";
                break;
            case 5:
                weekName = "五";
                break;
            case 6:
                weekName = "<font color=\"red\" style=\"font-size: 12px;\">六</font>";
                break;
        }

        return weekName;
    }

    @SuppressWarnings("unused")
    private String getWorkName(int i, String language) {
        if (language != null && language.equals("zh")) {
            if (i == 0)
                return "不工作";
            else
                return "工作";
        } else if (language != null && language.equals("ko")) {

        } else {
            if (i == 0)
                return "Rest Day";
            else
                return "Work Day";
        }
        return "";
    }

    private String getDayColor(int day, int week) {
        String daycolor = null;
        switch (week) {
            case 0:
                daycolor = "<font color=\"red\" style=\"font-size: 12px;\">" + day + "</font>";
                break;
            case 1:
                daycolor = Integer.toString(day);
                break;
            case 2:
                daycolor = Integer.toString(day);
                break;
            case 3:
                daycolor = Integer.toString(day);
                break;
            case 4:
                daycolor = Integer.toString(day);
                break;
            case 5:
                daycolor = Integer.toString(day);
                break;
            case 6:
                daycolor = "<font color=\"red\" style=\"font-size: 12px;\">" + day + "</font>";
                break;
        }
        return daycolor;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map addToolApp(HttpServletRequest request) {
        Map returnMap = new LinkedHashMap<Object, Object>();
        try {
            AdminBean admin = SessionUtil.getLoginUserFromSession(request);
            Map param = ObjectBindUtil.getRequestParamData(request);
            param.put("CREATED_BY", admin.getAdminID());
            returnMap = this.essAppCheckDao.toolAppChecker(param);
            Map processParam = new LinkedHashMap<String, Object>();
//            String deptLeaderId = this.infoAppDao.getDeptLeaderId(param.get("EMPID"));
//            String upperDeptLeaderId = this.infoAppDao.getUpperDeptLeaderId(param.get("EMPID"));
            String chineseName = this.infoAppDao.getChineseNameById(param.get("EMPID"));
            String toolName = param.get("TOOL_TYPE_CODE").toString();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String currentTime = formatter.format(new Date());
            processParam.put("application_time", currentTime);
            processParam.put("TOOLNAME", toolName);
            processParam.put("BO_DATE", param.get("BORROW_DATE"));
            processParam.put("RE_DATE", param.get("RETURN_DATE"));
            processParam.put("REASON", param.get("TOOL_CONTENT"));
            processParam.put("EMPID", param.get("EMPID"));
            processParam.put("applicant", chineseName);
//            processParam.put("LV01_ASSIGNER", deptLeaderId);// 直属领导
//            processParam.put("LV02_ASSIGNER", upperDeptLeaderId);// 上级部门领导
            if (((Integer) returnMap.get("errcode")).intValue() == 0) {
                ProcessInstance processInstance = runtimeService.startProcessInstanceByKey("ToolProcess", processParam);
                String processID = processInstance.getProcessInstanceId();
                param.put("PROCESSID", processID);
                returnMap = this.infoAppDao.addToolApp(param);
                if (((Integer) returnMap.get("errcode")).intValue() != 0) {
                    runtimeService.deleteProcessInstance(processID, "发生异常，申请取消");
                }
                Execution execution = runtimeService.createExecutionQuery().processInstanceId(processInstance.getProcessInstanceId())
                    .activityId(BUSINESS_DATA_READY).singleResult();
                if(execution!=null){
                    runtimeService.signal(execution.getId());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnMap.put("errcode", new Integer(1));
            returnMap.put("errmsg", e.toString());
        }
        return returnMap;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map addToolAppAss(HttpServletRequest request) {
        Map returnMap = new LinkedHashMap<Object, Object>();
        try {
            AdminBean admin = SessionUtil.getLoginUserFromSession(request);
            Map param = ObjectBindUtil.getRequestParamData(request);
            param.put("CREATED_BY", admin.getAdminID());
            returnMap = this.essAppCheckDao.toolAppChecker(param);
            if (((Integer) returnMap.get("errcode")).intValue() == 0) {
                returnMap = this.infoAppDao.addToolAppAss(param);
            }
        } catch (Exception e) {
            e.printStackTrace();
            returnMap.put("errcode", new Integer(1));
            returnMap.put("errmsg", e.toString());
        }
        return returnMap;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getToolLoan(HttpServletRequest request) {
        Map param = ObjectBindUtil.getRequestParamData(request);
        param.put("language", Messages.getLanguage(request));
        return this.infoAppDao.getToolLoan(param);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map transferWorkingHoursInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map returnMap = new LinkedHashMap<Object, Object>();
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("EMPID", admin.getAdminID());
        Object obj = paramMap.get("type");
        if(obj.equals("add")){
            returnMap = this.infoAppDao.saveWorkingHoursInfoB(paramMap);
        } else if(obj.equals("update")){
            returnMap = this.infoAppDao.updateWorkingHoursInfoB(paramMap);
        }
        return returnMap;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public Object getWhDetail(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));

        return this.infoAppDao.getWhDetail(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String addProductionOrderInfo(HttpServletRequest request) {
        String returnString = "Y";
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paraMap = ObjectBindUtil.getRequestParamData(request);

        paraMap.put("CREATED_BY", admin.getAdminID());
        paraMap.put("CPNY_ID", admin.getCpnyId());

        returnString = this.infoAppDao.addProductionOrderInfo(paraMap);

        return returnString;
    }

    @Override
    public String updateProductionOrderInfo(HttpServletRequest request) {
        String returnString = "Y";
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("UPDATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());

        String jsonString = request.getParameter("jsonData");

        List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, appendMap);

        returnString = this.infoAppDao.updateProductionOrderInfo(updateList);

        return returnString;
    }

    @Override
    public String deleteProductionOrderInfo(HttpServletRequest request) {
        String returnString = "Y";
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("UPDATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());

        String jsonString = request.getParameter("jsonData");

        List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, appendMap);

        returnString = this.infoAppDao.deleteProductionOrderInfo(updateList);

        return returnString;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String uploadProductionOrder(MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, ParseException {
        List paramList = new ArrayList();
        // 解析Excel
        HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
        HSSFSheet sheet = workbook.getSheetAt(0);
        HSSFRow row = null;
        Map map = new LinkedHashMap();
        int rowsnum = sheet.getPhysicalNumberOfRows();
        for (int i = 2; i < rowsnum; i++) {
            row = sheet.getRow(i);
            if (row != null) {
                map = this.getProductionOrderRowInfo(row);
            }
            if (map == null) {
                continue;
            }
            paramList.add(map);
        }
        // 将Excel里的内容添加进ESS_PRODUCTION_ORDER中
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("CREATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());
        LinkedHashMap<String, Object> requestParameter = ObjectBindUtil.getRequestParamData(request);
        ObjectBindUtil.getRequestListData(paramList, appendMap);
        ObjectBindUtil.getRequestListData(paramList, requestParameter);
        return this.infoAppDao.addProductionOrderInfo(paramList);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    private Map getProductionOrderRowInfo(HSSFRow row) {
        int columns = row.getPhysicalNumberOfCells();
        if (columns < 2) {
            return null;
        }
        HSSFCell cellProdId = row.getCell(0);
        HSSFCell cellDrawingNo = row.getCell(1);
        HSSFCell cellWeight = row.getCell(2);

        String prodId = "";
        String drawingNo = "";
        String weight = "";

        // 判断prodId是否为空
        if (cellProdId == null) {
            return null;
        }
        prodId = cellProdId.toString().trim();
        if ("".equals(prodId)) {
            return null;
        }
        // 判断drawingNo是否为空
        if (cellDrawingNo == null) {
            return null;
        }
        drawingNo = cellDrawingNo.toString().trim();
        if ("".equals(drawingNo)) {
            return null;
        }
        // 判断weight是否为空
        if (cellWeight == null) {
            return null;
        }
        weight = cellWeight.toString().trim();
        if ("".equals(weight)) {
            return null;
        }

        Map map = new LinkedHashMap();
        map.put("PROD_ID", prodId);
        map.put("DRAWING_NO", drawingNo);
        map.put("WEIGHT", weight);
        return map;
    }

    @Override
    public void downloadProductionOrderTemplate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String path = request.getSession().getServletContext().getRealPath("/resources/excel/productionOrder.xls");
        File file = new File(path);
        InputStream inputStream = new FileInputStream(file);
        String fileName = null;
        try {
            fileName = java.net.URLEncoder.encode("生产订单.xls", "UTF-8");
        } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
        }
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName=" + fileName);
        OutputStream outputStream = response.getOutputStream();
        byte[] b = new byte[1024];
        int length;
        while ((length = inputStream.read(b)) > 0) {
            outputStream.write(b, 0, length);
        }
        inputStream.close();
        outputStream.close();
    }

    @Override
    public String transferWorkingHoursInfoOther(HttpServletRequest request) {
        // TODO Auto-generated method stub
        return null;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public void calculateWhConclusion(HttpServletRequest request) throws SQLException {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        List<String> empList = this.infoAppDao.getAllEmpidList(paramMap);
        List conclusionList = new ArrayList();
        for (String empid: empList){
            Map conclusionMap = new LinkedHashMap();
            double totalWh = 0.0;
            paramMap.put("EMPID", empid);
            List personHwConclusionList = this.infoAppDao.getPersonHwConclusionList(paramMap);
            for(Object obj: personHwConclusionList){
                Map tmpMap = (Map)obj;
                Object weiNo = (Object) tmpMap.get("WEI_NO");
                if(weiNo!= null){
                    double wh = ((BigDecimal) tmpMap.get("WORK_HOUR")).doubleValue();
                    double weigh = ((BigDecimal) tmpMap.get("WEI_VALUE")).doubleValue();
                    double external = ((BigDecimal) tmpMap.get("EXTERNAL_WORK_HOUR")).doubleValue(); //外部项目绩效小时
                    double internal = ((BigDecimal) tmpMap.get("INTERNAL_WORK_HOUR")).doubleValue(); //内部项目绩效小时
                    conclusionMap.put("WEI_"+weiNo.toString()+"_HOUR", wh);
                    conclusionMap.put("WEI_"+weiNo.toString()+"_DAY", wh/8);
                    conclusionMap.put("WEI_"+5+"_HOUR", external);
                    conclusionMap.put("WEI_"+5+"_DAY", external/8); //外部项目绩效日
                    conclusionMap.put("WEI_"+6+"_HOUR", internal);
                    conclusionMap.put("WEI_"+6+"_DAY", internal/8); //内部项目绩效日
                    totalWh = totalWh + weigh*wh;
                }
            }
            conclusionMap.put("TOTAL_WH", totalWh);
            conclusionMap.put("TOTAL_WD", totalWh/8);
            conclusionMap.put("EMPID", empid);
            conclusionMap.put("MONTH", paramMap.get("MONTH"));
            conclusionList.add(conclusionMap);
        }
        this.infoAppDao.addWhConclusion(conclusionList);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getWhConclusionList(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return this.infoAppDao.getWhConclusionList(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public int getWhConclusionListCnt(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return this.infoAppDao.getWhConclusionListCnt(paramMap);
    }
}
