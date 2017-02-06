package com.siping.web.utility;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;

public class DateUtil {
    Logger logger = Logger.getLogger(DateUtil.class);

    private static DateUtil instance;

    public DateUtil() {
        if (instance == null) {
            getInstance();
        }
    }

    public static DateUtil getInstance() {
        return new DateUtil();
    }

    /**
     * 
     * @param dataFormat
     *            "yyyy-MM-dd" "yyyy-MM-dd HH:mm" "yyyy-MM-dd HH:mm:SS" "yyyyMM"
     *            "yyyy" "MM" "yyyyMMddHHmmssSSS"
     * @return
     */
    public static String getSysdateString(String timeFormat) {
        return getDateString(Calendar.getInstance().getTime(), timeFormat);
    }

    /**
     * 日期转化为字符串
     * 
     * @param date
     * @param timeFormat
     * @return
     */
    public static String getDateString(Date date, String timeFormat) {
        if (timeFormat == null || timeFormat.equals("")) {
            timeFormat = "yyyy-MM-dd";
        }
        SimpleDateFormat timeFormatter = new SimpleDateFormat(timeFormat);
        String sDate = timeFormatter.format(date);
        return sDate;
    }

    /**
     * 将长时间格式字符串转换为时间
     * 
     * @param strDate
     * @param timeFormat
     * @return
     */
    public static String strToDateLong(String strDate, String timeFormat, String reTimeFormat) {
        SimpleDateFormat formatter = new SimpleDateFormat(timeFormat);
        SimpleDateFormat reFormatter = new SimpleDateFormat(reTimeFormat);
        Date strtodate = new Date();
        String dateString = "";
        try {
            strtodate = formatter.parse(strDate);
            dateString = reFormatter.format(strtodate);
        } catch (ParseException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return dateString;
    }

    /**
     * Date to String
     * 
     * @param d
     * @param formatPattern
     * @return
     */
    public static String formatDate(Date d, String formatPattern) {
        if (d == null) {
            return "";
        }
        SimpleDateFormat timeFormatter = new SimpleDateFormat(formatPattern);
        String sDate = timeFormatter.format(d);
        return sDate;
    }

    /**
     * 
     * @param dateStr
     * @return
     */
    public static GregorianCalendar ParseGregorianCalendar(String dateStr) {
        GregorianCalendar gregorianCalendar = new GregorianCalendar();
        gregorianCalendar.clear();
        if (dateStr != null) {
            if (dateStr.length() == 10) {
                // yyyy-MM-dd
                gregorianCalendar.set(
                        Integer.parseInt(dateStr.substring(0, 4)),
                        Integer.parseInt(dateStr.substring(5, 7)) - 1,
                        Integer.parseInt(dateStr.substring(8, 10)), 0, 0, 0);
            } else if (dateStr.length() == 13) {
                // yyyy-MM-dd hh
                gregorianCalendar.set(
                        Integer.parseInt(dateStr.substring(0, 4)),
                        Integer.parseInt(dateStr.substring(5, 7)) - 1,
                        Integer.parseInt(dateStr.substring(8, 10)),
                        Integer.parseInt(dateStr.substring(11, 13)), 0, 0);
            } else if (dateStr.length() == 16) {
                // yyyy-MM-dd hh:mm
                gregorianCalendar.set(
                        Integer.parseInt(dateStr.substring(0, 4)),
                        Integer.parseInt(dateStr.substring(5, 7)) - 1,
                        Integer.parseInt(dateStr.substring(8, 10)),
                        Integer.parseInt(dateStr.substring(11, 13)),
                        Integer.parseInt(dateStr.substring(14, 16)), 0);
            } else if (dateStr.length() >= 19) {
                // yyyy-MM-dd hh:mm:ss
                gregorianCalendar.set(
                        Integer.parseInt(dateStr.substring(0, 4)),
                        Integer.parseInt(dateStr.substring(5, 7)) - 1,
                        Integer.parseInt(dateStr.substring(8, 10)),
                        Integer.parseInt(dateStr.substring(11, 13)),
                        Integer.parseInt(dateStr.substring(14, 16)),
                        Integer.parseInt(dateStr.substring(17, 19)));
            }
        }
        
        return gregorianCalendar;
    }

    /**
     * 
     * @param fromDate1
     * @param toDate1
     * @param fromDate2
     * @param toDate2
     * @param type
     * @return
     */
    public static long DateCross(Date fromDate1, Date toDate1, Date fromDate2,
            Date toDate2, String type) {
        GregorianCalendar gregorianCalendar1 = new GregorianCalendar();
        gregorianCalendar1.setTime(fromDate1);
        GregorianCalendar gregorianCalendar2 = new GregorianCalendar();
        gregorianCalendar2.setTime(toDate1);
        GregorianCalendar gregorianCalendar3 = new GregorianCalendar();
        gregorianCalendar1.setTime(fromDate2);
        GregorianCalendar gregorianCalendar4 = new GregorianCalendar();
        gregorianCalendar2.setTime(toDate2);
        
        return DateCross(gregorianCalendar1, gregorianCalendar2, gregorianCalendar3, gregorianCalendar4, type);
    }

    /**
     * 
     * @param fromDate1
     * @param toDate1
     * @param fromDate2
     * @param toDate2
     * @param type
     * @return
     */
    public static long DateCross(GregorianCalendar fromDate1, GregorianCalendar toDate1,
            GregorianCalendar fromDate2, GregorianCalendar toDate2, String type) {
        long length = 0;
        GregorianCalendar fromDate = fromDate1;
        GregorianCalendar toDate = toDate1;
        if (fromDate2.after(fromDate1)) {
            fromDate = fromDate2;
        }
        if (toDate2.before(toDate1)) {
            toDate = toDate2;
        }
        if (fromDate.after(toDate)) {
            length = 0;
        } else {
            length = DateDiff(fromDate, toDate, type);
        }
        
        Logger.getLogger(DateUtil.class).debug( "length : " + String.valueOf(length));
        return length;
    }

    /**
     * 申请休假以天为单位没有开始结束时间， 重载计算时间差的方法
     * 
     * @param fromDate1
     * @param toDate1
     * @param fromDate2
     * @param toDate2
     * @return
     */
    public static long DateCross(GregorianCalendar fromDate1, GregorianCalendar toDate1
            , GregorianCalendar fromDate2, GregorianCalendar toDate2) {
        long length = 0;
        GregorianCalendar fromDate = fromDate1;
        GregorianCalendar toDate = toDate1;
        if (fromDate2.compareTo(fromDate1) >= 0)
            fromDate = fromDate2;
        if (toDate2.compareTo(toDate1) <= 0)
            toDate = toDate2;
        if (fromDate.compareTo(toDate) >= 0)
            length = 0;
        else{
            length = 1;
        }
        Logger.getLogger(DateUtil.class).debug("length : " + String.valueOf(length));
        return length;
    }

    /**
     * 返回两个日期之间的差
     * 
     * @param date1
     * @param date2
     * @param type
     * @return
     */
    public static long DateDiff(GregorianCalendar date1, GregorianCalendar date2, String type) {
        long difference = 0;
        long milliseconds = date2.getTimeInMillis() - date1.getTimeInMillis();
        type = StringUtil.checkNull(type);
        if (type.equalsIgnoreCase("YEAR")) {
            difference = date2.get(GregorianCalendar.YEAR) - date1.get(GregorianCalendar.YEAR);
            if (dateAdd(date1, "YEAR", Integer.parseInt(String.valueOf(difference))).after(date2)){
                difference = difference - 1;
            }
        } else if (type.equalsIgnoreCase("MONTH")) {
            difference = date2.get(GregorianCalendar.MONTH) - dateAdd(date1,"YEAR",
                Integer.parseInt(String.valueOf(DateDiff(date1,date2, "YEAR")))).get(GregorianCalendar.MONTH);
            if (dateAdd(date1, "MONTH", Integer.parseInt(String.valueOf(DateDiff(date1, date2,"YEAR") * 12 + difference))).after(date2)){
                difference = difference - 1;
            }
        } else if (type.equalsIgnoreCase("DAY"))
            difference = milliseconds / 1000 / 60 / 60 / 24;
        else if (type.equalsIgnoreCase("HOUR"))
            difference = milliseconds / 1000 / 60 / 60;
        else if (type.equalsIgnoreCase("MINUTE"))
            difference = milliseconds / 1000 / 60;
        else if (type.equalsIgnoreCase("SECOND"))
            difference = milliseconds / 1000;
        else if (type.equalsIgnoreCase("MILLISECOND"))
            difference = milliseconds;
        
        return difference;
    }

    /**
     * 
     * @param date
     * @param type
     * @param integer
     * @return
     */
    public static java.util.Date dateAdd(Date date, String type, int integer) {
        GregorianCalendar gregorianCalendar = new GregorianCalendar();
        gregorianCalendar.setTime(date);
        return dateAdd(gregorianCalendar, type, integer).getTime();
    }

    /**
     * 返回某日期加减一个数值后的结果日期
     * 
     * @param date
     * @param type
     * @param integer
     * @return
     */
    public static GregorianCalendar dateAdd(GregorianCalendar date, String type, int integer) {
        GregorianCalendar dateAfter = date;
        type = StringUtil.checkNull(type);
        if (type.equalsIgnoreCase("YEAR"))
            dateAfter.add(Calendar.YEAR, integer);
        else if (type.equalsIgnoreCase("MONTH"))
            dateAfter.add(Calendar.MONTH, integer);
        else if (type.equalsIgnoreCase("DAY"))
            dateAfter.add(Calendar.DAY_OF_MONTH, integer);
        else if (type.equalsIgnoreCase("WEEK"))
            dateAfter.add(Calendar.WEEK_OF_YEAR, integer);
        else if (type.equalsIgnoreCase("WEEK_OF_YEAR"))
            dateAfter.add(GregorianCalendar.WEEK_OF_YEAR, integer);
        else if (type.equalsIgnoreCase("WEEK_OF_MONTH"))
            dateAfter.add(GregorianCalendar.WEEK_OF_MONTH, integer);
        else if (type.equalsIgnoreCase("HOUR"))
            dateAfter.add(GregorianCalendar.HOUR, integer);
        else if (type.equalsIgnoreCase("MINUTE"))
            dateAfter.add(GregorianCalendar.MINUTE, integer);
        else if (type.equalsIgnoreCase("SECOND"))
            dateAfter.add(GregorianCalendar.SECOND, integer);
        else if (type.equalsIgnoreCase("MILLISECOND"))
            dateAfter.add(GregorianCalendar.MILLISECOND, integer);
        
        return dateAfter;
    }
    /**
     * 产生指定大小的序列号
     * 
     * @param size
     * @param removeNum
     * @return
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public static List getTimeList(Map paraMap) {
        String spacing = paraMap.get("spacing").toString();
        if (spacing == null || spacing.equals("")) {
            spacing = "60";
        }
        List Rows = new ArrayList<Object>();
        GregorianCalendar today = new GregorianCalendar();
        today.set(Calendar.HOUR_OF_DAY, 0);
        today.set(Calendar.MINUTE, 0);
        GregorianCalendar tomorrow = new GregorianCalendar();
        tomorrow.setTimeInMillis(today.getTimeInMillis());
        tomorrow.add(Calendar.DAY_OF_MONTH, 1);
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
        while (today.before(tomorrow)) {
            Map object1 = new LinkedHashMap();
            String time = sdf.format(today.getTime());
            object1.put("TIME_ID", time);
            object1.put("TIME_NAME", time);
            Rows.add(object1);
            today.add(Calendar.MINUTE, Integer.parseInt(spacing));
        }
        
        return Rows;
    }
    /**
     * 获取指定月份前的日期
     * 
     * @param size
     * @param removeNum
     * @return
     */
    public static Date getPurMonthDate(Date date,int preIndex) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.MONTH, preIndex);
        return cal.getTime();
    }

    /**
     * 调用html5的时间控件传值时带有字符‘T’，需要去掉后再转换成Data类型
     * @param date
     * @param preIndex
     * @return
     */
    public static String removeCharT(String dateString) {
        return dateString.replace("T", " ");
    }
    
    /**  
     * 计算两个日期之间相差的天数  
     * @param smdate 较小的时间 
     * @param bdate  较大的时间 
     * @return 相差天数 
     * @throws ParseException  
     */    
    public static int daysBetween(Date smdate,Date bdate) throws ParseException    
    {    
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");  
        smdate=sdf.parse(sdf.format(smdate));  
        bdate=sdf.parse(sdf.format(bdate));  
        Calendar cal = Calendar.getInstance();    
        cal.setTime(smdate);    
        long time1 = cal.getTimeInMillis();                 
        cal.setTime(bdate);    
        long time2 = cal.getTimeInMillis();         
        long between_days=(time2-time1)/(1000*3600*24);  
            
       return Integer.parseInt(String.valueOf(between_days));           
    }
    
    /** 
    *字符串的日期格式的计算 
    */  
    public static int daysBetween(String smdate,String bdate) throws ParseException{  
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");  
        Calendar cal = Calendar.getInstance();    
        cal.setTime(sdf.parse(smdate));    
        long time1 = cal.getTimeInMillis();                 
        cal.setTime(sdf.parse(bdate));    
        long time2 = cal.getTimeInMillis();         
        long between_days=(time2-time1)/(1000*3600*24);  
            
       return Integer.parseInt(String.valueOf(between_days));     
    }
    
    /** 
     *计算几年之后的日期 
     */  
     public static String daysAfterYears(Date date,int years) throws ParseException{  
        	   java.text.Format formatter=new java.text.SimpleDateFormat("yyyy-MM-dd");
//		 		 几年之后的时间	
	       long afterTime=(date.getTime()/1000)+60*60*24*365*years;    
	       date.setTime(afterTime*1000);    
	       String afterDate=formatter.format(date);    
	        	 
	       return afterDate;
     }
}
