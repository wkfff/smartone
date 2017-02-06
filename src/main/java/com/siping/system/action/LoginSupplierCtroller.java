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
 
import com.siping.system.service.LoginSupplierSer;
import com.siping.web.utility.JsonUtil;

@Controller
@RequestMapping(value = "/system/rightsSupplierManagement")
public class LoginSupplierCtroller {
	Logger logger = Logger.getLogger(LoginSupplierCtroller.class);
	
	@Autowired
	private LoginSupplierSer loginSupplierSer ;
	  
	@RequestMapping(value = "/viewLoginSupplier",method = RequestMethod.GET)
	public ModelAndView viewLoginSupplier(HttpServletRequest request, ModelMap modelMap) throws Exception{
		modelMap.put("rolesSelectList", this.loginSupplierSer.getRolesSelectList(request));
		return new ModelAndView("/system/rightsSupplierManagement/viewLoginSupplier",modelMap);
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/addLoginSupplierView",method = RequestMethod.GET)
	public ModelAndView addLoginSupplierView(HttpServletRequest request, ModelMap modelMap){
		List loginSupplierInfoRolesGroupList = this.loginSupplierSer.getLoginSupplierRolesGroupList(request) ;
		String string = JsonUtil.deptInfoToJson(this.loginSupplierSer.getLoginSupplierDeptInfo(request));
		
		modelMap.put("loginSupplierInfoRolesGroupList", loginSupplierInfoRolesGroupList);
		modelMap.put("dataJson", string);
		
		return new ModelAndView("/system/rightsSupplierManagement/addLoginSupplierView",modelMap);
	}
	
	@RequestMapping(value="/addLoginSupplierInfo",method = RequestMethod.POST)
	@ResponseBody
	public String addLoginSupplierInfo(HttpServletRequest request ){
		return this.loginSupplierSer.addLoginSupplierInfo(request);
	}
	
	@RequestMapping(value = "/updateLoginSupplierInfo",method = RequestMethod.POST)
	@ResponseBody
	public String updateRolesGroupInfo(HttpServletRequest request)throws Exception{
		return this.loginSupplierSer.updateLoginSupplierInfo(request) ;
	}
	
	@RequestMapping(value="/deleteLoginSupplier",method = RequestMethod.POST)
	@ResponseBody
	public String deleteLoginSupplier(HttpServletRequest request){
		return this.loginSupplierSer.deleteLoginSupplierInfo(request);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getLoginSupplierInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getLoginSupplierInfo(HttpServletRequest request)throws Exception{
		List loginSupplierList = this.loginSupplierSer.getLoginSupplierInfo(request) ;
		int loginSupplierCnt = this.loginSupplierSer.getLoginSupplierInfoCnt(request) ;
		
		Map model=new HashMap();
		model.put("loginSupplierInfo", loginSupplierList);
		model.put("loginSupplierInfoCnt", loginSupplierCnt);
	
		return model;
	}

	@SuppressWarnings({ "rawtypes", "unchecked"})
	@RequestMapping(value = "/updateLoginSupplierView",method = RequestMethod.GET)
	public ModelAndView updateLoginSupplierView(HttpServletRequest request, ModelMap modelMap) throws Exception{
		Object loginSupplierInfo = this.loginSupplierSer.getLoginSupplierInfoObj(request) ;
		List loginSupplierInfoRolesGroupList = this.loginSupplierSer.getLoginSupplierRolesGroupList(request) ;
		
		modelMap.put("loginSupplierInfo", loginSupplierInfo);
		modelMap.put("loginSupplierInfoRolesGroupList", loginSupplierInfoRolesGroupList);
		return new ModelAndView("/system/rightsSupplierManagement/updateLoginSupplierView",modelMap);
	}

	@SuppressWarnings({ "rawtypes"})
	@RequestMapping(value = "/getLoginSupplierDeptInfo",method = RequestMethod.POST)
	@ResponseBody
	public List getLoginSupplierDeptInfo(HttpServletRequest request)throws Exception{
		List loginSupplierDeptList = this.loginSupplierSer.getLoginSupplierDeptInfo(request) ; 
		
		return 	loginSupplierDeptList;
	}

	/**
	 * 角色列表
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value = "/getRolesSelectList",method = RequestMethod.POST)
	@ResponseBody
	public List getRolesSelectList(HttpServletRequest request)throws Exception{
		
		List listMap= this.loginSupplierSer.getRolesSelectList(request) ;
		
		return listMap;		
	}
	
	
}
