/**
 * 添加头部按钮
 * 
 * @param {}
 *            grid
 */
$.fn.addTopBarForGrid = function(grid, button) {
    $('.l-grid-header', '#' + grid).before("<div id=\"" + grid + "toptoolbar\"   style=\"background:#d6e7fe;\" ></div>");
    $("#" + grid + "toptoolbar").ligerToolBar(button);
    setTimeout($('.l-toolbar-item').attr("style", "float :right;"), 1);
}
/**
 * 覆写grid表格入口方法增加头部按钮
 * 
 * @param {}
 *            p
 * @return {}
 */
$.fn.ligerGrid = function(p) {
    var fixedP = {};
    p = p || {};
    p = $.ligerGridSetParms(p, fixedP);
    this.each(function() {
        $.ligerAddGrid(this, p);
        if (p.topToolBar && p.topBarClick)
            $.fn.addTopBarForGrid(this.id, p.topBarClick);
    });
    if (this.length == 0)
        return null;
    if (this.length == 1)
        return $(this[0]).ligerGetGridManager();
    var managers = [];
    this.each(function() {
        managers.push($(this).ligerGetGridManager());
    });
    return managers;
};
/**
 * grid提交修改行
 * 
 * @type {}
 */
$.ligerExpandGrid = {
    editRowNum : new Array(),// 修改过的行ID
    girdManager : null,// 操作grid表格对象
    girdName : '',// grid表格ID
    jsonData : null,// 提交后台的json对象
    url : '',// 提交路径
    initExpandGrid : function(name, url) { // 初始化扩展表格
        this.girdName = name;
        this.url = url;
        this.gridManager = $("#" + this.girdName).ligerGetGridManager();
        return this;
    },
    getChangeEdit : function(editRowNum) { // 得到修改行ID
        if (!this.girdManager)
            this.girdManager = $("#" + this.girdName).ligerGetGridManager();
        $.each($(".l-grid-row-cell-edited", this.gridManager.gridbody), function(n, value) { // 迭代所有改变的的单元格
            if ($.inArray(value.parentNode.getAttribute("rowindex"), editRowNum) == -1)
                editRowNum.push(value.parentNode.getAttribute("rowindex"));
        });
    },
    initParamsJson : function() { // 将修改行转换成json字符串
        girdManager = this.girdManager;
        var lineTemp = new Array();
        $.each(this.editRowNum, function(index, value) {
            lineTemp.push(girdManager.getRowByRowIndex(parseInt(value)));
        });
        this.jsonData = JSON2.stringify(lineTemp);
    },
    initAjax : function(url, jsonData) { // ajax提交后台操作
        $.ajax({
            type : 'post',
            cache : false,
            contentType : 'application/json',
            url : url,
            dataType : 'json',
            data : jsonData,
            success : function(response) {
                $.ligerExpandGrid.backFunction(response);
            }
        });
    },
    backFunction : function(response) { // 用于覆写的回调函数
        if (response != '')
            alert(response);
        this.girdManager.loadData(true);
    },
    updateOrSaveGrid : function() { // 保存或更细grid表格
        this.getChangeEdit(this.editRowNum);
        this.initParamsJson();
        this.initAjax(this.url, this.jsonData);
    }
}
/**
 * 封装grid表格增删改查
 * 
 * @type {}
 */
