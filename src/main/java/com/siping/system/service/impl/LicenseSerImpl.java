package com.siping.system.service.impl;

import com.siping.system.bean.License;
import com.siping.system.dao.LicenseDao;
import com.siping.system.service.LicenseSer;
import com.siping.web.utility.ObjectBindUtil;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

@Service
public class LicenseSerImpl implements LicenseSer {
    @Autowired
    LicenseDao licenseDao;
    @Override
    public License getCurrentLicense() {
        return licenseDao.getCurrentLicense();
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List<License> getLicenseList(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        return licenseDao.getLicenseList(paramMap);
    }
    
    @SuppressWarnings("rawtypes")
    @Override
    public int getLicenseListCnt(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        return licenseDao.getLicenseListCnt(paramMap);
    }

    @Override
    public String addOrUpdateLicense(License license) throws Exception {
        
        licenseDao.addOrUpdateLicense(license);
        
        if(license.getLicenseId() != null && !"".equals(license.getLicenseId())){
            return "Y";
        }
        return "激活码验证通过，但由于网络原因未能激活，请重试";
    }

    /**
     * 新添加的lecense
     */
	@Override
	public String addLicense(License license) throws Exception {
		// TODO Auto-generated method stub
		licenseDao.addLicense(license);
        return "Y";
	}
	@Override
	public int getLicenseCnt(License license) throws Exception {
		// TODO Auto-generated method stub
		return licenseDao.getLicenseCnt(license);
	}
	/**
	 * 更新已有lecense
	 */
	@Override
	public String updateLicense(License license) throws Exception {
		licenseDao.updateLicense(license);
	    return "Y";
	}
}
