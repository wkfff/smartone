<%@ tag pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="name" required="true"%>
<%@ attribute name="selected" required="false"%>

<select name="${name}" id="${name}" >
    <option value="1" selected>创建</option>
    <option value="2" >审批</option>
    <option value="3" >归档</option>
</select>