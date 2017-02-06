package com.siping.eva.action;

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
import com.siping.eva.service.KPISer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;

@Controller
@RequestMapping(value = "/eva/kpi")
public class KPICtroller {

	Logger logger = Logger.getLogger(KPICtroller.class);

	@Autowired
	private KPISer kpiSer;

	/**
	 * 转正评价
	 * 
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewEvaKPIInfo", method = RequestMethod.GET)
	public ModelAndView viewEvaKPIInfo(HttpServletRequest request,
			ModelMap modelMap) throws Exception {
		modelMap.put("paraMap", this.kpiSer.getRequestParamData(request));
		return new ModelAndView("/eva/kpi/viewEvaKPIInfo", modelMap);
	}
	@RequestMapping(value = "/viewEvaKPIScore", method = RequestMethod.GET)
	public ModelAndView viewEvaKPIScore(HttpServletRequest request,
			ModelMap modelMap) throws Exception {
		modelMap.put("paraMap", this.kpiSer.getRequestParamData(request));
		return new ModelAndView("/eva/kpi/viewEvaKPIScore", modelMap);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getEvaKPIInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getEvaKPIInfo(HttpServletRequest request) throws Exception {

		List infoList = this.kpiSer.getEvaKPIInfo(request);
		int infoCnt = this.kpiSer.getEvaKPIInfoCnt(request);

		Map model = new HashMap();
		model.put("Rows", infoList);
		model.put("Total", infoCnt);

		return model;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getKPIScoreListByKPI", method = RequestMethod.POST)
	@ResponseBody
	public Map getKPIScoreListByKPI(HttpServletRequest request) throws Exception {

		List infoList = this.kpiSer.getKPIScoreListByKPI(request);
		int infoCnt = this.kpiSer.getKPIScoreListByKPICnt(request);

		Map model = new HashMap();
		model.put("Rows", infoList);
		model.put("Total", infoCnt);

		return model;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getKPIScoreListByEmployee", method = RequestMethod.POST)
	@ResponseBody
	public Map getKPIScoreListByEmployee(HttpServletRequest request) throws Exception {

		List infoList = this.kpiSer.getKPIScoreListByEmployee(request);
		int infoCnt = this.kpiSer.getKPIScoreListByEmployeeCnt(request);

		Map model = new HashMap();
		model.put("Rows", infoList);
		model.put("Total", infoCnt);

		return model;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getKPIScoreDetail", method = RequestMethod.POST)
	@ResponseBody
	public Map getKPIScoreDetail(HttpServletRequest request) throws Exception {

		Map model = new HashMap();
		model.put("scoreInfo", this.kpiSer.getKPIScoreDetail(request)); 
		return model;
	}
	
	@RequestMapping(value = "/saveAndUpdateEvaKPIInfo", method = RequestMethod.POST)
	@ResponseBody
	public String saveAndUpdateEvaKPIInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		return this.kpiSer.saveAndUpdateEvaKPIInfo(request);

	}
	
	@RequestMapping(value = "/deleteEvaKPIInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deleteEvaKPIInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		this.kpiSer.deleteEvaKPIInfo(request);
		return "Y";

	}

	@RequestMapping(value = "/updateEvaKPIScore", method = RequestMethod.POST)
	@ResponseBody
	public String updateEvaKPIScore(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		return this.kpiSer.updateEvaKPIScore(request);

	}

	@RequestMapping(value = "/addEvaKPIScore", method = RequestMethod.POST)
	@ResponseBody
	public String addEvaKPIScore(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		return this.kpiSer.addEvaKPIScore(request);

	}
	

	
	


	@RequestMapping(value = "/saveAndupdateEvaKPIInfo", method = RequestMethod.POST)
	@ResponseBody
	public String saveAndupdateEvaKPIInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		return this.kpiSer.saveAndupdateEvaKPIInfo(request);

	}

	@RequestMapping(value = "/deleteEvaEmpItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deleteEvaEmpItemInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		this.kpiSer.deleteEvaEmpItemInfo(request);
		return "Y";
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getEvaKpiTypeInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getEvaKpiTypeInfo(HttpServletRequest request){
		List infoList = this.kpiSer.getEvaKpiTypeInfo(request);
		int infoListCnt = this.kpiSer.getEvaKpiTypeInfoCnt(request);
		Map model = new HashMap();
		model.put("Rows", infoList);
		model.put("Total", infoListCnt);
		
		return model;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getEvaKpiItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getEvaKpiItemInfo(HttpServletRequest request){
		List infoList = this.kpiSer.getEvaKpiItemInfo(request);
		int infoListCnt = this.kpiSer.getEvaKpiItemInfoCnt(request);
		Map model = new HashMap();
		model.put("Rows", infoList);
		model.put("Total", infoListCnt);
		
		return model;
	}

	@RequestMapping(value = "/getKpiItemCount", method = RequestMethod.POST)
	@ResponseBody
	public String getKpiItemCount(HttpServletRequest request){
		int infoListCnt = this.kpiSer.getEvaKpiItemInfoCnt(request);
		if(infoListCnt>0){
			return "Y";
		}
		return "N";
	}
	@RequestMapping(value = "/addAndupdateKpiTypeInfo", method = RequestMethod.POST)
	@ResponseBody
	public String addAndupdateKpiTypeInfo(HttpServletRequest request){
		String returnString = "Y";
		try{
			this.kpiSer.addKpiTypeInfo(request);
			this.kpiSer.updateKpiTypeInfo(request);
		}catch(SQLException e){
			e.printStackTrace();;
			returnString = e.getMessage();
		}
		return returnString;
	}
	@RequestMapping(value = "/deleteKpiTypeInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deleteKpiTypeInfo(HttpServletRequest request){
		String returnString = "Y";
		int errorInt = this.kpiSer.checkDeleteKpiTypeInfo(request);
		if (errorInt == 0) {
			returnString = this.kpiSer.deleteKpiTypeInfo(request);
		} else {
			returnString = Messages.getMessage(request, "hrms.canNotdelete");
		}
		return returnString;
	}
	@RequestMapping(value = "/addKpiItemInfo", method = RequestMethod.GET)
	public ModelAndView addKpiItemInfo(HttpServletRequest request, ModelMap modelMap){
		modelMap.put("paraMap",ObjectBindUtil.getRequestParamData(request));
		return new ModelAndView("/eva/kpi/addKpiItemInfo", modelMap);
	}
	@RequestMapping(value = "/addKpiItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public String addKpiItemInfo(HttpServletRequest request) throws Exception {
		String returnString = "Y";
		this.kpiSer.addKpiItemInfo(request);
		//this.kpiSer.addKpiValidater(request);
		return returnString;
	}
	@RequestMapping(value = "/deleteKpiItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deleteKpiItemInfo(HttpServletRequest request){
		String returnString = "Y";
		int check = this.kpiSer.checkKpiItemDis(request);
		if(check <= 0){
			returnString = this.kpiSer.deleteKpiItemInfo(request);
		}else{
			returnString = "所选指标有已被锁定指标，不能删除";
		}
		return returnString;
	}
	@RequestMapping(value = "/updateKpiItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public String updateKpiItemInfo(HttpServletRequest request){
		String returnString = "Y";
		returnString = this.kpiSer.updateKpiItemInfo(request);
		return returnString;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getKpiItemByMonth", method = RequestMethod.POST)
	@ResponseBody
	public Map getKpiItemByMonth(HttpServletRequest request){
		List infoList = this.kpiSer.getKpiItemByMonth(request);
		int infoListCnt = this.kpiSer.getKpiItemByMonthCnt(request);
		Map model = new HashMap();
		model.put("Rows", infoList);
		model.put("Total", infoListCnt);
		
		return model;
	}
	@RequestMapping(value = "/addKpiBevalidaterInfo", method = RequestMethod.POST)
	@ResponseBody
	public String addKpiBevalidaterInfo(HttpServletRequest request){
		String returnString = "Y";
		returnString = this.kpiSer.addKpiBevalidaterInfo(request);
		return returnString;
	}
	@RequestMapping(value = "/deleteDistriKpiItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deleteDistriKpiItemInfo(HttpServletRequest request){
		String returnString = "Y";
		returnString = this.kpiSer.deleteDistriKpiItemInfo(request);
		return returnString;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getKpiItemManager", method = RequestMethod.POST)
	@ResponseBody
	public Map getKpiItemManager(HttpServletRequest request){
		List infoList = this.kpiSer.getKpiItemManager(request);
		int infoListCnt = this.kpiSer.getKpiItemManagerCnt(request);
		Map model = new HashMap();
		model.put("Rows", infoList);
		model.put("Total", infoListCnt);
		return model;
	}
	@RequestMapping(value = "/addKpiManagerInfo", method = RequestMethod.POST)
	@ResponseBody
	public String addKpiManagerInfo(HttpServletRequest request){
		String returnString = "Y";
		this.kpiSer.addKpiManagerInfo(request);
		return returnString;
	}
	@RequestMapping(value = "/deleteKpiManagerInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deleteKpiManagerInfo(HttpServletRequest request){
		String returnString = "Y";
		returnString = this.kpiSer.deleteKpiManagerInfo(request);
		return returnString;
	}
	@RequestMapping(value = "/addKpiScoreInfo", method = RequestMethod.POST)
	@ResponseBody
	public String addKpiScoreInfo(HttpServletRequest request){
		String returnString = "Y";
		returnString = this.kpiSer.addKpiScoreInfo(request);
		return returnString;
	}
	@RequestMapping(value = "/getScoreByExcel", method = RequestMethod.GET)
	public void getScoreByExcel(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		kpiSer.getScoreByExcel(request,response);
	}
}
