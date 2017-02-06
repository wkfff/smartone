package com.siping.hrm.service;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

public interface InfoStatisticsSer {
    public void downloadEmpInfoTemplate(HttpServletRequest request, HttpServletResponse response);

    public String uploadEmpInfoTemplate(MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, ParseException;

    @SuppressWarnings("rawtypes")
    public List getColumnList(HttpServletRequest request, HttpServletResponse response) throws SQLException;

    @SuppressWarnings("rawtypes")
    public List getTmpInfoList() throws Exception;

    public String saveEmpTmpInfo(HttpServletRequest request) throws Exception;

    @SuppressWarnings({ "rawtypes" })
    public List getInfoTypeList(HttpServletRequest request);

    @SuppressWarnings({ "rawtypes" })
    public List getInfoTableList(HttpServletRequest request);

    @SuppressWarnings({ "rawtypes" })
    public List getInfoFieldList(HttpServletRequest request);

    @SuppressWarnings({ "rawtypes" })
    public List getFieldInfo(HttpServletRequest request);

    public int getFieldInfoCnt(HttpServletRequest request);

    @SuppressWarnings({ "rawtypes" })
    public List getDataInfo(HttpServletRequest request);

    public int getDataInfoCnt(HttpServletRequest request);

    public int deleteFieldInfo(HttpServletRequest request);

    public int addFieldInfo(HttpServletRequest request);

    public void downloadCertificateInfoTemplate(HttpServletRequest request, HttpServletResponse response) throws IOException;

    public String uploadCertificateExcel(MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, ParseException;

    /**
     * 下载人事培训记录模板
     * @param request
     * @param response
     * @throws IOException
     */
    public void downloadTrainingInfoTemplate(HttpServletRequest request, HttpServletResponse response) throws IOException;

    /**
     * 上传人事培训记录并导入数据库
     * @param file
     * @param request
     * @param response
     * @return
     * @throws IOException
     * @throws SQLException
     * @throws ParseException
     */
    public String uploadTrainingExcel(MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, ParseException;
}
