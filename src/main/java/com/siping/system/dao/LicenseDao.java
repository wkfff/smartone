package com.siping.system.dao;


import com.siping.system.bean.License;

import java.util.List;

public interface LicenseDao {
    public License getCurrentLicense();

    public List<License> getLicenseList(Object obj);
    
    public int getLicenseListCnt(Object obj);
    
    public int getLicenseCnt(Object obj) throws Exception;
    
    public void addOrUpdateLicense(Object obj) throws Exception;
    
    public void addLicense(Object obj) throws Exception;
    
    public void updateLicense(Object obj) throws Exception;
}
