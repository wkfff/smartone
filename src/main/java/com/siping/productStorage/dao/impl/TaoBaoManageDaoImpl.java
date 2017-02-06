package com.siping.productStorage.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.siping.productStorage.dao.TaoBaoManageDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class TaoBaoManageDaoImpl extends SqlMapClientSupport implements TaoBaoManageDao {
    @SuppressWarnings({ "unchecked" })
    @Override
    public List<LinkedHashMap<String, Object>> getCustById(Object obj) {
        List<LinkedHashMap<String, Object>> list = new ArrayList<LinkedHashMap<String, Object>>();
        try {
            list = this.queryForList("cust.custInfo.getCustById", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int checkOrderTaobao(Object obj) {
        int result = 0;
        try {
            result = Integer.valueOf(this.queryForObject("prostor.productSale.checkOrderTaobao", obj).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
    
    @Override
    public int checkProTaobao(Object obj) {
        int result = 0;
        try {
            result = Integer.valueOf(this.queryForObject("prostor.product.checkProTaobao", obj).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}
