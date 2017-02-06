package com.siping.att.action.attendanceInfomation;

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
import com.siping.att.service.AttDetailSer;
import com.siping.att.service.AttMonInfoSer; 
import com.siping.att.service.AttMonthSer;
import com.siping.att.service.ItemsSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.JsonUtil; 
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.StringUtil;


@Controller
@RequestMapping(value = "/att/attendanceInfomation")
public class AttMonInfoController {
	Logger logger = Logger.getLogger(AttMonInfoController.class);

	@Autowired
	private AttMonInfoSer attMonInfoSer;

	@Autowired
	private AttDetailSer attDetailSer;

	@Autowired
	private ItemsSer itemsSer;
	@Autowired
	private AttMonthSer attMonthSer;
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/viewAttMonInfo",method = RequestMethod.GET)
	public ModelAndView viewAttMonInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{ 
		List getAttColumnsList  =  this.attMonInfoSer.getAttColumns(request);  
		modelMap.put("attColumnsList", JsonUtil.writeInternal(getAttColumnsList));
		modelMap.put("paraMap", this.attMonInfoSer.getRequestParamData(request));
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		modelMap.put("empId", admin.getAdminID());
		return new ModelAndView("/att/attendanceInfomation/viewAttMonInfo",modelMap);
	} 
	@RequestMapping(value = "/viewPersonalAttDetail", method = RequestMethod.GET)
	public ModelAndView viewPersonalAttDetail(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		modelMap.put("E_DATE",attDetailSer.getEndDateStr(request));
		modelMap.put("S_DATE",attDetailSer.getStartDateStr(request));
		modelMap.put("itemList", itemsSer.getItemInfoSelection(request));
		modelMap.put("lockList", StringUtil.getLockSelectList());
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		modelMap.put("empId", admin.getAdminID());
		return new ModelAndView("/att/attendanceInfomation/viewPersonalAttDetail",
				modelMap);
	} 
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getPersonalAttDetailList", method = RequestMethod.POST)
	@ResponseBody
	public Map getAttDetailList(HttpServletRequest request) throws Exception {

		List getAttDetailList = this.attDetailSer.getAttDetailList(request);
		int getAttDetailListCnt = this.attDetailSer
				.getAttDetailListCnt(request);
		Map model = new HashMap();
		model.put("Rows", getAttDetailList);
		model.put("Total", getAttDetailListCnt);
		return model;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getAttMonInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getAttMonInfo(HttpServletRequest request)throws Exception{
		List infoList = this.attMonInfoSer.getAttMonInfo(request) ;
		int infoCnt=this.attMonInfoSer.getAttMonInfoCnt(request);
		Map model=new HashMap();
		model.put("Rows", infoList);
		model.put("Total", infoCnt);
		return model;		
	}
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/viewPersonalAttMonth",method = RequestMethod.GET)
	public ModelAndView viewAttMonth(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{ 
		List  getAttColumnsList  =  attMonthSer.getAttColumns(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		modelMap.put("empId", admin.getAdminID());
		modelMap.put("attColumnsList", JsonUtil.writeInternal(getAttColumnsList));
		return new ModelAndView("/att/attendanceInfomation/viewPersonalAttMonth",modelMap);
	}
}
