<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ taglib uri="/WEB-INF/tld/SipingSoft.tld" prefix="siping"%>
<!doctype html>
<html>
<head>
<title>休假申请</title>
<meta name="viewport" content="width=device-width, height=device-height, user-scalable=no, initial-scale=1.0, maximum-scale=1.0" >
<link href="/resources/css/mobile/wechat-common.css" rel="stylesheet" type="text/css" />
<script src="/resources/js/jquery/jquery-1.10.2.js"></script>
<script src="/resources/js/jquery/jquery.form.js"></script>
<script src="/resources/js/mobile/js-tools.js"></script>

<script type="text/javascript">
function subLeave(){
    if(checkLeaveData()){
        if(confirm("确定提交申请吗?")){
            var options = {
                url : '/hrm/addLeave',
                type : 'post',
                success : function(result){
                    if(result == 'Y'){
                        showTips("申请已经提交，等待审核", 5, 2);
                        location.reload(true);
                    }else {
                        showTips("申请失败", 5, 2);
                    }
                },
                error : function() {
                    showTips("申请失败", 5, 2);
               }
           };
           $("#leave_form").ajaxSubmit(options);
        }
    }
    return false;
}
function checkLeaveData(){
    if($("#leaveTypeCode").val()==""){
        showTips("请选择休假类型", 5, 2);
        return false;
    }
    if($("#leaveFromTime").val()==""){
        showTips("请选择休假开始时间", 5, 2);
        return false;
    }
    if($("#leaveToTime").val()==""){
        showTips("请选择休假结束时间", 5, 2);
        return false;
    }
    if($("#leaveToTime").val()<$("#leaveFromTime").val()){
        showTips("结束时间必须在开始时间之后", 5, 2);
        return false;
    }
    if($("#leaveWaEmpid").val()==""){
        showTips("请选择工作代理人", 5, 2);
        return false;
    }
    if($("#leaveReason").val().trim()==""){
        showTips("请填写休假事由", 5, 2);
        return false;
    }
    return true;
}
</script>
<style>
.leave_table{
    width: 100%;
}
</style>
</head>
<body>
    <div>
        <form id="leave_form">
            <table class="leave_table">
                <tr><td colspan="2" style="text-align: center;height: 40px;line-height: 40px;">休假申请单</td></tr>
                <tr><td class="single-line-1">员工编号</td>
                <td class="single-line-2"><input name="empid"/></td></tr>
                <tr><td class="single-line-1">员工姓名</td>
                <td class="single-line-2"><input name="empname"/></td></tr>
                <tr><td class="single-line-1">休假类型</td>
                <td class="single-line-2"><siping:selectSyCode parentCode="LeaveTypeCode" name="leaveTypeCode" limit="all" /></td></tr>
                <tr><td class="single-line-1">开始时间</td>
                <td class="single-line-2"><input id="leaveFromTime" name="leaveFromTime" type="datetime-local"/></td></tr>
                <tr><td class="single-line-1">结束时间</td>
                <td class="single-line-2"><input id="leaveToTime" name="leaveToTime" type="datetime-local"/></td></tr>
                <tr><td class="single-line-1">工作代理</td>
                <td class="single-line-2"><input id="leaveWaEmpid" name="leaveWaEmpid"/></td></tr>
                <tr><td class="single-line-1">休假事由</td>
                <td class="single-line-2"><textarea style="width: 80%;height: 60px;" id="leaveReason" name="leaveReason"></textarea></td></tr>
                <tr style="height: 30px;"></tr>
                <tr><td colspan="2" style="text-align: center;">
                    <button type="submit" onclick="return subLeave();" style="width: 100px;height: 25px;">提交申请</button></td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>