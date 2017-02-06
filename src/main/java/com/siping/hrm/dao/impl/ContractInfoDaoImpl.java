package com.siping.hrm.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.hrm.dao.ContractInfoDao;
import com.siping.web.utility.JacobTheWord;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class ContractInfoDaoImpl extends SqlMapClientSupport implements
		ContractInfoDao {

	/**
	 * 取得所有合同列表
	 * 
	 * @param Object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getContractInfoList(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"hrm.contractInfo.getContractInfoList", object);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}
	
	/**
	 * 取得所有合同列表
	 * 
	 * @param Object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getContractInfoList(Object object, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"hrm.contractInfo.getContractInfoList", object,
					currentPage, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}

	/**
	 * 得到所有合同的数量
	 */
	@Override
	public int getContractInfoCnt(Object object) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("hrm.contractInfo.getContractInfoCnt",
							object)), Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnInt;
	}

	@SuppressWarnings({ "rawtypes" })
	public List getAddContractInfoList(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"hrm.contractInfo.searchEmpWithoutContract", object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}

	/**
	 * 得到新签合同列表
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getAddContractInfoList(Object object, int currentPage,
			int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"hrm.contractInfo.searchEmpWithoutContract", object,
					currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnList;
	}

	@Override
	public int getAddContractInfoCnt(Object object) {
		int returnInt = 0; 
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject(
							"hrm.contractInfo.searchEmpWithoutContractCnt",
							object)), Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return returnInt;
	}  
	@SuppressWarnings({ "rawtypes" })
	public List getExpiredContractInfoList(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"hrm.contractInfo.searchExpiredContract", object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}

	/**
	 * 得到新签合同列表
	 */
	@Override
	@SuppressWarnings({ "rawtypes" })
	public List getExpiredContractInfoList(Object object, int currentPage,
			int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"hrm.contractInfo.searchExpiredContract", object,
					currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnList;
	}

	@Override
	public int getExpiredContractInfoCnt(Object object) {
		int returnInt = 0; 
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject(
							"hrm.contractInfo.searchExpiredContractCnt",
							object)), Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return returnInt;
	}  
	/**
	 * 添加新合同
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public String addContractInfo(List objList) {
		String returnString = "Y";
		try {
			this.insertForList("hrm.contractInfo.addContractInfo", objList);
		} catch (SQLException e) { 
			returnString = "N";
			e.printStackTrace();
		} 
		return returnString;
	}
	
	/**
	 * 添加新合同
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public String updateContractInfo(List objList) {
		String returnString = "Y";
		try {
			this.updateForList("hrm.contractInfo.updateContractInfo", objList);
		} catch (SQLException e) { 
			returnString = "N";
			e.printStackTrace();
		} 
		return returnString;
	}
	
	/**
	 * 删除新合同
	 */ 
	@Override
	public String deleteContractInfoInfo(Object object) {
		String returnString = "Y";
		try {
			this.delete("hrm.contractInfo.deleteContractInfoInfo", object);
		} catch (SQLException e) { 
			returnString = "N";
			e.printStackTrace();
		} 
		return returnString;
	}
	
	/**
	 * 添加续签合同
	 */
	@Override
	public void saveExpiredContract(Object object) {
		try {
			this.insert("hrm.contractInfo.addExpiredContract", object);
		} catch (SQLException e) { 
			e.printStackTrace();
		}  
	}
	/**
	 * 利用合同模板生成文档
	 */
	
	@SuppressWarnings("rawtypes")
	public Map getContractInfo(Object object){
		Map map = new HashMap<String, Object>();
		try {
			map = (Map) this.queryForObject("hrm.contractInfo.getContractInfo", object);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return map;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void generateWord(Map map, String inputDoc, String outputDoc) {
		JacobTheWord jt = new JacobTheWord();
		HashMap<String, String> data = new HashMap<String, String>();
		String empname = this.objectToString(map.get("EMPNAME"));
		String deptname = this.objectToString(map.get("DEPTNAME"));
		String startdate = this.objectToString(map.get("STARTDATE"));
		String enddate = this.objectToString(map.get("ENDDATE"));
		String eduHisName = this.objectToString(map.get("EDUHISNAME"));
		String idCardNo = this.objectToString(map.get("IDCARDNO"));
		String cellphone = this.objectToString(map.get("CELLPHONE"));
		String province = this.objectToString(map.get("PROVINCE"));
		String city = this.objectToString(map.get("CITY"));
		String area = this.objectToString(map.get("AREA"));
		String address = this.objectToString(map.get("ADDRESS"));
		
		data.put("#empname#", empname);
		data.put("#deptname#", deptname);
		data.put("#startdate#", startdate);
		data.put("#enddate#", enddate);
		data.put("#eduHisName#", eduHisName);
		data.put("#idCardNo#", idCardNo);
		data.put("#cellphone#", cellphone);
		data.put("#address#", province+city+area+address);
		jt.toWord(inputDoc, outputDoc, data);
	}
	private String objectToString(Object object) {
		if (object == null) {
			return "";
		} else {
			return object.toString();
		}
	}
}
