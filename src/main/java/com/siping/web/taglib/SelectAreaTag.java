package com.siping.web.taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import org.apache.taglibs.standard.lang.support.ExpressionEvaluatorManager;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.tags.RequestContextAwareTag;

@SuppressWarnings("serial")
@Component
public class SelectAreaTag extends RequestContextAwareTag {

    protected String provinceID = null;

    protected String cityID = null;

    protected String countyID = null;

    protected String provinceSelected = null;

    protected String citySelected = null;

    protected String countySelected = null;

    protected String limit = null;
    
    /**
     * tag body
     */
    public int doStartTagInternal() throws JspException {
        if (provinceID != null) {
            provinceID = eval("provinceID", provinceID, Object.class).toString();
        } else {
            provinceID = "null";
        }

        if (cityID != null) {
            cityID = eval("cityID", cityID, Object.class).toString();
        } else {
            cityID = "null";
        }

        if (countyID != null) {
            countyID = eval("countyID", countyID, Object.class).toString();
        } else {
            countyID = "null";
        }
        
        if (provinceSelected != null) {
            provinceSelected = eval("provinceSelected", provinceSelected, Object.class).toString();
        } else {
            provinceSelected = "null";
        }

        if (citySelected != null) {
            citySelected = eval("citySelected", citySelected, Object.class).toString();
        } else {
            citySelected = "null";
        }

        if (countySelected != null) {
            countySelected = eval("countySelected", countySelected, Object.class).toString();
        } else {
            countySelected = "null";
        }
        
        if (limit != null) {
            limit = eval("limit", limit, Object.class).toString();
        } else {
            limit = "null";
        }
        try {
            JspWriter writer = pageContext.getOut();
            //生成所需JS

            writer.println("<script type='text/javascript'>");
            writer.println("  $(function(){");
            writer.println("    initializeArea('"+this.provinceID+"','"+this.provinceSelected+"','"+this.cityID+"','"+this.citySelected+"','"+this.countyID+"','"+this.countySelected+"');");
            writer.println("  });");
            writer.println("</script>");

            //生成INPUT和隐藏字段
            writer.println("<select name='"+this.provinceID+"' id='"+this.provinceID+"' onChange=\"setSubAreaCode('"+this.cityID+"','"+this.provinceID+"',null,'"+this.countyID+"');\")> </select>");
            writer.println("<select name='"+this.cityID+"' id='"+this.cityID+"' onChange=\"setAreaCode('"+this.countyID+"','"+this.cityID+"',null);\"> </select>");
            writer.println("<select name='"+this.countyID+"' id='"+this.countyID+"' > </select>");
        } catch (Exception ex) {
            throw new JspTagException(ex.getMessage());
        }
        return EVAL_PAGE;
    }

    @SuppressWarnings({ "rawtypes" })
    private Object eval(String attName, String attValue, Class clazz) throws JspException {
        Object obj = ExpressionEvaluatorManager.evaluate(attName, attValue, clazz, this, pageContext);
        if (obj == null) {
            return "null";
        } else {
            return obj;
        }
    }

    public String getProvinceID() {
        return provinceID;
    }

    public String getCityID() {
        return cityID;
    }

    public String getCountyID() {
        return countyID;
    }
    
    public void setProvinceID(String id) {
        this.provinceID = id;
    }

    public void setCityID(String id) {
        this.cityID = id;
    }

    public void setCountyID(String id) {
        this.countyID = id;
    }

    public String getProvinceSelected() {
        return provinceSelected;
    }

    public String getCitySelected() {
        return citySelected;
    }

    public String getCountySelected() {
        return countySelected;
    }
    
    public void setProvinceSelected(String selected) {
        this.provinceSelected = selected;
    }

    public void setCitySelected(String selected) {
        this.citySelected = selected;
    }

    public void setCountySelected(String selected) {
        this.countySelected = selected;
    }

    public String getLimit() {
        return limit;
    }

    public void setLimit(String limit) {
        this.limit = limit;
    }
}