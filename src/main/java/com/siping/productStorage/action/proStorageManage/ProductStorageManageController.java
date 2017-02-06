package com.siping.productStorage.action.proStorageManage;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

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

import com.siping.productStorage.service.ProductStorageManageSer;
import com.siping.productStorage.service.StorageManageSer;
import com.siping.system.bean.AdminBean;
import com.siping.system.service.SystemSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.JsonUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.service.UtilityEmpInfoSer;


@Controller
@RequestMapping(value="/productStorage/proStorageManage")
public class ProductStorageManageController {
    
    Logger logger = Logger.getLogger(ProductStorageManageController.class);

    @Autowired
    private UtilityEmpInfoSer utilityEmpInfoSer;
    @Autowired
    private ProductStorageManageSer productStorageManageSer;
    @Autowired
    private StorageManageSer storageManageSer;
    @Autowired
    private SystemSer systemSer;

    /**
     * 货品出库界面
     * @param request
     * @param modelMap
     * @return
     * @throws Exception 
     */
    @SuppressWarnings("rawtypes")
    @RequestMapping(value="/viewProductOutStorage", method=RequestMethod.GET)
    public ModelAndView viewProductOutStorage(HttpServletRequest request, ModelMap modelMap) throws Exception{
        List list = this.storageManageSer.getStorageName(request);
        modelMap.put("storageName", JsonUtil.writeInternal(list));
        return new ModelAndView("/productStorage/proStorageManage/viewProductOutStorage", modelMap);
    }
    /**
     * 返回出库历史记录页面
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value="/viewOutStorHistory", method=RequestMethod.GET)
    public ModelAndView viewOutStorHistory(HttpServletRequest request){
        return new ModelAndView("/productStorage/proStorageManage/viewOutStorHistory");
    }
    
    /**
     * 获取待出库销售单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value="/getSaleOrderList", method=RequestMethod.POST)
    @ResponseBody
    public Map getSaleOrderList(HttpServletRequest request) throws Exception {
//        String check_key = "";
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
//        Map map = this.systemSer.getApproverId("CheckType002");
//        if(map!=null){
//            check_key = map.get("CHECK_KEY").toString();
//        }
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID",admin.getCpnyId());
//        paramMap.put("CHECK_KEY", check_key);
        Map model = new HashMap();
        List saleOrderList = this.productStorageManageSer.getSaleOrderList(paramMap);
        int saleOrderListCnt = this.productStorageManageSer.getSaleOrderListCnt(paramMap);
        model.put("Rows", saleOrderList);
        model.put("Total", saleOrderListCnt);
        return model;
    }
    
    /**
     * 获取需要出库的某条销售单信息
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value="/getSalesOrderDetail", method=RequestMethod.POST)
    @ResponseBody
    public Map getSalesOrderDetail(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List saleOrderList = this.productStorageManageSer.getSalesOrderDetail(request);
        int saleOrderListCnt = this.productStorageManageSer.getSalesOrderDetailCnt(request);
        model.put("Rows", saleOrderList);
        model.put("Total", saleOrderListCnt);
        return model;
    }
    /**
     * 获取待出库的某条销售单详情
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value="/getSalesOrderInfo", method=RequestMethod.POST)
    @ResponseBody
    public Map getSalesOrderInfo(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List saleOrderList = this.productStorageManageSer.getSalesOrderInfo(request);
        int saleOrderListCnt = this.productStorageManageSer.getSalesOrderInfoCnt(request);
        model.put("Rows", saleOrderList);
        model.put("Total", saleOrderListCnt);
        return model;
    }
    /**
     * 获取货品在仓库的库存量
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/getLeftQuantity", method=RequestMethod.POST)
    @ResponseBody
    public Double getLeftQuantity(HttpServletRequest request) throws Exception {
        double proCnt = 0;
        proCnt = this.productStorageManageSer.getLeftQuantity(request);
        return proCnt;
    }
    /**
     * 出库操作
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/saveOutStorage", method=RequestMethod.POST)
    @ResponseBody
    public String saveOutStorage(HttpServletRequest request){
        String returnString = "N";
        try {
            returnString = this.productStorageManageSer.saveOutStorage(request);
        } catch (Exception e) {
            e.printStackTrace();
            returnString = "出库失败！";
        }
        return returnString;
    }
    /**
     * 查看历史出库单
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value="/viewOutStorHistoryList", method=RequestMethod.POST)
    @ResponseBody
    public Map viewOutStorHistoryList(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List historyList = this.productStorageManageSer.viewOutStorHistoryList(request);
        int historyListCnt = this.productStorageManageSer.viewOutStorHistoryListCnt(request);
        model.put("Rows", historyList);
        model.put("Total", historyListCnt);
        return model;
    }
    /**
     * 查看历史出库单的商品详情
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @RequestMapping(value="/viewOutStorHistoryDetail", method=RequestMethod.POST)
    @ResponseBody
    public Map viewOutStorHistoryDetail(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List historyDetail = this.productStorageManageSer.viewOutStorHistoryDetail(request);
        int historyDetailCnt = this.productStorageManageSer.viewOutStorHistoryDetailCnt(request);
        model.put("Rows", historyDetail);
        model.put("Total", historyDetailCnt);
        return model;
    }
    /**
     * 导出出库记录
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/exportOutStorInfo")
    public String exportOutStorInfo(HttpServletRequest request,HttpServletResponse response) throws Exception {
        String returnString = "N";
        returnString = this.productStorageManageSer.exportOutStorInfo(request,response);
        return returnString;
    }
    /**
     * 获取货品在仓库的最小库存量
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/getMinStorQuantity", method=RequestMethod.POST)
    @ResponseBody
    public Double getMinStorQuantity(HttpServletRequest request) throws Exception {
        double minCnt = 0;
        minCnt = this.productStorageManageSer.getMinStorQuantity(request);
        return minCnt;
    }
    /**
     * 进入出库单打印预览界面
     * @param request
     * @param modelMap
     * @return
     * @throws Exception 
     */
    @RequestMapping(value="/viewOutstorageOrderPreview", method=RequestMethod.GET)
    public ModelAndView viewPurchaseOrderPreview(HttpServletRequest request, ModelMap modelMap) throws Exception{
        modelMap.put("basicInfo",this.utilityEmpInfoSer.getEmpBasicInfo(request));
        modelMap.put("outstorageOrder",this.productStorageManageSer.getOutstorageOrderById(request));
        modelMap.put("outstorageOrderDetail",this.productStorageManageSer.viewOutStorHistoryDetail(request));
        modelMap.put("outstorageOrderDetailCnt",this.productStorageManageSer.viewOutStorHistoryDetailCnt(request));
        modelMap.put("currentDate",DateUtil.getSysdateString("yyyy-MM-dd"));
        
        return new ModelAndView("/productStorage/proStorageManage/viewOutstorageOrderPreview", modelMap);
    }
    /**
     * 返回销售单详情页面
     *
     * @param request
     * @param modelMap
     * @return
     * @throws Exception 
     */
    @RequestMapping(value = "/viewSaleOrderDetail", method = GET)
    public ModelAndView viewSaleOrderDetail(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("paraMap", this.productStorageManageSer.viewSaleOrderDetail(request));
        return new ModelAndView("/productStorage/proStorageManage/viewSaleOrderDetail", modelMap);
    }
    /**
     * 获取待出库的某条销售单详情
     *
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({"rawtypes", "unchecked"})
    @RequestMapping(value = "/viewSaleOrderDetailInfo", method = POST)
    @ResponseBody
    public Map viewSaleOrderDetailInfo(HttpServletRequest request) throws Exception {
        Map model = new HashMap();
        List saleOrderList = this.productStorageManageSer.viewSaleOrderDetailInfo(request);
        int saleOrderListCnt = this.productStorageManageSer.viewSaleOrderDetailInfoCnt(request);
        model.put("Rows", saleOrderList);
        model.put("Total", saleOrderListCnt);
        return model;
    }

    @RequestMapping(value="/checkReceiverPhoneNum", method=RequestMethod.POST)
    @ResponseBody
    public String checkReceiverPhoneNum(String saleOrderNo) {
        String returnStr = "";
        try {
            returnStr = this.productStorageManageSer.checkReceiverPhoneNum(saleOrderNo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnStr;
    }
}
