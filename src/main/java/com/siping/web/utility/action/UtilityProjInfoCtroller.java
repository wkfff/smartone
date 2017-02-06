package com.siping.web.utility.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.web.utility.service.*;

@Controller
@RequestMapping(value = "/utility/projInfo")
public class UtilityProjInfoCtroller {

    @Autowired
    private UtilityProjInfoSer utilityProjInfoSer;

    @RequestMapping(value = "/viewProjectList", method = RequestMethod.GET)
    public ModelAndView viewProductList(HttpServletRequest request) {
        return new ModelAndView("/web/utility/projInfo/searchProject");
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getProjectProcessList", method = RequestMethod.POST)
    @ResponseBody
    public Map getDocList(HttpServletRequest request, HttpServletResponse response) {
        Map modelMap = new HashMap();
        modelMap.put("Rows", this.utilityProjInfoSer.getProjectProcessList(request));
        modelMap.put("Total", this.utilityProjInfoSer.getProjectProcessListCnt(request));
        return modelMap;
    }

}
