package com.siping.system.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.system.service.LoginUserSer;
import com.siping.web.utility.JsonUtil;

@Controller
@RequestMapping(value = "/system/rightsManagement")
public class LoginUserCtroller {
    Logger logger = Logger.getLogger(LoginUserCtroller.class);

    @Autowired
    private LoginUserSer loginUserSer;

    @RequestMapping(value = "/viewLoginUser", method = RequestMethod.GET)
    public ModelAndView viewLoginUser(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("rolesSelectList", this.loginUserSer.getRolesSelectList(request));
        return new ModelAndView("/system/rightsManagement/viewLoginUser", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/addLoginUserView", method = RequestMethod.GET)
    public ModelAndView addLoginUserView(HttpServletRequest request, ModelMap modelMap) {
        List loginUserInfoRolesGroupList = this.loginUserSer.getLoginUserRolesGroupList(request);
        String string = JsonUtil.deptInfoToJson(this.loginUserSer.getLoginUserDeptInfo(request));

        modelMap.put("loginUserInfoRolesGroupList", loginUserInfoRolesGroupList);
        modelMap.put("dataJson", string);

        return new ModelAndView("/system/rightsManagement/addLoginUserView", modelMap);
    }

    @RequestMapping(value = "/addLoginUserInfo", method = RequestMethod.POST)
    @ResponseBody
    public String addLoginUserInfo(HttpServletRequest request) {
        String returnMsg = "";
        try {
            returnMsg = this.loginUserSer.addLoginUserInfo(request);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnMsg;
    }

    @RequestMapping(value = "/updateLoginUserInfo", method = RequestMethod.POST)
    @ResponseBody
    public String updateLoginUserInfo(HttpServletRequest request) throws Exception {
        return this.loginUserSer.updateLoginUserInfo(request);
    }

    @RequestMapping(value = "/deleteLoginUser", method = RequestMethod.POST)
    @ResponseBody
    public String deleteLoginUser(HttpServletRequest request) {
        return this.loginUserSer.deleteLoginUserInfo(request);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getLoginUserInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map getLoginUserInfo(HttpServletRequest request) throws Exception {
        List loginUserList = this.loginUserSer.getLoginUserInfo(request);
        int loginUserCnt = this.loginUserSer.getLoginUserInfoCnt(request);

        Map model = new HashMap();
        model.put("loginUserInfo", loginUserList);
        model.put("loginUserInfoCnt", loginUserCnt);

        return model;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/updateLoginUserView", method = RequestMethod.GET)
    public ModelAndView updateLoginUserView(HttpServletRequest request, ModelMap modelMap) throws Exception {
        Object loginUserInfo = this.loginUserSer.getLoginUserInfoObj(request);
        List loginUserInfoRolesGroupList = this.loginUserSer.getLoginUserRolesGroupList(request);
        String string = JsonUtil.deptInfoToJson(this.loginUserSer.getLoginUserDeptInfo(request));
        modelMap.put("loginUserInfo", loginUserInfo);
        modelMap.put("loginUserInfoRolesGroupList", loginUserInfoRolesGroupList);
        modelMap.put("dataJson", string);
        return new ModelAndView("/system/rightsManagement/updateLoginUserView", modelMap);
    }

    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getLoginUserDeptInfo", method = RequestMethod.POST)
    @ResponseBody
    public List getLoginUserDeptInfo(HttpServletRequest request) throws Exception {
        List loginUserDeptList = this.loginUserSer.getLoginUserDeptInfo(request);

        return loginUserDeptList;
    }

    /**
     * 角色列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @RequestMapping(value = "/getRolesSelectList", method = RequestMethod.POST)
    @ResponseBody
    public List getRolesSelectList(HttpServletRequest request) throws Exception {

        List listMap = this.loginUserSer.getRolesSelectList(request);

        return listMap;
    }

}
