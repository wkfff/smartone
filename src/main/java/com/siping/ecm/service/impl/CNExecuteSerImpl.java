package com.siping.ecm.service.impl;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.doc.dao.DocManageDao;
import com.siping.ecm.dao.CNExecuteDao;
import com.siping.ecm.service.CNExecuteSer;
import com.siping.ecm.util.CNExecuteUtil;
import com.siping.process.dao.ProcessManageDao;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class CNExecuteSerImpl implements CNExecuteSer {

    @Autowired
    private CNExecuteDao cnExecuteDao;

    @Autowired
    private DocManageDao docManageDao;

    @Autowired
    private ProcessManageDao processManageDao;

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String updateECMObject(HttpServletRequest request) throws Exception {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("CREATED_BY", admin.getAdminID());
        return this.prepareForECMObjectUpdate(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    private String prepareForECMObjectUpdate(Map paramMap) throws Exception {
        String objectCategory = paramMap.get("OBJECT_CATEGORY").toString();
        String objectId = null;
        if (this.objectHasBeenUpdated(paramMap)) {
            objectId = paramMap.get("OBJECT_ID").toString();
        } else {
            this.setCNObject2Changed(paramMap);
            paramMap.put("FORMOR_OBJECT_ID", paramMap.get("OBJECT_ID"));
            objectId = this.copyObject(objectCategory, paramMap);
            paramMap.put("AFFIRM_OBJECT", objectCategory);
            paramMap.put("OBJECT_ID", objectId);
            this.overwriteObject(paramMap);
            this.setupObjectApp(paramMap);
        }

        return CNExecuteUtil.getObjectUpdateURL(objectCategory) + objectId + "&CHANGE_NO=" + paramMap.get("CHANGE_NO");
    }

    @SuppressWarnings("rawtypes")
    private void overwriteObject(Map paramMap) throws Exception {
        this.cnExecuteDao.overwriteObject(paramMap);
    }

    private boolean objectHasBeenUpdated(Map paramMap) {
        if (paramMap.get("IS_UPDATED") == null || !paramMap.get("IS_UPDATED").equals("1")) {
            return false;
        } else {
            return true;
        }
    }

    @SuppressWarnings("rawtypes")
    private void setCNObject2Changed(Map paramMap) throws Exception {
        this.cnExecuteDao.setCNObject2Changed(paramMap);
    }

    @SuppressWarnings({ "rawtypes" })
    private String copyObject(String objectCategory, Map paramMap) throws Exception {
        String objId = "";
        if (objectCategory.equals("DOC")) {
            objId = this.docManageDao.copyDocument(paramMap);
        } else {
            objId = paramMap.get("OBJECT_ID").toString();
        }
        return objId;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    private void setupObjectApp(Map paramMap) {
        paramMap.put("affirmList", this.processManageDao.getAffirmorList(paramMap));
        this.processManageDao.addObjectApp(paramMap, true);
    }

}
