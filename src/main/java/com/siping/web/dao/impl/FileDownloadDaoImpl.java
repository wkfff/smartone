package com.siping.web.dao.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.siping.web.dao.FileDownloadDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class FileDownloadDaoImpl extends SqlMapClientSupport implements FileDownloadDao {

	/**
	 * 根据传入的parentCode查询出约束条件
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public String[] getOptions(Object object) throws SQLException {
		List list = this.queryForList("download.downloadInfo.queryCellOptions", object);
		String[] resultList = this.list2StringArray(list);
		return resultList;
	}

	@SuppressWarnings({ "rawtypes" })
	@Override
	public List getTitles(Object obj) throws SQLException {
		List list = this.queryForList("download.downloadInfo.queryColumnTitles", obj);		
		return list;
	}
	
	@Override
	public Object getProductAppendixInfo(Object obj) throws SQLException{
		return this.queryForObject("pro.proInfo.getAppendixDetail", obj);
	}
	
	@Override
	public Object getCustAppendixInfo(Object obj) throws SQLException{
		return this.queryForObject("cust.custAppendix.getAppendixDetail", obj);
	}
	
	@SuppressWarnings("rawtypes")
	public String getTitle(HashMap map){
		Object obj = map.get("COMMENTS");
		String resultStr = null;
		if (obj != null){
			resultStr = obj.toString().substring(1);
		}
		return resultStr;
	}
	
	@SuppressWarnings("rawtypes")
	public String[] list2StringArray(List list){
		if(list==null ||list.size()==0) return null;
		Object[] objects = list.toArray();
		String[] resultArray = new String[list.size()];
		//Cast Object[] to String[]
		for(int i=0, j=0; i<objects.length; i++){
			if(objects[i] != null){
				resultArray[j] = (String)objects[i];
				j++;
			}
		}
		return resultArray;
	}
}
