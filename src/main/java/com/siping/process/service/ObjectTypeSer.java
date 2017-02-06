package com.siping.process.service;

import java.util.HashMap;
import java.util.List;

import com.siping.doc.bean.BusinessData;
import com.siping.process.bean.Grant;
import com.siping.process.bean.PagerRequest;
import com.siping.process.bean.ProcessItem;
import com.siping.process.bean.Type;
import com.siping.system.bean.AdminBean;

public interface ObjectTypeSer {
    public List<Type> getObjectTypeList(HashMap<String, Object> params) throws Exception;

    public int getObjectTypeListCnt(HashMap<String, Object> params, AdminBean user) throws Exception;

    public List<Grant> getObjectTypeGrantList(Type type, PagerRequest papgerRequest) throws Exception;

    public int getObjectTypeGrantListCnt(Type type) throws Exception;

    public String addObjectType(Type type) throws Exception;

    public void updateObjectType(Type type) throws Exception;

    public void deleteObjectType(Type type) throws Exception;

    public Type getObjectTypeDetail(Type type) throws Exception;

    public void transferObjectType(Type type) throws Exception;

    public void updateObjectTypeGrant(Type type) throws Exception;

    public Grant getAdminObjectGrant(AdminBean use, Type type);

    public List<ProcessItem> getProcessItemList(Type type, PagerRequest pagerRequest) throws Exception;

    public int getProcessItemListCnt(Type type) throws Exception;

    public String addProcessItem(ProcessItem item) throws Exception;

    public void updateProcessItem(ProcessItem item) throws Exception;

    public ProcessItem getProcessItemDetail(ProcessItem item) throws Exception;

    public void removeProcessItem(ProcessItem item) throws Exception;

    public boolean isObjectEditable(BusinessData businessData) throws Exception;
}
