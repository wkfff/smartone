package com.siping.ass.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.ass.dao.AssInfoDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class AssInfoDaoImpl extends SqlMapClientSupport implements AssInfoDao {

    @SuppressWarnings({ "rawtypes" })
    public List getAssetList(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("ass.assInfo.getAssetList", object, Integer.parseInt(((Map) object).get("page").toString()), Integer.parseInt(((Map) object).get("pagesize").toString()));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getAssetListCnt(Object object) {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("ass.assInfo.getAssetListCnt", object).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    public Object getBasicInfo(Object object) {
        Object object2 = null;
        try {
            object2 = this.queryForObject("ass.assInfo.getBasicInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return object2;
    }

    public Object getAssetDetail(Object object) {
        Object object2 = null;
        try {
            object2 = this.queryForObject("ass.assInfo.getAssetDetail", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return object2;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getBorrowRecord(Object object) {
        List resultList = null;
        try {
            resultList = this.queryForList("ass.assInfo.getBorrowRecord", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getBorrowRecordList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ass.assInfo.getBorrowRecordList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnList;
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public List getBorrowRecordList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("ass.assInfo.getBorrowRecordList", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnList;
    }

    @Override
    public int getBorrowRecordListCnt(Object object) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("ass.assInfo.getBorrowRecordListCnt", object)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnInt;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getAssBrokenSelectList(Object object) {
        List Rows = new ArrayList();
        try {
            Rows = this.queryForList("ass.assInfo.getAssBrokenSelectList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Rows;
    }

    @Override
    @SuppressWarnings("rawtypes")
    public void assReturnUpdate(List objectList) {
        try {
            this.updateForList("ass.assInfo.assReturnUpdate", objectList);
            this.updateForList("ass.assInfo.assStatusUpdate", objectList);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
