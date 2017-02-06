package com.siping.report.att.action;
  
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;  
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;   
  
import com.siping.report.att.service.monthly.AttExcelSer;

@Controller
@RequestMapping(value = "/report/att/month")
public class AttMonthReportCtroller {
	Logger logger = Logger.getLogger(AttMonthReportCtroller.class);
 
	@Autowired
	private AttExcelSer attExcelSer;
   
	@RequestMapping(value = "/viewAttMonthReport", method = RequestMethod.GET)
	public void viewPaResultReport(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		attExcelSer.viewAttMonthReport(request,response);
		 
	}  
}
