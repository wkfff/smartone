package com.siping.process.action;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.doc.bean.MetaData;
import com.siping.doc.bean.RequestResult;
import com.siping.process.bean.Grant;
import com.siping.process.bean.PagerRequest;
import com.siping.process.bean.PagerResult;
import com.siping.process.bean.ProcessItem;
import com.siping.process.bean.ProcessModel;
import com.siping.process.bean.Type;
import com.siping.process.service.ActivitiEngineSer;
import com.siping.process.service.ObjectTypeSer;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/process/objectType")
public class ObjectTypeCtroller {
    Logger logger = Logger.getLogger(ObjectTypeCtroller.class);

    @Autowired
    private ObjectTypeSer objectTypeSer;

    @Autowired
    private ActivitiEngineSer activitiEngineSer;

    /************************* 跳转页面************************************* */
    @RequestMapping(value = "/viewObjectTypeList", method = RequestMethod.GET)
    public ModelAndView viewObjectTypeList(HttpServletRequest request, ModelMap modelMap) {
        return new ModelAndView("/process/objectType/viewObjectTypeList", modelMap);
    }

    @RequestMapping(value = "/viewObjectTypeDetail", method = RequestMethod.GET)
    public ModelAndView viewObjectTypeDetail(HttpServletRequest request, ModelMap modelMap, @RequestParam("typeNo") Long typeNo) {
        Type type = new Type();
        type.setNo(typeNo);

        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            type.setMetaData(metaData);
            type = this.objectTypeSer.getObjectTypeDetail(type);
            type.setMetaData(metaData);
        } catch (Exception e) {
            logger.error(e);
        }

