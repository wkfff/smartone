package com.siping.web.utility.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.web.utility.service.*;

@Controller
@RequestMapping(value = "/utility/proInfo")
public class UtilityProdInfoCtroller {

    @Autowired
    private UtilityProdInfoSer utilityProdInfoSer;

    @RequestMapping(value = "/viewProductList", method = RequestMethod.GET)
    public ModelAndView viewProductList(HttpServletRequest request) {
        return new ModelAndView("/web/utility/proInfo/searchProduct");
    }

    @RequestMapping(value = "/viewStorageList", method = RequestMethod.GET)
    public ModelAndView viewStorageList(HttpServletRequest request) {
        return new ModelAndView("/web/utility/proInfo/searchStorage");
    }

    @RequestMapping(value = "/viewBasicProductList", method = RequestMethod.GET)
    public ModelAndView viewBasicProductList(HttpServletRequest request) {
        return new ModelAndView("/web/utility/proInfo/searchBasicProduct");
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getProductList", method = RequestMethod.POST)
    @ResponseBody
    public Map getProductList(HttpServletRequest request, HttpServletResponse response) {
        Map modelMap = new HashMap();
        modelMap.put("Rows", this.utilityProdInfoSer.getProductList(request));
        modelMap.put("Total", this.utilityProdInfoSer.getProductListCnt(request));
        return modelMap;
    }

    @RequestMapping(value = "/viewProductListB", method = RequestMethod.GET)
    public ModelAndView viewProductListB(HttpServletRequest request) {
        return new ModelAndView("/web/utility/productInfo/searchProduct");
    }

    @RequestMapping(value = "/viewProductListC", method = RequestMethod.GET)
    public ModelAndView viewProductListC(HttpServletRequest request) {
        return new ModelAndView("/web/utility/productInfo/searchProductC");
    }

    @RequestMapping(value = "/viewSalesModeList", method = RequestMethod.GET)
    public ModelAndView viewSalesModeList(HttpServletRequest request) {
        return new ModelAndView("/web/utility/productInfo/searchSalesMode");
    }
}
