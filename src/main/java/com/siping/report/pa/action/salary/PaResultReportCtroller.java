package com.siping.report.pa.action.salary;
  
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
import com.siping.report.pa.service.salary.PaExcelSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.JsonUtil;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/report/pa/salary")
public class PaResultReportCtroller {
	Logger logger = Logger.getLogger(PaResultReportCtroller.class);
 
	@Autowired
	private PaExcelSer paExcelSer;

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/viewPaReport", method = RequestMethod.GET)
	public ModelAndView viewPaReport(HttpServletRequest request,ModelMap modelMap) throws Exception {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		
		return new ModelAndView("/report/pa/salary/viewPaReport", modelMap);
	}
	
	
/*-------------------------@ChenCai change---------------------------------------------*/
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/viewPaReportSta", method = RequestMethod.GET)
	public ModelAndView viewPaReportSta(HttpServletRequest request,ModelMap modelMap) throws Exception {
		List paColumnsList = this.paExcelSer.getPaColumns(request);
		modelMap.put("paColumnsList", JsonUtil.writeInternal(paColumnsList));
		return new ModelAndView("/report/pa/salary/viewPaReportSta", modelMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getPaReportSta", method = RequestMethod.POST)
	@ResponseBody
	public Map getPaReportSta(HttpServletRequest request, ModelMap modelMap) throws Exception {
		List infoList = this.paExcelSer.getPaReportSta(request) ;
		int infoCnt= this.paExcelSer.getPaReportStaCnt(request);
		
		Map model=new HashMap();
		model.put("Rows", infoList) ;
		model.put("Total", infoCnt) ;
		
		return model;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getPaStaDetail", method = RequestMethod.POST)
    @ResponseBody
    public Map getPaStaDetail(HttpServletRequest request, ModelMap modelMap) throws Exception {
        List infoList = this.paExcelSer.getPaStaDetailList(request) ;
        int infoCnt= this.paExcelSer.getPaStaDetailCnt(request);
        
        Map model=new HashMap();
        model.put("Rows", infoList) ;
        model.put("Total", infoCnt) ;
        
        return model;
    }
	
	@RequestMapping(value = "/getExcelSta", method = RequestMethod.GET)
	public void getExcelSta(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		paExcelSer.getExcelSta(request,response);
		 
	} 
/*-------------------------@ChenCai change---------------------------------------------*/
	
	
	@RequestMapping(value = "/viewPaResultReport", method = RequestMethod.GET)
	public void viewPaResultReport(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		paExcelSer.viewPaResultReport(request,response);
		 
	} 
	@RequestMapping(value = "/viewInsResultInfo",method = RequestMethod.GET)
	public ModelAndView viewInsCalculate(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		modelMap.put("paraMap",
				this.paExcelSer.getRequestParamData(request));
		modelMap.put("titleList",
				this.paExcelSer.getPaTitleInfo(request));
		return new ModelAndView("/pa/salary/viewPaResultInfo",modelMap);
	}
	
	@RequestMapping(value = "/viewPaWhDetailReport", method = RequestMethod.GET)
	public void viewPaWhDetailReport(HttpServletRequest request,
	        HttpServletResponse response) throws Exception {
	    paExcelSer.viewPaWhDetailReport(request,response);
	}
	   
	@RequestMapping(value = "/viewPaWhReport", method = RequestMethod.GET)
	public void viewPaWhReport(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		paExcelSer.viewPaWhReport(request,response);
		 
	}
}
