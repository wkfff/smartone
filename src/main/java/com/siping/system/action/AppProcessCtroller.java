package com.siping.system.action;

import java.sql.SQLException;
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
 
import com.siping.system.service.AppProcessSer;  
import com.siping.web.utility.StringUtil;

@Controller
@RequestMapping(value = "/system/appProcessManagement")
public class AppProcessCtroller {
	Logger logger = Logger.getLogger(AppProcessCtroller.class);
	
	@Autowired
	private AppProcessSer appProcessSer ;
	  
	@RequestMapping(value = "/viewAppProcessPInfo",method = RequestMethod.GET)
	public ModelAndView viewAppProcessPInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
 
		return new ModelAndView("/system/appProcessManagement/viewAppProcessPInfo",modelMap);
	} 
	/**
	 * 添加个人流程
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value = "/addAppProcessPInfo",method = RequestMethod.GET)
	public ModelAndView addAppProcessPInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		
		List listMap = StringUtil.getIntSerialList(6,"0") ;
		Map appProcessPInfo = this.appProcessSer.getAppProcessPInfoObj(request); 
		modelMap.put("appLevelList", listMap);
		modelMap.put("appProcessPInfo", appProcessPInfo); 
		 
		return new ModelAndView("/system/appProcessManagement/addAppProcessPInfo",modelMap);
	} 
	/**
	 * 添加部门流程
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value = "/addAppProcessDInfo",method = RequestMethod.GET)
	public ModelAndView addAppProcessDInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		
		List listMap = StringUtil.getIntSerialList(6,"0") ; 
		Map appProcessDInfo = this.appProcessSer.getAppProcessDInfoObj(request); 
		modelMap.put("appProcessDInfo", appProcessDInfo); 
		modelMap.put("appLevelList", listMap); 
		 
		return new ModelAndView("/system/appProcessManagement/addAppProcessDInfo",modelMap);
	} 
 
	@RequestMapping(value = "/viewAppProcessDInfo",method = RequestMethod.GET)
	public ModelAndView viewAppProcessDInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{

		return new ModelAndView("/system/appProcessManagement/viewAppProcessDInfo",modelMap);
	}
	   
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getAppProcessPInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getAppProcessPInfo(HttpServletRequest request)throws Exception{
		
		List appProcessPList = this.appProcessSer.getAppProcessPInfo(request) ;
		
		int appProcessPCnt = this.appProcessSer.getAppProcessPInfoCnt(request) ;
		
		Map model=new HashMap();
		model.put("appProcessPList", appProcessPList);
		model.put("appProcessPCnt", appProcessPCnt);
	
		return model;		
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getAppProcessPAInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getAppProcessPAInfo(HttpServletRequest request)throws Exception{
		
		List appProcessPAList = this.appProcessSer.getAppProcessPAInfo(request) ;
		
		Map model=new HashMap();
		model.put("appProcessPAList", appProcessPAList);
	
		return model;		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getAppProcessDInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getAppProcessDInfo(HttpServletRequest request)throws Exception{
		
		List appProcessDList = this.appProcessSer.getAppProcessDInfo(request) ;
		
		int appProcessDCnt = this.appProcessSer.getAppProcessDInfoCnt(request) ;
		
		Map model=new HashMap();
		model.put("appProcessDList", appProcessDList);
		model.put("appProcessDCnt", appProcessDCnt);
	
		return model;		
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getAppProcessDAInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getAppProcessDAInfo(HttpServletRequest request)throws Exception{
		
		List appProcessDAList = this.appProcessSer.getAppProcessDAInfo(request) ;
		
		Map model=new HashMap();
		model.put("appProcessDAList", appProcessDAList);
	
		return model;		
	}
	/**
	 * 删除个人流程
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */ 
	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value = "/deleteAppProcessPInfo",method = RequestMethod.GET)
	public ModelAndView deleteAppProcessPInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{

		Map appProcessPInfo = this.appProcessSer.getAppProcessPInfoObj(request); 
		Map paramMap = this.appProcessSer.getRequestParamData(request);
		
		modelMap.put("appProcessPInfo", appProcessPInfo); 
		modelMap.put("paramMap", paramMap); 
		return new ModelAndView("/system/appProcessManagement/deleteAppProcessPInfo",modelMap);
	} 
	/**
	 * 删除部门流程
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */ 
	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value = "/deleteAppProcessDInfo",method = RequestMethod.GET)
	public ModelAndView deleteAppProcessDInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{

		Map appProcessDInfo = this.appProcessSer.getAppProcessDInfoObj(request); 
		Map paramMap = this.appProcessSer.getRequestParamData(request);
		
		modelMap.put("appProcessDInfo", appProcessDInfo); 
		modelMap.put("paramMap", paramMap); 
		return new ModelAndView("/system/appProcessManagement/deleteAppProcessDInfo",modelMap);
	} 

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getAppProcessInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getAppProcessInfo(HttpServletRequest request)throws Exception{
		
		List appProcessInfoList = this.appProcessSer.getAppProcessInfo(request) ;
		Map model=new HashMap();
		model.put("appProcessInfoList", appProcessInfoList);
	
		return model;		
	}
	
	@RequestMapping(value = "/deleteAppProcessPInfo",method = RequestMethod.POST)
	@ResponseBody
	public String deleteAppProcessPInfo(HttpServletRequest request)throws Exception{
		
		this.appProcessSer.deleteAppProcessPInfo(request) ;
		
		return "Y";		
	}
	
	@RequestMapping(value = "/deleteAppProcessDInfo",method = RequestMethod.POST)
	@ResponseBody
	public String deleteAppProcessDInfo(HttpServletRequest request)throws Exception{
		
		this.appProcessSer.deleteAppProcessDInfo(request) ;
		
		return "Y";		
	}
	
	@RequestMapping(value = "/addAppProcessPInfo",method = RequestMethod.POST)
	@ResponseBody
	public String addAppProcessPInfo(HttpServletRequest request)throws Exception{
		
		this.appProcessSer.addAppProcessPInfo(request) ;
		
		return "Y";		
	}
	
	@RequestMapping(value = "/addAppProcessDInfo",method = RequestMethod.POST)
	@ResponseBody
	public String addAppProcessDInfo(HttpServletRequest request)throws Exception{
		
		this.appProcessSer.addAppProcessDInfo(request) ;
		
		return "Y";		
	}
	  
	@RequestMapping(value = "/updateAppProcessPInfo",method = RequestMethod.POST)
	@ResponseBody
	public String updateAppProcessPInfo(HttpServletRequest request)throws Exception{
		
		this.appProcessSer.updateAppProcessPInfo(request) ;
		
		return "Y";		
	} 
	
	@RequestMapping(value = "/updateAppProcessDInfo",method = RequestMethod.POST)
	@ResponseBody
	public String updateAppProcessDInfo(HttpServletRequest request)throws Exception{
		
		this.appProcessSer.updateAppProcessDInfo(request) ;
		
		return "Y";		
	} 
	
	@RequestMapping(value="viewSendEmailInfo")
	public ModelAndView viewSendEmailInfo(HttpServletRequest request, HttpServletResponse response){
		return new ModelAndView("/system/appProcessManagement/viewSendEmailInfo");
	}
	
	
	/**
	 * 获取发送Email列表
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value="/getSendEmailInfo")
	@ResponseBody
	public Map getSendEmailInfo(HttpServletRequest request, HttpServletResponse response){
		Map model = new HashMap();
		model.put("Rows",this.appProcessSer.getSendEmailInfo(request));
		model.put("Total",this.appProcessSer.getSendEmailInfoCnt(request));
		return model;
	}
	
	@RequestMapping(value="/updateSendEmailInfo", method=RequestMethod.POST)
	@ResponseBody
	public String updateSendEmailInfo(HttpServletRequest request, HttpServletResponse response){
		String returnString = "";		
		try{
			returnString = this.appProcessSer.updateSendEmailInfo(request);
		}catch(SQLException e){
			returnString = e.getMessage();
			e.printStackTrace();
		}
		return returnString;
	}
	@RequestMapping(value="/addSendEmailInfo", method=RequestMethod.POST)
	@ResponseBody
	public String addSendEmailInfo(HttpServletRequest request, HttpServletResponse response){
		String returnString = "";		
		try{
			returnString = this.appProcessSer.addSendEmailInfo(request);
		}catch(SQLException e){
			returnString = e.getMessage();
			e.printStackTrace();
		}
		return returnString;
	}
	@RequestMapping(value="/deleteSendEmailInfo", method=RequestMethod.POST)
	@ResponseBody
	public String deleteSendEmailInfo(HttpServletRequest request, HttpServletResponse response){
		String returnString = "";		
		try{
			returnString = this.appProcessSer.deleteSendEmailInfo(request);
		}catch(SQLException e){
			returnString = e.getMessage();
			e.printStackTrace();
		}
		return returnString;
	}
	 
}
