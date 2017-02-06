package com.siping.web.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.siping.web.dao.ChatterInfoDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class ChatterInfoDaoImpl extends SqlMapClientSupport implements ChatterInfoDao {

    public List getDeptTree(Object object) {
        List returnMap = null;
        try {
            returnMap = this.queryForList("chatter.chatterInfo.getDeptTree");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnMap;
    }

    @Override
    public List getAllEmpDeptTree() {
        List returnMap = null;
        try {
            returnMap = this.queryForList("chatter.chatterInfo.getAllEmpDeptTree");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnMap;
    }

}
