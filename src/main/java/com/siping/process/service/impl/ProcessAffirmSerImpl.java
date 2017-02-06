package com.siping.process.service.impl;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.process.dao.ObjectStatusDao;
import com.siping.process.dao.ProcessAffirmDao;
import com.siping.process.service.ProcessAffirmSer;
@Service
public class ProcessAffirmSerImpl implements ProcessAffirmSer{

    @Autowired
    private ProcessAffirmDao processAffirmDao;
    
    @Autowired
    private ObjectStatusDao objectStatusDao;

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public void updateSalesOrderStatusAgree(String processName, String processId) throws Exception {
        Map map = new LinkedHashMap();
        map.put("processInstanceId", processId);
        map.put("processKey", processName);
        processAffirmDao.updateSalesOrderStatusAgree(map);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public void updateSalesOrderStatusVeto(String processName, String processInstanceId) throws Exception {
        Map map = new LinkedHashMap();
        map.put("processInstanceId", processInstanceId);
        map.put("processKey", processName);
        processAffirmDao.updateSalesOrderStatusVeto(map);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public void updatePurchaseOrderStatusAgree(String processName, String processInstanceId) throws Exception {
        Map map = new LinkedHashMap();
        map.put("processInstanceId", processInstanceId);
        map.put("processKey", processName);
        processAffirmDao.updatePurchaseOrderStatusAgree(map);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public void updatePurchaseOrderStatusVeto(String processName, String processInstanceId) throws Exception {
        Map map = new LinkedHashMap();
        map.put("processInstanceId", processInstanceId);
        map.put("processKey", processName);
        processAffirmDao.updatePurchaseOrderStatusVeto(map);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public void updateHrApplicationAgree(String processName, String processInstanceId) throws Exception {
        Map map = new LinkedHashMap();
        map.put("processInstanceId", processInstanceId);
        map.put("processKey", processName);
        processAffirmDao.updateHrApplicationAgree(map);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public void updateHrApplicationVeto(String processName, String processInstanceId) throws Exception {
        Map map = new LinkedHashMap();
        map.put("processInstanceId", processInstanceId);
        map.put("processKey", processName);
        processAffirmDao.updateHrApplicationVeto(map);
    }

	@Override
	public int getHrApplicationStatus(String empId) throws Exception {
		// TODO Auto-generated method stub
		int status = 3;
		HashMap map = new HashMap();
        map.put("empId", empId);
//        map.put("processKey", processName);
//		0审核中1审核通过2审核拒绝3未审核
		status = objectStatusDao.getHrApplicationStatus(map);
		
		return status;
	}
}
