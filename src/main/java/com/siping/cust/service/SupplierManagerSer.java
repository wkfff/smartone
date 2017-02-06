package com.siping.cust.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

public interface SupplierManagerSer {

    public String addOrUpdateSupplierModel(HttpServletRequest request);

    public List getSupplierModelList(HttpServletRequest request);

    public String deleteSupplierModel(HttpServletRequest request);

    public int getSupplierModelCnt(HttpServletRequest request);

    public Object getSupplierDetatil(HttpServletRequest request);

    // 获取供应商的商品数量
    public int getSupplierProductCountCnt(HttpServletRequest request);

    // 供应商修改自己的信息
    public String updateSupplierBySupplier(HttpServletRequest request);

    public void downloadSupperliersTemp(HttpServletRequest request, HttpServletResponse response);

    public String uploadSupplierInfoTemplate(MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws Exception;

    @SuppressWarnings("rawtypes")
    public List getSupplierColumnList() throws Exception;

    @SuppressWarnings("rawtypes")
    public List getSupplierTmpList() throws Exception;

    public String saveSupplierTmpInfo(HttpServletRequest request) throws Exception;
}
