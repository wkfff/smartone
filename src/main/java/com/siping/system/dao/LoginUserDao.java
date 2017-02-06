package com.siping.system.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface LoginUserDao {

    public Object getLoginUserInfoObj(Object obj);

    @SuppressWarnings({ "rawtypes" })
    public List getLoginUserRolesGroupList(Object obj);

    @SuppressWarnings({ "rawtypes" })
    public List getLoginUserInfo(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getLoginUserInfo(Object object, int currentPage, int pageSize);

    public int getLoginUserInfoCnt(Object object);

    public String addLoginUserInfo(Object object) throws SQLException;

    public String updateLoginUserInfo(Object object);

    public String deleteLoginUserInfo(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getLoginUserDeptInfo(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getRolesSelectList(Object object);

    public int checkAdminID(Object object);

    @SuppressWarnings("rawtypes")
    public int checkUserName(Map map) throws Exception ;

}
