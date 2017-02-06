package com.siping.web.utility.bean;

import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

public class ParamTransferListBean {

	private List<LinkedHashMap<String, Object>> insertList;
	
	private List<LinkedHashMap<String, Object>> updateList;
	
	private String jsonString ;
	
	private LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
	
	public ParamTransferListBean(HttpServletRequest request){
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("UPDATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());
		jsonString = request.getParameter("jsonData");
	}
	
	public void generateList(){ 		
		setInsertList(ObjectBindUtil
				.getRequestJsonData(jsonString, "add", appendMap));
		setUpdateList(ObjectBindUtil
				.getRequestJsonData(jsonString, "update", appendMap));
	}
	
	public boolean hasInsertList(){
		return insertList!=null && insertList.size()>0;
	}
	
	public boolean hasUpdateList(){
		return updateList!=null && updateList.size()>0;
	}

	public LinkedHashMap<String, Object> getAppendMap() {
		return appendMap;
	}

	public void setAppendMap(LinkedHashMap<String, Object> appendMap) {
		this.appendMap = appendMap;
	}

	public List<LinkedHashMap<String, Object>> getInsertList() {
		return insertList;
	}

	public void setInsertList(List<LinkedHashMap<String, Object>> insertList) {
		this.insertList = insertList;
	}

	public List<LinkedHashMap<String, Object>> getUpdateList() {
		return updateList;
	}

	public void setUpdateList(List<LinkedHashMap<String, Object>> updateList) {
		this.updateList = updateList;
	}
}
