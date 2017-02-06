package com.siping.report.hrm.service.impl;
 
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest; 
import javax.servlet.http.HttpServletResponse;

import jofc2.model.Chart;
import jofc2.model.axis.Label;
import jofc2.model.axis.XAxis;
import jofc2.model.axis.YAxis;
import jofc2.model.elements.LineChart;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service; 
import org.springframework.util.NumberUtils;

import com.siping.hrm.dao.OrgDao;
import com.siping.report.hrm.dao.HrReportDao;
import com.siping.report.hrm.service.HrReportSer;
import com.siping.report.util.FillComputerManager;
import com.siping.report.util.Layouter;
import com.siping.report.util.Writer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.StringUtil;
import com.siping.web.utility.dao.UtilityOtherInfoDao;

@Service
public class HrReportSerImpl implements HrReportSer {
	Logger logger = Logger.getLogger(HrReportSerImpl.class);
	@Autowired
	private HrReportDao hrReportDao;

	@Autowired
	private OrgDao orgDao;
	
	@Autowired
	private UtilityOtherInfoDao utilityOtherInfoDao;
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	//@Override
	public Map viewReport(HttpServletRequest request) {
		
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("ADMINID", admin.getAdminID()) ;
		
		String reportName = paramMap.get("reportName").toString();
		logger.info("reportName:"+reportName);
		
		if("humanResources".equals(reportName)){
			hrReportDao.calReport(paramMap);
		}
		
		return hrReportDao.viewReport(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	//@Override
	public String viewReportChart(HttpServletRequest request) throws Exception {
		
        //y轴数据集合-使用数量   
        List<Number> dataSet = new ArrayList<Number>();   
        //x轴数据集合-浏览器类型   
        List<Label> xLabel = new ArrayList<Label>();   
        //获取需要显示的数据集   
        
        List browserList = new ArrayList(20);
        Map a = new HashMap();
        a.put("statCount", 6);
        a.put("statVar", "Safari");
        browserList.add(a);
        
        Map b = new HashMap();
        b.put("statCount", 16);
        b.put("statVar", "MSIE6X");
        browserList.add(b);
        
        Map c = new HashMap();
        c.put("statCount", 73);
        c.put("statVar", "MSIE7X");
        browserList.add(c);
        
        Map d = new HashMap();
        d.put("statCount", 183);
        d.put("statVar", "MSIE8X");
        browserList.add(d);
        
        Map e = new HashMap();
        e.put("statCount", 7);
        e.put("statVar", "Firefox");
        browserList.add(e);
        
        Map f = new HashMap();
        f.put("statCount", 7);
        f.put("statVar", "Chrome");
        browserList.add(f);
        
        System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
        
        
        for (int i = 0; i < browserList.size(); i++) {   
            Map map = (Map) browserList.get(i);   
            //填充x轴   
            dataSet.add((Integer) map.get("statCount"));   
            //填充y轴   
            xLabel.add(new Label((String) map.get("statVar")));   
        }   
        //设置X轴内容   
        XAxis labels = new XAxis();   
        labels.addLabels(xLabel);   
        //设置Y轴显示值域:Range的三个参数含义为：坐标最小值，最大值和步进值   
        YAxis range = new YAxis();   
        range.setRange(0, 200, 10);   
        //OFC折线图设置   
        LineChart lineChart = new LineChart(LineChart.Style.NORMAL);   
        lineChart.addValues(dataSet);   
        lineChart.setColour("#6666FF");   
        lineChart.setText("user number");   
        //图表设置   
        Chart chart = new Chart("bower");   
        chart.setXAxis(labels);   
        chart.setYAxis(range);   
        chart.addElements(lineChart);   
        //打印JSON格式的文本   
        System.out.print(chart.toString());   
        /*
        response.setContentType("application/json-rpc;charset=utf-8");   
        response.setHeader("Cache-Control", "no-cache");   
        response.setHeader("Expires", "0");   
        response.setHeader("Pragma", "No-cache");   
        response.getWriter().write(chart.toString());   */
        return chart.toString();  
        
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public void getDeptQuotaByExcel(HttpServletRequest request,
			HttpServletResponse response) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 附加信息
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request)); 
		
		List<String> codeList = new ArrayList<String>();
		codeList.add("DEPTNAME");
		codeList.add("POST_NAME");
		codeList.add("QUOTA_NUMBER");
		codeList.add("REAL_NUMBER");
		codeList.add("MINUSNUMBER");
		codeList.add("DESCRIPTION");
		
		List<String> titleList = new ArrayList<String>();
		titleList.add("部门");
		titleList.add("职位");
		titleList.add("定编人数");
		titleList.add("实际人数");
		titleList.add("差额人数");
		titleList.add("描述");
		
		// 1.创建一个 workbook
		HSSFWorkbook workbook = new HSSFWorkbook();

		// 2.创建一个 worksheet
		HSSFSheet worksheet = workbook.createSheet("部门定编信息");

		// 3.定义起始行和列
		int startRowIndex = 0;
		int startColIndex = titleList.size();

		// 4.创建title,data,headers 
		Layouter.buildDeptQuotaReport(worksheet, startRowIndex, startColIndex, titleList);

		// 5.填充数据
		//将状态和审核状态转变成可识别的中文
		startRowIndex += 2;
		List deptList = orgDao.getDeptInfoTree(paramMap);
		for(Object deptNode : deptList){
		    paramMap.put("DEPTID", ((Map)deptNode).get("DEPTID").toString());
		    List dataList = this.hrReportDao.getDeptQuotaList(paramMap);
		    if(dataList.size() != 0){
		        FillComputerManager.deptQuotaReport(worksheet, startRowIndex, startColIndex, dataList, codeList);
		        startRowIndex += dataList.size();
		    }
		}
		// 6.设置reponse参数
		// 进行转码，使其支持中文文件名
		String fileName = null;
		try {
			fileName = java.net.URLEncoder.encode("部门定编信息", "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		response.setHeader("Content-Disposition", "inline; filename="
				+ fileName + ".xls");
		// 确保发送的当前文本格式
		response.setContentType("application/vnd.ms-excel");

		// 7. 输出流
		Writer.write(response, worksheet);
		
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getEmpQualificationInfoList(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));
		
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.hrReportDao.getEmpQualificationInfoList(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = this.hrReportDao.getEmpQualificationInfoList(paramMap);
		}
		return retrunList;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getEmpQualificationInfoCnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		return this.hrReportDao.getEmpQualificationInfoCnt(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getEmpQualificationDetailList(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));
		
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.hrReportDao.getEmpQualificationDetailList(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = this.hrReportDao.getEmpQualificationDetailList(paramMap);
		}
		return retrunList;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public int getEmpQualificationDetailCnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		return this.hrReportDao.getEmpQualificationDetailCnt(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public void getEmpQualificationInfoByExcel(HttpServletRequest request,
			HttpServletResponse response) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 附加信息
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request)); 
		
