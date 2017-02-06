package com.siping.web.utility.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import com.siping.web.utility.SqlMapClientSupport;
import com.siping.web.utility.dao.UtilityCustInfoDao;

@Repository
public class UtilityCustInfoDaoImpl extends SqlMapClientSupport implements UtilityCustInfoDao {

    @Override
    public int getCustomerListCnt(Object object) {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("utility.custInfo.getCustomerListCnt", object).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getCustomerList(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("utility.custInfo.getCustomerList", object,
                    Integer.parseInt(((Map) object).get("page").toString()),
                    Integer.parseInt(((Map) object).get("pagesize").toString()));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
