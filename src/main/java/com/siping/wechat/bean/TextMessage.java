package com.siping.wechat.bean;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.siping.productStorage.bean.SalesOrder;
import com.siping.productStorage.dao.ProductDao;
import com.siping.productStorage.dao.ProductSaleDao;

@Component("wc_textMessage")
@Scope("request")
public class TextMessage extends WeChatMessage {
    private final Logger logger = Logger.getLogger(TextMessage.class);
    private static final String COMMAND_PRODUCT = "产品";
    private static final String COMMAND_SALES_ORDER = "订单";

    @Autowired
    private ProductDao productDao;

    @Autowired
    private ProductSaleDao productSaleDao;

    private String Content;
    private String MsgId;

    public void initParam(LinkedHashMap<String, String> messageMap) {
        super.initParam(messageMap);
        setMsgId(messageMap.get("MsgId"));
        setContent(messageMap.get("Content"));
    }

    public String getContent() {
        return Content;
    }

    public void setContent(String content) {
        Content = content;
    }

    public String getMsgId() {
        return MsgId;
    }

    public void setMsgId(String msgId) {
        MsgId = msgId;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public String getReturnMessage() {
        StringBuffer returnContent = new StringBuffer();
        // 销售订单命令
        if (this.getContent().startsWith(COMMAND_SALES_ORDER)) {
            Map paramMap = new LinkedHashMap<String, Object>();
            paramMap.put("salesOrderId", this.getContent().replaceAll(COMMAND_SALES_ORDER, "").trim());
            logger.error("parse order command");
            logger.error(paramMap);
            SalesOrder salesOrder = productSaleDao.getSalesOrderById(paramMap);
            logger.error("return from dao order");
            if (salesOrder != null) {
                returnContent.append("订单编号:" + generateOrderUrlLink(salesOrder) + "\n");
                if (salesOrder.getAffirmFlag() != null) {
                    logger.error("affirmflag ok");
                    returnContent.append("审核状态:" + salesOrder.getAffirmFlag().getCodeName() + "\n");
                }
                if (salesOrder.getStatusFlag() != null) {
                    logger.error("status ok");
                    returnContent.append("出库状态:" + salesOrder.getStatusFlag().getCodeName() + "\n");
                }
                if (salesOrder.getTraStatusFlag() != null) {
                    logger.error("trastatus ok");
                    returnContent.append("确认状态:" + salesOrder.getTraStatusFlag().getCodeName());
                }
            } else {
                returnContent.append("没有此订单");
            }
        }
        // 产品命令
        if (this.getContent().startsWith(COMMAND_PRODUCT)) {
            LinkedHashMap<String, Object> paramMap = new LinkedHashMap<String, Object>();
            paramMap.put("keyWord", this.getContent().replaceAll(COMMAND_PRODUCT, "").trim());
            List<LinkedHashMap<String, Object>> list = productDao.getProductList(paramMap);
            for (int i = 0; i < list.size(); i++) {
                LinkedHashMap<String, Object> product = list.get(i);
                returnContent.append(generateProductUrlLink(product));
                if (i == 4)
                    break;
            }
        }
        return this.generateTextMsgXML(returnContent.toString());
    }

    private String generateProductUrlLink(LinkedHashMap<String, Object> product) {
        String url = "<a href='http://" + webDomain + "/mobile/productManage/viewMobileProDetail?PRODUCT_NO=" + product.get("PRODUCT_NO") + "&OBJECT_ID=" + product.get("PRODUCT_ID")
                + "&OBJECT_TYPE_ID=PRODUCT&page=1&pagesize=20'>" + product.get("PRODUCT_NAME") + " " + product.get("SPECIFICATION") + "</a>" + " 价格:" + product.get("UNIT_PRICE") + "元\n";
        return url;
    }

    private String generateOrderUrlLink(SalesOrder salesOrder) {
        String url = "<a href='http://" + webDomain + "/mobile/mobileOrder/viewSalesOrderDetail?SALES_ORDER_NO=" + salesOrder.getSalesOrderNo() + "'>" + salesOrder.getSalesOrderId() + "</a>";
        return url;
    }
}
