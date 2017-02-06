package com.siping.pa.action.wagebase;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.pa.service.wagebase.PaAccountSer;

@Controller
@RequestMapping(value = "/pa/wagebase")
public class PaAccountCtroller {
	Logger logger = Logger.getLogger(PaAccountCtroller.class);
	
	@Autowired
	private PaAccountSer paAccountSer ;
	
	@RequestMapping(value = "/viewPaAccountInfo",method = RequestMethod.GET)
	public ModelAndView viewPaAccountInfo(HttpServletRequest request,ModelMap modelMap) throws Exception{
		
		return new ModelAndView("/pa/wagebase/viewPaAccountInfo",modelMap);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getPaAccountInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getPaAccountInfo(HttpServletRequest request)throws Exception{
		List paAccountList = this.paAccountSer.getPaAccountInfo(request) ;
		int paAccountListCnt = this.paAccountSer.getPaAccountInfoCnt(request) ;
		Map model=new HashMap();
		model.put("Rows", paAccountList) ;
		model.put("Total", paAccountListCnt) ;
		
		return model;
	}
	
	@RequestMapping(value = "/updatePaAccountInfo",method = RequestMethod.POST)
	@ResponseBody
	public String updatePaAccountInfo(HttpServletRequest request)throws Exception{
		return this.paAccountSer.updatePaAccountInfo(request) ;
	}
	
	@RequestMapping(value = "/viewPaWhSummery",method = RequestMethod.GET)
	public ModelAndView viewWhSummery(HttpServletRequest request,ModelMap modelMap) throws Exception{
		
		return new ModelAndView("/pa/wagebase/viewPaWhSummery",modelMap);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getPaWhInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getWhInfo(HttpServletRequest request)throws Exception{
		List paWhInfoList = this.paAccountSer.getPaWhInfoList(request) ;
		int paWhInfoListCnt = this.paAccountSer.getPaWhInfoListCnt(request) ;
		Map model=new HashMap();
		model.put("Rows", paWhInfoList) ;
		model.put("Total", paWhInfoListCnt) ;
		
		return model;
	}
}
