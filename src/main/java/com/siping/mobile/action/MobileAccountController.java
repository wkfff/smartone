package com.siping.mobile.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.mobile.service.MobileAccountSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/mobile/account")
public class MobileAccountController {
    @Autowired
    private MobileAccountSer mobileAccountSer;

    /**
     * 依据账号不同，进入不同的账号管理界面
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/accountManage", method = RequestMethod.GET)
    public ModelAndView accountManage(HttpServletRequest request, ModelMap modelMap) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        String accountType = admin.getAccountType();
        if ("CU".equals(accountType)) {
            modelMap.put("CUSTOMER", this.mobileAccountSer.getCustomer(request));
            modelMap.put("RECEIVERLIST", this.mobileAccountSer.getReciverList(request));
            modelMap.put("RECEIVERCNT", this.mobileAccountSer.getReciverCnt(request));
            return new ModelAndView("/mobile/account/viewCuAccountManage", modelMap);
        }else{
            return new ModelAndView("/mobile/account/viewUpdatePassword", modelMap);
        }
    }

    /**
     * 客户进入密码修改页面
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/viewUpdatePassword", method = RequestMethod.GET)
    public ModelAndView viewUpdatePassword(HttpServletRequest request, ModelMap modelMap) {
        return new ModelAndView("/mobile/account/viewUpdatePassword", modelMap);
    }
    
    /**
     * 本公司员工以及客户修改密码
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
    @ResponseBody
    public String updatePassword(HttpServletRequest request) {
        String returnString = "UPDATE_ERROR";
        try {
            returnString = this.mobileAccountSer.updatePassword(request);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnString;
    }

    /**
     * 客户进入账户修改页面
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/viewUpdateCuAccountInfo", method = RequestMethod.GET)
    public ModelAndView viewUpdateAccountInfo(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("CUSTOMER", this.mobileAccountSer.getCustomer(request));
        
        return new ModelAndView("/mobile/account/viewUpdateCuAccountInfo", modelMap);
    }

    /**
     * 客户进入企业信息修改页面
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/viewUpdateCuCompanyInfo", method = RequestMethod.GET)
    public ModelAndView viewUpdateCuCompanyInfo(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("CUSTOMER", this.mobileAccountSer.getCustomer(request));
        
        return new ModelAndView("/mobile/account/viewUpdateCuCompanyInfo", modelMap);
    }

    /**
     * 客户进入收貨人添加界面
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/viewAddReceiverInfo", method = RequestMethod.GET)
    public ModelAndView viewAddReceiverInfo(HttpServletRequest request, ModelMap modelMap) {
        
        return new ModelAndView("/mobile/account/viewAddReceiverInfo", modelMap);
    }

    /**
     * 依据parent_code从sy_code中获取城市或者地区list
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value="/getSelectList", method=RequestMethod.POST)
    @ResponseBody
    public List getSelectList(HttpServletRequest request) throws Exception {
        List cityList = this.mobileAccountSer.getSelectList(request);

        return cityList;
    }

    /**
     * 客户修改本公司信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updateCustInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updateCustInfo(HttpServletRequest request) {
        String returnString = "UPDATE_ERROR";
        try {
            returnString = this.mobileAccountSer.updateCustInfo(request);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnString;
    }

    /**
     * 客户添加收貨人
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addReceiver", method = RequestMethod.POST)
    @ResponseBody
    public String addReceiver(HttpServletRequest request) {
        String returnString = "INSERT_ERROR";
        try {
            returnString = this.mobileAccountSer.insertReceiver(request);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnString;
    }

    /**
     * 客户进入收貨人信息修改界面
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/viewUpdateReceiverInfo", method = RequestMethod.GET)
    public ModelAndView viewUpdateReceiverInfo(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("receiver", this.mobileAccountSer.getReceiver(request));
        
        return new ModelAndView("/mobile/account/viewUpdateReceiverInfo", modelMap);
    }

    /**
     * 客户修改收货人信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updateReceiver", method = RequestMethod.POST)
    @ResponseBody
    public String updateReceiver(HttpServletRequest request) {
        String returnString = "UPDATE_ERROR";
        try {
            returnString = this.mobileAccountSer.updateReceiver(request);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnString;
    }

    /**
     * 客户删除收货人
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/deleteReceiver", method = RequestMethod.POST)
    @ResponseBody
    public String deleteReceiver(HttpServletRequest request) {
        String returnString = "DELETE_ERROR";
        try {
            returnString = this.mobileAccountSer.deleteReceiver(request);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnString;
    }
}