		List<String> codeList = new ArrayList<String>();
		codeList.add("EMPID");
		codeList.add("CHINESENAME");
		codeList.add("DEPTNAME");
		codeList.add("POST_NAME");
		codeList.add("QUALIFICATIONNUMBER");
		codeList.add("QUALIFICATIONNAMES");
		
		List<String> titleList = new ArrayList<String>();
		titleList.add("工号");
		titleList.add("姓名");
		titleList.add("部门");
		titleList.add("职位");
		titleList.add("证书数量");
		titleList.add("证书名称");
		// 1.创建一个 workbook
		HSSFWorkbook workbook = new HSSFWorkbook();

		// 2.创建一个 worksheet
		HSSFSheet worksheet = workbook.createSheet("证件台账");

		// 3.定义起始行和列
		int startRowIndex = 0;
		int startColIndex = titleList.size();

		// 4.创建title,data,headers 
		Layouter.buildQualificateReport(worksheet, startRowIndex, startColIndex, titleList);

		// 5.填充数据
		List dataList = this.hrReportDao.getEmpQualificationInfoList(paramMap);
		
		FillComputerManager.fillReport(worksheet, startRowIndex, startColIndex,
				dataList, codeList);

		// 6.设置reponse参数
		// 进行转码，使其支持中文文件名
		String fileName = null;
		try {
			fileName = java.net.URLEncoder.encode("证件台账", "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		response.setHeader("Content-Disposition", "inline; filename="
				+ fileName + ".xls");
		// 确保发送的当前文本格式
		response.setContentType("application/vnd.ms-excel");

		// 7. 输出流
		Writer.write(response, worksheet);
	}

