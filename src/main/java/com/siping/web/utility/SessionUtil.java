package com.siping.web.utility;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.siping.doc.bean.MetaData;
import com.siping.productStorage.bean.Company;
import com.siping.system.bean.AdminBean;

public class SessionUtil {

    private static final String SESSION_LOGIN_USER = "LoginUser";
    private static final String SESSION_COMPANY = "Company";

    public static AdminBean getLoginUserFromSession(HttpServletRequest request) {
        HttpSession session = request.getSession();
        AdminBean admin = (AdminBean) session.getAttribute(SESSION_LOGIN_USER);
        return admin;
    }

    public static void setLoginUserToSession(HttpServletRequest request, AdminBean admin) {
        HttpSession session = request.getSession();
        session.setAttribute(SESSION_LOGIN_USER, admin);
    }

    public static Company getCompanyFromSession(HttpServletRequest request) {
        Company company = new Company();
        AdminBean admin = getLoginUserFromSession(request);
        company = admin.getMetaData().getCompany();
        return company;
    }

    public static void setCompanyToSession(HttpServletRequest request, Company company) {
        HttpSession session = request.getSession();
        session.setAttribute(SESSION_COMPANY, company);
    }

    public static MetaData generateMetaDataFromSession(HttpServletRequest request) throws Exception {
        MetaData metaData = new MetaData();

        AdminBean admin = getLoginUserFromSession(request);
        if (admin == null) {
            throw new Exception("Not logged in!");
        }
        metaData.setCreateUser(admin);
        metaData.setLastUpdateUser(admin);

        Company company = getCompanyFromSession(request);
        if (company == null) {
            throw new Exception("user has no client info about company");
        }
        metaData.setCompany(company);
        return metaData;
    }

}
