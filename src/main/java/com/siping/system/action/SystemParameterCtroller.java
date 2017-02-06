package com.siping.system.action;
 
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
 

import com.siping.system.service.SystemParameterSer;
import com.siping.web.utility.service.UtilityEmpInfoSer;

@Controller
@RequestMapping(value = "/system/systemParameter")
public class SystemParameterCtroller {
	Logger logger = Logger.getLogger(SystemParameterCtroller.class);
	@Autowired
	private SystemParameterSer systemParameterSer;
	@Autowired
	private UtilityEmpInfoSer utilityEmpInfoSer;
	   
	/**
	 * 模块参数
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewModuleParameter",method = RequestMethod.GET)
	public ModelAndView viewModuleParameter(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
        return new ModelAndView("/system/systemParameter/viewModuleParameter",modelMap);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getModuleParameterInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getModuleParameterInfo(HttpServletRequest request) {
		
		List ModuleParameterInfoList = this.systemParameterSer.getModuleParameterInfo(request) ;
		int ModuleParameterInfoCnt = this.systemParameterSer.getModuleParameterInfoCnt(request) ;
		
		Map model=new HashMap();
		model.put("moduleParameterInfoList", ModuleParameterInfoList);
		model.put("moduleParameterInfoCnt", ModuleParameterInfoCnt);
		
		return model ;	
	}
	@RequestMapping(value = "/deleteModuleParameterInfo",method = RequestMethod.POST)
	@ResponseBody
	public String deleteModuleParameterInfo(HttpServletRequest request) {
		return this.systemParameterSer.deleteModuleParameterInfo(request) ;		
	}
	/**
	 * 维护
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveAndUpdateModuleParameterInfo",method = RequestMethod.POST)
	@ResponseBody
	public String saveAndUpdateModuleParameterInfo(HttpServletRequest request)throws Exception{
		return this.systemParameterSer.saveAmdUpdateModuleParameterInfo(request);	
	}
	/**
	 * 休假审核参数
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewLeaveAppParameter",method = RequestMethod.GET)
	public ModelAndView viewLeaveAppParameter(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
        return new ModelAndView("/system/systemParameter/viewLeaveAppParameter",modelMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getLeaveAppParameterInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getLeaveAppParameterInfo(HttpServletRequest request) {
		
		List leaveAppParameterInfoList = this.systemParameterSer.getLeaveAppParameterInfo(request) ;
		int leaveAppParameterInfoCnt = this.systemParameterSer.getLeaveAppParameterInfoCnt(request) ;
		
		Map model=new HashMap();
		model.put("leaveAppParameterInfoList", leaveAppParameterInfoList);
		model.put("leaveAppParameterInfoCnt", leaveAppParameterInfoCnt);
		
		return model ;	
	}
 
	@RequestMapping(value = "/deleteLeaveAppParameterInfo",method = RequestMethod.POST)
	@ResponseBody
	public String deleteLeaveAppParameterInfo(HttpServletRequest request) {
		return this.systemParameterSer.deleteLeaveAppParameterInfo(request) ;	
	} 
	/**
	 * 维护
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveAndUpdateLeaveAppParameterInfo",method = RequestMethod.POST)
	@ResponseBody
	public String saveAndUpdateLeaveAppParameterInfo(HttpServletRequest request)throws Exception{
		return this.systemParameterSer.saveAndUpdateLeaveAppParameterInfo(request);	
	} 
	
	/**
	 * 休假审核参数
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewOTAppParameter",method = RequestMethod.GET)
	public ModelAndView viewOTAppParameter(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{  
        return new ModelAndView("/system/systemParameter/viewOTAppParameter",modelMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getOTAppParameterInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getOTAppParameterInfo(HttpServletRequest request) {
		
		List otAppParameterInfoList = this.systemParameterSer.getOTAppParameterInfo(request) ;
		int otAppParameterInfoCnt = this.systemParameterSer.getOTAppParameterInfoCnt(request) ;
		
		Map model=new HashMap();
		model.put("otAppParameterInfoList", otAppParameterInfoList);
		model.put("otAppParameterInfoCnt", otAppParameterInfoCnt);
		
		return model ;	
	}
 
	@RequestMapping(value = "/deleteOTAppParameterInfo",method = RequestMethod.POST)
	@ResponseBody
	public String deleteOTAppParameterInfo(HttpServletRequest request) {
		return this.systemParameterSer.deleteOTAppParameterInfo(request) ;	
	} 
	/**
	 * 维护
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveAndUpdateOTAppParameterInfo",method = RequestMethod.POST)
	@ResponseBody
	public String saveAndUpdateOTAppParameterInfo(HttpServletRequest request)throws Exception{
		return this.systemParameterSer.saveAndUpdateOTAppParameterInfo(request);	
	} 
}
