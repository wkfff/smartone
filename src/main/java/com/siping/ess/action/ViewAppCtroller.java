package com.siping.ess.action;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.RuntimeService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.ess.service.ViewAppSer;
import com.siping.hrm.service.EmpInfoSer;
import com.siping.web.utility.ObjectBindUtil;

@Controller
@RequestMapping(value = "/ess/viewApp")
public class ViewAppCtroller {

    Logger logger = Logger.getLogger(ViewAppCtroller.class);

    @Autowired
    private ViewAppSer viewAppSer;
    @Autowired
    private EmpInfoSer empInfoSer;
    @Autowired
    private RuntimeService runtimeService;
    
    /**
     * 页面跳转
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/{viewAppType}")
    public ModelAndView getPersonInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap, @PathVariable("viewAppType") String viewAppType) throws Exception {

        return new ModelAndView("/ess/viewApp/" + viewAppType, modelMap);
    }

    @RequestMapping(value = "/cancelApp", method = RequestMethod.POST)
    @ResponseBody
    public String cancelApp(HttpServletRequest request) {
        String jsonString = request.getParameter("jsonData");
        // String jsonStr = jsonString.substring(1, jsonString.length()-1);
        // JSONObject jsonObject = JSONObject.fromObject(jsonStr);
        List<LinkedHashMap<String, Object>> list = ObjectBindUtil.getRequestJsonData(jsonString);
        String flag = this.viewAppSer.cancelApp(request);
        if (flag.equals("cancel")) {
            try {
                for (int i = 0; i < list.size(); i++) {
                    String processID = list.get(i).get("PROCESSID").toString();
                    this.runtimeService.deleteProcessInstance(processID, "个人取消申请");
                }
                return "Y";
            } catch (Exception e) {
                // 若发生异常，则恢复申请
                this.viewAppSer.recoverCancel(request);
                e.printStackTrace();
                return e.getMessage();
            }
        } else {
            return "删除申请失败";
        }
    }

    @RequestMapping(value = "/cancelWhApp", method = RequestMethod.POST)
    @ResponseBody
    public String cancelWhApp(HttpServletRequest request) {

        return this.viewAppSer.cancelWhApp(request);
    }

    /**
     * 个人信息申请
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getPersonalInfoList", method = RequestMethod.POST)
    @ResponseBody
    public Map getPersonalInfoList(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List empInfoList = this.viewAppSer.getPersonalInfoList(request);
        int empInfoListCnt = this.viewAppSer.getPersonalInfoListCnt(request);
        model.put("Rows", empInfoList);
        model.put("Total", empInfoListCnt);
        return model;
    }

    @RequestMapping(value = "/viewPersonalInfo", method = RequestMethod.GET)
    public ModelAndView viewPersonalInfo(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        modelMap.put("personalInfo", this.viewAppSer.getPersonalInfo(request));
        return new ModelAndView("/ess/viewApp/viewPersonalInfo", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getWhInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getWhInfo(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List empInfoList = this.viewAppSer.getWhInfo(request);
        int empInfoListCnt = this.viewAppSer.getWhInfoCnt(request);
        model.put("Rows", empInfoList);
        model.put("Total", empInfoListCnt);
        return model;
    }

    @RequestMapping(value = "/viewEmpWhInfo", method = RequestMethod.GET)
    public ModelAndView viewEmpWhInfo(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("paraMap", this.viewAppSer.getRequestParamData(request));
        return new ModelAndView("/ess/viewApp/viewEmpWhInfo", modelMap);
    }

    @RequestMapping(value = "/viewExpDetailInfo", method = RequestMethod.GET)
    public ModelAndView viewExpDetailInfo(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("paraMap", this.viewAppSer.getRequestParamData(request));
        return new ModelAndView("/ess/viewApp/viewExpDetailInfo", modelMap);
    }

    @RequestMapping(value = "/viewBTDetailInfo", method = RequestMethod.GET)
    public ModelAndView viewBTDetailInfo(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("paraMap", this.viewAppSer.getRequestParamData(request));
        return new ModelAndView("/ess/viewApp/viewBTDetailInfo", modelMap);
    }

    @RequestMapping(value = "/viewApproverInfo", method = RequestMethod.GET)
    public ModelAndView viewApproverInfo(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("paraMap", this.viewAppSer.getRequestParamData(request));
        return new ModelAndView("/ess/viewApp/viewApproverInfo", modelMap);
    }

    /**
     * 项目信息
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getProInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getProInfo(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List empInfoList = this.viewAppSer.getProInfo(request);
        int empInfoListCnt = this.viewAppSer.getProInfoCnt(request);
        model.put("Rows", empInfoList);
        model.put("Total", empInfoListCnt);
        return model;
    }
    
    /**
     * 项目信息by员工
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getProInfoByReim", method = RequestMethod.POST)
    @ResponseBody
    public Map getProInfoByReim(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
//        String empId = (String) this.utilityEmpInfoSer.getRequestParamData(request).get("EMPID");
        List empInfoList = this.viewAppSer.getProInfoByReim(request);
        int empInfoListCnt = this.viewAppSer.getProInfoCnt(request);
        model.put("Rows", empInfoList);
        model.put("Total", empInfoListCnt);
        return model;
    }
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getProMemberInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getProMemberInfo(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List empInfoList = this.viewAppSer.getProMemberInfo(request);
        int empInfoListCnt = this.viewAppSer.getProMemberInfoCnt(request);
        model.put("Rows", empInfoList);
        model.put("Total", empInfoListCnt);
        return model;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getWorkingHoursInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getWorkingHoursInfo(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List empInfoList = this.viewAppSer.getWorkingHoursInfo(request);
        int empInfoListCnt = this.viewAppSer.getWorkingHoursInfoCnt(request);
        model.put("Rows", empInfoList);
        model.put("Total", empInfoListCnt);
        return model;
    }

    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getWorkingHoursInfoB", method = RequestMethod.POST)
    @ResponseBody
    public List getWorkingHoursInfoB(HttpServletRequest request) throws Exception {
        return this.viewAppSer.getWorkingHoursInfo(request);
    }

    /**
     * 物品信息
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getToolInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getToolInfo(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List toolInfoList = this.viewAppSer.getToolInfo(request);
        int toolInfoListCnt = this.viewAppSer.getToolInfoCnt(request);
        model.put("Rows", toolInfoList);
        model.put("Total", toolInfoListCnt);
        return model;
    }

    @RequestMapping(value = "/delProInfo", method = RequestMethod.POST)
    @ResponseBody
    public String delProInfo(HttpServletRequest request) throws Exception {

        return this.viewAppSer.delProInfo(request);
    }

    @RequestMapping(value = "/delProMemberInfo", method = RequestMethod.POST)
    @ResponseBody
    public String delProMemberInfo(HttpServletRequest request) throws Exception {

        return this.viewAppSer.delProMemberInfo(request);
    }

    @RequestMapping(value = "/delExpDetailInfo", method = RequestMethod.POST)
    @ResponseBody
    public String delExpDetailInfo(HttpServletRequest request) throws Exception {
        this.viewAppSer.delExpDetailInfo(request);
        return "Y";
    }

    @RequestMapping(value = "/delWorkingHoursInfo", method = RequestMethod.POST)
    @ResponseBody
    public String delWorkingHoursInfo(HttpServletRequest request) throws Exception {
        this.viewAppSer.delWorkingHoursInfo(request);
        return "Y";
    }

    /**
     * 加班信息申请查看
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getOtInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getOtInfo(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List empInfoList = this.viewAppSer.getOtInfo(request);
        int empInfoListCnt = this.viewAppSer.getOtInfoCnt(request);
        model.put("Rows", empInfoList);
        model.put("Total", empInfoListCnt);
        return model;
    }

    /**
     * 休假信息申请查看
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getLeaveInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getLeaveInfo(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List empInfoList = this.viewAppSer.getLeaveInfo(request);
        int empInfoListCnt = this.viewAppSer.getLeaveInfoCnt(request);
        model.put("Rows", empInfoList);
        model.put("Total", empInfoListCnt);
        return model;
    }

    /**
     * 漏卡信息申请查看
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getCardtimeAttInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getCardtimeAttInfo(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List empInfoList = this.viewAppSer.getCardtimeAttInfo(request);
        int empInfoListCnt = this.viewAppSer.getCardtimeAttInfoCnt(request);
        model.put("Rows", empInfoList);
        model.put("Total", empInfoListCnt);
        return model;
    }

    /**
     * 漏卡信息申请查看
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getCardtimeInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getCardtimeInfo(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List empInfoList = this.viewAppSer.getCardtimeInfo(request);
        int empInfoListCnt = this.viewAppSer.getCardtimeInfoCnt(request);
        model.put("Rows", empInfoList);
        model.put("Total", empInfoListCnt);
        return model;
    }

    /**
     * 费用明细申请查看
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getExpDetailInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getExpDetailInfo(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List empInfoList = this.viewAppSer.getExpDetailInfo(request);
        int empInfoListCnt = this.viewAppSer.getExpDetailInfoCnt(request);
        model.put("Rows", empInfoList);
        model.put("Total", empInfoListCnt);
        return model;
    }

    /**
     * 出差信息申请查看
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getBTInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getBTInfo(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List empInfoList = this.viewAppSer.getBTInfo(request);
        int empInfoListCnt = this.viewAppSer.getBTInfoCnt(request);
        model.put("Rows", empInfoList);
        model.put("Total", empInfoListCnt);
        return model;
    }

    /**
     * 培训信息申请查看
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/getViewTrainingview", method = RequestMethod.POST)
    @ResponseBody
    public Map getViewTrainingview(HttpServletRequest request) throws Exception {
        logger.info("getViewTrainingview.start......");
        Map temp = this.viewAppSer.getEmpTrainingAppView(request);// 培训信息申请查看
        return temp;
    }

    /**
     * 费用信息申请查看
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getExpInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getExpInfo(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List empInfoList = this.viewAppSer.getExpInfo(request);
        int empInfoListCnt = this.viewAppSer.getExpInfoCnt(request);
        model.put("Rows", empInfoList);
        model.put("Total", empInfoListCnt);
        return model;
    }

    /**
     * 教育信息申请查看
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/getViewEtnview", method = RequestMethod.POST)
    @ResponseBody
    public Map getViewEtnview(HttpServletRequest request) throws Exception {
        logger.info("getViewEtnview.start......");
        Map temp = this.viewAppSer.getEmpEtnAppView(request);// 教育信息申请查看
        return temp;
    }

    /**
     * 审批状态查询
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/getAffirmorList", method = RequestMethod.POST)
    @ResponseBody
    public Map getAffirmorList(HttpServletRequest request) throws Exception {
        Map returnMap = this.viewAppSer.getAffirmorList(request);
        return returnMap;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getEmpLeaveDetailInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getEmpLeaveDetailInfo(HttpServletRequest request) throws Exception {
        List leaveDetailInfo = this.viewAppSer.getEmpLeaveDetailInfo(request);
        int leaveDetailInfoCnt = this.viewAppSer.getEmpLeaveDetailInfoCnt(request);
        Map model = new HashMap();
        model.put("Rows", leaveDetailInfo);
        model.put("Total", leaveDetailInfoCnt);
        return model;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getProductionOrderInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getProductionOrderInfo(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List empInfoList = this.viewAppSer.getProductionOrderInfo(request);
        int empInfoListCnt = this.viewAppSer.getProductionOrderInfoCnt(request);
        model.put("Rows", empInfoList);
        model.put("Total", empInfoListCnt);
        return model;
    }
}
