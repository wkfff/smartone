package com.siping.productStorage.bean;

import com.siping.cust.bean.Customer;
import com.siping.cust.bean.Receiver;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.CustomDateSerializer;
import org.codehaus.jackson.map.annotate.JsonSerialize;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class SalesOrder {
    private String salesOrderNo;
    private String salesOrderId;
    private Customer customer;
    private Employee owner;
    private SalesMode salesMode;
    private String invoiceTitle;
    @JsonSerialize(using = CustomDateSerializer.class)
    private Date orderDate;
    private Employee affirmedEmp;
    private Price price;
    private String transportMode;
    private String deliveryDate;
    private String consignee;
    private String deliveryAddress;
    private List<Product> soldProducts;
    private SYCode status;
    private String remark;
    private String processid;
    private SYCode affirmFlag;
    private SYCode statusFlag;
    private SYCode traStatusFlag;
    private String receivedMoney;
    private Receiver receiver;
    private String taobaoOrderId;                   //淘宝订单号
    private String invoiceType;                     //发票类型（普通发票，增值税发票）
    private String invoiceTitleType;                //发票抬头类型（个人，公司）
    private String invoiceTitleContent;            //发票抬头内容（只针对抬头类型为公司）
    private String invoiceContent;                  //发票内容
    private String paymentMode;                     //支付方式
    
    public String getPaymentMode() {
        return paymentMode;
    }

    public void setPaymentMode(String paymentMode) {
        this.paymentMode = paymentMode;
    }

    public String getInvoiceType() {
        return invoiceType;
    }

    public void setInvoiceType(String invoiceType) {
        this.invoiceType = invoiceType;
    }

    public String getInvoiceTitleType() {
        return invoiceTitleType;
    }

    public void setInvoiceTitleType(String invoiceTitleType) {
        this.invoiceTitleType = invoiceTitleType;
    }

    public String getInvoiceTitleContent() {
        return invoiceTitleContent;
    }

    public void setInvoiceTitleContent(String invoiceTitleContent) {
        this.invoiceTitleContent = invoiceTitleContent;
    }

    public String getInvoiceContent() {
        return invoiceContent;
    }

    public void setInvoiceContent(String invoiceContent) {
        this.invoiceContent = invoiceContent;
    }

    public String getTaobaoOrderId() {
        return taobaoOrderId;
    }

    public void setTaobaoOrderId(String taobaoOrderId) {
        this.taobaoOrderId = taobaoOrderId;
    }

    public Receiver getReceiver() {
        return receiver;
    }

    public void setReceiver(Receiver receiver) {
        this.receiver = receiver;
    }

    public String getReceivedMoney() {
        return receivedMoney;
    }

    public void setReceivedMoney(String receivedMoney) {
        this.receivedMoney = receivedMoney;
    }

    public SYCode getTraStatusFlag() {
        return traStatusFlag;
    }

    public void setTraStatusFlag(SYCode traStatusFlag) {
        this.traStatusFlag = traStatusFlag;
    }

    private AdminBean operator;

    public SYCode getAffirmFlag() {
        return affirmFlag;
    }

    public void setAffirmFlag(SYCode affirmFlag) {
        this.affirmFlag = affirmFlag;
    }

    
    public SYCode getStatusFlag() {
        return statusFlag;
    }

    public void setStatusFlag(SYCode statusFlag) {
        this.statusFlag = statusFlag;
    }

    public SYCode getStatus() {
        return status;
    }

    public void setStatus(SYCode status) {
        this.status = status;
    }

    public AdminBean getOperator() {
        return operator;
    }

    public void setOperator(AdminBean operator) {
        this.operator = operator;
    }

    public SalesOrder() {
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getSalesOrderNo() {
        return salesOrderNo;
    }

    public void setSalesOrderNo(String salesOrderNo) {
        this.salesOrderNo = salesOrderNo;
    }

    public String getSalesOrderId() {
        return salesOrderId;
    }

    public void setSalesOrderId(String salesOrderId) {
        this.salesOrderId = salesOrderId;
    }

    public Price getPrice() {
        return price;
    }

    public void setPrice(Price price) {
        this.price = price;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Employee getOwner() {
        return owner;
    }

    public void setOwner(Employee owner) {
        this.owner = owner;
    }

    public SalesMode getSalesMode() {
        return salesMode;
    }

    public void setSalesMode(SalesMode salesMode) {
        this.salesMode = salesMode;
    }

    public String getInvoiceTitle() {
        return invoiceTitle;
    }

    public void setInvoiceTitle(String invoiceTitle) {
        this.invoiceTitle = invoiceTitle;
    }
    public Date getOrderDate() {
        return orderDate;
    }
    public String getFormattedOrderDate(){
        return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(orderDate);
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public Employee getAffirmedEmp() {
        return affirmedEmp;
    }

    public void setAffirmedEmp(Employee affirmedEmp) {
        this.affirmedEmp = affirmedEmp;
    }

    public List<Product> getSoldProducts() {
        return soldProducts;
    }

    public void setSoldProducts(List<Product> soldProducts) {
        this.soldProducts = soldProducts;
    }

    public String getTransportMode() {
        return transportMode;
    }

    public void setTransportMode(String transportMode) {
        this.transportMode = transportMode;
    }

    public String getDeliveryDate() {
        return deliveryDate;
    }

    public void setDeliveryDate(String deliveryDate) {
        this.deliveryDate = deliveryDate;
    }

    public String getConsignee() {
        return consignee;
    }

    public void setConsignee(String consignee) {
        this.consignee = consignee;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public String getProcessid() {
        return processid;
    }

    public void setProcessid(String processid) {
        this.processid = processid;
    }
}