        modelMap.put("ObjectTypeDetail", type);
        return new ModelAndView("/process/objectType/viewObjectTypeDetail", modelMap);
    }

    @RequestMapping(value = "/addObjectType", method = RequestMethod.GET)
    public ModelAndView addObjectType(HttpServletRequest request, ModelMap modelMap) {
        return new ModelAndView("/process/objectType/addObjectType", modelMap);
    }

    @RequestMapping(value = "/updateObjectType", method = RequestMethod.GET)
    public ModelAndView updateObjectType(HttpServletRequest request, ModelMap modelMap, @RequestParam("typeNo") Long typeNo) {
        Type type = new Type();
        type.setNo(typeNo);
        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            type.setMetaData(metaData);
            type = this.objectTypeSer.getObjectTypeDetail(type);
            type.setMetaData(metaData);
        } catch (Exception e) {
            logger.error(e);
        }

        modelMap.put("ObjectTypeDetail", type);
        return new ModelAndView("/process/objectType/updateObjectType", modelMap);
    }

    @RequestMapping(value = "/addProcessItem", method = RequestMethod.GET)
    public ModelAndView addProcessItem(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("paramMap", ObjectBindUtil.getRequestParams(request));
        return new ModelAndView("/process/objectType/addProcessItem", modelMap);
    }

    @RequestMapping(value = "/updateProcessItem", method = RequestMethod.GET)
    public ModelAndView updateProcessItem(HttpServletRequest request, ModelMap modelMap, @RequestParam("processItemNo") Long processItemNo) {
        modelMap.put("paramMap", ObjectBindUtil.getRequestParams(request));
        ProcessItem item = new ProcessItem();
        item.setNo(processItemNo);

        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            item.setMetaData(metaData);
            item = this.objectTypeSer.getProcessItemDetail(item);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        modelMap.put("processItem", item);
        return new ModelAndView("/process/objectType/updateProcessItem", modelMap);
    }

    /************************ 提交处理 ********************************/

    @RequestMapping(value = "/getObjectTypeList", method = RequestMethod.GET)
    @ResponseBody
    public List<Type> getObjectTypeList(HttpServletRequest request) {
        HashMap<String, Object> params = ObjectBindUtil.getRequestParams(request);

        List<Type> typeList = null;
        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            params.put(MetaData.KEY, metaData);

            typeList = this.objectTypeSer.getObjectTypeList(params);
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return typeList;
    }

    @RequestMapping(value = "/transferObjectType", method = RequestMethod.POST)
    @ResponseBody
    public RequestResult<String> transferObjectType(HttpServletRequest request, @RequestParam("jsonData") String jsonData, @RequestParam(value = "jsonGrants", required = false) String jsonGrants) {
        RequestResult<String> result = new RequestResult<String>();
        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            Type type = ObjectBindUtil.parseRequestJsonDataToObject(jsonData, Type.class);
            type.setMetaData(metaData);
            if (type.getNo() == null || type.getNo() == 0) {
                String typeNo = this.objectTypeSer.addObjectType(type);
                result.setMessage(typeNo);
            } else {
                List<Grant> grants = ObjectBindUtil.parseRequestJsonDataToList(jsonGrants, Grant.class);
                type.setGrants(grants);
                this.objectTypeSer.updateObjectType(type);
            }
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/getObjectTypeGrantList", method = RequestMethod.POST)
    @ResponseBody
    public PagerResult<Grant> getObjectTypeGrantList(HttpServletRequest request, @RequestParam("typeNo") Long typeNo, @RequestParam(value = PagerRequest.KEY_PAGE, required = false) int page,
                                                     @RequestParam(value = PagerRequest.KEY_PAGESIZE, required = false) int pagesize) {
        PagerRequest pagerRequest = new PagerRequest(page, pagesize);
        PagerResult<Grant> pagerResult = new PagerResult<Grant>();

        Type type = new Type();
        type.setNo(typeNo);

        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            type.setMetaData(metaData);
            pagerResult.setRows(this.objectTypeSer.getObjectTypeGrantList(type, pagerRequest));
            pagerResult.setTotal(this.objectTypeSer.getObjectTypeGrantListCnt(type));
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return pagerResult;
    }

    @RequestMapping(value = "/updateObjectTypeGrant", method = RequestMethod.POST)
    @ResponseBody
    public RequestResult<String> updateObjectTypeGrant(HttpServletRequest request, ModelMap modelMap) {
        RequestResult<String> result = new RequestResult<String>();
        Type type = new Type();
        try {
            this.objectTypeSer.updateObjectTypeGrant(type);
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    /***************************** ProcessItem *********************************/
    @RequestMapping(value = "/getProcessItemList", method = RequestMethod.POST)
    @ResponseBody
    public PagerResult<ProcessItem> getProcessItemList(HttpServletRequest request, @RequestParam("typeNo") Long typeNo, @RequestParam(value = PagerRequest.KEY_PAGE, required = false) int page,
                                                       @RequestParam(value = PagerRequest.KEY_PAGESIZE, required = false) int pagesize) {
        PagerRequest pagerRequest = new PagerRequest(page, pagesize);
        PagerResult<ProcessItem> result = new PagerResult<ProcessItem>();
        Type type = new Type();
        type.setNo(typeNo);
        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            type.setMetaData(metaData);
            result.setRows(this.objectTypeSer.getProcessItemList(type, pagerRequest));
            result.setTotal(this.objectTypeSer.getProcessItemListCnt(type));
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/transferProcessItem", method = RequestMethod.POST)
    @ResponseBody
    public RequestResult<String> transferProcessItem(HttpServletRequest request, @RequestParam("jsonData") String jsonData) {
        RequestResult<String> result = new RequestResult<String>();

        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            ProcessItem item = ObjectBindUtil.parseRequestJsonDataToObject(jsonData, ProcessItem.class);
            item.setMetaData(metaData);

            if (item.getNo() == null || item.getNo() == 0) {
                this.objectTypeSer.addProcessItem(item);
            } else {
                this.objectTypeSer.updateProcessItem(item);
            }
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/removeProcessItem", method = RequestMethod.POST)
    @ResponseBody
    public RequestResult<String> removeProcessItem(HttpServletRequest request, @RequestParam("processItemNo") Long processItemNo) {
        RequestResult<String> result = new RequestResult<String>();

        ProcessItem item = new ProcessItem();
        item.setNo(processItemNo);
        try {
            MetaData metaData = SessionUtil.generateMetaDataFromSession(request);
            item.setMetaData(metaData);
            this.objectTypeSer.removeProcessItem(item);
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    /*********************** activiti ************************************/
    /**
     * create new empty model
     * @param request
     * @param name
     * @param key
     * @return
     */
    @RequestMapping(value = "/createNewModel", method = RequestMethod.POST)
    @ResponseBody
    public RequestResult<String> createNewModel(HttpServletRequest request, @RequestParam(value = "key", required = false) String key) {
        RequestResult<String> result = new RequestResult<String>();
        try {
            ProcessModel processModel = this.activitiEngineSer.createNewModel();
            processModel.getModel().setKey(key);
            processModel.getModel().setName(key);
            this.activitiEngineSer.saveModel(processModel);
            result.setMessage(processModel.getId());
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    /**
     * 删除模型
     * @param request
     * @param modelId
     * @return
     */
    @RequestMapping(value = "/deleteModel", method = RequestMethod.POST)
    @ResponseBody
    public RequestResult<String> deleteModel(HttpServletRequest request, @RequestParam(value = "modelId") String modelId) {
        RequestResult<String> result = new RequestResult<String>();
        try {
            this.activitiEngineSer.removeModel(modelId);
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    /**
     * 根据Model部署流程
     */
    @ResponseBody
    @RequestMapping(value = "/deployModel", method = RequestMethod.POST)
    public RequestResult<String> deploy(HttpServletRequest request, @RequestParam(value = "modelId") String modelId) {
        RequestResult<String> result = new RequestResult<String>();
        try {
            ProcessModel processModel = this.activitiEngineSer.getProcessModel(modelId);
            this.activitiEngineSer.deployProcessModel(processModel);
        } catch (Exception e) {
            result.setCode(1000);
            result.setMessage(e.getMessage());
        }
        return result;
    }
}
