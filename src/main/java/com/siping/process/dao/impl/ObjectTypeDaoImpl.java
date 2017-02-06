package com.siping.process.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.siping.process.bean.Grant;
import com.siping.process.bean.PagerRequest;
import com.siping.process.bean.ProcessItem;
import com.siping.process.bean.Type;
import com.siping.process.dao.ObjectTypeDao;
import com.siping.web.utility.SqlMapClientSupport;
import com.siping.web.utility.dao.UtilityOtherInfoDao;

@Repository
public class ObjectTypeDaoImpl extends SqlMapClientSupport implements ObjectTypeDao {

    @Autowired
    private UtilityOtherInfoDao utilityOtherInfoDao;

    @Override
    public List<Type> getObjectTypeList(HashMap<String, Object> params) throws Exception {
        List<Type> list = new ArrayList<Type>();
        try {
            list = (ArrayList<Type>) this.queryForList("process.objectType.getObjectTypeList", params);
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return list;
    }

    @Override
    public int getObjectTypeListCnt(HashMap<String, Object> params) throws Exception {
        int count = 0;
        try {
            count = Integer.parseInt(this.queryForObject("process.objectType.getObjectTypeListCnt", params).toString());
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return count;
    }

    @Override
    public int getObjectTypeGrantListCnt(Type type) throws Exception {
        int count = 0;
        try {
            count = Integer.parseInt(this.queryForObject("process.objectType.getObjectTypeGrantListCnt", type).toString());
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return count;
    }

    @Override
    public List<Grant> getObjectTypeGrantList(Type type, PagerRequest pagerRequest) throws Exception {
        List<Grant> list = new ArrayList<Grant>();
        try {
            if (pagerRequest == null || pagerRequest.getPage() == 0) {
                list = (ArrayList<Grant>) this.queryForList("process.objectType.getObjectTypeGrantList", type);
            } else {
                list = (ArrayList<Grant>) this.queryForList("process.objectType.getObjectTypeGrantList", type, pagerRequest.getPage(), pagerRequest.getPagesize());
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return list;
    }

    @Override
    public String addObjectType(Type type) throws Exception {
        try {
            return this.insert("process.objectType.addObjectType", type).toString();
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void deleteObjectType(Type obj) throws Exception {
        try {
            this.startTransaction();
            this.delete("process.objectType.deleteObjectTypeGrant", obj);
            this.delete("process.objectType.deleteObjectType", obj);
            this.commitTransation();
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            try {
                this.endTransation();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void updateObjectType(Type type) throws Exception {
        try {
            this.update("process.objectType.updateObjectType", type);
            this.updateForList("process.objectType.addObjectTypeGrant", type.getGrants());
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void updateObjectTypeGrant(Type type) throws Exception {
        try {
            this.insert("process.objectType.addObjectTypeGrant", type);
            this.update("process.objectType.updateObjectTypeGrant", type);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public Type getObjectTypeDetail(Type type) throws Exception {
        try {
            type = (Type) this.queryForObject("process.objectType.getObjectTypeDetail", type);
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return type;
    }

    @Override
    public Grant getObjectGrantByRoles(Grant grant) throws Exception {
        try {
            return (Grant) this.queryForObject("process.objectType.getObjectGrantByRoles", grant);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public Object getNextTypeID(Object object) throws SQLException {
        return this.queryForObject("process.objectType.getNextTypeID", object);
    }

    @Override
    public List<ProcessItem> getProcessItemList(Type type, PagerRequest pagerRequest) throws Exception {
        List<ProcessItem> list = new ArrayList<ProcessItem>();
        try {
            if (pagerRequest == null || pagerRequest.getPage() == 0) {
                list = (ArrayList<ProcessItem>) this.queryForList("process.objectType.getProcessItemList", type, pagerRequest.getPage(), pagerRequest.getPagesize());
            } else {
                list = (ArrayList<ProcessItem>) this.queryForList("process.objectType.getProcessItemList", type);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return list;
    }

    @Override
    public int getProcessItemListCnt(Type type) throws Exception {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("process.objectType.getProcessItemListCnt", type).toString());
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return temp;
    }

    @Override
    public String addProcessItem(ProcessItem item) throws Exception {
        try {
            return this.insert("process.objectType.addProcessItem", item).toString();
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void updateProcessItem(ProcessItem item) throws Exception {
        try {
            this.update("process.objectType.updateProcessItem", item);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public ProcessItem getProcessItemDetail(ProcessItem item) throws Exception {
        try {
            if(item.getNo()==null || item.getNo()==0L){
                return (ProcessItem) this.queryForObject("process.objectType.getProcessItemDetailById", item);
            }else{
                return (ProcessItem) this.queryForObject("process.objectType.getProcessItemDetail", item);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void removeProcessItem(ProcessItem item) throws Exception {
        this.update("process.objectType.removeProcessItem", item);
    }

    @Override
    public boolean isObjectEditable(Object object) {
        boolean editable = false;
        try {
            editable = this.queryForObject("process.objectType.isObjectEditable", object).toString().equals("1");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return editable;
    }
}