$.ligerExpandGrid.CRUD = {
    gridName : new Array(),// 表格名称ID
    addSize : 3,// 新增最大行数
    addFlag : false,// 可否有新增
    urlParamets : {},// 表格数据提交地址
    addIndex : {},// 新建的行ID
    delIndex : {},// 删除的行ID
    editIndex : {},// 编辑过的行ID
    getRowsIndex : {}, // 得到复选框选中的行ID
    jsonData : {},// 将需要提交的数据根据行ID取得并拼成json对象
    delId : "EMPID", // 删除对象ID
    initSubmit : function()// 初始化表格提交封装器
    {
        if (arguments.length > 0)// 根据传入参数赋值页面需要提交的表格名称ID数组
            for (var n = 0; n < arguments.length; n++) {
                var manager = $(arguments[n]).ligerGetGridManager();
                if (manager)
                    this.gridName.push(arguments[n]);
                else
                    return {};
            }
        return $.extend({}, this);
    },
    addRow : function()// 新增行
    {
        flag = this.addFlag;
        if (flag)
            return;
        var tempContainer = {};
        $.each(this.gridName, function(index, value) {
            var addRowNum = new Array();
            var manager = $(value).ligerGetGridManager();
            for (var i = 0; i < $.ligerExpandGrid.CRUD.addSize; i++) {
                addRowNum.push(manager.addRow());
            }
            tempContainer[value] = addRowNum;
        });
        $.extend(this.addIndex, tempContainer);
        this.addFlag = true;
    },
    delRow : function()// 删除行
    {
        delIndex = $.extend({}, this.delIndex);
        delId = this.delId;
        var tempContainer = {};
        $.each(this.gridName, function(index, value) {
            var delRowNum = new Array();
            var manager = $(value).ligerGetGridManager();
            $(value + " td[columnname=" + delId + "]").find(":checkbox").each(function(i) {
                if (this.checked) {
                    delRowNum.push(this.parentNode.parentNode.parentNode.getAttribute("rowindex"));
                    manager.deleteRow(parseInt(this.parentNode.parentNode.parentNode.getAttribute("rowindex")));
                }
            });
            if (typeof (delIndex) != 'undefined' && typeof (delIndex[value]) != 'undefined')
                delRowNum.push(delIndex[value]);
            tempContainer[value] = delRowNum;

        });
        $.extend(this.delIndex, tempContainer);
    },
    editRow : function()// 编辑行
    {
        var tempContainer = {};
        $.each(this.gridName, function(index, value) {
            var editRowNum = new Array();
            var manager = $(value).ligerGetGridManager();
            $.each($(".l-grid-row-cell-edited", manager.gridbody), function(n, value) { // 迭代所有改变的的单元格
                if ($.inArray(value.parentNode.getAttribute("rowindex"), editRowNum) == -1) {
                    if (manager.getRowByRowIndex(parseInt(value.parentNode.getAttribute("rowindex"))).__status != 'add')
                        editRowNum.push(value.parentNode.getAttribute("rowindex"));
                }
            });
            tempContainer[value] = editRowNum;
        });
        $.extend(this.editIndex, tempContainer);
    },
    getRows : function()// 得到选中行
    {
        delId = this.delId;
        var tempContainer = {};
        $.each(this.gridName, function(index, value) {
            var getRowNum = new Array();
            var manager = $(value).ligerGetGridManager();
            $(value + " td[columnname=" + delId + "]").find(":checkbox").each(function(i) {
                if (this.checked) {
                    getRowNum.push(this.parentNode.parentNode.parentNode.getAttribute("rowindex"));
                }
            });
            if (typeof (getRowsIndex) != 'undefined' && typeof (getRowsIndex[value]) != 'undefined')
                getRowNum.push(getRowsIndex[value]);
            tempContainer[value] = getRowNum;
        });
        $.extend(this.getRowsIndex, tempContainer);
    },
    validateSubmit : function()// 提交前验证
    {
        delIndex = this.delIndex;
        $.each(this.gridName, function(index, value) {
            var manager = $(value).ligerGetGridManager();
            $.each(delIndex[value], function(i, val) {
                if (manager.getRowByRowIndex(parseInt(val)).__status == 'add-delete')
                    delete delIndex[i];
            });
        });
    },
    initParamsJson : function() {// 转换json对象
        addIndex = this.addIndex;
        delIndex = this.delIndex;
        editIndex = this.editIndex;
        jsonData = this.jsonData;
        $.each(this.gridName, function(index, value) {
            var manager = $(value).ligerGetGridManager();
            var lineTemp = new Array();
            if (typeof (addIndex[value]) != 'undefined')
                $.each(addIndex[value], function(i, val) {
                    if (manager.getRowByRowIndex(parseInt(val)).__status != 'add-delete')
                        lineTemp.push(manager.getRowByRowIndex(parseInt(val)));
                });
            if (typeof (delIndex[value]) != 'undefined')
                $.each(delIndex[value], function(i, val) {
                    if (manager.getRowByRowIndex(parseInt(val)).__status != 'add-delete')
                        lineTemp.push(manager.getRowByRowIndex(parseInt(val)));
                });
            if (typeof (editIndex[value]) != 'undefined')
                $.each(editIndex[value], function(i, val) {
                    lineTemp.push(manager.getRowByRowIndex(parseInt(val)));
                });
            jsonData[value] = JSON2.stringify(lineTemp);
        });
    },
    gridSubmit : function()// 表格提交（暂用Form提交待改成ajax提交可用）
    {
        this.editRow();
        this.initParamsJson();
    }
}
/**
 * 表格控件中有下拉框时回填信息
 * 
 * @param {}
 *            gird 渲染表格的当前行
 * @param {}
 *            item 数据集
 * @return {} 下拉框选中的值
 */
