package com.siping.att.action.attendanceMintenance;

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

import com.siping.att.service.EmpCalendarSer; 
import com.siping.web.utility.service.UtilityEmpInfoSer;
@Controller
@RequestMapping(value = "/att/attendanceMintenance")
public class EmpCalendarController {
	Logger logger = Logger.getLogger(EmpCalendarController.class);
	@Autowired
	private EmpCalendarSer empCalendarSer;

	@Autowired
	private UtilityEmpInfoSer utilityEmpInfoSer;

	@RequestMapping(value = "/viewEmpCalendar",method = RequestMethod.GET)
	public ModelAndView addEmpShiftView(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		String calendarHtml = this.empCalendarSer.getEmpCalendarViewHtml(request) ;

		modelMap.put("basicInfo", this.utilityEmpInfoSer.getEmpBasicInfo(request));
		modelMap.put("calendarHtml", calendarHtml) ;
		return new ModelAndView("/att/attendanceMintenance/viewEmpCalendar",modelMap);
	}

	@RequestMapping(value = "/updateEmpCalendarInfo",method = RequestMethod.POST)
	@ResponseBody
	public String updateEmpCalendarInfo(HttpServletRequest request)throws Exception{
		this.empCalendarSer.updateEmpCalendarInfo(request) ;
		return "Y";
	}
	
}
