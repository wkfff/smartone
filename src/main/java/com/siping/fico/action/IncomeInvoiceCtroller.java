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

import com.siping.fico.service.IncomeInvoiceSer;
import com.siping.web.utility.ObjectBindUtil;

@Controller
@RequestMapping(value = "/fico/incomeInvoice")
public class IncomeInvoiceCtroller {

	Logger logger = Logger.getLogger(IncomeInvoiceCtroller.class);
	
	@Autowired
	private IncomeInvoiceSer incomeInvoiceSer; 
	
	
	/** View **/
	@RequestMapping(value="/viewInvoiceList", method=RequestMethod.GET)
	public ModelAndView viewIncomeInvoiceList(HttpServletRequest request, ModelMap modelMap){
		return new ModelAndView("/fico/incomeInvoice/viewInvoiceList",modelMap);
	}
	
	@RequestMapping(value="/viewInvoiceDetail", method=RequestMethod.GET)
	public ModelAndView viewIncomeInvoiceDetail(HttpServletRequest request, ModelMap modelMap){
		modelMap.put("invoiceDetail", this.incomeInvoiceSer.getInvoiceDetail(request));
		return new ModelAndView("/fico/incomeInvoice/viewInvoiceDetail", modelMap);
	}
	
	@RequestMapping(value="/addInvoice",method=RequestMethod.GET)
	public ModelAndView addInvoice(HttpServletRequest request, ModelMap modelMap){
		return new ModelAndView("/fico/incomeInvoice/addInvoice", modelMap);
	}
	
	@RequestMapping(value="/updateInvoice",method=RequestMethod.GET)
	public ModelAndView updateInvoice(HttpServletRequest request, ModelMap modelMap){
		modelMap.put("invoiceDetail", this.incomeInvoiceSer.getInvoiceDetail(request));
		modelMap.put("paramMap", ObjectBindUtil.getRequestParamData(request));
		return new ModelAndView("/fico/incomeInvoice/updateInvoice", modelMap);
	}
	
	/** GET **/
	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value="/getInvoiceList", method=RequestMethod.POST)
	@ResponseBody
	public Map getIncomeInvoiceList(HttpServletRequest request,ModelMap modelMap){
		List invoiceList = this.incomeInvoiceSer.getInvoiceList(request);
		modelMap.put("Rows", invoiceList);
		modelMap.put("Total", invoiceList==null?0:invoiceList.size());
		return modelMap;
	}
	
	@RequestMapping(value="/getInvoiceDetail", method=RequestMethod.POST)
	@ResponseBody
	public Object getInvoiceDetail(HttpServletRequest request,ModelMap modelMap){	
		return this.incomeInvoiceSer.getInvoiceDetail(request);
	}
	
	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value="/getPositionList", method=RequestMethod.POST)
	@ResponseBody
	public Map getIncomeInvoicePositionList(HttpServletRequest request,ModelMap modelMap){
		List invoicePositionList = this.incomeInvoiceSer.getPositionList(request);
		modelMap.put("Rows", invoicePositionList);
		modelMap.put("Total", invoicePositionList==null?0:invoicePositionList.size());
		return modelMap;
	}
	
		
	/** Add And Update **/
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/transferInvoice",method=RequestMethod.POST)
	@ResponseBody
	public Map transferInvoice(HttpServletRequest request, ModelMap modelMap){
		return incomeInvoiceSer.transferInvoice(request); 
	}
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/transferPositions",method=RequestMethod.POST)
	@ResponseBody
	public Map transferPosition(HttpServletRequest request, ModelMap modelMap){
		return this.incomeInvoiceSer.transferPositions(request);
	}
}
