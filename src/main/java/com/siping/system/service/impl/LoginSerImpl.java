package com.siping.system.service.impl;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import com.siping.system.bean.AdminBean;
import com.siping.system.dao.LoginDao;
import com.siping.system.service.LoginSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.EncryptUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class LoginSerImpl implements LoginSer {

    Logger logger = Logger.getLogger(LoginSerImpl.class);

    @Autowired
    private LoginDao loginDao;

    /**
     * 用户登录
     * @param request
     * @param response
     * @return
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String findUser(HttpServletRequest request, HttpServletResponse response) {
        Map hm = new LinkedHashMap();
        hm.put("username", request.getParameter("username"));
        hm.put("password", EncryptUtil.MD5Encode(request.getParameter("password")));
        AdminBean user = (AdminBean) loginDao.findUser(hm);

        ModelMap modelMap = new ModelMap();

        if (user == null) {
            modelMap.put("msg", Messages.getMessage(request, "loginFail"));
            return Messages.getMessage(request, "loginFail");
        } else {
            user.setLocale(Messages.getLocale(request));
            logger.info("UserName:" + user.getUsername());
            LinkedHashMap info = new LinkedHashMap();
            int loginType = user.getLoginType();
            if (loginType == 0) {
                info.put("empid", user.getAdminID());
            } else if (loginType == 1) {
                info.put("contact_id", user.getAdminID());
            }
            info.put("ip", this.getIpAddr(request));

            // 获取MAC地址太过于耗时，所以被禁用
            // info.put("mac",
            // UserListen.getMACAddress(this.getIpAddr(request)));
            loginDao.addLoginInfo(info);
            request.getSession().setAttribute("LoginUser", user);
            return "1";
        }

    }

    /**
     * get Ip Address
     * @param request
     * @return
     */
    public String getIpAddr(HttpServletRequest request) {
        String hostIP = "127.0.0.1";
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        try {
            if (ip.equals(hostIP)) {
                InetAddress inet = InetAddress.getLocalHost();
                ip = inet.getHostAddress();
            }
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
        return ip;
    }

    /**
     * 获取一级菜单
     * @param request
     * @param response
     * @return
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getMainMenu(HttpServletRequest request, HttpServletResponse response) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("ADMINID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return loginDao.getMainMenu(paramMap);
    }

    /**
     * 获取二三级菜单
     * @param request
     * @param response
     * @return
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getLeftMenu(HttpServletRequest request, HttpServletResponse response) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("ADMINID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return loginDao.getLeftMenu(paramMap);
    }

    /**
     * 加载主页面
     * @param request
     * @param response
     * @return
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String getMenuLoad(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        return loginDao.getMenuLoad(paramMap);
    }

    /**
     * 加载主页面
     * @param request
     * @param response
     * @return
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String checkFirstLogin(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("ADMINID", admin.getAdminID());
        return loginDao.checkFirstLogin(paramMap);
    }

}
