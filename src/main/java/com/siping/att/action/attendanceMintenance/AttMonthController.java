package com.siping.att.action.attendanceMintenance;

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
import com.siping.att.service.AttMonthSer; 
import com.siping.web.utility.JsonUtil; 


@Controller
@RequestMapping(value = "/att/attendanceMintenance")
public class AttMonthController {
	Logger logger = Logger.getLogger(AttMonthController.class);
	
	@Autowired
	private AttMonthSer attMonthSer;
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/viewAttMonth",method = RequestMethod.GET)
	public ModelAndView viewAttMonth(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{ 
		List getAttColumnsList  =  attMonthSer.getAttColumns(request);  
		modelMap.put("attColumnsList", JsonUtil.writeInternal(getAttColumnsList));
		return new ModelAndView("/att/attendanceMintenance/viewAttMonth",modelMap);
	} 
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getAttMonthInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getAttMonthInfo(HttpServletRequest request)throws Exception{
		List infoList = this.attMonthSer.getAttMonthInfo(request) ;
		int infoCnt=this.attMonthSer.getAttMonthInfoCnt(request);
		Map model=new HashMap();
		model.put("Rows", infoList) ;
		model.put("Total", infoCnt) ;
		return model;
	}

	@RequestMapping(value = "/updateAttMonthInfo",method = RequestMethod.POST)
	@ResponseBody
	public String updateAttMonthInfo (HttpServletRequest request)throws Exception{
		this.attMonthSer.updateAttMonthInfo(request);
		return "Y";
	}
}
