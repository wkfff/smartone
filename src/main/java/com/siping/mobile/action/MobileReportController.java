package com.siping.mobile.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**  
 * @Description:
 * @author yinglai.yuan 
 * @date 2014-3-4 下午3:04:23
 * @version V2.0
 * © copyright -Made by SiPingSoft. 
 */

/**
 * 查看销售报表
 * */
@Controller
@RequestMapping(value="/mobile")
public class MobileReportController {
    Logger logger = Logger.getLogger(MobileReportController.class);

    @RequestMapping("/salesReport")
    public ModelAndView viewSalesReport(HttpServletRequest request,HttpServletResponse response)
    {
        return new ModelAndView("/mobile/report/salesReport");
    }
/**
 * 查看库存报表
 * **/
    @RequestMapping("/prostorReport")
    public ModelAndView viewProstorReport(HttpServletRequest request,HttpServletResponse response)
    {
        return new ModelAndView("/mobile/report/prostorReport");
    }
}
