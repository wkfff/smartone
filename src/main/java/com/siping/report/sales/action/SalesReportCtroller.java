package com.siping.report.sales.action;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
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

import com.siping.report.sales.service.SalesReportSer;
import com.siping.web.utility.DateUtil;

@Controller
@RequestMapping(value = "/report/sales")
public class SalesReportCtroller {

    @Autowired
    private SalesReportSer salesReportSer;

    @RequestMapping(value = "/viewCustomerSalesReport")
    public ModelAndView viewCustomerSalesReport(HttpServletRequest request,
            ModelMap modelMap) {
        modelMap.put("FOU_AGO", DateUtil.formatDate(DateUtil.getPurMonthDate(new Date(),-48),"yyyy"));
        modelMap.put("THR_AGO", DateUtil.formatDate(DateUtil.getPurMonthDate(new Date(),-36),"yyyy"));
        modelMap.put("TWO_AGO", DateUtil.formatDate(DateUtil.getPurMonthDate(new Date(),-24),"yyyy"));
        modelMap.put("ONE_AGO", DateUtil.formatDate(DateUtil.getPurMonthDate(new Date(),-12),"yyyy"));
        modelMap.put("ZER_AGO", DateUtil.formatDate(new Date(),"yyyy"));
        
        return new ModelAndView("/report/sales/viewCustomerSalesReport",modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getCustomerMonthlySalesList", method = RequestMethod.POST)
    @ResponseBody
    public Map getCustomerMonthlySalesList(HttpServletRequest request) {
        List empInfoList = this.salesReportSer.getCustomerMonthlySalesList(request);
        int empInfoCnt = this.salesReportSer.getCustomerMonthlySalesCnt(request);

        Map model = new HashMap();
        model.put("Rows", empInfoList);
        model.put("Total", empInfoCnt);
        return model;
    }
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getCustomerYearlySalesList", method = RequestMethod.POST)
    @ResponseBody
    public Map getCustomerYearlySalesList(HttpServletRequest request) {
        List empInfoList = this.salesReportSer.getCustomerYearlySalesList(request);
        int empInfoCnt = this.salesReportSer.getCustomerYearlySalesCnt(request);

        Map model = new HashMap();
        model.put("Rows", empInfoList);
        model.put("Total", empInfoCnt);
        return model;
    }

    @RequestMapping(value = "/viewProductSalesReport")
    public ModelAndView viewProductSalesReport(HttpServletRequest request,
            ModelMap modelMap) {
        modelMap.put("FOU_AGO", DateUtil.formatDate(DateUtil.getPurMonthDate(new Date(),-48),"yyyy"));
        modelMap.put("THR_AGO", DateUtil.formatDate(DateUtil.getPurMonthDate(new Date(),-36),"yyyy"));
        modelMap.put("TWO_AGO", DateUtil.formatDate(DateUtil.getPurMonthDate(new Date(),-24),"yyyy"));
        modelMap.put("ONE_AGO", DateUtil.formatDate(DateUtil.getPurMonthDate(new Date(),-12),"yyyy"));
        modelMap.put("ZER_AGO", DateUtil.formatDate(new Date(),"yyyy"));
        
        return new ModelAndView("/report/sales/viewProductSalesReport",modelMap);
    }
    
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getProductMonthlySalesList", method = RequestMethod.POST)
    @ResponseBody
    public Map getProductMonthlySalesList(HttpServletRequest request) {
        List empInfoList = this.salesReportSer.getProductMonthlySalesList(request);
        int empInfoCnt = this.salesReportSer.getProductMonthlySalesCnt(request);

        Map model = new HashMap();
        model.put("Rows", empInfoList);
        model.put("Total", empInfoCnt);
        return model;
    }
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getProductYearlySalesList", method = RequestMethod.POST)
    @ResponseBody
    public Map getProductYearlySalesList(HttpServletRequest request) {
        List empInfoList = this.salesReportSer.getProductYearlySalesList(request);
        int empInfoCnt = this.salesReportSer.getProductYearlySalesCnt(request);

        Map model = new HashMap();
        model.put("Rows", empInfoList);
        model.put("Total", empInfoCnt);
        return model;
    }
    @RequestMapping(value="/viewSalesReport")
    public ModelAndView getProductReport(HttpServletRequest request)
    {
        return new ModelAndView("/report/sales/viewSalesReport");
    }

    @RequestMapping(value="/viewStorageReport")
    public ModelAndView getStorageReport(HttpServletRequest request)
    {
        return new ModelAndView("/report/sales/viewStorageReport");
    }
}
