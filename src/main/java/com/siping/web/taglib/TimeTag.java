package com.siping.web.taglib;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.taglibs.standard.lang.support.ExpressionEvaluatorManager;

public class TimeTag extends TagSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected String name = null;

	protected String spacing = null;

	protected String selected = null;

	protected String onChange = null;

	protected String filling = null;

	protected String style = null;

	protected boolean disabled = false;

	public void setName(String name) {
		this.name = name;
	}

	public void setOnChange(String onChange) {
		this.onChange = onChange;
	}

	public void setSelected(String selected) {
		this.selected = selected;
	}

	public void setSpacing(String spacing) {
		this.spacing = spacing;
	}

	public void setFilling(String filling) {
		this.filling = filling;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public void setDisabled(boolean disabled) {
		this.disabled = disabled;
	}

	@SuppressWarnings({ "unused", "rawtypes" })
	@Override
	public int doEndTag() throws JspException {

		if (name != null) {
			name = eval("name", name, Object.class).toString();
		} else {
			name = "time";
		}

		if (selected != null) {
			selected = eval("selected", selected, Object.class).toString();
		} else {
			selected = "";
		}

		if (spacing != null) {
			spacing = eval("spacing", spacing, Object.class).toString();
		} else {
			spacing = "60";
		}

		if (onChange != null) {
			onChange = eval("onChange", onChange, Object.class).toString();
		} else {
			onChange = "";
		}

		HttpServletRequest request = (HttpServletRequest) pageContext
				.getRequest();

		JspWriter writer = pageContext.getOut();

		try {

			writer.print("<select id=\"" + name + "\" name=\"" + name + "\"");
			if (!"".equals(onChange)) {
				writer.print(" onChange=\"");
				writer.print(onChange);
				writer.print("\" ");
			}

			if (!"".equals(filling)) {
				writer.print(" ");
				writer.print(filling);
				writer.print(" ");
			}

			if (disabled) {
				writer.print(" disabled");
			}

			if (!"".equals(style)) {
				writer.println(" class=\"" + style + "\">");
			} else {
				writer.println(" class=\"input_select_short\">");
			}

			List list = new ArrayList();

			GregorianCalendar today = new GregorianCalendar();
			today.set(Calendar.HOUR_OF_DAY, 0);
			today.set(Calendar.MINUTE, 0);
			GregorianCalendar tomorrow = new GregorianCalendar();
			tomorrow.setTimeInMillis(today.getTimeInMillis());
			tomorrow.add(Calendar.DAY_OF_MONTH, 1);
			SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");

			while (today.before(tomorrow)) {

				String time = sdf.format(today.getTime());
				writer.print("<option value=\"" + time + "\"");

				if (time.equals(selected)) {
					writer.print(" selected ");
				}
				writer.println(">");
				writer.print(time);
				writer.println("</option>");

				today.add(Calendar.MINUTE, Integer.parseInt(spacing));
			}
 
		} catch (IOException ex) {

			throw new JspTagException(ex.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return EVAL_PAGE;
	}

	@SuppressWarnings("rawtypes")
	private Object eval(String attName, String attValue, Class clazz)
			throws JspException {
		Object obj = ExpressionEvaluatorManager.evaluate(attName, attValue,
				clazz, this, pageContext);
		if (obj == null) { 
			return "";
		} else {
			return obj;
		}
	}

}
