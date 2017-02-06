package com.siping.ass.dao.impl;

import java.sql.SQLException;

import org.springframework.stereotype.Repository;

import com.siping.ass.dao.AssManageDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class AssManageDaoImpl extends SqlMapClientSupport implements AssManageDao {

    @Override
    public int checkAssetID(Object object) throws SQLException {
        return (Integer) this.queryForObject("ass.assManage.checkAssetID", object);
    }

    @Override
    public int checkAssetName(Object object) throws SQLException {
        return (Integer) this.queryForObject("ass.assManage.checkAssetName", object);
    }

    @Override
    public void addAsset(Object object) throws SQLException {
        this.insert("ass.assManage.addAsset", object);
    }

    @Override
    public String getLastCodeID(Object object) throws SQLException {
        return (String) this.queryForObject("ass.assManage.getLastCodeID", object);
    }

    @Override
    public int checkCategoryName(Object object) throws SQLException {
        return (Integer) this.queryForObject("ass.assManage.checkCategoryName", object);
    }

    @Override
    public void addCategory(Object object) throws SQLException {
        this.insert("ass.assManage.addCategory", object);
    }

    @Override
    public void updateAsset(Object object) throws SQLException {
        this.update("ass.assManage.updateAsset", object);
    }

    @Override
    public Object getAssetDetail(Object object) {
        Object object2 = null;
        try {
            object2 = this.queryForObject("ass.assInfo.getAssetDetail", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return object2;
    }

    @Override
    public void removeAsset(Object object) throws SQLException {
        this.update("ass.assManage.removeAsset", object);
    }

    @Override
    public Integer getAssetId() throws SQLException {
        Integer assertId=(Integer)this.queryForObject("ass.assManage.getAssetId");
        return assertId;
    }

}
