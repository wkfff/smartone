package com.siping.mobile.action;

import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.cust.bean.Address;
import com.siping.cust.bean.Customer;
import com.siping.cust.bean.Receiver;
import com.siping.cust.service.CustInfoSer;
import com.siping.doc.service.DocInfoSer;
import com.siping.mobile.service.MobileManageSer;
import com.siping.productStorage.bean.Employee;
import com.siping.productStorage.bean.Price;
import com.siping.productStorage.bean.Product;
import com.siping.productStorage.bean.SalesMode;
import com.siping.productStorage.bean.SalesOrder;
import com.siping.productStorage.bean.Unit;
import com.siping.productStorage.service.ProductSaleSer;
import com.siping.productStorage.service.ProductSer;
import com.siping.productStorage.service.SalesModelSer;
import com.siping.system.bean.AdminBean;
import com.siping.system.service.BasicMaintenanceSer;
import com.siping.system.service.SystemSer;
import com.siping.web.bean.Pagging;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.service.UtilityCustInfoSer;

@Controller
@RequestMapping(value = "/mobile/mobileOrder")
public class MobileOrderCtroller {
    Logger logger = Logger.getLogger(MobileProManageCtroller.class);
    @Autowired
    private MobileManageSer mobileManageSer;
    @Autowired
    private ProductSer productSer;
    @Autowired
    private DocInfoSer docInfoSer;
    @Autowired
    private BasicMaintenanceSer basicMaintenanceSer;
    @Autowired
    private SalesModelSer salesModelSer;
    @Autowired
    private SystemSer systemSer;
    @Autowired
    private UtilityCustInfoSer utilityCustInfoSer;
    @Autowired
    private ProductSaleSer salesOrderSer;
    @Autowired
    private CustInfoSer custInfoSer;
    
