package com.siping.ecm.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.siping.doc.bean.BusinessData;
import com.siping.ecm.bean.EngineerChange;
import com.siping.ecm.dao.CNManageDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class CNManageDaoImpl extends SqlMapClientSupport implements CNManageDao {

    @Override
    public void addChangeNo(EngineerChange ecn) throws Exception {
        try {
            this.insert("ecm.cnManage.addChangeNo", ecn);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void updateChangeNoData(EngineerChange ecn) throws Exception {
        try {
            this.update("ecm.cnManage.updateChangeNo", ecn);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void removeChangeNo(Object object) throws Exception {
        try {
            this.update("ecm.cnManage.removeChangeNo", object);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void addObjects(List<BusinessData> addList) throws Exception {
        try {
            this.insertForList("ecm.cnManage.addObject", addList);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void deleteObjects(List<BusinessData> deleteList) throws Exception {
        try {
            this.deleteForList("ecm.cnManage.deleteObject", deleteList);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void addObject(Object object) throws Exception {
        this.insert("ecm.cnManage.addObject", object);
    }

    @Override
    public String generateEcnNo() throws Exception {
        try {
            return this.queryForObject("ecm.cnManage.generateEcnNo").toString();
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

}
