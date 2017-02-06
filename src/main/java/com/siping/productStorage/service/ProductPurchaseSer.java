package com.siping.productStorage.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ProductPurchaseSer {
	@SuppressWarnings("rawtypes")
	public List getSupplier(HttpServletRequest request);
	@SuppressWarnings("rawtypes")
	public List getSupplierProduct(HttpServletRequest request);
	public String addPurchaseOrder(HttpServletRequest request) throws Exception;
	@SuppressWarnings("rawtypes")
	public List getPurchaseOrderList(HttpServletRequest request);
	@SuppressWarnings("rawtypes")
	public Map getPurchaseOrder(HttpServletRequest request);
	public int getPurchaseOrderCnt(HttpServletRequest request) ;
	@SuppressWarnings("rawtypes")
	public List getPurchaseOrderDetailList(HttpServletRequest request);
	public int getPurchaseOrderDetailCnt(HttpServletRequest request) ;
	public String deletePurchaseOrder(HttpServletRequest request);
	public String updatePurchaseOrder(HttpServletRequest request) throws Exception;
	public String deletePurchaseOrderDetail(HttpServletRequest request);
    public String purchaseOrderToExcel(HttpServletRequest request, HttpServletResponse response);
}
