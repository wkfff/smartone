package com.siping.pa.action.salary;

import java.io.IOException;
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

import com.siping.pa.service.salary.PaItemSer;
import com.siping.web.messages.Messages;

@Controller
@RequestMapping(value = "/pa/salary")
public class PaItemCtroller {
	Logger logger = Logger.getLogger(PaItemCtroller.class);

	@Autowired
	private PaItemSer paItemSer;

	@RequestMapping(value = "/viewPaItemInfo", method = RequestMethod.GET)
	public ModelAndView viewPaItemInfo(HttpServletRequest request, ModelMap modelMap)  {

		return new ModelAndView("/pa/salary/viewPaItemInfo", modelMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getPaItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getPaItemInfo(HttpServletRequest request) {
		List paItemList = this.paItemSer.getPaItemInfo(request);
		int paItemCnt = this.paItemSer.getPaItemInfoCnt(request);
		Map model = new HashMap();
		model.put("Rows", paItemList);
		model.put("Total", paItemCnt);

		return model;
	}
	
	@RequestMapping(value = "/saveAndUpdatePaItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public String saveAndUpdatePaItemInfo(HttpServletRequest request){
		String returnString = "Y";
		try{
			this.paItemSer.addPaItemInfo(request);
			this.paItemSer.updatePaItemInfo(request);
		}catch(SQLException e){
			e.printStackTrace();
			returnString = e.getMessage();
		}
		return returnString;
	}

	@RequestMapping(value = "/deletePaItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deletePaItemInfo(HttpServletRequest request) {
		
		return this.paItemSer.deletePaItemInfo(request);
	}

	@RequestMapping(value = "/updatePaItemInfoCalOrder", method = RequestMethod.POST)
	@ResponseBody
	public String updatePaItemInfoCalOrder(HttpServletRequest request){

		return this.paItemSer.updatePaItemInfoCalOrder(request);
	}
	
	@RequestMapping(value = "/downloadPaDataTemplate", method = RequestMethod.GET)
	public void downloadPaDataTemplate(HttpServletRequest request, HttpServletResponse response)  {

		this.paItemSer.downloadPaDataTemplate(request, response);
	}
	
}
