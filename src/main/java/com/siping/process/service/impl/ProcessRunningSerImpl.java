package com.siping.process.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.doc.bean.BusinessData;
import com.siping.doc.bean.MetaData;
import com.siping.process.bean.ProcessItem;
import com.siping.process.bean.ProcessModel;
import com.siping.process.bean.ProcessRunning;
import com.siping.process.bean.State;
import com.siping.process.bean.Type;
import com.siping.process.dao.ObjectTypeDao;
import com.siping.process.dao.ProcessRunningDao;
import com.siping.process.service.ActivitiEngineSer;
import com.siping.process.service.ProcessRunningSer;

@Service
public class ProcessRunningSerImpl implements ProcessRunningSer {
    @Autowired
    private ObjectTypeDao objectTypeDao;

    @Autowired
    private ProcessRunningDao processRunningDao;

    @Autowired
    private ActivitiEngineSer activitiEngineSer;

    @Override
    public ProcessRunning addProcessRunningInfo(BusinessData busiData) throws Exception {
        MetaData metaData = busiData.getMetaData();
        ProcessRunning newRunning = busiData.createEmptyProcessRunning();
        Type type = newRunning.getType();
        type.setMetaData(metaData);

        State startState = objectTypeDao.getObjectTypeDetail(type).getDefaultState();
        newRunning.setType(type);
        newRunning.setState(startState);

        /**************************/
        ProcessItem item = new ProcessItem();
        item.setType(newRunning.getType());
        item.setState(newRunning.getState());
        item.setMetaData(metaData);
        item = objectTypeDao.getProcessItemDetail(item);

        ProcessModel model = item.getProcessModel();
        if (model != null && model.getProcessKey() != null && !model.getProcessKey().trim().equals("")) {
            String processKey = item.getProcessModel().getProcessKey();
            activitiEngineSer.startProcessOfBusinessData(processKey, busiData);
        }
        /**************************/

        String itemNo = processRunningDao.addProcessRunningInfo(newRunning);
        newRunning.setNo(Long.parseLong(itemNo));
        busiData.setProcessRunning(newRunning);
        return newRunning;
    }

    @Override
    public void updateProcessRunningForBusinessData(BusinessData busiData) throws Exception {
        MetaData metaData = busiData.getMetaData();
        ProcessRunning newRunning = busiData.getProcessRunning();
        newRunning.setDataClass(busiData.getClass().getName());
        newRunning.setMetaData(busiData.getMetaData());
        ProcessRunning oriRunning = this.getProcessRunningInfo(busiData);

        if (!newRunning.equals(oriRunning)) {
            /**************************/
            ProcessItem item = new ProcessItem();
            item.setType(newRunning.getType());
            item.setState(newRunning.getState());
            item.setMetaData(metaData);
            item = objectTypeDao.getProcessItemDetail(item);

            ProcessModel model = item.getProcessModel();
            if (model != null && model.getProcessKey() != null && !model.getProcessKey().trim().equals("")) {
                String processKey = item.getProcessModel().getProcessKey();
                activitiEngineSer.startProcessOfBusinessData(processKey, busiData);
            }
            /**************************/

            processRunningDao.updateProcessRunningForBusinessData(newRunning);
        }
    }

    @Override
    public void updateProcessRunningResult(ProcessRunning processRunning) throws Exception {
        processRunningDao.updateProcessRunningResult(processRunning);
    }

    @Override
    public ProcessRunning getProcessRunningInfo(BusinessData busiData) throws Exception {
        ProcessRunning newRunning = busiData.createEmptyProcessRunning();
        try {
            return processRunningDao.getProcessRunning(newRunning);
        } catch (Exception e) {
            throw e;
        }
    }

}
