package com.siping.productStorage.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.cust.bean.Address;
import com.siping.cust.bean.Customer;
import com.siping.cust.bean.Receiver;
import com.siping.productStorage.bean.Employee;
import com.siping.productStorage.bean.Price;
import com.siping.productStorage.bean.Product;
import com.siping.productStorage.bean.SalesMode;
import com.siping.productStorage.bean.SalesOrder;
import com.siping.productStorage.bean.Unit;
import com.siping.productStorage.dao.ProductDao;
import com.siping.productStorage.dao.ProductSaleDao;
import com.siping.productStorage.dao.TaoBaoManageDao;
import com.siping.productStorage.service.TaoBaoManageSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.taobao.api.ApiException;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.domain.AddressResult;
import com.taobao.api.domain.Item;
import com.taobao.api.domain.ItemCat;
import com.taobao.api.domain.LogisticsCompany;
import com.taobao.api.domain.Order;
import com.taobao.api.domain.Shop;
import com.taobao.api.domain.Trade;
import com.taobao.api.domain.User;
import com.taobao.api.request.ItemDeleteRequest;
import com.taobao.api.request.ItemUpdateRequest;
import com.taobao.api.request.ItemcatsGetRequest;
import com.taobao.api.request.ItemsOnsaleGetRequest;
import com.taobao.api.request.LogisticsAddressSearchRequest;
import com.taobao.api.request.LogisticsCompaniesGetRequest;
import com.taobao.api.request.LogisticsConsignOrderCreateandsendRequest;
import com.taobao.api.request.ShopGetRequest;
import com.taobao.api.request.TradeFullinfoGetRequest;
import com.taobao.api.request.TradesSoldGetRequest;
import com.taobao.api.request.UserSellerGetRequest;
import com.taobao.api.response.ItemDeleteResponse;
import com.taobao.api.response.ItemUpdateResponse;
import com.taobao.api.response.ItemcatsGetResponse;
import com.taobao.api.response.ItemsOnsaleGetResponse;
import com.taobao.api.response.LogisticsAddressSearchResponse;
import com.taobao.api.response.LogisticsCompaniesGetResponse;
import com.taobao.api.response.LogisticsConsignOrderCreateandsendResponse;
import com.taobao.api.response.ShopGetResponse;
import com.taobao.api.response.TradeFullinfoGetResponse;
import com.taobao.api.response.TradesSoldGetResponse;
import com.taobao.api.response.UserSellerGetResponse;

@Service
public class TaoBaoManageSerImpl implements TaoBaoManageSer {
    Logger logger = Logger.getLogger(TaoBaoManageSerImpl.class);
    
    protected static String url = "http://gw.api.tbsandbox.com/router/rest";//沙箱环境调用地址 
    protected static String appkey = "1021733955"; 
    protected static String appSecret = "sandbox5e2459fa765d06f7d2b1daca2";
    private TaobaoClient client = new DefaultTaobaoClient(url, appkey, appSecret);//实例化TopClient类 ;
    @Autowired
    private ProductDao productDao;
    @Autowired
    private TaoBaoManageDao taoBaoManageDao;
    @Autowired
    private ProductSaleDao productSaleDao;
    
