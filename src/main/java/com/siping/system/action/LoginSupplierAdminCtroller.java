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
 
import com.siping.system.service.LoginSupplierAdminSer;
import com.siping.web.utility.JsonUtil;

@Controller
@RequestMapping(value = "/system/rightsSupplierAdminManagement")
public class LoginSupplierAdminCtroller {
	Logger logger = Logger.getLogger(LoginSupplierAdminCtroller.class);
	
	@Autowired
	private LoginSupplierAdminSer loginSupplierAdminSer ;
	  
	@RequestMapping(value = "/viewLoginSupplierAdmin",method = RequestMethod.GET)
	public ModelAndView viewLoginSupplierAdmin(HttpServletRequest request, ModelMap modelMap) throws Exception{
		modelMap.put("rolesSelectList", this.loginSupplierAdminSer.getRolesSelectList(request));
		return new ModelAndView("/system/rightsSupplierAdminManagement/viewLoginSupplierAdmin",modelMap);
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/addLoginSupplierAdminView",method = RequestMethod.GET)
	public ModelAndView addLoginSupplierAdminView(HttpServletRequest request, ModelMap modelMap){
		List loginSupplierAdminInfoRolesGroupList = this.loginSupplierAdminSer.getLoginSupplierAdminRolesGroupList(request) ;
		String string = JsonUtil.deptInfoToJson(this.loginSupplierAdminSer.getLoginSupplierAdminDeptInfo(request));
		
		modelMap.put("loginSupplierAdminInfoRolesGroupList", loginSupplierAdminInfoRolesGroupList);
		modelMap.put("dataJson", string);
		
		return new ModelAndView("/system/rightsSupplierAdminManagement/addLoginSupplierAdminView",modelMap);
	}
	

	
	@RequestMapping(value = "/updateLoginSupplierAdminInfo",method = RequestMethod.POST)
	@ResponseBody
	public String updateRolesGroupInfo(HttpServletRequest request)throws Exception{
		return this.loginSupplierAdminSer.updateLoginSupplierAdminInfo(request) ;
	}
	
	@RequestMapping(value="/deleteLoginSupplierAdmin",method = RequestMethod.POST)
	@ResponseBody
	public String deleteLoginSupplierAdmin(HttpServletRequest request){
		return this.loginSupplierAdminSer.deleteLoginSupplierAdminInfo(request);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getLoginSupplierAdminInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getLoginSupplierAdminInfo(HttpServletRequest request)throws Exception{
		List loginSupplierAdminList = this.loginSupplierAdminSer.getLoginSupplierAdminInfo(request) ;
		int loginSupplierAdminCnt = this.loginSupplierAdminSer.getLoginSupplierAdminInfoCnt(request) ;
		
		Map model=new HashMap();
		model.put("loginSupplierAdminInfo", loginSupplierAdminList);
		model.put("loginSupplierAdminInfoCnt", loginSupplierAdminCnt);
	
		return model;
	}

	@SuppressWarnings({ "rawtypes", "unchecked"})
	@RequestMapping(value = "/updateLoginSupplierAdminView",method = RequestMethod.GET)
	public ModelAndView updateLoginSupplierAdminView(HttpServletRequest request, ModelMap modelMap) throws Exception{
		Object loginSupplierAdminInfo = this.loginSupplierAdminSer.getLoginSupplierAdminInfoObj(request) ;
		List loginSupplierAdminInfoRolesGroupList = this.loginSupplierAdminSer.getLoginSupplierAdminRolesGroupList(request) ;
		
		modelMap.put("loginSupplierAdminInfo", loginSupplierAdminInfo);
		modelMap.put("loginSupplierAdminInfoRolesGroupList", loginSupplierAdminInfoRolesGroupList);
		return new ModelAndView("/system/rightsSupplierAdminManagement/updateLoginSupplierAdminView",modelMap);
	}

	@SuppressWarnings({ "rawtypes"})
	@RequestMapping(value = "/getLoginSupplierAdminDeptInfo",method = RequestMethod.POST)
	@ResponseBody
	public List getLoginSupplierAdminDeptInfo(HttpServletRequest request)throws Exception{
		List loginSupplierAdminDeptList = this.loginSupplierAdminSer.getLoginSupplierAdminDeptInfo(request) ; 
		
		return 	loginSupplierAdminDeptList;
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
		
		List listMap= this.loginSupplierAdminSer.getRolesSelectList(request) ;
		
		return listMap;		
	}
	
	
}
