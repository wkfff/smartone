package com.siping.att.action.attendanceInfomation;
 
import java.util.List; 

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse; 
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod; 
import org.springframework.web.servlet.ModelAndView;

import com.siping.att.service.AttMonthSer; 
import com.siping.web.utility.JsonUtil; 


@Controller
@RequestMapping(value = "/att/attendanceInfomation")
public class AttPerInfoController {
	Logger logger = Logger.getLogger(AttPerInfoController.class);

	@Autowired
	private AttMonthSer attMonthSer;

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/viewAttPerInfo",method = RequestMethod.GET)
	public ModelAndView viewAttMonth(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		List getAttColumnsList  =  attMonthSer.getAttColumns(request);
		modelMap.put("attColumnsList", JsonUtil.writeInternal(getAttColumnsList));
		return new ModelAndView("",modelMap);
	} 
	 
}
