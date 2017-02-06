
function getOs() {
   var na = window.navigator.userAgent;
   if(na.indexOf("MSIE")>0) {
        return "MSIE";   //IE
   }
   if(na.indexOf("Firefox")>0){
        return "Firefox"; //FireFox
   }
   if(na.indexOf("OPR")>0) {
       return "Opera"; //Opera
  }
   if(na.indexOf("Chrome")>0) {
       return "Chrome"; //Chrome
   }
   if(na.indexOf("Safari")>0) {
        return "Safari"; //Safari
   }
   if(na.indexOf("Camino")>0){
        return "Camino";
   }
   if(na.indexOf("Gecko/")>0){
        return "Gecko";  //Mozilla
   }
}

function MyToDate(num) {
    if(num != null && num != 'undefined' && num != ''){
        if (num.toString().split("-").length > 1) {
            return num;
        }
        num = num + "";
        var date = "";
        var month = new Array();
        month["Jan"] = "01";
        month["Feb"] = "02";
        month["Mar"] = "03";
        month["Apr"] = "04";
        month["May"] = "05";
        month["Jun"] = "06";
        month["Jul"] = "07";
        month["Aug"] = "08";
        month["Sep"] = "09";
        month["Oct"] = "10";
        month["Nov"] = "11";
        month["Dec"] = "12";
        str = num.split(" ");
        if(getOs()=="MSIE"){
            date = str[5] + "-";
            var day = str[2]
            if (day < 10)
                day = "0" + day;
            date = date + month[str[1]] + "-" + day;
        }else{
            date = str[3] + "-";
            var day = str[2];
            date = date + month[str[1]] + "-" + day;
        }
        return date;
    }else{
        return '';
    }
}
function MyToYear(num) {
    if(num != null && num != 'undefined' && num != ''){
        if (num.toString().split("-").length > 1) {
            return num;
        }
        num = num + "";
        var date = "";
        str = num.split(" ");

        if(num.length==4){
            date = num;
        }
        else if(num.length<=33&&num.length>4){
            date = str[5];
        }else{
            date = str[3];
        }
        return date;
    }else{
        return '';
    }
}

function MyToYearAndMonth(num) {
    if(num != null && num != 'undefined' && num != ''){
        if (num.toString().split("-").length > 1) {
            return num;
        }
        num = num + "";
        var date = "";
        var month = new Array();
        month["Jan"] = "01";
        month["Feb"] = "02";
        month["Mar"] = "03";
        month["Apr"] = "04";
        month["May"] = "05";
        month["Jun"] = "06";
        month["Jul"] = "07";
        month["Aug"] = "08";
        month["Sep"] = "09";
        month["Oct"] = "10";
        month["Nov"] = "11";
        month["Dec"] = "12";
        str = num.split(" ");
        if(num.length==6){
            date = num;
        }
        else if(num.length<=33&&num.length>6){
            date = str[5];
            date = date + month[str[1]];
        }else{
            date = str[3];
            date = date + month[str[1]];
        }
        return date;
    }else{
        return '';
    }
}
function MyCheckNull(num) {
    if(num != null && num != 'undefined' && num != ''){
        return num;
    }else{
        return '';
    }
}
/**
 *  解决小数相乘后，小数点后位数过多的问题(保留两位小数)
*   Usage:  CurrencyFormatted(12345.678);
*   result: 12345.68
**/
function CurrencyFormatted(amount) {
    var i = parseFloat(amount);
    if(isNaN(i)) { i = 0.00; }
    var minus = '';
    if(i < 0) { minus = '-'; }
    i = Math.abs(i);
    i = parseInt((i + .005) * 100);
    i = i / 100;
    s = new String(i);
    if(s.indexOf('.') < 0) { s += '.00'; }
    if(s.indexOf('.') == (s.length - 2)) { s += '0'; }
    s = minus + s;
    return s;
}

function format_number(pnumber, decimals) {
    if (isNaN(pnumber)) {
        return 0;
    }
    if (pnumber == '') {
        return 0;
    }
    var snum = new String(pnumber);
    var sec = snum.split('.');
    var whole = parseFloat(sec[0]);
    var result = '';
    if (sec.length > 1) {
        var dec = new String(sec[1]);
        dec = String(parseFloat(sec[1])
                / Math.pow(10, (dec.length - decimals)));
        dec = String(whole + Math.round(parseFloat(dec))
                / Math.pow(10, decimals));
        var dot = dec.indexOf('.');
        if (dot == -1) {
            dec += '.';
            dot = dec.indexOf('.');
        }
        while (dec.length <= dot + decimals) {
            dec += '0';
        }
        result = dec;
    } else {
        var dot;
        var dec = new String(whole);
        dec += '.';
        dot = dec.indexOf('.');
        while (dec.length <= dot + decimals) {
            dec += '0';
        }
        result = dec;
    }
    return result;
}

