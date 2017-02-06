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

import com.siping.bom.service.BOMInfoSer;

@Controller
@RequestMapping(value = "/utility/bomInfo")
public class UtilityBOMInfoCtroller {

    @Autowired
    private BOMInfoSer bomInfoSer;

    @RequestMapping(value = "/viewBOMList", method = RequestMethod.GET)
    public ModelAndView viewBOMList(HttpServletRequest request) {
        return new ModelAndView("/web/utility/bomInfo/searchBOM");
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getBOMList", method = RequestMethod.POST)
    @ResponseBody
    public Map getBOMList(HttpServletRequest request, HttpServletResponse response) {
        Map modelMap = new HashMap();
        return modelMap;
    }

}
