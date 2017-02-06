package com.siping.ecm.dao;

import java.util.List;

import com.siping.doc.bean.BusinessData;
import com.siping.ecm.bean.EngineerChange;

public interface CNManageDao {

    public void addChangeNo(EngineerChange ecn) throws Exception;

    public void updateChangeNoData(EngineerChange ecn) throws Exception;

    public void removeChangeNo(Object object) throws Exception;

    public void addObjects(List<BusinessData> addList) throws Exception;

    public void deleteObjects(List<BusinessData> deleteList) throws Exception;

    public void addObject(Object object) throws Exception;

    public String generateEcnNo() throws Exception;

}
