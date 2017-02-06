package com.siping.cust.action;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.cust.service.SalesSettingSer;
import com.siping.web.utility.JsonUtil;
import com.siping.web.utility.service.UtilityDeptInfoSer;

@Controller
@RequestMapping(value = "/sales/salesSetting")
public class SalesSettingCtroller {
    Logger logger = Logger.getLogger(SalesSettingCtroller.class);

    @Autowired
    private SalesSettingSer salesSettingSer;
    @Autowired
    private UtilityDeptInfoSer utilityDeptInfoSer;

    /***************************** info part ****************************/
    @RequestMapping(value = "/viewSalesKeeperList", method = RequestMethod.GET)
    public ModelAndView viewSalesKeeperList(HttpServletRequest request) {
        return new ModelAndView("/cust/salesSetting/viewSalesKeeper");
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getSalesKeeperList", method = RequestMethod.POST)
    @ResponseBody
    public Map getSalesomeKeeperrList(HttpServletRequest request, HttpServletResponse response) {
        Map modelMap = new HashMap();
        modelMap.put("Rows", this.salesSettingSer.getSalesKeeperList(request));
        modelMap.put("Total", this.salesSettingSer.getSalesKeeperListCnt(request));
        return modelMap;
    }

    @RequestMapping(value = "/viewDirectSales", method = RequestMethod.GET)
    public ModelAndView viewDirectSales(HttpServletRequest request) {
        return new ModelAndView("/cust/salesSetting/viewDirectSales");
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getDirectSalesList", method = RequestMethod.POST)
    @ResponseBody
    public Map getDirectSalesList(HttpServletRequest request, HttpServletResponse response) {
        Map modelMap = new HashMap();
        modelMap.put("Rows", this.salesSettingSer.getDirectSalesList(request));
        modelMap.put("Total", this.salesSettingSer.getDirectSalesListCnt(request));
        return modelMap;
    }

    @RequestMapping(value = "/viewNetworkSales", method = RequestMethod.GET)
    public ModelAndView viewNetworkSales(HttpServletRequest request) {
        return new ModelAndView("/cust/salesSetting/viewNetworkSales");
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getNetworkSalesList", method = RequestMethod.POST)
    @ResponseBody
    public Map getNetworkSalesList(HttpServletRequest request, HttpServletResponse response) {
        Map modelMap = new HashMap();
        modelMap.put("Rows", this.salesSettingSer.getNetworkSalesList(request));
        modelMap.put("Total", this.salesSettingSer.getNetworkSalesListCnt(request));
        return modelMap;
    }

    /***************************** manage part **************************/
    @RequestMapping(value = "/removeSalesKeeper", method = RequestMethod.POST)
    @ResponseBody
    public String removeSalesKeeper(HttpServletRequest request, ModelMap modelMap) {
        return this.salesSettingSer.removeSalesKeeper(request);
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/addSalesKeeper", method = RequestMethod.GET)
    public ModelAndView addSalesKeeper(HttpServletRequest request, ModelMap modelMap) {
        String string = JsonUtil.deptInfoToJson(this.utilityDeptInfoSer.getDeptTreeInfo(request));
        modelMap.put("dataJson", string);
        modelMap.put("type", "add");
        return new ModelAndView("/cust/salesSetting/transferSalesKeeper", modelMap);
    }

    @SuppressWarnings("unchecked")
    @RequestMapping(value = "/updateSalesKeeper", method = RequestMethod.GET)
    public ModelAndView updateSalesKeeper(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("salesKeeperDetail", this.salesSettingSer.getSalesKeeperDetail(request));
        String string = JsonUtil.deptInfoToJson(this.salesSettingSer.getSalesKeeperDeptInfo(request));
        modelMap.put("dataJson", string);
        modelMap.put("type", "update");
        return new ModelAndView("/cust/salesSetting/transferSalesKeeper", modelMap);
    }

    @RequestMapping(value = "/transferSalesKeeper")
    @ResponseBody
    public String transferSalesKeeper(HttpServletRequest request, ModelMap modelMap) {
        String resultString = "Y";
        try {
            this.salesSettingSer.transferSalesKeeper(request);
        } catch (SQLException e) {
            resultString = e.getMessage();
            e.printStackTrace();
        }
        return resultString;
    }

    @RequestMapping(value = "/transferDirectSales", method = RequestMethod.POST)
    @ResponseBody
    public String transferDirectSales(HttpServletRequest request, ModelMap modelMap) {
        String resultString = "Y";
        try {
            this.salesSettingSer.transferDirectSales(request);
        } catch (SQLException e) {
            resultString = e.getMessage();
            e.printStackTrace();
        }
        return resultString;
    }

    @RequestMapping(value = "/transferNetworkSales", method = RequestMethod.POST)
    @ResponseBody
    public String transferNetworkSales(HttpServletRequest request, ModelMap modelMap) {
        String resultString = "Y";
        try {
            this.salesSettingSer.transferNetworkSales(request);
        } catch (SQLException e) {
            resultString = e.getMessage();
            e.printStackTrace();
        }
        return resultString;
    }

    @RequestMapping(value = "/removeDirectSales")
    @ResponseBody
    public String removeDirectSales(HttpServletRequest request, HttpServletResponse response) {
        String resultString = "Y";
        try {
            resultString = this.salesSettingSer.removeDirectSales(request);
        } catch (SQLException e) {
            resultString = e.getMessage();
            e.printStackTrace();
        }
        return resultString;
    }
}