    /**
     * 查询授权码与用户nick是否一致，类似于登录
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @Override
    public User getSellerBySessionKey(HttpServletRequest request) {
        User seller = new User();
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        String sessionKey = String.valueOf(paramMap.get("sessionKey"));

        UserSellerGetRequest userSellerGetRequest = new UserSellerGetRequest();
        userSellerGetRequest.setFields("user_id,nick,sex,seller_credit,type,has_more_pic,item_img_num,item_img_size,prop_img_num,"
            + "prop_img_size,auto_repost,promoted_type,status,alipay_bind,consumer_protection,avatar,liangpin,sign_food_seller_promise,"
            + "has_shop,is_lightning_consignment,has_sub_stock,is_golden_seller,vip_info,magazine_subscribe,vertical_market,online_gaming");
        UserSellerGetResponse userSellerGetResponse;
        try { 
            userSellerGetResponse = client.execute(userSellerGetRequest, sessionKey);
            seller = userSellerGetResponse.getUser();
        } catch (ApiException e) { 
        } 
        return seller;
    }
    
    /**
     * 通过账户nick获取该账户下店铺信息
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @Override
    public Shop getShopByNick(HttpServletRequest request) {
        Shop shop = new Shop();
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        String sessionKey = String.valueOf(paramMap.get("sessionKey"));
        String nick = String.valueOf(paramMap.get("nick"));
        
        ShopGetRequest shopGetRequest = new ShopGetRequest();
        shopGetRequest.setFields("all_count,bulletin,cid,created,desc,modified,nick,pic_path,remainCount,shop_score,sid,title");
        shopGetRequest.setNick(nick);
        ShopGetResponse shopGetResponse;
        
        try { 
            shopGetResponse = client.execute(shopGetRequest, sessionKey);
            shop = shopGetResponse.getShop();
        } catch (ApiException e) { 
        } 
        return shop;
    }

    /**
     * 查询出账户店铺下正在销售的商品信息
     * @param request
     * @return
     * @throws Exception
     */
    @Override
    public List<Item> getTaoBaoProOnSale(HttpServletRequest request) {
        List<Item> list = new ArrayList<Item>();
        String sessionKey = (String) request.getSession().getAttribute("sessionKey");
        
        ItemsOnsaleGetRequest itemsOnsaleGetRequest = new ItemsOnsaleGetRequest();
        itemsOnsaleGetRequest.setFields("approve_status,num_iid,title,nick,type,cid,pic_url,num,props,valid_thru,list_time,"
            + "price,has_discount,has_invoice,has_warranty,has_showcase,modified,delist_time,postage_id,seller_cids,outer_id");
        ItemsOnsaleGetResponse itemsOnsaleGetResponse;

        try { 
            itemsOnsaleGetResponse = client.execute(itemsOnsaleGetRequest, sessionKey);
            list = itemsOnsaleGetResponse.getItems();
        } catch (ApiException e) {
        }
        return list;
    }
    
    /**
     * 查询商品类别
     * @param request
     * @return
     * @throws Exception
     */
    @Override
    public List<ItemCat> getTaoBaoCatById(HttpServletRequest request,String cid) {
        List<ItemCat> itemCatList = new ArrayList<ItemCat>();
        String sessionKey = (String) request.getSession().getAttribute("sessionKey");
        
        ItemcatsGetRequest catGet = new ItemcatsGetRequest();
        ItemcatsGetResponse catRes;
        catGet.setCids(cid);
        catGet.setFields("cid,parent_cid,name,is_parent");
        try { 
            catRes = client.execute(catGet, sessionKey);
            itemCatList = catRes.getItemCats();
        } catch (ApiException e) {
        }
        return itemCatList;
    }

    /**
     * 从淘宝店铺中移除商品
     * @param request
     * @return
     * @throws Exception
     */
    @Override
    public String removeProFromTaoBao(HttpServletRequest request) {
        String result = "Y";
        String sessionKey = (String) request.getSession().getAttribute("sessionKey");
        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> delList = ObjectBindUtil.getRequestJsonData(jsonString);
        
        ItemDeleteRequest itemDelete;
        ItemDeleteResponse itemDeleteResponse;
        for(int i=0;i<delList.size();i++){
            itemDelete = new ItemDeleteRequest();
            itemDelete.setNumIid(Long.valueOf(delList.get(i).get("num_iid").toString()));
            try { 
                itemDeleteResponse = client.execute(itemDelete, sessionKey);
                if(itemDeleteResponse.getErrorCode()!=null){
                    result = itemDeleteResponse.getMsg();
                    break;
                }
            } catch (ApiException e) {
                result = e.getErrMsg();
                break;
            }
        }
        return result;
    }

