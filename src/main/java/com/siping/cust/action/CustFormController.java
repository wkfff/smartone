package com.siping.cust.action;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindException;
import org.springframework.validation.Errors;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractWizardFormController;

import bsh.This;

import com.siping.cust.bean.Customer;
import com.siping.cust.service.CustManageSer;
import com.siping.cust.service.SalesSettingSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.SessionUtil;

/**
 * @Description:
 * @author yinglai.yuan
 * @date 2014-2-13 下午2:30:56
 * @version V2.0 © copyright -Made by SiPingSoft.
 */
@Controller
@SuppressWarnings("deprecation")
public class CustFormController extends AbstractWizardFormController {

    @Autowired
    private CustManageSer custManageSer;
    private String successView;
    private String failedView;
  

    public String getFailedView() {
        return failedView;
    }

    public void setFailedView(String failedView) {
        this.failedView = failedView;
    }

    private String cancelView;

    @Autowired
    private SalesSettingSer salesSettingSer;

    public String getSuccessView() {
        return successView;
    }

    public void setSuccessView(String successView) {
        this.successView = successView;
    }

    public String getCancelView() {
        return cancelView;
    }

    @Override
    protected int getInitialPage(HttpServletRequest request, Object command) {
       AdminBean admin = SessionUtil.getLoginUserFromSession(request);
       request.getSession().setAttribute("isSupervisor",salesSettingSer.isSupervisor(request));
       if(request.getSession().getAttribute("isSupervisor")!="")
       {
           request.setAttribute("userName",this.custManageSer.getCustomerNameById(request).getCustomerName());
           request.setAttribute("ownerId", admin.getAdminID());
       }
        return super.getInitialPage(request);
    }

    public void setCancelView(String cancelView) {
        this.cancelView = cancelView;
    }

    public CustFormController() {
        setCommandClass(Customer.class);
        setCommandName("customer");// 绑定javaBean
    }

    @Override
    protected ModelAndView processFinish(HttpServletRequest request,
            HttpServletResponse response, Object command, BindException errors)
            throws Exception {
        Customer customer = (Customer) command;
        String returnString="N";
        try {
            this.custManageSer.addCustomer(request, customer);
            returnString="Y";
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getSession().removeAttribute("isSupervisor");
        if(returnString=="Y")
        {
            return new ModelAndView(this.getSuccessView(), "customer", customer);
        }
        else {
            return new ModelAndView(this.getFailedView(), "customer", customer);
        }
    }

    @Override
    protected ModelAndView processCancel(HttpServletRequest request,
            HttpServletResponse response, Object command, BindException errors)
            throws Exception {
        return null;
    }

    @SuppressWarnings("rawtypes")
    @Override
    protected Map referenceData(HttpServletRequest request, int page)
            throws Exception {
        return super.referenceData(request, page);
    }

}
