package com.siping.att.action.attendanceSettings;

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

import com.siping.att.service.DynamicGroupSer;
import com.siping.att.service.ItemsSer;
import com.siping.web.messages.Messages;

@Controller
@RequestMapping(value = "/att/attendanceSettings")
public class ItemsController {
	Logger logger = Logger.getLogger(ItemsController.class);

	@Autowired
	private ItemsSer itemsSer;
	@Autowired
	private DynamicGroupSer dynamicGroupSer;

	@RequestMapping(value = "/viewItemInfo", method = RequestMethod.GET)
	public ModelAndView viewItemInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		return new ModelAndView("/att/attendanceSettings/viewItemInfo",
				modelMap);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getItemInfo(HttpServletRequest request) throws Exception {

		List itemList = this.itemsSer.getItemInfo(request);

		int itemCnt = this.itemsSer.getItemInfoCnt(request);

		Map model = new HashMap();
		model.put("Rows", itemList);
		model.put("Total", itemCnt);

		return model;
	}

	@RequestMapping(value = "/addItemInfo", method = RequestMethod.GET)
	public ModelAndView addItemInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		return new ModelAndView("/att/attendanceSettings/addItemInfo", modelMap);
	}

	@RequestMapping(value = "/addItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public String addItemInfo(HttpServletRequest request) throws Exception {

		String returnString = "Y";

		int errorInt = this.itemsSer.checkItemInfo(request);

		if (errorInt == 0) {
			this.itemsSer.addItemInfo(request);
		} else {
			returnString = Messages.getMessage(request,
					"hrms.sameDataAlreadyExists");
		}
		return returnString;
	}

	@RequestMapping(value = "/updateItemInfo", method = RequestMethod.GET)
	public ModelAndView updateItemInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		modelMap.put("itemInfo", this.itemsSer.getItemObjectInfo(request));

		return new ModelAndView("/att/attendanceSettings/updateItemInfo",
				modelMap);
	}

	@RequestMapping(value = "/updateItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public String updateItemInfo(HttpServletRequest request) throws Exception {

		this.itemsSer.updateItemInfo(request);

		return "Y";
	}

	@RequestMapping(value = "/deleteItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deleteItemInfo(HttpServletRequest request) throws Exception {

		this.itemsSer.deleteItemInfo(request);

		return "Y";
	}

	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value = "/viewItemParameter", method = RequestMethod.GET)
	public ModelAndView viewItemParameter(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		List itemInfoList = this.itemsSer.getItemInfoTree(request);

		modelMap.put("itemInfoList", itemInfoList);

		return new ModelAndView("/att/attendanceSettings/viewItemParameter",
				modelMap);
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/getItemParameterInfoList", method = RequestMethod.POST)
	@ResponseBody
	public List getItemParameterInfoList(HttpServletRequest request) {

		List itemParameterList = this.itemsSer
				.getItemParameterInfoList(request);

		return itemParameterList;
	}

	@RequestMapping(value = "/addItemParameterInfo", method = RequestMethod.GET)
	public ModelAndView addItemParameterInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		modelMap.put("itemInfo", this.itemsSer.getItemObjectInfo(request));
		modelMap.put("itemParameter",
				this.itemsSer.getItemParameterInfo(request));
		modelMap.put("arDynamicGroupInfo",
				this.dynamicGroupSer.getDynamicGroupSelectionList(request));
		modelMap.put("arAppTypeInfo",
				this.itemsSer.getAppTypeSelectionList(request));

		return new ModelAndView("/att/attendanceSettings/addItemParameterInfo",
				modelMap);
	}

	@RequestMapping(value = "/addItemParameterInfo", method = RequestMethod.POST)
	@ResponseBody
	public String addItemParameterInfo(HttpServletRequest request)
			throws Exception {

		this.itemsSer.addItemParameterInfo(request);

		return "Y";
	}

	@RequestMapping(value = "/upadteItemParameterInfo", method = RequestMethod.GET)
	public ModelAndView updateItemParameterView(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		modelMap.put("itemParameter",
				this.itemsSer.getItemParameterInfo(request));
		modelMap.put("arDynamicGroupInfo",
				this.dynamicGroupSer.getDynamicGroupSelectionList(request));
		modelMap.put("arAppTypeInfo",
				this.itemsSer.getAppTypeSelectionList(request));
		
		return new ModelAndView(
				"/att/attendanceSettings/upadteItemParameterInfo", modelMap);
	}

	@RequestMapping(value = "/updateItemParameterInfo", method = RequestMethod.POST)
	@ResponseBody
	public String updateItemParameterInfo(HttpServletRequest request)
			throws Exception {

		this.itemsSer.updateItemParameterInfo(request);

		return "Y";
	}

	@RequestMapping(value = "/deleteItemParameterInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deleteItemParameterInfo(HttpServletRequest request)
			throws Exception {

		this.itemsSer.deleteItemParameterInfo(request);

		return "Y";
	}
}
