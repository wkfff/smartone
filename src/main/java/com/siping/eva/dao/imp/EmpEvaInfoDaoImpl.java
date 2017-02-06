package com.siping.eva.dao.imp;

import java.sql.SQLException;
import java.util.ArrayList; 
import java.util.List; 

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;
  
import com.siping.eva.dao.EmpEvaInfoDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class EmpEvaInfoDaoImpl extends SqlMapClientSupport implements EmpEvaInfoDao {

	Logger logger = Logger.getLogger(EmpEvaInfoDaoImpl.class);
 
	/*
	 * 计划
	 * @param Object
	 * @return
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.EmpEvaInfoDao#getEvaEmpWorkInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getEvaEmpWorkInfo(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"eva.infoEmpEva.getEvaEmpWorkInfo", object);
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
	 * @see com.siping.eva.dao.EmpEvaInfoDao#getEvaEmpEveInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getEvaEmpEveInfo(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"eva.infoEmpEva.getEvaEmpEveInfo", object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	} 
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.EmpEvaInfoDao#getEvaEmpWorkInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getEvaEmpWorkInfo(Object object, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"eva.infoEmpEva.getEvaEmpWorkInfo", object,
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
	 * @see com.siping.eva.dao.EmpEvaInfoDao#getEvaEmpWorkInfoCnt(java.lang.Object)
	 */
	@Override
	public int getEvaEmpWorkInfoCnt(Object object) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("eva.infoEmpEva.getEvaEmpWorkInfoCnt",
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
	 * @see com.siping.eva.dao.EmpEvaInfoDao#checkEvaEmpEveInfo(java.lang.Object)
	 */
	@Override
	public int checkEvaEmpEveInfo(Object object) {
		int returnInt = 1;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("eva.infoEmpEva.checkEvaEmpEveInfo",
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
	 * @see com.siping.eva.dao.EmpEvaInfoDao#addEvaEmpEveInfo(java.lang.Object)
	 */
	@Override 
	public int addEvaEmpEveInfo(Object obj) {
		int returnInt = 0;
		try {
			this.insert("eva.infoEmpEva.addEvaEmpEveInfo", obj) ;
			
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
	 * @see com.siping.eva.dao.EmpEvaInfoDao#addEvaEmpWorkInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int addEvaEmpWorkInfo(List obj) {
		int returnInt = 0;
		try {
			this.insertForList("eva.infoEmpEva.addEvaEmpWorkInfo", obj) ;
			
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
	 * @see com.siping.eva.dao.EmpEvaInfoDao#updateEvaEmpWorkInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int updateEvaEmpWorkInfo(List obj) {
		int returnInt = 0;
		try {
			this.updateForList("eva.infoEmpEva.updateEvaEmpWorkInfo", obj) ;
			
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
	 * @see com.siping.eva.dao.EmpEvaInfoDao#updateEvaEmpOngoingWorkInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int updateEvaEmpOngoingWorkInfo(List obj) {
		int returnInt = 0;
		try {
			this.updateForList("eva.infoEmpEva.updateEvaEmpOngoingWorkInfo", obj) ;
			
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
	 * @see com.siping.eva.dao.EmpEvaInfoDao#updateEssEmpOngoingWorkInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int updateEssEmpOngoingWorkInfo(List obj) {
		int returnInt = 0;
		try {
			this.updateForList("eva.infoEmpEva.updateEssEmpOngoingWorkInfo", obj) ;
			
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
	 * @see com.siping.eva.dao.EmpEvaInfoDao#updateEssWorkFlagInfo(java.lang.Object)
	 */
	@Override 
	public int updateEssWorkFlagInfo(Object obj) {
		int returnInt = 0;
		try {
			this.update("eva.infoEmpEva.updateEssWorkFlagInfo", obj) ;
			
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
	 * @see com.siping.eva.dao.EmpEvaInfoDao#updateEssItemFlagInfo(java.lang.Object)
	 */
	@Override 
	public int updateEssItemFlagInfo(Object obj) {
		int returnInt = 0;
		try {
			this.update("eva.infoEmpEva.updateEssItemFlagInfo", obj) ;
			
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
	 * @see com.siping.eva.dao.EmpEvaInfoDao#updateEvaItemFlagInfo(java.lang.Object)
	 */
	@Override 
	public int updateEvaItemFlagInfo(Object obj) {
		int returnInt = 0;
		try {
			this.update("eva.infoEmpEva.updateEvaItemFlagInfo", obj) ;
			
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
	 * @see com.siping.eva.dao.EmpEvaInfoDao#deleteEvaEmpWorkInfo(java.lang.Object)
	 */
	@Override
	public int deleteEvaEmpWorkInfo(Object obj) {
		int returnInt = 0;
		try {
			this.delete("eva.infoEmpEva.deleteEvaEmpWorkInfo", obj) ;
			
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
	 * @see com.siping.eva.dao.EmpEvaInfoDao#getEvaEmpItemInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getEvaEmpItemInfo(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"eva.infoEmpEva.getEvaEmpItemInfo", object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}  
	/*
	 * (non-Javadoc)
	 * @see com.siping.eva.dao.EmpEvaInfoDao#getEvaEmpItemInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getEvaEmpItemInfo(Object object, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"eva.infoEmpEva.getEvaEmpItemInfo", object,
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
	 * @see com.siping.eva.dao.EmpEvaInfoDao#getEvaEmpItemInfoCnt(java.lang.Object)
	 */
	@Override
	public int getEvaEmpItemInfoCnt(Object object) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("eva.infoEmpEva.getEvaEmpItemInfoCnt",
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
	 * @see com.siping.eva.dao.EmpEvaInfoDao#addEvaEmpItemInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int addEvaEmpItemInfo(List obj) {
		int returnInt = 0;
		try {
			this.insertForList("eva.infoEmpEva.addEvaEmpItemInfo", obj) ;
			
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
	 * @see com.siping.eva.dao.EmpEvaInfoDao#updateEvaEmpItemInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int updateEvaEmpItemInfo(List obj) {
		int returnInt = 0;
		try {
			this.updateForList("eva.infoEmpEva.updateEvaEmpItemInfo", obj) ;
			
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
	 * @see com.siping.eva.dao.EmpEvaInfoDao#updateEvaEmpOngoingItemInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int updateEvaEmpOngoingItemInfo(List obj) {
		int returnInt = 0;
		try {
			this.updateForList("eva.infoEmpEva.updateEvaEmpOngoingItemInfo", obj) ;
			
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
	 * @see com.siping.eva.dao.EmpEvaInfoDao#updateEssEmpOngoingItemInfo(java.lang.Object)
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public int updateEssEmpOngoingItemInfo(List obj) {
		int returnInt = 0;
		try {
			this.updateForList("eva.infoEmpEva.updateEssEmpOngoingItemInfo", obj) ;
			
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
	 * @see com.siping.eva.dao.EmpEvaInfoDao#deleteEvaEmpItemInfo(java.lang.Object)
	 */
	@Override
	public int deleteEvaEmpItemInfo(Object obj) {
		int returnInt = 0;
		try {
			this.delete("eva.infoEmpEva.deleteEvaEmpItemInfo", obj) ;
			
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