//人民币金额转大写程序 JavaScript版
//CopyRight Bardo QI
function numToCny(num) {
  var capUnit = ['万','亿','万','圆',''];
  var capDigit = { 2:['角','分',''], 4:['仟','佰','拾','']};
  var capNum=['零','壹','贰','叁','肆','伍','陆','柒','捌','玖'];
  if (((num.toString()).indexOf('.') > 16)||(isNaN(num)))
      return '';
  num = ((Math.round(num*100)).toString()).split('.');
  num = (num[0]).substring(0, (num[0]).length-2)+'.'+ (num[0]).substring((num[0]).length-2,(num[0]).length);
  num =((Math.pow(10,19-num.length)).toString()).substring(1)+num;
  var i,ret,j,nodeNum,k,subret,len,subChr,CurChr=[];
  for (i=0,ret='';i<5;i++,j=i*4+Math.floor(i/4)){
      nodeNum=num.substring(j,j+4);
      for(k=0,subret='',len=nodeNum.length;((k<len) && (parseInt(nodeNum.substring(k),10)!=0));k++){
          CurChr[k%2] = capNum[nodeNum.charAt(k)]+((nodeNum.charAt(k)==0)?'':capDigit[len][k]);
          if (!((CurChr[0]==CurChr[1]) && (CurChr[0]==capNum[0])))
              if(!((CurChr[k%2] == capNum[0]) && (subret=='') && (ret=='')))
                  subret += CurChr[k%2];
      }
      subChr = subret + ((subret=='')?'':capUnit[i]);
      if(!((subChr == capNum[0]) && (ret=='')))
          ret += subChr;
  }
  ret=(ret=='')? capNum[0]+capUnit[3]: ret;
  return ret;
}
/*
功能：将货币数字（阿拉伯数字）(小写)转化成中文(大写）

参数：Num为字符型,小数点之后保留两位,例：Arabia_to_Chinese("1234.06")
说明：1.目前本转换仅支持到 拾亿（元） 位，金额单位为元，不能为万元，最小单位为分
        2.不支持负数
*/
function numtochinese(Num) {
    for(i=Num.length-1;i>=0;i--) {
        Num = Num.replace(",","")//替换tomoney()中的“,”
        Num = Num.replace(" ","")//替换tomoney()中的空格
    }

    Num = Num.replace("￥","")//替换掉可能出现的￥字符
    if(isNaN(Num))    {
        //验证输入的字符是否为数字
        alert("请检查小写金额是否正确");
        return;
    }
    //---字符处理完毕，开始转换，转换采用前后两部分分别转换---//
    part = String(Num).split(".");
    newchar = "";
    //小数点前进行转化
    for(i=part[0].length-1;i>=0;i--) {
        if(part[0].length > 10){ alert("位数过大，无法计算");return "";}//若数量超过拾亿单位，提示
        tmpnewchar = ""
        perchar = part[0].charAt(i);
        switch(perchar){
            case "0": tmpnewchar="零" + tmpnewchar ;break;
            case "1": tmpnewchar="壹" + tmpnewchar ;break;
            case "2": tmpnewchar="贰" + tmpnewchar ;break;
            case "3": tmpnewchar="叁" + tmpnewchar ;break;
            case "4": tmpnewchar="肆" + tmpnewchar ;break;
            case "5": tmpnewchar="伍" + tmpnewchar ;break;
            case "6": tmpnewchar="陆" + tmpnewchar ;break;
            case "7": tmpnewchar="柒" + tmpnewchar ;break;
            case "8": tmpnewchar="捌" + tmpnewchar ;break;
            case "9": tmpnewchar="玖" + tmpnewchar ;break;
        }
        switch(part[0].length-i-1) {
            case 0: tmpnewchar = tmpnewchar +"元" ;break;
            case 1: if(perchar!=0)tmpnewchar= tmpnewchar +"拾" ;break;
            case 2: if(perchar!=0)tmpnewchar= tmpnewchar +"佰" ;break;
            case 3: if(perchar!=0)tmpnewchar= tmpnewchar +"仟" ;break;
            case 4: tmpnewchar= tmpnewchar +"万" ;break;
            case 5: if(perchar!=0)tmpnewchar= tmpnewchar +"拾" ;break;
            case 6: if(perchar!=0)tmpnewchar= tmpnewchar +"佰" ;break;
            case 7: if(perchar!=0)tmpnewchar= tmpnewchar +"仟" ;break;
            case 8: tmpnewchar= tmpnewchar +"亿" ;break;
            case 9: tmpnewchar= tmpnewchar +"拾" ;break;
        }
        newchar = tmpnewchar + newchar;
    }
    //小数点之后进行转化
    if(Num.indexOf(".")!=-1) {
        if(part[1].length > 2) {
            alert("小数点之后只能保留两位,系统将自动截段");
            part[1] = part[1].substr(0,2)
        }
        for(i=0;i<part[1].length;i++) {
            tmpnewchar = ""
            perchar = part[1].charAt(i)
            switch(perchar){
            case "0": tmpnewchar="零" + tmpnewchar ;break;
            case "1": tmpnewchar="壹" + tmpnewchar ;break;
            case "2": tmpnewchar="贰" + tmpnewchar ;break;
            case "3": tmpnewchar="叁" + tmpnewchar ;break;
            case "4": tmpnewchar="肆" + tmpnewchar ;break;
            case "5": tmpnewchar="伍" + tmpnewchar ;break;
            case "6": tmpnewchar="陆" + tmpnewchar ;break;
            case "7": tmpnewchar="柒" + tmpnewchar ;break;
            case "8": tmpnewchar="捌" + tmpnewchar ;break;
            case "9": tmpnewchar="玖" + tmpnewchar ;break;
        }
        if(i==0)tmpnewchar =tmpnewchar + "角";
        if(i==1)tmpnewchar = tmpnewchar + "分";
        newchar = newchar + tmpnewchar;
        }
    }
    //替换所有无用汉字
    while(newchar.search("零零") != -1)
       newchar = newchar.replace("零零", "零");
       newchar = newchar.replace("零亿", "亿");
       newchar = newchar.replace("亿万", "亿");
       newchar = newchar.replace("零万", "万");
       newchar = newchar.replace("零元", "元");
       newchar = newchar.replace("零角", "");
       newchar = newchar.replace("零分", "");

    if (newchar.charAt(newchar.length-1) == "元" || newchar.charAt(newchar.length-1) == "角")
    newchar = newchar+"整"
    return newchar;
}

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