package com.siping.ess.dao.impl;

import java.sql.SQLException;
import java.util.Date;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.siping.ess.dao.PasswordDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class PasswordDaoImpl extends SqlMapClientSupport implements PasswordDao {
    /**
     * 修改密码 (non-Javadoc)
     * @see com.siping.ess.dao.PasswordDao#updatePassword(java.lang.Object)
     */
    @Override
    public String updatePassword(Object obj) throws Exception {
        String returnString = "Y";
        try {
            this.update("ess.password.updateUserPassword", obj);
        } catch (SQLException e) {
            returnString = "N";
            e.printStackTrace();
        }
        return returnString;
    }

    @Override
    public String getEmailByUsername(String username) {
        String email = null;
        try {
            email = this.queryForObject("ess.password.getEmailByUsername", username).toString();
        } catch (Exception e) {
            return null;
        }
        return email;
    }

    @Override
    public boolean saveCheckCode(Map object) {
        try {
            this.insert("ess.password.insertCheckCode", object);
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    @Override
    public Date checkCkeckcode(Map object) {
        Object enddate = null;
        try {
            enddate = this.queryForObject("ess.password.getEnd_dateByUsername", object);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
        if (enddate != null) {
            return (Date) enddate;
        } else
            return null;
    }

    @Override
    public String updatepasswordAndCheckcode(Map object) {
        try {
            this.update("ess.password.updatePasswordAndCheckcode", object);
            this.update("ess.password.updateCheckCodeStatu", object);
        } catch (SQLException e) {
            e.printStackTrace();
            return "error";
        }
        return "Y";
    }

}
