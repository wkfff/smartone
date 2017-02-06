package com.siping.pa.action.wagebase;

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

import com.siping.pa.service.wagebase.PaBasicItemSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;

@Controller
@RequestMapping(value = "/pa/wagebase")
public class PaBasicItemCtroller {
	Logger logger = Logger.getLogger(PaBasicItemCtroller.class);
	
	@Autowired
	private PaBasicItemSer paBasicItemSer ;
	
	@RequestMapping(value = "/viewPaBasicItemInfo",method = RequestMethod.GET)
	public ModelAndView viewPaBasicItemInfo(HttpServletRequest request,
			HttpServletResponse response,ModelMap modelMap){
		
		return new ModelAndView("/pa/wagebase/viewPaBasicItemInfo",modelMap);
	}
	@RequestMapping(value = "/viewPaBasicItemDetailInfo",method = RequestMethod.GET)
	public ModelAndView viewPaBasicItemDetailInfo(HttpServletRequest request,
		HttpServletResponse response,ModelMap modelMap){
		
		return new ModelAndView("/pa/wagebase/viewPaBasicItemDetailInfo",modelMap);
	}
	@RequestMapping(value = "/addPaBasicItemDataInfo",method = RequestMethod.GET)
	public ModelAndView addPaBasicItemDataInfo(HttpServletRequest request,ModelMap modelMap){
		modelMap.put("paraMap",ObjectBindUtil.getRequestParamData(request));
		
		return new ModelAndView("/pa/wagebase/addPaBasicItemDataInfo",modelMap);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getPaBasicItemInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getPaBasicItemInfo(HttpServletRequest request)throws Exception{
		List paBasicItemInfo = this.paBasicItemSer.getPaBasicItemInfo(request) ;
		int paBasicItemInfoCnt = this.paBasicItemSer.getPaBasicItemInfoCnt(request) ;
		Map model=new HashMap();
		model.put("Rows", paBasicItemInfo) ;
		model.put("Total", paBasicItemInfoCnt) ;
		
		return model ;
	}

	@RequestMapping(value = "/addAndupdatePaBasicItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public String addAndupdatePaBasicItemInfo(HttpServletRequest request){
		String returnString = "Y";
		try{
			this.paBasicItemSer.addPaBasicItemInfo(request);
			this.paBasicItemSer.updatePaBasicItemInfo(request);
		}catch(SQLException e){
			e.printStackTrace();
			returnString = e.getMessage();
		}
		return returnString;
	}
	
	@RequestMapping(value = "/updatePaBasicItemInfo",method = RequestMethod.POST)
	@ResponseBody
	public String updatePaBasicItemInfo(HttpServletRequest request){
		String returnString = "Y";
		try{
			this.paBasicItemSer.updatePaBasicItemInfo(request) ;
		}catch(SQLException e){
			e.printStackTrace();
			returnString = e.getMessage();
		}
		return returnString;
	}
	
	@RequestMapping(value = "/deletePaBasicItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deletePaBasicItemInfo(HttpServletRequest request){
		String returnString = "Y";
		int errorInt = this.paBasicItemSer.checkDeletePaBasicItemInfo(request);
		if (errorInt == 0) {
			returnString = this.paBasicItemSer.deletePaBasicItemInfo(request);
		} else {
			returnString = Messages.getMessage(request, "hrms.canNotdelete");
		}
		return returnString;
	}
	
	@RequestMapping(value = "/deletePaBasicItemDataInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deletePaBasicItemDataInfo(HttpServletRequest request){
		
		return this.paBasicItemSer.deletePaBasicItemDataInfo(request);
	}
	
	@RequestMapping(value = "/viewPaBasicItemData",method = RequestMethod.GET)
	public ModelAndView viewPaBasicItemData(HttpServletRequest request,
		HttpServletResponse response,ModelMap modelMap){
		
		Object paBasicItemInfo = this.paBasicItemSer.getPaBasicItemInfo(request) ;
		modelMap.put("paBasicItemInfo", paBasicItemInfo) ;
		return new ModelAndView("/pa/wagebase/viewPaBasicItemData",modelMap);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getPaBasicItemDataInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getPaBasicItemDataInfo(HttpServletRequest request){
		List paBasicItemDataList = this.paBasicItemSer.getPaBasicItemDataInfo(request) ;
		int paBasicItemDataCnt = this.paBasicItemSer.getPaBasicItemDataInfoCnt(request);
		Map model=new HashMap();
		model.put("Rows", paBasicItemDataList) ;
		model.put("Total", paBasicItemDataCnt);
		
		return model ;
	}
	
	@RequestMapping(value = "/updatePaBasicItemDataInfo",method = RequestMethod.POST)
	@ResponseBody
	public String updatePaBasicItemDataInfo(HttpServletRequest request){
		return this.paBasicItemSer.updatePaBasicItemDataInfo(request) ;
	}
	 
	@RequestMapping(value = "/addPaBasicItemDataInfo",method = RequestMethod.POST)
	@ResponseBody
	public String addPaBasicItemDataInfo(HttpServletRequest request){
		return this.paBasicItemSer.addPaBasicItemDataInfo(request) ;
	}
	
	@RequestMapping(value = "/addPaBasicItemDataView",method = RequestMethod.GET)
	public ModelAndView addPaBasicItemDataView(HttpServletRequest request,ModelMap modelMap) {
		Object paBasicItemInfo = this.paBasicItemSer.getPaBasicItemInfo(request) ;
		modelMap.put("paBasicItemInfo", paBasicItemInfo) ;
		
		return new ModelAndView("/pa/wagebase/addPaBasicItemDataView",modelMap);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getPaBasicItemDataEmpInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getPaBasicItemDataEmpInfo(HttpServletRequest request){
		List insEmpInfo = this.paBasicItemSer.getPaBasicItemDataEmpInfo(request);
		int insEmpInfoCnt = this.paBasicItemSer.getPaBasicItemDataEmpInfoCnt(request);
		Map model = new HashMap();
		model.put("Rows", insEmpInfo);
		model.put("Total", insEmpInfoCnt);
		
		return model;
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getPaBasicItemDataOtherInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getPaBasicItemDataOtherInfo(HttpServletRequest request) {
		List insEmpInfo = this.paBasicItemSer.getPaBasicItemDataOtherInfo(request);
		int insEmpInfoCnt = this.paBasicItemSer.getPaBasicItemDataOtherInfoCnt(request);
		Map model = new HashMap();
		model.put("Rows", insEmpInfo);
		model.put("Total", insEmpInfoCnt);
		
		return model;
	}
}
