package com.siping.web.utility.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.siping.web.utility.service.UtilityPostInfoSer;

@Controller
@RequestMapping(value = "/utility/roleInfo")
public class UtilityRoleInfoCtroller {
    Logger logger = Logger.getLogger(UtilityRoleInfoCtroller.class);
    @Autowired
    private UtilityPostInfoSer UtilityPostInfoSer;

    @RequestMapping(value = "/searchRole", method = RequestMethod.GET)
    public ModelAndView searchPost(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        return new ModelAndView("/web/utility/roleInfo/searchRole", modelMap);
    }
}
