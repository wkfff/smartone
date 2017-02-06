package com.siping.productStorage.action.proBusinessManage;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.cust.bean.Customer;
import com.siping.cust.service.CustInfoSer;
import com.siping.cust.service.SalesSettingSer;
import com.siping.productStorage.bean.Employee;
import com.siping.productStorage.bean.Product;
import com.siping.productStorage.bean.SalesMode;
import com.siping.productStorage.bean.SalesOrder;
import com.siping.productStorage.service.ProductSaleSer;
import com.siping.productStorage.service.ProductSer;
import com.siping.productStorage.service.SalesModelSer;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.service.UtilityEmpInfoSer;

@Controller
@RequestMapping(value = "/productStorage/proBusinessManage")
public class ProductSaleController {

    @Autowired
    private UtilityEmpInfoSer utilityEmpInfoSer;
    @Autowired
    private ProductSer productSer;
    @Autowired
    private SalesModelSer salesModeSer;
    @Autowired
    private CustInfoSer custInfoSer;
    @Autowired
    private ProductSaleSer salesOrderSer;
    @Autowired
    private SalesSettingSer salesSettingSer;
    public static final String FAIL = "fail to save";

    /**
     * 返回订单管理-销售单
     *
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/viewProductSale", method = GET)
    public ModelAndView viewProductList(ModelMap modelMap,HttpServletRequest request) {
        modelMap.put("isSupervisor", salesSettingSer.isSupervisor(request));
        return new ModelAndView("/productStorage/proBusinessManage/viewProductSale", modelMap);
    }

    @RequestMapping(value = "/viewProductSaleManage", method = GET)
    public ModelAndView viewSalesOrderManage(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("basicInfo", this.utilityEmpInfoSer.getEmpBasicInfo(request));
        return new ModelAndView("/productStorage/proBusinessManage/viewProductSaleManage", modelMap);
    }

    @RequestMapping(value = "/getCurrentEmp", method = GET)
    @ResponseBody
    public Employee getCurrentEmp(HttpServletRequest request) {
        return this.utilityEmpInfoSer.getEmpBasicInfoUsingBeanMap(request);
    }

    @RequestMapping(value = "/getCurrentUser", method = GET)
    @ResponseBody
    public Map getCurrentUser(HttpServletRequest request) {
        return this.utilityEmpInfoSer.getEmpBasicInfo(request);
    }

    @RequestMapping(value = "/getAllCustomers", method = GET)
    @ResponseBody
    public List<Customer> getAllCustomers(HttpServletRequest request) {
        return this.custInfoSer.getAllCustomerListUsingBeanMap(request);
    }

    /**
     * 获取下单人候选名单
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/getEmInfoList", method = GET)
    @ResponseBody
    public List getEmpInfoList(HttpServletRequest request) {
        return this.utilityEmpInfoSer.getAllEmployeesUsingBeanMap(request);
    }

    @RequestMapping(value = "/getProductsBySalesMode", method = GET)
    @ResponseBody
    public List getProductsBySalesMode(HttpServletRequest request) {
        return productSer.getProductsBySalesMode(request);
    }

    @RequestMapping(value = "/getAllSalesMode", method = GET)
    @ResponseBody
    public List<SalesMode> getAllSalesMode() {
        return salesModeSer.getAllSalesModes();
    }

    @RequestMapping(value = "/saveSalesOrder", method = POST)
    @ResponseBody
    public String saveSalesOrder(@RequestBody SalesOrder salesOrder, HttpServletRequest request) {
        String returnMsg = "";
        try {
            returnMsg = this.salesOrderSer.saveSalesOrder(salesOrder, request);
        } catch (Exception e) {
            returnMsg = FAIL;
            e.printStackTrace();
        }
        return returnMsg;
    }

    @RequestMapping(value = "/getAllSalesOrders", method = POST)
    @ResponseBody
    public Map getAllSalesOrders(HttpServletRequest request, int page, int pagesize) {
        Map map = new LinkedHashMap();
        List<SalesOrder> resultList = this.salesOrderSer.getAllSalesOrders(request, page, pagesize);
        int total = this.salesOrderSer.getAllSalesOrdersCount(request);
        map.put("Rows", resultList);
        map.put("Total", total);
        return map;
    }

    @RequestMapping(value = "/getSalesOrderDetail", method = GET)
    @ResponseBody
    public List<Product> getSalesOrder(HttpServletRequest request, @RequestParam String salesOrderNo) {
        return this.salesOrderSer.getSalesOrder(request, salesOrderNo).getSoldProducts();
    }

    @RequestMapping(value = "/searchSalesOrder", method = GET)
    @ResponseBody
    public Map searchSalesOrder(HttpServletRequest request) {
        Map map = new LinkedHashMap();
        List<SalesOrder> resultList = this.salesOrderSer.searchSalesOrder(request);
        map.put("Rows", resultList);
        return map;
    }

    @RequestMapping(value = "/deleteSalesOrder", method = GET)
    @ResponseBody
    public String deleteSalesOrder(HttpServletRequest request, @RequestParam String salesOrderNo,
            @RequestParam String processId) {
        return this.salesOrderSer.deleteSalesOrder(request, salesOrderNo,processId);
    }

    /**
     * 审核人所看到的销售单信息
     *
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewCheckSalesOrder", method = RequestMethod.GET)
    public ModelAndView viewCheckSalesOrder(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("salesOrder", this.salesOrderSer.getSalesOrderInfo(request));
        return new ModelAndView("/productStorage/proBusinessManage/viewCheckSalesOrder", modelMap);
    }

    /**
     * 审核人所看到的销售单货品详情
     *
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({"unchecked", "rawtypes"})
    @RequestMapping(value = "/getSalesOrderDetailForCheck", method = RequestMethod.POST)
    @ResponseBody
    public Map getSalesOrderDetailForCheck(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List detail = this.salesOrderSer.getSalesOrderDetailForCheck(request);
        int cnt = this.salesOrderSer.getSalesOrderDetailForCheckCnt(request);
        model.put("Rows", detail);
        model.put("Total", cnt);
        return model;
    }

    /**
     * 进入采购单打印预览界面
     *
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewSalesOrderPreview", method = RequestMethod.GET)
    public ModelAndView viewSalesOrderPreview(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.utilityEmpInfoSer.getEmpBasicInfo(request));
        modelMap.put("salesOrder", this.salesOrderSer.getSalesOrderInfo(request));
        modelMap.put("salesOrderDetail", this.salesOrderSer.getSalesOrderDetailForCheck(request));
        modelMap.put("salesOrderDetailCnt", this.salesOrderSer.getSalesOrderDetailForCheckCnt(request));
        modelMap.put("currentDate", DateUtil.getSysdateString("yyyy-MM-dd"));

        return new ModelAndView("/productStorage/proBusinessManage/viewSalesOrderPreview", modelMap);
    }

    @RequestMapping(value = "/updateSalesOrderStatus", method = RequestMethod.POST)
    @ResponseBody
    public String updateSalesOrderStatus(HttpServletRequest request) throws Exception {
        String returnMsg = "N";
        returnMsg = this.salesOrderSer.updateSalesOrderStatus(request);
        return returnMsg;
    }

    @RequestMapping(value = "/salesOrderToExcel", method = GET)
    public void salesOrderToExcel(HttpServletRequest request, HttpServletResponse response,
                                    @RequestParam String salesOrderNo){
        this.salesOrderSer.salesOrderToExcel(request,response, salesOrderNo);
    }

    @RequestMapping(value = "/manySaleOrdersToExcel", method = RequestMethod.GET)
    public void manySaleOrdersToExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
        this.salesOrderSer.saleOrdersToExcel(request, response);
    }
}
