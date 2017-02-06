package com.siping.web.action;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.siping.web.service.FileDownloadSer;

@Controller
@RequestMapping(value="/download/fileDownload")
public class FileDownloadController {

	@Autowired
	private FileDownloadSer fileDownloadSer;
	
	@RequestMapping(value="/downloadExcel")
	public void downloadExcel(String fileName, HttpServletRequest request, HttpServletResponse response) throws FileNotFoundException, IOException{
		this.fileDownloadSer.downloadExcel(fileName, request, response);
	}
	
	@RequestMapping(value="/downloadDynamicExcel")
	public void downloadDynamicExcel(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException{
		this.fileDownloadSer.downloadDynamicExcel(request, response);
	}
	
	@RequestMapping(value="/downloadProductAppendix")
	public void downloadProductAppendix(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException{
		this.fileDownloadSer.downloadProductAppendix(request, response);
	}
	
	@RequestMapping(value="/downloadCustAppendix")
	public void downloadCustAppendix(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException{
		this.fileDownloadSer.downloadCustAppendix(request, response);
	}
}