    /**
     * 从淘宝店铺中获取订单信息,并获取单下子订单及商品信息
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @Override
    public List<Trade> getTaoBaoTradeList(HttpServletRequest request) {
        List<Trade> list = new ArrayList<Trade>();
        String sessionKey = (String) request.getSession().getAttribute("sessionKey");
        
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        TradesSoldGetRequest tradesRequest = new TradesSoldGetRequest();
        tradesRequest.setFields("seller_nick, buyer_nick, title, type, created, tid, seller_rate,seller_can_rate, buyer_rate,can_rate, "
            + "status, payment, discount_fee, adjust_fee, post_fee, total_fee, pay_time, end_time, modified, consign_time, "
            + "buyer_obtain_point_fee, point_fee, real_point_fee, received_payment, pic_path, num_iid, num, price, cod_fee, "
            + "cod_status, shipping_type, receiver_name, receiver_state, receiver_city, receiver_district, receiver_address, "
            + "receiver_zip, receiver_mobile, receiver_phone,seller_flag,alipay_id,alipay_no,is_lgtype,is_force_wlb,is_brand_sale,"
            + "buyer_area,has_buyer_message, credit_card_fee, lg_aging_type, lg_aging, step_trade_status,step_paid_fee,mark_desc,"
            + "has_yfx,yfx_fee,yfx_id,yfx_type,trade_source,send_time,is_daixiao,is_wt,is_part_consign,area_id,orders");
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            if (paramMap.get("start_created")!=null && !"".equals(paramMap.get("start_created"))) {
                tradesRequest.setStartCreated(sdf.parse(paramMap.get("start_created").toString()));
            }
            if (paramMap.get("end_created")!=null && !"".equals(paramMap.get("end_created"))) {
                tradesRequest.setEndCreated(sdf.parse(paramMap.get("end_created").toString()));
            }
        } catch (ParseException e1) {
            e1.printStackTrace();
        }
        if(paramMap.get("status")!=null && !"".equals(paramMap.get("status"))){
            tradesRequest.setStatus(paramMap.get("status").toString());
        }
        TradesSoldGetResponse tradesResponse;
        try { 
            tradesResponse = client.execute(tradesRequest, sessionKey);
            list = tradesResponse.getTrades();
        } catch (ApiException e) {
        }
        return list;
    }
    
    /**
     * 查询淘宝子单名称
     * @param request
     * @return
     * @throws Exception
     */
    @Override
    public Trade getTaoBaoTradeDetailById(HttpServletRequest request,String tid) {
        Trade trade = new Trade();
        String sessionKey = (String) request.getSession().getAttribute("sessionKey");
        
        TradeFullinfoGetRequest tradeRequest = new TradeFullinfoGetRequest();
        tradeRequest.setTid(Long.valueOf(tid));
        tradeRequest.setFields("seller_nick, buyer_nick, title, type, created, tid, seller_rate,seller_can_rate, buyer_rate,can_rate, "
            + "status, payment, discount_fee, adjust_fee, post_fee, total_fee, pay_time, end_time, modified, consign_time, "
            + "buyer_obtain_point_fee, point_fee, real_point_fee, received_payment, pic_path, num_iid, num, price, cod_fee, "
            + "cod_status, shipping_type, receiver_name, receiver_state, receiver_city, receiver_district, receiver_address, "
            + "receiver_zip, receiver_mobile, receiver_phone,seller_flag,alipay_id,alipay_no,is_lgtype,is_force_wlb,is_brand_sale,"
            + "buyer_area,has_buyer_message, credit_card_fee, lg_aging_type, lg_aging, step_trade_status,step_paid_fee,mark_desc,"
            + "has_yfx,yfx_fee,yfx_id,yfx_type,trade_source,send_time,is_daixiao,is_wt,is_part_consign,area_id,orders");
        
        TradeFullinfoGetResponse tradeResponse;
        try { 
            tradeResponse = client.execute(tradeRequest, sessionKey);
            trade = tradeResponse.getTrade();
        } catch (ApiException e) {
        }
        return trade;
    }

