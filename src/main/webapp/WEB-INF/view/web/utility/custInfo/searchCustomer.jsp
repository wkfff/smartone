<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
    var $grid = null;
    var $returnTypeSelectList;
    //扩展一个 多行文本框 的编辑器
    $.ligerDefaults.Grid.editors['textarea'] = {
        create : function(container, editParm) {
            var input = $("<textarea class='l-textarea' />");
            container.append(input);
            return input;
        },
        getValue : function(input, editParm) {
            return input.val();
        },
        setValue : function(input, value, editParm) {
            input.val(value);
        },
        resize : function(input, width, height, editParm) {
            var column = editParm.column;
            if (column.editor.width)
                input.width(column.editor.width);
            else
                input.width(width);
            if (column.editor.height)
                input.height(column.editor.height);
            else
                input.height(height);
        }
    };
    // 初始调用
    $(function() {
        //布局
        $("#layout1").ligerLayout({
            topHeight : 80,
            allowLeftResize : false, //是否允许 左边可以调整大小
            allowRightResize : false, //是否允许 右边可以调整大小
            allowTopResize : false, //是否允许 头部可以调整大小
            allowBottomResize : false
        //是否允许 底部可以调整大小
        });
        f_initGrid();
    });

    var ownerId = "${ownerId}";
    function f_initGrid() {
        $grid = $("#customerInfo").ligerGrid({
            //checkbox: true,
            columns : [ {
                display : '',
                name : 'CUST_ID',
                width : 0,
                hide : 1
            }, {
                display : '<spring:message code="hrms.customerName"/>',
                name : 'CUST_NAME',
                width : 140
            }, {
                display : '<spring:message code="hrms.theOwner"/>',
                name : 'OWNER',
                width : 90
            }, {
                display : '<spring:message code="hrms.customerType"/>',
                name : 'CUST_TYPE',
                width : 100
            }, {
                display : '<spring:message code="hrms.customerStatus"/>',
                name : 'CUST_STATUS',
                width : 100
            }, {
                display : '<spring:message code="hrms.customerAddress"/>',
                name : 'ADDRESS_TOTAL',
                width : 160
            }, {
                display : '<spring:message code="hrms.description"/>',
                name : 'DESCRIPTION',
                width : 160
            } ],
            enabledEdit : true,
            usePager : true,
            rownumbers : true,
            url : '/utility/custInfo/getCustomerList',
            parms : [ {
                name : 'EMP_ID',
                value : "${ownerId}"
            } ],
            width : '99.6%',
            height : '100%'
        });
    }

    function spf_selectCustomer() {
        var data;
        data = $grid.getSelectedRow()
        if (!data) {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>',
                    '<spring:message code="hrms.chooseLine"/>');
            return;
        }
        return data;
    }

    function spf_search() {
        $grid.setOptions({
            parms : [ {
                name : 'keyWord',
                value : $("#keyWord").attr('value')
            }, {
                name : 'OWNER_ID',
                value : $("#OWNER_ID").attr('value')
            }, {
                name : 'CUST_TYPE_CODE',
                value : $("#CUST_TYPE_CODE").attr('value')
            }, {
                name : 'CUST_STATUS_CODE',
                value : $("#CUST_STATUS_CODE").attr('value')
            }, {
                name : 'EMP_ID',
                value : ownerId
            } ],
            newPage : 1
        }); //设置数据参数
        $grid.loadData(true); //加载数据
    }

    function spf_afterRemove() {
        $dialog.close();
        $grid.loadData(true); //加载数据
    }

    function searchEmp() {
        $dialog = $.ligerDialog.open({
            isDrag : false,
            title : '<spring:message code="employee.information"/>',
            width : 800,
            height : 400,
            url : '/utility/empInfo/viewCustSearchEmployee'
        });
    }

    function spf_initSelectEmpInfo(data) {
        $("#OWNER_ID").attr("value", data.EMPID);
        $("#OWNER").attr("value", data.CHINESENAME);
        $dialog.close();
        spf_search();
    }
</script>
<style type="text/css">
body {
    padding: 5px;
    margin: 0;
    padding-bottom: 15px;
}

#layout1 {
    width: 99.8%;
    margin: 0;
    padding: 0;
}
</style>
</head>
<body style="padding: 2px">
    <div id="layout1">
        <div position="top">
            <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                <tr>
                    <td width="15%" class="l-table-edit-t"><spring:message code="keyWord" /></td>
                    <td width="35%" class="l-table-edit-c"><input name="keyWord" type="text" id="keyWord" size="30" /></td>
                    <c:if test="${isSupervisor}">
                        <td width="15%" class="l-table-edit-t"><spring:message code="hrms.customerManager" /></td>
                        <td width="35%" class="l-table-edit-c"><input name="OWNER" type="text" id="OWNER" size="30" onclick="searchEmp()" /></td>
                        <td width="35%" class="l-table-edit-c"><input name="OWNER_ID" type="hidden" id="OWNER_ID" size="30" /></td>
                    </c:if>
                    <c:if test="${!isSupervisor}">
                        <td width="15%" class="l-table-edit-t"><spring:message code="hrms.customerManager" /></td>
                        <td width="35%" class="l-table-edit-c"><input name="OWNER_ID" type="text" id="OWNER_ID" size="30" readonly="readonly" value="${EMP_ID}" /></td>
                    </c:if>
                </tr>
                <tr>
                    <td width="15%" class="l-table-edit-t"><spring:message code="hrms.customerType" /></td>
                    <td width="35%" class="l-table-edit-c"><SipingSoft:selectSyCode parentCode="CustomerTypeCode" name="CUST_TYPE_CODE" onChange="spf_search();" limit="all" /></td>
                    <td width="15%" class="l-table-edit-t"><spring:message code="hrms.customerStatus" /></td>
                    <td width="35%" class="l-table-edit-c"><SipingSoft:selectSyCode parentCode="CustomerStatusCode" name="CUST_STATUS_CODE" onChange="spf_search();" limit="all" /></td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" class="l-table-edit">
                <tr>
                    <td align="left" height="30px" colspan="3"><a class="l-button"
                        style="width: 79px; height: 20px; float: left; margin-left: 10px; " onclick="spf_search()"><spring:message
                                code="search" /></a></td>
                </tr>
            </table>
        </div>
        <div position="center" id='customerInfo'></div>
    </div>
    </div>
</body>
</html>
