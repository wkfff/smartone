package com.siping.process.dao.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import com.siping.process.dao.ProcessAffirmDao;
import com.siping.web.utility.SqlMapClientSupport;
@Repository
public class ProcessAffirmDaoImpl extends SqlMapClientSupport implements ProcessAffirmDao{

    private static final String UPDATE_SALES_ORDER_STATUS_AGREE = "process.processAffirm.updateSalesOrderStatusAgree";
    private static final String UPDATE_SALES_ORDER_STATUS_VETO = "process.processAffirm.updateSalesOrderStatusVeto";
    private static final String UPDATE_PURCHASE_ORDER_STATUS_AGREE = "process.processAffirm.updatePurchaseOrderStatusAgree";
    private static final String UPDATE_PURCHASE_ORDER_STATUS_VETO = "process.processAffirm.updatePurchaseOrderStatusVeto";
    private static final String UPDATE_HR_APPLICATION_AGREE = "process.processAffirm.updateHrApplicationAgree";
    private static final String UPDATE_HR_APPLICATION_VETO = "process.processAffirm.updateHrApplicationVeto";
//    private static final String GET_HR_APPLICATION_STATUS = "process.objectStatus.getHrApplicationStatus";

    @SuppressWarnings("rawtypes")
    @Override
    public void updateSalesOrderStatusAgree(Map map) throws Exception {
        this.update(UPDATE_SALES_ORDER_STATUS_AGREE, map);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public void updateSalesOrderStatusVeto(Map map) throws Exception {
        this.update(UPDATE_SALES_ORDER_STATUS_VETO, map);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public void updatePurchaseOrderStatusAgree(Map map) throws Exception {
        this.update(UPDATE_PURCHASE_ORDER_STATUS_AGREE, map);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public void updatePurchaseOrderStatusVeto(Map map) throws Exception {
        this.update(UPDATE_PURCHASE_ORDER_STATUS_VETO, map);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public void updateHrApplicationAgree(Map map) throws Exception {
        this.update(UPDATE_HR_APPLICATION_AGREE, map);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public void updateHrApplicationVeto(Map map) throws Exception {
        this.update(UPDATE_HR_APPLICATION_VETO, map);
    }

//	@Override
//	public int getHrApplicationStatus(Map map) throws Exception {
//		// TODO Auto-generated method stub
//		return 0;
//	}
}
