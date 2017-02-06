package com.siping.cust.service.impl;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.cust.bean.Action;
import com.siping.cust.dao.CustActionDao;
import com.siping.cust.service.CustActionSer;
import com.siping.cust.service.SalesSettingSer;
import com.siping.productStorage.bean.SYCode;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;


@Service
public class CustActionSerImpl implements CustActionSer {
	Logger logger = Logger.getLogger(CustActionSer.class);
	@Autowired
	private CustActionDao custActionDao;
	
	@Autowired
	private SalesSettingSer salesSettingSer;
	
	@SuppressWarnings({ "rawtypes", "unchecked"})
	@Override
	public List getCustomerActionList(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("ADMIN_ID", admin.getAdminID());
		paramMap.put("isSupervisor", salesSettingSer.isSupervisor(request));
        paramMap.put("language", Messages.getLanguage(request));
		List result = new ArrayList();
		if(paramMap.get("qryType") == null){
			result = this.custActionDao.getCustomerActionList(paramMap);
		}
		else if(paramMap.get("qryType").equals("simple")){
			result = this.custActionDao.getSimpleCustomerActionList(paramMap);
		}
		return result;
		
	}

	@SuppressWarnings({"rawtypes", "unchecked" })
	@Override
	public int getCustomerActionListCnt(HttpServletRequest request) {
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("ADMIN_ID", admin.getAdminID());
		paramMap.put("isSupervisor", salesSettingSer.isSupervisor(request));
		int result = 0;
		if(paramMap.get("qryType") == null){
			result = this.custActionDao.getCustomerActionListCnt(paramMap);
		}
		else if(paramMap.get("qryType").equals("simple")){
			result = this.custActionDao.getSimpleCustomerActionListCnt(paramMap);
		}
		return result;
	}
	
	@Override
	public void transferCustomerAction(HttpServletRequest request) throws SQLException{
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("UPDATED_BY", admin.getAdminID());
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
				.getRequestJsonData(jsonString, "add", appendMap);
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString, "update", appendMap);
		if (insertList.size() > 0) {
			this.custActionDao.addCustomerAction(insertList);
		}
		if (updateList.size() > 0) {
			this.custActionDao.updateCustomerAction(updateList);
		}
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public void addCustomerAction(HttpServletRequest request) throws SQLException{
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CREATED_BY", admin.getAdminID());
		this.custActionDao.addCustomerAction(paramMap);
		
	}
	
	@SuppressWarnings({"rawtypes","unchecked"})
	@Override
	public String removeCustomerAction(HttpServletRequest request) throws SQLException {
		String resultStr = "Y";
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("UPDATED_BY", admin.getAdminID());
		this.custActionDao.removeCustomerAction(paramMap);
		return resultStr;
	}

    @Override
    public void saveAction(Action action) throws SQLException {
        this.custActionDao.saveAction(action);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List<Action> getActionByCustId(HttpServletRequest request)
            throws SQLException {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        List<Action> actionList=this.custActionDao.getActionByCustId(paramMap);
        return actionList;
    }

    @Override
    public void updateActon(Action action) throws SQLException {
        this.custActionDao.updateAction(action);
    }

    @Override
    public void deleteAction(String custActionNo) throws SQLException {
        this.custActionDao.deleteAction(custActionNo);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public void changeActionState(HttpServletRequest request)
            throws SQLException {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        Action action=new Action();
        action.setCustActionNo((String) paramMap.get("custActionNo"));
        SYCode syCode=new SYCode();
        syCode.setCodeId((String) paramMap.get("actionState"));
        action.setActionState(syCode);
        this.custActionDao.changeActionState(action);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int getCountByCustId(HttpServletRequest request) throws SQLException {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        return this.custActionDao.getCountByCustId(paramMap);
    }

    @SuppressWarnings({  "rawtypes" })
    @Override
    public List<Action> getCustActionByCondition(HttpServletRequest request)
            throws SQLException, ParseException {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        return this.custActionDao.getCustActionByCondition(paramMap);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public Action getActionById(HttpServletRequest request) throws SQLException {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        Action action=this.custActionDao.getActionById(Integer.valueOf((String) paramMap.get("custActionNo")));
        return action;
    }
}
