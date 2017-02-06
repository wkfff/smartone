package com.siping.process.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.io.ByteArrayInputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.activiti.bpmn.converter.BpmnXMLConverter;
import org.activiti.bpmn.model.BpmnModel;
import org.activiti.editor.constants.ModelDataJsonConstants;
import org.activiti.editor.language.json.converter.BpmnJsonConverter;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.form.FormProperty;
import org.activiti.engine.form.TaskFormData;
import org.activiti.engine.history.HistoricVariableInstance;
import org.activiti.engine.impl.form.BooleanFormType;
import org.activiti.engine.impl.form.DateFormType;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.DeploymentBuilder;
import org.activiti.engine.repository.Model;
import org.activiti.engine.repository.ProcessDefinition;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.node.ObjectNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import org.apache.log4j.Logger;
import org.activiti.engine.FormService;
import org.activiti.engine.HistoryService;
import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/process/activitiEngine")
public class ActivitiEngineCtroller {
    Logger logger = Logger.getLogger(ObjectTypeCtroller.class);

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

    /**
     * 流程列表
     */
    @RequestMapping(value = "/viewProcessList", method = RequestMethod.GET)
    public ModelAndView viewProcessList(HttpServletRequest request, ModelMap modelMap) {
        return new ModelAndView("/process/activitiEngine/viewProcessList", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @ResponseBody
    @RequestMapping(value = "/getProcessList", method = RequestMethod.POST)
    public Map getProcessList(HttpServletRequest request, ModelMap modelMap) {
        List<ProcessDefinition> processDefinitionList = repositoryService.createProcessDefinitionQuery().latestVersion().list();
        List<LinkedHashMap<String, Object>> list = new ArrayList<LinkedHashMap<String, Object>>();
        for (ProcessDefinition node : processDefinitionList) {
            LinkedHashMap nodeMap = new LinkedHashMap<String, String>();
            nodeMap.put("VERSION", node.getVersion());
            nodeMap.put("DEPLOYMENTID", node.getDeploymentId());
            nodeMap.put("DESCRIPTION", node.getDescription());
            nodeMap.put("ID", node.getId());
            nodeMap.put("KEY", node.getKey());
            nodeMap.put("NAME", node.getName());
            nodeMap.put("RESOURCE", node.getResourceName());
            list.add(nodeMap);
        }
        modelMap.put("Rows", list);
        modelMap.put("Total", list.size());
        return modelMap;
    }

    /**
     * 删除Process-suspend it
     */
    @SuppressWarnings("rawtypes")
    @ResponseBody
    @RequestMapping(value = "/deleteProcess", method = RequestMethod.POST)
    public String deleteProcess(HttpServletRequest request, HttpServletResponse response) {
        String resultString = "Y";
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        /*
         * 删除全部模型 List<Model> modelList =
         * repositoryService.createModelQuery().list(); for(Model node :
         * modelList){ repositoryService.deleteModel(node.getId()); }
         */

        if (paramMap.get("PROCESSKEY") != null) {
            try {
                repositoryService.suspendProcessDefinitionById(paramMap.get("PROCESSKEY").toString(), false, new Date());
            } catch (Exception e) {
                e.getStackTrace();
                e.printStackTrace();
                resultString = "删除流程出错";
            }
        }
        return resultString;
    }

    /**
     * 模型列表
     */
    @RequestMapping(value = "/viewModelList", method = RequestMethod.GET)
    public ModelAndView viewModelList(HttpServletRequest request, ModelMap modelMap) {
        return new ModelAndView("/process/activitiEngine/viewModelList", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @ResponseBody
    @RequestMapping(value = "/getModelList", method = RequestMethod.POST)
    public Map getModelList(HttpServletRequest request, ModelMap modelMap) {
        // RepositoryService repositoryService =
        // processEngine.getRepositoryService();
        List<Model> modelList = repositoryService.createModelQuery().list();
        List<LinkedHashMap<String, Object>> list = new ArrayList<LinkedHashMap<String, Object>>();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        for (Model node : modelList) {
            LinkedHashMap nodeMap = new LinkedHashMap<String, String>();
            nodeMap.put("DEPLOYMENTID", node.getDeploymentId());
            nodeMap.put("METAINFO", node.getMetaInfo());
            nodeMap.put("VERSION", node.getVersion());
            nodeMap.put("ID", node.getId());
            nodeMap.put("KEY", node.getKey());
            nodeMap.put("NAME", node.getName());
            nodeMap.put("UPDATE_TIME", formatter.format(node.getLastUpdateTime()));
            list.add(nodeMap);
        }
        modelMap.put("Rows", list);
        modelMap.put("Total", list.size());
        return modelMap;
    }

    @RequestMapping(value = "/viewAddActivitiModel")
    public ModelAndView viewAddActivitiModel() {
        return new ModelAndView("/process/activitiEngine/viewAddActivitiModel");
    }

    /**
     * 修改模型
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/updateModel")
    public void updateModel(HttpServletRequest request, HttpServletResponse response) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        if (paramMap.get("PROCESSID") != null) {
            try {
                ProcessDefinition processDefinition = repositoryService.getProcessDefinition(paramMap.get("PROCESSID").toString());
                List<Model> queryList = repositoryService.createModelQuery().modelKey(processDefinition.getKey()).modelVersion(processDefinition.getVersion() + 1).list();
                if (queryList.size() != 0) {
                    Model model = queryList.get(0);
                    response.sendRedirect(request.getContextPath() + "/activiti/service/editor?id=" + model.getId());
                    return;
                }

                // 获取流程的BOMNModel并转化为Json格式的模型资源
                BpmnModel bpmnModel = repositoryService.getBpmnModel(paramMap.get("PROCESSID").toString());
                BpmnJsonConverter converter = new BpmnJsonConverter();
                ObjectNode jsonmodelNode = converter.convertToJson(bpmnModel);

                ObjectMapper objectMapper = new ObjectMapper();
                ObjectNode modelObjectNode = objectMapper.createObjectNode();
                modelObjectNode.put(ModelDataJsonConstants.MODEL_NAME, processDefinition.getName());
                modelObjectNode.put(ModelDataJsonConstants.MODEL_REVISION, processDefinition.getVersion() + 1);
                modelObjectNode.put(ModelDataJsonConstants.MODEL_DESCRIPTION, processDefinition.getDescription());

                Model modelData = repositoryService.newModel();
                modelData.setMetaInfo(modelObjectNode.toString());
                modelData.setName(processDefinition.getName());
                modelData.setKey(processDefinition.getKey());
                modelData.setVersion(processDefinition.getVersion() + 1);

                repositoryService.saveModel(modelData);
                // 存储模型资源信息到model中
                repositoryService.addModelEditorSource(modelData.getId(), jsonmodelNode.toString().getBytes("utf-8"));
                response.sendRedirect(request.getContextPath() + "/activiti/service/editor?id=" + modelData.getId());
            } catch (Exception e) {
                e.getStackTrace();
                e.printStackTrace();
            }
        }
        if (paramMap.get("MODELID") != null) {
            try {
                response.sendRedirect(request.getContextPath() + "/activiti/service/editor?id=" + paramMap.get("MODELID").toString());
            } catch (Exception e) {
                e.getStackTrace();
                e.printStackTrace();
            }
        }
    }

    /**
     * 创建模型
     */
    @SuppressWarnings("rawtypes")
    @ResponseBody
    @RequestMapping(value = "/deleteModel", method = RequestMethod.POST)
    public String deleteModel(HttpServletRequest request, HttpServletResponse response) {
        String resultString = "Y";
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        /*
         * 删除全部模型 List<Model> modelList =
         * repositoryService.createModelQuery().list(); for(Model node :
         * modelList){ repositoryService.deleteModel(node.getId()); }
         */

        if (paramMap.get("MODELID") != null) {
            try {
                repositoryService.deleteModel(paramMap.get("MODELID").toString());
            } catch (Exception e) {
                e.getStackTrace();
                e.printStackTrace();
                resultString = "删除模型出错";
            }
        }
        return resultString;
    }

    /**
     * 创建模型
     */
    @RequestMapping(value = "/createModel")
    public void createModel(@RequestParam("NAME") String name, @RequestParam("KEY") String key, @RequestParam("DESCRIPTION") String description, HttpServletRequest request,
                            HttpServletResponse response) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            ObjectNode editorNode = objectMapper.createObjectNode();
            editorNode.put("id", "canvas");
            editorNode.put("resourceId", "canvas");
            ObjectNode stencilSetNode = objectMapper.createObjectNode();
            stencilSetNode.put("namespace", "http://b3mn.org/stencilset/bpmn2.0#");
            editorNode.put("stencilset", stencilSetNode);
            Model modelData = repositoryService.newModel();

            ObjectNode modelObjectNode = objectMapper.createObjectNode();
            modelObjectNode.put(ModelDataJsonConstants.MODEL_NAME, name);
            modelObjectNode.put(ModelDataJsonConstants.MODEL_REVISION, 1);
            modelObjectNode.put(ModelDataJsonConstants.MODEL_DESCRIPTION, description);
            modelData.setMetaInfo(modelObjectNode.toString());
            modelData.setName(name);
            modelData.setKey(key);
            repositoryService.saveModel(modelData);
            repositoryService.addModelEditorSource(modelData.getId(), editorNode.toString().getBytes("utf-8"));
            response.sendRedirect(request.getContextPath() + "/activiti/service/editor?id=" + modelData.getId());
        } catch (Exception e) {
            e.getStackTrace();
            e.printStackTrace();
        }
    }

    /**
     * 根据Model部署流程
     */
    @SuppressWarnings("rawtypes")
    @ResponseBody
    @RequestMapping(value = "/deployModel")
    public String deploy(HttpServletRequest request, HttpServletResponse response) {
        String resultString = "Y";
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        if (paramMap.get("MODELID") != null) {
            try {
                Model modelData = repositoryService.getModel(paramMap.get("MODELID").toString());
                ObjectNode modelNode = (ObjectNode) new ObjectMapper().readTree(new String(repositoryService.getModelEditorSource(modelData.getId()), "UTF-8"));
                BpmnModel model = new BpmnJsonConverter().convertToBpmnModel(modelNode);
                byte[] bpmnBytes = new BpmnXMLConverter().convertToXML(model);

                String modename = modelData.getName();
                SimpleDateFormat formatter = new SimpleDateFormat("_yyyyMMdd_HH:mm");
                String processName = modelData.getKey() + formatter.format(new Date())+ ".bpmn20.xml";

                /**
                 * 创建部署构建器，设置相关参数（资源），并提交部署
                 */
                DeploymentBuilder deploymentBuilder = repositoryService.createDeployment().name(modename).addInputStream(processName, new ByteArrayInputStream(bpmnBytes));
                Deployment deployment = deploymentBuilder.deploy();

                modelData.setDeploymentId(deployment.getId());
                repositoryService.saveModel(modelData);
            } catch (Exception e) {
                e.getStackTrace();
                e.printStackTrace();
                resultString = "部署模型出错";
            }
        }
        return resultString;
    }

    /**
     * 查看task列表
     */
    @RequestMapping(value = "/viewTaskList", method = RequestMethod.GET)
    public ModelAndView viewTaskList(HttpServletRequest request, ModelMap modelMap) {
        return new ModelAndView("/process/activitiEngine/viewTaskList", modelMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @ResponseBody
    @RequestMapping(value = "/getTaskList", method = RequestMethod.POST)
    public Map getTaskList(HttpServletRequest request, ModelMap modelMap) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // RepositoryService repositoryService =
        // processEngine.getRepositoryService();
        // List<Task> taskList =
        // taskService.createTaskQuery().processDefinitionKey("OtApplyProcess").list();
        List<Task> taskList = taskService.createTaskQuery().taskAssignee(admin.getAdminID()).list();
        List<LinkedHashMap<String, Object>> list = new ArrayList<LinkedHashMap<String, Object>>();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        for (Task node : taskList) {
            LinkedHashMap nodeMap = new LinkedHashMap<String, String>();
            nodeMap.put("ASSIGNEE", node.getAssignee());
            nodeMap.put("OWNER", node.getOwner());
            nodeMap.put("ID", node.getId());
            nodeMap.put("DESCRIPTION", node.getDescription());
            nodeMap.put("INSTANCEID", node.getProcessInstanceId());
            nodeMap.put("EXECUTIONID", node.getExecutionId());
            nodeMap.put("NAME", node.getName());
            nodeMap.put("CREATE_TIME", formatter.format(node.getCreateTime()));
            List<HistoricVariableInstance> forDataList = historyService.createHistoricVariableInstanceQuery().processInstanceId(node.getProcessInstanceId()).orderByVariableName().desc().list();
            for(HistoricVariableInstance form : forDataList){
                nodeMap.put(form.getVariableName(),form.getValue());
            }
            list.add(nodeMap);
        }
        modelMap.put("Rows", list);
        modelMap.put("Total", list.size());
        return modelMap;
    }

    /**
     * 提交task
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/submitTask")
    public void submitTask(HttpServletRequest request, HttpServletResponse response) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        if (paramMap.get("TASKID") != null) {
            try {
                LinkedHashMap taskResult = new LinkedHashMap<String, Object>();
                List<FormProperty> formPropertyList = formService.getTaskFormData(paramMap.get("TASKID").toString()).getFormProperties();
                for (FormProperty node : formPropertyList) {
                    if (node.getType().getName().equals("boolean")) {
                        // taskResult.put(node.getId(),
                        // paramMap.get(node.getId()).equals("true"));
                        taskResult.put(node.getId(), ((BooleanFormType) node.getType()).convertFormValueToModelValue(paramMap.get(node.getId()).toString()));
                        continue;
                    }
                    if (node.getType().getName().equals("date")) {
                        // taskResult.put(node.getId(),
                        // formatter.parse(paramMap.get(node.getId()).toString()));
                        taskResult.put(node.getId(), ((DateFormType) node.getType()).convertFormValueToModelValue(paramMap.get(node.getId()).toString()));
                        continue;
                    }
                    if (node.getType().getName().equals("long")) {
                        taskResult.put(node.getId(), Long.parseLong(paramMap.get(node.getId()).toString()));
                        continue;
                    }
                    if (node.getType().getName().equals("string")) {
                        taskResult.put(node.getId(), paramMap.get(node.getId()).toString());
                        continue;
                    }
                }
                taskService.complete(paramMap.get("TASKID").toString(), taskResult);
                response.sendRedirect(request.getContextPath() + "/process/activitiEngine/viewTaskList?MENU_CODE=process0303");
            } catch (Exception e) {
                e.getStackTrace();
                e.printStackTrace();
            }
        }
    }

    /**
     * 获取Task Form格式
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @ResponseBody
    @RequestMapping(value = "/getTaskForm", method = RequestMethod.POST)
    public List getTaskForm(HttpServletRequest request, ModelMap modelMap) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        List<LinkedHashMap<String, Object>> list = new ArrayList<LinkedHashMap<String, Object>>();
        if (paramMap.get("TASKID") != null) {
            try {
                TaskFormData taskFormData = formService.getTaskFormData(paramMap.get("TASKID").toString());
                List<FormProperty> formPropertyList = taskFormData.getFormProperties();
                for (FormProperty node : formPropertyList) {
                    LinkedHashMap nodeMap = new LinkedHashMap<String, String>();
                    nodeMap.put("NAME", node.getName());
                    nodeMap.put("ID", node.getId());
                    nodeMap.put("TYPE", node.getType());
                    list.add(nodeMap);
                }
            } catch (Exception e) {
                e.getStackTrace();
                e.printStackTrace();
            }
        }
        return list;
    }

    /**
     * 删除task
     */
    @SuppressWarnings("rawtypes")
    @ResponseBody
    @RequestMapping(value = "/deleteTask")
    public String deleteTask(HttpServletRequest request, HttpServletResponse response) {
        String resultString = "Y";
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        if (paramMap.get("TASKID") != null) {
            try {
                taskService.deleteTask(paramMap.get("TASKID").toString());
            } catch (Exception e) {
                e.getStackTrace();
                e.printStackTrace();
                resultString = "删除任务出错";
            }
        }
        return resultString;
    }
}
