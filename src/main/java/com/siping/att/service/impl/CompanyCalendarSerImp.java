package com.siping.att.service.impl;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.att.dao.CompanyCalendarDao;
import com.siping.att.service.CompanyCalendarSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.ObjectBindUtil;

@Service
public class CompanyCalendarSerImp implements CompanyCalendarSer {

    Logger logger = Logger.getLogger(CompanyCalendarSerImp.class);

    @Autowired
    private CompanyCalendarDao companyCalendarDao;

    @SuppressWarnings({ "rawtypes" })
    public String getCompanyCalendarInfoHtml(HttpServletRequest request) {
        String frist = "";
        String Default = "";
        String actionType = ObjectUtils.toString(request.getParameter("actionType"));
        List calendarList = this.getCompanyCalendarInfo(request);
        if (calendarList.size() > 0) {
            String temp = this.getFrist(calendarList, actionType, request);
            int out = Integer.parseInt(temp.substring(temp.lastIndexOf("*") + 1, temp.length()));
            frist = temp.substring(0, temp.lastIndexOf("*"));
            Default = this.getDefault(out, calendarList, actionType, request);
        }
        return frist + Default;
    }

    @SuppressWarnings({ "rawtypes" })
    private String getFrist(List calendarList, String actionType, HttpServletRequest request) {

        String frist = "";
        int out = 0;

        // 得到第1天是星期几
        LinkedHashMap calendarMap0 = (LinkedHashMap) calendarList.get(0);
        out = 7 - NumberUtils.parseNumber(calendarMap0.get("IWEEK").toString(), Integer.class);

        for (int i = 0; i < 7 - out; ++i) {
            frist += "<td>&nbsp;</td>";
        }

        for (int i = 0; i < out; i++) {
            LinkedHashMap calendarMap = (LinkedHashMap) calendarList.get(i);

            frist += this.createCalendarHtml(calendarMap, actionType, request);
        }

        return "<tr>" + frist + "</tr>*" + out;
    }

    @SuppressWarnings({ "rawtypes" })
    private String getDefault(int out, List calendarList, String actionType, HttpServletRequest request) {

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

            Default += this.createCalendarHtml(calendarMap, actionType, request);

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

    @SuppressWarnings({ "rawtypes" })
    private String createCalendarHtml(LinkedHashMap calendarMap, String actionType, HttpServletRequest request) {
        String calendarHtml = "";

        calendarHtml += "<td height='25px;' valign='middle' >";
        calendarHtml += "<table width='98.8%' border='0' cellspacing='0' cellpadding='0'>";

        if (actionType != null && actionType.equals("edit")) {
            calendarHtml += "<tr><td height=\"4\"></td></tr><tr><td style=\"font-size: 12px;\"><input name=\"day\" value=\"" + calendarMap.get("DDATE_STR").toString()
                + "\" type= \"checkbox\" /></td></tr><tr>";
        } else {
            calendarHtml += "<tr><td colspan='2' height=\"4\"></td></tr><tr>";
        }

        calendarHtml += "<td style=\"font-size: 12px;\">"
            + this.getDayColor(NumberUtils.parseNumber(calendarMap.get("IDAY").toString(), Integer.class), NumberUtils.parseNumber(calendarMap.get("IWEEK").toString(), Integer.class)) + "</td>";
        calendarHtml += "<td height='10' width='60%' style=\"font-size: 12px;\">";
        calendarHtml += calendarMap.get("TYPE_NAME").toString() + "</td></tr>";
        calendarHtml += "<tr><td height=\"6\" colspan='2' align='center' style=\"font-size: 12px;\">";
        calendarHtml += calendarMap.get("SHIFT_NAME").toString() + "</td></tr><tr><td colspan='2' height=\"4\"></td></tr>";
        calendarHtml += "</table></td>";

        return calendarHtml;
    }

    @SuppressWarnings("unused")
    private String getweekName(int i, String language) {
        String weekName = null;
        switch (i) {
            case 0:
                weekName = "<font color=\"red\" style=\"font-size: 12px;\">日</font>";
                break;
            case 1:
                weekName = "一";
                break;
            case 2:
                weekName = "二";
                break;
            case 3:
                weekName = "三";
                break;
            case 4:
                weekName = "四";
                break;
            case 5:
                weekName = "五";
                break;
            case 6:
                weekName = "<font color=\"red\" style=\"font-size: 12px;\">六</font>";
                break;
        }

        return weekName;
    }

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

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List getCompanyCalendarInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();

        String arMonth = "";
        String year = ObjectUtils.toString(request.getParameter("year"));
        String month = ObjectUtils.toString(request.getParameter("month"));

        if (year == null || year.length() == 0) {
            year = DateUtil.getSysdateString("yyyy");
            month = DateUtil.getSysdateString("MM");
        }
        arMonth = year + month;

        LinkedHashMap paramMap = new LinkedHashMap();

        paramMap.put("AR_MONTH", arMonth);
        paramMap.put("language", Messages.getLanguage(request));

        retrunList = this.companyCalendarDao.getCompanyCalendarInfo(paramMap);

        return retrunList;
    }

    @SuppressWarnings({ "rawtypes" })
    public int addCompanyCalendarInfo(HttpServletRequest request) {

        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        this.companyCalendarDao.addCompanyCalendarInfo(paramMap);

        return 0;
    }

    public int updateCompanyCalendarInfo(HttpServletRequest request) {

        // 页面提交的JSON信息
        String jsonString = request.getParameter("jsonData");

        List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString);

        this.companyCalendarDao.updateCompanyCalendarInfo(updateList);

        return 0;
    }
}
