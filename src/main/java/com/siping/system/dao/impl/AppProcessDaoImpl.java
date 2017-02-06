package com.siping.system.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.system.dao.AppProcessDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class AppProcessDaoImpl extends SqlMapClientSupport implements
		AppProcessDao {
	/**
	 * 获取个人流程信息
	 * 
	 * @param obj
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public List getAppProcessInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"system.appProcess.getAppProcessInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	} 
	/**
	 * 获取个人流程信息
	 * 
	 * @param obj
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public Map getAppProcessPInfoObj(Object obj) {
		Map returnMap = null;
		try {
			returnMap = (Map) this.queryForObject(
					"system.appProcess.getAppProcessPInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnMap;
	}

	/**
	 * 获取个人流程信息
	 * 
	 * @param obj
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public List getAppProcessPInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"system.appProcess.getAppProcessPInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}

	/**
	 * 获取个人流程信息
	 * 
	 * @param obj
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public List getAppProcessPInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();

		try {
			returnList = this.queryForList(
					"system.appProcess.getAppProcessPInfo", obj, currentPage,
					pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}

	/**
	 * 获取个人流程信息
	 * 
	 * @param obj
	 * @return
	 */
	@Override
	public int getAppProcessPInfoCnt(Object obj) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("system.appProcess.getAppProcessPInfoCnt",
							obj)), Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}

	/**
	 * 获取个人流程审判者信息
	 * 
	 * @param obj
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public Map getAppProcessPAInfoObj(Object obj) {
		Map returnMap = null;
		try {
			returnMap = (Map) this.queryForObject(
					"system.appProcess.getAppProcessPInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnMap;
	}

	/**
	 * 获取个人流程审判者信息
	 * 
	 * @param obj
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getAppProcessPAInfo(Object obj) {
		List returnList = new ArrayList();
		List appTypeList = new ArrayList();
		try {
			if (obj != null) {
				Map paramMap = (Map) obj;
				appTypeList = (List) paramMap.get("appTypeList");
				if (appTypeList.size() > 0) {
					for (int i = 0; i < appTypeList.size(); i++) {
						Map param = (Map) appTypeList.get(i);
						Map paramApp = new LinkedHashMap<String, String>();
						paramApp.put("AFFIRM_TYPE_NAME", param.get("CODE_NAME"));
						paramApp.put("AFFIRM_TYPE_ID", param.get("CODE_ID"));
						paramApp.put("EMPID", paramMap.get("EMPID"));
						
						for(int j = 1;j<7;j++){
							paramMap.put("AFFIRM_TYPE_ID", param.get("CODE_ID"));
							paramMap.put("AFFIRM_LEVEL", j);
							List reList = this.queryForList(
									"system.appProcess.getAppProcessPAInfo", paramMap);
							if(reList.size()>0){
								String name = "";
								for(int k = 0; k < reList.size(); k++){
									Map para = (Map) reList.get(k);
									name += para.get("NAME") + ", ";
								}
								paramApp.put("NAME"+j, name);
							}
						}
						if(paramApp!=null){
							returnList.add(paramApp);
						}
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}

	/**
	 * 获取个人流程审判者信息
	 * 
	 * @param obj
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getAppProcessDAInfo(Object obj) {
		List returnList = new ArrayList();
		List appTypeList = new ArrayList();
		try {
			if (obj != null) {
				Map paramMap = (Map) obj;
				appTypeList = (List) paramMap.get("appTypeList");
				if (appTypeList.size() > 0) {
					for (int i = 0; i < appTypeList.size(); i++) {
						Map param = (Map) appTypeList.get(i);
						Map paramApp = new LinkedHashMap<String, String>();
						paramApp.put("AFFIRM_TYPE_NAME", param.get("CODE_NAME"));
						paramApp.put("AFFIRM_TYPE_ID", param.get("CODE_ID"));
						paramApp.put("DEPTID", paramMap.get("DEPTID"));
						
						for(int j = 1;j<7;j++){
							paramMap.put("AFFIRM_TYPE_ID", param.get("CODE_ID"));
							paramMap.put("AFFIRM_LEVEL", j);
							List reList = this.queryForList(
									"system.appProcess.getAppProcessDAInfo", paramMap);
							if(reList.size()>0){
								String name = "";
								for(int k = 0; k < reList.size(); k++){
									Map para = (Map) reList.get(k);
									name += para.get("NAME") + ", ";
								}
								paramApp.put("NAME"+j, name);
							}
						}
						if(paramApp!=null){
							returnList.add(paramApp);
						}
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	} 
	/**
	 * 获取部门流程信息
	 * 
	 * @param obj
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public Map getAppProcessDInfoObj(Object obj) {
		Map returnMap = null;
		try {
			returnMap = (Map) this.queryForObject(
					"system.appProcess.getAppProcessDInfoObj", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnMap;
	}

	/**
	 * 获取部门流程信息
	 * 
	 * @param obj
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public List getAppProcessDInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"system.appProcess.getAppProcessDInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}

	/**
	 * 获取部门流程信息
	 * 
	 * @param obj
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public List getAppProcessDInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();

		try {
			returnList = this.queryForList(
					"system.appProcess.getAppProcessDInfo", obj, currentPage,
					pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}

	/**
	 * 获取部门流程信息
	 * 
	 * @param obj
	 * @return
	 */
	@Override
	public int getAppProcessDInfoCnt(Object obj) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("system.appProcess.getAppProcessDInfoCnt",
							obj)), Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}

	/**
	 * 添加个人流程信息
	 * 
	 * @param obj
	 * @return
	 */ 
	@Override
	public int addAppProcessPInfo(Object obj) {
		try {
			this.insert("system.appProcess.addAppProcessInfo", obj); 
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	/**
	 * 添加个人流程信息
	 * 
	 * @param obj
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public int addAppProcessPInfo(List obj) {

		try {
			this.startTransaction() ;
			this.updateForList("system.appProcess.updateAppAdminFlag", obj); 
			this.insertForList("system.appProcess.addAppProcessInfo", obj);
			this.commitTransation() ;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				this.endTransation() ;
			} catch (Exception e) {
				e.printStackTrace();
			}
		 }
		return 0;
	}

	/**
	 * 添加部门流程信息
	 * 
	 * @param obj
	 * @return
	 */ 
	@Override
	public int addAppProcessDInfo(Object obj) {
		try {
			this.insert("system.appProcess.addAppProcessInfo", obj);  
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	/**
	 * 添加部门流程信息
	 * 
	 * @param obj
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public int addAppProcessDInfo(List obj) { 
		try {
			this.startTransaction() ;
			this.updateForList("system.appProcess.updateAppDeptFlag", obj); 
			this.insertForList("system.appProcess.addAppProcessInfo", obj);
			this.commitTransation() ;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				this.endTransation() ;
			} catch (Exception e) {
				e.printStackTrace();
			}
		 }
		return 0;
	}

	/**
	 * 更新个人流程信息
	 * 
	 * @param obj
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public int updateAppProcessPInfo(Object obj) {

		try {
			this.startTransaction();

			Map paramMap = (Map) obj;
			List insertRolesGroupPageList = (List) paramMap
					.get("insertRolesGroupPageList");
			List deleteRolesGroupPageList = (List) paramMap
					.get("deleteRolesGroupPageList");

			this.update("system.rolesGroup.updateRolesGroupInfo", obj);

			this.deleteForList("system.rolesGroup.deleteRolesGroupPageInfo",
					deleteRolesGroupPageList);

			this.insertForList("system.rolesGroup.addRolesGroupPageInfo",
					insertRolesGroupPageList);

			this.commitTransation();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				this.endTransation();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return 0;
	}

	/**
	 * 更新个人流程信息
	 * 
	 * @param obj
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public int updateAppProcessPInfo(List obj) {

		try {
			this.updateForList("system.rolesGroup.updateRolesGroupInfo", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return 0;
	}

	/**
	 * 更新部门流程信息
	 * 
	 * @param obj
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public int updateAppProcessDInfo(Object obj) {

		try {
			this.startTransaction();

			Map paramMap = (Map) obj;
			List insertRolesGroupPageList = (List) paramMap
					.get("insertRolesGroupPageList");
			List deleteRolesGroupPageList = (List) paramMap
					.get("deleteRolesGroupPageList");

			this.update("system.rolesGroup.updateRolesGroupInfo", obj);

			this.deleteForList("system.rolesGroup.deleteRolesGroupPageInfo",
					deleteRolesGroupPageList);

			this.insertForList("system.rolesGroup.addRolesGroupPageInfo",
					insertRolesGroupPageList);

			this.commitTransation();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				this.endTransation();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return 0;
	}

	/**
	 * 更新部门流程信息
	 * 
	 * @param obj
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public int updateAppProcessDInfo(List obj) {

		try {
			this.updateForList("system.rolesGroup.updateRolesGroupInfo", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return 0;
	}

	/**
	 * 删除个人流程信息
	 * 
	 * @param obj
	 * @return
	 */
	@Override
	public int deleteAppProcessPInfo(Object obj) {
		try {  
			this.delete("system.appProcess.deleteAppProcessInfo", obj);
			this.update("system.appProcess.updateAppProcessPflag");
  
		} catch (SQLException e) {
			e.printStackTrace();
		}  
		return 0;
	}

	/**
	 * 删除个人流程信息
	 * 
	 * @param obj
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" }) 
	public int deleteAppProcessPInfo(List obj) { 
		try {  
			this.deleteForList("system.appProcess.deleteAppProcessInfo",obj); 
			this.update("system.appProcess.updateAppProcessPflag");
		} catch (SQLException e) {
			e.printStackTrace();
		}   
		return 0;
	}

	/**
	 * 删除部门流程信息
	 * 
	 * @param obj
	 * @return
	 */
	@Override
	public int deleteAppProcessDInfo(Object obj) {
		try {
			this.delete("system.appProcess.deleteAppProcessInfo",obj); 
			this.update("system.appProcess.updateAppProcessDflag");

		} catch (SQLException e) {
			e.printStackTrace();
		}  

		return 0;
	}

	/**
	 * 删除部门流程信息
	 * 
	 * @param obj
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" }) 
	public int deleteAppProcessDInfo(List obj) {

		try {
			this.deleteForList("system.appProcess.deleteAppProcessInfo",obj); 
			this.update("system.appProcess.updateAppProcessDflag");

		} catch (SQLException e) {
			e.printStackTrace();
		}  

		return 0;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List getSendEmailInfo(Object object) {
		List resultList = new ArrayList();
		try{
			resultList = this.queryForList("system.appProcess.getSendEmailInfo", object);
		}catch(SQLException e){
			e.printStackTrace();
		}
		return resultList;
	}
	@Override
	public int getSendEmailInfoCnt(Object object) {
		int result = 0;
		try{
			result = (Integer) this.queryForObject("system.appProcess.getSendEmailInfoCnt", object);
		}catch(SQLException e){
			e.printStackTrace();
		}
		return result;
	}
	@Override
	public void updateSendEmailInfo(Object object) throws SQLException {
		this.update("system.appProcess.updateSendEmailInfo",object);		
	}
	@Override
	public void addSendEmailInfo(Object object) throws SQLException {
		this.update("system.appProcess.addSendEmailInfo",object);		
	}
	@Override
	public void deleteSendEmailInfo(Object object) throws SQLException {
		this.update("system.appProcess.deleteSendEmailInfo",object);		
	}

}
