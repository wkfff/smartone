package com.siping.system.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface LoginUserSer {

    public Object getLoginUserInfoObj(HttpServletRequest request);

    @SuppressWarnings({ "rawtypes" })
    public List getLoginUserRolesGroupList(HttpServletRequest request);

    @SuppressWarnings({ "rawtypes" })
    public List getLoginUserInfo(HttpServletRequest request);

    public int getLoginUserInfoCnt(HttpServletRequest request);

    public String addLoginUserInfo(HttpServletRequest request) throws Exception ;

    public String updateLoginUserInfo(HttpServletRequest request);

    public String deleteLoginUserInfo(HttpServletRequest request);

    @SuppressWarnings({ "rawtypes" })
    public List getLoginUserDeptInfo(HttpServletRequest request);

    @SuppressWarnings({ "rawtypes" })
    public List getRolesSelectList(HttpServletRequest request);

}
