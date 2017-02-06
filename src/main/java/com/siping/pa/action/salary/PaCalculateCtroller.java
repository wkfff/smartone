package com.siping.pa.action.salary;

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

import com.siping.pa.service.salary.PaCalculateSer;
import com.siping.pa.service.salary.PaResultSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.JsonUtil;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/pa/salary")
public class PaCalculateCtroller {
	Logger logger = Logger.getLogger(PaCalculateCtroller.class);

	@Autowired
	private PaCalculateSer paCalculateSer;
	
	@Autowired
	private PaResultSer paResultSer;
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/viewPaCalculate", method = RequestMethod.GET)
	public ModelAndView viewPaCalculate(HttpServletRequest request,ModelMap modelMap) throws Exception {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		modelMap.put("empID", admin.getAdminID());
		List  paColumnsList  =  this.paResultSer.getPaColumns(request);
		modelMap.put("paColumnsList", JsonUtil.writeInternal(paColumnsList));
		
		return new ModelAndView("/pa/salary/viewPaCalculate", modelMap);
	}

	@RequestMapping(value = "/paCalculate", method = RequestMethod.POST)
	@ResponseBody
	public String paCalculate(HttpServletRequest request) throws Exception {

		return this.paCalculateSer.paCalculate(request);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getPaMonInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getPaMonInfo(HttpServletRequest request, ModelMap modelMap) throws Exception {
		List infoList = this.paCalculateSer.getPaMonInfo(request) ;
		int infoCnt= this.paCalculateSer.getPaMonInfoCnt(request);
		
		Map model=new HashMap();
		model.put("Rows", infoList) ;
		model.put("Total", infoCnt) ;
		
		return model;
	}
	
	@RequestMapping(value = "/updatePaMonthInfo",method = RequestMethod.POST)
	@ResponseBody
	public String updatePaMonthInfo (HttpServletRequest request)throws Exception{
	 
		return this.paCalculateSer.updatePaMonthInfo(request) ;
	}
}
