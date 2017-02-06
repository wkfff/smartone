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

import com.siping.fico.service.InvoiceSer;
import com.siping.web.utility.ObjectBindUtil;

@Controller
@RequestMapping(value = "/fico/invoice")
public class InvoiceCtroller {

	Logger logger = Logger.getLogger(InvoiceCtroller.class);
	
	@Autowired
	private InvoiceSer invoiceSer; 
	
	
	/** View **/
	@RequestMapping(value="/viewInvoiceList", method=RequestMethod.GET)
	public ModelAndView viewInvoiceList(HttpServletRequest request, ModelMap modelMap){
		return new ModelAndView("/fico/invoice/viewInvoiceList",modelMap);
	}
	
	@RequestMapping(value="/viewInvoiceDetail", method=RequestMethod.GET)
	public ModelAndView viewInvoiceDetail(HttpServletRequest request, ModelMap modelMap){
		modelMap.put("invoiceDetail", this.invoiceSer.getInvoiceDetail(request));
		return new ModelAndView("/fico/invoice/viewInvoiceDetail", modelMap);
	}
	
	@RequestMapping(value="/addInvoice",method=RequestMethod.GET)
	public ModelAndView addInvoice(HttpServletRequest request, ModelMap modelMap){
		return new ModelAndView("/fico/invoice/addInvoice", modelMap);
	}
	
	@RequestMapping(value="/updateInvoice",method=RequestMethod.GET)
	public ModelAndView updateInvoice(HttpServletRequest request, ModelMap modelMap){
		modelMap.put("invoiceDetail", this.invoiceSer.getInvoiceDetail(request));
		modelMap.put("paramMap", ObjectBindUtil.getRequestParamData(request));
		return new ModelAndView("/fico/invoice/updateInvoice", modelMap);
	}	
	
	
	/** GET **/
	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value="/getInvoiceList", method=RequestMethod.POST)
	@ResponseBody
	public Map getInvoiceList(HttpServletRequest request,ModelMap modelMap){
		List invoiceList = this.invoiceSer.getInvoiceList(request);
		modelMap.put("Rows", invoiceList);
		modelMap.put("Total", invoiceList==null?0:invoiceList.size());
		return modelMap;
	}
	
	@RequestMapping(value="/getInvoiceDetail", method=RequestMethod.POST)
	@ResponseBody
	public Object getInvoiceDetail(HttpServletRequest request,ModelMap modelMap){	
		return this.invoiceSer.getInvoiceDetail(request);
	}
	
	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value="/getPositionList", method=RequestMethod.POST)
	@ResponseBody
	public Map getPositionList(HttpServletRequest request,ModelMap modelMap){
		List positionList = this.invoiceSer.getPositionList(request);
		modelMap.put("Rows", positionList);
		modelMap.put("Total", positionList==null?0:positionList.size());
		return modelMap;
	}
	
		
	/** Add And Update **/
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/transferInvoice",method=RequestMethod.POST)
	@ResponseBody
	public Map transferInvoice(HttpServletRequest request, ModelMap modelMap){
		return invoiceSer.transferInvoice(request); 
	}
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/transferPositions",method=RequestMethod.POST)
	@ResponseBody
	public Map transferPosition(HttpServletRequest request, ModelMap modelMap){
		return this.invoiceSer.transferPositions(request);
	}
	
	/** REMOVE **/	
}
