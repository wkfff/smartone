package com.siping.report.hrm.action;
  
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;  
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;   
   
import com.siping.report.hrm.service.HrEmpInfoExcelSer;

@Controller
@RequestMapping(value = "/report/hrm")
public class HrEmpInfoReportCtroller {
	Logger logger = Logger.getLogger(HrEmpInfoReportCtroller.class);
 
	@Autowired
	private HrEmpInfoExcelSer hrEmpInfoExcelSer;
   
	@RequestMapping(value = "/viewEmpInfoReport", method = RequestMethod.GET)
	public void viewEmpInfoReport(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		hrEmpInfoExcelSer.viewEmpInfoReport(request,response);
		 
	}  
}
