package com.siping.productStorage.service.impl;

import com.google.common.base.Joiner;
import com.siping.productStorage.dao.StorageManageDao;
import com.siping.productStorage.service.StorageManageSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import javax.servlet.http.HttpServletRequest;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Service
public class StorageManageSerImpl implements StorageManageSer {

    @Autowired
    private StorageManageDao storageManageDao;

    @SuppressWarnings({"rawtypes", "unchecked"})
    @Override
    public String saveStorage(HttpServletRequest request) {
        String returnString;
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("updatedBy", admin.getAdminID());
        paramMap.put("companyID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("storageNo") == null) {
            int temp = 0;
            temp = this.storageManageDao.checkStorageId(paramMap);
            if (temp<=0) {
                paramMap.put("createdBy", admin.getAdminID());
                returnString = this.storageManageDao.addNewStorage(paramMap);
            }else{
                returnString = "该仓库编号已存在";
            }
        } else {
            returnString = this.storageManageDao.updateStorage(paramMap);
        }
        return returnString;
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    @Override
    public List getStorageList(HttpServletRequest request) {
        List returnList;
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        returnList = getStorageListFromDatabase(paramMap);
        return returnList;
    }

    @Override
    public String deleteStorage(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("updatedBy", admin.getAdminID());
        paramMap.put("companyID", admin.getCpnyId());
        paramMap.put("resultMessage","N");

        String resultString = this.storageManageDao.deleteStorage(paramMap);

        if (errorOccurs(resultString)){
            return resultString;
        }
        return paramMap.get("resultMessage").toString();
    }

    private boolean errorOccurs(String resultString) {
        return !resultString.equals("-1");
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public int getStorageCount(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));
        int storageCount = this.storageManageDao.getStorageCount(paramMap);
        return  storageCount;
    }

    private List getStorageListFromDatabase(Map paramMap) {
        List returnList;
        if (isPagingOn(paramMap)) {
            returnList = this.storageManageDao.getStorageList(paramMap, Integer.parseInt((String) paramMap.get("page"))
                    , Integer.parseInt((String) paramMap.get("pagesize")));
        } else {
            returnList = this.storageManageDao.getStorageList(paramMap);
        }

        resolveFullAddr(returnList);

        return returnList;
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    private void resolveFullAddr(List returnList) {
        Iterator iterator = returnList.iterator();
        while (iterator.hasNext()) {
            Map eachStorage = (Map) iterator.next();
            String province = (String) eachStorage.get("PROVINCE");
            String city = (String) eachStorage.get("CITY");
            String county = (String) eachStorage.get("COUNTY");
            String address = (String) eachStorage.get("STORAGEADDR");
            String fullAddr = Joiner.on("").skipNulls().join(province, city, county, address);
            eachStorage.put("FULLADDR", fullAddr);
        }
    }

    private boolean isPagingOn(Map paramMap) {
        return paramMap.get("page") != null && paramMap.get("pagesize") != null;
    }

    /**
     * 获取仓库名称
     */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getStorageName(HttpServletRequest request) {
		List storList = new ArrayList();
		Map paramMap = new LinkedHashMap();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));
        storList = this.storageManageDao.getStorageName(paramMap);
		return storList;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getStorageProList(HttpServletRequest request) {
		List list = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID",admin.getCpnyId());
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			list = this.storageManageDao.getStorageProList(paramMap,
					NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")),Integer.class),
					NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")),Integer.class));
		}
		return list;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public Integer getStorageProListCnt(HttpServletRequest request) {
		int orderCnt = 0;
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID",admin.getCpnyId());
		orderCnt = this.storageManageDao.getStorageProListCnt(paramMap);
		return orderCnt;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String moveStorage(HttpServletRequest request) {
		String result = "Y";
		Map paramMap = ObjectBindUtil.getRequestParamData(request);

        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        result = this.storageManageDao.moveStorage(paramMap);

        return result;
	}

}
