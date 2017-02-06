package com.siping.cust.action;

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

import com.siping.cust.service.SupplierAccountManagerSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value="/cust/supplierAccoutManager")
public class SupplierAccountManagerController {

	@Autowired
	private SupplierAccountManagerSer supplierAccountSer;
	//跳转到账户管理页面
	@RequestMapping(value="/viewSupplierAccount",method=RequestMethod.GET)
	public ModelAndView viewSupplierAccount(HttpServletRequest request)
	{
		return new ModelAndView("/cust/supperlierManager/viewSupplierAccountList");
	}
	//查询出所有的供应商登录账户
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@ResponseBody
	@RequestMapping(value="/getSupplierAccountModelList",method=RequestMethod.POST)
	public Map getSupplierAccountModelList(HttpServletRequest request)
	{
		List list= this.supplierAccountSer.getSupplierModelList(request) ;
		int total=this.supplierAccountSer.getSupplierModelCnt(request);
		Map map=new HashMap();
		map.put("Rows", list);
		map.put("Total", total);
		return map;
		
	}
	
	@ResponseBody
	@RequestMapping(value="/addOrUpdateSupplierAccountModel")
	public String addOrUpdateSupplierAccountModel(HttpServletRequest request)
	{
		String returnString;
		returnString=this.supplierAccountSer.addOrUpdateSupplierAccount(request);
		return returnString;
	}
	
	@ResponseBody
	@RequestMapping(value="/deleteSupplierAccountModel")
	public String deleteSupplierAccountModel(HttpServletRequest request)
	{
		String returnString;
		returnString=this.supplierAccountSer.deleteSupplierAccount(request);
		return returnString;
	}
	
	@RequestMapping(value="/changeSupplierPassword")
	public ModelAndView changeSupplierPassword(HttpServletRequest request)
	{
		AdminBean admin=SessionUtil.getLoginUserFromSession(request);
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("admin",admin);
		return new ModelAndView("/cust/supperlierManager/changeSupplierPassword","map",map);
	}
	
	@ResponseBody
	@RequestMapping(value="/getSupplierByPassword",method=RequestMethod.POST)
	public int getSupplierByPassword(HttpServletRequest request)
	{
		return this.supplierAccountSer.getSupplierByPassword(request);
	}

	@ResponseBody
	@RequestMapping(value="/updateSupplierPassword",method=RequestMethod.POST)
	public String updateSupplierPassword(HttpServletRequest request)
	{
		return this.supplierAccountSer.updateSupplierPassword(request);
	}
	
	@ResponseBody
	@RequestMapping(value="/toggleSupplierActivity",method=RequestMethod.POST)
	public String toggleSupplierActivity(HttpServletRequest request)
	{
		return this.supplierAccountSer.toggleSupplierActivity(request);
	}
	
}
