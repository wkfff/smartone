package com.siping.report.hrm.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
 
import org.springframework.stereotype.Repository;
  
import com.siping.report.hrm.dao.HrEmpInfoReportDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class HrEmpInfoReportDaoImpl extends SqlMapClientSupport implements
HrEmpInfoReportDao {

	/**
	 * 保险结算
	 * 
	 * @param List
	 * @return
	 */
	@Override
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<LinkedHashMap> getDatasource(List<String> codeList,
			Object obj) {
		List returnList = new ArrayList();
		try {
			LinkedHashMap paramMap = (LinkedHashMap) obj;
			  
			paramMap.put("sqlPiece", getDataColumnsParam(paramMap));
			returnList = this.queryForList(
					"report.hr.getDataInfo", paramMap);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}
	@SuppressWarnings({ "rawtypes" })
	public String getDataColumnsParam(Object paramMap) { 
		String sqlString = "SELECT ";
		String fromWhereString = " FROM ";
		List fieldList;
		List tableList;
		try {
			fieldList = this.queryForList("report.hr.getEmpInfoColumnInfo", paramMap);
			tableList = this.queryForList("report.hr.getFieldTableInfo", paramMap);
			if(fieldList.size()==0||tableList.size()==0){
				sqlString = "";
			}else{
				for (int i = 0; i < fieldList.size(); i++) {
					LinkedHashMap map = (LinkedHashMap) fieldList.get(i);
					sqlString += map.get("TABLE_ID")+"."+map.get("FIELD_ID"); 
					if (i == fieldList.size() - 1) {
						sqlString += " ";
					} else {
						sqlString += ", ";
					}
				}
				for (int i = 0; i < tableList.size(); i++) {
					LinkedHashMap map = (LinkedHashMap) tableList.get(i); 
					fromWhereString += map.get("TABLE_ID"); 
					if (i == tableList.size() - 1) {
						fromWhereString += " ";
					} else {
						fromWhereString += ", ";
					} 
				}
				for (int i = 0; i < tableList.size()-1; i=i+1) {
					LinkedHashMap map = (LinkedHashMap) tableList.get(0); 
					if (tableList.size() == 1) { 
						
					} else {
						if (i == 0) {
							LinkedHashMap map1 = (LinkedHashMap) tableList.get(i+1);
							fromWhereString += " WHERE " + map.get("TABLE_ID")+".EMPID = "+map1.get("TABLE_ID")+".EMPID(+)";
						}else{
							LinkedHashMap map1 = (LinkedHashMap) tableList.get(i+1);
							fromWhereString += " AND " + map.get("TABLE_ID")+".EMPID = "+map1.get("TABLE_ID")+".EMPID(+)";
						}
					}
				}
			}
		} catch (SQLException e) { 
			e.printStackTrace();
		}
		
		return sqlString + fromWhereString;
	}
	@Override
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<String> getEmpInfoTitleInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			LinkedHashMap paramMap = (LinkedHashMap) obj;
			List codeList = (List) paramMap.get("codeList");
			 
			for (int i = 0; i < codeList.size(); i++) { 
				paramMap.put("FIELD_ID", codeList.get(i).toString());
				Object  titleName= this.queryForObject   (
						"report.hr.getEmpInfoTitleInfo", paramMap);
				returnList.add(titleName.toString());
			}   
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}
	
	@Override
	@SuppressWarnings("rawtypes")
	public int insertComputer(List<Map> list) {

		try {
			this.insertForList("report.hr.addComputerInfo", list);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String getEmpInfoColumnInfo(Object obj) {
		 String returnString = "";
		try {
			List<LinkedHashMap> returnList = this.queryForList("report.hr.getEmpInfoColumnInfo", obj);
			for(LinkedHashMap paraMap : returnList){
				returnString += paraMap.get("FIELD_ID").toString() + ",";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnString;
	} 
	
}
