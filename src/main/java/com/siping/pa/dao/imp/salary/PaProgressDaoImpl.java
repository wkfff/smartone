package com.siping.pa.dao.imp.salary;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.siping.pa.dao.salary.PaProgressDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class PaProgressDaoImpl extends SqlMapClientSupport implements PaProgressDao {
    /**
     * 添加工资锁定信息
     * @param List
     * @return
     */
    @SuppressWarnings("rawtypes")
    public Object addPaProgressObjectInfo(Object obj) {
        LinkedHashMap returnObj = new LinkedHashMap();
        try {
            this.insert("pa.progress.addPaProgressInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnObj;
    }

    /**
     * 取得工资锁定信息
     * @param List
     * @return
     */
    @SuppressWarnings("rawtypes")
    public Object getPaProgressObjectInfo(Object obj) {
        LinkedHashMap returnObj = new LinkedHashMap();
        try {
            returnObj = (LinkedHashMap) this.queryForObject("pa.progress.getPaProgressInfo", obj);
            if (returnObj == null) {
                this.addPaProgressObjectInfo(obj);
                returnObj = (LinkedHashMap) this.queryForObject("pa.progress.getPaProgressInfo", obj);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnObj;
    }

    /**
     * 取得工资锁定信息列表
     * @param List
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getPaProgressInfo(Object obj) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("pa.progress.getPaProgressInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnList;
    }

    /**
     * 更新工资锁定信息
     * @param List
     * @return
     */
    public int updatePaProgressInfo(Object obj) {
        try {
            this.update("pa.progress.updatePaProgressInfo", obj);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
