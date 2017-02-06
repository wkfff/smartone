package com.siping.eva.dao.imp;

import java.sql.SQLException;
import java.util.ArrayList; 
import java.util.LinkedHashMap;
import java.util.List; 

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;
  
import com.siping.eva.dao.KPIDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class KPIDaoImpl extends SqlMapClientSupport implements KPIDao {

	Logger logger = Logger.getLogger(KPIDaoImpl.class);
 
	/*
	 * 计划
	 * @param Object
	 * @return
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#getEvaKPIInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getEvaKPIInfo(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"eva.kpi.getEvaKPIInfo", object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}  
	/*
	 * 计划
	 * @param Object
	 * @return
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#getKPIScoreDetail(java.lang.Object)
	 */
	@Override
	public Object getKPIScoreDetail(Object object) {
		Object returnMap = null;
		try {
			returnMap = this.queryForObject(
					"eva.kpi.getKPIScoreDetail", object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnMap;
	} 
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#getEvaKPIInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getEvaKPIInfo(Object object, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"eva.kpi.getEvaKPIInfo", object,
					currentPage, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}  
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#getEvaKPIInfoCnt(java.lang.Object)
	 */
	@Override
	public int getEvaKPIInfoCnt(Object object) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("eva.kpi.getEvaKPIInfoCnt",
							object)), Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnInt;
	} 
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#checkEvaEmpEveInfo(java.lang.Object)
	 */
	@Override
	public int checkEvaEmpEveInfo(Object object) {
		int returnInt = 1;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("eva.kpi.checkEvaEmpEveInfo",
							object)), Integer.class);

		} catch (SQLException e) {
			returnInt = 1;
			e.printStackTrace();
		} catch (Exception e) {
			returnInt = 1;
			e.printStackTrace();
		}

		return returnInt;
	} 
	
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#addEvaEmpEveInfo(java.lang.Object)
	 */
	@Override 
	public int addEvaEmpEveInfo(Object obj) {
		int returnInt = 0;
		try {
			this.insert("eva.kpi.addEvaEmpEveInfo", obj) ;
			
		} catch (SQLException e) {	
			returnInt = 1;
			e.printStackTrace();
		} catch (Exception e) {	
			returnInt = 1;
			e.printStackTrace();
		}
		
		return returnInt ;
	}
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#addEvaEmpWorkInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int addEvaEmpWorkInfo(List obj) {
		int returnInt = 0;
		try {
			this.insertForList("eva.kpi.addEvaEmpWorkInfo", obj) ;
			
		} catch (SQLException e) {	
			returnInt = 1;
			e.printStackTrace();
		} catch (Exception e) {	
			returnInt = 1;
			e.printStackTrace();
		}
		
		return returnInt ;
	}
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#updateEvaEmpWorkInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int updateEvaEmpWorkInfo(List obj) {
		int returnInt = 0;
		try {
			this.updateForList("eva.kpi.updateEvaEmpWorkInfo", obj) ;
			
		} catch (SQLException e) {	
			returnInt = 1;
			e.printStackTrace();
		} catch (Exception e) {	
			returnInt = 1;
			e.printStackTrace();
		}
		
		return returnInt ;
	} 
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#updateEvaKPIScore(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int updateEvaKPIScore(List obj) {
		int returnInt = 0;
		try {
			this.updateForList("eva.kpi.updateEvaKPIScore", obj) ;
			
		} catch (SQLException e) {	
			returnInt = 1;
			e.printStackTrace();
		} catch (Exception e) {	
			returnInt = 1;
			e.printStackTrace();
		}
		
		return returnInt ;
	} 
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#updateEssEmpOngoingWorkInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int updateEssEmpOngoingWorkInfo(List obj) {
		int returnInt = 0;
		try {
			this.updateForList("eva.kpi.updateEssEmpOngoingWorkInfo", obj) ;
			
		} catch (SQLException e) {	
			returnInt = 1;
			e.printStackTrace();
		} catch (Exception e) {	
			returnInt = 1;
			e.printStackTrace();
		}
		
		return returnInt ;
	}
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#updateEssWorkFlagInfo(java.lang.Object)
	 */
	@Override 
	public int updateEssWorkFlagInfo(Object obj) {
		int returnInt = 0;
		try {
			this.update("eva.kpi.updateEssWorkFlagInfo", obj) ;
			
		} catch (SQLException e) {	
			returnInt = 1;
			e.printStackTrace();
		} catch (Exception e) {	
			returnInt = 1;
			e.printStackTrace();
		}
		
		return returnInt ;
	}
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#updateEssItemFlagInfo(java.lang.Object)
	 */
	@Override 
	public int updateEssItemFlagInfo(Object obj) {
		int returnInt = 0;
		try {
			this.update("eva.kpi.updateEssItemFlagInfo", obj) ;
			
		} catch (SQLException e) {	
			returnInt = 1;
			e.printStackTrace();
		} catch (Exception e) {	
			returnInt = 1;
			e.printStackTrace();
		}
		
		return returnInt ;
	}
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#updateEvaItemFlagInfo(java.lang.Object)
	 */
	@Override 
	public int updateEvaItemFlagInfo(Object obj) {
		int returnInt = 0;
		try {
			this.update("eva.kpi.updateEvaItemFlagInfo", obj) ;
			
		} catch (SQLException e) {	
			returnInt = 1;
			e.printStackTrace();
		} catch (Exception e) {	
			returnInt = 1;
			e.printStackTrace();
		}
		
		return returnInt ;
	}
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#deleteEvaKPIInfo(java.lang.Object)
	 */
	@Override
	public int deleteEvaKPIInfo(Object obj) {
		int returnInt = 0;
		try {
			this.delete("eva.kpi.deleteEvaKPIInfo", obj) ;
			
		} catch (SQLException e) {	
			returnInt = 1;
			e.printStackTrace();
		} catch (Exception e) {	
			returnInt = 1;
			e.printStackTrace();
		}
		
		return returnInt ;
	}  
	/*
	 * 评价项目
	 * @param Object
	 * @return
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#getKPIScoreListByKPI(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getKPIScoreListByKPI(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"eva.kpi.getKPIScoreListByKPI", object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}  
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#getKPIScoreListByKPI(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getKPIScoreListByKPI(Object object, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"eva.kpi.getKPIScoreListByKPI", object,
					currentPage, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}  
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#getKPIScoreListByKPICnt(java.lang.Object)
	 */
	@Override
	public int getKPIScoreListByKPICnt(Object object) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("eva.kpi.getKPIScoreListByKPICnt",
							object)), Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnInt;
	}   
	
	/*
	 * 评价项目
	 * @param Object
	 * @return
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#getKPIScoreListByKPI(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getKPIScoreListByEmployee(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"eva.kpi.getKPIScoreListByKPI", object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}  
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#getKPIScoreListByKPI(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getKPIScoreListByEmployee(Object object, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"eva.kpi.getKPIScoreListByKPI", object,
					currentPage, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}  
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#getKPIScoreListByKPICnt(java.lang.Object)
	 */
	@Override
	public int getKPIScoreListByEmployeeCnt(Object object) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("eva.kpi.getKPIScoreListByKPICnt",
							object)), Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnInt;
	} 
	
	
	
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#addEvaKPIInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int addEvaKPIInfo(List obj) {
		int returnInt = 0;
		try {
			this.insertForList("eva.kpi.addEvaKPIInfo", obj) ;
			
		} catch (SQLException e) {	
			returnInt = 1;
			e.printStackTrace();
		} catch (Exception e) {	
			returnInt = 1;
			e.printStackTrace();
		}
		
		return returnInt ;
	}
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#updateEvaKPIInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int updateEvaKPIInfo(List obj) {
		int returnInt = 0;
		try {
			this.updateForList("eva.kpi.updateEvaKPIInfo", obj) ;
			
		} catch (SQLException e) {	
			returnInt = 1;
			e.printStackTrace();
		} catch (Exception e) {	
			returnInt = 1;
			e.printStackTrace();
		}
		
		return returnInt ;
	} 
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#addEvaKPIScore(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int addEvaKPIScore(List obj) {
		int returnInt = 0;
		try {
			this.updateForList("eva.kpi.addEvaKPIScore", obj) ;
			
		} catch (SQLException e) {	
			returnInt = 1;
			e.printStackTrace();
		} catch (Exception e) {	
			returnInt = 1;
			e.printStackTrace();
		}
		
		return returnInt ;
	}
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#updateEssEmpOngoingItemInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int updateEssEmpOngoingItemInfo(List obj) {
		int returnInt = 0;
		try {
			this.updateForList("eva.kpi.updateEssEmpOngoingItemInfo", obj) ;
			
		} catch (SQLException e) {	
			returnInt = 1;
			e.printStackTrace();
		} catch (Exception e) {	
			returnInt = 1;
			e.printStackTrace();
		}
		
		return returnInt ;
	}
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.KPIDao#deleteEvaEmpItemInfo(java.lang.Object)
	 */
	@Override
	public int deleteEvaEmpItemInfo(Object obj) {
		int returnInt = 0;
		try {
			this.delete("eva.kpi.deleteEvaEmpItemInfo", obj) ;
			
		} catch (SQLException e) {	
			returnInt = 1;
			e.printStackTrace();
		} catch (Exception e) {	
			returnInt = 1;
			e.printStackTrace();
		}
		
		return returnInt ;
	}
	@SuppressWarnings("rawtypes")
	public List getEvaKpiTypeInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("eva.myKpi.getEvaKpiTypeInfo",obj);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}

	/**
	 * 取得所有工资输入项目信息列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getEvaKpiTypeInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("eva.myKpi.getEvaKpiTypeInfo",
				obj, currentPage, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}

	public int getEvaKpiTypeInfoCnt(Object obj) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(
				ObjectUtils.toString(this.queryForObject(
					"eva.myKpi.getEvaKpiTypeInfoCnt", obj)),
						Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List getEvaKpiItemInfo(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("eva.myKpi.getEvaKpiItemInfo",object);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List getEvaKpiItemInfo(Object object, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("eva.myKpi.getEvaKpiItemInfo",
				object, currentPage, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}
	@Override
	public int getEvaKpiItemInfoCnt(Object object) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(
				ObjectUtils.toString(this.queryForObject(
					"eva.myKpi.getEvaKpiItemInfoCnt", object)),
						Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public void addKpiTypeInfo(List objList) throws SQLException {
		this.insertForList("eva.myKpi.addKpiTypeInfo", objList);
	}
	@SuppressWarnings("rawtypes")
	@Override
	public void updateKpiTypeInfo(List objList) throws SQLException {
		this.updateForList("eva.myKpi.updateKpiTypeInfo", objList);
	}
	@Override
	public int checkDeleteKpiTypeInfo(Object object) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(this.queryForObject("eva.myKpi.checkDeleteKpiTypeInfo", object).toString(),
				Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}
	@Override
	public String deleteKpiTypeInfo(Object object) throws SQLException {
		String resultString = "Y";
		try {
			this.startTransaction(); 
			//this.delete("eva.myKpi.deletePaInputItemDataInfo", object);
			this.delete("eva.myKpi.deleteKpiTypeInfo", object);
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
	public int addKpiItemInfo(Object object) {
		int returnInt = 1;
		try {
			this.insert("eva.myKpi.addKpiItemInfo", object);
		} catch (SQLException e) {
			returnInt = 1;
			e.printStackTrace();
		} catch (Exception e) {
			returnInt = 1;
			e.printStackTrace();
		}
		return returnInt;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public String deleteKpiItemInfo(List objlist) {
		String resultString = "Y";
		try {
			this.startTransaction();
			this.deleteForList("eva.myKpi.deleteKpiItemInfo", objlist);
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
	public String updateKpiItemInfo(List objlist) {
		String resultString = "Y";
		try { 
			this.startTransaction();
			this.updateForList("eva.myKpi.updateKpiItemInfo",objlist);
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
	public List getKpiItemByMonth(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("eva.myKpi.getKpiItemByMonth",object);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List getKpiItemByMonth(Object object, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("eva.myKpi.getKpiItemByMonth",
				object, currentPage, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}
	@Override
	public int getKpiItemByMonthCnt(Object object) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(
				ObjectUtils.toString(this.queryForObject(
					"eva.myKpi.getKpiItemByMonthCnt", object)),
						Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List getEvaKpiItemInfoUnused(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("eva.myKpi.getEvaKpiItemInfoUnused",object);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List getEvaKpiItemInfoUnused(Object object, int currentPage,
			int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("eva.myKpi.getEvaKpiItemInfoUnused",
				object, currentPage, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}
	@Override
	public int getEvaKpiItemInfoCntUnused(Object object) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(
				ObjectUtils.toString(this.queryForObject(
					"eva.myKpi.getEvaKpiItemInfoCntUnused", object)),
						Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public String addKpiBevalidaterInfo(List objlist) {
		String resultString = "Y";
		try { 
			this.startTransaction();
			this.insertForList("eva.myKpi.addKpiBevalidaterInfo",objlist);
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
	public String deleteDistriKpiItemInfo(List objlist) {
		String resultString = "Y";
		try {
			this.startTransaction();
			this.deleteForList("eva.myKpi.deleteDistriKpiItemInfo", objlist);
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
	public int checkKpiItemDis(Object object) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(this.queryForObject("eva.myKpi.checkKpiItemDis", object).toString(),
				Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List getKpiItemManager(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("eva.myKpi.getKpiItemManager",object);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List getKpiItemManager(Object object, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("eva.myKpi.getKpiItemManager",
				object, currentPage, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}
	@Override
	public int getKpiItemManagerCnt(Object object) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(
				ObjectUtils.toString(this.queryForObject(
					"eva.myKpi.getKpiItemManagerCnt", object)),
						Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public void addKpiManagerInfo(List objlist) {
		try {
			this.insertForList("eva.myKpi.addKpiManagerInfo", objlist);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	@SuppressWarnings("rawtypes")
	@Override
	public String deleteKpiManagerInfo(List objlist) {
		String resultString = "Y";
		try {
			this.startTransaction();
			this.deleteForList("eva.myKpi.deleteKpiManagerInfo", objlist);
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
	public String addKpiScoreInfo(List objlist) {
		String resultString = "Y";
		try {
			this.startTransaction();
			this.insertForList("eva.myKpi.addKpiScoreInfo", objlist);
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
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List<LinkedHashMap> getDataScoreByExcel(Object obj) {
		List returnList = new ArrayList();
		LinkedHashMap paramMap = (LinkedHashMap) obj;
		try {
			returnList = this.queryForList(
					"eva.myKpi.getDataScoreByExcel", paramMap);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List getKpiItemByMonthIsScore(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("eva.myKpi.getKpiItemByMonthIsScore",object);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List getKpiItemByMonthIsScore(Object object, int currentPage,
			int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("eva.myKpi.getKpiItemByMonthIsScore",
				object, currentPage, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}
	@Override
	public int getKpiItemByMonthCntIsScore(Object object) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(
				ObjectUtils.toString(this.queryForObject(
					"eva.myKpi.getKpiItemByMonthCntIsScore", object)),
						Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List getEvaKpiItemInfoUnusedManager(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("eva.myKpi.getEvaKpiItemInfoUnusedManager",object);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List getEvaKpiItemInfoUnusedManager(Object object, int currentPage,
			int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("eva.myKpi.getEvaKpiItemInfoUnusedManager",
				object, currentPage, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}
	@Override
	public int getEvaKpiItemInfoCntUnusedManager(Object object) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(
				ObjectUtils.toString(this.queryForObject(
					"eva.myKpi.getEvaKpiItemInfoCntUnusedManager", object)),
						Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}
}
