package com.siping.system.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.springframework.stereotype.Repository;

import com.siping.system.dao.LoginDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class LoginDaoImpl extends SqlMapClientSupport implements LoginDao {
    /**
     * 用户登录 (non-Javadoc)
     * @see com.siping.system.dao.LoginDao#findUser(java.lang.Object)
     */
    @Override
    public Object findUser(Object object) {
        Object object2 = null;
        try {
            object2 = this.queryForObject("system.login.findUser", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return object2;
    }

    /**
     * 获取一级菜单 (non-Javadoc)
     * @see com.siping.system.dao.LoginDao#getMainMenu(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getMainMenu(Object object) {
        List list = new ArrayList();
        try {
        	//this.queryForObject("system.login.getMenuSplitTable",object);
            list = this.queryForList("system.login.getMainMenu", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * 获取二三级菜单 (non-Javadoc)
     * @see com.siping.system.dao.LoginDao#getLeftMenu(java.lang.Object)
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getLeftMenu(Object object) {
        List list = new ArrayList();
        try {
        	//this.queryForObject("system.login.getMenuSplitTable",object);
            list = this.queryForList("system.login.getLeftMenu", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * 加载主页面 (non-Javadoc)
     * @see com.siping.system.dao.LoginDao#getMenuLoad(java.lang.Object)
     */
    @Override
    public String getMenuLoad(Object object) {
        String temp = "";
        try {
        	
            temp = this.queryForObject("system.login.getMenuLoad", object).toString();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    /**
     * 加载主页面 (non-Javadoc)
     * @see com.siping.system.dao.LoginDao#checkFirstLogin(java.lang.Object)
     */
    @Override
    public String checkFirstLogin(Object object) {
        String returnString = "Y";
        try {
            Object temp01 = this.queryForObject("system.login.checkFirstLogin01", object);
            Object temp02 = this.queryForObject("system.login.checkFirstLogin02", object);
            if (temp01 == null) {
                returnString = "Y";
            } else {
                if (temp02 == null) {
                    returnString = "N";
                } else {
                    returnString = "Y";
                }
            }
        } catch (SQLException e) {
            returnString = "N";
            e.printStackTrace();
        } catch (Exception e) {
            returnString = "N";
            e.printStackTrace();
        }
        return returnString;
    }

    /**
     * 保存登录信息 (non-Javadoc)
     * @see com.siping.system.dao.LoginDao#addLoginInfo(java.lang.Object)
     */
    @Override
    public void addLoginInfo(Object object) {
        try {
            this.insert("system.login.addLoginInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
