package com.siping.mobile.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.mobile.dao.MobileAccountDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class MobileAccountDaoImpl extends SqlMapClientSupport implements MobileAccountDao {
    
    /**
     * 依据ADMINID获取该账号类型
     */
    @SuppressWarnings("rawtypes")
    @Override
    public Map getAccountType(Object object) {
        Map tempMap = new LinkedHashMap<Object, Object>();
        try {
            tempMap = (Map) this.queryForObject(
                    "mobile.account.getAccountType", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tempMap;
    }

    //修改密码
    @Override
    public String updatePassword(Object object) throws Exception {
        String resultString = "Y";
        this.update("mobile.account.updatePassword", object);
        return resultString;
    }

    //获得cust所有信息
    @SuppressWarnings("rawtypes")
    @Override
    public Map getCustomer(Object object) {
        Map tempMap = new LinkedHashMap<Object, Object>();
        try {
            tempMap = (Map) this.queryForObject(
                    "mobile.account.getCustomer", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tempMap;
    }

    //依据cust_id获取该客户收货信息
    @SuppressWarnings("rawtypes")
    @Override
    public List getReciverList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList(
                    "mobile.account.getReciverList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    //依据cust_id获取该客户收货信息条数
    @Override
    public int getReciverCnt(Object object) {
        int returnInt = 0;

        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
                    .queryForObject("mobile.account.getReciverCnt",
                            object)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

    //从sy_code中获取城市或者地区list
    @SuppressWarnings("rawtypes")
    @Override
    public List getSelectList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList(
                    "mobile.account.getSelectList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    //修改客戶企業信息
    @Override
    public String updateCustInfo(Object object) throws Exception {
        String resultString = "UPDATE_SUCCESS";
        this.update("mobile.account.updateCustInfo", object);
        return resultString;
    }

    //客戶添加收貨人
    @Override
    public String insertReceiver(Object object) throws Exception {
        String resultString = "INSERT_SUCCESS";
        this.insert("mobile.account.insertReceiver", object);
        return resultString;
    }

    //依据receiver_id获取收货人信息
    @SuppressWarnings("rawtypes")
    @Override
    public Map getReceiver(Object object) {
        Map tempMap = new LinkedHashMap<Object, Object>();
        try {
            tempMap = (Map) this.queryForObject(
                    "mobile.account.getReceiver", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tempMap;
    }

    //修改收货人信息
    @Override
    public String updateReceiver(Object object) throws Exception {
        String resultString = "UPDATE_SUCCESS";
        this.update("mobile.account.updateReceiver", object);
        return resultString;
    }

    //删除收货人信息
    @Override
    public String deleteReceiver(Object object) throws Exception {
        String resultString = "DELETE_SUCCESS";
        this.update("mobile.account.deleteReceiver", object);
        return resultString;
    }
}
