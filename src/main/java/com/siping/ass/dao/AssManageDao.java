package com.siping.ass.dao;

import java.sql.SQLException;

public interface AssManageDao {

    public int checkAssetID(Object object) throws SQLException;

    public int checkAssetName(Object object) throws SQLException;

    public int checkCategoryName(Object object) throws SQLException;

    public void addAsset(Object object) throws SQLException;

    public String getLastCodeID(Object object) throws SQLException;

    public void addCategory(Object object) throws SQLException;

    public void updateAsset(Object object) throws SQLException;

    public Object getAssetDetail(Object object);

    public void removeAsset(Object object) throws SQLException;

    public Integer getAssetId() throws SQLException;
}
