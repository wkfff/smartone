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

import com.siping.cust.service.SupplierAccountSelfManagerSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value="/cust/supplierAccountSelfManager")
public class SupplierAccountSelfManagerController {

	@Autowired
	private SupplierAccountSelfManagerSer supplierAccountSelfSer;
	//跳转到账户管理页面
	@RequestMapping(value="/viewSupplierAccountSelf",method=RequestMethod.GET)
	public ModelAndView viewSupplierAccountSelf(HttpServletRequest request)
	{
		return new ModelAndView("/cust/supperlierManager/viewSupplierAccountSelfList");
	}
	//查询出所有的供应商登录账户
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@ResponseBody
	@RequestMapping(value="/getSupplierAccountSelfModelList",method=RequestMethod.POST)
	public Map getSupplierAccountSelfModelList(HttpServletRequest request)
	{
		List list= this.supplierAccountSelfSer.getSupplierModelList(request) ;
		int total=this.supplierAccountSelfSer.getSupplierModelCnt(request);
		Map map=new HashMap();
		map.put("Rows", list);
		map.put("Total", total);
		return map;
		
	}
	
	@ResponseBody
	@RequestMapping(value="/addOrUpdateSupplierAccountSelfModel")
	public String addOrUpdateSupplierAccountSelfModel(HttpServletRequest request)
	{
		String returnString;
		returnString=this.supplierAccountSelfSer.addOrUpdateSupplierAccountSelf(request);
		return returnString;
	}
	
	@ResponseBody
	@RequestMapping(value="/deleteSupplierAccountSelfModel")
	public String deleteSupplierAccountSelfModel(HttpServletRequest request)
	{
		String returnString;
		returnString=this.supplierAccountSelfSer.deleteSupplierAccountSelf(request);
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
		return this.supplierAccountSelfSer.getSupplierByPassword(request);
	}

	@ResponseBody
	@RequestMapping(value="/updateSupplierPassword",method=RequestMethod.POST)
	public String updateSupplierPassword(HttpServletRequest request)
	{
		return this.supplierAccountSelfSer.updateSupplierPassword(request);
	}
	
	@ResponseBody
	@RequestMapping(value="/toggleSupplierActivity",method=RequestMethod.POST)
	public String toggleSupplierActivity(HttpServletRequest request){
		return this.supplierAccountSelfSer.toggleSupplierActivity(request);
	}
}
