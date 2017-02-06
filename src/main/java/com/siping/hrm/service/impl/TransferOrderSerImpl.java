package com.siping.hrm.service.impl;

import java.io.UnsupportedEncodingException;
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
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.ess.dao.InfoAppDao;
import com.siping.hrm.dao.PositionMgtDao;
import com.siping.hrm.dao.TransferOrderDao;
import com.siping.hrm.service.TransferOrderSer;
import com.siping.report.util.FillComputerManager;
import com.siping.report.util.Layouter;
import com.siping.report.util.Writer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class TransferOrderSerImpl implements TransferOrderSer {

    private static final String BUSINESS_DATA_READY = "businessDataReady";

    Logger logger = Logger.getLogger(TransferOrderSerImpl.class);

    @Autowired
    private TransferOrderDao transferOrderDao;

    @Autowired
    private PositionMgtDao positionMgtDao;

    @Autowired
    private InfoAppDao infoAppDao;

    @Autowired
    private RuntimeService runtimeService;

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getEmpActBusinessInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.transferOrderDao.getEmpActBusinessInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.transferOrderDao.getEmpActBusinessInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getEmpActBusinessInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.transferOrderDao.getEmpActBusinessInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getActBusinessInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.transferOrderDao.getActBusinessInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.transferOrderDao.getActBusinessInfoList(paramMap);
        }
        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getActBusinessInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        return this.transferOrderDao.getActBusinessInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getEmpInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.transferOrderDao.getEmpInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.transferOrderDao.getEmpInfoList(paramMap);
        }
        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getEmpInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.transferOrderDao.getEmpInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String saveTransferOrder(HttpServletRequest request) {
        String returnString = "Y";
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        String type = paramMap.get("TYPE").toString();
        if ("resign".equals(type)) {
//            String deptLeaderId = this.infoAppDao.getDeptLeaderId(paramMap.get("EMPID"));
//            String upperDeptLeaderId = this.infoAppDao.getUpperDeptLeaderId(paramMap.get("EMPID"));
            String chineseName = this.infoAppDao.getChineseNameById(paramMap.get("EMPID"));
            String codeName = this.infoAppDao.getCodeNameByCodeId(paramMap.get("RESIGN_TYPE_CODE"));
            Map processParam = new LinkedHashMap<String, Object>();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String currentTime = formatter.format(new Date());
            processParam.put("application_time", currentTime);
            processParam.put("resign_date", paramMap.get("RESIGN_DATE"));
            processParam.put("resign_type", codeName);
            processParam.put("empid", paramMap.get("EMPID"));
            processParam.put("resign_reason", paramMap.get("RESIGN_REASON"));
            processParam.put("applicant", chineseName);
//            processParam.put("lv01_assignee", deptLeaderId);
//            processParam.put("lv02_assignee", upperDeptLeaderId);
            ProcessInstance processInstance = runtimeService.startProcessInstanceByKey("ResignProcess", processParam);
            String processID = processInstance.getProcessInstanceId();
            paramMap.put("PROCESSID", processID);
            returnString = this.transferOrderDao.saveResign(paramMap);
            if (!returnString.equals("Y")) {
                runtimeService.deleteProcessInstance(processID, "发生异常，申请取消");
            }
            Execution execution = runtimeService.createExecutionQuery().processInstanceId(processInstance.getProcessInstanceId())
                .activityId(BUSINESS_DATA_READY).singleResult();
            if(execution!=null){
                runtimeService.signal(execution.getId());
            }
        } else if ("upgrade".equals(type)) {
//            String deptLeaderId = this.infoAppDao.getDeptLeaderId(paramMap.get("EMPID"));
//            String upperDeptLeaderId = this.infoAppDao.getUpperDeptLeaderId(paramMap.get("EMPID"));
            String chineseName = this.infoAppDao.getChineseNameById(paramMap.get("EMPID"));
            String st_codeName = this.infoAppDao.getCodeNameByCodeId(paramMap.get("STATUS_CODE"));
            String po_codeName = this.infoAppDao.getPositionByCodeId(paramMap.get("POST_ID"));
            String deptName = this.infoAppDao.getdeptNameByCodeId(paramMap.get("DEPTID"));
            Map processParam = new LinkedHashMap<String, Object>();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String currentTime = formatter.format(new Date());
            processParam.put("application_time", currentTime);
            processParam.put("empid", paramMap.get("EMPID"));
            processParam.put("applicant", chineseName);
            processParam.put("deptname", deptName);
            processParam.put("emp_status", st_codeName);
            processParam.put("position", po_codeName);
            processParam.put("s_date", paramMap.get("START_DATE"));
            processParam.put("remark", paramMap.get("REMARK"));
//            processParam.put("lv01_assignee", deptLeaderId);
//            processParam.put("lv02_assignee", upperDeptLeaderId);
            ProcessInstance processInstance = runtimeService.startProcessInstanceByKey("UpGradeProcess", processParam);
            String processID = processInstance.getProcessInstanceId();
            paramMap.put("PROCESSID", processID);
            returnString = this.transferOrderDao.saveExperience(paramMap);
            if (!returnString.equals("Y")) {
                runtimeService.deleteProcessInstance(processID, "发生异常，申请取消");
            }
            Execution execution = runtimeService.createExecutionQuery().processInstanceId(processInstance.getProcessInstanceId())
                .activityId(BUSINESS_DATA_READY).singleResult();
            if(execution!=null){
                runtimeService.signal(execution.getId());
            }
        } else if ("reward".equals(type)) {
            returnString = this.transferOrderDao.saveReward(paramMap);
        } else if ("punishment".equals(type)) {
            returnString = this.transferOrderDao.savePunishment(paramMap);
        } else if ("suspension".equals(type)) {
            returnString = this.transferOrderDao.saveExperience(paramMap);
        } else if ("dispatch".equals(type)) {
            returnString = this.transferOrderDao.saveDispath(paramMap);
        } else if ("dispatchend".equals(type)) {
            returnString = this.transferOrderDao.saveDispathEnd(paramMap);
        } else if ("plurality".equals(type)) {
            returnString = this.transferOrderDao.savePlurality(paramMap);
        } else if ("pluralityend".equals(type)) {
            returnString = this.transferOrderDao.savePluralityEnd(paramMap);
        } else if ("joinAgain".equals(type)) {
            returnString = this.transferOrderDao.saveExperience(paramMap);
        } else if ("hire".equals(type)) {
            if (this.transferOrderDao.checkEmpID(paramMap) == 0) {
                returnString = this.transferOrderDao.saveHire(paramMap);
            } else {
                returnString = Messages.getMessage(request, "hrms.sameDataAlreadyExists");
            }
        }
        // 执行发令
        this.transferOrderDao.hrUpdateAuto();
        return returnString;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getDispatchInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.transferOrderDao.getDispatchInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.transferOrderDao.getDispatchInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getDispatchInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.transferOrderDao.getDispatchInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getPluralityInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.transferOrderDao.getPluralityInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.transferOrderDao.getPluralityInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getPluralityInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.transferOrderDao.getPluralityInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getRewardInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.transferOrderDao.getRewardInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.transferOrderDao.getRewardInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getRewardInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.transferOrderDao.getRewardInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getPunishmentInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.transferOrderDao.getPunishmentInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.transferOrderDao.getPunishmentInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getPunishmentInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.transferOrderDao.getPunishmentInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getResignInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.transferOrderDao.getResignInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.transferOrderDao.getResignInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getResignInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.transferOrderDao.getResignInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getUpgradeInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.transferOrderDao.getUpgradeInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.transferOrderDao.getUpgradeInfoList(paramMap);
        }
        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getUpgradeInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.transferOrderDao.getUpgradeInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getExpInsideInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.transferOrderDao.getGeneralDocInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.transferOrderDao.getGeneralDocInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getExpInsideInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.transferOrderDao.getGeneralDocInfoCnt(paramMap);
    }

    @Override
    public String cancelDoc(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        String rollbackType = request.getParameter("rollbackType");
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("UPDATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());
        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, appendMap);
        try {
            if (rollbackType.equals("normal")) {
                this.transferOrderDao.cancelExpInsideInfo(updateList);
            } else if (rollbackType.equals("PunishMent")) {
                this.transferOrderDao.cancelPunishMentInfo(updateList);
            } else if (rollbackType.equals("Plurality")) {
                this.transferOrderDao.cancelPluralityInfo(updateList);
            } else if (rollbackType.equals("Reward")) {
                this.transferOrderDao.cancelRewardInfo(updateList);
            } else if (rollbackType.equals("Dispatch")) {
                this.transferOrderDao.cancelDispatchInfo(updateList);
            } else if (rollbackType.equals("Resign")) {
                this.transferOrderDao.cancelResignInfo(updateList);
            } else if (rollbackType.equals("ActBusiness")) {
                this.transferOrderDao.cancelActBusinessInfo(updateList);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "notCancel";
        }
        return "cancel";
    }

    @Override
    public String recoverCancel(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        String rollbackType = request.getParameter("rollbackType");
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("UPDATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());
        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, appendMap);
        try {
            if (rollbackType.equals("normal")) {
                this.transferOrderDao.cancelExpInsideInfoRecover(updateList);
            } else if (rollbackType.equals("PunishMent")) {
                this.transferOrderDao.cancelPunishMentInfoRecover(updateList);
            } else if (rollbackType.equals("Plurality")) {
                this.transferOrderDao.cancelPluralityInfoRecover(updateList);
            } else if (rollbackType.equals("Reward")) {
                this.transferOrderDao.cancelRewardInfoRecover(updateList);
            } else if (rollbackType.equals("Dispatch")) {
                this.transferOrderDao.cancelDispatchInfoRecover(updateList);
            } else if (rollbackType.equals("Resign")) {
                this.transferOrderDao.cancelResignInfoRecover(updateList);
            } else if (rollbackType.equals("ActBusiness")) {
                this.transferOrderDao.cancelActBusinessInfoRecover(updateList);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String getNewestEmpIDInfo(HttpServletRequest request) {
        String returnString = "";
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        returnString = this.transferOrderDao.getNewestEmpIDInfo(paramMap);
        return returnString;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String checkEmpID(HttpServletRequest request) {
        String returnString = "";
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        if (this.transferOrderDao.checkEmpID(paramMap) == 0) {
            returnString = "<font color=\"green\">可用</font>";
        } else {
            returnString = "<font color=\"red\">不可用</font>";
        }
        return returnString;
    }

    @Override
    public void hrUpdateAuto() {
        this.transferOrderDao.hrUpdateAuto();
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public void getTransferOrderByExcel(HttpServletRequest request, HttpServletResponse response) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 附加信息
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        List<String> codeList = new ArrayList<String>();
        codeList.add("EMPID");
        codeList.add("CHINESENAME");
        codeList.add("PRE_DEPTNAME");
        codeList.add("PRE_POST_NAME");
        codeList.add("PRE_POST_LEVEL_NAME");
        codeList.add("PRE_STATUS_NAME");
        codeList.add("DEPTNAME");
        codeList.add("POST_NAME");
        codeList.add("POST_LEVEL_NAME");
        codeList.add("EMPSTATUS");
        codeList.add("START_DATE");
        codeList.add("REMARK");

        List<String> titleList = new ArrayList<String>();
        titleList.add("工号");
        titleList.add("姓名");
        titleList.add("原部门");
        titleList.add("原职位");
        titleList.add("原职位等级");
        titleList.add("原状态");
        titleList.add("部门");
        titleList.add("职位");
        titleList.add("职位等级");
        titleList.add("员工状态");
        titleList.add("生效日期");
        titleList.add("备注");
        // 创建一个 workbook
        HSSFWorkbook workbook = new HSSFWorkbook();
        List dataList = this.transferOrderDao.getGeneralDocInfoList(paramMap);

        // 定义起始行和列
        int startRowIndex = 0;
        int startColIndex = titleList.size();

        List upgrade = new ArrayList();
        for (int i = 0; i < dataList.size(); i++) {
            LinkedHashMap node = (LinkedHashMap) dataList.get(i);
            if (!node.get("DEPTNAME").toString().equals(node.get("PRE_DEPTNAME").toString()) || !node.get("POST_NAME").toString().equals(node.get("PRE_POST_NAME").toString())) {
                upgrade.add(node);
                dataList.remove(node);
                i--;
            }
        }

        // 创建一个 worksheet
        HSSFSheet worksheet = workbook.createSheet(paramMap.get("PA_MONTH").toString() + "异动");

        // 创建title,data,headers
        Layouter.buildTransferOrderReport(worksheet, startRowIndex, startColIndex, titleList, "");
        FillComputerManager.fillReport(worksheet, startRowIndex, startColIndex, upgrade, codeList);

        upgrade = new ArrayList();
        for (int i = 0; i < dataList.size(); i++) {
            LinkedHashMap node = (LinkedHashMap) dataList.get(i);
            if (!((LinkedHashMap) node).get("EMPSTATUS").toString().equals(((LinkedHashMap) node).get("PRE_STATUS_NAME").toString())) {
                upgrade.add(node);
                dataList.remove(node);
                i--;
            }
        }

        // 创建另一个一个 worksheet1
        HSSFSheet worksheet1 = workbook.createSheet(paramMap.get("PA_MONTH").toString() + "转正");

        // 创建title,data,headers
        Layouter.buildTransferOrderReport(worksheet1, startRowIndex, startColIndex, titleList, "");
        FillComputerManager.fillReport(worksheet1, startRowIndex, startColIndex, upgrade, codeList);

        // 创建另一个一个 worksheet2
        HSSFSheet worksheet2 = workbook.createSheet(paramMap.get("PA_MONTH").toString() + "调薪");

        // 创建title,data,headers
        Layouter.buildTransferOrderReport(worksheet2, startRowIndex, startColIndex, titleList, "");
        FillComputerManager.fillReport(worksheet2, startRowIndex, startColIndex, dataList, codeList);

        // 6.设置reponse参数
        // 进行转码，使其支持中文文件名
        String fileName = null;
        try {
            fileName = java.net.URLEncoder.encode(paramMap.get("PA_MONTH").toString() + "职员调令汇总信息", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setHeader("Content-Disposition", "inline; filename=" + fileName + ".xls");
        // 确保发送的当前文本格式
        response.setContentType("application/vnd.ms-excel");

        // 7. 输出流
        Writer.write(response, worksheet);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public void getRewardInfoByExcel(HttpServletRequest request, HttpServletResponse response) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 附加信息
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        List<String> codeList = new ArrayList<String>();
        codeList.add("EMPID");
        codeList.add("CHINESENAME");
        codeList.add("DEPTNAME");
        codeList.add("POST_NAME");
        codeList.add("IDCARD_NO");
        codeList.add("REWARD_TYPE_NAME");
        codeList.add("REWARD_AMOUNT");
        codeList.add("REWARD_DATE");
        codeList.add("EXECUTED");
        codeList.add("REWARD_REASON");
        codeList.add("REMARK");
        List<String> codeList1 = new ArrayList<String>();
        codeList1.add("EMPID");
        codeList1.add("CHINESENAME");
        codeList1.add("DEPTNAME");
        codeList1.add("SUMREWARD_AMOUNT");

        List<String> titleList = new ArrayList<String>();
        titleList.add("工号");
        titleList.add("姓名");
        titleList.add("部门");
        titleList.add("职位");
        titleList.add("身份证号");
        titleList.add("奖励类型");
        titleList.add("奖励金额");
        titleList.add("奖励日期");
        titleList.add("状态");
        titleList.add("奖励理由");
        titleList.add("备注");
        List<String> titleList1 = new ArrayList<String>();
        titleList1.add("工号");
        titleList1.add("姓名");
        titleList1.add("部门");
        titleList1.add("月度奖励金额");
        // 1.创建一个 workbook
        HSSFWorkbook workbook = new HSSFWorkbook();

        // 2.创建一个 worksheet
        HSSFSheet worksheet = workbook.createSheet(paramMap.get("PA_MONTH").toString());
        HSSFSheet worksheet1 = workbook.createSheet(paramMap.get("PA_MONTH").toString() + "奖励汇总");

        // 3.定义起始行和列
        int startRowIndex = 0;
        int startColIndex = titleList.size();
        int startColIndex1 = titleList1.size();
        // 4.创建title,data,headers
        Layouter.buildRewardInfoReport(worksheet, startRowIndex, startColIndex, titleList);
        Layouter.buildSumRewardInfoReport(worksheet1, startRowIndex, startColIndex1, titleList1);
        // 5.填充数据
        List dataList = this.transferOrderDao.getRewardInfoList(paramMap);
        List dataList1 = this.transferOrderDao.getSumRewardInfoList(paramMap);
        // 将状态和审核状态转变成可识别的中文
        if (dataList.size() > 0) {
            for (int i = 0; i < dataList.size(); i++) {
                Map map = (Map) dataList.get(i);
                String executed = map.get("EXECUTED").toString();
                if ("0".equals(executed)) {
                    map.put("EXECUTED", "未生效");
                } else if ("1".equals(executed)) {
                    map.put("EXECUTED", "已生效");
                }
            }
        }

        FillComputerManager.fillReport(worksheet, startRowIndex, startColIndex, dataList, codeList);
        FillComputerManager.fillReport(worksheet1, startRowIndex, startColIndex1, dataList1, codeList1);
        // 6.设置reponse参数
        // 进行转码，使其支持中文文件名
        String fileName = null;
        try {
            fileName = java.net.URLEncoder.encode(paramMap.get("PA_MONTH").toString() + "职员奖励汇总信息", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setHeader("Content-Disposition", "inline; filename=" + fileName + ".xls");
        // 确保发送的当前文本格式
        response.setContentType("application/vnd.ms-excel");

        // 7. 输出流
        Writer.write(response, worksheet);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public void getPunishmentInfoByExcel(HttpServletRequest request, HttpServletResponse response) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 附加信息
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        List<String> codeList = new ArrayList<String>();
        codeList.add("EMPID");
        codeList.add("CHINESENAME");
        codeList.add("DEPTNAME");
        codeList.add("POST_NAME");
        codeList.add("IDCARD_NO");
        codeList.add("PUN_TYPE_NAME");
        codeList.add("PUN_REASON");
        codeList.add("PUN_AMOUNT");
        codeList.add("PUNISHED_DATE");
        codeList.add("EXECUTED");
        codeList.add("REMARK");
        List<String> codeList1 = new ArrayList<String>();
        codeList1.add("EMPID");
        codeList1.add("CHINESENAME");
        codeList1.add("DEPTNAME");
        codeList1.add("SUMPUN_AMOUNT");

        List<String> titleList = new ArrayList<String>();
        titleList.add("工号");
        titleList.add("姓名");
        titleList.add("部门");
        titleList.add("职位");
        titleList.add("身份证号");
        titleList.add("惩戒类型");
        titleList.add("惩戒事由");
        titleList.add("惩戒金额");
        titleList.add("惩戒日期");
        titleList.add("状态");
        titleList.add("备注");
        List<String> titleList1 = new ArrayList<String>();
        titleList1.add("工号");
        titleList1.add("姓名");
        titleList1.add("部门");
        titleList1.add("月度惩戒金额");
        // 1.创建一个 workbook
        HSSFWorkbook workbook = new HSSFWorkbook();

        // 2.创建一个 worksheet
        HSSFSheet worksheet = workbook.createSheet(paramMap.get("PA_MONTH").toString());
        HSSFSheet worksheet1 = workbook.createSheet(paramMap.get("PA_MONTH").toString() + "惩戒汇总");

        // 3.定义起始行和列
        int startRowIndex = 0;
        int startColIndex = titleList.size();
        int startColIndex1 = titleList1.size();
        // 4.创建title,data,headers
        Layouter.buildPunishmentInfoReport(worksheet, startRowIndex, startColIndex, titleList);
        Layouter.buildSumPunishmentInfoReport(worksheet1, startRowIndex, startColIndex1, titleList1);

        // 5.填充数据
        List dataList = this.transferOrderDao.getPunishmentInfoList(paramMap);
        List dataList1 = this.transferOrderDao.getSumPunishmentInfoList(paramMap);
        // 将状态和审核状态转变成可识别的中文
        if (dataList.size() > 0) {
            for (int i = 0; i < dataList.size(); i++) {
                Map map = (Map) dataList.get(i);
                String executed = map.get("EXECUTED").toString();
                if ("0".equals(executed)) {
                    map.put("EXECUTED", "未生效");
                } else if ("1".equals(executed)) {
                    map.put("EXECUTED", "已生效");
                }
            }
        }

        FillComputerManager.fillReport(worksheet, startRowIndex, startColIndex, dataList, codeList);
        FillComputerManager.fillReport(worksheet1, startRowIndex, startColIndex1, dataList1, codeList1);

        // 6.设置reponse参数
        // 进行转码，使其支持中文文件名
        String fileName = null;
        try {
            fileName = java.net.URLEncoder.encode(paramMap.get("PA_MONTH").toString() + "职员惩戒汇总信息", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setHeader("Content-Disposition", "inline; filename=" + fileName + ".xls");
        // 确保发送的当前文本格式
        response.setContentType("application/vnd.ms-excel");

        // 7. 输出流
        Writer.write(response, worksheet);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public void getResignInfoByExcel(HttpServletRequest request, HttpServletResponse response) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 附加信息
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        List<String> codeList = new ArrayList<String>();
        codeList.add("EMPID");
        codeList.add("CHINESENAME");
        codeList.add("DEPTNAME");
        codeList.add("POST_NAME");
        codeList.add("IDCARD_NO");
        codeList.add("RESIGN_TYPE_NAME");
        codeList.add("RESIGN_REASON");
        codeList.add("RESIGN_DATE");
        codeList.add("EXECUTED");
        codeList.add("AFFIRM_FLAG");
        codeList.add("REMARK");

        List<String> titleList = new ArrayList<String>();
        titleList.add("工号");
        titleList.add("姓名");
        titleList.add("部门");
        titleList.add("职位");
        titleList.add("身份证号");
        titleList.add("离职类型");
        titleList.add("离职原因");
        titleList.add("状态");
        titleList.add("审核状态");
        titleList.add("状态");
        titleList.add("备注");
        // 1.创建一个 workbook
        HSSFWorkbook workbook = new HSSFWorkbook();

        // 2.创建一个 worksheet
        HSSFSheet worksheet = workbook.createSheet(paramMap.get("PA_MONTH").toString());

        // 3.定义起始行和列
        int startRowIndex = 0;
        int startColIndex = titleList.size();

        // 4.创建title,data,headers
        Layouter.buildResignInfoReport(worksheet, startRowIndex, startColIndex, titleList);

        // 5.填充数据
        List dataList = this.transferOrderDao.getResignInfoList(paramMap);
        // 将状态和审核状态转变成可识别的中文
        if (dataList.size() > 0) {
            for (int i = 0; i < dataList.size(); i++) {
                Map map = (Map) dataList.get(i);
                String executed = map.get("EXECUTED").toString();
                String affirmFlag = map.get("AFFIRM_FLAG").toString();
                if ("0".equals(executed)) {
                    map.put("EXECUTED", "未生效");
                } else if ("1".equals(executed)) {
                    map.put("EXECUTED", "已生效");
                }
                if ("0".equals(affirmFlag)) {
                    map.put("AFFIRM_FLAG", "未审核");
                } else if ("1".equals(affirmFlag)) {
                    map.put("AFFIRM_FLAG", "已审核");
                } else if ("2".equals(affirmFlag)) {
                    map.put("AFFIRM_FLAG", "未通过");
                }
            }
        }

        FillComputerManager.fillReport(worksheet, startRowIndex, startColIndex, dataList, codeList);

        // 6.设置reponse参数
        // 进行转码，使其支持中文文件名
        String fileName = null;
        try {
            fileName = java.net.URLEncoder.encode(paramMap.get("PA_MONTH").toString() + "职员惩戒汇总信息", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setHeader("Content-Disposition", "inline; filename=" + fileName + ".xls");
        // 确保发送的当前文本格式
        response.setContentType("application/vnd.ms-excel");

        // 7. 输出流
        Writer.write(response, worksheet);
    }
}
