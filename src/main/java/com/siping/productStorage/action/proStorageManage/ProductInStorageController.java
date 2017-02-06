package com.siping.productStorage.action.proStorageManage;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.productStorage.service.ProductInStorageSer;
import com.siping.productStorage.service.ProductSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.JsonUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.service.UtilityEmpInfoSer;

@Controller
@RequestMapping(value = "/productStorage/proStorageManage")
public class ProductInStorageController {

    Logger logger = Logger.getLogger(ProductInStorageController.class);

    @Autowired
    private UtilityEmpInfoSer utilityEmpInfoSer;
    @Autowired
    private ProductInStorageSer productInStorageSer;
    @Autowired
    private ProductSer productSer;
    /**
     * 货品入库界面
     * @param request
     * @param modelMap
     * @return
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/viewProductInStorage", method = RequestMethod.GET)
    public ModelAndView viewProductInStorage(HttpServletRequest request, ModelMap modelMap) throws Exception {
        List proInColumns = productInStorageSer.getProInColumns(request);
        List supplierList = this.productInStorageSer.getSupplierList(request);

        modelMap.put("proInColumns", JsonUtil.writeInternal(proInColumns));

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        modelMap.put("IN_DATE", sdf.format(new Date()));
        modelMap.put("supplierList", JsonUtil.writeInternal(supplierList));

        return new ModelAndView("/productStorage/proStorageManage/viewProductInStorage", modelMap);
    }

    /**
     * 获取供应商
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getSupplierList", method = RequestMethod.POST)
    @ResponseBody
    public Map getSupplierList(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List saleOrderList = this.productInStorageSer.getSupplierList(request);

        model.put("Rows", saleOrderList);

        return model;
    }

    /**
     * 获取动态查出的商品
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getProductSymple", method = RequestMethod.POST)
    @ResponseBody
    public Map getProductSymple(HttpServletRequest request) throws Exception {

        List<HashMap> productList = this.productSer.getProductSymple(request);
        Map model = new HashMap();
        model.put("productList", productList);

        return model;
    }

    /**
     * 获取动态查出的商品
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getProductByOrder", method = RequestMethod.POST)
    @ResponseBody
    public Map getProductByOrder(HttpServletRequest request) throws Exception {

        List<HashMap> productList = this.productSer.getProductByOrder(request);
        Map model = new HashMap();
        model.put("product", productList);

        return model;
    }

    /**
     * 保存入库信息
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/productInStore", method = RequestMethod.POST)
    @ResponseBody
    public String productInStore(HttpServletRequest request) {
        String returnString = "Y";
        try {
            returnString = this.productInStorageSer.productInStore(request);
        } catch (Exception e) {
            e.printStackTrace();
            returnString = e.getMessage();
        }
        return returnString;
    }

    /**
     * 获取未完成入库单列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getInstorageList", method = RequestMethod.POST)
    @ResponseBody
    public Map getInstorageList(HttpServletRequest request) throws Exception {

        List<HashMap> inStorageList = this.productInStorageSer.getInstorageList(request);
        Map model = new HashMap();
        model.put("inStorageList", inStorageList);

        return model;
    }

    /**
     * 获取待入库的采购单信息
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getPurchaseOrderList", method = RequestMethod.POST)
    @ResponseBody
    public Map getPurchaseOrderList(HttpServletRequest request) throws Exception {
//        String check_key = "";
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
//        Map map = this.systemSer.getApproverId("CheckType001");
//        if(map!=null){
//            check_key = map.get("CHECK_KEY").toString();
//        }
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
//        paramMap.put("CHECK_KEY", check_key);
        List<HashMap> purchaseList = this.productInStorageSer.getPurchaseOrderList(paramMap);
        int purchaseListCnt = this.productInStorageSer.getPurchaseOrderListCnt(paramMap);
        Map model = new HashMap();
        model.put("Rows", purchaseList);
        model.put("Total", purchaseListCnt);

        return model;
    }

    /**
     * 获取待入库商品数量
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getWaitingInStorage", method = RequestMethod.POST)
    @ResponseBody
    public Map getWaitingInStorage(HttpServletRequest request) throws Exception {
        int sum = this.productInStorageSer.getWaitingInStorageSum(request);
        List<HashMap> supplierList = this.productInStorageSer.getSupplierList(request);
        List<HashMap> productList = this.productInStorageSer.getProductWaitingInfo(request);
        Map model = new HashMap();

        model.put("sum", sum);
        model.put("supplierList", supplierList);
        model.put("productList", productList);
        return model;
    }

    /**
     * 查看入库历史记录
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/viewInStorHistory", method = RequestMethod.GET)
    public ModelAndView viewInStorHistory(HttpServletRequest request, ModelMap modelMap) throws Exception {

        return new ModelAndView("/productStorage/proStorageManage/viewInStorHistory", modelMap);
    }

    /**
     * 获取入库单历史记录
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getInStorHistory", method = RequestMethod.POST)
    @ResponseBody
    public Map getInStorHistory(HttpServletRequest request) throws Exception {

        List<HashMap> list = this.productInStorageSer.getInStorHistoryList(request);
        int listCnt = this.productInStorageSer.getInStorHistoryListCnt(request);
        Map model = new HashMap();
        model.put("Rows", list);
        model.put("Total", listCnt);

        return model;
    }

    /**
     * 获取入库单详情
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/showInStorDetail", method = RequestMethod.POST)
    @ResponseBody
    public Map showInStorDetail(HttpServletRequest request) throws Exception {

        List<HashMap> list = this.productInStorageSer.getInStorDetailList(request);
        int temp = this.productInStorageSer.getInStorDetailListCnt(request);

        Map model = new HashMap();
        model.put("Rows", list);
        model.put("Total", temp);

        return model;
    }

    @RequestMapping(value = "/viewProInstorReport", method = RequestMethod.GET)
    public void viewProInstorReport(HttpServletRequest request, HttpServletResponse response) throws Exception {
        this.productInStorageSer.viewProInstorReport(request, response);
    }

    /**
     * 进入入库单打印预览界面
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewInstorageOrderPreview", method = RequestMethod.GET)
    public ModelAndView viewPurchaseOrderPreview(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.utilityEmpInfoSer.getEmpBasicInfo(request));
        modelMap.put("instorageOrder", this.productInStorageSer.getInstorOrderById(request));
        modelMap.put("instorageOrderDetail", this.productInStorageSer.getInStorDetailList(request));
        modelMap.put("instorageOrderDetailCnt", this.productInStorageSer.getInStorDetailListCnt(request));
        modelMap.put("currentDate", DateUtil.getSysdateString("yyyy-MM-dd"));

        return new ModelAndView("/productStorage/proStorageManage/viewInstorageOrderPreview", modelMap);
    }

    /**
     * 查看处理中的入库单
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/viewInStoring", method = RequestMethod.GET)
    public ModelAndView viewInStoring(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("paraMap", ObjectBindUtil.getRequestParamData(request));
        return new ModelAndView("/productStorage/proStorageManage/viewInStoring", modelMap);
    }

    @RequestMapping(value = "/exportInstorRecords", method = RequestMethod.GET)
    public void exportInstorRecords(HttpServletRequest request, HttpServletResponse response) throws Exception {
        this.productInStorageSer.exportInstorRecords(request, response);
    }
}
