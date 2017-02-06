package com.siping.cust.action;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.testng.log4testng.Logger;

import com.siping.cust.service.SupplierProductManagerSer;

@Controller
@RequestMapping(value="/cust/supperlierProductManager")
public class SupplierProductManagerController {
	
	public static final String SUCCESS="Y";
	Logger logger=Logger.getLogger(SupplierProductManagerController.class);
	
	@Autowired
	private SupplierProductManagerSer supplierProductManagerSer;
	//跳转到供应商添加商品和显示商品页面
	@RequestMapping(value="/viewSupplierProductList",method=RequestMethod.GET)
	public  ModelAndView viewSupplierProductList(HttpServletRequest request)
	{
		return new ModelAndView("/cust/supperlierManager/viewSupplierProductManager");
	}
	@ResponseBody
	@RequestMapping(value="/addOrUpdateSupplierProduct",method=RequestMethod.POST)
	public String addOrUpdateSupplierProduct(HttpServletRequest request) throws SQLException
	{
		String returnString="";
		returnString= supplierProductManagerSer.addOrUpdateProduct(request);
		return returnString;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value="/getSupplierProductList")
	public Map getSupplierProductList(HttpServletRequest request)
	{
		List supperlistProduct=this.supplierProductManagerSer.getSupplierProductList(request);
		int total=this.supplierProductManagerSer.getSupplierProductCnt(request);
		Map map=new HashMap();
		
		map.put("Rows", supperlistProduct);
		map.put("Total", total);
		return map;
	}
	@ResponseBody
	@RequestMapping(value="/deleteSupplierProduct",method=RequestMethod.POST)
	public String deleteSupplierProduct(HttpServletRequest request)
	{
		String returnString="Y";
		returnString=this.supplierProductManagerSer.deleteSupplierProduct(request);
		return returnString;
	}
}
