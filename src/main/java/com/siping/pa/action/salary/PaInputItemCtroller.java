package com.siping.pa.action.salary;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.LinkedHashMap;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.siping.pa.service.salary.PaInputItemSer;
import com.siping.pa.service.salary.PaProgressSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.ObjectBindUtil;

@Controller
@RequestMapping(value = "/pa/salary")
public class PaInputItemCtroller {
	Logger logger = Logger.getLogger(PaInputItemCtroller.class);

	@Autowired
	private PaInputItemSer paInputItemSer;
	
	@Autowired
	private PaProgressSer paProgressSer;

	@RequestMapping(value = "/viewPaInputItemInfo", method = RequestMethod.GET)
	public ModelAndView viewPaInputItemInfo(HttpServletRequest request, ModelMap modelMap){
		modelMap.put("year", DateUtil.getSysdateString("yyyy"));
		modelMap.put("month", DateUtil.getSysdateString("MM"));
		
		return new ModelAndView("/pa/salary/viewPaInputItemInfo", modelMap);
	}
	
	@RequestMapping(value = "/uploadPaParamData", method = RequestMethod.GET)
	public ModelAndView uploadPaParamData(HttpServletRequest request, ModelMap modelMap){
		modelMap.put("paraMap",ObjectBindUtil.getRequestParamData(request));
		
		return new ModelAndView("/pa/salary/uploadPaParamData", modelMap);
	}

	@RequestMapping(value = "/viewPaInputItemDetailInfo", method = RequestMethod.GET)
	public ModelAndView viewPaInputItemDetailInfo(HttpServletRequest request, ModelMap modelMap){
		modelMap.put("paraMap",ObjectBindUtil.getRequestParamData(request));

		return new ModelAndView("/pa/ins/viewPaInputItemDetailInfo", modelMap);
	}

