package com.siping.ess.action;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.siping.ess.service.InfoAppSer;
import com.siping.hrm.service.EmpInfoSer;
import com.siping.hrm.service.TransferOrderSer;
import com.siping.process.service.ProcessAffirmSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.service.UtilityEmpInfoSer;

import bsh.This;

@Controller
@RequestMapping(value = "/ess/infoApp")
public class InfoAppCtroller {
    Logger logger = Logger.getLogger(InfoAppCtroller.class);

    @Autowired
    private EmpInfoSer empInfoSer;

    @Autowired
    private UtilityEmpInfoSer utilityEmpInfoSer;

    @Autowired
    private InfoAppSer infoAppSer;
    
    @Autowired
    private TransferOrderSer transferOrderSer;
    
    @Autowired
    private ProcessAffirmSer processAffirmSer;
    
    private static String UPGRADE_TRANS_CODE = "TransCode_110";

    /**
     * 个人信息
     * @param personInfoType
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/personalInfoApp", method = RequestMethod.GET)
    public ModelAndView personalInfoApp(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("personalInfo", this.empInfoSer.getPersonalInfo(request));
        return new ModelAndView("/ess/infoApp/personalInfoApp", modelMap);
    }
    
    /**
     * 转正申请
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    /**
     * 获取列表
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getEmpActBusinessInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getEmpActBusinessInfoList(HttpServletRequest request) throws Exception {

        List empInfoList = this.transferOrderSer.getEmpActBusinessInfoList(request);
        int empInfoCnt = this.transferOrderSer.getEmpActBusinessInfoCnt(request);

        Map model = new HashMap();
        model.put("Rows", empInfoList);
        model.put("Total", empInfoCnt);
        return model;
    }

    /**
     * 提交发令
     */
    @RequestMapping(value = "/submitTransfer", method = RequestMethod.POST)
    @ResponseBody
    public String submitTransfer(HttpServletRequest request) {
        String returnString = "Y";
        try {
            returnString = this.transferOrderSer.saveTransferOrder(request);
        } catch (Exception e) {
            e.printStackTrace();
            returnString = e.getMessage();
        }
        return returnString;
    }
    
    @RequestMapping(value = "/viewConverApp", method = RequestMethod.GET)
    public ModelAndView viewConverApp(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
	    	LinkedHashMap basicInfo = (LinkedHashMap)this.empInfoSer.getBasicInfo(request);
	    String empId = (String) basicInfo.get("EMPID");
	    
	    modelMap.put("TRANS_CODE", UPGRADE_TRANS_CODE);
        modelMap.put("TRANS_NO", DateUtil.getSysdateString("yyyyMMddHHmmssSSS"));
	    modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
	    modelMap.put("statusName", (String)basicInfo.get("STATUS_NAME"));
	    modelMap.put("applyStatus",this.processAffirmSer.getHrApplicationStatus(empId));
	        
	    return new ModelAndView("/ess/infoApp/viewConverApp", modelMap);
    }
    

