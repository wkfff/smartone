package com.siping.system.dao;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public interface SystemDao {
    @SuppressWarnings({ "rawtypes" })
    public void deleteModel(List list);

    @SuppressWarnings({ "rawtypes" })
    public void insertModel(List list);

    @SuppressWarnings({ "rawtypes" })
    public List getModel(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getMenu(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getAssetID(Object object, int currentPage, int pageSize);

    public Object getPurview(Object object);

    public Object getPurviewBtn(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getSystemCode(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getPosition(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getPostGrade(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getPostGroup(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getPostColumn(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getPost(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getProductUnit(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getMessageType(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getTransferType(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getPropertyValueType(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getCompany(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getStatus(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getOrderStatus(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getConStatus(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getAppStatus(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getProductID(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getCustID(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getShiftAttribution(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getObjectTypeList(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getStatusNoList(Object object);

    public int getAssetInfoCnt(Object object);

    @SuppressWarnings("rawtypes")
    List getCheckTypeList(Map paramMap) throws Exception;

    @SuppressWarnings("rawtypes")
    List getCheckedListInfo(Map paramMap,int page,int pageSize) throws Exception;

    @SuppressWarnings("rawtypes")
    int getCheckedListInfoCnt(Map paramMap) throws Exception;

    @SuppressWarnings("rawtypes")
    String saveCheckedType(Map paramMap) throws Exception;

    @SuppressWarnings("rawtypes")
    int updateCheckedType(Map paramMap) throws Exception;

    @SuppressWarnings("rawtypes")
    int deleteCheckedType(Map paramMap) throws Exception;

    @SuppressWarnings("rawtypes")
    int getCheckedTypeCnt(Map paramMap) throws Exception;

    LinkedHashMap<String, Object> getApproverId(String checkTypeId) throws Exception;
}
