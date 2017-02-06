package com.siping.process.dao;

import java.util.List; 
import java.util.Map;

public interface ProcessManageDao {

	/**
	 * 添加对象申请
	 * @param obj
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map addObjectApp(Object obj,boolean affirmFlag); 


	@SuppressWarnings("rawtypes")
	public List getAffirmorList(Object obj);
	@SuppressWarnings("rawtypes")
	public List getAffirmorResultList(Object obj);
	
	@SuppressWarnings("rawtypes")
	public List getAffirmorListByObjectID(Object obj) ;
	/**
	 * 根据对象的Type取得审批人列表
	 * @param obj
	 * @return 
	 */
	@SuppressWarnings("rawtypes")
	public List getAffirmorListByObjectType(Object obj)  ;
	/**
	 * 无特殊设置取得审批人列表
	 * @param obj
	 * @return 
	 */
	@SuppressWarnings("rawtypes")
	public List getAffirmorListByNormal(Object obj) ;
	
	/* **********查看并审批申请************************************** */
	@SuppressWarnings("rawtypes")
	public Map getAffirmObjectInfo(Object object,int currentPage,int pageSize);
	@SuppressWarnings("rawtypes")
	public Map getAffirmObjectInfo(Object object);
	@SuppressWarnings("rawtypes")
	public Map affirmObjectApp(List objectList);
	
	public boolean isAllAffirm(Object object);
	public boolean isAllReject(Object object);
	
	public boolean updateObjectStatus(Object object);
	@SuppressWarnings("rawtypes")
	public boolean updateObjectListStatus(List list);
	
	@SuppressWarnings("rawtypes")
	public void addObjectListApp(List list);
	
	/* ******************************Cmx idea******************* */
	public void getObjectProcessNO(Object object);
	
	public String getProcessResult(Object object);
}