function girdChooseSelect(gird, item) {
    if (gird.editor && (gird.editor.type == 'select'))// 是可编辑的select单元格
    {
        gird.selected = true;
        if (item[gird.name])// 有数据
        {
            var temp;
            $.each(gird.editor.data, function(n, value) { // 循环下拉框数据
                if (item[gird.name] == value[gird.editor.dataValueField])
                    temp = value[gird.editor.dataDisplayField];
            });
            return temp;
        } else {
            if (gird.editor.data && (gird.editor.data.length > 0)) {
                item[gird.name] = gird.editor.data[0][gird.editor.dataValueField];// 回填初始化取值
                return gird.editor.data[0][gird.editor.dataDisplayField];
            }
        }
    }
}
// 修正时间只能以"1989/01/12"无法用"1989-01-12"问题覆写ligerGrid时间载入函数
$.ligerDefaults.Grid.renderDate = function(value) {
    var da;
    if (!value)
        return null;
    if (typeof value == 'object') {
        return value;
    }
    if (value.indexOf('Date') > -1) {
        da = eval('new ' + value.replace('/', '', 'g').replace('/', '', 'g'));
    } else {
        da = eval('new Date("' + value.replace('-', '/') + '");');
    }
    return da;
}

$.fn.loginWait = function(mainDivName, loadingDivName, waitTime) {
    if (typeof (mainDivName) == "undefined") {
        mainDivName = 'mainBody';
    }
    if (typeof (loadingDivName) == "undefined") {
        loadingDivName = 'loading';
    }
    if (typeof (waitTime) == "undefined") {
        waitTime = 250;
    }
    $("#" + mainDivName).hide();
    setTimeout('$("#' + loadingDivName + '").hide()', parseInt(waitTime));
    setTimeout('$("#' + mainDivName + '").show()', parseInt(waitTime));
}
$.fn.initStyle = function(getUrl, backUrl) {
    addStyleContainer();
    getStyle(getUrl);
    bindStyleFrom(backUrl);
}
function addStyleContainer() {
    var container = $("div");
    var divNames = new Array(container.length);
    for (var i = 0; i < container.length; i++) {
        divNames[i] = container[i].id;
        if (typeof ($("#" + divNames[i] + "Model")[0]) == "undefined") {
            var modelName = divNames[i] + "Model";
            if (modelName != 'searchEmpModel' && modelName != 'infoModel' && modelName != 'loadingModel' && modelName != 'mainBodyModel') {
                $("#infoForm").append("<input type='hidden' id='" + modelName + "' name='" + modelName + "' value='' />");
            }
        }
    }
}
function getStyle(url) {
    $.ajax({
        type : 'get',
        cache : false,
        contentType : 'application/json',
        dataType : 'json',
        url : url,
        success : function(data) {
            $.each(data.modelList, function(i, item) {
                $("#" + item.MNAME).attr("style", item.MCONTENT);
                $("#" + item.MNAME + "Model").attr("value", item.MCONTENT);
            });
        }
    });
}
function bindStyleFrom(backUrl) {
    $(document).ready(function() {
        $('#update').click(function() {
            var options = {
                url : backUrl,
                type : 'POST',
                success : function() {
                    location.href = location.href;
                }
            };
            $('#infoForm').ajaxSubmit(options);
            return false;
        })
    });
}

function edit() {
    $('div[id]').ligerDrag();
    $('div[id]').ligerResizable();
}

function change(object) {
    $('#' + object + 'Model').val($('#' + object).attr('style'));
}
