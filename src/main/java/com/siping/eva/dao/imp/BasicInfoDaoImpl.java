package com.siping.eva.dao.imp;

import java.sql.SQLException;
import java.util.ArrayList; 
import java.util.List; 

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;
 
import com.siping.eva.dao.BasicInfoDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class BasicInfoDaoImpl extends SqlMapClientSupport implements BasicInfoDao {

	Logger logger = Logger.getLogger(BasicInfoDaoImpl.class);
 
	/*
	 * 评价期间
	 * @param Object
	 * @return
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.BasicInfoDao#getEvaPeriodInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getEvaPeriodInfo(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"eva.infoBasic.getEvaPeriodInfo", object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}  
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.BasicInfoDao#getEvaPeriodInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getEvaPeriodInfo(Object object, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"eva.infoBasic.getEvaPeriodInfo", object,
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
	 * @see com.siping.eva.dao.BasicInfoDao#getEvaPeriodInfoCnt(java.lang.Object)
	 */
	@Override
	public int getEvaPeriodInfoCnt(Object object) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("eva.infoBasic.getEvaPeriodInfoCnt",
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
	 * @see com.siping.eva.dao.BasicInfoDao#addEvaPeriodInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int addEvaPeriodInfo(List obj) {
		int returnInt = 0;
		try {
			this.insertForList("eva.infoBasic.addEvaPeriodInfo", obj) ;
			
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
	 * @see com.siping.eva.dao.BasicInfoDao#updateEvaPeriodInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int updateEvaPeriodInfo(List obj) {
		int returnInt = 0;
		try {
			this.insertForList("eva.infoBasic.updateEvaPeriodInfo", obj) ;
			
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
	 * @see com.siping.eva.dao.BasicInfoDao#deleteEvaPeriodInfo(java.lang.Object)
	 */
	@Override
	public int deleteEvaPeriodInfo(Object obj) {
		int returnInt = 0;
		try {
			this.delete("eva.infoBasic.deleteEvaPeriodInfo", obj) ;
			
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
	 * 评价类型
	 * @param Object
	 * @return
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.BasicInfoDao#getEvaPeriodTypeInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getEvaPeriodTypeInfo(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"eva.infoBasic.getEvaPeriodTypeInfo", object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}  
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.BasicInfoDao#getEvaPeriodTypeInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getEvaPeriodTypeInfo(Object object, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"eva.infoBasic.getEvaPeriodTypeInfo", object,
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
	 * @see com.siping.eva.dao.BasicInfoDao#getEvaPeriodTypeInfoCnt(java.lang.Object)
	 */
	@Override
	public int getEvaPeriodTypeInfoCnt(Object object) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("eva.infoBasic.getEvaPeriodTypeInfoCnt",
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
	 * @see com.siping.eva.dao.BasicInfoDao#addEvaPeriodTypeInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int addEvaPeriodTypeInfo(List obj) {
		int returnInt = 0;
		try {
			this.insertForList("eva.infoBasic.addEvaPeriodTypeInfo", obj) ;
			
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
	 * @see com.siping.eva.dao.BasicInfoDao#updateEvaPeriodTypeInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int updateEvaPeriodTypeInfo(List obj) {
		int returnInt = 0;
		try {
			this.insertForList("eva.infoBasic.updateEvaPeriodTypeInfo", obj) ;
			
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
	 * @see com.siping.eva.dao.BasicInfoDao#deleteEvaPeriodTypeInfo(java.lang.Object)
	 */
	@Override
	public int deleteEvaPeriodTypeInfo(Object obj) {
		int returnInt = 0;
		try {
			this.delete("eva.infoBasic.deleteEvaPeriodTypeInfo", obj) ;
			
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
	 * 评价类型项目
	 * @param Object
	 * @return
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.BasicInfoDao#getEvaPeriodTypeItemInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getEvaPeriodTypeItemInfo(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"eva.infoBasic.getEvaPeriodTypeItemInfo", object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}  
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.BasicInfoDao#getEvaPeriodTypeItemInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getEvaPeriodTypeItemInfo(Object object, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"eva.infoBasic.getEvaPeriodTypeItemInfo", object,
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
	 * @see com.siping.eva.dao.BasicInfoDao#getEvaPeriodTypeItemInfoCnt(java.lang.Object)
	 */
	@Override
	public int getEvaPeriodTypeItemInfoCnt(Object object) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("eva.infoBasic.getEvaPeriodTypeItemInfoCnt",
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
	 * @see com.siping.eva.dao.BasicInfoDao#addEvaPeriodTypeItemInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int addEvaPeriodTypeItemInfo(List obj) {
		int returnInt = 0;
		try {
			this.insertForList("eva.infoBasic.addEvaPeriodTypeItemInfo", obj) ;
			
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
	 * @see com.siping.eva.dao.BasicInfoDao#updateEvaPeriodTypeItemInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int updateEvaPeriodTypeItemInfo(List obj) {
		int returnInt = 0;
		try {
			this.insertForList("eva.infoBasic.updateEvaPeriodTypeItemInfo", obj) ;
			
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
	 * @see com.siping.eva.dao.BasicInfoDao#deleteEvaPeriodTypeItemInfo(java.lang.Object)
	 */
	@Override
	public int deleteEvaPeriodTypeItemInfo(Object obj) {
		int returnInt = 0;
		try {
			this.delete("eva.infoBasic.deleteEvaPeriodTypeItemInfo", obj) ;
			
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
	 * 评价类型流程
	 * @param Object
	 * @return
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.BasicInfoDao#getEvaTypeProcessInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getEvaTypeProcessInfo(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"eva.infoBasic.getEvaTypeProcessInfo", object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}  
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.BasicInfoDao#getEvaTypeProcessInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getEvaTypeProcessInfo(Object object, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"eva.infoBasic.getEvaTypeProcessInfo", object,
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
	 * @see com.siping.eva.dao.BasicInfoDao#getEvaTypeProcessInfoCnt(java.lang.Object)
	 */
	@Override
	public int getEvaTypeProcessInfoCnt(Object object) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("eva.infoBasic.getEvaTypeProcessInfoCnt",
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
	 * @see com.siping.eva.dao.BasicInfoDao#addEvaTypeProcessInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int addEvaTypeProcessInfo(List obj) {
		int returnInt = 0;
		try {
			this.insertForList("eva.infoBasic.addEvaTypeProcessInfo", obj) ;
			
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
	 * @see com.siping.eva.dao.BasicInfoDao#updateEvaTypeProcessInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int updateEvaTypeProcessInfo(List obj) {
		int returnInt = 0;
		try {
			this.insertForList("eva.infoBasic.updateEvaTypeProcessInfo", obj) ;
			
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
	 * @see com.siping.eva.dao.BasicInfoDao#updateEvaTypeProcessOrderInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int updateEvaTypeProcessOrderInfo(List obj) {
		int returnInt = 0;
		try {
			this.insertForList("eva.infoBasic.updateEvaTypeProcessOrderInfo", obj) ;
			
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
	 * @see com.siping.eva.dao.BasicInfoDao#deleteEvaTypeProcessInfo(java.lang.Object)
	 */
	@Override
	public int deleteEvaTypeProcessInfo(Object obj) {
		int returnInt = 0;
		try {
			this.delete("eva.infoBasic.deleteEvaTypeProcessInfo", obj) ;
			
		} catch (SQLException e) {	
			returnInt = 1;
			e.printStackTrace();
		} catch (Exception e) {	
			returnInt = 1;
			e.printStackTrace();
		}
		
		return returnInt ;
	} 
}
