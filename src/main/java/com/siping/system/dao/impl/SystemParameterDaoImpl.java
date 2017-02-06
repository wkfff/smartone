package com.siping.system.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList; 
import java.util.List; 

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;
 

















import com.siping.system.dao.SystemParameterDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class SystemParameterDaoImpl extends SqlMapClientSupport implements
			SystemParameterDao {
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.system.dao.SystemParameterDao#getModuleParameterInfo(java.lang
	 * .Object)
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getModuleParameterInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"system.systemParameter.getModuleParameterInfo", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}
	@SuppressWarnings({ "rawtypes" })
	public List getModuleParameterInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"system.systemParameter.getModuleParameterInfo", obj,
					currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}
	public int getModuleParameterInfoCnt(Object object) {
		int i = 0;
		try { 
			i = NumberUtils
					.parseNumber(
							ObjectUtils.toString(this
									.queryForObject(
											"system.systemParameter.getModuleParameterInfoCnt",
											object)), Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return i;
	}
	  
	public int addModuleParameterInfo(Object object) {
		int result = 0;
		try {
			this.insert("system.systemParameter.addModuleParameterInfo",
					object);
			result = 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	@SuppressWarnings("rawtypes")
	public int addModuleParameterInfo(List objList) {
		int result = 0;
		try {
			this.insertForList(
					"system.systemParameter.addModuleParameterInfo", objList);
			result = 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public int updateModuleParameterInfo(Object object) {
		int result = 0;
		try {
			this.update("system.systemParameter.updateModuleParameterInfo",
					object);
			result = 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	@SuppressWarnings("rawtypes")
	public int updateModuleParameterInfo(List objList) {
		int result = 0;
		try {
			this.updateForList(
					"system.systemParameter.updateModuleParameterInfo",
					objList);
			result = 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public String deleteModuleParameterInfo(Object object) {
		String result = "Y"; 
		try { 
			this.delete("system.systemParameter.deleteModuleParameterInfo",
					object); 
		} catch (SQLException e) {
			e.printStackTrace();
			result = e.getMessage();
		}  
		return result;
	}

	@SuppressWarnings("rawtypes")
	public String deleteModuleParameterInfo(List objList) {
		String result = "Y"; 
		try { 
			this.deleteForList("system.systemParameter.deleteModuleParameterInfo",
					objList); 
		} catch (SQLException e) {
			e.printStackTrace();
			result = e.getMessage();
		}  
		return result;
	} 
	
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.system.dao.SystemParameterDao#getLeaveAppParameterInfo(java.lang
	 * .Object)
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getLeaveAppParameterInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"system.systemParameter.getLeaveAppParameterInfo", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}
	@SuppressWarnings({ "rawtypes" })
	public List getLeaveAppParameterInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"system.systemParameter.getLeaveAppParameterInfo", obj,
					currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}
	public int getLeaveAppParameterInfoCnt(Object object) {
		int i = 0;
		try { 
			i = NumberUtils
					.parseNumber(
							ObjectUtils.toString(this
									.queryForObject(
											"system.systemParameter.getLeaveAppParameterInfoCnt",
											object)), Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return i;
	}
	  
	public int addLeaveAppParameterInfo(Object object) {
		int result = 0;
		try {
			this.insert("system.systemParameter.addLeaveAppParameterInfo",
					object);
			result = 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	@SuppressWarnings("rawtypes")
	public int addLeaveAppParameterInfo(List objList) {
		int result = 0;
		try {
			this.insertForList(
					"system.systemParameter.addLeaveAppParameterInfo", objList);
			result = 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public int updateLeaveAppParameterInfo(Object object) {
		int result = 0;
		try {
			this.update("system.systemParameter.updateLeaveAppParameterInfo",
					object);
			result = 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	@SuppressWarnings("rawtypes")
	public int updateLeaveAppParameterInfo(List objList) {
		int result = 0;
		try {
			this.updateForList(
					"system.systemParameter.updateLeaveAppParameterInfo",
					objList);
			result = 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public String deleteLeaveAppParameterInfo(Object object) {
		String result = "Y"; 
		try { 
			this.delete("system.systemParameter.deleteLeaveAppParameterInfo",
					object); 
		} catch (SQLException e) {
			e.printStackTrace();
			result = e.getMessage();
		}  
		return result;
	}

	@SuppressWarnings("rawtypes")
	public String deleteLeaveAppParameterInfo(List objList) {
		String result = "Y"; 
		try { 
			this.deleteForList("system.systemParameter.deleteLeaveAppParameterInfo",
					objList);  
		} catch (SQLException e) {
			e.printStackTrace();
			result = e.getMessage();
		}  
		return result;
	} 
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.system.dao.SystemParameterDao#getOTAppParameterInfo(java.lang
	 * .Object)
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getOTAppParameterInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"system.systemParameter.getOTAppParameterInfo", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}
	@SuppressWarnings({ "rawtypes" })
	public List getOTAppParameterInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"system.systemParameter.getOTAppParameterInfo", obj,
					currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}
	public int getOTAppParameterInfoCnt(Object object) {
		int i = 0;
		try { 
			i = NumberUtils
					.parseNumber(
							ObjectUtils.toString(this
									.queryForObject(
											"system.systemParameter.getOTAppParameterInfoCnt",
											object)), Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return i;
	}
	  
	public int addOTAppParameterInfo(Object object) {
		int result = 0;
		try {
			this.insert("system.systemParameter.addOTAppParameterInfo",
					object);
			result = 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	@SuppressWarnings("rawtypes")
	public int addOTAppParameterInfo(List objList) {
		int result = 0;
		try {
			this.insertForList(
					"system.systemParameter.addOTAppParameterInfo", objList);
			result = 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public int updateOTAppParameterInfo(Object object) {
		int result = 0;
		try {
			this.update("system.systemParameter.updateOTAppParameterInfo",
					object);
			result = 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	@SuppressWarnings("rawtypes")
	public int updateOTAppParameterInfo(List objList) {
		int result = 0;
		try {
			this.updateForList(
					"system.systemParameter.updateOTAppParameterInfo",
					objList);
			result = 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public String deleteOTAppParameterInfo(Object object) {
		String result = "Y"; 
		try { 
			this.delete("system.systemParameter.deleteOTAppParameterInfo",
					object); 
		} catch (SQLException e) {
			e.printStackTrace();
			result = e.getMessage();
		}  
		return result;
	}

	@SuppressWarnings("rawtypes")
	public String deleteOTAppParameterInfo(List objList) {
		String result = "Y"; 
		try { 
			this.deleteForList("system.systemParameter.deleteOTAppParameterInfo",
					objList); 
		} catch (SQLException e) {
			e.printStackTrace();
			result = e.getMessage();
		}  
		return result;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List getSliceTypeParameter(Object object, int currentPage,
			int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"system.systemParameter.getSliceTypeParameter", object,
					currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}
	@Override
	public int getSliceTypeParameterCnt(Object object) {
		int i = 0;
		try { 
			i = NumberUtils
					.parseNumber(
							ObjectUtils.toString(this
									.queryForObject(
											"system.systemParameter.getSliceTypeParameterCnt",
											object)), Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return i;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List getSliceTypeParameter(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"system.systemParameter.getSliceTypeParameter", object);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List getSliceTypeDetail(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"system.systemParameter.getSliceTypeDetail", object);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List getSliceTypeDetail(Object object, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"system.systemParameter.getSliceTypeDetail", object,
					currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}
	@Override
	public int getSliceTypeDetailCnt(Object object) {
		int i = 0;
		try { 
			i = NumberUtils
					.parseNumber(
							ObjectUtils.toString(this
									.queryForObject(
											"system.systemParameter.getSliceTypeDetailCnt",
											object)), Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return i;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public int addSliceTypeParameter(List objList) {
		int result = 0;
		try {
			this.insertForList(
					"system.systemParameter.addSliceTypeParameter", objList);
			result = 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	@Override
	public int updateSliceTypeParameter(Object object) {
		int result = 0;
		try {
			this.update("system.systemParameter.updateSliceTypeParameter",
					object);
			result = 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public int updateSliceTypeParameter(List objList) {
		int result = 0;
		try {
			this.updateForList(
					"system.systemParameter.updateSliceTypeParameter",
					objList);
			result = 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	@Override
	public String deleteSliceTypeParameter(Object object) {
		String result = "Y"; 
		try { 
			this.delete("system.systemParameter.deleteSliceTypeParameter",
					object); 
		} catch (SQLException e) {
			e.printStackTrace();
			result = e.getMessage();
		}  
		return result;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public int deleteSliceTypeParameter(List objList) {
		int result = 0; 
		try { 
			this.deleteForList("system.systemParameter.deleteSliceTypeParameter",
					objList); 
			result = 1; 
		} catch (SQLException e) {
			e.printStackTrace();

		}  
		return result;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public int addSliceTypeDetail(List objList) {
		int result = 0;
		try {
			this.insertForList(
					"system.systemParameter.addSliceTypeDetail", objList);
			result = 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public int updateSliceTypeDetail(List objList) {
		int result = 0;
		try {
			this.updateForList(
					"system.systemParameter.updateSliceTypeDetail",
					objList);
			result = 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	@Override
	public String deleteSliceTypeDetail(Object object) {
		String result = "Y"; 
		try { 
			this.delete("system.systemParameter.deleteSliceTypeDetail",
					object);  
		} catch (SQLException e) {
			e.printStackTrace();
			result = e.getMessage();
		}  
		return result;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public String deleteSliceTypeDetail(List objList) {
		String result = "Y"; 
		try { 
			this.deleteForList("system.systemParameter.deleteSliceTypeDetail",
					objList); 
		} catch (SQLException e) {
			e.printStackTrace();
			result = e.getMessage();
		}  
		return result;
	} 
}
