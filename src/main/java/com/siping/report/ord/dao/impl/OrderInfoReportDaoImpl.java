package com.siping.report.ord.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import org.springframework.stereotype.Repository;
import com.siping.report.ord.dao.OrderInfoReportDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class OrderInfoReportDaoImpl extends SqlMapClientSupport implements OrderInfoReportDao {

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public String getOrderReportColumnInfo(Object obj) {
		 String returnString = "";
		try {
			List<LinkedHashMap> returnList = this.queryForList("order.orderReport.getOrderReportColumnInfo", obj);
			for(LinkedHashMap paraMap : returnList){
				returnString += paraMap.get("COLUMN_NAME").toString() + ",";
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnString;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List<String> getOrderReportTitleInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			LinkedHashMap paramMap = (LinkedHashMap) obj;
			List codeList = (List) paramMap.get("codeList");
			for (int i = 0; i < codeList.size(); i++) { 
				paramMap.put("ITEM_ID", codeList.get(i).toString());
				Object  titleName= this.queryForObject("order.orderReport.getOrderReportTitleInfo", paramMap);
				returnList.add(titleName.toString());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnList;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List<LinkedHashMap> getDataInfo(List<String> codeList, Object obj) {
		List returnList = new ArrayList();
		try {
			LinkedHashMap paramMap = (LinkedHashMap) obj;
			String sqlPiece = "";
			for (int i = 0; i < codeList.size(); i++) {
				 
				if(i==codeList.size()-1){ 
					sqlPiece += "OIRV."+codeList.get(i).toString();
				}else{
					sqlPiece += "OIRV."+codeList.get(i).toString() + ",";
				}
			}
			paramMap.put("sqlPiece", sqlPiece);
			returnList = this.queryForList("order.orderReport.getDataInfo", paramMap);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnList;
	}

}
