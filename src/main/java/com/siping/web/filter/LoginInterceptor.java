package com.siping.web.filter;

import java.util.Enumeration;
import java.util.LinkedHashMap;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.siping.web.utility.LicenseUtil;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.siping.system.bean.AdminBean;
import com.siping.system.bean.License;
import com.siping.system.service.SystemSer;
import com.siping.web.utility.HttpRequestDeviceUtils;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.StringUtil;

@Component
public class LoginInterceptor extends HandlerInterceptorAdapter {
    Logger logger = Logger.getLogger(LoginInterceptor.class);

    private String url;
    private String requestUrl;

    @Autowired
    private SystemSer systemSer;

    @Autowired
    private LicenseUtil licenseUtil;

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        boolean flag = false;
        url = request.getServletPath().toString();
        if(url.indexOf("/activate") == 0){
            return true;
        }
//        if (!doNotNeedActivation(request) && url.indexOf("/resources/") != 0){
//            request.getRequestDispatcher("/activate/keyActivate").forward(request, response);
//            return false;
//        }
        if(HttpRequestDeviceUtils.isMobileDevice(request)){
            if(!needLoginForMobile(url)){
                flag = true;
            }else{
                AdminBean admin = SessionUtil.getLoginUserFromSession(request);
                if(admin==null){
                    String targetUrl = url+"?"+StringUtil.checkNull(request.getQueryString());
                    if(targetUrl.contains("/mobile/login/index")||targetUrl.contains("/message/messageManage/getMyMessageCnt")){
                        targetUrl = "/mobile/home";
                    }
                    request.getSession().setAttribute("targetUrl", targetUrl);
                    request.getRequestDispatcher("/mobile/login/index").forward(request, response);
                }else{
                    flag = true;
                }
            }
        }else{
            if (isUrlNoNeedRight(url)) {
                flag = true;
            }else{
                AdminBean admin = SessionUtil.getLoginUserFromSession(request);
                if (admin != null) {
                    if (logger.isDebugEnabled()) {
                        showRequestLogger(request);
                    }
                    if (isAdminHasNoRight(request, admin)) {
                        request.getRequestDispatcher("/noPurview").forward(request, response);
                    }
                    flag = true;
                } else {
                    request.getRequestDispatcher("/").forward(request, response);
                }
            }
        }
        return flag;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    private boolean isAdminHasNoRight(HttpServletRequest request, AdminBean admin) {
        /*LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("ADMINID", admin.getAdminID());
        paramMap.put("url", url);
        return (Integer.parseInt(systemSer.getPurview(paramMap).toString()) == 0);*/
    	return false;
    }

    @SuppressWarnings("rawtypes")
    private void showRequestLogger(HttpServletRequest request) {
        requestUrl = request.getRequestURI();
        logger.debug("request RemoteHost " + request.getRemoteHost());
        logger.debug("request URI : " + requestUrl);
        Enumeration parameters = request.getParameterNames();
        while (parameters.hasMoreElements()) {
            String parameter = parameters.nextElement().toString();
            logger.debug("Parameter: " + parameter + " = " + request.getParameter(parameter));
        }
    }

    private boolean needLoginForMobile(String url) {
        boolean flag = false;
        String[] urls = {"/mobile/account/accountManage",
            "/mobile/mobileOrder/viewMobileOrderList",
            "/mobile/mobileOrder/viewCartList",
            "/mobile/mobileOrder/viewSalesOrderDetail",
            "/mobile/account/viewUpdateCuCompanyInfo",
            "/mobile/account/viewAddReceiverInfo",
            "/mobile/account/viewUpdatePassword"};
        for(int i=0;i<urls.length;i++){
            if(url.contains(urls[i])){
                flag = true;
                break;
            }
        }
        return flag;
    }

    private boolean isUrlNoNeedRight(String url) {
        return url.indexOf("/resources/") == 0 || url.indexOf("/mobile/login") == 0 || url.indexOf("/wechat") == 0 
            || url.indexOf("/login/in") == 0 || url.length() == 1
            || url.indexOf("/ess/password/forgetPassword") == 0 || url.indexOf("/ess/password/checkCheckCodeUpdatePassword") == 0
            || url.indexOf("/ess/password/getVerifyCode") == 0
            || url.indexOf("/productStorage/taoBaoProManage/getAuthCode") == 0
            || url.indexOf("/crossdomain.xml") == 0
            || url.indexOf("/activate") == 0;
    }

    private boolean doNotNeedActivation(HttpServletRequest request) {
        boolean flag = false;
        ServletContext context = request.getSession().getServletContext();
        License license = (License) context.getAttribute("license");
        if(license == null){
            license = new License();
            licenseUtil.getLicenseByProperties(context,license);
            if(license.getLicenseKey() != null && !"".equals(license.getLicenseKey())){
                context.setAttribute("license", license);
                try {
                    flag = licenseUtil.judgeLicense(license);
                } catch (Exception e) {
                    flag = false;
                    e.printStackTrace();
                }
            }else{
                flag = false;
            }
        }else{
            try {
                flag = licenseUtil.judgeLicense(license);
            } catch (Exception e) {
                flag = false;
                e.printStackTrace();
            }
        }
        return flag;
    }
}
