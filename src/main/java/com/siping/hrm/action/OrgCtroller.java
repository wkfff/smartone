package com.siping.hrm.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.hrm.service.OrgSer;

@Controller
@RequestMapping(value = "/hrm/org")
public class OrgCtroller {
    Logger logger = Logger.getLogger(OrgCtroller.class);

    @Autowired
    private OrgSer OrgSer;

    @RequestMapping(value = "/viewOrgInfo", method = RequestMethod.GET)
    public ModelAndView viewOrgInfo(HttpServletRequest request, ModelMap modelMap) throws Exception {
        return new ModelAndView("/hrm/org/viewOrgInfo", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getDeptInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getDeptInfo(HttpServletRequest request) {
        List deptInfoList = this.OrgSer.getDeptInfo(request);
        int deptInfoCnt = this.OrgSer.getDeptInfoCnt(request);

        Map model = new HashMap();
        model.put("Rows", deptInfoList);
        model.put("Total", deptInfoCnt);

        return model;
    }

    @RequestMapping(value = "/updateDeptInfo", method = RequestMethod.GET)
    public ModelAndView updateDeptInfo(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("deptInfoMap", this.OrgSer.getDeptInfoObj(request));

        return new ModelAndView("/hrm/org/updateDeptInfo", modelMap);
    }

    @RequestMapping(value = "/viewDeptInfo", method = RequestMethod.GET)
    public ModelAndView viewDeptInfo(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("deptInfoMap", this.OrgSer.getDeptInfoObj(request));

        return new ModelAndView("/hrm/org/viewDeptInfo", modelMap);
    }

    /**
     * 更新部门信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updateDeptInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updateDeptInfo(HttpServletRequest request) {
        return this.OrgSer.updateDeptInfo(request);
    }

    @RequestMapping(value = "/addDeptInfo", method = RequestMethod.GET)
    public ModelAndView addDeptInfo(HttpServletRequest request, ModelMap modelMap) throws Exception {
        return new ModelAndView("/hrm/org/addDeptInfo", modelMap);
    }

    /**
     * 添加部门信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addDeptInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addDeptInfo(HttpServletRequest request) throws Exception {
        return this.OrgSer.addDeptInfo(request);
    }

    /**
     * 删除部门信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/deleteDeptInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deleteDeptInfo(HttpServletRequest request) throws Exception {
        int cnt = this.OrgSer.checkDeptChildren(request);
        if (cnt > 0) {
            return "该部门下拥有子部门，不能删除";
        } else {
            return this.OrgSer.deleteDeptInfo(request);
        }
    }

    @RequestMapping(value = "/viewOrgInfoTree", method = RequestMethod.GET)
    public ModelAndView viewOrgInfoTree(HttpServletRequest request) throws Exception {
        return new ModelAndView("/hrm/org/viewOrgInfoTree");
    }

    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getOrgInfoTreeList", method = RequestMethod.GET)
    @ResponseBody
    public List getOrgInfoTreeList(HttpServletRequest request) throws Exception {
        return this.OrgSer.getDeptInfoTree(request);
    }

    /**
     * 定编信息
     * @param request
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getDeptQuotaList", method = RequestMethod.POST)
    @ResponseBody
    public Map getDeptQuotaList(HttpServletRequest request) {
        List deptQuotaList = this.OrgSer.getDeptQuotaList(request);
        int deptQuotaListCnt = this.OrgSer.getDeptQuotaListCnt(request);
        Map model = new HashMap();
        model.put("Rows", deptQuotaList);
        model.put("Total", deptQuotaListCnt);
        return model;
    }

    @RequestMapping(value = "/addDeptQuotaInfo", method = RequestMethod.GET)
    public ModelAndView addDeptQuotaInfo(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("deptInfoMap", this.OrgSer.getDeptInfoObj(request));

        return new ModelAndView("/hrm/org/addDeptQuotaInfo", modelMap);
    }

    /**
     * 添加定编信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addDeptQuotaInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addDeptQuotaInfo(HttpServletRequest request) {
        return this.OrgSer.addDeptQuotaInfo(request);
    }

    /**
     * 删除定编信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/deleteDeptQuotaInfo", method = RequestMethod.POST)
    @ResponseBody
    public String deleteDeptQuotaInfo(HttpServletRequest request) throws Exception {
        return this.OrgSer.deleteDeptQuotaInfo(request);
    }

    /**
     * 修改定编信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updateDeptQuotaInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updateDeptQuotaInfo(HttpServletRequest request) throws Exception {
        return this.OrgSer.updateDeptQuotaInfo(request);
    }

    /**
     * 将一个部门的人员批量转移到其他部门
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/massTransferEmployees", method = RequestMethod.POST)
    @ResponseBody
    public String updateContractInfo(HttpServletRequest request) throws Exception {

        String returnString = this.OrgSer.massTransferEmployees(request);
        return returnString;
    }
}
