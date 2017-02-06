package com.siping.web.utility.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.cust.service.SalesSettingSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.service.UtilityCustInfoSer;

@Controller
@RequestMapping(value = "/utility/custInfo")
public class UtilityCustInfoCtroller {

    @Autowired
    private UtilityCustInfoSer utilityCustInfoSer;

    @Autowired
    private SalesSettingSer salesSettingSer;

    @RequestMapping(value = "/viewCustomerList", method = RequestMethod.GET)
    public ModelAndView viewCustomerList(HttpServletRequest request, ModelMap modelmap,
                                         @RequestParam(required = false) String ownerId) {
        modelmap.put("isSupervisor", salesSettingSer.isSupervisor(request));
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        modelmap.put("EMP_ID", admin.getAdminID());
        if (ownerId == null) {
            modelmap.put("ownerId", admin.getAdminID());
        } else {
            modelmap.put("ownerId", ownerId);
        }
        return new ModelAndView("/web/utility/custInfo/searchCustomer", modelmap);
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    @RequestMapping(value = "/getCustomerList", method = RequestMethod.POST)
    @ResponseBody
    public Map getCustomerList(HttpServletRequest request, HttpServletResponse response) {
        Map modelMap = new HashMap();
        modelMap.put("Rows", this.utilityCustInfoSer.getCustomerList(request));
        modelMap.put("Total", this.utilityCustInfoSer.getCustomerListCnt(request));
        return modelMap;
    }

    @RequestMapping(value = "/viewAllCustomerList", method = RequestMethod.GET)
    public ModelAndView viewAllCustomerList(HttpServletRequest request, ModelMap modelmap) {

        return new ModelAndView("/web/utility/custInfo/searchAllCustomer", modelmap);
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    @RequestMapping(value = "/getAllCustomerList", method = RequestMethod.POST)
    @ResponseBody
    public Map getAllCustomerList(HttpServletRequest request, HttpServletResponse response) {
        Map modelMap = new HashMap();
        modelMap.put("Rows", this.utilityCustInfoSer.getAllCustomerList(request));
        modelMap.put("Total", this.utilityCustInfoSer.getAllCustomerListCnt(request));
        return modelMap;
    }
}
