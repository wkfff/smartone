package com.siping.system.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList; 
import java.util.List;  

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;
 
import com.siping.system.dao.SystemMgtDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class SystemMgtDaoImpl extends SqlMapClientSupport implements SystemMgtDao {
	/**
	 * 获取职群信息
	 * @param List 
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public List getPostGroupInfo(Object obj) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.mgt.getPostGroupInfo", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	}
	/**
	 * 获取职群信息
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getPostGroupInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.mgt.getPostGroupInfo", obj,currentPage,pageSize);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	} 
	/**
	 * 获取职群信息
	 * @param Object
	 * @return
	 */ 
	public int getPostGroupInfoCnt(Object obj) {
		int returnInt = 0 ;
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("system.mgt.getPostGroupInfoCnt", obj)),Integer.class);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnInt ;
	}  
	/**
	 * 添加职群信息
	 * @param Object
	 * @return
	 */ 
	public int addPostGroupInfo(Object obj) { 
		try {
			this.insert("system.mgt.addPostGroupInfo", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	}  
	/**
	 * 检查职群信息
	 * @param Object
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public int checkPostGroupInfo(Object obj) { 
		int i=0;
		try {
			List list = this.queryForList("system.mgt.checkPostGroupInfo", obj);
		    i = list.size();
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return i ;
	}  
	/**
	 * 更新职群信息
	 * @param Object
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public int updatePostGroupInfo(List list) { 
		try {
			this.updateForList("system.mgt.updatePostGroupInfo", list);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	} 
	/**
	 * 删除职群信息
	 * @param Object
	 * @return
	 */ 
	public int deletePostGroupInfo(Object obj) { 
		try {
			this.delete("system.mgt.deletePostGroupInfo", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	} 
	
	/**
	 * 获取职列信息
	 * @param List 
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public List getPostColumnInfo(Object obj) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.mgt.getPostColumnInfo", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	}
	/**
	 * 获取职列信息
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getPostColumnInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.mgt.getPostColumnInfo", obj,currentPage,pageSize);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	} 
	/**
	 * 获取职列信息
	 * @param Object
	 * @return
	 */ 
	public int getPostColumnInfoCnt(Object obj) {
		int returnInt = 0 ;
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("system.mgt.getPostColumnInfoCnt", obj)),Integer.class);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnInt ;
	}  
	/**
	 * 添加职列信息
	 * @param Object
	 * @return
	 */ 
	public int addPostColumnInfo(Object obj) { 
		try {
			this.update("system.mgt.addPostColumnInfo", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	}  
	/**
	 * 检查职列信息
	 * @param Object
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public int checkPostColumnInfo(Object obj) { 
		int i=0;
		try {
			List list = this.queryForList("system.mgt.checkPostColumnInfo", obj);
		    i = list.size();
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return i ;
	}  
	/**
	 * 更新职列信息
	 * @param Object
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public int updatePostColumnInfo(List list) { 
		try {
			this.updateForList("system.mgt.updatePostColumnInfo", list);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	} 
	/**
	 * 删除职列信息
	 * @param Object
	 * @return
	 */ 
	public int deletePostColumnInfo(Object obj) { 
		try {
			this.delete("system.mgt.deletePostColumnInfo", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	}  
	/**
	 * 获取职级信息
	 * @param List 
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public List getPostGradeInfo(Object obj) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.mgt.getPostGradeInfo", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	}
	/**
	 * 获取职级信息
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getPostGradeInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.mgt.getPostGradeInfo", obj,currentPage,pageSize);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	} 
	/**
	 * 获取职级信息
	 * @param Object
	 * @return
	 */ 
	public int getPostGradeInfoCnt(Object obj) {
		int returnInt = 0 ;
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("system.mgt.getPostGradeInfoCnt", obj)),Integer.class);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnInt ;
	}  
	/**
	 * 添加职级信息
	 * @param Object
	 * @return
	 */ 
	public int addPostGradeInfo(Object obj) { 
		try {
			this.update("system.mgt.addPostGradeInfo", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	}  
	/**
	 * 检查职级信息
	 * @param Object
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public int checkPostGradeInfo(Object obj) { 
		int i=0;
		try {
			List list = this.queryForList("system.mgt.checkPostGradeInfo", obj);
		    i = list.size();
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return i ;
	}  
	/**
	 * 更新职级信息
	 * @param Object
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public int updatePostGradeInfo(List list) { 
		try {
			this.updateForList("system.mgt.updatePostGradeInfo", list);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	} 
	/**
	 * 删除职级信息
	 * @param Object
	 * @return
	 */ 
	public int deletePostGradeInfo(Object obj) { 
		try {
			this.delete("system.mgt.deletePostGradeInfo", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	}  
	/**
	 * 获取职位岗位信息
	 * @param List 
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public List getPostInfo(Object obj) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.mgt.getPostInfo", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	}
	/**
	 * 获取职位岗位信息
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getPostInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.mgt.getPostInfo", obj,currentPage,pageSize);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	} 
	/**
	 * 获取职位岗位信息
	 * @param Object
	 * @return
	 */ 
	public int getPostInfoCnt(Object obj) {
		int returnInt = 0 ;
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("system.mgt.getPostInfoCnt", obj)),Integer.class);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnInt ;
	}  
	/**
	 * 添加职位岗位信息
	 * @param Object
	 * @return
	 */ 
	public int addPostInfo(Object obj) { 
		try {
			this.update("system.mgt.addPostInfo", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	}  
	/**
	 * 检查职位岗位信息
	 * @param Object
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public int checkPostInfo(Object obj) { 
		int i=0;
		try {
			List list = this.queryForList("system.mgt.checkPostInfo", obj);
		    i = list.size();
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return i ;
	}  
	/**
	 * 更新职位岗位信息
	 * @param Object
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public int updatePostInfo(List list) { 
		try {
			this.updateForList("system.mgt.updatePostInfo", list);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	} 
	/**
	 * 删除职位岗位信息
	 * @param Object
	 * @return
	 */ 
	public int deletePostInfo(Object obj) { 
		try {
			this.delete("system.mgt.deletePostInfo", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	}   
	/**
	 * 获取职务信息
	 * @param List 
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public List getPositionInfo(Object obj) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.mgt.getPositionInfo", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	}
	/**
	 * 获取职务信息
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getPositionInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.mgt.getPositionInfo", obj,currentPage,pageSize);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	} 
	/**
	 * 获取职务信息
	 * @param Object
	 * @return
	 */ 
	public int getPositionInfoCnt(Object obj) {
		int returnInt = 0 ;
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("system.mgt.getPositionInfoCnt", obj)),Integer.class);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnInt ;
	}  
	/**
	 * 添加职务信息
	 * @param Object
	 * @return
	 */ 
	public int addPositionInfo(Object obj) { 
		try {
			this.update("system.mgt.addPositionInfo", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	}  
	/**
	 * 检查职务信息
	 * @param Object
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public int checkPositionInfo(Object obj) { 
		int i=0;
		try {
			List list = this.queryForList("system.mgt.checkPositionInfo", obj);
		    i = list.size();
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return i ;
	}  
	/**
	 * 更新职务信息
	 * @param Object
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public int updatePositionInfo(List list) { 
		try {
			this.updateForList("system.mgt.updatePositionInfo", list);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	} 
	/**
	 * 删除职务信息
	 * @param Object
	 * @return
	 */ 
	public int deletePositionInfo(Object obj) { 
		try {
			this.delete("system.mgt.deletePositionInfo", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	} 
	/**
	 * 获得职级下拉列表
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getPostGradeSelectList(Object object) {
		List Rows = new ArrayList();
		try {
			Rows =this.queryForList("system.mgt.getPostGradeSelectList", object);
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return Rows;
	} 
	/**
	 * 获得职列下拉列表
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getPostColumnSelectList(Object object) {
		List Rows = new ArrayList();
		try {
			Rows =this.queryForList("system.mgt.getPostColumnSelectList", object);
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return Rows;
	}
	/**
	 * 获得职群下拉列表
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getPostGroupSelectList(Object object) {
		List Rows = new ArrayList();
		try {
			Rows =this.queryForList("system.mgt.getPostGroupSelectList", object);
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return Rows;
	}
	/**
	 * 获得职位下拉列表
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getPostSelectList(Object object) {
		List Rows = new ArrayList();
		try {
			Rows =this.queryForList("system.mgt.getPostSelectList", object);
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return Rows;
	}
}
