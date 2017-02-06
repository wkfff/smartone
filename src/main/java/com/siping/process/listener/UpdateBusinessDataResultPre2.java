package com.siping.process.listener;

import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.ExecutionListener;
import org.activiti.engine.delegate.TaskListener;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import com.siping.doc.bean.BusinessData;

@Component
public class UpdateBusinessDataResultPre2 extends UpdateProcessRunning implements ExecutionListener, TaskListener {
    private static final long serialVersionUID = 1L;

    Logger logger = Logger.getLogger(UpdateBusinessDataResultSuccess.class);

    @Override
    public void notify(DelegateExecution delegateExecution) {
        BusinessData busiData = (BusinessData) delegateExecution.getVariable(BusinessData.KEY_FORM);
        try {
            updateResult(busiData, ResultEnum.PRE2);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    }

    @Override
    public void notify(DelegateTask delegateTask) {
        BusinessData busiData = (BusinessData) delegateTask.getVariable(BusinessData.KEY_FORM);
        try {
            updateResult(busiData, ResultEnum.PRE2);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    }
}
