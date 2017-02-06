/*
 * @(#)DateTag.java 1.0 2012-01-09 下午01:14:31
 *
 *Copyright 2010 - 2011 SipingSoft. All Rights Reserved.
 */
package com.siping.web.taglib;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;

import org.apache.taglibs.standard.lang.support.ExpressionEvaluatorManager;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

import com.siping.web.messages.Messages;

/**
 * Copyright: SipingSoft (c) Company: SipingSoft
 * 
 * @author (sipingSoft@SipingSoft.com)
 * @Date 2012-01-09 下午01:14:31
 * @version 1.0
 * 
 */

@SuppressWarnings("serial")
@Component
public class DateTag extends RequestContextAwareTag {

	protected String yearName = null;

	protected String monthName = null;

	protected String yearSelected = null;
  
	protected String monthSelected = null;
  
	protected String yearMinus = null;

	protected String yearPlus = null;

	protected String onChange = null;
	
	protected String limit = null; 

	protected boolean monthSelectedOnly = false;

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int doStartTagInternal() throws JspException {

		if (yearName != null) {
			yearName = eval("yearName", yearName, Object.class).toString();
		} else {
			yearName = "YYYY";
		}
		if (monthName != null) {
			monthName = eval("monthName", monthName, Object.class).toString();
		} 
		if (yearSelected != null && !yearSelected.equals("")) {
			Object object = eval("yearSelected", yearSelected, Object.class);
			if (object == null || object.equals("")) {
				yearSelected = this.getToday("yyyy");
			} else {
				yearSelected = object.toString();
			}
		} else {
			yearSelected = this.getToday("yyyy");
			
		}
		if (monthSelected != null && !monthSelected.equals("")) {
			Object object = eval("monthSelected", monthSelected, Object.class);
			if (object == null || object.equals("")) {
				monthSelected = this.getToday("MM");
			} else {
				monthSelected = object.toString();
			}
		} else {
			monthSelected = this.getToday("MM");
			/*monthSelected=getPreMonth(monthSelected);
		    if(monthSelected.equals("12")){
		    	yearSelected = ""+(Integer.parseInt(yearSelected)-1);
		    }*/
		}
		if (yearMinus != null) {
			yearMinus = eval("yearMinus", yearMinus, Object.class).toString();
		} else {
			yearMinus = "2";
		}
		if (yearPlus != null) {
			yearPlus = eval("yearPlus", yearPlus, Object.class).toString();
		} else {
			yearPlus = "1";
		}
		if (onChange != null) {
			onChange = eval("onChange", onChange, Object.class).toString();
		} else {
			onChange = "";
		}
		if (limit != null) {
			limit = eval("limit", limit, Object.class).toString();
		} else {
			limit = "";
		}
 
		HttpServletRequest request = (HttpServletRequest) pageContext
				.getRequest();
		Map paramMap=new LinkedHashMap(); 
		paramMap.put("language",Messages.getLanguage(request));

		JspWriter writer = pageContext.getOut();

		try {
			// YYYY
			writer.print("<select id= \"" + yearName + "\" name=\"" + yearName + "\"");

			if (!"".equals(onChange)) {
				writer.print(" onChange=\"");
				writer.print(onChange);
				writer.print("\" ");
			} 
			writer.println(">");
			
			if(!limit.equals("")&&limit.toLowerCase().equals("all")){ 
				if (paramMap.get("language").equals("zh"))
					writer.print("<option value=''>请选择</option>");
				else
					writer.print("<option value=''>Selection</option>");  
			}

			int i = 0;
			int minus = Integer.parseInt(yearMinus);
			int plus = Integer.parseInt(yearPlus);

			for (i = 0 - minus; i <= plus; i++) {

				writer.print("<option value=\""
						+ (Integer.parseInt(this.getToday("yyyy")) + i)
						+ "\"");

				if (("" + (Integer.parseInt(this.getToday("yyyy")) + i))
						.equals(yearSelected)) {
					writer.print(" selected ");
				}
				writer.println(">");
				writer.print(""
						+ (Integer.parseInt(this.getToday("yyyy")) + i));
				writer.println("</option>");

			}
			// 适应 9999 缺省选中
			if (yearSelected.equals("9999")) {
				writer.print("<option vlaue=\"9999\" selected>9999</option>");
			}
			writer.println("</select>");
			// writer.println("&nbsp;");

			if (monthName != null) {
				writer.print("<select id = \"" + monthName + "\" name=\"" + monthName + "\"");
				if (!"".equals(onChange)) {
					writer.print(" onChange=\"");
					writer.print(onChange);
					writer.print("\" ");
				}
				writer.println(">");

				if(!limit.equals("")&&limit.toLowerCase().equals("all")){ 
					if (paramMap.get("language").equals("zh"))
						writer.print("<option value=''>请选择</option>");
					else
						writer.print("<option value=''>Selection</option>");  
				}
				for (int j = 1; j <= 12; j++) {

					String tmp = "";
					if (j < 10) {
						tmp = "0";
					}
					if (!(tmp + j).equals(monthSelected) && monthSelectedOnly) {
						continue;
					}
					writer.print("<option value=\"" + tmp + j + "\"");
					if ((tmp + j).equals(monthSelected)) {
						writer.print(" selected ");
					}
					writer.println(">");
					writer.print(tmp + j);
					writer.println("</option>");

				}
				writer.println("</select>");
			}
			
		} catch (IOException ex) {
			throw new JspTagException(ex.getMessage());
		}

		return EVAL_PAGE;
	}

