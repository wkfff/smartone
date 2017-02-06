package com.siping.att.service.impl;

import java.util.ArrayList; 
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.att.dao.EmpCalendarDao;
import com.siping.att.dao.ShiftDao;
import com.siping.att.service.EmpCalendarSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.StringUtil;

@Service
public class EmpCalendarSerImp implements EmpCalendarSer {

	@Autowired
	private EmpCalendarDao empCalendarDao;
	@Autowired
	private ShiftDao shiftDao;

	@SuppressWarnings({ "rawtypes" })
	public String getEmpCalendarViewHtml(HttpServletRequest request) {
		String frist = "";
		String Default = ""; 

		String actionType = StringUtil.checkNull(request
				.getParameter("actionType"),"edit");
		
		List calendarList = this.getEmpCalendarList(request);
		if (calendarList.size() > 0) {
			String temp = this.getFrist(calendarList, actionType,request);

			int out = Integer.parseInt(temp.substring(
					temp.lastIndexOf("*") + 1, temp.length()));
			frist = temp.substring(0, temp.lastIndexOf("*"));
			Default = this.getDefault(out, calendarList, actionType,request);
		}
		return frist + Default;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public List getEmpCalendarList(HttpServletRequest request) {

		LinkedHashMap paramMap = new LinkedHashMap();
		List retrunList = new ArrayList(); 
		String arMonth = "";
		
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		String empID = StringUtil.checkNull(request.getParameter("EMPID"),
				admin.getAdminID());
		String year = ObjectUtils.toString(request.getParameter("year"));
		String month = ObjectUtils.toString(request.getParameter("month"));

		if (year == null || year.length() == 0) {
			year = DateUtil.getSysdateString("yyyy");
			month = DateUtil.getSysdateString("MM");
		}
		arMonth = year + month;
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("AR_MONTH", arMonth);
		paramMap.put("EMPID", empID);

		retrunList = empCalendarDao.getEmpCalendarList(paramMap);

		return retrunList;
	}

	@SuppressWarnings({ "rawtypes" })
	private String getFrist(List calendarList, String actionType,HttpServletRequest request) {

		String frist = "";
		int out = 0;

		// 得到第1天是星期几
		LinkedHashMap calendarMap0 = (LinkedHashMap) calendarList.get(0);
		out = 7 - NumberUtils.parseNumber(calendarMap0.get("IWEEK").toString(),
				Integer.class);

		for (int i = 0; i < 7 - out; ++i) {
			frist += "<td>&nbsp;</td>";
		}

		for (int i = 0; i < out; i++) {
			LinkedHashMap calendarMap = (LinkedHashMap) calendarList.get(i);

			frist += this.createViewCalendarHtml(calendarMap, actionType,request);
		}

		return "<tr>" + frist + "</tr>*" + out;
	}

	@SuppressWarnings({ "rawtypes" })
	private String getDefault(int out, List calendarList, String actionType,HttpServletRequest request) {

		int r = 0;
		int rows = 0;
		if ((calendarList.size() - out) % 7 != 0) {// 算出 剩余的有几行
			rows = (calendarList.size() - out) / 7 + 1;
		} else {
			rows = (calendarList.size() - out) / 7;
		}
		rows = rows * 7;// 总共多少格子
		rows = rows - (calendarList.size() - out);// 到最后一行剩余几格子
		String Default = "";
		for (int i = out; i < calendarList.size(); i++) {
			LinkedHashMap calendarMap = (LinkedHashMap) calendarList.get(i);
			if (r == 0 || r == 7 || r == 14 || r == 21 || r == 28) {// 加换行
				Default += "<tr>";
			}

			Default += this.createViewCalendarHtml(calendarMap, actionType,request);

			if (r == 6 || r == 13 || r == 20 || r == 27 || r == 34) {// 加换行
				Default += "</tr>";
			}
			r += 1;
		}
		// 补空格
		if (rows > 0) {
			String temp = "";
			for (int i = 0; i < rows; i++) {
				temp += "<td>&nbsp;</td>";
			}
			Default += temp + "</tr>";
		}
		return Default;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	private String createViewCalendarHtml(LinkedHashMap calendarMap,
			String actionType,HttpServletRequest request) {

		LinkedHashMap paramMap = new LinkedHashMap();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("language", Messages.getLanguage(request));
		paramMap.put("CPNY_ID", admin.getCpnyId());
		List shiftList = this.shiftDao.getShiftInfoList(paramMap);// 获取班次

		boolean flag = false;
		if (!ObjectUtils.toString(calendarMap.get("SCHEDULE_SHIFT_NO")).equals(
				"")) {
			flag = true;
		}

		String calendarHtml = "";

		calendarHtml += "<td height='25px;' valign='middle' >";
		calendarHtml += "<table width='98.8%' border='0' cellspacing='0' cellpadding='0'>";

		if (actionType != null && actionType.equals("edit")) {
		calendarHtml += "<tr><td height=\"2\"></td></tr><tr><td align=\"left\" style=\"font-size: 12px;\">&nbsp;<input name=\"day\" value=\""
				+ calendarMap.get("DDATE_STR").toString()
				+ "\" type= \"checkbox\" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
				+ this.getDayColor(NumberUtils.parseNumber(
						calendarMap.get("IDAY").toString(), Integer.class),
						NumberUtils.parseNumber(calendarMap.get("IWEEK")
								.toString(), Integer.class)) +"</td></tr>";
		}

		calendarHtml += "<tr><td height='6' style=\"font-size: 12px;\">";
		String p = Messages.getMessage(request,"personal");
		String g = Messages.getMessage(request,"company");
		String type = flag ? "<font color=\"red\" style=\"font-size: 12px;\">["+p+"]</font>&nbsp;&nbsp;["+g+"]"
				: "["+p+"]&nbsp;&nbsp;<font color=\"red\" style=\"font-size: 12px;\">["+g+"]</font>";
		calendarHtml += type + "</td></tr>";
		calendarHtml += "<tr>";

		calendarHtml += "<td height=\"6\" style=\"font-size: 12px;\">";
		calendarHtml += "<select name=\"SHIFT_NO_"
				+ calendarMap.get("DDATE_STR").toString() + "\" id=\"SHIFT_NO_"
				+ calendarMap.get("DDATE_STR").toString() + "\">";
		for (int i = 0; i < shiftList.size(); i++) {
			LinkedHashMap map = (LinkedHashMap) shiftList.get(i);
			String temp = "";
			String tempShitNo = "";

			if (flag) {
				tempShitNo = calendarMap.get("SCHEDULE_SHIFT_NO").toString();
			} else {
				tempShitNo = calendarMap.get("SHIFT_NO").toString();
			}
			if (tempShitNo.equals(map.get("SHIFT_NO").toString())) {
				temp = "selected";
			}
			calendarHtml += "<option value=\"" + map.get("SHIFT_NO").toString()
					+ "\"" + temp + ">";
			if(paramMap.get("language").equals("en")){
				calendarHtml += map.get("SHIFT_EN_NAME").toString()
						+ "-["+map.get("SHIFT_NO").toString()+"]" + "</option>";
			}else{
				calendarHtml += map.get("SHIFT_NAME").toString()
						+ "-["+map.get("SHIFT_NO").toString()+"]" + "</option>";
			} 
		}

		calendarHtml += "</td></tr><tr><td height=\"2\"></td></tr>";
		calendarHtml += "</table></td>";

		return calendarHtml;
	}

	private String getDayColor(int day, int week) {
		String daycolor = null;
		switch (week) {
		case 0:
			daycolor = "<font color=\"red\" style=\"font-size: 12px;\">" + day + "</font>";
			break;
		case 1:
			daycolor = Integer.toString(day);
			break;
		case 2:
			daycolor = Integer.toString(day);
			break;
		case 3:
			daycolor = Integer.toString(day);
			break;
		case 4:
			daycolor = Integer.toString(day);
			break;
		case 5:
			daycolor = Integer.toString(day);
			break;
		case 6:
			daycolor = "<font color=\"red\" style=\"font-size: 12px;\">" + day + "</font>";
			break;
		}
		return daycolor;
	}

	@SuppressWarnings("unused")
	private String getWorkName(int i, String language) {
		if (language != null && language.equals("zh")) {
			if (i == 0)
				return "不工作";
			else
				return "工作";
		} else if (language != null && language.equals("ko")) {

		} else {
			if (i == 0)
				return "Rest Day";
			else
				return "Work Day";
		}
		return "";
	}

	public int updateEmpCalendarInfo(HttpServletRequest request) {

		// 页面提交的JSON信息
		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> empCalendarList = ObjectBindUtil
				.getRequestJsonData(jsonString);

		for (int i = 0; i < empCalendarList.size(); i++) {
			LinkedHashMap<String, Object> map = (LinkedHashMap<String, Object>) empCalendarList
					.get(i);
			this.empCalendarDao.deleteEmpCalendarInfo(map);

			if (this.empCalendarDao.getEmpCalendarInfo(map) == 0) {

				this.empCalendarDao.insertEmpCalendarInfo(map);
			} 
		} 
		return 0;
	}

}
