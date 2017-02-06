package com.siping.process.listener;

import org.springframework.beans.factory.annotation.Autowired;

import com.siping.doc.bean.BusinessData;
import com.siping.process.bean.ProcessRunning;
import com.siping.process.service.ProcessRunningSer;

public class UpdateProcessRunning {

    @Autowired
    ProcessRunningSer processRunningSer;

    protected void updateResult(BusinessData busiData, ResultEnum result) throws Exception {
        if (busiData == null || busiData.getNo() == null) {
            return;
        }
        try {
            ProcessRunning processRunning = busiData.createEmptyProcessRunning();
            processRunning.setResult(result.getCode());
            processRunningSer.updateProcessRunningResult(processRunning);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

}
