package com.siping.report.pa.action.bonus;
  
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller; 
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;  
import org.springframework.web.servlet.ModelAndView;
 
import com.siping.report.pa.service.bonus.BonusExcelSer; 

@Controller
@RequestMapping(value = "/report/pa/bonus")
public class BonusResultReportCtroller {
	Logger logger = Logger.getLogger(BonusResultReportCtroller.class);
 
	@Autowired
	private BonusExcelSer bonusExcelSer;
   
	@RequestMapping(value = "/viewBonusResultReport", method = RequestMethod.GET)
	public void viewBonusResultReport(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		bonusExcelSer.viewBonusResultReport(request,response);
		 
	} 
	@RequestMapping(value = "/viewBonusResultInfo",method = RequestMethod.GET)
	public ModelAndView viewBonusCalculate(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		modelMap.put("paraMap",
				this.bonusExcelSer.getRequestParamData(request));
		modelMap.put("titleList",
				this.bonusExcelSer.getBonusTitleInfo(request));
		return new ModelAndView("/pa/bonus/viewInsResultInfo",modelMap);
	}
}
