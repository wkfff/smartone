package com.siping.ess.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.siping.ess.dao.AffirmAppDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class AffirmAppDaoImpl extends SqlMapClientSupport implements
		AffirmAppDao {

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map getAffirmOtInfo(Object object, int currentPage, int pageSize) {
		Map returnMap = new LinkedHashMap();
		List returnList = new ArrayList<Map>();
		try {
			List Rows = this.queryForList("ess.affirmApp.getOtAffirmInfo",
					object, currentPage, pageSize);
			int Total = (Integer) this.queryForObject(
					"ess.affirmApp.getOtAffirmInfoCnt", object);

			for (int i = 0; i < Rows.size(); i++) {
				Map paraMap = (Map) Rows.get(i);
				String affirmFlag = (String) this.queryForObject(
						"ess.affirmApp.checkPreAffirmFlag", paraMap);
				paraMap.put("AFFIRM_FLAG", affirmFlag);
				returnList.add(paraMap);
			}
			returnMap.put("Rows", returnList);
			returnMap.put("Total", Total);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnMap;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map getAffirmOtInfo(Object object) {
		Map returnMap = new LinkedHashMap(); 
		List returnList = new ArrayList<Map>();
		try {
			List Rows = this.queryForList("ess.affirmApp.getOtAffirmInfo",
					object); 

			for (int i = 0; i < Rows.size(); i++) {
				Map paraMap = (Map) Rows.get(i);
				String affirmFlag = (String) this.queryForObject(
						"ess.affirmApp.checkPreAffirmFlag", paraMap);
				paraMap.put("AFFIRM_FLAG", affirmFlag);
				returnList.add(paraMap);
			}
			returnMap.put("Rows", returnList); 
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnMap;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map getAffirmBTInfo(Object object, int currentPage, int pageSize) {
		Map returnMap = new LinkedHashMap();
		List returnList = new ArrayList<Map>();
		try {
			List Rows = this.queryForList("ess.affirmApp.getBTAffirmInfo",
					object, currentPage, pageSize);
			int Total = (Integer) this.queryForObject(
					"ess.affirmApp.getBTAffirmInfoCnt", object);

			for (int i = 0; i < Rows.size(); i++) {
				Map paraMap = (Map) Rows.get(i);
				String affirmFlag = (String) this.queryForObject(
						"ess.affirmApp.checkPreAffirmFlag", paraMap);
				paraMap.put("AFFIRM_FLAG", affirmFlag);
				returnList.add(paraMap);
			}
			returnMap.put("Rows", returnList);
			returnMap.put("Total", Total);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnMap;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map getAffirmBTInfo(Object object) {
		Map returnMap = new LinkedHashMap();
		List returnList = new ArrayList<Map>();
		try {
			List Rows = this.queryForList("ess.affirmApp.getBTAffirmInfo",
					object); 

			for (int i = 0; i < Rows.size(); i++) {
				Map paraMap = (Map) Rows.get(i);
				String affirmFlag = (String) this.queryForObject(
						"ess.affirmApp.checkPreAffirmFlag", paraMap);
				paraMap.put("AFFIRM_FLAG", affirmFlag);
				returnList.add(paraMap);
			}
			returnMap.put("Rows", returnList); 
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnMap;
	}
 
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map getAffirmExpInfo(Object object, int currentPage, int pageSize) {
		Map returnMap = new LinkedHashMap();
		List returnList = new ArrayList<Map>();
		try {
			List Rows = this.queryForList("ess.affirmApp.getExpAffirmInfo",
					object, currentPage, pageSize);
			int Total = (Integer) this.queryForObject(
					"ess.affirmApp.getExpAffirmInfoCnt", object);

			for (int i = 0; i < Rows.size(); i++) {
				Map paraMap = (Map) Rows.get(i);
				String affirmFlag = (String) this.queryForObject(
						"ess.affirmApp.checkPreAffirmFlag", paraMap);
				paraMap.put("AFFIRM_FLAG", affirmFlag);
				returnList.add(paraMap);
			}
			returnMap.put("Rows", returnList);
			returnMap.put("Total", Total);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnMap;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map getAffirmExpInfo(Object object) {
		Map returnMap = new LinkedHashMap();
		List returnList = new ArrayList<Map>();
		try {
			List Rows = this.queryForList("ess.affirmApp.getExpAffirmInfo",
					object);

			for (int i = 0; i < Rows.size(); i++) {
				Map paraMap = (Map) Rows.get(i);
				String affirmFlag = (String) this.queryForObject(
						"ess.affirmApp.checkPreAffirmFlag", paraMap);
				paraMap.put("AFFIRM_FLAG", affirmFlag);
				returnList.add(paraMap);
			}
			returnMap.put("Rows", returnList);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnMap;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map getAffirmLeaveInfo(Object object, int currentPage, int pageSize) {
		Map returnMap = new LinkedHashMap();
		List returnList = new ArrayList<Map>();
		try {
			List Rows = this.queryForList("ess.affirmApp.getLeaveAffirmInfo",
					object, currentPage, pageSize);
			int Total = (Integer) this.queryForObject(
					"ess.affirmApp.getLeaveAffirmInfoCnt", object);

			for (int i = 0; i < Rows.size(); i++) {
				Map paraMap = (Map) Rows.get(i);
				String affirmFlag = (String) this.queryForObject(
						"ess.affirmApp.checkPreAffirmFlag", paraMap);
				paraMap.put("AFFIRM_FLAG", affirmFlag);
				returnList.add(paraMap);
			}
			returnMap.put("Rows", returnList);
			returnMap.put("Total", Total);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnMap;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map getAffirmLeaveInfo(Object object) {
		Map returnMap = new LinkedHashMap();
		List returnList = new ArrayList<Map>();
		try {
			List Rows = this.queryForList("ess.affirmApp.getLeaveAffirmInfo",
					object);

			for (int i = 0; i < Rows.size(); i++) {
				Map paraMap = (Map) Rows.get(i);
				String affirmFlag = (String) this.queryForObject(
						"ess.affirmApp.checkPreAffirmFlag", paraMap);
				paraMap.put("AFFIRM_FLAG", affirmFlag);
				returnList.add(paraMap);
			}
			returnMap.put("Rows", returnList);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnMap;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map getAffirmCardtimeInfo(Object object, int currentPage, int pageSize) {
		Map returnMap = new LinkedHashMap();
		List returnList = new ArrayList<Map>();
		try {
			List Rows = this.queryForList("ess.affirmApp.getCardtimeAffirmInfo",
					object, currentPage, pageSize);
			int Total = (Integer) this.queryForObject(
					"ess.affirmApp.getCardtimeAffirmInfoCnt", object);

			for (int i = 0; i < Rows.size(); i++) {
				Map paraMap = (Map) Rows.get(i);
				String affirmFlag = (String) this.queryForObject(
						"ess.affirmApp.checkPreAffirmFlag", paraMap);
				paraMap.put("AFFIRM_FLAG", affirmFlag);
				returnList.add(paraMap);
			}
			returnMap.put("Rows", returnList);
			returnMap.put("Total", Total);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnMap;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public Map getAffirmCardtimeInfo(Object object) {
		Map returnMap = new LinkedHashMap();
		List returnList = new ArrayList<Map>();
		try {
			List Rows = this.queryForList("ess.affirmApp.getCardtimeAffirmInfo",
					object);

			for (int i = 0; i < Rows.size(); i++) {
				Map paraMap = (Map) Rows.get(i);
				String affirmFlag = (String) this.queryForObject(
						"ess.affirmApp.checkPreAffirmFlag", paraMap);
				paraMap.put("AFFIRM_FLAG", affirmFlag);
				returnList.add(paraMap);
			}
			returnMap.put("Rows", returnList);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnMap;
	}
	/**
	 * 系统审核 (non-Javadoc)
	 * 
	 * @see com.siping.ess.dao.AffirmAppDao#affirmOtApp(java.lang.Object)
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public String affirmOtApp(List objectList) {
		String returnString = "Y";
		try {
			for (int i = 0; i < objectList.size(); i++) {
				Map paraMap = (Map) objectList.get(i);
				this.update("ess.affirmApp.updateDoAffirm", paraMap);
				if (paraMap.get("AFFIRM_FLAG").equals("1")) {
					if (this.isLastAffirm(paraMap)) {
						this.updateOtAffirm(paraMap);
					}
				} else {
					this.update("ess.affirmApp.updateOtAffirm", paraMap);
				}
			}
		} catch (SQLException e) {
			returnString = "N";
			e.printStackTrace();
		} catch (Exception e) {
			returnString = "N";
			e.printStackTrace();
		}
		return returnString;
	}

	/**
	 * 系统审核 (non-Javadoc)
	 * 
	 * @see com.siping.ess.dao.AffirmAppDao#affirmLeaveApp(java.lang.Object)
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public String affirmLeaveApp(List objectList) {
		String returnString = "Y";
		try {
			for (int i = 0; i < objectList.size(); i++) {
				Map paraMap = (Map) objectList.get(i);
				this.update("ess.affirmApp.updateDoAffirm", paraMap);
				if (paraMap.get("AFFIRM_FLAG").equals("1")) {
					if (this.isLastAffirm(paraMap)) {
						this.updateLeaveAffirm(paraMap);
					}
				} else {
					this.update("ess.affirmApp.updateLeaveAffirm", paraMap);
				}
			}
		} catch (SQLException e) {
			returnString = "N";
			e.printStackTrace();
		} catch (Exception e) {
			returnString = "N";
			e.printStackTrace();
		}
		return returnString;
	}
	/**
	 * 系统审核 (non-Javadoc)
	 * 
	 * @see com.siping.ess.dao.AffirmAppDao#affirmLeaveApp(java.lang.Object)
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public String affirmCardtimeApp(List objectList) {
		String returnString = "Y";
		try {
			for (int i = 0; i < objectList.size(); i++) {
				Map paraMap = (Map) objectList.get(i);
				this.update("ess.affirmApp.updateDoAffirm", paraMap);
				if (paraMap.get("AFFIRM_FLAG").equals("1")) {
					if (this.isLastAffirm(paraMap)) {
						this.updateCardtimeAffirm(paraMap);
					}
				} else {
					this.update("ess.affirmApp.updateCardtimeAffirm", paraMap);
				}
			}
		} catch (SQLException e) {
			returnString = "N";
			e.printStackTrace();
		} catch (Exception e) {
			returnString = "N";
			e.printStackTrace();
		}
		return returnString;
	}

	/**
	 * 系统审核 (non-Javadoc)
	 * 
	 * @see com.siping.ess.dao.AffirmAppDao#affirmExpApp(java.lang.Object)
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public String affirmExpApp(List objectList) {
		String returnString = "Y";
		try {
			for (int i = 0; i < objectList.size(); i++) {
				Map paraMap = (Map) objectList.get(i);
				this.update("ess.affirmApp.updateDoAffirm", paraMap);
				if (paraMap.get("AFFIRM_FLAG").equals("1")) {
					if (this.isLastAffirm(paraMap)) { 
						this.updateExpAffirm(paraMap);
					}
				} else {
					this.update("ess.affirmApp.updateExpAffirm", paraMap);
				}
			}
		} catch (SQLException e) {
			returnString = "N";
			e.printStackTrace();
		} catch (Exception e) {
			returnString = "N";
			e.printStackTrace();
		}
		return returnString;
	}
	
	/**
	 * 系统审核 (non-Javadoc)
	 * 
	 * @see com.siping.ess.dao.AffirmAppDao#affirmBTApp(java.lang.Object)
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public String affirmBTApp(List objectList) {
		String returnString = "Y";
		try {
			for (int i = 0; i < objectList.size(); i++) {
				Map paraMap = (Map) objectList.get(i);
				this.update("ess.affirmApp.updateDoAffirm", paraMap);
				if (paraMap.get("AFFIRM_FLAG").equals("1")) {
					if (this.isLastAffirm(paraMap)) { 
						this.updateBTAffirm(paraMap);
					}
				} else {
					this.update("ess.affirmApp.updateBTAffirm", paraMap);
				}
			}
		} catch (SQLException e) {
			returnString = "N";
			e.printStackTrace();
		} catch (Exception e) {
			returnString = "N";
			e.printStackTrace();
		}
		return returnString;
	}

	/**
	 * 检查是否是最后一级审核者 (non-Javadoc)
	 * 
	 * @see com.siping.ess.dao.AffirmAppDao#isLastAffirm(java.lang.Object)
	 */
	@Override
	public boolean isLastAffirm(Object object) {
		boolean returnBoolean = false;
		try {
			String aCnt = (String) this.queryForObject(
					"ess.affirmApp.getIsLastAffirm", object);
			String bCnt = (String) this.queryForObject(
					"ess.affirmApp.getRejectAffirm", object);
			if (aCnt.equals("0") && bCnt.equals("0")) {
				returnBoolean = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			returnBoolean = false;
		} catch (Exception e) {
			e.printStackTrace();
			returnBoolean = false;
		}
		return returnBoolean;
	}

	/**
	 * 是最后一节审核者更新 信息确认
	 */
	private boolean updateOtAffirm(Object object) {
		boolean returnBoolean = true;
		try {
			this.update("ess.affirmApp.updateOtAffirm", object);
		} catch (SQLException e) {
			e.printStackTrace();
			returnBoolean = false;
		}
		return returnBoolean;
	}
	/**
	 * 是最后一节审核者更新 信息确认
	 */
	private boolean updateCardtimeAffirm(Object object) {
		boolean returnBoolean = true;
		try {
			this.update("ess.affirmApp.updateCardtimeAffirm", object);
		} catch (SQLException e) {
			e.printStackTrace();
			returnBoolean = false;
		}
		return returnBoolean;
	}
	private boolean updateLeaveAffirm(Object object) {
		boolean returnBoolean = true;
		try {
			this.update("ess.affirmApp.updateLeaveAffirm", object);
		} catch (SQLException e) {
			e.printStackTrace();
			returnBoolean = false;
		}
		return returnBoolean;
	}
	private boolean updateExpAffirm(Object object) {
		boolean returnBoolean = true;
		try {
			this.update("ess.affirmApp.updateExpAffirm", object);
		} catch (SQLException e) {
			e.printStackTrace();
			returnBoolean = false;
		}
		return returnBoolean;
	} 
	private boolean updateBTAffirm(Object object) {
		boolean returnBoolean = true;
		try {
			this.update("ess.affirmApp.updateBTAffirm", object);
		} catch (SQLException e) {
			e.printStackTrace();
			returnBoolean = false;
		}
		return returnBoolean;
	}

}
