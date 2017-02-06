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

import com.siping.att.dao.AttDaliyLockDao;
import com.siping.att.service.AttDaliyLockSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class AttDaliyLockSerImp implements AttDaliyLockSer {
    Logger logger = Logger.getLogger(AttDaliyLockSerImp.class);

    @Autowired
    private AttDaliyLockDao attDaliyLockDao;

    @SuppressWarnings({ "unchecked", "rawtypes" })
    public int updateAttDaliyLockInfo(HttpServletRequest request) {

        int result = 0;
        // 页面参数
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("UPDATED_BY", admin.getAdminID());
        result = this.attDaliyLockDao.updateAttDaliyLockInfo(paramMap);

        return result;
    }

    @SuppressWarnings({ "rawtypes" })
    public String getAttDaliyLockInfoHtml(HttpServletRequest request) {
        String frist = "";
        String Default = "";
        String actionType = ObjectUtils.toString(request.getParameter("actionType"));
        List calendarList = this.getAttDaliyLockInfo(request);
        if (calendarList.size() > 0) {
            String temp = this.getFrist(calendarList, actionType, request);
            int out = Integer.parseInt(temp.substring(temp.lastIndexOf("*") + 1, temp.length()));
            frist = temp.substring(0, temp.lastIndexOf("*"));
            Default = this.getDefault(out, calendarList, actionType, request);
        }

        return frist + Default;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List getAttDaliyLockInfo(HttpServletRequest request) {
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
        retrunList = this.attDaliyLockDao.getAttDaliyLockInfo(paramMap);
        return retrunList;
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

        calendarHtml += "<td height='30' valign='top' >";
        calendarHtml += "<table width='98.8%' border='0' cellspacing='0' cellpadding='0'>";
        calendarHtml += "<tr>";
        calendarHtml += "<td width='5%' height='20' align='center'>&nbsp;&nbsp;"
            + this.getDayColor(NumberUtils.parseNumber(calendarMap.get("IDAY").toString(), Integer.class), NumberUtils.parseNumber(calendarMap.get("IWEEK").toString(), Integer.class)) + "</td>";
        calendarHtml += "<td width='2%' height='20'>&nbsp;</td>";
        calendarHtml += "<td width='5%' height='20' align='right'>";
        calendarHtml += this.getImage(calendarMap.get("STATUS").toString(), calendarMap.get("AR_DATE_STR").toString(), Messages.getLanguage(request)) + "</td>";
        calendarHtml += "<td width='2%' height='20'>&nbsp;</td>";
        calendarHtml += "</tr>";
        calendarHtml += "</table></td>";

        return calendarHtml;
    }

    private String getDayColor(int day, int week) {
        String daycolor = null;
        switch (week) {
            case 0:
                daycolor = "<font color='red'>" + day + "</font>";
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
                daycolor = "<font color='red'>" + day + "</font>";
                break;
        }
        return daycolor;
    }

    public String getImage(String status, String date, String language) {
        date = '"' + date + '"';
        if (language != null && language.equals("zh")) {
            if (status.equals("LockStatus020")) {
                return "<img style='cursor: pointer;' title='未锁定' src='/resources/images/lock_open.gif' onclick='f_save(1," + date + ")'>";
            } else {
                return "<img style='cursor: pointer;' title='已锁定' src='/resources/images/lock.gif' onclick='f_save(0," + date + ")'>";
            }
        } else {
            if (status.equals("LockStatus020")) {
                return "<img style='cursor: pointer;' title='Unlocked' src='/resources/images/lock_open.gif' onclick='f_save(1," + date + ")'>";
            } else {
                return "<img style='cursor: pointer;' title='Locked' src='/resources/images/lock.gif' onclick='f_save(0," + date + ")'>";
            }
        }
    }
}
