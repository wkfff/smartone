package com.siping.ecm.dao;

import java.util.List;
import java.util.Map;

import com.siping.doc.bean.BusinessData;
import com.siping.ecm.bean.EngineerChange;
import com.siping.process.bean.PagerRequest;

public interface CNInfoDao {

    public List<EngineerChange> getChangeNoList(Map<String, Object> ecn, PagerRequest pagerRequest) throws Exception;

    public int getChangeNoListCnt(Map<String, Object> params) throws Exception;

    public EngineerChange getChangeNoDetail(EngineerChange ecn) throws Exception;

    public List getTypeList(Object object);

    public List<BusinessData> getObjectList(Map<String, Object> params, PagerRequest pagerRequest) throws Exception;

    public int getObjectListCnt(Object object);
}