	@RequestMapping(value = "/addPaInputItemDataInfo", method = RequestMethod.GET)
	public ModelAndView addPaInputItemDataInfo(HttpServletRequest request, ModelMap modelMap){
		modelMap.put("paraMap",ObjectBindUtil.getRequestParamData(request));
		return new ModelAndView("/pa/ins/addPaInputItemDataInfo", modelMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getPaInputItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getPaInputItemInfo(HttpServletRequest request){
		List infoList = this.paInputItemSer.getPaInputItemInfo(request);
		int infoCnt = this.paInputItemSer.getPaInputItemInfoCnt(request);
		Map model = new HashMap();
		model.put("Rows", infoList);
		model.put("Total", infoCnt);
		
		return model;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getPaInputItemDataEmpInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getPaInputItemDataEmpInfo(HttpServletRequest request){
		List insEmpInfo = this.paInputItemSer.getPaInputItemDataEmpInfo(request);
		int insEmpInfoCnt = this.paInputItemSer.getPaInputItemDataEmpInfoCnt(request);
		Map model = new HashMap();
		model.put("Rows", insEmpInfo);
		model.put("Total", insEmpInfoCnt);

		return model;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getPaInputItemDataOtherInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getPaInputItemDataOtherInfo(HttpServletRequest request){
		List insEmpInfo = this.paInputItemSer.getPaInputItemDataOtherInfo(request);
		int insEmpInfoCnt = this.paInputItemSer.getPaInputItemDataOtherInfoCnt(request);
		Map model = new HashMap();
		model.put("Rows", insEmpInfo);
		model.put("Total", insEmpInfoCnt);

		return model;
	}

	@RequestMapping(value = "/addAndupdatePaInputItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public String addAndupdatePaInputItemInfo(HttpServletRequest request){
		String returnString = "Y";
		try{
			this.paInputItemSer.addPaInputItemInfo(request);
			this.paInputItemSer.updatePaInputItemInfo(request);
		}catch(SQLException e){
			e.printStackTrace();;
			returnString = e.getMessage();
		}
		return returnString;
	}

/*	@RequestMapping(value = "/addPaInputItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public String addPaInputItemInfo(HttpServletRequest request){

		return this.paInputItemSer.addPaInputItemInfo(request);
	}

	@RequestMapping(value = "/updatePaInputItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public String updatePaInputItemInfo(HttpServletRequest request){
		return this.paInputItemSer.updatePaInputItemInfo(request);
	}*/

	@RequestMapping(value = "/deletePaInputItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deletePaInputItemInfo(HttpServletRequest request){
		String returnString = "Y";
		int errorInt = this.paInputItemSer.checkDeletePaInputItemInfo(request);
		if (errorInt == 0) {
			returnString = this.paInputItemSer.deletePaInputItemInfo(request);
		} else {
			returnString = Messages.getMessage(request, "hrms.canNotdelete");
		}
		return returnString;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getPaInputItemDataInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getPaInputItemDataInfo(HttpServletRequest request){
		List infoList = this.paInputItemSer.getPaInputItemDataInfo(request);
		int infoCnt = this.paInputItemSer.getPaInputItemDataInfoCnt(request);
		Map model = new HashMap();
		model.put("Rows", infoList);
		model.put("Total", infoCnt);
		
		return model;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/deletePaInputItemDataInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deletePaInputItemDataInfo(HttpServletRequest request){
		String returnString = "Y";
		LinkedHashMap<Object, Object> paraMap = (LinkedHashMap<Object, Object>) this.paProgressSer.getPaProgressObjectInfo(request);
		if (paraMap.get("PA_LOCK_FLAG").toString().equals("0")) {
			returnString = this.paInputItemSer.deletePaInputItemDataInfo(request);
		} else {
			returnString = Messages.getMessage(request, "hrms.canNotdelete");
		}
		return returnString;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/updatePaInputItemDataInfo", method = RequestMethod.POST)
	@ResponseBody
	public String updatePaInputItemDataInfo(HttpServletRequest request){
		String returnString = "Y";
		LinkedHashMap<Object, Object> paraMap = (LinkedHashMap<Object, Object>) this.paProgressSer
				.getPaProgressObjectInfo(request);
		if (paraMap.get("PA_LOCK_FLAG").toString().equals("0")) {
			returnString = this.paInputItemSer.updatePaInputItemDataInfo(request);
		} else {
			returnString = Messages.getMessage(request, "hrms.canNotUpdate");
		}

		return returnString;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/addPaInputItemDataInfo", method = RequestMethod.POST)
	@ResponseBody
	public String addPaInputItemDataInfo(HttpServletRequest request){
		String returnString = "Y";
		LinkedHashMap<Object, Object> paraMap = (LinkedHashMap<Object, Object>) this.paProgressSer.getPaProgressObjectInfo(request);
		if (paraMap.get("PA_LOCK_FLAG").toString().equals("0")) {
			returnString = this.paInputItemSer.addPaInputItemDataInfo(request);
		} else {
			returnString = Messages.getMessage(request, "hrms.canNotAdd");
		}
		return returnString;
	}

	@RequestMapping(value = "/createPaInputItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public String createPaInputItemInfo(HttpServletRequest request){

		return this.paInputItemSer.createPaInputItemInfo(request);
	}

	@RequestMapping(value = "/createPaInputItemDataInfo", method = RequestMethod.POST)
	@ResponseBody
	public String createPaInputItemDataInfo(HttpServletRequest request) {
		
		return this.paInputItemSer.createPaInputItemDataInfo(request);
	}
	
	/**
	 * 上传Excel并将Excel放入AR_RECORDS表中 
	 * @throws ParseException 
	 */
	@RequestMapping(value="/uploadPaParamExcel",method = RequestMethod.POST)
	@ResponseBody
	public String uploadPaParamExcel(@RequestParam("file") MultipartFile file, 
			HttpServletRequest request,HttpServletResponse response) {
		String resultString = "Y";
		try {
			resultString = this.paInputItemSer.uploadPaParamExcel(file,request,response);
		} catch (IOException e) {
			resultString = e.getMessage();
			e.printStackTrace();
		} catch (SQLException e) {
			resultString = e.getMessage();
			e.printStackTrace();
		} catch (ParseException e) {
			resultString = e.getMessage();
			e.printStackTrace();
		} catch (Exception e){
			resultString = "未知错误";
			e.printStackTrace();
		}
		return resultString;
	}
}
