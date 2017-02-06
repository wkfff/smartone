package com.siping.mat.dao.impl;

import java.sql.SQLException;

import org.springframework.stereotype.Repository;

import com.siping.mat.dao.MatCheckDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class MatCheckDaoImpl extends SqlMapClientSupport implements MatCheckDao {

    @Override
    public int checkCategoryName(Object object) throws SQLException {
        return (Integer) this.queryForObject("mat.matCheck.checkCategoryName", object);
    }

    @Override
    public int checkMaterialID(Object object) throws SQLException {
        return (Integer) this.queryForObject("mat.matCheck.checkMaterialID", object);
    }

    @Override
    public int checkMaterialName(Object object) throws SQLException {
        return (Integer) this.queryForObject("mat.matCheck.checkMaterialName", object);
    }

    @Override
    public int checkStorageID(Object object) throws SQLException {
        return (Integer) this.queryForObject("mat.matCheck.checkStorageID", object);
    }

    @Override
    public int checkStorageName(Object object) throws SQLException {
        return (Integer) this.queryForObject("mat.matCheck.checkStorageName", object);
    }
}
