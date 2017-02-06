angular.module("prostor", ["ui.validate"])
    .controller("ProductSale", function ($scope, $http, $filter) {
        $scope.setOwner = function () {
            $http.get("/productStorage/proBusinessManage/getCurrentEmp").success(function (data){
                $scope.selectedOwner = data;
            });

        };

        $http.get("/productStorage/proBusinessManage/getAllSalesMode").success(function (data) {
            $scope.allSalesMode = data;
        });

        var clearGrid = function(){
            $scope.soldProducts = [
                {},
                {}
            ];
        };

        $scope.init = function () {
            $scope.isCustSuggestShown = false;
            $scope.isOwnerSuggestShown = false;
            clearGrid();
            $scope.setOwner();
            $scope.orderPrice = {"discount": 1, "price": 0.00, "discountPrice": 0.00};
            $scope.invoiceTitle = "";
            $scope.selectedOwner = $scope.currentUser;
            $scope.salesMode = null;
            $scope.selectedCustomer = {};
            $scope.selectedAffirmEmp = {};
            $scope.deliveryAddress = "";
            $scope.transportMode = "";
            $scope.deliveryDate = "";
            $scope.consignee = "";
            $scope.receivers = {};
            $scope.receiver = {};
            $scope.invoiceTitle = "个人";
            $scope.needInvoice = false;
            $("#PAYMENT_MODE").val("");
            $scope.invoiceContent = "";
            $scope.invoiceTitle = "个人";
            document.getElementById("orderDate").value = $filter('date')(new Date(), "yyyy-MM-dd HH:mm:ss");
        };
        $scope.init();

        $scope.changeSalesMode = function () {
            clearGrid();
        };
        $scope.spf_selectOwnerOK = function(item, dialog){
            var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo;
            var data = fn();
            if (!data){
                return;
            }
            dialog.close();
            $scope.selectedOwner["empId"] = data.EMPID;
            $scope.selectedOwner["empName"] = data.CHINESENAME;
            $("#owner").val(data.CHINESENAME);

            $scope.selectedCustomer = {};
            $scope.receivers = {};
            $("#cust").val("");
            $("#consignee").val("");
            $("#consignee option[value!='']").remove();
        };
        $scope.ownerChanged = function(){
        };

        $scope.spf_selectEmp = function(){
            $.ligerDialog.open({
                title: '职员信息',
                name:'winselector'+Math.random(),
                width: 800,
                height: 400,
                url: '/utility/empInfo/viewCustSearchEmployeeB',
                buttons: [
                    { text: '确定', onclick: $scope.spf_selectOwnerOK }
                ]
            });
        };
        $scope.spf_selectCustOK = function(item, dialog){
            var fn = dialog.frame.spf_selectCustomer || dialog.frame.window.spf_selectCustomer;
            var data = fn();
            if (!data){
                return;
            }
            dialog.close();
            $scope.selectedCustomer["customerNo"] = data["CUST_NO"];
            $scope.selectedCustomer["customerName"] = data["CUST_NAME"];
            $("#cust").val(data["CUST_NAME"]);
            $scope.receivers = data["RECEIVERS"];
            $("#cust").removeClass("ng-invalid");

            updateReceiverList(data);

            updateSalesMode(data);
        };

        function updateSalesMode(data){
            var preSalesMode = $scope.salesMode;
            if(data.CUST_SALES_MODE_CODE === null){
                $scope.salesMode = null;
            } else{
                $.each($scope.allSalesMode, function(index, eachSalesMode){
                    if(eachSalesMode.salesModeNo == data.CUST_SALES_MODE_CODE && data.CUST_SALES_MODE_CODE != preSalesMode){
                        $scope.salesMode = eachSalesMode;
                    }
                });
            }
            if(!angular.equals(preSalesMode, $scope.salesMode)){
                $scope.changeSalesMode();
                $("#salesMode").change();
            }

        }

        function updateReceiverList(customer){
            $.each(customer["RECEIVERS"], function(index, receiver){
                if(receiver.RECEIVER_MOBILE1 === null){
                    receiver.RECEIVER_MOBILE1="";
                }
                if(receiver.RECEIVER_NAME === null){
                    receiver.RECEIVER_NAME = "";
                }
                if(receiver.RECEIVER_ADDRESS === null){
                    receiver.RECEIVER_ADDRESS = "";
                }
            })
        }

        $scope.showCustSuggestion = function () {
            $.ligerDialog.open({
                title: '客户信息',
                name:'winselector'+Math.random(),
                width: 800,
                height: 400,
                url: '/utility/custInfo/viewCustomerList?ownerId='+$scope.selectedOwner.empId,
                buttons: [
                    { text: '确定', onclick: $scope.spf_selectCustOK }
                ]
            });
        };

        $scope.showInvoiceTitleContent = function(){
            return $scope.invoiceTitle === "公司"
        };

        $scope.selectRow = function (isLast) {
            if (isLast) {
                $scope.soldProducts.push({});
            }
            $scope.selectedProduct = this.soldProduct;
        };

        function getProductsBySalesMode() {
            $http.get("/productStorage/proBusinessManage/getProductsBySalesMode", {params: {salesModeNo: $scope.salesMode.salesModeNo}}).success(function (data) {
                $scope.allProducts = data;
            });
        }
        $scope.getAllProducts = function () {
            getProductsBySalesMode();
        };

        $scope.showIdDropdown = function () {
            $scope.getAllProducts();
            this.isIdDropdownShown = true;
        };

        $scope.showNameDropdown = function () {
            $scope.getAllProducts();
            this.isNameDropdownShown = true;
        };

        $scope.selectProduct = function (parent, index) {
            var product = this.product;
            for(var i = 0; i < $scope.soldProducts.length; i++){
                if($scope.soldProducts[i].no === product.no){
                    $.ligerMessageBox.warn('提示', '不能重复添加货品');
                    return;
                }
            }
            $scope.soldProducts[index] = this.product;
            $scope.soldProducts[index].sellingPrice.discount = 1;
            $scope.soldProducts[index].quantity = null;
            parent.isIdDropdownShown = false;
            parent.isNameDropdownShown = false;
        };

        $scope.$watch(function () {
            var orderPrice = 0;
            var thisSoldProduct;
            for (var i = 0; i < $scope.soldProducts.length; i++) {
                thisSoldProduct = $scope.soldProducts[i];
                if (thisSoldProduct.sellingPrice !== undefined) {    //当前货品售价不为空时才计算价格
                    thisSoldProduct.amount = thisSoldProduct.sellingPrice.price * thisSoldProduct.quantity;

                    if (thisSoldProduct.amount === thisSoldProduct.amount && thisSoldProduct.amount !== null) {   //如果total不是NAN且不为null时才计算,以避免初始时显示为null
                        thisSoldProduct.amount = thisSoldProduct.amount;
                        thisSoldProduct.sellingPrice.discountPrice = thisSoldProduct.amount * thisSoldProduct.sellingPrice.discount;
                        orderPrice += thisSoldProduct.sellingPrice.discountPrice;
                    }
                }
            }
            $scope.orderPrice.price = orderPrice;
            $scope.orderPrice.discountPrice = orderPrice * $scope.orderPrice.discount;
        });

        var getAllEmployees = function(){
            $http.get("/productStorage/proBusinessManage/getEmInfoList").success(function (data) {
                $scope.employees = data;
            });
        };
        $scope.showSuggestion = function () {
            getAllEmployees();
            $scope.isOwnerSuggestShown = true;
        };

        $scope.selectOwner = function () {
            $scope.selectedOwner = this.employee;
            $scope.isOwnerSuggestShown = false;
        };

        $scope.showAffirmEmpSuggestion = function(){
            $.ligerDialog.open({
                title: '职员信息',
                name:'winselector'+Math.random(),
                width: 800,
                height: 400,
                url: '/utility/empInfo/viewHrSearchEmployeeB',
                buttons: [
                    { text: '确定', onclick: $scope.spf_selectCheckerOK }
                ]
            });
        };
        $scope.spf_selectCheckerOK = function(item, dialog){
            var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo;
            var data = fn();
            if (!data){
                return;
            }
            dialog.close();
            $scope.selectedAffirmEmp["empId"] = data.EMPID;
            $scope.selectedAffirmEmp["empName"] = data.CHINESENAME;
            $("#checker").val(data.CHINESENAME);

            $("#checker").removeClass("ng-invalid");
        };

        $scope.cancel = function () {
            $scope.init();
            $scope.submitted = false;
        };

         $scope.isRequired = function(p){
             return !angular.equals(p, {});
         };
        $scope.isQuantityValid = function(product){
            if ($scope.isRequired(product)){
                return product.quantity > 0;
            }else{
                return true;
            }
        };
        function isSoldProductsEmpty (){
            for(var i = 0; i < $scope.soldProducts.length; i++){
                if(!angular.equals($scope.soldProducts[i],{})){
                    return false;
                }
            }
            return true;
        }
        function validate (){
            if($scope.salesOrderForm.$valid && isSoldProductsEmpty()){
                $.ligerMessageBox.error('提示', '请添加货品');
                return false;
            }
            return $scope.salesOrderForm.$valid && !isSoldProductsEmpty();
        }

        $scope.showTitle = function(){
            $(".message").ligerTip();
        };
        $scope.save = function () {
            if (!validate()){
                $scope.submitted = true;
                return;
            }
            var products = [];
            $.each($scope.soldProducts, function(index, p){
                if(!angular.equals(p, {})){
                    products.push(p);
                }
            });

            var salesOrder = {
                "customer": $scope.selectedCustomer,
                "owner": $scope.selectedOwner,
                "salesMode": $scope.salesMode,
                "price": $scope.orderPrice,
                "invoiceTitle": $scope.invoiceTitle,
                "transportMode": $scope.transportMode,
                "deliveryDate": $scope.deliveryDate,
                "consignee": $scope.receiver.RECEIVER_NAME,
                "deliveryAddress": $scope.receiver.RECEIVER_ADDRESS,
                "soldProducts": products,
                "orderDate": new Date(Date.parse((document.getElementById("orderDate").value).replace(/-/g,   "/"))),
                "receiver": {"receiverName": $scope.receiver.RECEIVER_NAME, "address": { "wholeAddress": $scope.receiver.RECEIVER_ADDRESS}, "mobilePhone": $scope.receiver.RECEIVER_MOBILE1},
                "paymentMode": $("#PAYMENT_MODE").val()
            };
            if($scope.needInvoice){
                salesOrder["invoiceType"]= "普通发票";
                salesOrder["invoiceTitleType"]= $scope.invoiceTitle;
                salesOrder["invoiceTitleContent"]= $scope.invoiceTitleContent;
                salesOrder["invoiceContent"]= $scope.invoiceContent;
            }
            $.ligerDialog.waitting('正在保存');
                $http({
                    method: 'POST',
                    url: '/productStorage/proBusinessManage/saveSalesOrder',
                    data: salesOrder
                }).success(function(data){
                        $.ligerDialog.closeWaitting();
                        if(data == '"Y"'){
                            $.ligerDialog.success('保存成功', '保存成功');
                            $scope.init();
                            $scope.submitted = false;
                        } else {
                            $.ligerMessageBox.error('保存失败', data);
                        }
                    }).error(function(){
                        $.ligerDialog.closeWaitting();
                        $.ligerMessageBox.error('保存失败', data);
                    });
        };
})
.directive("spValidNum", function(){
    return{
        restrict: "A",
        require: "ngModel",
        priority:0,
        link:function(scope, element, attr, ctrl){
            ctrl.$parsers.unshift(function(value){
                if (parseFloat(value) > attr["spMin"] ){
                    ctrl.$setValidity("numValidate", true);
                    return value;
                }
                else{
                    ctrl.$setValidity("numValidate", false);
                    return undefined;
                }
            })
        }
    }
})
.directive("spValidDiscount", function(){
    return{
        restrict: "A",
        require: "ngModel",
        priority:0,
        link:function(scope, element, attr, ctrl){
            ctrl.$parsers.unshift(function(value){
                if (parseFloat(value) > 0 && parseFloat(value) <=1 ){
                    ctrl.$setValidity("discountValidate", true);
                    return value;
                }
                else{
                    ctrl.$setValidity("discountValidate", false);
                    return undefined;
                }
            })
        }
    }
});
