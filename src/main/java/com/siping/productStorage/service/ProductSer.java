package com.siping.productStorage.service;

import com.siping.productStorage.bean.Product;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

public interface ProductSer {
    @SuppressWarnings({"rawtypes"})
    public List getProductList(HttpServletRequest request);

    public int getProductListCnt(HttpServletRequest request);

    public String addOrUpdateProduct(HttpServletRequest request);

    @SuppressWarnings("rawtypes")
    public List getProColumns(HttpServletRequest request);

    public int checkProductId(HttpServletRequest request);

    public String deleteProduct(HttpServletRequest request);

    @SuppressWarnings({"rawtypes"})
    public List getProductSymple(HttpServletRequest request);

    @SuppressWarnings({"rawtypes"})
    public List getProductByOrder(HttpServletRequest request);

    @SuppressWarnings({"rawtypes"})
    public Map getProStorageSaleDetail(HttpServletRequest request);

    @SuppressWarnings({"rawtypes"})
    public List getProStorDetailList(HttpServletRequest request);

    public int getProStorDetailListCnt(HttpServletRequest request);

    @SuppressWarnings({"rawtypes"})
    public List getProSaleDetailList(HttpServletRequest request);

    public int getProSaleDetailListCnt(HttpServletRequest request);

    public void viewProductReport(HttpServletRequest request, HttpServletResponse response);

    List<Product> getProductsBySalesMode(HttpServletRequest request);

    void downloadProductsTemp(HttpServletRequest request, HttpServletResponse response);

    public String uploadProInfoTemplate(MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws Exception;

    @SuppressWarnings("rawtypes")
    public List getProColumnList() throws Exception;

    @SuppressWarnings("rawtypes")
    public List getProTmpInfoList() throws Exception;

    public String saveProTmpInfo(HttpServletRequest request) throws Exception;
}