    @Override
    public List getMenList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));
        
        if(paramMap.get("S_DATE") == null || paramMap.get("S_DATE").toString().equals(""))
        {
            paramMap.put("S_DATE", DateUtil.getDateString(new Date(), "yyyy-MM-dd"));
        }
        
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.hrReportDao.getMenList(paramMap,
                    NumberUtils.parseNumber(
                            ObjectUtils.toString(paramMap.get("page")),
                            Integer.class), NumberUtils.parseNumber(
                            ObjectUtils.toString(paramMap.get("pagesize")),
                            Integer.class));
        } else {
            retrunList = this.hrReportDao.getMenList(paramMap);
        }
        return retrunList;
    }

    @Override
    public int getMenCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        
        if(paramMap.get("S_DATE") == null || paramMap.get("S_DATE").toString().equals(""))
        {
            paramMap.put("S_DATE", DateUtil.getDateString(new Date(), "yyyy-MM-dd"));
        }
        
        return this.hrReportDao.getMenCnt(paramMap);
    }

    @Override
    public List getToolItemSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("TABLE_NAME", "HR_MEN_V");

        return this.utilityOtherInfoDao.getToolItemSelectList(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public void getMenListByExcel(HttpServletRequest request,
            HttpServletResponse response) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 附加信息
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request)); 
        if(paramMap.get("S_DATE") == null || paramMap.get("S_DATE").toString().equals(""))
        {
            paramMap.put("S_DATE", DateUtil.getDateString(new Date(), "yyyy-MM-dd"));
        }
        
        // 页面提交的JSON信息
        String jsonCodeString = request.getParameter("jsonData_code");
        List<String> codeList = new ArrayList<String>();
        if (jsonCodeString != null) {
            codeList = StringUtil.hashToList(StringUtil.stringToHash(jsonCodeString));
        }
        
        paramMap.put("codeList", codeList);
        List<String> titleList = this.hrReportDao.getHrTitleInfo(paramMap);
        
        // 1.创建一个 workbook
        HSSFWorkbook workbook = new HSSFWorkbook();
        
        // 2.创建一个 worksheet
        HSSFSheet worksheet = workbook.createSheet(paramMap.get("S_DATE")+"员工花名册");
        
        // 3.定义起始行和列
        int startRowIndex = 0;
        int startColIndex = titleList.size();
        
        // 4.创建title,data,headers 
        Layouter.buildHrMenReport(worksheet, startRowIndex, startColIndex, titleList);
        
        // 5.填充数据
        //将状态和审核状态转变成可识别的中文
        FillComputerManager.fillReport(worksheet, startRowIndex, startColIndex,
                this.hrReportDao.getMenList(paramMap), codeList);
        
        /*********************人员类型结构表部分*************************/
        // 2.创建一个 worksheet
        HSSFSheet worksheet2 = workbook.createSheet("人员结构");
        
        titleList.removeAll(titleList);
        titleList.add("公司属性");
        titleList.add("海波重科");
        titleList.add("中仑钢构");
        titleList.add("合计");
        
        codeList.removeAll(codeList);
        codeList.add("DATA_NAME");
        codeList.add("HAIOD_DATA");
        codeList.add("ZHONGL_DATA");
        codeList.add("TOTAL_DATA");
        
        // 3.定义起始行和列
        startRowIndex = 0;
        startColIndex = titleList.size();
        
        // 4.创建title,data,headers 
        Layouter.buildHrMenConstructReport(worksheet2, startRowIndex, startColIndex, titleList,"海波中仑比例");
        
        startRowIndex += 2;
        // 5.填充数据
        List dataList = this.hrReportDao.getMenTypeConstructList(paramMap);
        FillComputerManager.newFillReport(worksheet2, startRowIndex, startColIndex, dataList, codeList);
        
        /*********************海波人员学历结构表部分*************************/
        titleList.removeAll(titleList);
        titleList.add("学历属性");
        titleList.add("硕士");
        titleList.add("本科");
        titleList.add("大专");
        titleList.add("高中");
        titleList.add("中专");
        titleList.add("初中");
        titleList.add("小学");
        titleList.add("合计");
        startColIndex = titleList.size();
        
        codeList.removeAll(codeList);
        codeList.add("DATA_NAME");
        codeList.add("SHUO_COUNT");
        codeList.add("BEN_COUNT");
        codeList.add("DA_COUNT");
        codeList.add("GAO_COUNT");
        codeList.add("ZHONG_COUNT");
        codeList.add("CHU_COUNT");
        codeList.add("XIAO_COUNT");
        codeList.add("TOTAL_DATA");
        
        startRowIndex += (dataList.size() + 1);
        Layouter.buildHrMenConstructReport(worksheet2, startRowIndex, startColIndex, titleList,"海波学历结构表");
        
        startRowIndex += 2;
        paramMap.put("EMP_TYPE_CODE", "EmpDivision1");
        dataList = this.hrReportDao.getMenEduConstructList(paramMap);
        FillComputerManager.newFillReport(worksheet2, startRowIndex, startColIndex,dataList, codeList);
        
        /*********************中仑学历结构表部分*************************/
        
        startRowIndex += (dataList.size() + 1);
        Layouter.buildHrMenConstructReport(worksheet2, startRowIndex, startColIndex, titleList,"中仑学历结构表");
        
        startRowIndex += 2;
        dataList = this.hrReportDao.getMenTypeConstructList(paramMap);
        paramMap.put("EMP_TYPE_CODE", "EmpDivision3");
        dataList = this.hrReportDao.getMenEduConstructList(paramMap);
        FillComputerManager.newFillReport(worksheet2, startRowIndex, startColIndex, dataList, codeList);
        
        /*********************海波年龄结构表部分*************************/
        titleList.removeAll(titleList);
        titleList.add("年龄属性");
        titleList.add("25岁以下");
        titleList.add("26-35岁");
        titleList.add("36-45岁");
        titleList.add("46-55岁");
        titleList.add("56岁以上");
        titleList.add("合计");
        startColIndex = titleList.size();
        
        codeList.removeAll(codeList);
        codeList.add("DATA_NAME");
        codeList.add("LEVEL1_AGE");
        codeList.add("LEVEL2_AGE");
        codeList.add("LEVEL3_AGE");
        codeList.add("LEVEL4_AGE");
        codeList.add("LEVEL5_AGE");
        codeList.add("TOTAL_DATA");
        
        startRowIndex += (dataList.size() + 1);
        Layouter.buildHrMenConstructReport(worksheet2, startRowIndex, startColIndex, titleList,"年龄结构分布表");
        
        startRowIndex += 2;
        dataList = this.hrReportDao.getMenAgeConstructList(paramMap);
        FillComputerManager.newFillReport(worksheet2, startRowIndex, startColIndex,dataList, codeList);
        
        /*********************海波工龄结构表部分*************************/
        titleList.removeAll(titleList);
        titleList.add("工龄属性");
        titleList.add("1年以下");
        titleList.add("1-3年");
        titleList.add("3-5年");
        titleList.add("5-10年");
        titleList.add("10年以上");
        titleList.add("合计");
        startColIndex = titleList.size();
        
        codeList.removeAll(codeList);
        codeList.add("DATA_NAME");
        codeList.add("LEVEL1_WAGE");
        codeList.add("LEVEL2_WAGE");
        codeList.add("LEVEL3_WAGE");
        codeList.add("LEVEL4_WAGE");
        codeList.add("LEVEL5_WAGE");
        codeList.add("TOTAL_DATA");
        
        startRowIndex += (dataList.size() + 1);
        Layouter.buildHrMenConstructReport(worksheet2, startRowIndex, startColIndex, titleList,"工龄结构分布表");
        
        startRowIndex += 2;
        dataList = this.hrReportDao.getMenWAgeConstructList(paramMap);
        FillComputerManager.newFillReport(worksheet2, startRowIndex, startColIndex,dataList, codeList);
        // 99.设置reponse参数
        // 进行转码，使其支持中文文件名
        String fileName = null;
        try {
            fileName = java.net.URLEncoder.encode("员工花名册", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setHeader("Content-Disposition", "inline; filename="
                + fileName + ".xls");
        // 确保发送的当前文本格式
        response.setContentType("application/vnd.ms-excel");
        
        // 7. 输出流
        Writer.write(response, worksheet);
    }
}
