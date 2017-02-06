package com.siping.cust.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.siping.cust.service.*;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.JsonUtil;
import com.siping.web.utility.SessionUtil;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

@Controller
@RequestMapping(value = "/cust/custInfo")
public class CustInfoCtroller {
    Logger logger = Logger.getLogger(CustInfoCtroller.class);

    @Autowired
    private CustInfoSer custInfoSer;

    @Autowired
    private SalesSettingSer salesSettingSer;

    @RequestMapping(value = "/viewCustomerDetail", method = GET)
    public ModelAndView viewCustomerDetail(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("customerDetail", this.custInfoSer.getCustomerDetail(request));
        return new ModelAndView("/cust/custInfo/viewCustomerDetail", modelMap);
    }

    @RequestMapping(value = "/viewCustomerList", method = GET)
    public ModelAndView viewCustomerList(HttpServletRequest request, ModelMap modelMap) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        modelMap.put("isSupervisor", salesSettingSer.isSupervisor(request));
        modelMap.put("EMP_ID", admin.getAdminID());
        return new ModelAndView("/cust/custInfo/viewCustomerList", modelMap);
    }

    @SuppressWarnings({"rawtypes"})
    @RequestMapping(value = "/getCustomerList", method = POST)
    @ResponseBody
    public Map getCustomerList(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("Rows", this.custInfoSer.getCustomerList(request));
        modelMap.put("Total", this.custInfoSer.getCustomerListCnt(request));
        return modelMap;
    }

    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/getAllCustomers", method = GET)
    @ResponseBody
    public List getAllCustomersList(HttpServletRequest request, ModelMap modelMap){
        try {
            modelMap.put("Rows",JsonUtil.writeInternal(this.custInfoSer.getAllCustomerList(request)));
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            return this.custInfoSer.getAllCustomerList(request);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
