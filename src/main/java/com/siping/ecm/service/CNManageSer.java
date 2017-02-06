package com.siping.ecm.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.siping.doc.bean.BusinessData;
import com.siping.ecm.bean.EngineerChange;
import com.siping.mat.bean.IdType;

public interface CNManageSer {

    public void generateEcnId(EngineerChange ecn, IdType idType) throws Exception;

    public String addChangeNo(EngineerChange ecn) throws Exception;

    public void updateChangeNo(EngineerChange ecn) throws Exception;

    public void removeChangeNo(EngineerChange ecn) throws Exception;

    public void addObjects(List<BusinessData> objects, EngineerChange ecn) throws Exception;

    public void deleteObjects(List<BusinessData> addList, EngineerChange ecn) throws Exception;

    public String addObject(HttpServletRequest request);

}
