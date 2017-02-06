package com.siping.mat.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.doc.bean.MetaData;
import com.siping.mat.bean.IdType;
import com.siping.mat.bean.Material;
import com.siping.mat.dao.MatManageDao;
import com.siping.mat.service.MatInfoSer;
import com.siping.mat.service.MatManageSer;
import com.siping.process.bean.ProcessRunning;
import com.siping.process.bean.Type;
import com.siping.process.service.ObjectTypeSer;
import com.siping.process.service.ProcessRunningSer;
import com.siping.system.bean.AdminBean;

@Service
public class MatManageSerImpl implements MatManageSer {

    @Autowired
    private MatManageDao matManageDao;

    @Autowired
    private ObjectTypeSer objectTypeSer;

    @Autowired
    private MatInfoSer matInfoSer;

    @Autowired
    private ProcessRunningSer processRunningSer;

    @Override
    public String addMaterial(Material material) throws Exception {
        Type type = material.getProcessRunning().getType();
        type.setMetaData(material.getMetaData());
        AdminBean admin = material.getMetaData().getCreateUser();

        if (objectTypeSer.getAdminObjectGrant(admin, type).getCreateable()) {
            /**
             * 增加流程记录
             */
            ProcessRunning running = processRunningSer.addProcessRunningInfo(material);
            material.setProcessRunning(running);

            return this.matManageDao.addMaterial(material);
        } else {
            throw new Exception("No right to add <" + type.getName() + "> type of material!");
        }
    }

    @Override
    public void updateMaterial(Material material) throws Exception {
        MetaData metaData = material.getMetaData();

        Material oriMaterial = this.matInfoSer.getMaterialDetail(material);
        oriMaterial.setMetaData(metaData);
        if (!objectTypeSer.isObjectEditable(oriMaterial)) {
            throw new Exception("Current state of material is not editable");
        }

        Type type = material.getProcessRunning().getType();
        type.setMetaData(metaData);
        AdminBean admin = metaData.getLastUpdateUser();

        if (objectTypeSer.getAdminObjectGrant(admin, type).getWriteable()) {
            processRunningSer.updateProcessRunningForBusinessData(material);
            matManageDao.updateMaterialData(material);
        } else {
            throw new Exception("No right to edit <" + type.getName() + "> type of material!");
        }
    }

    /**
     * 移除物料
     */
    @Override
    public void removeMaterial(Material mat) throws Exception {
        Material oriMaterial = this.matInfoSer.getMaterialDetail(mat);
        Type type = oriMaterial.getProcessRunning().getType();
        type.setMetaData(mat.getMetaData());
        AdminBean admin = mat.getMetaData().getLastUpdateUser();

        if (objectTypeSer.getAdminObjectGrant(admin, type).getDeleteable()) {
            mat.setActive(false);
            this.matManageDao.removeMaterial(mat);
        } else {
            throw new Exception("No right to delete type<" + type.getName() + "> of material");
        }
    }

    @Override
    public void generateMatId(IdType idType, Material material) throws Exception {
        String noStr = this.matManageDao.generateMatId();
        String idStr = material.getId();

        switch (idType) {
            case INNER:
                idStr = noStr;
                break;
            case MIX:
                idStr += ("-" + noStr);
                break;
            case OUTER:
                if (idStr == null || idStr.trim().equals("")) {
                    throw new Exception("Wrong param to generate idStr!");
                }
                if (this.matInfoSer.getMaterialDetail(material) != null) {
                    throw new Exception("Duplicated material data!");
                }
                break;
        }
        material.setNo(Long.parseLong(noStr));
        material.setId(idStr);
    }

}
