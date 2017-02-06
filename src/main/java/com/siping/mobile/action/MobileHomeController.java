package com.siping.mobile.action;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.siping.mobile.service.MobileManageSer;
import com.siping.productStorage.service.ProductSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/mobile")
public class MobileHomeController {
    @Autowired
    private MobileManageSer mobileManageSer;
    @Autowired
    private ProductSer productSer;

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public ModelAndView home(HttpServletRequest request, ModelMap modelMap) {
        List advList = this.mobileManageSer.getMobileAdv(request);
        List<HashMap> areaList = this.mobileManageSer.getMobileAreaList(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        if(admin==null){//未登录时
            HashMap saleMode = new HashMap();
            saleMode.put("SALES_MODE_NO", "0");
            for (int i = 0; i < areaList.size(); i++) {
                HashMap map = areaList.get(i);
                request.setAttribute("M_AREA_NO", map.get("M_AREA_NO"));
                List proList = this.productSer.getProductList(request);
                this.mobileManageSer.setSalePrice(proList, saleMode);
                areaList.get(i).put("proList", proList);
            }
        }else{
            if("CU".equals(admin.getAccountType())){//登录用户为客户时
                String saleNo = this.mobileManageSer.getSalesModeNoByCu(admin.getAdminID());
                HashMap saleMode = new HashMap();
                saleMode.put("SALES_MODE_NO", saleNo);
                for (int i = 0; i < areaList.size(); i++) {
                    HashMap map = areaList.get(i);
                    request.setAttribute("M_AREA_NO", map.get("M_AREA_NO"));
                    List proList = this.productSer.getProductList(request);
                    this.mobileManageSer.setSalePrice(proList, saleMode);
                    areaList.get(i).put("proList", proList);
                }
            }else if("EM".equals(admin.getAccountType())){//登录用户为员工时
                List<HashMap> salesList = mobileManageSer.getSalesModelList(request);
                for (int i = 0; i < areaList.size(); i++) {
                    HashMap map = areaList.get(i);
                    request.setAttribute("M_AREA_NO", map.get("M_AREA_NO"));
                    List proList = this.productSer.getProductList(request);
                    this.mobileManageSer.setSalePrice(proList, salesList.get(0));
                    areaList.get(i).put("proList", proList);
                }
            }
        }
        modelMap.put("advList", advList);
        modelMap.put("areaList", areaList);

        return new ModelAndView("/mobile/home", modelMap);
    }
}
