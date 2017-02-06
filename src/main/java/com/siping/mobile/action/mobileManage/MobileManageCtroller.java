package com.siping.mobile.action.mobileManage;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.mobile.service.MobileManageSer;
import com.siping.productStorage.service.ProductSer;
import com.siping.web.bean.Pagging;

@Controller
@RequestMapping(value="/mobile/mobileManage")
public class MobileManageCtroller {
    Logger logger = Logger.getLogger(MobileManageCtroller.class);
	@Autowired
	private MobileManageSer mobileManageSer;
	@Autowired
	private ProductSer productSer;
	
	@RequestMapping(value="/viewAreaManage",method=RequestMethod.GET)
	public ModelAndView viewAreaManage(HttpServletRequest request, ModelMap modelMap){
		return new ModelAndView("/mobile/mobileManage/viewMobileManage", modelMap);
	}
	
	@RequestMapping(value="/viewAdvManage",method=RequestMethod.GET)
	public ModelAndView viewAdvManage(HttpServletRequest request, ModelMap modelMap){
		return new ModelAndView("/mobile/mobileManage/viewAdvManage", modelMap);
	}
	
	/**
     * 获取专区信息
     * 
     * @param request
     * @return
     * @throws Exception
     */ 
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getMobileAreaList", method = RequestMethod.POST)
    @ResponseBody
    public Map getMobileAreaList(HttpServletRequest request) throws Exception {
        List list = this.mobileManageSer.getMobileAreaList(request);
        int cnt = this.mobileManageSer.getMobileAreaListCnt(request);
        Map model = new HashMap();
        model.put("Rows", list);
        model.put("Total", cnt);
        
        return model;
    }
    
    @RequestMapping(value = "/deleteMobileArea", method = RequestMethod.POST)
    @ResponseBody
    public String deleteMobileArea(HttpServletRequest request) throws Exception {
        String returnString = "Y";
        returnString = this.mobileManageSer.deleteMobileArea(request);
        return returnString;
    }
    
    @RequestMapping(value = "/saveOrUpdateMobileArea", method = RequestMethod.POST)
    @ResponseBody
    public String saveOrUpdateMobileArea(HttpServletRequest request) throws Exception {
        String returnString = "Y";
        returnString = this.mobileManageSer.saveOrUpdateMobileArea(request);
        return returnString;
    }
    
    /**
     * 获取专区商品
     * 
     * @param request
     * @return
     * @throws Exception
     */ 
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getProductByArea", method = RequestMethod.POST)
    @ResponseBody
    public Map getProductByArea(HttpServletRequest request) throws Exception {
        List list = this.productSer.getProductList(request);
        int cnt = this.productSer.getProductListCnt(request);
        
        Pagging page = new Pagging(Integer.valueOf(request.getParameter("page")), cnt, Integer.valueOf(request.getParameter("pagesize")));
        
        Map model = new HashMap();
        model.put("Rows", list);
        model.put("Total", cnt);
        model.put("page", page);
        
        return model;
    }
    
    @RequestMapping(value = "/saveProductToArea", method = RequestMethod.POST)
    @ResponseBody
    public String saveProductToArea(HttpServletRequest request) throws Exception {
        String returnString = "Y";
        returnString = this.mobileManageSer.saveProductToArea(request);
        return returnString;
    }
    
    /**
     * 获取专区信息
     * 
     * @param request
     * @return
     * @throws Exception
     */ 
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getMobileAdv", method = RequestMethod.POST)
    @ResponseBody
    public Map getMobileAdv(HttpServletRequest request) throws Exception {
        List list = this.mobileManageSer.getMobileAdv(request);
        int cnt = this.mobileManageSer.getMobileAdvCnt(request);
        Map model = new HashMap();
        model.put("Rows", list);
        model.put("Total", cnt);
        
        return model;
    }
    
    @RequestMapping(value = "/addOrUpdateMobileAdv", method = RequestMethod.POST)
    @ResponseBody
    public String addOrUpdateMobileAdv(HttpServletRequest request) throws Exception {
        String returnString = "Y";
        returnString = this.mobileManageSer.addOrUpdateMobileAdv(request);
        return returnString;
    }
    
    @RequestMapping(value = "/deleteMobileAdv", method = RequestMethod.POST)
    @ResponseBody
    public String deleteMobileAdv(HttpServletRequest request) throws Exception {
        String returnString = "Y";
        returnString = this.mobileManageSer.deleteMobileAdv(request);
        return returnString;
    }
}
