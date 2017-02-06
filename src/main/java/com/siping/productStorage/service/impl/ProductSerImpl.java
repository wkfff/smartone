package com.siping.productStorage.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.siping.productStorage.bean.Product;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.DVConstraint;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDataValidation;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddressList;
import org.apache.poi.ss.usermodel.Cell;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;
import org.springframework.web.multipart.MultipartFile;

import com.siping.productStorage.dao.ProductDao;
import com.siping.productStorage.dao.SalesModelDao;
import com.siping.productStorage.dao.StorageManageDao;
import com.siping.productStorage.service.ProductSer;
import com.siping.report.util.FillComputerManager;
import com.siping.report.util.Layouter;
import com.siping.report.util.Writer;
import com.siping.system.bean.AdminBean;
import com.siping.system.dao.BasicMaintenanceDao;
import com.siping.web.messages.Messages;
import com.siping.web.utility.EncryptUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class ProductSerImpl implements ProductSer {
    Logger logger = Logger.getLogger(ProductSerImpl.class);
    @Autowired
    private ProductDao productDao;
    @Autowired
    private SalesModelDao salesModelDao;
    @Autowired
    private StorageManageDao storageManageDao;
    @Autowired
    private BasicMaintenanceDao basicMaintenanceDao;

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getProductList(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        if (request.getAttribute("M_AREA_NO") != null) {
            paramMap.put("M_AREA_NO", request.getAttribute("M_AREA_NO"));
            request.removeAttribute("M_AREA_NO");
        }
        paramMap.put("language", Messages.getLanguage(request));
        Object temp_status = paramMap.get("STATUS");
        Object temp_keyWord = paramMap.get("keyWord");
        paramMap.put("STATUS", 1);
        paramMap.put("keyWord", "");
        List<HashMap> list = salesModelDao.getSalesModelList(paramMap); // 获取销售方式
        String nvl = ",NVL(" + "(SELECT SUM(PSP.LEFT_QUANTITY) FROM PROSTOR_STORAGE_PRODUCT PSP " + "WHERE PSP.PRODUCT_NO = PP.PRODUCT_NO " + "AND PSP.ACTIVITY = 1), " + "0) LEFT_QUANTITY";
        nvl = nvl + getSaleSql(request, list);
        paramMap.put("nvl", nvl);
        paramMap.put("STATUS", temp_status);
        paramMap.put("keyWord", temp_keyWord);
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            return this.productDao.getProductList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            return this.productDao.getProductList(paramMap);
        }
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public int getProductListCnt(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        return this.productDao.getProductListCnt(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String addOrUpdateProduct(HttpServletRequest request) {
        String returnString = "Y";
        // session用户信息
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("CATEGORY_ID", paramMap.get("PRODUCT_CATEGORY_ID_IN"));

        // 从前台获取的，总共有多少个销售方式和仓库
        List<LinkedHashMap<String, Object>> storageList = this.storageManageDao.getStorageList(paramMap);
        List<LinkedHashMap<String, Object>> salesList = this.salesModelDao.getSalesModelList(paramMap);
        List<LinkedHashMap<String, Object>> propertyList = this.basicMaintenanceDao.getPropertyList(paramMap);

        // 不为空则为更新，否则为添加
        if (paramMap.get("PRODUCT_NO") != null && !"".equals(paramMap.get("PRODUCT_NO"))) {
            String salesSql = "";
            String storageSql = "";
            String propertySql = "";
            // 判断更新商品的几种销售方式，先删除原有记录，再插入新纪录
            for (int i = 0; i < salesList.size(); i++) {
                // 还是判断一下，如果原来的商品有此销售方式，那么现在为空或者为/，则清空，表示移除该销售方式
                if (paramMap.get("SALE" + salesList.get(i).get("SALES_MODE_NO")) == null || "".equals(paramMap.get("SALE" + salesList.get(i).get("SALES_MODE_NO")))
                    || "null".equals(paramMap.get("SALE" + salesList.get(i).get("SALES_MODE_NO")))) {
                    salesSql = salesSql + "DELETE FROM PROSTOR_PRODUCT_SALES_MODEL  WHERE PROSTOR_PRODUCT_SALES_MODEL.PRODUCT_NO='" + paramMap.get("PRODUCT_NO") + "'" + " AND PROSTOR_PRODUCT_SALES_MODEL.SALES_MODE_NO='"
                        + salesList.get(i).get("SALES_MODE_NO") + "'" + " AND PROSTOR_PRODUCT_SALES_MODEL.CPNY_ID='" + paramMap.get("CPNY_ID") + "'" + " AND PROSTOR_PRODUCT_SALES_MODEL.ACTIVITY = 1;";
                }
                // 先删除后更新，减少代码量
                if (paramMap.get("SALE" + salesList.get(i).get("SALES_MODE_NO")) != null && !"".equals(paramMap.get("SALE" + salesList.get(i).get("SALES_MODE_NO")))
                    && !"null".equals(paramMap.get("SALE" + salesList.get(i).get("SALES_MODE_NO")))) {
                    salesSql = salesSql + "DELETE FROM PROSTOR_PRODUCT_SALES_MODEL WHERE PROSTOR_PRODUCT_SALES_MODEL.PRODUCT_NO='" + paramMap.get("PRODUCT_NO") + "'" + " AND PROSTOR_PRODUCT_SALES_MODEL.SALES_MODE_NO='"
                        + salesList.get(i).get("SALES_MODE_NO") + "'" + " AND PROSTOR_PRODUCT_SALES_MODEL.CPNY_ID = '" + paramMap.get("CPNY_ID") + "'" + " AND PROSTOR_PRODUCT_SALES_MODEL.ACTIVITY = 1;"
                        + "INSERT INTO PROSTOR_PRODUCT_SALES_MODEL(PRODUCT_NO,SALES_MODE_NO,PRICE,CREATE_DATE,CREATED_BY,ACTIVITY,CPNY_ID)" + "VALUES('" + paramMap.get("PRODUCT_NO") + "','"
                        + salesList.get(i).get("SALES_MODE_NO") + "'," + paramMap.get("SALE" + salesList.get(i).get("SALES_MODE_NO")) + "," + "SYSDATE(),'" + paramMap.get("CREATED_BY") + "'," + "1,'"
                        + paramMap.get("CPNY_ID") + "');";
                }
            }
            // -------------------------------------------------这里的注释千万不要删---------------------------------------------------------//
            // 判断更新物品几个仓库更新，先删除原有记录，再插入新纪录
            /*
             * for (int i = 0; i < storageList.size(); i++) { if
             * (paramMap.get("STOR" + storageList.get(i).get("STORAGENO")) !=
             * null && !"".equals(paramMap.get("STOR" +
             * storageList.get(i).get("STORAGENO")))) { storageSql = storageSql
             * +
             * "DELETE FROM PROSTOR_STORAGE_PRODUCT PSP WHERE PSP.PRODUCT_NO='"
             * + paramMap.get("PRODUCT_NO") + "'" + " AND PSP.STORAGE_NO = '" +
             * storageList.get(i).get("STORAGENO") + "'" +
             * " AND PSP.ACTIVITY = 1" +
             * " AND PSP.CPNY_ID = '"+paramMap.get("CPNY_ID")+"';"+
             * "INSERT INTO PROSTOR_STORAGE_PRODUCT(STORAGE_NO,PRODUCT_NO,LEFT_QUANTITY,QUANTITY_UNIT_CODE,CREATE_DATE,CREATED_BY,ACTIVITY,CPNY_ID)"
             * + "VALUES('" + storageList.get(i).get("STORAGENO") + "','" +
             * paramMap.get("PRODUCT_NO") + "'," + paramMap.get("STOR" +
             * storageList.get(i).get("STORAGENO")) + ",'" +
             * paramMap.get("UNIT_CODE_ID_IN") + "'," + "SYSDATE,'" +
             * paramMap.get("CREATED_BY") + "'," + "1,'" +
             * paramMap.get("CPNY_ID") + "');"; } else { storageSql = storageSql
             * +
             * "DELETE FROM PROSTOR_STORAGE_PRODUCT PSP WHERE PSP.PRODUCT_NO='"
             * + paramMap.get("PRODUCT_NO") + "'" + " AND PSP.STORAGE_NO = '" +
             * storageList.get(i).get("STORAGENO") + "'" +
             * " AND PSP.ACTIVITY = 1"+
             * " AND PSP.CPNY_ID = '"+paramMap.get("CPNY_ID")+"';"; }
             * if((paramMap.get("MIN" + storageList.get(i).get("STORAGENO")) !=
             * null && !"".equals(paramMap.get("MIN" +
             * storageList.get(i).get("STORAGENO"))))|| (paramMap.get("MAX" +
             * storageList.get(i).get("STORAGENO")) != null &&
             * !"".equals(paramMap.get("MAX" +
             * storageList.get(i).get("STORAGENO"))))|| (paramMap.get("ADDR" +
             * storageList.get(i).get("STORAGENO")) != null &&
             * !"".equals(paramMap.get("ADDR" +
             * storageList.get(i).get("STORAGENO"))))){ storageSql = storageSql
             * +
             * "DELETE FROM PROSTOR_STORAGE_PRODUCT_PARAM PS WHERE PS.PRODUCT_NO = '"
             * + paramMap.get("PRODUCT_NO") + "'" + " AND PS.STORAGE_NO = '"+
             * storageList.get(i).get("STORAGENO") +"'" +
             * " AND PS.ACTIVITY = 1"+
             * " AND PS.CPNY_ID = '"+paramMap.get("CPNY_ID")+"';"+
             * "INSERT INTO PROSTOR_STORAGE_PRODUCT_PARAM(STORAGE_NO,PRODUCT_NO,MAX_QUANTITY,MIN_QUANTITY,STOR_ADDR,CREATE_DATE,CREATED_BY,ACTIVITY,CPNY_ID)"
             * + "VALUES('"+storageList.get(i).get("STORAGENO")+"','" +
             * paramMap.get("PRODUCT_NO") + "','" + paramMap.get("MAX" +
             * storageList.get(i).get("STORAGENO"))+"','" + paramMap.get("MIN" +
             * storageList.get(i).get("STORAGENO"))+"','" + paramMap.get("ADDR"
             * + storageList.get(i).get("STORAGENO")) + "',SYSDATE,'" +
             * paramMap.get("CREATED_BY") + "'," + "1,'" +
             * paramMap.get("CPNY_ID") + "');"; }else{ storageSql = storageSql +
             * "DELETE FROM PROSTOR_STORAGE_PRODUCT_PARAM PS WHERE PS.PRODUCT_NO = '"
             * + paramMap.get("PRODUCT_NO") + "'" + " AND PS.STORAGE_NO = '"+
             * storageList.get(i).get("STORAGENO") +"'" +
             * " AND PS.ACTIVITY = 1"+
             * " AND PS.CPNY_ID = '"+paramMap.get("CPNY_ID")+"';"; } }
             */

            for (int i = 0; i < propertyList.size(); i++) {
                if (paramMap.get(propertyList.get(i).get("PROPERTY_ID")) != null && !"".equals(paramMap.get(propertyList.get(i).get("PROPERTY_ID")))) {
                    propertySql = propertySql + "DELETE FROM PRODUCT_PROPERTY_DETAIL WHERE PROPERTY_ID = '" + propertyList.get(i).get("PROPERTY_ID") + "' " + "AND PRODUCT_NO = '"
                        + paramMap.get("PRODUCT_NO") + "' AND ACTIVITY = 1 " + "AND CPNY_ID = '" + paramMap.get("CPNY_ID") + "';"
                        + "INSERT INTO PRODUCT_PROPERTY_DETAIL(PROPERTY_ID,PRODUCT_NO,P_VALUE_ID,CREATE_DATE,CREATED_BY,ACTIVITY,CPNY_ID,CATEGORY_ID)" + "VALUES('"
                        + propertyList.get(i).get("PROPERTY_ID") + "','" + paramMap.get("PRODUCT_NO") + "','" + paramMap.get(propertyList.get(i).get("PROPERTY_ID")) + "'," + "SYSDATE(),'"
                        + paramMap.get("CREATED_BY") + "'," + "1,'" + paramMap.get("CPNY_ID") + "','" + paramMap.get("PRODUCT_CATEGORY_ID_IN") + "');";
                } else {
                    propertySql = propertySql + "DELETE FROM PRODUCT_PROPERTY_DETAIL WHERE PROPERTY_ID = '" + propertyList.get(i).get("PROPERTY_ID") + "' " + "AND PRODUCT_NO = '"
                        + paramMap.get("PRODUCT_NO") + "' AND ACTIVITY = 1 " + "AND CPNY_ID = '" + paramMap.get("CPNY_ID") + "';";
                }
            }

            paramMap.put("salesSql", salesSql);
            paramMap.put("storageSql", storageSql);
            paramMap.put("propertySql", propertySql);
            returnString = this.productDao.updateProduct(paramMap);

        } else {
            String productId = "";
            boolean flag = true;
            if ("1".equals(paramMap.get("PRODUCT_ID_TYPE"))) {
                productId = this.productDao.getProductIdSerial();
                LinkedHashMap map = new LinkedHashMap();
                map.put("PRODUCT_ID_IN", productId);
                map.put("CPNY_ID", admin.getCpnyId());
                if (this.productDao.checkProductId(map) > 0) {
                    flag = false;
                    returnString = "操作失败，可能是内部编码冲突，请重试！！";
                } else {
                    paramMap.put("PRODUCT_ID_IN", productId);
                }
            } else if ("2".equals(paramMap.get("PRODUCT_ID_TYPE"))) {
                if (this.checkProductId(request) > 0) {
                    flag = false;
                    returnString = "该商品编号已存在，请重新输入！！";
                }
            }

            if (flag) {
                String salesSql = "";
                String storageSql = "";
                String propertySql = "";

                // 判断新增物品选了几种销售方式，并对每一个输了正确数据的销售方式进行保存
                for (int i = 0; i < salesList.size(); i++) {

                  /*  if (paramMap.get("SALE" + salesList.get(i).get("SALES_MODE_NO")) != null && !"".equals(paramMap.get("SALE" + salesList.get(i).get("SALES_MODE_NO")))) {
                        salesSql = salesSql + "INSERT INTO PROSTOR_PRODUCT_SALES_MODEL(PRODUCT_NO,SALES_MODE_NO,PRICE,CREATE_DATE,CREATED_BY,ACTIVITY,CPNY_ID)"
                            + "VALUES(''||PROSTOR_PRODUCT_SEQ.CURRVAL,'" + salesList.get(i).get("SALES_MODE_NO") + "'," + paramMap.get("SALE" + salesList.get(i).get("SALES_MODE_NO")) + ","
                            + "SYSDATE(),'" + paramMap.get("CREATED_BY") + "'," + "1,'" + paramMap.get("CPNY_ID") + "');";*/
                        
                        if (paramMap.get("SALE" + salesList.get(i).get("SALES_MODE_NO")) != null && !"".equals(paramMap.get("SALE" + salesList.get(i).get("SALES_MODE_NO")))) {
                            salesSql = salesSql + "INSERT INTO PROSTOR_PRODUCT_SALES_MODEL(SALES_MODE_NO,PRICE,CREATE_DATE,CREATED_BY,ACTIVITY,CPNY_ID)"
                                + "VALUES('"+salesList.get(i).get("SALES_MODE_NO") + "'," + paramMap.get("SALE" + salesList.get(i).get("SALES_MODE_NO")) + ","
                                + "SYSDATE(),'" + paramMap.get("CREATED_BY") + "'," + "1,'" + paramMap.get("CPNY_ID") + "');";
                    }
                }

                // 判断新增物品选了几个仓库入库，并对每个正确数据格式的仓库进行保存
                for (int i = 0; i < storageList.size(); i++) {
                    if (paramMap.get("STOR" + storageList.get(i).get("STORAGENO")) != null && !"".equals(paramMap.get("STOR" + storageList.get(i).get("STORAGENO")))) {
                        storageSql = storageSql + "INSERT INTO PROSTOR_STORAGE_PRODUCT(STORAGE_NO,LEFT_QUANTITY,QUANTITY_UNIT_CODE,CREATE_DATE,CREATED_BY,ACTIVITY,CPNY_ID)" + "VALUES('"
                            + storageList.get(i).get("STORAGENO") + "'," + paramMap.get("STOR" + storageList.get(i).get("STORAGENO")) + ",'"
                            + paramMap.get("UNIT_CODE_ID_IN") + "'," + "SYSDATE(),'" + paramMap.get("CREATED_BY") + "'," + "1,'" + paramMap.get("CPNY_ID") + "');";
                    }
                    if ((paramMap.get("MIN" + storageList.get(i).get("STORAGENO")) != null && !"".equals(paramMap.get("MIN" + storageList.get(i).get("STORAGENO"))))
                        || (paramMap.get("ADDR" + storageList.get(i).get("STORAGENO")) != null && !"".equals(paramMap.get("ADDR" + storageList.get(i).get("STORAGENO"))))) {
                        storageSql = storageSql + "INSERT INTO PROSTOR_STORAGE_PRODUCT_PARAM(STORAGE_NO,MIN_QUANTITY,STOR_ADDR,CREATE_DATE,CREATED_BY,ACTIVITY,CPNY_ID)" + "VALUES('"
                            + storageList.get(i).get("STORAGENO") + "','"  + paramMap.get("MIN" + storageList.get(i).get("STORAGENO")) + "','"
                            + paramMap.get("ADDR" + storageList.get(i).get("STORAGENO")) + "',SYSDATE(),'" + paramMap.get("CREATED_BY") + "'," + "1,'" + paramMap.get("CPNY_ID") + "');";
                    }
                }

                // 判断分类
                for (int i = 0; i < propertyList.size(); i++) {
                    if (paramMap.get(propertyList.get(i).get("PROPERTY_ID")) != null && !"".equals(paramMap.get(propertyList.get(i).get("PROPERTY_ID")))) {
                        propertySql = propertySql + "INSERT INTO PRODUCT_PROPERTY_DETAIL(PROPERTY_ID,P_VALUE_ID,CREATE_DATE,CREATED_BY,ACTIVITY,CPNY_ID,CATEGORY_ID)" + "VALUES('"
                            + propertyList.get(i).get("PROPERTY_ID") + paramMap.get(propertyList.get(i).get("PROPERTY_ID")) + "'," + "SYSDATE(),'"
                            + paramMap.get("CREATED_BY") + "'," + "1,'" + paramMap.get("CPNY_ID") + "','" + paramMap.get("PRODUCT_CATEGORY_ID_IN") + "');";
                    }
                }

                paramMap.put("salesSql", salesSql);
                paramMap.put("storageSql", storageSql);
                paramMap.put("propertySql", propertySql);

                returnString = this.productDao.addProduct(paramMap);
            }
        }
        return returnString;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getProColumns(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return this.productDao.getProColumns(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public int checkProductId(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        paramMap.put("CPNY_ID", admin.getCpnyId());
        return this.productDao.checkProductId(paramMap);
    }

    @Override
    public String deleteProduct(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("UPDATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());

        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> delList = ObjectBindUtil.getRequestJsonData(jsonString, appendMap);

        for (int i = 0; i < delList.size(); i++) {
            String photoName = delList.get(i).get("PRODUCT_ID").toString();
            String photoPath = request.getSession().getServletContext().getRealPath("/resources/picture/product") + "/" + photoName + ".jpg";
            File file = new File(photoPath);
            if (file.exists()) {
                file.delete();
            }
        }
        return this.productDao.deleteProduct(delList);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getProductSymple(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        if (paramMap.get("SUPPLIER_NO") == null || "null".equals(paramMap.get("SUPPLIER_NO"))) {
            paramMap.put("SUPPLIER_NO", "");
        }
        if (paramMap.get("PURCHASE_ORDER_ID") == null || "null".equals(paramMap.get("PURCHASE_ORDER_ID"))) {
            paramMap.put("PURCHASE_ORDER_ID", "");
        }
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.productDao.getProductSymple(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getProductByOrder(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("SUPPLIER_NO") == null || "null".equals(paramMap.get("SUPPLIER_NO"))) {
            paramMap.put("SUPPLIER_NO", "");
        }
        if (paramMap.get("PURCHASE_ORDER_ID") == null || "null".equals(paramMap.get("PURCHASE_ORDER_ID")) || "".equals(paramMap.get("PURCHASE_ORDER_ID"))) {
            paramMap.put("PURCHASE_ORDER_ID", "");
            return this.productDao.getProductList(paramMap);
        } else {
            return this.productDao.getProductByOrder(paramMap);
        }

    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map getProStorageSaleDetail(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("STATUS", 1);

        // 获取详细信息
        List<HashMap> storList = this.productDao.getProStorageDetail(paramMap);
        List<HashMap> saleList = this.productDao.getProSaleDetail(paramMap);
        List<HashMap> p_valueList = this.productDao.getProPropertyValueDetail(paramMap);

        Map map = new HashMap<String, String>();
        map.put("storList", storList);
        map.put("saleList", saleList);
        map.put("p_valueList", p_valueList);
        return map;
    }

    // 获取商品销售详细信息拼接sql语句方法
    @SuppressWarnings({ "rawtypes" })
    public String getSaleSql(HttpServletRequest request, List<HashMap> salesList) {
        String nvl = "";
        HashMap map = null;
        for (int i = 0; i < salesList.size(); i++) {
            map = salesList.get(i);
            nvl = nvl + ",ifnull((" + "SELECT PPSM.PRICE FROM PROSTOR_PRODUCT_SALES_MODEL PPSM WHERE PPSM.PRODUCT_NO = PP.PRODUCT_NO " +
                " AND PPSM.ACTIVITY = 1" + " AND PPSM.SALES_MODE_NO = '" + map.get("SALES_MODE_NO") + "')||''" + ",'-') AS SALE" + map.get("SALES_MODE_NO");
        }
        return nvl;
    }

    // 获取商品库存详细信息拼接sql语句方法
    @SuppressWarnings({ "rawtypes" })
    public String getStorageSql(HttpServletRequest request, List<HashMap> storageList) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        String nvl2 = "";
        HashMap map2 = null;
        for (int i = 0; i < storageList.size(); i++) {
            map2 = storageList.get(i);
            nvl2 = nvl2 + ",NVL((SELECT SUM(PSP.LEFT_QUANTITY) FROM PROSTOR_STORAGE_PRODUCT PSP" + " WHERE PSP.PRODUCT_NO = PP.PRODUCT_NO" + " AND PSP.CPNY_ID ='" + admin.getCpnyId() + "'"
                + " AND PSP.ACTIVITY = 1" + " AND PSP.STORAGE_NO = '" + map2.get("STORAGENO") + "'),0) AS STOR" + map2.get("STORAGENO");

        }
        return nvl2;
    }

    // 获取商品库存详细信息拼接sql语句方法
    @SuppressWarnings({ "rawtypes" })
    public String getStorageAddrSql(HttpServletRequest request, List<HashMap> storageList) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        String nvl3 = "";
        HashMap map2 = null;
        for (int i = 0; i < storageList.size(); i++) {
            map2 = storageList.get(i);
            nvl3 = nvl3 + ",NVL((SELECT PSP.STOR_ADDR FROM PROSTOR_STORAGE_PRODUCT PSP" + " WHERE PSP.PRODUCT_NO = PP.PRODUCT_NO" + " AND PSP.CPNY_ID ='" + admin.getCpnyId() + "'"
                + " AND PSP.ACTIVITY = 1" + " AND PSP.STORAGE_NO = '" + map2.get("STORAGENO") + "'" + " AND ROWNUM = 1" + "),'null') AS ADDR" + map2.get("STORAGENO");

        }
        return nvl3;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getProStorDetailList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            return this.productDao.getProStorDetailList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            return this.productDao.getProStorDetailList(paramMap);
        }
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public int getProStorDetailListCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.productDao.getProStorDetailListCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getProSaleDetailList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            return this.productDao.getProSaleDetailList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            return this.productDao.getProSaleDetailList(paramMap);
        }
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public int getProSaleDetailListCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.productDao.getProSaleDetailListCnt(paramMap);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List<Product> getProductsBySalesMode(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getAllRequestParamData(request);
        return this.productDao.getProductsBySalesMode(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes", "unused" })
    private Map getRequestParams(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return paramMap;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public void viewProductReport(HttpServletRequest request, HttpServletResponse response) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 附加信息
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        // 页面提交的JSON信息
        // String jsonCodeString =
        // attMonthReportDao.getAttMonthColumnInfo(paramMap);
        List<String> codeList = new ArrayList<String>();
        List<String> titleList = new ArrayList<String>();

        List<LinkedHashMap<String, Object>> list = this.productDao.getProColumns(paramMap);

        for (int i = 0; i < list.size(); i++) {
            if (!"HIDE".equals(list.get(i).get("ITEM_NAME"))) {
                if (!"STATUS".equals(list.get(i).get("COLUMN_NAME")) && !"SHOWDETAIL".equals(list.get(i).get("COLUMN_NAME"))) {
                    codeList.add(list.get(i).get("COLUMN_NAME").toString());
                    titleList.add(list.get(i).get("ITEM_NAME").toString());
                }
            }
        }
        codeList.add("STATUS_NAME");
        titleList.add("启用状态");

        // 1.创建一个 workbook
        HSSFWorkbook workbook = new HSSFWorkbook();

        // 2.创建一个 worksheet
        HSSFSheet worksheet = workbook.createSheet("货物品名");

        // 3.定义起始行和列
        int startRowIndex = 0;
        int startColIndex = titleList.size();

        String title = "货物品名导出信息";
        // 4.创建title,data,headers
        Layouter.buildPublicReport(worksheet, startRowIndex, startColIndex, titleList, title);

        // 5.填充数据
        FillComputerManager.fillReport(worksheet, startRowIndex, startColIndex, getProductList(request), codeList);

        // 6.设置reponse参数
        // 进行转码，使其支持中文文件名
        String fileName = null;
        try {
            fileName = java.net.URLEncoder.encode("货物品名导出信息", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setHeader("Content-Disposition", "inline; filename=" + fileName + ".xls");
        // 确保发送的当前文本格式
        response.setContentType("application/vnd.ms-excel");

        // 7. 输出流
        Writer.write(response, worksheet);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public void downloadProductsTemp(HttpServletRequest request, HttpServletResponse response) {
        // 先取出设定了格式的Excel表，再在此表的基础上生成表头和有效性限制
        String path = request.getSession().getServletContext().getRealPath("/resources/excel/productsImport.xls");
        HSSFWorkbook workbook = null;
        try {
            InputStream input = new FileInputStream(path);
            workbook = new HSSFWorkbook(input);
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }

        HSSFSheet sheet = workbook.getSheetAt(0);
        if (sheet == null) {
            sheet = workbook.createSheet("Products Information");
        }
        // 创建并隐藏hidden sheet
        HSSFSheet hidden = workbook.getSheet("hidden");
        if (hidden == null) {
            hidden = workbook.createSheet("hidden");
        }
        workbook.setSheetHidden(workbook.getSheetIndex(hidden), true);

        int sRow = 4, eRow = 199; // 开始行数和结束行数（+1后为excel中的实际行数）

        // 生成表头和对应的数据库字段与数据类型并放在Excel表单中的相应位置
        Map tmpParamMap = new LinkedHashMap();

        // 获取必填项并载入
        tmpParamMap.put("LIKE", "#*%");
        List<HashMap> columnTitleList = this.productDao.getTitles(tmpParamMap);
        this.reorderList(columnTitleList);

        // 获取选填项并载入
        tmpParamMap.put("LIKE", "#%");
        tmpParamMap.put("UNLIKE", "#*%");
        List<HashMap> optionalColTitleList = this.productDao.getTitles(tmpParamMap);
        columnTitleList.addAll(optionalColTitleList);

        this.trimList(columnTitleList);

        // 创建Title Row
        HSSFRow row = sheet.createRow(3);
        HSSFCell cell = null;
        String strTitle = null, strColCode = null, strColType = null, strColLength = null;
        String[] options = null; // 数据有效性限制的选项
        for (int i = 0; i < columnTitleList.size(); i++) {
            strTitle = (String) columnTitleList.get(i).get("COMMENTS"); // 标题名
            strColCode = (String) columnTitleList.get(i).get("COLUMN_NAME"); // 字段名
            strColType = (String) columnTitleList.get(i).get("DATA_TYPE"); // 数据类型
           int intColLength;// 数字类型数据长度}
		try {
			intColLength = Integer.parseInt(columnTitleList.get(i)
					.get("DATA_LENGTH").toString());
		} catch (Exception e) {
			intColLength=20;
			// TODO: handle exception
		}
            
            intColLength = intColLength * 2; // 长度加倍，防止存入字符时溢出
            strColLength = String.valueOf(intColLength); // 数据长度
            if (!strColType.equalsIgnoreCase("DATE") && !strColType.equalsIgnoreCase("NUMBER")) {
                strColType = strColType + "(" + strColLength + ")";
            }
            HSSFRow hiddenRow = hidden.getRow(i);
            if (hiddenRow == null) {
                hiddenRow = hidden.createRow(i);
            }
            cell = row.createCell(i);
            cell.setCellValue(strTitle);
            cell = hiddenRow.createCell(0);
            cell.setCellValue(strColCode);
            cell = hiddenRow.createCell(1);
            cell.setCellValue(strColType);

            // 设定tableName列和parentCode列
            String tableName = null;
            String parentCode = null;
            String columnName = null;
            String columnCode = null;
            if (strColCode.equals("PRODUCT_CATEGORY_ID")) {
                tableName = "SY_CATEGORY";
                columnName = "CATEGORY_NAME";
                columnCode = "CATEGORY_ID";
                parentCode = null;
            } else{
                tableName = "SY_CODE";
                columnName = "CODE_NAME";
                columnCode = "CODE_ID";
                if (strColCode.equals("UNIT_CODE_ID")) {
                    parentCode = "ProductUnit";
                }else {
                    parentCode = this.capitalize(strColCode);
                }
            }

            // 设定字段显示的顺序(ORDERNO)
            cell = hiddenRow.createCell(6);
            cell.setCellValue(String.valueOf(i));

            // 查询出数字有效性的选项，设置hidden表的数据
            Map optionParamMap = new LinkedHashMap();
            optionParamMap.put("PARENT_CODE", parentCode);
            optionParamMap.put("TABLE_NAME", tableName);
            optionParamMap.put("COLUMN_NAME", columnName);
            options = this.productDao.getOptions(optionParamMap);
            if (options == null) { // 说明此字段不是code，标记parent_code和table_name为-1，直接写入表中。
                cell = hiddenRow.createCell(2);// parentCode
                cell.setCellValue("-1");
                cell = hiddenRow.createCell(3);// tableName
                cell.setCellValue("-1");
                cell = hiddenRow.createCell(4);// columnCode
                cell.setCellValue("-1");
                cell = hiddenRow.createCell(5);// columnName
                cell.setCellValue("-1");
                continue;
            } else {
                cell = hiddenRow.createCell(2);// parentCode
                if (parentCode == null)
                    parentCode = "-1";
                cell.setCellValue(parentCode);
                cell = hiddenRow.createCell(3);// tableName
                cell.setCellValue(tableName);
                cell = hiddenRow.createCell(4);// columnCode
                cell.setCellValue(columnCode);
                cell = hiddenRow.createCell(5);// columnName
                cell.setCellValue(columnName);
            }
            // 设置数据有效性
            sheet.addValidationData(constraintValidation(options, sRow, eRow, i, i));
        }

        // 将生成的Excel表格输出
        String fileName = null;
        try {
            fileName = java.net.URLEncoder.encode("货品信息导入", "UTF-8");
        } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
        }
        response.setHeader("Content-Disposition", "inline; filename=" + fileName + ".xls");
        response.setContentType("application/vnd.ms-excel");
        try {
            ServletOutputStream outputStream = response.getOutputStream();
            workbook.write(outputStream);
            outputStream.flush();
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
    }

    /**
     * 将list内的元素重新排序
     * @param list
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public void reorderList(List<HashMap> list) {
        if (list == null || list.size() == 0)
            return;
        if (list.get(0).get("COMMENTS").toString().startsWith("#*")) {
            HashMap empidMap = null;
            HashMap chineseMap = null;
            for (int i = 0; i < list.size(); i++) {
                HashMap tmpMap = list.get(i);
                if (tmpMap.get("COLUMN_NAME").toString().equals("PRODUCT_ID")) {
                    empidMap = new HashMap(tmpMap);
                    list.remove(i);
                    i--;
                } else if (tmpMap.get("COLUMN_NAME").toString().equals("PRODUCT_NAME")) {
                    chineseMap = new HashMap(tmpMap);
                    list.remove(i);
                    i--;
                } else {
                    continue;
                }
            }
            if (empidMap != null) {
                list.add(0, empidMap);
            }
            if (chineseMap != null) {
                list.add(1, chineseMap);
            }
        }
    }

    /**
     * 将COMMENTS的#符号去掉
     * @param list
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public void trimList(List<HashMap> list) {
        if (list == null || list.size() == 0)
            return;
        if (list.get(0).get("COMMENTS") == null)
            return;
        if (list.get(0).get("COMMENTS").toString().startsWith("#")) {
            for (int i = 0; i < list.size(); i++) {
                HashMap tmpMap = list.get(i);
                String comments = tmpMap.get("COMMENTS").toString();
                comments = comments.substring(comments.indexOf("#") + 1);
                tmpMap.put("COMMENTS", comments);
                list.remove(i);
                list.add(i, tmpMap);
            }
        }
    }

    /**
     * 将"XXX_ID"转为"prefix_XXX_suffix"
     */
    public String trimIDString(String string, String prefix, String suffix) {
        String resultStr = prefix + string.substring(0, string.lastIndexOf("_ID")) + suffix;
        return resultStr;
    }


    /**
     * 为startRow 至 endRow, startColumn 至 endColumn 中间的区域设置数据有效性限制， 限制的选项为option,
     * 存储在hidden里的columnNum列.
     */
    @SuppressWarnings("deprecation")
    public HSSFDataValidation largeOptionValidation(HSSFSheet hidden, String[] options, int columnNum, int startRow, int endRow, int startColumn, int endColumn) {
        for (int i = 0, length = options.length; i < length; i++) {
            HSSFRow row = hidden.getRow(i);
            if (row == null) {
                row = hidden.createRow(i);
            }
            String cellValue = options[i];
            row.createCell(columnNum - 1).setCellValue(cellValue);
        }
        // 要加入检验columnNum是不是大于26的，如果是，还要进行改变。
        String columnName = String.valueOf((char) (columnNum + 64));
        DVConstraint constraint = DVConstraint.createFormulaListConstraint("hidden!" + columnName + "1:" + columnName + options.length);
        CellRangeAddressList regions = new CellRangeAddressList(startRow, endRow, startColumn, endColumn);
        return new HSSFDataValidation(regions, constraint);
    }

    @SuppressWarnings("deprecation")
    public HSSFDataValidation constraintValidation(String[] options, int startRow, int endRow, int startColumn, int endColumn) {
        DVConstraint constraint = DVConstraint.createExplicitListConstraint(options);
        CellRangeAddressList regions = new CellRangeAddressList(startRow, endRow, startColumn, endColumn);
        return new HSSFDataValidation(regions, constraint);
    }

    /**
     * 将"XXX_YYY"格式字符串转化为"XxxYyy"格式
     */
    public String capitalize(String str) {
        String result = "";
        String[] subStr = str.split("_");
        for (int i = 0; i < subStr.length; i++) {
            result = result + StringUtils.capitalize(subStr[i].toLowerCase());
        }
        return result;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String uploadProInfoTemplate(MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws Exception {
        List paramList = new ArrayList();
        // 解析 Excel
        HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
        HSSFSheet sheet = workbook.getSheetAt(0);
        HSSFRow row = sheet.getRow(3);
        Map map = new LinkedHashMap();
        

        // 取出Excel的表头信息,创建表TEMP_PRODUCT_INFO和表TEMP_PRODUCT_TITLES
        HSSFSheet hidden = workbook.getSheet("hidden");
        if (hidden == null)
            return "无效表格！";

        Map columnsTitleMap = this.getColumnsTitle(hidden);
        String titleString = (String) columnsTitleMap.get("title");
        List titleCodeList = (List) columnsTitleMap.get("titleCode");
        List dataTypeList = (List) columnsTitleMap.get("dataType");
        map.put("TITLES", titleString);
        this.productDao.createTmpProductInfo(map);

        // 取出Excel里的title有关的信息，放入TEMP_PRODUCT_TITLES表中
        List titleList = this.getTitlesInfo(row, hidden);
        this.productDao.updateTmpProductTitles(titleList);

        // 取出Excel里的内容
        int i = 3;
        while (true) {
            i++;
            row = sheet.getRow(i);
            map = this.getRowInfo(row, titleCodeList, dataTypeList);
            if (map == null)
                break;
            paramList.add(map);
        }

        // 将Excel里的内容放入临时表TEMP_PRODUCT_INFO
        this.productDao.updateTmpProductInfo(paramList);
        return "Y";
    }

    /**
     * 取出Excel两列的数据拼接成字符串，并取出两列的长度 
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private Map getColumnsTitle(HSSFSheet sheet) {
        Map result = new LinkedHashMap();
        List titleCodeList = new ArrayList();
        List dataTypeList = new ArrayList();
        String columnsTitle = "";
        String tmpStr = "";
        int i = 0, j = 0;
        while (true) {
            HSSFRow row = sheet.getRow(i);
            if (row == null)
                break;
            HSSFCell cell = row.getCell(j);
            if (cell == null)
                break;
            tmpStr = cell.getStringCellValue();
            titleCodeList.add(tmpStr);
            columnsTitle = columnsTitle + tmpStr + " ";
            cell = row.getCell(j + 1);
            tmpStr = cell.getStringCellValue();
            dataTypeList.add(tmpStr);
            columnsTitle = columnsTitle + tmpStr + ",";
            i++;
        }
        columnsTitle = columnsTitle.substring(0, columnsTitle.lastIndexOf(","));
        result.put("title", columnsTitle);
        result.put("length", i);
        result.put("titleCode", titleCodeList);
        result.put("dataType", dataTypeList);
        return result;
    }

    /**
     * 从Excel中取出表头的code、name和data type等信息
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    List getTitlesInfo(HSSFRow titleRow, HSSFSheet hidden) {
        List result = new ArrayList();
        HSSFRow row = null;
        int i = 0;
        String cellValue = "";
        while (true) {
            Map map = new LinkedHashMap();
            row = hidden.getRow(i);
            if (row == null || row.getCell(0) == null)
                break;
            cellValue = titleRow.getCell(i).getStringCellValue();
            map.put("TITLE_NAME", cellValue);
            cellValue = row.getCell(0).getStringCellValue();
            map.put("TITLE_CODE", cellValue);
            cellValue = row.getCell(1).getStringCellValue();
            map.put("DATA_TYPE", cellValue);
            cellValue = row.getCell(2).getStringCellValue();
            map.put("PARENT_CODE", cellValue);
            cellValue = row.getCell(3).getStringCellValue();
            map.put("TABLE_NAME", cellValue);
            cellValue = row.getCell(4).getStringCellValue();
            map.put("COLUMN_CODE", cellValue);
            cellValue = row.getCell(5).getStringCellValue();
            map.put("COLUMN_NAME", cellValue);
            cellValue = row.getCell(6).getStringCellValue();
            map.put("ORDERNO", cellValue);
            result.add(map);
            i++;
        }
        return result;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    public Map getRowInfo(HSSFRow row, List titleCodeList, List dataTypeList) throws ParseException {
        if (row == null)
            return null;
        String valuesStr = "", titlesStr = "";
        HSSFCell cell = row.getCell(0);
        if (cell == null)
            return null;
        String cellValue = cell.getStringCellValue(); // product_Id
        if (cellValue == null || cellValue == "")
            return null;
        Map map = new LinkedHashMap();
        map.put("PRODUCT_ID", cellValue);
        
        valuesStr = "'" + cellValue + "'";
        titlesStr = (String) titleCodeList.get(0);
        // 增加对于数据格式的判断（需要先在生成模板时加上去）
        for (int i = 1; i < titleCodeList.size(); i++) {
            cell = row.getCell(i);
            if (cell == null) {
                continue;
            }
            if (((String) dataTypeList.get(i)).equals("DATE")) { // 判断日期并解析
                String dateValue = this.parseDate2String(cell);
                if (dateValue != null) {
                    // map.put(titleCodeList.get(i), dateValue);
                    valuesStr = valuesStr + ", to_date(''" + dateValue + "'',''yyyy-MM-dd'') ";
                    titlesStr = titlesStr + "," + (String) titleCodeList.get(i);
                }
            } else {
                int cellType = cell.getCellType();
                if (cellType == Cell.CELL_TYPE_STRING) {
                    if (cell.getStringCellValue().equals("")) {
                        cellValue = "";
                    } else {
                        cellValue = cell.getStringCellValue();
                        valuesStr = valuesStr + ",'" + cellValue + "'";
                        titlesStr = titlesStr + "," + (String) titleCodeList.get(i);
                    }
                } else if (cellType == Cell.CELL_TYPE_NUMERIC) {
                    cellValue = String.valueOf(cell.getNumericCellValue());
                    valuesStr = valuesStr + ",'" + cellValue + "'";
                    titlesStr = titlesStr + "," + (String) titleCodeList.get(i);
                }
                // map.put(titleCodeList.get(i), cellValue);
            }
        }
        map.put("VALUESSTR", valuesStr);
        map.put("TITLESSTR", titlesStr);
        return map;
    }

    public String parseDate2String(HSSFCell cell) throws ParseException {
        Date dateValue = null;
        String stringValue = null;
        int cellType = cell.getCellType();
        if (cellType == Cell.CELL_TYPE_STRING) {
            String cellValue = cell.getStringCellValue();
            if (cellValue != null && cellValue != "") {
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                dateValue = format.parse(cellValue);
                if (dateValue != null) { // cellValue符合"yyyy-MM-dd"格式
                    return cellValue;
                } else {
                    return null;
                }
            } else {
                return null;
            }
        } else {
            dateValue = cell.getDateCellValue();
            if (dateValue != null) {
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                stringValue = format.format(dateValue);
                return stringValue;
            } else
                return null;
        }
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getProColumnList() throws Exception {
        return this.productDao.getProColumnList();
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getProTmpInfoList() throws Exception {
        return this.productDao.getProTmpInfoList();
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String saveProTmpInfo(HttpServletRequest request) throws Exception {
        String resultStr = "Y";
        // 修改临时表的内容，将内容转为code
        this.productDao.modifyProTmpTable();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = new LinkedHashMap();
        paramMap.put("ADMIN_ID", admin.getAdminID());

        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("CREATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());

        List insertList = this.productDao.getProInsertList(paramMap);
        if(insertList.size()==0){
            return resultStr = "没有新增的货品信息";
        }
        this.productDao.insertPro(ObjectBindUtil.getRequestListData(insertList, appendMap));
        return resultStr;
    }
}
