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

import com.siping.system.bean.AdminBean;
import com.siping.system.service.SystemSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.SessionUtil;

@SuppressWarnings("serial")
@Component
public class SelectObjectTypeTag extends RequestContextAwareTag {
    protected String name = null;

    protected String parentTypeNo = null;

    protected String selected = null;

    protected String onChange = null;

    protected String remove = null;

    protected String limit = null;

    @Autowired
    private SystemSer systemSer;

    /**
     * tag body
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public int doStartTagInternal() throws JspException {

        name = eval("name", name, Object.class).toString();
        parentTypeNo = eval("parentTypeNo", parentTypeNo, Object.class).toString();

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

        if (remove != null) {
            remove = eval("remove", remove, Object.class).toString();
        } else {
            remove = "";
        }

        if (limit != null) {
            limit = eval("limit", limit, Object.class).toString();
        } else {
            limit = "";
        }

        systemSer = (SystemSer) getRequestContext().getWebApplicationContext().getAutowireCapableBeanFactory().getBean("systemSerImpl");

        HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();

        Map paramMap = new LinkedHashMap();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("PARENT_TYPE_NO", parentTypeNo);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        List codeList = systemSer.getObjectTypeList(paramMap);

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
            if (remove.indexOf(",") == -1) {
                for (Object map : codeList) {
                    Map temp = (Map) map;
                    writer.print("<option value='" + temp.get("OBJECT_TYPE_NO") + "'");
                    if (temp.get("OBJECT_TYPE_NO").equals(selected)) {
                        writer.print(" selected ");
                    }
                    writer.print(">" + temp.get("OBJECT_TYPE_NAME") + "</option>");
                }
            } else {
                for (Object map : codeList) {
                    Map temp = (Map) map;
                    String[] removeStr = remove.split(",");
                    for (String reStr : removeStr) {
                        if (!reStr.equals(temp.get("OBJECT_TYPE_NO").toString())) {
                            writer.print("<option value='" + temp.get("CODE_ID") + "'");
                            if (temp.get("OBJECT_TYPE_NO").equals(selected)) {
                                writer.print(" selected ");
                            }
                            writer.print(">" + temp.get("OBJECT_TYPE_NAME") + "</option>");
                        }
                    }
                }
            }
            writer.print("</select>");
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

    public String getParentTypeNo() {
        return parentTypeNo;
    }

    public void setParentTypeNo(String parentTypeNo) {
        this.parentTypeNo = parentTypeNo;
    }

    public String getOnChange() {
        return onChange;
    }

    public String getRemove() {
        return remove;
    }

    public void setRemove(String remove) {
        this.remove = remove;
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
