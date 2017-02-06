package com.siping.process.action;

import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.process.service.ProcessManageSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.service.UtilityEmpInfoSer;

@Controller
@RequestMapping(value = "/process/processManage")
public class ProcessManageCtroller {
    Logger logger = Logger.getLogger(ProcessManageCtroller.class);

    @Autowired
    private ProcessManageSer processManageSer;

    @Autowired
    private UtilityEmpInfoSer utilityEmpInfoSer;

    /**
     * 对象申请
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/addObjectApp", method = RequestMethod.POST)
    @ResponseBody
    public String addObjectApp(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        String returnString = "N";
        Map returnMap = this.processManageSer.addObjectApp(request);
        if (((Integer) returnMap.get("errcode")).intValue() == 0) {
            returnString = "Y";
        } else {
            returnString = Messages.getErrorMessage("ObjectApply", returnMap, request);
        }
        return returnString;
    }

    /**
     * 查看对象申请
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewObjectApp", method = RequestMethod.GET)
    public ModelAndView viewObjectApp(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.utilityEmpInfoSer.getEmpBasicInfo(request));
        modelMap.put("isSupervisor", this.utilityEmpInfoSer.isSupervisor(request));
        return new ModelAndView("/process/processManage/viewObjectApp", modelMap);
    }

    /**
     * 查看审核者
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewApproverInfo", method = RequestMethod.GET)
    public ModelAndView viewApproverInfo(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("paramMap", ObjectBindUtil.getRequestParamData(request));
        return new ModelAndView("/process/processManage/viewApproverInfo", modelMap);
    }

    /**
     * 查看某对象的所有审核者与审核情况
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getAffirmorResultList", method = RequestMethod.POST)
    @ResponseBody
    public Map getAffirmorResultList(HttpServletRequest request) throws Exception {
        logger.info("getAffirmObjectview.start......");
        List resultList = processManageSer.getAffirmorResultList(request);// 申请审批
        Map resultMap = new HashMap();
        resultMap.put("Rows", resultList);
        resultMap.put("Total", resultList.size());
        return resultMap;
    }

    /**
     * Object申请审批
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/getAffirmObjectInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getAffirmObjectInfo(HttpServletRequest request) throws Exception {
        logger.info("getAffirmObjectview.start......");
        Map temp = processManageSer.getAffirmObjectInfo(request);// 申请审批
        return temp;
    }

    /**
     * 信息审核
     * @param request
     * @return
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/affirmApp", method = RequestMethod.POST)
    @ResponseBody
    public Map affirmApp(HttpServletRequest request, HttpServletResponse response) throws Exception {
        return this.processManageSer.affirmApp(request);
    }

    @RequestMapping(value = "/selectRejectStatus")
    public ModelAndView selectRejectStatus(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("paramMap", ObjectBindUtil.getRequestParamData(request));
        return new ModelAndView("/process/processManage/selectRejectStatus", modelMap);
    }

    /**
     * 设置rejectStatus
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/saveAndUpdateRejectStatus", method = RequestMethod.POST)
    @ResponseBody
    public String saveAndUpdateRejectStatus(HttpServletRequest request, HttpServletResponse response) throws Exception {
        return this.processManageSer.saveAndUpdateRejectStatus(request);
    }
}
