package com.siping.ess.action;

import java.util.Date;
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

import com.siping.ess.service.PasswordSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/ess/password")
public class PasswordCtroller {

    Logger logger = Logger.getLogger(PasswordCtroller.class);

    @Autowired
    private PasswordSer passwordSer;

    /**
     * 密码
     * @param changePassword
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/changePassword")
    public ModelAndView getPersonInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        modelMap.put("admin", admin);
        modelMap.put("currDate", DateUtil.getSysdateString("yyyy-MM-dd"));
        return new ModelAndView("/ess/password/changePassword", modelMap);
    }

    @RequestMapping(value = "/forgetPassword")
    public ModelAndView forgetPassword(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        String username = request.getParameter("username");
        modelMap.put("username", username);
        modelMap.put("currDate", DateUtil.getSysdateString("yyyy-MM-dd"));
        return new ModelAndView("/ess/password/forgetPassword", modelMap);
    }

    /**
     * 修改密码
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updatePassword", method = RequestMethod.POST)
    @ResponseBody
    public String updatePassword(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        String temp = passwordSer.updatePassword(request);
        return temp;
    }

    /**
     * 验证验证码是否正确
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/checkCheckCodeUpdatePassword", method = RequestMethod.GET)
    @ResponseBody
    public String checkCheckCodeUpdatePassword(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        Map param = ObjectBindUtil.getRequestParamData(request);
        Date end_date = passwordSer.getEndDate(param);
        if (end_date == null)
            return "1";
        Date nowtime = new Date();
        int hour = end_date.getHours() + 12;
        end_date.setHours(hour);
        if (nowtime.before(end_date)) {
            return passwordSer.updatepasswordAndCheckcode(param);
        } else
            return "0";
    }

    @RequestMapping(value = "/getVerifyCode", method = RequestMethod.POST)
    @ResponseBody
    public String getVerifyCode(HttpServletRequest request){
        String username = request.getParameter("USERNAME");
        String returnString = this.passwordSer.forgetPassword(username);
        if("-1".equals(returnString)){
            return "N";
        }
        String email = passwordSer.getVerifyCode(username);
        return email;
    }
}
