package com.siping.web.service;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

public interface FileUploadSer {

	public String uploadPhoto(HttpServletRequest request, MultipartFile file)
			throws IOException, SQLException;
	
	public String uploadAssetPic(HttpServletRequest request, MultipartFile file)
			throws IOException, SQLException;

	public String uploadExcel(MultipartFile file, HttpServletRequest request,
			HttpServletResponse response) throws IOException, SQLException, ParseException;

	public String uploadContractAppendix(HttpServletRequest request,
			MultipartFile file) throws IOException, SQLException;
	
	public String uploadProductAppendix(HttpServletRequest request,
			MultipartFile file) throws IOException, SQLException;	
	
	public String uploadProductPic(HttpServletRequest request,
			MultipartFile file) throws IOException, SQLException;	
			
	public String uploadMaterialPic(HttpServletRequest request,
			MultipartFile file) throws IOException, SQLException;	
	
	public String uploadCustAppendix(HttpServletRequest request,
			MultipartFile file) throws IOException, SQLException;
			
	@SuppressWarnings("rawtypes")
	public List getColumnList(HttpServletRequest request, 
			HttpServletResponse response) throws SQLException ;

	@SuppressWarnings("rawtypes")
	public List getTmpInfoList(HttpServletRequest request) throws SQLException;
	
	public String saveUploadExcel(HttpServletRequest request) throws SQLException ;
	
	/**
	 * 获取信息
	 */
	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request);
	
	public String uploadProImage(HttpServletRequest request, MultipartFile file)
			throws IOException, SQLException;
	
	public String uploadMobileAdvImage(HttpServletRequest request, MultipartFile file)
            throws IOException, SQLException;
}