    /**
     * 从淘宝店铺中将宝贝同步至系统中
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String addOrUpdateProduct(HttpServletRequest request) throws Exception {
        String returnString = "Y";
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> itemList = ObjectBindUtil.getRequestJsonData(jsonString);
        
        List<LinkedHashMap<String, Object>> addList = new ArrayList<LinkedHashMap<String,Object>>();
        List<LinkedHashMap<String, Object>> upList = new ArrayList<LinkedHashMap<String,Object>>();
        
        List<LinkedHashMap<String, Object>> updateItem = new ArrayList<LinkedHashMap<String,Object>>();
        String salesSql = "";
        for(int i=0;i<itemList.size();i++){
            salesSql = "";
            LinkedHashMap paramMap = itemList.get(i);
            paramMap.put("CREATED_BY", admin.getAdminID());
            paramMap.put("UPDATED_BY", admin.getAdminID());
            paramMap.put("CPNY_ID", admin.getCpnyId());
            
            boolean flag = true;
            if(paramMap.get("PRODUCT_ID_IN") != null && !"".equals(paramMap.get("PRODUCT_ID_IN"))){
                String k = this.checkProTaobao(request,paramMap.get("PRODUCT_ID_IN").toString());
                if(k!=null&&"N".equals(k)){
                    flag = false;
                }
            }
            //不为空则为更新，否则为添加
            if (!flag) {
                LinkedHashMap p = new LinkedHashMap();
                p.put("CPNY_ID", admin.getCpnyId());
                p.put("PRODUCT_ID", paramMap.get("PRODUCT_ID_IN"));
                String productNo = this.productDao.getProductNoById(p);
                salesSql = salesSql + "DELETE FROM PROSTOR_PRODUCT_SALES_MODEL PPSM WHERE PPSM.PRODUCT_NO='" + productNo + "'" +
                    " AND PPSM.SALES_MODE_NO='" + paramMap.get("salesMode") + "'" +
                    " AND PPSM.CPNY_ID = '"+paramMap.get("CPNY_ID")+"'" +
                    " AND PPSM.ACTIVITY = 1;" + 
                    "INSERT INTO PROSTOR_PRODUCT_SALES_MODEL(PRODUCT_NO,SALES_MODE_NO,PRICE,CREATE_DATE,CREATED_BY,ACTIVITY,CPNY_ID)" +
                    "VALUES('" + productNo + "','" +
                    paramMap.get("salesMode") + "'," +
                    paramMap.get("price") + "," +
                    "SYSDATE,'" +
                    paramMap.get("CREATED_BY") + "'," +
                    "1,'" +
                    paramMap.get("CPNY_ID") + "');";
                
                paramMap.put("salesSql", salesSql);
                upList.add(paramMap);
            } else {
                String productId = this.productDao.getProductIdSerial();
                salesSql = salesSql + "INSERT INTO PROSTOR_PRODUCT_SALES_MODEL(PRODUCT_NO,SALES_MODE_NO,PRICE,CREATE_DATE,CREATED_BY,ACTIVITY,CPNY_ID)" +
                    "VALUES(PROSTOR_PRODUCT_SEQ.CURRVAL,'" +
                    paramMap.get("salesMode") + "'," +
                    paramMap.get("price") + "," +
                    "SYSDATE,'" +
                    paramMap.get("CREATED_BY") + "'," +
                    "1,'" +
                    paramMap.get("CPNY_ID") + "');";
                paramMap.put("salesSql", salesSql);
                paramMap.put("PRODUCT_ID_IN", productId);
                addList.add(paramMap);
                //设置淘宝商品更改信息
                LinkedHashMap<String, Object> m = new LinkedHashMap<String, Object>();
                m.put("ownerId", productId);
                m.put("numIid", paramMap.get("numIid"));
                updateItem.add(m);
            }
        }
        returnString = this.productDao.addProductForList(addList);
        returnString = this.productDao.updateProductForListById(upList);
        if("Y".equals(returnString)){
            for(int i = 0;i<updateItem.size();i++){
                String result = this.updateTaoBaoItemOwnerId(request, updateItem.get(i));
                if(!"Y".equals(result)){
                    throw new Exception();
                }
            }
        }
        return returnString;
    }
    
    /**
     * 修改淘宝店铺中宝贝商家编码
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @Override
    public String updateTaoBaoItemOwnerId(HttpServletRequest request,Map map) {
        String result = "Y";
        String sessionKey = (String) request.getSession().getAttribute("sessionKey");
        
        ItemUpdateRequest itemUpdate = new ItemUpdateRequest();
        itemUpdate.setNumIid(Long.valueOf(map.get("numIid").toString()));
        itemUpdate.setOuterId(map.get("ownerId").toString());
        ItemUpdateResponse itemResponse;
        
        try { 
            itemResponse = client.execute(itemUpdate, sessionKey);
            if(itemResponse.getErrorCode() != null){
                result = itemResponse.getMsg();
            }
        } catch (ApiException e) {
        }
        return result;
    }

    /**
     * 检查该淘宝客户是否已经添加成为客户
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List<LinkedHashMap<String, Object>> getCustById(HttpServletRequest request) {
        List<LinkedHashMap<String, Object>> list = new ArrayList<LinkedHashMap<String, Object>>();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        list = this.taoBaoManageDao.getCustById(paramMap);
        return list;
    }

    /**
     * 从淘宝上将订单生成系统内部销售单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List<Map> saveOrderFromTaobao(HttpServletRequest request) throws Exception{
        List<Map> errorList = new ArrayList<Map>();
        
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> tradeList = ObjectBindUtil.getRequestJsonData(jsonString);
        
        //销售单bean
        SalesOrder salesOrder = new SalesOrder();
        List<SalesOrder> listSales = new ArrayList<SalesOrder>();
        
        //客户
        List<LinkedHashMap<String, Object>> custList;
        Customer cu;
        
        //循环传过来的淘宝订单
        for(int i=0;i<tradeList.size();i++){
            String flag = this.checkOrderTaobao(request, tradeList.get(i).get("tid").toString());
            if(flag != null && "Y".equals(flag)){
                salesOrder = new SalesOrder();
                Trade trade = this.getTaoBaoTradeDetailById(request, tradeList.get(i).get("tid").toString());
                if(trade == null){
                    Map map = new HashMap();
                    map.put("tid", tradeList.get(i).get("tid"));
                    map.put("msg", "网络连接异常");
                    errorList.add(map);
                    break;
                }
                if("Y".equals(this.checkCustIdByTaobaoNick(request, trade.getBuyerNick()))){
                    Map map = new HashMap();
                    map.put("tid", tradeList.get(i).get("tid"));
                    map.put("msg", "买家"+trade.getBuyerNick()+"未导入生成系统客户");
                    errorList.add(map);
                    break;
                }
                //*****************设置客户信息*****************//
                cu = new Customer();
                LinkedHashMap<String, Object> paramMap = new LinkedHashMap<String, Object>();
                paramMap.put("CPNY_ID", admin.getCpnyId());
                paramMap.put("TAOBAO_ID", trade.getBuyerNick());
                //通过淘宝订单购买者ID查出此购买者客户信息
                custList = this.taoBaoManageDao.getCustById(paramMap);
                if(custList != null && custList.size()>0){
                    cu.setCustomerNo(custList.get(0).get("CUST_NO").toString());
                    cu.setCustomerName(custList.get(0).get("CUST_NAME").toString());
                }
                salesOrder.setCustomer(cu);
                
