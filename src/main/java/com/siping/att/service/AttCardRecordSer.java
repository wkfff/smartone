package com.siping.att.service;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

public interface AttCardRecordSer {
	@SuppressWarnings({ "rawtypes" })
	public List getAttCardRecordInfo(HttpServletRequest request);

	public int getAttCardRecordInfoCnt(HttpServletRequest request);

	public String updateAttCardRecordInfo(HttpServletRequest request);

	public String deleteAttCardRecordInfo(HttpServletRequest request);

	public String addAttCardRecordInfo(HttpServletRequest request);
	
	public String uploadMacRecodsByExcel(MultipartFile file, HttpServletRequest request,
			HttpServletResponse response) throws IOException, SQLException, ParseException;
	
	public void downloadAttRecordsTemplate(HttpServletRequest request, HttpServletResponse response);
}
