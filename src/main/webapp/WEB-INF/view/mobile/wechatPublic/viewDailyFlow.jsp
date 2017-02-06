<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="height = device-height , width = device-width , initial-scale = 1 , minimum-scale = 1 , maximum-scale = 1 , user-scalable = no" />
<style type="text/css">
#admin_body{
    width: 95%;
    margin :20px auto;
}
.chart{
    width: 100%;
    height: 100%;
}
#home_charts{
    width: 100%;
}
#home_charts td{
    width: 100%;
    height: 300px;
}
</style>
</head>
<body>
    <div id="admin_body">
        <table id="home_charts">
            <tr>
                <td style="height: 40px;">显示最近
                    <select id="daysSelV" onchange="loadViData(this.value)">
                        <option value="10">10</option>
                        <option value="20">20</option>
                        <option value="30" selected="selected">30</option>
                        <option value="40">40</option>
                        <option value="50">50</option>
                        <option value="60">60</option>
                        <option value="70">70</option>
                        <option value="80">80</option>
                        <option value="90">90</option>
                        <option value="100">100</option>
                    </select>天的访问量
                </td>
            </tr>
            <tr>
                <td><div class="chart" id="chart01"></div></td>
            </tr>
            <tr>
                <td style="height: 40px;">显示最近
                    <select id="daysSelW" onchange="loadWeData(this.value)">
                        <option value="10">10</option>
                        <option value="20">20</option>
                        <option value="30" selected="selected">30</option>
                        <option value="40">40</option>
                        <option value="50">50</option>
                        <option value="60">60</option>
                        <option value="70">70</option>
                        <option value="80">80</option>
                        <option value="90">90</option>
                        <option value="100">100</option>
                    </select>天的关注量
                </td>
            </tr>
            <tr>
                <td><div class="chart" id="chart02"></div></td>
            </tr>
        </table>
    </div>
    <script type="text/javascript" src="/resources/js/jquery/jquery-1.7.2.min.js"></script>
    <script type="text/javascript" src="/resources/js/highchart/highcharts.js"></script>
    <script type="text/javascript" src="/resources/js/highchart/highchart-theme.js"></script>
    <script type="text/javascript">
    var listFlow = new Array();
    var wechatFlow = new Array();
    $(function () {
        Highcharts.setOptions({
            global: {
                useUTC: false //关闭UTC，不采用国际标准时间
            }
        });
        var vdays = $("#daysSelV").val();
        var wdays = $("#daysSelW").val();
        loadViData(vdays);
        loadWeData(wdays);
    });
    function loadViData(paramData){
        $.ajax({
            type:'post',
            cache : false,
            dataType : 'application/json',
            data: {days : paramData},
            url : '/wechat/getVisitDailyFlow',
            dataType : 'json',
            success : function(result) {
                listFlow = [];//必须事先清空，否则数据显示有误
                for(var i=0; i<result.visit.length;i++){
                    var dayFlow = new Array();
                    dayFlow.push(result.visit[i].time);
                    dayFlow.push(result.visit[i].times);
                    listFlow.push(dayFlow);
                }
                $('#chart01').highcharts({
                    title: {
                        style:{"color" : "white", "font-size" : "20px"},
                        text: '网站访问量'
                    },
                    xAxis: {
                        title: {
                            text: '日期'
                        },
                        type:'datetime',
                        labels: {
                            formatter: function() {
                                return Highcharts.dateFormat('%Y-%m-%d', this.value);
                            },
                            align: 'right',
                            style: {fontWeight: 'common',"font-size" : "10px"},
                            rotation: 315
                        }
                    },
                    yAxis: {
                        title: {
                            text: '访问次数'
                        },
                        plotLines: [{
                            value: 0,
                            width: 1,
                            color: '#808080'
                        }]
                    },
                    tooltip: {
                        formatter: function() {
                            return Highcharts.dateFormat('%Y-%m-%d', this.x) +'<br>'+this.y+"次";
                        },
                        crosshairs: [false,true],
                        valueSuffix: '次'
                    },
                    credits:{
                        enabled:false
                    },
                    series: [{
                        name: "",
                        data: listFlow,
                        showInLegend: false
                    }]
                });
            }
        });
    }
    function loadWeData(paramData){
        $.ajax({
            type:'post',
            cache : false,
            dataType : 'application/json',
            data: {days : paramData},
            url : '/wechat/getWechatDailyFlow',
            dataType : 'json',
            success : function(result) {
                wechatFlow = [];//必须事先清空，否则数据显示有误
                for(var i=0; i<result.wechat.length; i++){
                    var dayFlow = new Array();
                    dayFlow.push(result.wechat[i].time);
                    dayFlow.push(result.wechat[i].times);
                    wechatFlow.push(dayFlow);
                }
                $('#chart02').highcharts({
                    title: {
                        style:{"color" : "white", "font-size" : "20px"},
                        text: '微信关注量'
                    },
                    xAxis: {
                        title: {
                            text: '日期'
                        },
                        type:'datetime',
                        labels: {
                            formatter: function() {
                                return Highcharts.dateFormat('%Y-%m-%d', this.value);
                            },
                            align: 'right',
                            style: {fontWeight: 'common',"font-size" : "10px"},
                            rotation: 315
                        }
                    },
                    yAxis: {
                        title: {
                            text: '人数'
                        },
                        plotLines: [{
                            value: 0,
                            width: 1,
                            color: '#808080'
                        }]
                    },
                    tooltip: {
                        formatter: function() {
                            return Highcharts.dateFormat('%Y-%m-%d', this.x) +'<br>'+this.y+"人";
                        },
                        crosshairs: [false,true],
                        valueSuffix: '人'
                    },
                    credits:{
                        enabled:false
                    },
                    series: [{
                        name: "",
                        data: wechatFlow,
                        showInLegend: false
                    }]
                });
            }
        });
    }
    function seOnchange(){
        window.location.reload(true);
    }
    </script>
</body>
</html>