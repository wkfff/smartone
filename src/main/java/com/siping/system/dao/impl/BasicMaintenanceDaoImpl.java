package com.siping.system.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.siping.system.dao.BasicMaintenanceDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class BasicMaintenanceDaoImpl extends SqlMapClientSupport implements BasicMaintenanceDao {
	/**
	 * 获取公司信息
	 * @param List
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getCompanyInfo(Object obj) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.basicMaintenance.getCompanyInfo", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	}
	/**
	 * 获取公司信息
	 * @param List
	 * @return
	 */ 
	public Object getCompanyInfoObj(Object obj) {
		Object object = null ;
		try {
			object = this.queryForObject("system.basicMaintenance.getCompanyInfoObj", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return object ;
	} 
	/**
	 * 获取公司信息
	 * @param List
	 * @return
	 */ 
	public int addCompanyInfo(Object obj) { 
		try {
			this.update("system.basicMaintenance.addCompanyInfo", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	}  
	/**
	 * 获取公司信息
	 * @param List
	 * @return
	 */ 
	@SuppressWarnings({ "rawtypes" })
	public int checkCompanyInfo(Object obj) { 
		int i=0;
		try {
			List list = this.queryForList("system.basicMaintenance.checkCompanyInfo", obj);
		    i = list.size();
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return i ;
	}  
	/**
	 * 获取公司信息
	 * @param List
	 * @return
	 */ 
	public int updateCompanyInfo(Object obj) { 
		try {
			this.update("system.basicMaintenance.updateCompanyInfo", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	} 
	/**
	 * 获取公司信息
	 * @param List
	 * @return
	 */ 
	public int deleteCompanyInfo(Object obj) { 
		try {
			this.delete("system.basicMaintenance.deleteCompanyInfo", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	} 
	/**
	 * 取得所有部门列表
	 * @param List
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getDeptInfoList(Object obj) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.basicMaintenance.getDeptInfoList", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	}  
	/**
	 * 取得所有CODE列表,依据PARENT_CODE
	 * @param List
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getDeptListByParentCode(Object obj) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.basicMaintenance.getDeptListByParentCode", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	}
	/**
	 * 取得所有父级CODE列表
	 * @param List
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getParentCodeList(Object obj) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.basicMaintenance.getParentCodeList", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	} 
	/**
	 * 取得所有父级CODE列表
	 * @param List
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getTypeParentCodeList(Object obj) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.basicMaintenance.getTypeParentCodeList", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	} 
	/**
	 * 取得所有父级菜单列表
	 * @param List
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getParentMenuList(Object obj) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.basicMaintenance.getParentMenuList", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	}
	
	/**
	 * 取得所有CODE列表,依据PARENT_CODE
	 * @param List
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getCodeListByParentCode(Object obj) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.basicMaintenance.getCodeListByParentCode", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	}

	/**
	 * 取得所有父级菜单CODE列表,依据PARENT_MENU_CODE
	 * @param List
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getMenuListByParentMenuCode(Object obj) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.basicMaintenance.getMenuListByParentMenuCode", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	} 
	public String getMenuInfo(Object obj) {
		String returnString = "" ;
		try {
			returnString = this.queryForObject("system.basicMaintenance.getMenuInfo", obj).toString();
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnString ;
	}
	
	/**
	 * 插入CODE信息
	 * @param Object
	 * @return
	 */ 
	public int addCodeInfo(Object obj) {
		
		try {
			this.insert("system.basicMaintenance.addCodeInfo", obj) ;
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	}
	/**
	 * 插入菜单信息
	 * @param Object
	 * @return
	 */ 
	public int addMenuInfo(Object obj) {
		
		try {
			this.insert("system.basicMaintenance.addMenuInfo", obj) ;
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	}
	
	/**
	 * 批量插入CODE信息
	 * @param Object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public int addCodeInfo(List obj) throws SQLException {
		
		this.insertForList("system.basicMaintenance.addCodeInfo", obj) ;
		
		return 0 ;
	}
	/**
	 * 批量插入菜单信息
	 * @param Object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public int addMenuInfo(List obj) {
		
		try {
			this.insertForList("system.basicMaintenance.addMenuInfo", obj) ;
			//仅为普通用户在权限表中初始化
			this.insertForList("system.basicMaintenance.addSyScreenGrantFor2", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	}
	
	/**
	 * 更新CODE信息
	 * @param Object
	 * @return
	 */ 
	public int updateCodeInfo(Object obj) {
		
		try {
			this.update("system.basicMaintenance.updateCodeInfo", obj) ;
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	}
	/**
	 * 更新菜单信息
	 * @param Object
	 * @return
	 */ 
	public int updateMenuInfo(Object obj) {
		
		try {
			this.update("system.basicMaintenance.updateMenuInfo", obj) ;
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	}
	
	/**
	 * 批量更新CODE信息
	 * @param Object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public int updateCodeInfo(List obj) throws SQLException {
		this.updateForList("system.basicMaintenance.updateCodeInfo", obj) ;
		return 0 ;
	}
	/**
	 * 批量更新菜单信息
	 * @param Object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public int updateMenuInfo(List obj) {
		
		try {
			this.updateForList("system.basicMaintenance.updateMenuInfo", obj) ;
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	}
	
	/**
	 * 删除CODE信息
	 * @param Object
	 * @return
	 */ 
	public int deleteCodeInfo (Object obj) throws SQLException {
		
		this.delete("system.basicMaintenance.deleteCodeInfo", obj) ;
	
		return 0 ;
	}
	/**
	 * 删除菜单信息
	 * @param Object
	 * @return
	 */ 
	public int deleteMenuInfo(Object obj) {
		
		try {
			this.delete("system.basicMaintenance.deleteMenuInfo", obj) ;
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	}
	
	/**
	 * 批量删除CODE信息
	 * @param Object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public int deleteCodeInfo(List obj) {
		
		try {
			this.deleteForList("system.basicMaintenance.deleteCodeInfo", obj) ;
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	}
	/**
	 * 批量删除CODE信息
	 * @param Object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public int deleteMenuInfo(List obj) {
		
		try {
			this.deleteForList("system.basicMaintenance.deleteCodeInfo", obj) ;
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return 0 ;
	} 
	/**
	 * 获得下拉列表
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getSysCodeSelectMap(Object object) {
		Map object2 = new LinkedHashMap();
		try {
			List Rows =this.queryForList("system.basicMaintenance.getSysCodeSelectMap", object);
			object2.put("Rows", Rows!=null?Rows:null);
			object2.put("Total", Rows!=null?Rows.size():0);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return object2;
	}
	/**
	 * 获得下拉列表
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getSysCodeSelectList(Object object) {
		List Rows = new ArrayList();
		try {
			Rows =this.queryForList("system.basicMaintenance.getSysCodeSelectList", object);
			 
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return Rows;
	}
	/**
	 * 获得下拉列表
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map getActivitySelectMap(Object object) {
		Map object2 = new LinkedHashMap();
		try {
			List Rows =this.queryForList("system.basicMaintenance.getActivitySelectMap", object);
			object2.put("Rows", Rows!=null?Rows:null);
			object2.put("Total", Rows!=null?Rows.size():0);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return object2;
	}
	/**
	 * 获得下拉列表
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getDeptLevelList(Object object) {
		List Rows = new ArrayList();
		try {
			Rows =this.queryForList("system.basicMaintenance.getDeptLevelList", object);
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return Rows;
	} 
	/**
	 * 获得下拉列表
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map getCompanySelectMap(Object object) {
		Map object2 = new LinkedHashMap();
		try {
			List Rows =this.queryForList("system.basicMaintenance.getCompanySelectMap", object);
			object2.put("Rows", Rows!=null?Rows:null);
			object2.put("Total", Rows!=null?Rows.size():0);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return object2;
	}
	
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getAnnouncementList(Object object) {
		List list = new ArrayList();		
		try {
			if(((Map)object).get("page")==null){
				list = this.queryForList("system.basicMaintenance.getAnnouncementList",object);
			}else{
				list = this.queryForList("system.basicMaintenance.getAnnouncementList",object,
						Integer.parseInt(((Map)object).get("page").toString()),
						Integer.parseInt(((Map)object).get("pagesize").toString()));
			}
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int getAnnouncementListCnt(Object object) {
		int temp = 0;		
		try {
			temp = Integer.parseInt(this.queryForObject("system.basicMaintenance.getAnnouncementListCnt",object).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public void addAnnouncement(List object) throws SQLException {
		this.updateForList("system.basicMaintenance.addAnnouncement", object);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void updateAnnouncement(List object) throws SQLException {
		this.updateForList("system.basicMaintenance.updateAnnouncement", object);
	}

	@Override
	public void removeAnnouncement(Object object) throws SQLException {
		this.update("system.basicMaintenance.removeAnnouncement", object);
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List getCategoryList(Object object) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.basicMaintenance.getCategoryList", object);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	}
	@SuppressWarnings({ "rawtypes" })
	public List getCategoryList(Object object,int currentPage,int pageSize) {
		List list = new ArrayList();
		try {
			list = this.queryForList("system.basicMaintenance.getCategoryList",object,currentPage,pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public int getCategoryListCnt(Object object) {
		int temp = 0;		
		try {
			temp = Integer.parseInt(this.queryForObject("system.basicMaintenance.getCategoryListCnt",object).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List getPropertyList(Object object) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.basicMaintenance.getPropertyList", object);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	}
	@SuppressWarnings({ "rawtypes" })
	public List getPropertyList(Object object,int currentPage,int pageSize) {
		List list = new ArrayList();
		try {
			list = this.queryForList("system.basicMaintenance.getPropertyList",object,currentPage,pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public int getPropertyListCnt(Object object) {
		int temp = 0;		
		try {
			temp = Integer.parseInt(this.queryForObject("system.basicMaintenance.getPropertyListCnt",object).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List getPropertyValueList(Object object) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.basicMaintenance.getPropertyValueList", object);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	}
	@SuppressWarnings({ "rawtypes" })
	public List getPropertyValueList(Object object,int currentPage,int pageSize) {
		List list = new ArrayList();
		try {
			list = this.queryForList("system.basicMaintenance.getPropertyValueList",object,currentPage,pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public int getPropertyValueListCnt(Object object) {
		int temp = 0;		
		try {
			temp = Integer.parseInt(this.queryForObject("system.basicMaintenance.getPropertyValueListCnt",object).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public String addPropertyToCategory(List object) {
		String result = "Y";
		try {
			this.insertForList("system.basicMaintenance.addPropertyToCategory", object);
		} catch (SQLException e) {
			e.printStackTrace();
			result = e.getMessage();
		} catch (Exception e) { 
			e.printStackTrace();
			result = e.getMessage();
		}
		return result;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public String deletePropertyFromCategory(List object) {
		String result = "Y";
		try {
			this.deleteForList("system.basicMaintenance.deletePropertyFromCategory", object);
		} catch (SQLException e) {
			e.printStackTrace();
			result = e.getMessage();
		} catch (Exception e) { 
			e.printStackTrace();
			result = e.getMessage();
		}
		return result;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public String addValueToProperty(List object) {
		String result = "Y";
		try {
			this.insertForList("system.basicMaintenance.addValueToProperty", object);
		} catch (SQLException e) {
			e.printStackTrace();
			result = e.getMessage();
		} catch (Exception e) { 
			e.printStackTrace();
			result = e.getMessage();
		}
		return result;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public String deleteValueFromProperty(List object) {
		String result = "Y";
		try {
			this.deleteForList("system.basicMaintenance.deleteValueFromProperty", object);
		} catch (SQLException e) {
			e.printStackTrace();
			result = e.getMessage();
		} catch (Exception e) { 
			e.printStackTrace();
			result = e.getMessage();
		}
		return result;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public String updateCategory(List objlist) {
		String resultString = "Y";
		try { 
			this.startTransaction();
			this.updateForList("system.basicMaintenance.updateCategory",objlist);
			this.commitTransation();
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}finally{
			try {
				this.endTransation();
			} catch (SQLException e) { 
				e.printStackTrace();
			}
		}
		return resultString;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public String updateProperty(List objlist) {
		String resultString = "Y";
		try { 
			this.startTransaction();
			this.updateForList("system.basicMaintenance.updateProperty",objlist);
			this.commitTransation();
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}finally{
			try {
				this.endTransation();
			} catch (SQLException e) { 
				e.printStackTrace();
			}
		}
		return resultString;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public String updatePropertyValue(List objlist) {
		String resultString = "Y";
		try { 
			this.startTransaction();
			this.updateForList("system.basicMaintenance.updatePropertyValue",objlist);
			this.commitTransation();
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}finally{
			try {
				this.endTransation();
			} catch (SQLException e) { 
				e.printStackTrace();
			}
		}
		return resultString;
	}
	
	@Override
	public String addCategoryInfo(Object obj) {
		String result = "Y";
		try {
			this.insert("system.basicMaintenance.addCategoryInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
			result = e.getMessage();
		} catch (Exception e) { 
			e.printStackTrace();
			result = e.getMessage();
		}
		return result;
	}
	@Override
	public int checkCategoryId(Object obj) {
		int temp = 0;
		try {
			temp = Integer.parseInt(this.queryForObject("system.basicMaintenance.checkCategoryId",obj).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}
	@Override
	public int checkCategoryDelete(Object obj) {
		int temp = 0;
		try {
			temp = Integer.parseInt(this.queryForObject("system.basicMaintenance.checkCategoryDelete",obj).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}
	@Override
	public String addPropertyInfo(Object obj) {
		String result = "Y";
		try {
			this.insert("system.basicMaintenance.addPropertyInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
			result = e.getMessage();
		} catch (Exception e) { 
			e.printStackTrace();
			result = e.getMessage();
		}
		return result;
	}
	@Override
	public int checkPropertyId(Object obj) {
		int temp = 0;
		try {
			temp = Integer.parseInt(this.queryForObject("system.basicMaintenance.checkPropertyId",obj).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}
	@Override
	public String deleteCategoryInfo(Object obj) {
		String result = "Y";
		try {
			this.delete("system.basicMaintenance.deleteCategoryInfo", obj) ;
		} catch (SQLException e) {
			e.printStackTrace();
			result = e.getMessage();
		}
		return result;
	}
	@Override
	public String deletePropertyInfo(Object obj) {
		String result = "Y";
		try {
			this.delete("system.basicMaintenance.deletePropertyInfo", obj) ;
		} catch (SQLException e) {
			e.printStackTrace();
			result = e.getMessage();
		}
		return result;
	}
	@Override
	public String deletePropertyValueInfo(Object obj) {
		String result = "Y";
		try {
			this.delete("system.basicMaintenance.deletePropertyValueInfo", obj) ;
		} catch (SQLException e) {
			e.printStackTrace();
			result = e.getMessage();
		}
		return result;
	}
	
	@Override
	public String addPropertyValueInfo(Object obj) {
		String result = "Y";
		try {
			this.insert("system.basicMaintenance.addPropertyValueInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
			result = e.getMessage();
		} catch (Exception e) { 
			e.printStackTrace();
			result = e.getMessage();
		}
		return result;
	}
	@Override
	public int checkPropertyValueId(Object obj) {
		int temp = 0;
		try {
			temp = Integer.parseInt(this.queryForObject("system.basicMaintenance.checkPropertyValueId",obj).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List getStorageWarnList(Object object) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.basicMaintenance.getStorageWarnList", object);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	}
	@SuppressWarnings({ "rawtypes" })
	public List getStorageWarnList(Object object,int currentPage,int pageSize) {
		List list = new ArrayList();
		try {
			list = this.queryForList("system.basicMaintenance.getStorageWarnList",object,currentPage,pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public int getStorageWarnListCnt(Object object) {
		int temp = 0;		
		try {
			temp = Integer.parseInt(this.queryForObject("system.basicMaintenance.getStorageWarnListCnt",object).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}
	
	@Override
	public String addStorageWarnTarget(Object obj) {
		String result = "Y";
		try {
			this.insert("system.basicMaintenance.addStorageWarnTarget", obj);
		} catch (SQLException e) {
			e.printStackTrace();
			result = e.getMessage();
		} catch (Exception e) { 
			e.printStackTrace();
			result = e.getMessage();
		}
		return result;
	}
	
	@Override
	public int checkAddStorageWarnTarget(Object obj) {
		int temp = 0;
		try {
			temp = Integer.parseInt(this.queryForObject("system.basicMaintenance.checkAddStorageWarnTarget",obj).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}
	
	/**
	 * 
	 * @param List
	 * @return
	 */ 
	@Override
	public String deleteStorageWarnTarget(Object obj) { 
		String result = "Y";
		try {
			this.delete("system.basicMaintenance.deleteStorageWarnTarget", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
			result = e.getMessage();
		}
		
		return result;
	} 
}
