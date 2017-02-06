package com.siping.ecm.service.impl;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.doc.bean.BusinessData;
import com.siping.doc.bean.MetaData;
import com.siping.ecm.bean.EngineerChange;
import com.siping.ecm.dao.CNManageDao;
import com.siping.ecm.service.CNInfoSer;
import com.siping.ecm.service.CNManageSer;
import com.siping.mat.bean.IdType;
import com.siping.process.bean.Type;
import com.siping.process.dao.ObjectTypeDao;
import com.siping.process.service.ObjectTypeSer;
import com.siping.process.service.ProcessRunningSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class CNManageSerImpl implements CNManageSer {

    @Autowired
    private CNManageDao cnManageDao;

    @Autowired
    private ObjectTypeSer objectTypeSer;

    @Autowired
    private CNInfoSer cnInfoSer;

    @Autowired
    private ProcessRunningSer processRunningSer;

    @Autowired
    private ObjectTypeDao objectTypeDao;

    @Override
    public void generateEcnId(EngineerChange ecn, IdType idType) throws Exception {
        String noStr = this.cnManageDao.generateEcnNo();
        String idStr = ecn.getId()==null?"":ecn.getId();

        switch(idType){
            case INNER:
                idStr = noStr;
                break;
            case MIX:
                idStr += ("-"+noStr);
                break;
            case OUTER:
                if(idStr.trim().equals("")){
                    throw new Exception("Empty id value is not allowed!");
                }
                if(cnInfoSer.getChangeNoDetail(ecn) != null){
                    throw new Exception("Id exist in database!");
                }
                break;
        }
        ecn.setNo(Long.parseLong(noStr));
        ecn.setId(idStr);
    }
    @Override
    public String addChangeNo(EngineerChange ecn) throws Exception {
        MetaData metaData = ecn.getMetaData();

        Type type = ecn.getProcessRunning().getType();
        type.setMetaData(metaData);
        AdminBean user = metaData.getCreateUser();

        if (objectTypeSer.getAdminObjectGrant(user, type).getCreateable()) {
            this.processRunningSer.addProcessRunningInfo(ecn);
            this.cnManageDao.addChangeNo(ecn);
            return ecn.getNo().toString();
        } else {
            throw new Exception("No right to create this type of changeNo!");
        }
    }

    @Override
    public void updateChangeNo(EngineerChange ecn) throws Exception {
        MetaData metaData = ecn.getMetaData();

        EngineerChange oriEcn = this.cnInfoSer.getChangeNoDetail(ecn);
        oriEcn.setMetaData(metaData);
        if(!objectTypeSer.isObjectEditable(oriEcn)){
            throw new Exception("Current state of changeNo is not editable!");
        }

        Type type = ecn.getProcessRunning().getType();
        type.setMetaData(metaData);
        AdminBean user = metaData.getCreateUser();

        if (objectTypeSer.getAdminObjectGrant(user, type).getWriteable()) {
            this.processRunningSer.updateProcessRunningForBusinessData(ecn);
            this.cnManageDao.updateChangeNoData(ecn);
        } else {
            throw new Exception("No right to edit changeNo data");
        }
    }

    /**
     * 移除变更号
     */
    @Override
    public void removeChangeNo(EngineerChange ecn) throws Exception {
        MetaData metaData = ecn.getMetaData();
        EngineerChange oriEcn = this.cnInfoSer.getChangeNoDetail(ecn);

        Type type = oriEcn.getProcessRunning().getType();
        type.setMetaData(metaData);
        AdminBean user = metaData.getCreateUser();

        if (objectTypeSer.getAdminObjectGrant(user, type).getDeleteable()) {
            ecn.setActive(false);
            this.cnManageDao.removeChangeNo(ecn);
        } else {
            throw new Exception("No right remove changeNo data!");
        }
    }

    @Override
    public void addObjects(List<BusinessData> addList, EngineerChange ecn) throws Exception {
        MetaData metaData = ecn.getMetaData();
        EngineerChange oriEcn = this.cnInfoSer.getChangeNoDetail(ecn);

        oriEcn.setMetaData(metaData);
        if(!objectTypeSer.isObjectEditable(oriEcn)){
            throw new Exception("Current state of changeNo is not editable!");
        }

        Type type = oriEcn.getProcessRunning().getType();
        type.setMetaData(metaData);
        AdminBean user = metaData.getCreateUser();

        if (objectTypeSer.getAdminObjectGrant(user, type).getWriteable()) {
            this.cnManageDao.addObjects(addList);
        } else {
            throw new Exception("No right to edit changeNo data");
        }
    }

    @Override
    public void deleteObjects(List<BusinessData> deleteList, EngineerChange ecn) throws Exception {
        MetaData metaData = ecn.getMetaData();
        EngineerChange oriEcn = this.cnInfoSer.getChangeNoDetail(ecn);

        oriEcn.setMetaData(metaData);
        if(objectTypeSer.isObjectEditable(oriEcn)){
            throw new Exception("Current state of changeNo is not editable!");
        }

        Type type = oriEcn.getProcessRunning().getType();
        type.setMetaData(metaData);
        AdminBean user = metaData.getCreateUser();

        if (objectTypeSer.getAdminObjectGrant(user, type).getWriteable()) {
                this.cnManageDao.deleteObjects(deleteList);
        } else {
            throw new Exception("No right to edit changeNo data");
        }
    }


    @Override
    public String addObject(HttpServletRequest request) {
        String resultStr = "Y";
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        try {
            this.cnManageDao.addObject(paramMap);
        } catch (Exception e) {
            e.printStackTrace();
            resultStr = e.getMessage();
        }
        return resultStr;
    }
}
