package com.siping.report.ess.service.imp;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.report.ess.dao.EssInfoReportDao;
import com.siping.report.ess.service.EssInfoExcelSer;
import com.siping.report.util.FillComputerManager;
import com.siping.report.util.Layouter;
import com.siping.report.util.Writer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.ZipUtil;
import com.siping.web.utility.dao.UtilityEmpInfoDao;
import com.siping.report.util.*;
import com.siping.ess.dao.InfoAppDao;

@Service
public class EssInfoExcelSerImp implements EssInfoExcelSer {

    Logger logger = Logger.getLogger(EssInfoExcelSerImp.class);
    @Autowired
    private InfoAppDao infoAppDao;

    @Autowired
    private EssInfoReportDao essInfoReportDao;

    @Autowired
    private UtilityEmpInfoDao utilityEmpInfoDao;

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public void viewWhInfoReport(HttpServletRequest request, HttpServletResponse response) {
        // 附加信息
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("AR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));

        MSWordManager wordManager = new MSWordManager(false);
        String templateFilePath = request.getSession().getServletContext().getRealPath("/resources/template");
        String outputFilePath = request.getSession().getServletContext().getRealPath("/resources/temp");
        List<String> fileNameList = new ArrayList();
        List whDataList = this.getWhDataInfoForEachEmp(paramMap);

        for (Object whDataInfo : whDataList) {
            wordManager.openDocument(templateFilePath + "\\WorkHourReportTemplate.doc");
            List whEmpInfo = (List) whDataInfo;
            String fileName = null;
            for (int i = 1; i <= whEmpInfo.size(); i++) {
                Map object = (Map) whEmpInfo.get(i - 1);
                wordManager.putTxtToCell(2, i + 1, 1, object.get("START_DATE").toString());
                wordManager.putTxtToCell(2, i + 1, 2, object.get("PRO_NAME").toString());
                wordManager.putTxtToCell(2, i + 1, 3, object.get("WORK_HOUR").toString());
                wordManager.putTxtToCell(2, i + 1, 5, object.get("WORK_HOUR").toString());
                wordManager.putTxtToCell(2, i + 1, 6, object.get("WORK_CONTENT").toString());
                fileName = object.get("CHINESENAME").toString();
            }
            fileName = DateUtil.getSysdateString("yyyy-MM-dd") + "_" + fileName + ".doc";
            fileNameList.add(fileName);
            wordManager.save(outputFilePath + "\\" + fileName);
            wordManager.closeDocument();
        }
        wordManager.close();
        ZipUtil.downZipFile(response, outputFilePath, fileNameList);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    /**
     * 将报工汇总以Excel导出，现不用
     * @param request
     * @param response
     */
    public void viewWhInfoReport_BackUp(HttpServletRequest request, HttpServletResponse response) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 附加信息
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("AR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));

        // 1.创建一个 workbook
        HSSFWorkbook workbook = new HSSFWorkbook();

        // 2.创建一个 worksheet
        HSSFSheet worksheet = workbook.createSheet("Infomation");

        // 3.定义起始行和列
        int startRowIndex = 0;
        int startColIndex = 9;

        // 4.创建title,data,headers
        Layouter.buildWhInfoReport(worksheet, startRowIndex, startColIndex);

        // 5.填充数据
        FillComputerManager.fillWhReport(worksheet, startRowIndex, startColIndex, this.getWhDataInfo(paramMap));

        // 6.设置reponse参数
        // 进行转码，使其支持中文文件名
        String fileName = null;
        try {
            fileName = java.net.URLEncoder.encode("报工数据信息", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setHeader("Content-Disposition", "inline; filename=" + fileName + ".xls");
        // 确保发送的当前文本格式
        response.setContentType("application/vnd.ms-excel");

        // 7. 输出流
        Writer.write(response, worksheet);
    }

    /**
     * 从数据库获得所有的工时信息.
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    private List<LinkedHashMap> getWhDataInfoForEachEmp(Map paramMap) {
        List employees = utilityEmpInfoDao.getEmpInfoList(paramMap);

        List resultList = new ArrayList<LinkedHashMap>();
        for (Object employee : employees) {
            Map empInfo = (Map) employee;
            paramMap.put("EMPID", empInfo.get("EMPID"));
            resultList.add(essInfoReportDao.getWhDataInfo(paramMap));
        }
        return resultList;
    }

    @SuppressWarnings({ "rawtypes" })
    private List<LinkedHashMap> getWhDataInfo(Object obj) {
        return essInfoReportDao.getWhDataInfo(obj);
    }

    /**
     * 获取信息
     * @param request
     * @return
     */
    @SuppressWarnings("rawtypes")
    public Map getRequestParamData(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        return paramMap;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public void viewWhConclusion(HttpServletRequest request, HttpServletResponse response) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 附加信息
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("AR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("ACTIVITY", "undefined");

        // 1.创建一个 workbook
        HSSFWorkbook workbook = new HSSFWorkbook();

        // 2.创建一个 worksheet
        HSSFSheet worksheet = workbook.createSheet("Infomation");

        // 3.定义起始行和列
        int startRowIndex = 0;
        int startColIndex = 15;

        // 4.创建title,data,headers
        Layouter.buildWhConclusion(worksheet, startRowIndex, startColIndex);

        // 5.填充数据
        FillComputerManager.fillWhConclusion(worksheet, startRowIndex, startColIndex, this.infoAppDao.getWhConclusionList(paramMap));

        // 6.设置reponse参数
        // 进行转码，使其支持中文文件名
        String fileName = null;
        try {
            fileName = java.net.URLEncoder.encode("报工数据信息", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setHeader("Content-Disposition", "inline; filename=" + fileName + ".xls");
        // 确保发送的当前文本格式
        response.setContentType("application/vnd.ms-excel");

        // 7. 输出流
        Writer.write(response, worksheet);

    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public void viewWhConclusionSum(HttpServletRequest request, HttpServletResponse response) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 附加信息
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("AR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("ACTIVITY", "undefined");

        // 1.创建一个 workbook
        HSSFWorkbook workbook = new HSSFWorkbook();

        // 2.创建一个 worksheet
        HSSFSheet worksheet = workbook.createSheet("Infomation");

        // 3.定义起始行和列
        int startRowIndex = 0;
        int startColIndex = 15;

        // 4.创建title,data,headers
        Layouter.buildWhConclusionSum(worksheet, startRowIndex, startColIndex);

        // 5.填充数据
        FillComputerManager.fillWhConclusionSum(worksheet, startRowIndex, startColIndex, this.infoAppDao.getWhConclusionListSum(paramMap));

        // 6.设置reponse参数
        // 进行转码，使其支持中文文件名
        String fileName = null;
        try {
            fileName = java.net.URLEncoder.encode("报工数据信息汇总", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setHeader("Content-Disposition", "inline; filename=" + fileName + ".xls");
        // 确保发送的当前文本格式
        response.setContentType("application/vnd.ms-excel");

        // 7. 输出流
        Writer.write(response, worksheet);
    }
}
