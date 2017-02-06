package com.siping.web.taglib;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;

import org.apache.taglibs.standard.lang.support.ExpressionEvaluatorManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

import com.siping.system.bean.AdminBean;
import com.siping.system.service.SystemSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@SuppressWarnings("serial")
public class ButtonTag extends RequestContextAwareTag {
	
	protected String btnname = null;
	
	protected String onclick = null;
	
	protected String limit = null;
	
	@Autowired
	private SystemSer systemSer;	
	
	/**
	 * tag body
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
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
		
		String url = request.getServletPath().toString();
		
		systemSer=(SystemSer)getRequestContext().getWebApplicationContext().getAutowireCapableBeanFactory().getBean("systemSerImpl");
		
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request) ;
		paramMap.put("ADMINID", admin.getAdminID()) ;
		paramMap.put("url", url);
			
		Map action = (Map)systemSer.getPurviewBtn(paramMap);
		  
		try { 
			String addString = Messages.getMessage(request, "hrms.add");
			String saveString = Messages.getMessage(request, "hrms.save");
			String deleteString = Messages.getMessage(request, "hrms.delete");
			String updateString = Messages.getMessage(request, "hrms.update");
			String searchString = Messages.getMessage(request, "search");
			String confirmString = Messages.getMessage(request, "confirm");
			
			JspWriter writer = pageContext.getOut();
			
			if(action!=null){
  
				if (limit.equals("all")) {
					if(action.get("CANCELR").toString().equals("1")){			 
						writer.print("<a class='l-button' style='width:79px; height:20px; float:right; margin-left:10px;' onclick='spf_confirm()'>"+confirmString+"</a>");
					}
					if(action.get("INSERTR").toString().equals("1")){	 
						writer.print("<a class='l-button' style='width:79px; height:20px; float:right; margin-left:10px;' onclick='spf_add()'>"+addString+"</a>"); 
					}
					if(action.get("SAVER").toString().equals("1")){	  
						writer.print("<a class='l-button' style='width:79px; height:20px; float:right; margin-left:10px;' onclick='spf_save()'>"+saveString+"</a>");
					}
					if(action.get("DELETER").toString().equals("1")){			 
						writer.print("<a class='l-button' style='width:79px; height:20px; float:right; margin-left:10px;' onclick='spf_delete()'>"+deleteString+"</a>");
					}
					if(action.get("UPDATER").toString().equals("1")){			 
						writer.print("<a class='l-button' style='width:79px; height:20px; float:right; margin-left:10px;' onclick='spf_update()'>"+updateString+"</a>");
					}
					if(action.get("SELECTR").toString().equals("1")){			 
						writer.print("<a class='l-button' style='width:79px; height:20px; float:right; margin-left:10px;' onclick='spf_search()'>"+searchString+"</a>");
					}
				}else{
					if(limit.equals("cancel")&&action.get("CANCELR").toString().equals("1")){		 
						writer.print("<a class='l-button' style='width:79px; height:20px; float:right; margin-left:10px;' onclick='spf_confirm()'>"+confirmString+"</a>");
					}
					if(limit.equals("insert")&&action.get("INSERTR").toString().equals("1")){			
						writer.print("<a class='l-button' style='width:79px; height:20px; float:right; margin-left:10px;' onclick='spf_add()'>"+addString+"</a>"); 
					}
					if(limit.equals("save")&&action.get("SAVER").toString().equals("1")){			 
						writer.print("<a class='l-button' style='width:79px; height:20px; float:right; margin-left:10px;' onclick='spf_save()'>"+saveString+"</a>");
					}
					if(limit.equals("delete")&&action.get("DELETER").toString().equals("1")){			
						writer.print("<a class='l-button' style='width:79px; height:20px; float:right; margin-left:10px;' onclick='spf_delete()'>"+deleteString+"</a>");
					}
					if(limit.equals("update")&&action.get("UPDATER").toString().equals("1")){			
						writer.print("<a class='l-button' style='width:79px; height:20px; float:right; margin-left:10px;' onclick='spf_update()'>"+updateString+"</a>");
					}
					if(limit.equals("select")&&action.get("SELECTR").toString().equals("1")){			
						writer.print("<a class='l-button' style='width:79px; height:20px; float:right; margin-left:10px;' onclick='spf_search()'>"+searchString+"</a>");
					}
					if(limit.equals("other")){ 
						writer.print("<a class='l-button' style='width:79px; height:20px; float:right; margin-left:10px;' onclick='"+onclick+"'>"+Messages.getMessage(request, btnname)+"</a>");
					}
				}
			}else{
				if(limit.equals("other")){
					writer.print("<a class='l-button' style='width:79px; height:20px; float:right; margin-left:10px;' onclick='"+onclick+"'>"+Messages.getMessage(request, btnname)+"</a>");
				}
			}
			
			
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
