package com.siping.cust.action;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.cust.service.CustAppendixSer;
import com.siping.web.utility.ObjectBindUtil;

@Controller
@RequestMapping(value="/cust/custAppendix")
public class CustAppendixCtroller {
	
	@Autowired
	private CustAppendixSer custAppendixSer;
	
	@RequestMapping(value="/viewAppendixList", method=RequestMethod.GET)
	public ModelAndView viewAppendixList(HttpServletRequest request, ModelMap modelMap){
		modelMap.put("appendixDetail",ObjectBindUtil.getRequestParamData(request) );
		return new ModelAndView("/cust/custAppendix/viewAppendixList", modelMap);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value="/getAppendixList", method=RequestMethod.POST)
	@ResponseBody
	public Map getAppendixList(HttpServletRequest request, HttpServletResponse response){
		Map modelMap = new HashMap();
		modelMap.put("Rows",this.custAppendixSer.getAppendixList(request));
		modelMap.put("Total", this.custAppendixSer.getAppendixListCnt(request));
		return modelMap;
	}
	
	@RequestMapping(value="/removeAppendix",method=RequestMethod.GET)
	public ModelAndView removeAppendix(HttpServletRequest request, ModelMap modelMap){
		modelMap.put("appendixDetail",ObjectBindUtil.getRequestParamData(request));
		return new ModelAndView("/cust/custAppendix/removeAppendix");
	}
	
	@RequestMapping(value="/removeAppendix")
	@ResponseBody
	public String removeAppendix(HttpServletRequest request, HttpServletResponse response) throws SQLException{
		return this.custAppendixSer.removeAppendix(request);
	}
	
}
