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
@RequestMapping(value = "/utility/matInfo")
public class UtilityMatInfoCtroller {

    @Autowired
    private UtilityMatInfoSer utilityMatInfoSer;

    @RequestMapping(value = "/viewMaterialList", method = RequestMethod.GET)
    public ModelAndView viewMaterialList(HttpServletRequest request) {
        return new ModelAndView("/web/utility/matInfo/searchMaterial");
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getMaterialList", method = RequestMethod.POST)
    @ResponseBody
    public Map getMaterialList(HttpServletRequest request, HttpServletResponse response) {
        Map modelMap = new HashMap();
        modelMap.put("Rows", this.utilityMatInfoSer.getMaterialList(request));
        modelMap.put("Total", this.utilityMatInfoSer.getMaterialListCnt(request));
        return modelMap;
    }

}
