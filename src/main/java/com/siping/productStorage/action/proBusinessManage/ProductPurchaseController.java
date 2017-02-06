package com.siping.productStorage.action.proBusinessManage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.productStorage.service.ProductPurchaseSer;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.JsonUtil;
import com.siping.web.utility.service.UtilityEmpInfoSer;

@Controller
@RequestMapping(value = "/productStorage/proBusinessManage")
public class ProductPurchaseController {

    @Autowired
    private UtilityEmpInfoSer utilityEmpInfoSer;
    @Autowired
    private ProductPurchaseSer productPurchaseSer;

    @RequestMapping(value = "/viewProductPurchase", method = RequestMethod.GET)
    public ModelAndView viewProductList(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("basicInfo", this.utilityEmpInfoSer.getEmpBasicInfo(request));
        modelMap.put("currentDate", DateUtil.getSysdateString("yyyy-MM-dd"));
        return new ModelAndView("/productStorage/proBusinessManage/viewProductPurchase", modelMap);
    }

    /**
     * 依据品名规格获取供应商
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getSupplier", method = RequestMethod.POST)
    @ResponseBody
    public Map getSupplier(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List supplier = this.productPurchaseSer.getSupplier(request);
        model.put("supplier", supplier);

        return model;
    }

    /**
     * 依据品名规格、供货商No获取供应商下商品
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getSupplierProduct", method = RequestMethod.POST)
    @ResponseBody
    public Map getSupplierProduct(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List supplierProduct = this.productPurchaseSer.getSupplierProduct(request);
        model.put("supplierProduct", supplierProduct);

        return model;
    }

    /**
     * 保存采购单
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/addPurchaseOrder", method = RequestMethod.POST)
    @ResponseBody
    public String addPurchaseOrder(HttpServletRequest request) {
        String returnString = "Y";
        try {
            returnString = this.productPurchaseSer.addPurchaseOrder(request);
        } catch (Exception e) {
            e.printStackTrace();
            returnString = e.getMessage();
        }
        return returnString;
    }

    /**
     * 进入采购单管理界面
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/viewPurchaseOrderManagement", method = RequestMethod.GET)
    public ModelAndView viewPurchaseOrderManagement(HttpServletRequest request, ModelMap modelMap) {

        return new ModelAndView("/productStorage/proBusinessManage/viewPurchaseOrderManagement", modelMap);
    }

    /**
     * 采购单列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getPurchaseOrderList", method = RequestMethod.POST)
    @ResponseBody
    public Map getPurchaseOrderList(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List purchaseOrderList = this.productPurchaseSer.getPurchaseOrderList(request);
        int purchaseOrderCnt = this.productPurchaseSer.getPurchaseOrderCnt(request);
        model.put("Rows", purchaseOrderList);
        model.put("Total", purchaseOrderCnt);
        return model;
    }

    /**
     * 采购单详情页面
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/showPurchaseOrderDetail", method = RequestMethod.GET)
    public ModelAndView showPurchaseOrderDetail(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("paraMap", this.utilityEmpInfoSer.getRequestParamData(request));
        return new ModelAndView("/productStorage/proBusinessManage/viewPurchaseOrderDetail", modelMap);
    }

    /**
     * 采购单详情列表
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getPurchaseOrderDetailList", method = RequestMethod.POST)
    @ResponseBody
    public Map getPurchaseOrderDetailList(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List purchaseOrderDetailList = this.productPurchaseSer.getPurchaseOrderDetailList(request);
        int purchaseOrderDetailCnt = this.productPurchaseSer.getPurchaseOrderDetailCnt(request);
        model.put("Rows", purchaseOrderDetailList);
        model.put("Total", purchaseOrderDetailCnt);
        return model;
    }

    /**
     * 删除采购单
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/deletePurchaseOrder", method = RequestMethod.POST)
    @ResponseBody
    public String deletePurchaseOrder(HttpServletRequest request) {
        String returnString = this.productPurchaseSer.deletePurchaseOrder(request);
        return returnString;
    }

    /**
     * 进入采购单修改页面
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewPurchaseOrderModify", method = RequestMethod.GET)
    public ModelAndView viewPurchaseOrderModify(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("purchaseOrder", this.productPurchaseSer.getPurchaseOrder(request));
        modelMap.put("purchaseOrderDetail", JsonUtil.writeInternal(this.productPurchaseSer.getPurchaseOrderDetailList(request)));
        modelMap.put("purchaseOrderDetailCnt", this.productPurchaseSer.getPurchaseOrderDetailCnt(request));

        return new ModelAndView("/productStorage/proBusinessManage/viewPurchaseOrderModify", modelMap);
    }

    /**
     * 依据采购单id获取采购单信息
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value = "/getPurchaseOrderInfo", method = RequestMethod.GET)
    @ResponseBody
    public Map getPurchaseOrderInfo(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("purchaseOrder", this.productPurchaseSer.getPurchaseOrder(request));
        modelMap.put("purchaseOrderDetail", JsonUtil.writeInternal(this.productPurchaseSer.getPurchaseOrderDetailList(request)));
        modelMap.put("purchaseOrderDetailCnt", this.productPurchaseSer.getPurchaseOrderDetailCnt(request));

        return modelMap;
    }

    /**
     * 修改采购单
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updatePurchaseOrder", method = RequestMethod.POST)
    @ResponseBody
    public String updatePurchaseOrder(HttpServletRequest request) {
        String returnString;
        try {
            returnString = this.productPurchaseSer.updatePurchaseOrder(request);
        } catch (Exception e) {
            e.printStackTrace();
            returnString = e.getMessage();
        }
        return returnString;
    }

    /**
     * 删除采购单详情中的某条记录
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/deletePurchaseOrderDetail", method = RequestMethod.POST)
    @ResponseBody
    public String deletePurchaseOrderDetail(HttpServletRequest request) {
        String returnString = this.productPurchaseSer.deletePurchaseOrderDetail(request);
        return returnString;
    }

    /**
     * 进入采购单打印预览界面
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewPurchaseOrderPreview", method = RequestMethod.GET)
    public ModelAndView viewPurchaseOrderPreview(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.utilityEmpInfoSer.getEmpBasicInfo(request));
        modelMap.put("purchaseOrder", this.productPurchaseSer.getPurchaseOrder(request));
        modelMap.put("purchaseOrderDetail", this.productPurchaseSer.getPurchaseOrderDetailList(request));
        modelMap.put("purchaseOrderDetailCnt", this.productPurchaseSer.getPurchaseOrderDetailCnt(request));
        modelMap.put("currentDate", DateUtil.getSysdateString("yyyy-MM-dd"));

        return new ModelAndView("/productStorage/proBusinessManage/viewPurchaseOrderPreview", modelMap);
    }

    /**
     * 审核人所看到的采购单信息
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @SuppressWarnings({})
    @RequestMapping(value = "/viewCheckPurchaseOrder", method = RequestMethod.GET)
    public ModelAndView viewCheckPurchaseOrder(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("purchaseOrder", this.productPurchaseSer.getPurchaseOrder(request));

        return new ModelAndView("/productStorage/proBusinessManage/viewCheckPurchaseOrder", modelMap);
    }

    /**
     * 导出出库记录
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/purchaseOrderToExcel")
    public void purchaseOrderToExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
        this.productPurchaseSer.purchaseOrderToExcel(request, response);
    }
}
