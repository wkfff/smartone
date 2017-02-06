<%@ tag pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="name" required="true"%>
<%@ attribute name="selected" required="false"%>

<select name="${name}" id="${name}">
    <c:if test="${selected == \"true\"}">
        <option value="true" selected>可用</option>
        <option value="false">不可用</option>
    </c:if>
    <c:if test="${selected == \"false\"}">
        <option value="true" >可用</option>
        <option value="false" selected>不可用</option>
    </c:if>
</select>