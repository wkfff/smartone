package com.siping.process.dao;

import com.siping.process.bean.ProcessRunning;

public interface ProcessRunningDao {
    public String addProcessRunningInfo(ProcessRunning item) throws Exception;

    public void updateProcessRunningForBusinessData(ProcessRunning processRunning) throws Exception;

    public ProcessRunning getProcessRunning(ProcessRunning item) throws Exception;

    public void updateProcessRunningResult(ProcessRunning processRunning) throws Exception;

}
