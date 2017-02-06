package com.siping.web.taglib;
  
import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;

import org.apache.taglibs.standard.lang.support.ExpressionEvaluatorManager; 
import org.springframework.web.servlet.tags.RequestContextAwareTag;
 
import com.siping.web.messages.Messages; 

@SuppressWarnings("serial")
public class ButtonConTag extends RequestContextAwareTag {
	
	protected String btnname = null;
	
	protected String onclick = null;
	
	protected String limit = null;
	
	
 
	
	/**
	 * tag body
	 */ 
	protected int doStartTagInternal() throws Exception {		
				
		if(limit != null){
			limit = eval("limit", limit, Object.class).toString();
		}else{
			limit = "all";
		}
		
		if(btnname != null){
			btnname = eval("btnname", btnname, Object.class).toString();
		}else{
			btnname = limit;
		}		

		if(onclick != null){
			onclick = eval("onclick", onclick, Object.class).toString();
		}else{
			onclick = btnname+"()";
		}
		
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		 
		try {   
			String approveString = Messages.getMessage(request, "hrms.approve");
			String rejectString = Messages.getMessage(request, "hrms.reject"); 
			
			JspWriter writer = pageContext.getOut();
			  
			writer.print("<a class='l-button' style='width:79px; height:20px; float:right; margin-left:10px;background-image: url(\"/resources/images/button/button.gif\");' onclick='spf_approve(1,3)'>"+approveString+"</a>"); 
			writer.print("<a class='l-button' style='width:79px; height:20px; float:right; margin-left:10px;background-image: url(\"/resources/images/button/button.gif\");' onclick='spf_reject(2,3)'>"+rejectString+"</a>"); 
					 
				 
		} catch (Exception ex) {
			throw new JspTagException(ex.getMessage());
		} 

		return EVAL_PAGE;
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

	public String getBtnname() {
		return btnname;
	}

	public void setBtnname(String btnname) {
		this.btnname = btnname;
	}

	public String getOnclick() {
		return onclick;
	}

	public void setOnclick(String onclick) {
		this.onclick = onclick;
	}

	public String getLimit() {
		return limit;
	}

	public void setLimit(String limit) {
		this.limit = limit;
	}
	

}
