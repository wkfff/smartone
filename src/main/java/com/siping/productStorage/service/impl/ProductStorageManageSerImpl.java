package com.siping.productStorage.service.impl;

import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.productStorage.dao.ProductSaleDao;
import com.siping.productStorage.dao.ProductStorageManageDao;
import com.siping.productStorage.service.ProductStorageManageSer;
import com.siping.report.util.FillComputerManager;
import com.siping.report.util.Layouter;
import com.siping.report.util.Writer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SMSUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.StringUtil;

@Service
public class ProductStorageManageSerImpl implements ProductStorageManageSer{

    Logger logger = Logger.getLogger(ProductStorageManageSerImpl.class);

    @Autowired
    private ProductStorageManageDao productStorageManageDao;

    @Autowired
    private ProductSaleDao productSaleDao;

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getSaleOrderList(Map paramMap) throws Exception {
        List list = new ArrayList();
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            list = this.productStorageManageDao.getSaleOrderList(paramMap,
                    NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")),Integer.class),
                    NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")),Integer.class));
        }
        return list;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public int getSaleOrderListCnt(Map paramMap) {
        return this.productStorageManageDao.getSaleOrderListCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getSalesOrderDetail(HttpServletRequest request) {
        List list = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID",admin.getCpnyId());
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            list = this.productStorageManageDao.getSalesOrderDetail(paramMap,
                    NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")),Integer.class),
                    NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")),Integer.class));
        }
        return list;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public int getSalesOrderDetailCnt(HttpServletRequest request) {
        int orderCnt = 0;
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID",admin.getCpnyId());
        orderCnt = this.productStorageManageDao.getSalesOrderDetailCnt(paramMap);
        return orderCnt;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List viewSaleOrderDetailInfo(HttpServletRequest request) {
        List list = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID",admin.getCpnyId());
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            list = this.productStorageManageDao.getSalesOrderDetail(paramMap,
                    NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")),Integer.class),
                    NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")),Integer.class));
        }
        return list;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public int viewSaleOrderDetailInfoCnt(HttpServletRequest request) {
        int orderCnt = 0;
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID",admin.getCpnyId());
        orderCnt = this.productStorageManageDao.getSalesOrderDetailCnt(paramMap);
        return orderCnt;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public Double getLeftQuantity(HttpServletRequest request) {
        double proCnt = 0;
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID",admin.getCpnyId());
        proCnt = this.productStorageManageDao.getLeftQuantity(paramMap);
        return proCnt;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String saveOutStorage(HttpServletRequest request) throws Exception {
        String returnString = "N";
        String returnMsg = "Y";
        double money = 0;
        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> jsonList = ObjectBindUtil.getRequestJsonData(jsonString);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("COMP_ID",admin.getCpnyId());
        paramMap.put("CPNY_ID",admin.getCpnyId());
        paramMap.put("UPDA_BY",admin.getAdminID());
        paramMap.put("OPERATOR", admin.getChineseName());
        String SerialNum = this.productStorageManageDao.getSerialNum();
        paramMap.put("OUTSTORAGE_ID", SerialNum);
        for(LinkedHashMap<String, Object> map : jsonList){
            map.put("COMP_ID",admin.getCpnyId());
            map.put("UPDA_BY",admin.getAdminID());
            map.put("SERIALNUM", SerialNum);
            map.put("returnMsg", returnMsg);
            double discount = Double.parseDouble(map.get("DISCOUNT").toString());
            double pro_price = Double.parseDouble(map.get("PRO_PRICE").toString());
            double out_num = Double.parseDouble(map.get("CURR_OUT_NUM").toString());
            money += discount*pro_price*out_num;
        }
        DecimalFormat df = new DecimalFormat("#.00");
        double df_money = Double.parseDouble(df.format(money));
        paramMap.put("MONEY",df_money);
        double disc = Double.parseDouble(paramMap.get("DISCOUNT").toString());
        paramMap.put("DIS_MONEY", df.format(df_money*disc));
        String insertMsg = this.productStorageManageDao.insertOutInfo(paramMap);
        if(insertMsg.equals("Y")){
            returnString = this.productStorageManageDao.insertOutDetailForList(jsonList);
        }
        if(paramMap.get("voiceRemind")!=null&&paramMap.get("voiceRemind").toString().equals("remindYes")){
            Map orderMap = productSaleDao.getSalesOrderInfo(paramMap);
            String message = "您" + orderMap.get("ORDER_DATE") + "的订单（编号："+orderMap.get("SALES_ORDER_ID")+"）已出库，请做好收货准备!";
            if(paramMap.get("MOBILE")!=null && SMSUtil.sendVoiceWithIMSTelcome(paramMap.get("MOBILE").toString(), message) != 0){
                logger.error("Fail to send voice message with SMSUtil");
            }
        }
        return returnString;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List viewOutStorHistoryList(HttpServletRequest request) {
        List list = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID",admin.getCpnyId());
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            list = this.productStorageManageDao.viewOutStorHistoryList(paramMap,
                    NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")),Integer.class),
                    NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")),Integer.class));
        }
        return list;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public int viewOutStorHistoryListCnt(HttpServletRequest request) {
        int listCnt = 0;
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID",admin.getCpnyId());
        listCnt = this.productStorageManageDao.viewOutStorHistoryListCnt(paramMap);
        return listCnt;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List viewOutStorHistoryDetail(HttpServletRequest request) {
        List list = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID",admin.getCpnyId());
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            list = this.productStorageManageDao.viewOutStorHistoryDetail(paramMap,
                    NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")),Integer.class),
                    NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")),Integer.class));
        }else {
            list = this.productStorageManageDao.viewOutStorHistoryDetail(paramMap);
        }
        return list;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public int viewOutStorHistoryDetailCnt(HttpServletRequest request) {
        int listCnt = 0;
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID",admin.getCpnyId());
        listCnt = this.productStorageManageDao.viewOutStorHistoryDetailCnt(paramMap);
        return listCnt;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String exportOutStorInfo(HttpServletRequest request, HttpServletResponse response) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 附加信息
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));
        // 页面提交的JSON信息
        String jsonCodeString = null;
        List<String> codeList = new ArrayList<String>();
        jsonCodeString = productStorageManageDao.getOutStorExcelColumnInfo(paramMap);
        if (jsonCodeString != null) {
            codeList = StringUtil.hashToList(StringUtil.stringToHash(jsonCodeString));
        }
        paramMap.put("codeList", codeList);
        List<String> titleList = new ArrayList<String>();
        titleList = this.productStorageManageDao.getOutStorExcelTitleInfo(paramMap);
        // 1.创建一个 workbook
        HSSFWorkbook workbook = new HSSFWorkbook();

        // 2.创建一个 worksheet
        HSSFSheet worksheet = workbook.createSheet("出库记录表");

        // 3.定义起始行和列
        int startRowIndex = 0;
        int startColIndex = titleList.size();

        // 4.创建title,data,headers
        Layouter.buildOutStorExcelInfo(worksheet, startRowIndex, startColIndex, titleList,paramMap);

        String discount = paramMap.get("DISCOUNT").toString();
        // 5.填充数据
        FillComputerManager.fillOutStorExcelInfo(worksheet, startRowIndex, startColIndex,getOutStorDatasource(paramMap), codeList,discount);

        // 6.设置reponse参数
        // 进行转码，使其支持中文文件名
        String fileName = null;
        try {
            fileName = java.net.URLEncoder.encode("销售出库记录表"+paramMap.get("OUTSTORAGE_ID").toString(), "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setHeader("Content-Disposition", "inline; filename="+ fileName + ".xls");
        // 确保发送的当前文本格式
        response.setContentType("application/vnd.ms-excel");

        // 7. 输出流
        Writer.write(response, worksheet);
        return "Y";
    }

    @SuppressWarnings("rawtypes")
    private List<LinkedHashMap> getOutStorDatasource(Map paramMap) {
        return this.productStorageManageDao.getOutStorDatasource(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public Double getMinStorQuantity(HttpServletRequest request) {
        double minCnt = 0;
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID",admin.getCpnyId());
        minCnt = this.productStorageManageDao.getMinStorQuantity(paramMap);
        return minCnt;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map getOutstorageOrderById(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("EMPID",StringUtil.checkNull(paramMap.get("EMPID"), admin.getAdminID()));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.productStorageManageDao.getOutstorageOrderById(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getSalesOrderInfo(HttpServletRequest request) {
        List list = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID",admin.getCpnyId());
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            list = this.productStorageManageDao.getSalesOrderInfo(paramMap,
                    NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")),Integer.class),
                    NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")),Integer.class));
        }
        return list;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public int getSalesOrderInfoCnt(HttpServletRequest request) {
        int orderCnt = 0;
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID",admin.getCpnyId());
        orderCnt = this.productStorageManageDao.getSalesOrderInfoCnt(paramMap);
        return orderCnt;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public LinkedHashMap<String, Object> viewSaleOrderDetail(HttpServletRequest request) throws Exception {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID",admin.getCpnyId());
        return this.productStorageManageDao.viewSaleOrderDetail(paramMap);
    }

    @Override
    public String checkReceiverPhoneNum(String saleOrderNo) throws Exception {
        return this.productStorageManageDao.checkReceiverPhoneNum(saleOrderNo);
    }
}
