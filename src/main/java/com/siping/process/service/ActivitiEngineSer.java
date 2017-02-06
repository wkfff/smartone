package com.siping.process.service;

import com.siping.doc.bean.BusinessData;
import com.siping.process.bean.ProcessModel;

public interface ActivitiEngineSer {

    ProcessModel createNewModel() throws Exception;

    void saveModel(ProcessModel processModel) throws Exception;

    void removeModel(String modelId) throws Exception;

    ProcessModel getProcessModel(String modelId) throws Exception;

    String deployProcessModel(ProcessModel modelData) throws Exception;

    void startProcessOfBusinessData(String processKey, BusinessData busiData) throws Exception;
}
