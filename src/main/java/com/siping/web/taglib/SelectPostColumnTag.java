package com.siping.web.taglib;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import org.apache.taglibs.standard.lang.support.ExpressionEvaluatorManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

import com.siping.system.service.SystemSer;
import com.siping.web.messages.Messages;

@SuppressWarnings("serial")
@Component
public class SelectPostColumnTag extends RequestContextAwareTag {

	protected String name = null;

	protected String selected = null;

	protected String onChange = null;

	protected String limit = null;

	@Autowired
	private SystemSer systemSer;

	/**
	 * tag body
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int doStartTagInternal() throws JspException {

		name = eval("name", name, Object.class).toString();

		if (selected != null) {
			selected = eval("selected", selected, Object.class).toString();
		} else {
			selected = "";
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

		systemSer = (SystemSer) getRequestContext().getWebApplicationContext()
				.getAutowireCapableBeanFactory().getBean("systemSerImpl");

		HttpServletRequest request = (HttpServletRequest) pageContext
				.getRequest();

		Map paramMap = new LinkedHashMap();
		paramMap.put("language", Messages.getLanguage(request));

		List codeList = systemSer.getPostColumn(paramMap);

		try {

			JspWriter writer = pageContext.getOut();


			writer.print("<select style=\"width: 120px;font-size: 12px;\" id=\"" + name + "\" name=\"" + name + "\"");
			if (!"".equals(onChange)) {
				writer.print(" onChange=\"");
				writer.print(onChange);
				writer.print("\" ");
			}
			writer.print(">");

			if (!limit.equals("") && limit.toLowerCase().equals("all")) {
				if (paramMap.get("language").equals("zh"))
					writer.print("<option value=''>请选择</option>");
				else
					writer.print("<option value=''>Selection</option>");  
			}

			for (Object map : codeList) {
				Map temp = (Map) map;
				writer.print("<option value='" + temp.get("POST_COLUMN_ID")
						+ "'");
				if (temp.get("POST_COLUMN_ID").equals(selected)) {
					writer.print(" selected ");
				}
				writer.print(">" + temp.get("POST_COLUMN_NAME") + "</option>");
			}
			writer.print("</select>");

		} catch (Exception ex) {
			throw new JspTagException(ex.getMessage());
		}

		return EVAL_PAGE;
	}

	@SuppressWarnings({ "rawtypes" })
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSelected() {
		return selected;
	}

	public void setSelected(String selected) {
		this.selected = selected;
	}

	 
	public String getOnChange() {
		return onChange;
	}

	public void setOnChange(String onChange) {
		this.onChange = onChange;
	}
	
	public String getLimit() {
		return limit;
	}

	public void setLimit(String limit) {
		this.limit = limit;
	}

}