    /**
     * 报销申请
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/addExpApp", method = RequestMethod.POST)
    @ResponseBody
    public String addExpApp(HttpServletRequest request) throws Exception {
        String returnString = "N";
        Map returnMap = this.infoAppSer.addExpApp(request);
        if (((Integer) returnMap.get("errcode")).intValue() == 0) {
            returnString = "Y";
        } else {
            returnString = Messages.getErrorMessage("ExpApply", returnMap, request);
        }
        return returnString;
    }
    
    /**
     * 报销申请
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewReimburseApp", method = RequestMethod.GET)
    public ModelAndView viewReimburseApp(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.utilityEmpInfoSer.getEmpBasicInfo(request));
        modelMap.put("isSupervisor", this.utilityEmpInfoSer.isSupervisor(request));
        modelMap.put("appDate", DateUtil.getSysdateString("yyyy-MM-dd"));
        modelMap.put("timeStamp", DateUtil.getSysdateString("yyyyMMddHHmmssSSS"));
        return new ModelAndView("/ess/infoApp/viewReimburseApp", modelMap);
    }
    
    @RequestMapping(value = "/viewWhApp", method = RequestMethod.GET)
    public ModelAndView viewWhApp(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("isWhManager", this.infoAppSer.isWhManager(request));
        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        return new ModelAndView("/ess/infoApp/viewWhApp", modelMap);
    }
    
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/viewWhAppB", method = RequestMethod.GET)
    public ModelAndView viewWhAppB(HttpServletRequest request, ModelMap modelMap) {
        List calendarList = this.infoAppSer.getCompanyCalendarInfo(request) ;
        Map paraMap = this.empInfoSer.getRequestParamData(request);
        LinkedHashMap list = (LinkedHashMap)calendarList.get(0);
        int head = Integer.parseInt(list.get("IWEEK").toString());
        modelMap.put("head", head) ;
        list = (LinkedHashMap)calendarList.get(calendarList.size()-1);
        int end = Integer.parseInt(list.get("IWEEK").toString());
        modelMap.put("end", end) ;
        modelMap.put("calendarList", calendarList) ;
        modelMap.put("paraMap", paraMap) ;
        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        return new ModelAndView("/ess/infoApp/viewWhAppB", modelMap);
    }

    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/addWhApp", method = RequestMethod.GET)
    public ModelAndView addWhApp(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        Map paraMap = this.empInfoSer.getRequestParamData(request);
        modelMap.put("paraMap", paraMap);
        modelMap.put("type", "add");
        return new ModelAndView("/ess/infoApp/transferWhApp", modelMap);
    }

    @RequestMapping(value = "/updateWhApp", method = RequestMethod.GET)
    public ModelAndView updateWhApp(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("paraMap", this.infoAppSer.getWhDetail(request));
        modelMap.put("type", "update");
        return new ModelAndView("/ess/infoApp/transferWhApp", modelMap);
    }

    @RequestMapping(value = "/viewProInfo", method = RequestMethod.GET)
    public ModelAndView viewProInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        modelMap.put("isWhManager", this.infoAppSer.isWhManager(request));
        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        return new ModelAndView("/ess/infoApp/viewProInfo", modelMap);
    }

    @RequestMapping(value = "/addProInfo", method = RequestMethod.GET)
    public ModelAndView addProInfo(HttpServletRequest request, ModelMap modelMap) {
        return new ModelAndView("/ess/infoApp/addProInfo", modelMap);
    }

    @RequestMapping(value = "/upateProMemberInfo", method = RequestMethod.GET)
    public ModelAndView upateProMemberInfo(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("paraMap", this.utilityEmpInfoSer.getRequestParamData(request));
        return new ModelAndView("/ess/infoApp/upateProMemberInfo", modelMap);
    }

    /**
     * 修改项目信息
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updateProjectInfo", method = RequestMethod.GET)
    public ModelAndView updateProjectInfo(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("paraMap", this.utilityEmpInfoSer.getRequestParamData(request));
        return new ModelAndView("/ess/infoApp/updateProjectInfo", modelMap);
    }

    /**
     * 添加生产订单
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewAddProductionOrder", method = RequestMethod.GET)
    public ModelAndView viewAddProductionOrder(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("paraMap", this.utilityEmpInfoSer.getRequestParamData(request));
        return new ModelAndView("/ess/infoApp/viewAddProductionOrder", modelMap);
    }

    /**
     * 添加生产订单
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addProductionOrderInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addProductionOrderInfoFunc(HttpServletRequest request, ModelMap modelMap) {
        return this.infoAppSer.addProductionOrderInfo(request);
    }

    /**
     * 修改项目下生产订单
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updateProductionOrderInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updateProductionOrderInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        return this.infoAppSer.updateProductionOrderInfo(request);
    }

    /**
     * 删除项目下生产订单
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/deleteProductionOrderInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deleteProductionOrderInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        return this.infoAppSer.deleteProductionOrderInfo(request);
    }

    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/viewWhCalendarInfo", method = RequestMethod.GET)
    public ModelAndView viewWhCalendarInfo(HttpServletRequest request, ModelMap modelMap) throws Exception {
        String calendarHtml = this.infoAppSer.getWhCalendarInfoHtml(request);
        Map paraMap = this.empInfoSer.getRequestParamData(request);
        modelMap.put("calendarHtml", calendarHtml);
        modelMap.put("paraMap", paraMap);
        return new ModelAndView("/ess/infoApp/viewWhCalendarInfo", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/viewWorkhourCalendarInfo", method = RequestMethod.GET)
    public ModelAndView viewWorkhourCalendarInfo(HttpServletRequest request, ModelMap modelMap) throws Exception {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paraMap = this.empInfoSer.getRequestParamData(request);
        if (paraMap == null || paraMap.get("EMPID") == null || paraMap.get("EMPID").toString() == null || (paraMap.get("EMPID").toString().equals(""))) {
            paraMap.put("EMPID", admin.getAdminID());
            paraMap.put("NAME", admin.getChineseName());
        }
        String calendarHtml = this.infoAppSer.getWhCalendarInfoHtml(request);
        modelMap.put("calendarHtml", calendarHtml);
        modelMap.put("paraMap", paraMap);
        return new ModelAndView("/ess/infoApp/viewWorkhourCalendarInfo", modelMap);
    }

    @RequestMapping(value = "/updateProInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updateProInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        return this.infoAppSer.updateProInfo(request);
    }

    @RequestMapping(value = "/addProInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addProInfoFunc(HttpServletRequest request, ModelMap modelMap) {
        return this.infoAppSer.addProInfo(request);
    }

    @RequestMapping(value = "/addProMemberInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addProMemberInfo(HttpServletRequest request, ModelMap modelMap) throws Exception {
        return this.infoAppSer.addProMemberInfo(request);
    }

    /*
     * 电焊、装配工人报工申请
     */
    @RequestMapping(value = "/transferWorkingHoursInfo", method = RequestMethod.POST)
    @ResponseBody
    public String transferWorkingHoursInfo(HttpServletRequest request, ModelMap modelMap) {
        String returnString = "N";
        Map returnMap = this.infoAppSer.transferWorkingHoursInfo(request);

        if (((Integer) returnMap.get("errcode")).intValue() == 0) {
            returnString = "Y";
        } else {
            returnString = Messages.getErrorMessage("whApply", returnMap,
                    request);
        }
        return returnString;
    }

