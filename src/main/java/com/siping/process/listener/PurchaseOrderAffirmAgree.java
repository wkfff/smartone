package com.siping.process.listener;

import org.activiti.engine.delegate.DelegateExecution;
import org.activiti.engine.delegate.ExecutionListener;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.siping.process.service.ProcessAffirmSer;

@SuppressWarnings("serial")
@Component
public class PurchaseOrderAffirmAgree implements ExecutionListener {

    Logger logger = Logger.getLogger(PurchaseOrderAffirmAgree.class);
    @Autowired
    private ProcessAffirmSer affirmSer;

    @Override
    public void notify(DelegateExecution delegateExecution) throws Exception {
        String processInstanceId = delegateExecution.getProcessInstanceId();
        String processName = delegateExecution.getEngineServices().getRepositoryService().
            getProcessDefinition(delegateExecution.getProcessDefinitionId()).getKey();
        try {
            affirmSer.updatePurchaseOrderStatusAgree(processName, processInstanceId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        logger.info("更改审核结果：同意。。。。。。。");
    }

}