                //*****************设置下单人*****************//
                Employee emp = new Employee();
                emp.setEmpId(request.getParameter("EMPID"));
                salesOrder.setOwner(emp);
                
                //*****************设置价格信息*****************//
                Price pr = new Price();
                pr.setDiscount(1);
                pr.setDiscountPrice(Double.valueOf(trade.getTotalFee()));
                pr.setPrice(Double.valueOf(trade.getTotalFee()));
                salesOrder.setPrice(pr);
                
                //*****************设置收货人信息*****************//
                Receiver re = new Receiver();
                Address a = new Address();
                a.setWholeAddress(trade.getReceiverState()+trade.getReceiverAddress());
                re.setAddress(a);
                re.setMobilePhone(trade.getReceiverMobile());
                re.setReceiverName(trade.getReceiverName());
                salesOrder.setReceiver(re);
                
                //*****************设置销售方式*****************//
                SalesMode sa = new SalesMode();
                sa.setSalesModeId("TAOBAO_ID");
                sa.setSalesModeName("淘宝销售");
                sa.setSalesModeNo(request.getParameter("SALES_MODE_NO"));
                salesOrder.setSalesMode(sa);
                
                //*****************设置销售单相关属性*****************//
                salesOrder.setConsignee(trade.getReceiverName());
                salesOrder.setDeliveryAddress(trade.getReceiverState()+trade.getReceiverCity()+trade.getReceiverDistrict()+trade.getReceiverAddress());
                salesOrder.setDeliveryDate(trade.getBuyerMessage());
                salesOrder.setInvoiceTitle(trade.getInvoiceName());
                salesOrder.setOrderDate(trade.getCreated());
                salesOrder.setTransportMode("");
                salesOrder.setTaobaoOrderId(tradeList.get(i).get("tid").toString());
                