    /**
     * 添加到购物车
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/addToCart", method = RequestMethod.POST)
    @ResponseBody
    public int addToCart(HttpServletRequest request) throws Exception {
        int count = 0;
        count = this.mobileManageSer.addToCart(request);
        return count;
    }
    
    /**
     * 添加到购物车
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/deleteFromCart", method = RequestMethod.POST)
    @ResponseBody
    public String deleteFromCart(HttpServletRequest request) throws Exception {
        String returnString = "Y";
        returnString = this.mobileManageSer.deleteFromCart(request);
        return returnString;
    }
    
    /**
     * 下单确认
     * @param request
     * @param modelMap
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value="/viewCartList",method=RequestMethod.GET)
    public ModelAndView viewCartList(HttpServletRequest request, ModelMap modelMap){
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        //如果是客户登陆则读取客户信息
        if(admin.getAccountType()!=null && "CU".equals(admin.getAccountType())){
            request.setAttribute("CUST_ID", admin.getAdminID());
            List<HashMap> cuList = this.utilityCustInfoSer.getCustomerList(request);
            if(cuList.size()>0){
                modelMap.put("customer", cuList.get(0));
                Map map = new HashMap();
                map.put("SALES_MODE_NO", cuList.get(0).get("CUST_SALES_MODE_CODE"));
                modelMap.put("saleMode", map);
            }
        }else{
          //设置商品移动端所要显示销售渠道价格
            List<HashMap> salesList = mobileManageSer.getSalesModelList(request);
            if (salesList.size()>0) {
                modelMap.put("saleMode", salesList.get(0));
            }
        }
        return new ModelAndView("/mobile/mobileOrder/viewCartList", modelMap);
    }
    
    /**
     * 获取客户列表
     * @param request
     * @param modelMap
     * @return
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value = "/getMobileCustomerList", method = RequestMethod.POST)
    @ResponseBody
    public Map getMobileCustomerList(HttpServletRequest request) throws Exception {
        Map map = new HashMap();
        map.put("Rows", this.utilityCustInfoSer.getCustomerList(request));
        map.put("Total", this.utilityCustInfoSer.getCustomerListCnt(request));
        return map;
    }
    
    /**
     * 获取客户收货人
     * @param request
     * @param modelMap
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getMobileCustomerReceiverList", method = RequestMethod.POST)
    @ResponseBody
    public List getMobileCustomerReceiverList(HttpServletRequest request) throws Exception {
        //查询出客户信息
        List<HashMap> cuList = this.utilityCustInfoSer.getCustomerList(request);
        HashMap custChose = new HashMap();
        if(cuList.size()>0){
            custChose = cuList.get(0);
        }
        List list = (List)custChose.get("RECEIVERS");
        if(list == null){
            return new ArrayList();
        }
        return list;
    }
    
    /**
     * 提交订单
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/saveCart", method = RequestMethod.POST)
    @ResponseBody
    public String saveCart(HttpServletRequest request) throws Exception {
        String result = "Y";
        //这是一个巨坑不解释
        String customer = request.getParameter("customer");
        String owner = request.getParameter("owner");
        String price = request.getParameter("price");
        String receiver = request.getParameter("receiver");
        String salesMode = request.getParameter("salesMode");
        String jsonString = request.getParameter("jsonData");
        
        List<LinkedHashMap<String, Object>> tempList;
        SalesOrder salesOrder = new SalesOrder();
        
        //设置客户
        Customer cu = new Customer();
        tempList = ObjectBindUtil.getRequestJsonData(customer);
        
        //cu.setAddress(tempList.get(0).get("address").toString());
        cu.setCustomerNo(tempList.get(0).get("customerNo").toString());
        cu.setCustomerName(tempList.get(0).get("customerName").toString());
        salesOrder.setCustomer(cu);
        
        //设置下单人
        String custId = String.valueOf(request.getParameter("CUST_ID"));
        if(custId != null&&!"".equals(custId)){
            Customer cust = (Customer)this.custInfoSer.getCustomerDetail(request);
            Employee aff2 = new Employee();
            aff2.setEmpId(cust.getOwner().getEmpId());
            aff2.setEmpName(cust.getOwner().getEmpName());
            salesOrder.setOwner(aff2);
        }else{
            Employee aff2 = new Employee();
            tempList = ObjectBindUtil.getRequestJsonData(owner);
            aff2.setEmpId(tempList.get(0).get("empId").toString());
            aff2.setEmpName(tempList.get(0).get("empName").toString());
            salesOrder.setOwner(aff2);
        }
        
        //设置价格信息
        Price pr = new Price();
        tempList = ObjectBindUtil.getRequestJsonData(price);
        pr.setDiscount(Double.valueOf(tempList.get(0).get("discount").toString()));
        pr.setDiscountPrice(Double.valueOf(tempList.get(0).get("discountPrice").toString()));
        pr.setPrice(Double.valueOf(tempList.get(0).get("price").toString()));
        salesOrder.setPrice(pr);
        
        //设置收货人
        Receiver re = new Receiver();
        tempList = ObjectBindUtil.getRequestJsonData(receiver);
        Address a = new Address();
        a.setWholeAddress(tempList.get(0).get("address").toString());
        re.setAddress(a);
        re.setMobilePhone(tempList.get(0).get("mobile").toString());
        re.setReceiverName(tempList.get(0).get("name").toString());
        salesOrder.setReceiver(re);
        
        //设置销售方式
        SalesMode sa = new SalesMode();
        tempList = ObjectBindUtil.getRequestJsonData(salesMode);
        /*sa.setSalesModeId(tempList.get(0).get("salesModeId").toString());
        sa.setSalesModeName(tempList.get(0).get("salesModeName").toString());*/
        sa.setSalesModeNo(tempList.get(0).get("salesModeNo").toString());
        salesOrder.setSalesMode(sa);
        
        //设置销售单各相关属性
        salesOrder.setConsignee(request.getParameter("consignee"));
        salesOrder.setDeliveryAddress(request.getParameter("deliveryAddress"));
        salesOrder.setDeliveryDate(request.getParameter("deliveryDate"));
        salesOrder.setInvoiceTitle(request.getParameter("invoiceTitle"));
        salesOrder.setOrderDate(new Date());
        salesOrder.setTransportMode(request.getParameter("transportMode"));
        salesOrder.setInvoiceType(request.getParameter("invoiceType"));
        salesOrder.setInvoiceTitleType(request.getParameter("invoiceTitleType"));
        salesOrder.setInvoiceTitleContent(request.getParameter("invoiceTitleContent"));
        salesOrder.setInvoiceContent(request.getParameter("invoiceContent"));
        salesOrder.setPaymentMode(request.getParameter("paymentMode"));
        
