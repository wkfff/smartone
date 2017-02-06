package com.siping.att.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.att.dao.AttDaliyLockDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class AttDaliyLockDaoImpl extends SqlMapClientSupport implements AttDaliyLockDao {

    @SuppressWarnings("rawtypes")
    public List getAttDaliyLockInfo(Object object) {
        List returnList = new ArrayList();

        try {
            returnList = this.queryForList("att.daliyLock.getAttDaliyLockInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }

    public int updateAttDaliyLockInfo(Object object) {
        int returnInt = 1;
        try {
            this.update("att.daliyLock.updateAttDaliyLockInfo", object);
        } catch (SQLException e) {
            returnInt = 0;
            e.printStackTrace();
        } catch (Exception e) {
            returnInt = 0;
            e.printStackTrace();
        }
        return returnInt;
    }

    public int addDailyLock(Object object) {

        try {
            this.insert("att.daliyLock.addDailyLock", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int validateDailyLock(Object object) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("att.daliyLock.validateDailyLock", object)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnInt;
    }

}
