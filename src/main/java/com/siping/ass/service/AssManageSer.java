package com.siping.ass.service;

import java.sql.SQLException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface AssManageSer {

	public String checkAssetID(HttpServletRequest request) throws SQLException;
	public String checkAssetName(HttpServletRequest request) throws SQLException;
	public String checkCategoryName(HttpServletRequest request) throws SQLException;
	public void transferAsset(HttpServletRequest request) throws SQLException;
	public String addCategory(HttpServletRequest request) throws SQLException;
	@SuppressWarnings("rawtypes")
	public Map getAssetDetail(HttpServletRequest request);
	public String removeAsset(HttpServletRequest request) throws SQLException;
}
