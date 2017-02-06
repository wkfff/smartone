package com.siping.system.service;

import javax.jws.WebMethod;
import javax.jws.WebParam;
import javax.jws.WebService;

import com.siping.system.bean.License;

@WebService(targetNamespace="siping.license.webservice")
public interface LicenseWebSer{
    @WebMethod(operationName = "checkLicenseByNet")
    public License checkLicenseByNet(@WebParam(name = "license") License license);
    
    @WebMethod(operationName = "updateLicenseStatus")
    public void updateLicenseStatusByKey(License license);
}