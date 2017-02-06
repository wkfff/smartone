package com.siping.process.service.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.doc.bean.BusinessData;
import com.siping.doc.bean.MetaData;
import com.siping.process.bean.Grant;
import com.siping.process.bean.PagerRequest;
import com.siping.process.bean.ProcessItem;
import com.siping.process.bean.ProcessModel;
import com.siping.process.bean.ProcessRunning;
import com.siping.process.bean.State;
import com.siping.process.bean.Type;
import com.siping.process.dao.ObjectTypeDao;
import com.siping.process.service.ActivitiEngineSer;
import com.siping.process.service.ObjectTypeSer;
import com.siping.process.service.ProcessRunningSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.dao.UtilityOtherInfoDao;

@Service
public class ObjectTypeSerImpl implements ObjectTypeSer {
    Logger logger = Logger.getLogger(ObjectTypeSer.class);

    @Autowired
    private ObjectTypeDao objectTypeDao;

    @Autowired
    private UtilityOtherInfoDao utilityOtherInfoDao;

    @Autowired
    private ActivitiEngineSer activitiEngineSer;

    @Autowired
    private ProcessRunningSer processRunningSer;

    @Override
    public List<Type> getObjectTypeList(HashMap<String, Object> params) throws Exception {
        return this.objectTypeDao.getObjectTypeList(params);
    }

    @Override
    public int getObjectTypeListCnt(HashMap<String, Object> params, AdminBean user) throws Exception {
        return this.objectTypeDao.getObjectTypeListCnt(params);
    }

    @Override
    public List<Grant> getObjectTypeGrantList(Type type, PagerRequest pagerRequest) throws Exception {
        return this.objectTypeDao.getObjectTypeGrantList(type, pagerRequest);
    }

    @Override
    public int getObjectTypeGrantListCnt(Type type) throws Exception {
        return this.objectTypeDao.getObjectTypeGrantListCnt(type);
    }

    /**
     * 添加角色信息
     * @param type
     * @return
     */
    public String addObjectType(Type type) throws Exception {
        return this.objectTypeDao.addObjectType(type);
    }

    /**
     * 修改文档类型信息
     * @param type
     */
    public void updateObjectType(Type type) throws Exception {
        this.objectTypeDao.updateObjectType(type);
    }

    /**
     * 删除角色信息
     * @param type
     */
    public void deleteObjectType(Type type) throws Exception {
        objectTypeDao.deleteObjectType(type);
    }

    @Override
    public Type getObjectTypeDetail(Type type) throws Exception {
        return this.objectTypeDao.getObjectTypeDetail(type);
    }

    @Override
    public void transferObjectType(Type type) throws Exception {
        try {
            if (type.getNo() == null || type.getNo() == 0) {
                objectTypeDao.addObjectType(type);
            } else {
                objectTypeDao.updateObjectType(type);
            }
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public void updateObjectTypeGrant(Type type) throws Exception {
        objectTypeDao.updateObjectTypeGrant(type);
    }

    @Override
    public List<ProcessItem> getProcessItemList(Type type, PagerRequest pagerRequest) throws Exception {
        return this.objectTypeDao.getProcessItemList(type, pagerRequest);
    }

    @Override
    public int getProcessItemListCnt(Type type) throws Exception {
        return this.objectTypeDao.getProcessItemListCnt(type);
    }

    @Override
    public String addProcessItem(ProcessItem item) throws Exception {
        deployProcessModel(item);
        return objectTypeDao.addProcessItem(item);
    }

    @Override
    public void updateProcessItem(ProcessItem item) throws Exception {
        deployProcessModel(item);
        objectTypeDao.updateProcessItem(item);
    }

    /**
     * 如果模型存在则部署，并添加到item的信息中
     */
    private void deployProcessModel(ProcessItem item) throws Exception{
        ProcessModel processModel = item.getProcessModel();
        if (item.getProcessModel() != null && item.getProcessModel().getId() != null && !processModel.getId().trim().equals("")) {
            String modeld = item.getProcessModel().getId();
            processModel = this.activitiEngineSer.getProcessModel(modeld);
            String processId = this.activitiEngineSer.deployProcessModel(processModel);
            processModel.setProcessKey(processId);
            item.setProcessModel(processModel);
        }else {
            processModel = new ProcessModel();
        }
        item.setProcessModel(processModel);
    }

    @Override
    public ProcessItem getProcessItemDetail(ProcessItem item) throws Exception {
        return objectTypeDao.getProcessItemDetail(item);
    }

    @Override
    public void removeProcessItem(ProcessItem item) throws Exception {
        objectTypeDao.removeProcessItem(item);
    }

    /**
     * 根据ADMINID和OBJECT_TYPE_ID获取文档权限 分别为 SELECTR（访问）1 or 0 UPDATER（修改）1 or 0
     * CREATER（访问）1 or 0 和 DELETER（修改）1 or 0
     */
    @Override
    public Grant getAdminObjectGrant(AdminBean admin, Type type) {
        Grant returnGrant = new Grant();
        String[] grantIds = admin.getScreenGrantID().split(",");
        try {
            List<Grant> grantsOfType = this.objectTypeDao.getObjectTypeGrantList(type, null);
            for (Grant oneGrant : grantsOfType) {
                for (String grantId : grantIds) {
                    if (oneGrant.getRole().getNo().toString().equals(grantId)) {
                        returnGrant.setReadable(oneGrant.getReadable() ? true : returnGrant.getReadable());
                        returnGrant.setWriteable(oneGrant.getWriteable() ? true : returnGrant.getWriteable());
                        returnGrant.setCreateable(oneGrant.getCreateable() ? true : returnGrant.getCreateable());
                        returnGrant.setDeleteable(oneGrant.getDeleteable() ? true : returnGrant.getDeleteable());
                    }
                }
            }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return returnGrant;
    }

    @Override
    public boolean isObjectEditable(BusinessData businessData) throws Exception {
        Type type = businessData.getProcessRunning().getType();
        State state = businessData.getProcessRunning().getState();
        MetaData metaData = businessData.getMetaData();
        if (type == null || state == null || metaData == null) {
            throw new Exception("Business info is not enought to save!");
        }

        ProcessItem item = new ProcessItem();
        item.setMetaData(metaData);
        item.setState(state);
        item.setType(type);
        item = this.getProcessItemDetail(item);

        if (item.getProcessModel() == null || item.getProcessModel().getProcessKey() == null) {
            return true;
        } else {
            /**
             * 如果有审批流程，则一定要有结果
             */
            ProcessRunning running = this.processRunningSer.getProcessRunningInfo(businessData);
            return (running.getResult() != null);
        }
    }

}
