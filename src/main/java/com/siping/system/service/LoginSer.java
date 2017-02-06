package com.siping.system.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface LoginSer {
    /**
     * 用户登录
     * @param request
     * @param response
     * @return
     */
    public String findUser(HttpServletRequest request, HttpServletResponse response);

    /**
     * 获取一级菜单
     * @param request
     * @param response
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getMainMenu(HttpServletRequest request, HttpServletResponse response);

    /**
     * 获取二三级菜单
     * @param request
     * @param response
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getLeftMenu(HttpServletRequest request, HttpServletResponse response);

    /**
     * 加载主页面
     * @param request
     * @param response
     * @return
     */
    public String getMenuLoad(HttpServletRequest request);

    /**
     * 加载主页面
     * @param request
     * @param response
     * @return
     */
    public String checkFirstLogin(HttpServletRequest request);
}
