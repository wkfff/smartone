package com.siping.process.service.impl;

import java.io.ByteArrayInputStream;
import java.util.HashMap;
import java.util.Map;

import org.activiti.bpmn.converter.BpmnXMLConverter;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.editor.constants.ModelDataJsonConstants;
import org.activiti.editor.language.json.converter.BpmnJsonConverter;
import org.activiti.engine.FormService;
import org.activiti.engine.HistoryService;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.DeploymentBuilder;
import org.activiti.engine.repository.Model;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.node.ObjectNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.siping.doc.bean.BusinessData;
import com.siping.process.bean.ProcessModel;
import com.siping.process.service.ActivitiEngineSer;

@Service
public class ActivitiEngineSerImpl implements ActivitiEngineSer {
    private static final String BUSI_MODEL_DESCRIPTION = "BusinessData Process Definition!";

    @Autowired
    private HistoryService historyService;

    @Autowired
    @Qualifier("processEngine")
    private ProcessEngine processEngine;

    @Autowired
    @Qualifier("repositoryService")
    private RepositoryService repositoryService;

    @Autowired
    @Qualifier("taskService")
    private TaskService taskService;

    @Autowired
    @Qualifier("formService")
    private FormService formService;

    @Autowired
    @Qualifier("runtimeService")
    private RuntimeService runtimeService;

    @Override
    public ProcessModel createNewModel() {
        ProcessModel processModel = new ProcessModel();
        Model model = repositoryService.newModel();
        processModel.setModel(model);
        return processModel;
    }

    @Override
    public void saveModel(ProcessModel processModel) throws Exception {
        try {
            Model model = processModel.getModel();
            ObjectMapper objectMapper = new ObjectMapper();

            ObjectNode modelObjectNode = objectMapper.createObjectNode();
            modelObjectNode.put(ModelDataJsonConstants.MODEL_ID, processModel.generateProcessId());
            modelObjectNode.put(ModelDataJsonConstants.MODEL_NAME, processModel.generateProcessId());
            modelObjectNode.put(ModelDataJsonConstants.MODEL_REVISION, model.getVersion());
            modelObjectNode.put(ModelDataJsonConstants.MODEL_DESCRIPTION,BUSI_MODEL_DESCRIPTION);
            model.setMetaInfo(modelObjectNode.toString());
            repositoryService.saveModel(model);

            ObjectNode editorNode = objectMapper.createObjectNode();
            editorNode.put("id", "canvas");
            editorNode.put("resourceId", "canvas");
            ObjectNode stencilSetNode = objectMapper.createObjectNode();
            stencilSetNode.put("namespace", "http://b3mn.org/stencilset/bpmn2.0#");
            editorNode.put("stencilset", stencilSetNode);
            ObjectNode properties  = objectMapper.createObjectNode();
            properties.put(BpmnJsonConverter.PROPERTY_PROCESS_ID, processModel.generateProcessId());
            properties.put(BpmnJsonConverter.PROPERTY_NAME, processModel.generateProcessId());
            properties.put(BpmnJsonConverter.PROPERTY_PROCESS_VERSION, model.getVersion());
            properties.put(BpmnJsonConverter.PROPERTY_DOCUMENTATION, BUSI_MODEL_DESCRIPTION);
            editorNode.put("properties", properties);
            repositoryService.addModelEditorSource(model.getId(), editorNode.toString().getBytes("UTF-8"));
            processModel.setId(model.getId());
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void removeModel(String modelId) throws Exception {
        this.repositoryService.deleteModel(modelId);
    }

    @Override
    public ProcessModel getProcessModel(String modelId) throws Exception {
        ProcessModel processModel = new ProcessModel();
        Model model = this.repositoryService.getModel(modelId);
        if (model == null) {
            throw new Exception("No model with id:" + modelId + " was found in activiti!");
        }
        processModel.setModel(model);
        processModel.setId(model.getId());
        return processModel;
    }

    @Override
    public String deployProcessModel(ProcessModel processModel) throws Exception {
        try {
            Model model = processModel.getModel();
            ObjectNode modelNode = (ObjectNode) new ObjectMapper().readTree(new String(repositoryService.getModelEditorSource(model.getId()), "UTF-8"));
            BpmnModel bpmnModel = new BpmnJsonConverter().convertToBpmnModel(modelNode);
            byte[] bpmnBytes = new BpmnXMLConverter().convertToXML(bpmnModel);

            String processName = processModel.createProcessName();

            /**
             * 创建部署构建器，设置相关参数（资源），并提交部署
             */
            DeploymentBuilder deploymentBuilder = repositoryService.createDeployment().name(model.getName());
            deploymentBuilder.addInputStream(processName, new ByteArrayInputStream(bpmnBytes));
            Deployment deployment = deploymentBuilder.deploy();

            model.setDeploymentId(deployment.getId());
            repositoryService.saveModel(model);

            return processModel.generateProcessId();
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }

    }

    @Override
    public void startProcessOfBusinessData(String processKey, BusinessData busiData) throws Exception {
        try {
            Map<String, Object> dataMaps = new HashMap<String, Object>();
            dataMaps.put(BusinessData.KEY_FORM, busiData);

            this.runtimeService.startProcessInstanceByKey(processKey, dataMaps);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

}
