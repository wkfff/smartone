package com.siping.report.ess.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.siping.report.ess.service.EssInfoExcelSer;

@Controller
@RequestMapping(value = "/report/ess")
public class EssInfoReportCtroller {
    Logger logger = Logger.getLogger(EssInfoReportCtroller.class);

    @Autowired
    private EssInfoExcelSer essInfoExcelSer;

    @RequestMapping(value = "/viewWhInfoReport", method = RequestMethod.GET)
    public void viewWhInfoReport(HttpServletRequest request, HttpServletResponse response) throws Exception {
        essInfoExcelSer.viewWhInfoReport(request, response);

    }

    @RequestMapping(value = "/viewWhConclusion", method = RequestMethod.GET)
    public void viewWhConclusion(HttpServletRequest request, HttpServletResponse response) throws Exception {
        essInfoExcelSer.viewWhConclusion(request, response);

    }
    @RequestMapping(value = "/viewWhConclusionSum", method = RequestMethod.GET)
    public void viewWhConclusionSum(HttpServletRequest request, HttpServletResponse response) throws Exception {
        essInfoExcelSer.viewWhConclusionSum(request, response);

    }
}
