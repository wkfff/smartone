package com.siping.ecm.service;

import java.util.List;
import java.util.Map;

import com.siping.doc.bean.BusinessData;
import com.siping.ecm.bean.EngineerChange;
import com.siping.process.bean.PagerRequest;

public interface CNInfoSer {
    public List<EngineerChange> getChangeNoList(Map<String, Object> params, PagerRequest pagerRequest) throws Exception;

    public int getChangeNoListCnt(Map<String, Object> params) throws Exception;

    public EngineerChange getChangeNoDetail(EngineerChange ecn) throws Exception;

    public List<BusinessData> getObjectList(Map<String, Object> params, PagerRequest pagerRequest) throws Exception;

    public int getObjectListCnt(Map<String, Object> params) throws Exception;
}
