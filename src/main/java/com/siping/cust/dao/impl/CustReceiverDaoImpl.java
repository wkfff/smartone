package com.siping.cust.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.siping.cust.bean.Receiver;
import com.siping.cust.dao.CustReceiverDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class CustReceiverDaoImpl extends SqlMapClientSupport implements
        CustReceiverDao {
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List<Receiver> getReceiverList(Object object, int page, int pagesize) {
        List<Receiver> list = new ArrayList();
        try {
            list = this.queryForList("cust.custReceiver.getReceiverList",
                    object, page, pagesize);
        } catch (SQLException e) {
            logger.error(e.getMessage());
        }
        return list;
    }

    @Override
    public int getReceiverListCnt(Object object) {
        int i = 0;
        try {
            i = (Integer) this.queryForObject(
                    "cust.custReceiver.getReceiverCnt", object);
        } catch (SQLException e) {
            logger.error(e.getMessage());
        }
        return i;
    }

    @Override
    public Object getReceiver(Object object) {
        Object obj = null;
        try {
            obj = this.queryForObject("cust.custReceiver.getReceiver", object);
        } catch (SQLException e) {
            logger.error(e.getMessage());
        }
        return obj;
    }

    @Override
    public Object addReceiver(Object object) throws SQLException {
        return this.insert("cust.custReceiver.addReceiver", object);
    }

    @Override
    public Object updateReceiver(Object object) throws SQLException {
        return this.update("cust.custReceiver.updateReceiver", object);
    }

    @Override
    public Object deleteReceiver(Object object) throws SQLException {
        return this.delete("cust.custReceiver.deleteReceiver", object);
    }

    @Override
    public Object addReceiverByWizard(Object object) throws SQLException {
        return this.insert("cust.custReceiver.addReceiverByWizard", object);
    }
}
