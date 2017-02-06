package com.siping.system.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.system.dao.LoginUserDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class LoginUserDaoImpl extends SqlMapClientSupport implements LoginUserDao {

    /**
     * 取得登陆用户权限组列表
     * @param List
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getLoginUserRolesGroupList(Object obj) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("system.loginUser.getLoginUserRolesGroupList", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnList;
    }

    /**
     * 取得登陆用户信息
     * @param List
     * @return
     */
    @Override
    public Object getLoginUserInfoObj(Object obj) {
        Object returnObj = new Object();
        try {
            returnObj = this.queryForObject("system.loginUser.getLoginUserObj", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnObj;
    }

    /**
     * 取得所有登陆用户列表
     * @param obj
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getLoginUserInfo(Object obj) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("system.loginUser.getLoginUserInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnList;
    }

    /**
     * 取得所有登陆用户列表
     * @param obj
     * @return
     */
    @Override
    public int getLoginUserInfoCnt(Object obj) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("system.loginUser.getLoginUserInfoCnt", obj)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 取得所有登陆用户列表
     * @param List
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getLoginUserInfo(Object obj, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("system.loginUser.getLoginUserInfo", obj, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnList;
    }

    /**
     * 插入登陆者信息
     * @param obj
     * @return
     */
    @Override
    public String addLoginUserInfo(Object obj) throws SQLException {
        String resultString = "Y";
        try {
            this.insert("system.loginUser.addLoginUserInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    /**
     * 更新登陆用户信息
     * @param obj
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public String updateLoginUserInfo(Object obj) {
        String resultString = "Y";
        try {
            this.startTransaction();
            this.update("system.loginUser.updateLoginUserInfo", obj);
            this.delete("system.loginUser.deleteLoginUserDeptInfo", obj);
            Map paramMap = (Map) obj;
            List insertLoginUserDeptList = (List) paramMap.get("insertLoginUserDeptList");
            if (insertLoginUserDeptList.size() != 0) {
                this.insertForList("system.loginUser.insertLoginUserDeptList", insertLoginUserDeptList);
            }
            this.commitTransation();
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        } finally {
            try {
                this.endTransation();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return resultString;
    }

    /**
     * 删除登陆用户信息
     * @param obj
     * @return
     */
    @Override
    public String deleteLoginUserInfo(Object obj) {
        String resultString = "Y";
        try {
            this.delete("system.loginUser.deleteLoginUserDeptInfo", obj);
            this.delete("system.loginUser.deleteLoginUserInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    /**
     * 取得所有登陆用户部门权限信息列表
     * @param List
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getLoginUserDeptInfo(Object obj) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("system.loginUser.getLoginUserDeptInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnList;
    }

    /**
     * 取得角色信息列表
     * @param List
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getRolesSelectList(Object obj) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("system.loginUser.getRolesSelectList", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnList;
    }

    @Override
    public int checkAdminID(Object obj) {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("system.loginUser.checkAdminID", obj).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int checkUserName(Map map) throws Exception {
        return Integer.parseInt(this.queryForObject("system.loginUser.checkUserName", map).toString());
    }

}
