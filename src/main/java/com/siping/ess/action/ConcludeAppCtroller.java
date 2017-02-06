package com.siping.ess.action;

import java.sql.SQLException;
import java.util.HashMap;
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

import com.siping.ess.service.ConcludeAppSer;

@Controller
@RequestMapping(value = "/ess/concludeApp")
public class ConcludeAppCtroller {
	
	Logger logger = Logger.getLogger(InfoAppCtroller.class);

	@Autowired
	private ConcludeAppSer concludeAppSer;
	
	/* ****报工统计***************************************************** */
	@RequestMapping(value = "/viewWhConclusion")
	public ModelAndView viewWhConclusion(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		return new ModelAndView("/ess/concludeApp/viewWhConclusion", modelMap);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value="/getWhConclusionList", method=RequestMethod.POST)
	@ResponseBody
	public Map getWhConclusionList(HttpServletRequest request, HttpServletResponse response){
		Map modelMap = new HashMap();
		modelMap.put("Rows",this.concludeAppSer.getWhConclusionList(request));
		modelMap.put("Total", this.concludeAppSer.getWhConclusionListCnt(request));
		return modelMap;
	}

	@RequestMapping(value="/calculateWhConclusion", method=RequestMethod.POST)
	@ResponseBody
	public String calculateWhConclusion(HttpServletRequest request, HttpServletResponse response){
		String resultString = "Y";
		try {
			this.concludeAppSer.calculateWhConclusion(request);
		} catch (SQLException e) {
			resultString = e.getMessage();
			e.printStackTrace();
		}
		return resultString;
	}
	
}
