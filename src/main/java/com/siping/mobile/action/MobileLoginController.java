package com.siping.mobile.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.mobile.service.MobileLoginSer;

@Controller
@RequestMapping(value = "/mobile/login")
public class MobileLoginController {
    @Autowired
    private MobileLoginSer mobileLoginSer;

    /**
     * 进入移动端用户登陆界面
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public ModelAndView index(HttpServletRequest request, ModelMap modelMap) {
        return new ModelAndView("/mobile/login/index", modelMap);
    }

    /**
     * 进入移动端用户注册页面
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public ModelAndView register(HttpServletRequest request, ModelMap modelMap) {
        return new ModelAndView("/mobile/login/register", modelMap);
    }

    /**
     * 验证码生成
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("/verifyCode")
    public ModelAndView verifyCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
        this.mobileLoginSer.generateVerifyCode(request, response);
        return null;
    }

    /**
     * 检查用户名是否已存在
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/isExistsUsername", method = RequestMethod.POST)
    @ResponseBody
    public int isExistsUsername(HttpServletRequest request) {
        return this.mobileLoginSer.getCntByUsername(request);
    }

    /**
     * 检查邀请码状态
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/checkInvitationId", method = RequestMethod.POST)
    @ResponseBody
    public String checkInvitationId(HttpServletRequest request) {
        return this.mobileLoginSer.invitationStatus(request);
    }

    /**
     * 保存注册信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/insertRegisterInfo", method = RequestMethod.POST)
    @ResponseBody
    public String insertRegisterInfo(HttpServletRequest request) {
        String returnString = "INSERT_FAIL";
        try {
            returnString = this.mobileLoginSer.insertRegisterInfo(request);
        } catch (Exception e) {
            e.printStackTrace();
            returnString = e.getMessage();
        }
        return returnString;
    }
}
