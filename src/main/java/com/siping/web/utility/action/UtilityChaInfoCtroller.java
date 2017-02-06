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
@RequestMapping(value = "/utility/chaInfo")
public class UtilityChaInfoCtroller {

    @Autowired
    private UtilityChaInfoSer utilityChaInfoSer;

    @RequestMapping(value = "/viewChannelList", method = RequestMethod.GET)
    public ModelAndView viewChannelList(HttpServletRequest request) {
        return new ModelAndView("/web/utility/chaInfo/searchChannel");
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getChannelList", method = RequestMethod.POST)
    @ResponseBody
    public Map getChannelList(HttpServletRequest request, HttpServletResponse response) {
        Map modelMap = new HashMap();
        modelMap.put("Rows", this.utilityChaInfoSer.getChannelList(request));
        modelMap.put("Total", this.utilityChaInfoSer.getChannelListCnt(request));
        return modelMap;
    }

}
