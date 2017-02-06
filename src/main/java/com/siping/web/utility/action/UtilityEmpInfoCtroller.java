package com.siping.web.utility.action;

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

import com.siping.system.bean.AdminBean;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.service.UtilityEmpInfoSer;

@Controller
@RequestMapping(value = "/utility/empInfo")
public class UtilityEmpInfoCtroller {
    Logger logger = Logger.getLogger(UtilityEmpInfoCtroller.class);
    @Autowired
    private UtilityEmpInfoSer utilityEmpInfoSer;
    @RequestMapping(value = "/searchEmp", method = RequestMethod.GET)
    public ModelAndView searchEmp(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        return new ModelAndView("/web/utility/empInfo/searchEmp", modelMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getEmpInfoList")
    @ResponseBody
    public Map getEmpInfoList(HttpServletRequest request) throws Exception {
        List empInfoList = this.utilityEmpInfoSer.getEmpInfoList(request);
        int empInfoListCnt = this.utilityEmpInfoSer.getEmpInfoListCnt(request);
        Map model = new HashMap();
        model.put("empInfoList", empInfoList);
        model.put("empInfoListCnt", empInfoListCnt);
        return model;
    }

    @RequestMapping(value = "/viewAttSearchEmployeeB", method = RequestMethod.GET)
    public ModelAndView viewAttSearchEmployeeB(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        return new ModelAndView("/web/utility/empInfo/viewAttSearchEmployeeB", modelMap);
    }

    @RequestMapping(value = "/viewAttSearchEmployee", method = RequestMethod.GET)
    public ModelAndView viewAttSearchEmployee(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("paraMap", this.utilityEmpInfoSer.getRequestParamData(request));
        return new ModelAndView("/web/utility/empInfo/viewAttSearchEmployee", modelMap);
    }

    @RequestMapping(value = "/viewHrSearchEmployee", method = RequestMethod.GET)
    public ModelAndView viewHrSearchEmployee(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("paraMap", this.utilityEmpInfoSer.getRequestParamData(request));
        return new ModelAndView("/web/utility/empInfo/viewHrSearchEmployee", modelMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getAttSearchEmployeeList", method = RequestMethod.POST)
    @ResponseBody
    public Map getAttSearchEmployeeList(HttpServletRequest request) throws Exception {
        List attSearchEmployeeList = this.utilityEmpInfoSer.getAttSearchEmployeeList(request);
        int attSearchEmployeeCnt = this.utilityEmpInfoSer.getAttSearchEmployeeCnt(request);
        Map model = new HashMap();
        model.put("Rows", attSearchEmployeeList);
        model.put("Total", attSearchEmployeeCnt);
        return model;
    }

    @RequestMapping(value = "/viewHrSearchEmployeeB", method = RequestMethod.GET)
    public ModelAndView viewHrSearchEmployeeB(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        modelMap.put("admin", admin);
        return new ModelAndView("/web/utility/empInfo/viewHrSearchEmployeeB", modelMap);
    }

    /**
     * 获取去除当前用户的其他员工
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewHrSearchEmployeeC", method = RequestMethod.GET)
    public ModelAndView viewHrSearchEmployeeC(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        modelMap.put("admin", admin);
        return new ModelAndView("/web/utility/empInfo/viewHrSearchEmployeeC", modelMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getHrSearchEmployeeList", method = RequestMethod.POST)
    @ResponseBody
    public Map getHrSearchEmployeeList(HttpServletRequest request) throws Exception {
        List hrSearchEmployeeList = this.utilityEmpInfoSer.getHrSearchEmployeeList(request);
        int hrSearchEmployeeCnt = this.utilityEmpInfoSer.getHrSearchEmployeeCnt(request);
        Map model = new HashMap();
        model.put("Rows", hrSearchEmployeeList);
        model.put("Total", hrSearchEmployeeCnt);
        return model;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getProSearchEmployeeInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getProSearchEmployeeInfo(HttpServletRequest request) throws Exception {
        List hrSearchEmployeeList = this.utilityEmpInfoSer.getProSearchEmployeeInfo(request);
        int hrSearchEmployeeCnt = this.utilityEmpInfoSer.getProSearchEmployeeInfoCnt(request);
        Map model = new HashMap();
        model.put("Rows", hrSearchEmployeeList);
        model.put("Total", hrSearchEmployeeCnt);
        return model;
    }

    @RequestMapping(value = "/viewAttSearchEmployeeWithCheckBox", method = RequestMethod.GET)
    public ModelAndView viewArSearchEmployeeWithCheckBox(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        return new ModelAndView("/web/utility/empInfo/viewAttSearchEmployeeWithCheckBox", modelMap);
    }

    @RequestMapping(value = "/viewCustSearchEmployeeAll", method = RequestMethod.GET)
    public ModelAndView viewCustSearchEmployeeAll(HttpServletRequest request, ModelMap modelMap) throws Exception {
        return new ModelAndView("/web/utility/empInfo/viewCustSearchEmployeeAll", modelMap);
    }

    @RequestMapping(value = "/viewCustSearchEmployee", method = RequestMethod.GET)
    public ModelAndView viewCustSearchEmployee(HttpServletRequest request, ModelMap modelMap) throws Exception {
        return new ModelAndView("/web/utility/empInfo/viewCustSearchEmployee", modelMap);
    }

    @RequestMapping(value = "/viewCustSearchEmployeeB", method = RequestMethod.GET)
    public ModelAndView viewCustSearchEmployeeB(HttpServletRequest request, ModelMap modelMap) throws Exception {
        return new ModelAndView("/web/utility/empInfo/viewCustSearchEmployeeB", modelMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getCustSearchEmployeeList", method = RequestMethod.POST)
    @ResponseBody
    public Map getCustSearchEmployeeList(HttpServletRequest request) throws Exception {
        List custSearchEmployeeList = this.utilityEmpInfoSer.getCustSearchEmployeeList(request);
        int custSearchEmployeeCnt = this.utilityEmpInfoSer.getCustSearchEmployeeCnt(request);
        Map model = new HashMap();
        model.put("Rows", custSearchEmployeeList);
        model.put("Total", custSearchEmployeeCnt);
        return model;
    }

}