	/**
	 * @param deduct
	 *            The deduct to set.
	 */
	public void setYearName(String yearName) {
		this.yearName = yearName;
	}

	@SuppressWarnings({ "rawtypes" })
	private Object eval(String attName, String attValue, Class clazz) throws JspException {
		Object obj = ExpressionEvaluatorManager.evaluate(attName, attValue, clazz, this, pageContext);
		if (obj == null) {
			return "";
		} else {
			return obj;
		}
	}

	/**
	 * @param monthName
	 *            The codeClass to set.
	 */
	public void setMonthName(String monthName) {
		this.monthName = monthName;
	}

	/**
	 * @param selected
	 *            The selected to set.
	 */
	public void setYearSelected(String yearSelected) {
		this.yearSelected = yearSelected;
	}

	/**
	 * @param onChange
	 *            The onChange to set.
	 */
	public void setMonthSelected(String monthSelected) {
		this.monthSelected = monthSelected;
	}

	public void setYearMinus(String yearMinus) {
		this.yearMinus = yearMinus;
	}

	public void setYearPlus(String yearPlus) {
		this.yearPlus = yearPlus;
	}

	public void setOnChange(String onChange) {
		this.onChange = onChange;
	} 

	public void setLimit(String limit) {
		this.limit = limit;
	}

	public void setMonthSelectedOnly(boolean monthSelectedOnly) {
		this.monthSelectedOnly = monthSelectedOnly;
	}

	/**
	 * 根据格式参数返回当前日期
	 * @param pOutformat
	 * @return String
	 */
    private String getToday(String pOutformat) {

        SimpleDateFormat pOutformatter = new SimpleDateFormat(pOutformat,
                java.util.Locale.CHINA);

        String rDateString = null;
        Date vDate = new Date();

        try {
            rDateString = pOutformatter.format(vDate);

        } catch (Exception e) {
        }

        return rDateString;
    }
    /**
	 * 获取当前月的前一个月
	 * @param 1606 代表16年06月
	 * @return String
	 */
    public String getPreMonth(String month){
		if(month.equals("12")){
			return "11";
		}else if(month.equals("11")){
			return "10";
		}else if(month.equals("10")){
			return "09";
		}else if(month.equals("01")){
			return "12";
		}else{
			return "0"+(Integer.parseInt(month.substring(1))-1);
		}
	}
}
