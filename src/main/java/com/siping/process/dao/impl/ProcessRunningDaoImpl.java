package com.siping.process.dao.impl;

import org.springframework.stereotype.Repository;

import com.siping.process.bean.ProcessRunning;
import com.siping.process.dao.ProcessRunningDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class ProcessRunningDaoImpl extends SqlMapClientSupport implements ProcessRunningDao {
    @Override
    public String addProcessRunningInfo(ProcessRunning item) throws Exception {
        try {
            return this.insert("process.processRunning.addProcessRunningInfo", item).toString();
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void updateProcessRunningForBusinessData(ProcessRunning item) throws Exception {
        try {
            this.update("process.processRunning.updateProcessRunningInfo", item);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public ProcessRunning getProcessRunning(ProcessRunning item) throws Exception {
        try {
            return (ProcessRunning) this.queryForObject("process.processRunning.getProcessRunning", item);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void updateProcessRunningResult(ProcessRunning processRunning) throws Exception {
        try {
            this.update("process.processRunning.updateProcessRunningResult", processRunning);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

}
