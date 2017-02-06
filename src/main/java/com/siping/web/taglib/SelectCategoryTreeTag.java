package com.siping.web.taglib;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;

import org.apache.taglibs.standard.lang.support.ExpressionEvaluatorManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

import com.siping.system.dao.BasicMaintenanceDao;
import com.siping.system.service.SystemSer;

@SuppressWarnings("serial")
@Component
public class SelectCategoryTreeTag extends RequestContextAwareTag {

	protected String name = null;

	protected String selected = null;
	
	protected String limit = null; 
	
	protected String onChange = null;
	
	protected String root = null; 
	
	@Autowired
	private SystemSer systemSer;
	@Autowired
	private BasicMaintenanceDao basicMaintenanceDao ;

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
		
		if (limit != null) {
			limit = eval("limit", limit, Object.class).toString();
		} else {
			limit = "hr";
		}
		
		if (onChange != null) {
			onChange = eval("onChange", onChange, Object.class).toString();
		} else {
			onChange = "";
		}
		
		if (root != null) {
			root = eval("root", root, Object.class).toString();
		} else {
			root = "";
		}
		
		systemSer=(SystemSer)getRequestContext().getWebApplicationContext().getAutowireCapableBeanFactory().getBean("systemSerImpl");
		
		String categoryName="";
		
		if(!selected.equals("")){
			Map object=new LinkedHashMap();
			object.put("CATEGORY_ID",selected);
			categoryName =  ((Map)basicMaintenanceDao.getCategoryList(object)).get("CATEGORY_NAME").toString();
//			categoryName =  ((Map)basicMaintenanceDao.getCategoryList(object).get(0)).get("CATEGORY_NAME").toString();
		}
		
		
		try {
			

			JspWriter writer = pageContext.getOut();
			//生成所需JS

			writer.print("<SCRIPT type='text/javascript'>");			
			
			writer.print(" $(function(){");
			writer.print(" 		var "+name+"tree = [];");
			writer.print("		$.ajax({");
			writer.print("			type:'POST',cache:false,contentType:'application/json',");
			writer.print("			url:'/system/basicMaintenance/getCategoryList',dataType:'json',");
			writer.print("	        success:function(data){");
			writer.print("		"+name+"tree.push({ id: '', pid: 'CATEGORY', text: '请选择' ,isexpand : true});");
			
			writer.print("	$.each(data.Rows, function(i, item){");
			writer.print("		"+name+"tree.push({ id: item.CATEGORY_ID, pid: item.PARENT_ID, text: item.CATEGORY_NAME ,isexpand : item.ISEXPAND});");
			writer.print("	});");
			
			writer.print("	$('#"+name+"tree').ligerComboBox({");
			writer.print("		width: 200,selectBoxWidth: 200,selectBoxHeight: 200,treeLeafOnly:false,");
			writer.print("		tree: {");
			writer.print("	data: "+name+"tree,checkbox:false,idFieldName :'id',parentIDFieldName :'pid',");
			writer.print("		nodeWidth:100},");
			writer.print("		onSelected:function (note){ ");
			writer.print("			if($('#"+name+"tree').val()=='') note=''; ");
			writer.print("			$('#"+name+"').attr('value',note);");
			writer.print("          spf_choseCategory(note);");
			writer.print("		}");
			writer.print("   });");
			writer.print("  }");
			writer.print(" });");
			writer.print("});");
			
			writer.print("</SCRIPT>");
			
			//生成INPUT和隐藏字段
			writer.print("<input id='"+name+"tree' value='"+categoryName+"' >");
			writer.print("<input type='hidden' id='"+name+"' name='"+name+"' value='"+selected+"'  onChange='"+onChange+"'>");
			
			
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

	public String getLimit() {
		return limit;
	}

	public void setLimit(String limit) {
		this.limit = limit;
	}

	public String getOnChange() {
		return onChange;
	}

	public void setOnChange(String onChange) {
		this.onChange = onChange;
	}
	
	public String getRoot() {
		return root;
	}

	public void setRoot(String root) {
		this.root = root;
	}

}