                //*****************循环商品信息并添加进去*****************//
                List<Order> orderList = trade.getOrders();
                List<Product> proList = new ArrayList<Product>();
                Product product;
                boolean flag2 = true;
                for(int j=0;j<orderList.size();j++){
                    
                    product = new Product();
                    Price p = new Price();
                    Unit u = new Unit();
                    
                    //单个商品打折价格信息
                    p.setDiscount(1);
                    p.setDiscountPrice(Double.valueOf(orderList.get(j).getTotalFee())*p.getDiscount());
                    p.setPrice(Double.valueOf(orderList.get(j).getPrice()));
                    product.setSellingPrice(p);
                    
                    //单个商品单位信息
                    u.setUnitId("");
                    u.setUnitName("");
                    
                    //单个商品相关信息
                    product.setAmount(Double.valueOf(orderList.get(j).getTotalFee()));
                    
                    if (orderList.get(j).getOuterIid()!=null&&!"".equals(orderList.get(j).getOuterIid())) {
                        /*if("Y".equals(this.checkProTaobao(request, orderList.get(j).getOuterIid()))){
                            errorPro++;
                            flag2 = false;
                            break;
                        }*/
                        paramMap.put("PRODUCT_ID", orderList.get(j).getOuterIid());
                        List<Map> list = this.productDao.getProductList(paramMap);
                        if(list.size()>0){
                            product.setNo(list.get(0).get("PRODUCT_NO").toString());
                            u.setUnitId(list.get(0).get("UNIT_CODE_ID").toString());
                            u.setUnitName(list.get(0).get("UNIT_CODE").toString());
                            product.setId(orderList.get(j).getOuterIid());
                            product.setName(list.get(0).get("PRODUCT_NAME").toString());
                            if (list.get(0).get("SPECIFICATION")!=null) {
                                product.setSpecification(list.get(0).get("SPECIFICATION").toString());
                            }
                        }else{
                            Map map = new HashMap();
                            map.put("tid", tradeList.get(i).get("tid"));
                            map.put("msg", "下单时商品'"+orderList.get(j).getTitle()+"'未与系统商品正确关联");
                            errorList.add(map);
                            flag2 = false;
                            break;
                        }
                        
                    }else{
                        Map map = new HashMap();
                        map.put("tid", tradeList.get(i).get("tid"));
                        map.put("msg", "下单时商品'"+orderList.get(j).getTitle()+"'未与系统商品正确关联");
                        errorList.add(map);
                        flag2 = false;
                        break;
                    }
                    product.setUnit(u);
                    product.setQuantity(Double.valueOf(orderList.get(j).getNum()));
                    proList.add(product);
                }
                if(flag2){
                    salesOrder.setSoldProducts(proList);
                    salesOrder.setTaobaoOrderId(tradeList.get(i).get("tid").toString());
                    listSales.add(salesOrder);
                }
            }else{
                Map map = new HashMap();
                map.put("tid", tradeList.get(i).get("tid"));
                map.put("msg", "订单"+tradeList.get(i).get("tid")+"已导入");
                errorList.add(map);;
            }
        }
        
        //循环将订单插入生成销售单
        for(int i=0;i<listSales.size();i++){
            salesOrder = listSales.get(i);
            salesOrder.setOperator(admin);
            String salesOrderId = this.productSaleDao.getSalesOrderId();
            if (salesOrderId.equals(ProductSaleSerImpl.FAIL)) {
                
            }else{
                salesOrder.setSalesOrderId(salesOrderId);
                this.productSaleDao.insertSalesOrder(listSales.get(i));
            }
        }
        return errorList;
    }

    /**
     * 检查该淘宝订单是否已经导入系统中
     * @param request
     * @return
     * @throws Exception
     */
    @Override
    public String checkOrderTaobao(HttpServletRequest request, String taobaoId) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> paramMap = new LinkedHashMap<String, Object>();
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("TAOBAO_ORDERID", taobaoId);
        int i = this.taoBaoManageDao.checkOrderTaobao(paramMap);
        if(i==0){
            return "Y";
        }
        return "N";
    }
    
    /**
     * 检查是否存在与淘宝宝贝上架编码相关联的系统内部商品
     * @param request
     * @return
     * @throws Exception
     */
    @Override
    public String checkProTaobao(HttpServletRequest request, String outer_id) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> paramMap = new LinkedHashMap<String, Object>();
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("PRODUCT_ID", outer_id);
        int i = this.taoBaoManageDao.checkProTaobao(paramMap);
        if(i==0){
            return "Y";
        }
        return "N";
    }

    /**
     * 获取卖家地址
     * @param request
     * @return
     * @throws Exception
     */
    @Override
    public List<AddressResult> getSellerAddress(HttpServletRequest request) {
        List<AddressResult> list = new ArrayList<AddressResult>();
        String sessionKey = (String) request.getSession().getAttribute("sessionKey");
        
        LogisticsAddressSearchRequest addressRequest = new LogisticsAddressSearchRequest();
        LogisticsAddressSearchResponse addressResponse;
        
        try { 
            addressResponse = client.execute(addressRequest, sessionKey);
            list = addressResponse.getAddresses();
        } catch (ApiException e) {
        }
        return list;
    }
    
    /**
     * 获取物流公司
     * @param request
     * @return
     * @throws Exception
     */
    @Override
    public List<LogisticsCompany> getLogCompanies(HttpServletRequest request) {
        List<LogisticsCompany> list = new ArrayList<LogisticsCompany>();
        String sessionKey = (String) request.getSession().getAttribute("sessionKey");
        
        LogisticsCompaniesGetRequest companyRequest = new LogisticsCompaniesGetRequest();
        companyRequest.setFields("id,code,name,reg_mail_no");
        LogisticsCompaniesGetResponse companyResponse;
        
        try { 
            companyResponse = client.execute(companyRequest, sessionKey);
            list = companyResponse.getLogisticsCompanies();
        } catch (ApiException e) {
        }
        return list;
    }

    /**
     * 订单发货操作
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public String saveSend(HttpServletRequest request) {
        String result = "Y";
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        
        String sessionKey = (String) request.getSession().getAttribute("sessionKey");
        
        //设置各相关属性(必须)
        LogisticsConsignOrderCreateandsendRequest createRequest = new LogisticsConsignOrderCreateandsendRequest();
        createRequest.setUserId(Long.valueOf(paramMap.get("user_id").toString()));
        createRequest.setOrderSource(Long.valueOf(paramMap.get("order_source").toString()));
        createRequest.setOrderType(Long.valueOf(paramMap.get("order_type").toString()));
        createRequest.setLogisType(Long.valueOf(paramMap.get("logis_type").toString()));
        createRequest.setCompanyId(Long.valueOf(paramMap.get("company_id").toString()));
        createRequest.setTradeId(Long.valueOf(paramMap.get("trade_id").toString()));
        createRequest.setMailNo(paramMap.get("mail_no").toString());
        createRequest.setsName(paramMap.get("s_name").toString());
        createRequest.setsAreaId(Long.valueOf(paramMap.get("s_area_id").toString()));
        createRequest.setsAddress(paramMap.get("s_address").toString());
        createRequest.setsZipCode(paramMap.get("s_zip_code").toString());
        createRequest.setsMobilePhone(paramMap.get("s_mobile_phone").toString());
        createRequest.setrName(paramMap.get("r_name").toString());
        createRequest.setrAreaId(Long.valueOf(paramMap.get("r_area_id").toString()));
        createRequest.setrAddress(paramMap.get("r_address").toString());
        createRequest.setrZipCode(paramMap.get("r_zip_code").toString());
        createRequest.setrMobilePhone(paramMap.get("r_mobile_phone").toString());
        createRequest.setrProvName(paramMap.get("r_prov_name").toString());
        createRequest.setrCityName(paramMap.get("r_city_name").toString());
        createRequest.setrDistName(paramMap.get("r_dist_name").toString());
        createRequest.setsProvName(paramMap.get("s_prov_name").toString());
        createRequest.setsCityName(paramMap.get("s_city_name").toString());
        createRequest.setsDistName(paramMap.get("s_dist_name").toString());
        //设置该订单下商品信息(必须)
        String item_json_string = paramMap.get("item_json_string").toString();
        String jsonString = item_json_string.replace(" ", "").replace("{", "{\"").replace("}", "\"}").replace("=", "\":\"").replace(",", "\",\"");
        List<LinkedHashMap<String, Object>> itemList = ObjectBindUtil.getRequestJsonData(jsonString);
        StringBuffer itemString = new StringBuffer("[");
        for(int i=0;i<itemList.size();i++){
            if (itemString.length() > 1){
               itemString.append(",{");
            }else{
                itemString.append("{");
            }
            itemString.append("\"itemName\":\""+itemList.get(i).get("title")+"\",");
            itemString.append("\"singlePrice\":"+itemList.get(i).get("price")+",");
            itemString.append("\"itemCount\":"+itemList.get(i).get("num")+"");
            itemString.append("}"); 
        }
        itemString.append("]");
        createRequest.setItemJsonString(itemString.toString());
        
        LogisticsConsignOrderCreateandsendResponse createResponse;
        try { 
            createResponse = client.execute(createRequest, sessionKey);
            if(createResponse.getErrorCode() != null){
                result = createResponse.getMsg();
            }
            result = createResponse.getResultDesc();
        } catch (ApiException e) {
        }
        return result;
    }

    /**
     * 修改保存宝贝信息
     * @param request
     * @return
     * @throws Exception
     */
    @Override
    public String updateItem(HttpServletRequest request) {
        String result = "Y";
        String sessionKey = (String) request.getSession().getAttribute("sessionKey");
        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> itemList = ObjectBindUtil.getRequestJsonData(jsonString);
        
        ItemUpdateRequest itemUpdate;
        ItemUpdateResponse itemResponse;
        for(int i=0;i<itemList.size();i++){
            itemUpdate = new ItemUpdateRequest();
            itemUpdate.setNumIid(Long.valueOf(itemList.get(i).get("num_iid").toString()));
            itemUpdate.setTitle(itemList.get(i).get("title").toString());
            itemUpdate.setOuterId(itemList.get(i).get("outer_id").toString());
            //itemUpdate.setPrice(itemList.get(i).get("price").toString());
            itemUpdate.setNum(Long.valueOf(itemList.get(i).get("num").toString()));
            try { 
                itemResponse = client.execute(itemUpdate, sessionKey);
                if(itemResponse.getErrorCode() != null){
                    result = itemResponse.getMsg();
                    break;
                }
            } catch (ApiException e) {
            }
        }
        return result;
    }
    
    /**
     * 检查该淘宝客户是否已经添加成为客户
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public String checkCustIdByTaobaoNick(HttpServletRequest request,String TAOBAO_ID) {
        List<LinkedHashMap<String, Object>> list = new ArrayList<LinkedHashMap<String, Object>>();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("TAOBAO_ID", TAOBAO_ID);
        list = this.taoBaoManageDao.getCustById(paramMap);
        if(list.size()>0){
            return "N";
        }
        return "Y";
    }
}
