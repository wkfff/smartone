package com.siping.bom.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.bom.bean.Bom;
import com.siping.bom.bean.BomItem;
import com.siping.bom.dao.BOMManageDao;
import com.siping.bom.service.BOMInfoSer;
import com.siping.bom.service.BOMManageSer;
import com.siping.doc.bean.MetaData;
import com.siping.ecm.bean.EngineerChange;
import com.siping.process.bean.Type;
import com.siping.process.service.ObjectTypeSer;
import com.siping.process.service.ProcessRunningSer;
import com.siping.system.bean.AdminBean;

@Service
public class BOMManageSerImpl implements BOMManageSer {

    Logger logger = Logger.getLogger(BOMManageSer.class);

    @Autowired
    private BOMManageDao bomManageDao;

    @Autowired
    private ObjectTypeSer objectTypeSer;

    @Autowired
    private BOMInfoSer bomInfoSer;

    @Autowired
    private ProcessRunningSer processRunningSer;

    @Override
    public String addBOM(Bom bom) throws Exception {
        Type type = bom.getProcessRunning().getType();
        type.setMetaData(bom.getMetaData());
        AdminBean user = bom.getMetaData().getCreateUser();

        if (objectTypeSer.getAdminObjectGrant(user, type).getCreateable()) {
            this.generateBomId(bom);
            this.processRunningSer.addProcessRunningInfo(bom);
            this.bomManageDao.addBOM(bom);
            return bom.getNo().toString();
        } else {
            throw new Exception("No right to create this type of bom");
        }
    }

    @Override
    public void updateBOM(Bom bom) throws Exception {
        Type type = bom.getProcessRunning().getType();
        type.setMetaData(bom.getMetaData());
        AdminBean user = bom.getMetaData().getCreateUser();

        if (this.objectTypeSer.getAdminObjectGrant(user, type).getWriteable()) {
            if (this.objectTypeSer.isObjectEditable(bom)) {
                this.processRunningSer.updateProcessRunningForBusinessData(bom);
                bomManageDao.updateBOMData(bom);
            } else {
                throw new Exception("Current state of bom is not editable");
            }
        } else {
            throw new Exception("No right to update bom data");
        }
    }

    @Override
    public void removeBOM(Bom bom) throws Exception {
        MetaData metaDate = bom.getMetaData();
        Bom oriBom = this.bomInfoSer.getBOMDetail(bom);

        Type type = oriBom.getProcessRunning().getType();
        type.setMetaData(metaDate);
        AdminBean user = metaDate.getCreateUser();

        if (objectTypeSer.getAdminObjectGrant(user, type).getDeleteable()) {
            bom.setActive(false);
            this.bomManageDao.removeBOM(bom);
        } else {
            throw new Exception("No right to delete bom data");
        }
    }

    @Override
    public void transferBOMItems(List<BomItem> bomItems, Bom bom, EngineerChange ecn) throws Exception {
        MetaData metaData = bom.getMetaData();

        bom = this.bomInfoSer.getBOMDetail(bom);
        bom.setMetaData(metaData);

        Type type = bom.getProcessRunning().getType();
        type.setMetaData(metaData);
        AdminBean user = metaData.getCreateUser();

        if (this.objectTypeSer.getAdminObjectGrant(user, type).getWriteable()) {
            if (this.objectTypeSer.isObjectEditable(bom)) {
                List<BomItem> insertList = new ArrayList<BomItem>();
                List<BomItem> updateList = new ArrayList<BomItem>();

                for (BomItem bomItem : bomItems) {
                    if (bomItem.getNo() == null || bomItem.getNo() == 0L) {
                        insertList.add(bomItem);
                        bomItem.setBom(bom);
                    } else {
                        updateList.add(bomItem);
                    }
                    bomItem.setMetaData(metaData);
                }

                if (insertList.size() > 0) {
                    this.addBOMItems(insertList);
                }
                if (updateList.size() > 0) {
                    this.updateBOMItems(updateList);
                }
            } else {
                throw new Exception("current state of bom is not editable");
            }
        } else {
            throw new Exception("No right to edit bom data");
        }
    }

    private void addBOMItems(List<BomItem> insertList) throws Exception {
        this.bomManageDao.addBOMItems(insertList);
    }

    public void updateBOMItems(List<BomItem> updateList) throws Exception {
        this.bomManageDao.updateBOMItems(updateList);
    }

    public void deleteBOMItem(BomItem busiData, Bom bom) throws java.lang.Exception {
        Type type = bom.getProcessRunning().getType();
        AdminBean user = bom.getMetaData().getCreateUser();

        if (objectTypeSer.getAdminObjectGrant(user, type).getWriteable()) {
            if (this.objectTypeSer.isObjectEditable(bom)) {
                this.bomManageDao.deleteBOMItem(busiData);
            } else {
                throw new Exception("Current state of bom is not editable");
            }
        } else {
            throw new Exception("No right to update bom data!");
        }
    }

    @Override
    public void generateBomId(Bom bom) throws Exception {
        String bomNo = this.bomManageDao.generateBomNo();
        bom.setId(bomNo);
        bom.setNo(Long.parseLong(bomNo));
    }

}
