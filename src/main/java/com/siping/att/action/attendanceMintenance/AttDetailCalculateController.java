package com.siping.att.action.attendanceMintenance;

import java.util.List;

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

import com.siping.att.service.AttDetailCalulateSer;
import com.siping.att.service.AttDetailSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/att/attendanceMintenance")
public class AttDetailCalculateController {
	Logger logger = Logger.getLogger(AttDetailCalculateController.class);

	@Autowired
	private AttDetailCalulateSer AttDetailCalulateSer;

	@Autowired
	private AttDetailSer attDetailSer;

	@SuppressWarnings({ "rawtypes", "unused" })
	@RequestMapping(value = "/viewAttDetailCalculate",method = RequestMethod.GET)
	public ModelAndView viewArDetailCalculate(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		List arSupervisorList  = this.AttDetailCalulateSer.getAttSupervisorList(request); 
		AdminBean admin = SessionUtil.getLoginUserFromSession(request) ;
		String  supervisorId = admin.getAdminID();
		modelMap.put("sDate", attDetailSer.getStartDateStr(request,"yyyy-MM-dd"));
		modelMap.put("eDate", attDetailSer.getEndDateStr(request,"yyyy-MM-dd"));
		return new ModelAndView("/att/attendanceMintenance/viewAttDetailCalculate",modelMap);
	}
	@RequestMapping(value = "/detailCalculate",method = RequestMethod.POST)
	@ResponseBody
	public String detailCalculate(HttpServletRequest request)throws Exception{
		String returnString = this.AttDetailCalulateSer.detailCalculate(request) ;
		return returnString ;		
	}
}
