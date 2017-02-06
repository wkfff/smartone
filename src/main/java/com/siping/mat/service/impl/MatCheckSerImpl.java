package com.siping.mat.service.impl;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.mat.dao.MatCheckDao;
import com.siping.mat.service.MatCheckSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class MatCheckSerImpl implements MatCheckSer {

    @Autowired
    private MatCheckDao matCheckDao;

    /**
     * 检查是否重复
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String checkDuplicate(HttpServletRequest request) {
        String returnString = "";
        int result = -1;
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        try {
            if (paramMap.get("type").equals("materialID")) {
                result = this.matCheckDao.checkMaterialID(paramMap);
            } else if (paramMap.get("type").equals("materialName")) {
                result = this.matCheckDao.checkMaterialName(paramMap);
            } else if (paramMap.get("type").equals("storageID")) {
                result = this.matCheckDao.checkStorageID(paramMap);
            } else if (paramMap.get("type").equals("storageName")) {
                result = this.matCheckDao.checkStorageName(paramMap);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (result == 0) {
            returnString = "<font color=\"green\">可用</font>";
        } else {
            returnString = "<font color=\"red\">不可用</font>";
        }

        return returnString;
    }
}
