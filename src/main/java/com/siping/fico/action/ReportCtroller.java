package com.siping.fico.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/fico/report")
public class ReportCtroller {

    Logger logger = Logger.getLogger(ReportCtroller.class);

    /**
     * 页面跳转
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/{reportType}")
    public ModelAndView getPersonInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        modelMap.put("toDate", new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        return new ModelAndView("", modelMap);
    }

}
