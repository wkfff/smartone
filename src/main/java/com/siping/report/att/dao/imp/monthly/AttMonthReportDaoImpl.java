package com.siping.report.att.dao.imp.monthly;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
 
import org.springframework.stereotype.Repository;
 
import com.siping.report.att.dao.monthly.AttInfoReportDao; 
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class AttMonthReportDaoImpl extends SqlMapClientSupport implements
AttInfoReportDao {

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
			String sqlPiece = "";
			for (int i = 0; i < codeList.size(); i++) {
				 
				if(i==codeList.size()-1){ 
					sqlPiece += "AR_HISTORY."+codeList.get(i).toString();
				}else{
					sqlPiece += "AR_HISTORY."+codeList.get(i).toString() + ",";
				}
				 
			}
			paramMap.put("sqlPiece", sqlPiece);
			returnList = this.queryForList(
					"att.attReport.getDataInfo", paramMap);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}
	@Override
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<String> getAttInfoTitleInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			LinkedHashMap paramMap = (LinkedHashMap) obj;
			List codeList = (List) paramMap.get("codeList");
			 
			for (int i = 0; i < codeList.size(); i++) { 
				paramMap.put("ITEM_ID", codeList.get(i).toString());
				Object  titleName= this.queryForObject   (
						"att.attReport.getAttInfoTitleInfo", paramMap);
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
			this.insertForList("att.attReport.addComputerInfo", list);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String getAttInfoColumnInfo(Object obj) {
		 String returnString = "";
		try {
			List<LinkedHashMap> returnList = this.queryForList("att.attReport.getAttInfoColumnInfo", obj);
			for(LinkedHashMap paraMap : returnList){
				returnString += paraMap.get("ITEM_ID").toString() + ",";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnString;
	}
	
}
