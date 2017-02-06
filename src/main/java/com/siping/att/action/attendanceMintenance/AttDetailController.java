package com.siping.att.action.attendanceMintenance;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.siping.att.service.AttDetailSer; 
import com.siping.att.service.ItemsSer;
import com.siping.web.utility.StringUtil;

@Controller
@RequestMapping(value = "/att/attendanceMintenance")
public class AttDetailController {

	@Autowired
	private AttDetailSer attDetailSer;

	@Autowired
	private ItemsSer itemsSer; 

	@RequestMapping(value = "/viewAttDetail", method = RequestMethod.GET)
	public ModelAndView viewAttDetail(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		modelMap.put("sDate", attDetailSer.getStartDateStr(request));
		modelMap.put("eDate", attDetailSer.getEndDateStr(request));
		modelMap.put("itemList", itemsSer.getItemInfoSelection(request));
		modelMap.put("lockList", StringUtil.getLockSelectList());
		return new ModelAndView("/att/attendanceMintenance/viewAttDetail",
				modelMap);
	} 
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getAttDetailList", method = RequestMethod.POST)
	@ResponseBody
	public Map getAttDetailList(HttpServletRequest request) throws Exception {

		List getAttDetailList = this.attDetailSer.getAttDetailList(request);
		int getAttDetailListCnt = this.attDetailSer.getAttDetailListCnt(request);
		Map model = new HashMap();
		model.put("Rows", getAttDetailList);
		model.put("Total", getAttDetailListCnt);
		return model;
	}

	@RequestMapping(value = "/updateAttDetailInfo", method = RequestMethod.POST)
	@ResponseBody
	public String updateAttDetailInfo(HttpServletRequest request)
			throws Exception {
		return this.attDetailSer.updateAttDetailInfo(request);
	}

	@RequestMapping(value = "/deleteAttDetailInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deleteAttDetailInfo(HttpServletRequest request)
			throws Exception {
		return this.attDetailSer.deleteAttDetailInfo(request);
	}

	@RequestMapping(value = "/addAttDetailInfo", method = RequestMethod.GET)
	public ModelAndView addAttDetailInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		modelMap.put("itemList", itemsSer.getItemInfoSelection(request)); 
		return new ModelAndView("/att/attendanceMintenance/addAttDetailInfo",
				modelMap);
	}

	@RequestMapping(value = "/addAttDetailInfo", method = RequestMethod.POST)
	@ResponseBody
	public String addAttDetailInfo(HttpServletRequest request) throws Exception {
		return this.attDetailSer.addAttDetailInfo(request);
	}

}
