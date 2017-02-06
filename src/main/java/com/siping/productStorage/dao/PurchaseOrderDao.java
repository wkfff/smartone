package com.siping.productStorage.dao;

import java.util.List;
import java.util.Map;

public interface PurchaseOrderDao {
	@SuppressWarnings("rawtypes")
	public List getSupplier(Object object);
	@SuppressWarnings("rawtypes")
	public List getSupplierProduct(Object object);
	public String getPurchaseSerialNum(Object obj);
	public String getPurchaseOrderId(Object obj);
	public String addPurchaseOrder(Object object) throws Exception;
	@SuppressWarnings("rawtypes")
	public String addPurchaseOrderDetail(List objList) throws Exception;
	@SuppressWarnings({ "rawtypes" })
	public List getPurchaseOrderList(Object object, int currentPage,int pageSize);
	@SuppressWarnings({ "rawtypes" })
	public List getPurchaseOrderList(Object object); 
	@SuppressWarnings("rawtypes")
	public Map getPurchaseOrder(Object object);
	public int getPurchaseOrderCnt(Object object);
	@SuppressWarnings({ "rawtypes" })
	public List getPurchaseOrderDetailList(Object object, int currentPage,int pageSize);
	@SuppressWarnings({ "rawtypes" })
	public List getPurchaseOrderDetailList(Object object); 
	public int getPurchaseOrderDetailCnt(Object object);
	public String deletePurchaseOrder(Object object) ;
	public String updatePurchaseOrder(Object object) throws Exception;
	@SuppressWarnings("rawtypes")
	public String updatePurchaseOrderDetail(List objList);
	public String deletePurchaseOrderDetail(Object object) ;
}
