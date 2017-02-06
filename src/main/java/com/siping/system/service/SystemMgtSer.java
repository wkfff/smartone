package com.siping.system.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface SystemMgtSer {  	
	/**
	 * 获取职群信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getPostGroupInfo(HttpServletRequest request); 
	/**
	 * 获取职群信息
	 */ 
	public int getPostGroupInfoCnt(HttpServletRequest request); 
	/**
	 * 修改职群信息
	 */
	public int updatePostGroupInfo(HttpServletRequest request) ;
	/**
	 * 删除职群信息
	 */
	public int deletePostGroupInfo(HttpServletRequest request) ;
	
	/**
	 * 检查职群信息
	 */
	public int checkPostGroupInfo(HttpServletRequest request) ;  
	/**
	 * 添加职群信息
	 */
	public int addPostGroupInfo(HttpServletRequest request) ;
	
	/**
	 * 获取职群信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getPostColumnInfo(HttpServletRequest request); 
	/**
	 * 获取职群信息
	 */ 
	public int getPostColumnInfoCnt(HttpServletRequest request); 
	/**
	 * 修改职群信息
	 */
	public int updatePostColumnInfo(HttpServletRequest request) ;
	/**
	 * 删除职群信息
	 */
	public int deletePostColumnInfo(HttpServletRequest request) ;
	
	/**
	 * 检查职群信息
	 */
	public int checkPostColumnInfo(HttpServletRequest request) ;  
	/**
	 * 添加职群信息
	 */
	public int addPostColumnInfo(HttpServletRequest request) ;

	/**
	 * 获取职级信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getPostGradeInfo(HttpServletRequest request); 
	/**
	 * 获取职级信息
	 */ 
	public int getPostGradeInfoCnt(HttpServletRequest request); 
	/**
	 * 修改职级信息
	 */
	public int updatePostGradeInfo(HttpServletRequest request) ;
	/**
	 * 删除职级信息
	 */
	public int deletePostGradeInfo(HttpServletRequest request) ;
	
	/**
	 * 检查职级信息
	 */
	public int checkPostGradeInfo(HttpServletRequest request) ;  
	/**
	 * 添加职级信息
	 */
	public int addPostGradeInfo(HttpServletRequest request) ;
	/**
	 * 获取职位岗位信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getPostInfo(HttpServletRequest request); 
	/**
	 * 获取职位岗位信息
	 */ 
	public int getPostInfoCnt(HttpServletRequest request); 
	/**
	 * 修改职位岗位信息
	 */
	public int updatePostInfo(HttpServletRequest request) ;
	/**
	 * 删除职位岗位信息
	 */
	public int deletePostInfo(HttpServletRequest request) ;
	
	/**
	 * 检查职位岗位信息
	 */
	public int checkPostInfo(HttpServletRequest request) ;  
	/**
	 * 添加职位岗位信息
	 */
	public int addPostInfo(HttpServletRequest request) ;
	/**
	 * 获取职位岗位信息
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getPositionInfo(HttpServletRequest request); 
	/**
	 * 获取职位岗位信息
	 */ 
	public int getPositionInfoCnt(HttpServletRequest request); 
	/**
	 * 修改职位岗位信息
	 */
	public int updatePositionInfo(HttpServletRequest request) ;
	/**
	 * 删除职位岗位信息
	 */
	public int deletePositionInfo(HttpServletRequest request) ;
	
	/**
	 * 检查职位岗位信息
	 */
	public int checkPositionInfo(HttpServletRequest request) ;  
	/**
	 * 添加职位岗位信息
	 */
	public int addPositionInfo(HttpServletRequest request) ;
	 
}
