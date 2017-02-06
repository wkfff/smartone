package com.siping.system.dao;

import java.util.List;  
  
public interface SystemMgtDao {
	/**
	 * 获取职群信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getPostGroupInfo(Object obj); 
	/**
	 * 获取职群信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getPostGroupInfo(Object obj, int currentPage, int pageSize); 
	/**
	 * 获取职群信息
	 */  
	public int getPostGroupInfoCnt(Object obj);  
	/**
	 * 修改职群信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public int updatePostGroupInfo(List list) ;
	/**
	 * 删除职群信息
	 */
	public int deletePostGroupInfo(Object obj) ;
	
	/**
	 * 检查职群信息
	 */
	public int checkPostGroupInfo(Object obj) ;  
	/**
	 * 添加职群信息
	 */
	public int addPostGroupInfo(Object obj) ;  
	
	/**
	 * 获取职列信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getPostColumnInfo(Object obj); 
	/**
	 * 获取职列信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getPostColumnInfo(Object obj, int currentPage, int pageSize); 
	/**
	 * 获取职列信息
	 */  
	public int getPostColumnInfoCnt(Object obj);  
	/**
	 * 修改职列信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public int updatePostColumnInfo(List list) ;
	/**
	 * 删除职列信息
	 */
	public int deletePostColumnInfo(Object obj) ;
	
	/**
	 * 检查职列信息
	 */
	public int checkPostColumnInfo(Object obj) ;  
	/**
	 * 添加职列信息
	 */
	public int addPostColumnInfo(Object obj) ;
	/**
	 * 获取职级信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getPostGradeInfo(Object obj); 
	/**
	 * 获取职级信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getPostGradeInfo(Object obj, int currentPage, int pageSize); 
	/**
	 * 获取职级信息
	 */  
	public int getPostGradeInfoCnt(Object obj);  
	/**
	 * 修改职级信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public int updatePostGradeInfo(List list) ;
	/**
	 * 删除职级信息
	 */
	public int deletePostGradeInfo(Object obj) ;
	
	/**
	 * 检查职级信息
	 */
	public int checkPostGradeInfo(Object obj) ;  
	/**
	 * 添加职级信息
	 */
	public int addPostGradeInfo(Object obj) ;
	/**
	 * 获取职位岗位信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getPostInfo(Object obj); 
	/**
	 * 获取职位岗位信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getPostInfo(Object obj, int currentPage, int pageSize); 
	/**
	 * 获取职位岗位信息
	 */  
	public int getPostInfoCnt(Object obj);  
	/**
	 * 修改职位岗位信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public int updatePostInfo(List list) ;
	/**
	 * 删除职位岗位信息
	 */
	public int deletePostInfo(Object obj) ;
	
	/**
	 * 检查职位岗位信息
	 */
	public int checkPostInfo(Object obj) ;  
	/**
	 * 添加职位岗位信息
	 */
	public int addPostInfo(Object obj) ;
	/**
	 * 获取职务信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getPositionInfo(Object obj); 
	/**
	 * 获取职务信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getPositionInfo(Object obj, int currentPage, int pageSize); 
	/**
	 * 获取职务信息
	 */  
	public int getPositionInfoCnt(Object obj);  
	/**
	 * 修改职务信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public int updatePositionInfo(List list) ;
	/**
	 * 删除职务信息
	 */
	public int deletePositionInfo(Object obj) ;
	
	/**
	 * 检查职务信息
	 */
	public int checkPositionInfo(Object obj) ;  
	/**
	 * 添加职务信息
	 */
	public int addPositionInfo(Object obj) ;
	
}
