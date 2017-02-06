package com.siping.web.dao.impl;

import java.sql.SQLException;

import org.springframework.stereotype.Repository;

import com.siping.web.dao.TimerTaskDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class TimerTaskDaoImpl extends SqlMapClientSupport implements TimerTaskDao {

    @Override
    public void initialPaInputItemInfo(Object object) {
        try {
            this.insert("pa.paInputItem.initialPaInputItemInfo", object);
            this.insert("pa.paInputItem.initialEvaItemInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void daylyCheckAttInfo() {
        try {
            this.insert("pa.paInputItem.timingInsertAttendanceInfo");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
