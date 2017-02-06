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
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.JsonUtil; 
import com.siping.web.utility.SessionUtil;


@Controller
@RequestMapping(value = "/att/attendanceInfomation")
public class AttReportController {
	Logger logger = Logger.getLogger(AttReportController.class);

	@Autowired
	private AttMonthSer attMonthSer;

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/viewAttReportInfo",method = RequestMethod.GET)
	public ModelAndView viewAttReport(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		List getAttColumnsList  =  attMonthSer.getAttColumns(request);
		modelMap.put("attColumnsList", JsonUtil.writeInternal(getAttColumnsList));
		return new ModelAndView("",modelMap);
	}

	@RequestMapping(value = "/viewPersonalRecords",method = RequestMethod.GET)
	public ModelAndView viewPersonalRecords(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		modelMap.put("E_DATE",DateUtil.getSysdateString("yyyy-MM-dd"));
		modelMap.put("S_DATE",DateUtil.getSysdateString("yyyy-MM-dd"));
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		modelMap.put("EMPID", admin.getAdminID());
		return new ModelAndView("/att/attendanceInfomation/viewPersonalRecords",modelMap);
	}
}
