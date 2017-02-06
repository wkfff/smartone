package com.siping.mobile.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.mobile.dao.MobileManageDao;
import com.siping.mobile.service.MobileManageSer;
import com.siping.productStorage.dao.ProductDao;
import com.siping.productStorage.dao.ProductStorageManageDao;
import com.siping.productStorage.dao.SalesModelDao;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class MobileManageSerImpl implements MobileManageSer {
    Logger logger = Logger.getLogger(MobileManageSerImpl.class);
    @Autowired
    private MobileManageDao mobileManageDao;
    @Autowired
    private SalesModelDao salesModelDao;
    @Autowired
    private ProductDao productDao;
    @Autowired
    private ProductStorageManageDao productStorageManageDao;
    
    /**
     * 获取移动端商品专区
     * @param request
     * @return
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    @Override
    public List getMobileAreaList(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            return this.mobileManageDao.getMobileAreaList(paramMap, NumberUtils.parseNumber(
                    ObjectUtils.toString(paramMap.get("page")), Integer.class), NumberUtils.parseNumber(
                    ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            return this.mobileManageDao.getMobileAreaList(paramMap);
        }
    }

    /**
     * 获取移动端商品专区条目
     * @param request
     * @return
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    @Override
    public int getMobileAreaListCnt(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        return this.mobileManageDao.getMobileAreaListCnt(paramMap);
    }
    
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String deleteMobileArea(HttpServletRequest request) {
        String result = "Y";
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
            
        this.mobileManageDao.deleteMobileArea(paramMap);
        
        return result;
    }
    
    @Override
    public String saveOrUpdateMobileArea(HttpServletRequest request) {
        String returnString = "Y";
        // session用户信息
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        // 页面提交数据
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("CREATED_BY", admin.getAdminID());
        appendMap.put("UPDATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());
        
        String jsonString = request.getParameter("jsonData");

        List<LinkedHashMap<String, Object>> list = ObjectBindUtil
                .getRequestJsonData(jsonString, appendMap);

        List<LinkedHashMap<String, Object>> insertList = new ArrayList<LinkedHashMap<String,Object>>();
        List<LinkedHashMap<String, Object>> updateList = new ArrayList<LinkedHashMap<String,Object>>();
        for(int i=0;i<list.size();i++){
            if(list.get(i).get("M_AREA_NO")!=null && !"".equals(list.get(i).get("M_AREA_NO"))){
                updateList.add(list.get(i));
            }else{
                insertList.add(list.get(i));
            }
        }
        
        returnString =this.mobileManageDao.addMobileAreaInfo(insertList);
        returnString =this.mobileManageDao.updateMobileAreaInfo(updateList);

        return returnString;
    }
    
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String saveProductToArea(HttpServletRequest request) {
        String returnString = "Y";
        // session用户信息
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        // 页面提交数据
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("CREATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());
        appendMap.put("M_AREA_NO", paramMap.get("M_AREA_NO"));
        
        String jsonString = request.getParameter("jsonData");

        List<LinkedHashMap<String, Object>> list = ObjectBindUtil
                .getRequestJsonData(jsonString, appendMap);
        
        
        
        
        returnString =this.mobileManageDao.deleteProductByArea(paramMap);
        returnString =this.mobileManageDao.saveProductToArea(list);

        return returnString;
    }
    
    @SuppressWarnings({"rawtypes", "unchecked"})
    @Override
    public List getMobileAdv(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        return this.mobileManageDao.getMobileAdv(paramMap);
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    @Override
    public int getMobileAdvCnt(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        return this.mobileManageDao.getMobileAdvCnt(paramMap);
    }
    
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String addOrUpdateMobileAdv(HttpServletRequest request) {
        String returnString = "Y";
        // session用户信息
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        
        returnString =this.mobileManageDao.addOrUpdateMobileAdv(paramMap);
        return returnString;
    }
    
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String deleteMobileAdv(HttpServletRequest request) {
        String returnString = "Y";
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        
        String photoName = request.getParameter("PHOTOPATH");
        String photoPath = request.getSession().getServletContext()
                .getRealPath("/resources/picture/mobileAdv")
                + "/" + photoName;
        
        File file = new File(photoPath);
        
        if(file.exists()){
            file.delete();
        }
        
        returnString =this.mobileManageDao.deleteMobileAdv(paramMap);
        return returnString;
    }
    
    //遍历出根类别所有子类别
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public void getAllSonNode(List<HashMap> list,List reList,String pid){
        HashMap map;
        for(int i=0;i<list.size();i++){
            if(pid!=null && pid.equals(list.get(i).get("PARENT_ID"))){
                map = list.get(i);
                reList.add(map);
                getAllSonNode(list,reList,map.get("CATEGORY_ID").toString());
            }
        }
    }

    //将根类下所有子类抽取为同级类于移动端显示
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public void setSonNodes(List<HashMap> list, List<HashMap> reList) {
        HashMap map;
        List<HashMap> sonList;
        for(int i=0;i<list.size();i++){
            if(list.get(i).get("PARENT_ID").equals("CATEGORY")){
                map = list.get(i);
                //递归遍历出该根类别下所有子孙类别
                sonList = new ArrayList<HashMap>();
                this.getAllSonNode(list,sonList,map.get("CATEGORY_ID").toString());
                map.put("sonList", sonList);
                reList.add(map);
            }
        }
    }
    
    //设置商品移动端显示价格的方法
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public void setSalePrice(List<HashMap> list, HashMap saleMode) {
        for(int i=0;i<list.size();i++){
            if(saleMode.get("SALES_MODE_NO")!=null && !"".equals(saleMode.get("SALES_MODE_NO"))){
                list.get(i).put("salePrice", list.get(i).get("SALE"+saleMode.get("SALES_MODE_NO")));
            }else{
                list.get(i).put("salePrice", "-");
            }
        }
    }
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getSalesModelList(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("keyWord", "");
        paramMap.put("STATUS", 1);
        paramMap.put("MOBILE_STATUS", 1);
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            return this.salesModelDao.getSalesModelList(paramMap,NumberUtils.parseNumber(
                    ObjectUtils.toString(paramMap.get("page")),Integer.class), NumberUtils.parseNumber(
                    ObjectUtils.toString(paramMap.get("pagesize")),Integer.class));
        }else{
            return this.salesModelDao.getSalesModelList(paramMap);
        }
    }

    /**
     * 添加商品到购物车
     * @param request
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public int addToCart(HttpServletRequest request) {
        boolean flag = true;
        List<Map> cartProList = (List<Map>) request.getSession().getAttribute("cartProList");
        if(cartProList == null){
            cartProList = new ArrayList<Map>();
        }

        String saleJson = request.getParameter("PRODUCT");
        String jsonData = saleJson.replace("{", "{\"").replace("}", "\"}").replace("=", "\":\"").replace(",", "\",\"").replace("null", "")
            .replace("\" ", "\"").replace(" \"", "\"");
        List<LinkedHashMap<String, Object>> saleList = ObjectBindUtil
            .getRequestJsonData("["+jsonData+"]");

        if (saleList.size()>0) {
            saleList.get(0).put("QUANTITY", request.getParameter("QUANTITY"));
            for (int i = 0; i < cartProList.size() && flag; i++) {
                if (cartProList.get(i).get("PRODUCT_NO").equals(saleList.get(0).get("PRODUCT_NO"))) {
                    cartProList.get(i).put("QUANTITY", Integer.valueOf(cartProList.get(i).get("QUANTITY").toString()) + Integer.valueOf(saleList.get(0).get("QUANTITY").toString()));
                    flag = false;
                }
            }
            if (flag) {
                cartProList.add(saleList.get(0));
            }
        }
        request.getSession().setAttribute("cartProList", cartProList);
        return cartProList.size();
    }
    
    /**
     * 从购物车移除商品
     * @param request
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String deleteFromCart(HttpServletRequest request) {
        String result = "Y";
        List<Map> cartProList = (List<Map>) request.getSession().getAttribute("cartProList");
        if(cartProList == null){
            cartProList = new ArrayList<Map>();
        }
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        for(int i=0;i<cartProList.size();i++){
            if(cartProList.get(i).get("PRODUCT_NO").equals(paramMap.get("PRODUCT_NO"))){
                cartProList.remove(i);
                break;
            }
        }
        request.getSession().setAttribute("cartProList", cartProList);
        return result;
    }
    
    /**
     * 清空购物车
     * @param request
     * @return
     */
    public void clearCart(HttpServletRequest request) {
        request.getSession().removeAttribute("cartProList");
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getProductListBySalesOrder(HttpServletRequest request,String salesOrderNo) {
        List list = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID",admin.getCpnyId());
        paramMap.put("SALES_ORDER_NO", salesOrderNo);

        list = this.productStorageManageDao.getSalesOrderDetail(paramMap,1,999);
        return list;
    }

    @Override
    public String getSalesModeNoByCu(String cid) {
        return this.mobileManageDao.getSalesModeNoByCu(cid);
    }
}
