<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html ng-app="prostor">
<head>
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- CSS -->
    <link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css"/>
    <link href="/resources/css/default.css" rel="stylesheet" type="text/css">
    <link href="/resources/css/productStorage/prostor.css" rel="stylesheet" type="text/css"/>
</head>
<body ng-controller="ProductSale">
<div id="mainContainer">
    <form id="salesOrderContainer" name="salesOrderForm" novalidate>
        <div id="salesOrderInfo">
            <div class="formHeader"><spring:message code="hrms.basicInfo"/></div>

            <span class="l-table-edit-t label"><spring:message code="hrms.placeOrderPerson"/></span>
            <div class="l-table-edit-c value" id="ownerInput">
                <input type="text" id="owner"
                       ng-click="<c:if test="${isSupervisor}">spf_selectEmp()</c:if>"
                       ng-change="ownerChanged()"
                       readonly
                       ng-model="selectedOwner.empName"
                       ng-init='setOwner()'
                       ng-class="{submitted:submitted}"
                       required/>
            </div>

            <div class="l-table-edit-t label"><spring:message code="hrms.customerName"/></div>
            <div class="l-table-edit-c value">
                <input type="text" id="cust" readonly
                       ng-click="showCustSuggestion()"
                       ng-class="{submitted:submitted}"
                       ng-model="selectedCustomer.customerName"
                       required/>
            </div>

            <br>

            <div class=" l-table-edit-t label"><spring:message code="hrms.salesMode"/></div>
            <div class="l-table-edit-c value">
                <select id="salesMode"
                        ng-model="salesMode"
                        ng-options="s.salesModeName for s in allSalesMode"
                        ng-change="changeSalesMode()">
                    <option value=""><spring:message code="hrms.selection"/></option>
                </select>
            </div>

            <div class=" l-table-edit-t label"><spring:message code="prostor.sales.order.search.date"/></div>
            <div class="l-table-edit-c value">
                <input type="text"
                       id="orderDate"
                       onclick="WdatePicker({
                               lang:<spring:message code='dateLanguage'/>,
                               isShowClear:true,
                               readOnly:true,
                               dateFmt:'yyyy-MM-dd HH:mm:ss'
                               })"
                       readonly="readonly"/>
            </div>

            <div class="l-table-edit-t label"><spring:message code="hrms.paymentMode"/></div>
            <div class="l-table-edit-c value">
                <SipingSoft:selectSyCode parentCode="PaymentMode" name="PAYMENT_MODE" limit="all"/>
            </div>

            <br><br>
            <div class="formHeader">
                <span >发票内容 </span>
                <button class="link-button" ng-hide="needInvoice" ng-click="needInvoice=!needInvoice">[开具发票]</button>
                <button class="link-button" ng-show="needInvoice" ng-click="needInvoice=!needInvoice">[隐藏发票]</button>
            </div>
            <div class="warning" ng-hide="needInvoice">无</div>
            <div ng-show="needInvoice">
                <div class="l-table-edit-t label"><spring:message code="hrms.invoiceTitle"/></div>
                <div class="l-table-edit-c value">
                    <ul id="invoice">
                        <li>
                            <input  id="personalInvoice"
                                    type="radio"
                                    ng-model="invoiceTitle"
                                    value="个人"/>
                            <label for="personalInvoice" class="radioLabel">个人</label>
                        </li>
                        <li>
                            <input  id="companyInvoice"
                                    type="radio"
                                    ng-model="invoiceTitle"
                                    value="公司"/>
                            <label for="companyInvoice" class="radioLabel">公司</label>
                        </li>
                        <li>
                            <input type="text"
                                   ng-if="showInvoiceTitleContent()"
                                   ng-model="invoiceTitleContent" />
                        </li>
                    </ul>
                </div>

                <div class=" l-table-edit-t label"><spring:message code="hrms.invoiceContent"/></div>
                <input type="text" ng-model="invoiceContent"/>
            </div>
        </div>
        <br>
        <div id="salesOrder">
            <div class="formHeader"><spring:message code="prostor.sales.order.add.products"/></div>
            <div ng-if="!salesMode"
                class="warning"><spring:message code="prostor.sales.order.select.sales.mode.before.add.products"/></div>

            <table ng-show="salesMode" width="100%">
                <tr>
                    <th style="width:4%"><spring:message code="hrms.line.no"/></th>
                    <th style="width:8%"><spring:message code="hrms.productCode"/></th>
                    <th style="width:15%"><spring:message code="hrms.product.name"/></th>
                    <th style="width:4%"><spring:message code="hrms.specification"/></th>
                    <th style="width:4%"><spring:message code="hrms.unit"/></th>
                    <th style="width:10%"><spring:message code="hrms.unitPrice"/></th>
                    <th style="width:5%"><spring:message code="hrms.quantity"/></th>
                    <th style="width:10%"><spring:message code="hrms.price.without.discount"/></th>
                    <th style="width:5%"><spring:message code="hrms.discount"/></th>
                    <th style="width:10%"><spring:message code="hrms.discount.price"/></th>
                    <th style="width:18%"><spring:message code="hrms.remarks"/></th>
                    <th style="width:7%"><spring:message code="edit"/></th>
                </tr>
                <tr ng-repeat="soldProduct in soldProducts"
                    ng-click="selectRow($last)"
                    ng-class-even="'even'"
                    ng-class="{selected: soldProduct === selectedProduct}"
                    ng-form="dataForm">
                    <td> {{$index + 1}}</td>
                    <td ng-mouseleave="isIdDropdownShown=false">
                        <input  type="text"
                                name="pno"
                                ng-click="showIdDropdown()"
                                ng-class="{submitted:submitted}"
                                ng-model="soldProduct.id"
                                ng-required="isRequired(soldProduct)" />
                        <ul class="dropdown" ng-if="isIdDropdownShown">
                    <li
                            ng-repeat="product in allProducts | filter: soldProduct.id"
                            ng-click="selectProduct($parent.$parent, $parent.$index)"
                            ng-class-even="'even'"
                            ng-mouseover="isHovered=true"
                            ng-mouseleave="isHovered=false"
                            ng-class="{optionHover:isHovered}">
                        {{product.id}} - {{product.name}}({{product.specification}})
                    </li>
                </ul>
                    </td>
                    <td ng-mouseleave="isNameDropdownShown=false">
                        <input type="text"
                               ng-model="soldProduct.name"
                               ng-click="showNameDropdown()"
                               ng-class="{submitted:submitted}"
                               ng-required="isRequired(soldProduct)"
                                />
                        <ul class="dropdown" ng-if="isNameDropdownShown">
                            <li ng-repeat="product in allProducts | filter: soldProduct.name"
                                ng-click="selectProduct($parent.$parent, $parent.$index)"
                                ng-class-even="'even'"
                                ng-mouseover="isHovered=true"
                                ng-mouseleave="isHovered=false"
                                ng-class="{optionHover:isHovered}">
                                {{product.id}} - {{product.name}}({{product.specification}})
                            </li>
                        </ul>
                    </td>
                    <td>{{soldProduct.specification}}</td>
                    <td>{{soldProduct.unit.unitName}}</td>
                    <td>{{soldProduct.sellingPrice.price | number:2}}</td>
                    <td>
                        <input type="text"
                               name="quantity"
                               ng-class="{submitted:submitted}"
                               ng-model="soldProduct.quantity"
                               ng-required="isRequired(soldProduct)"
                               sp-valid-num
                               sp-min="0"
                                />
                    </td>
                    <td>{{soldProduct.amount | number:2}}</td>
                    <td><input  type="text"
                                class="message"
                                title='<spring:message code="prostor.sales.order.discount.toolip"/>'
                                ng-mouseover="showTitle()"
                                ng-model="soldProduct.sellingPrice.discount"
                                ng-class="{submitted:submitted}"
                                ng-required="isRequired(soldProduct)"
                                sp-valid-discount/>
                    </td>
                    <td>{{soldProduct.sellingPrice.discountPrice | number:2}}</td>
                    <td><input type="text" ng-model="soldProduct.remark"/></td>
                    <td>
                            <span class="deleteRow" ng-click="soldProducts.splice($index, 1)">
                                <img src="/resources/js/ligerUI/skins/icons/0.gif" alt="delete">
                            </span>
                            <span class="addRow" ng-click="soldProducts.splice($index+1, 0, {})">
                                <img src="/resources/js/ligerUI/skins/icons/add.gif" alt="add">
                            </span>
                    </td>
                </tr>
            </table>
    <br><br>

    <div id="salesOrderInfoBottom">
        <div class="formHeader"><spring:message code="prostor.Other"/></div>
        <span class="l-table-edit-t label"><spring:message code="hrms.total.amount"/></span>

        <div class="l-table-edit-c value">
            <input type="text" readonly="readonly" value="{{orderPrice.price | number:2}}"/>
        </div>

        <span class="l-table-edit-t label"><spring:message code="hrms.discount"/></span>

        <div class="l-table-edit-c value">
            <input class="inputclass message" title='<spring:message code="prostor.sales.order.discount.toolip"/>'
                   ng-model="orderPrice.discount"
                   sp-valid-discount
                   ng-class="{submitted:submitted}"/>
        </div>

        <span class="l-table-edit-t label"><spring:message code="hrms.discount.price"/></span>

        <div class="l-table-edit-c value">
            <input type="text" readonly="readonly" value="{{orderPrice.discountPrice | number:2}}"/>
        </div>
        <br>

        <span class="l-table-edit-t label"><spring:message code="hrms.transport.mode"/></span>

        <div class="l-table-edit-c value">
            <input type="text" ng-model="transportMode"/>
        </div>

        <span class="l-table-edit-t label"><spring:message code="hrms.delivery.date"/></span>

        <div class="l-table-edit-c value">
            <input type="text" ng-model="deliveryDate"/>
        </div>

        <span class="l-table-edit-t label"><spring:message code="hrms.consignee"/></span>

        <div class="l-table-edit-c value" ng-mouseover>
            <select id="consignee"
                    ng-model="receiver"
                    ng-class="{submitted:submitted}"
                    ng-options="r.RECEIVER_NAME+ ' ' + r.RECEIVER_ADDRESS + ' ' + r.RECEIVER_MOBILE1 for r in receivers">
                <option value=""><spring:message code="hrms.selection"/></option>
            </select>
        </div>
    </div>

    <ul class="buttonGroup">
        <li>
            <button class="l-button" ng-click="save()" type="submit"><spring:message
                    code="hrms.save"/></button>
        </li>
        <li>
            <button class="l-button" ng-click="cancel()"
                    type="button"><spring:message code="cancel"/></button>
        </li>
    </ul>
</div>
    </form>
</div>
<script src="/resources/js/jquery/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui-1.2.2.min.js" type="text/javascript"></script>
<script src="/resources/js/angularjs/angular.min.js" type="text/javascript"></script>
<script src="/resources/js/angularjs/validate.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/prostor.js" type="text/javascript"></script>

</body>
</html>
