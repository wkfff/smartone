package com.siping.fico.action;

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

import com.siping.fico.service.AccountSer;

@Controller
@RequestMapping(value = "/fico/account")
public class AccountCtroller {

	Logger logger = Logger.getLogger(AccountCtroller.class);
	
	@Autowired
	private AccountSer accountSer; 
	
	
	/** View **/
	@RequestMapping(value="/viewAccountList", method=RequestMethod.GET)
	public ModelAndView viewAccountList(HttpServletRequest request, ModelMap modelMap){
		return new ModelAndView("/fico/account/viewAccountList",modelMap);
	}
	
	@RequestMapping(value="/updateAccount",method=RequestMethod.GET)
	public ModelAndView updateAccount(HttpServletRequest request, ModelMap modelMap){
		return new ModelAndView("/fico/account/updateAccount", modelMap);
	}	
	
	
	/** GET **/
	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value="/getAccountList", method=RequestMethod.POST)
	@ResponseBody
	public Map getAccountList(HttpServletRequest request,ModelMap modelMap){
		List invoiceList = this.accountSer.getAccountList(request);
		modelMap.put("Rows", invoiceList);
		modelMap.put("Total", invoiceList==null?0:invoiceList.size());
		return modelMap;
	}
		
	/** Add And Update **/
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/transferAccounts",method=RequestMethod.POST)
	@ResponseBody
	public Map transferAccounts(HttpServletRequest request, ModelMap modelMap){
		return accountSer.transferAccounts(request); 
	}
	
	/** REMOVE **/	
}
