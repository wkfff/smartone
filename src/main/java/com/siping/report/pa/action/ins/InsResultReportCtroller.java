package com.siping.report.pa.action.ins;
  
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller; 
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;  
import org.springframework.web.servlet.ModelAndView;
 
import com.siping.report.pa.service.ins.InsExcelSer;

@Controller
@RequestMapping(value = "/report/pa/ins")
public class InsResultReportCtroller {
	Logger logger = Logger.getLogger(InsResultReportCtroller.class);
 
	@Autowired
	private InsExcelSer insExcelSer;
   
	@RequestMapping(value = "/viewInsResultReport", method = RequestMethod.GET)
	public void viewInsResultReport(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		insExcelSer.viewInsResultReport(request,response);
		 
	} 
	@RequestMapping(value = "/viewInsResultInfo",method = RequestMethod.GET)
	public ModelAndView viewInsCalculate(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		modelMap.put("paraMap",
				this.insExcelSer.getRequestParamData(request));
		modelMap.put("titleList",
				this.insExcelSer.getInsTitleInfo(request));
		return new ModelAndView("/pa/ins/viewInsResultInfo",modelMap);
	}
}
