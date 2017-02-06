package com.siping.system.service;


import com.siping.system.bean.License;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface LicenseSer {
    public License getCurrentLicense();

    public List<License> getLicenseList(HttpServletRequest request);
    
    public int getLicenseListCnt(HttpServletRequest request);
    
    public int getLicenseCnt(License license) throws Exception; 
    
    public String addOrUpdateLicense(License license) throws Exception;
    
    public String addLicense(License license) throws Exception;
    
    public String updateLicense(License license) throws Exception ;
}
