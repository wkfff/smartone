package com.siping.system.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.siping.system.dao.SystemDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class SystemDaoImpl extends SqlMapClientSupport implements SystemDao {

    @SuppressWarnings({ "rawtypes" })
    @Override
    public void deleteModel(List list) {
        try {
            this.deleteForList("system.model.deleteModel", list);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public void insertModel(List list) {
        try {
            this.insertForList("system.model.insertModel", list);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getModel(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("system.model.getModel", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getAssetID(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("system.model.getAssetID", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnList;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getMenu(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("system.model.getMenu", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @Override
    public Object getPurview(Object object) {
        Object temp = "";
        try {
            temp = this.queryForObject("system.model.getPurview", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @Override
    public Object getPurviewBtn(Object object) {
        Object temp = "";
        try {
        	//this.queryForObject("system.model.getMenuSplitTable",object);
            temp = this.queryForObject("system.model.getPurviewBtn", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getSystemCode(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("system.model.getSyCode", object);
            /*aibi添加*/
            if(temp.isEmpty()){
            	temp = this.queryForList("system.model.getTSyCode", object);
            }
            /*end*/
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getPosition(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("system.model.getPosition", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getPostGrade(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("system.model.getPostGrade", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getPostGroup(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("system.model.getPostGroup", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getPostColumn(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("system.model.getPostColumn", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getPost(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("system.model.getPost", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getProductUnit(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("system.model.getProductUnit", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getMessageType(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("system.model.getMessageType", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getTransferType(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("system.model.getTransferType", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getPropertyValueType(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("system.model.getPropertyValueType", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getCompany(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("system.model.getCompany", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getStatus(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("system.model.getStatus", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getOrderStatus(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("system.model.getOrderStatus", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getConStatus(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("system.model.getConStatus", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getAppStatus(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("system.model.getAppStatus", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getShiftAttribution(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("system.model.getShiftAttribution", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getProductID(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("system.model.getProductID", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getCustID(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("system.model.getCustID", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getObjectTypeList(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("system.model.getObjectTypeList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getStatusNoList(Object object) {
        List temp = new ArrayList();
        try {
            temp = this.queryForList("system.model.getStatusNoList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @Override
    public int getAssetInfoCnt(Object object) {
        int AssetInfoCnt = 0;
        try {
            AssetInfoCnt = (Integer) this.queryForObject("system.model.getAssetInfoCnt", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return AssetInfoCnt;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getCheckTypeList(Map paramMap) throws Exception {
        return this.queryForList("system.model.getCheckTypeList", paramMap);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getCheckedListInfo(Map paramMap,int page,int pageSize) throws Exception {
        return this.queryForList("system.model.getCheckedListInfo", paramMap, page, pageSize);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int getCheckedListInfoCnt(Map paramMap) throws Exception{
        return (Integer) this.queryForObject("system.model.getCheckedListInfoCnt", paramMap);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String saveCheckedType(Map paramMap) throws Exception {
        String returnMsg = "Y";
        this.insert("system.model.saveCheckedType", paramMap);
        return returnMsg;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int updateCheckedType(Map paramMap) throws Exception{
        return (Integer) this.update("system.model.updateCheckedType", paramMap);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int deleteCheckedType(Map paramMap) throws Exception {
        return (Integer) this.delete("system.model.deleteCheckedType", paramMap);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int getCheckedTypeCnt(Map paramMap) throws Exception {
        return (Integer) this.queryForObject("system.model.getCheckedTypeCnt", paramMap);
    }

    @SuppressWarnings("unchecked")
    @Override
    public  LinkedHashMap<String, Object> getApproverId(String checkTypeId) throws Exception {
        return (LinkedHashMap<String, Object>) this.queryForObject("system.model.getApproverId", checkTypeId);
    }
}
