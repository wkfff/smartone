package com.siping.pa.dao.imp.wagebase;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.pa.dao.wagebase.PaAccountDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class PaAccountDaoImpl extends SqlMapClientSupport implements PaAccountDao {
	/**
	 * 取得所有人员账户信息列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getPaAccountInfo(Object obj) {
		List returnList = new ArrayList(); 
		try {
			returnList = this.queryForList("pa.wagebase.getPaAccountInfo",obj);
		} catch (SQLException e) { 
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnList;
	}

	/**
	 * 取得所有人员账户信息列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getPaAccountInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("pa.wagebase.getPaAccountInfo",
				obj, currentPage, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return returnList;
	}

	/**
	 * 取得所有人员账户信息总数
	 * 
	 * @param List
	 * @return
	 */
	public int getPaAccountInfoCnt(Object obj) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
				.queryForObject("pa.wagebase.getPaAccountInfoCnt", obj)),
					Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}

	/**
	 * 修改工资账户信息
	 * 
	 * @param List
	 * @return
	 */
	// @Override
	@SuppressWarnings("rawtypes")
	public String updatePaAccountInfo(List list) {
		String resultString = "Y";
		try {
			this.updateForList("pa.wagebase.updatePaAccountInfo", list);
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}
		return resultString;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getPaWhInfoList(Object object) {
		List returnList = new ArrayList(); 
		try {
			returnList = this.queryForList("pa.wagebase.getPaWhInfoList",object);
		} catch (SQLException e) { 
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnList;
	}

	@Override
	public int getPaWhInfoListCnt(Object object) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
				.queryForObject("pa.wagebase.getPaWhInfoListCnt", object)),
					Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}
}