    /*
     * 下料工人报工申请
     */
    @RequestMapping(value = "/transferWorkingHoursInfoOther", method = RequestMethod.POST)
    @ResponseBody
    public String transferWorkingHoursInfoOther(HttpServletRequest request, ModelMap modelMap) {
        return this.infoAppSer.transferWorkingHoursInfoOther(request);
    }

    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/saveWorkingHoursInfo", method = RequestMethod.POST)
    @ResponseBody
    public String saveWorkingHoursInfo(HttpServletRequest request, ModelMap modelMap) throws Exception {
        String returnString = "N";
        Map returnMap = this.infoAppSer.saveWorkingHoursInfo(request);
        if (((Integer) returnMap.get("errcode")).intValue() == 0) {
            returnString = "Y";
        } else {
            returnString = Messages.getErrorMessage("whApply", returnMap, request);
        }
        return returnString;
    }

    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/updateWorkingHoursInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updateWorkingHoursInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        String returnString = "N";
        Map returnMap = this.infoAppSer.updateWorkingHoursInfo(request);
        if (((Integer) returnMap.get("errcode")).intValue() == 0) {
            returnString = "Y";
        } else {
            returnString = Messages.getErrorMessage("whApply", returnMap, request);
        }
        return returnString;

    }

    /**
     * 获取列表
     * @param personInfoType
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/addPersonalInfoApp", method = RequestMethod.POST)
    @ResponseBody
    public String addPersonalInfoApp(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        String returnString = "N";
        Map returnMap = this.infoAppSer.addPersonalInfoApp(request);
        if (((Integer) returnMap.get("errcode")).intValue() == 0) {
            returnString = "Y";
        } else {
            returnString = Messages.getErrorMessage("perInfoApp", returnMap, request);
        }
        return returnString;
    }

    /**
     * 加班申请
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewOTApp", method = RequestMethod.GET)
    public ModelAndView viewOTApp(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.utilityEmpInfoSer.getEmpBasicInfo(request));
        modelMap.put("isSupervisor", this.utilityEmpInfoSer.isSupervisor(request));
        modelMap.put("currentDate", DateUtil.getSysdateString("yyyy-MM-dd"));
        modelMap.put("appDate", DateUtil.getSysdateString("yyyy-MM-dd"));
        return new ModelAndView("/ess/infoApp/viewOTApp", modelMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getAffirmorList", method = RequestMethod.POST)
    @ResponseBody
    public Map getAffirmorList(HttpServletRequest request) throws Exception {
        List affirmorInfoList = this.infoAppSer.getAffirmorList(request);
        Map model = new HashMap();
        model.put("Rows", affirmorInfoList);
        return model;
    }

    /**
     * 出差申请
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewBTApp", method = RequestMethod.GET)
    public ModelAndView viewBTApp(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.utilityEmpInfoSer.getEmpBasicInfo(request));
        modelMap.put("isSupervisor", this.utilityEmpInfoSer.isSupervisor(request));
        modelMap.put("currentDate", DateUtil.getSysdateString("yyyy-MM-dd HH:mm"));
        modelMap.put("appDate", DateUtil.getSysdateString("yyyy-MM-dd"));
        modelMap.put("timeStamp", DateUtil.getSysdateString("yyyyMMddHHmmssSSS"));
        return new ModelAndView("/ess/infoApp/viewBTApp", modelMap);
    }


    /**
     * 漏卡时间申请
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewCardtimeApp", method = RequestMethod.GET)
    public ModelAndView viewCardtimeApp(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.utilityEmpInfoSer.getEmpBasicInfo(request));
        modelMap.put("isSupervisor", this.utilityEmpInfoSer.isSupervisor(request));
        modelMap.put("appDate", DateUtil.getSysdateString("yyyy-MM-dd"));
        modelMap.put("timeStamp", DateUtil.getSysdateString("yyyyMMddHHmmssSSS"));
        return new ModelAndView("/ess/infoApp/viewCardtimeApp", modelMap);
    }

    /**
     * 加班申请
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/addOvertimeApp", method = RequestMethod.POST)
    @ResponseBody
    public String addOvertimeApp(HttpServletRequest request) throws Exception {
        String returnString = "N";
        Map returnMap = this.infoAppSer.addOvertimeApp(request);
        if (((Integer) returnMap.get("errcode")).intValue() == 0) {
            returnString = "Y";
        } else {
            returnString = Messages.getErrorMessage("OtApply", returnMap, request);
        }
        return returnString;
    }

    /**
     * 出差申请
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/addBTApp", method = RequestMethod.POST)
    @ResponseBody
    public String addBTApp(HttpServletRequest request) throws Exception {
        String returnString = "N";
        Map returnMap = this.infoAppSer.addBTApp(request);
        if (((Integer) returnMap.get("errcode")).intValue() == 0) {
            returnString = "Y";
        } else {
            returnString = Messages.getErrorMessage("BTApply", returnMap, request);
        }
        return returnString;
    }

    /**
     * 漏卡申请
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/addCardtimeApp", method = RequestMethod.POST)
    @ResponseBody
    public String addCardtimeApp(HttpServletRequest request) throws Exception {
        String returnString = "N";
        Map returnMap = this.infoAppSer.addCardtimeApp(request);
        if (((Integer) returnMap.get("errcode")).intValue() == 0) {
            returnString = "Y";
        } else {
            returnString = Messages.getErrorMessage("cardApply", returnMap, request);
        }
        return returnString;
    }

    /**
     * 休假申请
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/addLeaveApp", method = RequestMethod.POST)
    @ResponseBody
    public String addLeaveApp(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        String returnString = "N";
        Map returnMap = this.infoAppSer.addLeaveApp(request);
        if (((Integer) returnMap.get("errcode")).intValue() == 0) {
            returnString = "Y";
        } else {
            returnString = Messages.getErrorMessage("LeaveApply", returnMap, request);
        }
        return returnString;
    }

    /**
     * 休假申请
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewLeaveApp", method = RequestMethod.GET)
    public ModelAndView viewLeaveApp(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.utilityEmpInfoSer.getEmpBasicInfo(request));
        modelMap.put("isSupervisor", this.utilityEmpInfoSer.isSupervisor(request));
        modelMap.put("currentDate", DateUtil.getSysdateString("yyyy-MM-dd HH:mm"));
        modelMap.put("appDate", DateUtil.getSysdateString("yyyy-MM-dd"));
        return new ModelAndView("/ess/infoApp/viewLeaveApp", modelMap);
    }

    /**
     * 加班申请
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addTrainingApp")
    @ResponseBody
    public String addTrainingApp(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        logger.info("addHandselApp.start......");
        if (this.infoAppSer.addTrainingApp(request)) {
            return "Y";
        }
        return "N";
    }

    /**
     * 班次信息
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/searchEmpShift", method = RequestMethod.GET)
    public ModelAndView searchEmpShift(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("paramMap", ObjectBindUtil.getRequestParamData(request));
        return new ModelAndView("/ess/infoApp/searchEmpShift", modelMap);
    }

    /**
     * 班次信息
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewEmpLeaveInfo", method = RequestMethod.GET)
    public ModelAndView viewEmpLeaveInfo(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("paramMap", ObjectBindUtil.getRequestParamData(request));
        return new ModelAndView("/ess/infoApp/viewEmpLeaveInfo", modelMap);
    }

    /**
     * 审核者信息
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewApproverInfo", method = RequestMethod.GET)
    public ModelAndView viewApproverInfo(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("paramMap", ObjectBindUtil.getRequestParamData(request));
        return new ModelAndView("/ess/infoApp/viewApproverInfo", modelMap);
    }

    /**
     * 班次信息
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getEmpShift", method = RequestMethod.POST)
    @ResponseBody
    public Map getEmpShift(HttpServletRequest request) throws Exception {
        List shiftInfoList = this.infoAppSer.getEmpShift(request);
        Map model = new HashMap();
        model.put("shiftInfoList", shiftInfoList);
        return model;
    }

    /**
     * 跳至物品申请界面
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewToolApp", method = RequestMethod.GET)
    public ModelAndView viewToolApp(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.utilityEmpInfoSer.getEmpBasicInfo(request));
        modelMap.put("isSupervisor", this.utilityEmpInfoSer.isSupervisor(request));
        modelMap.put("currentDate", DateUtil.getSysdateString("yyyy-MM-dd HH:mm"));
        modelMap.put("appDate", DateUtil.getSysdateString("yyyy-MM-dd HH:mm"));
        return new ModelAndView("/ess/infoApp/viewToolApp", modelMap);
    }

    /**
     * 物品申请
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/addToolApp", method = RequestMethod.POST)
    @ResponseBody
    public String addToolApp(HttpServletRequest request) throws Exception {
        String returnString = "N";
        Map returnMap = this.infoAppSer.addToolApp(request);
        if (((Integer) returnMap.get("errcode")).intValue() == 0) {
            returnString = "Y";
        } else {
            returnString = Messages.getErrorMessage("ToolApply", returnMap, request);
        }
        return returnString;
    }

    /**
     * 物品申请
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/addToolAppAss", method = RequestMethod.POST)
    @ResponseBody
    public String addToolAppAss(HttpServletRequest request) throws Exception {
        String returnString = "N";
        Map returnMap = this.infoAppSer.addToolAppAss(request);
        if (((Integer) returnMap.get("errcode")).intValue() == 0) {
            returnString = "Y";
        } else {
            returnString = Messages.getErrorMessage("ToolApply", returnMap, request);
        }
        return returnString;
    }

    /**
     * 跳转至物品出借信息页面
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/previewTool", method = RequestMethod.GET)
    public ModelAndView previewTool(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("paramMap", ObjectBindUtil.getRequestParamData(request));
        return new ModelAndView("/ess/infoApp/previewTool", modelMap);
    }

    /**
     * 显示物品出借信息
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getToolLoan", method = RequestMethod.POST)
    @ResponseBody
    public Map getToolLoan(HttpServletRequest request) throws Exception {
        List toolLoanList = this.infoAppSer.getToolLoan(request);
        Map model = new HashMap();
        model.put("toolLoanList", toolLoanList);
        return model;
    }

    /**
     * 跳转到生产订单导入界面
     * @param request
     * @param response
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/uploadProductionOrder", method = RequestMethod.GET)
    public ModelAndView uploadProductionOrdero(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
        modelMap.put("paraMap", this.utilityEmpInfoSer.getRequestParamData(request));
        return new ModelAndView("/ess/infoApp/uploadProductionOrder", modelMap);
    }

    /**
     * 将Excel中的内容导入数据库
     * @param file
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/uploadProductionOrder", method = RequestMethod.POST)
    @ResponseBody
    public String uploadProductionOrder(@RequestParam("file") MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
        String resultString = "Y";
        try {
            resultString = this.infoAppSer.uploadProductionOrder(file, request, response);
        } catch (IOException e) {
            resultString = e.getMessage();
            e.printStackTrace();
        } catch (SQLException e) {
            resultString = e.getMessage();
            e.printStackTrace();
        } catch (ParseException e) {
            resultString = e.getMessage();
            e.printStackTrace();
        } catch (Exception e) {
            resultString = "未知错误";
            e.printStackTrace();
        }
        return resultString;
    }

    /**
     * 下载生产订单模板
     * @param request
     * @param response
     * @throws SQLException
     * @throws IOException
     */
    @RequestMapping(value = "/downloadProductionOrderTemplate")
    public void downloadProductionOrderTemplate(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        this.infoAppSer.downloadProductionOrderTemplate(request, response);
    }
    /* ****报工统计***************************************************** */
    @RequestMapping(value = "/viewWhConclusion")
    public ModelAndView viewWhConclusion(HttpServletRequest request,
            HttpServletResponse response, ModelMap modelMap) throws Exception {

        return new ModelAndView("/ess/infoApp/viewWhConclusion", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value="/getWhConclusionList", method=RequestMethod.POST)
    @ResponseBody
    public Map getWhConclusionList(HttpServletRequest request, HttpServletResponse response){
        Map modelMap = new HashMap();
        modelMap.put("Rows",this.infoAppSer.getWhConclusionList(request));
        modelMap.put("Total", this.infoAppSer.getWhConclusionListCnt(request));
        return modelMap;
    }

    @RequestMapping(value="/calculateWhConclusion", method=RequestMethod.POST)
    @ResponseBody
    public String calculateWhConclusion(HttpServletRequest request, HttpServletResponse response){
        String resultString = "Y";
        try {
            this.infoAppSer.calculateWhConclusion(request);
        } catch (SQLException e) {
            resultString = e.getMessage();
            e.printStackTrace();
        }
        return resultString;
    }
}

