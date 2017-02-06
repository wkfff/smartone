package com.siping.hrm.service.impl;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.hrm.dao.HrmDao;
import com.siping.hrm.service.HrmSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class HrmSerImpl implements HrmSer {
    Logger logger = Logger.getLogger(HrmSerImpl.class);

    @Autowired
    private HrmDao hrmDao;

    public Object getDeptById(Object object) {
        return hrmDao.getDeptById(object);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getDeptTree(HttpServletRequest request, String limit) {
        List list = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("adminID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        if (limit.equals("hr")) {
            list = hrmDao.getDeptTree("hrm.getDeptTreeForHr", paramMap);
        } else if (limit.equals("ar")) {
            list = hrmDao.getDeptTree("hrm.getDeptTreeForAr", paramMap);
        } else if (limit.equals("all")) {
            list = hrmDao.getDeptTree("hrm.getDeptTreeForAll", paramMap);
        }
        return list;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getAllDept(Object object) {
        return hrmDao.getDeptTree("hrm.getAllDept", object);
    }
    
    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getAllConPer() {
        return hrmDao.getAllConPer("hrm.getAllConPer");
    }

}
