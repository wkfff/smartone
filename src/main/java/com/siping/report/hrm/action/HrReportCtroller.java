package com.siping.report.hrm.action;
 
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

import com.siping.web.utility.service.UtilityOtherInfoSer;
import com.siping.report.hrm.service.HrReportSer;

@Controller
@RequestMapping(value = "/report/hr")
public class HrReportCtroller {
	Logger logger = Logger.getLogger(HrReportCtroller.class);
	@Autowired
	private HrReportSer hrReportSer;
	
	@Autowired
	private UtilityOtherInfoSer utilityOtherInfoSer;
	/**
	 * 页面跳转
	 */
	@RequestMapping(value="/{reportType}",method = RequestMethod.GET)
	public void getReport(){}
	
	/**
	 * 预览
	 */
	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value = "/viewReport",method = RequestMethod.POST)
	@ResponseBody
	public Map viewReport(HttpServletRequest request) throws Exception{
		logger.info("View Report......");
		return hrReportSer.viewReport(request);
	}
	
	/**
	 * 页面导出
	 */
	@RequestMapping(value = "/{reportType}",method = RequestMethod.POST)
	public ModelAndView expReport(HttpServletRequest request,ModelMap map) throws Exception{
		logger.info("Exp Report......");
		map.put("info", hrReportSer.viewReport(request));
		return new ModelAndView("",map);
	}
	
	/**
	 * 预览图表
	 */
	@RequestMapping(value = "/humanChart",method = RequestMethod.GET)
	public ModelAndView viewReportChart(HttpServletRequest request,ModelMap modelMap) throws Exception{	
		
		System.out.println("~~~~~~~~~~111111~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		
		String chart = hrReportSer.viewReportChart(request);
		
		modelMap.put("chart", chart);
		
		return new ModelAndView("/report/hr/humanChart",modelMap);
	}
	/**
	 * 跳转到部门定编信息报表生成页面
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewDeptQuotaReport", method = RequestMethod.GET)
	public ModelAndView viewPaReport(HttpServletRequest request,ModelMap modelMap) throws Exception {
		return new ModelAndView("/report/hrm/viewDeptQuotaReport", modelMap);
	}
	/**
	 * 将部门定编信息以Excel导出
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/getDeptQuotaByExcel", method = RequestMethod.GET)
	public void getDeptQuotaByExcel(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		this.hrReportSer.getDeptQuotaByExcel(request, response);
	}
	/**
	 * 跳转到证件台账报表生成页面
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewQualificationReport", method = RequestMethod.GET)
	public ModelAndView viewQualificationReport(HttpServletRequest request,ModelMap modelMap) throws Exception {
		return new ModelAndView("/report/hrm/viewQualificationReport", modelMap);
	}
	/**
	 * 获取员工证件信息列表
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getEmpQualificationInfoList", method = RequestMethod.POST)
	@ResponseBody
	public Map getEmpQualificationInfoList(HttpServletRequest request) throws Exception {

		List empInfoList = this.hrReportSer.getEmpQualificationInfoList(request);
		int empInfoCnt = this.hrReportSer.getEmpQualificationInfoCnt(request);

		Map model = new HashMap();
		model.put("Rows", empInfoList);
		model.put("Total", empInfoCnt);
		return model;
	}
	/**
	 * 获取员工证件详细信息列表
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getEmpQualificationDetailList", method = RequestMethod.POST)
	@ResponseBody
	public Map getEmpQualificationDetailList(HttpServletRequest request) throws Exception {

		List empInfoList = this.hrReportSer.getEmpQualificationDetailList(request);
		int empInfoCnt = this.hrReportSer.getEmpQualificationDetailCnt(request);

		Map model = new HashMap();
		model.put("Rows", empInfoList);
		model.put("Total", empInfoCnt);
		return model;
	}
	/**
	 * 将搜索之后所获取到的证件台账信息以Excel导出
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/getEmpQualificationInfoByExcel", method = RequestMethod.GET)
	public void getEmpQualificationInfoByExcel(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		this.hrReportSer.getEmpQualificationInfoByExcel(request, response);
	}
	
	   /**
     * 跳转员工花名册生成页面
     * @param request
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/viewMenList", method = RequestMethod.GET)
    public ModelAndView viewMenList(HttpServletRequest request,ModelMap modelMap) throws Exception {
        List hrItemList = this.hrReportSer.getToolItemSelectList(request);
        
        modelMap.put("hrItemList", hrItemList);
        return new ModelAndView("/report/hrm/viewMenList", modelMap);
    }
    /**
     * 获取员工证件信息列表
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getMenList", method = RequestMethod.POST)
    @ResponseBody
    public Map getMenList(HttpServletRequest request) throws Exception {
        List empInfoList = this.hrReportSer.getMenList(request);
        int empInfoCnt = this.hrReportSer.getMenCnt(request);

        Map model = new HashMap();
        model.put("Rows", empInfoList);
        model.put("Total", empInfoCnt);
        return model;
    }
    
    /**
     * 获取员工证件信息列表
     */
    @RequestMapping(value = "/getMenListByExcel", method = RequestMethod.GET)
    public void getMenListByExcel(HttpServletRequest request,HttpServletResponse response) throws Exception {
        
        this.hrReportSer.getMenListByExcel(request, response);
    }
}
