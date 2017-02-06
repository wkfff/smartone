package com.siping.process.dao;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import com.siping.process.bean.Grant;
import com.siping.process.bean.PagerRequest;
import com.siping.process.bean.ProcessItem;
import com.siping.process.bean.Type;

public interface ObjectTypeDao {
    public List<Type> getObjectTypeList(HashMap<String, Object> params) throws Exception;

    public int getObjectTypeListCnt(HashMap<String, Object> params) throws Exception;

    public List<Grant> getObjectTypeGrantList(Type type, PagerRequest pagerRequest) throws Exception;

    public int getObjectTypeGrantListCnt(Type type) throws Exception;

    public String addObjectType(Type type) throws Exception;

    public void deleteObjectType(Type type) throws Exception;

    public void updateObjectType(Type type) throws Exception;

    public void updateObjectTypeGrant(Type type) throws Exception;

    public Type getObjectTypeDetail(Type type) throws Exception;

    public Object getNextTypeID(Object object) throws SQLException;

    public Grant getObjectGrantByRoles(Grant grant) throws Exception;

    public List<ProcessItem> getProcessItemList(Type type, PagerRequest pagerRequest) throws Exception;

    public int getProcessItemListCnt(Type type) throws Exception;

    public String addProcessItem(ProcessItem item) throws Exception;

    public void updateProcessItem(ProcessItem item) throws Exception;

    public ProcessItem getProcessItemDetail(ProcessItem ProcessItem) throws Exception;

    public void removeProcessItem(ProcessItem item) throws Exception;

    public boolean isObjectEditable(Object object);

}
