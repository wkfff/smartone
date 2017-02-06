package com.siping.web.utility.action;

import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/utility/fico")
public class UtilityFICOInfoCtroller {

    @RequestMapping(value = "/viewTaskList", method = RequestMethod.GET)
    public ModelAndView viewTaskList(HttpServletRequest request) {
        return new ModelAndView("/web/utility/ficoInfo/searchTask");
    }

    @RequestMapping(value = "/viewAccountList", method = RequestMethod.GET)
    public ModelAndView viewAccountList(HttpServletRequest request) {
        return new ModelAndView("/web/utility/ficoInfo/searchAccount");
    }

}
