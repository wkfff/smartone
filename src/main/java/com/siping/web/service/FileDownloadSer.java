package com.siping.web.service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public interface FileDownloadSer {

	public void downloadExcel(String fileName, HttpServletRequest request, HttpServletResponse response) throws FileNotFoundException, IOException;
	public void downloadDynamicExcel(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException;
	public void downloadProductAppendix(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException;
	public void downloadCustAppendix(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException;
}
