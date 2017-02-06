package com.siping.pa.service.salary;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

public interface PaInputItemSer {

	public Object getPaInputItemObjectInfo(HttpServletRequest request);

	@SuppressWarnings("rawtypes")
	public List getPaInputItemInfo(HttpServletRequest request);

	public int getPaInputItemInfoCnt(HttpServletRequest request);

	@SuppressWarnings("rawtypes")
	public List getPaInputItemDataEmpInfo(HttpServletRequest request);

	public int getPaInputItemDataEmpInfoCnt(HttpServletRequest request);

	@SuppressWarnings("rawtypes")
	public List getPaInputItemDataOtherInfo(HttpServletRequest request);

	public int getPaInputItemDataOtherInfoCnt(HttpServletRequest request);

	public void addPaInputItemInfo(HttpServletRequest request) throws SQLException;

	public void updatePaInputItemInfo(HttpServletRequest request) throws SQLException;

	public int checkDeletePaInputItemInfo(HttpServletRequest request);

	public String deletePaInputItemInfo(HttpServletRequest request);

	public String deletePaInputItemDataInfo(HttpServletRequest request);

	@SuppressWarnings("rawtypes")
	public List getPaInputItemDataInfo(HttpServletRequest request);

	public int getPaInputItemDataInfoCnt(HttpServletRequest request);

	public String createPaInputItemInfo(HttpServletRequest request);

	public String createPaInputItemDataInfo(HttpServletRequest request);

	public String updatePaInputItemDataInfo(HttpServletRequest request);

	public String addPaInputItemDataInfo(HttpServletRequest request);
	
	public String uploadPaParamExcel(MultipartFile file, HttpServletRequest request,
			HttpServletResponse response) throws IOException, SQLException, ParseException;
}
