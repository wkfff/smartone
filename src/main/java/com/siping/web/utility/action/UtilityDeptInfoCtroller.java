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

import com.siping.web.utility.JsonUtil;
import com.siping.web.utility.service.UtilityDeptInfoSer;

@Controller
@RequestMapping(value = "/utility/deptInfo")
public class UtilityDeptInfoCtroller {
    Logger logger = Logger.getLogger(UtilityDeptInfoCtroller.class);

    @Autowired
    private UtilityDeptInfoSer utilityDeptInfoSer;

    @RequestMapping(value = "/selectDepartmentBeforeOpen", method = RequestMethod.GET)
    public ModelAndView selectDepartmentBeforeOpen(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        return new ModelAndView("/web/utility/deptInfo/selectDepartmentBeforeOpen", modelMap);
    }

    @RequestMapping(value = "/selectDepartment", method = RequestMethod.GET)
    public ModelAndView selectDepartment(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        return new ModelAndView("/web/utility/deptInfo/selectDepartment", modelMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getDepartmentInfoList")
    @ResponseBody
    public Map getDepartmentInfoList(HttpServletRequest request) throws Exception {

        List deptInfoList = this.utilityDeptInfoSer.getDepartmentInfoList(request);

        int deptInfoListCnt = this.utilityDeptInfoSer.getDepartmentInfoListCnt(request);

        Map model = new HashMap();
        model.put("deptInfoList", deptInfoList);
        model.put("deptInfoListCnt", deptInfoListCnt);

        return model;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getDeptTreeInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getDeptTreeInfo(HttpServletRequest request) throws Exception {

        String string = JsonUtil.deptInfoToJson(this.utilityDeptInfoSer.getDeptTreeInfo(request));

        Map model = new HashMap();
        model.put("dataJson", string);

        return model;
    }

    @SuppressWarnings({ "unchecked" })
    @RequestMapping(value = "/getDeptTreeInfoTree", method = RequestMethod.POST)
    @ResponseBody
    public String getDeptTreeInfoTree(HttpServletRequest request) throws Exception {

        String string = JsonUtil.deptInfoToJson(this.utilityDeptInfoSer.getDeptTreeInfo(request));

        return string;
    }

    /**
     * 获取部门下拉菜单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getDeptSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getDeptSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.utilityDeptInfoSer.getDeptSelectList(request);

        return listMap;
    }
}
