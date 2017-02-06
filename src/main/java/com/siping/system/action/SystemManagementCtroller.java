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
 
import com.siping.system.service.SystemMgtSer;   

@Controller
@RequestMapping(value = "/system/systemManagement")
public class SystemManagementCtroller {
	Logger logger = Logger.getLogger(SystemManagementCtroller.class);
 
	@Autowired
	private SystemMgtSer systemMgtSer ;
	/**
	 * 获取职群信息
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */ 
	@RequestMapping(value = "/viewPostGroupManage",method = RequestMethod.GET)
	public ModelAndView viewPostGroupManage(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{ 
		  
		return new ModelAndView("/system/systemManagement/viewPostGroupManage",modelMap);
	}
	/**
	 * 获取职群信息
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */ 
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getPostGroupInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getPostGroupInfo(HttpServletRequest request) throws Exception{ 

		Map model=new HashMap();
		List pgList = this.systemMgtSer.getPostGroupInfo(request);
		int pgListCnt = this.systemMgtSer.getPostGroupInfoCnt(request);
		 
		model.put("Rows", pgList) ;
		model.put("Total", pgListCnt) ;
		  
		return model;
	}
	/**
	 * 添加职群信息
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */ 
	@RequestMapping(value = "/addPostGroupInfo",method = RequestMethod.GET)
	public ModelAndView addPostGroupInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		 
		return new ModelAndView("/system/systemManagement/addPostGroupInfo",modelMap);
	} 
	/**
	 * 更新职群信息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updatePostGroupInfo",method = RequestMethod.POST)
	@ResponseBody
	public String updatePostGroupInfo(HttpServletRequest request)throws Exception{
		
		this.systemMgtSer.updatePostGroupInfo(request) ;
		
		return "Y";		
	} 
	/**
	 * 删除职群信息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deletePostGroupInfo",method = RequestMethod.POST)
	@ResponseBody
	public String deletePostGroupInfo(HttpServletRequest request)throws Exception{
		
		this.systemMgtSer.deletePostGroupInfo(request) ;
		
		return "Y";		
	}  
	/**
	 * 添加职群信息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addPostGroupInfo",method = RequestMethod.POST)
	@ResponseBody
	public String addPostGroupInfo(HttpServletRequest request)throws Exception{
		
		String returnString = "Y" ;
		
		int errorInt = this.systemMgtSer.checkPostGroupInfo(request) ;
		if(errorInt == 0){
			this.systemMgtSer.addPostGroupInfo(request) ;
		}
		else{
			returnString = "N" ;
		}
		
		return returnString ;		
	} 
	
	/**
	 * 获取职列信息
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */ 
	@RequestMapping(value = "/viewPostColumnManage",method = RequestMethod.GET)
	public ModelAndView viewPostColumnManage(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{ 
		  
		return new ModelAndView("/system/systemManagement/viewPostColumnManage",modelMap);
	}
	/**
	 * 获取职列信息
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */ 
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getPostColumnInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getPostColumnInfo(HttpServletRequest request) throws Exception{ 

		Map model=new HashMap();
		List pcList = this.systemMgtSer.getPostColumnInfo(request);
		int pcListCnt = this.systemMgtSer.getPostColumnInfoCnt(request);
		 
		model.put("Rows", pcList) ;
		model.put("Total", pcListCnt) ;
		  
		return model;
	}
	/**
	 * 添加职列信息
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */ 
	@RequestMapping(value = "/addPostColumnInfo",method = RequestMethod.GET)
	public ModelAndView addPostColumnInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		 
		return new ModelAndView("/system/systemManagement/addPostColumnInfo",modelMap);
	} 
	/**
	 * 更新职列信息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updatePostColumnInfo",method = RequestMethod.POST)
	@ResponseBody
	public String updatePostColumnInfo(HttpServletRequest request)throws Exception{
		
		this.systemMgtSer.updatePostColumnInfo(request) ;
		
		return "Y";		
	} 
	/**
	 * 删除职列信息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deletePostColumnInfo",method = RequestMethod.POST)
	@ResponseBody
	public String deletePostColumnInfo(HttpServletRequest request)throws Exception{
		
		this.systemMgtSer.deletePostColumnInfo(request) ;
		
		return "Y";		
	}
	/**
	 * 添加职列信息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addPostColumnInfo",method = RequestMethod.POST)
	@ResponseBody
	public String addPostColumnInfo(HttpServletRequest request)throws Exception{
		
		String returnString = "Y" ;
		
		int errorInt = this.systemMgtSer.checkPostColumnInfo(request) ;
		if(errorInt == 0){
			this.systemMgtSer.addPostColumnInfo(request) ;
		}
		else{
			returnString = "N" ;
		}
		
		return returnString ;		
	}
	/**
	 * 获取职级信息
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */ 
	@RequestMapping(value = "/viewPostGradeManage",method = RequestMethod.GET)
	public ModelAndView viewPostGradeManage(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{ 
		 
		return new ModelAndView("/system/systemManagement/viewPostGradeManage",modelMap);
	}
	/**
	 * 获取职级信息
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */ 
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getPostGradeInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getPostGradeInfo(HttpServletRequest request) throws Exception{ 

		Map model=new HashMap();
		List pcList = this.systemMgtSer.getPostGradeInfo(request);
		int pcListCnt = this.systemMgtSer.getPostGradeInfoCnt(request);
		 
		model.put("Rows", pcList) ;
		model.put("Total", pcListCnt) ;
		  
		return model;
	}
	/**
	 * 添加职级信息
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */ 
	@RequestMapping(value = "/addPostGradeInfo",method = RequestMethod.GET)
	public ModelAndView addPostGradeInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		 
		return new ModelAndView("/system/systemManagement/addPostGradeInfo",modelMap);
	} 
	/**
	 * 更新职级信息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updatePostGradeInfo",method = RequestMethod.POST)
	@ResponseBody
	public String updatePostGradeInfo(HttpServletRequest request)throws Exception{
		
		this.systemMgtSer.updatePostGradeInfo(request) ;
		
		return "Y";		
	} 
	/**
	 * 删除职级信息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deletePostGradeInfo",method = RequestMethod.POST)
	@ResponseBody
	public String deletePostGradeInfo(HttpServletRequest request)throws Exception{
		
		this.systemMgtSer.deletePostGradeInfo(request) ;
		
		return "Y";		
	}
	/**
	 * 添加职级信息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addPostGradeInfo",method = RequestMethod.POST)
	@ResponseBody
	public String addPostGradeInfo(HttpServletRequest request)throws Exception{
		
		String returnString = "Y" ;
		
		int errorInt = this.systemMgtSer.checkPostGradeInfo(request) ;
		if(errorInt == 0){
			this.systemMgtSer.addPostGradeInfo(request) ;
		}
		else{
			returnString = "N" ;
		}
		
		return returnString ;		
	}  
	/**
	 * 获取职位岗位信息
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */ 
	@RequestMapping(value = "/viewPostManage",method = RequestMethod.GET)
	public ModelAndView viewPostManage(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{ 
		 
		return new ModelAndView("/system/systemManagement/viewPostManage",modelMap);
	}
	/**
	 * 获取职位岗位信息
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */ 
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getPostInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getPostInfo(HttpServletRequest request) throws Exception{ 

		Map model=new HashMap();
		List pcList = this.systemMgtSer.getPostInfo(request);
		int pcListCnt = this.systemMgtSer.getPostInfoCnt(request);
		 
		model.put("Rows", pcList) ;
		model.put("Total", pcListCnt) ;
		  
		return model;
	}
	/**
	 * 添加职位岗位信息
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */ 
	@RequestMapping(value = "/addPostInfo",method = RequestMethod.GET)
	public ModelAndView addPostInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		 
		return new ModelAndView("/system/systemManagement/addPostInfo",modelMap);
	} 
	/**
	 * 更新职位岗位信息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updatePostInfo",method = RequestMethod.POST)
	@ResponseBody
	public String updatePostInfo(HttpServletRequest request)throws Exception{
		
		this.systemMgtSer.updatePostInfo(request) ;
		
		return "Y";		
	} 
	/**
	 * 删除职位岗位信息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deletePostInfo",method = RequestMethod.POST)
	@ResponseBody
	public String deletePostInfo(HttpServletRequest request)throws Exception{
		
		this.systemMgtSer.deletePostInfo(request) ;
		
		return "Y";		
	}
	/**
	 * 添加职位岗位信息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addPostInfo",method = RequestMethod.POST)
	@ResponseBody
	public String addPostInfo(HttpServletRequest request)throws Exception{
		
		String returnString = "Y" ;
		
		int errorInt = this.systemMgtSer.checkPostInfo(request) ;
		if(errorInt == 0){
			this.systemMgtSer.addPostInfo(request) ;
		}
		else{
			returnString = "N" ;
		}
		
		return returnString ;		
	}   
	/**
	 * 获取职务信息
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */ 
	@RequestMapping(value = "/viewPositionManage",method = RequestMethod.GET)
	public ModelAndView viewPositionManage(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{ 
		 
		return new ModelAndView("/system/systemManagement/viewPositionManage",modelMap);
	}
	/**
	 * 获取职务信息
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */ 
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getPositionInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getPositionInfo(HttpServletRequest request) throws Exception{ 

		Map model=new HashMap();
		List pcList = this.systemMgtSer.getPositionInfo(request);
		int pcListCnt = this.systemMgtSer.getPositionInfoCnt(request);
		 
		model.put("Rows", pcList) ;
		model.put("Total", pcListCnt) ;
		  
		return model;
	}
	/**
	 * 添加职务信息
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */ 
	@RequestMapping(value = "/addPositionInfo",method = RequestMethod.GET)
	public ModelAndView addPositionInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		 
		return new ModelAndView("/system/systemManagement/addPositionInfo",modelMap);
	} 
	/**
	 * 更新职务信息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updatePositionInfo",method = RequestMethod.POST)
	@ResponseBody
	public String updatePositionInfo(HttpServletRequest request)throws Exception{
		
		this.systemMgtSer.updatePositionInfo(request) ;
		
		return "Y";		
	} 
	/**
	 * 删除职务信息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deletePositionInfo",method = RequestMethod.POST)
	@ResponseBody
	public String deletePositionInfo(HttpServletRequest request)throws Exception{
		
		this.systemMgtSer.deletePositionInfo(request) ;
		
		return "Y";		
	}
	/**
	 * 添加职务信息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addPositionInfo",method = RequestMethod.POST)
	@ResponseBody
	public String addPositionInfo(HttpServletRequest request)throws Exception{
		
		String returnString = "Y" ;
		
		int errorInt = this.systemMgtSer.checkPositionInfo(request) ;
		if(errorInt == 0){
			this.systemMgtSer.addPositionInfo(request) ;
		}
		else{
			returnString = "N" ;
		}
		
		return returnString ;		
	} 
}
