package com.siping.report.pa.dao.imp.ins;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
 
import org.springframework.stereotype.Repository;

import com.siping.report.pa.dao.ins.InsResultReportDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class InsResultReportDaoImpl extends SqlMapClientSupport implements
		InsResultReportDao {

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
					sqlPiece += codeList.get(i).toString();
				}else{
					sqlPiece += codeList.get(i).toString() + ",";
				}
				 
			}
			paramMap.put("sqlPiece", sqlPiece);
			returnList = this.queryForList(
					"pa.insReport.getDataInfo", paramMap);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}
	@Override
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List<String> getInsTitleInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			LinkedHashMap paramMap = (LinkedHashMap) obj;
			List codeList = (List) paramMap.get("codeList");
			 
			for (int i = 0; i < codeList.size(); i++) { 
				paramMap.put("ITEM_ID", codeList.get(i).toString());
				Object  titleName= this.queryForObject   (
						"pa.insReport.getInsTitleInfo", paramMap);
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
			this.insertForList("pa.insReport.addComputerInfo", list);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
}
