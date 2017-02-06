package com.siping.web.utility.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.web.utility.service.UtilityDocInfoSer;

@Controller
@RequestMapping(value = "/utility/docInfo")
public class UtilityDocInfoCtroller {
    @Autowired
    private UtilityDocInfoSer utilityDocInfoSer;

    @RequestMapping(value = "/viewDocumentList", method = RequestMethod.GET)
    public ModelAndView viewDocList(HttpServletRequest request, ModelMap modelmap) {
        return new ModelAndView("/web/utility/docInfo/searchDocument", modelmap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getDocList", method = RequestMethod.POST)
    @ResponseBody
    public Map getDocList(HttpServletRequest request, HttpServletResponse response) {
        Map modelMap = new HashMap();
        modelMap.put("Rows", this.utilityDocInfoSer.getDocList(request));
        modelMap.put("Total", this.utilityDocInfoSer.getDocListCnt(request));
        return modelMap;
    }

    @RequestMapping(value = "/viewDocTypeList", method = RequestMethod.GET)
    public ModelAndView viewDocTypeList(HttpServletRequest request, ModelMap modelmap) {
        return new ModelAndView("/web/utility/docInfo/searchDocType", modelmap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getDocTypeList", method = RequestMethod.POST)
    @ResponseBody
    public Map getDocTypeList(HttpServletRequest request, HttpServletResponse response) {
        Map modelMap = new HashMap();
        modelMap.put("Rows", this.utilityDocInfoSer.getDocTypeList(request));
        modelMap.put("Total", this.utilityDocInfoSer.getDocTypeListCnt(request));
        return modelMap;
    }
}