        //循环商品添加进去
        tempList = ObjectBindUtil.getRequestJsonData(jsonString);
        Product product;
        List<LinkedHashMap<String, Object>> temp;
        List<Product> proList = new ArrayList<Product>();
        for(int i=0;i<tempList.size();i++){
            product = new Product();
            
            Price p = new Price();
            Unit u = new Unit();
            
            //单个商品打折价格信息
            String s = "["+tempList.get(i).get("sellingPrice").toString()+"]";
            String pString = s.replace("\'", "\"").replace("=", ":");
            temp = ObjectBindUtil.getRequestJsonData(pString);
            p.setDiscount(Double.valueOf(temp.get(0).get("discount").toString()));
            p.setDiscountPrice(Double.valueOf(temp.get(0).get("discountPrice").toString()));
            p.setPrice(Double.valueOf(temp.get(0).get("price").toString()));
            product.setSellingPrice(p);
            
            //单个商品单位信息
            String us = "["+tempList.get(i).get("unit").toString()+"]";
            String uString = us.replace("\'", "\"").replace("=", ":");
            temp = ObjectBindUtil.getRequestJsonData(uString);
            u.setUnitId(temp.get(0).get("unitId").toString());
            u.setUnitName(temp.get(0).get("unitName").toString());
            product.setUnit(u);
            
            //单个商品相关信息
            product.setAmount(Double.valueOf(tempList.get(i).get("amount").toString()));
            product.setId(tempList.get(i).get("id").toString());
            product.setName(tempList.get(i).get("name").toString());
            product.setNo(tempList.get(i).get("no").toString());
            product.setQuantity(Double.valueOf(tempList.get(i).get("quantity").toString()));
            product.setSpecification(tempList.get(i).get("specification").toString());

            proList.add(product);
        }
        salesOrder.setSoldProducts(proList);
        result = salesOrderSer.saveSalesOrder(salesOrder,request);
        //保存成功后清空购物车
        if(result != null && "Y".equals(result)){
            this.mobileManageSer.clearCart(request);
        }
        return result;
    }
    
    /**
     * 我的订单
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value="/viewMobileOrderList",method=RequestMethod.GET)
    public ModelAndView viewMobileOrderList(HttpServletRequest request, ModelMap modelMap){
        return new ModelAndView("/mobile/mobileOrder/viewMobileOrderList", modelMap);
    }
    
    /**
     * 查看订单
     * @param request
     * @param modelMap
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getMySalesOrders", method = POST)
    @ResponseBody
    public Map getAllSalesOrders(HttpServletRequest request) {
        Map map = new LinkedHashMap();
        List<SalesOrder> salesOrderList = this.salesOrderSer.getAllSalesOrders(request, Integer.valueOf(request.getParameter("page")), 
            Integer.valueOf(request.getParameter("pagesize")));
        List<Product> productList = new ArrayList<Product>();
        for(int i=0;i<salesOrderList.size();i++){
            productList = this.salesOrderSer.getProductBySalesOrder(request, salesOrderList.get(i));
            salesOrderList.get(i).setSoldProducts(productList);
        }
        
        int total = this.salesOrderSer.getAllSalesOrdersCount(request);
        //分页类
        Pagging page = new Pagging(Integer.valueOf(request.getParameter("page")), total, Integer.valueOf(request.getParameter("pagesize")));

        map.put("Rows", salesOrderList);
        map.put("page", page);
        return map;
    }
    
    /**
     * 查看销售单详情
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/viewSalesOrderDetail", method = RequestMethod.GET)
    public ModelAndView viewSalesOrderDetail(HttpServletRequest request, ModelMap modelMap) {
        SalesOrder salesOrder = new SalesOrder();
        List<SalesOrder> salesOrderList = this.salesOrderSer.getAllSalesOrders(request, 1, 5);
        List<Product> productList = new ArrayList<Product>();
        for(int i=0;i<salesOrderList.size();i++){
            productList = this.salesOrderSer.getProductBySalesOrder(request, salesOrderList.get(i));
            salesOrderList.get(i).setSoldProducts(productList);
        }
        if(salesOrderList.size()>0){
            salesOrder = salesOrderList.get(0);
        }
        modelMap.put("salesOrder", salesOrder);
        return new ModelAndView("/mobile/mobileOrder/viewSalesOrderDetail", modelMap);
    }
    
    /**
     * 获取选择新客户之后购物车商品新价格
     * @param request
     * @param modelMap
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getNewPriceByCu", method = RequestMethod.POST)
    @ResponseBody
    public List getNewPriceByCu(HttpServletRequest request) throws Exception {
        String salesModeNo = request.getParameter("salesModeNo");
        List<Map> proList = (List<Map>) request.getSession().getAttribute("cartProList");
        List<Map> priceList = new ArrayList<Map>();
        Map map;
        for(int i=0;i<proList.size();i++){
            map = new HashMap();
            map.put("PRODUCT_NO", proList.get(i).get("PRODUCT_NO"));
            map.put("PRICE", proList.get(i).get("SALE"+salesModeNo));
            priceList.add(map);
        }
        return priceList;
    }
}
