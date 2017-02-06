package com.siping.process.service;

import com.siping.doc.bean.BusinessData;
import com.siping.process.bean.ProcessRunning;

public interface ProcessRunningSer {
    public ProcessRunning addProcessRunningInfo(BusinessData busiData) throws Exception;

    public void updateProcessRunningForBusinessData(BusinessData busiData) throws Exception;

    public void updateProcessRunningResult(ProcessRunning processRunning) throws Exception;

    public ProcessRunning getProcessRunningInfo(BusinessData busiData) throws Exception;
}
