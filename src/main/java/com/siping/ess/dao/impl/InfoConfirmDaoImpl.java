package com.siping.ess.dao.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.siping.ess.dao.InfoConfirmDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class InfoConfirmDaoImpl extends SqlMapClientSupport implements
		InfoConfirmDao {
   
	/**
	 * 确认信息申请 (non-Javadoc)
	 * 
	 * @see com.siping.ess.dao.AffirmAppDao#confirmPerInfo(java.util.List)
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public String confirmPerInfo(List objectList) {
		String returnString = "Y";
		try {
			this.startTransaction();

			this.updateForList("ess.infoConfirm.confirmPersonInfo", objectList);
			this.updateHrPersonInfo(objectList);

			this.commitTransation();
		} catch (SQLException e) {
			e.printStackTrace();
			returnString = "N";
		} finally {
			try {
				this.endTransation();
			} catch (SQLException e) {
				returnString = "N";
				e.printStackTrace();
			}
		}
		return returnString;
	}

	/**
	 * 更新员工人事信息
	 * 
	 * @param objectList
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public String updateHrPersonInfo(List objectList) {
		String returnString = "Y";
		try {
			for (int i = 0; i < objectList.size(); i++) {
				Map paraMap = (Map) objectList.get(i);
				Map parMap = (Map) this.queryForObject(
						"ess.viewApp.getEssPersonalInfo", paraMap);
				this.update("ess.infoConfirm.updateHrPersonInfo", parMap);
				this.update("ess.infoConfirm.updateHrEmpInfo", parMap);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			returnString = "N";
		} catch (Exception e) {
			e.printStackTrace();
			returnString = "N";
		}
		return returnString;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public String confirmWhInfo(List objectList) {
		String returnString = "Y";
		try {
			this.updateForList("ess.infoConfirm.confirmWhInfo", objectList);
		} catch (SQLException e) {
			e.printStackTrace();
			returnString = "N";
		} catch (Exception e) {
			e.printStackTrace();
			returnString = "N";
		}
		return returnString;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public String confirmOtInfo(List objectList) {
		String returnString = "Y";
		try {
			for (int i = 0; i < objectList.size(); i++) {
				Map paraMap = (Map) objectList.get(i);
				this.update("ess.infoConfirm.confirmOtInfo", paraMap);
				if (paraMap.get("ACTIVITY").equals("1")) {
					this.insertOtAppResult(paraMap);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			returnString = "N";
		} catch (Exception e) {
			e.printStackTrace();
			returnString = "N";
		}
		return returnString;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public String confirmLeaveInfo(List objectList) {
		String returnString = "Y";
		try {
			for (int i = 0; i < objectList.size(); i++) {
				Map paraMap = (Map) objectList.get(i);
				this.update("ess.infoConfirm.confirmLeaveInfo", paraMap);
				if (paraMap.get("ACTIVITY").equals("1")) {
					this.insertLeaveAppResult(paraMap);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			returnString = "N";
		} catch (Exception e) {
			e.printStackTrace();
			returnString = "N";
		}
		return returnString;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public String confirmCardtimeInfo(List objectList) {
		String returnString = "Y";
		try {
			for (int i = 0; i < objectList.size(); i++) {
				Map paraMap = (Map) objectList.get(i);
				this.update("ess.infoConfirm.confirmCardtimeInfo", paraMap);
				if (paraMap.get("ACTIVITY").equals("1")) {
					this.insertCardtimeAppRecord(paraMap);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			returnString = "N";
		} catch (Exception e) {
			e.printStackTrace();
			returnString = "N";
		}
		return returnString;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public String confirmBizInfo(List objectList) {
		String returnString = "Y";
		try {
			for (int i = 0; i < objectList.size(); i++) {
				Map paraMap = (Map) objectList.get(i);
				this.update("ess.infoConfirm.confirmBizInfo", paraMap);
				if (paraMap.get("ACTIVITY").equals("1")) {
					this.insertBTAppResult(paraMap);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			returnString = "N";
		} catch (Exception e) {
			e.printStackTrace();
			returnString = "N";
		}
		return returnString;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public String confirmExpInfo(List objectList) {
		String returnString = "Y";
		try {
			for (int i = 0; i < objectList.size(); i++) {
				Map paraMap = (Map) objectList.get(i);
				this.update("ess.infoConfirm.confirmExpInfo", paraMap); 
			}
		} catch (SQLException e) {
			e.printStackTrace();
			returnString = "N";
		} catch (Exception e) {
			e.printStackTrace();
			returnString = "N";
		}
		return returnString;
	}
	private boolean insertLeaveAppResult(Object object) {
		boolean returnBoolean = true;
		try {
			this.delete("ess.infoConfirm.deleteAppResult", object);
			this.insert("ess.infoConfirm.insertLeaveAppResult", object);
		} catch (SQLException e) {
			e.printStackTrace();
			returnBoolean = false;
		}
		return returnBoolean;
	}
	private boolean insertCardtimeAppRecord(Object object) {
		boolean returnBoolean = true;
		try { 
			this.insert("ess.infoConfirm.insertCardtimeAppRecord", object);
		} catch (SQLException e) {
			e.printStackTrace();
			returnBoolean = false;
		}
		return returnBoolean;
	} 
	private boolean insertOtAppResult(Object object) {
		boolean returnBoolean = true;
		try {
			this.delete("ess.infoConfirm.deleteAppResult", object);
			this.insert("ess.infoConfirm.insertOtAppResult", object);
		} catch (SQLException e) {
			e.printStackTrace();
			returnBoolean = false;
		}
		return returnBoolean;
	}
	private boolean insertBTAppResult(Object object) {
		boolean returnBoolean = true;
		try {
			this.delete("ess.infoConfirm.deleteAppResult", object);
			this.insert("ess.infoConfirm.insertBTAppResult", object);
		} catch (SQLException e) {
			e.printStackTrace();
			returnBoolean = false;
		}
		return returnBoolean;
	}

	@SuppressWarnings({ "rawtypes" })
	@Override
	public String delBTInfo(List objectList) {
		String returnString = "Y";
		try {
			this.deleteForList("ess.infoConfirm.delArDetail", objectList);
			this.deleteForList("ess.infoConfirm.delArAppResult", objectList);
			this.deleteForList("ess.infoConfirm.delEssBTInfo", objectList);
			this.deleteForList("ess.infoConfirm.delEssAffirm", objectList);
		} catch (SQLException e) {
			e.printStackTrace();
		    returnString = "N";
		} catch (Exception e) {
			e.printStackTrace();
		    returnString = "N";
		}
		return returnString;
	}
	@Override
	@SuppressWarnings("rawtypes")
	public String delExpInfo(List objectList) {
		String returnString = "Y";
		try {
			this.deleteForList("ess.infoConfirm.delEssExpDetailInfo", objectList);
			this.deleteForList("ess.infoConfirm.delEssExpInfo", objectList);
			this.deleteForList("ess.infoConfirm.delEssAffirm", objectList); 
		} catch (SQLException e) {
			e.printStackTrace();
		    returnString = "N";
		} catch (Exception e) {
			e.printStackTrace();
		    returnString = "N";
		}
		return returnString;
	}
	@Override
	@SuppressWarnings("rawtypes")
	public String delWhInfo(List objectList) {
		String returnString = "Y";
		try { 
			this.deleteForList("ess.infoConfirm.delEssWhInfo", objectList); 
		} catch (SQLException e) {
			e.printStackTrace();
		    returnString = "N";
		} catch (Exception e) {
			e.printStackTrace();
		    returnString = "N";
		}
		return returnString;
	}
	@SuppressWarnings({ "rawtypes" })
	@Override
	public String delLeaveInfo(List objectList) {
		String returnString = "Y"; 
		try { 
			this.deleteForList("ess.infoConfirm.delArDetail", objectList);
			this.deleteForList("ess.infoConfirm.delArAppResult", objectList);
			this.deleteForList("ess.infoConfirm.delEssAffirm", objectList);
			this.deleteForList("ess.infoConfirm.delEssLeaveInfo", objectList);
		} catch (SQLException e) {
			e.printStackTrace();
		    returnString = "N";
		} catch (Exception e) {
			e.printStackTrace();
		    returnString = "N";
		}
		return returnString;
	}
	@SuppressWarnings({ "rawtypes" })
	@Override
	public String delCardtimeInfo(List objectList) {
		String returnString = "Y"; 
		try { 
			this.deleteForList("ess.infoConfirm.delAttRecordDetail", objectList); 
			this.deleteForList("ess.infoConfirm.delAttRecord", objectList); 
			this.deleteForList("ess.infoConfirm.delEssAffirm", objectList);
			this.deleteForList("ess.infoConfirm.delEssCardtimeInfo", objectList);
		} catch (SQLException e) {
			e.printStackTrace();
		    returnString = "N";
		} catch (Exception e) {
			e.printStackTrace();
		    returnString = "N";
		}
		return returnString;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public String delPersonInfo(List objectList) {
		String returnString = "Y";
		try {
			this.deleteForList("ess.infoConfirm.delPersonInfo", objectList);
		} catch (SQLException e) {
			e.printStackTrace();
		    returnString = "N";
		} catch (Exception e) {
			e.printStackTrace();
		    returnString = "N";
		}
		return returnString;
	}

	@SuppressWarnings({ "rawtypes" })
	@Override
	public String delOtInfo(List objectList) {
		String returnString = "Y"; 
		try { 
			this.deleteForList("ess.infoConfirm.delArDetail", objectList);
			this.deleteForList("ess.infoConfirm.delArAppResult", objectList);
			this.deleteForList("ess.infoConfirm.delEssAffirm", objectList); 
			this.deleteForList("ess.infoConfirm.delEssOtInfo", objectList);
		} catch (SQLException e) { 
			e.printStackTrace();
		    returnString = "N";
		} catch (Exception e) {
			e.printStackTrace();
		    returnString = "N";
		}
		return returnString;
	}

	@Override
	@SuppressWarnings("rawtypes")
	public String delTrainingInfo(List objectList) {
		String returnString = "Y";
		try {
			this.deleteForList("ess.infoConfirm.delEssLeaveInfo", objectList);
			this.deleteForList("ess.infoConfirm.delEssAffirm", objectList);
			this.deleteForList("ess.infoConfirm.delArAppResult", objectList);
		} catch (SQLException e) {
			e.printStackTrace();
		    returnString = "N";
		} catch (Exception e) {
			e.printStackTrace();
		    returnString = "N";
		}
		return returnString;
	}

	/**
	 * 确认物品申请
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public String confirmToolInfo(List objectList) {
		String returnString = "Y";
		String RETURN_FLAG = "4";
			
		try {
			if( ((Map)objectList.get(0)).get("ACTIVITY").toString().equals(RETURN_FLAG) ){
				this.updateForList("ess.infoConfirm.returnToolInfo", objectList);
			}
			else{	
				this.updateForList("ess.infoConfirm.confirmToolInfo", objectList);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			returnString = "N";
		} catch (Exception e) {
			e.printStackTrace();
			returnString = "N";
		}
		return returnString;
	}

	/**
	 * 删除物品申请
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public String delToolInfo(List objectList) {
		String returnString = "Y";
		try { 
			this.deleteForList("ess.infoConfirm.delEssToolInfo", objectList); 
		} catch (SQLException e) {
			e.printStackTrace();
		    returnString = "N";
		} catch (Exception e) {
			e.printStackTrace();
		    returnString = "N";
		}
		return returnString;
	}
}
