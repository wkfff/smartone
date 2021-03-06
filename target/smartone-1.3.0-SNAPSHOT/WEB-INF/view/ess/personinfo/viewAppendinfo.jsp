<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<html>
<head>

<title>Translate information</title>

<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<meta http-equiv="X-UA-Compatible" content="IE=edge" >
<!-- css -->
<link href="/resources/js/ligerUI/skins/Silvery/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<!-- js -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script> 
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerMenuBar.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
<script src="/resources/js/common.js" type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
</head>
<SCRIPT type="text/javascript">
    /**附加信息
     */

    $(function() {
        $(this).loginWait('mainBody', 'loading', 250);
        $("#appendInfoGrid").ligerGrid({
            columns : [ {
                display : '<spring:message code="hrms.releaseDate"/>',
                name : 'EVENTDATE',
                align : 'center',
                width : 140,
                minWidth : 60,
                type : 'date'
            }, {
                display : '<spring:message code="hrms.informationType"/>',
                name : 'INFOTYPECODE',
                minWidth : 100
            }, {
                display : '<spring:message code="hrms.details"/>',
                name : 'DETATLS',
                minWidth : 110
            }, {
                display : '<spring:message code="hrms.registrants"/>',
                name : 'REGISTER',
                minWidth : 110
            } ],
            url : "/hrm/empinfo/getAppendInfoList?empid=${basicInfo.EMPID }",
            sortName : 'EMPID',
            dataAction : 'server',
            pageSize : 5,
            pageSizeOptions : [ 5, 4, 3, 2, 1 ],
            width : '92%',
            height : '33%'
        });

    });
</SCRIPT>
<style type="text/css">
.l-button-update,.l-button-edit {
    width: 80px;
    float: right;
    margin-right: 10px;
    margin-top: 10px;
}
</style>
<body>

    <div id="mainBody">
        <div>
            <%@include file="viewPersonInfo.jsp"%>
            <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br />
            <table width="100%">
                <tr>
                    <td>
                        <div id="punishMentinfo" onmouseout="change('punishMentinfo');"
                            style="border: dashed 1px #cccccc; float: left;">
                            <table cellpadding="1" cellspacing="1"
                                style="height: 25px; font-size: 12px;">
                                <tr>
                                    <td align="right"><img
                                        src="/resources/images/title/top_1.gif" align="center" /></td>
                                    <td align="left"><font size="2">附加信息</font></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="appendInfoGrid" onmouseout="change('punishMentGrid');"
                            style="float: left;"></div>
                    </td>
                </tr>
            </table>
        </div>
</body>
</html>
