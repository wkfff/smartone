package com.siping.hrm.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.siping.hrm.dao.HrmDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class HrmDaoImpl extends SqlMapClientSupport implements HrmDao {

    public Object getDeptById(Object object) {
        Object object2 = null;
        try {
            object2 = this.queryForObject("hrm.getDeptById", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return object2;
    }

    @SuppressWarnings({ "rawtypes" })
    public List getDeptTree(String sm, Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList(sm, object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

	@Override
	public List getAllConPer(String sm) {
		// TODO Auto-generated method stub
		List list = new ArrayList();
        try {
            list = this.queryForList(sm);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
}
