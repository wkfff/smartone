package com.siping.mobile.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.siping.doc.service.DocInfoSer;
import com.siping.mobile.service.MobileManageSer;
import com.siping.productStorage.service.ProductSer;
import com.siping.productStorage.service.SalesModelSer;
import com.siping.system.bean.AdminBean;
import com.siping.system.service.BasicMaintenanceSer;
import com.siping.web.bean.Pagging;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value="/mobile/productManage")
public class MobileProManageCtroller {
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

    /**
     * 手机端查看商品详细信息
     * @param request
     * @param modelMap
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value="/viewMobileProDetail",method=RequestMethod.GET)
    public ModelAndView viewMobileProDetail(HttpServletRequest request, ModelMap modelMap){
        List<HashMap> list = productSer.getProductList(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        if(admin==null){
            String saleNo = "0";
            HashMap map = new HashMap();
            map.put("SALES_MODE_NO", saleNo);
            this.mobileManageSer.setSalePrice(list, map);
            modelMap.put("saleMode", map);
        }else{
            if("CU".equals(admin.getAccountType())){
                String saleNo = this.mobileManageSer.getSalesModeNoByCu(admin.getAdminID());
                HashMap map = new HashMap();
                map.put("SALES_MODE_NO", saleNo);
                this.mobileManageSer.setSalePrice(list, map);
                modelMap.put("saleMode", map);
            }else if("EM".equals(admin.getAccountType())){
              //设置商品移动端所要显示销售渠道价格
                List<HashMap> salesList = mobileManageSer.getSalesModelList(request);
                if(salesList.size()>0){
                    this.mobileManageSer.setSalePrice(list, salesList.get(0));
                    modelMap.put("saleMode", salesList.get(0));
                }
            }
        }
        //设置页面显示销售渠道价格
        if(list.size()>0){
            modelMap.put("product", list.get(0));
        }
        return new ModelAndView("/mobile/productManage/viewMobileProDetail", modelMap);
    }
    /**
     * 手机端查看商品搜索列表
     * @param request
     * @param modelMap
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value="/viewMobileProList",method=RequestMethod.GET)
    public ModelAndView viewMobileProList(HttpServletRequest request, ModelMap modelMap){
        List<HashMap> proList = productSer.getProductList(request);
        int proListCnt = productSer.getProductListCnt(request);
        //Pagging类用于分页
        int currPage = Integer.parseInt(request.getParameter("page").toString());
        Pagging page = new Pagging(currPage, proListCnt, 10);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        
        if(admin==null){
            String saleNo = "0";
            HashMap map = new HashMap();
            map.put("SALES_MODE_NO", saleNo);
            this.mobileManageSer.setSalePrice(proList, map);
            modelMap.put("saleMode", map);
        }else{
            if("CU".equals(admin.getAccountType())){
                String saleNo = this.mobileManageSer.getSalesModeNoByCu(admin.getAdminID());
                HashMap map = new HashMap();
                map.put("SALES_MODE_NO", saleNo);
                this.mobileManageSer.setSalePrice(proList, map);
                modelMap.put("saleMode", map);
            }else if("EM".equals(admin.getAccountType())){
              //设置商品移动端所要显示销售渠道价格
                List<HashMap> salesList = mobileManageSer.getSalesModelList(request);
                if(salesList.size()>0){
                    this.mobileManageSer.setSalePrice(proList, salesList.get(0));
                    modelMap.put("saleMode", salesList.get(0));
                }
            }
        }
        //将所传参数亦传到页面相关显示-如类别-关键字
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        modelMap.put("productList", proList);
        modelMap.put("page", page);
        modelMap.put("paramMap", paramMap);
        return new ModelAndView("/mobile/productManage/viewMobileProList", modelMap);
    }
    
    /**
     * 手机端查看商品类目
     * @param request
     * @param modelMap
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value="/viewMobileCategory",method=RequestMethod.GET)
    public ModelAndView viewMobileCategory(HttpServletRequest request, ModelMap modelMap){
        //获取所有类别
        List<HashMap> list = basicMaintenanceSer.getCategoryList(request);
        List<HashMap> reList = new ArrayList();
        //获取根类并提取出子孙类作为平级显示
        this.mobileManageSer.setSonNodes(list,reList);
        modelMap.put("categoryList", reList);
        return new ModelAndView("/mobile/productManage/viewMobileCategory", modelMap);
    }
}
