package com.siping.pa.dao.imp.salary;

import java.sql.SQLException; 
import java.util.ArrayList;
import java.util.LinkedHashMap; 
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository; 

import com.siping.pa.dao.salary.PaCalculateDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class PaCalculateDaoImpl extends SqlMapClientSupport implements PaCalculateDao {

	/**
	 * 工资计算
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public String paCalculate(LinkedHashMap paramMap) {
		String returnString = "";
		try {
			paramMap.put("message", "");
			this.insert("pa.paCalculate.paCalculate", paramMap);
			returnString = ObjectUtils.toString(paramMap.get("message"));
		} catch (SQLException e) {
			returnString = e.getMessage();
			e.printStackTrace();
		}
		return returnString;
	}

	@Override
	public List getPaMonInfo(LinkedHashMap object) {
		List list = new ArrayList();		
		try {
			list = this.queryForList("pa.paCalculate.getPaMonInfo",object,
					Integer.parseInt(((Map)object).get("page").toString()),
					Integer.parseInt(((Map)object).get("pagesize").toString()));
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int getPaMonInfoCnt(LinkedHashMap object) {
		int temp = 0;		
		try {
			temp = Integer.parseInt(this.queryForObject("pa.paCalculate.getPaMonInfoCnt",object).toString());
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		return temp;
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public List getPaSqlColumns(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("pa.paCalculate.getPaSqlColumns",object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnList;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public void updatePaMonthInfo(Object object) throws SQLException {
		this.update("pa.paCalculate.updatePaMonthInfo", object);
	}

}
