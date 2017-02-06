package com.siping.mobile.dao.impl;

import java.sql.SQLException;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.mobile.dao.MobileLoginDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class MobileLoginDaoImpl extends SqlMapClientSupport implements MobileLoginDao {
    /**
     * 依据username查询sy_admin
     * @param object
     * @return
     */
    @Override
    public int getCntByUsername(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("mobile.login.getCntByUsername", object)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 依据invitation_id和use_status查询mobile_invitation
     * @param object
     * @return
     */
    @Override
    public int getCntByInvitationCondition(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("mobile.login.getCntByInvitationCondition", object)), Integer.class);

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    /**
     * 添加注册信息到数据库
     * @param object
     * @return
     */
    @Override
    public String insertRegisterInfo(Object object) throws Exception {
        String result = "Y";

        this.insert("mobile.login.insertRegisterInfo", object);

        return result;
    }

}
